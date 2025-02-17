Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E078C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 14:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764E48083C;
	Mon, 17 Feb 2025 15:53:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oPcMOFeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5787807F1; Mon, 17 Feb 2025 15:53:45 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62853807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 15:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fa5af6d743so6706760a91.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739804022; x=1740408822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T1hPQl1gp6mczAUhHPbh+XNpnE5BJfzhP9ecXPmYq+k=;
 b=oPcMOFeFJTFtW6C1j6nP5ySS2GG4Lwe3+tfwNESERIG5vovr3KTFBDYFX1o6Jevae/
 7u/wG2QA2uXIXLwevgMhwltddBhATeh9VGHyzSkz56+NgS+e9yfUFwZnBw1wIZSchsY5
 mGDZ+5wALSYWoIWU+DF7hXzCy3m6nNrpLjHpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739804022; x=1740408822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1hPQl1gp6mczAUhHPbh+XNpnE5BJfzhP9ecXPmYq+k=;
 b=sFHyLo7UrUsa9Zc32ZoniSeUEMGDB7PXpn6c1IGpafN29H7jg3bmUFpqzaatMJF9g+
 4hT6RmBgiCulNEmfgpjqucctuWKISUb7SE+ZZC9ISWNCeagiHy9nuTbvxCBf9w6F559y
 kyP2QOs8gypLepgg09lCT35blPBtcdTVmgQSXXLcPOLiMnKTCdhgEpVWV2os3M4Zu3mD
 vFL7sCGROG8FnmGmKFVvQ7prMON8Ezc8xSuW0RCTsUyncHjZ58Xsq3Fh2Y04OAsIlK69
 O6thXQ84RdlonKC81zwEuSILidDvO7YpYeWG5L4oM5+XDuJ/s8Ty5DUqz8HhmPGiI++X
 YZIQ==
X-Gm-Message-State: AOJu0Yyh0Xn52Ngb1LpWwy14Ak+vE1r3yCAtjHI67hEOAP4WtvIczMwd
 Xu+zcvTCedv4JcKi0FPm5C8lVJBWYQE0tioPA6R5sIHEO28dZmVdv3ZabSUBHzw=
X-Gm-Gg: ASbGncv2VHQ7qSCxfiASsGkJI1DwH4I3RdyzrJ28Z1sAuA428uDk/J2RSZMNAXqOY3X
 YrmKE9R0Do37VPTqHtf2v98om9LNFLwhGTEO/KlfxD4pveQiq+eqxBtXs3rccXZB3jsqKU2fjpH
 IAiWLZFcIjbiYhIZJnyGL5AHSH2qTjWZXL6NahZCoEiEFetvblAlt/6ar/krvnIZnCO53Yylc2f
 lDMfvliPhzO+EWeECDJHijhULAJ9M92qwTE/Ca+D5Fh4ZSXmuAkGbbGWPrxaFr2qNWdlPqAPP9T
 G8I2aEIvRJqA/g==
X-Google-Smtp-Source: AGHT+IFxFt/EJwLCvrtc2X5DXYTmZL30LYmnBbzvBR3xAxMphbm7fmwVwC49EeB77y69ju0+9MA8Hw==
X-Received: by 2002:a17:90b:3b92:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2fc40f1085emr16132718a91.10.1739804021884; 
 Mon, 17 Feb 2025 06:53:41 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ba6969sm8248817a91.47.2025.02.17.06.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 06:53:41 -0800 (PST)
Date: Mon, 17 Feb 2025 08:53:38 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ng, Boon Khai" <boon.khai.ng@intel.com>
Cc: Uboot Open List <u-boot@lists.denx.de>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Maniyam, Dinesh" <dinesh.maniyam@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>
Subject: Re: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
Message-ID: <20250217145338.GL1233568@bill-the-cat>
References: <20250117031535.19595-1-boon.khai.ng@intel.com>
 <20250117031535.19595-2-boon.khai.ng@intel.com>
 <20250117175638.GV3476@bill-the-cat>
 <DM8PR11MB5751359F31EDC36DABABCF8CC1FB2@DM8PR11MB5751.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ok8MgLdnph9WwiQ8"
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5751359F31EDC36DABABCF8CC1FB2@DM8PR11MB5751.namprd11.prod.outlook.com>
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


--Ok8MgLdnph9WwiQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 02:34:24AM +0000, Ng, Boon Khai wrote:
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Saturday, 18 January, 2025 1:57 AM
> > To: Ng, Boon Khai <boon.khai.ng@intel.com>
> > Cc: Uboot Open List <u-boot@lists.denx.de>; Chee, Tien Fong
> > <tien.fong.chee@intel.com>; Hea, Kok Kiang <kok.kiang.hea@intel.com>;
> > Maniyam, Dinesh <dinesh.maniyam@intel.com>; Yuslaimi, Alif Zakuan
> > <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> > <muhammad.hazim.izzat.zamri@intel.com>
> > Subject: Re: [XGMAC dt bindings v1 1/1] dt: net: add DWC XGMAC binding
> >=20
> > On Fri, Jan 17, 2025 at 11:15:34AM +0800, Boon Khai Ng wrote:
> >=20
> > > The Synopsys DWC XGMAC is a configurable Ethernet MAC/DMA IP block
> > > which supports multiple options for bus type, clocking and reset
> > > structure, and feature list.
> > >
> > > Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
> > > ---
> > >  .../net/snps,dwc-xgmac-ethernet.txt           | 67 +++++++++++++++++=
++
> > >  1 file changed, 67 insertions(+)
> > >  create mode 100644
> > > doc/device-tree-bindings/net/snps,dwc-xgmac-ethernet.txt
> >=20
> > Same comments as the first binding patch.
>=20
> Hi Tom, I didn't quite get the context, the previous comment in the first=
 binding patch
> were " We need to just use the upstream binding here, thanks."
>=20
> Do you mean I can just use the doc/device-tree-bindings/net/stmmac.txt
> as the binding for the xgmac driver?

To be clear, it means you should use the same bindings at the linux
kernel, which we have in dts/upstream/

--=20
Tom

--Ok8MgLdnph9WwiQ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmezTWYACgkQFHw5/5Y0
tyybGQv/aAi9BhdEar3k0JFF96nwqr/ZnqBucfXE/dkOOb4tM62vrTuK/1DKYtfO
BXucAcWhXwdCpDvZ5lmj/VD9Wv9nwSAlUU7a0qPQC9HI4Obpw8/9a3s7tRmSPOnd
1sZkXYJQW1jpch2x1m+4B8fM3tYfz+Ga95BlF7JWYjQbZq/sa2JK3+CpdSwpLFZ7
BO5mTGRIZnQyD+ceUGWOh4BrV2PVfk9coY2t5RidUG58X+Vmc1iy7OPTcq7mOEII
NKsfY6RgCi20t3Ha/38NmubuPDK0CNHQK3N4LdI/oAPTXYgtTeaA0hYhlfASo7lf
QBHyF7eWwbJLMz1KMFZDAeO1h6D5ZFlNBunuVannEfEg4q8gsvB2VO1PKlWIiK9t
j7ZBZmbQDaMpW5obFgzhR1T8iXw7dlL1jLVItp5k5ektbCLhUO4/bsdKt5bGbGHa
Ee76CDp57YiqXRvUx26J9Dc3S9+p8y0py+LemOtUHhP2m4/2/vYUUnY5888Ustx8
aYIJrEkV
=0M2n
-----END PGP SIGNATURE-----

--Ok8MgLdnph9WwiQ8--
