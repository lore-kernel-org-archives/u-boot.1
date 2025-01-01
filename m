Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AE1E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 19:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B25803D2;
	Wed,  1 Jan 2025 20:19:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZKmPeDej";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WMfyRcyP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B8C803CC; Wed,  1 Jan 2025 20:19:52 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BF98039B
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 20:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YNfmP5Hw3z9tsy;
 Wed,  1 Jan 2025 20:19:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735759189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXmNiaQZ5fcDRpWiS3wvvDwO3zs2DCaKwaVO+ZtXTY0=;
 b=ZKmPeDejoobZEKXggZMrw5Cb21lZREPDhlA/MXzFiVJH58r564VVhRQKv4ONpK5TC0CtjD
 rMDIajySWlMGhVZHIafbEwWXFTb7C7sAJh+Rwnf9HDUHYuE9DEIg9eUXNxowOaV/GOt9FJ
 2pIny8S2Grd8mcAgKsAQ3mLPDFwzi6kJTl0MFz2MNWI399FPVlh68Y/S/MoPH45JiPmrVp
 2Eho4DMyh0Nzjz2pIkOyYXSFYNmflCLG1uZqvO8qPkDgEwvdzF3lUzaj8Bn9Tp7GUh/wxw
 09lyOv2UTCiQ7aky0/zqdQF0FLFInYOuUi7QxZyWSmbfFIEfiCFowIswJxolWQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735759187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXmNiaQZ5fcDRpWiS3wvvDwO3zs2DCaKwaVO+ZtXTY0=;
 b=WMfyRcyPh3kTiNBMAxLZz4RdxECtwvSOyz7r6G22T+zhBjjPgNnNe/lXTB44wlJZoUW2S4
 ebUgyz9vZfEEWNPXDI3a9KU2KZZp/wyl2syIK6oAjbQWq1pM6jh1krnYKoFIq31ZtBaGAQ
 C2B2kZr/xpAOWPet1ks20H5NfePjj6fwZ2X3ggHYEXivC18jZx5OyAiARuC1+Ypu87dvaJ
 xaysXwfxgAC7vuzP3jsOjmuYntSiGKWeACmqVd7bHEYoFYCv3U2dwvdzTwi17xl/5U+Cfz
 Q+EhgNLJERQv0UAVSv7XUQDlaHe12QFF0NJNuxUyRKQ0cDhwHmYs6rSbRgyQrg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/3] arm64: renesas: Convert boards over to is_cortex_a()
 functions
Date: Wed,  1 Jan 2025 20:19:06 +0100
Message-ID: <20250101191920.25317-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250101191920.25317-1-marek.vasut+renesas@mailbox.org>
References: <20250101191920.25317-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ke1sj698wqys8bht54zfdw46df9tdkos
X-MBO-RS-ID: a711c8439cfd7bb6b5f
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

Use generic is_cortex_a() functions instead of open-coded midr_el1 read.
No functional change.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Rebase on u-boot/next
    - Add RB from Paul
---
 board/hoperun/hihope-rzg2/hihope-rzg2.c |  8 ++------
 board/renesas/rcar-common/gen3-common.c | 10 +++-------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/board/hoperun/hihope-rzg2/hihope-rzg2.c b/board/hoperun/hihope-rzg2/hihope-rzg2.c
index 8b635ef71ac..d2c5aaacf66 100644
--- a/board/hoperun/hihope-rzg2/hihope-rzg2.c
+++ b/board/hoperun/hihope-rzg2/hihope-rzg2.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2021 Renesas Electronics Corporation
  */
 
+#include <asm/armv8/cpu.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/processor.h>
@@ -66,12 +67,7 @@ int board_init(void)
 
 void reset_cpu(void)
 {
-	unsigned long midr, cputype;
-
-	asm volatile("mrs %0, midr_el1" : "=r" (midr));
-	cputype = (midr >> 4) & 0xfff;
-
-	if (cputype == 0xd03)
+	if (is_cortex_a53())
 		writel(RST_CA53_CODE, RST_CA53RESCNT);
 	else
 		writel(RST_CA57_CODE, RST_CA57RESCNT);
diff --git a/board/renesas/rcar-common/gen3-common.c b/board/renesas/rcar-common/gen3-common.c
index 4291e1d5bcb..004feca6180 100644
--- a/board/renesas/rcar-common/gen3-common.c
+++ b/board/renesas/rcar-common/gen3-common.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2015 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
+#include <asm/armv8/cpu.h>
 #include <dm.h>
 #include <fdt_support.h>
 #include <hang.h>
@@ -50,14 +51,9 @@ int fdtdec_board_setup(const void *fdt_blob)
 
 void __weak reset_cpu(void)
 {
-	unsigned long midr, cputype;
-
-	asm volatile("mrs %0, midr_el1" : "=r" (midr));
-	cputype = (midr >> 4) & 0xfff;
-
-	if (cputype == 0xd03)
+	if (is_cortex_a53())
 		writel(RST_CA53_CODE, RST_CA53RESCNT);
-	else if (cputype == 0xd07)
+	else if (is_cortex_a57())
 		writel(RST_CA57_CODE, RST_CA57RESCNT);
 	else
 		hang();
-- 
2.45.2

