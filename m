Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86E4C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8FEE88C3A;
	Sat, 20 Jul 2024 14:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xqpG+0XW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vYGnAzYs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC3088C4B; Sat, 20 Jul 2024 14:43:45 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE9388C37
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WR5nW19Tvz9sd6;
 Sat, 20 Jul 2024 14:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZM4cs5ffrsL3BzGAM6VH8/Kn9+WWIYQLDm5AIBE2oU=;
 b=xqpG+0XWk+3rMqQhm0Z0NNqLxBQ72Of48GzlWqKP5oCGvN+OXzXXbF0GbJxYD0o7PunZkt
 tmsuiotMSOFlM5FkelC7D5JwLuyH2tfWgnV1TxfZGuhRUhYhpw8FaEu8XNmGhYN6j6qwnw
 CyfvsfvlMpHi4NOXluZJjNg6kuhQB40Dr1x4vRMarlh87/vBJIMgfKBe2Ya4JXkzTUpghc
 JVlSUtLkuP1QxZvTV7wXW8WCJy2gvXPtMPHdCjy379XhBbUXoCwOPXlDqxjJO8eB/6vhw9
 T109bc0e2lY9VbU1syYBFv2iKAnwkyzG3FaOYuBNE5VjQDgMKZhg5durNJykWg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZM4cs5ffrsL3BzGAM6VH8/Kn9+WWIYQLDm5AIBE2oU=;
 b=vYGnAzYsCIk9v0EWbCU1M3z4Ljy/aom2FCVgjdKrgUwTcEVaclORgRPrkkRRMrtoOpLpV5
 W6f2bJnyf81AAzcfuK6hGnrJ6PZhOKH9NLnX4bech8pcnmyf5weuxOtNXfUyH0MGJowfbR
 AXvYu3SE7jNG0xdmAcxKj750uy7lGNDCMpH4j4EnOnwxQCGhIoyO528BUCVNDJVRSyUled
 evQsuiI8y5whXRkt6GMOVV/9mgKmECWZGzx6xeQ7x2uWLn6jCN8oLNCEduYPKLQw9YjVgA
 q/owUGBtZ5mNfTI3985XR2ALqqwWmSGso2stP8FfkF0eQljfm7Z29BT8v7D5YQ==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 12/40] drivers: fpga: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:37 +0200
Message-ID: <20240720124239.7553-12-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: afa389ee9602cec412e
X-MBO-RS-META: iqpur1gr5b7o7b93adr7m33jbp8spc63
X-Rspamd-Queue-Id: 4WR5nW19Tvz9sd6
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
 drivers/fpga/ACEX1K.c   | 1 -
 drivers/fpga/fpga.c     | 1 -
 drivers/fpga/ivm_core.c | 1 -
 drivers/fpga/lattice.c  | 1 -
 drivers/fpga/spartan2.c | 2 --
 drivers/fpga/spartan3.c | 2 --
 6 files changed, 8 deletions(-)

diff --git a/drivers/fpga/ACEX1K.c b/drivers/fpga/ACEX1K.c
index cb7877a8afe..3de9011ac06 100644
--- a/drivers/fpga/ACEX1K.c
+++ b/drivers/fpga/ACEX1K.c
@@ -79,7 +79,6 @@ int ACEX1K_info( Altera_desc *desc )
 	return FPGA_SUCCESS;
 }
 
-
 /* ------------------------------------------------------------------------- */
 /* ACEX1K Passive Serial Generic Implementation                                  */
 
diff --git a/drivers/fpga/fpga.c b/drivers/fpga/fpga.c
index 38ba6c21ea2..1f6782537de 100644
--- a/drivers/fpga/fpga.c
+++ b/drivers/fpga/fpga.c
@@ -30,7 +30,6 @@ static void fpga_no_sup(char *fn, char *msg)
 		printf("No FPGA support!\n");
 }
 
-
 /* fpga_get_desc
  *	map a device number to a descriptor
  */
diff --git a/drivers/fpga/ivm_core.c b/drivers/fpga/ivm_core.c
index b9cecdd8720..3c9a01e5110 100644
--- a/drivers/fpga/ivm_core.c
+++ b/drivers/fpga/ivm_core.c
@@ -580,7 +580,6 @@ void ispVMFreeMem(void)
 	}
 }
 
-
 /*
  *
  * ispVMDataSize
diff --git a/drivers/fpga/lattice.c b/drivers/fpga/lattice.c
index 036580cad70..3f481e38565 100644
--- a/drivers/fpga/lattice.c
+++ b/drivers/fpga/lattice.c
@@ -35,7 +35,6 @@ extern unsigned short g_usIntelDataIndex;
 extern unsigned short g_usIntelBufferSize;
 extern char *const g_szSupportedVersions[];
 
-
 /*
  * ispVMDelay
  *
diff --git a/drivers/fpga/spartan2.c b/drivers/fpga/spartan2.c
index 9cd6cb7f0fb..906649ea181 100644
--- a/drivers/fpga/spartan2.c
+++ b/drivers/fpga/spartan2.c
@@ -85,7 +85,6 @@ static int spartan2_info(xilinx_desc *desc)
 	return FPGA_SUCCESS;
 }
 
-
 /* ------------------------------------------------------------------------- */
 /* Spartan-II Slave Parallel Generic Implementation */
 
@@ -285,7 +284,6 @@ static int spartan2_sp_dump(xilinx_desc *desc, const void *buf, size_t bsize)
 	return ret_val;
 }
 
-
 /* ------------------------------------------------------------------------- */
 
 static int spartan2_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
diff --git a/drivers/fpga/spartan3.c b/drivers/fpga/spartan3.c
index b4d87d47d93..98405589134 100644
--- a/drivers/fpga/spartan3.c
+++ b/drivers/fpga/spartan3.c
@@ -91,7 +91,6 @@ static int spartan3_info(xilinx_desc *desc)
 	return FPGA_SUCCESS;
 }
 
-
 /* ------------------------------------------------------------------------- */
 /* Spartan-II Slave Parallel Generic Implementation */
 
@@ -293,7 +292,6 @@ static int spartan3_sp_dump(xilinx_desc *desc, const void *buf, size_t bsize)
 	return ret_val;
 }
 
-
 /* ------------------------------------------------------------------------- */
 
 static int spartan3_ss_load(xilinx_desc *desc, const void *buf, size_t bsize)
-- 
2.43.0

