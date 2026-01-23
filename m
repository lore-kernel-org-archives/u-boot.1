Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745A1D72372
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 11:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56CA583B0B;
	Fri, 23 Jan 2026 12:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NrGyqZXf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A829E83B91; Fri, 23 Jan 2026 12:45:51 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0CF483B82
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 12:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 5BEB91A2B38;
 Fri, 23 Jan 2026 11:45:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 315ED6070A;
 Fri, 23 Jan 2026 11:45:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B55E119A87BE; Fri, 23 Jan 2026 12:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1769168747; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=mYjbOgzN39N9J7SLGiDDcHMQS3ieStCc8zpGjvxq/Lg=;
 b=NrGyqZXfKHAUcinlwK72z8md79Fe9lCG0LA1ROBmIcVdEatyDPXnpm58rV8P+X/3eO2/rT
 IHh+4EmooLTEVCl63bgXzRywP884z+xBnkNPmWDZazUUyTytj9o1X9LoxcZg0xiAfyiK/P
 P04RrLXI6KY/sNVbImiRk4nCRPaYCuh/moyHMFicPhm0oxBhQ69mc4w+8UMa3eFWicuX7B
 uWwavs3NjAiIHMJivrW+FaqRJWUKKoR65fIS8Foi25KPXnOjU2EOjVNggTcB/EzAiBV5j5
 rd43v0lAoq4hDfV3Pp57WxhAXMTt0bvuoypcuNWtWOneGi63cUZ6r06jDiIyGw==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 04/26] mtd: rawnand: sunxi_spl: cosmetic: use definitions
 from linux/mtd/rawnand.h
Date: Fri, 23 Jan 2026 12:44:39 +0100
Message-ID: <20260123114507.1400918-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123114507.1400918-1-richard.genoud@bootlin.com>
References: <20260123114507.1400918-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Remove unneeded definitions NFC_CMD_R* in sunxi_nand_spl.c

No need to define NFC_CMD_RNDOUTSTART, NFC_CMD_RNDOUT and
NFC_CMD_READSTART here since they are already in linux/mtd/rawnand.h

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 drivers/mtd/nand/raw/sunxi_nand_spl.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand_spl.c b/drivers/mtd/nand/raw/sunxi_nand_spl.c
index a4a73dcf8d09..bd6fcd07be50 100644
--- a/drivers/mtd/nand/raw/sunxi_nand_spl.c
+++ b/drivers/mtd/nand/raw/sunxi_nand_spl.c
@@ -62,10 +62,6 @@
 #define NFC_RND_READ_CMD0_OFFSET    8
 #define NFC_RND_READ_CMD1_OFFSET    16
 
-#define NFC_CMD_RNDOUTSTART        0xE0
-#define NFC_CMD_RNDOUT             0x05
-#define NFC_CMD_READSTART          0x30
-
 struct nfc_config {
 	int page_size;
 	int ecc_strength;
@@ -199,9 +195,9 @@ static int nand_load_page(const struct nfc_config *conf, u32 offs)
 {
 	int page = offs / conf->page_size;
 
-	writel((NFC_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
-	       (NFC_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
-	       (NFC_CMD_READSTART << NFC_READ_CMD_OFFSET),
+	writel((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
+	       (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
+	       (NAND_CMD_READSTART << NFC_READ_CMD_OFFSET),
 	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
 	writel(((page & 0xFFFF) << 16), SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
 	writel((page >> 16) & 0xFF, SUNXI_NFC_BASE + NFC_REG_ADDR_HIGH);
@@ -215,15 +211,15 @@ static int nand_change_column(u16 column)
 {
 	int ret;
 
-	writel((NFC_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
-	       (NFC_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
-	       (NFC_CMD_RNDOUTSTART << NFC_READ_CMD_OFFSET),
+	writel((NAND_CMD_RNDOUTSTART << NFC_RND_READ_CMD1_OFFSET) |
+	       (NAND_CMD_RNDOUT << NFC_RND_READ_CMD0_OFFSET) |
+	       (NAND_CMD_RNDOUTSTART << NFC_READ_CMD_OFFSET),
 	       SUNXI_NFC_BASE + NFC_REG_RCMD_SET);
 	writel(column, SUNXI_NFC_BASE + NFC_REG_ADDR_LOW);
 
 	ret = nand_exec_cmd(NFC_SEND_CMD1 | NFC_SEND_CMD2 | NFC_NORMAL_OP |
 			    (1 << NFC_ADR_NUM_OFFSET) | NFC_SEND_ADR |
-			    NFC_CMD_RNDOUT);
+			    NAND_CMD_RNDOUT);
 	if (ret)
 		return ret;
 
-- 
2.47.3

