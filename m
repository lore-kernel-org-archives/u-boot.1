Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E593C5AD56
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 01:34:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A325D6067C;
	Sun,  9 Aug 2026 01:34:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vE-JoNk_RFPd; Sun,  9 Aug 2026 01:34:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8C8A60628
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786239283;
	bh=QKruSlypFpb0pYGcbYxgKj2VHMyzXDP7LRKvJXqfa8g=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=YG+sCOAhamHCA8pmL1TrCYLgCslEH7xecrhUtA+Ta9eK10fsGpIM0a/Bsff1ZBDKw
	 ZIA3XMcN4nmBb81kWkotabv6dMrwG1p0hf66nMM4hdoNlchbBSChayGkrEUBHV24ej
	 B+KlheGsRloKeNGeoUMpg5bw7gZZjJv3UXxaRgjknlvKdyEE3DTO2NYDvX+Jz7yse3
	 3YoPgTmFY4hdeRFWGPv0KyKM0ERgZJqE/CdRudTtv74FZcDjGZML8YehJlOVEbpprh
	 yg9KwehyUgFcR4QxI4th8zNZqcvbMJ8F6husw4TNWnoMGCv6KkTrMLltP31mxVPKvD
	 yz1Hp70c0XDDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8C8A60628;
	Sun,  9 Aug 2026 01:34:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4AD6A2F5
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:34:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CAF8400EA
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:34:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YypiJQhkenoj for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 01:34:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7016640068
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7016640068
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7016640068
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 01:34:41 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hHgRM16m2zMlBF;
 Sun, 09 Aug 2026 03:34:39 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH 1/3] pci: pcie-rcar-gen4: Switch to generic firmware loader
Date: Sun,  9 Aug 2026 03:32:38 +0200
Message-ID: <20260809013431.444164-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9muppawrwqrjzyxz8tm3wo8uzb1i8ka4
X-MBO-RS-ID: 737c49ffc9f7408fe2d
X-Rspamd-Queue-Id: 4hHgRM16m2zMlBF
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QKruSlypFpb0pYGcbYxgKj2VHMyzXDP7LRKvJXqfa8g=;
 b=XFqKJzLFiGxS6uKjJmPAue7TgskegVcshbYB2fauyhn6eITjWf8j+iDMvrU1bu0/YxKU24
 6AQM/c98IgRUEnTPrCgXajy1vcIIp0x++o6Rzq3zJM6nKIm+r34O4MeogBZVSkJsnIuia2
 aFcmIVWy2vWGHIu4g4dWa1533usOtLcaTo9zF7vrgjdbvWoNRc0bxFPgQMvU52Fa14HOFs
 w9nzi6S7sErWoWQ0vU8Z+BS+seDQ46gx7DJrTwNFQYo9tJG3LbRtbmXcL0HTol18RX2bcN
 Pv4hie/4fE6Cr752MiEOQtwbBYL+AYCBCce3wyCwIUajijPrv/oBsi6i6XsCFg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786239277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QKruSlypFpb0pYGcbYxgKj2VHMyzXDP7LRKvJXqfa8g=;
 b=FcMosAolRHlphvKgLaMxP4eY7llEyxzo21rQpxdOlvWdf5lyVUlqNWwvWGCh4AlrCcEIY1
 1bcS79tl/oYBduLVlTDWUwMHL/D21NAEVrCwfV/ILgEoK5Xxz9JWSWKtrPWPoLjLJlzBR8
 Yr8557rx5QJhNCl5Rn26hUrYnZuuI5RAwBRTYHDp6qSWQhHpXd35wdHaK7ohyAguS5EjCK
 mSSpeX4An1wu9kjkhOX2jYktfJ60Wff0kuEPHBBXa7hBS+ZOJxLPXkhKj1uWzagkjz7l5l
 Zu8x7jnK+z2xUQ3CdDFVp8rC0Fkohh0UPT1GRsJA7AAdp27ZSNmjMq5jrwR+gQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=XFqKJzLF; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=FcMosAol
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=FcMosAol;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Use generic request_firmware_into_buf_via_script() instead of local
implementation of similar functionality. This reduces code duplication.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/pci/Kconfig         |  1 +
 drivers/pci/pci-rcar-gen4.c | 67 ++++++++++++-------------------------
 2 files changed, 23 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9ffccc3a80b..2b2ccdf4745 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -396,6 +396,7 @@ config PCI_RCAR_GEN4
 	depends on RCAR_GEN4
 	select DM_RESET
 	select DM_GPIO
+	select FW_LOADER
 	select PCIE_DW_COMMON
 	help
 	  Say Y here if you want to enable PCIe controller support on
diff --git a/drivers/pci/pci-rcar-gen4.c b/drivers/pci/pci-rcar-gen4.c
index 8c5c8095c73..34561406641 100644
--- a/drivers/pci/pci-rcar-gen4.c
+++ b/drivers/pci/pci-rcar-gen4.c
@@ -19,6 +19,7 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <env.h>
+#include <fw_loader.h>
 #include <log.h>
 #include <reset.h>
 
@@ -75,6 +76,7 @@
 
 #define RCAR_GEN4_PCIE_FIRMWARE_NAME		"rcar_gen4_pcie.bin"
 #define RCAR_GEN4_PCIE_FIRMWARE_BASE_ADDR	0xc000
+#define RCAR_GEN4_PCIE_FIRMWARE_SIZE		0x8000
 
 #define PCIE_T_PVPERL_MS			100
 
@@ -107,7 +109,7 @@ struct rcar_gen4_pcie {
 	u32			max_link_speed;
 	u32			num_lanes;
 	u16			*firmware;
-	u32			firmware_size;
+	size_t			firmware_size;
 };
 
 /* Common */
@@ -362,56 +364,31 @@ static int rcar_gen4_pcie_host_init(struct udevice *dev)
 
 static int rcar_gen4_pcie_load_firmware(struct rcar_gen4_pcie *rcar)
 {
-	ulong addr, size;
 	int ret;
 
-	/*
-	 * Run user specified firmware loading script, which loads the
-	 * firmware from whichever location the user decides it should
-	 * load the firmware from, by whatever means the user decides.
-	 */
-	ret = run_command_list("run renesas_rcar_gen4_load_firmware", -1, 0);
-	if (ret) {
-		printf("Firmware loading script 'renesas_rcar_gen4_load_firmware' not defined or failed.\n");
-		goto fail;
-	}
-
-	/* Find out where the firmware got loaded and how long it is. */
-	addr = env_get_hex("renesas_rcar_gen4_load_firmware_addr", 0);
-	size = env_get_hex("renesas_rcar_gen4_load_firmware_size", 0);
-
-	/*
-	 * Clear the variables set by the firmware loading script, as
-	 * their content would become stale once this function exits.
-	 */
-	env_set("renesas_rcar_gen4_load_firmware_addr", NULL);
-	env_set("renesas_rcar_gen4_load_firmware_size", NULL);
-
-	if (!addr || !size) {
-		printf("Firmware address (%lx) or size (%lx) are invalid.\n", addr, size);
-		goto fail;
-	}
-
-	/* Create local copy of the loaded firmware. */
-	rcar->firmware = (u16 *)memdup((void *)addr, size);
+	rcar->firmware = calloc(1, RCAR_GEN4_PCIE_FIRMWARE_SIZE);
 	if (!rcar->firmware)
 		return -ENOMEM;
 
-	rcar->firmware_size = size;
-
-	return 0;
+	ret = request_firmware_into_buf_via_script(rcar->firmware,
+						   RCAR_GEN4_PCIE_FIRMWARE_SIZE,
+						   "renesas_rcar_gen4_load_firmware",
+						   &rcar->firmware_size);
+	if (ret) {
+		free(rcar->firmware);
+
+		printf("Define 'renesas_rcar_gen4_load_firmware' script which loads the R-Car\n"
+		       "Gen4 PCIe controller firmware from storage into memory and sets these\n"
+		       "two environment variables:\n"
+		       "  renesas_rcar_gen4_load_firmware_addr ... address of firmware in memory\n"
+		       "  renesas_rcar_gen4_load_firmware_size ... length of firmware in bytes\n"
+		       "\n"
+		       "Example:\n"
+		       "  => env set renesas_rcar_gen4_load_firmware 'env set renesas_rcar_gen4_load_firmware_addr 0x54000000 && load mmc 0:1 ${renesas_rcar_gen4_load_firmware_addr} lib/firmware/rcar_gen4_pcie.bin && env set renesas_rcar_gen4_load_firmware_size ${filesize}'\n"
+		       );
+	}
 
-fail:
-	printf("Define 'renesas_rcar_gen4_load_firmware' script which loads the R-Car\n"
-	       "Gen4 PCIe controller firmware from storage into memory and sets these\n"
-	       "two environment variables:\n"
-	       "  renesas_rcar_gen4_load_firmware_addr ... address of firmware in memory\n"
-	       "  renesas_rcar_gen4_load_firmware_size ... length of firmware in bytes\n"
-	       "\n"
-	       "Example:\n"
-	       "  => env set renesas_rcar_gen4_load_firmware 'env set renesas_rcar_gen4_load_firmware_addr 0x54000000 && load mmc 0:1 ${renesas_rcar_gen4_load_firmware_addr} lib/firmware/rcar_gen4_pcie.bin && env set renesas_rcar_gen4_load_firmware_size ${filesize}'\n"
-	       );
-	return -EINVAL;
+	return ret;
 }
 
 /**
-- 
2.53.0

