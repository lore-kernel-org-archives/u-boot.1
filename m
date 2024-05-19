Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD278C25B77
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67C4588633;
	Sun, 19 May 2024 14:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="GDEU6c75";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRycikJn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36DC588633; Sun, 19 May 2024 14:57:08 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156808849D
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfout.west.internal (Postfix) with ESMTP id 134901C00099;
 Sun, 19 May 2024 08:57:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Sun, 19 May 2024 08:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123422;
 x=1716209822; bh=R++e2OxRdxhOhfyXW/fgfSK09WKNubBoYGFz/UJHtMs=; b=
 GDEU6c75OJcHO6LVojyBCyKXcmcZWfyItbRAx+tF+L+2P2vzzjQcgmi9ohsU7T+t
 p9oL22KMXI3+Tb0k/JqdWyaIeh/Ea8OFlN1TbsILj5lwHsaC2wiNWyJYOGVywCuq
 /ZliYpQ/bf8DC5MISv93zgObjb1fRBrdDtf0jtNUXKxLDOgNVF/r4FSfXEnBfixr
 plpeiISA+PR5oeswvGO/DrvMHGZy4ldjkJ3+aJL+0n4kKfT/NtGP0b1oWIEM75jw
 KnG/c/iJR6wn0dyL6ZtC1jWvfp7kwnBb/+Ybkk9ypoE9VPwOXgcF3fse3+QHCxX4
 WapsTC0oImB037whJnVesQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123422; x=
 1716209822; bh=R++e2OxRdxhOhfyXW/fgfSK09WKNubBoYGFz/UJHtMs=; b=F
 RycikJn6UCxs8b1efjQinSfWTDPHKAwlGx+sTWWXxfrnNPCl/6iRRmeeAvukfImr
 peVS88FjUlKHAs/fcDXvBp9vfdGvMwE01pKVXIp/4DG6T+AEw1ttwZZpWQQiTIr0
 BMP4OjOB37lMdVAkCEYfUBu0ce4j8TcfYxDQdJTi8NLHnSKpiOwaJrcaC21IgEvy
 8pOFYZomoa+miiWgASnUPsFJ+pJYvO3H/1ImWsCSCV+Nim4r2GhidS+lxjZq/drp
 iOqlV5N6hfGH6dgYtHcecbmTRHtlb+CZlfOjWcOpXbh4AyKxJk/6k/P0Gu21lAF9
 9+j+iwKlWGznhBfPM3BMw==
X-ME-Sender: <xms:HvdJZu3Oq-951jdBOfxBR2CssxTNe7bfUOBJNiwib1mKb-q7YdGjUA>
 <xme:HvdJZhElgvjPmuIRfa1YIgLGq2mTzmk3lcDCXoyzEBX-7fyIJamDktdl6kshY6M4U
 kRe_hKLhFnM2pQdduA>
X-ME-Received: <xmr:HvdJZm5mw515WZJQ8fFJfz-bE36ZOUv8OByUmtfhQxIAwhmZaDm1syM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:HvdJZv3chNAzPnvR4m6Z0cp3SDvsH4hH3DSMbqUa-NbzFskEP0TZWw>
 <xmx:HvdJZhEqnYKZTY_sb95oi0yAhwUF5e0uKFsXSoXjkuqWmescB60TKA>
 <xmx:HvdJZo_LSNdYCfNg-iFK0qcvQm2n7Y75NlfV6_e-8o_0JX03X2Ei7w>
 <xmx:HvdJZmm3Ui2K5lji-6bg3bcrHhttBbpUXcHp-wjGzhcWpKPBOSwnMw>
 <xmx:HvdJZqJyUeMCfEVT85gVeu34o5UGEKjA_qzc9nxZ-Hk2stEwn6czhqAs>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:00 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:48 +0100
Subject: [PATCH 03/13] arm: Fix assembler.h for arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-3-75cc328eddfa@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=970;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=Hr3QOjuatJoZm6dzF/pmhMO+Pdfnq8G8AsT8jAXxWCQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7/wc1nXRKv1/LmkZ2ivUyD40bV6aznJVMOjPjT8pH
 9cGG2zrKGVhEONikBVTZAkRUOrb0HhxwfUHWX9g5rAygQxh4OIUgIkcZ2VkmKvjtXuqYrRs9sSW
 2rWZEqwZdZ/WKHhlOBRu4ZEwWcNdyfA/10Pg8tH4Gaeq3obelL40uyA7JyD1fidLRWDT1mu1T05
 zAgA=
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

Header guard is missing, and ret macro is not relevant for
arm64.

Both fixed.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/arm/include/asm/assembler.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 4fda483b8d8d..c3b8f34dd0af 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -14,6 +14,9 @@
  *  assembler source.
  */
 
+#ifndef __ASM_ARM_ASSEMBLER_H
+#define __ASM_ARM_ASSEMBLER_H
+
 #include <asm/unified.h>
 
 /*
@@ -56,6 +59,7 @@
 #define PLD(code...)
 #endif
 
+#if !defined(__aarch64__)
 /*
  * Use 'bx lr' everywhere except ARMv4 (without 'T') where only 'mov pc, lr'
  * works
@@ -75,6 +79,7 @@
 #endif
 	.endm
 	.endr
+#endif
 
 /*
  * Cache aligned, used for optimized memcpy/memset
@@ -87,3 +92,5 @@
 #else
 #define CALGN(code...) code
 #endif
+
+#endif

-- 
2.43.0

