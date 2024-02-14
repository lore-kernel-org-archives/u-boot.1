Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3093C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 20:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A82AA87C2D;
	Wed, 14 Feb 2024 21:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hCReB9fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A59787CEC; Wed, 14 Feb 2024 21:31:45 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 340A286F67
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 21:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51182ece606so201639e87.0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 12:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707942686; x=1708547486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mNwD+xUhJEJ0KwQ2uoADHaKoP2gdzaqm4sAptBQg6zE=;
 b=hCReB9fsIZLhg7bIe4pLn+L/m/a0741mESu/GEVLmtBJPmc45/nQ+Gj7zGdRyVF69a
 o/4Qm+EWLSOup4pK/W9GKDfHyakgPNXm4RfCPEdq+0I89xVw+OrWZdig7a5n3u47uVCG
 Lnw3vzmApcZak3TPNSqC2AVcR+vQDPVDLmZn87PLSIlHuLS2aVwh0tXIT97yY7BvoSee
 wy7HqXEcHqBmEefd2yYuAfyxxTConaSZmJiB+scQ23CxiMt6Dizn9/x84daG0X7m3d+l
 8TvwTRC4k21dwMfve1J1TLjcG9njr3DBnafshmCLqDJ87rYakU7N88E/pGDuomrHaNiz
 llEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707942686; x=1708547486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNwD+xUhJEJ0KwQ2uoADHaKoP2gdzaqm4sAptBQg6zE=;
 b=an1vs5L0AUjiE2inxL6o+GuhZxWoqpFj5TFI9aqKEuaVop1JvDbvE7RZe7JUzoXkyC
 bB7rdclCFye6QK0xAsiX/uz1961Thx/Dg5LNCRqcHIsPlR1NpTRHfVvlWiaSZpwFRTjE
 iQUXVdY4gIo+UN7HvI0wVuA3nSsVPGdqxEkt3ACD0F6+vuzy3D0K6x6B0RUbKsFoHVpF
 p7LRPttCXRFYxI42lF4K+W+VfIIERY4nv1BGfRBkq7z4Vz4GCnPOHJHxRgBFaVKU2ARo
 n/z9KpfHbD9Qv+x9eftGzAjqEcZXyORKVjVZAzLM4T8zB7zW82rb97mNYvYp18RoMGgC
 bSNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURaF7zh9GS1HX8hdEDdkWqxuSY6QC/G9sYo1D+dENlpkdE+J8YQeySiylHIJCbTkzEYLrUEs9wwbbqVUeUQ4CAgxwaPA==
X-Gm-Message-State: AOJu0Yzn7JGdTWnmM82SOAg2QSO5dVBbpuQZSz1AHtsX+dxRgsQrUsKx
 la45KQ/4VUXh9DgZpXQzTqAIk44bIZvalSuUwbYDuj6bmqnvU8T0
X-Google-Smtp-Source: AGHT+IHYgbqmzdwQaACG15wCmn3sJsmBVU7Vxg2Z71EUMdTh7sk6tEMQXe0bOBi9q5blGDZ5BTwY0w==
X-Received: by 2002:a05:6512:34c5:b0:511:853e:8d72 with SMTP id
 w5-20020a05651234c500b00511853e8d72mr904559lfr.34.1707942686134; 
 Wed, 14 Feb 2024 12:31:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXnucYvkDVUXxiJZwz9sPBjmA3Qaqrm71mKBYlnI/srYJYq56DZydCBQVxjSylPyLGL/x9KmgeAFji9Ew2pRGrETCS/jvlodEcxx1cIRZ0vfvtGFq/Ybw==
Received: from user-PC.. ([37.232.111.23]) by smtp.gmail.com with ESMTPSA id
 o3-20020ac24943000000b00511525b9d57sm1793028lfi.43.2024.02.14.12.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 12:31:25 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Maksim Kiselev <bigunclemax@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v1] pci-host-ecam-generic: Convert to ofnode functions
Date: Wed, 14 Feb 2024 23:30:01 +0300
Message-Id: <20240214203001.150942-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
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

FDT functions is not working when OF_LIVE is enabled.
Convert fdt parsing functions to ofnode parsing functions

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/pci/pcie_ecam_generic.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie_ecam_generic.c b/drivers/pci/pcie_ecam_generic.c
index 2e089b0e03..f5bc6e3d92 100644
--- a/drivers/pci/pcie_ecam_generic.c
+++ b/drivers/pci/pcie_ecam_generic.c
@@ -10,7 +10,7 @@
 #include <common.h>
 #include <dm.h>
 #include <pci.h>
-#include <asm/global_data.h>
+#include <linux/ioport.h>
 #include <linux/printk.h>
 
 #include <asm/io.h>
@@ -133,18 +133,17 @@ static int pci_generic_ecam_write_config(struct udevice *bus, pci_dev_t bdf,
 static int pci_generic_ecam_of_to_plat(struct udevice *dev)
 {
 	struct generic_ecam_pcie *pcie = dev_get_priv(dev);
-	struct fdt_resource reg_res;
-	DECLARE_GLOBAL_DATA_PTR;
+	ofnode node = dev_ofnode(dev);
+	struct resource reg_res;
 	int err;
 
-	err = fdt_get_resource(gd->fdt_blob, dev_of_offset(dev), "reg",
-			       0, &reg_res);
+	err = ofnode_read_resource(node, 0, &reg_res);
 	if (err < 0) {
 		pr_err("\"reg\" resource not found\n");
 		return err;
 	}
 
-	pcie->size = fdt_resource_size(&reg_res);
+	pcie->size = resource_size(&reg_res);
 	pcie->cfg_base = map_physmem(reg_res.start, pcie->size, MAP_NOCACHE);
 
 	return 0;
-- 
2.40.1

