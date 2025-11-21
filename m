Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38624CFC50C
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 07:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A5F483A41;
	Sat, 22 Nov 2025 08:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AmPVzwve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F189C83A9F; Fri, 21 Nov 2025 20:41:05 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D9AB83A8A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 20:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47755de027eso13640235e9.0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763754062; x=1764358862;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J1juZXC3LOEyc9UhK0KqgErqZEAQMvWDiNtfYTs8TUc=;
 b=AmPVzwve3KhifWBlnqRSwpfp48nTrhyYy11lqagsanUQQWVxdRTqRQUPnjgHQRSdVi
 iH9zNFUptuX3d+/0Qgk8n2HlgpnEGOzTBFkmhc0PoxRTbZ+ub51njh8dwHodJ8CNPEPP
 QgsmRzTUw5UnHIyhofp/WKVP5pf0wnpH3VymqX1Z8XQPzg2KclOlt5MBcj355a67eR57
 EgLtZs1/pXsDgFyyPdxZeaORXVw6ku4gyrW/02gD2gLaBUYkPr7bgzgrcx6pp9X7WhS0
 KZKlhr//+QCGj97g8nRmcxdBmd6WQt5mfmZm5NIla2/RfWzdA4bY9qfXdjbU+ewYRYP6
 CgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763754062; x=1764358862;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1juZXC3LOEyc9UhK0KqgErqZEAQMvWDiNtfYTs8TUc=;
 b=lfCsINsylSU8l49Pfe6FYZ+duFlOm2mo8YL0UVU7TLB9IeOwM6krqg/43CXMjVaGIt
 CAnX2YqeJ3criKRrxSkLk1a7pBU6bNhlqMRVuBJ7mw2/zoeEZd6NW7spGjQyN2Ru3rSi
 LvJUDjHMq4Klfyoyzo1sJBEYXAwcGL9hbdGSbU6PGrJva5SLVIsE6LQ2QwvKj/+AQ20/
 9GSAO8wmaYs0u94BFHL4aUVOgC+pD3OaGemlr05vl9TzFfjCXu1xEkcHHGfmofWemKRz
 827KbX3XT2OAYsXTBEz1xiEbgIt+VBME/8mzLy0NzrmNZvpW25vJB+/wYE19x+DIUF2Y
 JRCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5zj+8PwLObNV/QsTKFVgenytbt8PMjIUuEG/7K7NKX4Fd71L/xQix4ZDDpJiG5/C8bUjy8eo=@lists.denx.de
X-Gm-Message-State: AOJu0YxWQ4y5Y8S5J5PjWd0hqyMhyVbco7IzebwkzUiarpzKph6cfa7X
 7wd9HMNlDWvHl0qExhp4E0Y4QifMMK6FYN2LXpqVntWkkxCjUIE/CgaikOtLghlzWVc=
X-Gm-Gg: ASbGnctqqFrd4OriwKLYyZy44FilkQNExbwJG1GAb8X2P7W1WzKrseo1jASXHQrDasZ
 J4TX2GyxCFSJouWIuYnoSGSi2iv0U3IesyBJaWwEOflnluzxi110cezTZfNo6srs7N638v4+8Lo
 sWS6bqWlX4DGmIKjDsnQCWaQSC2HJwG2g6jkclautqi9cw1vzt+KATsyrPPkRg3S7ffrYjZrtT2
 kA39nmyh6NkB7ASy7AXetD+0cYoq/oXkl5SwnVHIeoUroAP85gngTRuETjAsttL4MZgiicvM+RM
 xeWhnEy+cvkoCjN/Q7xBmaK5qhF4jzxtzLja0fZPeWzrRj3yR0TktogyI09O1ukiZzegGiSGVYG
 fSch3bJgfy0Oja4BtohI1V1IuBnuzmJ5Fw2+sHRzq9+5v5hu8uyxxXOYikrKNgB9xeNpCernMg2
 Ne2/ux
X-Google-Smtp-Source: AGHT+IEBOqnkN1Sh3gPAGz6Bs9UAP8f160nDtQEikYMWdZjBX7kDuJNJBkntajP3ZOF4qr2MzROhag==
X-Received: by 2002:a05:600c:1c24:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-477c01be2b2mr51131095e9.16.1763754060635; 
 Fri, 21 Nov 2025 11:41:00 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1df3d5sm59150495e9.2.2025.11.21.11.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 11:40:59 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=bf6fd95ff0ebf9742212239977e26397f15946e00a24de257cb374d9c922;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 21 Nov 2025 20:40:50 +0100
Message-Id: <DEEMMP7ISZ9P.BP6XAE07Y26S@baylibre.com>
Cc: "Maarten Brock" <Maarten.Brock@sttls.nl>, <u-boot@lists.denx.de>, "Kory
 Maincent" <kory.maincent@bootlin.com>, "Rasmus Villemoes" <ravi@prevas.dk>,
 "Rayagonda Kokatanur" <rayagonda.kokatanur@broadcom.com>, "Tien Fong Chee"
 <tien.fong.chee@altera.com>, "Alif Zakuan Yuslaimi"
 <alif.zakuan.yuslaimi@altera.com>, "Casey Connolly"
 <casey.connolly@linaro.org>, "Tingting Meng" <tingting.meng@altera.com>,
 "Peng Fan" <peng.fan@nxp.com>, "Quentin Schulz" <quentin.schulz@cherry.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, "Liya Huang"
 <1425075683@qq.com>, "Romain Gantois" <romain.gantois@bootlin.com>, "Simon
 Glass" <sjg@chromium.org>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, "Andrew Goodbody" <andrew.goodbody@linaro.org>,
 "Anatolij Gustschin" <ag.dev.uboot@gmail.com>, "Sukrut Bellary"
 <sbellary@baylibre.com>
Subject: Re: [PATCH 08/15] dm: core: Support multiple drivers with same
 compatibles
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Tom Rini" <trini@konsulko.com>
X-Mailer: aerc 0.21.0
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-8-91ce13c661e2@baylibre.com>
 <20251118140804.GR2125796@bill-the-cat>
 <DEDGK9KKB61P.1QY81TPR5JLNY@baylibre.com>
 <20251120212909.GQ2125796@bill-the-cat>
 <0b9e2a8e-1ab8-4a6e-899f-4ae9fd43b68c@mailbox.org>
 <DEE8BZBDYO08.1SX1UEB750S25@baylibre.com>
 <423d52bd-2446-47de-b6bc-4ee61fd0c23e@mailbox.org>
In-Reply-To: <423d52bd-2446-47de-b6bc-4ee61fd0c23e@mailbox.org>
X-Mailman-Approved-At: Sat, 22 Nov 2025 08:23:49 +0100
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

--bf6fd95ff0ebf9742212239977e26397f15946e00a24de257cb374d9c922
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Marek,

On Fri Nov 21, 2025 at 3:43 PM CET, Marek Vasut wrote:
> On 11/21/25 9:28 AM, Markus Schneider-Pargmann wrote:
>
> Hello Markus,
>
> [...]
>
>> Thanks for the pointer, this is using the exact same mechanism as I want
>> to use. Is this tested and works? Because if I look into the current
>> code for probing and binding:
>>=20
>> 	/*
>> 	 * Walk through the compatible string list, attempting to match each
>> 	 * compatible string in order such that we match in order of priority
>> 	 * from the first string to the last.
>> 	 */
>> 	for (i =3D 0; i < compat_length; i +=3D strlen(compat) + 1) {
>> 		compat =3D compat_list + i;
>>      ...
>> 		for (entry =3D driver; entry !=3D driver + n_ents; entry++) {
>>        ...
>> 			ret =3D driver_check_compatible(entry->of_match, &id,
>> 						      compat);
>> 			if (!ret)
>> 				break;
>> 		}
>> 		if (entry =3D=3D driver + n_ents)
>> 			continue;
>>=20
>> 		...
>> 		ret =3D device_bind_with_driver_data(parent, entry, name,
>> 						   id ? id->data : 0, node,
>> 						   &dev);
>> 		if (ret =3D=3D -ENODEV) {
>> 			log_debug("Driver '%s' refuses to bind\n", entry->name);
>> 			continue;
>> 		}
>> 		...
>> 		break;
>> 	}
>>=20
>> So if I understand this correctly, the returned -ENODEV will cause a
>> continue in the outer loop which iterates through the device compatible
>> string list, jumping to the next compatible of the device if any is
>> given. It does not continue in the inner for loop that iterates the
>> drivers.
>
> I check the HF one regularly, the SPI is a bit less accessible, but the=
=20
> binding code didn't change for a while so I don't think it should be brok=
en.
>
> I wonder if the RPC works by accident, and one driver matches on SoC=20
> compatible and the other on fallback compatible. In that case, I think=20
> the bind code should be patched to try other drivers and check whether=20
> they might also be compatible in case the bind returns -ENODEV, indeed.

I rechecked the compatible lists, but they do not have two different
matching compatibles, mostly just one matches to a driver.

But I think I may know why there was no issue with this. Grepping the
config symbols it seems there is no config in which both drivers are
actually enabled at the same time:

  configs/renesas_rcar64.config:CONFIG_RENESAS_RPC_SPI=3Dy
  configs/renesas_rza1.config:CONFIG_RENESAS_RPC_SPI=3Dy

  configs/r8a77990_ebisu_defconfig:CONFIG_RENESAS_RPC_HF=3Dy
  configs/r8a77995_draak_defconfig:CONFIG_RENESAS_RPC_HF=3Dy
  configs/rcar3_salvator-x_defconfig:CONFIG_RENESAS_RPC_HF=3Dy
  configs/rcar3_ulcb_defconfig:CONFIG_RENESAS_RPC_HF=3Dy

Best
Markus

--bf6fd95ff0ebf9742212239977e26397f15946e00a24de257cb374d9c922
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaSDAQxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMQ
0gD+K6dDbAlMZesCJsj2M4qBoHhXg4F84ccNeagnB3ohRKABAPI4K8gWHP+NSHvO
Bs9BXEkvxwsAL7KDhNA4De/f63UD
=6drK
-----END PGP SIGNATURE-----

--bf6fd95ff0ebf9742212239977e26397f15946e00a24de257cb374d9c922--
