Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88768D0EE1C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 01:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF47E88966;
	Sat, 12 Oct 2024 03:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NgWjh48t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DED889DA; Sat, 12 Oct 2024 03:42:50 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1764682BA7
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 03:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb82317809so18573386d6.0
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728697367; x=1729302167; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RBXDGC1wbei+StOITGHa4VM/IDCS72eUfqS6xtGpI08=;
 b=NgWjh48tsMKnpKmAf3TAX/2IprHrStzjfAOmJhE6hiSVuRm+5rzCON6sc1le90jw2O
 XLOkYkOcwtzmCqraZunL+KRC1JWrzHVZ0MzuGif+4+rb5hANLkBeaDib6mpTSTjVBYi4
 3y0oUzosWeznUwiH2+WEGVfxw/LxaEm4Bw54I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728697367; x=1729302167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBXDGC1wbei+StOITGHa4VM/IDCS72eUfqS6xtGpI08=;
 b=psvQXUFuXXOoULw9TCIfnjMJfR7JCf/QMqNu9D+Jh5Pvp8unoN4H8PmQSiTikXsgyh
 3zilSz1i1AxNu+mO/cfNsNSAqcIsuWrWm8KYZmtUwrlPzfzq5q2l8TTk9WFUP94xaNv6
 qXI6cXzyx8Fmjyk3zsJSc11hzGSFXMi6Xd/LC2MI5J1fv6Cx/nY1jtmWyXG1hbJE7UpF
 jpG2cVxNaZe58JuQtSH2+GKIrlfxrMry2ekb1QlUauV8B6p513oKKLq99BV8Lz4G+uIJ
 nrocdSBez0UmTYm1M3884jqpGvj1WbV7U/rZUDAJr3b1HPEyrKxBLyygoq1jaMpylML1
 JNqg==
X-Gm-Message-State: AOJu0Yzv5dqMkGW7DxjXb8s7cYyqll77MNimLnxRRlUackLx2aLK5TQO
 FH4RPhFEfooIEIcNgRXdmYcL+ANvX41Dzz1JWV2thafgeKJ16/WMWqKuWBG+KCdCXT+0ATcdrc4
 on81v6Q==
X-Google-Smtp-Source: AGHT+IEa8DvgCuDiWoeabSKAWFQrE+mkbStylPm8SBEq32lLVAzA9kTA6sOdNaPGdq0iU7ZOtqGIAg==
X-Received: by 2002:a05:6214:3381:b0:6cb:f039:85a0 with SMTP id
 6a1803df08f44-6cbf9e9f2edmr18697796d6.40.1728697366813; 
 Fri, 11 Oct 2024 18:42:46 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe8609ef4sm21227056d6.96.2024.10.11.18.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 18:42:45 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:42:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 7/7] cmd: Update the meminfo command to show the
 memory map
Message-ID: <20241012014242.GJ14210@bill-the-cat>
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-8-sjg@chromium.org>
 <18910B7B-B3C3-4C4E-B2DC-5398F480E075@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dqBmc9uy0l7mHB4Y"
Content-Disposition: inline
In-Reply-To: <18910B7B-B3C3-4C4E-B2DC-5398F480E075@gmx.de>
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


--dqBmc9uy0l7mHB4Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 01:18:19AM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 11. Oktober 2024 23:40:31 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >U-Boot has a fairly rigid memory map which is normally not visible
> >unless debugging is enabled in board_f.c
> >
> >Update the 'meminfo' command to show it. This command does not cover
> >arch-specific pieces but gives a good overview of where things are.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> >Changes in v2:
> >- Modify the existing 'meminfo' command instead
> >
> > cmd/meminfo.c             |  48 ++++++++++++++-
> > doc/usage/cmd/meminfo.rst | 126 ++++++++++++++++++++++++++++++++++++++
> > doc/usage/index.rst       |   1 +
> > test/cmd/Makefile         |   3 +-
> > test/cmd/meminfo.c        |  38 ++++++++++++
> > 5 files changed, 214 insertions(+), 2 deletions(-)
> > create mode 100644 doc/usage/cmd/meminfo.rst
> > create mode 100644 test/cmd/meminfo.c
> >
> >diff --git a/cmd/meminfo.c b/cmd/meminfo.c
> >index bb9bcec2e3f..e9a635bf4bf 100644
> >--- a/cmd/meminfo.c
> >+++ b/cmd/meminfo.c
> >@@ -4,18 +4,64 @@
> >  * Written by Simon Glass <sjg@chromium.org>
> >  */
> >=20
> >+#include <bloblist.h>
> >+#include <bootstage.h>
> > #include <command.h>
> > #include <display_options.h>
> >+#include <malloc.h>
> >+#include <mapmem.h>
> > #include <asm/global_data.h>
> >=20
> > DECLARE_GLOBAL_DATA_PTR;
> >=20
> >+static void print_region(const char *name, ulong base, ulong size, ulon=
g *uptop)
> >+{
> >+	ulong end =3D base + size;
> >+
> >+	printf("%-12s %8lx %8lx %8lx", name, base, size, end);
> >+	if (*uptop)
> >+		printf(" %8lx", *uptop - end);
> >+	putc('\n');
> >+	*uptop =3D base;
> >+}
> >+
> > static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
> >-		       char *const argv[])
> >+		      char *const argv[])
> > {
> >+	ulong upto, stk_bot;
> >+
> > 	puts("DRAM:  ");
> > 	print_size(gd->ram_size, "\n");
> >=20
> >+	printf("\n%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
> >+	       "Gap");
> >+	printf("------------------------------------------------\n");
> >+	upto =3D 0;
> >+	if (IS_ENABLED(CONFIG_VIDEO))
> >+		print_region("video", gd_video_bottom(),
> >+			     gd_video_size(), &upto);
> >+	if (IS_ENABLED(CONFIG_TRACE))
> >+		print_region("trace", map_to_sysmem(gd_trace_buff()),
> >+			     gd_trace_size(), &upto);
> >+	print_region("code", gd->relocaddr, gd->mon_len, &upto);
> >+	print_region("malloc", map_to_sysmem((void *)mem_malloc_start),
> >+		     mem_malloc_end - mem_malloc_start, &upto);
> >+	print_region("board_info", map_to_sysmem(gd->bd),
> >+		     sizeof(struct bd_info), &upto);
> >+	print_region("global_data", map_to_sysmem((void *)gd),
> >+		     sizeof(struct global_data), &upto);
> >+	print_region("devicetree", map_to_sysmem(gd->fdt_blob),
> >+		     fdt_totalsize(gd->fdt_blob), &upto);
> >+	if (IS_ENABLED(CONFIG_BOOTSTAGE))
> >+		print_region("bootstage", map_to_sysmem(gd_bootstage()),
> >+			     bootstage_get_size(false), &upto);
> >+	if (IS_ENABLED(CONFIG_BLOBLIST))
> >+		print_region("bloblist", map_to_sysmem(gd_bloblist()),
> >+			     bloblist_get_total_size(), &upto);
> >+	stk_bot =3D gd->start_addr_sp - CONFIG_STACK_SIZE;
> >+	print_region("stack", stk_bot, CONFIG_STACK_SIZE, &upto);
> >+	print_region("free", gd->ram_base, stk_bot, &upto);
> >+
> > 	return 0;
> > }
> >=20
> >diff --git a/doc/usage/cmd/meminfo.rst b/doc/usage/cmd/meminfo.rst
> >new file mode 100644
> >index 00000000000..c628119787e
> >--- /dev/null
> >+++ b/doc/usage/cmd/meminfo.rst
> >@@ -0,0 +1,126 @@
> >+.. SPDX-License-Identifier: GPL-2.0+:
> >+
> >+.. index::
> >+   single: meminfo (command)
> >+
> >+meminfo command
> >+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >+
> >+Synopsis
> >+--------
> >+
> >+::
> >+
> >+    meminfo
> >+
> >+Description
> >+-----------
> >+
> >+The meminfo command shows the amount of memory, the layout of memory us=
ed by
> >+U-Boot and the region which is free for use by images.
>=20
> The information offered by this command cannot be used for this purpose a=
s it is incomplete.
>=20
> Memory allocated in LMB cannot be used to load images. And EFI in future =
will use LMB for allocations.
>=20
> The command should be changed to show LMB allocations.

I agree, this need to include the lmb information as that's quite
likely to be helpful to anyone wondering "well where can I place things
then?" when denied being able to load an image somewhere.

--=20
Tom

--dqBmc9uy0l7mHB4Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJ1BIACgkQFHw5/5Y0
tywsBgv+MkEvRmSyQ/P2r0LM5I5QwlLzUDm6kiIr1jMZ0xYZ9pSEAxr/+gLucHSJ
u1JZHepZ3/gYWM5pYq37WXp1Z67iUEMimo6SV0frc27vfGYk6Q09ZTTkof39R8EW
l5ftNwq0vkmK/AuPicBss4XYVpQ0V9CcvY/HYy31gUaGH7IhRXRvHHYmQkTUDTGT
r10x/Xu/9TKKD0zDgsaTOkgTxrdkLZkQIJnYsccNSMbCwAGt0q5jZ23OUcCl6WuA
xXR5sC2Tu1RFFJXLjXftNkQflTRXG/DQkLzN+TSzzAsoDFkHGDvE6WSl4g3CJ/Gz
kXpmcLJfffaxg4s/Y2c3EWi+zwM2rXAEqL9mztBytd8/vKYFDXAzreBjW64aI2vj
xuTCxrZIZnTGBEopcdXvM4zf3N52DjMHGMCD4esrEaMYbllqaln1gsg68ewwkUst
Xni+B2/TiA2bblZhItMOCc1dKpNcXQ2E8jNGs3yF+tgX7nXasGm7P/JFkLm6tuLQ
YfiUxVns
=xaNd
-----END PGP SIGNATURE-----

--dqBmc9uy0l7mHB4Y--
