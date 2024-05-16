Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2A1C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BC6E88296;
	Thu, 16 May 2024 13:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="lmdhuGc6";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="joj2MFZm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB7C98803A; Thu, 16 May 2024 13:40:46 +0200 (CEST)
Received: from fhigh4-smtp.messagingengine.com
 (fhigh4-smtp.messagingengine.com [103.168.172.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 946F288286
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id CCBE91140172;
 Thu, 16 May 2024 07:40:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Thu, 16 May 2024 07:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859643;
 x=1715946043; bh=A09TdZSjf/AHnbMvBFi9xIa9m13gd1pgvqRU37n3YsQ=; b=
 lmdhuGc6M4kt327cJb5Chz2WJxN4jQczbGq+EGKuxvJRK0rTHC0EbLd/XUwcaQPO
 7F6+RX5SfZ1lw+dHfQ/oSUYrZb6y55P8q0NvENtvigFjkspYGVBB3U5n6iKmxkhL
 laRSHK1seT9Yg5uiSJ/1pB/MdQ1J/fPi2p8W9t8oGJiUrXOln4Bs3YWuwsOCqTy9
 jLbCUU1Fm2Qm11MTqmz+f/jeDkTbFDnwUtqu4aO7jlsKcD94J549r6jf177IyzEx
 j4ImfvLFvFKJuS6cCUWuEtVHYR31EVc1RcY9+gDCZBO6Yl+tHkqP5WpNiPBbogDu
 yP57qTH24ORl5k55m3BfLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859643; x=
 1715946043; bh=A09TdZSjf/AHnbMvBFi9xIa9m13gd1pgvqRU37n3YsQ=; b=j
 oj2MFZmT2l5SNfgVzj5QV2/gSYcfy1eItE1IW1BCJ2pYXySmEXvNT2CnaADfol+7
 gNQMK27GDj0vznF3639XxypCVJ2Ja6TWn2K/3c60/JBGI8BEXNmZJ9RYpDXFjsT2
 baJoSLVsJ10pUWu2ClYZeuonMei42GbhVik0KSMB+cO0BQ9Ho587D05pVnQdjhYZ
 zvCOSU2sQOTuT1lpQ4AhA7eNiILY9fVaq6Nv27NXRxxUHu4V81AgG6WC4qaPwh7p
 v5V4GM9VsvKkOLYO5yW/9haTuIZzAjwXQnWyzfrP/ch9mbqgfPP+1Ku68ESKaaV6
 8eCShgZ5nN7c6xVQXxAnA==
X-ME-Sender: <xms:u_BFZn92Et6ffdERg9w7v5-sNQQVvxGNTU2EACNcryAERZh2Nxx6MQ>
 <xme:u_BFZjuqXMuHfsHqf3MV2kU-LrUtid6LIkAOjOakjJrRfj035Q_8cNWaEnwsQv0SB
 pcHx-FvY0cHGxjFlQw>
X-ME-Received: <xmr:u_BFZlDVKeeuk6rS-CheQfTWyE74XBk2o-WOk0i2PsSjEgdhGaNiIOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:u_BFZjcfGU1vs9SwiuUZv9asHBzKhuk8-bHI6wr_B_XmLjeywxnK0A>
 <xmx:u_BFZsN4tRpBF2dOCfzt94KFwf77OxgJy0lLftJ6k64AZTTAsshGMw>
 <xmx:u_BFZlk5bli8WPWlFU3VdI_BwWObWcX3ZIZT_MZ9ceC_94IFutLJSw>
 <xmx:u_BFZmvyHS1fvMi_WWHbMI9MbMmwSpGXVaLAriqG1ZGT_0Ge5ObyJA>
 <xmx:u_BFZtHBx5vrxqN85O7DoTGAV5fFbpHjla7algQAyGOka3l_W48MsW14>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:42 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:22 +0100
Subject: [PATCH v2 02/12] pci: auto: Reduce bridge mem alignment boundary
 for boston
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-2-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
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
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDzt230zZENWWmWIcdHC97f7Nn9aEzFDQYLVneDBbu
 Eh79ufFHSUsDGIcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjARnyaGHzeff/mWKazzIqSz
 /05JvPNn9mTFDdek69T3fal8UJnPwMgw8WGS9oyj1UH9Jy9LforOE/62Qf0ko8vLW5aH30Tss87
 gBgA=
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

