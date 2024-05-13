Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63DCC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A3D788303;
	Mon, 13 May 2024 20:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="EHYTLUiW";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="JI+JH2/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684D787D08; Mon, 13 May 2024 20:13:13 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C6088303
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id A40E713803BD;
 Mon, 13 May 2024 14:13:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 13 May 2024 14:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715623989;
 x=1715710389; bh=FHOkLkDoexiMQ/U2G1EFu1LKxC7hFW6/lzB9xBeafnY=; b=
 EHYTLUiWn6YZljpiLOuZzgxeMPSetJNJgxT6fX8BpIgQhwN9sETab7D3GBq+9Pya
 x5xAYN0s9+PA4xk2/IuIZzQD8xZEEvOiEHHt99U+RPsxPkaw0WYdZNOQe/Auq1sP
 Rcs32hHOTqb1QMqo/xXy7tfzkqxKcsdLtQP24674/W2DRaXXBGWerk9G7tx+uEnq
 YkdaPVhNGmjhRJkvVhSjfFMJ9kL4FmrQ+obbULF4hXga1W34Joc6Gs5fXX3Oi7HB
 /ELfVm9YH0K6beYIJGfDE2D7U+LjFyq2alvjHIuhv0JJt4uhlI0DR0qHOtcydro0
 5ibQPiWFLykGziXqBCCoRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715623989; x=
 1715710389; bh=FHOkLkDoexiMQ/U2G1EFu1LKxC7hFW6/lzB9xBeafnY=; b=J
 I+JH2/SjOnKAvg6ptdruBg1gKX6icO+us+gKH2ofQz6WaOUDvTck79xC1EKyxHp7
 0r+yBrEJaKeofm+pJ9fRZiFR1tIFOABb1xDC/QQi0jwLrBGAwRBfqa/nZCs5zbD0
 94GGPd7z8iJcg9KhcRxnyCB4qMMzhrK/F0p43r3me0oPc/qvYGDjqClqcp1t+LCB
 Kx+/zCGjEDR3oES/DaZq8lB3U5uBl9ojGME0sNLJDijVMWWUCGXS+BYlsAi0Q3lF
 ODvTad/nyCklY3PDSPDD3+2zIisgMC49xr6QPLlTJOACYejVEh21ZXCXO7GW7eDt
 ZHxODGyxW9D+GeODSg01w==
X-ME-Sender: <xms:NVhCZsRL-n3p6pU_qCnU3BBVvCDvHT3abe_Sz9k1OLfwy__6Qj_IMw>
 <xme:NVhCZpx2SpxfWf5UqA8CE7VZ-xUaDJVD-AEK-9RsYjORQv0dyqAOtGjoHvsBOi1ex
 RuN-PqHZ4gqbEdDnrA>
X-ME-Received: <xmr:NVhCZp0AdQlok5Csm-NvcghmzywsIycfKz_gVxFTlUBeNnmpeD4bvrs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:NVhCZgC9_SBkecu36CoHF-mC1iUZlPpNxSUihJxeKTR-1bhpH9m6Ug>
 <xmx:NVhCZlg9G3yT4q_itt5-GPXwafAbpuQ2Y8dUMRxkCscuHOnELbdTiw>
 <xmx:NVhCZsrKvK7FiMkwV9GOTWqbnXnVn5uskuvWkg-2sQsum42Lc879fw>
 <xmx:NVhCZohlaZUxp9sm660brd1nGT-Q2-TRSD1kX1hn5WE3tEqMqNaQpQ>
 <xmx:NVhCZqbVqxXFIDkUJrLlwqe54G15j6I7uBQcPj_qc7lGPYOo7YKabqWB>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:07 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:12:58 +0100
Subject: [PATCH 01/13] pci: xilinx: Handle size of ecam region properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-1-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3688;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8jtahATj+J0VxXyy7U3lsuyxhxEVDaJ4JLco4h9mYN8=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCGPL5JwrmrLlol7Wb796nOuPDzCUsIxkNGiatri41
 SZSSKqjlIVBjINBVkyRJURAqW9D48UF1x9k/YGZw8oEMoSBi1MAJqL+gpGhk6liy2ORA4Lql25H
 ls95+uTj0TKfD58ffN8gxj/vvSaPMiND82HfrFKRFbci7k8KZqyMzW/zndpcKZJkd2Xh152fXv3
 nAAA=
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

Probe size of ecam from devicetree properly and cap accessible
bus number accorading to ecam region size to ensure we don't go
beyond hardware address space.

Also disable all interrupts to ensure errors are handled silently.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/pci/pcie_xilinx.c | 53 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index a674ab04beee..63058e8e7c5d 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -18,14 +18,19 @@
  */
 struct xilinx_pcie {
 	void *cfg_base;
+	pci_size_t size;
+	int first_busno;
 };
 
 /* Register definitions */
-#define XILINX_PCIE_REG_PSCR		0x144
-#define XILINX_PCIE_REG_PSCR_LNKUP	BIT(11)
-#define XILINX_PCIE_REG_RPSC		0x148
-#define XILINX_PCIE_REG_RPSC_BEN	BIT(0)
-
+#define XILINX_PCIE_REG_BRIDGE_INFO			0x130
+#define  XILINX_PCIE_REG_BRIDGE_INFO_ECAMSZ_SHIFT	16
+#define  XILINX_PCIE_REG_BRIDGE_INFO_ECAMSZ_MASK	(0x7 << 16)
+#define XILINX_PCIE_REG_INT_MASK			0x13c
+#define XILINX_PCIE_REG_PSCR				0x144
+#define  XILINX_PCIE_REG_PSCR_LNKUP			BIT(11)
+#define XILINX_PCIE_REG_RPSC				0x148
+#define  XILINX_PCIE_REG_RPSC_BEN			BIT(0)
 /**
  * pcie_xilinx_link_up() - Check whether the PCIe link is up
  * @pcie: Pointer to the PCI controller state
@@ -61,14 +66,18 @@ static int pcie_xilinx_config_address(const struct udevice *udev, pci_dev_t bdf,
 				      uint offset, void **paddress)
 {
 	struct xilinx_pcie *pcie = dev_get_priv(udev);
-	unsigned int bus = PCI_BUS(bdf);
+	unsigned int bus = PCI_BUS(bdf) - pcie->first_busno;
 	unsigned int dev = PCI_DEV(bdf);
 	unsigned int func = PCI_FUNC(bdf);
+	int num_buses = DIV_ROUND_UP(pcie->size, 1 << 16);
 	void *addr;
 
 	if ((bus > 0) && !pcie_xilinx_link_up(pcie))
 		return -ENODEV;
 
+	if (bus > num_buses)
+		return -ENODEV;
+
 	/*
 	 * Busses 0 (host-PCIe bridge) & 1 (its immediate child) are
 	 * limited to a single device each.
@@ -142,20 +151,37 @@ static int pcie_xilinx_of_to_plat(struct udevice *dev)
 	struct xilinx_pcie *pcie = dev_get_priv(dev);
 	fdt_addr_t addr;
 	fdt_size_t size;
-	u32 rpsc;
 
 	addr = dev_read_addr_size(dev, &size);
 	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
-	pcie->cfg_base = devm_ioremap(dev, addr, size);
-	if (IS_ERR(pcie->cfg_base))
-		return PTR_ERR(pcie->cfg_base);
+	pcie->cfg_base = map_physmem(addr, size, MAP_NOCACHE);
+	if (!pcie->cfg_base)
+		return -ENOMEM;
+	pcie->size = size;
+	return 0;
+}
 
-	/* Enable the Bridge enable bit */
-	rpsc = __raw_readl(pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+static int pci_xilinx_probe(struct udevice *dev)
+{
+	struct xilinx_pcie *pcie = dev_get_priv(dev);
+	u32 rpsc;
+	int num_buses = DIV_ROUND_UP(pcie->size, 1 << 16);
+
+	pcie->first_busno = dev_seq(dev);
+
+	/* Disable all interrupts */
+	writel(0, pcie->cfg_base + XILINX_PCIE_REG_INT_MASK);
+
+	/* Enable the bridge */
+	rpsc = readl(pcie->cfg_base + XILINX_PCIE_REG_RPSC);
 	rpsc |= XILINX_PCIE_REG_RPSC_BEN;
-	__raw_writel(rpsc, pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+	writel(rpsc, pcie->cfg_base + XILINX_PCIE_REG_RPSC);
+
+	/* Enable access to all possible subordinate buses */
+	writel((0 << 0) | (1 << 8) | (num_buses << 16),
+	       pcie->cfg_base + PCI_PRIMARY_BUS);
 
 	return 0;
 }
@@ -176,5 +202,6 @@ U_BOOT_DRIVER(pcie_xilinx) = {
 	.of_match		= pcie_xilinx_ids,
 	.ops			= &pcie_xilinx_ops,
 	.of_to_plat	= pcie_xilinx_of_to_plat,
+	.probe			= pci_xilinx_probe,
 	.priv_auto	= sizeof(struct xilinx_pcie),
 };

-- 
2.34.1

