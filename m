Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCD2C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 16:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4BE687479;
	Thu, 16 Nov 2023 17:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="iD54xDxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0419D874CF; Thu, 16 Nov 2023 17:51:28 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4291F874CF
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 17:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc3c51f830so8668305ad.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 08:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700153483; x=1700758283; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6PIjTiKBh+QObxclUAqHzRmHb3g+ca6/2KWgDvbLt6U=;
 b=iD54xDxfTCqkX7nQPtyfJulGlaylzO7m8dl1zpRwEcIuNLUGsdSNgDDVtFSuPgqNww
 QLnDeP9rRNmftwJskeAnWrLHvuYu0UGvuw/NDkIz3oStTIqfQtQn154S2VAfZrZD+/Bk
 OTH9eu84f477UmOYQ2wVEQO9InACDd4/DNtkQJ9LTew7cG2ltRVnGrc7M/VLMoSr9PhX
 znTNjbtRqtxCLkPMFoQsZVDQ6HyN2/HNS78ThEle5i+NDq8PPgniG4DvB+IrNR9g+788
 f50hlavPQlCb6tZihFOntXLx52rHgBdngMos3dDj7LteL7IxuCdVvVDfODEg9c630SaY
 SyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700153483; x=1700758283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6PIjTiKBh+QObxclUAqHzRmHb3g+ca6/2KWgDvbLt6U=;
 b=HpuaHZnTciqQA2UKAV9bs+UqXQDQ+/NLeImmm2vA+tUTOZNAYXi9aQVD3t3DS1pfP1
 WGgHtkWw3F6hSrXHO26xXsx8i3IqnoYzzsvc/S6laQMhHlCOVDEjNtZBa09QLop4+4Jw
 HPslfAowP7zw2R5qzdPXdhEWSzVa4qhUSTZ1vM4BuzRov+9lExIv2WBlJ6URp5O0U7Hr
 Jye7tkfzRfi5NSWSmNep53PWdaHbcgNPVqA5BRHaO0XkskAlRRIrs3k6eVHDzntJzbah
 +lCTtKL0u9934HxsTMIz8yRBRDL/x966GycsX+L9dauU9y40RS6Z3tRLTeAy8p7VZe49
 m8yQ==
X-Gm-Message-State: AOJu0YwYTGbksI8OWpjE6Cq1ejovkBiOuOWZZoMIskl7T6/mE9rKGaL0
 IhqxRkpHrw8DXQfPbj1swn2drg==
X-Google-Smtp-Source: AGHT+IGKyTYno9quxwnPIX9pfrBgSG2aZ++743eqGXDh7uvsO4orFz4UpQLQH0EMPvVvYBP0s103kw==
X-Received: by 2002:a17:902:aa4a:b0:1ca:4092:7200 with SMTP id
 c10-20020a170902aa4a00b001ca40927200mr8325740plr.54.1700153483550; 
 Thu, 16 Nov 2023 08:51:23 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:57e3:f37f:e352:7f6c:bf18:83f0])
 by smtp.googlemail.com with ESMTPSA id
 j13-20020a170902da8d00b001cc32261bdfsm9438696plx.38.2023.11.16.08.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 08:51:23 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Michal Simek <michal.simek@amd.com>, Bo Gan <ganboing@gmail.com>,
 Puhan Zhou <puh4n.zhou@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Shengyu Qu <wiagn233@outlook.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/2] pci: xilinx: Enable MMIO region
Date: Thu, 16 Nov 2023 22:21:03 +0530
Message-Id: <20231116165103.140968-3-mchitale@ventanamicro.com>
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

The host bridge MMIO region is disabled by default due to which MMIO
accesses cause an exception. Fix it by setting the bridge enable bit.
This change is ported from the linux pcie-xilinx driver.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Michal Simek <michal.simek@amd.com>
---
 drivers/pci/pcie_xilinx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index fdc9b08c10..3db460b5f9 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -24,6 +24,8 @@ struct xilinx_pcie {
 /* Register definitions */
 #define XILINX_PCIE_REG_PSCR		0x144
 #define XILINX_PCIE_REG_PSCR_LNKUP	BIT(11)
+#define XILINX_PCIE_REG_RPSC		0x148
+#define XILINX_PCIE_REG_RPSC_BEN	BIT(0)
 
 /**
  * pcie_xilinx_link_up() - Check whether the PCIe link is up
@@ -141,6 +143,7 @@ static int pcie_xilinx_of_to_plat(struct udevice *dev)
 	struct xilinx_pcie *pcie = dev_get_priv(dev);
 	fdt_addr_t addr;
 	fdt_size_t size;
+	u32 rpsc;
 
 	addr = dev_read_addr_size(dev, &size);
 	if (addr == FDT_ADDR_T_NONE)
@@ -150,6 +153,11 @@ static int pcie_xilinx_of_to_plat(struct udevice *dev)
 	if (IS_ERR(pcie->cfg_base))
 		return PTR_ERR(pcie->cfg_base);
 
+	/* Enable the Bridge enable bit */
+	rpsc = __raw_readl(pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+	rpsc |= XILINX_PCIE_REG_RPSC_BEN;
+	__raw_writel(rpsc, pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+
 	return 0;
 }
 
-- 
2.34.1

