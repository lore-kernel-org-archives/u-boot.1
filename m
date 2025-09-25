Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36B0CAC5A5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 11:11:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39503836C1;
	Thu, 25 Sep 2025 13:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AnQcqEfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 978B2836F0; Thu, 25 Sep 2025 13:11:19 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87CDA830CA
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso618770f8f.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758798676; x=1759403476; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tl25qpKWRCsL0ghG41BoIwvsW/OG4ixrOoKkYaykqVU=;
 b=AnQcqEfkmclQucL4wNTiop04Fly5xXj5H13zEgVAlrOUe7NxwDu3c/ooj1WZMx4hAX
 dNvRNxIVXXb9coaLpXr65qX2EnP0VOJx9vk6vGB0K8CqEgNTA3SnPknvBgiiBx44cSQH
 XxNPHQ1QiY4SkNLtQ1bh3zqtSgdkURPgLo2Vqy8CVPmp64MsOx/Q6C0QFZjWczFouKTR
 mTHdwTHhuFplyL7WWWmCItV5C7FWxiOM3qgdwwvuGHEvft6oy9Rp5yYxhYQh03yiM0rA
 PrwyJQx/A01Lp2U8OCuMXkruIqY4bm3wSdk+CuopmeliYCrnK92enssgMv0nS8fatg1O
 rLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758798676; x=1759403476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tl25qpKWRCsL0ghG41BoIwvsW/OG4ixrOoKkYaykqVU=;
 b=wykRvGk6POT7dwXGs4daGeOzhlJ0ti50AEhq6Rj3JKpg/V22GmaO1QC3rV1Uuqb6+v
 Q3je6oo6snnftxFu3jzz+ze0VT6LGnRIEXKTzpHx+yum0AGVQzikUJSedJWTBRHXWg9F
 tUhkSxM4tU74NpPJO8sDY8p3eXHxU6zjYhmqjIS4J85zGBtDF88RnpeHBtDIQxqB2cz5
 eCd16ZFfZISn2Vy1cEccG6XIpi7KpZ/EKTscGVJBfhNHN0odezPZX8DcAwKJ5xERWlg9
 AZdaoPF6s7RRbEjew6GJw737oxaQDPn3C3zSEHNSzG4nkl6n9n7fG1wNTm9v7O0UjvR2
 lY/Q==
X-Gm-Message-State: AOJu0YxxwfLtbu7RsL0aMN0PHkDsFu918/vsxgndFl4worI78aA6NV09
 K65u8BA5hSJIQ3eBzHV4ZM9mWjaoMu1mvUPaHEohoVkowudiZbGkJcENLEYq+kPbu3Y=
X-Gm-Gg: ASbGncsGW+880tTRk0DXlQ5jfouIACCRtYNgtYJ8IWpYMzm0d+5GlAXIEweRKrejN1o
 HlraLFKcXEtujyKtA+Ted3911qlinHKA4GW0hgJ7QGMn6RbHQFDpPhd/bS7YsR8YdM4aRrjB/fc
 G83XZus2fBQpg3WvyBSgDgtZGAsqACRKkbyHNe8U1cW/tLJrmJTQDH5HmDS9zxr0PoysX40NNi+
 xRtm+9Ws8H8tt32LM1BzCd524iM7MeUTKspDPjA3LG1l6eVR847wo1ZtcImppgwi8qXNwieWptC
 +7dEBkrbZpL0wiXwFiyLo91sjE+z+/kLOxYSjvJFfyw3Lu+W7OIBAPQc7ny7MjKQC4vM5aGgQke
 1bI3vJOqJUHKiuKKorn8FUbH5LhmqICihpwy+jjNeEinTspkiUpLkCAaXv4AO2u5cVeNuCF6GM8
 42MQ==
X-Google-Smtp-Source: AGHT+IGqO6LBPASJOqPZhC+jMAQg8FKC6JGJN3Qb1DSxVN2xhqqzsapMsBkDqeg00AsyrF3g8IRtvQ==
X-Received: by 2002:a05:6000:22c1:b0:3ea:71c4:8e27 with SMTP id
 ffacd0b85a97d-40f64c5e2b5mr1980867f8f.22.1758798675916; 
 Thu, 25 Sep 2025 04:11:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:f9e:3c01:5cb4:3820:cbe0:c98b?
 ([2a0a:ef40:f9e:3c01:5cb4:3820:cbe0:c98b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6921bcfsm2702711f8f.43.2025.09.25.04.11.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:11:15 -0700 (PDT)
Message-ID: <5b5d3865-1bc0-45c5-adf8-0f63cfda47bf@linaro.org>
Date: Thu, 25 Sep 2025 12:11:14 +0100
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
 <b44654c2-de9e-4bd6-96a8-aa338435048a@linaro.org>
 <d320ef0e-2711-4f86-9881-6aabdf6766c2@kontron.de>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <d320ef0e-2711-4f86-9881-6aabdf6766c2@kontron.de>
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

On 01/09/2025 17:58, Frieder Schrempf wrote:
> Hi Andrew,
> 
> Am 01.09.25 um 18:26 schrieb Andrew Goodbody:
>> On 27/08/2025 08:54, Frieder Schrempf wrote:
>>> Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
>>>> The code in tps65910_regulator.c treats the field supply in struct
>>>> tps65910_regulator_pdata as an int and even tests the value for being
>>>> negative so change it from a u32 to int so that the code all works as
>>>> expected.
>>>
>>> I'm not sure if this is the best solution. The supply field holds a
>>> voltage value in uV and u32 seems like a reasonable type to use.
>>>
>>> I would argue that the driver should be changed to not use int and
>>> remove the negative value check.
>>
>> Hi Frieder,
>>
>> I would offer the counter argument that the TPS65910 has an absolute
>> maximum rating of 7V so any advantage of being able to use all 32 bits
>> vs 'only' 31 bits to hold a value in uV, when 23 bits would be enough,
>> is somewhat lost.
>>
>> As I say in the commit message all the rest of the code in this driver
>> treats this field as an int and declares int variables to hold its value
>> so using a u32 throughout this driver would just mean changes being made
>> with no benefit. Removing the negative value check leaves the code open
>> to unexpected behaviour and hard to find bugs.
>>
>> More than that the field is being assigned to from the function
>> regulator_get_value() which is in the regulator uclass and returns an
>> int. So following your suggestion to its logical conclusion would mean
>> changing the uclass and then that would lead to changes also being made
>> to all other clients. This would turn into a major project which I am
>> not very keen to take on as I do not see any benefit to it.
>>
>> So yes, simply changing one field in a struct from u32 to int does seem
>> to me to be the best solution. It achieves the aim of fixing the code
>> with the minimum of effort and I see no downside to it.
> 
> Thanks for the reply. I totally missed the fact that
> regulator_get_value() returns an int. When I was looking at the code, I
> assumed that there are only positive values ever used.
> 
> You are right. Sorry for the noise. The patch is fine.
> 
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Thanks
> Frieder


This patch is still showing as 'Changes requested' in Patchwork but I am 
not sure why. Should I change its state or should I leave that to 
someone else?

Thanks,
Andrew
