Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6B8D49C81
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 09:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA0778426E;
	Fri, 30 Jan 2026 10:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dzKdqcGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11A498421E; Fri, 30 Jan 2026 10:05:53 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1677B8426E
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 10:05:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-435a11957f6so1534222f8f.0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769763945; x=1770368745;
 darn=lists.denx.de; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aqj0WvUo58Vop/GW99xfdYNz0HcVQONzCZfsblXout0=;
 b=dzKdqcGe7eBvCIQyxnGn5NVXYZ43C9V3FwSWEJb9PmYuEpyGtEdOc+afNdIpkVdd5X
 UBj63kYVukEwWunK4VcoBDfxojAkV4U5mFwzutzAFzpj0v4GLuE1VfHT+KAQyICVVHxg
 Zqx1COMuLeCaOd0WuNnhXAA9Rq0+F/YOHENrF2PX1Gw2gfqpPHkI8G59hYH4nfiYsF9P
 a5q7HDiYWNkP6906BWl4SGgWo6mLtl/753nSf4++BJpORN9R+GTVtkm7PchuMRWU7iNa
 zQuMeWwpb7BajbxZuwJT7BawfVrW76fd7U8ljaGbGtL0DTOg4sFZFl1r807s8vpUQg70
 8SLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769763945; x=1770368745;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqj0WvUo58Vop/GW99xfdYNz0HcVQONzCZfsblXout0=;
 b=fCm3nTfBtl5Mp2cYIXuIg0vrmJdy+BnT3sjI9NDdUvuAUBOlQ9PFMT6Ef496Zu2+ys
 7ZJCt9nCESh0D9b/JeuKz/sjeuCluwg+6AeNZA3O46YTAnWVvZeFYvb6kxzZrRJtnmTU
 u1Sav+PXNXlBcexXapEp75EO6pP9xswyUofJWIxoenH1uS8ANiRPRzZWGDOflZb6fhex
 BmsZIDMnJYaPPOJQJO9qQEQobs9ePmY3d5Qek7QG8ecgaiN2tWpd6Nd8zd8G5nQHv6Zi
 QgMj95sYB+QSg30nBAmd8664CENzlBZn3eLdjrgI+DkjYoHg8nF1XL4NXPhspwVzUkAc
 NXFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgNJgIJy628w56ON6dkUP/l2yTaLgpLJrm/MHHKTJbXU2Tcwmoc61YCf7bMNm2z+sW4B1w14E=@lists.denx.de
X-Gm-Message-State: AOJu0YzRFUVp0r1antDTiNoOZO7LBkab023tMDB2n1D5D16gbrhIVd2S
 g7+JocMpjOpNbkC3eKk7ScqZVJGUgWAesqygZYSz3OVq80JiwB4Qw2o2m0f2tOkRVnc=
X-Gm-Gg: AZuq6aLXEO2tOelC3cuMzYp+ObUEy87FEwHEDVhGjQY0L3GFAHDQR0L0TDrkzplGyu6
 ccmtyqNdUKykhxIV8oi1Ggmnn7wSTdAoLKoYLmXdVqFhvNxIEjkTVUK3+GVQDTWL80ZiX/S5bEQ
 01PFmN/vbWeOjIlWh/Cl7eOskfKCP2ezhsbwzMMVNjDi29frwMWr130DFCOEUaxsDx0zObGgN+E
 F9kTKRmTcazdLDLjHG+IJuKoq7eC3vN7MxU8c1Qny62GexLk3ZvBljV36dt7D0EVeq902qn54Dl
 nGoqiLaB8UdrLjD7L1b3SlxMo8uV8m+4tZe+JA2gmD849VCPzdjOHmMOv/EX4OiXHU83FZz9OsU
 6HAzcH8lI892xc6a4oxMR8Q1Jcs6pMv5xxKPrFSZv2Ep12NC0IAQyOruCR3bmLTUeMNhZpOXtQJ
 wgApg+4HRjr7VIXA==
X-Received: by 2002:a5d:5d0b:0:b0:435:9a2b:53d0 with SMTP id
 ffacd0b85a97d-435f3aaf592mr3434758f8f.45.1769763945345; 
 Fri, 30 Jan 2026 01:05:45 -0800 (PST)
Received: from localhost ([195.52.31.202]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e132356dsm21741086f8f.33.2026.01.30.01.05.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 01:05:44 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=7bd315c774291f1d3a46971c882180f8346d15277450ae4c014c21760629;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 30 Jan 2026 10:05:35 +0100
Message-Id: <DG1SYGA0ELMR.2398HVY4R18L@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>, <u-boot@lists.denx.de>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>
Cc: "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Andrew Goodbody" <andrew.goodbody@linaro.org>, "Kory Maincent"
 <kory.maincent@bootlin.com>, "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Christian Marangi" <ansuelsmth@gmail.com>, "Dinesh Maniyam"
 <dinesh.maniyam@altera.com>, "Heiko Schocher" <hs@nabladev.com>, "Rasmus
 Villemoes" <ravi@prevas.dk>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "U-Boot" <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH v4 7/7] usb: musb-new: Add compatibles for ti,musb-am33xx
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
 <20260127-topic-musb-probing-v2026-01-v4-7-ea3201e0f809@baylibre.com>
 <25d52b97-52f4-4842-9aaa-10c5495a5ec8@mailbox.org>
In-Reply-To: <25d52b97-52f4-4842-9aaa-10c5495a5ec8@mailbox.org>
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

--7bd315c774291f1d3a46971c882180f8346d15277450ae4c014c21760629
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Marek,

On Tue Jan 27, 2026 at 10:15 PM CET, Marek Vasut wrote:
> On 1/27/26 12:03 PM, Markus Schneider-Pargmann (TI.com) wrote:
>
> [...]
>
>> +static int ti_musb_host_bind(struct udevice *dev)
>> +{
>> +	enum usb_dr_mode dr_mode =3D usb_get_dr_mode(dev_ofnode(dev));
>> +
>> +	if (dr_mode !=3D USB_DR_MODE_HOST && dr_mode !=3D USB_DR_MODE_OTG)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>
> [...]
>
>>   #if CONFIG_IS_ENABLED(OF_CONTROL)
>> +static int ti_musb_peripheral_bind(struct udevice *dev)
>> +{
>> +	enum usb_dr_mode dr_mode =3D usb_get_dr_mode(dev_ofnode(dev));
>> +
>> +	if (dr_mode !=3D USB_DR_MODE_PERIPHERAL)
>> +		return -ENODEV;
> How do you handle USB_DR_MODE_UNKNOWN , host or peripheral ?

Thanks for seeing this, I checked, USB_DR_MODE_UNKNOWN will result in
none of the drivers binding. That's the same behavior as the previous
wrapper:

	static int ti_musb_wrapper_bind(struct udevice *parent)
	{
		[...]
			switch (dr_mode) {
			case USB_DR_MODE_PERIPHERAL:
				[...]
				break;
			case USB_DR_MODE_HOST:
				[...]
				break;
			default:
				break;
			};
		}
		return 0;
	}

Thanks for reviewing the patches.

Best
Markus

--7bd315c774291f1d3a46971c882180f8346d15277450ae4c014c21760629
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaXx0YBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOT
NAEAhVd9DqFaWW58PU3CUjkPgveyL5k4UlVJnYhMuI9hu0sA/ROTzuagpS6LIXRL
O8czPGCsTDiBZZzM8tx6kTxf9hoO
=Iks5
-----END PGP SIGNATURE-----

--7bd315c774291f1d3a46971c882180f8346d15277450ae4c014c21760629--
