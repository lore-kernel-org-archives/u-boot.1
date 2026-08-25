Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A39C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EB6760743;
	Tue, 25 Aug 2026 22:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5aV3Yl8XJJ03; Tue, 25 Aug 2026 22:57:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698665;
	bh=6QBTCNhpDHoxcX+IOEJZPaewPNXK3F3u7gYMAH4imek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BT2rCmbuBumfYfrs+ctfKWW3LVZ2oY2+/2/56UxpeTnaRdQ60o8nK2Ro/g5LwmVsP
	 GFOq/ChNijboriULxpYmEwofCU/fCdgqZ8cC2UBxoLe5/D3nD1BZdq5PxHxJDHMNHk
	 leNnxSniJNrk5oEnriGXHXqg5m4Bjlxj/dgPD71Sr2vJuyfdafbP7NwgGl8PnkNJLL
	 u0uINSGlbGaZxMmRVAeYBdmjXxZHbcFzyr2OTWVEjj8xwXBib7WuuLKrLqD58D9A6L
	 EbUOFsK6Oc3bE0z8mUSKmirvi8w2A+LU8pBkcupeo+tC27pgCTSupa23DjAUxo6f0i
	 Pt/mDR3E27qKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1C246073C;
	Tue, 25 Aug 2026 22:57:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2233E3C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13F1A6073C
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yqGew1HHbq5H for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:57:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2d; helo=mail-oa1-x2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SNFy7YAU
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F0FC60736
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:57:42 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-44cb057311bso31179fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787698661; x=1788303461;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6QBTCNhpDHoxcX+IOEJZPaewPNXK3F3u7gYMAH4imek=;
 b=SNFy7YAU2Cu/pvp6IL/UdU3UsDOAZh/W7X9+4Z40TpgiGaJz448PWLJv17dw3JFZB5
 PtmuhhenOq0Lt8mWqmjXEpsQwQ+wwaAXycHcVQX/MphtStT7f5q1NqOvQHayjDhlZSjl
 K7pgMzAmkbcS8E/22h8EjiSTsgWhHk8MIO46M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787698661; x=1788303461;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6QBTCNhpDHoxcX+IOEJZPaewPNXK3F3u7gYMAH4imek=;
 b=H7B9amyEspDOr57nfd5/q12gsRhWjCURc7t2P7rO1tbg7uXuNxjII8D9uOOM6A5dOS
 hT+HWZskkSCqSsKe/GZxcj/BuE4IPfA/PlHMItq6wLGz0J+7B5aH5x316uNKc0uN6zId
 nTjerks4SPOtK6caF+aBty+0Rw6QChDdSX0GmM4LE1KYyKDNWZ9r5Q0yvu7QOiWrxZPl
 8HuBeOfiXRlaS0ENiINh2WHRCPpeVSZ0WVCoYGVITjUCykqsQZiLPx26c9djvAeKuowr
 H649XaDr4hl2f2pmm1rhXfEKGCtHZ03Ud7jE/GuZ+Kx5waRNiEiAiV+JrTUP0RASxXwH
 u+vQ==
X-Gm-Message-State: AFuF++laGiaHaY5kFRqi2UHlR2MfgXKw2Ti2uZD3LfFV9AWcNvS2upTm
 6GAi855/BP5PntiGcOgIT7kZ87IeOgKrKu5SII6p8apwZ9Kv4fXNRVNmfnY/KvVcG0Q=
X-Gm-Gg: AR+sD12A+JHjK23DhzAR+TRy9YntvQPtOciDEcfoI21lChHe++heXFR1hqo7eL60iJ3
 B1EjHlkQyt/T2NB2Tbs6riQzCnPbVzs/sLi5dlrmdOlEHsLK44YO0vJH5ex2RmUpMfISJefZj3p
 mxSK42RcWeQg9+Og4X8kvQE+qdz1/nRPhqqMB3PSPaAyi0g8GHgP+WYwvnwc6EPrcpIZ7vHCBtH
 bmq8E3vK1K4YH9ZHV1yDQwFo3C02Qfb20hCPRWWfYk+SJBhim385txP0wE21cPPTSvjxVLDnD+r
 O8cfM3Z1ES7o62LcNNiHEF4r9mBordDV50N11rWqs9CiS8hByMvdHd1cingqyjft6NWGJy8IMKd
 z3J3osUEeQuml+31WfFv7GpeoDHXC3PShkt1lI70b8Nhts6oN7XmVJNEFnArjXglPDMWmj7hoKz
 43QEszrP2x3ryVT+5deji0gG6/vvadmCC3WZWsuJPCTg6jD4odB9gbjD2gGvxL63PSX1eXDgbJ8
 BVwO7f+MBNUs2G6Olh4fkUwow917V3r9vB3YbssGNQPQjnWNIhtvl6kAJ1jGGVLuiWnAtRJjlTz
 dsQY7Nr1iQ==
X-Received: by 2002:a05:6820:6007:b0:6b1:3663:8616 with SMTP id
 006d021491bc7-6b1a053b713mr1738454eaf.33.1787698661597; 
 Tue, 25 Aug 2026 15:57:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b1a24bdb31sm237934eaf.2.2026.08.25.15.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:57:40 -0700 (PDT)
Date: Tue, 25 Aug 2026 16:57:38 -0600
From: Tom Rini <trini@konsulko.com>
To: AK Sharma <maskachoska@yahoo.com>
Cc: u-boot@lists.u-boot-project.org, Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v1 11/12] board: econet: add EN7528 board support
Message-ID: <20260825225738.GF523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <20260825224330.713151-12-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/6Rbig84zofqQ9Fu"
Content-Disposition: inline
In-Reply-To: <20260825224330.713151-12-maskachoska@yahoo.com>
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


--/6Rbig84zofqQ9Fu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 04:12:06AM +0530, AK Sharma wrote:

> Add the EcoNet EN7528 board: board glue, the reference/RAM/tclinux and
> JCOW414 R3-hook defconfigs, board header and default environment.
>=20
> Signed-off-by: AK Sharma <maskachoska@yahoo.com>
[snip]
> diff --git a/board/econet/en7528/MAINTAINERS b/board/econet/en7528/MAINTA=
INERS
> new file mode 100644
> index 00000000..69cefe4a
> --- /dev/null
> +++ b/board/econet/en7528/MAINTAINERS
> @@ -0,0 +1,13 @@
> +ECONET/AIROHA EN75XX
> +M:	AK Sharma <maskachoska@yahoo.com>
> +S:	Maintained
> +F:	arch/mips/mach-en75xx/
> +F:	arch/mips/dts/econet,en7528*
> +F:	board/econet/en7528/
> +F:	configs/en7528_*_defconfig
> +F:	defenvs/en7528_jcow414_r3hook_env
> +F:	doc/board/econet/en7528.rst
> +F:	doc/board/econet/index.rst
> +F:	drivers/mtd/nand/spi/en75_bmt.*
> +F:	drivers/serial/serial_en75xx.c
> +F:	include/configs/en7528.h

You should make use of the "N:" format to match on things like en75xx or
en7528 and so forth.

[snip]
> diff --git a/board/econet/en7528/mk_tclinux_uboot.py b/board/econet/en752=
8/mk_tclinux_uboot.py
> new file mode 100644
> index 00000000..d63f46a3
> --- /dev/null
> +++ b/board/econet/en7528/mk_tclinux_uboot.py
> @@ -0,0 +1,112 @@
> +#!/usr/bin/env python3
> +"""
> +Package U-Boot as an EcoNet/TrendChip "tclinux" HDR2 image, so the stock
> +bootbase will load and run it exactly the way it loads the stock kernel.
> +
> +The bootbase decompresses a slot's LZMA payload to a fixed 0x80002000 an=
d jumps
> +there. U-Boot cannot be linked at that address (MIPS relocation needs the
> +relocation delta 64 KiB aligned, and reserve_uboot() force-aligns reloca=
ddr to
> +64 KiB, so a TEXT_BASE of 0x80002000 always panics "Mis-aligned relocati=
on").
> +So the payload is a small relocator stub followed by a U-Boot linked at
> +0x81000000; the stub copies it up and jumps.
> +
> +  payload =3D [stub @0x80002000][pad to 0x100][u-boot.bin linked @0x8100=
0000]
> +  image   =3D [HDR2 header 0x100][LZMA(payload)]
> +
> +Header layout, confirmed against the stock image on a live board
> +(0x100 + kernel_len + rootfs_len =3D=3D total, exactly):
> +
> +  0x00  "HDR2"
> +  0x08  u32 LE  total size, including the 0x100 header
> +  0x0c  u32 LE  JAMCRC of everything after the header
> +  0x10  version string
> +  0x50  u32 LE  kernel length
> +  0x54  u32 LE  rootfs length
> +  0x100         LZMA kernel, then the rootfs
> +
> +Usage: mk_tclinux_uboot.py <stub.bin> <u-boot.bin> <out.trx> [version]
> +"""

This should be part of the binman support I believe.

--=20
Tom

--/6Rbig84zofqQ9Fu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao4d4gAKCRAr4qD1Cr/k
CmvmAQDWvFPGwf28i+08zY0r6ZIZL5yOuJoE3BbR5KcOwRcBgwEAsGUIudMJn4oH
XykzrvI8Ejmx/6NTi8o2vPVD7hUsuAs=
=TS/4
-----END PGP SIGNATURE-----

--/6Rbig84zofqQ9Fu--
