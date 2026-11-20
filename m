Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FD1606A338
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R/oNI902;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=VgRMnkyz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEF8760E8B;
	Fri, 20 Nov 2026 16:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wD6C-z5UECU3; Fri, 20 Nov 2026 16:30:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 71B3260E90
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795192214;
	b=ZPNTpB1IfH0TITq1JA/1DZnCegzLYWlZd7pLQN16oQGbFeUhiz39rH7JHGuQoNvtPo3E
	 t61lAtZzLgVfQ+L2vf3IiCUmqLDXe+eKK6oEq5eFIImJnVHBbXE2sbHNVTaYKgeYsCkPg
	 NmkPhe4PfQdrFtR8lEJULUrDpSGmoLT8dAmgvbOWV2rNWxF734ucoSWJhNkza9S2uuUWD
	 mHwAZVc0rbW2uuETESBgOtlMKX6/IxLvr0WWbh/11UiqmPr5zfbA1R+wmRMKQOO3jOjjt
	 QcCnkMgzOPMgC2Eth5LWX6Hp6r9tWgrDa7Pm4ep8PgJftEAqTTVKEwMCkiQk5Y1OcdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CbWqFr58g1ZjanHQNVq1Mou7NWT7wd2DF/T5sgfDdHY=;
	b=RiufS+QS/wgvUChMmtDSjzDgu9TEpBjxuR5HolPWm5gPH14yGyF4GVTrlDfhDuJ+gO6o
	 IgL1iL88//xDuGlb5qIoirTvjNPGczRZ5onOXwOvNu3Y05mDpR0LITsLlteFITUVxAVZe
	 JiA2VdjMKQYFBTgolPCBXutzYSrJEk5wNjhS/RLXan7q6I0X6bzWCZlEKMTMrwt9vNNlp
	 0ENhKd/gSkqFhWQ0/wNO1M1D2Ao28d62qCA+mDAimPOhxf5lKusAxZnyGaLdvBijIpvRp
	 CuXjQ+PyP8aZOAcs630hXhflVB+AayaeaYHdF7ueyIa0hSW9p94hJ9V+Fq69d05/20w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=VgRMnkyz;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795192214;
	bh=CbWqFr58g1ZjanHQNVq1Mou7NWT7wd2DF/T5sgfDdHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R/oNI902d8be9tZv0k5jx4hWQSSyb1IL4uE1tvwiX2Kty3IMhIoKvb7Ph1dwSI3EP
	 0wS+kAbqoZO9Gyg7vWOk4pJ2qaCDSwCwXy8IBjq8Q9KmlBceq5Ivg229QlRKswAWB/
	 Px5HWhhzLtRKfeQ+7htToZdiE46VtPWkh/1QJF8wculjd6nD2a1DLtfSPptX0RjvOD
	 qYR80FvTzfuiXPN3ZpSGPKimYVoR9LN3LhHrcrLzbYVAEo+rE5PhC2Im6RJtoZPyjo
	 D6eHHxdC3YsIoldv96F0Svg1TFRggxcu0+Th6j8SqQRLbAXIeD/BBSGjPA3cYUKUuq
	 ezI4bATJdu8+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71B3260E90;
	Fri, 20 Nov 2026 16:30:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B54F1E7
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31B706071D
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4qEHc2Ac_aPV for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 16:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CEC3160740
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.161
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=lists@steffen.cc;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=VgRMnkyz
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CEC3160740
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 16:30:08 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jWLQz2nnBzKn2J;
 Fri, 20 Nov 2026 17:30:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795192203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbWqFr58g1ZjanHQNVq1Mou7NWT7wd2DF/T5sgfDdHY=;
 b=VgRMnkyzdAVaeuk3OudE6uOD8smpYuB2WM0DVNBA0TCT8/VmQBShBRpMI24OS9X3RoB10t
 mohSoJ5JggvggXJhHL8Gm2+YNj+kK83P/ohXrSWar1xMPygTM5f0d5XdPn74e8yY1MzwYx
 su9mOjNxtpWvYA/RxsBJXisKgpAYxAbhAu9rnlm0UPDwn7qy5u0Ex6C6/OrEQvOJmVYF1v
 YBuppQmiZJgHy07E2d315yVMXAuS85lYnMhcbOw62ZVcEtvGHEFKmsrxOwMA7ZV8Y5fpWA
 P8MuFGR32AiiU4fO6zlTjVhlW/DHkrBdGbwn27b9QoV3j8Z1Mkt1EklPgh+nIA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Fri, 20 Nov 2026 17:29:18 +0100
Subject: [PATCH v3 1/2] arm: mediatek: enable the caches in SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-std-upstream-mt8188-spl-caches-v3-1-b5ab70d56006@beckhoff.com>
References: <20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com>
In-Reply-To: <20261120-std-upstream-mt8188-spl-caches-v3-0-b5ab70d56006@beckhoff.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795192198; l=5237;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=ldoEQXlSkwxzx3X+9Y/o791MomJAvU+deKdQPwSHQt0=;
 b=WhsEkcp0Jy82vGgMl27k3A6lx3ovARIU/l2jwXtgdej32Vh2UJ5D5poEgVg7TBtNJ/FvK1yhL
 DZBGGKNeKpYA9jhXkChiAOImqQz0A3xP2CA46L1TTn/fusBScPZ8Z1W
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jWLQz2nnBzKn2J
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

Running through spl without the dcache is very slow, especially when
hashing or checking signatures.

Time from the SPL banner to entering BL31 on an MT8370 module loading a
2.7 MB FIT with SHA-256 hashes from SPI NOR, two boots each:

  FIT                    caches off            caches on
  unsigned               848.3 / 848.6 ms      95.7 / 118.8 ms
  RSA-3072 signature     1903.6 / 1903.0 ms    128.3 / 143.3 ms

EARLY_TLB_SIZE is 32K, the largest get_page_table_size() of all
MediaTek mem maps.

The page tables are at MTK_EARLY_TLB_ADDR. On MT8188 the default is the
last 32K of the first 2 MiB of DRAM. This is above the SPL image, BSS
and stack, which end at 0x4013b800, and below the download agent FIT at
0x41000000.

U-Boot on ARMv8 can't run with the I-cache on and the D-cache off: with
SPL_SYS_DCACHE_OFF the cache functions aren't built at all and with
SPL_SYS_ICACHE_OFF the I-cache functions are empty. So calling
cleanup_before_linux() only with SPL_MTK_EARLY_CACHES is fine.
rockchip spl.c does the same.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
 arch/arm/include/asm/arch-mediatek/misc.h |  2 ++
 arch/arm/mach-mediatek/Kconfig            | 17 +++++++++++++++++
 arch/arm/mach-mediatek/Makefile           |  1 +
 arch/arm/mach-mediatek/early_caches.c     | 21 +++++++++++++++++++++
 arch/arm/mach-mediatek/spl.c              | 14 ++++++++++++++
 5 files changed, 55 insertions(+)

diff --git a/arch/arm/include/asm/arch-mediatek/misc.h b/arch/arm/include/asm/arch-mediatek/misc.h
index 2530e78a5f11..dd248d222b97 100644
--- a/arch/arm/include/asm/arch-mediatek/misc.h
+++ b/arch/arm/include/asm/arch-mediatek/misc.h
@@ -14,4 +14,6 @@
 #define APHW_VER		0x08
 #define APSW_VER		0x0c
 
+void mtk_early_enable_caches(void);
+
 #endif /* __MEDIATEK_MISC_H_ */
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index cdbcb6b3bc18..9e36b2a2c82d 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -221,6 +221,23 @@ config MTK_BROM_HEADER_INFO
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
+config SPL_MTK_EARLY_CACHES
+	bool "Enable caches in SPL"
+	depends on SPL && ARM64 && !SPL_SYS_DCACHE_OFF
+	default y if TARGET_MT8188
+	help
+	  Enable the MMU and caches in SPL and disable them before
+	  jumping to the next stage.
+
+config MTK_EARLY_TLB_ADDR
+	hex "Address of the early page tables"
+	depends on SPL_MTK_EARLY_CACHES
+	default 0x401f8000 if TARGET_MT8188
+	help
+	  Address of the 32 KiB of page tables used while the early
+	  caches are on. Nothing else may use this memory during that
+	  time.
+
 config SPL_MTK_FIRMWARE_AB
 	bool "MediaTek firmware A/B boot in SPL"
 	depends on TARGET_MT8188 && SPL_MMC && SPL_LOAD_FIT && SPL_BLK
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 4b1524e5e2f1..55bf8790cc92 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o mtk_ab.o
 obj-$(CONFIG_$(PHASE_)MTK_BROM_DOWNLOAD_AGENT_FASTBOOT) += download_agent.o
+obj-$(CONFIG_$(PHASE_)MTK_EARLY_CACHES) += early_caches.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/early_caches.c b/arch/arm/mach-mediatek/early_caches.c
new file mode 100644
index 000000000000..003393d2f681
--- /dev/null
+++ b/arch/arm/mach-mediatek/early_caches.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMU and caches before U-Boot sets up its final page tables
+ */
+
+#include <cpu_func.h>
+#include <asm/global_data.h>
+#include <asm/arch/misc.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* get_page_table_size() for the largest MediaTek mem_map */
+#define EARLY_TLB_SIZE	SZ_32K
+
+void mtk_early_enable_caches(void)
+{
+	gd->arch.tlb_addr = CONFIG_MTK_EARLY_TLB_ADDR;
+	gd->arch.tlb_size = EARLY_TLB_SIZE;
+	dcache_enable();
+}
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 95e2157b507d..2fe1b4e6c524 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -5,9 +5,11 @@
  */
 
 #include <clk.h>
+#include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
 #include <spl.h>
+#include <asm/arch/misc.h>
 
 __weak int mtk_soc_early_init(void)
 {
@@ -18,6 +20,12 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
+	if (CONFIG_IS_ENABLED(MTK_EARLY_CACHES)) {
+		/* SPL skips arch_cpu_init(), which enables the I-cache */
+		icache_enable();
+		mtk_early_enable_caches();
+	}
+
 	ret = spl_early_init();
 	if (ret)
 		hang();
@@ -31,6 +39,12 @@ void board_init_f(ulong dummy)
 		hang();
 }
 
+void spl_board_prepare_for_boot(void)
+{
+	if (CONFIG_IS_ENABLED(MTK_EARLY_CACHES))
+		cleanup_before_linux();
+}
+
 u32 spl_boot_device(void)
 {
 	if (IS_ENABLED(CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT))

-- 
2.56.1

