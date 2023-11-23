Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61321C5AD4C
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 17:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF2FE87650;
	Thu, 23 Nov 2023 18:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA104874E0; Thu, 23 Nov 2023 18:15:32 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9640E874E0
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 18:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=foss.arm.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=robert.catherall@foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81A3BFEC;
 Thu, 23 Nov 2023 09:16:16 -0800 (PST)
Received: from e123340-lin.cambridge.arm.com (e123340-lin.cambridge.arm.com
 [10.2.75.62])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872853F7A6;
 Thu, 23 Nov 2023 09:15:29 -0800 (PST)
From: robert.catherall@foss.arm.com
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com
Subject: [PATCH] arm: afs: Set the filesize env. var. on load
Date: Thu, 23 Nov 2023 17:15:22 +0000
Message-Id: <20231123171522.7302-1-robert.catherall@foss.arm.com>
X-Mailer: git-send-email 2.17.1
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

From: Robert Catherall <robert.catherall@arm.com>

The `afs load` command copies data to RAM. Set the filesize
environment variable to record how much data was 'loaded'

Signed-off-by: Robert Catherall <robert.catherall@arm.com>
---
 cmd/armflash.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/cmd/armflash.c b/cmd/armflash.c
index d1466f73aa..fdaea5ad81 100644
--- a/cmd/armflash.c
+++ b/cmd/armflash.c
@@ -180,6 +180,7 @@ static int load_image(const char * const name, const ulong address)
 {
 	struct afs_image *afi = NULL;
 	int i;
+	loff_t len_read = 0;
 
 	parse_flash();
 	for (i = 0; i < num_afs_images; i++) {
@@ -197,6 +198,7 @@ static int load_image(const char * const name, const ulong address)
 
 	for (i = 0; i < afi->region_count; i++) {
 		ulong from, to;
+		u32 size;
 
 		from = afi->flash_mem_start + afi->regions[i].offset;
 		if (address) {
@@ -208,14 +210,20 @@ static int load_image(const char * const name, const ulong address)
 			return CMD_RET_FAILURE;
 		}
 
-		memcpy((void *)to, (void *)from, afi->regions[i].size);
+		size = afi->regions[i].size;
+		memcpy((void *)to, (void *)from, size);
 
 		printf("loaded region %d from %08lX to %08lX, %08X bytes\n",
 		       i,
 		       from,
 		       to,
-		       afi->regions[i].size);
+		       size);
+
+		len_read += size;
 	}
+
+	env_set_hex("filesize", len_read);
+
 	return CMD_RET_SUCCESS;
 }
 
-- 
2.17.1

