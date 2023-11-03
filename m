Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E195CC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BCC987495;
	Fri,  3 Nov 2023 20:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WZhHc9CO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9001287489; Fri,  3 Nov 2023 20:40:00 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A405886E54
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53ed4688b9fso4000034a12.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699040393; x=1699645193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=d7HnO0dNeoAHLsEexCzlbJkGDubEot2xMXB2AgLqkos=;
 b=WZhHc9COzZwcXb2PtmiTHjMHMcmOTZ7VCJ8Y+4L7upduFtUAK/jqVWr/IhcndLcacw
 9pRuIIke+ZW94DB7yt9HKKnXvNa8GYMKN2dcNggUvQNQLZXr2m7P5bwD1VKDMfqSFyki
 qe5u0khfE8cWEwUqnbCCgFN4gklLicactSurxbYpjr9O+p7nVvjsGoD41SXJrFAzcWNP
 w9in8YhNME4zLA4qqZ25OAu09EtP8YJh+Rnoc9kiuZLiiNVFWK1DwIGpnlUnXFtLuth7
 PlFNcgNBwUWrlTvawHzOZX+kpf3VhJmiTmcncfjYSqEEjxQoK5rTc3wjH2PTLw+t6YJr
 vEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699040393; x=1699645193;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d7HnO0dNeoAHLsEexCzlbJkGDubEot2xMXB2AgLqkos=;
 b=eXB5vP0Sg7y+apMu7P1eOtVHqzq87zq8fuO2y4NdhTwkGMXa6LvPbtRoQKCAczKD76
 Y50l/xFzoqAS3M31y7mwgM+uXgcLEG2BuLpt1PpqIwcfDcdJESVq8p961C7iE7J+ZLXg
 gkyDvRdWSOzOpK3ff02viSp/jbwNHO0y56QqdFYlxd2qg4uZDiXTELrJ0I+iNR0129cJ
 nyDy9hp13PHJ40XGun68otEiPdtuHqOZr1ndPFPwz4mgyMeAuGiLYuFmnTwWgY0QCWzz
 aUfqUIVKWmQ4+3qdfeHRpXhAAEBNqN0QE/CxDcPPbTjqxiuPyEq0KAiIs98U39eKsMum
 5HjA==
X-Gm-Message-State: AOJu0YyVa18pntKGpuPb2alN9jWBP6O8w1nO6GnOuSYlxilJW6FJy7OF
 ya2E4W4VMGc+ZgKZNPZ0NqPM/qni7Rk=
X-Google-Smtp-Source: AGHT+IF/KIbQmRVLJWIvvjtcfypKLm2sbM/M4dqZ15y3Bfg9fijiHnVU3tKEd5IGZKdp08Fd7engkw==
X-Received: by 2002:a50:9ecb:0:b0:540:61ad:6083 with SMTP id
 a69-20020a509ecb000000b0054061ad6083mr17304430edf.6.1699040392898; 
 Fri, 03 Nov 2023 12:39:52 -0700 (PDT)
Received: from [127.0.0.1] ([46.211.252.165]) by smtp.gmail.com with ESMTPSA id
 v29-20020a50955d000000b0054358525a5bsm1288483eda.62.2023.11.03.12.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 12:39:52 -0700 (PDT)
Date: Fri, 03 Nov 2023 21:39:51 +0200
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/3] drivers: gpio-uclass: support PMIC GPIO children
User-Agent: K-9 Mail for Android
In-Reply-To: <20231103190339.GA2621465@bill-the-cat>
References: <20231024083801.202365-1-clamor95@gmail.com>
 <20231024083801.202365-2-clamor95@gmail.com>
 <20231103190339.GA2621465@bill-the-cat>
Message-ID: <4FA8B3C5-B9FF-498D-A369-57AC099785AF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



3 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=BF=D0=B0=D0=B4=D0=B0 2023 =D1=80=2E 21=
:03:39 GMT+02:00, Tom Rini <trini@konsulko=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
>On Tue, Oct 24, 2023 at 11:37:59AM +0300, Svyatoslav Ryhel wrote:
>
>> UCLASS_PMIC may have GPIO children without exposed fdt node,
>> in this case if requesting fails, check if uclass is PMIC=2E
>> If so, iterate through its children to find correct device=2E
>>=20
>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail=2Ecom>
>> ---
>>  drivers/gpio/gpio-uclass=2Ec | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/gpio/gpio-uclass=2Ec b/drivers/gpio/gpio-uclass=2E=
c
>> index 7aece85a70=2E=2Ea3fc470a5d 100644
>> --- a/drivers/gpio/gpio-uclass=2Ec
>> +++ b/drivers/gpio/gpio-uclass=2Ec
>> @@ -1143,9 +1143,22 @@ static int gpio_request_tail(int ret, const char=
 *nodename,
>>  		ret =3D uclass_get_device_by_ofnode(UCLASS_GPIO, args->node,
>>  						  &desc->dev);
>>  		if (ret) {
>> -			debug("%s: uclass_get_device_by_ofnode failed\n",
>> -			      __func__);
>> -			goto err;
>> +			struct udevice *pmic;
>> +			ret =3D uclass_get_device_by_ofnode(UCLASS_PMIC, args->node,
>> +							  &pmic);
>> +			if (ret) {
>> +				log_err("PMIC device get failed, err %d\n", ret);
>> +				goto err;
>> +			}
>> +
>> +			device_foreach_child(desc->dev, pmic) {
>> +				if (device_get_uclass_id(desc->dev) =3D=3D UCLASS_GPIO)
>> +					break;
>> +			}
>> +
>> +			/* if loop exits without GPIO device return error */
>> +			if (device_get_uclass_id(desc->dev) !=3D UCLASS_GPIO)
>> +				goto err;
>>  		}
>>  	}
>>  	ret =3D gpio_find_and_xlate(desc, args);
>
>This needs to check for DM_PMIC or so as it leads to a lot of size
>increase and one failure to link due to running out of space now=2E

Thanks for checking! I will look into it deeper to reduce the size inflati=
on, not sure though why it occurs at all=2E
Best regards,
Svyatoslav R=2E
