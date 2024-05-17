Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453EFC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77B228854E;
	Fri, 17 May 2024 20:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="qVr4l4mX";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="iq6ILJhN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9395488566; Fri, 17 May 2024 20:15:08 +0200 (CEST)
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com
 [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9468288518
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id C8A1D13814F5;
 Fri, 17 May 2024 14:15:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Fri, 17 May 2024 14:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969705;
 x=1716056105; bh=q+NVLZguUFYODrflU4pyldNoLF7gP7bvlHCKnwa9A1M=; b=
 qVr4l4mXtfeT+dLp7W/+bldQm00CNwyTO6ZQtG3e0SjL834UA/q9Ntr68xPkyNSS
 z8UK5TIuP/xgWtWJI/fMB6x9S0Z2/eO00rLgOUJ4ZD96nTw/tD/oNaY8iOoCv9uB
 OEp5hWkjfkQWYYpO+2ekxf56R/eJ9LpOIAC1UHlBSse1lTVd1bsBCBBW1lrao2m3
 mrvfvZykdsqceCq9hBuFTAdr4swv2AyMydkPYIjEKWZxPBBfQ+LEYk8Wu3JuA7XA
 /zZRhyCpgMZTgwCQzMwutx/aUtXdPUbW/oOReaousWqfNvRW20ZbaPPoNnBHOnMu
 9mkw/JP3WQIx9D/x+baFNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969705; x=
 1716056105; bh=q+NVLZguUFYODrflU4pyldNoLF7gP7bvlHCKnwa9A1M=; b=i
 q6ILJhNeRcUL3Z9DHVa8suy4dRJD+Np3IAOwwxbPb9EwgRuXo5eFmEMj5QEZ46k1
 CeiO4NXAbrbBxX9aiEmVg+2D2EwwBhZVklTSgUMjaKEruq4jwPfj6KdvIQA1JqDM
 i9PXxmNkNKsmp+OT6l54thvJGMuv6Uqa5hlbAXFgnSyfpJKOL88uitj0yz/lIl8v
 pSp3Hha3xnqak77qNo6TMnbygyV1ZvpjcFgII2zSKS7ZdFkWkmfU0bWrAIkukxkr
 mh/LahFViXvPGv09fBdMQS3Xc+DbcVtBT/io+nPorTMqgtrVVSgg2obYhbD4Wxyo
 bs23z+ld8zvYWfpe9jG+Q==
X-ME-Sender: <xms:qZ5HZvvwCPlyaprvw5UNNQqpGBDWB4d90xE9upIi0AiDzUjwQHXtQg>
 <xme:qZ5HZgc5qioH0ZU-LkaG2cbK_7ZMsncmu1QVjVUuRv5p9Uf0XC1ZT_5ca3tB_qBym
 mXEQtAQeJytVMqBRvk>
X-ME-Received: <xmr:qZ5HZizqirUVY8hy-x9Z75NWAF-_nI3nbp5erb61T79vWYu_I76Q4Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:qZ5HZuOo_GcFMw2JkOe2IinW6GLd252KVMmQX3ZugKh0SbvG4al9Cg>
 <xmx:qZ5HZv-e1w1H2POHPkyFsznN8-4Qe_wuXYTZ88KTmqJserehBJiOMw>
 <xmx:qZ5HZuVootNMdCqBNj4c2sLjbDOaf8BHZ6mq6GwGkLlGQACaww6b2Q>
 <xmx:qZ5HZgf5HcKxTQj3lwqluLr3yljUK1IrLRgW7CI-BhiuvAo6bGe5xA>
 <xmx:qZ5HZuV-aKfe05e7D9V78tq72-uAMW2OStvq159GIZAHfUtNcjJ1hGKt>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:15:03 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:55 +0100
Subject: [PATCH v3 07/12] MIPS: boston: Imply various options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-7-1ea7d23f4a1d@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=CZBjrAU5NlyUrHS456r0I/mJwWm0ZF91DB5HvH6MZKQ=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebOnrdhwlTHOLE80sP//q/4L2b+/1lvru3ac/vqMW
 Ur6mQ9LRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEyEaTbDP1U1K76iZW36O/Km
 /+mOe3latECM1b74ospSp9Iry0W+uzH8d+It2ezKeFLjhM6EW/w6i+vm+r1xW77bhnXrcsXSuRW
 HuQA=
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

