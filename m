Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC08C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 17:36:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B17008700D;
	Sat, 11 Nov 2023 18:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="j+qw4nMQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B31A786FF2; Sat, 11 Nov 2023 18:36:38 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A68787015
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 18:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2802d218242so2891297a91.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 09:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699724194; x=1700328994; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Ll9TryH6bS1Vmm0wPUeyh8HzcnZlYdBmKnaSNQo6W4=;
 b=j+qw4nMQweGSYtSmwXjmPrBO9xTPqWb+9c95ytAIt2QIfEhxb0l2UALNtE6Xg3XclJ
 V8+kAQTb0yuuGzx5IDm8IgIJBIU0GfEP0Q6xXx+oy2kwpIuKfzcvAHIuZQZDQTfZKH/A
 VHl9NA2zvyHxWoAA76n9tYlQE/Hz2ZPnEEZA7BiQ+ZAkvZR/3fvA1hhJffShC6+yRqt0
 L7pKn5f7Kf4IZa9JjeDYX/bMJEZIaYKy4Fj5kYlA9ij4fnnRDLssG2AJP9onBzbqQpdV
 CyNJutTmz+CNGjh1irBOYTs6KscZpA+/ZxclmeFE2ZMnIXoJfB0t1f+GTdzIAQxBlpPE
 nOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699724194; x=1700328994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Ll9TryH6bS1Vmm0wPUeyh8HzcnZlYdBmKnaSNQo6W4=;
 b=cTwHIzpjRqZaDPZPZFOgOXSjbI4fwNJebe3D9Pf0KxB7Aw7J7t+RFs/eFVbvGu0gGL
 UyBFWqOrdunOAtUROLz+qRLlk1TX75Cl+8tbYRq1ZYYjh0YtHGXn6to0jjTR9XwRBmwb
 vO8B54gSIXpTvUXZju39o6BKlfNLjdAQOF0HmsvioWwi19Dl+z9pihPCiBfz/qjirAkx
 5zEoP3nvJpWRO4wNc5knwBacwA6XtyATWZ3KwOOamdpOduYwHjXCDxYKrg8C2QatSyYv
 3HVLiKFVDOdCkOHKqSX3MQTo5wo72S27wIc4Trrn3ziQuvCwnEvRic8LeUEWqtZB9nrb
 yWmw==
X-Gm-Message-State: AOJu0YxXDoNb4ml+eaa1xfqSLUsxgF8RiJvfF/+1xZAMG42YM2zWhQp8
 q1kKI3JSO2eGpEflOncgJ5yupfH+gkOztetdlqG4yw==
X-Google-Smtp-Source: AGHT+IFO3vuHQiCdpJju82vT6Ro0YPENmkDDSJK+ARdjg5BlKojLbjJbzvp9u3MM8vLorteVO1JPTQ==
X-Received: by 2002:a17:90b:4b0c:b0:279:2dac:80b3 with SMTP id
 lx12-20020a17090b4b0c00b002792dac80b3mr2508146pjb.44.1699724194409; 
 Sat, 11 Nov 2023 09:36:34 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com ([223.233.86.194])
 by smtp.googlemail.com with ESMTPSA id
 15-20020a17090a030f00b0027d0c3507fcsm3809877pje.9.2023.11.11.09.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 09:36:32 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Michal Simek <michal.simek@amd.com>, Bo Gan <ganboing@gmail.com>,
 Puhan Zhou <puh4n.zhou@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] pci: xilinx: Enable MMIO region
Date: Sat, 11 Nov 2023 23:06:04 +0530
Message-Id: <20231111173604.93103-3-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231111173604.93103-1-mchitale@ventanamicro.com>
References: <20231111173604.93103-1-mchitale@ventanamicro.com>
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
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
Changes in v2:
====
Add Reviewed-by Tag.

 drivers/pci/pcie_xilinx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index c1f5bbbb1b..7052d6dac8 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -23,6 +23,8 @@ struct xilinx_pcie {
 /* Register definitions */
 #define XILINX_PCIE_REG_PSCR		0x144
 #define XILINX_PCIE_REG_PSCR_LNKUP	BIT(11)
+#define XILINX_PCIE_REG_RPSC		0x148
+#define XILINX_PCIE_REG_RPSC_BEN	BIT(0)
 
 /**
  * pcie_xilinx_link_up() - Check whether the PCIe link is up
@@ -140,6 +142,7 @@ static int pcie_xilinx_of_to_plat(struct udevice *dev)
 	struct xilinx_pcie *pcie = dev_get_priv(dev);
 	fdt_addr_t addr;
 	fdt_size_t size;
+	u32 rpsc;
 
 	addr = dev_read_addr_size(dev, &size);
 	if (addr == FDT_ADDR_T_NONE)
@@ -147,6 +150,11 @@ static int pcie_xilinx_of_to_plat(struct udevice *dev)
 
 	pcie->cfg_base = devm_ioremap(dev, addr, size);
 
+	/* Enable the Bridge enable bit */
+	rpsc = __raw_readl(pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+	rpsc |= XILINX_PCIE_REG_RPSC_BEN;
+	__raw_writel(rpsc, pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+
 	return 0;
 }
 
-- 
2.34.1

