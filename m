Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C827C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 17:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1588F88863;
	Mon, 15 Jul 2024 19:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mAIebhSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C30A5885EE; Mon, 15 Jul 2024 19:32:27 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8809887E6
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 19:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5c46c8b0defso2477287eaf.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 10:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721064744; x=1721669544; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2/+EiMht0xBRcfmy6ZED1m2xlf+8IQRWhTe9DveeXKY=;
 b=mAIebhSBor80Wrbtapp0jpAMHhaXRqGlYirlq25jUNHDk24/6TMgvxQshTTsh+rtjA
 yVHb7u2QwaihuLCwwaG4EdvJbfmCQvwn1AHOOQo/Pqt4Q9dgA0SBa2Lgw0P9/iETGg0l
 jfsK42m6IQF4I5tdA/+62eH+kGUSbieohRfFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721064744; x=1721669544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/+EiMht0xBRcfmy6ZED1m2xlf+8IQRWhTe9DveeXKY=;
 b=hwZlVdvyR3G1jbiucAeLB+xkOWH0eqmlwtvgc7sWgbiFa80Hzw1RTFPFS0fLFWGVsq
 EFLrY1/EC4K2j8tCustkytX5mzzolE6MKnKMx5HNkyUgrtcpyBw5hFW7Wi3cMCQGK83D
 nScYi2osOBy/7JYMLxL4v5bD54A3xizSyIqH6B43lZTB5+6inH6tWQU3E7BmXM7AkuS3
 ttPZLA0orJZ0Nsqgh2Lp+x4pQclzdGOxrXPotxnHgKP972fj93HGnuDuwa5+/LzyWun0
 FPr+y2LZL3GGCTzANmCclQlUTo5WejZ7KDycBftlKiAruYK+ygvV8LTSDw5lmgi5zLzb
 HARw==
X-Gm-Message-State: AOJu0YySLencrsoLOp1TlPjZYKLWhbf1ZZ5cjMOC0CCjOL42y+uwP5jq
 ROhkAzgsQqc/lKOl5TMvEDDTQ5D295V1pzCaLTWN91nMGAUnwIJiHi4EFQUWOPPRWukoEC4Gnmp
 k
X-Google-Smtp-Source: AGHT+IHojzV3BXs3Fo0suLvZCkFYbCJE04NxaXFdjOqULHaGgEOgbc6Sha36DmaTedYin/pzp285UQ==
X-Received: by 2002:a05:6820:2612:b0:5c6:60d9:b0e1 with SMTP id
 006d021491bc7-5d2535c842amr314347eaf.2.1721064744411; 
 Mon, 15 Jul 2024 10:32:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce76ff8accsm833410eaf.30.2024.07.15.10.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 10:32:23 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:32:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20240715173222.GK38804@bill-the-cat>
References: <412c7fd9-1495-447b-98c3-a0136950182c@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BY+5S8YfO83I/SvZ"
Content-Disposition: inline
In-Reply-To: <412c7fd9-1495-447b-98c3-a0136950182c@denx.de>
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


--BY+5S8YfO83I/SvZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:59:03PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this small batch of Marvell related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--BY+5S8YfO83I/SvZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaVXSUACgkQFHw5/5Y0
tyyauwwAqx6KxkgwD1u5rk/GwaHOcmF5R2gnoIoWL2zIrzFvWb16JomgG9UFBBTe
VTvd0SxHBkrcnaEjrAPccvqgEnfkZNd5GocZrk0j8T62zuz4gg06tHxXrTW2RVQk
VobQ4j8CRV/yT4z76APU8U5nx7Wydl5nOSgvy4lHmNkNRc1zkaOpMepdAr6mdcbk
2GZEtCTcUAKeISLGvn8ma9WI20+501Ulgvcgk2NC7n84SdjPSRW6Lp9RMhyFj5ba
CrIxWBsIcA2gOUCmoP/uI0FZus4Aa8O7/htgpoReR1h5Lh13/cYeKcDu0TfOIL94
sZaPyJkpJ1j2OdxZuJJXBH64sHn+d+4+suPeTSzfcfCxR6/kiet5J6KVFIDlsEBb
A9D7khJLeIueoAs7ffV7PBteywTNmL4kfjDvD655kZSjGVSVkGR8MHsF55D0UPKc
/OmxOSaVtLVSM8EDXq75cLtWvSttF5mCDaNTwXfhe2Z5dORYTcuXgnrrBpvJm9fh
e+bDhjgX
=3NHM
-----END PGP SIGNATURE-----

--BY+5S8YfO83I/SvZ--
