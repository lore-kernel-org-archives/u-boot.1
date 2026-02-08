Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD27DEF06E4
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 20:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FD78341A;
	Sun,  8 Feb 2026 21:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mDNi/71o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D8983642; Sun,  8 Feb 2026 21:21:12 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B9C805D7
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 21:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43638a33157so708793f8f.1
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 12:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770582070; x=1771186870;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e/Z2gf3jdcRruG3i9VdFsZTFsXfj3Z4P/M1d3sWlxXc=;
 b=mDNi/71oFsVF+mh1GdAopGi5urW5JoxcB5LtmbRa+c9rWYyKlTlaD9gwp5RfUaHhjz
 3Y6xQiUrgXrL+NyMK9vZQvJQ67bK02yK4s2WbqEbPpu1QD7n1nO3gSy7izr7ELJG6Xao
 mXpbVzIqi07WkrKd2sS8E3crD6M5+1WpU5EBWUNjRFcrWlZ+c8IZUo7iX4VbpEIgIjUW
 GUXuOAgXEXpkG+GNIiuZCyu7MseFzbf9voJycMIyxc17TjpIMPIlGzbm6+vCeNFbMJNd
 TTqUtqAC+5chvVIZ2AeDwbMt/FcEIOwFq/9TDz1XQtijOtcY0WyDdVQT3RhCm6tncmye
 z4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770582070; x=1771186870;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/Z2gf3jdcRruG3i9VdFsZTFsXfj3Z4P/M1d3sWlxXc=;
 b=CIEdBcQ0YbPu2kD18yQaMCse0qe9UTOQ06C3Dmg97PfNIv3lgRs/U3PcookV9ZGy1F
 YBgiHrH6oNDvHo6OteC6kio1148mwRdLII4jsYN9CA/OHhLCDx7z16EVM5ZkLTmx1jZg
 Nqy+5j40UVKFB1aeGrIjdZTuFrrDU/j6J6k4zQSXbFhBgFGUye8HxQqvnYj7WZRx9aID
 BZlHoD29CtgIJa/OjflDfWLiqOVMnIU9DdW62p4Fh6wnFM51cJjO2thXgQVshdKfbAhY
 F90v95h5zWyrD4eo0gijbPnZiZoavWwRiMGtjdbLTWOnT4zOOXFqwSpDD0uBGB9h6S5z
 Z6/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPffAJsuAJb8kNAMc19/YCLje7OYnMsjhEj3/2FGZR+zbogzovFudfP8ARJGcKnAAHk69ZPl8=@lists.denx.de
X-Gm-Message-State: AOJu0YwysISspuT3q4sah5XFhjOQNTs7Ei99YuVqbw+FgGfuYjlpBwkq
 dDSqNzAMUoJsV5Aw1YPohCx7UDVYCqDhrxhyqszfWiAcm8qOM0IFOz5EO7BRn5Fq2RA=
X-Gm-Gg: AZuq6aIHKBvI+AUT6cSVq4nFBqbHdi9+h048UKnd4n6QtDtt0PGmG1pR0GGkuUI6D1U
 sG/yoYcwPuTNBLwqPtCJjOlzZoV6dPqcl7pvKwz+Io5oY6urseRunnlfaRyn3UctGB+Kl1j+Rx8
 4UCPDNC9vM+f5oUyEjYu8BG478dv+HAvBLwtvo2Ai5PrFu5Cyx2Bpy3bcvRORP2NnHyvRokrjEt
 HemdJIps0sux8LKvHuhEeB5VHKC1ItDPM3lvuEMZu7BkWnwYn57W0RyAIhZah12BJV5IMK7L1c6
 n0C5GByNnPLuawuWXOyJ+aRMrgO/9RmmjsGbDaa8ze7jmABWm4I+CkPbIA/zBTXEiMXY4T3HYTQ
 jjaDL5ce9LehwxDciTl1NkMGE9+UAUX4t07MyaaDHxkexuPw+uJ265hxiYPDjVwfcfrwpMCSx0s
 UUdUbBJ4F4fmGHtA==
X-Received: by 2002:a05:6000:1786:b0:435:a2f8:151c with SMTP id
 ffacd0b85a97d-43629242557mr13878372f8f.28.1770582069634; 
 Sun, 08 Feb 2026 12:21:09 -0800 (PST)
Received: from localhost ([195.52.25.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fa4csm20363689f8f.26.2026.02.08.12.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 12:21:08 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e8f27dd5a400db107767ce049748f183c82710f3b76110abbbde32bcb8bb;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 08 Feb 2026 21:20:59 +0100
Message-Id: <DG9UYH3KEHMK.30RD25B27GEU9@baylibre.com>
Cc: "Tom Rini" <trini@konsulko.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, "Andrew Goodbody" <andrew.goodbody@linaro.org>,
 "Kory Maincent" <kory.maincent@bootlin.com>
Subject: Re: [PATCH v5 1/2] usb: musb-new: Relative ctrl_mod address parsing
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-63-gbde0bca3c3bc-dirty
References: <20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com>
 <20260130-topic-musb-probing-v2026-01-v5-1-195b23c7948f@baylibre.com>
 <c0c59409-95e4-46a2-ab19-06bd150cdec0@mailbox.org>
In-Reply-To: <c0c59409-95e4-46a2-ab19-06bd150cdec0@mailbox.org>
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

--e8f27dd5a400db107767ce049748f183c82710f3b76110abbbde32bcb8bb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sun Feb 1, 2026 at 7:18 PM CET, Marek Vasut wrote:
> On 1/30/26 5:28 PM, Markus Schneider-Pargmann (TI.com) wrote:
>> For the upstream DT the ctrl_mod node is using a relative register
>> address which is not translated by the current code.
>>=20
>> Make address parsing understand relative addresses.
>>=20
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>   drivers/usb/musb-new/ti-musb.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-mu=
sb.c
>> index bcd31adba522fc55190fc43fd2dbd2dec93a2731..75dc2dc18748e33785c7312a=
24145544b659579d 100644
>> --- a/drivers/usb/musb-new/ti-musb.c
>> +++ b/drivers/usb/musb-new/ti-musb.c
>> @@ -83,17 +83,17 @@ static int ti_musb_of_to_plat(struct udevice *dev)
>>   	struct ti_musb_plat *plat =3D dev_get_plat(dev);
>>   	const void *fdt =3D gd->fdt_blob;
>>   	int node =3D dev_of_offset(dev);
>> -	int phys;
>> -	int ctrl_mod;
>> +	ofnode phys_node;
>> +	ofnode ctrl_mod_node;
>>   	int usb_index;
>>   	int ret;
>>   	struct musb_hdrc_config *musb_config;
>>  =20
>>   	plat->base =3D devfdt_get_addr_index_ptr(dev, 1);
>>  =20
>> -	phys =3D fdtdec_lookup_phandle(fdt, node, "phys");
>> -	ctrl_mod =3D fdtdec_lookup_phandle(fdt, phys, "ti,ctrl_mod");
>> -	plat->ctrl_mod_base =3D (void *)fdtdec_get_addr(fdt, ctrl_mod, "reg");
>> +	phys_node =3D ofnode_get_by_phandle(dev_read_u32_default(dev, "phys", =
0));
>> +	ctrl_mod_node =3D ofnode_get_by_phandle(ofnode_read_u32_default(phys_n=
ode, "ti,ctrl_mod", 0));
>> +	plat->ctrl_mod_base =3D (void *)ofnode_get_addr(ctrl_mod_node);
> Is the cast to void * necessary , and if yes, can it be removed ?

Yes it is necessary, ctrl_mod_base is a void pointer. It is used in
clrsetbits_le32(). If I resolved that macro correctly that expects a
pointer as well. Other drivers seem to use the void pointer as well.

Best
Markus

--e8f27dd5a400db107767ce049748f183c82710f3b76110abbbde32bcb8bb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaYjwLRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP5
hgEAjAlHuGLaqo57U4Z5niR8kJcL2SQfOb7i/KhU5N1wBBMBAM0fETHmgGXgLqT6
kosfSgLtS97ntj2oQtL7jx8aMH8H
=vugb
-----END PGP SIGNATURE-----

--e8f27dd5a400db107767ce049748f183c82710f3b76110abbbde32bcb8bb--
