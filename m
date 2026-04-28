Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FC4FF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0123584676;
	Tue, 28 Apr 2026 14:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="bmvUFjMn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9272884669; Tue, 28 Apr 2026 12:14:23 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81F74843D4
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 12:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso114148705e9.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777371261; x=1777976061;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LIqDRjTFWvIXNUesbcOCbQdysc+5Gt8f6vpHG9LtSkU=;
 b=bmvUFjMngZ5qqqtEzymE0hRVsx5kjZ8+NRDW3D5OQ9ab1Jwk6HCdVN6Fq6W8655q4H
 c4wFJUNZJz6bTo2x1Gv2Otg5SbVlWlH2qMaBiJ0FRmj3Pu9SwOr01/ePc7sQ6jQe9zYa
 95zSu9oySMlTUceRFruytIopm/ovYXKaP6l34/NceSHZY6i30SRwRbecsv8gpgmD8vEN
 UfnYvfxLH4lLqbqmVbhtF9flVK6OR4O63ZFTRPNo9uPnG6uKqYV9oND0yIWKZTnw8Cuh
 NMlWvo7bk0Q92kvWcvZ0+/nW6RGgPODl7m9plh676SUvidA/19gfUIIAZv7fF+oyyfFl
 ynEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777371261; x=1777976061;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LIqDRjTFWvIXNUesbcOCbQdysc+5Gt8f6vpHG9LtSkU=;
 b=ci41pGV1ccaCPCbA7L16jvjT6dp1BmLtM2F4bB0TwlgS/xSbaq2TcU7aiPvK4W4xZD
 b5wPxK5ALRjG46teDAhUN2pENYeXtbYMJsjyrH4rvie/E5315St4f8yB41n5j6tp1MLQ
 bXnsSw0klBbsedJ98M4ANGPfRiGhyazt1jYWA8pql1s1dN8gdg+2vGs6UN/okRaosCTS
 c42XYiHBtDtO8fO+KMu7ioM3IVZg6yBOAWhlC6bN7QZtupsEU0dBSWdQrdJnbfcySxl7
 w7sy9bS+ZhEThUCoiHzA882vgv8UodSMnz6JOjh/GXvn0hkKDizMTO7f9cicOcNvGEpb
 l5RA==
X-Gm-Message-State: AOJu0Yxum5tg09YZKOInqq0wOGRY+ebn4/+vg7FUNcMu5LHbZ37u1U3r
 6OwjzlNUuyeDmOnMtqGFk2Nas3LVTmhLMlJ1fmoeQqJwLpMExp4Ad+301jd284TpKTk=
X-Gm-Gg: AeBDies4DDwF3bWvnpnf+6JL6t/pZGGJf4oLnbUBcuYAQLjRAN71he2F92K+5bp7riU
 fS5TvpJR6ZmNBmD6irqJutPmSMRskcJxXTNqdfwazOwq0+fi3RVQwNrZK0fq4ZcB484BHLWCIbP
 dCq0Jr1mcc9HHz08QTUTJf/qJ5WtL69RZ+oU1S+dyyN2cCy33Eq7YUdA5wl7tfcbwyH9aG+evh4
 03g5rxphA8QF/h80Vg89KbxGxHO+3UA/q63s/obRK1EjhZe0GziFtRZQPKDNbFf2qaF3n0ppaGC
 BXvqxmsi1fP5+r4igL4alA/XcyXRRfOBFwR+CuL8WHVY6dDApqhI82YFgQpJJ6LHpwunZh+Swq5
 lbzAzDjXb5ewWSjJbMvMheaeGDLF82gx7ba7/k60eZTod7cTzojM4dmRNITdoLDDhpjSmlaQWh3
 OU53kev7F4zX8EIKl81lzImMSIAw==
X-Received: by 2002:a05:600c:1d24:b0:488:aa33:dc8f with SMTP id
 5b1f17b1804b1-48a7889c570mr28800005e9.0.1777371260810; 
 Tue, 28 Apr 2026 03:14:20 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773af544sm48111885e9.6.2026.04.28.03.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 03:14:19 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=2da51c81dcd28418089c23ef173eea2ae02d4ffcc55301af643aba0d4ee8;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 28 Apr 2026 12:14:13 +0200
Message-Id: <DI4PIXTMXMIT.RUEQIX1314GO@baylibre.com>
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
 <jonasschwoebel@yahoo.de>, "Paul Kocialkowski" <contact@paulk.fr>, "Andre
 Przywara" <andre.przywara@arm.com>, "Paresh Bhagat" <p-bhagat@ti.com>, "Ion
 Agorria" <ion@agorria.com>, "Peng Fan" <peng.fan@nxp.com>
Subject: Re: [PATCH v7 00/14] arm: am335x: Switch to upstream devicetree
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Markus Schneider-Pargmann
 (TI)" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
 <20260428104252.6aebf748@kmaincent-XPS-13-7390>
In-Reply-To: <20260428104252.6aebf748@kmaincent-XPS-13-7390>
X-Mailman-Approved-At: Tue, 28 Apr 2026 14:41:00 +0200
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

--2da51c81dcd28418089c23ef173eea2ae02d4ffcc55301af643aba0d4ee8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kory,

On Tue Apr 28, 2026 at 10:42 AM CEST, Kory Maincent wrote:
> On Mon, 27 Apr 2026 11:01:16 +0200
> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>
>> The series is split into two logical groups:
>>=20
>> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>>   with the current u-boot devicetree.
>> - Patches 4-14: Make upstream devicetree working with uboot. This
>>   adds tick-timer, adds compatibility of the board code for different
>>   USB probing, makes SPL smaller and updates the defconfig.
>>=20
>> The series has been tested on am335x-evm. Note that I don't have all
>> other boards built with the am335x_*evm_*defconfig, so tests are
>> appreciated. buildman reports builds are working.
>
> Tested-by: Kory Maincent <kory.maincent@bootlin.com>
> For the BeagleBone Green Eco.

Thanks for testing and reviewing, I am glad it works now.

Best
Markus

--2da51c81dcd28418089c23ef173eea2ae02d4ffcc55301af643aba0d4ee8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCafCIdhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlML
dgD/UJu7Vo6NQJj4VvqdVUU2e1tGWyEEQPX9TJCK6s2NIrQA/jEpWZBB9feBDCix
EYCgR2JIEIEex4YAiI7yotPrNYYJ
=Z5vC
-----END PGP SIGNATURE-----

--2da51c81dcd28418089c23ef173eea2ae02d4ffcc55301af643aba0d4ee8--
