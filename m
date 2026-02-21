Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28CBC61DE5
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 16:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA8983936;
	Sat, 21 Feb 2026 17:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sf92EdNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156EF83936; Sat, 21 Feb 2026 17:46:05 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 497C1801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-463a0e14abfso2004019b6e.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771692360; x=1772297160; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8mqnzUvGKa22CbTU7IHeFEkGYhFOdbjdrYpIFJjpEiw=;
 b=sf92EdNpVZNUxY0cEpOEqkPKGb7v8x7xzw5w8i5yD32GyXrO5MjNSHCAAjfICD/Emd
 U1ftxCUOLTIeJcir7tgu47lwD8YPF+wtjwHhXlKtd6+VI3fbscaTHEipJ+kq/gI6Eljv
 QUynb34V6Opx/ORWXWm9PzDphLN2JEmgYEVrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771692360; x=1772297160;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mqnzUvGKa22CbTU7IHeFEkGYhFOdbjdrYpIFJjpEiw=;
 b=iYHWEq771Yh/h2pN4pjMxDTUVMK5Med/f62EPINgUwF0llqP8b2llwzFxNNyQK1t9z
 7iYqXgCMtcYvKOTGMaTTY3nOeH3fMXHvqrnfwhrMOHhinZsfLxjypfLrh1n2CL0uzeT6
 82ZQu/hG7V/XHhg1/uLz+UsCUCD4ugCmH/ejmSdCa3QOjCMPo6PvYV3SNiF6RgqTKbUy
 YsaJmMwp8JAhO9LKUaLNAHukk129hsaZclf5HT3/3B7a2RE8omP+5nGXTSx7QaE64kJ1
 SKcld5dikvDNgF7FYsIQfA8iEXC5+KBCvzOiIqJNXFPeNSQGPEdMaE0HpmTxxvPzZSXG
 iijw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGxpxYQahE0aVoSMK1RWkNLEtf7ldR8c1ccznT58LCx3W4ax8wi0Qw5cir6x6vAuyh5z3ZX9M=@lists.denx.de
X-Gm-Message-State: AOJu0YzcGY2+H7ltbZEDjNAv8joaORXsikgVh8/5EF0HLK0NBjl3PdQr
 7QNHdBzI8zFQOyr7aW5fpFZ0v8gAgKpPeHTJr7WGIj6F9pAm76Uk0HMnZbiwPvazInI=
X-Gm-Gg: AZuq6aKrKtSCnnM4DlQ1Zfb2XLQ7aO4EGz+e4uQ6gv01Zn3xyB4LXUjvlDkpWxUQdTc
 g4DgaSsAitIiA8mHEJG3vnWG6yygp57qv5HNlPDM7fIOZD2+4vmSHyVsEXJBEFYuN4lhaFm3iVN
 mhht/EosYsUBbhBeG+LTMBuvHnAfnieruwL3V9VgIETbv/AdSx2FK69OwygA0ai8W/pzcuoaOMk
 5zfaPRNt8/NCJsk24ZMubwSkBdG2+0mNITuDbSFN90gZfwZJwdmzJYV2wHvHxHbMislS13e4KDc
 ws8FElrTV/Z+loIjrnnM2h95MQg3OYh0uKrmRHFNLmSpiRwFuMKO4d7Pfl7dElvHIhfC5BwEAOL
 1UNG+R/fLOqu8jsjSZFEKuG3CQSgutLluf8dmnmR/5bR5TYL7KdczOuXSrp33vFs9ITbZYmjvES
 Kp3SGYVVuRuWzU/CJNzd6t47mZbVCC/8Li0XmiNg7f+MF1P9lUDFHP7KJLUOGhkEJ5IeU6+v8ma
 e+YD+poERkkEhpUNc3vnojYfiB76C0weCZBgAxSbqEQPKxQu10=
X-Received: by 2002:a05:6808:c115:b0:45c:a040:e53c with SMTP id
 5614622812f47-46446332bd4mr2212281b6e.32.1771692360077; 
 Sat, 21 Feb 2026 08:46:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e152sm2924655fac.2.2026.02.21.08.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 08:45:59 -0800 (PST)
Date: Sat, 21 Feb 2026 10:45:56 -0600
From: Tom Rini <trini@konsulko.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com,
 kabel@kernel.org, vladimir.oltean@nxp.com, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/4] dt-bindings: net: airoha,en8811h: deprecate
 pnswap-rx and pnswap-tx
Message-ID: <20260221164556.GZ3233182@bill-the-cat>
References: <20260221163114.87553-1-lucienzx159@gmail.com>
 <20260221163114.87553-4-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j1uJ7s8pmSbPfy87"
Content-Disposition: inline
In-Reply-To: <20260221163114.87553-4-lucienzx159@gmail.com>
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


--j1uJ7s8pmSbPfy87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 12:31:13AM +0800, Lucien.Jheng wrote:

> Deprecate the proprietary airoha,pnswap-rx and airoha,pnswap-tx boolean
> properties in favour of the standard rx-polarity and tx-polarity
> properties defined in phy-common-props.yaml.
>=20
> Update the example to use rx-polarity with the PHY_POL_INVERT constant.
>=20
> Link: https://git.kernel.org/linus/44f62aa1b1209232cedcfb39097fc1bfbe75bb=
c7
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>

And for clarity, my comment about cherry-pick also applies here. The
script tools/update-subtree.sh makes doing the cherry-picks
straighforward.

--=20
Tom

--j1uJ7s8pmSbPfy87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZnhRAAKCRAr4qD1Cr/k
CsdEAQCL5NZPEC9P02V6JYNP6/LwESafiNq0xWjGLPtb8h5/bQD/auWjG+bE3p0A
TN6TNRAa9U769h37j66xT3lhVsKfDQg=
=GgBw
-----END PGP SIGNATURE-----

--j1uJ7s8pmSbPfy87--
