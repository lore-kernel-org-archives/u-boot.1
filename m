Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D11CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 11:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0566B8447F;
	Thu,  9 Oct 2025 13:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K8QwrZhP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92EE84505; Thu,  9 Oct 2025 13:59:01 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97769844FD
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 13:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 599BwuKv076967;
 Thu, 9 Oct 2025 06:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760011136;
 bh=DaCeYbBJmn1X9Aa3uh1jlXfgOYptqm3jAkuJNIOzSEc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=K8QwrZhPR3N80Cob/nPOVMLr2wvVfuxDUvoJF7cQuUVHvdiWoAiHzueAZcA9CVf98
 UlyvUT2afq/WPlYHYPjKj3Pvca7PyQFvSit2nV9y3gWKDKeEK1wLsVxgmwjr+M5/Lz
 AVivPwDTq4bzJx6JZipG4+zuKE0e3yD+w9DboY4I=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 599Bwu0l1409782
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 9 Oct 2025 06:58:56 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 9
 Oct 2025 06:58:55 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 06:58:55 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 599Bwsuk4171986;
 Thu, 9 Oct 2025 06:58:55 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 3/3] spl: set fdt address as spl_image arg in falcon mode
Date: Thu, 9 Oct 2025 17:28:45 +0530
Message-ID: <20251009115846.897186-4-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009115846.897186-1-anshuld@ti.com>
References: <20251009115846.897186-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The arg field of `struct spl_image_info` is used by jump_to_image_linux
as the argument for the kernel in falcon mode.

Since commit 601cebc29d2a ("cmd: spl: Remove ATAG support from this
command"), fdt is the only valid argument for kernel in falcon mode.

However fdt was only being set as the argument in nor and xip boot
modes, this patch fixes it for all boot modes and removes the now
redundant code from spl_nor and spl_xip.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl.c     | 1 +
 common/spl/spl_nor.c | 4 ----
 common/spl/spl_xip.c | 1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index f1a1785beef..8c20b75b178 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -800,6 +800,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			fdt = spl_image_fdt_addr(&spl_image);
 		spl_fixup_fdt(fdt);
 		spl_board_prepare_for_linux();
+		spl_image.arg = fdt;
 		jumper = &jump_to_image_linux;
 	} else {
 		debug("Unsupported OS image.. Jumping nevertheless..\n");
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index 6f9ff91bef7..d18cdc07569 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -69,10 +69,6 @@ static int spl_nor_load_image_os(struct spl_image_info *spl_image,
 	       (void *)(CONFIG_SYS_OS_BASE + sizeof(struct legacy_img_hdr)),
 	       spl_image->size);
 
-#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
-	spl_image->arg = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
-#endif
-
 	return 0;
 }
 #endif
diff --git a/common/spl/spl_xip.c b/common/spl/spl_xip.c
index 1465c3e46b9..90b4102a749 100644
--- a/common/spl/spl_xip.c
+++ b/common/spl/spl_xip.c
@@ -14,7 +14,6 @@ static int spl_xip(struct spl_image_info *spl_image,
 {
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	if (!spl_start_uboot()) {
-		spl_image->arg = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
 		spl_image->name = "Linux";
 		spl_image->os = IH_OS_LINUX;
 		spl_image->load_addr = CONFIG_SYS_LOAD_ADDR;
-- 
2.51.0

