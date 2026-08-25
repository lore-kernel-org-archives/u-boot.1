Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DA3C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 18:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03C2E606E5;
	Tue, 25 Aug 2026 18:34:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Qf9GnnyJZfm; Tue, 25 Aug 2026 18:34:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787682868;
	bh=cfHGAgPypryvqRx3CZRQ2wqUQ5Fm6TzTYh47g18q10U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BY+G0N5qNAnPrebhgOgNsuMwe3ulhgHy3ksYzILV/eQZQ28yVyPrheOS9cQGgHST9
	 +/DcOqv7apTPXrtouZbVNsuPnmh63/UcHDxbFZBqhGFAUbN3YEtXXNbXwrJZ4EXBWs
	 NozqejNPqcZdqMtsOpZSYEu1sC9DTxChNsRGCDMXZLoHGr4XAfITzKWPgsQZhW0Cxc
	 bzDwhr3IWagfse6D7veGz3dJN9z6/H4brrSFfITWow1NhnqMNTzGTopnnXEp/sXEU2
	 pUd1x9g7/p1J5oOWoWSodI36zyHekqEJLrDUVlK9hz2k4p9hzw3J+tJ+Bulb1fOJXi
	 WaXsUjoXnJSjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD839606E1;
	Tue, 25 Aug 2026 18:34:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 13A69334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 060C240595
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNG2tlWIAh4z for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 18:34:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=YAvbMLZC
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3FD53404E7
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:34:26 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-497e6956acfso135939b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787682866; x=1788287666;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cfHGAgPypryvqRx3CZRQ2wqUQ5Fm6TzTYh47g18q10U=;
 b=YAvbMLZC6Sub1sDqtX1uJkKSgve/aUOKcowoT4Nn5bgklz3n+SGbInH8RC4uFGS8mP
 8+C/04eAFUosD0mO8ScvVLxVz0NdQGBAao7CrV9Vcg6LPWoP6GVoG40mXv/oDiV4oC15
 tEXyrooCePtHVIU/IZeX1zGn0vZ6gYM2lmr0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787682866; x=1788287666;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cfHGAgPypryvqRx3CZRQ2wqUQ5Fm6TzTYh47g18q10U=;
 b=K+Wh/3y20e0eC3B3dEte0xuZ4tORRB1PDxJJrCoYr/jXA2n+H6/gW95d3paU0NxZsZ
 wfVZ6nAvhw0KymNoixGaRoKievdat5EeiSuYNAV/Y6HOaCkdnXDYABTQiFUnmwdzuZSv
 /91OO6JV42f27TV4Q3F1scFM5IS3Ttz9qP9X1gxOMnzwP1sM0Somnnkrb+qr2/+2hFGj
 s5ttZzKXdVAH1dT/G+NnCYtE/mrTBCw6+p7ctK1XjwEAutIM7uDy17lbf+uIGROacD/h
 swCGU5cIjhRc8SEZ9ZvJCK6CCONAZIS5zMQ7kuf/0f2M42zDyFonhfhFJeA2y1nYDj7d
 3Yhw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqx56lqadAYNMZ+dPOhwhtbifX+JsqOMqdZHP7E+sNgpjc5MV6R53yKasL32fQYbaBKcKTBMo8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nG+D9+Nr3eTEl23ywIN93XTrmI8CQ4RItZpbArjw7W8f8JQRGM
 ErFEwRLQ+C/iwWcGfI3kw7QqQgjo5XBgznpDsMQyVRMngtP6S9XTDywKaCjU+2KMvx4=
X-Gm-Gg: AR+sD12VMTE6xYNOFDNp6bhXClm44DmSeE1q6Ci0R1GhWCUYaTz2CFbRp9Dr+JpFyHZ
 jFplhwegvB0GNp2APAiSlZeaBLDleqwPUGaa94nM1qXbrFH0xjBUs9JFHdyKSW8vsW0p/r24jEV
 l8rcYkpU7xjANFLDsJ6YF45UU3XJpQMgNCNmwehMGwZXRWXidoe1aFZrl1EuCsrYEWkjH2Mr1IX
 hLqoHzL1baylJEGgjRYI47oEYnQQSwkAo45rGM2IzIDTNXtSu3fiPrYObZ33MBwBHkpbH6X0I7Z
 t8eODSo+dlNvRdVI1iaRDP8jpMO/GlXePT7MWnuviCmgrgXcn4mobXdG1BDzYl2yJoslungC/WC
 sasSdFVPP9k0hAauDmE1tn0AnXrs1HDUhMC6y0HdVqQBg3VH6tnNsivjWPrMrWDskEULLN7HV1K
 Gw9NUQOoxgtkkICNprVe8q3eetdm1AdF18scG7Ws+801jNjKRKCfeiet0WyELc7byZHdQuKKJgz
 qtmSdNpabEIqNMfzSVZEc1VqGno3hbrRZeX3Ye427Ik/Nvtiq5lHfdZ1RDCCIJJTswe0ORhzU0+
 tfWbRfbJGQ==
X-Received: by 2002:a05:6808:5028:b0:496:117b:1f04 with SMTP id
 5614622812f47-4b3502011a8mr6729942b6e.2.1787682865786; 
 Tue, 25 Aug 2026 11:34:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b367ccdea6sm176872b6e.5.2026.08.25.11.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 11:34:24 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:34:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jacky.Cao@sony.com, u-boot@lists.denx.de, nora.schiffer@ew.tq-group.com,
 Steffen.Doster@tq-group.com, alexander.feilke@ew.tq-group.com,
 Max.Merchel@ew.tq-group.com, peng.fan@nxp.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1] env: Fix compile error for envtools
Message-ID: <20260825183422.GZ523975@bill-the-cat>
References: <20260713083141.2772971-1-Jacky.Cao@sony.com>
 <CAFLszThWHSB3dnXYTvuSTwcTO0r4ja4hd8KuVgy-gKxb8ctw_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BbFX6t4bIubXlQXt"
Content-Disposition: inline
In-Reply-To: <CAFLszThWHSB3dnXYTvuSTwcTO0r4ja4hd8KuVgy-gKxb8ctw_A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--BbFX6t4bIubXlQXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 12:21:01PM -0600, Simon Glass wrote:
> Hi Jacky,
>=20
> On 2026-07-13T08:31:41, Jacky.Cao@sony.com <Jacky.Cao@sony.com> wrote:
> > env: Fix compile error for envtools
> >
> > Following error happens when build envtools for mx6qsabrelite.
> >
> > $ make tools envtools
> >   UPD     include/generated/timestamp_autogenerated.h
> >   HOSTCC  tools/printinitialenv
> >   GENENV  u-boot-initial-env
> >   COPY    tools/version.h
> >   HOSTCC  tools/env/crc32.o
> >   HOSTCC  tools/env/ctype.o
> >   HOSTCC  tools/env/env_attr.o
> >   HOSTCC  tools/env/env_flags.o
> > In file included from ./arch/arm/include/asm/mach-imx/regs-lcdif.h:16,
> >                  from ./arch/arm/include/asm/arch/imx-regs.h:371,
> >                  from include/configs/mx6_common.h:21,
> >                  from include/configs/nitrogen6x.h:13,
> >                  from include/config.h:3,
> >                  from include/env.h:12,
> >                  from tools/env/../../env/flags.c:7,
> >                  from tools/env/env_flags.c:1:
> > ./arch/arm/include/asm/mach-imx/regs-common.h:51:9: error: unknown type=
 name 'uint8_t'
> >    51 |         __mxs_reg_8(reg)
> >       |         ^~~~~~~~~~~
> >
> > uint8_t type is defined in linux/types.h header file.
> > The config.h includes regs-common.h that uses uint8_t type,
> > to fix this, include config.h after linux/types.h in env.h file.
> >
> > Fixes: 9f1807e57cbb ("env: add env_set_runtime() helper")
>=20
> env.h only needs <config.h> so that IS_ENABLED() works inside the
> inline env_set_runtime() helper. A cleaner fix is to make
> env_set_runtime() a normal (non-inline) function declared in env.h and
> defined in env/common.c (or wherever env_set() lives). Then env.h no
> longer needs <config.h> and the tools build stops dragging board
> configs into the host-side compilation. What do you think?

Just using a normal #if/#else/#endif would be the better fix here.

> > [...]
> >
> > include/env.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> > diff --git a/include/env.h b/include/env.h
> > @@ -9,10 +9,10 @@
> >  #ifndef __ENV_H
> >  #define __ENV_H
> >
> > -#include <config.h>
> >  #include <compiler.h>
> >  #include <stdbool.h>
> >  #include <linux/types.h>
> > +#include <config.h>
>=20
> As Tom mentioned, we really don't want to move config.h later - even
> though the files above it are probably unrelated in this case...

It's not "don't want", it's "cannot". You cannot have it be anywhere
other than the first line or you will introduce other obscure problems.

--=20
Tom

--BbFX6t4bIubXlQXt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao3gLgAKCRAr4qD1Cr/k
ClpHAQCPJcfasayPBoc+ChjNLf7MqSK90ws9hsY/rLtXfJPtxgD+Kx4L8kdagsTp
2eC+Fml8SkVnv8Did98arMnCd3bw7wE=
=iV2U
-----END PGP SIGNATURE-----

--BbFX6t4bIubXlQXt--
