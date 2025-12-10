Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECECED3C520
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 02:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10C1083B48;
	Wed, 10 Dec 2025 03:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rYMgtDGZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 059E483B4A; Wed, 10 Dec 2025 03:22:17 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5045283AEF
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 03:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3ec41466a30so374374fac.0
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 18:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765333333; x=1765938133; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4SKtnv/RusNUX+DUUxPG6rLyeeAu5fOQxBp1ztKJ/D4=;
 b=rYMgtDGZTQUOwVO8qhlVcH6cM7bjJUzMw0cxX2i+eBTtY5GLU/4IwhK1dZ+lexTQQ8
 yU4TCbiluewanTrx/Yv2YP7gtnslmKz8uKCrIqVIvFC7JU28WRKr0Xu0uEoUuJosIwqu
 InUWfksOYpcIPG1a0xj0bpW4ut5D44DKaLVLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765333333; x=1765938133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4SKtnv/RusNUX+DUUxPG6rLyeeAu5fOQxBp1ztKJ/D4=;
 b=oZS3TWUU0KE7892XKgPKCWRLjxmWqf5YspczJ1fnaL6K0Zi6Tn0adFCRPahzcUmb9v
 5Hu0KokJvfe80KP8r3Y+1KTbIHUM3M2Xalx92PYIxCWGXT1IG+6W6h8xw9rqcBkUjfTY
 VCUgEI36YZZIaMu2s57mHMwthQThsyWf12Mqj1GJ8bPs9qGmIKgqpPdMuiMQSoSXDi5/
 R8t3d2AJJGGvp4+b7p05oOPVW76AZiXdWw5/V+OS/0X5Op4nVXZzVw9Thio+HDY1ovWr
 iZTA+VFU46ztc+9N11+G3zH9QJCjZv7zukhezyBJ647zahWgYzrLzGlba6iHaX+pNnFp
 4JPQ==
X-Gm-Message-State: AOJu0YwQ6KPZHeYrbNbd7usWNZ2e9phavrgpTmHEJHy+ij4NfH35nnVI
 RAYtgN4H53PXArktyhid+gpFocwWL///nvnXjlHPTrC876B6+jbaOIZO3sIslZgg2JI=
X-Gm-Gg: ASbGnctG1ZtWkgxIu6kT2b1kgTmGtszRe4tQ4rlc3+7XuyUq659/vnM4VWF7vCSuAjK
 pkjhBWm9Fifv/7sZga8ofQh46LQnHqrc/mxnYNgtENp+s0PIhbXz2qZGu/zfkiFVr5FysIPH2B5
 dr8sTkwmp2uS6ILsF014KKbBMN8ENi8mdiAl+bFCrwnGwlbqAxqYQ/LayBqDxEBgLiIx0gGKXQR
 j73+MO45nyeT7Bh6Dp9Czaq6HLuAWZXtMpOv7Y9B89igFdI/E2WVtTGYDDklImEWP+lWMkJP8ME
 PRT8pnfvlITrgSEauSuzgcLZlq4t9YqmUkcfjWW9GJvZCz6qLRJueTC7Vlix32i+8p5IjzLy6Tu
 T2ZIiziZ/yiXdwphA8upqii9VLoh0yi3LoRh1nq2i55hTCZ6cRLQOp8Hk/cfDE3C5q74RbSzBRX
 PLKMC2nkeCyLMq4OGWfqYK5NwYov+Bs91xsE71CXwEo/xxJxAR3Q==
X-Google-Smtp-Source: AGHT+IEkxthFzeKV33UyNv7Eq9E8fBPBDEIF/3Cz3wVJLVT7TLQufV1hYQW8AgxPMspxiEOE8sG32A==
X-Received: by 2002:a05:6871:8085:b0:3e8:97ab:d072 with SMTP id
 586e51a60fabf-3f5bee17593mr659663fac.6.1765333333065; 
 Tue, 09 Dec 2025 18:22:13 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50b5e4944sm11576693fac.21.2025.12.09.18.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 18:22:12 -0800 (PST)
Date: Tue, 9 Dec 2025 20:22:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Message-ID: <20251210022210.GE303283@bill-the-cat>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FbSmmTw+OxOGthP6"
Content-Disposition: inline
In-Reply-To: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
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


--FbSmmTw+OxOGthP6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 08:32:50PM +0100, Marek Vasut wrote:

> Synchronize local copy of DTC with Linux 6.17 . This includes the
> following picked and squashed commits from Linux kernel. The squash
> was necessary, since the DTC here contains changes which were also
> part of DTC in Linux alraedy, and the squash helped resolve those
> without going back and forth with the changes.
>=20
> The following commits from Linux are picked:
>=20
> 8f324cd712df7 # scripts/dtc: consolidate include path options in Makefile
> b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
> 7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.7-14-gc86da8=
4d30e4
> ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.7-57-gf267e6=
74d145
> 02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.0-23-g87963e=
e20693
> 6e321b7637396 # scripts/dtc: Update to upstream version v1.5.0-30-g702c1b=
6c0e73
> 9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output support
> 8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.1-22-gc40aeb=
60b47a
> 4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consistent bracketi=
ng of properties with phandles"
> 5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
> 40dd266887654 # scripts/dtc: Update to upstream version v1.6.0-2-g87a656a=
e5ff9
> 8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.h> in non-st=
andard path
> b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.0-11-g9d7888=
cbf19c
> 69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text formatting consist=
ent
> 8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS instead of o=
verwriting
> b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.0-31-gcbca97=
7ea121
> 93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from external DTC project
> 0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.0-51-g183df9=
e9c2b9
> ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
> a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
> e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitignore
> d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d=
3449c8
> a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example from help te=
xt
> 8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
> b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.1-63-g55778a=
03df61
> f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.1-66-gabbd52=
3bae6e
> 09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.0-93-g1df7b0=
47fe43
> ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.0-95-gbcd02b=
523429
> ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.2-35-g52f07d=
cca47c
>=20
> This also includes forward port of U-Boot commit
> e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
> to avoid binary size growth.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

This gets us 95% of the way to where I'd like things to be, and so it's
good enough for -next once the pre-requisite patches are merged, which
should be soon. The remaining 5% are changes that need to be pushed to
upstream dtc and I've started that work here:
https://lore.kernel.org/devicetree-compiler/20251210022002.3004223-4-trini@=
konsulko.com/

--=20
Tom

--FbSmmTw+OxOGthP6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTjZTgAKCRAr4qD1Cr/k
Cm0vAP9veKt0FuU5OTOEVt/AmzxpnOAk+tM8Z/sd9gzWI15DwgD+LCBB0RSQNi/Y
ig9zrvmMWjtj4pNPUPlnekmcEYvfEA4=
=5BES
-----END PGP SIGNATURE-----

--FbSmmTw+OxOGthP6--
