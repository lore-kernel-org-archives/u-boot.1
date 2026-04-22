Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF66FA1FE7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 19:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E634284376;
	Wed, 22 Apr 2026 21:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="BqbL4ll2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D96284378; Wed, 22 Apr 2026 21:07:48 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F08E84227
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 21:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso54180815e9.3
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776884865; x=1777489665;
 darn=lists.denx.de; 
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ngBNeFMv6rIMv61VqO1ItafrjsGKkUfKcUTlhEhFFUQ=;
 b=BqbL4ll2t6GmcZImGHaB4UfXESZBefgZ4S3MKT7Qf8KK6Xg4OPnxmVoUVmB4juVmDm
 DNZnQ5JbBnlMDH8KlOqCcUrQbADsAjht38i0v2kDml8dsyuyJRXRhRAPidScZtY4PqT0
 S2ttM/DbR9P/XZi0139Q+xtahPmbvQkRoNKa+G8SOOFulMPYDDLP6+A87b3BNoJICjVZ
 tq80Qo39FQT64TWEiBieqlIYVAGM0qg9nTDAA7eEbPVGK8yyODbBSTtNwnh66mxdXhOS
 F2RYG6wcM/uWfU6rdj/fJMs9VOS+AwOIxZA7lHis4FeSkS9KnPniphYWbM45fE8uT7+t
 kl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776884865; x=1777489665;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ngBNeFMv6rIMv61VqO1ItafrjsGKkUfKcUTlhEhFFUQ=;
 b=osz+a3zdNJp+uArjtgQDMbjgh2B/ALjZKVHNdQbAcgaeuM5ENLsPCrY4QzxQybAJZ5
 4+kKHATScHf1kdo+eRhadbKjCry2VdloNPWHQP2nABivl8ANHvcuu5NcLN3O3tO5nWDZ
 i0S6f1drFyuEawwutTPyL4Ns0Kj530Orekj3a8b4htuu6HU64KJ3/qQGNsDcCAtjCCGV
 y1OW4jTLBA1CBoKITBJJkJuIErcGlxtXS+onGlWJ7UC2AE+tlGqtVC6HBFcm0SCbA1KJ
 HpjhI85sUlB5HTMRLyBeM5uqDRUtQ37qQyqvHw/plB7AUJ8PL40CpS27ZmKl+aUlb7LU
 53/Q==
X-Gm-Message-State: AOJu0YxzxkRkhfVIaBCTRSWf8Le8n2xH7eVZBefs+7RgOj2L+DWYK1ZU
 lFVnsqEYR+wDb3v5Ri/+3oHM1xgLrxqp9SRAJpGb88jpTDh3F8Ts4a6nEgnxIHaF0AQ=
X-Gm-Gg: AeBDieuT8PV5yIDmH6vELDBnvkxBzypubGLXYBO7IMGhuGs+ZR8yo2n1asc2MwbC6sp
 gAX2dEW/LLXn/tmkTcyOtjWDf1YOuXG0wMg3WrLXF/3az0yKrGom7YGqXk7Axgotsw9XI4QkQWD
 V/VYrrmr4mauQ1yTAIIlgpQegMkg8pKstlAGZprSwCRZNhnBfFA5QcVQRIF/eO44ZhK9ousSjOy
 dSliUTYMBqQ/iOgnXYePetoPhuaNcbiuCgmt6Fum0xCj7V6gaQFNvc7n1yuV1Z0dpKKb42i2FUJ
 qNrOkgGn5V0z6RgR2dWosXmnFj2SMxpb9i//YYI5GLSRi8VAgcXYToyQJWvtaXVAFu2fdKQg6yD
 kEXZBAgAz3k4LHMm4dAHkTS1j8K3vowZ29xSAIVrXWZY12Mn8KoJce/pS5ZhIjmX1j2LJd9ntPd
 kEDQf7bmkw8ffgffh11aat8cZUSQ==
X-Received: by 2002:a05:600c:b90:b0:488:b99b:4177 with SMTP id
 5b1f17b1804b1-488fb78ee4emr330021565e9.25.1776884865545; 
 Wed, 22 Apr 2026 12:07:45 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm464769015e9.1.2026.04.22.12.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 12:07:44 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=39db3bc97e1f6205a790c5f3cffdd0f1b9fcd4d18e17d6b83b7d49217e0c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 22 Apr 2026 21:07:39 +0200
Message-Id: <DHZX43AJN38O.1GRUDR6FY3H0N@baylibre.com>
Subject: Re: [PATCH v6 00/14] arm: am335x: Switch to upstream devicetree
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Kory Maincent"
 <kory.maincent@bootlin.com>
Cc: <u-boot@lists.denx.de>, "Marc Murphy" <marc.murphy@sancloud.com>, "Tom
 Rini" <trini@konsulko.com>, "Rasmus Villemoes" <ravi@prevas.dk>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, "Romain Gantois"
 <romain.gantois@bootlin.com>, "Parvathi Pudi" <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, "Paul Barker"
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, "Simon Glass"
 <sjg@chromium.org>, "Anshul Dalal" <anshuld@ti.com>, "Michael Trimarchi"
 <michael@amarulasolutions.com>, "Patrick Delaunay"
 <patrick.delaunay@foss.st.com>, "Patrice Chotard"
 <patrice.chotard@foss.st.com>, "Svyatoslav Ryhel" <clamor95@gmail.com>,
 "Tien Fong Chee" <tien.fong.chee@altera.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Johan Jonker" <jbx6244@gmail.com>, "Brian
 Sune" <briansune@gmail.com>, "Hai Pham" <hai.pham.ud@renesas.com>,
 "Bernhard Messerklinger" <bernhard.messerklinger@at.abb.com>, "Emanuele
 Ghidoli" <emanuele.ghidoli@toradex.com>, "Parth Pancholi"
 <parth.pancholi@toradex.com>, =?utf-8?q?Jonas_Schw=C3=B6bel?=
 <jonasschwoebel@yahoo.de>, "Paul Kocialkowski" <contact@paulk.fr>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
 <20260416110631.6f89a2e9@kmaincent-XPS-13-7390>
 <20260416111302.45a7e1fb@kmaincent-XPS-13-7390>
 <DHVGLJTPJW53.2EX6R0YM5BC5R@baylibre.com>
 <DHVGPVAMBGWD.2QHTLW4V9UNAQ@baylibre.com>
In-Reply-To: <DHVGPVAMBGWD.2QHTLW4V9UNAQ@baylibre.com>
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

--39db3bc97e1f6205a790c5f3cffdd0f1b9fcd4d18e17d6b83b7d49217e0c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 17, 2026 at 3:26 PM CEST, Markus Schneider-Pargmann wrote:
> On Fri Apr 17, 2026 at 3:20 PM CEST, Markus Schneider-Pargmann wrote:
>> Hi Kory,
>>
>> On Thu Apr 16, 2026 at 11:13 AM CEST, Kory Maincent wrote:
>>> On Thu, 16 Apr 2026 11:06:49 +0200
>>> Kory Maincent <kory.maincent@bootlin.com> wrote:
>>>
>>>> On Wed, 15 Apr 2026 18:02:21 +0200
>>>> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>>>>=20
>>>> > The series is split into two logical groups:
>>>> >=20
>>>> > - Patches 1-3: Fixes for am335x-evm to boot and support the LCD pane=
l
>>>> >   with the current u-boot devicetree.
>>>> > - Patches 4-14: Make upstream devicetree working with uboot. This
>>>> >   adds tick-timer, adds compatibility of the board code for differen=
t
>>>> >   USB probing, makes SPL smaller and updates the defconfig.
>>>> >=20
>>>> > The series has been tested on am335x-evm. Note that I don't have all
>>>> > other boards built with the am335x_*evm_*defconfig, so tests are
>>>> > appreciated. buildman reports builds are working. =20
>>>>=20
>>>> Your patch series breaks the scan of extension boards (cape).
>>>> =3D> extension scan =20
>>>> Found 0 extension board(s).
>>>>=20
>>>> While I should have:
>>>> =3D> extension scan =20
>>>> BeagleBone Cape: Beaglebone green hdmi cape (0x57)
>>>> Found 1 extension board(s).
>>>> =3D> extension list =20
>>>> Extension 0: Beaglebone green hdmi cape
>>>> 	Manufacturer: 		Seeed
>>>> 	Version: 		00A0
>>>> 	Devicetree overlay: 	BB-GREEN-HDMI-00A0.dtbo
>>>> 	Other information: =09
>>>
>>> After I bisect, I have located the breakage on patch 13.=20
>>
>> Thanks for testing. I think I missed adding TI_SYSC config symbol to the
>> default config, I will add it to the next version.
>
> No, that can't be the issue. TI_SYSC is automatically selected. I will
> keep debugging.

I think this issue may be the same as the one with MMC. The enumeration
is broken because all i2c device nodes now have the same i2c@0 name. I
think it should be fixed with the next version which adds PHANDLE_CHECK_SEQ=
.

Best
Markus

--39db3bc97e1f6205a790c5f3cffdd0f1b9fcd4d18e17d6b83b7d49217e0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaekcexsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMb
DgD/RQTohQpyFRMqHP9WxxoEJP68H7a6Rc8POSk4vt4BRkMBAPMb5rjSecuUFxPX
VXBLkruHX2zDtcTwqBryxi+Z2fsH
=C+JA
-----END PGP SIGNATURE-----

--39db3bc97e1f6205a790c5f3cffdd0f1b9fcd4d18e17d6b83b7d49217e0c--
