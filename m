Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A39CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BB886998;
	Sun, 17 Sep 2023 16:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h1CsRRDw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pVwY74QW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20B6186552; Sun, 17 Sep 2023 16:09:16 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55AAF8658D
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVCt1jnFz9sPm
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0XBQKCe3eoKFIhYxo/qPWxPc0Px3shwzdYcLvZZku0=;
 b=h1CsRRDwEQtGlKtgM6M3y/Tk9kMecNrUlslzmPpRSVLn6Vp6Xssf0maNBrG/Vg0MadUxLq
 YBte7iuqVFoQDeeNLwLpt2JlM7UyINyiR06ClflnadxwnqVf4l2vuy4+xAJkXXjafPrmOz
 ZKsVPqjd5WNCKnsGai5855u817NTSPNcCXAs3dDSDhcgaJClqHB8Nmuz3XZSNLYG6Mgemj
 IthSKqOambwGOXHNd22234yWiBp5cvcUv0Clih6iRR/MTjyiZEcT1EMToBYgA/wpXrxmID
 c7+VxtJxgGg06j3k8dGTzSOTDoqdjqoFFdoMwUkYRFmFa1CmXrjUQrszevARnw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0XBQKCe3eoKFIhYxo/qPWxPc0Px3shwzdYcLvZZku0=;
 b=pVwY74QWG7Xft9wkiebIQg/iJ57AlUFBAVwKQu0sVGxnIEaVKU7/dvam29tByNTQ0sopmV
 vhxu7mwTLDGEXJpeBBWZWGTm3cmG63UE+kycu+BgQCJVGnSytNd23lCo0iPSgMNArSyESj
 je4ruCr2MiAz2bjtx4b9SBV9S9OujrRsTT1htBhrpjFvn0jlQ2zYXOjzbp+U1LobnIL+Yg
 XvqPCgufhe2LgapM17Uwzh/gYcPn5+ZH/RuaO3QWEyvlFBDU/XcSbxLnxWdzxXrWWdBiR8
 xGCtRNgtxfS3owegu5HJP11zlRRcHO8FFE+gRXIUUWSlEUfS3zOQ3AWbt/M9/g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/18] pinctrl: renesas: Synchronize R8A77960 M3-W and
 R8A77961 M3-W+ PFC tables with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:41 +0200
Message-Id: <20230917140849.379711-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: zkfek8n8wjjffz5rf869wwx6p7nbz946
X-MBO-RS-ID: 045caa57afcef839862
X-Rspamd-Queue-Id: 4RpVCt1jnFz9sPm
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

Synchronize R-Car R8A77960 M3-W and R8A77961 M3-W+ PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a7796.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a7796.c b/drivers/pinctrl/renesas/pfc-r8a7796.c
index 3cc4a3b366a..163d1805dfb 100644
--- a/drivers/pinctrl/renesas/pfc-r8a7796.c
+++ b/drivers/pinctrl/renesas/pfc-r8a7796.c
@@ -25,12 +25,12 @@
 	PORT_GP_CFG_16(0, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_29(1, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_15(2, fn, sfx, CFG_FLAGS),	\
-	PORT_GP_CFG_12(3, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE),	\
+	PORT_GP_CFG_12(3, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE_18_33),	\
 	PORT_GP_CFG_1(3, 12, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_1(3, 13, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_1(3, 14, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_1(3, 15, fn, sfx, CFG_FLAGS),	\
-	PORT_GP_CFG_18(4, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE),	\
+	PORT_GP_CFG_18(4, fn, sfx, CFG_FLAGS | SH_PFC_PIN_CFG_IO_VOLTAGE_18_33),	\
 	PORT_GP_CFG_26(5, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_32(6, fn, sfx, CFG_FLAGS),	\
 	PORT_GP_CFG_4(7, fn, sfx, CFG_FLAGS)
@@ -5568,7 +5568,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED 16-1 */
 		MOD_SEL2_0 ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static const struct pinmux_drive_reg pinmux_drive_regs[] = {
@@ -5816,7 +5816,7 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(6, 30),  8, 3 },	/* GP6_30 */
 		{ RCAR_GP_PIN(6, 31),  4, 3 },	/* GP6_31 */
 	} },
-	{ },
+	{ /* sentinel */ }
 };
 
 enum ioctrl_regs {
@@ -5827,7 +5827,7 @@ enum ioctrl_regs {
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL] = { 0xe6060380, },
 	[TDSELCTRL] = { 0xe60603c0, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int r8a7796_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
@@ -6084,7 +6084,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[30] = SH_PFC_PIN_NONE,
 		[31] = SH_PFC_PIN_NONE,
 	} },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static const struct sh_pfc_soc_operations r8a7796_pfc_ops = {
-- 
2.40.1

