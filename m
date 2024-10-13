Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6E9CF2576
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 10:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21A5F88F16;
	Sun, 13 Oct 2024 12:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D371288F1E; Sun, 13 Oct 2024 12:56:05 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D69BC88F0C
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 12:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C94991007;
 Sun, 13 Oct 2024 03:56:32 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A31933F71E;
 Sun, 13 Oct 2024 03:56:00 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 07/15] efi_memory: do not add U-Boot memory to the memory
 map
Date: Sun, 13 Oct 2024 16:25:14 +0530
Message-Id: <20241013105522.391414-8-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241013105522.391414-1-sughosh.ganu@linaro.org>
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
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

The memory region occupied by U-Boot is reserved by LMB, and gets
added to the EFI memory map through a call from the LMB module. Remove
this superfluous addition to the EFI memory map.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: New patch

 lib/efi_loader/efi_memory.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 41501e9d41..16e64987af 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -870,16 +870,6 @@ static void add_u_boot_and_runtime(void)
 {
 	unsigned long runtime_start, runtime_end, runtime_pages;
 	unsigned long runtime_mask = EFI_PAGE_MASK;
-	unsigned long uboot_start, uboot_pages;
-	unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
-
-	/* Add U-Boot */
-	uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
-		       uboot_stack_size) & ~EFI_PAGE_MASK;
-	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
-		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
-	efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
-			      false);
 
 #if defined(__aarch64__)
 	/*
-- 
2.34.1

