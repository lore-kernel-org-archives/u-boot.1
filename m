Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D13DC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB4D87F4E;
	Thu, 16 May 2024 13:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="fjuV782i";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="cXwA4x/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E068882A6; Thu, 16 May 2024 13:40:46 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F3648803A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 4C9621140094;
 Thu, 16 May 2024 07:40:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Thu, 16 May 2024 07:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859642;
 x=1715946042; bh=FHOkLkDoexiMQ/U2G1EFu1LKxC7hFW6/lzB9xBeafnY=; b=
 fjuV782i/x/Oj1RicR0YviFfrGq3AJG/cTH7xF8pNxmzfx0/SxtnUuMcz+0XJt1u
 q/pzl3G+XhIBEZWKYEu77HhyG1Z4aJLS7sSA44wle9zg5MG2706G9aB5kYdIaa+G
 OSMK7l04t5m4t2tOgOhDd0wxHQZ/E06HGoZ/9XUJnv6nfyFpWZgfgP7l17DVaYoB
 xJ0h0yG2/TZNyobQ8LDPyL9TFuq7p21vrio7m1Xm7hmeNrGTIQ2viQk5/ux6PBlj
 hdjdnBCVqovaq+rd9xkBAd49RVVpT4AvX5CsrLGYrXo1O+5azr8TRHIz2s2PH4q7
 SZLzBJi1FzM24t9O0sQorA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859642; x=
 1715946042; bh=FHOkLkDoexiMQ/U2G1EFu1LKxC7hFW6/lzB9xBeafnY=; b=c
 XwA4x/7fLV+KUK2EsgGXG30+Kp2Q6DmVbvf9IrsCgPh+FOWmTC16Q/roqN4My40v
 mhioYi4sBIEB3t/YXdM5v7G7ZJemuzhODDXMOEPlXOm05m5sCTpPBw1jRWPIwpbA
 EznfjYBZlVReW+0ahwWNmkpUt/YTgnGRa/BIgBpiWZtnhk0mk15QhA6RXhilxZK+
 zs4NXNlgBuKVUOUeYgBypfpRVqxXum9jws1gauMMZaDE56aLptdcQFEKEJDlqdFa
 fXZNu8gHf9+1DBmgvxbM9YKX8DsB/+rj2SaAESUxjk3eLaNIk+WRpTLsVSrVVwKa
 VfQIFGbBRtUcqKBgei/wA==
X-ME-Sender: <xms:uvBFZjmjV51-8TAmVvyWU4sZqOotnVqz8npqMzQ8hdte2kMbKYFdxQ>
 <xme:uvBFZm3Rd-ny-24sDlD6jT4f0D6nE8xEFtrhiWc_Qw-5PKt-gAzaD4kU2073GHzYL
 5rPjHPzLx3inM8aQLM>
X-ME-Received: <xmr:uvBFZppxCJwV1-SHZ_Q3hsNljWEqt0GG7tp22URvUgUowICR1NUZC0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:uvBFZrkmhJBImqrq72RA6KatkyDmvu7IORzJk_1pAm3jAX_JA3CENw>
 <xmx:uvBFZh133p_zEH3s4bxLKFEjIFzP6hyGCcnPgfYgNhh7AAZv5b2Mew>
 <xmx:uvBFZqthX2bVc4TMt_IZab8sTm1utA0bWL-vYW1jLCgD_DXiW7s2HA>
 <xmx:uvBFZlXJnQ5ovcNOiDo_F-88zT4J0kRM31gg_OLnW_nfKO7i_yp_0g>
 <xmx:uvBFZqsK9b13faIm1JHBaTlreq71fLomzFryT5QTnXZYcfHtBCKeLZi->
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:40 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:21 +0100
Subject: [PATCH v2 01/12] pci: xilinx: Handle size of ecam region properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-1-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
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
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDztuyhz/pPlHtf519JsTuuGTWFqF1XZyJvVuX3X7g
 eHux3VhHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRstWMDFOV0pJqtxtyz2T+
 1vyEv35Ol4Va3pWHyy8t4l9aIcFg7cDI0C2Zs3fxlFX6HjuZyt949aT3ab2aUbxuT5JOWNvcDKG
 tHAA=
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

