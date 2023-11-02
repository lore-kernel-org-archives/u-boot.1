Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC10C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29564864C3;
	Thu,  2 Nov 2023 09:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Sw9F8lwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F176B86564; Thu,  2 Nov 2023 09:23:35 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B14688082A
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso5618885ad.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698913410; x=1699518210; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HLXclpofBdksOqrvJpmfjjkOEzmJWDaAUE/vBnNpw74=;
 b=Sw9F8lwZruFPowF0pnKHBPwjX/272VD/nKS8G53plBvzkJ2/2lrwL3g1hPuUlzBPKz
 jpbsdWOMI3WAKL8IWrzbr4oq6ndThzy1h26LV1ObGjAm+udRrI6Qb9IMelWFbvVBm5Nv
 IjsnCK3hDK9OkvgIrExmiRig+S0RczL68NnaxYi0fDX6rHuju9W2TEt0oQ1b0A6ZD5NO
 63/8Z0oxmTils7ymi2KpUYbZBhuE79g5bqshmBS3m8PA5ueUKtzNun/pLtFCr/pgm+a9
 YIHBtWw3nWSxENv1Dt15z6WkJT5lCOWMOICRKwBpPy0BMmYuw5vGQRE8s2D3ne4e6ey7
 D1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698913410; x=1699518210;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HLXclpofBdksOqrvJpmfjjkOEzmJWDaAUE/vBnNpw74=;
 b=nLWULr/+EUeDslMC/vVtiwL0F+2gXNl30dcbVWLKwTQBdE+UDkRjuo3pB1n25ujDco
 Jstv1CHKs2HVjm/vrEK262AVdASkE7WGLaSoA9bdPm3oASjO94YZt6E+F6aMLPSsYZWj
 KktR/Z2HxRM9QxgO4OM+ZeqQvhvF6ze2O65R/uACTJzY1I4w5EcR3Mbx2fJ26zgruCMj
 JLejZEouIWbmppa3SyK60t2ZJloK/XmoT0mwxNI2h4Vd6Tf8w8FP7xj8ZcROoF/Wj6Vm
 8NG5GWpZ02cjNdjHKS5MGKMfRVFU7dAw8CVAdrvVpdNQHh6FTn440VHKCRFN66HkUB0T
 8R3g==
X-Gm-Message-State: AOJu0YyI0uV6bcW4YXEFPJN04I+D+R9+EgkwkdKYf2BvY/mgffctsG4B
 Zh+1QGOlHUN3AlL4xsr8zJHH0jCPblsc1D2KWtNSxw==
X-Google-Smtp-Source: AGHT+IGwrhebBSPnJp/N8RxTPp7Mc6skFF5KNTGzG2Djrcta0WRrhbYGYo4TyeZ0cku/UsTjyZddfw==
X-Received: by 2002:a17:902:f2d1:b0:1ca:1be4:bda4 with SMTP id
 h17-20020a170902f2d100b001ca1be4bda4mr16559465plc.4.1698913409788; 
 Thu, 02 Nov 2023 01:23:29 -0700 (PDT)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:5315:cd32:1e1a:95f3:9ce0:bc69])
 by smtp.googlemail.com with ESMTPSA id
 l9-20020a170902d34900b001cc47c1c29csm2546789plk.84.2023.11.02.01.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 01:23:29 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Puhan Zhou <puh4n.zhou@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Alexander Dahl <ada@thorsis.com>, Jonas Karlman <jonas@kwiboo.se>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] drivers: pcie_xilinx: Fix "reg" not found error
Date: Thu,  2 Nov 2023 13:53:00 +0530
Message-Id: <20231102082303.354944-1-mchitale@ventanamicro.com>
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
 drivers/pci/pcie_xilinx.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index 53fd121e90..20b630027f 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -140,20 +140,14 @@ static int pcie_xilinx_write_config(struct udevice *bus, pci_dev_t bdf,
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
+	pcie->cfg_base = map_physmem(addr, size, MAP_NOCACHE);
 
 	return 0;
 }
-- 
2.34.1

