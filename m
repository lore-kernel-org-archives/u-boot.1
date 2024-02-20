Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7362C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 17:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A9D87FE9;
	Tue, 20 Feb 2024 18:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uJfIQhmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F28A87FE6; Tue, 20 Feb 2024 18:22:17 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B25087FDB
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 18:22:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-512b29f82d1so3528693e87.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708449732; x=1709054532; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=63zII7G/pXb+UOKUUF/QrH7LX69YOLRF7vvTVOaoc4g=;
 b=uJfIQhmVf0s2GxOuYo0WKvgxNXirlCUXHyR9qLQ1NEWB2an+yxpAAj4v9kL3stVERx
 Okj9zwehA1S2S+vuovVjBBqJNCxFYjuBHnqT/T0U+knv5tf6x1iY2UwmPYoNshL2yNH3
 t93GYO9BMmNA/lKbUqmHEsHkiZ9cauEUJYpLDsmpuGNFESTo+/toS5Ou6GhgwEfxtWCB
 PgD/P9IGe92wSfgs6vCyUTYPlzUFGVds0AJuOPdkhw05eOtzeIz8irv0iaFWxduvJk7G
 1zX74LhjnL8KmIT84qf7JyHrs4ooYb0Nd6pK7zCJmQKVZePunPylY8y7E37FiGwIuCZT
 9SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708449732; x=1709054532;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=63zII7G/pXb+UOKUUF/QrH7LX69YOLRF7vvTVOaoc4g=;
 b=od9fFLOo4q48j1g8BPJtz4qaoRXs9xPw7Hi+EJZLygzUYpfb4YzGsVGAjdk39KHh82
 jmA+OocAG6UX231n+uxGd1PonCXFfnJPTXyx+PgnRItHLS7hvJjQ5PgLQgltQzOOvHWC
 Pi18FKITs8wiAg4EyWaKQIso8DacH67mOoBC19U6eP/KFem1iXgJw+GskzO9lUPqqbwF
 3ZXyVw3ITX5A/JBYJeRKU0723kULnk4rC3W8ky2gDXf09ff/bRTawlsQIoQ9wUPuk8Is
 DTm2PQHeqXweGspNtMgtwIWQf03vSjmDTPmODczsfCxXHi1mmf5m8ll+jIPSTZU0xiuJ
 sZoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5WQ8v0goAlOONVOCcwnc0PahmWueRma3temQq9joELDQnDk+242YhbB+90pynCXEg5KE02SJoxWFljTwhrrzu13Ux8Q==
X-Gm-Message-State: AOJu0Yz1kSJWwh7mRnFbBMm0fN7B8zpOKHUrSlMYq3eFZDMkA2A3sZE9
 hZ3nYFb6MWjrpudTVIK91FfrbaBMeJWbWaaX0obsijx3YQi7zXKlWPqRRSlnZWU=
X-Google-Smtp-Source: AGHT+IFVTUCKPGbegL3lBPTDjaEkpL29RBokVTIkJXPruwkdjwl+w5o8aJFkvsrXA4fDmn1NqHhx0g==
X-Received: by 2002:a05:6512:1290:b0:512:96dc:ab50 with SMTP id
 u16-20020a056512129000b0051296dcab50mr10866111lfs.20.1708449731758; 
 Tue, 20 Feb 2024 09:22:11 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a170906770c00b00a3df13a4fe0sm4218686ejm.15.2024.02.20.09.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 09:22:11 -0800 (PST)
Message-ID: <ca960f7c-6b78-4355-bdee-008ade4d91c4@linaro.org>
Date: Tue, 20 Feb 2024 17:22:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/39] board: dragonboard410c: add chainloaded config
 fragment
Content-Language: en-US
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-16-ed06355c634a@linaro.org>
 <CALeDE9MzcnEBR-McJvJo8FPf8ad=8ytoU0+HkmpB4s-bLEDAwQ@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CALeDE9MzcnEBR-McJvJo8FPf8ad=8ytoU0+HkmpB4s-bLEDAwQ@mail.gmail.com>
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



On 20/02/2024 14:19, Peter Robinson wrote:
> On Thu, 15 Feb 2024 at 21:03, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Add a config fragment for building U-Boot such that it can be
>> chainloaded by aboot/LK rather than being flashed directly to the aboot
>> partition.
> 
> How does this work in practice? I think a lot of devices, one example
> I see is signed vs unsigned, or emmc vs other storage, have to
> configs, how would a user choose with LK vs the other option here?

I'm not sure I understand, maybe the commit message wording was a bit
vague... There is only the default mode where U-Boot is flashed to the
aboot partition, and then the chainloaded usecase where it's wrapped in
an Android boot image and flashed to the boot partition.
> 
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  board/qualcomm/dragonboard410c/configs/chainloaded.config | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/board/qualcomm/dragonboard410c/configs/chainloaded.config b/board/qualcomm/dragonboard410c/configs/chainloaded.config
>> new file mode 100644
>> index 000000000000..3fd064924a1f
>> --- /dev/null
>> +++ b/board/qualcomm/dragonboard410c/configs/chainloaded.config
>> @@ -0,0 +1,7 @@
>> +# CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK is not set
>> +CONFIG_TEXT_BASE=0x0
>> +# CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR is not set
>> +# CONFIG_REMAKE_ELF is not set
>> +CONFIG_POSITION_INDEPENDENT=y
>> +CONFIG_INIT_SP_RELATIVE=y
>> +CONFIG_SYS_INIT_SP_BSS_OFFSET=524288
>>
>> --
>> 2.43.1
>>

-- 
// Caleb (they/them)
