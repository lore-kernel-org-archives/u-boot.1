Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A93C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C70688315;
	Mon, 13 May 2024 20:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="ODE44/Kr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="YwxAGUx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BC1388013; Mon, 13 May 2024 20:13:14 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5741888315
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.nyi.internal (Postfix) with ESMTP id 6F98D13810E1;
 Mon, 13 May 2024 14:13:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 13 May 2024 14:13:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715623991;
 x=1715710391; bh=A09TdZSjf/AHnbMvBFi9xIa9m13gd1pgvqRU37n3YsQ=; b=
 ODE44/Kr1oWLfJT4zP5m7HSO5w73Iq8OQ2zo15kCPqtRFs5gvMe4sISIb8K+fVg0
 Q5HcGfIHcZENKENrltd4dfHgwsqkEbcptSfifIo6zRq700k5XITkJGcC7zAjZxXf
 EEracZV6KYfMKbaHNdcbF3hjaYhCLwqnCWMrHQQ1i/1jzStHV0kU3XA9t4Uu5CkC
 WbLy1GA+5AfDPocC+SsRxurertDTo6evbbg3YKXh/zKa6eTFtSacRAG6pQ9ywXpt
 GPzennpKcr5mAks/j7zfqHqelmPV0Jp+a8xHKYn3Lrqh8HMNx+kvUxVadv1Yk4f/
 CsZMHJstrNgowfjW9cm5Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715623991; x=
 1715710391; bh=A09TdZSjf/AHnbMvBFi9xIa9m13gd1pgvqRU37n3YsQ=; b=Y
 wxAGUx1+kiq5MoQQ8p1R08L3muxpZECyDA7b4fJii9sTVYYAu9JXZMF19oDlNFb8
 FJSttjH9BPCyNpf5ZQnhZ6BlyyEfz9VH3NucTkdxdnGu7LrsHNJyHg70+ehXmeDs
 ElVzpt46b1rQvR7Uh6PNJDC443uRTn8aq6Bu9N5/i1an7unbMNqXCM/eteJX7uPy
 p/Vj4kvzyi2Q9yjoDpM/EJmILn7g1pSnVrsHbbm8Zw5yrsAXUWYtELWjJdw4q3m5
 IxGRrvqy2NPHMrGSxqO9yklKVZ/e4dKqrck9FGxGndJXXDfiB5zGVdCKM3FgOtJn
 ME9ji/85lCoHBRk2ZEw1A==
X-ME-Sender: <xms:N1hCZj-WkD8ZhQEIdmZ8cl-voSO2ow9IRMYm9cQtCfhYpFit3vjJ1g>
 <xme:N1hCZvuulmNfKxkf4bjIyGhUfHXxqmwG9jQ-CGDTBb10-XbhxHYZSDSyab9iKAcDk
 XoW_DMULdeu7qCNUak>
X-ME-Received: <xmr:N1hCZhBbIrlgC49-JU0xIwp1hPwtNFBZF3sEMkDgSZ3hEAdWNUmoJ6M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:N1hCZveRFMl3t_-iQfL8W-ka8zZH3zqm6TBoOOHlcQ5eycsxEhAyOA>
 <xmx:N1hCZoPU3RbulhoEB5T8_Jtza6g038zWeEOPWMYO5_vprNwLFJgzmA>
 <xmx:N1hCZhnKCw38GWKlxKMRDctokemn6yGurn2zB-UzbSxez_vJsU1FbA>
 <xmx:N1hCZisUQZX0kUWZK4Q9y8wQRL7s2eTP3CoJyTJFgsPWzM91V27WcA>
 <xmx:N1hCZpGNvoVkfmu_omu1Ur1wWUQpEvYwpa_tPGNSXDm-im82CB9OVOLm>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:09 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:12:59 +0100
Subject: [PATCH 02/13] pci: auto: Reduce bridge mem alignment boundary for
 boston
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-2-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=47N9g7qZS/9fuK9fjUgi3DPCL1HeIrDjoEfRwEqV7nU=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCONisf1PGXzLyxn54q1tz2mw8z1kj9Lel+flNt8yq
 2JHwNmOUhYGMQ4GWTFFlhABpb4NjRcXXH+Q9QdmDisTyBAGLk4BmEj/Cob/MZaNmzvMyg/d2J5Q
 2S9z8v6qz8cYE4QW2K2+tPOG4HUZL4Z/ivcks5TPtnCvLFxs7j1b4r9KeHcvw2adkKN9CTs9o1a
 wAAA=
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

