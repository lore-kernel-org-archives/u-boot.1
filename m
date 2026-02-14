Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637B0EDF15A
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 14:56:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7825C83642;
	Sat, 14 Feb 2026 15:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XXMaYHp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86DF83AA7; Sat, 14 Feb 2026 15:56:41 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE98083015
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 15:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45f194e9a98so605797b6e.3
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 06:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771080998; x=1771685798; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KHjSgP3aTyTple2rVfqxoPa6kj5Cr5X+lMvmi7/zXDY=;
 b=XXMaYHp7YXDScOkoxopkFS0R5HI2XK7ostaMxKcItcil5rqrGSGo0Nuf7gqt6hmaEV
 3lHpJX8Ju+6Qw10sWetPoHEyXRDFCbebiGVm1iBPSu26vtQOJ6/2MAUg2MGMTJ1FuEY2
 wMaxSGz/c87jkQuPB1di68+GnNfwpIQa5Mgpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771080998; x=1771685798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHjSgP3aTyTple2rVfqxoPa6kj5Cr5X+lMvmi7/zXDY=;
 b=ZxisNTCavlgoUqUAZg4QjWJ8/kDFmzSfeali9ktVab++2M7Qu6CcAAWO7sTBRtvQm5
 63ECn8hE5eLEGwxIyGn3+TRLfSN0UGvEwxfHFnecUdVye3vvqgibbzZPKHrY4R8dHdKJ
 2AndJefacmLj+vvLHiLBayY1pvnHMUuG+XlkKAQz9ImM9P0Mvb1FXwZwQRom7hy9u1ad
 nt2fPnAFcTNVYYcIqTliZfGgCov9FPEdSsfSK8jtmo2MjIKRAjDnDkV07V56ZRFDgrU2
 Nh/L66rJEZkcO2dRbLv8nUQBKMoHPbNAHqUDSgvKKuBWGPm5Jko4ey0MS0lGSpHE78u6
 nFxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVegCQwdHg+Vpved9Ru8i81UxS7EQlOrxNQ9hGV5EFOKOYHhDZUCVddTln9/avWl+jcC8ScoVY=@lists.denx.de
X-Gm-Message-State: AOJu0YzczdcSsJeyvTtMQSKTgNwZxTe2sRdcZeVIA3resg2to3U2L4Mk
 OPTHyG+AhkLb0taEU11cSHZ3MVqbJ75xn1XvOiNfyPEfvb3BLWhMGL6i7NTxVUNbBN1Rd/6A4lD
 2WnpczJI=
X-Gm-Gg: AZuq6aL9PjTlpIUB1bXKpjurKilUd7WYXMiUHW/bldTTxEbnGjG8L20DV2RKol5IIta
 2lxoOexlkWwSTWchwQV2Hpz8sC2HxrRQKfy8Uey+ZCNMgd7NsYFaXYhs4JmBUD1f1R3gIV6Bc2I
 22mDZ7siS3LGHUZ57+cD/Z96Q0LKNFoKMQfMtAetyHk5+oflpIf/yLAPpKDSoRDcNIGhT9HK1kh
 05+dimbflIUMFYwkgyhnC8eTNIRJMydZ+qdYvzJtPZNmUxlnYpmNGgHdFmU6db2LzZD51L0iO4B
 hz2ZfK3KNFYB+609uv8Kh/3ZWOYuFCKLXrH7MwDTuekS2onVnCaMgV8owWPUZZzthstYHuDtUVy
 +lp5U3c/6U05s+YOlNSL3X+F/BFbKnuwKyY7HYSIYq8eus04o0MA8EC53oghgnKETuqR0ljN53j
 Tp7Hjbo9Rcx/m7qUilkNssmWhU9m36cCyDqBtM2H3E3noukj7fjJC7ANE+6imzUDTSct/bItGkz
 F54TZHP3ur7Taie/oTsWd+avglqPTtIplS3pv13GODdY3L14GA=
X-Received: by 2002:a05:6808:2e48:b0:450:cb93:69ef with SMTP id
 5614622812f47-4639f28a1b2mr2782120b6e.56.1771080998222; 
 Sat, 14 Feb 2026 06:56:38 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636b065d46sm6667650b6e.12.2026.02.14.06.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 06:56:37 -0800 (PST)
Date: Sat, 14 Feb 2026 08:56:34 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>,
 Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
Cc: Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] configs: visionfive2: Fix the name of VisionFive 2
 Lite DT
Message-ID: <20260214145634.GQ2747538@bill-the-cat>
References: <20260214091424.28428-1-hal.feng@starfivetech.com>
 <b36465d8-2d99-4143-9e4c-91724c43c620@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qf/QBQU0p05QX/OX"
Content-Disposition: inline
In-Reply-To: <b36465d8-2d99-4143-9e4c-91724c43c620@freeshell.de>
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


--Qf/QBQU0p05QX/OX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 03:02:38AM -0800, E Shattow wrote:
> Hi Hal,
>=20
> On 2/14/26 01:14, Hal Feng wrote:
> > The name of VisionFive 2 Lite DT was set incorrectly. Fix it.
> >=20
> > Fixes: 4ea3acc000a7 ("configs: visionfive2: Add VisionFive 2 Lite DT to=
 OF_LIST")
> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > ---
> >  configs/starfive_visionfive2_defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_=
visionfive2_defconfig
> > index ef4acf7c1db..614a003c971 100644
> > --- a/configs/starfive_visionfive2_defconfig
> > +++ b/configs/starfive_visionfive2_defconfig
> > @@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=3Dy
> >  CONFIG_CMD_BOOTSTAGE=3Dy
> >  CONFIG_OF_BOARD=3Dy
> >  CONFIG_DEVICE_TREE_INCLUDES=3D"starfive-visionfive2-u-boot.dtsi"
> > -CONFIG_OF_LIST=3D"starfive/jh7110-deepcomputing-fml13v01 starfive/jh71=
10-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marsc=
m-lite starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-=
v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b configs/starfive_visionfi=
ve2_defconfig"
> > +CONFIG_OF_LIST=3D"starfive/jh7110-deepcomputing-fml13v01 starfive/jh71=
10-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marsc=
m-lite starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-=
lite starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-v=
isionfive-2-v1.3b"
> >  CONFIG_MULTI_DTB_FIT=3Dy
> >  CONFIG_ENV_OVERWRITE=3Dy
> >  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
>=20
> NAK
>=20
> That fixes tag is not valid because the problem is responsibility of Leo
> to revert and re-apply. Your series does not have this defect. I care
> about this because I am listed as a reviewer.
>=20
> Leo: fix this error with revert of all affected commits and do it again
> correctly instead of authors having to submit a "fix" to a bad merge.
>=20
> I would like to know why this happened?
>=20
> Further, when there are ANY changes I would say that the person making
> that change MUST add their tag to take responsibility;  it is not
> acceptable to me to be tagged on a commit that has been silently
> altered. The "forge" (gitlab) lists who committed the series but there
> is no indication or comment about what happened here where it matters in
> the git repository log.

This final paragraph is what I want to stress. If something needs to be
reworked to apply, review tags should be dropped. It really should get
posted again for review (or ask the submitter to rebase) as well if it
wasn't trivial. With b4 you can make sure that if there's problems with
the merge, you instead have the merge resolution in its own commit, for
example:
b4 shazam -S -M series-message-id --merge-base old-commit-series-is-based-on
This will in turn apply the whole series in its own branch on top of the
commit passed to --merge-base, and then merge that commit to the top of
tree. And then you resolve the merge errors there.

--=20
Tom

--Qf/QBQU0p05QX/OX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZCNHwAKCRAr4qD1Cr/k
Csz1AQDzPjAAaJPuEpTr45+lHnbHFFqrVTet/J8RTtjJZvXapQD+IJQpVbW1TVxp
612pYCDLCNutVKim/A2q3mc6a0cuCwA=
=JJYC
-----END PGP SIGNATURE-----

--Qf/QBQU0p05QX/OX--
