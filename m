Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CF3C27C42
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 22:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5252286A50;
	Thu, 17 Aug 2023 00:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Byte9ip0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4233186A45; Thu, 17 Aug 2023 00:28:42 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B0A86A47
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 00:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-26b2beae166so3106654a91.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692224905; x=1692829705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2hq0SGFCEPJhSCBxivnjqg6//gD2oPPyIN2Di5P7EAw=;
 b=Byte9ip0JmNo3s+KJa2M73f+0gZIPIyGjHjDnUskybeAFjVI1b7fScvj7bibk9jg5A
 LDEl0/TTIanBtxgBKQ5qFXfsXgTpeIW5Y3GaklYUC9tv8jrBZxR5O4H2cBpqTzvUaen4
 ScIQLIfPkiKQAWcpE+cVZmMoesDopRFxL/tbmHZsOix4DQLTwlMNys9JqoMdbbyheBEO
 Q/7wQk5Mv6Re5+FabCiLz/pAG5tFosG0Ak2hZjzCeXlIqJjvbzmRm+vv7czbXecePApw
 ObvUOXvYmXP2IDSBn9qTHU4+usFShmhQwpXGP695U8Q0QctMFnoyL+1rWK5whAMABSB7
 BKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692224905; x=1692829705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hq0SGFCEPJhSCBxivnjqg6//gD2oPPyIN2Di5P7EAw=;
 b=JGvOXhlJ6FRkmQfjZ1FkuhD4v6KzI4QeIt32liq60NCoD8Gm2qEMF83WS9ywXeYmVH
 b/yUjGq/o7pG1zTBZ6Q1k9sy8TOiB9H+eH7VpLF4Z3mrTlItqkDATOZd0vDdNa7/HcHM
 npxh5LVihs4P9IiWBXv0DMA611B9Hci32C9GjyHUTzrhiU7tW4VI1LX8chtsRo+HOxy8
 y5JCIBpQyiJE8ivn/1kPal31zn+lzAe4exP22C5+qBfa+mlmGAHQDANCMJMoyQFVXBon
 wZcFebIVcl/OpvIeer2/R19bMeEfgzbBbUJRUe211AG2RvQZN5/6xrrS+akfhfkkD+TI
 blTA==
X-Gm-Message-State: AOJu0YwrkXYK/nudR6G9jdhxVlFnCnbH4j3z4iuEKHrx52ySxXg/x4sO
 3CRf+kcUdC/qY52l9GCs8PlQ1TamA+C+6w==
X-Google-Smtp-Source: AGHT+IH6FqlrGESChrHniBTbi5sDPG22Mzi6d034PR4bdS2rgtZlRAt2hjzHbvdYelH5ujy2gDMVKA==
X-Received: by 2002:a17:90a:ba02:b0:26b:1081:a432 with SMTP id
 s2-20020a17090aba0200b0026b1081a432mr2598945pjr.30.1692224905423; 
 Wed, 16 Aug 2023 15:28:25 -0700 (PDT)
Received: from celestia.nettie.lan (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 d5-20020a17090ac24500b002681bda127esm219767pjx.35.2023.08.16.15.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 15:28:24 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: u-boot@lists.denx.de,
	Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Tom Rini <trini@konsulko.com>, Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH] pci: pcie-brcmstb: do not rely on CLKREQ# signal
Date: Wed, 16 Aug 2023 15:27:53 -0700
Message-ID: <20230816222753.104882-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
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

When the Broadcom STB PCIe controller is initialized, it must be set
into one of three CLKREQ# modes: "none"/"aspm"/"l1ss". The Linux driver,
through today, hard-codes "aspm" since the vast majority of boards using
this driver have a fixed PCIe bus with the CLKREQ# signal wired up.

The Raspberry Pi CM4, however, can be connected to a plethora of PCIe
devices, some of which do not connect the CLKREQ# line (they just leave
it floating). So "aspm" mode is no longer appropriate in all cases. In
Linux, there is a proposed patchset [1] to determine the proper mode.
This doesn't really make sense in U-Boot's case, so we just change the
assumption from "aspm" to "none" (which is always safe).

This patch DOES resolve a real-world crash that occurs when U-Boot is
running on a Raspberry Pi CM4 installed in slot 3 of a Turing Pi 2
cluster board.

[1]: https://lore.kernel.org/all/20230428223500.23337-1-jim2101024@gmail.com/

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 drivers/pci/pcie_brcmstb.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index 1de2802113..b8105654c5 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -33,6 +33,9 @@
 #define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
 #define  CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK		0xffffff
 
+#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
+#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
+
 #define PCIE_RC_DL_MDIO_ADDR				0x1100
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
@@ -88,7 +91,6 @@
 	 PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
 
 #define PCIE_MISC_HARD_PCIE_HARD_DEBUG			0x4204
-#define  PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
 #define  PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
 
 #define PCIE_MSI_INTR2_CLR				0x4508
@@ -562,12 +564,18 @@ static int brcm_pcie_probe(struct udevice *dev)
 	clrsetbits_le32(base + PCIE_RC_CFG_VENDOR_SPECIFIC_REG1,
 			VENDOR_SPECIFIC_REG1_ENDIAN_MODE_BAR2_MASK,
 			VENDOR_SPECIFIC_REG1_LITTLE_ENDIAN);
+
 	/*
-	 * Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
-	 * is enabled => setting the CLKREQ_DEBUG_ENABLE field to 1.
+	 * We used to enable the CLKREQ# input here, but a few PCIe cards don't
+	 * attach anything to the CLKREQ# line, so we shouldn't assume that
+	 * it's connected and working. The controller does allow detecting
+	 * whether the port on the other side of our link is/was driving this
+	 * signal, so we could check before we assume. But because this signal
+	 * is for power management, which doesn't make sense in a bootloader,
+	 * let's instead just unadvertise ASPM support.
 	 */
-	setbits_le32(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG,
-		     PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK);
+	clrbits_le32(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY,
+		     PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
 
 	return 0;
 }
-- 
2.41.0

