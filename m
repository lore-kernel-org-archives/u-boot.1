Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08E2D3C526
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 18:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CA528900A;
	Thu, 17 Oct 2024 20:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bapOhdV0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1CDC88FE4; Thu, 17 Oct 2024 20:13:13 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F041A8900A
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A0C643F93B; 
 Thu, 17 Oct 2024 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729188788;
 bh=Vy9zGXr0WZ+ILcV/5OOl30zjq3cLRb6APXNVMWDOGb8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bapOhdV0Fwr89ZqpoSAQRhORGFSQypeJuEOgVSHfsJRhdIz3ykgETFHIN6v0uo0eo
 d7FejRfkhjp8PflbZdHKX2RnmpxCZN/rqLLYhcdnQ+l2VXhQDffJ9vrXsPmA0UUQzu
 5rKAsEXkIMjyEDQz87yRCUKTv4kbeTBxiRzKJnOUK2RBidGIAWqY42xah3JoFfTY1f
 h8T1HDVTY/5kjuVNnMDsf0vo3QvUFqUDiktXqXn07aYeFWnR0vV+sFtwuBGk4H1xfL
 YV+0sVv33iQ3wuxCy+VBX6WL65HYZVsBO98LR9ZXHHQEN7ub5z/U+akWiOR2MsFAOe
 QX6zH531zIc4w==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: remove ERROR:, WARNING: prefixes in messages
Date: Thu, 17 Oct 2024 20:13:05 +0200
Message-ID: <20241017181306.6615-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

We should not write "ERROR:" or "WARNING:" when using log_err() or
log_warning(). These prefixed don't provide additional information.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index a481eb4b7e3..00167bd2a10 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -412,7 +412,7 @@ static efi_status_t copy_fdt(void **fdtp)
 				 EFI_ACPI_RECLAIM_MEMORY, fdt_pages,
 				 &new_fdt_addr);
 	if (ret != EFI_SUCCESS) {
-		log_err("ERROR: Failed to reserve space for FDT\n");
+		log_err("Failed to reserve space for FDT\n");
 		goto done;
 	}
 	new_fdt = (void *)(uintptr_t)new_fdt_addr;
@@ -468,7 +468,7 @@ efi_status_t efi_install_fdt(void *fdt)
 	 * but not both.
 	 */
 	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) && fdt)
-		log_warning("WARNING: Can't have ACPI table and device tree - ignoring DT.\n");
+		log_warning("Can't have ACPI table and device tree - ignoring DT.\n");
 
 	if (fdt == EFI_FDT_USE_INTERNAL) {
 		const char *fdt_opt;
@@ -483,13 +483,13 @@ efi_status_t efi_install_fdt(void *fdt)
 		if (!fdt_opt) {
 			fdt_opt = env_get("fdtcontroladdr");
 			if (!fdt_opt) {
-				log_err("ERROR: need device tree\n");
+				log_err("need device tree\n");
 				return EFI_NOT_FOUND;
 			}
 		}
 		fdt_addr = hextoul(fdt_opt, NULL);
 		if (!fdt_addr) {
-			log_err("ERROR: invalid $fdt_addr or $fdtcontroladdr\n");
+			log_err("invalid $fdt_addr or $fdtcontroladdr\n");
 			return EFI_LOAD_ERROR;
 		}
 		fdt = map_sysmem(fdt_addr, 0);
@@ -497,7 +497,7 @@ efi_status_t efi_install_fdt(void *fdt)
 
 	/* Install device tree */
 	if (fdt_check_header(fdt)) {
-		log_err("ERROR: invalid device tree\n");
+		log_err("invalid device tree\n");
 		return EFI_LOAD_ERROR;
 	}
 
@@ -510,12 +510,12 @@ efi_status_t efi_install_fdt(void *fdt)
 	/* Prepare device tree for payload */
 	ret = copy_fdt(&fdt);
 	if (ret) {
-		log_err("ERROR: out of memory\n");
+		log_err("out of memory\n");
 		return EFI_OUT_OF_RESOURCES;
 	}
 
 	if (image_setup_libfdt(&img, fdt, false)) {
-		log_err("ERROR: failed to process device tree\n");
+		log_err("failed to process device tree\n");
 		return EFI_LOAD_ERROR;
 	}
 
@@ -527,7 +527,7 @@ efi_status_t efi_install_fdt(void *fdt)
 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
 		ret = efi_tcg2_measure_dtb(fdt);
 		if (ret == EFI_SECURITY_VIOLATION) {
-			log_err("ERROR: failed to measure DTB\n");
+			log_err("failed to measure DTB\n");
 			return ret;
 		}
 	}
@@ -535,7 +535,7 @@ efi_status_t efi_install_fdt(void *fdt)
 	/* Install device tree as UEFI table */
 	ret = efi_install_configuration_table(&efi_guid_fdt, fdt);
 	if (ret != EFI_SUCCESS) {
-		log_err("ERROR: failed to install device tree\n");
+		log_err("failed to install device tree\n");
 		return ret;
 	}
 
@@ -574,7 +574,7 @@ efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
 	 */
 	ret = efi_set_watchdog(300);
 	if (ret != EFI_SUCCESS) {
-		log_err("ERROR: Failed to set watchdog timer\n");
+		log_err("failed to set watchdog timer\n");
 		goto out;
 	}
 
-- 
2.45.2

