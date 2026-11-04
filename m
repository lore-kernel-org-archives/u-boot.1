Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4176606C91F
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s4QyP7OJ;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aCUxN/Pj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A44BA6076F;
	Wed,  4 Nov 2026 19:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PD6Q7Dp1Xlbn; Wed,  4 Nov 2026 19:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EF05C60732
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793819939;
	b=m+VfrLyTy+VAaV7KzbK8Fq5iPxQFeqvEAIA00OPi9o+UjKSgU6Aq/DxYZ8hjR5s4lZl6
	 UW1tt7tol4hg9A0eOQfpscH+oKjoJi3khX+JQJQ/2mVAj/HsRYQVLGYk5Sx/fQ+a1KW4R
	 ySNcRcE66PfIg7P/GkEiuudSYXv3dMxjuLTC1KdjIlyZfOlGhmabmESmuLktCDvVWt/Wm
	 UOGC0UQarvqldMTEOdYyfesGL5238IbBH2mHBL3vxS7waGPyfTXlIjGtrHIsfi6eSvH3I
	 iVBQGFZ7mIxguFy+c6DV7ph6iGvD4ZPN1GLsSsnF6uko/WdxpM0FL0XG8L6PZTotPkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793819939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dAb+g3Yy/cWlz6ZuTdi1urcB2Nfvr4CFRX6iqQlgFtg=;
	b=ZSTB/FpHTFmMom7bM3Hzc3Vda5yU2aOUeEMXfAqPDUqVSiBzU/LNQdvUS2jFoJ0MAP6/
	 u/vNMKNNltoTusTVCgc5PpSP/5ccsY8hgaVtKpPy7Ny107ugPfxLbiLiPM2GryFOLCT7+
	 JU4DzEnqvEIKdE81yLdKIAXbvYfNWQEUyQK5uKxAS+HdSSaClB7bvVg8clUQEAL13OMtd
	 tKIJMcT1T48eMsSnwuh5j0vFJgv7Gegdh+HhRjS0NQHWFLK8Snw0RMEhRmpDTtdacjOxF
	 MVFTe9wnexGKSrxWy3bLZR6vaQaOssOBwoIB2ZJ23H7iBICevV2O2Lb2WwxrFrYXzkA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793819939;
	bh=dAb+g3Yy/cWlz6ZuTdi1urcB2Nfvr4CFRX6iqQlgFtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s4QyP7OJfoUK9gLKu/mGhRaJozzc0FUhMva5z0QqQHUmNNTDNoSb26Gpxi1em3yjk
	 K76/asmbweA00JzscWp+SfPuz4HBtajJnAPS3LXe9TJP4BuLH0stJs6Z1C7yz9UE/k
	 LovD+bmJJXOK+3yQIqQVdhYmk8oL95Odlw0hk2cBHgVNiHi7jCpvKluuwyAzvMXHr3
	 f3v56ESj4e5B8thgvwandEuhJOlGhGKXI06lEE3nRrHrE2+AiyOVY/sBJHAw9525pg
	 nbNBn+jChmUyk5LxuGaUQ64InuzM4W6NIcC+micqW9XRcOMwGr/VWV54uXnIVhSRnp
	 Vfv/1e9rckvfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF05C60732;
	Wed,  4 Nov 2026 19:18:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 47054177B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:18:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 383B581324
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4WyqRZpn52Y for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 19:18:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 85520810F4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aCUxN/Pj
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85520810F4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 19:18:55 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-8241a56cd70so719355a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 11:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793819935; x=1794424735;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dAb+g3Yy/cWlz6ZuTdi1urcB2Nfvr4CFRX6iqQlgFtg=;
 b=aCUxN/PjSQIFqek86u+H5JBA0OwDm5WLIXj1+Em1n16Vq3bLc37djdBZvofRvWdUkY
 PGnFvoV93ANCxGL2qdipyKZvuKkSHIS6j8vlkQeS0bWRwgWu9m2AGGTZ1ZZSz8+7UnU6
 5/Gucd2WM7C2hOFBP4Y4lLDcn4VRTqI7kqmbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793819935; x=1794424735;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dAb+g3Yy/cWlz6ZuTdi1urcB2Nfvr4CFRX6iqQlgFtg=;
 b=D2N9blqjvKS39jnTemKiklQabQ/Bq5JoGIHrUNKf1BT6TWYJAhBKquhs3sqJ1j2B4Z
 M35PuuCvGUlSSQWg4zJLkla3NIgaiKR8VI5Ubc2MA1mUMyhxS0ynh4/HcVGPjKl52Wlw
 iJ6t7w26lzzqHyoeil5z3m44XYC9Au72sUuGE52uoDJm7BWLckN3T7i5gOaYYpYNJfKU
 p9H48ViV582oMNvrFKBWFB4ihGfsSi3gxK3NY5WZKU9ehwZKy+mRSCfs3VOz5G5NulMB
 4Ekh4uYsdRsNBJ0Qyp4p6ngOQm6mJpwfLotc426qmAc3hL4ONjVM/IHjrmZ2szOa0B6d
 9nhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSZ2u12fpLMtqOSIt3WXsThkAchBO1Tic9/J1yiSEYaGHl5CnT+H/PmR9uoUmGHGmPO8zjYSY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/8ioeVg6liM2dIuhTAg2s4rRGxONztoLOXZdXhKbxqHLa55wZZ
 AUhiMNJd92kEnvGqvYqJ/vg4i9oBVVdkwzEOu/ZlM+i+JEvgbV44NFEiPL3GRx0ei2Q=
X-Gm-Gg: AYBFou3Raw0R4dATpNZfR6rp/wLnYVyRxjNhtKQRbjkzCEcEmF3xNGxBhHjlCED2TLI
 0WxBWS2nwsWZy4pltdhwWR9DUuc641GYkAGTvehTiTQ14Bvq7E6tVkyEr1S8Rj7bcN11qbC9+U8
 HMoB0MG2VwfrATu0u6GvSNnf48rxh3/6Y1H2iqGi1G7UW/+XJlvEHg4amgPbnGWdKJLZJ14gs3D
 5uJwaEB5mdnnai+nwWGD45JLbAgQibnREmH23kzllvLwvc+QE1u+mD51zzwu9nN2hqqL0TsBRVl
 oucJhSNVBc9TXTwdfDyMptxvX/ahDyqI59LlSh3WJdRiyCNc7xAzgJK4sHZzS6eu5ECN0SF1vqQ
 D4ZeF+iGnzvnCbiRTUb8EVBj0SxV1iATFkj9s8Uo4ZXasnGwHYIo5u4joy8N08C/sTcvh5LIC2t
 a0dtNQfECvIn2PMlvbPOhL9L19Tp7OyS0qAaq0cZHMn5XOUAx5LjV85cTSH2BcDAD6lZMdOjDcV
 Z+6t98Nqw6dejRS71Z2Z/puoatcpftGvK1J42EyJPzCWDXNu1ij8Zo+Dg2lnxJ9x3iQ8IDlp9Jh
 9NZBRHIOgCIa55zO1GvOq+n2sH9w1ge5e+G/9svoc/NbUM4IBfeHu6cthXobzPapA92KoUreOnM
 iBIENABcFCN9Wb2LJMZ7ozOoLcwNtZe83SHxu07v5S/qBOvFjGg4u4HuArJgOOAf2UA1w4rk9bG
 J4Qb0KRZ5BWPEf+BBW3LNg6h9Rv6UtC3BUmX5I/zBShK+zp2KL2Zrc
X-Received: by 2002:a05:6830:2683:b0:855:4d49:10a3 with SMTP id
 46e09a7af769-85d365acb55mr12513210a34.22.1793819934808; 
 Wed, 04 Nov 2026 11:18:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85ef3e55906sm2554581a34.18.2026.11.04.11.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:18:53 -0800 (PST)
Date: Wed, 4 Nov 2026 13:18:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 24/33] splash: make splash_video_logo_load() available to
 boards
Message-ID: <20261104191851.GC1164024@bill-the-cat>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
 <20261104085036.4012238-25-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y26dGYmVVC8iuGvi"
Content-Disposition: inline
In-Reply-To: <20261104085036.4012238-25-dario.binacchi@amarulasolutions.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--y26dGYmVVC8iuGvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 09:49:57AM +0100, Dario Binacchi wrote:

> Boards providing their own splash_screen_prepare() to load the splash
> image from a board specific location have no way to fall back to the
> built-in logo when that image is missing.
>=20
> Export splash_video_logo_load(), which copies the built-in logo to
> the "splashimage" address, so that they can use it as fallback.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--y26dGYmVVC8iuGvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauuFGwAKCRAr4qD1Cr/k
Co3DAQDey6YWA2zakNnx8WW3KYAjM69DU0SU6ECZcCCOl+aWewD+Ot0rKqnAhJ3B
CnpxUW0WkQzEUjwy3dJX9C3qoEt9oAc=
=5X0l
-----END PGP SIGNATURE-----

--y26dGYmVVC8iuGvi--
