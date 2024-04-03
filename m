Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332DACD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 11:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983628823F;
	Wed,  3 Apr 2024 13:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Q9I1UN9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C9F88240; Wed,  3 Apr 2024 13:40:57 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A4008823B
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 13:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id AEEA43F118; 
 Wed,  3 Apr 2024 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712144455;
 bh=7J5h2HX9buNP4SFHzlwyH4PRI5GWElMa4MdEoJzaFb8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Q9I1UN9WFEzMjki9xvdZnPyJrdbkL4/2zzmY8FgLCxaSV25wsHpCmIURCOMt2vaHP
 Cu6Xu1pOlmEnRUBPW35Z+PoxsZXuoO1FB72+U8+v2FzUGejv3d5yacQngGK9y6/ogm
 d2ce5/2Ct/aaK3R6P6r8lt4DT15/YAbnjYNDdeaNJlJ0WjcDq5MbzURNxxpy3MPRDu
 WL6AhKSRPW30ufGygswE1dDz/lUknkXvZ7xZdr7p55U09ESCXz5tuoduBtMaiL9sa7
 5gp8M54NB9azwjILNVsyA4Lccx6PdQl2GMSAaGYig4acLQCkl+v8t6Ga2pYHPZQFpL
 V9BH0xKDPjc6A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Joshua Watt <jpewhacker@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Love Kumar <love.kumar@amd.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] disk: simplify print_part_header()
Date: Wed,  3 Apr 2024 13:40:47 +0200
Message-ID: <20240403114047.84030-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Using uclass_get_name() reduces the code size.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 disk/part.c                | 47 +++-----------------------------------
 test/py/tests/test_scsi.py |  2 +-
 2 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 36b88205eca..65289a31e30 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -14,6 +14,7 @@
 #include <malloc.h>
 #include <part.h>
 #include <ubifs_uboot.h>
+#include <dm/uclass.h>
 
 #undef	PART_DEBUG
 
@@ -305,50 +306,8 @@ static void print_part_header(const char *type, struct blk_desc *desc)
 	CONFIG_IS_ENABLED(ISO_PARTITION) || \
 	CONFIG_IS_ENABLED(AMIGA_PARTITION) || \
 	CONFIG_IS_ENABLED(EFI_PARTITION)
-	puts ("\nPartition Map for ");
-	switch (desc->uclass_id) {
-	case UCLASS_IDE:
-		puts ("IDE");
-		break;
-	case UCLASS_AHCI:
-		puts ("SATA");
-		break;
-	case UCLASS_SCSI:
-		puts ("SCSI");
-		break;
-	case UCLASS_USB:
-		puts ("USB");
-		break;
-	case UCLASS_MMC:
-		puts ("MMC");
-		break;
-	case UCLASS_HOST:
-		puts ("HOST");
-		break;
-	case UCLASS_NVME:
-		puts ("NVMe");
-		break;
-	case UCLASS_PVBLOCK:
-		puts("PV BLOCK");
-		break;
-	case UCLASS_RKMTD:
-		puts("RKMTD");
-		break;
-	case UCLASS_VIRTIO:
-		puts("VirtIO");
-		break;
-	case UCLASS_EFI_MEDIA:
-		puts("EFI");
-		break;
-	case UCLASS_BLKMAP:
-		puts("BLKMAP");
-		break;
-	default:
-		printf("UNKNOWN(%d)", desc->uclass_id);
-		break;
-	}
-	printf (" device %d  --   Partition Type: %s\n\n",
-			desc->devnum, type);
+	printf("\nPartition Map for %s device %d  --   Partition Type: %s\n\n",
+	       uclass_get_name(desc->uclass_id), desc->devnum, type);
 #endif /* any CONFIG_..._PARTITION */
 }
 
diff --git a/test/py/tests/test_scsi.py b/test/py/tests/test_scsi.py
index be2e283e7d2..445693cafd7 100644
--- a/test/py/tests/test_scsi.py
+++ b/test/py/tests/test_scsi.py
@@ -87,6 +87,6 @@ def test_scsi_dev(u_boot_console):
 def test_scsi_part(u_boot_console):
     test_scsi_dev(u_boot_console)
     output = u_boot_console.run_command('scsi part')
-    assert 'Partition Map for SCSI device' in output
+    assert 'Partition Map for scsi device' in output
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
-- 
2.43.0

