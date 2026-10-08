Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC74CCA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 10:32:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 008B0404FF;
	Thu,  8 Oct 2026 10:32:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fBkdIW-acECM; Thu,  8 Oct 2026 10:32:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EB02B40505
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791455566;
	b=pD7JNejWUhkXjHEKWi5e7Og4UGwuQJhxbFXwkQjWQevsnlFySGxS5hUlp5AFajia1kZI
	 oa2rnC0Wf6vz92PbDmtgj/xhcub8ClMnyux9RkEQI+YkbkIPM6ozkhfjUkz7BtLe7mNi7
	 r/86ltSVkdaWLOeTJlDMUlFp5HoRV2YaY4DA8A/DQIBDU0GM2/IQPiW0jbL6mVvUBF1IS
	 evc/iHLc9ygD51W7YZPEaJfOm0oBTQNXYY4LAqEgWbwRSNrIwhIvJuXd11SBpgs9Wh14j
	 +CNiDGoUgkYIXaIc2I63dbs4y7/M4m/O3zwb+M5LWIrGAEgr9BvWMMpUIeWebJ3rHJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791455566;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:From:
	 To:Cc:X-Mailer:References:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ph+SgV5iCe0hekTQT/5EJx7XynnPfjGs5sZR7wlUUVA=;
	b=l/g8j98wmx1oBow8x0ppwLPuCcFYBZFxYPmJPSqbYGnv0oMw96QEtN37uwqg1+QenHI1
	 oCgAo2aLE9p7Ey13NXKxuTXxck9dBc8up3hhEHkpjvK4oa6ECBZUms2lW93w/QO8N8J1V
	 +K4FxuRhjcGBYFTC06er5zmjHNXLYdeEG5v4Boj72eruGlgE6ImWunMVjI7TW3iWIMH0s
	 ZjL2TnEeHgAgYa50R1rvijr0aNVOQXkjqM7T4bw12T2YHyEhCDWA6hld21Ln5oX9RVGQc
	 QPI4C3Dzp1SYXlxiO9LPBZATfgMqNe6kkDMisN72Nq/IFgw4iojtEFXXTHmu/lvAQlQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791455566;
	bh=ph+SgV5iCe0hekTQT/5EJx7XynnPfjGs5sZR7wlUUVA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0tpmSVV8Qsdsbcb7+/xj+l0ke8eh5kVEhhz8LnlZ8tPURMFxY3CKLGTOmIkjR++JZ
	 r8mHjvmRwCgnNzItg/3UYLylFgEQ5/f46t7eNue1XTYwz7Qu1rL28uZfOZWDegnH8w
	 eD8hE6u5ZsfOTB+D61nCHuIawO42tOnuZo/QpksU5Wiw7WaTIugCYoUGQjFu7nDYqF
	 Enlae7bjlKadEZeknnugSLd91caMLcKuShvhr5M1cHRi1R1KB1pvgLley8LzjE09Vw
	 GGITzRafh2o+vGenm+XompqoYb/nTKW6QdTAfdacgcj+yUoNPiEXqRob0UYexFj0+Q
	 VHyZsfy5r1Wog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB02B40505;
	Thu,  8 Oct 2026 10:32:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6053722F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4645E8121B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C-QV-Fbx0TJD for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 10:32:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F226F80A68
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791455563;
 b=Bp9QvgWBfm4gQ09yLP1HyzlNQcBZ8S89BJqxNt43NYTCZsoZNQSMhH5kZ3WzFPTqSoAe
 mpO/Hm6gGcux+rdLtLT8swezHtoSEXyXgcFsdjrZi0166Y0lzkmPP8MmmZ8nt+JchsUXR
 ImcYLcJ7zdcI2gkQ+2kR6ENymu622bKqCGQC8IrF5pmAaAX25ozGjEkK8Xczv6zwVwU6e
 ZPp3pp2JEkQoT9DH+XfgHN0maAx2AzVfEZSMnHTLbRWE/x1jv5yCoPT0CatSH8ySuc7aF
 ORu2/9FwPQdsUDr4endqmg/MkRPOb2lzmvXrnCiyvAnjRwxP9xZcRuA+eBmhoo4XWWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791455563;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
 bh=ph+SgV5iCe0hekTQT/5EJx7XynnPfjGs5sZR7wlUUVA=;
 b=f5gvmVy5peHJ4USCfuCxN4C/JNo6mZjv0iQ+WO59dR/8coDwWxVgv4Tsz6OsZ2ET/Auj
 QO7QZY1h/xGuFeJYqNUFOUU7XojUbjUnxA5RNyrn0icgv2mzfFRNqqTAiUNAlkD4XC4iP
 2G3/PwmRT49oQ4LUhwTV24lPVxeWeJPMf7juQvi6yuZSs+KhprldNWgb/aXeL0+hOJgIj
 hs4FLt9NxzdKWBNNu0CAyAu4hNpLMbSMkoZmB/bEQtKbI1NNBrKeUGfDmspqtWku/L1N8
 YwtsVx+Mg6O8DaEkp/6kG5vXpsHdblnWW9gCFc3pvHvQK5wrbdPMckbJObi/cPHR7kA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="xCGT/iKd"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xCGT/iKd
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F226F80A68
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 10:32:42 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so2041924f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791455560; x=1792060360;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ph+SgV5iCe0hekTQT/5EJx7XynnPfjGs5sZR7wlUUVA=;
 b=xCGT/iKdQ2qgrxDFFSxY+himowB57ITEsuNgevQhpbM/HASthuFUtCvFjG2vnZp977
 hUNkO30kFPseN1oVYUWg/BinhYD5jd+cP93Wj4GZuSPzXPbZo3thmw8cBFx8rNWZKP0b
 IQA85a6Cf3IN/GN7R8bH5PUyfTb/YKonwvwyK+teXCFBasvzvYT7GkqsbK57OhxT7XlB
 CcNa58zY6Zsz7Q4aeX8JCwi0KXL74h45jbM8gYybNlRxd4ziKvNegHFI3DEa7nYI+2Z6
 WoNPjc374W9jKsNaLo+Xcw8ZoBbdX6MxmGg4usVZcj5MfFV3JWI2irbeiXL2dKXYNiQB
 8WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791455560; x=1792060360;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ph+SgV5iCe0hekTQT/5EJx7XynnPfjGs5sZR7wlUUVA=;
 b=ubuKTKxELejBJoyUZlwlM09W2Kl3wxdQh2xDG22wLE2Q6AtJ5yQRsfFX835Qs7w4PT
 QU+QYqgxE6VK5ugeB0Xl/Nzq7h+zkiWKkc7HJZWvZ71E16prP68klRYj5YmeewVPkc9m
 Vu73M4YRPjhgiWg6jdCk6qZsOY+AUHJrX3sjts3quFC4RxemMHY+DN1BeKdlm5o9R11u
 jIwign9iq+kCVTmR5To7NKktg163rofuw4czVnrU5xUsckWTmHtIaRRvjkP0g1lDBClL
 QsjBdFUAoZmQnDYGY+6rbYJfHKJDJUzHDUZdMwJzqXkl3kr7PoSGtn2bnldiUCJd9v64
 u8gA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7nZALbkQhQOsbJO0b89XbSbz6F1tpUNlJeEjzb8GxdXezq/sQP/6YlWzQhY8d6P7Qj9P9Nao=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKR7aTWcrIsKCszVClbzR5o58iPUz9yrjFbDi/vCPRkaafKubmU
 7BXpnOAIsupUnyX7Fhz6XR3ZdJ0uzhcxmvrktvujbN0n+YlGsUJEf6p3FFJIt1IP/dU=
X-Gm-Gg: AYBFou0EGJgeB1ycdDiY4UiB2CramQd7AwwSAJOX5FT5vvu2Znw2cC0mLTzXJGehgLW
 0L1KwskWE1Zehrbsm6WyjR8jacUIHqsemA7Qxag+255dBOdTWOdl1zkd8B0rR+d7RqsALLCOcz3
 WBTKJGsK/eoZauBEFSSen2DlhNOCAQuamQd0jPyrGkkqKjZuHbMr5G0K1NgFycfSXWJxmc7XgwH
 xkMlaeMwbedjLxAN6LJG+5LeRFGEClMMxP1KQOS0IP68JAI8cx8ZAkI+Z88CAlt5dUYo5NxmckI
 clHAbV8OH0uQZYqbsM6qazu7cmN4JuYS3CAk/vx7zRPwNj+f5YFn1oaukERHDz0EEJIK4w8APiA
 n6buBSy9FVxh3s2Q6fhutCK/O4lpIgGkd1MYUuCEbQIDpiODskjHP0zrFOmqyEiQVD4NmAVYEG7
 dzl0ab17cSqFqgEXIy1cte8kr7ot7LU2tflXVHZWFJBNyoQRlMwPq5QIhzXMsDJuu8h2JRowUVL
 dXB8s/KRYRa2o9aYF66GUHPDb/HMRSVnRM9qo3Ap/k8dPP43K8ATg0Z5lW3RAeGdLvuzBMqPjHd
 hAIN0cLxKOZ6IPyPeA2vNdb3DQRJ/vYoPeu1Z0Wucki5zHA2SAT96iDf7DYFGqKJyYTLVtsrYhH
 ZSwlqrPUepRsODNEqeAMm3dBm4LzZBjD7ruimXD7y80nEAII5v1571BZx0deLzafRMfHDywQEP9
 2aAIMRO1aUm2ZhUmxvguf7dMN7/z8wCKUc9FJBR6083uBE+yrhQs+BfyFAAiid5ac0dIgnaUOjd
 iMIDKc+4rDq8TdB6U0etz61TTmWX8M0A2HYAWJV/9W7wyba7W7l0PR2mEjM7CMwt75YZlvtChYB
 f/Y=
X-Received: by 2002:a05:6000:4683:b0:488:7f8b:b4b with SMTP id
 ffacd0b85a97d-48c7276a894mr6182534f8f.26.1791455559787; 
 Thu, 08 Oct 2026 03:32:39 -0700 (PDT)
Received: from localhost ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c7af26edasm5186036f8f.1.2026.10.08.03.32.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 03:32:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 13:32:38 +0300
Message-Id: <DLZDZTZVOEHY.1MJ22UQOHL27P@linaro.org>
Subject: Re: [PATCH v3 1/3] tpm: Add an option to start the TPM during init
From: "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
To: "Michael Haener" <michael.haener@siemens.com>,
 <u-boot@lists.u-boot-project.org>
Cc: "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Michal Simek" <michal.simek@amd.com>
X-Mailer: aerc 0.17.0
References: <20261006090504.110845-1-michael.haener@siemens.com>
 <20261006155217.187050-1-michael.haener@siemens.com>
 <20261006155217.187050-2-michael.haener@siemens.com>
In-Reply-To: <20261006155217.187050-2-michael.haener@siemens.com>
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

Hi Michael,

This looks ok now. I am thinking if we should also remove the tpm_auto_star=
t() from
efi_tcg2.c now and select the new Kconfig option. It might be a bit problem=
atic,
since the tpm_auto_start() from EFI onlyruns when you initialize the subsys=
tem.
That subsystem only comes to life when we ask something out of EFI, i.e
read a variable or boot an image etc. So in theory you can have a combinati=
on where EFI
is compiled in, but TPM_AUTOSTART isn't and you only enable the TPM when bo=
oting via EFI.
If we select that symbol we initialize it regardless.

Thanks
/Ilias


On Tue Oct 6, 2026 at 6:52 PM EEST, Michael Haener wrote:
> Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
> sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
> 'tpm autostart' command does, but it does not depend on a boot script or
> on the environment.
>
> Today a TPM is only started automatically when either CONFIG_MEASURED_BOO=
T
> is used (and then only from bootm) or when booting via EFI with
> CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
> uninitialised and the OS has to start it itself, which Linux reports as
> "A TPM error (256) occurred attempting the self test". Boards have worked
> around this by putting 'tpm autostart' into their environment, see
> board/xilinx/zynqmp/zynqmp_kria.env.
>
> The startup is done from an event rather than in the uclass probe:
> nothing probes the TPM on a plain booti/bootm, and the event runs exactly
> once in U-Boot proper without changing what probing a TPM means for the
> existing callers.
>
> Boards that share one binary between variants with and without a TPM
> fitted can enable this safely: when no TPM device is found the startup is
> skipped silently. Other errors are reported as warnings but do not stop
> the boot. Note that the full self-test adds to the boot time.
>
> Signed-off-by: Michael Haener <michael.haener@siemens.com>
> ---
> Changes in v3:
> - Split the tests and the Kria conversion into separate patches
>
> Changes in v2:
> - Move the code to lib/tpm_autostart.c and the option to lib/Kconfig
> - Stay silent only when no TPM device exists (-ENODEV), warn otherwise
> - Use u32 and %#x for the tpm_auto_start() result
> - Mention the boot-time cost of the self-test in the help text
> - Document the option in doc/usage/measured_boot.rst
> - Explain in the commit message why an event is used instead of probe
>
>  doc/usage/measured_boot.rst | 18 ++++++++++++++++++
>  lib/Kconfig                 | 19 +++++++++++++++++++
>  lib/Makefile                |  1 +
>  lib/tpm_autostart.c         | 37 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 75 insertions(+)
>  create mode 100644 lib/tpm_autostart.c
>
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> index 488dd546f13..d74cfab2594 100644
> --- a/doc/usage/measured_boot.rst
> +++ b/doc/usage/measured_boot.rst
> @@ -55,3 +55,21 @@ Requirements
>  * The operating system must also be configured to use the memory regions
>    specified in the U-Boot device-tree in order to make use of the event
>    log.
> +
> +Starting the TPM without measured boot
> +--------------------------------------
> +
> +Measured boot starts the TPM as a side effect, but only on the boot path=
s
> +listed above. A plain booti/bootm without CONFIG_MEASURED_BOOT, or a boo=
t
> +which does not go through the EFI subsystem, leaves the chip uninitialis=
ed
> +and the operating system has to start it itself. Some kernels report thi=
s as
> +an error.
> +
> +CONFIG_TPM_AUTOSTART runs the same startup and self-test sequence as the
> +'tpm autostart' command from an EVT_LAST_STAGE_INIT handler, independent=
ly of
> +the boot path, the environment and any boot script. When no TPM device i=
s
> +found the startup is skipped, so a board which shares one binary between
> +variants with and without a TPM fitted can enable it safely.
> +
> +Note that a full self-test can take a noticeable amount of time on a TPM=
v2,
> +which is added to every boot even when the TPM is not used afterwards.
> diff --git a/lib/Kconfig b/lib/Kconfig
> index ff7655e1496..33ae8037479 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -565,6 +565,25 @@ config TPM
>  	  If you want a fully functional TPM enable all hashing algorithms.
>  	  If you enabled measured boot all hashing algorithms are selected.
>
> +config TPM_AUTOSTART
> +	bool "Start the TPM during board initialisation"
> +	depends on TPM
> +	select EVENT
> +	help
> +	  Run the TPM startup and self-test sequence from an EVT_LAST_STAGE_INI=
T
> +	  handler, which is the same thing the 'tpm autostart' command does.
> +	  Without this the chip is still uninitialised when the OS takes over
> +	  and the OS has to start it itself, which some kernels report as an
> +	  error.
> +
> +	  Boards that share one binary between variants with and without a TPM
> +	  fitted can enable this safely: when no TPM device is found the
> +	  startup is skipped silently.
> +
> +	  Note that a full self-test can take a noticeable amount of time on
> +	  a TPMv2, so this adds to the boot time of every boot, even when the
> +	  TPM is not used afterwards.
> +
>  config SPL_TPM
>  	bool "Trusted Platform Module (TPM) Support in SPL"
>  	depends on SPL_DM
> diff --git a/lib/Makefile b/lib/Makefile
> index 93a389b10e4..b31861fe4b5 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_$(PHASE_)OF_LIVE) +=3D of_live.o
>  obj-$(CONFIG_$(PHASE_)TPM) +=3D tpm-common.o
>  ifeq ($(CONFIG_$(PHASE_)TPM),y)
>  obj-$(CONFIG_TPM) +=3D tpm_api.o
> +obj-$(CONFIG_TPM_AUTOSTART) +=3D tpm_autostart.o
>  obj-$(CONFIG_TPM_V1) +=3D tpm-v1.o
>  obj-$(CONFIG_TPM_V2) +=3D tpm-v2.o
>  obj-$(CONFIG_EFI_TCG2_PROTOCOL) +=3D tpm_tcg2.o
> diff --git a/lib/tpm_autostart.c b/lib/tpm_autostart.c
> new file mode 100644
> index 00000000000..5b43b2aecbb
> --- /dev/null
> +++ b/lib/tpm_autostart.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Start the TPM during init, so that the OS does not have to do it.
> + *
> + * Copyright (c) 2026 Siemens AG
> + */
> +
> +#define LOG_CATEGORY UCLASS_TPM
> +
> +#include <dm.h>
> +#include <errno.h>
> +#include <event.h>
> +#include <log.h>
> +#include <tpm_api.h>
> +
> +static int tpm_evt_autostart(void)
> +{
> +	struct udevice *dev;
> +	int ret;
> +	u32 rc;
> +
> +	ret =3D uclass_first_device_err(UCLASS_TPM, &dev);
> +	if (ret) {
> +		/* a board may share one binary between variants without a TPM */
> +		if (ret !=3D -ENODEV)
> +			log_warning("Cannot init TPM (err=3D%dE)\n", ret);
> +
> +		return 0;
> +	}
> +
> +	rc =3D tpm_auto_start(dev);
> +	if (rc)
> +		log_warning("TPM startup failed (rc=3D%#x)\n", rc);
> +
> +	return 0;
> +}
> +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);

