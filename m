Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85223C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 14:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6243833C0;
	Tue, 12 Aug 2025 16:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qId7t2uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4598340C; Tue, 12 Aug 2025 16:27:58 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC7983145
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 16:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-433f42c9fe3so3401309b6e.1
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755008874; x=1755613674; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z929v8wWFehmixRX05gZU9T6a1AzEyXC5O670SyvhBk=;
 b=qId7t2uucj9nd55HtNQQmG/jww0wBEt3WHa6OwR6caXU75yvKggVnrCpmEUHo+djDf
 EARP5BvGu3mTpFlrFa+HPSHN7TPYfpxM/QFS30Ayw5/48eyzSUi+Ego32lxmr1LkcFDL
 eQDnptmhImpNHYX339IyH39JkXiiZzF2bA/qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755008874; x=1755613674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z929v8wWFehmixRX05gZU9T6a1AzEyXC5O670SyvhBk=;
 b=Dv6537YwQ0Nv6DWxKtGb/i2B89UUny06IoRGrgyh1PAhoIJONdcdL2b85E5pwbYLdQ
 NlJJqcje5V8sZaz7NhDjJcchYAEamfwoNaNMFETo0iSqzkkRXwPPszP1OySq5PT+Kyc5
 b+jiazXrLh8JBn78uNWC1tS6hY6B1xhKSPatCswzjKruCtr45sdyCwqoB9FG2rU7qXnO
 wYVvevVpjulb+XW/Gr6xIKonqqmj7THi1JFFq0KOF511J4S6wefkNut8N+UjesXXw+wV
 iyWEfw+N2rNbo4EQfL6eqRVKOCgL3c4+vX114qflXViRw1GJKVbsrzi1AXRN5aASNsBA
 U2HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUTsPWhZ3bYNtoZ+eTVmOVW01fK57ia9BkiLimMOVYhe63KagCOyFkuyGI3khB1AI1jMB2S5I=@lists.denx.de
X-Gm-Message-State: AOJu0YwE1Og0ho3dDcbVKEJp7sRcL7kX0eF3NE1eT18TJ5JWvMokRM8R
 XNZQIMZZNgDdZ5ZTgoUXoow/iHj9kN4tn0lwEuGDEv+nJ6JdxesWAv3vWJgylKAHZt8=
X-Gm-Gg: ASbGnctQ26y0rLaR7cw6xIJyNb0rjCLQiiMNydaqnlQY+F+IL7e3GMXeEFg1KlKGstg
 c919tjJn7V6XkJuAtw/ar3J2xQYMh9rEwCtA9B7hAltErO+XVgr9i4dzuRM9FyF8cuPZblumcx7
 hZgAicFfvpwE+l6EzUFq79Tbi9TSPkbCxHANch7Z5VEz6zS8xcVDZdjLiiDNY4cl3NFhgxniRWe
 mL7UxSoz9MU/ffBtzUqfgaMKa1zMbjin/tDMANN4k2AhH4wAMKxRsr01Ld3Fq70QeVzJMN0eX3b
 wAKjDlYMe3Xm5RuErW/ded0FBHHoF0WOz08bntbQYKPQqro0VF4gf3PDmcJJEecDM40uBDARKig
 2IuNZNjSqvJK0APq1CyRNcrUK+UQhO1+G5BpMpDdjikU886Z8QV/nX6O2
X-Google-Smtp-Source: AGHT+IEfngyzJjeuZfvdfpBL72gRBY7Cn/vGjWcNwve5mJ0e6i40NVH+ZR0UUqPzKolbuS+ma57d8A==
X-Received: by 2002:a05:6808:198e:b0:434:bef0:2f0 with SMTP id
 5614622812f47-43597b202abmr9338002b6e.6.1755008874161; 
 Tue, 12 Aug 2025 07:27:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ce85683dsm203146b6e.20.2025.08.12.07.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 07:27:53 -0700 (PDT)
Date: Tue, 12 Aug 2025 08:27:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC] rockchip: add /chosen/bootsource to U-Boot proper DT
Message-ID: <20250812142751.GP124814@bill-the-cat>
References: <20250730-dt-chosen-bootsource-v1-1-955f045b386b@cherry.de>
 <20250730172438.GU1807455@bill-the-cat>
 <8f60f137-0e58-4dd0-9c7b-dd8bce55617d@cherry.de>
 <20250812141524.GN124814@bill-the-cat>
 <c455fb2f-a71c-4939-ad5d-0c7c95f01431@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FFI4bXqErnucP+RZ"
Content-Disposition: inline
In-Reply-To: <c455fb2f-a71c-4939-ad5d-0c7c95f01431@cherry.de>
X-Clacks-Overhead: GNU Terry Pratchett
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


--FFI4bXqErnucP+RZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 04:26:14PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 8/12/25 4:15 PM, Tom Rini wrote:
> > On Tue, Aug 12, 2025 at 03:15:00PM +0200, Quentin Schulz wrote:
> > > Hi Tom,
> > >=20
> > > On 7/30/25 7:24 PM, Tom Rini wrote:
> > > > On Wed, Jul 30, 2025 at 02:03:18PM +0200, Quentin Schulz wrote:
> > > >=20
> > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > >=20
> > > > > U-Boot typically can be loaded from different storage media, such=
 as
> > > > > eMMC, SD card, SPI flash, but also from non-persistent media such=
 as USB
> > > > > (via proprietary protocols loading directly into SRAM, or fastboo=
t, DFU,
> > > > >    etc..), JTAG, ...
> > > > >=20
> > > > > This information is usually reported by the BootROM via some prop=
rietary
> > > > > mechanism (some specific address in registers/DRAM for example). =
For
> > > > > Rockchip, that information is stored in a register
> > > > > (BROM_BOOTSOURCE_ID_ADDR).
> > > > >=20
> > > > > While we already have the information about which medium was used=
 to
> > > > > load U-Boot proper from SPL (via /chosen/u-boot,spl-boot-device),=
 this
> > > > > new property represents the medium used to load U-Boot first phase
> > > > > (depending on configuration, can be VPL/TPL/SPL) which absolutely=
 may
> > > > > differ from the one used to load U-Boot proper!
> > > > >=20
> > > > > It would be useful to know which medium was used to load the firs=
t phase
> > > > > of U-Boot, for example to check fallback mechanisms (proper loade=
d from
> > > > > a different medium than first phase) are actually working.
> > > > >=20
> > > > > For now, this only applies to Rockchip's U-Boot proper DT but cou=
ld be
> > > > > applied to the kernel's as well and possibly for other architectu=
res or
> > > > > vendors.
> > > > >=20
> > > > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > ---
> > > > > I have a board (RK3399 Puma) running U-Boot which currently has 9=
 boot
> > > > > scenarios (eMMC/SD/SPI-NOR for the first phase, eMMC/SD/SPI-NOR f=
or the
> > > > > next phases; not counting USB loading yet, which would make it a =
few
> > > > > more). I cannot force the BootROM of this board to select a speci=
fic
> > > > > device aside from erasing the other media.
> > > > >=20
> > > > > The only way to identify which device was used for the first phas=
e is to
> > > > > parse U-Boot first phase console output or add some custom logic =
for my
> > > > > board. To validate that a new version of the bootloader works, in=
cluding
> > > > > the fallback mechanisms, I need to make sure the BootROM loads th=
e first
> > > > > phase from the expected device otherwise I may have false positiv=
es.
> > > > > This would be useful for automated testing.
> > > > >=20
> > > > > Patches pending in the devicetree-spec[1] and dt-schema[2], hence=
 the
> > > > > RFC here.
> > > > >=20
> > > > > [1] https://lore.kernel.org/devicetree-spec/20250505-bootsource-v=
2-1-5a315d9bff26@cherry.de/
> > > > > [2] https://github.com/devicetree-org/dt-schema/pull/169
> > > >=20
> > > > I am conceptually fine with the changes, but this needs to have the
> > > > schema side approved first, just for the record.
> > > >=20
> > >=20
> > > Now merged in the dt-schema (still no news on the spec side though as=
ide
> > > from a R-b from Simon 2 months ago). Is that good enough or do we nee=
d to
> > > wait on the spec part too?
> >=20
> > Ah good, OK. So should this be in v2025.10 or will v2026.01 be OK? It's
> > small enough I'm OK taking it now.
> >=20
>=20
> I'm fine with v2026.01, there's no hurry for me as I can carry it in my
> downstream forks until it's merged upstream.
>=20
> So, up to you!

OK, thanks. I'll put it in -next soon then for v2026.01.

--=20
Tom

--FFI4bXqErnucP+RZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJtPZgAKCRAr4qD1Cr/k
CqelAP4s28VbD4Fp1IzqkPA/RokFgsXIf4kbuBwZ7cAi8u0yagEAx+kX4qHCMShV
C7IUHPtiUrj2zyipPnrMCDsQVnG5pgs=
=k/yc
-----END PGP SIGNATURE-----

--FFI4bXqErnucP+RZ--
