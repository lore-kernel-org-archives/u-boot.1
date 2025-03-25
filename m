Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23F9C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 22:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F7681D3B;
	Tue, 25 Mar 2025 23:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OnfEi7hu";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l99EYyjh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417AE81951; Tue, 25 Mar 2025 23:45:09 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4380D81CA8
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 23:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZMlNp06LTz9tY2;
 Tue, 25 Mar 2025 23:44:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epWKt7otTaFsl31nwIaR5/3PXT8GtHGmzUVc6JQiWvE=;
 b=OnfEi7huq0o5YZZ33Iuet6pRgVMF3hc3XbYdLq7JHTBtV5t9J/xtX9BgjnaATTAcFxvRxV
 epMMXH+QNX07rNwTfTfxTa9Q1RidfqLOLB3DYha3UmJOf2AWU2njdYS8ij5NUt2HIJDYGv
 nYzNdr45VPgJOb0NJPwfBoAgAW4loFv3grlNXd28X4rZfxEwSsNIBbY/Nb7W3p2jhmSre1
 8oZ+u5P7tC7EOwaqBwJwzbBAnkuBglaBwWVSmeOYEgRWVXiwKmgD7oebPxRmp6d4tEocAy
 +Oow6O6yz067AQ5gNVfcjY8ENofqEQN+2ckWw6/K/hiSm+id8mZugKwNMy0V7A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epWKt7otTaFsl31nwIaR5/3PXT8GtHGmzUVc6JQiWvE=;
 b=l99EYyjhYC/ZbeDXDv2BpslbN2zys7ey05aBO/t36QQwn+XLHCw9BW8Y7cHe1hLizjNVTP
 icgQqBusGMYVRGzhz/HVXQm6ZeU8Y2emfFFXWuep7MbUD4l4thy/NfcVaDym2ZE/Q0TkZX
 zMiTOtn5AcrD32dq7yA2OmrehbTCYnBqklfLRuKCmdt5QiocIHePAqQtT7ZAb9es/JmICm
 gvndeEKEfHrsMKorv3RBkXZF1vJ2SBGwomnOCmZVYvIdWENRoR56DGf2BrI1TQOrkHfBfi
 67Pv9/7NMU7VnGhZPFro5AJYHQBNWitNakfM1DkNUSfWO4TqvpbOFOgUhn3ouw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] ram: renesas: dbsc5: Factor out dbsc5_wait_dbwait()
Date: Tue, 25 Mar 2025 23:43:32 +0100
Message-ID: <20250325224433.39090-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250325224433.39090-1-marek.vasut+renesas@mailbox.org>
References: <20250325224433.39090-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: bf7b7ef98b7186bb08a
X-MBO-RS-META: kkqhki8wjp6nse18xg5fdg5xj4tdqigk
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

Extract wait for completion code from dbsc5_send_dbcmd2() into
new separate function dbsc5_wait_dbwait(). This extracted code
can be used to implement MR register read in the future.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 42 ++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index 461c862ea27..ce04dd58180 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -1740,6 +1740,34 @@ static void dbsc5_reg_write(void __iomem *addr, u32 data)
 		writel(data, addr + 0x8000);
 }
 
+/**
+ * dbsc5_wait_dbwait() - DRAM Command Wait Access Completion
+ * @dev: DBSC5 device
+ *
+ * Wait for DRAM access completion. This is used before sending a command
+ * to the DRAM to assure no other command is in flight already, or while
+ * waiting for MRR command to complete.
+ */
+static void dbsc5_wait_dbwait(struct udevice *dev)
+{
+	struct renesas_dbsc5_dram_priv *priv = dev_get_priv(dev);
+	void __iomem *regs_dbsc_d = priv->regs + DBSC5_DBSC_D_OFFSET;
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout(regs_dbsc_d + DBSC_DBWAIT, val, ((val & BIT(0)) == 0), 1000000);
+	if (ret < 0) {
+		printf("%s DBWAIT bit 0 timeout\n", __func__);
+		hang();
+	}
+
+	ret = readl_poll_timeout(regs_dbsc_d + DBSC_DBWAIT + 0x4000, val, ((val & BIT(0)) == 0), 1000000);
+	if (ret < 0) {
+		printf("%s DBWAIT + 0x4000 bit 0 timeout\n", __func__);
+		hang();
+	}
+}
+
 /**
  * dbsc5_send_dbcmd2() - DRAM Command Write Access
  * @dev: DBSC5 device
@@ -1759,23 +1787,11 @@ static void dbsc5_send_dbcmd2(struct udevice *dev, const u8 opcode,
 	const u32 cmd = (opcode << 24) | (channel << 20) | (rank << 16) | arg;
 	struct renesas_dbsc5_dram_priv *priv = dev_get_priv(dev);
 	void __iomem *regs_dbsc_d = priv->regs + DBSC5_DBSC_D_OFFSET;
-	u32 val;
-	int ret;
 
 	/* dummy read */
 	readl(regs_dbsc_d + DBSC_DBCMD);
 
-	ret = readl_poll_timeout(regs_dbsc_d + DBSC_DBWAIT, val, ((val & BIT(0)) == 0), 1000000);
-	if (ret < 0) {
-		printf("%s DBWAIT bit 0 timeout\n", __func__);
-		hang();
-	}
-
-	ret = readl_poll_timeout(regs_dbsc_d + DBSC_DBWAIT + 0x4000, val, ((val & BIT(0)) == 0), 1000000);
-	if (ret < 0) {
-		printf("%s DBWAIT + 0x4000 bit 0 timeout\n", __func__);
-		hang();
-	}
+	dbsc5_wait_dbwait(dev);
 
 	dbsc5_reg_write(regs_dbsc_d + DBSC_DBCMD, cmd);
 }
-- 
2.47.2

