Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71716CD37B3
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5843E86A82;
	Sun, 17 Sep 2023 16:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B4wzwI3x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ti0+lyXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE2C86A21; Sun, 17 Sep 2023 16:12:04 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7007F86A28
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpVH62rMpz9sWS
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzsHH4RC9cpek7SkzDeWpN3qz9tnk+3wn0Pfa4wTd6o=;
 b=B4wzwI3xkXoU06vuA0yggVTW8kyELE2HsH/Kg9ktPdowibysr/iqk3Ri84kEZW3w/CeaFz
 Z4fGlyRWm+Hd8Ub5GaUAzcsnCcLXpLyTqD6WwJyldCFkfK8hJNpj7Zp8wl89iLI7AR9Owx
 hrtybxHtw1DDIsTKWGj8VRWalakx5u9/ctLF4QlXZSm6deHa/Ys3mC46kpkm4cbZI5k2V2
 8os2np/40qUw35sYhz3UWmShw+M/ZoKs9XCnhx2Ulbbp5mjMtNkcZyz8dDnC8tqDbuyhNU
 g/+aUPRAw5kKNV9mpOvOWNLvBuYaZqG9GH6ZbbvtkQ/N45NtvRHhxDbASkxVlQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzsHH4RC9cpek7SkzDeWpN3qz9tnk+3wn0Pfa4wTd6o=;
 b=ti0+lyXeqNJO/XiEY4sf4wK33PFG6P/hq1KUDJpG1aEY/dTi8yhpAnOhxGfLsYKVxbXZ7g
 aP8uK38htWI/V8XOi8UBu+rZBrim1s8Mjxt1NsADEd0oplwErJ/qJX70jUyxCWWL9FpmFX
 SK5yzk/AOeQ8CbVvAWWJOWXQ1s0XExvSTMVYGln9GjB4sRKgjQ29YDUsoOmGGufuuhiBuS
 3ifbNIqs3VzWSYRv8PgX1NEboP+mg3Gu7TAEvOUrWKvarQv+WJ91sSoCxuVLGWUIGHoQW0
 3dhPEjdekuvsDw4vNLgrHvZxjZFxfvtfAtijAGpcpWIVB4mIyvMx9PkC8dh30A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 04/20] clk: renesas: Synchronize R8A7791 M2-W and R8A7793 M2-N
 clock tables with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:11:25 +0200
Message-Id: <20230917141141.379884-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
References: <20230917141141.379884-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a94c0fda8198432bba3
X-MBO-RS-META: b1mw96hetbgdcxpk1trw7mx5bdi9mw3c
X-Rspamd-Queue-Id: 4RpVH62rMpz9sWS
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

Synchronize R-Car R8A7791 M2-W and R8A7793 M2-N clock tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/clk/renesas/r8a7791-cpg-mssr.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/r8a7791-cpg-mssr.c b/drivers/clk/renesas/r8a7791-cpg-mssr.c
index fcca7be8865..dcb0fd85c52 100644
--- a/drivers/clk/renesas/r8a7791-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7791-cpg-mssr.c
@@ -1,10 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Renesas R8A7791 CPG MSSR driver
- *
- * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
- *
- * Based on the following driver from Linux kernel:
  * r8a7791 Clock Pulse Generator / Module Standby and Software Reset
  *
  * Copyright (C) 2015-2017 Glider bvba
@@ -43,7 +38,7 @@ enum clk_ids {
 	MOD_CLK_BASE
 };
 
-static const struct cpg_core_clk r8a7791_core_clks[] = {
+static struct cpg_core_clk r8a7791_core_clks[] __initdata = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal",     CLK_EXTAL),
 	DEF_INPUT("usb_extal", CLK_USB_EXTAL),
@@ -89,7 +84,7 @@ static const struct cpg_core_clk r8a7791_core_clks[] = {
 	DEF_DIV6P1("ssprs", R8A7791_CLK_SSPRS, CLK_PLL1_DIV2, 0x24c),
 };
 
-static const struct mssr_mod_clk r8a7791_mod_clks[] = {
+static const struct mssr_mod_clk r8a7791_mod_clks[] __initconst = {
 	DEF_MOD("msiof0",		   0,	R8A7791_CLK_MP),
 	DEF_MOD("vcp0",			 101,	R8A7791_CLK_ZS),
 	DEF_MOD("vpc0",			 103,	R8A7791_CLK_ZS),
@@ -232,7 +227,7 @@ static const struct mssr_mod_clk r8a7791_mod_clks[] = {
 #define CPG_PLL_CONFIG_INDEX(md)	((((md) & BIT(14)) >> 12) | \
 					 (((md) & BIT(13)) >> 12) | \
 					 (((md) & BIT(19)) >> 19))
-static const struct rcar_gen2_cpg_pll_config cpg_pll_configs[8] = {
+static const struct rcar_gen2_cpg_pll_config cpg_pll_configs[8] __initconst = {
 	{ 1, 208, 106 }, { 1, 208,  88 }, { 1, 156,  80 }, { 1, 156,  66 },
 	{ 2, 240, 122 }, { 2, 240, 102 }, { 2, 208, 106 }, { 2, 208,  88 },
 };
-- 
2.40.1

