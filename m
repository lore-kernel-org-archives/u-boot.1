Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DADC28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 11:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3273581668;
	Mon, 10 Mar 2025 12:58:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028CE811DF; Mon, 10 Mar 2025 12:58:16 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B8CE28142D
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 12:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86CB01516;
 Mon, 10 Mar 2025 04:58:24 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 350543F5A1;
 Mon, 10 Mar 2025 04:58:09 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v7 2/8] efi_loader: install device-tree on configuration table
 on every invocation
Date: Mon, 10 Mar 2025 17:27:44 +0530
Message-Id: <20250310115750.1019051-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310115750.1019051-1-sughosh.ganu@linaro.org>
References: <20250310115750.1019051-1-sughosh.ganu@linaro.org>
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

The efi_install_fdt() function is called before booting an EFI binary,
either directly, or through a bootmanager. This function installs a
copy of the device-tree(DT) on the EFI configuration table, which is
passed on to the OS.

The current logic in this function does not install a DT if the table
already has a DT installed on it. However, this existing copy of the
DT might not be up-to-date, or it could be a wrong DT for the image
that is being booted. Always install a DT afresh to the configuration
table before booting the EFI binary.

Installing a new DT also involves some additional checks that are
needed to clean up memory associated with the existing DT copy. Check
for an existing copy, and free up that memory.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V6: New patch

 lib/efi_loader/efi_helper.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 15ad042bc61..fe25eabeaac 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -454,11 +454,27 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle,
  */
 static efi_status_t copy_fdt(void **fdtp)
 {
-	unsigned long fdt_pages;
 	efi_status_t ret = 0;
 	void *fdt, *new_fdt;
-	u64 new_fdt_addr;
-	uint fdt_size;
+	static u64 new_fdt_addr;
+	static ulong fdt_pages;
+	ulong fdt_size;
+
+	if ((new_fdt_addr && !fdt_pages) || (fdt_pages && !new_fdt_addr)) {
+		log_err("%s: Fdt address/size not in the right state\n",
+			__func__);
+		return EFI_INVALID_PARAMETER;
+	}
+
+	if (new_fdt_addr) {
+		log_debug("%s: Found allocated memory at %#llx, with %#lx pages\n",
+			__func__, new_fdt_addr, fdt_pages);
+		ret = efi_free_pages(new_fdt_addr, fdt_pages);
+		if (ret != EFI_SUCCESS) {
+			log_err("Unable to free up existing FDT memory region\n");
+			return ret;
+		}
+	}
 
 	/*
 	 * Give us at least 12 KiB of breathing room in case the device tree
@@ -472,16 +488,20 @@ static efi_status_t copy_fdt(void **fdtp)
 				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
 				 &new_fdt_addr);
 	if (ret != EFI_SUCCESS) {
+		new_fdt_addr = fdt_pages = 0;
 		log_err("Failed to reserve space for FDT\n");
-		goto done;
+		return ret;
 	}
+	log_debug("%s: Allocated memory at %#llx, with %#lx pages\n",
+		  __func__, new_fdt_addr, fdt_pages);
+
 	new_fdt = (void *)(uintptr_t)new_fdt_addr;
 	memcpy(new_fdt, fdt, fdt_totalsize(fdt));
 	fdt_set_totalsize(new_fdt, fdt_size);
 
-	*fdtp = (void *)(uintptr_t)new_fdt_addr;
-done:
-	return ret;
+	*fdtp = new_fdt;
+
+	return EFI_SUCCESS;
 }
 
 /**
@@ -534,9 +554,6 @@ efi_status_t efi_install_fdt(void *fdt)
 		const char *fdt_opt;
 		uintptr_t fdt_addr;
 
-		/* Look for device tree that is already installed */
-		if (efi_get_configuration_table(&efi_guid_fdt))
-			return EFI_SUCCESS;
 		/* Check if there is a hardware device tree */
 		fdt_opt = env_get("fdt_addr");
 		/* Use our own device tree as fallback */
-- 
2.34.1

