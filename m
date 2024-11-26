Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00EED3B996
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 14:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100F589C8A;
	Tue, 26 Nov 2024 15:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f2YHNH4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4368489C8B; Tue, 26 Nov 2024 15:51:12 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE18289C89
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 15:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so13435445e9.3
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732632669; x=1733237469; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dY22EhnmDtoPKCZN5v4HaV/9cik5yZ1vzaAHxqJo5nE=;
 b=f2YHNH4HQdaGHrd7NN8flpq6InpmO6c6TQEKheMu/ypIpLUzh+62FQ9ETxRqHc3zv1
 Hod9Ik5eVRnH+xCbXGckujC5U+qVqFNjo2UUbwEGWfwY0J57eMcV+9kzQpQcDV22siFM
 yvd+pE/I7QJn2FPeCUyREt52iTg7zHxEaz0uQbIG2t+fXTbDPBp/kK+DOb5Jmqw04omv
 uV1VAQ0I71lbBeAP0H9W54+04GpPlwfeF80vBSESzpFRklOh8CNKs3HIOUoWYTC+BpKM
 1WH7WshVynW22EjI9w4Q3TuAGd0d8Cq9t514kTYUoCHzgM46Yxed/kabbm8OQeycWATQ
 icYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732632669; x=1733237469;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dY22EhnmDtoPKCZN5v4HaV/9cik5yZ1vzaAHxqJo5nE=;
 b=lh5BD2xEV2SaJGb1mv23pYhMdXrhOZDTWS3yZ7gOqwrei3kCk0qWDiiFi/kGzpSFIO
 jXGdfjEq+xuw0v1yK/Zh62N6eVaywjYlCJ9NrnhiKgz5iYMGPLuLSak1VI0mFmTQZbyp
 /tFBw7SBcwKxwmPXDgi3LfIrxX4+0JtRd8PvWURXOtrCCvtKRjeHqTzOKhUJTxYfOVYH
 6welQ8UMYcXae+iMUrzwSNtnTFn0bIRC+KrbEBoZiUulS9c91CAjNhlc60DMRx13kG8T
 dAQLsLCLvNA/VTJiOLoNauNOs/W50M5a2sfvnR5JYpwL0Kkah2oxHQtAMjh0NvY95G9r
 SYWg==
X-Gm-Message-State: AOJu0Ywv8JvxEzDdR159CM/uQ0MpNB4zT1hzX12mwMRNW0PVY0Ufj4ZN
 rrpkbycNbnhF5Qw/mI01s2/8tNXJwbe/AHADPMg/DgeEBJA1VtOLwnCDIuPCv7M=
X-Gm-Gg: ASbGncshAWGi5PGEHgBeaYzV5NZstHSZl5p3wWakeEzxxdVwWuILwlNX+OlbBAQHzr7
 Vhs1Evq/pukn6P5ODOLbfuaeNdSbxsShgdolu9OXSe9rVlTweB9eTKmuf8V0itFCGtufG2tKL2S
 f5beJKU7mAayV0I5KWu/5dmMyvN/zO1tB2ZtoNfvzHb34W7xxuzpb54Ibrsp9v8rPuUK7JjIL/a
 RzzgIeoSw6rGgHB82TYbVHdkMoWk35zp3p3KBQ6Gh9pFRjSyhWKl7qgDkyxNRE=
X-Google-Smtp-Source: AGHT+IGHun/nky6/mNpd/7/Pyl6bITFyMCM9E05st4qAdpyjOTMA9H/iKE8Exdii9zi9+Elb2Z6dpA==
X-Received: by 2002:a05:600c:5128:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-434a80206f9mr15260885e9.27.1732632669237; 
 Tue, 26 Nov 2024 06:51:09 -0800 (PST)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349ca82957sm99996585e9.33.2024.11.26.06.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 06:51:08 -0800 (PST)
Message-ID: <b10dece7-15c4-48a7-90eb-59e88d89ca9a@linaro.org>
Date: Tue, 26 Nov 2024 15:51:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: lwip: dhcp: support arguments for TFTP file
 download
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <lucent@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20241114172007.2074874-1-jerome.forissier@linaro.org>
 <20241123024206.GS3600562@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241123024206.GS3600562@bill-the-cat>
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

Hi Tom,

On 11/23/24 03:42, Tom Rini wrote:
> On Thu, Nov 14, 2024 at 06:20:07PM +0100, Jerome Forissier wrote:
> 
>> The dhcp command is supposed to have the following syntax as per
>> "help dhcp":
>>
>>   dhcp [loadAddress] [[hostIPaddr:]bootfilename]
>>
>> In other words, any arguments should be passed to an implicit
>> tftpboot command after the DHCP exchange has occurred.
>>
>> Add the missing code to the lwIP version of do_dhcp().
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> 
> Applied to u-boot/master, thanks!
> 
> But please note, I believe this is what breaks
> test_efi_helloworld_net_http now as we can no longer abuse "wget 200000
> EFI/arm64/helloworld.efi" for example:
> U-Boot> wget 200000 EFI/arm64/helloworld.efi
> invalid uri, no file path
> Invalid URL. Use http(s)://
> U-Boot>

That's actually caused by commit 356011f7ac25 ("lwip: fix code style
issues") :-/ I've just sent a fix [1]. Sorry for the breakage.


[1] https://lists.denx.de/pipermail/u-boot/2024-November/573054.html

Thanks,
-- 
Jerome
