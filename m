Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C394FE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 15:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40B8983946;
	Thu, 19 Feb 2026 16:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qnjIu77h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E29283A47; Thu, 19 Feb 2026 16:31:08 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FDB80050
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 16:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7d19d3c7208so753310a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 07:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771515064; x=1772119864; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AW0yJseXEE3gNzB/E1S1OKec7WwpsJ7atVE7UNHIdqo=;
 b=qnjIu77hwZo+j2mYfVo8fb88rk5DyXLS1I9VDHwl4yp15Pxv/5TnFjbP8Hy0puwMK9
 JMyoqk6ApvYjIqJ/uEbIOyMzrNq4LG5ad12nD/lgomkx6vmDUSHh1KPr94m1LJqpZxfG
 XqB3fW32cOVRm5IbtY8i9ucE9ziVtE8DFJNfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771515064; x=1772119864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AW0yJseXEE3gNzB/E1S1OKec7WwpsJ7atVE7UNHIdqo=;
 b=BRSR1BQME30WxXJFl+ZxqGWm6KoRIc2DQbZvYHsZkJgtf9P+Lp1mJ+s4K/5pUPzjSs
 lsIuDFenCOPMQ6gbDR1qmHIjBdcYLVIl8yL0krjsZ6rxKv+Icajgx7jrhBrte1BvF7za
 N/utME1HxX1ENdDWJlGTr4UVSBEQZ/texQLorkyh8Z6jCX/ZQa8Ig3Fw3uhLUJ57s40h
 emURKM5v/1r4bYMpKWWvmMSu4ylQrbmM3KQlbSThSPYC+3ixF3ZVTi1zB87IRo90iK/G
 lo9K8iJGsjxNBPFGEsraz8OtSv+PlAOu+vG3j1ZS/94VJgdKfs7s0WzDsx8QKRbf9LSr
 EzJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuiFo4aAsTGAMcL+f7WRXu0xSzcwtamneVvplCIi66AVcBtbjPeEiA14v8a5KDKHDPnnjWT2c=@lists.denx.de
X-Gm-Message-State: AOJu0YxT+vhW0TNePrBu6bZdUlxlOmfklAXsMs4hkbmXotGp5cQPn3AX
 Me8gnyOm1WEctznxsAojw6v3JEL+jbG2gFa3pbL/oRPKqsEi4UxWiy9J5zF8CKVfSyk=
X-Gm-Gg: AZuq6aJgkGIx+8eaz2T69qWBQHPISiHgssf9zOpYf02/K85MK1Osy/4bPut0P6avxYc
 yym1MRdSBMsoVbRAY0n+b8dy92XE8XReWUL/ZlWjL2/KeFObyAfaL3NE5P3k+r0Jq2x/kjBTvt4
 GqUduIH3D/CT+M3JvPJlHb+hGiZW9mUhUGQVP56demL92IdtJyYnZr2T/8PLxD77RSuCggL1/5j
 Ei0M2nV1YPuwvOnieyk5TiVREVBIGgO2E0ei5ObIpIxxgC4eWYwpWVwXuoQOfkl45LR3xIr1ume
 6Hd5//wNYTy1ZXlt7OOgGAiCeax90n0flE7mNi2eKxaYkqRCSGhmDAKoJXXoDB2e94aFhq6BUPk
 zqhf2eRlzWaS1mJ9YCLnNUPCVZZcyXUZOwHWyc7fWuIXqDTVVg+cvtGFizBdiYc+m+AE3nNxYHf
 pxpwaqmc4eTu0OQt4o3PnZM1vBDnGzW/YGVtyD8NhUMzJITSJZfF35EN+e8jFy82vNaw2MNsPUT
 OA2InZaOhYzHqC9ZaaZOPzWyjXX9VyY31qzh4twrl584oQNvMQ=
X-Received: by 2002:a05:6830:370a:b0:7c7:5f09:879c with SMTP id
 46e09a7af769-7d505e1a2b8mr3757618a34.26.1771515064483; 
 Thu, 19 Feb 2026 07:31:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm20478043a34.14.2026.02.19.07.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 07:31:03 -0800 (PST)
Date: Thu, 19 Feb 2026 09:31:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 13/20] boot: bootmeth: add OpenWrt boot method skeleton
Message-ID: <20260219153100.GL3233182@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <46dcab5fc58e9116ca017a63ed07922ae3093913.1771275704.git.daniel@makrotopia.org>
 <CAFLszTiE82Bo1PbvK7Lx7P4Gq=-z+hhgLcgXORtSrYha4R7sBg@mail.gmail.com>
 <20260219140002.GI3233182@bill-the-cat>
 <CAFLszTj9BzFK3hcRRGtwzZWBO39WwtLjbYJ9ajFQ_c2+rDU=FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="67s2jV7q+LmNp55H"
Content-Disposition: inline
In-Reply-To: <CAFLszTj9BzFK3hcRRGtwzZWBO39WwtLjbYJ9ajFQ_c2+rDU=FQ@mail.gmail.com>
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


--67s2jV7q+LmNp55H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 07:31:17AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 19 Feb 2026 at 07:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Feb 19, 2026 at 06:09:28AM -0700, Simon Glass wrote:
> > > On Mon, 16 Feb 2026 at 14:23, Daniel Golle <daniel@makrotopia.org> wr=
ote:
> > > >
> > > > Add the initial bootmeth_openwrt driver with:
> > > >
> > > > - UCLASS_BOOTMETH driver, compatible "u-boot,openwrt"
> > > > - check(): accept block devices via bootflow_iter_check_blk()
> > > > - bind(): set BOOTMETHF_ANY_PART so bootstd iterates all partitions
> > > >   without requiring a filesystem
> > > > - read_bootflow(): stub returning -ENOENT
> > > > - boot(): stub returning -ENOSYS
> > > > - Kconfig: CONFIG_BOOTMETH_OPENWRT depending on FIT, BOOTSTD,
> > > >   BOOTM_STORAGE
> > >
> > > We don't normally write out this much detail in the code
> >
> > I assume you mean the commit message? And yes, this reads like an
> > AI genreated (then human proof-read) commit message. Which is something
> > I wanted to address, once done with the open questions I still have in
> > the cover letter.
>=20
> Yes I meant 'about' the code not 'in' the code.
>=20
> You can normally fix it by asking for prose, or giving it some general
> instructions.

If that's even a good idea, sure. Some of the policies I was reading
yesterday disallow having the AI generate the commit message because the
human should be able to read and understand and explain the code.

--=20
Tom

--67s2jV7q+LmNp55H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZcstAAKCRAr4qD1Cr/k
CgflAP499+gQRO6Uu0+2eV8bl7S5DSEI0Lwdzj7dDd5Flt360gEAksUPXkHmzafD
BAyCxFpqDLElR584L1zMbCibV7fCaQU=
=CFLk
-----END PGP SIGNATURE-----

--67s2jV7q+LmNp55H--
