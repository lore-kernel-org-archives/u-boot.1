Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED52CC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B31C587443;
	Thu, 16 Nov 2023 17:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bXtVCRbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88AD2874CF; Thu, 16 Nov 2023 17:51:28 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C03E87443
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso9231265ad.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700153479; x=1700758279; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8++qtWWaifqhQSDNBcP6a1XgePEzeOqoZ++JpjjVhI=;
 b=bXtVCRbd0Ay0FUakJxAA6ShrPR6DB5iqERJY2nSqSaB/C1KBaG7tdAb5f0UMKRa8kI
 PU6K29EE9lb36bxuPoAgmvPCYvH2gzokvyFIifmRuYl2aSIz1ywzIxN0EP2bGBFGimuC
 Bh88SlRwRDUq8ifQL97ySysmcdfo0G9KYmEkMoCYUZ1TuBjhLIMmiP0/eA6CTV4YnhT3
 nhxfnyK9bYT/HOGPyMcoJ/O5vG/1XO7iODqwzJrIah4+TFro2MYqSaAHXbOQFmKtsOXg
 ILr7GIiW9BZbZtuuOXE27km0x6BU2AGqV3dhWo6Xp9GAurns7unN0BpqhJLXUxTq/MNA
 lzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153479; x=1700758279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8++qtWWaifqhQSDNBcP6a1XgePEzeOqoZ++JpjjVhI=;
 b=wUYhtM0icv9M7p1hYjCl7VDrQ00lqaTxUVOvoStFljX2mTz6pcB3Dhhe04fSnVoSVl
 Q8niqhYxq6HT9XBYGcf0mf+MovCUFZexrJNyLasi/2V4zJXU4+LTPrL04+TUbED8+92q
 B9LBmdpU81yjcSBa16H3aejmyHtVXewT4ZCEAiKsnkBqC3fMAVpp9xLEsghJrzYiWrWO
 g39SsM6BLsvtyjiZAwiped5Ux8G8X0UpPYCLODwl7ys4dMWOEhzNhRzoxcqjC2pTcnLn
 KKAJbgKHAYve1Vn0afvUn2aZaaLtFCkHQ++aRhodXsW475FxVZarpwPLxthQJSCZnEcA
 x88w==
X-Gm-Message-State: AOJu0Yy1oCpGH3a/nnIUZ/DpNZGF1TyzHLC0rvZxShiqYcV+nOuT4UxX
 oazJbWRP1j9bWeeIYVivKOGjrw==
X-Google-Smtp-Source: AGHT+IEeAP8OYJz8/zg86I8UNZkow+ocLTdMesA9XpQlctn1Hg4r/V2yIg/N12Bjv/tqV7ZfcB5JgQ==
X-Received: by 2002:a17:902:748c:b0:1cc:4677:2f0e with SMTP id
 h12-20020a170902748c00b001cc46772f0emr8750927pll.45.1700153479555; 
 Thu, 16 Nov 2023 08:51:19 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:57e3:f37f:e352:7f6c:bf18:83f0])
 by smtp.googlemail.com with ESMTPSA id
 j13-20020a170902da8d00b001cc32261bdfsm9438696plx.38.2023.11.16.08.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:51:19 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Michal Simek <michal.simek@amd.com>, Bo Gan <ganboing@gmail.com>,
 Puhan Zhou <puh4n.zhou@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] pci: xilinx: Fix "reg" not found error
Date: Thu, 16 Nov 2023 22:21:02 +0530
Message-Id: <20231116165103.140968-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116165103.140968-1-mchitale@ventanamicro.com>
References: <20231116165103.140968-1-mchitale@ventanamicro.com>
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

Fix the driver to use the dev_read_addr_size API to fetch the reg
property from the DT.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/pci/pcie_xilinx.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index 53fd121e90..fdc9b08c10 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -8,11 +8,10 @@
 #include <common.h>
 #include <dm.h>
 #include <pci.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
+#include <linux/err.h>
 
 /**
  * struct xilinx_pcie - Xilinx PCIe controller state
@@ -140,20 +139,16 @@ static int pcie_xilinx_write_config(struct udevice *bus, pci_dev_t bdf,
 static int pcie_xilinx_of_to_plat(struct udevice *dev)
 {
 	struct xilinx_pcie *pcie = dev_get_priv(dev);
-	struct fdt_resource reg_res;
-	DECLARE_GLOBAL_DATA_PTR;
-	int err;
-
-	err = fdt_get_resource(gd->fdt_blob, dev_of_offset(dev), "reg",
-			       0, &reg_res);
-	if (err < 0) {
-		pr_err("\"reg\" resource not found\n");
-		return err;
-	}
-
-	pcie->cfg_base = map_physmem(reg_res.start,
-				     fdt_resource_size(&reg_res),
-				     MAP_NOCACHE);
+	fdt_addr_t addr;
+	fdt_size_t size;
+
+	addr = dev_read_addr_size(dev, &size);
+	if (addr == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	pcie->cfg_base = devm_ioremap(dev, addr, size);
+	if (IS_ERR(pcie->cfg_base))
+		return PTR_ERR(pcie->cfg_base);
 
 	return 0;
 }
-- 
2.34.1

