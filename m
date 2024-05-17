Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24B4C25B78
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 18:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BDAC88556;
	Fri, 17 May 2024 20:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="Rjkzk2kR";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IU4naAlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE0E78853E; Fri, 17 May 2024 20:15:00 +0200 (CEST)
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D772688547
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 20:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id EEE5611401C5;
 Fri, 17 May 2024 14:14:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Fri, 17 May 2024 14:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715969697;
 x=1716056097; bh=x8LDYv2RenMOlJR07nmGqmXKuo8xzS8MSIcW3Gnujww=; b=
 Rjkzk2kRxQQNdeLwgsNTIBykDmic5wp82cFuiIwqwYU7mut0cyzi/vG2245c7tGL
 bE8zaUTrO/Rqg3ehqjEDtE92anT3G13ceZOFvuvOyQQ+xPWVDHDssWKjbS6f1Sa9
 gCE4n03NuJod7giWWcq7rD+KHmbSYi5XZWMW0n1+mOJqnUmUfcRuIYzcsTbcJ+4e
 NYUjoiywjCBvyq1L+1qbTQf4IUaZxJ/XoruIohV+4clDNCxlQkW1btyR1AIPeeC4
 OPHVhYizYcRDpTGTr+7jo6xjgAE9o7JFpC7cTFYxAkJNtrR6LPEN3lpkEOb4jKlF
 IaeWgnT/+SA6GIOlaWfBGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715969697; x=
 1716056097; bh=x8LDYv2RenMOlJR07nmGqmXKuo8xzS8MSIcW3Gnujww=; b=I
 U4naAlAfX+uzCwPkFNAM5ewsc2ywbsfdsMyNYDzxIYfZmZZ04toXUnLGtORUjzrq
 IcwdprmTdOzeqp5ZNrqj6evLBaUFNw9FPbutXIzKY+23TfMVVNoHutQACl6ZXbe9
 uskE+vmQHZmFyNNPhP5BuHS12FOGQS2jqv2xTaQDbnaqpLamMf6MyW5FuPrKfqch
 KUMlv/ZpnRXn+LLxvUMHtWc1qRz//V0ywBhMs/1sBAhfyH3avF2DArqc6nd8quFm
 YN9C4eK6F3qFB6CuQ7bIm7LIfJuOfT4Ycqzm/wGUog+e80uTr8J1mVeMm8Bw6c99
 F3R/ALaO1XS7pMB1WViIw==
X-ME-Sender: <xms:oZ5HZgJiEY8iVa-kmtCc8UmtjdEU42ZGVYRzZmYS8FQCNT_otIaFtA>
 <xme:oZ5HZgKjQuYO9O0oba4YY019i5I7qNffP1nA9V63qfSva5UCswn4Jox-ytKet2WqO
 q45YDKeNFVN2AYwOSs>
X-ME-Received: <xmr:oZ5HZguMC-KaQ2lx4_X0KwJcAgToKP1uZJi2X1Kpai8yy0kAPd6vKlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehgedgvdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:oZ5HZtbuw4epjGhGJJSTZZPOcZOEO69SNruP2Mv8nyX9Oz9ut1YxUQ>
 <xmx:oZ5HZna5jNShq72VRApON03jkiJnRQRo8Vqvi4RlHjj7Stc66t-WLA>
 <xmx:oZ5HZpCXObxhbHmhdrKXRuti1u5lX_jWgDQgFq4G6xaJQsxpl348Pg>
 <xmx:oZ5HZtZ5Du5sKB_xrGRsk7hO-3Ry6AoH3EIGWIHVsLRV9frt-tOWNA>
 <xmx:oZ5HZlCupCm-44rOy6-HpgEiDagiEcL44349RUKytWLUuFhUGvp3KmBR>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 14:14:56 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 19:14:51 +0100
Subject: [PATCH v3 03/12] pci: Enable PCI_MAP_SYSTEM_MEMORY when
 ARCH_MAP_SYSMEM is not set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-boston-v3-3-1ea7d23f4a1d@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=845;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=5P0kah0j1rkZJDtXsUvgnBypLjtGpRRBsmtGjzJbCg4=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3ebMNX2hPDFrcsObgze1eSsHv/PubqqQe2S2fYflwQ
 biGLN+1jlIWBjEOBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZjIJQuG/3GrBCUyF55U//3o
 k96WUNnQwhMq4hpf/xdob1GsPFUuO5Phv3tx8fTZvhfaLux7b6/HbRw7PfjMacGKyw2uKiZavRL
 dLAA=
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

For MIPS we are always looking gd->dram in virtual address so
PCI_MAP_SYSTEM_MEMORY should always be enabled.

If in future we ever want to make it physical we have to set
ARCH_MAP_SYSMEM.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/pci/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 289d1deb38b6..14f6067fa29b 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -67,6 +67,7 @@ config PCI_CONFIG_HOST_BRIDGE
 config PCI_MAP_SYSTEM_MEMORY
 	bool "Map local system memory from a virtual base address"
 	depends on MIPS
+	default y if !ARCH_MAP_SYSMEM
 	help
 	  Say Y if base address of system memory is being used as a virtual address
 	  instead of a physical address (e.g. on MIPS). The PCI core will then remap

-- 
2.34.1

