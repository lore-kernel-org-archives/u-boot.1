Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8323C02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 11:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E0B180771;
	Sat, 18 Jan 2025 12:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d+mRgxyX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yJGEZRf6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F9480759; Sat, 18 Jan 2025 12:16:57 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B9180756
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 12:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YZvFM076Sz9svH;
 Sat, 18 Jan 2025 12:16:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Woyqh9AFlYPaeormObiWC5pQSr8aOZaN/KgOBKgc3Zc=;
 b=d+mRgxyXbui8yh9GO0Ar4d/R+ScxRAI7CsGJjHwqJ9OQH0i3zIOG81W3UdV6h3b6XGxjCB
 xqKRKzua/zGmZxdkKslHCnXV1RPuQh8D2t0Ky/CA9nw1gouVizSg/8/Q4wWuSw8GLXb0/e
 Dy/co4LfAaoWzNPPsdvRLN9MFgSCaYuUuB3/PB0YoT4vJhnZJQFHfQ4ulzPs5yIx263Twt
 piCZ+h76tm4vOKwxsaDeKYqM2h29v5XMMDcf3DJQ/USqAmB7nCqovIHQImMtWHxB0UjCmI
 EBaKjxhsd66JFSHWCemeLeozkdk205a1Ihuu8t8k1+yYKya1QR7xNrI34qc10w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737199013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Woyqh9AFlYPaeormObiWC5pQSr8aOZaN/KgOBKgc3Zc=;
 b=yJGEZRf6LVaCMsuqUsFYc3RFS8+WvMqKXROngRdnNkhRtFwsangqLJYhYVEpv4vQd3o3L1
 EQXo5qfNCOOvCqg0CG7LwQbikq1pbu4Y2kBs4GiMpIDeiN0oVRE4fen70ze9e3Z6SqMaja
 oe6zKpZf3cEGrQRK0hVZ7bA3KJM+rf21as8+Se496xjj2Q9c180MtHmbOfLuXSpx75qS3H
 QGRA5EnybuF99SuIVK1NaD7aDcqTCBJjj9IqogyOUJ75Sn4EetZGf1Nay091yH4EP+HMu1
 iH74SkYHwaGomTvgbymBgQomwnxmvZJDkmfBfXEPozxau8FgU4Z55tWEIGrRKw==
To: u-boot@lists.denx.de
Cc: quentin.schulz@cherry.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/8] ARM: renesas: Rename common/common.c to
 common/rcar64-common.c
Date: Sat, 18 Jan 2025 12:15:26 +0100
Message-ID: <20250118111621.362188-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i9eas7zd3jkk1bgu3sdi7aixiesfmtsd
X-MBO-RS-ID: ad928104c19757c5905
X-Rspamd-Queue-Id: 4YZvFM076Sz9svH
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

The common.c content is specific to 64-bit R-Car SoCs, rename
the file to rcar64-common.c and remove R-Car 64-bit ifdeffery
in the file. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 board/beacon/beacon-rzg2m/Makefile                 | 2 +-
 board/hoperun/hihope-rzg2/Makefile                 | 2 +-
 board/renesas/common/Makefile                      | 2 +-
 board/renesas/common/{common.c => rcar64-common.c} | 4 ----
 board/silinux/ek874/Makefile                       | 2 +-
 5 files changed, 4 insertions(+), 8 deletions(-)
 rename board/renesas/common/{common.c => rcar64-common.c} (97%)

diff --git a/board/beacon/beacon-rzg2m/Makefile b/board/beacon/beacon-rzg2m/Makefile
index 6a6ae94def8..10b7a7fbfa9 100644
--- a/board/beacon/beacon-rzg2m/Makefile
+++ b/board/beacon/beacon-rzg2m/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= beacon-rzg2m.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
+obj-y	:= beacon-rzg2m.o ../../renesas/common/gen3-common.o ../../renesas/common/rcar64-common.o
diff --git a/board/hoperun/hihope-rzg2/Makefile b/board/hoperun/hihope-rzg2/Makefile
index a42c55b9d00..299769c9cb6 100644
--- a/board/hoperun/hihope-rzg2/Makefile
+++ b/board/hoperun/hihope-rzg2/Makefile
@@ -6,4 +6,4 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
-obj-y	:= hihope-rzg2.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
+obj-y	:= hihope-rzg2.o ../../renesas/common/gen3-common.o ../../renesas/common/rcar64-common.o
diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
index c531738b22e..8c26c0afd90 100644
--- a/board/renesas/common/Makefile
+++ b/board/renesas/common/Makefile
@@ -18,7 +18,7 @@ endif
 # 64 bit SoCs
 ifdef CONFIG_RCAR_64
 ifndef CONFIG_XPL_BUILD
-obj-y	+= common.o
+obj-y	+= rcar64-common.o
 endif
 
 ifdef CONFIG_RCAR_GEN3
diff --git a/board/renesas/common/common.c b/board/renesas/common/rcar64-common.c
similarity index 97%
rename from board/renesas/common/common.c
rename to board/renesas/common/rcar64-common.c
index 7fba8d10ff5..74ec0a46e6f 100644
--- a/board/renesas/common/common.c
+++ b/board/renesas/common/rcar64-common.c
@@ -18,8 +18,6 @@
 #include <asm/system.h>
 #include <linux/libfdt.h>
 
-#ifdef CONFIG_RCAR_64
-
 DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
@@ -67,5 +65,3 @@ int __weak board_init(void)
 {
 	return 0;
 }
-
-#endif
diff --git a/board/silinux/ek874/Makefile b/board/silinux/ek874/Makefile
index c1cab6fa788..0beda63d115 100644
--- a/board/silinux/ek874/Makefile
+++ b/board/silinux/ek874/Makefile
@@ -9,5 +9,5 @@
 ifdef CONFIG_XPL_BUILD
 obj-y	:= ../../renesas/common/gen3-spl.o
 else
-obj-y	:= ek874.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
+obj-y	:= ek874.o ../../renesas/common/gen3-common.o ../../renesas/common/rcar64-common.o
 endif
-- 
2.45.2

