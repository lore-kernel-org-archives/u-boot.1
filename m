Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB08DC36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 22:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF4D81C84;
	Tue, 25 Mar 2025 23:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EbcBUipq";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="neXUAiFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4489C81DCC; Tue, 25 Mar 2025 23:45:08 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68E481C64
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 23:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZMlNn2Wfgz9tY2;
 Tue, 25 Mar 2025 23:44:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BnGkShDFwAc7n0GsiNtfDGVOD0z/tO96q8fdaMNDILE=;
 b=EbcBUipqMQgRIvYi0V8gYylO0Vf01kL7hwkfapdYhk8xb2T4i8V8hIvIaxpl7gLggCzHCS
 /q7GuGRpo8QT8H2oJgKt55REspPfOJ6GXR6luYe5A8LPov0muaWWE2pNylE9pTSsPd3WjM
 nV+bl6ZiUP/RJXszLqOVISD702so3C9QRAqbszhhJ0MQU/kWnjEUTq69wQavxcofqfx6Eq
 CmnJTNkfCM0Lm4kJwElQgvIlmJEVHg0UMb18H2fJkE0XP+Dm/fkUxaU+jahFWhNxt3IonD
 y1kjMLdvl9pDcOBv1XzSQc0zm4wm2ff1jVGaqAZYU/fxO8itD2HmM/mKdTtiaQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BnGkShDFwAc7n0GsiNtfDGVOD0z/tO96q8fdaMNDILE=;
 b=neXUAiFCnFgQg6lANEXrsu1iXchj6h/4aBwfQKSENJ132ox6Tl+csKmQE125744yNmVzdw
 0aCVdF2xqgJxeVgTU/1bgNJW2GwIR3uQkZVGIZ6PdZwBXKvv+AbV2ccl9/sAaZc5opjmEj
 CLNeDclE784lzBkYKzoR1tpgUZbTqYiAHNsks0JFM7R+EK4uUFOfZ//wUkF16eJNDF+omV
 6737w8s4/j97UvGvwZ0hPE+SnQGcSC0hAs65BlUrBEoeyRR2QSK+kHRMfq+UW0muOSCM5f
 5pxjp8Rtih4LcAqU4w+EksH/6uSLPWzmzk+yVc0Jv9qcmT0ODnGW7MX9ZLlpjw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] ram: renesas: dbsc5: Improve dbsc5_send_dbcmd2() signature
Date: Tue, 25 Mar 2025 23:43:31 +0100
Message-ID: <20250325224433.39090-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250325224433.39090-1-marek.vasut+renesas@mailbox.org>
References: <20250325224433.39090-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 66njhz1iefyc6m63bt76koynhifyggfo
X-MBO-RS-ID: b1bea59d1251ea513b0
X-Rspamd-Queue-Id: 4ZMlNn2Wfgz9tY2
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

Update dbsc5_send_dbcmd2() such that it takes multiple parameters
instead of one magic register content value. These parameters are
used to form the same resulting register value internally in the
dbsc5_send_dbcmd2() function, but from well defined input constants.
The new input constants are the operation code, channel, rank, and
operation argument. The argument is operation code specific, therefore
it is still a 16-bit magic number, but the rest of the arguments are
now split up. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 41 ++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index 730ce79605b..461c862ea27 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -1325,6 +1325,11 @@ static const u32 PI_DARRAY3_1_CSx_Fx[CS_CNT][3] = {
 #define DBSC_DBACEN			0x200
 #define DBSC_DBRFEN			0x204
 #define DBSC_DBCMD			0x208
+#define DBSC_DBCMD_CMD_OPCODE_PD	0x8
+#define DBSC_DBCMD_CMD_OPCODE_MRW	0xe
+#define DBSC_DBCMD_CMD_OPCODE_MRR	0xf
+#define DBSC_DBCMD_CMD_CHANNEL_ALL	0x8
+#define DBSC_DBCMD_CMD_RANK_ALL		0x4
 #define DBSC_DBWAIT			0x210
 #define DBSC_DBBL			0x400
 #define DBSC_DBBLA			0x400
@@ -1736,16 +1741,22 @@ static void dbsc5_reg_write(void __iomem *addr, u32 data)
 }
 
 /**
- * dbsc5_reg_write() - DRAM Command Write Access
+ * dbsc5_send_dbcmd2() - DRAM Command Write Access
  * @dev: DBSC5 device
- * @cmd DRAM command.
+ * @opcode DRAM controller opcode
+ * @channel DRAM controller channel (0..3)
+ * @rank DRAM controller rank (0..1)
+ * @arg Command and argument bits (command specific encoding)
  *
  * First, execute the dummy read to DBSC_DBCMD.
  * Confirm that no DBSC command operation is in progress 0.
  * Write the contents of the command to be sent to DRAM.
  */
-static void dbsc5_send_dbcmd2(struct udevice *dev, u32 cmd)
+static void dbsc5_send_dbcmd2(struct udevice *dev, const u8 opcode,
+			      const u8 channel, const u8 rank,
+			      const u16 arg)
 {
+	const u32 cmd = (opcode << 24) | (channel << 20) | (rank << 16) | arg;
 	struct renesas_dbsc5_dram_priv *priv = dev_get_priv(dev);
 	void __iomem *regs_dbsc_d = priv->regs + DBSC5_DBSC_D_OFFSET;
 	u32 val;
@@ -2950,10 +2961,14 @@ static u32 dbsc5_pi_training(struct udevice *dev)
 		writel(0x21, regs_dbsc_d + DBSC_DBDFICNT(ch));
 
 	/* Dummy PDE */
-	dbsc5_send_dbcmd2(dev, 0x8840000);
+	dbsc5_send_dbcmd2(dev, DBSC_DBCMD_CMD_OPCODE_PD,
+			  DBSC_DBCMD_CMD_CHANNEL_ALL,
+			  DBSC_DBCMD_CMD_RANK_ALL, 0);
 
 	/* PDX */
-	dbsc5_send_dbcmd2(dev, 0x8840001);
+	dbsc5_send_dbcmd2(dev, DBSC_DBCMD_CMD_OPCODE_PD,
+			  DBSC_DBCMD_CMD_CHANNEL_ALL,
+			  DBSC_DBCMD_CMD_RANK_ALL, 1);
 
 	/* Wait init_complete */
 	for (retry = 0; retry < retry_max; retry++) {
@@ -4094,7 +4109,9 @@ static u32 dbsc5_read_training(struct udevice *dev)
  */
 static void dbsc5_ddr_register_mr28_set(struct udevice *dev)
 {
-	dbsc5_send_dbcmd2(dev, 0xE841C24);
+	dbsc5_send_dbcmd2(dev, DBSC_DBCMD_CMD_OPCODE_MRW,
+			  DBSC_DBCMD_CMD_CHANNEL_ALL,
+			  DBSC_DBCMD_CMD_RANK_ALL, (28 << 8) | 0x24);
 }
 
 /**
@@ -4111,17 +4128,21 @@ static void dbsc5_ddr_register_mr27_mr57_read(struct udevice *dev)
 		return;
 
 	/* MR27 rank0 */
-	dbsc5_send_dbcmd2(dev, 0xF801B00);
+	dbsc5_send_dbcmd2(dev, DBSC_DBCMD_CMD_OPCODE_MRR,
+			  DBSC_DBCMD_CMD_CHANNEL_ALL, 0, 27 << 8);
 	/* MR57 rank0 */
-	dbsc5_send_dbcmd2(dev, 0xF803900);
+	dbsc5_send_dbcmd2(dev, DBSC_DBCMD_CMD_OPCODE_MRR,
+			  DBSC_DBCMD_CMD_CHANNEL_ALL, 0, 57 << 8);
 
 	if (!priv->ch_have_this_cs[1])
 		return;
 
 	/* MR27 rank1 */
-	dbsc5_send_dbcmd2(dev, 0xF811B00);
+	dbsc5_send_dbcmd2(dev, DBSC_DBCMD_CMD_OPCODE_MRR,
+			  DBSC_DBCMD_CMD_CHANNEL_ALL, 1, 27 << 8);
 	/* MR57 rank1 */
-	dbsc5_send_dbcmd2(dev, 0xF813900);
+	dbsc5_send_dbcmd2(dev, DBSC_DBCMD_CMD_OPCODE_MRR,
+			  DBSC_DBCMD_CMD_CHANNEL_ALL, 1, 57 << 8);
 }
 
 /**
-- 
2.47.2

