Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1B2C48BF6
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 02:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3F387FA5;
	Tue, 27 Feb 2024 03:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VtuUo3f9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EFF987BFD; Tue, 27 Feb 2024 03:25:27 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57D1187F6D
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 03:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dcd94fb9e4dso4077048276.2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709000721; x=1709605521; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VufDSU/qx5WGJqvicnMNt/PdXj1HsFP60F4EYkoY47Y=;
 b=VtuUo3f9qa89thrKKhZXis+bmkxDRLGAKDbKTfsQFCg/DQkRzpredMiQXXqesXqAsT
 NAMWEBlqGxsYCqfZt7RHk6Ybrq4eh/6WHdORnpyiNNZN5aLd1TMp3K/g/LpbwQ57ZoCo
 7LCo/LHUytRaG75/VXcFFySFomW3+9y82GpIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709000721; x=1709605521;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VufDSU/qx5WGJqvicnMNt/PdXj1HsFP60F4EYkoY47Y=;
 b=afG6Kres/UgxhP9pCjiYPm8WFY4L710tSQ+h2Mxdo8Y58wMb8OC8LckqGAr39CKHJd
 w9JdYWt4LaNY7KQLaLLCIR0bBSTPPX/3zLIvwmK26xjIxQ/HPKsQAhQG6HK/psnt5bRr
 pUDXbfHwEU7yI8mlP7gxoTmEmi8ADF9vdi6zl15IUi0OUWGCCNtkXvWqvRO8cazEDzIc
 8IJTmiCdsgvmAGbOTtjtotWdjggyGYa8GHXu6rY+LwC5B5qGDo4NxPsJIupAsYizSvP+
 vFGhd+ifZ0C0d8FPHIzrJExI1eM/UYaWnXiqjaX4epKiWjsNmCmxgfSi8adtb/E+QhDL
 A9Bw==
X-Gm-Message-State: AOJu0YwhE5B+mObNsDTq2CkxDJF46eYS6oMy3d/bjwX19gC/AACtnlPl
 JHEcm8mXAXBzFYA9HHEOiN4ZV8p8nKfUuGJDOqlxB5CsCXLBOxOE47vdH08ExBZTx9NzPX2zCa3
 v
X-Google-Smtp-Source: AGHT+IHYrkxEsFZQiVvG3gjA2Y8GIH3zBXtgUa2mepNon2MUx6z1eicbhcwesVCReh/GqJ5a1dISew==
X-Received: by 2002:a25:c5c8:0:b0:dcf:47b6:9155 with SMTP id
 v191-20020a25c5c8000000b00dcf47b69155mr1037705ybe.54.1709000721596; 
 Mon, 26 Feb 2024 18:25:21 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 y14-20020a25860e000000b00dcdac51bad9sm1169783ybk.49.2024.02.26.18.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 18:25:20 -0800 (PST)
Date: Mon, 26 Feb 2024 21:25:18 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.04-rc3 released
Message-ID: <20240227022518.GJ3040305@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rvipUUSNoOQRg2Gm"
Content-Disposition: inline
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


--rvipUUSNoOQRg2Gm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's late in the day, but still release day and so here's -rc3. I've
also pushed this to the next branch and that is now open.

In terms of a changelog,=20
git log --merges v2024.04-rc2..v2024.04-rc3
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to get back on schedule and that means the rest of the rcs every
other Monday, and with final release on Tuesday, April 2nd, 2024. Thanks
all!

--=20
Tom

--rvipUUSNoOQRg2Gm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXdSA4ACgkQFHw5/5Y0
tyxiCAv+KMfiW/LconySScZAKhodTm+C7ghn4YLKY7vm0003Bnh2kyAcVr+c1Gwa
FnBA+E0C1ry2lqu02LEStlibVA4z+0/otin6YmjFHb8k2wa5+M3clYn7ve6kPGtq
x+yhwW2yZIRfSmfNHlpLd9dGmW3csZYDIVgDRBhtz6oKpfjV3N0M80GQ4tV9SyIj
kIrbHCnX2vI5tYmA8O2f+W4og1o82Okcyz8f2RLGLtD4jaSNfJOcfdNsqiUKnmM1
YsjoGo9VKoPOFNzuuy6/rnthb5N2p3iJNSZXPbB92c220484gfjTkwcFJ3JLRbRp
WMeuYlyeLyOzeGVBLgHExUkxiPQF5M3O5R5pt91BymTu2W6tE0+lPRdtUh5v/uzl
TdAp/24DX/yQFcO0688663HH3fBWnU4RS5virkR/fnQHSuKimVYNMP3eIa8xln01
75n3egp5hkxgiLf7GiCZVNtiTvPnSSZk3yaOMjVb+RdDppLYVZYmEUDOeUwrNuxo
vVxiNprd
=b7tl
-----END PGP SIGNATURE-----

--rvipUUSNoOQRg2Gm--
