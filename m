Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6226C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 14:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C6881101;
	Thu, 27 Feb 2025 15:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="bVZxQkvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 654F180BA4; Thu, 27 Feb 2025 15:48:28 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D9780BA4
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 15:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 476D225B4D;
 Thu, 27 Feb 2025 15:48:26 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D5eHi2v6RadN; Thu, 27 Feb 2025 15:48:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1740667705; bh=I2kwGqgoNG+nHMtqfcJYGaOkEdeCVVUYJFKSaivhs2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bVZxQkvhWo6CkdAeGH64pUcXKNphHgcyiXHB56svMoYgkA68TvFzNAxqWBqf5XPkh
 ATV0Q6Q40g7yGEyX8WnmBN4cxqVVihLCE1rxb0ozIO6DoQJaoYuHUmWqrxGbE6FGTZ
 4++O7cGH82tCOQEG+CmmgTOVreCpF+dK3JWfc46ToBodusHec06JSsHNzQxI3hLG8u
 GZWLWBS2DhIU8LUtmKnjKmZ2RO6+qN2wzCpGXrbFak9YE3Yo5tBr+rUGDzX3wuQYc8
 35kmbHBgO1qE034aWWu9GGl5roZ7b4ZlH6YF6f37StUMx3lSWOppXldGft0J7uTrke
 KqbCFvJNjVKag==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 4/5] board: sifive: Remove duplicated board_fdt_blob_setup
Date: Thu, 27 Feb 2025 14:47:32 +0000
Message-ID: <20250227144734.61458-5-ziyao@disroot.org>
In-Reply-To: <20250227144734.61458-1-ziyao@disroot.org>
References: <20250227144734.61458-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The default version should work for both SiFive Unmatched and Unleashed.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 board/sifive/unleashed/unleashed.c | 11 -----------
 board/sifive/unmatched/unmatched.c | 10 ----------
 2 files changed, 21 deletions(-)

diff --git a/board/sifive/unleashed/unleashed.c b/board/sifive/unleashed/unleashed.c
index c1c374610c3..f5da289b836 100644
--- a/board/sifive/unleashed/unleashed.c
+++ b/board/sifive/unleashed/unleashed.c
@@ -114,17 +114,6 @@ int misc_init_r(void)
 
 #endif
 
-int board_fdt_blob_setup(void **fdtp)
-{
-	if (gd->arch.firmware_fdt_addr) {
-		*fdtp = (ulong *)(uintptr_t)gd->arch.firmware_fdt_addr;
-
-		return 0;
-	}
-
-	return -EEXIST;
-}
-
 int board_init(void)
 {
 	/* enable all cache ways */
diff --git a/board/sifive/unmatched/unmatched.c b/board/sifive/unmatched/unmatched.c
index 23e03e145ee..a57ce1f10fe 100644
--- a/board/sifive/unmatched/unmatched.c
+++ b/board/sifive/unmatched/unmatched.c
@@ -10,16 +10,6 @@
 #include <dm.h>
 #include <asm/sections.h>
 
-int board_fdt_blob_setup(void **fdtp)
-{
-	if (gd->arch.firmware_fdt_addr) {
-		*fdtp = (ulong *)(uintptr_t)gd->arch.firmware_fdt_addr;
-		return 0;
-	}
-
-	return -EEXIST;
-}
-
 int board_init(void)
 {
 	/* enable all cache ways */
-- 
2.48.1

