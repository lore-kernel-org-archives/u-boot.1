Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EDDC4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 780EA8770D;
	Thu,  2 Nov 2023 09:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jGquWmyg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F3487703; Thu,  2 Nov 2023 09:24:05 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0183876FA
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5b9a453d3d3so512698a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698913439; x=1699518239; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cw0m53VIGDOsBzLQEuTXXxUZKAaL2GOgI8UyR0vBlVw=;
 b=jGquWmygctvMuGex/wigZ8ZPj3bGemXRi3DrIKdLOM8H1XGj8hsI9Y0rt34oHEfi2K
 hA2KrflNbPtqNbl8yMHG2sS/4NYC3frWjxgaQIR6FHs7UbM3/pPdmNE5rULON9oG6J0G
 OFStmtJLYqN0VhkGmn+CKBsVdpCl3RXSAueRn4S2q6gVpOoWw4ls3CGjJKntHx5YXm3t
 lM0hAGOKrXZRrn2rrhNEhLdpu+vvQgocPaMIyhPuJomAlSLbmP8i5GMMfhLYB/VCJViF
 AlSwj396J2BIXhhCLc5zi5gztPlw2kwIavy/aWBi9Zdi8tTvtii3CaNoQkfsft7qWIny
 raLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698913439; x=1699518239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cw0m53VIGDOsBzLQEuTXXxUZKAaL2GOgI8UyR0vBlVw=;
 b=B9SLqFXO07ud8Nsxu3UZKHT7EO2Z1wUfI/aDUqqIlHa7PbothGYetd4ux02kyYd1Ah
 CDPGxjpHCCFb+1KazPU1aNhERgXf55b0JhiKuMoQqSER6JNe/UQdy53wtVZkJn0Celyq
 vqDs5M+ZT+n6Vn/B0Qpkx/fJi1E8px3ssIMQwVdSikgGs7vCnkzXw7w6PIgVH8HIcJX7
 uWcHKTfB7ELlT6qVrSJGYENUOQSFhpmj7EBIVcoTppPzLyTzYGYoGRbsp5LpzVkWfLV0
 vPJY8YLu0LLaF4zeq6p6sV461/0q26gdnmTsKQNhY/qUi0e4dNKhMURvW8S2SPiloBIl
 i8iA==
X-Gm-Message-State: AOJu0YzRVDAgOabAvSRDsiA8SrvgMB8c3VdMvHl0zf3tjFIBUv/PWA+s
 OuI6BX2m8rdJdM+TOj4gJFmxqA==
X-Google-Smtp-Source: AGHT+IHzgAgC7MNE2xTpUUD+J/wTsSpuEBdyyAT8w2koEfyKArKtzit3NCZ3PhRYBMTNe4gqo07O4g==
X-Received: by 2002:a05:6a21:3d83:b0:17f:cf8e:241e with SMTP id
 bj3-20020a056a213d8300b0017fcf8e241emr14579531pzc.41.1698913439055; 
 Thu, 02 Nov 2023 01:23:59 -0700 (PDT)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:5315:cd32:1e1a:95f3:9ce0:bc69])
 by smtp.googlemail.com with ESMTPSA id
 l9-20020a170902d34900b001cc47c1c29csm2546789plk.84.2023.11.02.01.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 01:23:58 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Michal Simek <michal.simek@amd.com>, Bo Gan <ganboing@gmail.com>,
 Puhan Zhou <puh4n.zhou@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pci: xilinx: Enable MMIO region
Date: Thu,  2 Nov 2023 13:53:03 +0530
Message-Id: <20231102082303.354944-4-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231102082303.354944-1-mchitale@ventanamicro.com>
References: <20231102082303.354944-1-mchitale@ventanamicro.com>
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


The host bridge MMIO region is disabled by default due to which MMIO
accesses cause an exception. Fix it by setting the bridge enable bit.
This change is ported from the linux pcie-xilinx driver.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/pci/pcie_xilinx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index 20b630027f..d1fbd40175 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -25,6 +25,8 @@ struct xilinx_pcie {
 /* Register definitions */
 #define XILINX_PCIE_REG_PSCR		0x144
 #define XILINX_PCIE_REG_PSCR_LNKUP	BIT(11)
+#define XILINX_PCIE_REG_RPSC		0x148
+#define XILINX_PCIE_REG_RPSC_BEN	BIT(0)
 
 /**
  * pcie_xilinx_link_up() - Check whether the PCIe link is up
@@ -142,6 +144,7 @@ static int pcie_xilinx_of_to_plat(struct udevice *dev)
 	struct xilinx_pcie *pcie = dev_get_priv(dev);
 	fdt_addr_t addr;
 	fdt_size_t size;
+	u32 rpsc;
 
 	addr = dev_read_addr_size(dev, &size);
 	if (addr == FDT_ADDR_T_NONE)
@@ -149,6 +152,11 @@ static int pcie_xilinx_of_to_plat(struct udevice *dev)
 
 	pcie->cfg_base = map_physmem(addr, size, MAP_NOCACHE);
 
+	/* Enable the Bridge enable bit */
+	rpsc = __raw_readl(pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+	rpsc |= XILINX_PCIE_REG_RPSC_BEN;
+	__raw_writel(rpsc, pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+
 	return 0;
 }
 
-- 
2.34.1

