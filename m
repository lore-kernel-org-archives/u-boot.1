Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158C7C83F16
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 09:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C096286B4B;
	Sat, 26 Aug 2023 11:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D91A786B4B; Sat, 26 Aug 2023 11:07:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 431BB86B12
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 11:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBC841FB;
 Sat, 26 Aug 2023 02:07:49 -0700 (PDT)
Received: from a076522.blr.arm.com (a076522.blr.arm.com [10.162.46.7])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB1B3F844;
 Sat, 26 Aug 2023 02:07:07 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 4/5] bootefi: Call the EVT_FT_FIXUP event handler
Date: Sat, 26 Aug 2023 14:36:32 +0530
Message-Id: <20230826090633.239342-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230826090633.239342-1-sughosh.ganu@linaro.org>
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
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

The bootefi command passes the devicetree to the kernel through the
EFI config table. Call the event handlers for fixing the devicetree
before jumping into the kernel. This removes any devicetree nodes
and/or properties that are specific only to U-Boot, and are not to be
passed to the OS.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 cmd/bootefi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index f73d6eb0e2..c359a46ec4 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -237,6 +237,23 @@ static void *get_config_table(const efi_guid_t *guid)
 	return NULL;
 }
 
+/**
+ * event_notify_dt_fixup() - call ft_fixup event
+ *
+ * @fdt:	address of the device tree to be passed to the kernel
+ *		through the configuration table
+ * Return:	None
+ */
+static void event_notify_dt_fixup(void *fdt)
+{
+	int ret;
+	struct event_ft_fixup fixup = {0};
+
+	fixup.tree.fdt = fdt;
+	ret = event_notify(EVT_FT_FIXUP, &fixup, sizeof(fixup));
+	if (ret)
+		printf("Error: %d: FDT Fixup event failed\n", ret);
+}
 #endif /* !CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) */
 
 /**
@@ -318,6 +335,7 @@ efi_status_t efi_install_fdt(void *fdt)
 	efi_carve_out_dt_rsv(fdt);
 
 	efi_try_purge_kaslr_seed(fdt);
+	event_notify_dt_fixup(fdt);
 
 	if (CONFIG_IS_ENABLED(EFI_TCG2_PROTOCOL_MEASURE_DTB)) {
 		ret = efi_tcg2_measure_dtb(fdt);
-- 
2.34.1

