Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0688606A32A
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nnLTup8k;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=J/Yim46r
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 903AA4074C;
	Wed, 25 Nov 2026 15:51:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MyzmXQeub92D; Wed, 25 Nov 2026 15:51:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 90D59405A5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795621887;
	b=NWP5wo6pE9evqEz0QGF4nXHIqkmk3lkKLjq/uSmq6takq8QOPnzbRcnBMc+RqearYcLW
	 +T/18VkhZeQHC5FCYjigYriIcASjcfcF3dalWEIwd/Qu4Kl5Jby4lVdZbZHYmFhpm/wgg
	 CiK4yAdUMO5t5faqK9bxk97kiWv0R4V+96foBZcc0bWPG0POycVZpTrw/vGUUfSQUsRNT
	 4EDeHSROYxyCc/vq0fuPJlhmlJuRjs03inG9v1WixaQKtAx5+sHkEUVYhiWxUu72J9vW5
	 /eQq19KC5JWhlFle7TIoOSnOQdFE1uOfkwOwJHoxw8jKtc4KKoQGgqjU7KdyMmzQ5vA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795621887;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zt6XfyO9ZBxEJkNd0cOYo5OsTXwhDkzYh9+XuI5lifM=;
	b=bgtyICd+fFOA5F0DygpMHrQ1083tlSQZ/8Barg2e9fgMyn9ZhQRmkGMD7y514hN5KmD3
	 ZaJmYHLblpCuyfxm9Wj+sGQ7VQN77ESyyBnd2pnERQfNOx2eUvRq5yUUylXMFMU+1tE09
	 DX7XyPpySz88qriIackzJgx+zHMeA3PVme73KINmIOX9t0eIBirzsz8bxXcl7HsDzidjh
	 baG7L9LKROq3XD0CV6qOgjMod1Fghn+G5Vuk5t9S+Y/lLNTQO/E/ImUnAOQiXLzCdwJ85
	 onJjOl4A2fxFxtjPF+b0ougUduiczDSS7fAMKRGrvQhEmQLQJy5ldMV0NNTfzA/xe0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795621887;
	bh=zt6XfyO9ZBxEJkNd0cOYo5OsTXwhDkzYh9+XuI5lifM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nnLTup8kDKcDAHMLIebTQUO4+k6fNmyQSp+HLMA9UFWFKu6KmSrPr5GfZ3RbBJukW
	 XCSpyXZ9JyJ4XoaCY5wdvreUri+yxUOuAZVZDC11EBiqPz0m235hKjuUiSoHIrJJBV
	 osOzJd0KAOdpEqv6Gm7t8mR0shcv9VClQUFvZq/d4O03Jd+jO5vicv0rb0IcEIDON/
	 IZUvDwT3RVmdpPXA75HSeuek/WFaDd4ABCL8nb1h3H1gsSgKaLkVzf6O4Fut0Wl8VB
	 ZlD/WlMdftbMDNtDVrrHXcPslv6xmPRQ/aeySwWtWDhvhG3PVQvXtEwJhh45fNiyZh
	 wyx9w4XcI3cMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90D59405A5;
	Wed, 25 Nov 2026 15:51:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BABD32D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69958400E6
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9d9MmHutja6G for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 15:51:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7151A400CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=J/Yim46r
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7151A400CB
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 15:51:25 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-71ab5e64742so3584290eaf.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795621884; x=1796226684;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zt6XfyO9ZBxEJkNd0cOYo5OsTXwhDkzYh9+XuI5lifM=;
 b=J/Yim46rW+kesbjtd1QlnWKekcJVmtk+rdUtef8Wx8QuzI7WpdWExcs4plQMQ6uPJM
 mZcVuEo8nNRNLlKupcei9b1rnYCFJeiZZtrm4P5KSMRVjHjMup3AbmQqsNYESK3boQ4A
 Zi8mHkhzqR/jkPLTGCysSBD5/s8Za2Gv7pAt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795621884; x=1796226684;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zt6XfyO9ZBxEJkNd0cOYo5OsTXwhDkzYh9+XuI5lifM=;
 b=WKDjCr6cDWBBMzNpQKd7/6Cq1cfCTzHjuMj9cHQH/y+mwvHWLqOaidzcOOe714KSjM
 iCrKeXYKX+eu1k07t33/tBO08IdqH2mlIPJk5UFfRvk44OzCabqsLzYL6vDwisHCBibI
 8GDGThAekkFUIvy1M4fEqpkT8tEV1TLNoQH4Jz7lB+9+kcBRFimyukM6+Q5SQ9J4EChc
 XSa6zhpqzgeUlskRJ3Ybrljf1Asqy4krBG0g3vp+3DM4wparzmMWbLNONLho5pD1w+kI
 sE+fqh+kAUwwY1b09MHymtKXYFrSjDhlRBIXoFgB/Y3uQVstZuHpZ7DcTyCZ5kGDmgFQ
 3NEA==
X-Forwarded-Encrypted: i=1;
 AL+hErG3PfPQzwygFg3KrRm4jsFvGcArQOCkSt9ky/oEb5QGlIANdTSnmndBzQCgg8NL9vwrBgBsZKk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z89i5+dnMqhKBDrQJcHRM3nEYjEOSxsrvvPzzBeKecWXjYnSHW8
 2amefRTVGDFG/eWFLlxxA0wp6FW4zjxmUx9/gUropvCHJMLKaIOFwqGRkanuH98+HQ0=
X-Gm-Gg: AZFdTZd8H9gvmtTjVoUSvw79y5IX8xoa9NEJ/ZMgc0rT7+mxvFLL5W+bnFL45jWE2Jr
 YHcGTK0ob6munJim0TQ3fAJJR2yU0eG7ZQCjLd8I8dzwGrv9kC1AqydaK9fRwoVyY5EOuTK6HJC
 5j73fBqnbGZjihxdk3nnqS951+XPL+ib722/zH2nBfnKpQsOyiz1YD+IFzTgXcUC7b88w6wMIO0
 nznT1TZlHQsQVFAhI2RhANFyR7f4cLifHmnOVDRCS3eFKJBvcGyk4MwsOL3gNGtmAiElkbrCO5o
 Vli1Cut8scMOAW/EZ5F7pJiePD+5xqypeBL5vqFFAMCqPUXTuBKkof5wz4AeyYRCCOYlfTvuYtr
 zCR3M5X5BqMK/tipcz/3G/oNSHM/PO1mrmNq8BrQB9Lf/UIlVu2UezhoVqm3CZxgejS6nN3pkRP
 K9OkhlDIZGmvHp04nCi7HV3cin+T4RGKJt3kF4UVZ/pNLZArkdwEvARRoU7ZcGT6jela3JcfMcv
 8Ooa0/a1w0upTv8Kqy3XvFNsI6d0cdl4PmpFBFHoo4a5loFg0sSQYY9xtSWfIPadDd0Yn0NLCp3
 kFj/hbaG6s7jQYJHdIPI2u6H5aZwt/+DikY6pEnNUmsp/MJ+BQ4kZ8NY2oVUMReZc2XKS8KiN0C
 flsOW90NvYABmT3SBrHqg1irGZZg6xCyzQqS+0ILLMwPf/3BxPthMkWNNmbQg7j4idPwyWGt+i8
 e9ay5gInXamGZM5g12R5pusEniMOAHdbRp
X-Received: by 2002:a05:6820:612:b0:71a:eb23:a7da with SMTP id
 006d021491bc7-71b39521213mr15418841eaf.31.1795621883973; 
 Wed, 25 Nov 2026 07:51:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5ebdc0bbsm15822050fac.6.2026.11.25.07.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 07:51:23 -0800 (PST)
Date: Wed, 25 Nov 2026 09:51:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Bradley Morgan <bradley.morgan@linux.dev>
Cc: Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Qu Wenruo <wqu@suse.com>, Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] Avoid 64-bit divisions that need __udivdi3() or
 __umoddi3()
Message-ID: <20261125155120.GG3176972@bill-the-cat>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
 <5D58F095-45B7-4BA0-A25E-2D65AF893947@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gO3bzhjyIoDqAEfy"
Content-Disposition: inline
In-Reply-To: <5D58F095-45B7-4BA0-A25E-2D65AF893947@linux.dev>
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


--gO3bzhjyIoDqAEfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 03:45:12PM +0000, Bradley Morgan wrote:
> On 25 November 2026 12:42:53 GMT, Josef Schlehofer
> <pepe.schlehofer@gmail.com> wrote:
> >U-Boot's private libgcc does not provide __udivdi3() and __umoddi3().
> >v3 of the mpc85xx LTO series links mpc85xx LTO builds with it and added
> >both routines [1]. Christophe Leroy asked why the callers do not avoid
> >'/' and '%' on 64-bit operands instead, and Tom Rini asked to update
> >the common code [2].
> >
> >Patches 1-4 avoid the divisions that make the mpc85xx LTO builds call
> >__udivdi3() or __umoddi3(), in btrfs, squashfs, mmc_berase() and
> >get_win_cnt() of the mpc8xxx PAMU code. They do not depend on each
> >other. Patch 5 removes fs/btrfs/dev.c, which nothing uses and which
> >holds another 64-bit modulo. Patch 6 converts the remaining divisions
> >in btrfs. U-Boot never runs them, but builds without LTO still link the
> >ones in the RAID5/6 code. My reply in that thread announced these
> >conversions for v4 of the LTO series. They are sent on their own
> >instead.
> >
> >Patch 2 and my big-endian fix for squashfs [3] conflict in
> >sqfs_read_nest(). I will rebase whichever of them goes in second.
> >
> >Build tested with a buildman world build on a fork's CI, and sandbox
> >test.py gives the same results as before. Run tested on qemu-ppce500
> >(btrfs) and qemu_arm (btrfs, squashfs, mmc erase), and on a Turris 1.1
> >with the mpc85xx LTO patches on top, which boots from an SD card and
> >loads files from btrfs. The PAMU change is build tested only.
> >
> >[1]
> >https://lore.kernel.org/u-boot/20261119133310.22732-5-pepe.schlehofer@gm=
ail.com/
> >[2] https://lore.kernel.org/u-boot/20261119200924.GB3176972@bill-the-cat/
> >[3]
> >https://lore.kernel.org/u-boot/20261125095537.37979-1-pepe.schlehofer@gm=
ail.com/
>=20
>=20
> Thanks,  after review, who will merge? Me? Or anyone else up to?

I'll pick up the series, once there's been enough review on it.

--=20
Tom

--gO3bzhjyIoDqAEfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawcD9AAKCRAr4qD1Cr/k
Co2ZAQCrLxPCi462jYPTwB46o2Pq0j8BKCXleLBRKmGh8onO3wEA55MQfuEdgQP6
E5H9kdE1mdNH/FuB1VrU0ma3lGDRhAc=
=XI22
-----END PGP SIGNATURE-----

--gO3bzhjyIoDqAEfy--
