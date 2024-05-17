Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E63C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D1A8854B;
	Fri, 17 May 2024 20:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="c/C5HlwP";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBOpO8/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 288098853E; Fri, 17 May 2024 20:15:03 +0200 (CEST)
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com
 [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0AE88540
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 11AFC13814F9;
 Fri, 17 May 2024 14:15:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Fri, 17 May 2024 14:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969700;
 x=1716056100; bh=MSzSQ1dSj3f5QzEIvjJj71+RlzAvGxEFWZVc7ZeXqcQ=; b=
 c/C5HlwPIwX3satkwSJPJXKAjhD4w59yNiDrCnthqv4wOBt9IhO90f9BHoT/8J1u
 xmXn20YyU1EPGo43ut4KhHOnDIa05xl5OWvzPKHgU/pj1omx4m95F9dOC5crbDj+
 K2Ub6zsaRuz3JMkByEsfKvH4NipmZEW82zVUWeXz9BXPOc08ms2mbTEzSjyrrQ2a
 zb1VAj8P6dvbvvnoY0C+vQjsiPE8pHoi7wHzlZbq1yfzZdTDzxteENAn4AksEBZK
 X+a3FicgO8KQcfB17/inPB0SlS1X/2s86/W0RrfZOn9FNiUAHgLwvcy6UF/PWQC7
 4KrmGAsJL8+NGLW7k28WtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969700; x=
 1716056100; bh=MSzSQ1dSj3f5QzEIvjJj71+RlzAvGxEFWZVc7ZeXqcQ=; b=R
 BOpO8/Et6whPqZabiqwVU00ocglLxbesHRXPi0pIsSy+EbotI5E783V0bK7qXEpZ
 bc+p2OmcWuW/r/2EqAVCjc31HrzHDV0Fx0sp6RibfM0dEqhTU3KrV3tKk3EKbj5g
 gtjLXVYZGH4VTO/GFW1EK7V20k1TT2is2eZ7MgI4nZprjx8C5gdh4+WBFQMXCGb2
 AaCqkWdXUW5ZwHidmHpCccvlNSdK3W8XJ1fdXOfHGP6Q8BXW2VAeC+DKYr178wsW
 lUWRhqb4ksl6+U7/aYZXD7g3Lbv+rBFovIhFKmHk6HfDLVQ0nne2zh4V8GcfRBe7
 Hau+suI4i23arp8MxSfeg==
X-ME-Sender: <xms:o55HZpWkEGpoWlbH17a1lL3Qs-Z2sFdZfiDX6WiRrhAnpxlt3v6kPQ>
 <xme:o55HZpkNRlQCM3_IfeToJ20sDwx9xrzuctaIW9Fgy1UB0qhIq4eN9_GxLGSjkRZMp
 UKSEqZKWTvaMtvOteo>
X-ME-Received: <xmr:o55HZlaYdwC9dKPEk57zh99mUZD-83yeynZ2BpTHPivReSN7RbvD3IU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:o55HZsWM9O1mvrtx9jcIqxFg8CsIpTFaJjtEfMF6Oc2O0O-J3fdiMg>
 <xmx:o55HZjmyeN86md_zx0pwzZ2CMCvn_BpgUH1QeWjVaxPLmI1VkbXrZw>
 <xmx:o55HZpe09dGGms9FIOALaiwQ7CnpNOTTIZE7YirdJ-_12Es7I3PITQ>
 <xmx:o55HZtEfrwV4YKRean-N5-zKYY3sqZ42opJyTiYvHOtrlIG4wSNCtg>
 <xmx:pJ5HZhcbzu1Nco_fAukWoZTv1bMoY9AMAoZEMjAg9cBiinYvCDR7_KOL>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:14:58 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:52 +0100
Subject: [PATCH v3 04/12] ahci: DMA addressing fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-4-1ea7d23f4a1d@flygoat.com>
References: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
In-Reply-To: <20240517-boston-v3-0-1ea7d23f4a1d@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8830;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=fw17qbL3Fk/uTmZo+IITOEuVcTdCWfeQs2YU77ePoFU=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebMPZWkbvHvI/KNGcNMxs/qkwHuhxXsesYQxFf71a
 WabfW5ZRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAExk8W1Ghm3myYVl5Ye3CJRM
 SWZ8Xfr1vpnoH6eJ3uZ533i4T7zkrWZkWGpjuE8sgFGv8vr2/AquaxuYlq6eNa912hmzqQYvsla
 ZsQMA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Ensure that we are using correct physical/virtual address for
DMA buffer write and hardware register settings.

The convention is: in ahci_ioports all pointers are virtual,
that will be converted to physical address when writing to
hardware registers or into sg/cmd_tbl.

Also fixed 64bit physical address support for dwc_ahsata, ensure
higher bits are written into registers/sg properly.

Use memalign for allocating aligned buffer in dwc_ahsata so we
don't have to do our own alignment in driver.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/ata/ahci.c            | 34 ++++++++++++++++-----------------
 drivers/ata/dwc_ahsata.c      | 44 +++++++++++++++++++++++--------------------
 drivers/ata/dwc_ahsata_priv.h |  2 --
 include/ahci.h                |  4 ++--
 4 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ac869296d525..21b13fedac50 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -421,7 +421,7 @@ static int ahci_fill_sg(struct ahci_uc_priv *uc_priv, u8 port,
 
 static void ahci_fill_cmd_slot(struct ahci_ioports *pp, u32 opts)
 {
-	phys_addr_t pa = virt_to_phys((void *)pp->cmd_tbl);
+	phys_addr_t pa = virt_to_phys(pp->cmd_tbl);
 
 	pp->cmd_slot->opts = cpu_to_le32(opts);
 	pp->cmd_slot->status = 0;
@@ -450,7 +450,7 @@ static int ahci_port_start(struct ahci_uc_priv *uc_priv, u8 port)
 {
 	struct ahci_ioports *pp = &(uc_priv->port[port]);
 	void __iomem *port_mmio = pp->port_mmio;
-	u64 dma_addr;
+	phys_addr_t dma_addr;
 	u32 port_status;
 	void __iomem *mem;
 
@@ -474,34 +474,32 @@ static int ahci_port_start(struct ahci_uc_priv *uc_priv, u8 port)
 	 * First item in chunk of DMA memory: 32-slot command table,
 	 * 32 bytes each in size
 	 */
-	pp->cmd_slot =
-		(struct ahci_cmd_hdr *)(uintptr_t)virt_to_phys((void *)mem);
-	debug("cmd_slot = %p\n", pp->cmd_slot);
-	mem += (AHCI_CMD_SLOT_SZ + 224);
+	pp->cmd_slot = (struct ahci_cmd_hdr *)mem;
+	mem += AHCI_CMD_SLOT_SZ * AHCI_MAX_CMD_SLOT;
 
 	/*
 	 * Second item: Received-FIS area
 	 */
-	pp->rx_fis = virt_to_phys((void *)mem);
+	pp->rx_fis = mem;
 	mem += AHCI_RX_FIS_SZ;
 
 	/*
 	 * Third item: data area for storing a single command
 	 * and its scatter-gather table
 	 */
-	pp->cmd_tbl = virt_to_phys((void *)mem);
-	debug("cmd_tbl_dma = %lx\n", pp->cmd_tbl);
+	pp->cmd_tbl = mem;
 
 	mem += AHCI_CMD_TBL_HDR;
-	pp->cmd_tbl_sg =
-			(struct ahci_sg *)(uintptr_t)virt_to_phys((void *)mem);
-
-	dma_addr = (ulong)pp->cmd_slot;
-	writel_with_flush(dma_addr, port_mmio + PORT_LST_ADDR);
-	writel_with_flush(dma_addr >> 32, port_mmio + PORT_LST_ADDR_HI);
-	dma_addr = (ulong)pp->rx_fis;
-	writel_with_flush(dma_addr, port_mmio + PORT_FIS_ADDR);
-	writel_with_flush(dma_addr >> 32, port_mmio + PORT_FIS_ADDR_HI);
+	pp->cmd_tbl_sg = (struct ahci_sg *)(mem);
+
+	dma_addr = virt_to_phys(pp->cmd_slot);
+	debug("cmd_slot_dma = 0x%08llx\n", (u64)dma_addr);
+	writel_with_flush(lower_32_bits(dma_addr), port_mmio + PORT_LST_ADDR);
+	writel_with_flush(upper_32_bits(dma_addr), port_mmio + PORT_LST_ADDR_HI);
+	dma_addr = virt_to_phys(pp->rx_fis);
+	debug("rx_fis_dma = 0x%08llx\n", (u64)dma_addr);
+	writel_with_flush(lower_32_bits(dma_addr), port_mmio + PORT_FIS_ADDR);
+	writel_with_flush(upper_32_bits(dma_addr), port_mmio + PORT_FIS_ADDR_HI);
 
 #ifdef CONFIG_SUNXI_AHCI
 	sunxi_dma_init(port_mmio);
diff --git a/drivers/ata/dwc_ahsata.c b/drivers/ata/dwc_ahsata.c
index a29d641343ed..c2cde48c0b55 100644
--- a/drivers/ata/dwc_ahsata.c
+++ b/drivers/ata/dwc_ahsata.c
@@ -329,6 +329,7 @@ static int ahci_fill_sg(struct ahci_uc_priv *uc_priv, u8 port,
 {
 	struct ahci_ioports *pp = &uc_priv->port[port];
 	struct ahci_sg *ahci_sg = pp->cmd_tbl_sg;
+	phys_addr_t pa = virt_to_phys(buf);
 	u32 sg_count, max_bytes;
 	int i;
 
@@ -340,9 +341,8 @@ static int ahci_fill_sg(struct ahci_uc_priv *uc_priv, u8 port,
 	}
 
 	for (i = 0; i < sg_count; i++) {
-		ahci_sg->addr =
-			cpu_to_le32((u32)buf + i * max_bytes);
-		ahci_sg->addr_hi = 0;
+		ahci_sg->addr = cpu_to_le32(lower_32_bits(pa));
+		ahci_sg->addr_hi = cpu_to_le32(upper_32_bits(pa));
 		ahci_sg->flags_size = cpu_to_le32(0x3fffff &
 					(buf_len < max_bytes
 					? (buf_len - 1)
@@ -358,14 +358,14 @@ static void ahci_fill_cmd_slot(struct ahci_ioports *pp, u32 cmd_slot, u32 opts)
 {
 	struct ahci_cmd_hdr *cmd_hdr = (struct ahci_cmd_hdr *)(pp->cmd_slot +
 					AHCI_CMD_SLOT_SZ * cmd_slot);
+	phys_addr_t pa = virt_to_phys(pp->cmd_tbl);
 
 	memset(cmd_hdr, 0, AHCI_CMD_SLOT_SZ);
 	cmd_hdr->opts = cpu_to_le32(opts);
 	cmd_hdr->status = 0;
-	pp->cmd_slot->tbl_addr = cpu_to_le32((u32)pp->cmd_tbl & 0xffffffff);
+	pp->cmd_slot->tbl_addr = cpu_to_le32(lower_32_bits(pa));
 #ifdef CONFIG_PHYS_64BIT
-	pp->cmd_slot->tbl_addr_hi =
-	    cpu_to_le32((u32)(((pp->cmd_tbl) >> 16) >> 16));
+	pp->cmd_slot->tbl_addr_hi = cpu_to_le32(upper_32_bits(pa));
 #endif
 }
 
@@ -403,7 +403,7 @@ static int ahci_exec_ata_cmd(struct ahci_uc_priv *uc_priv, u8 port,
 	}
 	ahci_fill_cmd_slot(pp, cmd_slot, opts);
 
-	flush_cache((int)(pp->cmd_slot), AHCI_PORT_PRIV_DMA_SZ);
+	flush_cache((ulong)(pp->cmd_slot), AHCI_PORT_PRIV_DMA_SZ);
 	writel_with_flush(1 << cmd_slot, &port_mmio->ci);
 
 	if (waiting_for_cmd_completed((u8 *)&port_mmio->ci, 10000,
@@ -411,8 +411,8 @@ static int ahci_exec_ata_cmd(struct ahci_uc_priv *uc_priv, u8 port,
 		printf("timeout exit!\n");
 		return -1;
 	}
-	invalidate_dcache_range((int)(pp->cmd_slot),
-				(int)(pp->cmd_slot)+AHCI_PORT_PRIV_DMA_SZ);
+	invalidate_dcache_range((ulong)(pp->cmd_slot),
+				(ulong)(pp->cmd_slot) + AHCI_PORT_PRIV_DMA_SZ);
 	debug("ahci_exec_ata_cmd: %d byte transferred.\n",
 	      pp->cmd_slot->status);
 	if (!is_write)
@@ -440,8 +440,9 @@ static int ahci_port_start(struct ahci_uc_priv *uc_priv, u8 port)
 {
 	struct ahci_ioports *pp = &uc_priv->port[port];
 	struct sata_port_regs *port_mmio = pp->port_mmio;
+	phys_addr_t dma_addr;
 	u32 port_status;
-	u32 mem;
+	void *mem;
 	int timeout = 10000000;
 
 	debug("Enter start port: %d\n", port);
@@ -452,22 +453,20 @@ static int ahci_port_start(struct ahci_uc_priv *uc_priv, u8 port)
 		return -1;
 	}
 
-	mem = (u32)malloc(AHCI_PORT_PRIV_DMA_SZ + 1024);
+	mem = memalign(2048, AHCI_PORT_PRIV_DMA_SZ);
 	if (!mem) {
 		printf("No mem for table!\n");
 		return -ENOMEM;
 	}
 
-	mem = (mem + 0x400) & (~0x3ff);	/* Aligned to 1024-bytes */
-	memset((u8 *)mem, 0, AHCI_PORT_PRIV_DMA_SZ);
+	memset(mem, 0, AHCI_PORT_PRIV_DMA_SZ);
 
 	/*
 	 * First item in chunk of DMA memory: 32-slot command table,
 	 * 32 bytes each in size
 	 */
 	pp->cmd_slot = (struct ahci_cmd_hdr *)mem;
-	debug("cmd_slot = 0x%x\n", (unsigned int) pp->cmd_slot);
-	mem += (AHCI_CMD_SLOT_SZ * DWC_AHSATA_MAX_CMD_SLOTS);
+	mem += AHCI_CMD_SLOT_SZ * AHCI_MAX_CMD_SLOT;
 
 	/*
 	 * Second item: Received-FIS area, 256-Byte aligned
@@ -480,14 +479,19 @@ static int ahci_port_start(struct ahci_uc_priv *uc_priv, u8 port)
 	 * and its scatter-gather table
 	 */
 	pp->cmd_tbl = mem;
-	debug("cmd_tbl_dma = 0x%lx\n", pp->cmd_tbl);
-
 	mem += AHCI_CMD_TBL_HDR;
+	pp->cmd_tbl_sg = (struct ahci_sg *)mem;
 
 	writel_with_flush(0x00004444, &port_mmio->dmacr);
-	pp->cmd_tbl_sg = (struct ahci_sg *)mem;
-	writel_with_flush((u32)pp->cmd_slot, &port_mmio->clb);
-	writel_with_flush(pp->rx_fis, &port_mmio->fb);
+	dma_addr = virt_to_phys(pp->cmd_slot);
+	debug("cmd_slot_dma = 0x%08llx\n", (u64)dma_addr);
+	writel_with_flush(lower_32_bits(dma_addr), &port_mmio->clb);
+	writel_with_flush(upper_32_bits(dma_addr), &port_mmio->clbu);
+	dma_addr = virt_to_phys(pp->cmd_slot);
+	debug("rx_fis_slot_dma = 0x%08llx\n", (u64)dma_addr);
+	writel_with_flush(lower_32_bits(dma_addr), &port_mmio->fb);
+	writel_with_flush(upper_32_bits(dma_addr), &port_mmio->fbu);
+
 
 	/* Enable FRE */
 	writel_with_flush((SATA_PORT_CMD_FRE | readl(&port_mmio->cmd)),
diff --git a/drivers/ata/dwc_ahsata_priv.h b/drivers/ata/dwc_ahsata_priv.h
index 5b0579ae1159..0c2cd5446b57 100644
--- a/drivers/ata/dwc_ahsata_priv.h
+++ b/drivers/ata/dwc_ahsata_priv.h
@@ -7,8 +7,6 @@
 #ifndef __DWC_AHSATA_PRIV_H__
 #define __DWC_AHSATA_PRIV_H__
 
-#define DWC_AHSATA_MAX_CMD_SLOTS	32
-
 /* Max host controller numbers */
 #define SATA_HC_MAX_NUM		4
 /* Max command queue depth per host controller */
diff --git a/include/ahci.h b/include/ahci.h
index d4f0f3ce0e71..eb05cc687f64 100644
--- a/include/ahci.h
+++ b/include/ahci.h
@@ -137,8 +137,8 @@ struct ahci_ioports {
 	void __iomem	*port_mmio;
 	struct ahci_cmd_hdr	*cmd_slot;
 	struct ahci_sg		*cmd_tbl_sg;
-	ulong	cmd_tbl;
-	u32	rx_fis;
+	void *cmd_tbl;
+	void *rx_fis;
 };
 
 /**

-- 
2.34.1

