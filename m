Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DD4EE14C3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3914A869BB;
	Thu,  7 Sep 2023 03:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OF51lDDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B14D986998; Thu,  7 Sep 2023 03:53:02 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0657686989
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d7d15e6884dso424240276.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051579; x=1694656379; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xm0EBUCMp0wd1q68f6MnXhbpTemXlLYTrUIrXuY+iM4=;
 b=OF51lDDRK+z7IpTIJuQNLkYzSrb7HRO5z6WEUsX2jViJIe0KlJyUZKAdr8x0ZiXhBw
 FFn/b4Y0t755MJPOXCNz2VGvyfDRajMCFYCQDGj5Trrpdghr0DPpm2sVLktjhejobGjW
 nq3aDWL/lPB/yrAqO7Y/6UfRq/ZOcqyTuH7R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051579; x=1694656379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xm0EBUCMp0wd1q68f6MnXhbpTemXlLYTrUIrXuY+iM4=;
 b=ORRsXTjfe3Ual4QIxP1iYNuxQzD+xQImo0BNNnV/hEL1bC+tXocG67ZPcfRd1j2VR9
 zOfs5GTT88Jk0Rz7UXkdIZWUC0ZS9WLx3EpdIQ181uMIpD7wlt5FOocz6nebAGxAI/gk
 tAjV5sjNb+lEK1VMPqwk1A23V903/2aFrygPOMQTxbj7wgitRR5P2QhbkMQuQrZaFVz6
 E08vrni9bmY5re49tjrUTnqABrM6UUIMe0MxI5CvppfKAYuE7wK00dauo/Th89qcKhNK
 n0cSVHQOLn7EklfHJC1VhqiAmcu0BCbXvFpkAikmXACUq8J7iLxDB6mCeBBnAxslMRLT
 YBVg==
X-Gm-Message-State: AOJu0YxE4DnTfEqRam1o1Iq9iUozJ6YnCD9cKKhZsb8Y2HyK+Nt3hyNU
 OwHcN5wV4ASLoFVSTRqOWDn7FoRPYcXALeYqOwZ1Gw==
X-Google-Smtp-Source: AGHT+IGoPkHpU4Vhm/GBX48GMXKFpUXwciXTaqKTsHpGUiaWS/a/U32vdBQzB/6JnQlMCJDCuWUJvA==
X-Received: by 2002:a25:778b:0:b0:d7a:c527:38cd with SMTP id
 s133-20020a25778b000000b00d7ac52738cdmr17542645ybc.63.1694051578814; 
 Wed, 06 Sep 2023 18:52:58 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 n205-20020a25d6d6000000b00d7481ed7e45sm3595933ybg.56.2023.09.06.18.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:52:58 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:52:56 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Mario Six <mario.six@gdsys.cc>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] configs: sandbox64: Enable legacy image format support
Message-ID: <20230907015256.GO305624@bill-the-cat>
References: <20230823001712.266249-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o8XNy3sgNUXmPPkb"
Content-Disposition: inline
In-Reply-To: <20230823001712.266249-1-marek.vasut+renesas@mailbox.org>
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


--o8XNy3sgNUXmPPkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:17:12AM +0200, Marek Vasut wrote:

> Align the sandbox64 defconfig with sandbox defconfig. Enable missing
> legacy image format support. This fixes ut_bootstd_bootflow_cmd_menu
> test.
>=20
> Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--o8XNy3sgNUXmPPkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LPgACgkQFHw5/5Y0
tyyepQv/clb9dVhnDKqQzlYfN08Wz+XcdQ4IB8N3CyRgHkhUYdsEQnC/7t8xK2eV
Yir2N5lqWjgnZctD3P+TK/952YJ97TKnLdYH+aArm2bQVh9YHppk1jBRvuoskwLK
RNg5AvoIPLgs3Dqe2/fTkB7r+xQpf1ffdbnbNxVIW/6s6UCTio78iRK55R1J2xOa
SEV/7PPbw1loDC8HXVJYrpXC1qzIZcAVLsa0BnfbDKZQ8TMAs7qzAv2ZWVYXMIiZ
BR/rA/tz+Yg3QJgN+vod07WCZdFRdf5ZSy+NymmokWmbRIkTFPG985Dc5Y5o/fni
gcLfoCm3xeMmYulf5c6PyAiCItYLpIb0MEnc4zQqQL6k3n+PnIOlwR4t0m46R9sc
qPMrVcC1AZTYX6ifeQgL6rGdD5vw/BjkReZB8GEXbkdgFWX0xzYn9/tsSeN4bSdW
mktlyyRdIpTj74Kfz/zeThTVz9PsgAk3GD80feFN3OJgveeNYtb6WOagg9t+pgK7
mDqV6QWF
=gMkv
-----END PGP SIGNATURE-----

--o8XNy3sgNUXmPPkb--
