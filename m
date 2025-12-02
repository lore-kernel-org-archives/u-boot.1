Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6114ED12668
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 18:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B427B83ED7;
	Tue,  2 Dec 2025 19:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iZVgIBME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7CEC83E85; Tue,  2 Dec 2025 16:50:19 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E1C83E81
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 16:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775ae5684fso26902425e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764690617; x=1765295417;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gxDyGn3/w1KRpWInGveM1fklXdwrVcjA7c8lTTs7t80=;
 b=iZVgIBMEton+9/SL2/laZ3pwkKunl7KSXUjDs/tasfEXFR4IFNprzYXgpsV9P5FUUY
 5Y+gRyiDswfKL1W90ZVJbawzlKu2Zwarws+PRnm8o+0xowp8MEpZjN3SN8GKpy0Cv44F
 TF+pUpmCVoSaun9tAafV93XTcKn9L5T+8vfAsK5X/cSz7hP8+/QVk2VGM3suK30VbFXk
 ZfOyCY2YMEBggkk0iVHBnwKSlouHFEAMncEld48GbtwE4Ry9JHljEqFbQJLzWWs69GHb
 aDXwn2gydJpZEY0jzC/MRLat8+rm/mgGgN+2zz/aeYkrtLQ7JgYQ30nr/jjtMLIlqzo7
 fxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764690617; x=1765295417;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxDyGn3/w1KRpWInGveM1fklXdwrVcjA7c8lTTs7t80=;
 b=sZcC1EO4y2J+OMHX9cIdgpEXvB7RPu9DVTOEgzDdxNPpo5cUNQ80QHSwaQ6Gy2Fc91
 VmTLhLqmh8tZmhUJ0/YQAUNL4Xymt3xdf8Ke79/rnpw7Y3OK307KCo+FpBSWkTSKfa/Y
 g05kasWY9mBu8k7t4/Qp99mkhOzmC7rYhSJlkU+HCvrezphIGEKeZ52L2doQI0Y9e704
 Sm6HGBw5EsbSM4rdbBlagil/548YwVxfO9TxckRMM6rqnv/uRjXqFMBOw/iJ6b1ZyDRg
 ram04GvnTJ4r/rxBt23cmQVv3i1up9Gn4rutXZm2Ri8TSyamqJgm/DrYBuSVHQDC565q
 ZKpg==
X-Gm-Message-State: AOJu0YxmUcGj7VCciI1f/ituHICp6I2EZ0QTBb6b68OVNeiixIOTkBJu
 E/g04uQ2MXf9TjwzC27v76wR3GdE8PBbTnFbszrG29/vJJ/bojb2cylMJzbBmnAeu/U=
X-Gm-Gg: ASbGncumaeR3VZBLXTRb4TzolINW17U2yNwimOsgAx7TR9YEa4HclVTABS8K9ZaZ4MK
 IEVP8th/CnsTzZ4y0/RGCr6YTrmCB9ArNHgYDQYiqkzMNzAe4pa3CqkL7I5M5i0x4QwwGkNIZ1N
 bEVUrvDNhHVymEIVuo2wPdW7gWdzOBpy3Pz/Alb2GC51qbZnUCeExsFpczoiDKElZNtE69HvTvF
 y6mJEs8rdamyquKbgqFcHv7bCXITVnWcyoVDW5P9MQDu8LPrfIp1Lb8yZ3gtndOdvK/TrdyT5OW
 PaoWaPX9qu7iYXHPHkBcEC5VeQz6QtInynvou2Ym0q9uaCgUYfkzV/8joBO2P+NeK1rvO+57JZU
 UqllQZOf8fKakIJ0pPspn6pIoHIHTxL9R00dHX3SVmogjwjyGUJjp2XlUEzfmNLx0nn2nXOPbRt
 pauJGiEZpCsRe9gwKQz+IOPxs0cnT7m5REk1/w/Bd3Z9o=
X-Google-Smtp-Source: AGHT+IGYmXMgC/52WPp0xZIWXaWHYmSn5A65Jly7cmLqtGrMr69SmnaReolZguhdmyg/AuwSn+T7HA==
X-Received: by 2002:a05:600c:5249:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-4792a49041bmr455655e9.7.1764690616762; 
 Tue, 02 Dec 2025 07:50:16 -0800 (PST)
Received: from localhost (ip-185-104-138-127.ptr.icomera.net.
 [185.104.138.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47911143bb6sm338765525e9.3.2025.12.02.07.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 07:50:15 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ae560d89e562c572490e26687f33e8925be9b2482f256fbe98b42c37cd0f;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 02 Dec 2025 16:50:03 +0100
Message-Id: <DENULZHQKCD0.SD0HVKKGH4PE@baylibre.com>
Cc: <u-boot@lists.denx.de>, "Marc Murphy" <marc.murphy@sancloud.com>, "Tom
 Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>
Subject: Re: [PATCH v2 6/7] am33xx: Support upstream devicetree binding
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
 <20251128-topic-am33-evm-oftree-v2026-01-v2-6-42a863304498@baylibre.com>
 <20251201141416.03333902@kmaincent-XPS-13-7390>
In-Reply-To: <20251201141416.03333902@kmaincent-XPS-13-7390>
X-Mailman-Approved-At: Tue, 02 Dec 2025 19:10:35 +0100
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

--ae560d89e562c572490e26687f33e8925be9b2482f256fbe98b42c37cd0f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kory,

On Mon Dec 1, 2025 at 2:14 PM CET, Kory Maincent wrote:
> On Fri, 28 Nov 2025 21:46:36 +0100
> "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:
>
>> Support musb being probed by ti,musb-am33xx. The non-upstream DT probing
>> used a wrapper driver that probed ti-musb-peripheral and ti-musb-host.
>> This wrapper registered as UCLASS_MISC, which is why it is requested in
>> this board.c file.
>>=20
>> With the new devicetree the wrapper that registers as UCLASS_MISC is
>> gone, instead the UCLASS_USB and UCLASS_USB_GADGET_GENERIC have to be
>> requested.
>>=20
>> Also don't fail if the USB devices are not available.
>>=20
>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>> ---
>>  arch/arm/mach-omap2/am33xx/board.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/arm/mach-omap2/am33xx/board.c
>> b/arch/arm/mach-omap2/am33xx/board.c index
>> d7db260513308257f142ea70d5d5c643afc920c9..4bfdb55b2dd5c66cd58bce360cf1c6=
9fb7a00cd6
>> 100644 --- a/arch/arm/mach-omap2/am33xx/board.c +++
>> b/arch/arm/mach-omap2/am33xx/board.c @@ -266,12 +266,16 @@ int
>> arch_misc_init(void) struct udevice *dev;
>>  	int ret;
>> =20
>> -	ret =3D uclass_first_device_err(UCLASS_MISC, &dev);
>> -	if (ret)
>> -		return ret;
>> +	if (IS_ENABLED(CONFIG_OF_UPSTREAM)) {
>> +		uclass_first_device_err(UCLASS_USB, &dev);
>> +		ret =3D uclass_first_device_err(UCLASS_USB_GADGET_GENERIC,
>> &dev);
>> +	} else {
>> +		ret =3D uclass_first_device_err(UCLASS_MISC, &dev);
>> +	}
>> =20
>>  #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
>> -	usb_ether_init();
>> +	if (!ret)
>> +		usb_ether_init();
>>  #endif
>> =20
>>  	return 0;
>
> You are losing the error return value here.

Yes, on purpose. During my work on using the upstream devicetree I
didn't have a working USB yet but u-boot wouldn't start because
arch_misc_init failed. I don't see why u-boot shouldn't start a console
if something USB related is broken. That's why I did not return the USB
error code here.

Also if you do need USB for booting you notice it really quick.

Thanks for all your reviews.

Best
Markus

--ae560d89e562c572490e26687f33e8925be9b2482f256fbe98b42c37cd0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaS8KqxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNE
qwD+L3kE1xj80vOkLE0bT23fBJIaSy/TIK+lhQOC9g6CJ6sA/0UL6smg/WkrZpQ6
PuPjUI/ZwoW7jSpJTn9Bi/7JMecF
=BLk0
-----END PGP SIGNATURE-----

--ae560d89e562c572490e26687f33e8925be9b2482f256fbe98b42c37cd0f--
