Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFA6C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1359E87C3C;
	Fri, 15 Dec 2023 23:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ckUMeu2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAEE87C12; Fri, 15 Dec 2023 23:48:27 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 733C787C3C
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77f48aef0a5so66070585a.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680504; x=1703285304; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=90wNzGxuiPiXXL7CPc9eK4W3GFIqcFN26rN/ZpXSDt4=;
 b=ckUMeu2hqgDiFUz/3343GYGJC+DmkTis4ca8E2eEeBRLSDsneGkbw2ROjGP+CLpIDQ
 PccS6mr9uccDdfqX4cNmD19SbSJH/5eCCRfXw8uL3GqmQmxPMTEshNHsPi6FJfRo+BLV
 /Qv8sC0aAK1uIL1UXglvXOYhXGd7kmAWvtkY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680504; x=1703285304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90wNzGxuiPiXXL7CPc9eK4W3GFIqcFN26rN/ZpXSDt4=;
 b=OfQqJMgk8Pvtk7MUUfbgV4hCCk5IlxWlbDHdvrCr3u/yPw0Lu8UhsBO6gSKtdzrnoM
 bC2GlpPc4DwBxtytgPkyKop1rKPrsvFZ8MG2t8RbUUPHCE/6FlU7HIjEFp1ITFilJV9V
 uk8FKFl69hwY3Ajhu9nou1Df6gNV0TriWoF6KHDubLaW8voWmS+IZ0E53F3uxTXNAPsM
 II8AESnc5VO5EP6ZhFtUMbkUt3xaWVZNm4kQHFLcSf4kWzNN1kFo9MYw0fzzgGlu8CVI
 44eq0TCORCRqQ7AMDqSY/m6DpFw4BZ4K2N+4lAU+1V0eJSPOW/LktxYN52a+L/z3Zl3R
 7NbA==
X-Gm-Message-State: AOJu0Yx5r+SEt/VRrDlhqJjcADukrpqTiYOmyArW2QjtqiSB9qi/VmdC
 5k/uoQBnZeyvxLsAbPToNTJIpA==
X-Google-Smtp-Source: AGHT+IFBoYdPyWt31tOrD7Y0lRj3Nymr/tVeh1/528q0kG6xhQ1ozV+sgpbi8cqNbSWk9TkcCDC9nw==
X-Received: by 2002:a05:620a:880f:b0:77d:85cd:fa6b with SMTP id
 qj15-20020a05620a880f00b0077d85cdfa6bmr10868529qkn.78.1702680504252; 
 Fri, 15 Dec 2023 14:48:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a05620a110c00b0077f249608besm6378308qkk.53.2023.12.15.14.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:48:23 -0800 (PST)
Date: Fri, 15 Dec 2023 17:48:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Vishal Mahaveer <vishalm@ti.com>
Cc: u-boot@lists.denx.de, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH 1/4] board: ti: am62x/am62ax: Formatting updates to board
 config files
Message-ID: <20231215224822.GH2513409@bill-the-cat>
References: <20231128194024.20809-1-vishalm@ti.com>
 <20231128194024.20809-2-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mDIW201WiDCGr4Kg"
Content-Disposition: inline
In-Reply-To: <20231128194024.20809-2-vishalm@ti.com>
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


--mDIW201WiDCGr4Kg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 01:40:21PM -0600, Vishal Mahaveer wrote:

> Minor formatting updates to the rm board configuration file for
> am62x and am62ax boards.
>=20
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--mDIW201WiDCGr4Kg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV817UACgkQFHw5/5Y0
tywiowwAknzPwhGf7XEQGq1vREROQPjD9AqPdpOe86OaVlznuemrVVZxBgeNK/hO
u3A7Fad9RP/2F1Bg8NSHOc4BkXL1ET1kb8ZZfpf64YneS++UoCt0NobCaE3+6J03
PVvFMPjrk7eOK0KVrSTlHvqogi9LUpeRLIVhmTolg3VphkPr4R517t9sArCAzwDV
JW2VSx9wzNlXkj1W3vd+d5N/hPKcPL7hE/Yq/kmghfqlOfzvvZXpWzmWyLg3tr2w
fzSN74S7Wj58nd+WjJW0Uu8lzaNtt6gk23cWMtglBcGGDSUvoxcAtn9zT/mRFHSG
lmrNMq0jov/yWlH7e+ikWkKPf7ofpGKbuBxF2c36DzqNYn1ZpidTc/1uVsyIfAUH
NAYBP1YyB6hfJKRFxG3fSqGTZY20oM1QNJ9HSwyF82Dj0059t4xZSH1Vj8EgZkzr
ir7xcLjHnsz1YVtHDtRjltB4AgVv2MDzzC1vkbi9vEiiuoUDIG1wpp9fkp4DGHPv
T90gHFC9
=yJAA
-----END PGP SIGNATURE-----

--mDIW201WiDCGr4Kg--
