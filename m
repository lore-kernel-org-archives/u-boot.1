Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32167CD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF065867EA;
	Sun, 17 Sep 2023 16:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BDy0E21Y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Rre1bnPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E038186823; Sun, 17 Sep 2023 16:09:16 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3D03867B5
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RpVCt52Wtz9sWt
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrNAX23OxLBOMiqVgeDuWkSMgaZpBxsqmfFK0smqOtE=;
 b=BDy0E21YK1Mj3FhaQc7sasC03PwdyTXFCHaG9S3hUxUzxe8u44yRRZ3aEB1gVUmdmBnFUr
 Ics4ZPI9OdzeuORiK2kqooyWUt/4vS9YNEGbNFqVeY8Ln+EwO8jd0sn3d9PKYklrD5708f
 Dh/pE9gmpy8LutdPB+YKydQGHtXJucIgAhYCJwHHtBrJXABNluWIazPDo/AE/941cG6GEE
 KYZblsvV0pOob0ohwHvP60kXiTQPN1mef28rjfH/3qOpbGDQjlEWpbkH5X/1IQeLTJxYKb
 Ga4A0ffg/a5UmtI0V/9qRSgFWHDQDkIhBslJQ+va/6janWcGxvUMRE6McUFDcA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrNAX23OxLBOMiqVgeDuWkSMgaZpBxsqmfFK0smqOtE=;
 b=Rre1bnPUZapc+WNsyG+PuRTdWTAPw344N3bmipAg3JSGjJx7u0SDTX2Zfy/agnL2iN7+Mv
 HRyWB9xNmeRFV0bKEVPgk4DRPmWNk+/2s+LD9QMVqsNuRFm/XhoUoTkKQMogtlDzzys19c
 Uk/7IxqKqMEbxC9otMgV9x8oxYqKvnqdnpdSG0/NPaSO2EdNk2mTbyd7R4pHES6rYkClva
 iMWVtVnw47qiVHBrTKPZtu+WbNjtYFfadHjRSeSSMynfOhSM/haA4587sUrJIvg1dPqa+W
 /jZOeAYQpOW3ncboYB7pom2JPv09/FqjgpXgJmyk6v28xUzKDxYrBHFJZzJmwg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 11/18] pinctrl: renesas: Synchronize R8A77965 M3-N PFC tables
 with Linux 6.5.3
Date: Sun, 17 Sep 2023 16:08:42 +0200
Message-Id: <20230917140849.379711-11-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 929eb5c9e53557f20f6
X-MBO-RS-META: y3mmq84zq6fd7mjf6qpam4paiqwc38wz
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

Synchronize R-Car R8A77965 M3-N PFC tables with Linux 6.5.3,
commit 238589d0f7b421aae18c5704dc931595019fa6c7 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/pfc-r8a77965.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a77965.c b/drivers/pinctrl/renesas/pfc-r8a77965.c
index 04e8371f51e..377143d3918 100644
--- a/drivers/pinctrl/renesas/pfc-r8a77965.c
+++ b/drivers/pinctrl/renesas/pfc-r8a77965.c
@@ -26,12 +26,12 @@
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
@@ -5809,7 +5809,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		/* RESERVED 16-1 */
 		MOD_SEL2_0 ))
 	},
-	{ },
+	{ /* sentinel */ }
 };
 
 static const struct pinmux_drive_reg pinmux_drive_regs[] = {
@@ -6057,7 +6057,7 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(6, 30),  8, 3 },	/* GP6_30 */
 		{ RCAR_GP_PIN(6, 31),  4, 3 },	/* GP6_31 */
 	} },
-	{ },
+	{ /* sentinel */ }
 };
 
 enum ioctrl_regs {
@@ -6068,7 +6068,7 @@ enum ioctrl_regs {
 static const struct pinmux_ioctrl_reg pinmux_ioctrl_regs[] = {
 	[POCCTRL] = { 0xe6060380, },
 	[TDSELCTRL] = { 0xe60603c0, },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int r8a77965_pin_to_pocctrl(unsigned int pin, u32 *pocctrl)
@@ -6325,7 +6325,7 @@ static const struct pinmux_bias_reg pinmux_bias_regs[] = {
 		[30] = SH_PFC_PIN_NONE,
 		[31] = SH_PFC_PIN_NONE,
 	} },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static const struct sh_pfc_soc_operations r8a77965_pfc_ops = {
-- 
2.40.1

