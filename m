Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A19D3C935
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 17:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C30D88F01;
	Mon, 21 Oct 2024 19:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AB7388E94; Mon, 21 Oct 2024 19:24:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 61D3A88E94
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 19:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F501DA7;
 Mon, 21 Oct 2024 10:25:12 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41AF13F528;
 Mon, 21 Oct 2024 10:24:41 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH] fdt: lmb: add reserved regions as no-overwrite
Date: Mon, 21 Oct 2024 22:54:33 +0530
Message-Id: <20241021172433.637950-1-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The boot_fdt_add_mem_rsv_regions() function reserves the memreserve and
reserved-memory regions. These regions are being set with the LMB_NONE
flag which allows overwriting and re-using the regions. This was fine
earlier when the LMB memory map was local and not enforced
globally. But that is no longer the case. Mark these regions as
LMB_NOOVERWRITE so that they cannot be used.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reported-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 boot/image-fdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 8eda521693d..9a1fa8840d7 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -110,7 +110,7 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 	for (i = 0; i < total; i++) {
 		if (fdt_get_mem_rsv(fdt_blob, i, &addr, &size) != 0)
 			continue;
-		boot_fdt_reserve_region(addr, size, LMB_NONE);
+		boot_fdt_reserve_region(addr, size, LMB_NOOVERWRITE);
 	}
 
 	/* process reserved-memory */
@@ -122,7 +122,7 @@ void boot_fdt_add_mem_rsv_regions(void *fdt_blob)
 			ret = fdt_get_resource(fdt_blob, subnode, "reg", 0,
 					       &res);
 			if (!ret && fdtdec_get_is_enabled(fdt_blob, subnode)) {
-				flags = LMB_NONE;
+				flags = LMB_NOOVERWRITE;
 				if (fdtdec_get_bool(fdt_blob, subnode,
 						    "no-map"))
 					flags = LMB_NOMAP;
-- 
2.34.1

