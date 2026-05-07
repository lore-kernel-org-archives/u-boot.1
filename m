Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAF4CD3445
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 23:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 809E884BCF;
	Fri,  8 May 2026 01:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fvff4O+W";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="udDXlHs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD65584B92; Fri,  8 May 2026 01:26:10 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9089384BCF
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 01:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gBSzx5W2tz9vC9;
 Fri,  8 May 2026 01:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5FN/yVGoBuz1jFH7hlDPCnz9pcEsIZr5YcfnyZizfk=;
 b=fvff4O+W4dwHlN222uLZaXfXIpk87zIeXYIeYggKd7E7rNkKn8gACI6EadDBqZbvDbmi3r
 N8aT/4SZ347yNk1efKqKmIXuW4//oPumF3fpvSXyheK118w4biZJ7V2hCsLZwlAwY1YoSp
 3lIgx9rNdBFFz37K/5GvTd/AMMCG3+VVse+TGa6egZi1qcyn6JhNTCaQ5MvfGjHMCtkrFQ
 irNwhRO80PFk2lrTy0fiIUdLMxidbKUB/GI5YjGi5cSyd7225akAvjjo/dFgya6/ty5Auo
 XQB8O92jsw9C4u4E0nYVCklbUfvAXAfQBk+XyWzyTA0lqIiH0fiAgCVdIH5JiQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778196364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5FN/yVGoBuz1jFH7hlDPCnz9pcEsIZr5YcfnyZizfk=;
 b=udDXlHs/gxIlC55V5gdhw7Lj/qSKduuqtGzNwV5Y7w9vxg4E22CsWJNXQ07ATRfm2WIwb7
 bp1688AhGJjxrqTk+Ze/u9mXvcfAjh3511zpFTz9bUvqNHT2JwmUCon3INX4uT/5m4Q2lT
 DOpkLl10016ylG+uA/t+ErSfrECD+6spmidwl4Zn9PW6fE3z42elK2PYbkI6k1pf7pOWrX
 qTSiaYF/S2N8yHWXooJWk06GtrsC508zgiLJFbN6Xi/RNKFOaMoIg0uSIHWR9WtH2J+aQR
 VYTbLOeL8Kzms5p0oMyLNKzEYekdpfV7ck+Q05wvYLd+5wzMabwoAMW97gLl8g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] arm: renesas: Generate u-boot-elf.shdr for R-Car Gen5 RSIP
Date: Fri,  8 May 2026 01:25:36 +0200
Message-ID: <20260507232558.304204-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507232558.304204-1-marek.vasut+renesas@mailbox.org>
References: <20260507232558.304204-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: f17648mi1nfsfydipms5hhpdjw6n6fo7
X-MBO-RS-ID: 2c4d7c90945aa0fb75f
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

Add target to generate u-boot-elf.shdr for R-Car Gen5 Cortex-M33
RSIP core. The resulting .shdr SREC file can be written into the
HF at offset 0.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 Makefile                       |  3 +++
 arch/arm/mach-renesas/Makefile | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Makefile b/Makefile
index 49d9740327e..623e66538ec 100644
--- a/Makefile
+++ b/Makefile
@@ -1578,6 +1578,9 @@ spl/u-boot-spl.srec: spl/u-boot-spl FORCE
 %.scif: %.srec
 	$(Q)$(MAKE) $(build)=arch/arm/mach-renesas $@
 
+%.shdr: %.srec
+	$(Q)$(MAKE) $(build)=arch/arm/mach-renesas $@
+
 OBJCOPYFLAGS_u-boot-nodtb.bin := -O binary \
 		$(if $(CONFIG_X86_16BIT_INIT),-R .start16 -R .resetvec) \
 		$(if $(CONFIG_MPC85XX_HAVE_RESET_VECTOR),$(if $(CONFIG_OF_SEPARATE),-R .bootpg -R .resetvec))
diff --git a/arch/arm/mach-renesas/Makefile b/arch/arm/mach-renesas/Makefile
index e3133668e13..83c576d6007 100644
--- a/arch/arm/mach-renesas/Makefile
+++ b/arch/arm/mach-renesas/Makefile
@@ -46,6 +46,20 @@ quiet_cmd_srec_cat = SRECCAT $@
 			-Output_Block_Size 16 \
 			-generate 0x18402010 0x18402014 $(srec_cat_le_cmd) $(CONFIG_SYS_UBOOT_START) 4 \
 			-generate 0x18402014 0x18402018 $(srec_cat_le_cmd) 0x1ef000 4
+
+quiet_cmd_srec_shdr_cat = SRECCAT $@
+      cmd_srec_shdr_cat = srec_cat -output $@ -M 8 \
+			-Output_Block_Size 16 \
+			-generate 0x18400000 0x18400004 $(srec_cat_le_cmd) 0x00000003 4 \
+			-generate 0x18400004 0x18400008 $(srec_cat_le_cmd) 0x0 4 \
+			-generate 0x18402000 0x18402004 $(srec_cat_le_cmd) 0x6b657963 4 \
+			-generate 0x18402004 0x18402008 $(srec_cat_le_cmd) 0x00010010 4 \
+			-generate 0x18402008 0x1840200c $(srec_cat_le_cmd) 0x0 4 \
+			-generate 0x1840200c 0x18402010 $(srec_cat_le_cmd) 0x34040000 4 \
+			-generate 0x18402010 0x18402014 $(srec_cat_le_cmd) $(CONFIG_SYS_UBOOT_START) 4 \
+			-generate 0x18402014 0x18402018 $(srec_cat_le_cmd) 0x1ef000 4 \
+			-generate 0x18402018 0x1840201c $(srec_cat_le_cmd) 0x0 4 \
+			-generate 0x1840201c 0x18402020 $(srec_cat_le_cmd) 0x0 4
 else
 ifneq ($(CONFIG_RCAR_GEN4),)
 quiet_cmd_srec_cat = SRECCAT $@
@@ -121,6 +135,9 @@ spl/u-boot-spl.scif: spl/u-boot-spl.srec spl/u-boot-spl.bin
 u-boot-elf.scif: u-boot-elf.srec u-boot.bin
 	$(call cmd,srec_cat,$(shell wc -c u-boot-dtb.bin | awk '{printf("0x%08x\n",$$1)}'))
 
+u-boot-elf.shdr: u-boot-elf.srec u-boot.bin
+	$(call cmd,srec_shdr_cat,$(shell wc -c u-boot-dtb.bin | awk '{printf("0x%08x\n",$$1)}'))
+
 # if srec_cat is present build u-boot-spl.scif by default
 has_srec_cat = $(call try-run,srec_cat -VERSion,y,n)
 INPUTS-$(has_srec_cat) += u-boot-spl.scif
-- 
2.53.0

