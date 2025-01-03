Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5117AE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 08:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F11E80295;
	Fri,  3 Jan 2025 09:49:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W+3+SXlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C9C802EF; Fri,  3 Jan 2025 09:49:06 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE4EF80196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 09:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aaec111762bso1804919666b.2
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 00:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735894143; x=1736498943; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RsOosr9PuVGFB6h8YBz2a96VM/TTlMizWKg0DdlnL1w=;
 b=W+3+SXlpKmCbF2C6v5MvFjKy8aDVok5mTfrG/uR1YP/Wy0q6KFOPOl5oPLYX0BGvHo
 GA2o/qX2M6Ygr6/V1BZQaX9NB/twLXa9TI+6A1TmTbgRLFQdlzGmBpSg3avzpgHDtzD/
 FwPTYI7a8rNfWNgytVfBc55dtiEpCkwka199syqm4C3/1+4jq3aLV8+PhwsJIFxHhxnk
 H7Ktz5SbefwdHEljwpzaL5NMAuaDwe6NFOHfc1ARPQhBPVht4pmqG/W1GCvRWghvFcpx
 VcM6Q66CAgHTFCXs2DGhtBRe/tgFFE5pz6uE2jcJ3tenXv6mlId2f3KhVSPLNNRvyCc/
 PmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735894143; x=1736498943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RsOosr9PuVGFB6h8YBz2a96VM/TTlMizWKg0DdlnL1w=;
 b=OGVfhSQt6mCFJSTQJu0xhK9nPJGZJNoIhe/MRiPVEbzoZctg/lwO3WKsj79haJFm68
 JDfxEriKaGNYOz5RcQe3fL+iqnalIlmDaItRGefyqoc/vQO4Jab3/oHj8q9Tnxm+E2FV
 rzqHxxkyX0wNAPqtodTHsLbQQtzFmMAhtDUJA6EMDSrnxbjQiliH/nIGmtZF83K9O9H6
 fP7q4h9TWK/NG/h2CgJzRyX9XFqfQ/AksUPWoU5LHqAN+sYfpalXA2rEDon/bHtRXmFV
 uokmw7HvaoE/ED7i8MOr+/p16woON4368AZlS0UP1hgyxUY4kYqoo5pvLbZjTI8b4wP/
 5r7g==
X-Gm-Message-State: AOJu0YzeW015Lxht8B8nC0lVyY9S2QGPHJ2aaMANuUuc6b0s9kKzqy3W
 xMykUxiZcqFtmR8KArxYEOxBhNi9rHNRMnhPpFS0JXzd3SMcQ3qmEc/exitt5l544DGoHp08J1f
 TWiA=
X-Gm-Gg: ASbGncv3KzxLEAqjeYpersqu2EZYEDpnHevgc0Og4cakcgSexqyd4VHgy99gY0Vu1dj
 STM5ErXW1tfW0moeen11ad9dohuAyI5w5qNNlEBO3pMXqAsxdiDOPFYJO49OsUzh2Z18lCzEy+5
 anWOupcSH5u9T0d54hV0M3VTupRNZACDTouaa+dplNOwwcTV6p9qaLagVrVVk7K1mOB0c47zr9w
 sbZlLJA/hrT5DdIUPWQeIFhTsMiEA6IKNx54m/YrNUM8LOBLZ42nwD5zpdRnacSWrfOJbCJWKtc
 jEpymsCwIRywcLNrRKBOKHNZ/YinJA8Ljg==
X-Google-Smtp-Source: AGHT+IEcY+00TTf5ad1NM5HMdxGPrtNKXZzOQzA46hy2sXr7wzp4qQVZEvil/XTcJAPT91q+Hqk4ew==
X-Received: by 2002:a17:907:944c:b0:aac:61b:580a with SMTP id
 a640c23a62f3a-aac3443bfd6mr4789102566b.61.1735894143249; 
 Fri, 03 Jan 2025 00:49:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c381:4b2b:2e3a:bef?
 ([2a01:e0a:3cb:7bb0:c381:4b2b:2e3a:bef])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f06629esm1874464566b.189.2025.01.03.00.49.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 00:49:03 -0800 (PST)
Message-ID: <5f8a2f37-87ba-4067-a119-7ccb043d632b@linaro.org>
Date: Fri, 3 Jan 2025 09:49:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Static initcalls
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
 <20250101175518.GA1682161@bill-the-cat>
 <CAFLszTjryDVBwn-RxfgTOneUBBUsE-3sS+Y1ykk5BOKzeFc9Gg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTjryDVBwn-RxfgTOneUBBUsE-3sS+Y1ykk5BOKzeFc9Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Simon,

On 1/3/25 02:41, Simon Glass wrote:
> Hi Jerome,
> 
> On Thu, 2 Jan 2025 at 06:55, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Wed, Dec 18, 2024 at 04:53:53PM +0100, Jerome Forissier wrote:
>>
>>> This series replaces the dynamic initcalls (with function pointers) with
>>> static calls, and gets rid of initcall_run_list(), init_sequence_f,
>>> init_sequence_f_r and init_sequence_r. This makes the code simpler and the
>>> binary slighlty smaller: -2507 bytes/-0.23 % with LTO enabled and -1232
>>> bytes/-0.11 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
>>>
>>> Execution time doesn't seem to change noticeably. There is no impact on
>>> the SPL.
>>
>> This leads to run-time failures on SH:
>> https://source.denx.de/u-boot/u-boot/-/jobs/986701
> 
> I'm not a huge fan of this series in terms of the style, but this is a
> significant code-size reduction!
> 
> For the board_init_f() etc. functions, can you do a follow-up with a
> comment indicating that logic must not be added?...i.e. that we don't
> end up with variables, if(), etc. in these functions. I think that
> would be a good rule to have.

I agree. I will add a comment in v3.

Thanks,
-- 
Jerome

> 
> Regards,
> Simon
