Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33770C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 17:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 661E384374;
	Mon, 24 Jun 2024 19:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HpaKzmCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B62EB882BE; Mon, 24 Jun 2024 19:28:45 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C2C2809A8
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 19:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-700a7b3d6bdso1303734a34.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719250122; x=1719854922; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5CHZXWLo4S6t88TIgcubDaOu8BjzxXLRc9KZTi5SrJ0=;
 b=HpaKzmCq0P4mIdDD0Sx7zvQVvJJWNG0403eqB0JqSY3wxf6K8kC9Zxjn/7nMtYi9OA
 kautjCqYxbIkLH5d7quWej0iRMBjs2AuI3VXrivZ3wpJTx6mMOfguWOJrHOXLuQ6UD3q
 EH2pK6odhUQ83XXSoauZVTJpTQ3McID3df7Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719250122; x=1719854922;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CHZXWLo4S6t88TIgcubDaOu8BjzxXLRc9KZTi5SrJ0=;
 b=ojrFT7aY3ow+gR+faB7uYFT61BhblDGhVLpsemiJMxcoBS4f2cF6YP0mv2EPrLf42W
 2lH74ZxOWrDgi6cGik1Dg6ZI+vEJpZQiBpFnlpplvn5J7QcqKXJg73kLEJ9g3CyaoTRG
 Tgp+dkE9sxd3NTdaqHjrj4MXOhWBk3wqNyIgKARtoxXXDJdXtS6R5D0Yq0niIG+cHKNt
 0Y71XGZYy0tFcJ0yrJNaa1IM40Guj1QyTw8Py10jcsSmbV8pn14LVNop3k/yegHd3NBl
 WIy6dJNO+oYB/Jya07/lHhDMScC5trp/ofp5CnXIVzPAlEI8yoK8sUlH96q6Ksla+9Yc
 rSaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNTm/56ipafF9gVRXhqhV6ikav5o3g9Iuj/4zptE51LtvuaLgdgMKJd9fMmXAuK038DtZVS3mUKg/EPslHxAy+jdJg7A==
X-Gm-Message-State: AOJu0Ywn8YqUyz3tMokM3CKFay5Ntd9gGbDgkn2JLiCCRBG/OwU7Dtzh
 zg6okbgXaKYZ3+fnuv6VYldYzebrVuRfC0M5CdXFNALEVUdO6rNwi3M/+Ieplq4=
X-Google-Smtp-Source: AGHT+IGkAlvydtf/YBY2wvcsKnAvbZGMx8TL8R3xJAyFrQM150FOxHZK8aik7oePcmRJvkb2TMAsiA==
X-Received: by 2002:a05:6830:1390:b0:6f0:e7b0:ac1c with SMTP id
 46e09a7af769-700b11cbd68mr5731277a34.11.1719250122035; 
 Mon, 24 Jun 2024 10:28:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7009c5df163sm1281217a34.10.2024.06.24.10.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 10:28:41 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:28:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
Message-ID: <20240624172839.GE38804@bill-the-cat>
References: <20240619153207.GF68077@bill-the-cat>
 <CAFLszTiHSn4Vw7oMBOwOBC1gAHNYQ3Xc4mT54FkT-dfGSb0F0A@mail.gmail.com>
 <20240620231943.GT68077@bill-the-cat>
 <CAFLszTgA6Gc1T55v07skZQ3U=_JuM7yW9aTxmAtXsoLTbSOtdQ@mail.gmail.com>
 <20240621160514.GY68077@bill-the-cat>
 <CAFLszTi45oeCoLRQK_noh2dHXTMGGteadT83M9Ce9cC2fcR9wA@mail.gmail.com>
 <20240621191915.GZ68077@bill-the-cat>
 <CAFLszTjdDSVsMPTU0OU09JrD0Njxb6NXmb_KKk4gUXC_JAgv8A@mail.gmail.com>
 <20240621221209.GD68077@bill-the-cat>
 <CAFLszTi8YoYuNf2-c5TeRDMYGERBVm-w6kTX_B5uUao147Zmuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oSDNzc/OKZDuOnXh"
Content-Disposition: inline
In-Reply-To: <CAFLszTi8YoYuNf2-c5TeRDMYGERBVm-w6kTX_B5uUao147Zmuw@mail.gmail.com>
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


--oSDNzc/OKZDuOnXh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 03:52:12PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 21 Jun 2024 at 16:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jun 21, 2024 at 01:38:07PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 21 Jun 2024 at 13:19, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Jun 21, 2024 at 11:55:42AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 21 Jun 2024 at 10:05, Tom Rini <trini@konsulko.com> wrote:
> > > > [snip]
> > > > > > Yes, I very much do not like guessing about 3 numbers instead of
> > > > > > guessing about 1 number and using the standard mechanism we alr=
eady
> > > > > > have. Please use BOARD_SIZE_LIMIT as this is the standard mecha=
nism to
> > > > > > enforce size limits on U-Boot itself.
> > > > >
> > > > > If it were that easy I would have sent a patch :-)
> > > > >
> > > > > Here is the map for this board:
> > > > >
> > > > > ImagePos    Offset      Size  Name
> > > > > 00000000  00000000  00800000  rom
> > > > > ff800000   ff800000  00001000  intel-descriptor
> > > > > ff801000   ff801000  001ff000  intel-me
> > > > > ffef0000   ffef0000  000999f0  u-boot-with-ucode-ptr
> > > > > fff899f0   fff899f0  00005554  u-boot-dtb-with-ucode
> > > > > fff8ef50   fff8ef50  00000000  u-boot-ucode
> > > > > fff8ef50   fff8ef50  00000571  fdtmap
> > > > > fff90000   fff90000  00010000  intel-vga
> > > > > fffa0000   fffa0000  0002fc94  intel-mrc
> > > > > fffcfc94   fffcfc94  00000000  private-files
> > > > > fffff800   fffff800  00000070  x86-start16
> > > > > fffffff0   fffffff0  00000005  x86-reset16
> > > > > fffffff8   fffffff8  00000008  image-header
> > > > >
> > > > > What limit should I set on what?
> > > >
> > > > Is this a trick question?
> > > > $ printf %d\\n $(( 0xfff90000 - 0xffef0000))
> > > > 655360
> > > >
> > > > Of course since we're less than that today, you can reduce it by
> > > > whatever other magic numbers I'm not seeing but are part of your as=
sumed
> > > > sizes.
> > >
> > > That limit is on u-boot-nodtb.bin. Even with a size (for that file) of
> > > 634816 it doesn't fit. I need to calculate a size based on the size of
> > > the dtb and the microcode...which of course can change.
> >
> > Yes, and you're able to assume some size for them, which is what you
> > put in the dts file?
>=20
> I just put in a limit for the blobs, whose sizes are known.
>=20
> >
> > > > > - the U-Boot is the thing you are wanting to limit
> > > > > - the dtb has microcode added
> > > > > - the ucode is empty in this case
> > > > > - the fdtmap is variable in size
> > > > >
> > > > > So this all seems a bit backwards. The actual limit is that
> > > > > (u-boot-with-ucode-ptr + u-boot-dtb-with-ucode + u-boot-ucode +
> > > > > fdtmap) fits in the space available. Note that some boards don't =
have
> > > > > intel-vga or intel-mrc.
> > > > >
> > > > > With the other patch I sent I can have a sensible limit for all x=
86 boards.
> > >
> > > Did you miss the comments above?
> >
> > No, I saw them. They're similar constraints to other systems.
> > >
> > > >
> > > > And you can set the same sensible limit with the existing mechanism=
 with
> > > > the bonus of it not making x86 different from the rest?
> > >
> > > I understand that it is possible to set a limit for u-boot-nodtb.bin
> > > but that is not accurate nor sufficient in the presence of blobs. The
> > > solution belongs in Binman.
> >
> > Your series puts reasonable estimates on the size of the blobs and then
> > will give a failure such as:
> > binman: Node '/binman/rom/intel-vga': Offset 0xfff90000 (4294508544)
> > overlaps with previous entry '/binman/rom/fdtmap' ending at 0xfff902e1
> > (4294509281)
> > Which is not as nice as (I just threw in a limit):
> > u-boot-nodtb.bin exceeds file size limit:
> >   limit:  0x927c0 bytes
> >   actual: 0x9a810 bytes
> >   excess: 0x8050 bytes
> > make[1]: *** [/home/trini/work/u-boot/u-boot/Makefile:1359: u-boot-nodt=
b.bin] Error 1
> >
> > And tells us how much we need to get back size wise. Aside from when
> > using the actual blobs (and in which case a real error will be shown
> > when trying to use them), it's always about making an estimate on the
> > part of the system that we control.
>=20
> Thanks for digging into this.
>=20
> I wasn't aware that the limit was just an estimate. Since it produces
> a build error it seems to be enforced as a hard requirement. But I can
> set a limit and we'll see how things go.
>=20
> I still like the binman block-size thing though. The error message
> binman provides actually tells you what to do (reduce the space of the
> things that are overflowing into intel-vga). So I'd like to add that
> too.

I think this is a reasonable compromise, thank you.

--=20
Tom

--oSDNzc/OKZDuOnXh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5rMMACgkQFHw5/5Y0
tywCfgv/Z8oAalyG5CU/R93hJTLJqY566TzntqFEClaLO/HnSujvTXG3U/HbjNax
ZQgBNpiWLefriR2Gloc4OMjGmZKoQmpVHwMgcMB51b82W/EUF+K2+o/EVtfMMFeE
AaAmRH+3G9LuJ/QDvLxYiZbFNu6O8rjgYhbAyX6iuHdU4Fd7ug8FuFp3ufHR90H6
P4d4HJIZ0sjOlWdQFharwtkNFHf/NW5SHz8iAK8UZs3A0RRV0DCoFrCyRHjLy5AW
UJ+TWaZdH5EttfIAtsafMyanddcbDS18hLrD/4+vWblmxnAWB5px2FT1TwQSJ86Z
J5xwL2h01Ohyj+xKDPQ6J+XVnODSfs2BhKV6Fn/oQ9ZBqSyEIu+hs63ld5L0BVfv
hZs1ameKE/6qLDoUdx2fzxnIC1Jv9W6uD/3mr4/KWxV+vfDm6w8nQYa0Sst92uKc
sJ0bHL8GBtHbPKQhVKGB5YPdf57DoqYbr+ZCTv0AxVrVxYGAuVMVpV8aiBU4XrFT
j3EFAoa1
=pN57
-----END PGP SIGNATURE-----

--oSDNzc/OKZDuOnXh--
