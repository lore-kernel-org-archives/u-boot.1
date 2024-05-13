Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027CEC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5837788341;
	Mon, 13 May 2024 20:17:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="iJmcQTgU";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="LlvCXo7Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEE4D87D08; Mon, 13 May 2024 20:13:17 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968A6882ED
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id A3E3A1380255;
 Mon, 13 May 2024 14:13:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 13 May 2024 14:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715623994;
 x=1715710394; bh=MSzSQ1dSj3f5QzEIvjJj71+RlzAvGxEFWZVc7ZeXqcQ=; b=
 iJmcQTgUgHJm5Lb7f0Yy8LgALP1qWxk/exWxR7GFpkVNwG2IMMF5Qblk2XjqpAqG
 nduA/GfAgoecWA/XaHFMKADvsjH4ove8XDa5rUZ86lM6plkoc6kbJdfAQoNSpwlj
 r4voOLVh9UfovVWcuM/xD1+qEDyVOtn33U3ace+YBHKyvrhQrvObhJde4apXneya
 MEbZo8Yl0T8aSD+2LqWxFrdoCsMP9Tuw7PdeeM0X9HVHzOxxBIXR2MvVy5igYvgl
 l8JlHAuZWGsD4Sr2ubQl/q2APSPqIDNlvLTSLmNSiQDLE9bLShcpRC0h4zDLQk2D
 bZWF4iq1JgKOv0bvgbs9dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715623994; x=
 1715710394; bh=MSzSQ1dSj3f5QzEIvjJj71+RlzAvGxEFWZVc7ZeXqcQ=; b=L
 lvCXo7Z1sRKjjUxFHlN87nr9UWK47guenxY21HAO1AekscIG+QIGwtoD8t3AqGyB
 4SYruEErnvvJ7Q/B5MbVL3kFaLgJ4o4sSqIMMGJ9R9+fFBiMdu/B1L1vlH2UEOso
 0D23T3YXGpcXIsfP2BjMueDbvhbmVfjhKZXjJOKmxfECptohlRo+lIdrBCgDZqz6
 7NOFKPHY24Gm/aMVAYrecc5KtO18p6r2gtvgk3N2Y9LclY1TVN4cm2md++JRlTkN
 C3uIoyuDEr/f+W4iCB9RNMwhHiC0MQk8SYI3PZO0pceelI2kCX4HKIw0cTUfCvif
 CSx9k7JT2LVYBHn2ya+Pw==
X-ME-Sender: <xms:OlhCZr3O59exXfoLNf7fwDU2hAEWzva16toRKM9aU5W1fvH3er7hnw>
 <xme:OlhCZqHwovXg59YDety_gUytC8FUrqtgR8T2FWtvnSum48XfpT1lxbq2ab80YlMob
 lM2AUtJq_BPpvMY9VE>
X-ME-Received: <xmr:OlhCZr5yXWRhg0_8dJeWF1Pmsbxbk1Psk4NmhXspPng_gzBD1R_Hd84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:OlhCZg3764CaOn1bkqtYA10ADgCdCVzVa4EtCWPMbSJ-dUsGeVCTCA>
 <xmx:OlhCZuFWR9oV_cB788K7Vtc8vt1-P5SD-3uc8IKFpMix560t-VIF2w>
 <xmx:OlhCZh_AwL5SfoOaI83_riLOn4hRns6xP8E6hqnHJyqr79ftAmIFcA>
 <xmx:OlhCZrk439UsLGcZ_SZ82EjlImHfVbmQLgvrZbKSGHA4AWOK_a0n-g>
 <xmx:OlhCZm9jJUlBRJm5sD1J9kjQzgUo9ZB3ENbO-LuYvLJAPxTLkURk5F7V>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:13 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:01 +0100
Subject: [PATCH 04/13] ahci: DMA addressing fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-4-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8830;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=fw17qbL3Fk/uTmZo+IITOEuVcTdCWfeQs2YU77ePoFU=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCGOrqR2nOG3cNO8IsT7XXl8v8CM4QbG62S+3fIax+
 Ns7orYdpSwMYhwMsmKKLCECSn0bGi8uuP4g6w/MHFYmkCEMXJwCMBGHDEaGDuPdghekUrm2K0hk
 Gi5fYZJ689K57hM5B+6JJU3pnn7wE8NfGe1ti7ra48weTWNYrrJlicxJ2Q8zGaJWrJGuXq3Xv8G
 CFQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
X-Mailman-Approved-At: Mon, 13 May 2024 20:17:26 +0200
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

