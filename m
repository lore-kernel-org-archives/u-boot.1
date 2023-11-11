Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1839AC4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 17:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC5186EDA;
	Sat, 11 Nov 2023 18:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WJQbzRD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508DE86EE1; Sat, 11 Nov 2023 18:36:28 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3447286EB9
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 18:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5aa7172bafdso2128214a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 09:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699724184; x=1700328984; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VnfsphvXx+SeilBfaJRLO4IX/5mqgUJn5CDe2dtvVoQ=;
 b=WJQbzRD7kXLVL1LhcMoH5wb02ekI2wG09cyEEI+N+vrNJD1ZB8BjGfDjXvEP8+KDG4
 7MBfZgxV5URjAmgk/8Bf8YWia2QamQgNE3NVzOy6x5vVwatu1qc4TK/aOMvO7bQWD1KS
 7+Nu3vF8WfYjrusDCURcKPja6NBPjSLolyOIPFoy4A2LAdidrRncdgfcdBsqoqMpNk5u
 Os/2+9k2ZydXpueJNk6621W4UTAYjQtM9I0Lb8zsMmNljFh8DjtH5sttoIQ6MtiDaoJB
 eCAqAs2JR6gNzHWZLOjYIDC6nvtG+ZbsdfmNeG+cr7VYIg4Pvrz7znfhsy6TsY/m0nYA
 +BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699724184; x=1700328984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VnfsphvXx+SeilBfaJRLO4IX/5mqgUJn5CDe2dtvVoQ=;
 b=C/OWNIya4OhvAkLVwN3gJvFkjkZQB3K3oUnE+1qO8B5lknDJjBgKZhhnATQD+jCKGT
 f2nPGxejYpRQGHNovKPhtVc81ik2cxWHdMtXLarDx2VksMJHWQ1S8KRxukVTlG7lB+tA
 rM4S4DIPullfuuATBsyb6aBJyqXWDAKz8nvB9dmNELLm8ZB5olj3HrxcG7wVLvH69+uU
 D4JORK7JuQIZIdnatfolk2MH73EqDqpXXL5B/f6ayR1ERzj3hEjFFwiu7nzLb9ndDLoL
 0Q11KvQXKVL+CvUovMWbbQBh23lpIfT170LTkXvo8721d7I1MuLyYnZiuRR1GOWlvhIq
 nX3A==
X-Gm-Message-State: AOJu0YwL0Dxqfhb8wvcuG7glSZV8qj2MA6+ciJMg6mYPTYj1X1lz/M3k
 QmIXBoA2Dyvb37wqZptA+D4Mzg==
X-Google-Smtp-Source: AGHT+IGb/vO9HqdyrwSEOaCwuZUwjCiTnnPkzxoedkINmyvIB4P1FJtR1ZYLfBOPCiBQTcSqB6loWw==
X-Received: by 2002:a17:90b:3e8c:b0:27d:492e:137a with SMTP id
 rj12-20020a17090b3e8c00b0027d492e137amr1966316pjb.45.1699724184286; 
 Sat, 11 Nov 2023 09:36:24 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com ([223.233.86.194])
 by smtp.googlemail.com with ESMTPSA id
 15-20020a17090a030f00b0027d0c3507fcsm3809877pje.9.2023.11.11.09.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 09:36:21 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Michal Simek <michal.simek@amd.com>, Bo Gan <ganboing@gmail.com>,
 Puhan Zhou <puh4n.zhou@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] drivers: pcie_xilinx: Fix "reg" not found error
Date: Sat, 11 Nov 2023 23:06:02 +0530
Message-Id: <20231111173604.93103-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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
Changes in v2:
====
- Remove global_data.h from include
- Use devm_ioremap instead of map_phsymem

 drivers/pci/pcie_xilinx.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index 53fd121e90..c1f5bbbb1b 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -8,11 +8,9 @@
 #include <common.h>
 #include <dm.h>
 #include <pci.h>
-#include <asm/global_data.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 /**
  * struct xilinx_pcie - Xilinx PCIe controller state
@@ -140,20 +138,14 @@ static int pcie_xilinx_write_config(struct udevice *bus, pci_dev_t bdf,
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
 
 	return 0;
 }
-- 
2.34.1

