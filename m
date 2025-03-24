Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC39C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 08:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B0681F0D;
	Mon, 24 Mar 2025 09:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ED0A81F4E; Mon, 24 Mar 2025 09:34:15 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5827081EDD
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9872A168F;
 Mon, 24 Mar 2025 01:34:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.34.124.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F386A3F58B;
 Mon, 24 Mar 2025 01:34:09 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, Jason Jin <jason.jin@freescale.com>
Subject: [PATCH] ata: ahci: remove bad free
Date: Mon, 24 Mar 2025 09:34:06 +0100
Message-ID: <20250324083406.1536773-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

In the case of a memory allocation error, the ahci_port_start() function
tries to free the `pp' pointer.
This pointer was not dynamically allocated but does in fact point to an
element of the port[] array member of the struct ahci_uc_priv.
Remove the erroneous call to free() to fix this.

Fixes: 4782ac80b02f ("Add AHCI support to u-boot")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Jason Jin <jason.jin@freescale.com>
---
 drivers/ata/ahci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8058d5ff1c3..e593e228685 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -463,7 +463,6 @@ static int ahci_port_start(struct ahci_uc_priv *uc_priv, u8 port)
 
 	mem = memalign(2048, AHCI_PORT_PRIV_DMA_SZ);
 	if (!mem) {
-		free(pp);
 		printf("%s: No mem for table!\n", __func__);
 		return -ENOMEM;
 	}
-- 
2.47.2

