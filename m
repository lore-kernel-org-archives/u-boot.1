Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EC2C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FC2D87FE3;
	Mon,  4 Mar 2024 16:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k7aa/Cmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CA6D87FD2; Mon,  4 Mar 2024 16:26:43 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 036EC87FD1
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78822adc835so71144185a.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566000; x=1710170800; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xhvpjvioIsD9nPkiCflMZ277Z3Inmq/Oz7R1S5adqXU=;
 b=k7aa/Cmk41BT/v2ZmCejUqq6B+mS5t4rQ6uhu8mrNj0GzOL85UBsUReIot82h7b8ew
 iza9mPeTkjHS7+VmKMH7uE8rajRYWLLnn0EUsKCYHlIJt5+TXAekRgE2IwVgdTg9pZ23
 KHUzRnA8sXcsrfY6HRWTclLethIJFqqW1gWdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566000; x=1710170800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhvpjvioIsD9nPkiCflMZ277Z3Inmq/Oz7R1S5adqXU=;
 b=HWkUD3hFoX2/It+KluQMx4B7G+jfyx7rrNIZjWgHGYkid4JrGtXz5fPGOtKbYpgk+7
 S0Tl+5QZEF1UAXs38cJmEwP15fVCCi35B9Yubigwu59s3WEojdnT9eRXS4EXq05f3qRI
 YGnZZ0eOfdx9qA640omOFTRhlllXj0Mo9txWPn441PHRxsMZhRFWt/EvQQPswcAtl5pU
 dQFvl6faXJNI1jZ0UbIdBniAYUQoIbgxI85EDL6thWnKDWpcZqs/25FxvCw2GBe9NV7a
 +/X8AmcaWYpyt0U2jNyPhTDFhiY/H5LCB6YpmsUDbIMweQLtlcsUA8i20LycdZvosrhx
 QvAg==
X-Gm-Message-State: AOJu0Yyt3/1V9YlTFjpJsufpjvxr7lexR+2F+M24C5+tk3+24FWoKhzj
 RMg4gLy/CKQG/Q8wW2NR67zIBwDWai+NkyU3vAgy9H3e6vWZ2WttgKjqBiDERsl2NiQjMfIL3IL
 K
X-Google-Smtp-Source: AGHT+IG4lwXTeh4lmtJs4L0M790BJtcT6dWsQKyTQ6iGAHZjsw2BngEZMLvXbSXTn7ppRe0v0GhDqA==
X-Received: by 2002:a0c:fdec:0:b0:68f:2b9b:2809 with SMTP id
 m12-20020a0cfdec000000b0068f2b9b2809mr8669243qvu.54.1709565999764; 
 Mon, 04 Mar 2024 07:26:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 lu19-20020a0562145a1300b0068fbc383a80sm5119971qvb.108.2024.03.04.07.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:26:39 -0800 (PST)
Date: Mon, 4 Mar 2024 10:26:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <linux@fw-web.de>,
 Dong Huang <dong.huang@mediatek.com>
Subject: Re: [PATCH 01/60] arm: dts: mt7988-sd-rfb: add SD pin driving settings
Message-ID: <20240304152637.GI1523872@bill-the-cat>
References: <20240122020754.143309-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H/O1OvgK5+t0TOwi"
Content-Disposition: inline
In-Reply-To: <20240122020754.143309-1-weijie.gao@mediatek.com>
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


--H/O1OvgK5+t0TOwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 10:07:54AM +0800, Weijie Gao wrote:

> Set SD pin driving to 4mA
>=20
> Signed-off-by: Dong Huang <dong.huang@mediatek.com>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Applied to u-boot/next, thanks!

--=20
Tom

--H/O1OvgK5+t0TOwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6C0ACgkQFHw5/5Y0
tyy3bAv/XPr3d5UkVp2qmc5/7rv85vXrKzmeu9FmBRuNdbirfw+pM0GWDBYX4McD
ibyIjQYH5GLtlKGNCFoC7ePN95yrY7Fa9jhYZ2gvRkJwfP3v9aU+R6iP51PwaetV
imF9nVYTqkMI9L+hfMKQSP3FVElLRvQPmKROfTXbe6F2XGHSwejPPtGkcofFeD28
eqCSJkpOGc/6KOjOvlhCjcXd9q+SWPPTNxRIIccA3FQc1ncGHnyGirsHlNwkJEd8
SzL05gFai8KpXLZViLAOrl2sUhjsj5dOTQ0Y8euTWxebeq79OJeYVfrvmpT8THZS
FsJUyF6C55Y7kbSKxtgF+olBfNJMQkSk4Nnc74Gt+BGk1uRa7QNC7YiDRBho+GTR
vc8jXy9gsGdD1orv51T2BBkl9RK5DE2JdA1eiVVc976H0upE3DGxs6No/CC3GDuk
KIk/fW5/okYAYbaXNGouT6j5niHUnxwhfTgkdPp4EwBwgJ6+3gIFVWAubV3rk6WO
THEatepZ
=HPbJ
-----END PGP SIGNATURE-----

--H/O1OvgK5+t0TOwi--
