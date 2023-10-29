Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B533C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 07:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948E08723E;
	Sun, 29 Oct 2023 08:23:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="TVpHCDED";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F16687211; Sun, 29 Oct 2023 08:23:50 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157708711D
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 08:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id B584942657;
 Sun, 29 Oct 2023 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698564227; bh=Kz85rg26Atuqv8E74ZJdlykEf51f3XpmmMYLAGVnYks=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TVpHCDEDGGUgImY3Kl+DoBGRDkfT0R0drf0BhCJw4Lzz8Nrza9ZPupWGMrPvQjYW4
 iNIXFwM6miGmRb3PMBo2DeZLbAM82PtntiT5ccQjcLYDLBEh+ZeDnTtTWIYwpsjR3x
 P2vhR7FsvxPamHT53MFSO7WzVNSMVrUd6sYMM1lr/XgghXQScrWBxKOen9QPwqgHWF
 BtFogjkQoavnigTgFaZHMn/Cs/s+t7EbREO/6qtiDo+q4ydXNDSFUH8mhKhvDKxefC
 SKvzDBY1XiIX/OC0HD8XGtfA9WnO2oExf+wDb9fgth0YbkhX2WyxJOTw6rPTzJCIaQ
 nEEQWy6xyKzgQ==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 16:23:28 +0900
Subject: [PATCH 1/4] scsi: Fix a bunch of SCSI definitions.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-3-v1-1-0153210a7f55@marcan.st>
References: <20231029-usb-fixes-3-v1-0-0153210a7f55@marcan.st>
In-Reply-To: <20231029-usb-fixes-3-v1-0-0153210a7f55@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3671; i=marcan@marcan.st;
 h=from:subject:message-id; bh=Kz85rg26Atuqv8E74ZJdlykEf51f3XpmmMYLAGVnYks=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlQ7jpo3hjOidng/etxrMfnknW+bd8k8XnX1obiLa0Oig
 Z/BTt3yjlIWBjEOBlkxRZbGE72nuj2nn1NXTZkOM4eVCWQIAxenAEzkdwQjQ/MqldslR+UL7J2n
 SS98sU5V00BIO+L4zsq3P5c3rva8cIORYfuR649bZ+8WPrZBclI1x60ZfybOf1r/Nd9W/kMF9zL
 mG7wA
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
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

0x9e isn't Read Capacity, it's a service action and the read capacity
command is a subcommand.

READ16 is not 0x48, it's 0x88. 0x48 is SANITIZE and that sounds like we
might have been destroying data instead of reading data. No bueno.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/ata/ahci.c  | 9 ++++++---
 drivers/scsi/scsi.c | 4 ++--
 include/scsi.h      | 8 ++++++--
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 2062197afcd3..b252e9e525db 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -906,15 +906,18 @@ static int ahci_scsi_exec(struct udevice *dev, struct scsi_cmd *pccb)
 	case SCSI_RD_CAPAC10:
 		ret = ata_scsiop_read_capacity10(uc_priv, pccb);
 		break;
-	case SCSI_RD_CAPAC16:
-		ret = ata_scsiop_read_capacity16(uc_priv, pccb);
-		break;
 	case SCSI_TST_U_RDY:
 		ret = ata_scsiop_test_unit_ready(uc_priv, pccb);
 		break;
 	case SCSI_INQUIRY:
 		ret = ata_scsiop_inquiry(uc_priv, pccb);
 		break;
+	case SCSI_SRV_ACTION_IN:
+		if ((pccb->cmd[1] & 0x1f) == SCSI_SAI_RD_CAPAC16) {
+			ret = ata_scsiop_read_capacity16(uc_priv, pccb);
+			break;
+		}
+		/* Fallthrough */
 	default:
 		printf("Unsupport SCSI command 0x%02x\n", pccb->cmd[0]);
 		return -ENOTSUPP;
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index d7b33010e469..f2c828eb305e 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -380,8 +380,8 @@ static int scsi_read_capacity(struct udevice *dev, struct scsi_cmd *pccb,
 
 	/* Read capacity (10) was insufficient. Use read capacity (16). */
 	memset(pccb->cmd, '\0', sizeof(pccb->cmd));
-	pccb->cmd[0] = SCSI_RD_CAPAC16;
-	pccb->cmd[1] = 0x10;
+	pccb->cmd[0] = SCSI_SRV_ACTION_IN;
+	pccb->cmd[1] = SCSI_SAI_RD_CAPAC16;
 	pccb->cmdlen = 16;
 	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
 
diff --git a/include/scsi.h b/include/scsi.h
index b47c7463c1d6..89e268586477 100644
--- a/include/scsi.h
+++ b/include/scsi.h
@@ -141,10 +141,9 @@ struct scsi_cmd {
 #define SCSI_MED_REMOVL	0x1E		/* Prevent/Allow medium Removal (O) */
 #define SCSI_READ6		0x08		/* Read 6-byte (MANDATORY) */
 #define SCSI_READ10		0x28		/* Read 10-byte (MANDATORY) */
-#define SCSI_READ16	0x48
+#define SCSI_READ16	0x88		/* Read 16-byte */
 #define SCSI_RD_CAPAC	0x25		/* Read Capacity (MANDATORY) */
 #define SCSI_RD_CAPAC10	SCSI_RD_CAPAC	/* Read Capacity (10) */
-#define SCSI_RD_CAPAC16	0x9e		/* Read Capacity (16) */
 #define SCSI_RD_DEFECT	0x37		/* Read Defect Data (O) */
 #define SCSI_READ_LONG	0x3E		/* Read Long (O) */
 #define SCSI_REASS_BLK	0x07		/* Reassign Blocks (O) */
@@ -158,15 +157,20 @@ struct scsi_cmd {
 #define SCSI_SEEK10		0x2B		/* Seek 10-Byte (O) */
 #define SCSI_SEND_DIAG	0x1D		/* Send Diagnostics (MANDATORY) */
 #define SCSI_SET_LIMIT	0x33		/* Set Limits (O) */
+#define SCSI_SRV_ACTION_IN	0x9E	/* Service Action In */
+#define SCSI_SRV_ACTION_OUT	0x9F	/* Service Action Out */
 #define SCSI_START_STP	0x1B		/* Start/Stop Unit (O) */
 #define SCSI_SYNC_CACHE	0x35		/* Synchronize Cache (O) */
 #define SCSI_VERIFY		0x2F		/* Verify (O) */
 #define SCSI_WRITE6		0x0A		/* Write 6-Byte (MANDATORY) */
 #define SCSI_WRITE10	0x2A		/* Write 10-Byte (MANDATORY) */
+#define SCSI_WRITE16	0x8A		/* Write 16-byte */
 #define SCSI_WRT_VERIFY	0x2E		/* Write and Verify (O) */
 #define SCSI_WRITE_LONG	0x3F		/* Write Long (O) */
 #define SCSI_WRITE_SAME	0x41		/* Write Same (O) */
 
+#define SCSI_SAI_RD_CAPAC16	0x10	/* Service Action: Read Capacity (16) */
+
 /**
  * struct scsi_plat - stores information about SCSI controller
  *

-- 
2.41.0

