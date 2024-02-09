Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45938C48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 13:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85A4B87E74;
	Fri,  9 Feb 2024 14:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NIrxfes+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEEFA87E71; Fri,  9 Feb 2024 14:40:38 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8893B87E6B
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 14:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-783e22a16d4so160431185a.0
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 05:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707486030; x=1708090830; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2eNqxhtC1DbIj4IbazI4N7wdXSX/apgG1N9WvKGNRgg=;
 b=NIrxfes+S4Na60ZZLlEsqspqXDYoYcsnJMkiiDEy7ZK4byMGzXLPj41oCxXubvk7Xp
 kBvysodLtNuddmHrqORebVdmYP+m0AT+v0ccWs3AbNO4nDN3ef7yhlxrcNigc1LSPnEa
 xdAp6IJnmGCkkq0m4Vz07mX/pk4xNp2l9qZOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707486030; x=1708090830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eNqxhtC1DbIj4IbazI4N7wdXSX/apgG1N9WvKGNRgg=;
 b=WINI0lsY5hhw21n6o39IM/VwBgXqYEF1MpY3jJ41Wxv/LkEaFHprTG58k8kEzS/rwl
 oJlD/WanTLvxpGJdgKdum3YDTxxI2nvlkaAEJIA/Mvttr6DCYpZEDoZ2aS+uTWHoyS1m
 TEhQCtwr0ybtIs8WveYfECpoHKcc8UVAmcx631T8erfhYnIhMWPtWui2M5ldWUQh3dua
 RD3bdaooBmKV3okb920VwB3dK6s1QmxkLEtKB42zYfA1wwb3dvfB53u9xHt06BOptXer
 JvnRYolG7wWFVChB5PPyPVqdAXqa1Kmn02TR0iTFtQBQqWf7FMGnJhirdSqJ/FDL13yy
 l9JQ==
X-Gm-Message-State: AOJu0Yyvj1Ezb47N0hIGDLnWPUGTVL7BYVQcLYbX/FyltsrK6nJHpRBZ
 tOIi+FaU5PiwXIO67Ze8pSjWyAcYLuCihK/xu3/bnUENQC7RzzAPNp7O+bvRAu8=
X-Google-Smtp-Source: AGHT+IGvtDOc31Plygw1YYRQGDuso5foYETPMF9Z3Mh174rpBB5fwQlQ/OeNGwVMfNmLL71cau8KVQ==
X-Received: by 2002:a05:620a:1203:b0:785:6601:ea1c with SMTP id
 u3-20020a05620a120300b007856601ea1cmr1365741qkj.33.1707486030222; 
 Fri, 09 Feb 2024 05:40:30 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 c10-20020a37e10a000000b00783df788230sm715758qkm.126.2024.02.09.05.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 05:40:29 -0800 (PST)
Date: Fri, 9 Feb 2024 08:40:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Selvakumar Velandi <selvakumar.velandi@olakrutrim.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Added FDT PAD memory size while reserving memory for FDT
 to avoid some memory corruption issue
Message-ID: <20240209134027.GN1152441@bill-the-cat>
References: <CAJ-dvqwMWvWw0=34ZLkG37MwTRG1m_tabSi0zLkoHNY8CjR_PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2wsJ30fwnhDYwl9K"
Content-Disposition: inline
In-Reply-To: <CAJ-dvqwMWvWw0=34ZLkG37MwTRG1m_tabSi0zLkoHNY8CjR_PQ@mail.gmail.com>
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


--2wsJ30fwnhDYwl9K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 01:22:08PM +0530, Selvakumar Velandi wrote:
> Hi,
>=20
> Issue:
> Linux kernel getting crash after loading kernel in VM system using RISCV
> QEMU.
>=20
> RootCause:
> Memory corruption in uboot FDT memory while launching a VM system in RISCV
> QEMU.
>=20
> Fix:
> In the board_f.c file the FDT memory region is reserved without FDT paddi=
ng
> bytes. uboot will add some params like bootargs while launching linux.
> While relocate the FDT, if its decided as run in the Fixed memory location
> i.e fdy_high is set as -1, then the padding bytes not added while
> relocating the FDT,

Do not disable fdt relocation. The RISC-V platforms which do this today
are broken.

--=20
Tom

--2wsJ30fwnhDYwl9K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXGK0gACgkQFHw5/5Y0
tyy9/gv/QdOM+UH3pQpFduJUZQnCmQ423Ng3KYms2RwUMjdntDOMrdQoAggP/dUP
YeuHeiupixs4nmqotdzEqmFLUS/4jxrphtRnt3Z4WGb068DqJjJ56CpTcLOFRT/2
TwbesHM66pd1PGvAnq0/isbyRF3Sa1ooN0uDbqf2z5V/nkPVJybIDtr0uGLXhPMQ
Z+jjDPX+8d6MOeUdg3KPK8VLSx1Db585xGGRBL1uIjaq1LFtAEjlnau3Gf3QTG+6
olAivS+npK7aWoR5iR+yFw2ZMQ4JoBo5S4xx7w95B7BF1VZg3JPGnj0zLeSNP8Mj
9KxjWNFE7cuNF02P8rR+IqBv2I6BN6pck7kkQVimqVk4BgKpxguiS2NgilOsxofr
3nOmJo3M99zvwElc3tebutbGdOjgC4cAvn5hmpW+Z80ENF4R7Omf+K1lEkJpA6Tk
oXYQ543m1PuMueGOssuhrExgDIjvwb9kLiSJb9mgLFRaFHEgL6W+LazbxouT5dbc
kjnrVSmF
=WNcd
-----END PGP SIGNATURE-----

--2wsJ30fwnhDYwl9K--
