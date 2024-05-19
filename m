Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1FCC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 12:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB6D886B3;
	Sun, 19 May 2024 14:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="5CCnkUZL";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="pPupfMGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED68886B1; Sun, 19 May 2024 14:57:43 +0200 (CEST)
Received: from wfout6-smtp.messagingengine.com
 (wfout6-smtp.messagingengine.com [64.147.123.149])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C1BB882B5
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 14:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id 6ACE21C00099;
 Sun, 19 May 2024 08:57:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Sun, 19 May 2024 08:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716123458;
 x=1716209858; bh=9nKrP3/TdzYaqi8bLQJWpxkzKWxQILRjnQM6ViawEtc=; b=
 5CCnkUZLPsTqzWMJm7Z3fQhg6IGxvcvWGZjzpUHBWQZPB8z30ZmtlF5V2SLf4NO0
 grM9AQrM3d66bbmHm//9zNqEE28ZodaBhPJpHBrpZ9AXTigbjk/RoBkrEJVuHofL
 ZCRbEBRsU/JSng27NJy29f0OI/XGujuZB55qlsUWuYJpVGASirQhUIRVQCC2ViAw
 zU+Yf0b6S+tfCtOwJocPSysXJQ6C8YMFqXj23qFfsuQNLHN2og2HaEG8IwxXpcwP
 WdCrZ7+X941VI9wDyCvaDbhKyZ8Ir5PXaAGlGj3Gg6ZMpOyjKFlDQ3krA3zQ+n4j
 Re4RenoUsT7Go3SrqYCMxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716123458; x=
 1716209858; bh=9nKrP3/TdzYaqi8bLQJWpxkzKWxQILRjnQM6ViawEtc=; b=p
 PupfMGCc3eEHE6KHSmSGZdYL/nlDvbF0BC50eLEOqpU1wO6O19Q/4zJecqJ/9weK
 fLRVZEbfvy77jd/DtLOqmgxiGCK0a6xprtduroxHj5XTid2GAN2oHb55MtQWu1Qi
 f/dO9tjfNRgy70oWXrU4jKZK3uEz7fWkTS91FBIAoKNc1YUhJWeb0sQwwF01wC1O
 Av+MlGD5vtYavOBk4Lke2FIJoaZy2cP10M4LmAjmZHMb8D/bLpjXuRVZoOvsBq3c
 BZlJ4NZXfi9ywDSYOUiZhOGfCOwIAer7MGgvUBQVc8+xxVu5yWnCnOIgXnn5b2mG
 xudLVbjZuw8eCyZHLeeGg==
X-ME-Sender: <xms:QfdJZvLtKPUqkTFcTpmUMuyKV5htb8d3XJEB5jIZMf5K5FtubNwzlA>
 <xme:QfdJZjLYQqc2fPE4T1LCfTbxnYaYSgy0wcfeuznpkqOGtMkzi_zA5pZ3DDectTgUp
 -BKjjkeU8NEID3G-Ik>
X-ME-Received: <xmr:QfdJZntRK-do-9Q7CTYQe_uqWxaGZfJv_JFD5Zba0h5kQ-pjQ_DNZZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:QfdJZoaf7WSgZpa00MN3Rew9KsrPb7lhKCJdb6pMV5zCfU2KlXTQvQ>
 <xmx:QfdJZmYUS_YUV3ebOOz9e9pX0ohy5Yy09zA4gBWmwpJzReylKDZ8dA>
 <xmx:QfdJZsDvORWBfa48Yosv3D7rIZ9pMU1twIo6krCwQ9T-yYHtKvym-w>
 <xmx:QfdJZkYmrw6FrVrJhCtuvXMUsR1odK1OpggGr4ZFOKkCRybEvyF2Ug>
 <xmx:QvdJZouZpgkiuq_8bJtlIrPlnuBizAvfPiENehxedegNVY3jdsxPHJgZ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 08:57:35 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 13:56:57 +0100
Subject: [PATCH 12/13] config: Use CONFIG_SYS_BIG_ENDIAN in code whenever
 possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-aarch64-be-v1-12-75cc328eddfa@flygoat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4642;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=D7TRtB2PzZkn2GYcMRbFyhA3Ykd61jGG2zJ+46LANB4=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjTP7wKZUtfU0+JerpknvXbyvMJfIuV/n1yYWia9JGdq/
 0vZ7VGiHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjARVQ2G/y4hFe4/YpXn7f9w
 hnPiVc+mYwcnaO5bMGnmP52H14qcrdwY/qkbTWNY+83+l9v3jRs+bvtvsqilq+v85sUHZYVW1Rw
 pWsAIAA==
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

So CONFIG_SYS_BIG_ENDIAN is our cross architecture option for
selecting machine endian, while the old CONFIG_CPU_BIG_ENDIAN
is defined by Arc only.

Use it whenever possible to ensure big endian code path is enabled
for all possible big endian machines.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 Makefile                                            |  2 +-
 arch/arc/include/asm/arc-bcr.h                      | 10 +++++-----
 arch/arm/cpu/armv8/linux-kernel-image-header-vars.h |  4 ++--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c            |  2 +-
 scripts/Makefile.build                              |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 44deb339af19..49959ecf3100 100644
--- a/Makefile
+++ b/Makefile
@@ -1048,7 +1048,7 @@ endif
 CHECKFLAGS += --arch=$(ARCH)
 
 # insure the checker run with the right endianness
-CHECKFLAGS += $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig-endian,-mlittle-endian)
+CHECKFLAGS += $(if $(CONFIG_SYS_BIG_ENDIAN),-mbig-endian,-mlittle-endian)
 
 # the checker needs the correct machine size
 CHECKFLAGS += $(if $(CONFIG_64BIT),-m64,-m32)
diff --git a/arch/arc/include/asm/arc-bcr.h b/arch/arc/include/asm/arc-bcr.h
index a6c972bf1e31..d4de9b818c1a 100644
--- a/arch/arc/include/asm/arc-bcr.h
+++ b/arch/arc/include/asm/arc-bcr.h
@@ -15,7 +15,7 @@
 
 union bcr_di_cache {
 	struct {
-#ifdef CONFIG_CPU_BIG_ENDIAN
+#ifdef CONFIG_SYS_BIG_ENDIAN
 		unsigned int pad:12, line_len:4, sz:4, config:4, ver:8;
 #else
 		unsigned int ver:8, config:4, sz:4, line_len:4, pad:12;
@@ -26,7 +26,7 @@ union bcr_di_cache {
 
 union bcr_slc_cfg {
 	struct {
-#ifdef CONFIG_CPU_BIG_ENDIAN
+#ifdef CONFIG_SYS_BIG_ENDIAN
 		unsigned int pad:24, way:2, lsz:2, sz:4;
 #else
 		unsigned int sz:4, lsz:2, way:2, pad:24;
@@ -37,7 +37,7 @@ union bcr_slc_cfg {
 
 union bcr_generic {
 	struct {
-#ifdef CONFIG_CPU_BIG_ENDIAN
+#ifdef CONFIG_SYS_BIG_ENDIAN
 		unsigned int pad:24, ver:8;
 #else
 		unsigned int ver:8, pad:24;
@@ -48,7 +48,7 @@ union bcr_generic {
 
 union bcr_clust_cfg {
 	struct {
-#ifdef CONFIG_CPU_BIG_ENDIAN
+#ifdef CONFIG_SYS_BIG_ENDIAN
 		unsigned int pad:7, c:1, num_entries:8, num_cores:8, ver:8;
 #else
 		unsigned int ver:8, num_cores:8, num_entries:8, c:1, pad:7;
@@ -59,7 +59,7 @@ union bcr_clust_cfg {
 
 union bcr_mmu_4 {
 	struct {
-#ifdef CONFIG_CPU_BIG_ENDIAN
+#ifdef CONFIG_SYS_BIG_ENDIAN
 	unsigned int ver:8, sasid:1, sz1:4, sz0:4, res:2, pae:1,
 		     n_ways:2, n_entry:2, n_super:2, u_itlb:3, u_dtlb:3;
 #else
diff --git a/arch/arm/cpu/armv8/linux-kernel-image-header-vars.h b/arch/arm/cpu/armv8/linux-kernel-image-header-vars.h
index b6394aee1657..c6af825dbc7b 100644
--- a/arch/arm/cpu/armv8/linux-kernel-image-header-vars.h
+++ b/arch/arm/cpu/armv8/linux-kernel-image-header-vars.h
@@ -31,7 +31,7 @@
  * when PIE is in effect. So we need to split them up in 32-bit high and low
  * words.
  */
-#ifdef CONFIG_CPU_BIG_ENDIAN
+#ifdef CONFIG_SYS_BIG_ENDIAN
 #define DATA_LE32(data)				\
 	((((data) & 0x000000ff) << 24) |	\
 	 (((data) & 0x0000ff00) << 8)  |	\
@@ -55,7 +55,7 @@
 #endif
 #define __MEM_USAGE		(__CODE_DATA_SIZE + __MAX_EXTRA_RAM_USAGE)
 
-#ifdef CONFIG_CPU_BIG_ENDIAN
+#ifdef CONFIG_SYS_BIG_ENDIAN
 #define __HEAD_FLAG_BE		1
 #else
 #define __HEAD_FLAG_BE		0
diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index b7bf7cc0893d..b1af3f717d43 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1698,7 +1698,7 @@ static int brcmnand_fill_dma_desc(struct brcmnand_host *host,
 	desc->cmd_irq = (dma_cmd << 24) |
 		(end ? (0x03 << 8) : 0) | /* IRQ | STOP */
 		(!!begin) | ((!!end) << 1); /* head, tail */
-#ifdef CONFIG_CPU_BIG_ENDIAN
+#ifdef CONFIG_SYS_BIG_ENDIAN
 	desc->cmd_irq |= 0x01 << 12;
 #endif
 	desc->dram_addr = lower_32_bits(buf);
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 97dd4a64f6ef..99cc29595b4a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -224,7 +224,7 @@ recordmcount_source := $(srctree)/scripts/recordmcount.c \
 		    $(srctree)/scripts/recordmcount.h
 else
 sub_cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
-	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
+	"$(if $(CONFIG_SYS_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \

-- 
2.43.0

