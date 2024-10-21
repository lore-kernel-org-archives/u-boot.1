Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B932D1714B
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 23:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 045C9892CD;
	Tue, 22 Oct 2024 01:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wc02JNiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B67A088F3D; Mon, 21 Oct 2024 19:26:26 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C64D88EAF
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 19:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b155cca097so305056285a.1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729531583; x=1730136383; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ly/UiLuZr7Xfdz8fHzVwcyMy2T7g34lLEuUrEDQhkYg=;
 b=Wc02JNiF36PUMHFPB6RRTD8hT2oXRytJ8pBfpEzpbOFVD8zm2fVK9j6n1DVITpfpEo
 jwujQI+eO/cbh3e6+SzPtDwCMhMj6u4qn0TJxkvpi8MRxCgf2JKE4kzdUdZiF4OqRxFy
 b+fbSBLGIJ4stLhe0AscEwBnUvv/Hb0jk0IyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729531583; x=1730136383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ly/UiLuZr7Xfdz8fHzVwcyMy2T7g34lLEuUrEDQhkYg=;
 b=pRBjj8USaWh0NP97l1PYRp6qEMowmOi+E5MVt1TGgV3emgvH+W87IFPdGQ185myPLT
 /3Ymctbl+lEjPACG3pTl+H1Gc2gtfK7h1SnvVgiL5nGgwtFkN4zKKFsSzxjGND++4psb
 u8U8KJ1AJ1IdQKFUF0+z4Tfc/EQQGJta8N2nk8QB6g5WVWE5Rv4XOxLCnKcoIRLJTv+J
 sCpN6nr8ypwGKYZ9QzDtRxqxzo7kdS31QNkg3M8WcTylrGJsocUZ9hNL/v3iHMhEs3yF
 rKviQIxYUtG7Dbr9QGRrzt82dL2KEGPhg8FW0frkFOyUPCp+Beit/XCg4fe9rbCnMqQ4
 KvSQ==
X-Gm-Message-State: AOJu0YxQ73SzMW3VfHoYxn6IoK6dbEeZJeE2oXqlZaIfD7BteZzjc2DG
 R23pNoxWScuM/hllGzD53247bVfiEXY7Kj10pqqnKiZBLfqBdPn7V1ywE9bhzik=
X-Google-Smtp-Source: AGHT+IFuP9u7KYEpS10iBl15Z5HlPW1oWKxzIANwAJQiNMzxpVzG+VxLUCO49cansxqFxMJRKOX24A==
X-Received: by 2002:a05:620a:4047:b0:7b1:3c0e:3289 with SMTP id
 af79cd13be357-7b1755b6600mr58412185a.22.1729531583247; 
 Mon, 21 Oct 2024 10:26:23 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a89216sm191017885a.135.2024.10.21.10.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 10:26:22 -0700 (PDT)
Date: Mon, 21 Oct 2024 11:26:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Artur Rojek <artur@conclusive.pl>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jens Scharsig <esw@bus-elektronik.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sam Edwards <CFSworks@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 00/25] led: Remove old status-LED code
Message-ID: <20241021172613.GN4959@bill-the-cat>
References: <20241021113839.318572-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0/RB41bhVlUorVM2"
Content-Disposition: inline
In-Reply-To: <20241021113839.318572-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 22 Oct 2024 01:45:50 +0200
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


--0/RB41bhVlUorVM2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 01:38:08PM +0200, Simon Glass wrote:
> There has been an LED framework in U-Boot which uses driver model for
> about 9 years now. Recent work is underway to improve it and provide
> more features. It is probably a good time to drop the old code, which
> is only used by 5 boards:
>=20
>    ./tools/qconfig.py -f LED_STATUS
>    5 matches
>    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
>    socfpga_vining_fpga
>=20
> This series attempts that.
>=20
> Changes in v2:
> - Combine code-removal and defconfig changes
> - Add a patch to enable LED and LED_BOOT for these boards
> - Add a patch to enable LED and LED_BOOT for these boards
> - Enable LED on the 5 affected platforms
> - Reorder patches for bisectability

So I believe this means you missed the feedback of just doing the blind
migration rather than disabling the feature, like we used to often do
for cases where it's just a matter of changing CONFIG options. It
should:
- Not introduce a failure to build
- Just work on platforms with either OF_UPSTREAM or semi-recent device
  trees
- Just start working on those platforms when they do move to
  OF_UPSTREAM.

--=20
Tom

--0/RB41bhVlUorVM2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcWjrUACgkQFHw5/5Y0
tyyFiAv/aHo3Tokt2eUZXHos4TznuQUnW1QEkLbjCBK7u9mU+aEH3CfMHzKLXNsH
4JpdEG6Y8Bebt4NcHmkJwQinPeZYWYCv6Vje+L3PfISCIIj2x6mi1sdNKwM6qYUr
4V8ywmb+AnBDawPz19//9niWmhYNhCiW5W/xfKSM34R6T6O/qpNkb6XcqmbURv5t
gYQi3OpvMHlMb6EEgzW+HDEQOiFo5qAPIE0gL0DOb/ZUxbEdm7uW7D7BzbpjSKlF
g6LKAaSI7hnaHsFXn17yTgnQnPfYs3UrWcEIrUCuks+d4/gvkfRhJBV348GRurtE
kn4+vC5N3Hji12572pDuCwRvSH37l7jLYWO40EjIhC0cMySpvVITOO+N1Mgx3jlX
oxUfS+y+zPmW61bi7p7GhuvWp3JTBH01z1hbfhZMDloW/mMUoP3adzmXQ60ase2c
tYcG++HwX6+HNu7k5g+dO5zjQZkv9m/t/Bog51ouX+gZkSkxTfUk1g4siplhB5Bd
CE9uAD17
=gtKj
-----END PGP SIGNATURE-----

--0/RB41bhVlUorVM2--
