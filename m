Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99D0C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 18:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC5A8778C;
	Mon,  4 Dec 2023 19:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qAqkSP6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E22CD87600; Mon,  4 Dec 2023 19:49:07 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0BD8766C
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 19:49:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5d7692542beso21574617b3.3
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 10:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701715743; x=1702320543; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qJxjGjt/AL4Cfed3w1CDnhCnGjhsGoiO2kB1xBRBo0s=;
 b=qAqkSP6L+Y/MbK4V2zzbD9e7B/PidfCxXnHALEOyvatePaheYi9QgUZZCUStm/MLa2
 NXf8OUn5gy58b9Cd1nPZp7ghkQqGPr81Qwwt1Jr/TYCJiNl3i2f9LDN1Xy0QckkMmuI9
 a72dyoDbEes6h8UdBUyYdWhjOOVfVE8NMUhfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701715743; x=1702320543;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJxjGjt/AL4Cfed3w1CDnhCnGjhsGoiO2kB1xBRBo0s=;
 b=eccV9Vlexrm8Lxi6IvhdhfAJ2urvf6kzr/ivKCMTP1t5NNH1fj4zpZ/HNdavZeIfyK
 5Cxrob53ljxzSfxzgfbbv/msTie2h8xH/PonCD4+Wl+ZtwV2ciGMNlVZZnC6bL7S5fVu
 IsRtP4CwjPGCUuR9JEgkWlgSuWDBaGyuUJsXhrKzvswCWl5uy+m8WB7JQL6KgQzZMJmN
 dGdj1WX6ZxcK3V/k/uqq4mgBSKPPzwcek77RrM00uuUx22aeHFjM9xQieEeOYr4m6+IZ
 +8aAafYZ6d4PctBtHLsfJ2Un2dA4ROM8OpjcfTVv+iplDrXYIsrGVqaq5TToZqS6kWMz
 pc3Q==
X-Gm-Message-State: AOJu0YxgQ/3bVyIVo4fpqQMsHwRDYmwUgN2VwqYhuSf2G+U0BTmG0Pdo
 thGclXR2yAE0Xw4WgEHWuKz/MmDsflbG2KCODz+xh/Nj
X-Google-Smtp-Source: AGHT+IGEPVJZlHaHoEmPfEvJIbMHOrIw8utoFMF6UDIG8UALK6Jq+TFTSCqBtKlicV9XyCVe6XkuYQ==
X-Received: by 2002:a81:af09:0:b0:5d7:1940:53cf with SMTP id
 n9-20020a81af09000000b005d7194053cfmr3549596ywh.71.1701715742743; 
 Mon, 04 Dec 2023 10:49:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38a8-7605-2d5e-44b8.res6.spectrum.com.
 [2603:6081:7b00:6400:38a8:7605:2d5e:44b8])
 by smtp.gmail.com with ESMTPSA id
 z83-20020a814c56000000b005d3c950160csm3141383ywa.4.2023.12.04.10.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 10:49:02 -0800 (PST)
Date: Mon, 4 Dec 2023 13:49:00 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.01-rc4 released
Message-ID: <20231204184900.GX2513409@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kwL91zqUZpGMjltl"
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


--kwL91zqUZpGMjltl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc4. There's just a few fixes I know of
outstanding at this point, and only one of them (NAND for AM335x
platforms) I think isn't something that can be said to be provably
correct, to try and borrow mathematical terms.

In terms of a changelog,=20
git log --merges v2024.01-rc3..v2024.01-rc4
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on January 8th, 2024.  Thanks all!

--=20
Tom

--kwL91zqUZpGMjltl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVuHxwACgkQFHw5/5Y0
tyxDgwv9FlRSixH9/s0CoLGE3DqVY5qu6O8AmLzAPTVfwX01Stgnd8tmoQieN6Oh
jSecFayX6Pgv2RTVCWvLoRsXwCR06vuZuhP2iFadkByF89FzVXuAy7GbrFnkC30e
LAFQdVaYVpxXluXEUnZ0AAJpGdCJVnHbWgiEqNnK5oo1Ni4ymyIAu9LtkrSh0q/z
s90m67X1PKPTvxuTqovit7jzWqR7Cr1ymt5thV1P4IfklKBY04fO8WqxhRQ+1uIq
VnvliOPOcwqajvYus2BuCIY1STB6DEbmC1DjM/qwMle8gBH0yGf7oi6eNknF5WIT
2ACyT2JbHtE93f1zAuVMFDBt1vWl1H2Tu7sTGDPV02elocweRvKh1qY9ZUA4VvEZ
xUXTbPWz4Qb3ybID26DtpgRrid8IIF+i8e4bv5VVzLKACR15H+0097T2l3eEukBG
BOecZUq27E/bHAZn4GLOmN/cxMpRSWpWdSC4zrsRuLmazAWUEvkJSyskttXrtJ9k
/a3Cv5M7
=u+h6
-----END PGP SIGNATURE-----

--kwL91zqUZpGMjltl--
