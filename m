Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF94C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 11:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63FA882E0;
	Thu, 16 May 2024 13:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="CMY1/esA";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WgRk+g1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404CD882F9; Thu, 16 May 2024 13:40:55 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F6288313
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 13:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id CE4631380232;
 Thu, 16 May 2024 07:40:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 16 May 2024 07:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715859651;
 x=1715946051; bh=q+NVLZguUFYODrflU4pyldNoLF7gP7bvlHCKnwa9A1M=; b=
 CMY1/esAs0X/v8KwM7QCvT2KkIVrWzFGROukmOw0FYhJHnj1VB4EHxKPAmVefrLk
 1ffpP4ZYssPb3T1rAdE5u29kDY8DoMvuRu+7QQXx2Y+rBE/B0lsIYx4FDLwlZyy8
 dR+7aUHeNEx45ACLVPnLldt6exMP6ySQUYStdiWaj+czSVZhF7afkIJrYW30xeI5
 XT5HpCFK69tV7RBPKf+Iqp6fYVmTOxWN4pH+EQVjV9hnE5V0xJmLJ+N1B0PALDzl
 8YQNdpS4Xi5tidcQ4G/ep4a3FJIgqLaI5OkP5jMxlQpwtLm57pG2gOzBqp2BxlDH
 HsJFJzkolAP0wR1H2IlVZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715859651; x=
 1715946051; bh=q+NVLZguUFYODrflU4pyldNoLF7gP7bvlHCKnwa9A1M=; b=W
 gRk+g1njdkKw1wE9RdmT06e5vFTm0lVtOrDnoVCX+q03u/zlsFb7icFOHck8eTiV
 10/5QnRVC0H2/Nr7c9pcDCZ0WiCNa9WnRW17nqeC3oa3DGEVyhoroHy9jKpGcrZI
 0NcLddfOsohtIZiX2BESNv8VoZPY48pfzlfH+Y4bskBaAJUcWkXegFtU393CT8K5
 SZJixcce5IqiFt46k7PrfmODHYnLU8hbxa0RgnMnP/jgLrUpyguIBYWGnhNg6Oyh
 37rFgXXyziiZFYjacqHl7Xb3t2WkQ1QKWii9b+O3jpLYWqdD5sjyw+s7EJATXeD+
 0JGeb/gnyt4IlV0IuEbHg==
X-ME-Sender: <xms:w_BFZtHlZg1AcHaStS1P9GBXuY-l_iL6BLuuOCfR824xzR6ICgUREA>
 <xme:w_BFZiW864kjD51llEepG9Px89bLchtGYmOt1gkdKKP36bjC5erp52XYlvLw-VCZu
 pSBzFNN2ecwh7b0QsE>
X-ME-Received: <xmr:w_BFZvKx5AM8ZPA3ujiUZvD2eLWUGQaiU8amaiOqqI0ZKnjIYG-L3iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:w_BFZjGcOkzjHqLqNBhpdu51glP29056jqFA-zS8VrtJnXU8R5mYSw>
 <xmx:w_BFZjVLuNRwp5DKigzCWLPOkcbqjj2YDWEuUuNd06UxeBQKmH8Lsg>
 <xmx:w_BFZuM_zPGdZh9qGbG8M9uuzh9L6vfT-xkzg0qmBWCUOJaaLclTsw>
 <xmx:w_BFZi23PqeuD2B6wHWiUDzi69u8OBaJfAtNC69taE-PriPL3ATl1Q>
 <xmx:w_BFZsMUzPcDdKEcjM7YVEeglqvrExZGU96hYLDoIYkL_LWWjAbcfuiS>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:40:50 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 12:40:27 +0100
Subject: [PATCH v2 07/12] MIPS: boston: Imply various options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-boston-v2-7-77938800d1dd@flygoat.com>
References: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
In-Reply-To: <20240516-boston-v2-0-77938800d1dd@flygoat.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CZBjrAU5NlyUrHS456r0I/mJwWm0ZF91DB5HvH6MZKQ=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjTXDzsMDkV++Dlj7V6Vgmd1ss3LpxxhTp0rfvHruadr3
 K/nnjjG01HKwiDGwSArpsgSIqDUt6Hx4oLrD7L+wMxhZQIZwsDFKQATabnIyPBM9hiLsdzFRA+d
 dO7Xaje+W2ZFa2Z6fte8rD2hK6M6JpSR4ZaK2dWZ/T8WP0k226bP6VLKLZ8R9UZCbn5Y43dzz1m
 lDAA=
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

This is a PC-like platform board.
Enable drivers for most on-board devices to make it useful.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index eb7f3ad23762..748b5175b2eb 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -146,7 +146,34 @@ config TARGET_BOSTON
 	select SUPPORTS_CPU_MIPS64_R2
 	select SUPPORTS_CPU_MIPS64_R6
 	select SUPPORTS_LITTLE_ENDIAN
+	imply BOOTSTD_FULL
+	imply CLK
+	imply CLK_BOSTON
 	imply CMD_DM
+	imply AHCI
+	imply AHCI_PCI
+	imply CFI_FLASH
+	imply MTD_NOR_FLASH
+	imply MMC
+	imply MMC_PCI
+	imply MMC_SDHCI
+	imply MMC_SDHCI_SDMA
+	imply PCH_GBE
+	imply PCI
+	imply PCI_XILINX
+	imply PCI_INIT_R
+	imply SCSI
+	imply SCSI_AHCI
+	imply SYS_NS16550
+	imply SYSRESET
+	imply SYSRESET_CMD_POWEROFF
+	imply SYSRESET_SYSCON
+	imply USB
+	imply USB_EHCI_HCD
+	imply USB_EHCI_PCI
+	imply USB_XHCI_HCD
+	imply USB_XHCI_PCI
+	imply CMD_USB
 
 config TARGET_XILFPGA
 	bool "Support Imagination Xilfpga"

-- 
2.34.1

