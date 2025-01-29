Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF27CC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 15:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3C7807F9;
	Wed, 29 Jan 2025 16:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YTw1uqCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 354DF8083E; Wed, 29 Jan 2025 16:29:35 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC909807E2
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 16:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7b6e9586b82so607912585a.1
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 07:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738164571; x=1738769371; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cSYkRMnmcp4crWWUQ49usY3wjeb1+bESFjn1ETabf2U=;
 b=YTw1uqCujDexBBAigrswNfNkIo3fXl4wKLZsrMcuQ1PdnpQY2qH1m2wXgpdBPoK1aa
 0sOUkq/1W5RFrugLlS6BjNMv9x4r+zR7BtCO2rPZvIwkzieBgv2JBU1pJZSSwC6ewu+p
 re3dnLx4gSngN+ZLMzcOd1H2b3+r+tn5p1E7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738164571; x=1738769371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSYkRMnmcp4crWWUQ49usY3wjeb1+bESFjn1ETabf2U=;
 b=oDWEFdMoq4ziEJVk67j/7kLa2cRoXlS8YNHD4cjEzoZOnna8LDg07ATNSuxyOZcyqL
 ej2Kr9RrjvQ5XyKBwEktN9bEn9i7OlO/+V4FDrJEe5s4fsKVhCvhxqkw1rJSuzrEMMtL
 SD1m2dijUtcqgNqxawqfyx+BSG+ba/K+0LcRCJzz30LdpSBQ3qJkxGHR8Et/P4lKUrbC
 U4P68eFinlKT4O+qGdJGPRWjb2SJkrAQw0nt/77mW1yT30BMWuyMGxLhQny0TnpSvcHw
 99vOObyUiYm3BoP7m8mGf+qLLQS45ywF1Yz7PPTzmXp69l7ebSfNiWMhdcZ4wDTn491W
 Y7+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxzzEeeIsGJpOABgiqXu/4qulSpT3g0vKBczzSExyO0cGaW19hqrY4X1LajKIZgtk3hzdZYXo=@lists.denx.de
X-Gm-Message-State: AOJu0YxWHp4/EyhbAObkUc2Mcc3HKmLz9fuWOCv5DNibEkFTykdGJne8
 egOJvWpJA6J3AoUvOW6ZzDHxuaezuZYpgyNO0pUi6CRkeSqkQcS3HTrg4/jw+Mc=
X-Gm-Gg: ASbGncvM06d0KxlpFvIQklKrmAQE8yyBjXKNlov9EP4Ary4YXmgY952/KQKkN4hd7ct
 8vTw3tdprPJy8IK74KqoWGo3AJyQKpVCRZgt3cQXozVa8FFEDtK87v0uuHDf45Sqx//3pqz1D4r
 6Nwj9OHu12Gk2oIB/ipT291nR9Lg9CUY5bpkfLJUg+gilslwKJ9hjDquadIRrlD4KI/tqrDHZkE
 G1yGnOJaKRQ8mDM4rwkPrfXfWi/D/GHv2gIp4YUrpIxe1Ub7NVUNLmDEcw9Mw8v+5FSmB2FAQcb
 wpIaIVEb/GMJ1M8=
X-Google-Smtp-Source: AGHT+IEWPo25iAYGWtDuFKlhTGXxpYs9O+Kq6QvJ/eZs6rtRaKiQ7IdL7HzHuvr81+0cIaQBcdMs/Q==
X-Received: by 2002:ad4:596f:0:b0:6d4:36ff:4358 with SMTP id
 6a1803df08f44-6e243bf672emr64312166d6.25.1738164570633; 
 Wed, 29 Jan 2025 07:29:30 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c159bsm56218066d6.97.2025.01.29.07.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 07:29:29 -0800 (PST)
Date: Wed, 29 Jan 2025 09:29:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 jonas@kwiboo.se, dsimic@manjaro.org, pbrobinson@gmail.com,
 marek.vasut+renesas@mailbox.org, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, greg.malysa@timesys.com, bb@ti.com
Subject: Re: [PATCH 1/3] rockchip: Fix TPL link error
Message-ID: <20250129152926.GU1233568@bill-the-cat>
References: <20250129132529.807031-1-naoki@radxa.com>
 <d7c14292-1d74-4692-b981-8b674c005069@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hokMThkKhgM+Rw1q"
Content-Disposition: inline
In-Reply-To: <d7c14292-1d74-4692-b981-8b674c005069@cherry.de>
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


--hokMThkKhgM+Rw1q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 03:16:13PM +0100, Quentin Schulz wrote:
> Hi Naoki,
>=20
> On 1/29/25 2:25 PM, FUKAUMI Naoki wrote:
> > Rockchip RK3399 targets build TPL. If CONFIG_SPL_USB_DWC3_GENERIC and
> > CONFIG_SPL_USB_GADGET are enabled, linking u-boot-tpl will fail.
> >=20
> >    LD      tpl/u-boot-tpl
> > ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_bind_co=
mmon':
> > /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue=
_bind_common+0x20): undefined reference to `usb_get_dr_mode'
> > /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:527:(.text.dwc3_glue=
_bind_common+0x20): relocation truncated to fit: R_AARCH64_CALL26 against u=
ndefined symbol `usb_get_dr_mode'
> > ld.bfd: /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:529:(.text.d=
wc3_glue_bind_common+0x2c): undefined reference to `usb_get_dr_mode'
> > /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:529:(.text.dwc3_glue=
_bind_common+0x2c): relocation truncated to fit: R_AARCH64_CALL26 against u=
ndefined symbol `usb_get_dr_mode'
> > ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dwc3_glue_probe':
> > /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue=
_probe+0xb0): undefined reference to `usb_get_dr_mode'
> > /home/radxa/u-boot/drivers/usb/dwc3/dwc3-generic.c:683:(.text.dwc3_glue=
_probe+0xb0): relocation truncated to fit: R_AARCH64_CALL26 against undefin=
ed symbol `usb_get_dr_mode'
> >=20
> > Do not compile drivers/usb/ for TPL.
> >=20
> > Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> > ---
> >   scripts/Makefile.xpl | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
> > index abc49fbe6c9..e4ca4d395ac 100644
> > --- a/scripts/Makefile.xpl
> > +++ b/scripts/Makefile.xpl
> > @@ -125,8 +125,8 @@ endif
> >   libs-y +=3D drivers/
> >   libs-$(CONFIG_SPL_MEMORY) +=3D drivers/memory/
> > -libs-$(CONFIG_SPL_USB_GADGET) +=3D drivers/usb/dwc3/
> > -libs-$(CONFIG_SPL_USB_GADGET) +=3D drivers/usb/cdns3/
> > +libs-$(CONFIG_$(PHASE_)USB_GADGET) +=3D drivers/usb/dwc3/
> > +libs-$(CONFIG_$(PHASE_)USB_GADGET) +=3D drivers/usb/cdns3/
>=20
> I don't know what this is actually used for? Like why is it different from
> the typical Makefile we have for other subsystems and drivers?
>=20
> Can't we simply remove those and add them in drivers/Makefile, like:
>=20
> obj-$(CONFIG_$(PHASE_)USB_GADGET) +=3D usb/dwc3/
> obj-$(CONFIG_$(PHASE_)USB_GADGET) +=3D usb/cdns3/
>=20
> For example?

The likely answer is that we used to not have consistent CONFIG naming
here between SPL support and non-SPL support, and while that's since
been corrected, this part was never updated to take advantage of that.

--=20
Tom

--hokMThkKhgM+Rw1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeaSU8ACgkQFHw5/5Y0
tywleQwAprAw1rYYJbJvOjLY16cfUSy7Zk4+11tk2kVlmHapDISfPbu8ErJ9Xs8d
XX2K1Li2eIZkYDAA8llxHdN1CmrCCjeJPcAzZG4d+tQC+5W2Ef/xcQErUwseAsIH
Cd7WbmBBSJZND4ivmC+AO4XbO3XrJzo+qhOyP543QUztNOxxQwlFtAoljxyk3boG
Xd9cLhMNqAlapGxXerdzoYdfKnaJ5cdX41easptqzczyRvv9+F+GIqOyaz0wB1ll
hPeap/TpNCM5yt9ukFBjEAwOSvJp7YVth4PDb2kbzo/+DM90OeakO6dflToJ+2LK
pcW6D8T3V71JqFM3hG2uRvxKp9XXSwsXiJ76VeEHgJ7h6Mtmtc2fBH1UHqOJH0sy
E9MycbBRJhSJ+W0dopn3Wdu1GHljAAufZjZdgyF1aQ2X5osQl6JOkfmvme5LnoPr
88Q+ttNlIjZa17Lv579h5l1PW7y26OxR03hS/t2S/pHQLNhT0cLEguUVrDoc/7rF
8TqkdPDV
=sX/A
-----END PGP SIGNATURE-----

--hokMThkKhgM+Rw1q--
