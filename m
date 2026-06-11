Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435CFCD8CB9
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 06:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B2580433;
	Thu, 11 Jun 2026 08:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="dxuI/jUv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E85D839A8; Thu, 11 Jun 2026 08:59:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id C253B80086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 08:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21A8B1E4D;
 Wed, 10 Jun 2026 23:59:49 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.129.1])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B82E83FB7F;
 Wed, 10 Jun 2026 23:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781161193; bh=cQ54MobPFKKd8HVlkk7gg3dZX6Ul497P3k/BkxIIIyM=;
 h=From:To:Cc:Subject:Date:From;
 b=dxuI/jUvKvT+TLOAYMz71C2Yo0fDJ9laUr9YndLZHioBV5sOzeGBfWhPnq0E5dO9s
 AMhlIWX2G5VcOM0MJ6J/lcNoDkD8GVyTbNdGGB8XfI8TJ1Vc766PogOPsjoO4ZVFVe
 LZ9M9p40xJClqHnCN32txsibffIJ1tJaEDr/9rVs=
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] efi_selftest: fix use-after-free
Date: Thu, 11 Jun 2026 08:59:50 +0200
Message-ID: <20260611065950.522179-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.53.0
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

When the `memory' efi selftest verifies the Devicetree memory reservation,
it accesses the memory_map buffer after it has been freed with free_pool().
Move the verification earlier to fix this.

Fixes: 34c96659ed57 ("efi_selftest: check fdt is marked as runtime data")
Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_selftest/efi_selftest_memory.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_memory.c b/lib/efi_selftest/efi_selftest_memory.c
index 7320964c129..450470ceedd 100644
--- a/lib/efi_selftest/efi_selftest_memory.c
+++ b/lib/efi_selftest/efi_selftest_memory.c
@@ -155,6 +155,15 @@ static int execute(void)
 			       EFI_RUNTIME_SERVICES_DATA) != EFI_ST_SUCCESS)
 		return EFI_ST_FAILURE;
 
+	/* Check memory reservation for the device tree */
+	if (fdt_addr &&
+	    find_in_memory_map(map_size, memory_map, desc_size, fdt_addr,
+			       EFI_ACPI_RECLAIM_MEMORY) != EFI_ST_SUCCESS) {
+		efi_st_error
+			("Device tree not marked as ACPI reclaim memory\n");
+		return EFI_ST_FAILURE;
+	}
+
 	/* Free memory */
 	ret = boottime->free_pages(p1, EFI_ST_NUM_PAGES);
 	if (ret != EFI_SUCCESS) {
@@ -172,14 +181,6 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 
-	/* Check memory reservation for the device tree */
-	if (fdt_addr &&
-	    find_in_memory_map(map_size, memory_map, desc_size, fdt_addr,
-			       EFI_ACPI_RECLAIM_MEMORY) != EFI_ST_SUCCESS) {
-		efi_st_error
-			("Device tree not marked as ACPI reclaim memory\n");
-		return EFI_ST_FAILURE;
-	}
 	return EFI_ST_SUCCESS;
 }
 
-- 
2.53.0

