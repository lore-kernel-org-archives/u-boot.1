Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7490C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 18:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A68E88368;
	Mon, 13 May 2024 20:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="tBLx14uQ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z6WQPxm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE68882ED; Mon, 13 May 2024 20:13:23 +0200 (CEST)
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com
 [103.168.172.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE1288312
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 20:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id 8BCFB13803A5;
 Mon, 13 May 2024 14:13:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Mon, 13 May 2024 14:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715624000;
 x=1715710400; bh=q+NVLZguUFYODrflU4pyldNoLF7gP7bvlHCKnwa9A1M=; b=
 tBLx14uQ/uetogJIVu6Q8dHfvp68dQSG+0PzKezSsmi8Yuc64rh0Q8EU/ipQ5cYw
 5HZznCxnwyw3Q5vg5epnO9I1sEm5wdsSdFNkoCvcDYjnTtcXE2Z5fTIZKQlLP8K0
 y5X1m7QMmw+Okbuh49Wk4fJHmr9NF9pJAJ5As8OX1oooOLagw1Re82uP9ODKBqia
 fBVSxWEi3bMLRajim2Xw1H3swGQwdr8DcDVAitGeGbvxtdmcj3s6WFbpuSmeM06A
 cGRRjzKvOLgFM3JK8izh+TFXGclJWTOiANhNq/lCBp39Lm4fequrYppbxd6iQLgW
 e0azBqKeH/cCt0Z8/u6r3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715624000; x=
 1715710400; bh=q+NVLZguUFYODrflU4pyldNoLF7gP7bvlHCKnwa9A1M=; b=Z
 6WQPxm9MsJOO/geP/0Aq5yMWXKmnfqRJGthsG/LTjbtUJYEavzrbuYe3sKsRfWuE
 v1jEMwAKXsmoSY+79VzLBJL8CZh0g3+RcOukJGmPBaayZiGhOtHkO5e2ujrCbdcY
 MI1+hdEYZNRtW9EawYySJkd6RhDVowWvc5WsMoVZ/SKN/ZyVmQAFnl1lHNOgW4lO
 UPjTKrHnpdeCXs8lG7ot7cJ3eWn9+T44R0I35Xq/5bppnkBtRnFq1AK4QLJZ656Q
 JmYE/l0WrBJ4CQji379Meizno70Q3Msb4IGw7WFZyzRIOb/eCuo0DBa1EzWWuULO
 jFZg+vwWSJ1kp+5Jnsa0g==
X-ME-Sender: <xms:QFhCZmhe3bJXY1XUxIcA7rxK5QZp3-MrnCWnT56KPwwOgkVTAFWQ0A>
 <xme:QFhCZnC-6Io2GZqDExnzCJAU9j7JWhDLZM9NdH160Y0n3XPQD8wW9S-YrdIrKUxDg
 OFYEyz7M9u4im8iUOw>
X-ME-Received: <xmr:QFhCZuEN0uY3KLUY7dp1a9CbhWYNpxlyDUEepQL0uvqlJcrko-TgkGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddvudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:QFhCZvR6Ny7ATfOyILBT5-72px8ZS3sZ07tfbZPH7gSlAKvo5GJrMQ>
 <xmx:QFhCZjxWSrM49vw8BguJ6EVEZAYs9svcfp2EPlS8CGVXifwCGWW_Ug>
 <xmx:QFhCZt47VyjtXxMJ3ZOfOvEHf3Lcd-GQiYMHNedXZzO-Uy21c_lezA>
 <xmx:QFhCZgyDM7Tta6WV59w6VsmiCeXS7JDqdiWbPPOdNCYDW9nM-BrmHw>
 <xmx:QFhCZorvIj651ED3NIuvb1uMCGbe8jQPXJK34l1kN3LweYME__DnoyP0>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:13:18 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Mon, 13 May 2024 19:13:04 +0100
Subject: [PATCH 07/13] MIPS: boston: Imply various options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-boston-v1-7-fac96938417e@flygoat.com>
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-0-fac96938417e@flygoat.com>
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
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjSnCOOS93EbZzIm9vA+/3fHuj/+/O6VV+s/R3bzxraVe
 20K+8vVUcrCIMbBICumyBIioNS3ofHigusPsv7AzGFlAhnCwMUpABP5Y8DI8NxIPWD1Utc3uk7C
 c/TMZC79XNka8k3/lP1s32j/T6vev2FkOLRq0mndXJZJPzrYZnZMCrRld9pccvZWTl6EQMEW2U5
 zbgA=
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

