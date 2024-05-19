Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C812C25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 580A488291;
	Sun, 19 May 2024 14:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="DnyKjvsz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="WoPs8eY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A228869A; Sun, 19 May 2024 14:57:28 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D301886AE
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 869201C000D9;
 Sun, 19 May 2024 08:57:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Sun, 19 May 2024 08:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123442;
 x=1716209842; bh=+WPQAF07FH2pnYemc+vWqbMVULpLUAWKBUQRCf02OFU=; b=
 DnyKjvszmqUqBUOd9aaDulyRmJqPhWcwR49ihiXEbpE7y+0GdPTHjcjzKN9z9PY4
 cK5a1U0wBllFSeHHdka65pF7y+Z2hIIxcXpl18QAh+QcmEoIUd5irXty5CThNtL2
 fjWT7S2ZtIKcCGZ5xV5duZaEPN5tK6l4OJm0lgULr2GYaabF5A+uPn4jPA93WBpE
 hQd9bs/5Q1ITBkuQCJlD2cltrs63bd6/M7iieAAvrWKXUkMOzmYaEgPlrn9BM6TY
 L6bq6BzF2vfcvQW6K9nRBW7tMyHI+6eH+dTBnVg+kDV6oJ5VsoMit3DLeXskckPJ
 UtYnUASdMh1Z3orPd4782g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123442; x=
 1716209842; bh=+WPQAF07FH2pnYemc+vWqbMVULpLUAWKBUQRCf02OFU=; b=W
 oPs8eY0JwNCCmamWWW3GANiHJTz1U3YLzcS8SwG3LexUjJGS/SH/sErUe6zrnAX5
 zITJz3ZYEcI11u1tgxxe8LEKaF3eeUtdrFVLxi/zXNwtqNwZgXzg6ODROIu22JtS
 RN9tznjBXSeRdQhxKpgHZGRz2Rd9WWWNqrtbeImlCCYkZcP8+gE9OiL8qlkrsFI0
 6Sn4nUTK9EaREWUryak6GQ7/CUIcld8wnCl8hQWtsdMM82Xqg1fD3KJybj+KRtVb
 W0DR6DYxhSUYvCOXULv46wXnc9Ld7r/sB1y8Ph2IhQQAX3inPEaw2QtULTqGFNMd
 9+DEOZdE86k2aDR4b1B/Q==
X-ME-Sender: <xms:MfdJZuRdEMBtbgAZwxlK5A7YLCSKq2yhKjrVwx2ixSFIDPAbMxT5TA>
 <xme:MfdJZjzueAmqvIEgyye1qUB-Nc0nYbtzQO26cC04Es71p9-Y0164kc1tP20jm_3u0
 5XTIAX4mk05D7GUJTU>
X-ME-Received: <xmr:MfdJZr2vN03uyT_hd9nG5RIc18rvg0LB3-v7nBZY7VaEHgjjkO_YLw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepuddvuedtffejueelheekvdffveekieduveefueffhffftdel
 leekudevjeeviedtnecuffhomhgrihhnpehsthgrrhhtrdhssgenucevlhhushhtvghruf
 hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
 lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:MvdJZqANuRV60fJhM-IRHOTUEPqviM6XKtcjdkRdWy7Dfo0B0giCOg>
 <xmx:MvdJZnhRzA2B-u1rT7iLKImHNX_jlR4Yl7CgQSzIl-i1GUl_mwvNpQ>
 <xmx:MvdJZmoctxwqjIxQuNwJINT2dUdSiuatMpaI7Nc0_Lw9c_ufAosFyQ>
 <xmx:MvdJZqjm001HVf7RONaQRyg-p5xrJ0MYZ1wjXmfaFz5NroEljQvp7A>
 <xmx:MvdJZmV70COL-GRIckScEQXc45gRlMGkG1n1_VYjBCWZoS6UcccJPDfV>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:20 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:53 +0100
Subject: [PATCH 08/13] armv8: Allow endianness to be setted at reset entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-8-75cc328eddfa@flygoat.com>
References: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
In-Reply-To: <20240519-aarch64-be-v1-0-75cc328eddfa@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=y4+DwH0p4ZmKEWSBAWeL2oK8jl/XN3q+9Pr533Z/tOg=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7wLffzdKvzz7dq/QhQdLHc7eeBTGoyI/d0a+7ub97
 DNmfGDW7ShlYRDjYpAVU2QJEVDq29B4ccH1B1l/YOawMoEMYeDiFICJcJ5i+F9dVrO82zqiIDLL
 bZE7v+l9OREm1uu9d/8G9G8NUNq96Cojw4UdWhsDmsUuSp1/xJEeniM57YFb1uuNFoVcU88Eu8t
 e5gQA
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

Provide a option to allow Endian at U-Boot's EL to be setted
at reset entry.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm/cpu/armv8/Kconfig |  9 +++++++++
 arch/arm/cpu/armv8/start.S | 26 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
index 9f0fb369f773..4b38ee12de58 100644
--- a/arch/arm/cpu/armv8/Kconfig
+++ b/arch/arm/cpu/armv8/Kconfig
@@ -14,6 +14,15 @@ config ARMV8_SPL_EXCEPTION_VECTORS
 	  Say N here if you are running out of code space in the image
 	  and want to save some space at the cost of less debugging info.
 
+config ARMV8_RESET_SET_ENDIAN
+	bool "Set CPU endianness at reset entry"
+	help
+	  Perform endianness setting with SCTLR_ELx registers at U-Boot's
+	  reset entry.
+
+	  Say Y here if your CPU may comes out of reset in a different
+	  endianness.
+
 config ARMV8_MULTIENTRY
         bool "Enable multiple CPUs to enter into U-Boot"
 
diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 746128026172..2e6ae2f6f3ca 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -9,6 +9,7 @@
 #include <linux/linkage.h>
 #include <asm/macro.h>
 #include <asm/armv8/mmu.h>
+#include <asm/assembler.h>
 
 /*************************************************************************
  *
@@ -53,6 +54,31 @@ _bss_end_ofs:
 	.quad	__bss_end - _start
 
 reset:
+#if CONFIG_IS_ENABLED(ARMV8_RESET_SET_ENDIAN)
+	switch_el x16, 3f, 2f, 1f
+3:	mrs	x16, sctlr_el3
+CPU_BE(	mov	x17, #(CR_EE))
+CPU_BE(	orr	x16, x17, x16)
+CPU_LE(	mov	x17, #~(CR_EE))
+CPU_LE(	and	x16, x17, x16)
+	msr	sctlr_el3, x16
+	isb
+2:	mrs	x16, sctlr_el2
+CPU_BE(	mov	x17, #(CR_EE | CR_E0E))
+CPU_BE(	orr	x16, x17, x16)
+CPU_LE(	mov	x17, #~(CR_EE | CR_E0E))
+CPU_LE(	and	x16, x17, x16)
+	msr	sctlr_el2, x16
+	isb
+1:	mrs	x16, sctlr_el1
+CPU_BE(	mov	x17, #(CR_EE | CR_E0E))
+CPU_BE(	orr	x16, x17, x16)
+CPU_LE(	mov	x17, #~(CR_EE | CR_E0E))
+CPU_LE(	and	x16, x17, x16)
+	msr	sctlr_el1, x16
+0:	isb
+#endif
+
 	/* Allow the board to save important registers */
 	b	save_boot_params
 .globl	save_boot_params_ret

-- 
2.43.0

