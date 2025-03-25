Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D38C36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 22:45:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593F781E14;
	Tue, 25 Mar 2025 23:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Uxgsl3lZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="H+QRW6E5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E6281DCA; Tue, 25 Mar 2025 23:45:05 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1E081CFD
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 23:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZMlNp4G4bz9v55;
 Tue, 25 Mar 2025 23:44:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgjilZV9FN1E6A5gF3EJm+Y3BD+kKFf1sxMzio/RqQk=;
 b=Uxgsl3lZMw/AzTUVbAIEjGxfHohK7zjRVz6bSFjZfNvk12ATyHmSKZwrZvkDpm/SYRNM5J
 cRfixnyEUYa7zctH+SGgJNgaqJH4wnW4wWwUYnm4DKJWfMvB0OA0V/8RkjvzjTnUk7+3/m
 VBjwFJwa331+VC/vWyw0+JsldtxZyX8w8+G7SMZhqifuCHk3Kd9LOcrym89r1dvPzGP3t6
 ekvSNJSp8cuSHCspXVth6ROb9yhryDFicGN0fnI0eF8yoLOcrltgy1MW5GbZmFO2qK4IZ7
 CQf72WLpEOFXvtUrVftomQgjoUigCLeUFQOdwYLnkYn44++S9qDbYdoiAZS5rw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742942696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GgjilZV9FN1E6A5gF3EJm+Y3BD+kKFf1sxMzio/RqQk=;
 b=H+QRW6E5B+QI2xViBFI4MR8gVdSFy3GakCZDugtb40k+ThKgSmAlrK/lQq91QJQ+KVvQ+2
 2D46dlUmQenQ1VBOAtFx73hQFzKGtQNFpRjHBEWi74S1LoTG5UJdiuq4jMKpS5J49bqUAt
 kjGRo79eSpmBHk+vTV8+qW01C2F5oVv+9FZpoqQRup2bf9YDtp6HFa5+36d4LMZ0J1D3k0
 EGVSqRfzoTkRCv1782+0DQxL3drmIwQWf+jXbPeeWqG6eU73BAxjndbzLI++/GQnjMilE5
 S759D9yEa3/DAQYyE9m10M6Kw0OM6vHqfgpOfSdhVWt+0Ip3S41vpjBKw79Vhw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] ram: renesas: dbsc5: Pass udevice and MODEMR0 to
 dbsc5_get_board_data()
Date: Tue, 25 Mar 2025 23:43:33 +0100
Message-ID: <20250325224433.39090-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250325224433.39090-1-marek.vasut+renesas@mailbox.org>
References: <20250325224433.39090-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: d85ecdea5acd004e849
X-MBO-RS-META: uhqchdej9qtpisw17ko9otydcu6bewdu
X-Rspamd-Queue-Id: 4ZMlNp4G4bz9v55
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

Pass DBSC5 udevice and MODEMR0 register values to board specific
function dbsc5_get_board_data(). The board specific implementation
of dbsc5_get_board_data() can return struct renesas_dbsc5_board_config
which matches the board based on the content of MODEMR0 or content
of DT accessible via the udevice.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/ram/renesas/dbsc5/dram.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/renesas/dbsc5/dram.c b/drivers/ram/renesas/dbsc5/dram.c
index ce04dd58180..ca8a7fb4783 100644
--- a/drivers/ram/renesas/dbsc5/dram.c
+++ b/drivers/ram/renesas/dbsc5/dram.c
@@ -4333,10 +4333,13 @@ static u32 dbsc5_init_ddr(struct udevice *dev)
 
 /**
  * dbsc5_get_board_data() - Obtain board specific DRAM configuration
+ * @dev: DBSC5 device
+ * @modemr0: MODEMR0 register content
  *
  * Return board specific DRAM configuration structure pointer.
  */
-__weak const struct renesas_dbsc5_board_config *dbsc5_get_board_data(void)
+__weak const struct renesas_dbsc5_board_config *
+dbsc5_get_board_data(struct udevice *dev, const u32 modemr0)
 {
 	return &renesas_v4h_dbsc5_board_config;
 }
@@ -4372,7 +4375,7 @@ static int renesas_dbsc5_dram_probe(struct udevice *dev)
 	u32 ch, cs;
 
 	/* Get board data */
-	priv->dbsc5_board_config = dbsc5_get_board_data();
+	priv->dbsc5_board_config = dbsc5_get_board_data(dev, modemr0);
 	priv->ddr_phyvalid = (u32)(priv->dbsc5_board_config->bdcfg_phyvalid);
 	priv->max_density = 0;
 	priv->cpg_regs = (void __iomem *)ofnode_get_addr(cnode);
-- 
2.47.2

