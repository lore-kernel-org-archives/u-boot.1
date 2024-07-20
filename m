Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88E6C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2337D886F0;
	Sat, 20 Jul 2024 14:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wODLPL7X";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yJrvLw/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 786BE88675; Sat, 20 Jul 2024 14:43:35 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66FAC883BA
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nK0HKgz9sd6;
 Sat, 20 Jul 2024 14:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cVLTcy62TkCha84BXvANd90T+SFYW8x60y4PwubSJ1M=;
 b=wODLPL7X8UMo3qkJOO6L8Nmybgq6cguq3J9HMRy/7u2CSBnrmyZjH2XdBsEBSDXOy8eL8c
 6QzPc5EOE6jLtGFksVUGlzDtWqyGq/dcAvH3n+n37zwk0xfhHaB1eAMqYqEBqEZDfNRYvA
 YSscdo6H2zPI7kde/1L0tygd1LqJk4d8v8h3l6Y/ExhS0KkofItRUEbaW7iTZtRAg0tdsC
 +SPodZIXAeOeYfmvjz19E08qU/xwYUilQvwz9ctHNdniCp02Bh8aL3rAD5AGwb/LXuV2Aw
 +ffpFNs91wKBSWKI1WKQ5iE3OD/iuX2QihXlA6UVwpGuixiDENORo/6Ow73vsA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cVLTcy62TkCha84BXvANd90T+SFYW8x60y4PwubSJ1M=;
 b=yJrvLw/QLcgYv5/cl0sZ9ct8n+lRGqsCxtoWWvGq/+NC7/jeslvlVdqik/zZViN57dIevN
 XHy0AA5puiQ/RG0WDBw1W1b7xKPt+PbIQTGaEaSIBaKCVWe7EZ5YazzFg5GZWrrdnaOyHs
 MZMTc7s3PDTvOkmZCHjrCUQe0sYbsskwYFXqp0/TtryJ+JHiGkp2pEtaVZvskLFRmkypZ+
 j+9xBtO+iPpyANnKdeb8OCF85dByMgfoLaoWGO5QhiJOUsJd46+A4wN0erCDstF6fb0DF0
 GoT9n8jYQZy1fw6Rq9jR70A4xpgAk1zruzqheZJjpyALbrMN0BYoj8t2n0iv2Q==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 01/40] drivers: ata: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:26 +0200
Message-ID: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c794f043b7867c4ceaa
X-MBO-RS-META: 4df6yhmozxahxu7x8iioafnofxuqpejs
X-Rspamd-Queue-Id: 4WR5nK0HKgz9sd6
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
 drivers/ata/ahci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ac869296d52..8058d5ff1c3 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -294,7 +294,6 @@ static int ahci_host_init(struct ahci_uc_priv *uc_priv)
 	return 0;
 }
 
-
 static void ahci_print_info(struct ahci_uc_priv *uc_priv)
 {
 	void __iomem *mmio = uc_priv->mmio_base;
@@ -520,7 +519,6 @@ static int ahci_port_start(struct ahci_uc_priv *uc_priv, u8 port)
 	return wait_spinup(port_mmio);
 }
 
-
 static int ahci_device_data_io(struct ahci_uc_priv *uc_priv, u8 port, u8 *fis,
 			       int fis_len, u8 *buf, int buf_len, u8 is_write)
 {
@@ -647,7 +645,6 @@ static int ata_scsiop_inquiry(struct ahci_uc_priv *uc_priv,
 	return 0;
 }
 
-
 /*
  * SCSI READ10/WRITE10 command operation.
  */
@@ -759,7 +756,6 @@ static int ata_scsiop_read_write(struct ahci_uc_priv *uc_priv,
 	return 0;
 }
 
-
 /*
  * SCSI READ CAPACITY10 command operation.
  */
@@ -790,7 +786,6 @@ static int ata_scsiop_read_capacity10(struct ahci_uc_priv *uc_priv,
 	return 0;
 }
 
-
 /*
  * SCSI READ CAPACITY16 command operation.
  */
@@ -817,7 +812,6 @@ static int ata_scsiop_read_capacity16(struct ahci_uc_priv *uc_priv,
 	return 0;
 }
 
-
 /*
  * SCSI TEST UNIT READY command operation.
  */
@@ -827,7 +821,6 @@ static int ata_scsiop_test_unit_ready(struct ahci_uc_priv *uc_priv,
 	return (uc_priv->ataid[pccb->target]) ? 0 : -EPERM;
 }
 
-
 static int ahci_scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
 {
 	struct ahci_uc_priv *uc_priv = dev_get_uclass_priv(dev->parent);
-- 
2.43.0

