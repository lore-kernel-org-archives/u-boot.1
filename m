Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF299CEE35B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 22:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2429688DD4;
	Thu, 10 Oct 2024 00:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V8tRhIIs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 840B788BC2; Thu, 10 Oct 2024 00:16:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 772E588DDD
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 00:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1EF413F5B5
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 22:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1728512185;
 bh=XyA45uBJEOHP0790+04CC5Xvxtr9iOc+XKrfZ02uYbM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=V8tRhIIsl+REWv8g8KANn3up+wVASSajEgcxMRoySuYSBMWwsTJvz7AGFW6twJn0L
 NEER6tY1U5NYlC/YTsSMj8KphtsyBm1bLCBKOFkw8NY6u/VxP8m2C9DR1XpYOwH7Cj
 3cHJUAGx7M9VBvHJcqWuyS0CrtxjAhqDSOxWaSmxXeisZb8r54SWFrstjuijTUajiq
 ajB8NHhRlaN8M2DOJ2hX0+l487EaB+AokCG1dig4ClUKUhUHz9DutYOuTplJJ76L2V
 sPcgWgbPJmgTS3rSzRvEPwQYRsLCUEwyqW5eFuIPgsHlmxI42UidORf6G8+FtUrPOu
 prSFVJ/ghfiDQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37cd08d3678so116259f8f.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 15:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728512184; x=1729116984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XyA45uBJEOHP0790+04CC5Xvxtr9iOc+XKrfZ02uYbM=;
 b=LEO2lpcQYSEDX/xHrR56k+dDeIGhw086aQszYxUaq+CpSn4j73G9q4+WEouvoWscmH
 tnsA5VloE0bG2J2a6I6xtiqXD7bBLQdPTFTbHBSsMqwWoQzYfjvqOwmQoWoy33SV2V2A
 92ra3tELMTT3wh13SGkOHvVU7TwYM+K7gU0laIz8EyhQNXV3NZJl53bJrHiIlm2Kl+d+
 9JiQxh996MIAAWctrgxrr0omifRiGj3mNDHGLA96PFHoy0OiWZyaQYlEWCouH97KASJ3
 r5aaQRc5XfGMsKDjXMsncOckvlR9p/VJ9GdsuoWwlNbaJAJvp/7s/A0W64E4JEM8k/ES
 IBtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY9EVfup8libte+wSRwIziJWBHozpvoLQ76y2xooXeJadfUcp6vBm2qx/K8CEJhNkQZRy5MsU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5RY0hDlW0R9yW1HeHrPOynN4pDImYVU3lTvvBCvh5xw/+H0qC
 bjI/ze7N7hQJq/+Y1tTLFRY6J+YpvcYVALWf+ruRtuyt5M84DxFvXR0nC9cVNSC7ExOw+b4KLa+
 X9xzXAvBCJigLJ4TAj2BzgKGVPSu67PxpNzQV5w86zJlH4flZoH1XIPrFe62qJr8U3d8=
X-Received: by 2002:adf:fccf:0:b0:37c:bafd:5624 with SMTP id
 ffacd0b85a97d-37d481d2a89mr931789f8f.25.1728512184149; 
 Wed, 09 Oct 2024 15:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6ejRx+TQdvPD9dYHWR0CziEVWCMHgcdNK1jfECjP+b0Ti8IHQqTE6WHYuanBl9p24DBXf7A==
X-Received: by 2002:adf:fccf:0:b0:37c:bafd:5624 with SMTP id
 ffacd0b85a97d-37d481d2a89mr931784f8f.25.1728512183791; 
 Wed, 09 Oct 2024 15:16:23 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:3cab:4823:b867:e230:71c3?
 ([2a02:3035:6e0:3cab:4823:b867:e230:71c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d3f568fd7sm2191995f8f.102.2024.10.09.15.16.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 15:16:22 -0700 (PDT)
Message-ID: <fc8dbc41-3df7-4771-8f74-cefb85330d8d@canonical.com>
Date: Thu, 10 Oct 2024 00:16:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: Show the FirmwareVendor and
 FirmwareRevision in helloworld
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20241009115552.31455-1-heinrich.schuchardt@canonical.com>
 <CAFLszTiB8=SDPz2Tz-J3JUdVaVb2iHaE0Oj=84hmxZ6oEZKFPA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFLszTiB8=SDPz2Tz-J3JUdVaVb2iHaE0Oj=84hmxZ6oEZKFPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/9/24 23:14, Simon Glass wrote:
> On Wed, 9 Oct 2024 at 05:56, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>> From: Simon Glass<sjg@chromium.org>
>>
>> Show the firmware vendor and revision to make it clear which firmware is
>> used, e.g. whether U-Boot is providing the boot services.
>>
>> The output will look like
>>
>>      Firmware vendor: Das U-Boot
>>      Firmware revision: 20241000
>>
>> Signed-off-by: Simon Glass<sjg@chromium.org>
>> Signed-off-by: Heinrich Schuchardt<heinrich.schuchardt@canonical.com>
>> ---
>>   lib/efi_loader/helloworld.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
> Reviewed-by: Simon Glass<sjg@chromium.org>

I just looked at the output for my Asus mainboard. The AMI Bios uses a 
value of FirmwareRevision which was introduced into EDK II in 2009 and 
does not relate to my current firmware. The SMBIOS table type 0 seems to 
provide more accurate information.

But anyway it is good to have a tool to look at the system table 
information.

Best regards

Heinrich

