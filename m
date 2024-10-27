Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AAAD0C604
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 02:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 418EA88F01;
	Sun, 27 Oct 2024 03:05:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CVd4BmWu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JCN0eEkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBA188F01; Sun, 27 Oct 2024 03:05:24 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C41A88C10
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 03:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XbfxC6NMBz9smf;
 Sun, 27 Oct 2024 03:05:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729994719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KqahMKhFxEB3L139OxxaM19YD5/bpvOuHzoqldCmG4U=;
 b=CVd4BmWurmgpA6iQJg/BSRZks5dCQun/RJjbJWda0D+tPL0u1rIjWHmAALtxk5WMDYUAAG
 yTooJz21H3skTNeIszoICORZZDzN6L0+Ijs/bs9cxhin0KN5sm+biIQQ6Gybnk3p6nUDEW
 XOSmnSHmuW6wfjO8vRtZT37YeM0c/8loOoTGK6O0GNi0/wal5GTkrt+Imm7JJTAGsUwWdG
 trRdFJsTmB8r77+39xK9GbhJmfn5iqJfviGnZR87j+4/fIi04pVMY8zXmjsySG9CQEPi8c
 2YMm6u+OdxiGCehd7hLp91mpPju/+3qdwgBs+vkNUMSqBxGbhmzMYzSj2RWpNQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729994718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KqahMKhFxEB3L139OxxaM19YD5/bpvOuHzoqldCmG4U=;
 b=JCN0eEkHA/nE+HrcQyIsqXjB7ETaGhuj/KgKDvt3RTUrtM9AcBwPHtXWnPYZsTcdQF6dav
 uKm9F18O1rCa5Mz87IlSrGVn3sEZFHJCKmeKwQfO9r5jB0G+rEYRG/Z0IxXcGmk6j8Mw+s
 hW3qI6EqNbQc1ItYJPaUTTjmskoXjB2opE00qJ6LCHzsF/QgxM1HgYC4BTvOHw5vjM0lft
 y1xj7U0BiORkjvRBrIJhnVfz6kGtjDSXj/IrZNDLkBkT4Iuw8wYx+0adTv5auHnczHyJ7B
 L6Vg+TqKDuYUOaL2JN2F++VGUYeIPNWCnEhBlpyR9AQl9YyTNW4JOHjGVxMY6w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Cogent Embedded, Inc." <source@cogentembedded.com>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] ARM: renesas: Drop old unused clock DT headers
Date: Sun, 27 Oct 2024 03:04:30 +0100
Message-ID: <20241027020504.354623-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wt5w9nxf8pummnp6h47zjn5e9rzaarfw
X-MBO-RS-ID: db4d82d7e9638d8246c
X-Rspamd-Queue-Id: 4XbfxC6NMBz9smf
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

Renesas R-Car systems use mainline Linux DTs for U-Boot via OF_UPSTREAM,
which also includes headers from dts/upstream/include/dt-bindings/clock .
Remove unused legacy DT header files from include/dt-bindings/clock .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Cogent Embedded, Inc." <source@cogentembedded.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Masakazu Mochizuki <masakazu.mochizuki.wd@hitachi.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 include/dt-bindings/clock/r8a774a1-cpg-mssr.h | 59 ------------
 include/dt-bindings/clock/r8a774b1-cpg-mssr.h | 57 -----------
 include/dt-bindings/clock/r8a774c0-cpg-mssr.h | 61 ------------
 include/dt-bindings/clock/r8a774e1-cpg-mssr.h | 59 ------------
 include/dt-bindings/clock/r8a7790-cpg-mssr.h  | 48 ----------
 include/dt-bindings/clock/r8a7791-cpg-mssr.h  | 44 ---------
 include/dt-bindings/clock/r8a7792-cpg-mssr.h  | 39 --------
 include/dt-bindings/clock/r8a7793-cpg-mssr.h  | 44 ---------
 include/dt-bindings/clock/r8a7794-cpg-mssr.h  | 43 ---------
 include/dt-bindings/clock/r8a7795-cpg-mssr.h  | 66 -------------
 include/dt-bindings/clock/r8a7796-cpg-mssr.h  | 65 -------------
 include/dt-bindings/clock/r8a77961-cpg-mssr.h | 65 -------------
 include/dt-bindings/clock/r8a77965-cpg-mssr.h | 62 ------------
 include/dt-bindings/clock/r8a77970-cpg-mssr.h | 44 ---------
 include/dt-bindings/clock/r8a77980-cpg-mssr.h | 51 ----------
 include/dt-bindings/clock/r8a77990-cpg-mssr.h | 62 ------------
 include/dt-bindings/clock/r8a77995-cpg-mssr.h | 54 -----------
 include/dt-bindings/clock/r8a779a0-cpg-mssr.h | 55 -----------
 include/dt-bindings/clock/r8a779f0-cpg-mssr.h | 64 -------------
 include/dt-bindings/clock/r8a779g0-cpg-mssr.h | 91 ------------------
 .../clock/renesas,r8a779h0-cpg-mssr.h         | 96 -------------------
 include/dt-bindings/clock/renesas-cpg-mssr.h  | 15 ---
 22 files changed, 1244 deletions(-)
 delete mode 100644 include/dt-bindings/clock/r8a774a1-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a774b1-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a774c0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a774e1-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7790-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7791-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7792-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7793-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7794-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7795-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a7796-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77961-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77965-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77970-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77980-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77990-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a77995-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a779a0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a779f0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/r8a779g0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
 delete mode 100644 include/dt-bindings/clock/renesas-cpg-mssr.h

diff --git a/include/dt-bindings/clock/r8a774a1-cpg-mssr.h b/include/dt-bindings/clock/r8a774a1-cpg-mssr.h
deleted file mode 100644
index e355363f40c..00000000000
--- a/include/dt-bindings/clock/r8a774a1-cpg-mssr.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2018 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A774A1_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A774A1_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a774a1 CPG Core Clocks */
-#define R8A774A1_CLK_Z			0
-#define R8A774A1_CLK_Z2			1
-#define R8A774A1_CLK_ZG			2
-#define R8A774A1_CLK_ZTR		3
-#define R8A774A1_CLK_ZTRD2		4
-#define R8A774A1_CLK_ZT			5
-#define R8A774A1_CLK_ZX			6
-#define R8A774A1_CLK_S0D1		7
-#define R8A774A1_CLK_S0D2		8
-#define R8A774A1_CLK_S0D3		9
-#define R8A774A1_CLK_S0D4		10
-#define R8A774A1_CLK_S0D6		11
-#define R8A774A1_CLK_S0D8		12
-#define R8A774A1_CLK_S0D12		13
-#define R8A774A1_CLK_S1D2		14
-#define R8A774A1_CLK_S1D4		15
-#define R8A774A1_CLK_S2D1		16
-#define R8A774A1_CLK_S2D2		17
-#define R8A774A1_CLK_S2D4		18
-#define R8A774A1_CLK_S3D1		19
-#define R8A774A1_CLK_S3D2		20
-#define R8A774A1_CLK_S3D4		21
-#define R8A774A1_CLK_LB			22
-#define R8A774A1_CLK_CL			23
-#define R8A774A1_CLK_ZB3		24
-#define R8A774A1_CLK_ZB3D2		25
-#define R8A774A1_CLK_ZB3D4		26
-#define R8A774A1_CLK_CR			27
-#define R8A774A1_CLK_CRD2		28
-#define R8A774A1_CLK_SD0H		29
-#define R8A774A1_CLK_SD0		30
-#define R8A774A1_CLK_SD1H		31
-#define R8A774A1_CLK_SD1		32
-#define R8A774A1_CLK_SD2H		33
-#define R8A774A1_CLK_SD2		34
-#define R8A774A1_CLK_SD3H		35
-#define R8A774A1_CLK_SD3		36
-#define R8A774A1_CLK_RPC		37
-#define R8A774A1_CLK_RPCD2		38
-#define R8A774A1_CLK_MSO		39
-#define R8A774A1_CLK_HDMI		40
-#define R8A774A1_CLK_CSI0		41
-#define R8A774A1_CLK_CP			42
-#define R8A774A1_CLK_CPEX		43
-#define R8A774A1_CLK_R			44
-#define R8A774A1_CLK_OSC		45
-#define R8A774A1_CLK_CANFD		46
-
-#endif /* __DT_BINDINGS_CLOCK_R8A774A1_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a774b1-cpg-mssr.h b/include/dt-bindings/clock/r8a774b1-cpg-mssr.h
deleted file mode 100644
index 1355451b74b..00000000000
--- a/include/dt-bindings/clock/r8a774b1-cpg-mssr.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2019 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A774B1_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A774B1_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a774b1 CPG Core Clocks */
-#define R8A774B1_CLK_Z			0
-#define R8A774B1_CLK_ZG			1
-#define R8A774B1_CLK_ZTR		2
-#define R8A774B1_CLK_ZTRD2		3
-#define R8A774B1_CLK_ZT			4
-#define R8A774B1_CLK_ZX			5
-#define R8A774B1_CLK_S0D1		6
-#define R8A774B1_CLK_S0D2		7
-#define R8A774B1_CLK_S0D3		8
-#define R8A774B1_CLK_S0D4		9
-#define R8A774B1_CLK_S0D6		10
-#define R8A774B1_CLK_S0D8		11
-#define R8A774B1_CLK_S0D12		12
-#define R8A774B1_CLK_S1D2		13
-#define R8A774B1_CLK_S1D4		14
-#define R8A774B1_CLK_S2D1		15
-#define R8A774B1_CLK_S2D2		16
-#define R8A774B1_CLK_S2D4		17
-#define R8A774B1_CLK_S3D1		18
-#define R8A774B1_CLK_S3D2		19
-#define R8A774B1_CLK_S3D4		20
-#define R8A774B1_CLK_LB			21
-#define R8A774B1_CLK_CL			22
-#define R8A774B1_CLK_ZB3		23
-#define R8A774B1_CLK_ZB3D2		24
-#define R8A774B1_CLK_CR			25
-#define R8A774B1_CLK_DDR		26
-#define R8A774B1_CLK_SD0H		27
-#define R8A774B1_CLK_SD0		28
-#define R8A774B1_CLK_SD1H		29
-#define R8A774B1_CLK_SD1		30
-#define R8A774B1_CLK_SD2H		31
-#define R8A774B1_CLK_SD2		32
-#define R8A774B1_CLK_SD3H		33
-#define R8A774B1_CLK_SD3		34
-#define R8A774B1_CLK_RPC		35
-#define R8A774B1_CLK_RPCD2		36
-#define R8A774B1_CLK_MSO		37
-#define R8A774B1_CLK_HDMI		38
-#define R8A774B1_CLK_CSI0		39
-#define R8A774B1_CLK_CP			40
-#define R8A774B1_CLK_CPEX		41
-#define R8A774B1_CLK_R			42
-#define R8A774B1_CLK_OSC		43
-#define R8A774B1_CLK_CANFD		44
-
-#endif /* __DT_BINDINGS_CLOCK_R8A774B1_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a774c0-cpg-mssr.h b/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
deleted file mode 100644
index 8ad9cd6be8e..00000000000
--- a/include/dt-bindings/clock/r8a774c0-cpg-mssr.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A774C0_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A774C0_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a774c0 CPG Core Clocks */
-#define R8A774C0_CLK_Z2			0
-#define R8A774C0_CLK_ZG			1
-#define R8A774C0_CLK_ZTR		2
-#define R8A774C0_CLK_ZT			3
-#define R8A774C0_CLK_ZX			4
-#define R8A774C0_CLK_S0D1		5
-#define R8A774C0_CLK_S0D3		6
-#define R8A774C0_CLK_S0D6		7
-#define R8A774C0_CLK_S0D12		8
-#define R8A774C0_CLK_S0D24		9
-#define R8A774C0_CLK_S1D1		10
-#define R8A774C0_CLK_S1D2		11
-#define R8A774C0_CLK_S1D4		12
-#define R8A774C0_CLK_S2D1		13
-#define R8A774C0_CLK_S2D2		14
-#define R8A774C0_CLK_S2D4		15
-#define R8A774C0_CLK_S3D1		16
-#define R8A774C0_CLK_S3D2		17
-#define R8A774C0_CLK_S3D4		18
-#define R8A774C0_CLK_S0D6C		19
-#define R8A774C0_CLK_S3D1C		20
-#define R8A774C0_CLK_S3D2C		21
-#define R8A774C0_CLK_S3D4C		22
-#define R8A774C0_CLK_LB			23
-#define R8A774C0_CLK_CL			24
-#define R8A774C0_CLK_ZB3		25
-#define R8A774C0_CLK_ZB3D2		26
-#define R8A774C0_CLK_CR			27
-#define R8A774C0_CLK_CRD2		28
-#define R8A774C0_CLK_SD0H		29
-#define R8A774C0_CLK_SD0		30
-#define R8A774C0_CLK_SD1H		31
-#define R8A774C0_CLK_SD1		32
-#define R8A774C0_CLK_SD3H		33
-#define R8A774C0_CLK_SD3		34
-#define R8A774C0_CLK_RPC		35
-#define R8A774C0_CLK_RPCD2		36
-#define R8A774C0_CLK_ZA2		37
-#define R8A774C0_CLK_ZA8		38
-#define R8A774C0_CLK_Z2D		39
-#define R8A774C0_CLK_MSO		40
-#define R8A774C0_CLK_R			41
-#define R8A774C0_CLK_OSC		42
-#define R8A774C0_CLK_LV0		43
-#define R8A774C0_CLK_LV1		44
-#define R8A774C0_CLK_CSI0		45
-#define R8A774C0_CLK_CP			46
-#define R8A774C0_CLK_CPEX		47
-#define R8A774C0_CLK_CANFD		48
-
-#endif /* __DT_BINDINGS_CLOCK_R8A774C0_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a774e1-cpg-mssr.h b/include/dt-bindings/clock/r8a774e1-cpg-mssr.h
deleted file mode 100644
index b2fc1d1c3c4..00000000000
--- a/include/dt-bindings/clock/r8a774e1-cpg-mssr.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2020 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A774E1_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A774E1_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* R8A774E1 CPG Core Clocks */
-#define R8A774E1_CLK_Z			0
-#define R8A774E1_CLK_Z2			1
-#define R8A774E1_CLK_ZG			2
-#define R8A774E1_CLK_ZTR		3
-#define R8A774E1_CLK_ZTRD2		4
-#define R8A774E1_CLK_ZT			5
-#define R8A774E1_CLK_ZX			6
-#define R8A774E1_CLK_S0D1		7
-#define R8A774E1_CLK_S0D2		8
-#define R8A774E1_CLK_S0D3		9
-#define R8A774E1_CLK_S0D4		10
-#define R8A774E1_CLK_S0D6		11
-#define R8A774E1_CLK_S0D8		12
-#define R8A774E1_CLK_S0D12		13
-#define R8A774E1_CLK_S1D2		14
-#define R8A774E1_CLK_S1D4		15
-#define R8A774E1_CLK_S2D1		16
-#define R8A774E1_CLK_S2D2		17
-#define R8A774E1_CLK_S2D4		18
-#define R8A774E1_CLK_S3D1		19
-#define R8A774E1_CLK_S3D2		20
-#define R8A774E1_CLK_S3D4		21
-#define R8A774E1_CLK_LB			22
-#define R8A774E1_CLK_CL			23
-#define R8A774E1_CLK_ZB3		24
-#define R8A774E1_CLK_ZB3D2		25
-#define R8A774E1_CLK_ZB3D4		26
-#define R8A774E1_CLK_CR			27
-#define R8A774E1_CLK_CRD2		28
-#define R8A774E1_CLK_SD0H		29
-#define R8A774E1_CLK_SD0		30
-#define R8A774E1_CLK_SD1H		31
-#define R8A774E1_CLK_SD1		32
-#define R8A774E1_CLK_SD2H		33
-#define R8A774E1_CLK_SD2		34
-#define R8A774E1_CLK_SD3H		35
-#define R8A774E1_CLK_SD3		36
-#define R8A774E1_CLK_RPC		37
-#define R8A774E1_CLK_RPCD2		38
-#define R8A774E1_CLK_MSO		39
-#define R8A774E1_CLK_HDMI		40
-#define R8A774E1_CLK_CSI0		41
-#define R8A774E1_CLK_CP			42
-#define R8A774E1_CLK_CPEX		43
-#define R8A774E1_CLK_R			44
-#define R8A774E1_CLK_OSC		45
-#define R8A774E1_CLK_CANFD		46
-
-#endif /* __DT_BINDINGS_CLOCK_R8A774E1_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a7790-cpg-mssr.h b/include/dt-bindings/clock/r8a7790-cpg-mssr.h
deleted file mode 100644
index c5955b56b36..00000000000
--- a/include/dt-bindings/clock/r8a7790-cpg-mssr.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2015 Renesas Electronics Corp.
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7790_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A7790_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a7790 CPG Core Clocks */
-#define R8A7790_CLK_Z			0
-#define R8A7790_CLK_Z2			1
-#define R8A7790_CLK_ZG			2
-#define R8A7790_CLK_ZTR			3
-#define R8A7790_CLK_ZTRD2		4
-#define R8A7790_CLK_ZT			5
-#define R8A7790_CLK_ZX			6
-#define R8A7790_CLK_ZS			7
-#define R8A7790_CLK_HP			8
-#define R8A7790_CLK_I			9
-#define R8A7790_CLK_B			10
-#define R8A7790_CLK_LB			11
-#define R8A7790_CLK_P			12
-#define R8A7790_CLK_CL			13
-#define R8A7790_CLK_M2			14
-#define R8A7790_CLK_ADSP		15
-#define R8A7790_CLK_IMP			16
-#define R8A7790_CLK_ZB3			17
-#define R8A7790_CLK_ZB3D2		18
-#define R8A7790_CLK_DDR			19
-#define R8A7790_CLK_SDH			20
-#define R8A7790_CLK_SD0			21
-#define R8A7790_CLK_SD1			22
-#define R8A7790_CLK_SD2			23
-#define R8A7790_CLK_SD3			24
-#define R8A7790_CLK_MMC0		25
-#define R8A7790_CLK_MMC1		26
-#define R8A7790_CLK_MP			27
-#define R8A7790_CLK_SSP			28
-#define R8A7790_CLK_SSPRS		29
-#define R8A7790_CLK_QSPI		30
-#define R8A7790_CLK_CP			31
-#define R8A7790_CLK_RCAN		32
-#define R8A7790_CLK_R			33
-#define R8A7790_CLK_OSC			34
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7790_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a7791-cpg-mssr.h b/include/dt-bindings/clock/r8a7791-cpg-mssr.h
deleted file mode 100644
index aadd06c566c..00000000000
--- a/include/dt-bindings/clock/r8a7791-cpg-mssr.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2015 Renesas Electronics Corp.
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7791_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A7791_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a7791 CPG Core Clocks */
-#define R8A7791_CLK_Z			0
-#define R8A7791_CLK_ZG			1
-#define R8A7791_CLK_ZTR			2
-#define R8A7791_CLK_ZTRD2		3
-#define R8A7791_CLK_ZT			4
-#define R8A7791_CLK_ZX			5
-#define R8A7791_CLK_ZS			6
-#define R8A7791_CLK_HP			7
-#define R8A7791_CLK_I			8
-#define R8A7791_CLK_B			9
-#define R8A7791_CLK_LB			10
-#define R8A7791_CLK_P			11
-#define R8A7791_CLK_CL			12
-#define R8A7791_CLK_M2			13
-#define R8A7791_CLK_ADSP		14
-#define R8A7791_CLK_ZB3			15
-#define R8A7791_CLK_ZB3D2		16
-#define R8A7791_CLK_DDR			17
-#define R8A7791_CLK_SDH			18
-#define R8A7791_CLK_SD0			19
-#define R8A7791_CLK_SD2			20
-#define R8A7791_CLK_SD3			21
-#define R8A7791_CLK_MMC0		22
-#define R8A7791_CLK_MP			23
-#define R8A7791_CLK_SSP			24
-#define R8A7791_CLK_SSPRS		25
-#define R8A7791_CLK_QSPI		26
-#define R8A7791_CLK_CP			27
-#define R8A7791_CLK_RCAN		28
-#define R8A7791_CLK_R			29
-#define R8A7791_CLK_OSC			30
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7791_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a7792-cpg-mssr.h b/include/dt-bindings/clock/r8a7792-cpg-mssr.h
deleted file mode 100644
index 829c44db027..00000000000
--- a/include/dt-bindings/clock/r8a7792-cpg-mssr.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2015 Renesas Electronics Corp.
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7792_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A7792_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a7792 CPG Core Clocks */
-#define R8A7792_CLK_Z			0
-#define R8A7792_CLK_ZG			1
-#define R8A7792_CLK_ZTR			2
-#define R8A7792_CLK_ZTRD2		3
-#define R8A7792_CLK_ZT			4
-#define R8A7792_CLK_ZX			5
-#define R8A7792_CLK_ZS			6
-#define R8A7792_CLK_HP			7
-#define R8A7792_CLK_I			8
-#define R8A7792_CLK_B			9
-#define R8A7792_CLK_LB			10
-#define R8A7792_CLK_P			11
-#define R8A7792_CLK_CL			12
-#define R8A7792_CLK_M2			13
-#define R8A7792_CLK_IMP			14
-#define R8A7792_CLK_ZB3			15
-#define R8A7792_CLK_ZB3D2		16
-#define R8A7792_CLK_DDR			17
-#define R8A7792_CLK_SD			18
-#define R8A7792_CLK_MP			19
-#define R8A7792_CLK_QSPI		20
-#define R8A7792_CLK_CP			21
-#define R8A7792_CLK_CPEX		22
-#define R8A7792_CLK_RCAN		23
-#define R8A7792_CLK_R			24
-#define R8A7792_CLK_OSC			25
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7792_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a7793-cpg-mssr.h b/include/dt-bindings/clock/r8a7793-cpg-mssr.h
deleted file mode 100644
index d1ff646c31f..00000000000
--- a/include/dt-bindings/clock/r8a7793-cpg-mssr.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2015 Renesas Electronics Corp.
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7793_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A7793_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a7793 CPG Core Clocks */
-#define R8A7793_CLK_Z			0
-#define R8A7793_CLK_ZG			1
-#define R8A7793_CLK_ZTR			2
-#define R8A7793_CLK_ZTRD2		3
-#define R8A7793_CLK_ZT			4
-#define R8A7793_CLK_ZX			5
-#define R8A7793_CLK_ZS			6
-#define R8A7793_CLK_HP			7
-#define R8A7793_CLK_I			8
-#define R8A7793_CLK_B			9
-#define R8A7793_CLK_LB			10
-#define R8A7793_CLK_P			11
-#define R8A7793_CLK_CL			12
-#define R8A7793_CLK_M2			13
-#define R8A7793_CLK_ADSP		14
-#define R8A7793_CLK_ZB3			15
-#define R8A7793_CLK_ZB3D2		16
-#define R8A7793_CLK_DDR			17
-#define R8A7793_CLK_SDH			18
-#define R8A7793_CLK_SD0			19
-#define R8A7793_CLK_SD2			20
-#define R8A7793_CLK_SD3			21
-#define R8A7793_CLK_MMC0		22
-#define R8A7793_CLK_MP			23
-#define R8A7793_CLK_SSP			24
-#define R8A7793_CLK_SSPRS		25
-#define R8A7793_CLK_QSPI		26
-#define R8A7793_CLK_CP			27
-#define R8A7793_CLK_RCAN		28
-#define R8A7793_CLK_R			29
-#define R8A7793_CLK_OSC			30
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7793_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a7794-cpg-mssr.h b/include/dt-bindings/clock/r8a7794-cpg-mssr.h
deleted file mode 100644
index 6314e23b51a..00000000000
--- a/include/dt-bindings/clock/r8a7794-cpg-mssr.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2015 Renesas Electronics Corp.
- */
-
-#ifndef __DT_BINDINGS_CLOCK_R8A7794_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A7794_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a7794 CPG Core Clocks */
-#define R8A7794_CLK_Z2			0
-#define R8A7794_CLK_ZG			1
-#define R8A7794_CLK_ZTR			2
-#define R8A7794_CLK_ZTRD2		3
-#define R8A7794_CLK_ZT			4
-#define R8A7794_CLK_ZX			5
-#define R8A7794_CLK_ZS			6
-#define R8A7794_CLK_HP			7
-#define R8A7794_CLK_I			8
-#define R8A7794_CLK_B			9
-#define R8A7794_CLK_LB			10
-#define R8A7794_CLK_P			11
-#define R8A7794_CLK_CL			12
-#define R8A7794_CLK_CP			13
-#define R8A7794_CLK_M2			14
-#define R8A7794_CLK_ADSP		15
-#define R8A7794_CLK_ZB3			16
-#define R8A7794_CLK_ZB3D2		17
-#define R8A7794_CLK_DDR			18
-#define R8A7794_CLK_SDH			19
-#define R8A7794_CLK_SD0			20
-#define R8A7794_CLK_SD2			21
-#define R8A7794_CLK_SD3			22
-#define R8A7794_CLK_MMC0		23
-#define R8A7794_CLK_MP			24
-#define R8A7794_CLK_QSPI		25
-#define R8A7794_CLK_CPEX		26
-#define R8A7794_CLK_RCAN		27
-#define R8A7794_CLK_R			28
-#define R8A7794_CLK_OSC			29
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7794_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a7795-cpg-mssr.h b/include/dt-bindings/clock/r8a7795-cpg-mssr.h
deleted file mode 100644
index 92b3e2a9517..00000000000
--- a/include/dt-bindings/clock/r8a7795-cpg-mssr.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2015 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A7795_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A7795_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a7795 CPG Core Clocks */
-#define R8A7795_CLK_Z			0
-#define R8A7795_CLK_Z2			1
-#define R8A7795_CLK_ZR			2
-#define R8A7795_CLK_ZG			3
-#define R8A7795_CLK_ZTR			4
-#define R8A7795_CLK_ZTRD2		5
-#define R8A7795_CLK_ZT			6
-#define R8A7795_CLK_ZX			7
-#define R8A7795_CLK_S0D1		8
-#define R8A7795_CLK_S0D4		9
-#define R8A7795_CLK_S1D1		10
-#define R8A7795_CLK_S1D2		11
-#define R8A7795_CLK_S1D4		12
-#define R8A7795_CLK_S2D1		13
-#define R8A7795_CLK_S2D2		14
-#define R8A7795_CLK_S2D4		15
-#define R8A7795_CLK_S3D1		16
-#define R8A7795_CLK_S3D2		17
-#define R8A7795_CLK_S3D4		18
-#define R8A7795_CLK_LB			19
-#define R8A7795_CLK_CL			20
-#define R8A7795_CLK_ZB3			21
-#define R8A7795_CLK_ZB3D2		22
-#define R8A7795_CLK_CR			23
-#define R8A7795_CLK_CRD2		24
-#define R8A7795_CLK_SD0H		25
-#define R8A7795_CLK_SD0			26
-#define R8A7795_CLK_SD1H		27
-#define R8A7795_CLK_SD1			28
-#define R8A7795_CLK_SD2H		29
-#define R8A7795_CLK_SD2			30
-#define R8A7795_CLK_SD3H		31
-#define R8A7795_CLK_SD3			32
-#define R8A7795_CLK_SSP2		33
-#define R8A7795_CLK_SSP1		34
-#define R8A7795_CLK_SSPRS		35
-#define R8A7795_CLK_RPC			36
-#define R8A7795_CLK_RPCD2		37
-#define R8A7795_CLK_MSO			38
-#define R8A7795_CLK_CANFD		39
-#define R8A7795_CLK_HDMI		40
-#define R8A7795_CLK_CSI0		41
-/* CLK_CSIREF was removed */
-#define R8A7795_CLK_CP			43
-#define R8A7795_CLK_CPEX		44
-#define R8A7795_CLK_R			45
-#define R8A7795_CLK_OSC			46
-
-/* r8a7795 ES2.0 CPG Core Clocks */
-#define R8A7795_CLK_S0D2		47
-#define R8A7795_CLK_S0D3		48
-#define R8A7795_CLK_S0D6		49
-#define R8A7795_CLK_S0D8		50
-#define R8A7795_CLK_S0D12		51
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7795_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a7796-cpg-mssr.h b/include/dt-bindings/clock/r8a7796-cpg-mssr.h
deleted file mode 100644
index c0957cf4584..00000000000
--- a/include/dt-bindings/clock/r8a7796-cpg-mssr.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2016 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A7796_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A7796_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a7796 CPG Core Clocks */
-#define R8A7796_CLK_Z			0
-#define R8A7796_CLK_Z2			1
-#define R8A7796_CLK_ZR			2
-#define R8A7796_CLK_ZG			3
-#define R8A7796_CLK_ZTR			4
-#define R8A7796_CLK_ZTRD2		5
-#define R8A7796_CLK_ZT			6
-#define R8A7796_CLK_ZX			7
-#define R8A7796_CLK_S0D1		8
-#define R8A7796_CLK_S0D2		9
-#define R8A7796_CLK_S0D3		10
-#define R8A7796_CLK_S0D4		11
-#define R8A7796_CLK_S0D6		12
-#define R8A7796_CLK_S0D8		13
-#define R8A7796_CLK_S0D12		14
-#define R8A7796_CLK_S1D1		15
-#define R8A7796_CLK_S1D2		16
-#define R8A7796_CLK_S1D4		17
-#define R8A7796_CLK_S2D1		18
-#define R8A7796_CLK_S2D2		19
-#define R8A7796_CLK_S2D4		20
-#define R8A7796_CLK_S3D1		21
-#define R8A7796_CLK_S3D2		22
-#define R8A7796_CLK_S3D4		23
-#define R8A7796_CLK_LB			24
-#define R8A7796_CLK_CL			25
-#define R8A7796_CLK_ZB3			26
-#define R8A7796_CLK_ZB3D2		27
-#define R8A7796_CLK_ZB3D4		28
-#define R8A7796_CLK_CR			29
-#define R8A7796_CLK_CRD2		30
-#define R8A7796_CLK_SD0H		31
-#define R8A7796_CLK_SD0			32
-#define R8A7796_CLK_SD1H		33
-#define R8A7796_CLK_SD1			34
-#define R8A7796_CLK_SD2H		35
-#define R8A7796_CLK_SD2			36
-#define R8A7796_CLK_SD3H		37
-#define R8A7796_CLK_SD3			38
-#define R8A7796_CLK_SSP2		39
-#define R8A7796_CLK_SSP1		40
-#define R8A7796_CLK_SSPRS		41
-#define R8A7796_CLK_RPC			42
-#define R8A7796_CLK_RPCD2		43
-#define R8A7796_CLK_MSO			44
-#define R8A7796_CLK_CANFD		45
-#define R8A7796_CLK_HDMI		46
-#define R8A7796_CLK_CSI0		47
-/* CLK_CSIREF was removed */
-#define R8A7796_CLK_CP			49
-#define R8A7796_CLK_CPEX		50
-#define R8A7796_CLK_R			51
-#define R8A7796_CLK_OSC			52
-
-#endif /* __DT_BINDINGS_CLOCK_R8A7796_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a77961-cpg-mssr.h b/include/dt-bindings/clock/r8a77961-cpg-mssr.h
deleted file mode 100644
index 7921d785546..00000000000
--- a/include/dt-bindings/clock/r8a77961-cpg-mssr.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2019 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A77961_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A77961_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a77961 CPG Core Clocks */
-#define R8A77961_CLK_Z			0
-#define R8A77961_CLK_Z2			1
-#define R8A77961_CLK_ZR			2
-#define R8A77961_CLK_ZG			3
-#define R8A77961_CLK_ZTR			4
-#define R8A77961_CLK_ZTRD2		5
-#define R8A77961_CLK_ZT			6
-#define R8A77961_CLK_ZX			7
-#define R8A77961_CLK_S0D1		8
-#define R8A77961_CLK_S0D2		9
-#define R8A77961_CLK_S0D3		10
-#define R8A77961_CLK_S0D4		11
-#define R8A77961_CLK_S0D6		12
-#define R8A77961_CLK_S0D8		13
-#define R8A77961_CLK_S0D12		14
-#define R8A77961_CLK_S1D1		15
-#define R8A77961_CLK_S1D2		16
-#define R8A77961_CLK_S1D4		17
-#define R8A77961_CLK_S2D1		18
-#define R8A77961_CLK_S2D2		19
-#define R8A77961_CLK_S2D4		20
-#define R8A77961_CLK_S3D1		21
-#define R8A77961_CLK_S3D2		22
-#define R8A77961_CLK_S3D4		23
-#define R8A77961_CLK_LB			24
-#define R8A77961_CLK_CL			25
-#define R8A77961_CLK_ZB3			26
-#define R8A77961_CLK_ZB3D2		27
-#define R8A77961_CLK_ZB3D4		28
-#define R8A77961_CLK_CR			29
-#define R8A77961_CLK_CRD2		30
-#define R8A77961_CLK_SD0H		31
-#define R8A77961_CLK_SD0			32
-#define R8A77961_CLK_SD1H		33
-#define R8A77961_CLK_SD1			34
-#define R8A77961_CLK_SD2H		35
-#define R8A77961_CLK_SD2			36
-#define R8A77961_CLK_SD3H		37
-#define R8A77961_CLK_SD3			38
-#define R8A77961_CLK_SSP2		39
-#define R8A77961_CLK_SSP1		40
-#define R8A77961_CLK_SSPRS		41
-#define R8A77961_CLK_RPC			42
-#define R8A77961_CLK_RPCD2		43
-#define R8A77961_CLK_MSO			44
-#define R8A77961_CLK_CANFD		45
-#define R8A77961_CLK_HDMI		46
-#define R8A77961_CLK_CSI0		47
-/* CLK_CSIREF was removed */
-#define R8A77961_CLK_CP			49
-#define R8A77961_CLK_CPEX		50
-#define R8A77961_CLK_R			51
-#define R8A77961_CLK_OSC			52
-
-#endif /* __DT_BINDINGS_CLOCK_R8A77961_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a77965-cpg-mssr.h b/include/dt-bindings/clock/r8a77965-cpg-mssr.h
deleted file mode 100644
index 6d3b5a9a608..00000000000
--- a/include/dt-bindings/clock/r8a77965-cpg-mssr.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A77965_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A77965_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a77965 CPG Core Clocks */
-#define R8A77965_CLK_Z			0
-#define R8A77965_CLK_ZR			1
-#define R8A77965_CLK_ZG			2
-#define R8A77965_CLK_ZTR		3
-#define R8A77965_CLK_ZTRD2		4
-#define R8A77965_CLK_ZT			5
-#define R8A77965_CLK_ZX			6
-#define R8A77965_CLK_S0D1		7
-#define R8A77965_CLK_S0D2		8
-#define R8A77965_CLK_S0D3		9
-#define R8A77965_CLK_S0D4		10
-#define R8A77965_CLK_S0D6		11
-#define R8A77965_CLK_S0D8		12
-#define R8A77965_CLK_S0D12		13
-#define R8A77965_CLK_S1D1		14
-#define R8A77965_CLK_S1D2		15
-#define R8A77965_CLK_S1D4		16
-#define R8A77965_CLK_S2D1		17
-#define R8A77965_CLK_S2D2		18
-#define R8A77965_CLK_S2D4		19
-#define R8A77965_CLK_S3D1		20
-#define R8A77965_CLK_S3D2		21
-#define R8A77965_CLK_S3D4		22
-#define R8A77965_CLK_LB			23
-#define R8A77965_CLK_CL			24
-#define R8A77965_CLK_ZB3		25
-#define R8A77965_CLK_ZB3D2		26
-#define R8A77965_CLK_CR			27
-#define R8A77965_CLK_CRD2		28
-#define R8A77965_CLK_SD0H		29
-#define R8A77965_CLK_SD0		30
-#define R8A77965_CLK_SD1H		31
-#define R8A77965_CLK_SD1		32
-#define R8A77965_CLK_SD2H		33
-#define R8A77965_CLK_SD2		34
-#define R8A77965_CLK_SD3H		35
-#define R8A77965_CLK_SD3		36
-#define R8A77965_CLK_SSP2		37
-#define R8A77965_CLK_SSP1		38
-#define R8A77965_CLK_SSPRS		39
-#define R8A77965_CLK_RPC		40
-#define R8A77965_CLK_RPCD2		41
-#define R8A77965_CLK_MSO		42
-#define R8A77965_CLK_CANFD		43
-#define R8A77965_CLK_HDMI		44
-#define R8A77965_CLK_CSI0		45
-#define R8A77965_CLK_CP			46
-#define R8A77965_CLK_CPEX		47
-#define R8A77965_CLK_R			48
-#define R8A77965_CLK_OSC		49
-
-#endif /* __DT_BINDINGS_CLOCK_R8A77965_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a77970-cpg-mssr.h b/include/dt-bindings/clock/r8a77970-cpg-mssr.h
deleted file mode 100644
index 6145ebe6636..00000000000
--- a/include/dt-bindings/clock/r8a77970-cpg-mssr.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2016 Renesas Electronics Corp.
- * Copyright (C) 2017 Cogent Embedded, Inc.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A77970_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A77970_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a77970 CPG Core Clocks */
-#define R8A77970_CLK_Z2			0
-#define R8A77970_CLK_ZR			1
-#define R8A77970_CLK_ZTR		2
-#define R8A77970_CLK_ZTRD2		3
-#define R8A77970_CLK_ZT			4
-#define R8A77970_CLK_ZX			5
-#define R8A77970_CLK_S1D1		6
-#define R8A77970_CLK_S1D2		7
-#define R8A77970_CLK_S1D4		8
-#define R8A77970_CLK_S2D1		9
-#define R8A77970_CLK_S2D2		10
-#define R8A77970_CLK_S2D4		11
-#define R8A77970_CLK_LB			12
-#define R8A77970_CLK_CL			13
-#define R8A77970_CLK_ZB3		14
-#define R8A77970_CLK_ZB3D2		15
-#define R8A77970_CLK_DDR		16
-#define R8A77970_CLK_CR			17
-#define R8A77970_CLK_CRD2		18
-#define R8A77970_CLK_SD0H		19
-#define R8A77970_CLK_SD0		20
-#define R8A77970_CLK_RPC		21
-#define R8A77970_CLK_RPCD2		22
-#define R8A77970_CLK_MSO		23
-#define R8A77970_CLK_CANFD		24
-#define R8A77970_CLK_CSI0		25
-#define R8A77970_CLK_FRAY		26
-#define R8A77970_CLK_CP			27
-#define R8A77970_CLK_CPEX		28
-#define R8A77970_CLK_R			29
-#define R8A77970_CLK_OSC		30
-
-#endif /* __DT_BINDINGS_CLOCK_R8A77970_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a77980-cpg-mssr.h b/include/dt-bindings/clock/r8a77980-cpg-mssr.h
deleted file mode 100644
index a4c0d76c392..00000000000
--- a/include/dt-bindings/clock/r8a77980-cpg-mssr.h
+++ /dev/null
@@ -1,51 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018 Renesas Electronics Corp.
- * Copyright (C) 2018 Cogent Embedded, Inc.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A77980_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A77980_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a77980 CPG Core Clocks */
-#define R8A77980_CLK_Z2			0
-#define R8A77980_CLK_ZR			1
-#define R8A77980_CLK_ZTR		2
-#define R8A77980_CLK_ZTRD2		3
-#define R8A77980_CLK_ZT			4
-#define R8A77980_CLK_ZX			5
-#define R8A77980_CLK_S0D1		6
-#define R8A77980_CLK_S0D2		7
-#define R8A77980_CLK_S0D3		8
-#define R8A77980_CLK_S0D4		9
-#define R8A77980_CLK_S0D6		10
-#define R8A77980_CLK_S0D12		11
-#define R8A77980_CLK_S0D24		12
-#define R8A77980_CLK_S1D1		13
-#define R8A77980_CLK_S1D2		14
-#define R8A77980_CLK_S1D4		15
-#define R8A77980_CLK_S2D1		16
-#define R8A77980_CLK_S2D2		17
-#define R8A77980_CLK_S2D4		18
-#define R8A77980_CLK_S3D1		19
-#define R8A77980_CLK_S3D2		20
-#define R8A77980_CLK_S3D4		21
-#define R8A77980_CLK_LB			22
-#define R8A77980_CLK_CL			23
-#define R8A77980_CLK_ZB3		24
-#define R8A77980_CLK_ZB3D2		25
-#define R8A77980_CLK_ZB3D4		26
-#define R8A77980_CLK_SD0H		27
-#define R8A77980_CLK_SD0		28
-#define R8A77980_CLK_RPC		29
-#define R8A77980_CLK_RPCD2		30
-#define R8A77980_CLK_MSO		31
-#define R8A77980_CLK_CANFD		32
-#define R8A77980_CLK_CSI0		33
-#define R8A77980_CLK_CP			34
-#define R8A77980_CLK_CPEX		35
-#define R8A77980_CLK_R			36
-#define R8A77980_CLK_OSC		37
-
-#endif /* __DT_BINDINGS_CLOCK_R8A77980_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a77990-cpg-mssr.h b/include/dt-bindings/clock/r8a77990-cpg-mssr.h
deleted file mode 100644
index a596a482f3a..00000000000
--- a/include/dt-bindings/clock/r8a77990-cpg-mssr.h
+++ /dev/null
@@ -1,62 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A77990_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A77990_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a77990 CPG Core Clocks */
-#define R8A77990_CLK_Z2			0
-#define R8A77990_CLK_ZR			1
-#define R8A77990_CLK_ZG			2
-#define R8A77990_CLK_ZTR		3
-#define R8A77990_CLK_ZT			4
-#define R8A77990_CLK_ZX			5
-#define R8A77990_CLK_S0D1		6
-#define R8A77990_CLK_S0D3		7
-#define R8A77990_CLK_S0D6		8
-#define R8A77990_CLK_S0D12		9
-#define R8A77990_CLK_S0D24		10
-#define R8A77990_CLK_S1D1		11
-#define R8A77990_CLK_S1D2		12
-#define R8A77990_CLK_S1D4		13
-#define R8A77990_CLK_S2D1		14
-#define R8A77990_CLK_S2D2		15
-#define R8A77990_CLK_S2D4		16
-#define R8A77990_CLK_S3D1		17
-#define R8A77990_CLK_S3D2		18
-#define R8A77990_CLK_S3D4		19
-#define R8A77990_CLK_S0D6C		20
-#define R8A77990_CLK_S3D1C		21
-#define R8A77990_CLK_S3D2C		22
-#define R8A77990_CLK_S3D4C		23
-#define R8A77990_CLK_LB			24
-#define R8A77990_CLK_CL			25
-#define R8A77990_CLK_ZB3		26
-#define R8A77990_CLK_ZB3D2		27
-#define R8A77990_CLK_CR			28
-#define R8A77990_CLK_CRD2		29
-#define R8A77990_CLK_SD0H		30
-#define R8A77990_CLK_SD0		31
-#define R8A77990_CLK_SD1H		32
-#define R8A77990_CLK_SD1		33
-#define R8A77990_CLK_SD3H		34
-#define R8A77990_CLK_SD3		35
-#define R8A77990_CLK_RPC		36
-#define R8A77990_CLK_RPCD2		37
-#define R8A77990_CLK_ZA2		38
-#define R8A77990_CLK_ZA8		39
-#define R8A77990_CLK_Z2D		40
-#define R8A77990_CLK_CANFD		41
-#define R8A77990_CLK_MSO		42
-#define R8A77990_CLK_R			43
-#define R8A77990_CLK_OSC		44
-#define R8A77990_CLK_LV0		45
-#define R8A77990_CLK_LV1		46
-#define R8A77990_CLK_CSI0		47
-#define R8A77990_CLK_CP			48
-#define R8A77990_CLK_CPEX		49
-
-#endif /* __DT_BINDINGS_CLOCK_R8A77990_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a77995-cpg-mssr.h b/include/dt-bindings/clock/r8a77995-cpg-mssr.h
deleted file mode 100644
index fd701c4e87c..00000000000
--- a/include/dt-bindings/clock/r8a77995-cpg-mssr.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
- * Copyright (C) 2017 Glider bvba
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A77995_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A77995_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a77995 CPG Core Clocks */
-#define R8A77995_CLK_Z2			0
-#define R8A77995_CLK_ZG			1
-#define R8A77995_CLK_ZTR		2
-#define R8A77995_CLK_ZT			3
-#define R8A77995_CLK_ZX			4
-#define R8A77995_CLK_S0D1		5
-#define R8A77995_CLK_S1D1		6
-#define R8A77995_CLK_S1D2		7
-#define R8A77995_CLK_S1D4		8
-#define R8A77995_CLK_S2D1		9
-#define R8A77995_CLK_S2D2		10
-#define R8A77995_CLK_S2D4		11
-#define R8A77995_CLK_S3D1		12
-#define R8A77995_CLK_S3D2		13
-#define R8A77995_CLK_S3D4		14
-#define R8A77995_CLK_S1D4C		15
-#define R8A77995_CLK_S3D1C		16
-#define R8A77995_CLK_S3D2C		17
-#define R8A77995_CLK_S3D4C		18
-#define R8A77995_CLK_LB			19
-#define R8A77995_CLK_CL			20
-#define R8A77995_CLK_ZB3		21
-#define R8A77995_CLK_ZB3D2		22
-#define R8A77995_CLK_CR			23
-#define R8A77995_CLK_CRD2		24
-#define R8A77995_CLK_SD0H		25
-#define R8A77995_CLK_SD0		26
-/* CLK_SSP2 was removed */
-/* CLK_SSP1 was removed */
-#define R8A77995_CLK_RPC		29
-#define R8A77995_CLK_RPCD2		30
-#define R8A77995_CLK_ZA2		31
-#define R8A77995_CLK_ZA8		32
-#define R8A77995_CLK_Z2D		33
-#define R8A77995_CLK_CANFD		34
-#define R8A77995_CLK_MSO		35
-#define R8A77995_CLK_R			36
-#define R8A77995_CLK_OSC		37
-#define R8A77995_CLK_LV0		38
-#define R8A77995_CLK_LV1		39
-#define R8A77995_CLK_CP			40
-#define R8A77995_CLK_CPEX		41
-
-#endif /* __DT_BINDINGS_CLOCK_R8A77995_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a779a0-cpg-mssr.h b/include/dt-bindings/clock/r8a779a0-cpg-mssr.h
deleted file mode 100644
index f1d737ca7ca..00000000000
--- a/include/dt-bindings/clock/r8a779a0-cpg-mssr.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2020 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A779A0_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A779A0_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a779A0 CPG Core Clocks */
-#define R8A779A0_CLK_Z0			0
-#define R8A779A0_CLK_ZX			1
-#define R8A779A0_CLK_Z1			2
-#define R8A779A0_CLK_ZR			3
-#define R8A779A0_CLK_ZS			4
-#define R8A779A0_CLK_ZT			5
-#define R8A779A0_CLK_ZTR		6
-#define R8A779A0_CLK_S1D1		7
-#define R8A779A0_CLK_S1D2		8
-#define R8A779A0_CLK_S1D4		9
-#define R8A779A0_CLK_S1D8		10
-#define R8A779A0_CLK_S1D12		11
-#define R8A779A0_CLK_S3D1		12
-#define R8A779A0_CLK_S3D2		13
-#define R8A779A0_CLK_S3D4		14
-#define R8A779A0_CLK_LB			15
-#define R8A779A0_CLK_CP			16
-#define R8A779A0_CLK_CL			17
-#define R8A779A0_CLK_CL16MCK		18
-#define R8A779A0_CLK_ZB30		19
-#define R8A779A0_CLK_ZB30D2		20
-#define R8A779A0_CLK_ZB30D4		21
-#define R8A779A0_CLK_ZB31		22
-#define R8A779A0_CLK_ZB31D2		23
-#define R8A779A0_CLK_ZB31D4		24
-#define R8A779A0_CLK_SD0H		25
-#define R8A779A0_CLK_SD0		26
-#define R8A779A0_CLK_RPC		27
-#define R8A779A0_CLK_RPCD2		28
-#define R8A779A0_CLK_MSO		29
-#define R8A779A0_CLK_CANFD		30
-#define R8A779A0_CLK_CSI0		31
-#define R8A779A0_CLK_FRAY		32
-#define R8A779A0_CLK_DSI		33
-#define R8A779A0_CLK_VIP		34
-#define R8A779A0_CLK_ADGH		35
-#define R8A779A0_CLK_CNNDSP		36
-#define R8A779A0_CLK_ICU		37
-#define R8A779A0_CLK_ICUD2		38
-#define R8A779A0_CLK_VCBUS		39
-#define R8A779A0_CLK_CBFUSA		40
-#define R8A779A0_CLK_R			41
-#define R8A779A0_CLK_OSC		42
-
-#endif /* __DT_BINDINGS_CLOCK_R8A779A0_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a779f0-cpg-mssr.h b/include/dt-bindings/clock/r8a779f0-cpg-mssr.h
deleted file mode 100644
index c34be562495..00000000000
--- a/include/dt-bindings/clock/r8a779f0-cpg-mssr.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
-/*
- * Copyright (C) 2021 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A779F0_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A779F0_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a779f0 CPG Core Clocks */
-
-#define R8A779F0_CLK_ZX			0
-#define R8A779F0_CLK_ZS			1
-#define R8A779F0_CLK_ZT			2
-#define R8A779F0_CLK_ZTR		3
-#define R8A779F0_CLK_S0D2		4
-#define R8A779F0_CLK_S0D3		5
-#define R8A779F0_CLK_S0D4		6
-#define R8A779F0_CLK_S0D2_MM		7
-#define R8A779F0_CLK_S0D3_MM		8
-#define R8A779F0_CLK_S0D4_MM		9
-#define R8A779F0_CLK_S0D2_RT		10
-#define R8A779F0_CLK_S0D3_RT		11
-#define R8A779F0_CLK_S0D4_RT		12
-#define R8A779F0_CLK_S0D6_RT		13
-#define R8A779F0_CLK_S0D3_PER		14
-#define R8A779F0_CLK_S0D6_PER		15
-#define R8A779F0_CLK_S0D12_PER		16
-#define R8A779F0_CLK_S0D24_PER		17
-#define R8A779F0_CLK_S0D2_HSC		18
-#define R8A779F0_CLK_S0D3_HSC		19
-#define R8A779F0_CLK_S0D4_HSC		20
-#define R8A779F0_CLK_S0D6_HSC		21
-#define R8A779F0_CLK_S0D12_HSC		22
-#define R8A779F0_CLK_S0D2_CC		23
-#define R8A779F0_CLK_CL			24
-#define R8A779F0_CLK_CL16M		25
-#define R8A779F0_CLK_CL16M_MM		26
-#define R8A779F0_CLK_CL16M_RT		27
-#define R8A779F0_CLK_CL16M_PER		28
-#define R8A779F0_CLK_CL16M_HSC		29
-#define R8A779F0_CLK_Z0			30
-#define R8A779F0_CLK_Z1			31
-#define R8A779F0_CLK_ZB3		32
-#define R8A779F0_CLK_ZB3D2		33
-#define R8A779F0_CLK_ZB3D4		34
-#define R8A779F0_CLK_SD0H		35
-#define R8A779F0_CLK_SD0		36
-#define R8A779F0_CLK_RPC		37
-#define R8A779F0_CLK_RPCD2		38
-#define R8A779F0_CLK_MSO		39
-#define R8A779F0_CLK_SASYNCRT		40
-#define R8A779F0_CLK_SASYNCPERD1	41
-#define R8A779F0_CLK_SASYNCPERD2	42
-#define R8A779F0_CLK_SASYNCPERD4	43
-#define R8A779F0_CLK_DBGSOC_HSC		44
-#define R8A779F0_CLK_RSW2		45
-#define R8A779F0_CLK_OSC		46
-#define R8A779F0_CLK_ZR			47
-#define R8A779F0_CLK_CPEX		48
-#define R8A779F0_CLK_CBFUSA		49
-#define R8A779F0_CLK_R			50
-
-#endif /* __DT_BINDINGS_CLOCK_R8A779F0_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/r8a779g0-cpg-mssr.h b/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
deleted file mode 100644
index 7850cdc62e2..00000000000
--- a/include/dt-bindings/clock/r8a779g0-cpg-mssr.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
-/*
- * Copyright (C) 2022 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_R8A779G0_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_R8A779G0_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a779g0 CPG Core Clocks */
-
-#define R8A779G0_CLK_ZX			0
-#define R8A779G0_CLK_ZS			1
-#define R8A779G0_CLK_ZT			2
-#define R8A779G0_CLK_ZTR		3
-#define R8A779G0_CLK_S0D2		4
-#define R8A779G0_CLK_S0D3		5
-#define R8A779G0_CLK_S0D4		6
-#define R8A779G0_CLK_S0D1_VIO		7
-#define R8A779G0_CLK_S0D2_VIO		8
-#define R8A779G0_CLK_S0D4_VIO		9
-#define R8A779G0_CLK_S0D8_VIO		10
-#define R8A779G0_CLK_S0D1_VC		11
-#define R8A779G0_CLK_S0D2_VC		12
-#define R8A779G0_CLK_S0D4_VC		13
-#define R8A779G0_CLK_S0D2_MM		14
-#define R8A779G0_CLK_S0D4_MM		15
-#define R8A779G0_CLK_S0D2_U3DG		16
-#define R8A779G0_CLK_S0D4_U3DG		17
-#define R8A779G0_CLK_S0D2_RT		18
-#define R8A779G0_CLK_S0D3_RT		19
-#define R8A779G0_CLK_S0D4_RT		20
-#define R8A779G0_CLK_S0D6_RT		21
-#define R8A779G0_CLK_S0D24_RT		22
-#define R8A779G0_CLK_S0D2_PER		23
-#define R8A779G0_CLK_S0D3_PER		24
-#define R8A779G0_CLK_S0D4_PER		25
-#define R8A779G0_CLK_S0D6_PER		26
-#define R8A779G0_CLK_S0D12_PER		27
-#define R8A779G0_CLK_S0D24_PER		28
-#define R8A779G0_CLK_S0D1_HSC		29
-#define R8A779G0_CLK_S0D2_HSC		30
-#define R8A779G0_CLK_S0D4_HSC		31
-#define R8A779G0_CLK_S0D2_CC		32
-#define R8A779G0_CLK_SVD1_IR		33
-#define R8A779G0_CLK_SVD2_IR		34
-#define R8A779G0_CLK_SVD1_VIP		35
-#define R8A779G0_CLK_SVD2_VIP		36
-#define R8A779G0_CLK_CL			37
-#define R8A779G0_CLK_CL16M		38
-#define R8A779G0_CLK_CL16M_MM		39
-#define R8A779G0_CLK_CL16M_RT		40
-#define R8A779G0_CLK_CL16M_PER		41
-#define R8A779G0_CLK_CL16M_HSC		42
-#define R8A779G0_CLK_Z0			43
-#define R8A779G0_CLK_ZB3		44
-#define R8A779G0_CLK_ZB3D2		45
-#define R8A779G0_CLK_ZB3D4		46
-#define R8A779G0_CLK_ZG			47
-#define R8A779G0_CLK_SD0H		48
-#define R8A779G0_CLK_SD0		49
-#define R8A779G0_CLK_RPC		50
-#define R8A779G0_CLK_RPCD2		51
-#define R8A779G0_CLK_MSO		52
-#define R8A779G0_CLK_CANFD		53
-#define R8A779G0_CLK_CSI		54
-#define R8A779G0_CLK_FRAY		55
-#define R8A779G0_CLK_IPC		56
-#define R8A779G0_CLK_SASYNCRT		57
-#define R8A779G0_CLK_SASYNCPERD1	58
-#define R8A779G0_CLK_SASYNCPERD2	59
-#define R8A779G0_CLK_SASYNCPERD4	60
-#define R8A779G0_CLK_VIOBUS		61
-#define R8A779G0_CLK_VIOBUSD2		62
-#define R8A779G0_CLK_VCBUS		63
-#define R8A779G0_CLK_VCBUSD2		64
-#define R8A779G0_CLK_DSIEXT		65
-#define R8A779G0_CLK_DSIREF		66
-#define R8A779G0_CLK_ADGH		67
-#define R8A779G0_CLK_OSC		68
-#define R8A779G0_CLK_ZR0		69
-#define R8A779G0_CLK_ZR1		70
-#define R8A779G0_CLK_ZR2		71
-#define R8A779G0_CLK_IMPA		72
-#define R8A779G0_CLK_IMPAD4		73
-#define R8A779G0_CLK_CPEX		74
-#define R8A779G0_CLK_CBFUSA		75
-#define R8A779G0_CLK_R			76
-#define R8A779G0_CLK_CP			77
-
-#endif /* __DT_BINDINGS_CLOCK_R8A779G0_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h b/include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
deleted file mode 100644
index 7ab6cfbaf90..00000000000
--- a/include/dt-bindings/clock/renesas,r8a779h0-cpg-mssr.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
-/*
- * Copyright (C) 2023 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_CLOCK_RENESAS_R8A779H0_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_RENESAS_R8A779H0_CPG_MSSR_H__
-
-#include <dt-bindings/clock/renesas-cpg-mssr.h>
-
-/* r8a779h0 CPG Core Clocks */
-
-#define R8A779H0_CLK_ZX			0
-#define R8A779H0_CLK_ZD			1
-#define R8A779H0_CLK_ZS			2
-#define R8A779H0_CLK_ZT			3
-#define R8A779H0_CLK_ZTR		4
-#define R8A779H0_CLK_S0D2		5
-#define R8A779H0_CLK_S0D3		6
-#define R8A779H0_CLK_S0D4		7
-#define R8A779H0_CLK_S0D1_VIO		8
-#define R8A779H0_CLK_S0D2_VIO		9
-#define R8A779H0_CLK_S0D4_VIO		10
-#define R8A779H0_CLK_S0D8_VIO		11
-#define R8A779H0_CLK_VIOBUSD1		12
-#define R8A779H0_CLK_VIOBUSD2		13
-#define R8A779H0_CLK_S0D1_VC		14
-#define R8A779H0_CLK_S0D2_VC		15
-#define R8A779H0_CLK_S0D4_VC		16
-#define R8A779H0_CLK_VCBUSD1		17
-#define R8A779H0_CLK_VCBUSD2		18
-#define R8A779H0_CLK_S0D2_MM		19
-#define R8A779H0_CLK_S0D4_MM		20
-#define R8A779H0_CLK_S0D2_U3DG		21
-#define R8A779H0_CLK_S0D4_U3DG		22
-#define R8A779H0_CLK_S0D2_RT		23
-#define R8A779H0_CLK_S0D3_RT		24
-#define R8A779H0_CLK_S0D4_RT		25
-#define R8A779H0_CLK_S0D6_RT		26
-#define R8A779H0_CLK_S0D2_PER		27
-#define R8A779H0_CLK_S0D3_PER		28
-#define R8A779H0_CLK_S0D4_PER		29
-#define R8A779H0_CLK_S0D6_PER		30
-#define R8A779H0_CLK_S0D12_PER		31
-#define R8A779H0_CLK_S0D24_PER		32
-#define R8A779H0_CLK_S0D1_HSC		33
-#define R8A779H0_CLK_S0D2_HSC		34
-#define R8A779H0_CLK_S0D4_HSC		35
-#define R8A779H0_CLK_S0D8_HSC		36
-#define R8A779H0_CLK_SVD1_IR		37
-#define R8A779H0_CLK_SVD2_IR		38
-#define R8A779H0_CLK_IMPAD1		39
-#define R8A779H0_CLK_IMPAD4		40
-#define R8A779H0_CLK_IMPB		41
-#define R8A779H0_CLK_SVD1_VIP		42
-#define R8A779H0_CLK_SVD2_VIP		43
-#define R8A779H0_CLK_CL			44
-#define R8A779H0_CLK_CL16M		45
-#define R8A779H0_CLK_CL16M_MM		46
-#define R8A779H0_CLK_CL16M_RT		47
-#define R8A779H0_CLK_CL16M_PER		48
-#define R8A779H0_CLK_CL16M_HSC		49
-#define R8A779H0_CLK_ZC0		50
-#define R8A779H0_CLK_ZC1		51
-#define R8A779H0_CLK_ZC2		52
-#define R8A779H0_CLK_ZC3		53
-#define R8A779H0_CLK_ZB3		54
-#define R8A779H0_CLK_ZB3D2		55
-#define R8A779H0_CLK_ZB3D4		56
-#define R8A779H0_CLK_ZG			57
-#define R8A779H0_CLK_SD0H		58
-#define R8A779H0_CLK_SD0		59
-#define R8A779H0_CLK_RPC		60
-#define R8A779H0_CLK_RPCD2		61
-#define R8A779H0_CLK_MSO		62
-#define R8A779H0_CLK_CANFD		63
-#define R8A779H0_CLK_CSI		64
-#define R8A779H0_CLK_FRAY		65
-#define R8A779H0_CLK_IPC		66
-#define R8A779H0_CLK_SASYNCRT		67
-#define R8A779H0_CLK_SASYNCPERD1	68
-#define R8A779H0_CLK_SASYNCPERD2	69
-#define R8A779H0_CLK_SASYNCPERD4	70
-#define R8A779H0_CLK_DSIEXT		71
-#define R8A779H0_CLK_DSIREF		72
-#define R8A779H0_CLK_ADGH		73
-#define R8A779H0_CLK_OSC		74
-#define R8A779H0_CLK_ZR0		75
-#define R8A779H0_CLK_ZR1		76
-#define R8A779H0_CLK_ZR2		77
-#define R8A779H0_CLK_RGMII		78
-#define R8A779H0_CLK_CPEX		79
-#define R8A779H0_CLK_CP			80
-#define R8A779H0_CLK_CBFUSA		81
-#define R8A779H0_CLK_R			82
-
-#endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A779H0_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/clock/renesas-cpg-mssr.h b/include/dt-bindings/clock/renesas-cpg-mssr.h
deleted file mode 100644
index 569a3cc33ff..00000000000
--- a/include/dt-bindings/clock/renesas-cpg-mssr.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * Copyright (C) 2015 Renesas Electronics Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-#ifndef __DT_BINDINGS_CLOCK_RENESAS_CPG_MSSR_H__
-#define __DT_BINDINGS_CLOCK_RENESAS_CPG_MSSR_H__
-
-#define CPG_CORE			0	/* Core Clock */
-#define CPG_MOD				1	/* Module Clock */
-
-#endif /* __DT_BINDINGS_CLOCK_RENESAS_CPG_MSSR_H__ */
-- 
2.45.2

