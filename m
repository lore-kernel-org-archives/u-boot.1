Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F16606A33D
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TA6FGOS4;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZBjdBHNK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81D2B60B8C;
	Fri, 20 Nov 2026 15:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V6jmzrlAavTu; Fri, 20 Nov 2026 15:52:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7CB49606F2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795189960;
	b=EuXoQ9o0YHRtBcElyW7QkKydbaYrl3BVKXn4l3YNOl84Y1/YQTa3auWwOqkq0HJrJq54
	 Wpdn7I8pvqCWV5dpUGfLfvL+6SA1m6RSzu0Zhc0fyfoGylk/a8NzcMDSLs9361QV5MszO
	 rlcOP+38W7g4kMfM2DRR4XUGPMZVJnp3AZsfg20lylsKFOkvBE36EPbDrARrY59E+c/k8
	 imXuIJsNAo5hLxNOCcwpL1W0imMKSSQBYnsq7dUBiGQWg6Sa4trpZ6Oea5dBXANkyy67F
	 4RSdwCiZ6rB/yKs0dxYQ7s7kHJaqmmVpgxImxsWJVzMOzV6plKKDwxImTXQOBBa5mMA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795189960;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LaUOHBSlMM3cv0tQ9xsMZJiYGybvqS8zWFrPitB+Tbk=;
	b=nXpMkMMqlhnkCBxl/+5+jTe6F7yELMLfs5vtNTWrqE9f3pVNfpPyoaQFKJWJWGXUa+N5
	 yEaBwawJQyp8YGhHaJjSrVl5EN2U2kqbEthCT9VsZt8qsD+e4kVHE8qk3TACirI/k1JsA
	 efB3+8mSDLxWCpBvRapWfvRsRUxM3vVBelMt2jwG+1t9DD5zNtpPW2F1Q4SPWfsgyO5wq
	 A4O7We2d+U5YcsRLO0Si8JutkGkYaOLyNgxQRHPIKGpkifKlZNV0GTZGpHeF5OQhV21+K
	 aIHGMikYS2cFx5cvAiGJtkgwa4eI9K+n7D6oZtGz+L8po35sj/qt+7eHnW0UDRZARKA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795189960;
	bh=LaUOHBSlMM3cv0tQ9xsMZJiYGybvqS8zWFrPitB+Tbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TA6FGOS41oRvbQ0WeiglXKLoNAvkxUqrnvpizMzYC/XVFn9jMYOQV1D6VUt0ATjkq
	 J9shfblFiVRGNuSQYkUlgzgKz4WG5WPokIUOOZnq/OYhwmyywGrqaNdXrlnAMuuuE7
	 TwVUJ2ALH5rFMl3JBaNxGTZnlq0Mnkj7nHO7qEqs2K7cQRhskScCLu6jj1Kc0PihPu
	 qjgZY+6UDxztdoLdVAS2jXrcs3ELIPBCvIfGMUu7fWo4quTT/JkMUzcpRKpim4Byij
	 NFod3gW3BprZ09VOekOPg3tBEo/lwm9HDFMuNj09ockjRJ8tKM4CS+VmjkvrkilnbB
	 GC6mHXGvFvq+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CB49606F2;
	Fri, 20 Nov 2026 15:52:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BE44169
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:52:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7BD3140E43
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:52:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B_KVK7Zl8s7T for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 15:52:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 71CE140D5F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZBjdBHNK
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71CE140D5F
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 15:52:36 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-55650fe1f0dso642627b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 07:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795189956; x=1795794756;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LaUOHBSlMM3cv0tQ9xsMZJiYGybvqS8zWFrPitB+Tbk=;
 b=ZBjdBHNKXgTuQP5hKaVon+uAluLBb2rYnfC8IX56kq9jbzIVY0SlIV3s7WSSBCd8/h
 OdaNqNEVMQotNX0SmBPSTpJ5IgOXmo4OVy3AYYM9zzR1npgBlrZMMJJXtGnzjfUYltMy
 Ok6Z26jZCshGsb9qYpneClfTKdGBLqeCYQ55o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795189956; x=1795794756;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LaUOHBSlMM3cv0tQ9xsMZJiYGybvqS8zWFrPitB+Tbk=;
 b=FzmkQ7Sd8hcSKWcUOQG3MrIfTLPCnlPTkCJe+TwQdCSPDMuZEPiBrPQqvO3oTApcZR
 54VOlI9k7uZmteyR02IsHK1Vv6QOXOHZv1dr8SxgccyehHfis+n4z0zRf2RUAk+8z+jq
 tXSZbrg3A8DK3TwS3Rr343bBge/PZEA/2aL2J4GcEViEgmMrzE4yNV76bOqz1MTqx6xL
 naAuiklQV3b4t/Ndad4KtS2tv+qiWkpFagu9xW3buJqbQk+dPQlNcpuaQ6pu9K3o2YSD
 5PWYWyQApKs8IFojS6Zth/MBzYldYIxU9D+eZoi04OFNFd7LLInjXiZHT9Xai9dKEB1K
 udxA==
X-Gm-Message-State: APuU4Z9l/NUjt28cAAiRdsPCNFQZEy3bEonrNMe2bZZFNAJGtx/9/aMA
 HWZWX0Q/omWZUk6KFujCtXXMWhn71lIdJRiL8ZRW0VrRF6Aq7ZFdqsgSWlxHP3NDGcU=
X-Gm-Gg: AYBFou1w3rY3QX03plva2CmP1D2PHVowmWZSoEUZhnjzdmRmZ0iEChktP4fiKprr38I
 nV2Koe9Idvf6weXUoqRyW3fTRSjQKBDRqT9+80HGXj/9xxFaCZLeymDo42Pq2J23axg8lXly2j1
 JF6F1iXtkukR7l0spXGF3jmPsg2h/rQjG4a36J7vs9dWjp40GnHIryWWItWMRgs1/DaH6yAr7eC
 Go7rLsq9L9zynlO9zLFlHzhiwtaj9Ru1zghE0+Hv6qeDeipchlpbaEX5IcHAS7aHeYgeMIheLcY
 K4KoaY5aMzqOSK7dN6ySqnDKra2R72nvsaqz8M5Z2tgpetUTLmMuVVTqxofj5UnCSNB07a1oDxZ
 thz7qXlu3uL3TLRHnei+5g5KKxjGb8pMW6rPsXvMUfX6RfpOSeZLP1Sv48IpnXe1g9IaSwG+ECa
 Xg8XNraHPQkHzxY+N3YPwRr35DjRWafP3LstmhlNLfH4ZZXoGwHHL344tINLQX8g7bzfGWoytNN
 BBIEUYARra8if8RVKxPnqZ6TjGaSj685Sp+HLSjfthiI7mubOtCpbQqxxW6DPnczAX6LSM9ZEW9
 Z5dLcr114edB8o2qa0k1d5jTtNr3Uu/EV6blfcqIQX9QqmeE6PEjJqo98lqwFvw/aMov1KTxg7/
 0BI/J2TiWD1uWJFO3R/csd9dxAUmqdnP7S/uvImu320cqez452s30S7AKGQsgWYIYYRoONdBNXq
 30KWHxdpMxwunlp40AjIF2cvrjPOtjnBE=
X-Received: by 2002:a05:6808:c1b0:b0:539:ad19:d0cf with SMTP id
 5614622812f47-57a09c11039mr3858049b6e.20.1795189955775; 
 Fri, 20 Nov 2026 07:52:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a3575f5bfsm2398728b6e.14.2026.11.20.07.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:52:35 -0800 (PST)
Date: Fri, 20 Nov 2026 09:52:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH 0/5] mtd: spi-nor: Micron, Macronix and n25q512ax3 updates
Message-ID: <20261120155233.GA983185@bill-the-cat>
References: <20261111120713.1526940-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Dx7wMgC7yvKTuFl6"
Content-Disposition: inline
In-Reply-To: <20261111120713.1526940-1-padmarao.begari@amd.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Dx7wMgC7yvKTuFl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 05:36:40PM +0530, Padmarao Begari wrote:

> This series updates some Micron, Macronix and n25q512ax3 SPI NOR
> flashes.
>=20
> Patches 1-3 enable octal DTR read for the Micron mt35xu01g and
> mt35xu02g flashes, and apply mt35xu512aba_fixups to all mt35xx flashes
> with octal DTR read. Patch 2 moves mt35xu01g before mt35xu01gaba, which
> has the same 3-byte ID, as mt35xu01g is never detected otherwise.
>=20
> Patch 4 adds the Macronix MX66UM2G45G flash.
>=20
> Patch 5 disables chip erase for the n25q512ax3 flash, which does not
> work, so that sector erase is used instead.

Now that we have applied this to next:
commit e6fa1282975af50acf44be7aa678b89e187f0860
Merge: d5aa20e268bd a821b0b2697f
Author: Tom Rini <trini@konsulko.com>
Date:   Wed Nov 18 13:17:28 2026 -0600

    Merge patch series "mtd: spi-nor: split SFDP, ID database, and fixups"
   =20
    Takahiro Kuwano <takahiro.kuwano@infineon.com> says:
   =20
    The spi-nor-core.c contains optional logics like SFDP and manufcaturer
    specific fixups. The spi-nor-ids.c has single large ID database. There
    are many #ifdef directives in those files and that negatively affects
    readability and maintainability.
   =20
    This series, as the first step of cleanup, move SFDP logic, IDs, and
    fixups to newly source files. Reworking, renaming, and reformating
    existing code is not a scope of this series and further cleanup will be
    taken place in follow-up patches.
   =20
    To mitigate the size increase due to these changes, drop one of the
    page size parameter from struct flash_info. The resulting size is
    smaller than it was before the patch was applied (see below).
   =20
    Here is the code size impact when applying this series.
    Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
    manufcaturers are enabled.
   =20
    SPI-NOR:
                text    data     bss     dec     hex filename
    BEFORE    722344   14100       0  736444   b3cbc u-boot
    AFTER     722196   14188       0  736384   b3c80 u-boot
    DELTA       -148     +88             -60
   =20
    TINY:
                text    data     bss     dec     hex filename
    BEFORE     77490    3128     248   80866   13be2 spl/u-boot-spl
    AFTER      76342    3200     248   79790   137ae spl/u-boot-spl
    DELTA      -1148     +72           -1076
   =20
    Link: https://patch.msgid.link/20261109-split-sfdp-id-v3-v4-0-7270c9d82=
fd3@infineon.com

Please recheck, rebase and repost, thanks.

--=20
Tom

--Dx7wMgC7yvKTuFl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawBsuQAKCRAr4qD1Cr/k
Cj5oAP9wfF3ZE30JiG6F8pp6Stn1I7gR+GIIEbERSf1qQy4HYwD/dyz6nycN+ry1
O1eQOeFrgWUWgRrDbmBCyfyZQIAfpAo=
=sZZJ
-----END PGP SIGNATURE-----

--Dx7wMgC7yvKTuFl6--
