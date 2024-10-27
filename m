Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2076ED10C07
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 02:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B199B89034;
	Sun, 27 Oct 2024 03:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YCfbPuis";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HhCRNiz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516D088C10; Sun, 27 Oct 2024 03:05:26 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03C4188E42
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 03:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XbfxF53Djz9tG4;
 Sun, 27 Oct 2024 03:05:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729994721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/YjEY8c8wPEckeS1/5Ii9G7ZDTgpNCduqq94OOuW7M=;
 b=YCfbPuisbEI2I910DPmtGMaxCag7xRePKzL7rr4T9cdh+wyqebI/RTgUW+sq6POJ6fZA+G
 KbNKqXOWlJqEjMpbcshyU+Iu8YMqfxDqJn7pfUTn5VGXiBC0Ihy0mhxnu7xESNJVQUY3bP
 V/sdS8ysW5f/37yI7TZit3RlaPzgAiApUfRHEphNgAwyNjKoAjyqf1U+nfLbEFXnN+C6F4
 BnslLtetbSejgRaZw2nB4rcimSm3tueXCvoBlk1pLX/6id8GMHb4dy3v8ADSVamm7FJ/Mv
 ueZoQ781OZDDUuqmvh/7vTsvkRpctSvkhg/M+Yi1+8sqi3Nzm93G0ZXr/0pBwg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1729994719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/YjEY8c8wPEckeS1/5Ii9G7ZDTgpNCduqq94OOuW7M=;
 b=HhCRNiz/DJ/LogT0hpSk4lrBqXz7GY6rOdEp2swa0RMHerOsEZygRiWM7Ul1KyROPHE7mx
 zuZf2bvtgTiFr78XH/HLLonP4w7Z0XtazfEZyR0d07EiVpZHmSQ58Ai/1oqXhKsLxAGeMU
 GeryC4fOdvAO11QIhkoFunr7cwNXB7t2mZj6NOcTaZucFjzxNC0Q9R2vpR2ZrFjdQBuVOb
 84+CbzzOhWRGVvNCDmVGEu42kTWiBuS7YlHFHIpQHWcObYaDPhHRsaBAtmQ8exLDoQvwNG
 i7aQ9QrVVP1ZhxUt3g6U3CtgnZ9oENMVX+gRQU56NYYg5Pp9aaYu2FVVyv5ZJw==
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
Subject: [PATCH 2/2] ARM: renesas: Drop old unused power DT headers
Date: Sun, 27 Oct 2024 03:04:31 +0100
Message-ID: <20241027020504.354623-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241027020504.354623-1-marek.vasut+renesas@mailbox.org>
References: <20241027020504.354623-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mnh5dtumw9nns5ifcjfsihdo8uwfjs6g
X-MBO-RS-ID: ec6cbd6a9a64540e891
X-Rspamd-Queue-Id: 4XbfxF53Djz9tG4
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
which also includes headers from dts/upstream/include/dt-bindings/power .
Remove unused legacy DT header files from include/dt-bindings/power .

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
 include/dt-bindings/power/r8a774a1-sysc.h     | 31 ----------
 include/dt-bindings/power/r8a774b1-sysc.h     | 26 --------
 include/dt-bindings/power/r8a774c0-sysc.h     | 25 --------
 include/dt-bindings/power/r8a774e1-sysc.h     | 36 -----------
 include/dt-bindings/power/r8a7790-sysc.h      | 31 ----------
 include/dt-bindings/power/r8a7791-sysc.h      | 23 --------
 include/dt-bindings/power/r8a7792-sysc.h      | 23 --------
 include/dt-bindings/power/r8a7793-sysc.h      | 25 --------
 include/dt-bindings/power/r8a7794-sysc.h      | 23 --------
 include/dt-bindings/power/r8a7795-sysc.h      | 38 ------------
 include/dt-bindings/power/r8a7796-sysc.h      | 33 -----------
 include/dt-bindings/power/r8a77961-sysc.h     | 32 ----------
 include/dt-bindings/power/r8a77965-sysc.h     | 29 ---------
 include/dt-bindings/power/r8a77970-sysc.h     | 28 ---------
 include/dt-bindings/power/r8a77980-sysc.h     | 43 --------------
 include/dt-bindings/power/r8a77990-sysc.h     | 26 --------
 include/dt-bindings/power/r8a77995-sysc.h     | 20 -------
 include/dt-bindings/power/r8a779a0-sysc.h     | 59 -------------------
 include/dt-bindings/power/r8a779f0-sysc.h     | 30 ----------
 include/dt-bindings/power/r8a779g0-sysc.h     | 46 ---------------
 .../dt-bindings/power/renesas,r8a779h0-sysc.h | 49 ---------------
 21 files changed, 676 deletions(-)
 delete mode 100644 include/dt-bindings/power/r8a774a1-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a774b1-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a774c0-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a774e1-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7790-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7791-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7792-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7793-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7794-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7795-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a7796-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77961-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77965-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77970-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77980-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77990-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a77995-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a779a0-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a779f0-sysc.h
 delete mode 100644 include/dt-bindings/power/r8a779g0-sysc.h
 delete mode 100644 include/dt-bindings/power/renesas,r8a779h0-sysc.h

diff --git a/include/dt-bindings/power/r8a774a1-sysc.h b/include/dt-bindings/power/r8a774a1-sysc.h
deleted file mode 100644
index 580f431cd32..00000000000
--- a/include/dt-bindings/power/r8a774a1-sysc.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2018 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_POWER_R8A774A1_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A774A1_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A774A1_PD_CA57_CPU0		 0
-#define R8A774A1_PD_CA57_CPU1		 1
-#define R8A774A1_PD_CA53_CPU0		 5
-#define R8A774A1_PD_CA53_CPU1		 6
-#define R8A774A1_PD_CA53_CPU2		 7
-#define R8A774A1_PD_CA53_CPU3		 8
-#define R8A774A1_PD_CA57_SCU		12
-#define R8A774A1_PD_A3VC		14
-#define R8A774A1_PD_3DG_A		17
-#define R8A774A1_PD_3DG_B		18
-#define R8A774A1_PD_CA53_SCU		21
-#define R8A774A1_PD_A2VC0		25
-#define R8A774A1_PD_A2VC1		26
-
-/* Always-on power area */
-#define R8A774A1_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A774A1_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a774b1-sysc.h b/include/dt-bindings/power/r8a774b1-sysc.h
deleted file mode 100644
index 373736402f0..00000000000
--- a/include/dt-bindings/power/r8a774b1-sysc.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2019 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_POWER_R8A774B1_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A774B1_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A774B1_PD_CA57_CPU0		 0
-#define R8A774B1_PD_CA57_CPU1		 1
-#define R8A774B1_PD_A3VP		 9
-#define R8A774B1_PD_CA57_SCU		12
-#define R8A774B1_PD_A3VC		14
-#define R8A774B1_PD_3DG_A		17
-#define R8A774B1_PD_3DG_B		18
-#define R8A774B1_PD_A2VC1		26
-
-/* Always-on power area */
-#define R8A774B1_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A774B1_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a774c0-sysc.h b/include/dt-bindings/power/r8a774c0-sysc.h
deleted file mode 100644
index 9922d4c6f87..00000000000
--- a/include/dt-bindings/power/r8a774c0-sysc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2018 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_POWER_R8A774C0_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A774C0_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A774C0_PD_CA53_CPU0		5
-#define R8A774C0_PD_CA53_CPU1		6
-#define R8A774C0_PD_A3VC		14
-#define R8A774C0_PD_3DG_A		17
-#define R8A774C0_PD_3DG_B		18
-#define R8A774C0_PD_CA53_SCU		21
-#define R8A774C0_PD_A2VC1		26
-
-/* Always-on power area */
-#define R8A774C0_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A774C0_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a774e1-sysc.h b/include/dt-bindings/power/r8a774e1-sysc.h
deleted file mode 100644
index 7edb8161db3..00000000000
--- a/include/dt-bindings/power/r8a774e1-sysc.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2020 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_POWER_R8A774E1_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A774E1_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A774E1_PD_CA57_CPU0		 0
-#define R8A774E1_PD_CA57_CPU1		 1
-#define R8A774E1_PD_CA57_CPU2		 2
-#define R8A774E1_PD_CA57_CPU3		 3
-#define R8A774E1_PD_CA53_CPU0		 5
-#define R8A774E1_PD_CA53_CPU1		 6
-#define R8A774E1_PD_CA53_CPU2		 7
-#define R8A774E1_PD_CA53_CPU3		 8
-#define R8A774E1_PD_A3VP		 9
-#define R8A774E1_PD_CA57_SCU		12
-#define R8A774E1_PD_A3VC		14
-#define R8A774E1_PD_3DG_A		17
-#define R8A774E1_PD_3DG_B		18
-#define R8A774E1_PD_3DG_C		19
-#define R8A774E1_PD_3DG_D		20
-#define R8A774E1_PD_CA53_SCU		21
-#define R8A774E1_PD_3DG_E		22
-#define R8A774E1_PD_A2VC1		26
-
-/* Always-on power area */
-#define R8A774E1_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A774E1_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a7790-sysc.h b/include/dt-bindings/power/r8a7790-sysc.h
deleted file mode 100644
index bcb49057060..00000000000
--- a/include/dt-bindings/power/r8a7790-sysc.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Glider bvba
- */
-#ifndef __DT_BINDINGS_POWER_R8A7790_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A7790_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A7790_PD_CA15_CPU0		 0
-#define R8A7790_PD_CA15_CPU1		 1
-#define R8A7790_PD_CA15_CPU2		 2
-#define R8A7790_PD_CA15_CPU3		 3
-#define R8A7790_PD_CA7_CPU0		 5
-#define R8A7790_PD_CA7_CPU1		 6
-#define R8A7790_PD_CA7_CPU2		 7
-#define R8A7790_PD_CA7_CPU3		 8
-#define R8A7790_PD_CA15_SCU		12
-#define R8A7790_PD_SH_4A		16
-#define R8A7790_PD_RGX			20
-#define R8A7790_PD_CA7_SCU		21
-#define R8A7790_PD_IMP			24
-
-/* Always-on power area */
-#define R8A7790_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A7790_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a7791-sysc.h b/include/dt-bindings/power/r8a7791-sysc.h
deleted file mode 100644
index 1d20fae4242..00000000000
--- a/include/dt-bindings/power/r8a7791-sysc.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Glider bvba
- */
-#ifndef __DT_BINDINGS_POWER_R8A7791_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A7791_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A7791_PD_CA15_CPU0		 0
-#define R8A7791_PD_CA15_CPU1		 1
-#define R8A7791_PD_CA15_SCU		12
-#define R8A7791_PD_SH_4A		16
-#define R8A7791_PD_SGX			20
-
-/* Always-on power area */
-#define R8A7791_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A7791_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a7792-sysc.h b/include/dt-bindings/power/r8a7792-sysc.h
deleted file mode 100644
index dd3a4667ca1..00000000000
--- a/include/dt-bindings/power/r8a7792-sysc.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Cogent Embedded Inc.
- */
-#ifndef __DT_BINDINGS_POWER_R8A7792_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A7792_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A7792_PD_CA15_CPU0		0
-#define R8A7792_PD_CA15_CPU1		1
-#define R8A7792_PD_CA15_SCU		12
-#define R8A7792_PD_SGX			20
-#define R8A7792_PD_IMP			24
-
-/* Always-on power area */
-#define R8A7792_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A7792_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a7793-sysc.h b/include/dt-bindings/power/r8a7793-sysc.h
deleted file mode 100644
index 056998c635a..00000000000
--- a/include/dt-bindings/power/r8a7793-sysc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Glider bvba
- */
-#ifndef __DT_BINDINGS_POWER_R8A7793_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A7793_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- *
- * Note that R-Car M2-N is identical to R-Car M2-W w.r.t. power domains.
- */
-
-#define R8A7793_PD_CA15_CPU0		 0
-#define R8A7793_PD_CA15_CPU1		 1
-#define R8A7793_PD_CA15_SCU		12
-#define R8A7793_PD_SH_4A		16
-#define R8A7793_PD_SGX			20
-
-/* Always-on power area */
-#define R8A7793_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A7793_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a7794-sysc.h b/include/dt-bindings/power/r8a7794-sysc.h
deleted file mode 100644
index 4d6c708e6f3..00000000000
--- a/include/dt-bindings/power/r8a7794-sysc.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Glider bvba
- */
-#ifndef __DT_BINDINGS_POWER_R8A7794_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A7794_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A7794_PD_CA7_CPU0		 5
-#define R8A7794_PD_CA7_CPU1		 6
-#define R8A7794_PD_SH_4A		16
-#define R8A7794_PD_SGX			20
-#define R8A7794_PD_CA7_SCU		21
-
-/* Always-on power area */
-#define R8A7794_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A7794_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a7795-sysc.h b/include/dt-bindings/power/r8a7795-sysc.h
deleted file mode 100644
index ff532385857..00000000000
--- a/include/dt-bindings/power/r8a7795-sysc.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Glider bvba
- */
-#ifndef __DT_BINDINGS_POWER_R8A7795_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A7795_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A7795_PD_CA57_CPU0		 0
-#define R8A7795_PD_CA57_CPU1		 1
-#define R8A7795_PD_CA57_CPU2		 2
-#define R8A7795_PD_CA57_CPU3		 3
-#define R8A7795_PD_CA53_CPU0		 5
-#define R8A7795_PD_CA53_CPU1		 6
-#define R8A7795_PD_CA53_CPU2		 7
-#define R8A7795_PD_CA53_CPU3		 8
-#define R8A7795_PD_A3VP			 9
-#define R8A7795_PD_CA57_SCU		12
-#define R8A7795_PD_CR7			13
-#define R8A7795_PD_A3VC			14
-#define R8A7795_PD_3DG_A		17
-#define R8A7795_PD_3DG_B		18
-#define R8A7795_PD_3DG_C		19
-#define R8A7795_PD_3DG_D		20
-#define R8A7795_PD_CA53_SCU		21
-#define R8A7795_PD_3DG_E		22
-#define R8A7795_PD_A3IR			24
-#define R8A7795_PD_A2VC1		26
-
-/* Always-on power area */
-#define R8A7795_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A7795_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a7796-sysc.h b/include/dt-bindings/power/r8a7796-sysc.h
deleted file mode 100644
index 7e6fc06ebff..00000000000
--- a/include/dt-bindings/power/r8a7796-sysc.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2016 Glider bvba
- */
-#ifndef __DT_BINDINGS_POWER_R8A7796_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A7796_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A7796_PD_CA57_CPU0		 0
-#define R8A7796_PD_CA57_CPU1		 1
-#define R8A7796_PD_CA53_CPU0		 5
-#define R8A7796_PD_CA53_CPU1		 6
-#define R8A7796_PD_CA53_CPU2		 7
-#define R8A7796_PD_CA53_CPU3		 8
-#define R8A7796_PD_CA57_SCU		12
-#define R8A7796_PD_CR7			13
-#define R8A7796_PD_A3VC			14
-#define R8A7796_PD_3DG_A		17
-#define R8A7796_PD_3DG_B		18
-#define R8A7796_PD_CA53_SCU		21
-#define R8A7796_PD_A3IR			24
-#define R8A7796_PD_A2VC0		25
-#define R8A7796_PD_A2VC1		26
-
-/* Always-on power area */
-#define R8A7796_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A7796_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a77961-sysc.h b/include/dt-bindings/power/r8a77961-sysc.h
deleted file mode 100644
index 7a3800996f7..00000000000
--- a/include/dt-bindings/power/r8a77961-sysc.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2019 Glider bvba
- */
-#ifndef __DT_BINDINGS_POWER_R8A77961_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A77961_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A77961_PD_CA57_CPU0		 0
-#define R8A77961_PD_CA57_CPU1		 1
-#define R8A77961_PD_CA53_CPU0		 5
-#define R8A77961_PD_CA53_CPU1		 6
-#define R8A77961_PD_CA53_CPU2		 7
-#define R8A77961_PD_CA53_CPU3		 8
-#define R8A77961_PD_CA57_SCU		12
-#define R8A77961_PD_CR7			13
-#define R8A77961_PD_A3VC		14
-#define R8A77961_PD_3DG_A		17
-#define R8A77961_PD_3DG_B		18
-#define R8A77961_PD_CA53_SCU		21
-#define R8A77961_PD_A3IR		24
-#define R8A77961_PD_A2VC1		26
-
-/* Always-on power area */
-#define R8A77961_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A77961_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a77965-sysc.h b/include/dt-bindings/power/r8a77965-sysc.h
deleted file mode 100644
index de82d8a15ea..00000000000
--- a/include/dt-bindings/power/r8a77965-sysc.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018 Jacopo Mondi <jacopo+renesas@jmondi.org>
- * Copyright (C) 2016 Glider bvba
- */
-
-#ifndef __DT_BINDINGS_POWER_R8A77965_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A77965_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A77965_PD_CA57_CPU0		 0
-#define R8A77965_PD_CA57_CPU1		 1
-#define R8A77965_PD_A3VP		 9
-#define R8A77965_PD_CA57_SCU		12
-#define R8A77965_PD_CR7			13
-#define R8A77965_PD_A3VC		14
-#define R8A77965_PD_3DG_A		17
-#define R8A77965_PD_3DG_B		18
-#define R8A77965_PD_A2VC1		26
-
-/* Always-on power area */
-#define R8A77965_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A77965_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a77970-sysc.h b/include/dt-bindings/power/r8a77970-sysc.h
deleted file mode 100644
index 9dcdbd5a930..00000000000
--- a/include/dt-bindings/power/r8a77970-sysc.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2017 Cogent Embedded Inc.
- */
-#ifndef __DT_BINDINGS_POWER_R8A77970_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A77970_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A77970_PD_CA53_CPU0		 5
-#define R8A77970_PD_CA53_CPU1		 6
-#define R8A77970_PD_CA53_SCU		21
-#define R8A77970_PD_A2IR0		23
-#define R8A77970_PD_A3IR		24
-#define R8A77970_PD_A2IR1		27
-#define R8A77970_PD_A2DP		28
-#define R8A77970_PD_A2CN		29
-#define R8A77970_PD_A2SC0		30
-#define R8A77970_PD_A2SC1		31
-
-/* Always-on power area */
-#define R8A77970_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A77970_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a77980-sysc.h b/include/dt-bindings/power/r8a77980-sysc.h
deleted file mode 100644
index e12c8587b87..00000000000
--- a/include/dt-bindings/power/r8a77980-sysc.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (C) 2018 Renesas Electronics Corp.
- * Copyright (C) 2018 Cogent Embedded, Inc.
- */
-#ifndef __DT_BINDINGS_POWER_R8A77980_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A77980_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A77980_PD_A2SC2		0
-#define R8A77980_PD_A2SC3		1
-#define R8A77980_PD_A2SC4		2
-#define R8A77980_PD_A2DP0		3
-#define R8A77980_PD_A2DP1		4
-#define R8A77980_PD_CA53_CPU0		5
-#define R8A77980_PD_CA53_CPU1		6
-#define R8A77980_PD_CA53_CPU2		7
-#define R8A77980_PD_CA53_CPU3		8
-#define R8A77980_PD_A2CN		10
-#define R8A77980_PD_A3VIP0		11
-#define R8A77980_PD_A2IR5		12
-#define R8A77980_PD_CR7			13
-#define R8A77980_PD_A2IR4		15
-#define R8A77980_PD_CA53_SCU		21
-#define R8A77980_PD_A2IR0		23
-#define R8A77980_PD_A3IR		24
-#define R8A77980_PD_A3VIP1		25
-#define R8A77980_PD_A3VIP2		26
-#define R8A77980_PD_A2IR1		27
-#define R8A77980_PD_A2IR2		28
-#define R8A77980_PD_A2IR3		29
-#define R8A77980_PD_A2SC0		30
-#define R8A77980_PD_A2SC1		31
-
-/* Always-on power area */
-#define R8A77980_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A77980_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a77990-sysc.h b/include/dt-bindings/power/r8a77990-sysc.h
deleted file mode 100644
index 944d85beec1..00000000000
--- a/include/dt-bindings/power/r8a77990-sysc.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_POWER_R8A77990_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A77990_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A77990_PD_CA53_CPU0		5
-#define R8A77990_PD_CA53_CPU1		6
-#define R8A77990_PD_CR7			13
-#define R8A77990_PD_A3VC		14
-#define R8A77990_PD_3DG_A		17
-#define R8A77990_PD_3DG_B		18
-#define R8A77990_PD_CA53_SCU		21
-#define R8A77990_PD_A2VC1		26
-
-/* Always-on power area */
-#define R8A77990_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A77990_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a77995-sysc.h b/include/dt-bindings/power/r8a77995-sysc.h
deleted file mode 100644
index f2b35502f2b..00000000000
--- a/include/dt-bindings/power/r8a77995-sysc.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2017 Glider bvba
- */
-#ifndef __DT_BINDINGS_POWER_R8A77995_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A77995_SYSC_H__
-
-/*
- * These power domain indices match the numbers of the interrupt bits
- * representing the power areas in the various Interrupt Registers
- * (e.g. SYSCISR, Interrupt Status Register)
- */
-
-#define R8A77995_PD_CA53_CPU0		 5
-#define R8A77995_PD_CA53_SCU		21
-
-/* Always-on power area */
-#define R8A77995_PD_ALWAYS_ON		32
-
-#endif /* __DT_BINDINGS_POWER_R8A77995_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a779a0-sysc.h b/include/dt-bindings/power/r8a779a0-sysc.h
deleted file mode 100644
index 57929e459a6..00000000000
--- a/include/dt-bindings/power/r8a779a0-sysc.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2020 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_POWER_R8A779A0_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A779A0_SYSC_H__
-
-/*
- * These power domain indices match the Power Domain Register Numbers (PDR)
- */
-
-#define R8A779A0_PD_A1E0D0C0		0
-#define R8A779A0_PD_A1E0D0C1		1
-#define R8A779A0_PD_A1E0D1C0		2
-#define R8A779A0_PD_A1E0D1C1		3
-#define R8A779A0_PD_A1E1D0C0		4
-#define R8A779A0_PD_A1E1D0C1		5
-#define R8A779A0_PD_A1E1D1C0		6
-#define R8A779A0_PD_A1E1D1C1		7
-#define R8A779A0_PD_A2E0D0		16
-#define R8A779A0_PD_A2E0D1		17
-#define R8A779A0_PD_A2E1D0		18
-#define R8A779A0_PD_A2E1D1		19
-#define R8A779A0_PD_A3E0		20
-#define R8A779A0_PD_A3E1		21
-#define R8A779A0_PD_3DG_A		24
-#define R8A779A0_PD_3DG_B		25
-#define R8A779A0_PD_A1CNN2		32
-#define R8A779A0_PD_A1DSP0		33
-#define R8A779A0_PD_A2IMP01		34
-#define R8A779A0_PD_A2DP0		35
-#define R8A779A0_PD_A2CV0		36
-#define R8A779A0_PD_A2CV1		37
-#define R8A779A0_PD_A2CV4		38
-#define R8A779A0_PD_A2CV6		39
-#define R8A779A0_PD_A2CN2		40
-#define R8A779A0_PD_A1CNN0		41
-#define R8A779A0_PD_A2CN0		42
-#define R8A779A0_PD_A3IR		43
-#define R8A779A0_PD_A1CNN1		44
-#define R8A779A0_PD_A1DSP1		45
-#define R8A779A0_PD_A2IMP23		46
-#define R8A779A0_PD_A2DP1		47
-#define R8A779A0_PD_A2CV2		48
-#define R8A779A0_PD_A2CV3		49
-#define R8A779A0_PD_A2CV5		50
-#define R8A779A0_PD_A2CV7		51
-#define R8A779A0_PD_A2CN1		52
-#define R8A779A0_PD_A3VIP0		56
-#define R8A779A0_PD_A3VIP1		57
-#define R8A779A0_PD_A3VIP2		58
-#define R8A779A0_PD_A3VIP3		59
-#define R8A779A0_PD_A3ISP01		60
-#define R8A779A0_PD_A3ISP23		61
-
-/* Always-on power area */
-#define R8A779A0_PD_ALWAYS_ON		64
-
-#endif /* __DT_BINDINGS_POWER_R8A779A0_SYSC_H__ */
diff --git a/include/dt-bindings/power/r8a779f0-sysc.h b/include/dt-bindings/power/r8a779f0-sysc.h
deleted file mode 100644
index cde1536e9ed..00000000000
--- a/include/dt-bindings/power/r8a779f0-sysc.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
-/*
- * Copyright (C) 2021 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_POWER_R8A779F0_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A779F0_SYSC_H__
-
-/*
- * These power domain indices match the Power Domain Register Numbers (PDR)
- */
-
-#define R8A779F0_PD_A1E0D0C0		0
-#define R8A779F0_PD_A1E0D0C1		1
-#define R8A779F0_PD_A1E0D1C0		2
-#define R8A779F0_PD_A1E0D1C1		3
-#define R8A779F0_PD_A1E1D0C0		4
-#define R8A779F0_PD_A1E1D0C1		5
-#define R8A779F0_PD_A1E1D1C0		6
-#define R8A779F0_PD_A1E1D1C1		7
-#define R8A779F0_PD_A2E0D0		16
-#define R8A779F0_PD_A2E0D1		17
-#define R8A779F0_PD_A2E1D0		18
-#define R8A779F0_PD_A2E1D1		19
-#define R8A779F0_PD_A3E0		20
-#define R8A779F0_PD_A3E1		21
-
-/* Always-on power area */
-#define R8A779F0_PD_ALWAYS_ON		64
-
-#endif /* __DT_BINDINGS_POWER_R8A779A0_SYSC_H__*/
diff --git a/include/dt-bindings/power/r8a779g0-sysc.h b/include/dt-bindings/power/r8a779g0-sysc.h
deleted file mode 100644
index c7b139fb075..00000000000
--- a/include/dt-bindings/power/r8a779g0-sysc.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
-/*
- * Copyright (C) 2022 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_POWER_R8A779G0_SYSC_H__
-#define __DT_BINDINGS_POWER_R8A779G0_SYSC_H__
-
-/*
- * These power domain indices match the Power Domain Register Numbers (PDR)
- */
-
-#define R8A779G0_PD_A1E0D0C0		0
-#define R8A779G0_PD_A1E0D0C1		1
-#define R8A779G0_PD_A1E0D1C0		2
-#define R8A779G0_PD_A1E0D1C1		3
-#define R8A779G0_PD_A2E0D0		16
-#define R8A779G0_PD_A2E0D1		17
-#define R8A779G0_PD_A3E0		20
-#define R8A779G0_PD_A33DGA		24
-#define R8A779G0_PD_A23DGB		25
-#define R8A779G0_PD_A1DSP0		33
-#define R8A779G0_PD_A2IMP01		34
-#define R8A779G0_PD_A2PSC		35
-#define R8A779G0_PD_A2CV0		36
-#define R8A779G0_PD_A2CV1		37
-#define R8A779G0_PD_A1CNN0		41
-#define R8A779G0_PD_A2CN0		42
-#define R8A779G0_PD_A3IR		43
-#define R8A779G0_PD_A1DSP1		45
-#define R8A779G0_PD_A2IMP23		46
-#define R8A779G0_PD_A2DMA		47
-#define R8A779G0_PD_A2CV2		48
-#define R8A779G0_PD_A2CV3		49
-#define R8A779G0_PD_A1DSP2		53
-#define R8A779G0_PD_A1DSP3		54
-#define R8A779G0_PD_A3VIP0		56
-#define R8A779G0_PD_A3VIP1		57
-#define R8A779G0_PD_A3VIP2		58
-#define R8A779G0_PD_A3ISP0		60
-#define R8A779G0_PD_A3ISP1		61
-#define R8A779G0_PD_A3DUL		62
-
-/* Always-on power area */
-#define R8A779G0_PD_ALWAYS_ON		64
-
-#endif /* __DT_BINDINGS_POWER_R8A779G0_SYSC_H__*/
diff --git a/include/dt-bindings/power/renesas,r8a779h0-sysc.h b/include/dt-bindings/power/renesas,r8a779h0-sysc.h
deleted file mode 100644
index f27976f523e..00000000000
--- a/include/dt-bindings/power/renesas,r8a779h0-sysc.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
-/*
- * Copyright (C) 2023 Renesas Electronics Corp.
- */
-#ifndef __DT_BINDINGS_POWER_RENESAS_R8A779H0_SYSC_H__
-#define __DT_BINDINGS_POWER_RENESAS_R8A779H0_SYSC_H__
-
-/*
- * These power domain indices match the Power Domain Register Numbers (PDR)
- */
-
-#define R8A779H0_PD_A1E0D0C0		0
-#define R8A779H0_PD_A1E0D0C1		1
-#define R8A779H0_PD_A1E0D0C2		2
-#define R8A779H0_PD_A1E0D0C3		3
-#define R8A779H0_PD_A2E0D0		16
-#define R8A779H0_PD_A3CR0		21
-#define R8A779H0_PD_A3CR1		22
-#define R8A779H0_PD_A3CR2		23
-#define R8A779H0_PD_A33DGA		24
-#define R8A779H0_PD_A23DGB		25
-#define R8A779H0_PD_C4			31
-#define R8A779H0_PD_A1DSP0		33
-#define R8A779H0_PD_A2IMP01		34
-#define R8A779H0_PD_A2PSC		35
-#define R8A779H0_PD_A2CV0		36
-#define R8A779H0_PD_A2CV1		37
-#define R8A779H0_PD_A3IMR0		38
-#define R8A779H0_PD_A3IMR1		39
-#define R8A779H0_PD_A3VC		40
-#define R8A779H0_PD_A2CN0		42
-#define R8A779H0_PD_A1CN0		44
-#define R8A779H0_PD_A1DSP1		45
-#define R8A779H0_PD_A2DMA		47
-#define R8A779H0_PD_A2CV2		48
-#define R8A779H0_PD_A2CV3		49
-#define R8A779H0_PD_A3IMR2		50
-#define R8A779H0_PD_A3IMR3		51
-#define R8A779H0_PD_A3PCI		52
-#define R8A779H0_PD_A2PCIPHY		53
-#define R8A779H0_PD_A3VIP0		56
-#define R8A779H0_PD_A3VIP2		58
-#define R8A779H0_PD_A3ISP0		60
-#define R8A779H0_PD_A3DUL		62
-
-/* Always-on power area */
-#define R8A779H0_PD_ALWAYS_ON		64
-
-#endif /* __DT_BINDINGS_POWER_RENESAS_R8A779H0_SYSC_H__ */
-- 
2.45.2

