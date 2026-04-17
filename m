Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A7BF4369F
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 13:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C14484297;
	Fri, 17 Apr 2026 15:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="glvM7Avq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0558842D7; Fri, 17 Apr 2026 15:20:40 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EAB83015
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 15:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so371153f8f.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 06:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776432038; x=1777036838;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zrQq4cX7NqxouzpD8sYxMnboJyNFHsE12fBIJ/P1C58=;
 b=glvM7Avqkz4RX1TSo4uy/zK+Fuk20MpmyHPkqzJTxvaLUbBq+PLVQUaoakP7DYxdQn
 5B/xPuO0Nm5n0TDfLAWR9xPyag5uQMqgpxzJM5r1qNIQUrK1uMf4Hto4xBIUIT4Clas9
 iZ8mr7laSomHyR+bJezAAjLagQvGbdU6ROprQe8bk/pbmXnEBGVIKV5q1w32BTFAICIN
 ARgoQm0pcCcA5IkodhdIDGDDsDPbGSpUo2+x3VYSxS6btX/crkCd+gvnC6fFK0jMnLkH
 SxrBH+vRDbPS2bmZmQT2hoS/9kV6TMQXFW52uzJ+uIMjYfxNBcFNrCnpCrcv2uvo2Rac
 1BJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776432038; x=1777036838;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrQq4cX7NqxouzpD8sYxMnboJyNFHsE12fBIJ/P1C58=;
 b=f8rFiKn3uagmH0ESUjQ+ubJCYg8S/a5p1Vm4gMpRYlg4SyjYLsnZHcA0OIvQKQC1rp
 Z4yte6ddiaBVR4jREhfE3f71mVgw8N46dSAuX7+3xG365YvfjMU8/mu/CBhrhLwMHKYJ
 NI2RRuTTyyBgIx0lkXnvSKBG5tFBksAOcCq78k0YOiBkLDICCWsO63X3Yw/eDJagYKks
 qH2wv3vpKFl2cHMLp12sPbZ0yzuzG16oEAXPBxhre/pYLuo9vNq/Z17fxoxJ/mTpQ5vK
 iMHM7BOx5Z+RRU/smt61vHfwx1zGyA4zEfPPxsAQN9e80R4tjNB9ccQL9HGP3z8jhB+L
 H+RA==
X-Gm-Message-State: AOJu0YwBkHQPSAn3XnnX1P6aYe+YbMWJwB2HY4PRgodzRzWt/AfAnElu
 +c0M7D6zylnqNu0lcV9DaMn7qz40UdtmJPpsMO76Y1MxzweqmzFCE2fV7oGLp4Eslok=
X-Gm-Gg: AeBDieuu52FR2D8Ke5svFTazd18vafWR7bnF9kbcDzKxGMAZkyykG88BG64sqO7Q3oH
 OIYf1lDum18ZOdfr9RymM+XDW1GzXQJ8pkVTV3bpSRVC5lynVG6w8OiRqu2k/W5BDGSw+n1Wh1x
 OAAAvvKkuakbilW/NpVjJn2BtKKSgmRboR8V+DxjhgUiMCHYHQaY69VtjXkp8qbgWkT4EmQwpfX
 O7zlt/5inZsBPuDGxQ6bsf26e2Tcm3Us/6eEAOFXvWG8UfCzZVIliWNyOuVqdtg0hTo0y6pcvE2
 lbRNQj7o91QIalpKXLngzOtmRcLCgSPD3IsqnQ5Qq13XS84RPbthYQjMwpdRgLiczWjnP+Wdv9E
 wdqKt4cCkul82rXzRVSDzJa7ZB4Yn8gR8eCcORuXeh/faRdMdg5s7/FuJT2lS3yQL3N6PNnonxl
 QY6p5fMyliZy7PnKzOEiIwkBWrXA==
X-Received: by 2002:a05:6000:2dc8:b0:43d:6fce:3ef with SMTP id
 ffacd0b85a97d-43fe3dd2b9cmr4255202f8f.21.1776432037728; 
 Fri, 17 Apr 2026 06:20:37 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1682sm4641323f8f.1.2026.04.17.06.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 06:20:36 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4847621503d38e0141c0c4e265299a5e71e98e1c01d97b9d41913a1bd8a1;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 17 Apr 2026 15:20:28 +0200
Message-Id: <DHVGLJTPJW53.2EX6R0YM5BC5R@baylibre.com>
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
Subject: Re: [PATCH v6 00/14] arm: am335x: Switch to upstream devicetree
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Markus Schneider-Pargmann
 (TI)" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
 <20260416110631.6f89a2e9@kmaincent-XPS-13-7390>
 <20260416111302.45a7e1fb@kmaincent-XPS-13-7390>
In-Reply-To: <20260416111302.45a7e1fb@kmaincent-XPS-13-7390>
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

--4847621503d38e0141c0c4e265299a5e71e98e1c01d97b9d41913a1bd8a1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kory,

On Thu Apr 16, 2026 at 11:13 AM CEST, Kory Maincent wrote:
> On Thu, 16 Apr 2026 11:06:49 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>
>> On Wed, 15 Apr 2026 18:02:21 +0200
>> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>>=20
>> > The series is split into two logical groups:
>> >=20
>> > - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>> >   with the current u-boot devicetree.
>> > - Patches 4-14: Make upstream devicetree working with uboot. This
>> >   adds tick-timer, adds compatibility of the board code for different
>> >   USB probing, makes SPL smaller and updates the defconfig.
>> >=20
>> > The series has been tested on am335x-evm. Note that I don't have all
>> > other boards built with the am335x_*evm_*defconfig, so tests are
>> > appreciated. buildman reports builds are working. =20
>>=20
>> Your patch series breaks the scan of extension boards (cape).
>> =3D> extension scan =20
>> Found 0 extension board(s).
>>=20
>> While I should have:
>> =3D> extension scan =20
>> BeagleBone Cape: Beaglebone green hdmi cape (0x57)
>> Found 1 extension board(s).
>> =3D> extension list =20
>> Extension 0: Beaglebone green hdmi cape
>> 	Manufacturer: 		Seeed
>> 	Version: 		00A0
>> 	Devicetree overlay: 	BB-GREEN-HDMI-00A0.dtbo
>> 	Other information: =09
>
> After I bisect, I have located the breakage on patch 13.=20

Thanks for testing. I think I missed adding TI_SYSC config symbol to the
default config, I will add it to the next version.

Best
Markus

--4847621503d38e0141c0c4e265299a5e71e98e1c01d97b9d41913a1bd8a1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaeIznBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlM4
5QD+K/B72P32JuvhHXZLITa65kdceTMjurJGfyl+4uVX9NcA/jF1Q9frby3twa+e
p4nb7xR1YHGNaOFNYfp/hq1osiQE
=XWu2
-----END PGP SIGNATURE-----

--4847621503d38e0141c0c4e265299a5e71e98e1c01d97b9d41913a1bd8a1--
