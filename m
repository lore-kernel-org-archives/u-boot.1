Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102B60A261A
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RSG0Xhp2;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MINWXKkM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA8F460750;
	Fri, 20 Nov 2026 17:46:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lOZXwapLgZD0; Fri, 20 Nov 2026 17:46:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4AEE1606F2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795196816;
	b=S2L0ZsXR2ihCQsHUe8zl1tEaLRioAdHupqK/rr6cM/T7gU44VtYVeNConJRB8aRydLt7
	 JSnYPVGXcywcbmKIzTlhXsJ+BDQcNDpFYiD+vwYXpBQ8s3n7WxWedEiwUkhB/jZtHBJs9
	 X7mTQn6GVKfYBNe0De70X1aRXtcuY1okxUUhPfO3fR73EqObsdzxD6cjkxhpItYCJK5NP
	 7gso5dtj+ACN9Ws1hDXp9pwri/DuNdza7suiCyTUdUo0z+NWGsAR2SBJiNNDu7YHaIlrp
	 Tr3z1pYhKxC5I9YsFRZz2aZ4w0t+jnvxVdeiI1qapXJLB+CbktoEoArgLJ014rPvh2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795196816;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=2qzHjYIt9Gnwufleiu3aK1lvOJ/tKtySmNraifHHxyU=;
	b=SC5RtAAOX+6mmx9YmSv9qywQInr4jE2C6hQ+5tmCjpWetT1dKEsfPK5ZXBvCtH0nyum7
	 Xai6NyzP98yygaNKP8EFc42LYuVkw968vdGO/JyFhAiIXQXhNnk87f6tYSoJyv6O57C+B
	 9jNSJUEsYdDHRN1I/lkLfs0dtpuQUKo2cskDNEytfpvjFXTMnwvulD8w1cKOcDylTnvcp
	 xbTnfmuFWRhaakvEyw1CW/YrOEhGIg6dYL9aWTx6B8j0zbkSjVPaEAz6h4DaJ0Vl6U493
	 vreoBQVOG0mJt3N+1fPTAfh/LJVzL0r5jPgyPViK0TludjBGeqWXGyDHbbFeWlwFtzg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MINWXKkM;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795196816;
	bh=2qzHjYIt9Gnwufleiu3aK1lvOJ/tKtySmNraifHHxyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RSG0Xhp26/9nm3qbitdSqAL0fyb1vX8Z6ryKbLASUrpAI1cyZ7P5TfG1LSwbPBjwN
	 FLq7ZMJ57Gt3u2fDkJzYjfsglrypjgIMWIcxVn5IIWzI6YoAeaXCquJrcyEnRG2/Qc
	 A1CHgrs42VyJvJWTdLSD02zytYyPc/0V4U8yX6pax++w2RKnD7CUmkM5RGx5uQeWLo
	 CaT8FueiO1MePhWXu5WlRlkOyK61sK9FdSRq6EClyfcxI3ksq10RKq+VME0qauqE4G
	 xEnWPrrq9D9+Yktem+iXUnJIBQzQaFTsARWqBb5zLGCjXopqklfUlEYO8QHN37828O
	 qZJFW2nEfVvgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AEE1606F2;
	Fri, 20 Nov 2026 17:46:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0FEDE22
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 17:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86D24606F2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 17:46:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52GlN6qeOjTW for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 17:46:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9DFF86069A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MINWXKkM
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9DFF86069A
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 17:46:53 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-71ad5f20016so826257eaf.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 09:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795196812; x=1795801612;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2qzHjYIt9Gnwufleiu3aK1lvOJ/tKtySmNraifHHxyU=;
 b=MINWXKkMRDTbT+NGN4dEZYGbC7EvGaKVC30kh+EnzfKYl97aGFGjbnnX6G2E8v7kss
 uj02cTAU+Q893VUEly2D6JF8YEMy2QrcziDDSQazk+cM+GfwdlB1PafaFYI/od1elzfJ
 40H6LoLPGw2nPuOOzsskT6uyd+iLUDoo+uGyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795196812; x=1795801612;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2qzHjYIt9Gnwufleiu3aK1lvOJ/tKtySmNraifHHxyU=;
 b=HtPENZ5qL3EXueXLBOm34GcvInmwrjO2thWNtSVPJtTCp8L3q3gdYcmD/kPw8ZqmrE
 cswN2B9kyzVmdcbItNWQvLpckT3rhq5T1WA/nA6jS5t57on0AKHPmhyKIIEuaUUg8/y3
 9JQQI+fBqDXbUPMyAB+fBXOv8Z1QzSZcSFAh3/VQUs/douTXN5huLLCsAdbOW7FUiFxG
 mtxoyfkq7yEN29LRbE91s5y7TiAFqhP3TNxqze1Fz/VFULhuEQErfZuJKSWkTD2C/KWc
 7Ba8sMkMhKbEEMA7inog3AmzyDbYa1vFIZrfZFM4RvOdRGm3HQpasl8rOh7a5fY/NqMf
 4Jcw==
X-Gm-Message-State: APuU4Z+rsvLe/fziDI0PMtjyua9jcR2uQwStILNuxyiNL9idgDArSVCq
 zA9lAznmwowCZc1BQCPcmjucBzwo6VlGJKfqM7ZHJ8lLIAlcv2C8DnS0yZXiRNnSLLM=
X-Gm-Gg: AYBFou2knRCRetXwObrDo/RjTS80XHS48vXbKYFZ4ELB92Qz7zL6saJVfTT8lZhOJHz
 CzlrseJu0ZOk+9OKEJpSU7HPFcoUPTeo8OAA6AaB8v4x6LbWL1hW8chWc2sHVpSa9Whs4zCE9KC
 0+1tVXOFXBubiefdem9RQUFHeGu7P+WyhUI3wkpJKE7lWcqrXfhbN8fayIlT9OYpcGVewd/9Om4
 8x/7j5lhr4MmY4Qke6s8ENyXnwBtwD7veWipNVRJrUoAOia8NX0H/vkUPckjE4TWiZrcQAzANwC
 zpj3Q+OB1bSUDPjG7swcS4ERbLrdudHH6AvtdAy+GoP3e4g5gB9mD1UpFbAI+txiLJRztNGbUG/
 bmBzIMJb695eJu40ELTKjdBYZEPwmtwWjTSj0uqZeb20BYjXT2TqzgPJBM7sA/fRQP0qytEoRoQ
 5XNy/f/kLDL1WJVyoonfK0H+rD7oXFVs2iEe54qo9BxYeZakoVbo5/xBHRzM5ceO+4kKpbieWKx
 1nVfvUNiArFIQYDUPNxKPRcNmdJX9E93EbHkNJeATle6YMmvbbJEqk8HJWQ8RowjwI6jMtlApNX
 F6CF1v3QG/CDJq7iNSZj3D3QOcb5S5zxoTviTxlEsIjBaYwByKLA7N8psDrQgZSAPxtnoDAqULR
 KDWsv28l2URjvTZIaREkHc1owYKI4S8dDumrwbbfIOyHzVX4lZHScIJWgE5WqZTrgjCDZxckcbd
 NWu13klh8y0qQ/jBZ8LZi9B2+edAHg7cA=
X-Received: by 2002:a05:6820:7099:10b0:6f8:e2ac:ecd2 with SMTP id
 006d021491bc7-71b39480ec3mr2516221eaf.33.1795196812091; 
 Fri, 20 Nov 2026 09:46:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60491337sm3364382fac.12.2026.11.20.09.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 09:46:51 -0800 (PST)
Date: Fri, 20 Nov 2026 11:46:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 Denis Mukhin <dmukhin@ford.com>, E Shattow <e@freeshell.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Simon Glass <sjg@chromium.org>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Subject: Re: [PATCH v2 0/3] dts: build the DTS from a directory outside the
 tree
Message-ID: <20261120174649.GA1006920@bill-the-cat>
References: <20261110075256.1800130-1-vjardin@free.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NFyr3CQ9DvY50ZcR"
Content-Disposition: inline
In-Reply-To: <20261110075256.1800130-1-vjardin@free.fr>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--NFyr3CQ9DvY50ZcR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 08:52:53AM +0100, Vincent Jardin wrote:

> A board whose DTS is not in U-Boot does not have a clean way to build it.
>=20
> Today the build systems copy the sources into the tree and follow its
> layout: Buildroot has copied BR2_TARGET_UBOOT_CUSTOM_DTS_PATH into
> arch/<arch>/dts since 2017 [1][2], and had to learn
> dts/upstream/src/<arch>/<vendor> for OF_UPSTREAM boards this September [3=
];
> Yocto layers copy their .dts into arch/<arch>/dts and sed a dtb-y line
> into its Makefile [4], copy their -u-boot.dtsi there [5], or tell the user
> to patch the dts into the U-Boot source [6].

With this series I now get:
+(boston32r2 boston32r2el boston32r6 boston32r6el boston64r2 boston64r2el b=
oston64r6 boston64r6el) scripts/Makefile.dts:37: warning: ignoring old reci=
pe for target 'dtbs'

when building for those (MIPS) platforms. Please investigate, thanks.

--=20
Tom

--NFyr3CQ9DvY50ZcR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawCHfQAKCRAr4qD1Cr/k
CuNyAQD2j7E8qlbr/Sf0Bzs0Khj0anaDF3td7+Ec33urYfkarwD+PvGe8miQIaoD
7IAql8G5kIUK1HniHyl86v9092ZGqQQ=
=1n7w
-----END PGP SIGNATURE-----

--NFyr3CQ9DvY50ZcR--
