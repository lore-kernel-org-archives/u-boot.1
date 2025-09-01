Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ADCCA0FFF
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 16:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF18A83965;
	Mon,  1 Sep 2025 18:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jadkIdNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0902383990; Mon,  1 Sep 2025 18:26:30 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E8583145
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 18:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3cbb0df3981so2220839f8f.3
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 09:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756743987; x=1757348787; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aSciuMpKuhN2On+gj7iiPD6+VDTsCIOxxfURbEsZf2s=;
 b=jadkIdNTJ4yhwrs9C5NVkWjQi/QV++LiHTtweNiq6ZSlM091OgJOqmn/vcqR7UpPRT
 ZVFoANGNh+kWlEQO9IpgksoLjJHBWuHzx3a3V6lI5HXdsmWf2Iwq/8Eebpe0N+bfVC/6
 DsZkvCTijwzzh4yjiPnWGigzcLvXMv0HaYweo5WOch3YXyQbHa84pEMdxb2GIbAKsDk7
 maz/W/FEmiLekhqbvX9/BrifT+eGUvqDHNzlAG1GS4r/urugdM/SVptRL4H3MAh025Dc
 b+EuuDHVpMkmFNcctRazY9d5FhrmmKmOsOPT1tajnGpxlUukKk6q+hwmO3i7O2P2qbmq
 75TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756743987; x=1757348787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aSciuMpKuhN2On+gj7iiPD6+VDTsCIOxxfURbEsZf2s=;
 b=BiTZ0/d+Rp8RVpezim47pxyAPM2mwjtOx1BTYDfVHLFoRFvppxSYsua0M8sExbtwxJ
 Twq+QSFWwo8eJ1jwKiPgmpgCedDIrmHBhCWrUJ0ongvgPJHitCpA2EN27TCphzC/Ed6j
 IIqJju8QhqDcX7oWT4t58mQ6YF7kOeUUfejL8WL0mXpwW5KQapkiRJ+aX8GAManvOIeL
 Tv5sSv2W3OssTl4cTR0V/H5lph/L90cxb4nedvbMZn1Mh5JZWlbS0LWLc6c+e2qYma9F
 tYr732FQt0VUpnGFgETfn2Eb+QksvNtjfWfMvPO14wm13uUNDk+8clpTcyk2QXPN2Bsu
 GRlw==
X-Gm-Message-State: AOJu0Yw+pcU8YU5dgYsclrjfneAimQVauPHxvG4aGk4JZKiYpJZr+yWE
 a007jwh9MCqyxHo8VohV/VmdIQrI/vA+geazP+TEZ+kH6yJzLZKhntPrgSZYZRcqZWQ=
X-Gm-Gg: ASbGncu9q7wLw3GFpwvbptNqUS9dfhx2t/kazGqPhxmaGOo3pcXvrdIkcEPEUzZBDeX
 63KAueP1jJB7yNB9sUkie9vfby+rarYWJ9ehU4wRIbj/5y2iv+8pApyY8SaMNdDhaOz83tQ0gtT
 Y20c+0ZSDs2MfEU/Ueh26JHwXVCUNDjMl6CnqBqIPGXVmeLKz9lqyiUqC/O+gwo7l6xqGUi8+qm
 NH7KbvHjOfF/GrNJpl5xW5NutiiDyxVhhlTQle0gNOSGbIyaDCOb5wguvgzEKq570gZSdBIki5d
 iCXpV2vt3hc/O0F562u+ELkJ8Gy1mN54UC3VHglA4eUG/MlI9hsWMw1LWSZCzFgEDUh52AWcEJn
 Z4pN8e63dURMOtod78lFXWAYclOKOGsT6LIEgiSIWObDZKFPzHfKfk8ViFo/zCqyQezSSiPGE5I
 5iY++aobaILbmbtIjQ9YgdXGI=
X-Google-Smtp-Source: AGHT+IHIbCUWhP8lX0Tfax70C8Z+cTMF/FGZdkBkQf0VBv5CtDAe6Q0Nw/JlCJNf7cyg2Hro1HS1Iw==
X-Received: by 2002:a05:6000:188f:b0:3d5:2c3f:99c0 with SMTP id
 ffacd0b85a97d-3d52c3fa1a5mr4363111f8f.5.1756743987044; 
 Mon, 01 Sep 2025 09:26:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986?
 ([2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0a7691340sm15036291f8f.39.2025.09.01.09.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 09:26:26 -0700 (PDT)
Message-ID: <b44654c2-de9e-4bd6-96a8-aa338435048a@linaro.org>
Date: Mon, 1 Sep 2025 17:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] power: regulator: tps65910: Cannot test unsigned for
 being negative
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-5-42a4105336ec@linaro.org>
 <78a0767b-2508-4602-a37a-eb4e72b37120@kontron.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <78a0767b-2508-4602-a37a-eb4e72b37120@kontron.de>
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

On 27/08/2025 08:54, Frieder Schrempf wrote:
> Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
>> The code in tps65910_regulator.c treats the field supply in struct
>> tps65910_regulator_pdata as an int and even tests the value for being
>> negative so change it from a u32 to int so that the code all works as
>> expected.
> 
> I'm not sure if this is the best solution. The supply field holds a
> voltage value in uV and u32 seems like a reasonable type to use.
> 
> I would argue that the driver should be changed to not use int and
> remove the negative value check.

Hi Frieder,

I would offer the counter argument that the TPS65910 has an absolute 
maximum rating of 7V so any advantage of being able to use all 32 bits 
vs 'only' 31 bits to hold a value in uV, when 23 bits would be enough, 
is somewhat lost.

As I say in the commit message all the rest of the code in this driver 
treats this field as an int and declares int variables to hold its value 
so using a u32 throughout this driver would just mean changes being made 
with no benefit. Removing the negative value check leaves the code open 
to unexpected behaviour and hard to find bugs.

More than that the field is being assigned to from the function 
regulator_get_value() which is in the regulator uclass and returns an 
int. So following your suggestion to its logical conclusion would mean 
changing the uclass and then that would lead to changes also being made 
to all other clients. This would turn into a major project which I am 
not very keen to take on as I do not see any benefit to it.

So yes, simply changing one field in a struct from u32 to int does seem 
to me to be the best solution. It achieves the aim of fixing the code 
with the minimum of effort and I see no downside to it.

Andrew

>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   include/power/tps65910_pmic.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/power/tps65910_pmic.h b/include/power/tps65910_pmic.h
>> index 2026ec2f426..8fa02f33ab1 100644
>> --- a/include/power/tps65910_pmic.h
>> +++ b/include/power/tps65910_pmic.h
>> @@ -123,7 +123,7 @@ enum {
>>   
>>   /* platform data */
>>   struct tps65910_regulator_pdata {
>> -	u32 supply;	/* regulator supply voltage in uV */
>> +	int supply;	/* regulator supply voltage in uV */
>>   	uint unit;	/* unit-address according to DT */
>>   };
>>   
>>
> 

