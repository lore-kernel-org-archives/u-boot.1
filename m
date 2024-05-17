Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40421C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B3788544;
	Fri, 17 May 2024 20:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="fxVlkZlU";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqBR3QnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F128853E; Fri, 17 May 2024 20:14:59 +0200 (CEST)
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3649288541
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 5250C11400BD;
 Fri, 17 May 2024 14:14:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 17 May 2024 14:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969696;
 x=1716056096; bh=A09TdZSjf/AHnbMvBFi9xIa9m13gd1pgvqRU37n3YsQ=; b=
 fxVlkZlUeALuW5nE/FS7+6FvtjFuk7oEgfWFr1uKVVGaK84zS4/BtqTCXEWzZmvh
 IYfW1GGZkjqKQrcJgQN0Ho138pBq4Juv7PRerau/bXDSWge9O2qYhgoCTgqbULr+
 5GSYE8HvV3jV4RrM3DaRhPFQh2y5S2nekZlUJJ0sqN6bc3DdSWIIXlDlSDMf+uww
 kLkxroNEcHWROKbIIP651a8OZhh7hWO0SMPKiBXPe6VmBYP0aQ0Zh/VmFQ1zYYhw
 SCu4EUpHhe4gCD/s1/78PG9/fzVG35BljOPXJP2QyJDgqb6oD15qTsBLOc3kgjK6
 olGULlRSYJPm5KJXA8lxpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969696; x=
 1716056096; bh=A09TdZSjf/AHnbMvBFi9xIa9m13gd1pgvqRU37n3YsQ=; b=E
 qBR3QnAr0Jz9K1jxA8wzctKx5MZNh14fY8Uu5HTv2d1eGp9tNgHtRI0xcXOlf3af
 vqxxnSDYib3UtKcHYqoryC1sISv4cuDu1duqJg7K0mUQqkGw+PPNxRZ7Jac+Ut8o
 UZifcQjTa1pXwt0Xnn6RqSmMphyMtsdwLXWzHUdxpTiMOpxE2pwLWOSdN+tHE1U3
 oVejMo0zvvWAIviHpKyTQwPBc/0dzBv5X3Ewf7Ry7t7MQ/uO6AMWaI77qiPV60or
 VIigr8+IyOYtK3SOteNHPe7MYkgpHTTbJX9iWsPFFXQXHCWvEWBDbX577E9PmE53
 sr0HrO2kvmX4rZrtgWilQ==
X-ME-Sender: <xms:oJ5HZmRlc1VF0oC-nlGxiw8VH7hk7D0IkpJFJNE2qUOUUTAPXPEB-w>
 <xme:oJ5HZrwfYIdhsZkYxsBwV76LLuo9dIlKlQeMO0U_BbrzrjNyuNso0iom0yBEcJWMI
 bcJmtVeaPzL4eI3Shw>
X-ME-Received: <xmr:oJ5HZj3DIEHl_9tXotzB4GixXZLxl1vNfzC4QQ4qWIvO3KgwxqR9JO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:oJ5HZiBbe1Gg7VOXkxLAWcyNLzwzDs4XeJ3DI_F1AIUvXO3RczShaQ>
 <xmx:oJ5HZvhQKIP1MYQfidOHFlVY7o7cZnv8Z14lmAkF5Gsj4mYhYFE03g>
 <xmx:oJ5HZurlb0b57zmsubvJ4U9adbVAIvPxrPOzaGXY2cwQKOLBfAorbg>
 <xmx:oJ5HZiiyitjSaOi_BOWgyHMlbYGXQP0TTe4uzfEEgkrIjArjA5ke6A>
 <xmx:oJ5HZipH0-7ESMtycWVzqfPkz4UBdj4znbJU-fIu93PS9JcG0wzfoqNH>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:14:54 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:50 +0100
Subject: [PATCH v3 02/12] pci: auto: Reduce bridge mem alignment boundary
 for boston
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-2-1ea7d23f4a1d@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=47N9g7qZS/9fuK9fjUgi3DPCL1HeIrDjoEfRwEqV7nU=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebMXn9a+fK/xvJhDRp8ak5Hu9nNFq/gOLVEwfmD2U
 PjDOtZLHaUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjCRxX8Y/ufG7hdWr2OMiq5V
 E9ZQ5Zm+2If5p/mdWrvu+4crnp2/cpqRYfpxl8UTA/wWHDJnnLXv66xvwtK1d/duX3kxY6GOt1J
 zLSMA
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

Boston has a very limited memory range for PCI controllers, where
1MB can't easily fit into it.

Make alignment boundary of PCI memory resource allocation a Kconfig
option and default to 0x10000 for boston.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/pci/Kconfig    |  9 +++++++++
 drivers/pci/pci_auto.c | 16 ++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 8d02ab82ad9f..289d1deb38b6 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -75,6 +75,15 @@ config PCI_MAP_SYSTEM_MEMORY
 	  This should only be required on MIPS where CFG_SYS_SDRAM_BASE is still
 	  being used as virtual address.
 
+config PCI_BRIDGE_MEM_ALIGNMENT
+	hex "Alignment boundary of PCI memory resource allocation"
+	default 0x10000 if TARGET_BOSTON
+	default 0x100000
+	help
+	  Specify a boundary for alignment of PCI memory resource allocation,
+	  this is normally 0x100000 (1MB) but can be reduced to accommodate
+	  hardware with tight bridge range if hardware allows.
+
 config PCI_SRIOV
 	bool "Enable Single Root I/O Virtualization support for PCI"
 	help
diff --git a/drivers/pci/pci_auto.c b/drivers/pci/pci_auto.c
index 90f818864457..b2c76b25801a 100644
--- a/drivers/pci/pci_auto.c
+++ b/drivers/pci/pci_auto.c
@@ -372,8 +372,8 @@ void dm_pciauto_prescan_setup_bridge(struct udevice *dev, int sub_bus)
 	dm_pci_write_config8(dev, PCI_SUBORDINATE_BUS, 0xff);
 
 	if (pci_mem) {
-		/* Round memory allocator to 1MB boundary */
-		pciauto_region_align(pci_mem, 0x100000);
+		/* Round memory allocator */
+		pciauto_region_align(pci_mem, CONFIG_PCI_BRIDGE_MEM_ALIGNMENT);
 
 		/*
 		 * Set up memory and I/O filter limits, assume 32-bit
@@ -387,8 +387,8 @@ void dm_pciauto_prescan_setup_bridge(struct udevice *dev, int sub_bus)
 	}
 
 	if (pci_prefetch) {
-		/* Round memory allocator to 1MB boundary */
-		pciauto_region_align(pci_prefetch, 0x100000);
+		/* Round memory allocator */
+		pciauto_region_align(pci_prefetch, CONFIG_PCI_BRIDGE_MEM_ALIGNMENT);
 
 		/*
 		 * Set up memory and I/O filter limits, assume 32-bit
@@ -465,8 +465,8 @@ void dm_pciauto_postscan_setup_bridge(struct udevice *dev, int sub_bus)
 	dm_pci_write_config8(dev, PCI_SUBORDINATE_BUS, sub_bus - dev_seq(ctlr));
 
 	if (pci_mem) {
-		/* Round memory allocator to 1MB boundary */
-		pciauto_region_align(pci_mem, 0x100000);
+		/* Round memory allocator */
+		pciauto_region_align(pci_mem, CONFIG_PCI_BRIDGE_MEM_ALIGNMENT);
 
 		dm_pci_write_config16(dev, PCI_MEMORY_LIMIT,
 				      ((pci_mem->bus_lower - 1) >> 16) &
@@ -480,8 +480,8 @@ void dm_pciauto_postscan_setup_bridge(struct udevice *dev, int sub_bus)
 				     &prefechable_64);
 		prefechable_64 &= PCI_PREF_RANGE_TYPE_MASK;
 
-		/* Round memory allocator to 1MB boundary */
-		pciauto_region_align(pci_prefetch, 0x100000);
+		/* Round memory allocator */
+		pciauto_region_align(pci_prefetch, CONFIG_PCI_BRIDGE_MEM_ALIGNMENT);
 
 		dm_pci_write_config16(dev, PCI_PREF_MEMORY_LIMIT,
 				      (((pci_prefetch->bus_lower - 1) >> 16) &

-- 
2.34.1

