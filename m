Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218A0D13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 18:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 561FF8860B;
	Sun, 27 Oct 2024 19:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lyoc1B0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351F1887D1; Sun, 27 Oct 2024 19:31:59 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5514388278
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 19:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b15467f383so270369085a.3
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730053914; x=1730658714; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KFEBn6/Q6upMXAa5qzvZAgg31lMmquRR/BMZJyngbVo=;
 b=Lyoc1B0o+MqzJoI/lBjh7t6Ct5Sf5+dnyoz5bsou0JXhiNyjnMFxqbVQEeZXiAlnhb
 8X4no2JCpoW45V4XgZQbVkau9QDSxBQZOWHEusGHj7v9cbqbsePcGfxZIQaeZuFXn3cC
 RBLmSxQ6UJq1G1q0oh0vtCi/Lu13MEz9tnDGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730053914; x=1730658714;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFEBn6/Q6upMXAa5qzvZAgg31lMmquRR/BMZJyngbVo=;
 b=Q48wEqgeMFzsTiGZDnf2JjLe1xnn/e1wUC7Tf2xtzGFBbrkSAZwUvzsiIAOQGyJq99
 +ktwbp8WqLOZ/xIB40xqesIb3D6bR9HDg9yptZUyHcod2PxBv+jUezWLBtqSFPRmffwt
 /C1aPbsSsPebip6a58IG4Jb8O8CgPjrM8Ph/+LExFJ9sV3yNjjuKC5Gsa8TqAWLmoYVT
 ipbp3RkkouwEVDTnSmRmR9tCDVqF2kYAm9/D3haKPwC6sRf4E7HdescswgcNT13Bfa93
 Prg1OJsYgS1DaLaC237Wlk4bkfMFBS4GroxGhvdfZTCp85pqs8YmmpXcVRVofJa1z7Gy
 7bzg==
X-Gm-Message-State: AOJu0YyzIKS4WCgWcbgC7pY1LO/dCt5PIuZPZwyIZd6KARwV6u12LIXi
 5P0GFZpHBF7xxGqMsbaUKEXEzZYpBgSpp/mqje9IDws588bBIC2SeXCcbq59PCY=
X-Google-Smtp-Source: AGHT+IFhdn9EwK9BWHRTjNuNnxjX4+ZBwniB4UnbQxMycXX/3ZzeJafimJLVV9mA3LF6Q6CH1xMbMg==
X-Received: by 2002:a05:620a:4607:b0:7b1:54f6:d1dc with SMTP id
 af79cd13be357-7b193ed72e3mr1205615385a.4.1730053914239; 
 Sun, 27 Oct 2024 11:31:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d359eeesm252245985a.128.2024.10.27.11.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 11:31:53 -0700 (PDT)
Date: Sun, 27 Oct 2024 12:31:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Gothe <markus.gothe@genexis.eu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH] Bitbanging MDIO driver for DM framework.
Message-ID: <20241027183150.GK4959@bill-the-cat>
References: <d7d1e0ca-f0cf-4458-a52d-0e8ba1b85bdb@genexis.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k3gnAn8E2NCG7xGh"
Content-Disposition: inline
In-Reply-To: <d7d1e0ca-f0cf-4458-a52d-0e8ba1b85bdb@genexis.eu>
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


--k3gnAn8E2NCG7xGh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 04:47:38PM +0000, Markus Gothe wrote:

> Linux DTS compatible MDIO bitbanging driver.
> Both clause 22 and clause 45 MDIO supported and validated.
>=20
> Heavily based on the Linux drivers (more or less the same code base).
>=20
> Signed-off-by: Markus Gothe <markus.gothe@genexis.eu>

Unfortunately the whitespace in this patch was totally broken when
posting and cannot easily be applied. Can you please retry? Thanks.

--=20
Tom

--k3gnAn8E2NCG7xGh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcehxIACgkQFHw5/5Y0
tywCSgwArU6wfJQNdY+iz++nOaBdjPKgfaFJuaRBd1MNeO5oecdLm/IN7F7Hpte9
sywETfZMy2CrgFvlK+uSKLRtyyM5QB81usNvrHxLEwYSwz67W+psH30M2hFuROTF
zU4lsFiI2h+QZuyfD7WjZRLICfG9CpRbNf3iOJKWk2ldaSf1h0ozEGtTLM/i60Rk
6aZqFCV5Enbq+f38UX9ioAPmeGdVef077HUSgFrZcrx4P48ekOlwE6fQpnX5hk4n
nv1siklnzg4GlgdI4kfBKyhVawDpHdC5obqXw7JQPMc4A6sZtSBgW+lFJkXlQ+C9
Wr5bo21cLVKeooj+pMsZmCXbv30OoCdqYQ0NJMvhmaHX7/M6DorgL4PDDfsVtdsk
brR/orraL8nuB9sMLdAP9jUUvV6Gi9v2YnphZ56aO9Ahs474zqGgeqjlbPClKQ+c
ktgDJFPQmynZyDPqn6NqfeHSADV5Dl9YYKRzuKWGR+yztzO2m4NnYZj69otuYDkf
Z22mCTwM
=1Ymb
-----END PGP SIGNATURE-----

--k3gnAn8E2NCG7xGh--
