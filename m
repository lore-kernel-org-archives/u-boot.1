Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31855FF60D5
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 07:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A7983DBF;
	Tue, 31 Mar 2026 09:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oD+YrEwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B5783DBF; Tue, 31 Mar 2026 09:00:36 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13A5580212
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 09:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so42061495e9.0
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774940433; x=1775545233;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EhrqRSZZS5c5HD6Jrlw70HA7qhN7sxdTI92yYmsmf0Q=;
 b=oD+YrEwzO9iUnJ4rPzBZK0zNmYXwYfQo0VxGOtzmy1GiQl0aLWY+0bQR0ElODaecH7
 aFWdDwJX+tXlcF7JvH04tc+HiFDFdYqlkMG/2GA5jpetlLLZ7pGT4GV0LGIiDqJQzLZh
 uhtRhFxMIbYfoWg6cxuxIkRr0Rdq1Wal19wnv020kqmjEtWlDdeuF+0SBf98vRSS8AQ9
 5qkI7Ku7bawANSqPSzs/92jvk7Gl7XaZ8Oi9zgOe19ObyUNNwKsPLvdnJBRvZ2OVCSk8
 TPLGHRgQz9Jy7HxQEamn3lOTqHw31XdbQrsI0h5HH8WwAHn/wkoRhq/Bzk13uiuBzZAb
 8NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774940433; x=1775545233;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhrqRSZZS5c5HD6Jrlw70HA7qhN7sxdTI92yYmsmf0Q=;
 b=B22qv6Yfv7DuSxJYR4Ntrd2/5JQgxLSPTW+fdOPxCF8el0OlmjZM8dbmiBshaf622Z
 v0+tmIi/jHNvCc3SfGHiY4va0J2CGNnVu0Tv2Jys16Ss3Tl4mWOmjUnVU0M+B0EZnFJ8
 MwEfpBKSEqCtvsJqWm0JURKXbNXcTjLT/JVyaU974pyEkAYLqRSs/7p6LUMHjpjDb2xW
 Uz8V5gykrzWo/ETCZZiFxPMf4Guqr4ioqYKY+YULEsyUfuV+83ipjjw3iHV4iwuQL9dl
 BIYc8+Lsfj/eRlyxaIUbRQls2wUfnRWv0Mn1GCXwsAnuufBAKFLzm3MrsUfcS9+IxT/Y
 msJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHbOxyBYEkTB56LTNcX1y2/CjiFsfCIjWsY7HvHCc9P65hReId37WkfnL6sa7BVh+4PIwVZgk=@lists.denx.de
X-Gm-Message-State: AOJu0YymVBVR28ACfZGr80QCLv4vNGw+jiS/+AJ2j38bTxXRUD0tBOyR
 S2aUP/klMwl5fIuI53659WJfITzIVdAYo+7oM6yJ23wnVMFT4F8tphkfsV3LDgjXtfE=
X-Gm-Gg: ATEYQzwuUkI1FlWGgOBQaZaDG82URRbldY1Xmys1GOVIyYSflDqHWwvNhBpG+eZ2alf
 8CSLArYlDBLBRDHDq+ZP16cL8J4WcumEHOpnjkI+kKPNZdN8UKvWlZuNbVHo4nPYR8VbkU4m3YP
 g751DsMDqohyCdHtY1WibfLMx+fCvKtdjz/TgeFgQrE29225LiTJmhO1wq2Ck2+07eqsFiNPmVC
 EaF35+kluArJY1haDgMwfsQT9leAHXMBdiZ1mgfM2YEsm5lwxqyhHUgf/b4fNC7iM3tvhavHZK/
 fWY9tQMx3ThXIh/IifVcguNe5EjKlcNhvH904khiIlqp2dpXpAob6N4XuEiuYH4BBcxagrQCJ7W
 LX+OaPsa5AogeLMn7Ouz6mzvEPgvmTCj1rM3940awuReM9tw/+3gvPmM19jNqazE0xMJWKwK7gi
 4JLCyc6Yv3lKx8JWB/HmvbdM8GVFU=
X-Received: by 2002:a05:600c:a11a:b0:483:709e:f238 with SMTP id
 5b1f17b1804b1-48727ee5405mr177189515e9.29.1774940433322; 
 Tue, 31 Mar 2026 00:00:33 -0700 (PDT)
Received: from localhost ([195.52.184.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c884c10sm8806675e9.19.2026.03.31.00.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 00:00:32 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=9a565b9683e0ac3540886abdc2bc590754cc48f5f2f6851fd83e60e14951;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 31 Mar 2026 09:00:22 +0200
Message-Id: <DHGRV9DE9A3T.1I61RAHP95WSW@baylibre.com>
Cc: "Andrew Goodbody" <andrew.goodbody@linaro.org>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, "Michal Simek" <michal.simek@amd.com>, "Simon
 Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] dm: Respect dma-ranges size
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260315235756.304972-1-marek.vasut+renesas@mailbox.org>
 <DHG5MITAHNOS.3KKMVUI98SAZ0@baylibre.com>
 <2c4f13c9-ff78-42c6-b770-71d06f59d522@mailbox.org>
In-Reply-To: <2c4f13c9-ff78-42c6-b770-71d06f59d522@mailbox.org>
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

--9a565b9683e0ac3540886abdc2bc590754cc48f5f2f6851fd83e60e14951
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Mar 30, 2026 at 7:24 PM CEST, Marek Vasut wrote:
> On 3/30/26 3:34 PM, Markus Schneider-Pargmann wrote:
>
> Hello Markus,
>
>> On Mon Mar 16, 2026 at 12:57 AM CET, Marek Vasut wrote:
>>> Rework dev_phys_to_bus() and dev_bus_to_phys() to respect the size
>>> of the area specified in dma-ranges DT property. The area outside
>>> of ranges is remapped 1:1, while the area in the ranges is remapped
>>> according to the description in the dma-ranges property.
>>>
>>> Adjust the test to test the area within the remapped range, not area
>>> outside the remapped range, which was incorrect.
>>>
>>=20
>> Should this have a Fixes tag?
>>=20
>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>=20
>> Not a big expert, but this looks good to me:
>>=20
>> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
>
> This was broken long enough, so this should go into next so it would get=
=20
> sufficient testing before the next release.
>
> [...]
>
>>> +++ b/include/dm/device.h
>>> @@ -166,8 +166,9 @@ enum {
>>>    *		When CONFIG_DEVRES is enabled, devm_kmalloc() and friends will
>>>    *		add to this list. Memory so-allocated will be freed
>>>    *		automatically when the device is removed / unbound
>>> - * @dma_offset: Offset between the physical address space (CPU's) and =
the
>>> - *		device's bus address space
>>> + * @dma_cpu: DMA physical address space (CPU's)
>>> + * @dma_bus: DMA device's bus address space
>>> + * @dma_size: DMA window size
>>>    * @iommu: IOMMU device associated with this device
>>>    */
>>>   struct udevice {
>>> @@ -196,7 +197,9 @@ struct udevice {
>>>   	struct list_head devres_head;
>>>   #endif
>>>   #if CONFIG_IS_ENABLED(DM_DMA)
>>> -	ulong dma_offset;
>>> +	phys_addr_t dma_cpu;
>>> +	dma_addr_t dma_bus;
>>> +	u64 dma_size;
>>>   #endif
>
> [...]
>
>>> +++ b/include/phys2bus.h
>>> @@ -21,17 +21,23 @@ static inline unsigned long bus_to_phys(unsigned lo=
ng bus)
>>>   }
>>>   #endif
>>>  =20
>>> -#if CONFIG_IS_ENABLED(DM)
>>> +#if CONFIG_IS_ENABLED(DM_DMA)
>>=20
>> This is not related to the code changes right?
>
> It is, see the matching hunk above and below why this is guarded by DM_DM=
A .

Ah thanks, yes, the macro had the check for DM_DMA, I missed that.

Best
Markus

>
>>>   #include <dm/device.h>
>>>  =20
>>>   static inline dma_addr_t dev_phys_to_bus(struct udevice *dev, phys_ad=
dr_t phys)
>>>   {
>>> -	return phys - dev_get_dma_offset(dev);
>>> +	/* If the PA is in the remap range, apply remap. */
>>> +	if (phys >=3D dev->dma_cpu && phys < dev->dma_cpu + dev->dma_size)
>>> +		phys -=3D dev->dma_cpu - dev->dma_bus;
>>> +	return phys;
> [...]


--9a565b9683e0ac3540886abdc2bc590754cc48f5f2f6851fd83e60e14951
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCactxBhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPW
EQEAtGGh0C6hlxhPs20XJPVDGFU/Z/m5bRcW3hy9ug+megEBAPyAQY1VtI2GZuEC
MV3JsVH2HwME/HYfhLofQGaGk1QI
=3j6u
-----END PGP SIGNATURE-----

--9a565b9683e0ac3540886abdc2bc590754cc48f5f2f6851fd83e60e14951--
