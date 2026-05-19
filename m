Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA803CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36900846DF;
	Tue, 19 May 2026 15:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="erzRwkG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 522F5846DF; Tue, 19 May 2026 15:56:05 +0200 (CEST)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com
 [IPv6:2001:4860:4864:20::44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 811E6846DD
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x44.google.com with SMTP id
 586e51a60fabf-43a6491f5dbso2576690fac.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779198960; x=1779803760; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C2ofDaH/iDMzny2yvuMxJqbHkzJNimEG7VLzx15ViXg=;
 b=erzRwkG1z8/Gj89Ru3tCrdRkrmg85UE0oof5PPuNtblU1jKdHnVlDPuhnsDq8eVnAT
 VnvpKvZRIQR/P0xvxsEtPsvXDwZXBp3RjMBIGH1RVHhpRXcsPqDUvqJcii0rKrEyUcfs
 BRG7/j/Os7Dgqu+7icU2rdlXOQrqM4DJpRowY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779198960; x=1779803760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2ofDaH/iDMzny2yvuMxJqbHkzJNimEG7VLzx15ViXg=;
 b=F9w4/mDwUlUQVRgnsVIcRZCnDJ/hqkOJUAlTEl6IUPIcI0Eznr3dOpTJ8htzHA075R
 CAXy+MoLmzed81+AYZtpmbI0MqAjlQrzQthO0EMVAK+QSpS0zGLwELE9Bl9c1CqG3Ypx
 VTeVjXegNsSCNjwFHmWvKmJjwmM4VGG0IB5q3VggYdrY61qFaf68yxsm+5aiaEiD2JuP
 BDJuwYoAVq32vf6yjr3iKQFh1s98PneL8qdq8oZ1ITOubnLNAygsM+9kqcacRcPRLVqV
 H6JGFyo0plbShZ2FxCASADmQ1ezmKlb+VYSE9E/1SSp+A+saWd9TP6logMoFOnBxxCJv
 k9iQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DVWE1IxqLbsNRF1PhYb7sXGC4M4Ha60N5D6wWgS2DKfQdj1lgnEOE2ytqeqAXyXbXbCcnSaQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxp9gy15VCfFy3/W/vsUw9LYx60ju4tZjUHNzWX2rVjOenoVDpq
 mYc6gre1QjsLESObPScOgVrtQAl+kYi0aDXBQiW+tvHyKTzZIf6bgLq43gJ1idTCQhI=
X-Gm-Gg: Acq92OFz7L9G3KUTPe/hoKr2Pd4CHIVS/zYZiorlBG/DNQz2NMkb8qASpPwt+/9caQV
 3G7cJRndNEXFqfdOA36uj6NdiLBym2qd48uqaNHElZztI1nXrgT6BpFVqv8apECX6ASt+lZoq2n
 EJILr13dqoV8EdekTnnsUHdSXO+OOpHswVIetsaqMpbMuRYbxiPlG55ZgVui4EktBI59fQy6ct6
 IxUF+BfY8GeRqQERkfqg6Da4fH+WTy3T8qbVL9UKMk0L9bEgEnxFjNNZ/H7QZJd73V3IYqz29F7
 Ds+lIH67syWVWVws0dF/5j8ZVjIuv8ElD7rsBRKKukS5eW34KEjjLVAekSs0KXn+RXR/UIyFLmk
 st/YmQ/spfHBlgSL04t7mK3JUFNRCpDxMDFuUA7GVRw07CKSg8V7+aB6OIB+d19lERgMQ1oS2Qi
 CMM8HYKlnqDKXjLw/93qCc6mdl10mX3Sn0ZKk/6Axvg4ufEFKQwbd9EOWwEyw2fBbi+VKr9ibKK
 yqV1S/FNMxA3LG1CLTfUr0BNtdnm5x2Vb2iSBUcblRHGz0NkR8=
X-Received: by 2002:a05:6870:3182:b0:417:685e:3748 with SMTP id
 586e51a60fabf-43a2d7b9058mr13279492fac.0.1779198960380; 
 Tue, 19 May 2026 06:56:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a957639b2sm7058694fac.14.2026.05.19.06.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:55:59 -0700 (PDT)
Date: Tue, 19 May 2026 07:55:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 0/9] fs: add change date to ls output
Message-ID: <20260519135556.GX1858239@bill-the-cat>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518181553.GU1858239@bill-the-cat>
 <aebdf20c-c93a-4711-8ea8-2b92334714bc@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6yiov/VBg8GGtcD+"
Content-Disposition: inline
In-Reply-To: <aebdf20c-c93a-4711-8ea8-2b92334714bc@canonical.com>
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


--6yiov/VBg8GGtcD+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 09:25:37AM +0200, Heinrich Schuchardt wrote:
> On 5/18/26 20:15, Tom Rini wrote:
> > On Mon, May 18, 2026 at 07:57:19AM +0200, Heinrich Schuchardt wrote:
> >=20
> > > The ls command currently only displays the size and name of files and
> > > directories.
> > >=20
> > > * Add the change date to the output on FAT and ext2/3/4.
> > > * Use the actual date when updating the change date in ext2/3/4
> > >    file-systems.
> >=20
> > What's the motivation for this change, and how much of a size impact
> > does this have in general?
> >=20
>=20
> For qemu_arm64_defconfig fs/fs.o shows a growth of 260 bytes in .text and
> .data sections.

OK, can you please use something like
https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-b=
oot-size-test.sh?ref_type=3Dheads
for the whole board?

> Change times let users immediately spot which files were modified most
> recently (kernel images, device trees).
>=20
> If a device stops booting, seeing a file=E2=80=99s change date helps dete=
rmine
> whether a recent change could be the cause.

Yes, that is useful and more user friendly than hashing a file. But I do
worry about global size growth.

--=20
Tom

--6yiov/VBg8GGtcD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagxr5QAKCRAr4qD1Cr/k
CvOTAQDvzng/P1d539wOJvnf7WoIM+Lt/y+SFSuc7GiqtRGbDwEAjqkyjbWh6gxj
FQKb6J9Iq46vS4YM40o0+NBfCeydcQI=
=rC3d
-----END PGP SIGNATURE-----

--6yiov/VBg8GGtcD+--
