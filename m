Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE84CF07A5
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DAD689114;
	Thu, 10 Oct 2024 07:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="MmTK0hHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0306D8911A; Thu, 10 Oct 2024 07:56:01 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81C5890D8
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2024101005555732b11cc9fa61f134ad for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=b8CWqpHNIJYEj9JLsGa35ZfQxwxSA8aisUiLuWwjW+A=;
 b=MmTK0hHvfepb6haCFCRviIoTOzwKsir0Hw5eo3psKnk7TKerF80ehltbJQuOMM0dHp8oQM
 RjETWSmfLd3hxq1KumvTDpmyIPhzaTBaQt9C/gAsnMoPv0NclUp41X6FgS2D2v1Gr7RHs9kj
 MQ4WVS+mZrFPNmoFSFsco575UlyhdHMJIivtE2BxNY2awVCkBEt/mZ1GFLCo2kXIeOJRv5K/
 zhonrLRhl9wRFh7WUXYpmlLOxoBlJP/sPMcLdVHeCK6w+mj8XyfEbnb83q+HOaqFhAiuNOez
 wJAotlW2UEdL56niUsWS25RV1Cdd5KEHmXal9GdBKrMHFlBtuKBvQisw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 05/11] board: siemens: iot2050: Generalize the fdt fixup
Date: Thu, 10 Oct 2024 07:55:49 +0200
Message-ID: <4b1d2aed4304d3ca5ae55f65e7e300a914f69253.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Baocheng Su <baocheng.su@siemens.com>

The fdt fixup logic actually also applies to other possible variants who
also have device tree overlays. So generalize this part by extracting
it from the m.2 specific function and make it a standalone one.

Since now we only have M.2 variant consuming the overlay, it may not
have immediate effect for other variant, however this makes the future
variant more easier to apply fdt fixups.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/siemens/iot2050/board.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index 16082ae2afe..fad6bc04735 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -245,23 +245,14 @@ void set_board_info_env(void)
 	env_save();
 }
 
-static void m2_overlay_prepare(void)
+static void do_overlay_prepare(const char *overlay_path)
 {
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
-	const char *overlay_path;
 	void *overlay;
 	u64 loadaddr;
 	ofnode node;
 	int ret;
 
-	if (connector_mode == BKEY_PCIEX2)
-		return;
-
-	if (connector_mode == BKEY_PCIE_EKEY_PCIE)
-		overlay_path = "/fit-images/bkey-ekey-pcie-overlay";
-	else
-		overlay_path = "/fit-images/bkey-usb3-overlay";
-
 	node = ofnode_path(overlay_path);
 	if (!ofnode_valid(node))
 		goto fit_error;
@@ -288,6 +279,21 @@ fit_error:
 #endif
 }
 
+static void m2_overlay_prepare(void)
+{
+	const char *overlay_path;
+
+	if (connector_mode == BKEY_PCIEX2)
+		return;
+
+	if (connector_mode == BKEY_PCIE_EKEY_PCIE)
+		overlay_path = "/fit-images/bkey-ekey-pcie-overlay";
+	else
+		overlay_path = "/fit-images/bkey-usb3-overlay";
+
+	do_overlay_prepare(overlay_path);
+}
+
 static void m2_connector_setup(void)
 {
 	ulong m2_manual_config = env_get_ulong("m2_manual_config", 10,
@@ -466,7 +472,7 @@ int board_late_init(void)
 }
 
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
-static void m2_fdt_fixup(void *blob)
+static void variants_fdt_fixup(void *blob)
 {
 	void *overlay_copy = NULL;
 	void *fdt_copy = NULL;
@@ -506,14 +512,14 @@ cleanup:
 	return;
 
 fixup_error:
-	pr_err("Could not apply M.2 device tree overlay\n");
+	pr_err("Could not apply device tree overlay\n");
 	goto cleanup;
 }
 
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	if (board_is_m2())
-		m2_fdt_fixup(blob);
+		variants_fdt_fixup(blob);
 
 	return 0;
 }
-- 
2.43.0

