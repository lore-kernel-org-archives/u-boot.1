Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EDBC48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 10:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A3C8792D;
	Sat, 17 Feb 2024 11:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Pwj7/28m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7571A8785A; Sat, 17 Feb 2024 11:56:00 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B076587C9E
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 11:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C81403F2AE; 
 Sat, 17 Feb 2024 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708167348;
 bh=q2Xdq18qu6sGL8+9L04uMZ+dmqy7zUPyJgYog5SQ90o=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Pwj7/28mbhzDf65VQIeXfMsZjEQr+WIjB1E5cAHHDyb/4ka2gLGrn9zLLqAfkoe1G
 4TgEI4+HwaMlM8ATB/GNNe8uKZDzeCKSYSEWfsqSBPFgStT5HFU3R4J4MxigSGZkz6
 eKdBrhWPvwsw9r+gtqyzdpBud6T6O6ZdQNA7tDsO4Xd+5aWIWKpYrO9+72+9fH14Oh
 3BN5kz7IuhB7Oy7TBkaZ29qOGd6J/xED35xitbWFk0vDYUxdpNSJ09N7tfSKGR3qL/
 s7LgILfzLU5mbRDeBf6k77xYmdlCUwRjoprPmu6c3ugl1SVNNi45pg7SkJxoGOkxYo
 7Cr3YPlo//0FA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: ignore device-tree in ACPI case
Date: Sat, 17 Feb 2024 11:55:58 +0100
Message-ID: <20240217105558.21767-1-heinrich.schuchardt@canonical.com>
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

If a device-tree is passed to the bootefi command while using ACPI, we
currently only show a warning that the device-tree will be ignored. But we
use that device-tree to create memory reservations.

To be consistent we need to fallback to the internal device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_helper.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 5dd9cc876e..e2f547b3cd 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -422,8 +422,11 @@ efi_status_t efi_install_fdt(void *fdt)
 	 * The EBBR spec requires that we have either an FDT or an ACPI table
 	 * but not both.
 	 */
-	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) && fdt)
+	if (CONFIG_IS_ENABLED(GENERATE_ACPI_TABLE) &&
+	    fdt != EFI_FDT_USE_INTERNAL) {
+		fdt = EFI_FDT_USE_INTERNAL;
 		log_warning("WARNING: Can't have ACPI table and device tree - ignoring DT.\n");
+	}
 
 	if (fdt == EFI_FDT_USE_INTERNAL) {
 		const char *fdt_opt;
-- 
2.43.0

