Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C008C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 11:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE46C80F4C;
	Sun, 16 Feb 2025 12:13:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kjhG/tpa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 285A880F10; Sun, 16 Feb 2025 12:13:01 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 177D58056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:12:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 92B653FF79; 
 Sun, 16 Feb 2025 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739704376;
 bh=kwQa7dNulqvxOSfMJz7TngjQlhM65jpkw5xJNZQIrgM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kjhG/tpa3MrOpbgfOmbpQ7SuiiZJ+FYKPoSJ78+sUBh0r8QFkyidbkMGmtDo1mu8x
 GvlB8Q6mQS57/LYim7vLHuLrqR4ltHSTE8a2ZhVMoeFa5GH/pe7gzyjs2tqr2gI74m
 UOLUHjh1vF0ic5iTi5D7iwB2Chk0DK8FjRbmLXjUlmtM7JU491Vdo5S5uwJZwxVewi
 R9zQwLNjM+dc6T8Rifk76KdPpaWqsWKc+lRZc4y5za3ilrH0W0M3unHTHblSOlwW2w
 ArYJMUF/u3N5NyEsr36ROD+mY+4VpHYLIjiXMUSjRWuyUJ/nu/WeA+BIY87nrBJCGZ
 iim5BwacT594A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Liya Huang <1425075683@qq.com>, Adriano Cordova <adrianox@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] efi_loader: make efi_add_memory_map_pg() static
Date: Sun, 16 Feb 2025 12:12:41 +0100
Message-ID: <20250216111241.6846-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
References: <20250216111241.6846-1-heinrich.schuchardt@canonical.com>
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

The function is only used in the efi_memory.c module.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_loader.h        | 15 ---------------
 lib/efi_loader/efi_memory.c |  1 +
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index db3d20fd753..1d75d97ebbc 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -852,21 +852,6 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 /* Adds a range into the EFI memory map */
 efi_status_t efi_add_memory_map(u64 start, u64 size, int memory_type);
 
-/**
- * efi_add_memory_map_pg() - add pages to the memory map
- *
- * @start:			start address, must be a multiple of
- *				EFI_PAGE_SIZE
- * @pages:			number of pages to add
- * @memory_type:		type of memory added
- * @overlap_conventional:	region may only overlap free(conventional)
- *				memory
- * Return:			status code
- */
-efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
-				   int memory_type,
-				   bool overlap_conventional);
-
 /* Called by board init to initialize the EFI drivers */
 efi_status_t efi_driver_init(void);
 /* Called when a block device is added */
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 11d092dc289..6d00b186250 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -268,6 +268,7 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
  *				memory
  * Return:			status code
  */
+static
 efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 				   int memory_type,
 				   bool overlap_conventional)
-- 
2.47.1

