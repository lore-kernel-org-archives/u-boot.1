Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F50F357AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:28:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A1B83EE2;
	Tue, 24 Feb 2026 15:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="acQW7D1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCB5D83642; Tue, 24 Feb 2026 15:24:54 +0100 (CET)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35EBC82A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7d18d0e6d71so3789249a34.1
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771943091; x=1772547891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5Ai1AUT5nmehN4PhvIv9IheDl7zW3Q76MkE8sFwaU+U=;
 b=acQW7D1NUUjH1ylXnguFDLLA82LazcGwdPwbemadoZnVhznPPv/spRWJSSSdNTtfnI
 3iwEheejt+f9CZLqAB54GGjSTLidEiBOC5P6ZszxR4OJkiKq/pBNBA9veA4A3T4Nlkzl
 Kfu62EL5RM9+9a2RK+GZiwY0bVVGNDn5rd4tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943091; x=1772547891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Ai1AUT5nmehN4PhvIv9IheDl7zW3Q76MkE8sFwaU+U=;
 b=EUPMQBMa9husxuy/ONpry4qHdVt4+pmgMFkAc5qiMEgT9Qjb9oap6I/lsfTOi1f4I/
 g4kBNXdrtQw7DQZT/swc0VcmSg+gSZHy4GEzHt9O3iJnESTUmYpsM1sUX9geH+hznhz3
 BfqqMgtruVePHgwmM052zw5twTsHifPQMZDrXUixNiNHR96NuoGj840PEhDMbsT33KEz
 VqBv3d7zPp6GGY4eqUEHJ99gtQtyky1DOamB1O7RkAYAq2MiiuvlZzpu1fSJuJOo2Bth
 Tf3QrAgRhNYnzzmMg6xK3+AV8Sabsqa0MTYFM6XUgo7/WpTR0mTbiMBaoMbMdkc4AG6t
 WoMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyFeEHPqv5Z73LWc8AZpANPiLrXfz3EE042OFp5yJhTAXeCd4wh++U0DRk58ULv5QS6FU1ZQ4=@lists.denx.de
X-Gm-Message-State: AOJu0YzcsAQMQMA/uJghWAimPXoql6m3soMi/Ym3EljqX30Q8naGMOv0
 4akYv2cNT0o1aeAVh2BcGHPAyv/p+jAvBfTSzqDsQ4Ds/m0LexNDnGjivSpid9gcQps=
X-Gm-Gg: AZuq6aITgb8P6iIFXHHZnOmo/jgxIaTqdlz37vw8KMuGOKIdWpgJPXwb7y6N6AcxlsV
 w8e63w+wv4zSs315XUzvDsvUfz4EVEF+7MN97a6bDY5L/QIZlMT0fO3Ul+LuEOhWoaPyBfLA3gt
 jUjr8rLjq3fBIkCwVhmvZLn1XlWwkVM+N9ME6H3MsiIV3l0YYiTqKGMcOrqVGt4YWe7ViWACttH
 C7rmsGNLf+h/GzpLvCAVDp/Bs3q8EERt/nWqvbo5MH6iGn5C36UcGCc7tA8zSUJkWMUMFnoBpf2
 PqnhDmjiXCFCKfjD5LoHXYAOSIyuNy8jT+Aw+NTo8ywqylAAPbTW+NC6UhQMukv2E6EI+I/Ryxf
 z0seoU81UCD3T80gVKYU906YiJ0nNV/UF4GluLBC7wtbHeuY4b4EhLlpOLH8hit7UgrobFAQ0eP
 qKOPgzgk8oK/uiE2E0zGOxSVRqIMUyGnNBZiN7fRsNxdDAlu21H066tKHOzVTRjLWFP9Z3o1nM8
 Jw4Ly2U7dasCxJR50C26aVdGapxS/6gRrio3yvKCyc7CIvOXoU=
X-Received: by 2002:a05:6830:2b25:b0:7cf:d9ba:c99b with SMTP id
 46e09a7af769-7d52be3dd53mr9358479a34.11.1771943090724; 
 Tue, 24 Feb 2026 06:24:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm9797616a34.22.2026.02.24.06.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:24:49 -0800 (PST)
Date: Tue, 24 Feb 2026 08:24:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
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
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260224142446.GO3233182@bill-the-cat>
References: <20260217181358.GE2747538@bill-the-cat>
 <aZTBQykqCt7H8H4W@makrotopia.org>
 <20260217193534.GI2747538@bill-the-cat>
 <aZTYk8E6r4S5zo_Z@makrotopia.org>
 <20260217211853.GJ2747538@bill-the-cat>
 <aZTqyRfqYe1iJ9EY@makrotopia.org>
 <20260218155839.GC3233182@bill-the-cat>
 <aZX2APcJvmU4XSIy@makrotopia.org>
 <20260218203314.GG3233182@bill-the-cat>
 <aZzyv1sUrnm2PKBc@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hY/m+R2EfOyCV7kq"
Content-Disposition: inline
In-Reply-To: <aZzyv1sUrnm2PKBc@makrotopia.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 24 Feb 2026 15:26:41 +0100
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


--hY/m+R2EfOyCV7kq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 12:37:19AM +0000, Daniel Golle wrote:
> On Wed, Feb 18, 2026 at 02:33:14PM -0600, Tom Rini wrote:
> > On Wed, Feb 18, 2026 at 05:25:20PM +0000, Daniel Golle wrote:
> > > On Wed, Feb 18, 2026 at 09:58:39AM -0600, Tom Rini wrote:
> > > > On Tue, Feb 17, 2026 at 10:25:13PM +0000, Daniel Golle wrote:
> > > > > [...]
> > > > > As the existing code expects the whole image to reside in RAM and=
 only
> > > > > take care of validation, decompression and relocation, I had to e=
xtend
> > > > > image-fit.c to use the image_loader to only load the parts *from
> > > > > storage* which are actually needed, and if possible, load them di=
rectly
> > > > > to where they are supposed to go. Imho, the code is simple enough=
 to
> > > > > just look at it:
> > > > >=20
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/ab7837536e4567b9=
0d7cb662984dd7e637ef4361.1771275704.git.daniel@makrotopia.org/
> > > > >=20
> > > > > At this stage (because I first wanted to discuss the general appr=
oach)
> > > > > the patch still skips some parts of image-fit.c, which is obvious=
ly not
> > > > > acceptable for upstream inclusion, but good enough to demonstrate=
 the
> > > > > idea and also try it in practise.
> > > > >=20
> > > > > Ie. the 'goto storage_loaded' has to go away and all of image-fit=
=2Ec has
> > > > > to be changed to equally work on RAM-backed or storage-backed ima=
ges.
> > > >=20
> > > > I was talking with Marek to recall some of the details about what w=
e can
> > > > and can't (easily..) do today with external data and he remidned me=
 of
> > > > something. So one big concern here is that we have to be care to not
> > > > re-open things like:
> > > > https://nvd.nist.gov/vuln/detail/CVE-2023-39902
> > > > or otherwise allow for mix-and-match type attacks by having some so=
rt of
> > > > partial reads allowed.
> > > >=20
> > > > So a specialized partial-read of FIT images, in full U-Boot (not ju=
st
> > > > SPL), is something to figure out, but may also invalidate one of yo=
ur
> > > > design goals because you do have to authenticate the whole image, u=
nless
> > > > there's something both secure and clever I'm missing.
> > >=20
> > > The idea here is to have one or more IH_TYPE_FILESYSTEM subimages whi=
ch
> > > do not have hash-* subnodes at all, hence, if there is anyway nothing=
 to
> > > validate and they do not need to be loaded to RAM (ie. no load addres=
s),
> > > they can be skipped entirely, even if listed as 'loadable' (which is =
how
> > > the parser in the kernel currently knows which filesystem image to ma=
p;
> > > we could introduce a new property different from 'loadables', of cour=
se).
> > > Everything else which is part of the selected configuration node of
> > > course has to be loaded and authenticated.
> > >=20
> > > To compensate for the authentication of IH_TYPE_FILESYSTEM subimages =
not
> > > done by U-Boot before launching Linux, the dm-verity root hash passed=
 to
> > > Linux via cmdline should be part of the signed configuration, eg. by
> > > including an image of IH_TYPE_SCRIPT modifying 'bootargs', or by comi=
ng
> > > up with a new image type specifically for that purpose. Or, even bett=
er
> > > but a bit more involved, include the dm-verity roothash in the ITS sp=
ec
> > > instead of the hash-* nodes.
> > >=20
> > > In terms of security, anyway only dm-verity makes sense, as there is =
no
> > > point in validating the filesystem subimage if what is validated then
> > > isn't also what is used -- one could quickly swap the storage device
> > > after U-Boot has launched the kernel and before Linux mounts the root=
fs
> > > (from storage!) ending up with a different rootfs than what U-Boot had
> > > previously validated when authenticating the image.
> >=20
> > Right, OK. What I was thinking about, but Marek corrected me on, is
> > about where we may or may not have problems about authentication. So
> > long as we start by reading in the whole of the FIT (which excludes
> > external data, being external) and start the authentication with that,
> > we should be fine.
> >=20
> > I have some other questions / concerns still, but there's also still a
> > number of other emails I sent that're outstanding. So, can you please
> > link to an itb that would be making use of your proposed feature? Being
> > able to examine that would help me be more precise in my own questions,
> > thanks.
>=20
> I don't have any option at hand to host larger binaries anywhere public.
>=20
> If you know any service which allows to do this for free without
> requiring a complicated and personal-data-exposing sign-up procedure,
> please let me know, I'll use that.

Can you use https://www.file.io/ perhaps? And split as needed.

> Meanwhile, as the content of the large data blobs probably anyway
> doesn't matter for this discussion, here is the decompiled FIT structure:

It doesn't matter but it does help me when poking around. Thanks for the
dts dump. But please note I had a several other questions still open. I
tried to not complicate things by sending them as separate replies but
maybe that made them harder to see? Thanks.

--=20
Tom

--hY/m+R2EfOyCV7kq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ20pwAKCRAr4qD1Cr/k
CuvAAP4rMqn8aOzTaNdo3sMbWqhiYa8icKXmUoTgvh4LaR3+4QD+Ola/igdA0sp7
ZTtzohywHQQqZO6YKtf1l4KeTLte/gQ=
=Sjrk
-----END PGP SIGNATURE-----

--hY/m+R2EfOyCV7kq--
