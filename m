Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB3CC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C87E8889B;
	Sat, 13 Jul 2024 15:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T+1gnsQq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a+n8O6/B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F4088889; Sat, 13 Jul 2024 15:21:29 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBA388872
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyH17r4z9sdG;
 Sat, 13 Jul 2024 15:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Xsv/He1t0+R27t7srHaMvDEoh9fG5tRGLA0I89+edM=;
 b=T+1gnsQqPajnE0T1/VMNTe5u9QEsxacOhi749frNVeFrVRPVyaA+nB1Jm3ybLg/ft49SPe
 TPsRu38KkxNT9aJQBJn7in0B1cGuUVx6LAcIWJ1YqUtn2l0QAlSrmbgF6PZM1hFft2h6Nz
 8viNXDVOVsyaS/IJHhixbDJUwO+PyDyO6n7ATqWEzA0hN1UXwx053Jh32QeFdgo3Dc+S0i
 MbpCGAFNbVbUYnCCglVYlQe/NG21GJK4fCS+noBH/WrNyNI/IcsGNEZkxczmYAMovdu+x2
 8/ZEs5WBbSaJaMOVkNom5VFCTKsEM37U/Yc3OdcLVUwLHSj6Jaty2kOt/gaW9A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Xsv/He1t0+R27t7srHaMvDEoh9fG5tRGLA0I89+edM=;
 b=a+n8O6/BJgt/U7Oe9Ru5RERbMp+RbJnIhQ2By5MipQjZpTcAm9yt5M1dVO3Xu+QriRx5qr
 0QH4DNMaG5SeygMXiiJrta2K/GuDFIG3npOTbDnI9lLE32E0dnBWWrGGXzP7+rt0Lbu8nO
 aro00elNWnJzz99vAvzM3pXiNCfo8kabU2Kige6e8H1Fkf16Hqy0ysM7oLGicjjU51Ok6v
 ebU7okv+W5IuAsUDnD9kYqlSNhtJ17XLcPbaLE9FpA0ShEfvWjw+EjW4UyTpH6JfrX+wSB
 hA5I9wvjqB++51GvDFyQKYhG7kwyCcQBC3hV5mHkK0CxGQWQg2Qo0QTECnvVKw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/45] arm: mach: marvell: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:10 +0200
Message-ID: <20240713132021.57650-19-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: dd599040cc81b9a27e4
X-MBO-RS-META: p1bdnz4jqx41ewbayhciaqhe3na3zttb
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-kirkwood/mpp.c                         | 1 -
 arch/arm/mach-mvebu/mbus.c                           | 1 -
 arch/arm/mach-mvebu/serdes/axp/board_env_spec.h      | 5 -----
 arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.h | 2 --
 4 files changed, 9 deletions(-)

diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-kirkwood/mpp.c
index 7938820e513..3d224e20364 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-kirkwood/mpp.c
@@ -48,7 +48,6 @@ void kirkwood_mpp_conf(const u32 *mpp_list, u32 *mpp_save)
 	}
 	debug("\n");
 
-
 	while (*mpp_list) {
 		unsigned int num = MPP_NUM(*mpp_list);
 		unsigned int sel = MPP_SEL(*mpp_list);
diff --git a/arch/arm/mach-mvebu/mbus.c b/arch/arm/mach-mvebu/mbus.c
index 9baeece3c85..c13416add1d 100644
--- a/arch/arm/mach-mvebu/mbus.c
+++ b/arch/arm/mach-mvebu/mbus.c
@@ -276,7 +276,6 @@ static int mvebu_mbus_alloc_window(phys_addr_t base, size_t size,
 							       target, attr);
 	}
 
-
 	for (win = 0; win < MVEBU_MBUS_NUM_WINS; win++)
 		if (mvebu_mbus_window_is_free(win))
 			return mvebu_mbus_setup_window(win, base, size,
diff --git a/arch/arm/mach-mvebu/serdes/axp/board_env_spec.h b/arch/arm/mach-mvebu/serdes/axp/board_env_spec.h
index 9c3e7c08204..625c2a5dd71 100644
--- a/arch/arm/mach-mvebu/serdes/axp/board_env_spec.h
+++ b/arch/arm/mach-mvebu/serdes/axp/board_env_spec.h
@@ -76,7 +76,6 @@
 
 #define SAR_CPU_FAB_GET(cpu, fab)	(((cpu & 0x7) << 21) | ((fab & 0xF) << 24))
 
-
 #define CORE_AVS_CONTROL_0REG		0x18300
 #define CORE_AVS_CONTROL_2REG		0x18308
 #define CPU_AVS_CONTROL2_REG		0x20868
@@ -86,7 +85,6 @@
 #define MSAR_TCLK_OFFS			28
 #define MSAR_TCLK_MASK			(0x1 << MSAR_TCLK_OFFS)
 
-
 /* Controler environment registers offsets */
 #define GEN_PURP_RES_1_REG		0x182F4
 #define GEN_PURP_RES_2_REG		0x182F8
@@ -146,7 +144,6 @@
 					 0x40000 + ((port) % 2) * 0x4000)
 #define MV_ETH_REGS_BASE(port)		MV_ETH_REGS_OFFSET(port)
 
-
 #define SGMII_PWR_PLL_CTRL_REG(port)	(MV_ETH_REGS_BASE(port) + 0xE04)
 #define SGMII_DIG_LP_ENA_REG(port)	(MV_ETH_REGS_BASE(port) + 0xE8C)
 #define SGMII_REF_CLK_SEL_REG(port)	(MV_ETH_REGS_BASE(port) + 0xF18)
@@ -182,7 +179,6 @@
 #define SCR_PEX1_4BY1_OFFS		8
 #define SCR_PEX1_4BY1_MASK		(1 << SCR_PEX1_4BY1_OFFS)
 
-
 #define MV_MISC_REGS_OFFSET		(0x18200)
 #define MV_MISC_REGS_BASE		(MV_MISC_REGS_OFFSET)
 #define SOC_CTRL_REG			(MV_MISC_REGS_BASE + 0x4)
@@ -226,7 +222,6 @@
 #define PXCAR_REAL_EXT_REG_NUM_OFFS     8
 #define PXCAR_REAL_EXT_REG_NUM_MASK     (0xF << PXCAR_REAL_EXT_REG_NUM_OFFS)
 
-
 #define PEX_CAPABILITIES_REG(if)	((MV_PEX_IF_REGS_BASE(if)) + 0x60)
 #define PEX_LINK_CAPABILITIES_REG(if)	((MV_PEX_IF_REGS_BASE(if)) + 0x6C)
 #define PEX_LINK_CTRL_STATUS_REG(if)	((MV_PEX_IF_REGS_BASE(if)) + 0x70)
diff --git a/arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.h b/arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.h
index b920f5ef090..a29d06cf3c2 100644
--- a/arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.h
+++ b/arch/arm/mach-mvebu/serdes/axp/high_speed_env_spec.h
@@ -21,7 +21,6 @@ typedef enum {
 	SERDES_LAST_UNIT
 } MV_BIN_SERDES_UNIT_INDX;
 
-
 typedef enum {
 	PEX_BUS_DISABLED	= 0,
 	PEX_BUS_MODE_X1		= 1,
@@ -63,7 +62,6 @@ typedef struct board_serdes_conf {
 	MV_SERDES_CHANGE_M_PHY *serdes_m_phy_change;
 } MV_BIN_SERDES_CFG;
 
-
 #define BIN_SERDES_CFG {	\
 	{0, 1, -1 , -1, -1, -1, -1, -1, -1}, /* Lane 0 */	\
 	{0, 1, -1 , -1, -1, -1, -1, -1,  2}, /* Lane 1 */	\
-- 
2.43.0

