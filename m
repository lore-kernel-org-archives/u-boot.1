Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347ECF4369F
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7946A8427F;
	Fri, 17 Apr 2026 15:26:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="NMLCaBvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5679684297; Fri, 17 Apr 2026 15:26:21 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CAF884246
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso8660475e9.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776432379; x=1777037179;
 darn=lists.denx.de; 
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G4qAvkEoGGS0DiyAAABlFmFzSigQVUvXOgi1FEoobwE=;
 b=NMLCaBvPLIGdNC/9ybq1zFuKcKqlCSjwy8kWbaso++ccBhHtomE9vDrPQtX0MUWhJh
 kc46S1gWonc1aQWsACLQsJxYnNIA3BO2AJt6uz49gUCkkNzMZbUNMnBsBxjrii9WjmP1
 fX/QV8dGdwaXWc65i1jD79gslxGndGTDluuyGF8szIuE649qKoVGxEhJVhOncLZmtDxv
 vXnPmmdYqLLSUIysnqnhBlvvEXNJkeKTL8LgWzZNvvKchyRfn9HGp62G7l4iU6eq4luS
 WX+3tYeFNJ110Ul/r1d+ZKJ3SIcY3sDntlWFHvEdMDy9nm0Wxb+uandKphw3tmuvsvVm
 OCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776432379; x=1777037179;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4qAvkEoGGS0DiyAAABlFmFzSigQVUvXOgi1FEoobwE=;
 b=elpTVP4pPLyxrDbS4CxKLM3P5NNzOdl2XKwGHb0wQrkwu7H87PrfA9WRo6Nrna2baw
 PcvtyPoLTeIjnr1pI5qLVJzPmC0qTG1WS7xjDfpZwFPpc0YkF2PutiDcEUN+p8NyB1bj
 rHh7LsKBNXnYze361PuLsdXhgLVl9X2Qje6f00lgaQtj0rgfRpGKndYoPUtGwenMbUaX
 9IPd/BMqEQPdhG/PcsolbfF3uh9jvCSXrWxEgF5eMQ9fyxTDdqoGItirUdxVKfRKLSfM
 sU6iYv6CyTUUKzXth8dSqiXT7xw4AeFh9f7hkOB9L81K5hUkrD6YHBIhPqUNT2QJYlFo
 EKbw==
X-Gm-Message-State: AOJu0YznNXUcDfw0OXh2LYo/qGgNrWqEBD0MZBnxsAPjFUc5ey4X2ClC
 2BBTB3BK7FRYJGz3WaUEn/hGNlt2ovdvQ2ITa/OtbdgT5YY9XN03PpDgPFiW/6GOYou6N3e03YW
 FvmTMTPc=
X-Gm-Gg: AeBDievxLu2+PT/pRgK28zFJFsqGuPnZ5NsLLN+TrF/Dn+zJtjqQvYP26nnUV3sPRtK
 jPmWzmn7bnhQoOxrcDdKEe1HkShoZdPYOw12UT9Gq6+O6UtAP8LOa4MVAWr0lA7lsZN36nR/YRA
 Nlp3YNjp5aWmXDh10oXeZ1riI5rrs13rcaD8bsg3mSMA+7s05cEeA+sScBP94F991j66Sxod0qM
 6cSK5beUQSmrXMgrKZQnxODTj1haj0X05r5rO6lI4IjzGfVsKyflNySYQD+YfTkQb2HnfF2nF1L
 H240dJv3yrLbySvxGIXSQ1k50imAMCbSqcfdwCs+IMp3In8zvFdvHToVQG7CGiPyZtKNEQp+VyT
 oBxC4/BGgoq7bjYZz0RHgJTUJe08SLqVLUbYwanreVbkMGGFXhgFjfltUZcLBPv4rT20wP1ASYy
 spYz6P8EybIPN1XMxrAXahJ8wRfA==
X-Received: by 2002:a05:600c:4fc7:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-488fb78894bmr38134255e9.26.1776432378491; 
 Fri, 17 Apr 2026 06:26:18 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c0354sm39914795e9.11.2026.04.17.06.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:26:17 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=2f3b7a87901a532b3cbec8f51c9df3efd288f661ee9d7fac3ae693159e5e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 17 Apr 2026 15:26:07 +0200
Message-Id: <DHVGPVAMBGWD.2QHTLW4V9UNAQ@baylibre.com>
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
In-Reply-To: <DHVGLJTPJW53.2EX6R0YM5BC5R@baylibre.com>
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

--2f3b7a87901a532b3cbec8f51c9df3efd288f661ee9d7fac3ae693159e5e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Apr 17, 2026 at 3:20 PM CEST, Markus Schneider-Pargmann wrote:
> Hi Kory,
>
> On Thu Apr 16, 2026 at 11:13 AM CEST, Kory Maincent wrote:
>> On Thu, 16 Apr 2026 11:06:49 +0200
>> Kory Maincent <kory.maincent@bootlin.com> wrote:
>>
>>> On Wed, 15 Apr 2026 18:02:21 +0200
>>> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>>>=20
>>> > The series is split into two logical groups:
>>> >=20
>>> > - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>>> >   with the current u-boot devicetree.
>>> > - Patches 4-14: Make upstream devicetree working with uboot. This
>>> >   adds tick-timer, adds compatibility of the board code for different
>>> >   USB probing, makes SPL smaller and updates the defconfig.
>>> >=20
>>> > The series has been tested on am335x-evm. Note that I don't have all
>>> > other boards built with the am335x_*evm_*defconfig, so tests are
>>> > appreciated. buildman reports builds are working. =20
>>>=20
>>> Your patch series breaks the scan of extension boards (cape).
>>> =3D> extension scan =20
>>> Found 0 extension board(s).
>>>=20
>>> While I should have:
>>> =3D> extension scan =20
>>> BeagleBone Cape: Beaglebone green hdmi cape (0x57)
>>> Found 1 extension board(s).
>>> =3D> extension list =20
>>> Extension 0: Beaglebone green hdmi cape
>>> 	Manufacturer: 		Seeed
>>> 	Version: 		00A0
>>> 	Devicetree overlay: 	BB-GREEN-HDMI-00A0.dtbo
>>> 	Other information: =09
>>
>> After I bisect, I have located the breakage on patch 13.=20
>
> Thanks for testing. I think I missed adding TI_SYSC config symbol to the
> default config, I will add it to the next version.

No, that can't be the issue. TI_SYSC is automatically selected. I will
keep debugging.

Best
Markus

--2f3b7a87901a532b3cbec8f51c9df3efd288f661ee9d7fac3ae693159e5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaeI07xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPo
nQD+IXZmh/8EU/4XG10OjQ087UB9PHK/r9J0nxb2/LzYnQQBAO+SQem/gQWR8MV9
IosSk80cuekXgp2EmcMXlrVT7n8F
=bBgt
-----END PGP SIGNATURE-----

--2f3b7a87901a532b3cbec8f51c9df3efd288f661ee9d7fac3ae693159e5e--
