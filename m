Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478C6CD5BC9
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 15:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DEA788C8A;
	Thu,  5 Sep 2024 17:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FCS9BvgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B317288C9D; Thu,  5 Sep 2024 17:07:19 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2B088C8A
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 17:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-456825b4314so8051961cf.0
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725548836; x=1726153636; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yo/LS2q+M9BjkuPzbOW85g7Rtr0pPg/uYezWch9/t/A=;
 b=FCS9BvgFkwlkCY/zI8ZBpnr6Ft9pzZOn6T+7LEoF+ffvZNas+oZ0DJQyw9/Wgm4Rrc
 kkR0BEUigyYb78o9GCDO8foRHVnsxYi0YvntNulqDvDn3RdWmYb7xBUVEHqLTQxBD1d0
 wjWoaHDjW22jURXCYxBm3hBk41jpBI0m6mQn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725548836; x=1726153636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yo/LS2q+M9BjkuPzbOW85g7Rtr0pPg/uYezWch9/t/A=;
 b=VSiWVYwCl15Sboc1oc5m+kxNQkjG2ZQOSLW76JNKWKIDFyyxFB0UP/vkWf6FjbI9wV
 R4xF7uPl7zMqABfG/8hpjNRa7fnyl5WI81dEeBpeA5qxn74fqkO6iZ6sgcMoDWNZtZb1
 fnB3qtQ37muUu9WSSM2/5BwMxKoaT+KlUD5WF8kUS1vFidBHAEcrc5yT6pbz0GUFaqhb
 dyyUltvlzm1yGLAX0R0dZ65B3Q+S4/SexsKkRuZBVXd136sfpxd3a572/CPNvmzO7kM2
 8G56NvNYxvVYf3TVoNplfgVjSt0PEI/qS90yl2xz+GSH6zt5lZW2aZMcuU0IkbYdRUZU
 i20g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1/mG/dQmnHA9zDYslHoMErnD3kjC8wEIg8Tf96BZ+/MZipUBROs42MqUWAsIAlhrGts0cBjA=@lists.denx.de
X-Gm-Message-State: AOJu0YzlrUD4IHP+WTzFvYAvwffgOtHBgltjI6qKHZ30Fi0MEfD76sb6
 PElebIl9g+ODgeIIskRZVGT2Y1u3dgivliGgc50IYe6fx68jb5iN+6iacHPoa1M=
X-Google-Smtp-Source: AGHT+IF8nU/Tpsumrbl0rwCeTojHMNfFw3uazK2D+1paoNai2UBoS5lLocyYHfCa1c4UkDjn/5V+cg==
X-Received: by 2002:a05:622a:1456:b0:458:a6c:806e with SMTP id
 d75a77b69052e-4580a6c833cmr8170431cf.30.1725548836176; 
 Thu, 05 Sep 2024 08:07:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45801dc19b8sm7830411cf.82.2024.09.05.08.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 08:07:13 -0700 (PDT)
Date: Thu, 5 Sep 2024 09:07:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Hiago De Franco <hiagofranco@gmail.com>, Keerthy <j-keerthy@ti.com>,
 Amjad Ouled-Ameur <aouledameur@baylibre.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH] fs: Fix SPL build if SPL_FS_LOADER is enabled and
 FS_LOADER is disabled
Message-ID: <20240905150710.GD2479150@bill-the-cat>
References: <20240826181933.252020-1-hiagofranco@gmail.com>
 <20240830205119.GA3268574@bill-the-cat>
 <20240831134911.GA32220@francesco-nb>
 <20240904212721.GZ2479150@bill-the-cat>
 <Ztjw5bGI0RKpAIVP@gaggiata.pivistrello.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZTlt3Jl3WphpN7Z0"
Content-Disposition: inline
In-Reply-To: <Ztjw5bGI0RKpAIVP@gaggiata.pivistrello.it>
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


--ZTlt3Jl3WphpN7Z0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 01:44:37AM +0200, Francesco Dolcini wrote:
> Hello Tom,
>=20
> On Wed, Sep 04, 2024 at 03:27:21PM -0600, Tom Rini wrote:
> > On Sat, Aug 31, 2024 at 03:49:11PM +0200, Francesco Dolcini wrote:
> > > On Fri, Aug 30, 2024 at 02:51:19PM -0600, Tom Rini wrote:
> > > > On Mon, Aug 26, 2024 at 03:19:33PM -0300, Hiago De Franco wrote:
> > > >=20
> > > > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > > >=20
> > > > > When SPL_FS_LOADER is set to y and FS_LOADER is not enabled, the =
SPL build
> > > > > fails with the following errors:
> > > > >=20
> > > > >   AR      spl/boot/built-in.o
> > > > >   LD      spl/u-boot-spl
> > > > > arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in fun=
ction
> > > > > `fw_get_filesystem_firmware':
> > > > > /u-boot/drivers/misc/fs_loader.c:162: undefined reference to
> > > > > `fs_set_blk_dev'
> > > > > arm-none-linux-gnueabihf-ld.bfd: /home/frh/tdx/src/u-boot/drivers=
/misc/
> > > > > fs_loader.c:185: undefined reference to `fs_read'
> > > > > arm-none-linux-gnueabihf-ld.bfd: drivers/misc/fs_loader.o: in fun=
ction
> > > > > `select_fs_dev':
> > > > > /u-boot/drivers/misc/fs_loader.c:89: undefined reference to
> > > > > `fs_set_blk_dev_with_part'
> > > > > make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
> > > > > make: *** [Makefile:2055: spl/u-boot-spl] Error 2
> > > > >=20
> > > > > Fix it by replacing the FS_LOADER with SPL_FS_LOADER in the Makef=
ile, so
> > > > > the fs.c with the necessary function definitions are compiled.
> > > > >=20
> > > > > Fixes: b071a07743d4 ("drivers: misc: Makefile: Enable fs_loader c=
ompilation at SPL Level")
> > > > > Suggested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > > Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > >=20
> > > > This leads to failure to build on sandbox_noinst_defconfig.
> > >=20
> > > --- a/drivers/block/Kconfig
> > > +++ b/drivers/block/Kconfig
> > > @@ -110,6 +110,7 @@ config EFI_MEDIA
> > >  config SPL_BLK_FS
> > >         bool "Load images from filesystems on block devices"
> > >         depends on SPL_BLK
> > > +       select SPL_FS_LOADER
> > >         help
> > >           Use generic support to load images from fat/ext filesystems=
 on
> > >           different types of block devices such as NVMe.
> > >=20
> > >=20
> > > ?
> >=20
> > I think "depends on" and sandbox_noinst_defconfig should enable
> > CONFIG_SPL_FS_LOADER too.
>=20
> What do you mean?
>=20
> The change I proposed fixes the issue you reported with sandbox_noinst_de=
fconfig and I
> think is the right solution. Are you ok with that or are you proposing to=
 just
> change sandbox_noinst_defconfig enabling CONFIG_SPL_FS_LOADER explicitly?

I'm saying, based on the other options which use SPL_FS_LOADER it should
be a depends not select here, and that sandbox_noinst_defconfig should
be enabling SPL_FS_LOADER. There's also an argument to be made that
SPL_FS_LOADER (and FS_LOADER) should be unprompted options (ie "bool"
without the text to explain the option) and selected by all of its
users. I'm not immediately sure which is better now.

--=20
Tom

--ZTlt3Jl3WphpN7Z0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbZyRoACgkQFHw5/5Y0
tyySBwwAsmZzozxKRB0i2xJnNYaAU5+wsKm53vN4FmWaKwq6W8mrzbep00XsETv/
SgWLdoeV8BpaCl43klzRFO1zh53KClmaXswdPlDnpStNLCP9xae/bRntns88C0eA
n4rBPoOqCsYA+KkXtgteny9h3NzzEMolFPkMe2AuE/m1cUigQ5qHIOlFsdbLFumd
HhiCNTeGPvvRL4ptfEcYwuXTm0zVxa6P44ZBysNr+ykyp7aFdFMc9dFsm0bjIys7
C/FajDTUejMeSDV1aiZXYPwSxXT04hJ08Hxrs7nYl6DhBkdAM63skfmBJGu173CK
z2epuDTSbOvghyb5n8DKDwOOM01ZVGS2Wm7iYe/ADuiWG+G8LP0w+/5roPBKdeLg
QDrlKshVVtEKNgou+OrcsSaRw8IrtZDzuE96zLnGhJP/ztvHKWWBge2NujnyL+Oy
U8taZHuNL1KfhHO3gN8B0vAQ8xLuCRvqRRgsMqfOnlxF48CW4vrQcYX+/t0YMY3f
O8ajEjF+
=z107
-----END PGP SIGNATURE-----

--ZTlt3Jl3WphpN7Z0--
