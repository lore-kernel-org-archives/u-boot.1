Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7C7FC6170
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 18:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC9DF88DCC;
	Fri, 13 Sep 2024 20:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zej53mCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 649D888DCE; Fri, 13 Sep 2024 20:27:42 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A8988D8D
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 20:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6c3567a143eso19831326d6.2
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726252058; x=1726856858; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=laWs3G28EpyiFnPU2uBEhSlcA8mftZduO1M9urlcHqA=;
 b=Zej53mCbhUn9vUHtAuC+GJNISSpu3LaBiPMElwA4awDo2REov0H33zO0+BwLMMvU5m
 BJCALxUMiSx5KwjPUHhOynMAzCRwo82N/9TJM18Pu2dp70Z6d9VNiWJASQkqHzYftoGS
 SgjbweG/fO6eMpppOzuFYNDuBupeELv6CxfyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726252058; x=1726856858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=laWs3G28EpyiFnPU2uBEhSlcA8mftZduO1M9urlcHqA=;
 b=BcbUQ6bvNF5/8+xjtUjt7OqSzanPais4wRhRgFy0qEOZpagWsJaRlmCJm27QnHSYVa
 d93gRt3WsZmBlp04xliB1Vq+gTtUcNulWF/uFk+970pOZmob+AGSWeXORDwa5/EGtYfM
 2NPq0wCn7Wz4ogDdDQOJ4TSZCfUvYQHsO4f6bcMuvAGoJF3/CGzra9ZrQSW+NEMYbGho
 07/zXjR5czGH2AjQvc3phFgX16CDDYf/z1wN2Oj5fNMBKr57PYh6XCsX8MvdcJKSUnp/
 SSgQsXLL3CyJ1GPYUK2mLHx2/D+btH+5IP8InvIlKQ/nZZJ5l1nBB6PE60+lwkI2w5/l
 dqHQ==
X-Gm-Message-State: AOJu0Yyx5i9tT7AH1Q8v3BrXX0MJUff/dViWYf/hEjwCVH7IKzPoZqPQ
 lurKP66GmIWxh8FAFCsxkUoziOJAn5gnwjHkmPf74jFR0Ic6eiCXV2OMwZvCQgZNAy1ocXdJjAu
 jrrA=
X-Google-Smtp-Source: AGHT+IHfidW7HAnEvDBXnRwDl36ENj982/C5pTn1VB+BEpDGGs4dgGkPodZxI5rZx0OTIRKSaeMN9Q==
X-Received: by 2002:a05:6214:590a:b0:6bf:6ef6:22d5 with SMTP id
 6a1803df08f44-6c573518e5cmr123662656d6.17.1726252058364; 
 Fri, 13 Sep 2024 11:27:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534786f4csm69806396d6.145.2024.09.13.11.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 11:27:37 -0700 (PDT)
Date: Fri, 13 Sep 2024 12:27:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [MASTER] Pull request doc-2024-10-rc4
Message-ID: <20240913182734.GX4252@bill-the-cat>
References: <5f056170-6966-4925-b165-ab5f46959188@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BErGOJJhbNBXDXvF"
Content-Disposition: inline
In-Reply-To: <5f056170-6966-4925-b165-ab5f46959188@gmx.de>
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


--BErGOJJhbNBXDXvF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 03:39:06PM +0200, Heinrich Schuchardt wrote:

> Hello Tom,
>=20
> The following changes since commit 5f044932413694475422d4b16607dfcf9aff87=
81:
>=20
>   scripts/Makefile.lib: do not include CONFIG_DEVICE_TREE_INCLUDES in
> dtsi_include_list (2024-09-10 11:31:54 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2024-10-rc4
>=20
> for you to fetch changes up to ff994a3c2ed0e8d233bcc6f0176ef21ea9c75009:
>=20
>   binman: Update links for sending patches (2024-09-12 18:14:50 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/22327
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--BErGOJJhbNBXDXvF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbkhBMACgkQFHw5/5Y0
tyykwgwAilUorY3RfEIRIM3jGW5LZD3RmtuKjHQTyUtBhgfR6C4X1/jLijSM+XeH
64VMNyet+G5umG4WiameS11UtszxkCizdVMgyD1T175iBiJS5l0RhvGEglIJq++1
I6wbC/oLPAk8ymzlurzqK5oHRq/PPccCZ4cUOayuesvhky13IL7SKu1wc9rb5Q1I
oXFSjDkt3aLSpV/0y1/rcphgey4SHDJF/t7wogM3e3T20Kl/SobBOj7rWp9EHebZ
UmPMgofvWv+4eFUiLcfYFJhZlRWQO294U5pr04218FqXi4i3uRxC1tcE+200IZGR
WGFmd9xSEqQOY6OqCNz7skYtSvnrrRdB+o0ThKPD84KGgHlbL+U6QuHACORB8ECf
WtQ6iAaw9gxYWwDNpQJOPQHJFRypeXLxjrQ5YaJGaVPYeB2mdU0Lq/et2p9mYu0C
GGA2lmbY/aHKT69eRW6SRN9t3gczECeEarPRRjhPJVtO4nkiDOhQDUNmnICzfS72
cFvpKTBD
=C0MS
-----END PGP SIGNATURE-----

--BErGOJJhbNBXDXvF--
