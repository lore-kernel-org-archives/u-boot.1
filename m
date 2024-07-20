Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A6FC3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38BE488C8E;
	Sat, 20 Jul 2024 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wTRweXgO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RuQWTa54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E6A088C81; Sat, 20 Jul 2024 14:43:54 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2548F88C4A
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5ng6GrQz9snN;
 Sat, 20 Jul 2024 14:43:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TP6+odgOeNLDwbC+yzzuY5x6N77KUmF8PWHrqS/vP4=;
 b=wTRweXgOD4mEU6zoyGQnhOeL/tqlY5koGEWEWXk80ck+22t1nv9rSKNUhRRK/hkuQF+1Fx
 dh1r8TRGdM7ADBIAt0VemDno8FRhsODH7XWCxO6RIQ6XmlW/rFpH9Caz1/Bl931FsU6X/k
 WAlty8g2L/fAlfiXP3s8gcCt/c4Lm4mKuAJNjVzU5mFwfCTCdzWIfkn/RqDjznBGFQ7jTm
 oooKyTrO9aJtRYDcJWhUW+bBgMKgVIMfkCtHg7LcLA0X2rllEfy5/ihc56cQ0CLnGEnpAY
 z8alwRiOqTRYJE/sdF5i+DYR6+h1Q/BB23bGlprz7eElqfV9StaySzvfOTPV8g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5TP6+odgOeNLDwbC+yzzuY5x6N77KUmF8PWHrqS/vP4=;
 b=RuQWTa54zMv3SvVM/6Oxs2i4Rbd1C7Cjj2FULkFQ4CYl6iY9KF9NBvTNtQeuFyvj91gDqa
 BApdLIKbukFqHBa9a0gnRRKVIDazXzK8Ro3H5OfCcyPjNqrpvc0B4N0QC5CrLaEducny/b
 xrYBkuKViWew4GZS2Fz0Vp6OSGt8grHMhy4sBfPJe8Wr4JibUIWDywytZgfD3j2xNSEt+N
 t+ZrmU749qF+s+5RV25P0uArW+QZ4Op32zaElQAOnLIMPjqiuLrPOreBTxG2Df2ACmQBs0
 OulSBv3RCDKi9aJPeulnroEacEU2LDu8O3UabyvJ1N8VI++PfCTTAkaN7ingNg==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 21/40] drivers: pci: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:46 +0200
Message-ID: <20240720124239.7553-21-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4e1092f31cae201d6d6
X-MBO-RS-META: 8hex9e9w1m6sf48ic38pfegnbnb7s6gt
X-Rspamd-Queue-Id: 4WR5ng6GrQz9snN
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pci/pci_auto_common.c       | 1 -
 drivers/pci/pcie_dw_rockchip.c      | 1 -
 drivers/pci/pcie_dw_ti.c            | 1 -
 drivers/pci/pcie_layerscape_fixup.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/pci/pci_auto_common.c b/drivers/pci/pci_auto_common.c
index cfa818ed821..141166e59b7 100644
--- a/drivers/pci/pci_auto_common.c
+++ b/drivers/pci/pci_auto_common.c
@@ -108,7 +108,6 @@ void pciauto_config_init(struct pci_controller *hose)
 		}
 	}
 
-
 	if (hose->pci_mem)
 		pciauto_show_region("Memory", hose->pci_mem);
 	if (hose->pci_prefetch)
diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchip.c
index 1bad51fb3eb..ac7faa4cc19 100644
--- a/drivers/pci/pcie_dw_rockchip.c
+++ b/drivers/pci/pcie_dw_rockchip.c
@@ -506,7 +506,6 @@ static int rockchip_pcie_probe(struct udevice *dev)
 		 pcie_dw_get_link_width(&priv->dw),
 		 hose->first_busno);
 
-
 	ret = pcie_dw_prog_outbound_atu_unroll(&priv->dw,
 					       PCIE_ATU_REGION_INDEX0,
 					       PCIE_ATU_TYPE_MEM,
diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index 78a5d035865..dc6e65273b7 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -46,7 +46,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define PCIE_CMD_STATUS			0x04
 #define LTSSM_EN_VAL			BIT(0)
 
-
 #define AM654_PCIE_DEV_TYPE_MASK	0x3
 #define EP				0x0
 #define LEG_EP				0x1
diff --git a/drivers/pci/pcie_layerscape_fixup.c b/drivers/pci/pcie_layerscape_fixup.c
index ec4a7e7b657..97c38c0bfa7 100644
--- a/drivers/pci/pcie_layerscape_fixup.c
+++ b/drivers/pci/pcie_layerscape_fixup.c
@@ -503,7 +503,6 @@ static void fdt_fixup_pcie_ls(void *blob)
 	struct extra_iommu_entry *entries;
 	int i, cnt, nodeoffset;
 
-
 	/* Scan all known buses */
 	for (pci_find_first_device(&dev);
 	     dev;
-- 
2.43.0

