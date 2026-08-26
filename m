Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACA5C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 19:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D877780C38;
	Wed, 26 Aug 2026 19:18:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xOS25S0VyO4Q; Wed, 26 Aug 2026 19:18:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787771930;
	bh=kKdPw4r6pJ/BP7eC9CqEl+gVqcntOCKjDH9AEIu7ccs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dife6iKV0XDYsO3KbJ9dzsiK9EYvLiZdi92bQVtUN3zi9JNge4ld0s6sV+4MlGdj5
	 w5QGwppySMHRbGBVoQlwMKfkfzG+B1YcchgNESQhxToUMjcM4UxHacEBUjq8pF3V2v
	 nhOPDLLAseTihtWnOffK56xvRR2EjRCdJVsVj9zHIkFm6+kLVO+FUTr1h6BwrPSwIb
	 VsTetPYAiakllvQ+Ex0P2D4hIF+Szc5eGJ2fCwni3T+GpcBCP4Qs1LzbApfEXtEqLO
	 nlX4osbyy5QbQm1BCN6Pj/hk679U1UAU7yS/e1f/aTD20yo2F8fimB1riaDaNV5d7q
	 ADuxML8Axp37w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5686380BEA;
	Wed, 26 Aug 2026 19:18:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8914939A
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 19:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F14940206
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 19:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v5j3gBhiak4E for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 19:18:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=NSr8nQEz
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EE0E400F2
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 19:18:47 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so1723962a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787771926; x=1788376726;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kKdPw4r6pJ/BP7eC9CqEl+gVqcntOCKjDH9AEIu7ccs=;
 b=NSr8nQEzBISnHENplDYVpfomY5bYr4OrjGeylO967uX6x9HKwddcEX5ZywSwTcHVfI
 71cJAet4YYzxS5yGU+2T6koIvikwMNERKEEghDxxDbXuFzQ32Jzbo4hCiinc7fXUoDvt
 LHf9MPk/rERbhuBYiMhhB23khaCsZgwZOqAcaosl8BmkRWcrQsqW4zmND/PjKTa6IXtj
 G55RardayvBbvtsFQdL6DbOjwTMsb8K0FxzCz6woF3tY9rQPS37r9Gd6wCpNs1SQymDK
 Hb07Q7uVGsaRWbyVQy0AMYThqICzju3v+15xUDVP3+4fsfng3fVPX8LujFl4EHDagIPb
 gyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787771926; x=1788376726;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kKdPw4r6pJ/BP7eC9CqEl+gVqcntOCKjDH9AEIu7ccs=;
 b=ONvljAZo/eL7corRtSmDrNKrSYrYhqFWd7+K72bPufA3l8qtmuLJk5YVm67qupZKRA
 04yD32hrG0JPOxcVJVnGrjDzVqVPeEUjfFHeOVx6RZow4N4VSjLq8LQGKMjT2Y/gLrsy
 HJTbdmqP5oe+rAZofLxl21iLwVo/BP0jtK21GG/vsV1ZKEv1Trxs5SxFI+plcu63X+D/
 F8udG/qB9N7UnpfzFb5XAsuvXn1LNsxN3qhWRCsTd24nZsZuYM+qtihQy2QZeX4Fe6mA
 EH8ZQp4f0TukXs/Ok7SI8dpJk6Z2JpMTR8ZRbEwfvWOSRyI6NGOKs7n4m+MYPaSuqSB7
 ivAw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+BO9PKWW8l+4bK/XJQeJRCUBBqCrGWUftwgK41FDf87+YtATDfGXVBCZrFVonlfPkNCdx54k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nbb26ebC5oud1tEXJebwkZh2u+fpYbohLrJ6MTfJP1QDFvHI0S
 gb9balgv7qxpxjRsR4En3UM19XiM0Z2jlCQOFVA7rMKzInEEwVxPqGNB6xr+G8pO3hA=
X-Gm-Gg: AR+sD13tOqGT8zPKeQ1EuZeMwk4+tVYhgGbkxCvt7b8/WmPQEqjssSAGQ2KekMItDD1
 eBuiSbgRVvqOyL9vnnH2ltIuphRnP/6ZlbCtL2dMrQP00l7PrmugXJi0k6ujFs11d4nzWprMBu7
 csIO/iGrq62pHf5F9PrMOL+QqpRijVce5YB4RRRvkQhNHlg5v+tA+3HePhM7wqoiX4LTuPXesSG
 ij+Fzg9v0UW28+hmd4RC3z/D/ZStJ4eGtYdy0RDdZ8GZLit+0o8C19a/GzO5LhQu2E9ABIphR4r
 itPNKeeQiP5RwMf+4z1UBLd9HqI3OQDEOWnLtpBVB3f8psgssi86J0vGxb+RX5D8vHYL64UD1Sc
 YZ90/LhYxP1Gdw8Rq5zVGxl6nA4ooKoXYEbKYljwUno0KbXe9QPBt+iuqiV2r71+w/6CLDlVVJS
 FWIbbWOGp/D4vclEpB+PU9YtSP+LIMIHggvrp8I0a36zOcgcgPQWh0Z/xNUzC283EHzv4AfkbS1
 rREhYHPF+pmVd3RGB5MPCMNBmQ=
X-Received: by 2002:a17:907:d26:b0:c15:dcc6:d06d with SMTP id
 a640c23a62f3a-c250b9bc2cdmr1192323166b.0.1787771925720; 
 Wed, 26 Aug 2026 12:18:45 -0700 (PDT)
Received: from [192.168.1.37] (p5b29ea13.dip0.t-ipconnect.de. [91.41.234.19])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250f99f6bdsm497771166b.0.2026.08.26.12.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 12:18:44 -0700 (PDT)
Message-ID: <75b547f3-514e-4db4-a1fa-0ac0be6f1d29@linaro.org>
Date: Wed, 26 Aug 2026 21:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] efi_loader: firmware: decouple dfu_alt_num from
 image_index
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>
References: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260813-efi-firmware-dfu-alt-num-v1-0-43f034253b21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Balaji,

On 13/08/2026 07:53, Balaji Selvanathan via U-Boot wrote:
> RAW capsule updates hardcode dfu_alt_num = image_index - 1, which
> assumes every board's fw_images[] table is a positionally
> ordered mirror of its dfu_alt_info string. That's true for every
> board that hand-writes fw_images[], but it breaks down for a platform
> that builds the table by scanning its partition layout at boot: the
> set of images and their indices can vary per board, with gaps where a
> component isn't present, so image_index and dfu_alt_num can't be
> assumed to stay in lockstep.
> 
> This series moves that calculation into a __weak
> efi_firmware_get_dfu_alt_num() a platform can override, the same
> pattern already used for efi_firmware_get_image_type_id() and the
> efi_reset_system()/efi_get_time() hooks. The default implementation is
> the same image_index - 1 every existing board relies on today, so
> nothing needs to change anywhere else.

Please tame your LLM, this isn't a sales pitch. I'd much rather see a
succint explanation from yourself, same goes for the code comments in
these patches. Please follow the tone of the project and avoid leaking
implementation details in function comments.

> 
> This is infrastructure for a follow-on series that builds fw_images[]
> dynamically on Qualcomm boards, which needs this hook to keep
> dfu_alt_num correct once the table stops being static.
> 
> This work is part of multi-image capsule update support for
> Qualcomm boards.
> 
> Balaji Selvanathan (2):
> 
> efi_loader: firmware: decouple dfu_alt_num from image_index
> test: efi_capsule: add sandbox coverage for dfu_alt_num override
> ---
> Balaji Selvanathan (2):
>       efi_loader: firmware: decouple dfu_alt_num from image_index
>       test: efi_capsule: add sandbox coverage for dfu_alt_num override
> 
>  arch/sandbox/dts/sandbox_capsule.dtsi              | 12 ++++++
>  board/sandbox/sandbox.c                            | 18 +++++++++
>  include/efi_loader.h                               | 17 ++++++++
>  include/sandbox_efi_capsule.h                      |  1 +
>  lib/efi_loader/efi_firmware.c                      | 21 +++++++++-
>  .../test_efi_capsule/test_capsule_firmware_raw.py  | 45 ++++++++++++++++++++++
>  6 files changed, 112 insertions(+), 2 deletions(-)
> ---
> base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
> change-id: 20260811-efi-firmware-dfu-alt-num-1289dae96490
> 
> Best regards,

-- 
// Casey (she/her)

