Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED43ECCD19F
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F34DF838F3;
	Fri, 17 Oct 2025 17:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="I0Dnq7Ne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4451D83857; Fri, 17 Oct 2025 17:25:29 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AFD283826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 188DA25C64;
 Fri, 17 Oct 2025 17:25:27 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DB8KbmY3BRr2; Fri, 17 Oct 2025 17:25:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714726; bh=0SQMldarpDJXRdI12EguC33R5ZTVlbPf7aq6CIPAwbM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=I0Dnq7NekfPxsBOSg7SxWHDAApso9u4EzY45pw8yFgolxoAhSuTSVqsH1s80daf+N
 MIu67ymyt3WhArfrlTJlt5Z0gkl3adeYN+bB0ocMPZ1sVdRHmJ+szDC3eE9eOlBWhB
 PVs8ARNuwsHnPI17Fm53dQjf0ynajUlUhXN8r+pE+6vvKWx0NchPyc4oTT7YmJa5zz
 KGB9d/L24RmhTMYGwrtX238qMB7cXwR/Od4IzPZmTTR4lGgNsFLyPCFjw4aqjBflAB
 AAlSBlz7e+eJ5ChPeuPElVG+0Zq8qn9I0lhAw0q4pluH4B7tkpp8/A8SIBffwE7FJH
 RyN+mTMqzHl/A==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:54:09 +0530
Subject: [PATCH 4/9] mmc: dw_mmc: add voltage switch command flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mmc-dw-exynos7870-v1-4-a2c5139d9afe@disroot.org>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=4105;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=0SQMldarpDJXRdI12EguC33R5ZTVlbPf7aq6CIPAwbM=;
 b=1qzXdMvyBWr2C1lhbt92J4wXNI4Ro1nVXu8kEZcEWRM/N1q1eYn7p3/f2WSqvRYQuJr9tiQJ0
 rS5+AV5DsIfDdqKyhqYiDbUro23acSQ9554cBT40JPlNIsFu16cOQoj
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

During a voltage switch command (CMD11, opcode: SD_CMD_SWITCH_UHS18V),
certain hosts tend to stop responding to subsequent commands. This is
addressed by introducing an additional command flag,
DWMCI_CMD_VOLT_SWITCH.

The associated interrupt bit is defined as DWMCI_INTMSK_VOLTSW. This is
set high when a voltage switch is issued, this needs to be waited for
and set to low. Implement the same in the timeout loop. Do note that
since DWMCI_INTMSK_VOLTSW shares the same bit as DWMCI_INTMSK_HTO (bit
10), the interrupt bit needs to be polled for only if the volt switch
command is issued.

DWMCI_CMD_VOLT_SWITCH also needs to be set for subsequent clken commands
after the volt switch. To ensure this, add a boolean member in the host
private struct (herein named volt_switching), which informs if the last
command issued was for volt switching or not.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/dw_mmc.c | 15 +++++++++++++--
 include/dwmmc.h      |  4 ++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index 1aa992c352c3f11ccdd1c02745fa988646952261..94b6641c44c39e67aac453c027d519c0e1580de6 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -419,6 +419,10 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
 	if (cmd->resp_type & MMC_RSP_CRC)
 		flags |= DWMCI_CMD_CHECK_CRC;
 
+	host->volt_switching = (cmd->cmdidx == SD_CMD_SWITCH_UHS18V);
+	if (host->volt_switching)
+		flags |= DWMCI_CMD_VOLT_SWITCH;
+
 	flags |= cmd->cmdidx | DWMCI_CMD_START | DWMCI_CMD_USE_HOLD_REG;
 
 	debug("Sending CMD%d\n", cmd->cmdidx);
@@ -427,6 +431,10 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
 
 	for (i = 0; i < retry; i++) {
 		mask = dwmci_readl(host, DWMCI_RINTSTS);
+		if (host->volt_switching && (mask & DWMCI_INTMSK_VOLTSW)) {
+			dwmci_writel(host, DWMCI_RINTSTS, DWMCI_INTMSK_VOLTSW);
+			break;
+		}
 		if (mask & DWMCI_INTMSK_CDONE) {
 			if (!data)
 				dwmci_writel(host, DWMCI_RINTSTS, mask);
@@ -508,12 +516,15 @@ static int dwmci_control_clken(struct dwmci_host *host, bool on)
 	const u32 val = on ? DWMCI_CLKEN_ENABLE | DWMCI_CLKEN_LOW_PWR : 0;
 	const u32 cmd_only_clk = DWMCI_CMD_PRV_DAT_WAIT | DWMCI_CMD_UPD_CLK;
 	int i, timeout = 10000;
-	u32 mask;
+	u32 flags, mask;
 
 	dwmci_writel(host, DWMCI_CLKENA, val);
 
 	/* Inform CIU */
-	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_START | cmd_only_clk);
+	flags = DWMCI_CMD_START | cmd_only_clk;
+	if (host->volt_switching)
+		flags |= DWMCI_CMD_VOLT_SWITCH;
+	dwmci_writel(host, DWMCI_CMD, flags);
 
 	for (i = 0; i < timeout; i++) {
 		mask = dwmci_readl(host, DWMCI_RINTSTS);
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 639a2d28e7860f2ceb09955ee11550e406fd1bd2..47e3220985e900050d9db9d80e0d45efe6c2e545 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -72,6 +72,7 @@
 #define DWMCI_INTMSK_RTO	BIT(8)
 #define DWMCI_INTMSK_DRTO	BIT(9)
 #define DWMCI_INTMSK_HTO	BIT(10)
+#define DWMCI_INTMSK_VOLTSW	BIT(10) /* overlap! */
 #define DWMCI_INTMSK_FRUN	BIT(11)
 #define DWMCI_INTMSK_HLE	BIT(12)
 #define DWMCI_INTMSK_SBE	BIT(13)
@@ -104,6 +105,7 @@
 #define DWMCI_CMD_ABORT_STOP	BIT(14)
 #define DWMCI_CMD_PRV_DAT_WAIT	BIT(13)
 #define DWMCI_CMD_UPD_CLK	BIT(21)
+#define DWMCI_CMD_VOLT_SWITCH	BIT(28)
 #define DWMCI_CMD_USE_HOLD_REG	BIT(29)
 #define DWMCI_CMD_START		BIT(31)
 
@@ -190,6 +192,7 @@ struct dwmci_idmac_regs {
  * @cfg:	Internal MMC configuration, for !CONFIG_BLK cases
  * @fifo_mode:	Use FIFO mode (not DMA) to read and write data
  * @dma_64bit_address: Whether DMA supports 64-bit address mode or not
+ * @volt_switching: Whether SD voltage switching is in process or not
  * @regs:	Registers that can vary for different DW MMC block versions
  */
 struct dwmci_host {
@@ -229,6 +232,7 @@ struct dwmci_host {
 
 	bool fifo_mode;
 	bool dma_64bit_address;
+	bool volt_switching;
 	const struct dwmci_idmac_regs *regs;
 };
 

-- 
2.51.0

