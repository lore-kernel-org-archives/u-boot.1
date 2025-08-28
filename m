Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF80DCA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 13:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D2EF83390;
	Thu, 28 Aug 2025 15:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LYhx0Afv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19A783394; Thu, 28 Aug 2025 15:52:37 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8745C831C2
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 15:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-74542b1b2bcso1002747a34.3
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 06:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756389154; x=1756993954; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vE084mwnXhVqciGEWJ67zkJ2QX1Ea6nPXF0OCPIcBGc=;
 b=LYhx0AfvkPYPrONq86fpriEPwFmijCscBAOVXFihAaPFbjAznxevOOkyaMGhj5wvwB
 bwoPMg8xc6J/LtzImbsKMT9fpUn/Y9K5uu6KrLX5ILQd+dj5x37SQ/OBro0F7aFIz9Ru
 NpEagIUI3vYQ+Kc6ASGBpPQv/7ZVDlzfcF9Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756389154; x=1756993954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vE084mwnXhVqciGEWJ67zkJ2QX1Ea6nPXF0OCPIcBGc=;
 b=gSHaHD2vHXDU2K2uhxgKAZJrnBNmcCHbbyRhkzq10MI8Pi1scVDFs7feNjI/o1S317
 RX89PBQNHrnEzgndp5oa3dHTN1go45vASbXfxckpfJL2+D4oulmaXskBGD9aECm/jrFe
 fEN1qHo3MISFBBNBSLc7fBfSe0fNMvAzfj79xIJy+RoE9jGM6tQ0tIPGttNMuqg3i8in
 teZvK/+fJPuwmTxhOqfTU2vrBMI7nHFymq3oAr7xk3QWF7HcBcKULae9Alsklx3/T0Dn
 R8+AzLrsLDvHyC1Z9lnFBgekzBwrKB9LOlF8lE2LB/aOVc2sE774wtoTN/LfBt0UJHjT
 FJYw==
X-Gm-Message-State: AOJu0YwQ/moJTPaa4GHsMqNGVF5J0uolbCSkbR6GyNzVoD9K62M3hazA
 //QQu/UMH5lv2JTwJquidncLpJVnUtAYm4IFfom8CfIaXXjUOHP7vEW+lf4imTTHD+g=
X-Gm-Gg: ASbGncsw3jkH+EeCA6HDHkwR4+Inhl7h52/FdYRZ4GX+jdT7PPkZo+vIroTMswz0y0u
 Rg1h9wewjmQEbvt5gJFCJlgqURz+Td66B7Zcy623W7sa1LypWOc+5+RpjdKK1tHEKForsgIa9RO
 wh/qFq+97TiyA+YDDFP99wQXd+j+TEU5i/Y7/9/vOi4VlhOx8kns/eLghM31FY8wctaEvDVRsEP
 xcaUU488iMXl0bBz813NhiXQLj5KUhF1/DpeKGsoAhzOWNXLEAsK0V6RgEPtB92OYbU0ad1NuBP
 HqTVIc+z9q39goWZ66Xdrsl11kV5SWZwyDzARYkHPQ67qoEujRm3xE1A2X6NiwFfRxX/4z8ZENO
 KaRq92qlsh/DwnlnKEnZ80ewsT29oEnO3qCrz+74q+uIIDDQnQ8lOzAkdk478Rg/lyPI=
X-Google-Smtp-Source: AGHT+IFGoeLZJCxMjIGs5TNUTrRnYqwAt4eDHSkZqh/tylKR5R0uhkhCcLF6wQVjDptI6VjRVgj+OA==
X-Received: by 2002:a05:6830:7304:b0:745:3dc1:16ba with SMTP id
 46e09a7af769-7453dc11b27mr2841765a34.20.1756389154107; 
 Thu, 28 Aug 2025 06:52:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e49dbb1sm3871813a34.38.2025.08.28.06.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 06:52:33 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:52:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sky Huang <SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mediatek: add doc for MediaTek
 MT7987/MT7988 2.5Gb ethernrt PHY
Message-ID: <20250828135231.GO124814@bill-the-cat>
References: <cover.1756283872.git.weijie.gao@mediatek.com>
 <8c0d6997255a2bbc2e761ed457c51de653cc96c5.1756283872.git.weijie.gao@mediatek.com>
 <20250827182822.GJ124814@bill-the-cat>
 <e13e0dabf7b4adee9b987557c2c54803dcc6075e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UP6KAOYy4585XTsn"
Content-Disposition: inline
In-Reply-To: <e13e0dabf7b4adee9b987557c2c54803dcc6075e.camel@mediatek.com>
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


--UP6KAOYy4585XTsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 03:22:14PM +0800, Weijie Gao wrote:
> On Wed, 2025-08-27 at 12:28 -0600, Tom Rini wrote:
> > On Wed, Aug 27, 2025 at 04:55:54PM +0800, Weijie Gao wrote:
> > > The MediaTek MT7987 and MT7988 platforms supports one built-in
> > > 2.5Gb
> > > ethernet PHY through eth1 interface.
> > >=20
> > > This patch add documentation for configuring these PHYs.
> > >=20
> > > Signed-off-by: Sky Huang <SkyLake.Huang@mediatek.com>
> > > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > > ---
> > > Changes in v2:
> > > 1. rename "pd-disable" property to "half-en"
> > > 2. rename "gbe-min-ipg-11-bytes" property to "gbe-min-ipg-11-bytes-
> > > en"
> > > 3. rename "auto-downshift-disable" property to "auto-downshift-dis"
> > > 4. add note for "retrain-dis" property
> > > ---
> > >  .../net/phy/mediatek,mt798x-i2p5ge-phy.txt    | 68
> > > +++++++++++++++++++
> > >  1 file changed, 68 insertions(+)
> > >  create mode 100644 doc/device-tree-
> > > bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt
> >=20
> > What is the status of this binding in Linux? Thanks.
> >=20
>=20
> The driver in linux kernel is just a basic version supporting only
> mt7988, and of course none of these bindings are supported. The u-boot
> driver is actually the complete version. We also plan to update the
> linux driver later.

To make using OF_UPSTREAM easier, among other things, I would prefer to
get the binding finalized in the kernel and then implement things in
U-Boot so that we don't end up having to deal with incompatibilities
here. Thanks.

--=20
Tom

--UP6KAOYy4585XTsn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLBfGwAKCRAr4qD1Cr/k
ClOUAQD+op6ZDDN4gm6q8ppRs5+HV4LyHE8/Cy2UTIrjJNF/uAEA+xEdOSseUW50
C8oW1s0pwz1AKN5fDArt30OpDK8dPQc=
=42qG
-----END PGP SIGNATURE-----

--UP6KAOYy4585XTsn--
