Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DD7C25B78
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:15:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C3B8850B;
	Fri, 17 May 2024 20:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="IB9/U6YX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WO7p7DJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D06088518; Fri, 17 May 2024 20:14:58 +0200 (CEST)
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com
 [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A96D38852B
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id 71D2E13814F5;
 Fri, 17 May 2024 14:14:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 17 May 2024 14:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969694;
 x=1716056094; bh=FHOkLkDoexiMQ/U2G1EFu1LKxC7hFW6/lzB9xBeafnY=; b=
 IB9/U6YX/YiAbLGHKsh5KN1LgbYyn618FDEU2GC0meTOXP9iLgVQxsTsaN2ib5Jb
 5jN6hav48Yetox8c9XjHYOkfPPfzOi5IO2CFtJ5uQlcgqkwaMA7uL9m+6j3tSS/r
 Uiu8BGASpzh802g3I60E5KNeseD09S2E06b0LFmMzWHfr4DWQyC0QiWAE0RWOg26
 P4N01cUhq0V2jRa92FegO4/c7exD3CW64swQq6MOwlZjm1Rn2svHnOvERROHrpIJ
 bIm4brfILQJIDiNSUCOM/DQil9X9kaSmWsgt8QfKoe2lGEAy5DzYw6Wt2mHqzdr0
 ciAi1TiLpyta2Jfdj+IVBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969694; x=
 1716056094; bh=FHOkLkDoexiMQ/U2G1EFu1LKxC7hFW6/lzB9xBeafnY=; b=W
 O7p7DJDfkXRFdLkV/8PZFJIjryjsK/pMcDcVsiMAjIsEmq16RGga1I0bEz4sdFbd
 bNyCucbuXjjBb4w36SrO2jD6eoMWYoS57PVDspxfZRwWb2r9U6bSqB9efsjkqLrp
 U8qDyHtlSYvUqhoSPXDF8TIMt6C4LR9g5G6nnZK9P9wFkQpHrvWaEXU9PPylojWL
 1EjAsPN4dOoy6jV5ENYvKl6mb/2pbsM/zCNxnmrdrX/xk55cmYLImAjabhDf46pF
 uH3XA2KuK6ABlXFCAnBu9KGi2PBcU6ZDmwFS3xnkQIlwYQYp7bTZJZz1ZjoDIUC6
 NhLrL7nJytcPbRckl4yxQ==
X-ME-Sender: <xms:np5HZqToJDXpOLm2cTRqSuEMh8PcIucDrkFtS6NHHfC7lZdRpglI9g>
 <xme:np5HZvyB4MCApUeJ0DNEQEVHyD2QCwvJW5dTUk8nZIe5KJGwpYYvrY_2TP1MBa4w2
 EKalLOMSi9QQ8KM8MI>
X-ME-Received: <xmr:np5HZn0YECiGC098As5kwXBqQfxOHALLXOHu4Fc7Xo5OvxkeZlDNv-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:np5HZmAn-sJN5_sKYmD6lqmCJ-5AdrqtksIfBdG04tFz90-7lzyGtQ>
 <xmx:np5HZjjIpox4pZR6pQCvC6UnhFqnGNPq-GsjLNE-Ass9F2UQaT-AZw>
 <xmx:np5HZiosbF84oCUuzZRIhdiqr6CtfVOeDoqNN19fJXFnq93PMQFfFA>
 <xmx:np5HZmgbEmYGPU_W09WbWee269syvimCwXC6RfcwU5SzjZOM-_ExUQ>
 <xmx:np5HZmqdbRSbeteNL6gjIcN3BB0jnDq1dyT3aB0CZE79srlyOnxjMuds>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:14:52 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:49 +0100
Subject: [PATCH v3 01/12] pci: xilinx: Handle size of ecam region properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-1-1ea7d23f4a1d@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3688;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=8jtahATj+J0VxXyy7U3lsuyxhxEVDaJ4JLco4h9mYN8=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebO7f1bO1EiesdFaPqvZSb6K525IiMnlWm2Gs26CE
 XNmPVvTUcrCIMbBICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABNhWcLIMOlhSyjHoXNsVQ9Y
 o6uXi7nN2s2/qeHdVP9PVm5Fr2b11DIy/FvJJ5qwSEKFzZNloxvbRD6X9K1iQku8fzzary+5uU+
 cCwA=
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

