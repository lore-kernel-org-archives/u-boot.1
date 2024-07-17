Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F31C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:07:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC1768870E;
	Wed, 17 Jul 2024 10:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="RWb5LTNw";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8yep52S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A5B087E13; Wed, 17 Jul 2024 10:07:26 +0200 (CEST)
Received: from fhigh8-smtp.messagingengine.com
 (fhigh8-smtp.messagingengine.com [103.168.172.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5999088049
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 729B511402D7;
 Wed, 17 Jul 2024 04:07:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Wed, 17 Jul 2024 04:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1721203643;
 x=1721290043; bh=qnLoEICbiIli5I4WWvca11Z8JM17JE7rBW5QwaQp3jM=; b=
 RWb5LTNwXhkYUGGn4M8SRez/QbOe88+vdN6dpzDE+jt7+a6VGAA1ASwFCh3J4Wng
 7ZotYloRmRlwIAlBWV6G+sPZvI2EdUMzP5xjy0ZwyV/7UNwUPjduRtsM1Ai71aSm
 GP6nSvzeavsjvVR0CHgmnsKPtoEiXSlenzbLaU5jAvYMZdDuRiqlZApjLoyS/Qum
 DYAvmMFwWTTQQCK65jKpuIBPIyQj6+qhuA5AK4mzsQs2ejyz/5T3tpritmks4QyQ
 03TXMv2QpUYhPfbFSsb1Rj8NvA0rb0Lh3Q8XKTVJKYW5FDi2PDLyDtoWOnf81jxn
 6Tw9WrotcJu4ijr9Q/4ATQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721203643; x=
 1721290043; bh=qnLoEICbiIli5I4WWvca11Z8JM17JE7rBW5QwaQp3jM=; b=C
 8yep52SNoAItTHKY4rB7ur89Jntd6e9dl47lqArp3B85M+BJjWFH7pHghWqvQo5a
 lS5W19nMioNZzpLAcp8c8y4QkG4YF0wqp7Wcj7hzMel3yiOBAgz5cJW7AKoa+Vtq
 eMcvXc8H8d9mYVBBm7jyDe3IFmQkmDpYLg86GlFbkUkGOwjSPoo231hUw7ra0kg7
 ypb1b/qMDfcyg84iRt7uK7uqkBuMYI6c0yYlCnS2LO7Yo/9Hyzow78XPntNx+UWb
 mRnVaoAScWZSPuShFgAUDG5nSMQHyOWRoSuqBhoOuAet0bFJ+V8V3A1WwDoy5RFK
 iiTNd7pa48n9eOMzLUIfQ==
X-ME-Sender: <xms:unuXZk-mnlagac4wk_zAy2gaY4OxtJXp2WJ81uS4WWYhJgxkqvpXlw>
 <xme:unuXZsvlwYX4LgecxkXFH0WMXVJALPE0lpxEDZyEwTuthJLff9lMFPluv5xsqKzaK
 s8DD3rXLKXf-W_Oip8>
X-ME-Received: <xmr:unuXZqCRhwDsdzWPIEmYmmVI6VvCGuHdOrbO_n-Wkl75VYqY25xee_PaKQAWKE5Tk_QE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeehgddufedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:unuXZkct8kohbF9bq4efd2R9fxjwP8srf53uY7rSdr9WP_ZbOpY9lw>
 <xmx:unuXZpPVggkgge2gIdik7JnnJK5_6Dvxi7JV5lkdmtmWj7i9yqOWaA>
 <xmx:unuXZumdAXcBAjWXlZsrnM175OTtnBejIJVo3lr3WFrVlJD6VcDXmw>
 <xmx:unuXZrsj-TI-x5Jxm9FLkjBlvfMxNECFLeubrUalkjy3Vz2sZOvzZQ>
 <xmx:u3uXZvu1N_p0UuJGwlck7xnKgwsY-aQZn1DJd1LJ59wDxEsZaMLpCHZ4>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jul 2024 04:07:18 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 17 Jul 2024 16:07:03 +0800
Subject: [PATCH 2/2] config: Use CONFIG_SYS_BIG_ENDIAN in code whenever
 possible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-edian-v1-2-3cd4896edf2d@flygoat.com>
References: <20240717-edian-v1-0-3cd4896edf2d@flygoat.com>
In-Reply-To: <20240717-edian-v1-0-3cd4896edf2d@flygoat.com>
To: u-boot@lists.denx.de, uboot-snps-arc@synopsys.com
Cc: Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Ezequiel Garcia <ezequiel@collabora.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4642;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=dDr26qzKVGGGwtFn0nvMFUzVK0ahJ18RaHGf5Rvidw8=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTp1atV9K+o/Z2ntblbPJOJn2FazJ1lkRMcnnwJYeSOy
 nq3JsG2o5SFQYyLQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACZi/ZmR4SLjlx/9oi4i5UIF
 n1LC7Dr36BxwcLnxK7C794H2/cjDmowM/V0LmWV49p+463km/m79orKyQ3s9xNUMpQpdihtdM+7
 yAAA=
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
index f5b2512f3690..aa791426424f 100644
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
2.45.2

