Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C6EF3C9AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A634283642;
	Tue, 24 Feb 2026 17:04:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ovgyAp1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0A5383981; Tue, 24 Feb 2026 17:04:44 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90AB182BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45f0c1f1b54so3640077b6e.1
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771949081; x=1772553881; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IjVHBpc2Ybnb5SYBC6NJRLVJKNfz/Q4ry/gz4XON90k=;
 b=ovgyAp1lxEwLZWD1HXLIHVi3HHZEG83HfFTLtKz+Fm1Z+fXoWaZeJpCVpZ/ls1iTLp
 9zZ8DWggASkL4eWHx+EkHbd0veJIoJeecP7NbqhVRxPDit/CEwb0tyP5DtpZAEdlNhaS
 LaRD01Wdw0yS6iop+sX2Zzf0simeBbLp7JLes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771949081; x=1772553881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjVHBpc2Ybnb5SYBC6NJRLVJKNfz/Q4ry/gz4XON90k=;
 b=FkDM3qw/jlS1wX+rCHcAPUr2WEbgDw5HiPpNBtMArp4YlnCZtSOEflBkv5Y/yI8+Ms
 iip8RuJltMv9F5C9aj41EaFDDXkZ2nN+vMnd3RwyChLLt4do1YWt5n32RpCNL6Eh/sWv
 2lPRg5ugMOk/3hyoXKbNEPTjAdpaQV8wmLnv2nr5Jxv3bILeG3o3nggxIwfeTv4UaYvu
 M0XvWkuLEu0Y0Pse74gdZ3JPf1/HK4POEo8aBUMomXhD9Whn3lBAuvKbhd9Nc87UQclO
 4pHza5PVHqGbMsBzak9iIJBd37jrDtUUIWgp5+GV4X7o0L1wSK9Z5DWXhJsSfcm3Oj6W
 5YoA==
X-Gm-Message-State: AOJu0YwS++j7YlrMnjx1bfjFPs0oNzCpT4ExQlYd8njc7IWeBoXX+lv1
 a6RMRZ+0QFpIf0luHOpfqeElqYpxsFdywEuyn9tRpmFJuSuhJwTPfDguqosq1JhsSSA=
X-Gm-Gg: AZuq6aL3tM9l2+gFT2R4Y6vdJW61Hdnl1XoaTmdUzypoaIR15CDxq3zQAbQ9AIt8qOn
 5GnJ1PiXrzg/fiNrlOwiy1vELaRiX+hM30A22CZykh86tmYsg+QYJG3Q2wPzi/Dx6qbAR0hpx5q
 xVLQu1SsUIDB3f/r5IbCI0TPwnJlHaVtH8LdX92fxnycx3jmwj3hxhBEUcdsPfwVH989aWQEp+k
 KMjswnjRHfdUAnaJ+zl2DvLVEEwcOuK6ybGJiDOBNZe5/plkQpx89ljHYMD4JNs5Yn+VyE4qMdZ
 F+0ZvhNGmv6aFnUunNLW3iW1FvEPnHX1av3CmIRlFvI6hLHO9S4tl1NDJBU3MA81PpL4wOGZELE
 GM2rUiCqd8NZhwiq+sTBuNw1fQ7BgaIJXHwcxJ+qlg5+sTj7emyC9IR5cdieTqpVxUCEvedCdPb
 qzlir831oq6O8F0x2ELS3KbwE/cZKgnoufgLse5ZBsk9JauiXWZgZ1OefcKmuY032N+RIs6f7zG
 IfhPtTikWqoRYfK37CcpUaR0SfP8FaUQlFD0DR7CzfcJyJlRS3BfwAByye1Ew==
X-Received: by 2002:a05:6808:1824:b0:459:b564:e20e with SMTP id
 5614622812f47-464463d1b79mr6915583b6e.61.1771949080683; 
 Tue, 24 Feb 2026 08:04:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cf9f666sm10122997fac.7.2026.02.24.08.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:04:40 -0800 (PST)
Date: Tue, 24 Feb 2026 10:04:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: Re: [PATCH v2 9/9] x86: Add cleanup_before_linux()
Message-ID: <20260224160437.GS3233182@bill-the-cat>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
 <20260224142553.1608883-10-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T7X1ayC2RSMplue0"
Content-Disposition: inline
In-Reply-To: <20260224142553.1608883-10-simon.glass@canonical.com>
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


--T7X1ayC2RSMplue0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 07:25:51AM -0700, Simon Glass wrote:

> This function is not present on x86, but there is an x86-specific
> version which is never called. This is a bug, meaning that APs are not
> parked before booting.
>=20
> The original weak function was added in 2012 by:
> commit f30fc4de4160 ("x86: Add a default implementation for cleanup_befor=
e_linux()")
>=20
> At later change made use of the weak function but was actually dead
> code. The Fixes tag reflects that.
>=20
> Add cleanup_before_linux(), making it call x86_cleanup_before_linux()
>=20
> Fixes: 99a573fb326f ("x86: mp: Park CPUs before running the OS")
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

We're at over 5 years since 99a573fb326f and over a decade since
f30fc4de4160 and I don't think it was ever actually called. We should
just be dropping this, not suddenly calling it.

--=20
Tom

--T7X1ayC2RSMplue0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3MFQAKCRAr4qD1Cr/k
Ch2JAP9Sl9A0XdBA6UuUhj9NWhqycJitaBgNxVOpwtsoA3RdOQD8CSowO4o6RRvS
b0fAUakPO8rLhOZ9j5PTkdzXEBHZwwc=
=0CVx
-----END PGP SIGNATURE-----

--T7X1ayC2RSMplue0--
