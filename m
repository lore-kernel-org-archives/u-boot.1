Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61528C36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 22:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C7BE8192A;
	Tue, 25 Mar 2025 23:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZlWAx+4o";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C3W7NbMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE5981D27; Tue, 25 Mar 2025 23:44:59 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CD98186D
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 23:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZMlNm1DDcz9tHg;
 Tue, 25 Mar 2025 23:44:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LM7got+xDhfgYRBJnCJ6efVHCf078DZt5Hb4zxm9u90=;
 b=ZlWAx+4okWKQIbZQ8kMV0NMwWE69/lYXuppCKtObBbOvEPUpYbLdGEdpbhVA/zVaRfJt/j
 uhuUwoiePI+maXcJ+VjZZP4VCwLvSF6i6LQwVZA31bQe7Y6FH+LDxF7pz2eKRPQjQdDIis
 BiqDTmyTpO04Nip3gJ8FigRL/seeWDEpvYIWBtgNMZ3DPQX6RUxqC+qw5BMw2jjhvCOMyr
 7rfOjJ9E0L3RMtzb375nLQ49jw5Bus/RljMW93uFgdwRQXEdIcfjLRmcX+WxAjiGCcog4F
 5COx7AoMBiTdQ3qjRlN2p6mhFpSYhM1xOiYuyNq11CIC6OobACnTbBxNllJGaw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LM7got+xDhfgYRBJnCJ6efVHCf078DZt5Hb4zxm9u90=;
 b=C3W7NbMybaBuoT+O4wST7jV794XSIcAabRmAD2OBXUW93BPSiZgpWs2LUzllZUOfatK1TW
 R6jAWHaGpVsJkM9GahYVqDAQULtcnQ9u5Pp3Sff2uLEVYoiYCc47gvViimw5E+3inYbZdL
 SY4ugCBZznc+wuEV4BxiJeT7oMEkIZeFdJsOiVDON9CbLq36QSgrdR1haq8KTlG5vajyjy
 ceA1fRlC3Myt0XM1GIsMEk98wuTIprFy7KRrbv3k1hhiPRQ4E7u7J+YpGhRqSKEPKH3pKY
 3S6mPuD7g02UUS89h/4Pd73p4XlmyxJ6UFu8B33v+8TZdN8YsiJKCAgCU2s9TA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] ram: renesas: dbsc5: Clarify MR27/MR28/MR57 register
 operations
Date: Tue, 25 Mar 2025 23:43:29 +0100
Message-ID: <20250325224433.39090-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: stmf3x91mabm9cppq86m4ydtpejb8e6o
X-MBO-RS-ID: ede37d9bc839db7c1d6
X-Rspamd-Queue-Id: 4ZMlNm1DDcz9tHg
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

Rename dbsc5_ddr_register_read() to dbsc5_ddr_register_mr27_mr57_read()
and dbsc5_ddr_register_set() to dbsc5_ddr_register_mr28_set() to make
it clear what those functions really do. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index 6f78afb0ab5..e0c4e5fe6c0 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -4085,25 +4085,25 @@ static u32 dbsc5_read_training(struct udevice *dev)
 }
 
 /**
- * dbsc5_ddr_register_set() - DDR mode register setting
+ * dbsc5_ddr_register_mr28_set() - DDR mode register MR28 set
  * @dev: DBSC5 device
  *
  * Set the mode register 28 of the SDRAM.
  * ZQ Mode: Command-Based ZQ Calibration
  * ZQ interval: Background Cal Interval < 64ms
  */
-static void dbsc5_ddr_register_set(struct udevice *dev)
+static void dbsc5_ddr_register_mr28_set(struct udevice *dev)
 {
 	dbsc5_send_dbcmd2(dev, 0xE841C24);
 }
 
 /**
- * dbsc5_ddr_register_read() - DDR mode register read
+ * dbsc5_ddr_register_mr27_mr57_read() - DDR mode register MR27/MR57 read
  * @dev: DBSC5 device
  *
  * Set the mode register 27 and 57 of the SDRAM.
  */
-static void dbsc5_ddr_register_read(struct udevice *dev)
+static void dbsc5_ddr_register_mr27_mr57_read(struct udevice *dev)
 {
 	struct renesas_dbsc5_dram_priv *priv = dev_get_priv(dev);
 
@@ -4278,10 +4278,10 @@ static u32 dbsc5_init_ddr(struct udevice *dev)
 
 	/* setup DDR mode registers */
 	/* MRS */
-	dbsc5_ddr_register_set(dev);
+	dbsc5_ddr_register_mr28_set(dev);
 
 	/* MRR */
-	dbsc5_ddr_register_read(dev);
+	dbsc5_ddr_register_mr27_mr57_read(dev);
 
 	/* training complete, setup DBSC */
 	dbsc5_dbsc_regset_post(dev);
-- 
2.47.2

