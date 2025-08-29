Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C69ACA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A184B835EA;
	Fri, 29 Aug 2025 16:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dtzQhX2R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B230835FE; Fri, 29 Aug 2025 16:23:34 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED515835D0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 16:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-30cce50dfb4so2176895fac.0
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756477410; x=1757082210; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AgIJHTSnQakiPpm3aBTMc/hV3OSNeu0MW3JVpW44yqc=;
 b=dtzQhX2RYhDoNkZHnqa9Tdh11QjK/eyUtGGWeoW5BHsZMENfZtTG2onWVsdRXrLobP
 qna7qbv6zbNm6C+m3qGbVjDyo4bDAy/zxIbPopOfOKR1GjLP8ibhF8FtYDLFbaa30dNQ
 XrgexHyX5UNGVGgjwSXGFmiZ6SSnMHdCxjT2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756477410; x=1757082210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AgIJHTSnQakiPpm3aBTMc/hV3OSNeu0MW3JVpW44yqc=;
 b=bzII5Yronmsr/BkJAFfQa1N0YTFBXmTgRDNoQaWvu62uTK2IFJ82OdH7rJ1h+lWhxQ
 SwDmRaOh6Y97LjOe1A3cOu124HS85Ynja+1dbPDluYHooBA94RjitxKNwpoBSxzu4O6D
 Bbc5S1YuBsLH3M0OeTcrZEceM4rzAA/MCUfvbqt3kxW7wpqhHiXo0+koYDeeOqEiYsVn
 JxXH0edQCerp/mgssBbifh4axbqySbaiM8jnsvTmHC3fHKcAx/6k5NsaRbkCsb5/Um4l
 6UCmsj/Hl3X2pWi7+H4/bdtdK9ouNksULp4Y2/kzoaj8I9zPd6YSQnNI4mLRJubaTGPG
 Vcig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKlHrXPx7Elska88K0BM5+bb5SurF5yB9d/iBRzQ9yKjyKuuHZaFg1vfDZE4CQIcdT96jxt9A=@lists.denx.de
X-Gm-Message-State: AOJu0YyGrXlRJUJDFknlAPH2gxs6wWeApCys61L2l5O4+PtWWLAGFCjX
 otmuVBCXZSmlP6CnsN6BUEHxKpZiU+97HU471DB7qBrG5jQ9iOYpvkgdAT85IYBOk0E=
X-Gm-Gg: ASbGncuQlxPHfnyj7WukuQwtsHU1jcaLtWEduI331/Si3WJb7p2NW7aiyZvma8i9ebB
 9L6X6qlZjN+oOMkDQFipEZT20lgtJ3nRIFqtC3XV2YihmuhSFybcEVsN8eChc6bgTQUxQcrl9k1
 Dgy5vhHhIIRquUcUPaaq1XzzJ/w1uYLWfr2dbU44VCM8B8kSAmTqsnrgtpwotFKhuXo233dbT0V
 f22tp0nU7vNMVcUvlj6vZixXKxuyeMlNpbzPcRrf6FbzhNN+ElkXAQHIDJ8t/oGvxriaBTmhJzB
 0zVFCOal7oG1TClkLrahMPxCWZzRzjf5TavIb9LFjJx8fWIk+yGzFnEempW15v4m1eACApGPZRX
 TP9bVS6MEbwnlbyCCBjPkKt5TZAcmCpqA9aPjspCywwDY8CI5Eyq2XuCp
X-Google-Smtp-Source: AGHT+IFFd2wwChzv1UlKHwPql2sbkTBD/uLchFsueIqaC9XCwc7xZLnxaJkuQ7JsmKNtk/MlStwCpA==
X-Received: by 2002:a05:6870:304a:b0:314:b6a6:685a with SMTP id
 586e51a60fabf-314dcdf52dcmr11867336fac.40.1756477410531; 
 Fri, 29 Aug 2025 07:23:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-315afc5b846sm1323066fac.13.2025.08.29.07.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 07:23:29 -0700 (PDT)
Date: Fri, 29 Aug 2025 08:23:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao =?utf-8?B?KOmrmOaDn+adsCk=?= <Weijie.Gao@mediatek.com>
Cc: "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mediatek: add doc for MediaTek
 MT7987/MT7988 2.5Gb ethernrt PHY
Message-ID: <20250829142327.GT124814@bill-the-cat>
References: <cover.1756283872.git.weijie.gao@mediatek.com>
 <8c0d6997255a2bbc2e761ed457c51de653cc96c5.1756283872.git.weijie.gao@mediatek.com>
 <20250827182822.GJ124814@bill-the-cat>
 <e13e0dabf7b4adee9b987557c2c54803dcc6075e.camel@mediatek.com>
 <20250828135231.GO124814@bill-the-cat>
 <d2a5263ad99060c90f8b414db96d45f192c6f6db.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="terzhZMqiZjqU4Q7"
Content-Disposition: inline
In-Reply-To: <d2a5263ad99060c90f8b414db96d45f192c6f6db.camel@mediatek.com>
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


--terzhZMqiZjqU4Q7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 01:44:45AM +0000, Weijie Gao (=E9=AB=98=E6=83=9F=E6=
=9D=B0) wrote:
> On Thu, 2025-08-28 at 07:52 -0600, Tom Rini wrote:
> > On Thu, Aug 28, 2025 at 03:22:14PM +0800, Weijie Gao wrote:
> > > On Wed, 2025-08-27 at 12:28 -0600, Tom Rini wrote:
> > > > On Wed, Aug 27, 2025 at 04:55:54PM +0800, Weijie Gao wrote:
> > > > > The MediaTek MT7987 and MT7988 platforms supports one built-in
> > > > > 2.5Gb
> > > > > ethernet PHY through eth1 interface.
> > > > >=20
> > > > > This patch add documentation for configuring these PHYs.
> > > > >=20
> > > > > Signed-off-by: Sky Huang <SkyLake.Huang@mediatek.com>
> > > > > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > 1. rename "pd-disable" property to "half-en"
> > > > > 2. rename "gbe-min-ipg-11-bytes" property to "gbe-min-ipg-11-
> > > > > bytes-
> > > > > en"
> > > > > 3. rename "auto-downshift-disable" property to "auto-downshift-
> > > > > dis"
> > > > > 4. add note for "retrain-dis" property
> > > > > ---
> > > > >  .../net/phy/mediatek,mt798x-i2p5ge-phy.txt    | 68
> > > > > +++++++++++++++++++
> > > > >  1 file changed, 68 insertions(+)
> > > > >  create mode 100644 doc/device-tree-
> > > > > bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt
> > > >=20
> > > > What is the status of this binding in Linux? Thanks.
> > > >=20
> > >=20
> > > The driver in linux kernel is just a basic version supporting only
> > > mt7988, and of course none of these bindings are supported. The u-
> > > boot
> > > driver is actually the complete version. We also plan to update the
> > > linux driver later.
> >=20
> > To make using OF_UPSTREAM easier, among other things, I would prefer
> > to
> > get the binding finalized in the kernel and then implement things in
> > U-Boot so that we don't end up having to deal with incompatibilities
> > here. Thanks.
> >=20
>=20
> I can resend this driver with all dt-binding related code removed as
> they are not really used in normal case. No incompatibilitie will be
> introduce in this case.

Sounds good, thanks.

--=20
Tom

--terzhZMqiZjqU4Q7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLG32wAKCRAr4qD1Cr/k
CgvZAP9QVGJIvJhGGHSl1LQgEW2EenLGEMTskCo6h3PRGrVt8QEAt5EArRsirg9s
XasoL92NYN9TH4eINaqwiCM4BTeRVg8=
=/PIx
-----END PGP SIGNATURE-----

--terzhZMqiZjqU4Q7--
