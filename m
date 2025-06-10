Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98FCC61DB2
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 22:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1682382A4B;
	Wed, 11 Jun 2025 00:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RGq6ozvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 441BB82B18; Wed, 11 Jun 2025 00:46:28 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04C6580050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 00:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72ecc0eeb8bso2076938a34.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749595585; x=1750200385; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rUbnVjGGueIST1R9XDzVdqVsqUl6A40VdwdRaLQynwU=;
 b=RGq6ozvj3R1U/03FeYJJ8OLXro4f0wNpSpCibEqzL1HNMk03mcNldgjSEvfW2NjXur
 vxRtphKgKvG/s9XNPSJpo5HKRYxp5Bn5WYlZ5X/6veeuSa9jZecwoQpYCS1QT7U0H/Os
 wn4nDUEex/uWLf/AHRLINVT8SoECSJYHZbW2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749595585; x=1750200385;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rUbnVjGGueIST1R9XDzVdqVsqUl6A40VdwdRaLQynwU=;
 b=S550trFYG1Etmv/KS4DH1QWUhwx1zrfoceDdi8raXa4LKvHH7nbJ1qL6NfzvOlx/fB
 PNl7//mgBGQz1JKkLkkICWxa3AaTkv+RoKmiY5Xgbzrb1SgmdlJpK7yGPU5Z8Ns8nE0h
 A0bllA7knuzSbh40M1Ykng6P3IArfxqreogfH3kyLsbrBqVqasecneW8I6ahRCqJ5MYx
 Y98MDx8ZQ7JMC5kKTdQkJDejgvWKpGIvZPYMRtGmEDviR0RNV2eHQ/b/ln2ar2/zQ85R
 que4ymVyAIWHM8dwxRNxtAG54wn6qm/15mDkAu/LgGt6WU/jrFcXPY3WW8Jcc0U/c8yb
 U6Vg==
X-Gm-Message-State: AOJu0YwwzMWbJldjBROU/kYYYO2rL8Qp19pz/dcD06Cdg87h5Pn6y6pz
 XZRifqXVnwe5PBDOzaq1lHE9TZ8k2tKrNG6hD/MnRJ8PVl5Z3F5pQhan4BV9NMU2hj0=
X-Gm-Gg: ASbGncvRKq6NxoeNx4xqcWTsheRQBmltpAALOxiNa9OG/5Q1lwfHYvD/9fwzt/NC4z3
 yHFPS8oRpzpY9eCCHT8qqcyCXHHKEDTu3BA3iUA6hz69lcm/6ZrGyNVxSEX2Kn0wk/wFgXFcsi7
 pYivqsdOwz9vWKuDRAXiy/mufsCaGV7Jg9x7+WsLHuelFCZJN76BVsRKvxbbwJpXTGNvmqVmUOv
 Ov32sgmlOxmCNvtl8s/w4hGf2S6s/8jfDWtpAjnDW2MXgUCmuCW+sDu74rWdolGm46PEQdmaeSI
 0C0GjMlGqY8ctRwjL8XSy/l8gUTrWjq4ayqhg/aWwDm4QbOxUPYKl4Fi0+/b54PfdV2Ky1CM1FN
 KAj6n66pJILCy8r4/1ii4uF4=
X-Google-Smtp-Source: AGHT+IH+nr+OJPSzz5i0fjG9oHOLMrhdrUkvPfXSFeLk732Wc1su+b1J9xzSFVfwek4sFV1jFNITBg==
X-Received: by 2002:a05:6870:2404:b0:2d5:2955:aa66 with SMTP id
 586e51a60fabf-2ea96ba785amr620100fac.1.1749595584653; 
 Tue, 10 Jun 2025 15:46:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ea071253c4sm2581257fac.21.2025.06.10.15.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 15:46:23 -0700 (PDT)
Date: Tue, 10 Jun 2025 16:46:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 07/10] board: ti: add default dtb for am62 in falcon
 mode
Message-ID: <20250610224621.GF1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-8-anshuld@ti.com>
 <20250606190956.GA1382132@bill-the-cat>
 <DAHTVJ8QOH6P.1VUE8A6ES0CRJ@ti.com>
 <20250609145716.GM1382132@bill-the-cat>
 <DAIRTBR6H2UR.3D9X1G3AV77FZ@ti.com>
 <20250610144624.GZ1382132@bill-the-cat>
 <DAIZEBF8NRLV.GPI5TVNOPT1Z@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jKRNH6vr3kHVcU4m"
Content-Disposition: inline
In-Reply-To: <DAIZEBF8NRLV.GPI5TVNOPT1Z@ti.com>
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


--jKRNH6vr3kHVcU4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 09:37:54PM +0530, Anshul Dalal wrote:
> On Tue Jun 10, 2025 at 8:16 PM IST, Tom Rini wrote:
> > On Tue, Jun 10, 2025 at 03:41:21PM +0530, Anshul Dalal wrote:
> >> On Mon Jun 9, 2025 at 8:27 PM IST, Tom Rini wrote:
> >> > On Mon, Jun 09, 2025 at 01:05:36PM +0530, Anshul Dalal wrote:
> >> >> On Sat Jun 7, 2025 at 12:39 AM IST, Tom Rini wrote:
> >> >> > On Tue, Jun 03, 2025 at 07:54:47PM +0530, Anshul Dalal wrote:
> >> >> >
> >> >> >> The SPL_FS_LOAD_ARGS_NAME config is used for the arguments to th=
e kernel
> >> >> >> (dtb in our case) in falcon boot.
> >> >> >>=20
> >> >> >> Setting it in board specific Kconfig allows us to reuse the same=
 config
> >> >> >> fragment 'am62x_r5_falcon.config' for all 3 platforms for enabli=
ng
> >> >> >> falcon boot.
> >> >> >>=20
> >> >> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> >> >> ---
> >> >> >>  board/ti/am62ax/Kconfig | 3 +++
> >> >> >>  board/ti/am62px/Kconfig | 3 +++
> >> >> >>  board/ti/am62x/Kconfig  | 3 +++
> >> >> >>  3 files changed, 9 insertions(+)
> >> >> >
> >> >> > Why can't whatever is using the fragment also set this? Is it bec=
ause
> >> >> > you're only using this as part of say:
> >> >> > make am62ax_evm_r5_defconfig am62x_falcon.config
> >> >> > ?
> >> >>=20
> >> >> Correct, having three different config fragments with only changes =
to the
> >> >> dtb path doesn't seem very useful imo.
> >> >
> >> > Then these belong back in the main defconfig itself I think.
> >>=20
> >> That's not an option since SPL_FS_LOAD_ARGS_NAME depends on
> >> SPL_OS_BOOT[1] and due to the way config fragments are applied. Since =
we
> >> only set OS_BOOT to y inside of the fragment, we can not define any
> >> configs that depend on it before that in the defconfig like
> >> SPL_FS_LOAD_ARGS_NAME, it would just default to "args" instead.
> >>=20
> >> [1]: common/spl/Kconfig:794
> >> config SPL_FS_LOAD_ARGS_NAME
> >> 	string "File to load for the OS kernel argument parameters from the f=
ilesystem"
> >> 	depends on (SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS) && SPL_OS_B=
OOT
> >> 	default "args"
> >
> > Config fragments can be nested, so maybe the falcon variant will need to
> > include the main defconfig, the falcon fragment and then set the args to
> > the dtb.
>=20
> So we add 3 new defconfigs for each platforms that include their
> respective defconfigs and the fragment with only the dtb changes?
>=20
> That sounds good to me though why not modify the Kconfig's directly like
> I did in the patch originally?

The problem is that just because we can put values in a Kconfig file,
and are much more relaxed about it than the linux kernel is, does not
mean it's the right place for values used on a single platform. We do
have a few anti-pattern examples of this, but they should be fixed and
not expanded upon.

--=20
Tom

--jKRNH6vr3kHVcU4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhItbkACgkQFHw5/5Y0
tyzA6gwAk7wHKAuuSvtihm3BTfejr2UfF7jDx+SzhQHEg5y+Jle4gn9xbGb53Lyq
NLfR2v1pCkuCJBPA9lYhHeOSKcG6TJcyHKnjEz0B8hV8f3cxMMWjp8aAPz/lMu6N
5f1R9iAanogAGJpUPpVdWvAVlTmyO1MG6Gx3zrWrZVC3aCHFaNeSxR+A5cKFx09c
wQNcQqovm1DStfkpj8JLJOF8N2w3Zgqtw8qK5rL+ZjyyyuENFrv5ka46XqoZnklU
Ov0ra2CtEJvzZ+j1PnIr9HdWfHMNH7dGNZP4CdXXxkzA4yGtarFyRUCfbXIsX2id
7Ty9HQJ8CEEXQNWabTae/F7OLXaHBoB6XBJYOlePAZYk1G2cZS9wEXV0URBa+477
vEzQS2nFeiApzeD3r5oRXK7qcoWFeNZmnU4u7EVj8bxwupfKN/lgEMSqBHAtEJzI
52Lw1fQWta45ZqecoV0H3FwxLCMcHI7PjpYjBg1fNjbZdHCkd8NcHry1pUbEzqY0
VUUZVLiT
=+zTu
-----END PGP SIGNATURE-----

--jKRNH6vr3kHVcU4m--
