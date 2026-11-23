Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326BB606A32E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pjGpO5Mx;
	dkim=pass (2048-bit key, unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=I6VZJaWU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10A2F80E2E;
	Mon, 23 Nov 2026 11:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvKI__HE-UC0; Mon, 23 Nov 2026 11:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3391480E23
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795433197;
	b=WwJXozxx44NEOMMwXW+GWWN4pBgRCkB/YPhvYFdDCwxHVSh0fdFU63/sqjflyOW8vPB5
	 /bDo5fFUKBRXUYAYHgGBDOhXI3pP+a6+fGd7knFjBVcgS0WEseBOfwbIMaWPBBGQeu0GZ
	 wysdy/mGmGnJLMT6gWVCr/BlDQuJz8AnMV1Iay5Rwx/VJYUcVbKZnyApCQJFesM5jDSHm
	 Tkx5DKk3GN+TnrLHSvETaLI00twpe+CkUxqSw6RnKTN5zzKCbQpi6dPLnh6grs4Lz11wB
	 lJgKtCBD1gVErAgrC6+UdQLV9ju5kozlnJOD3+3u0PgYsna30b88PP1YyT4HIDex6Bw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795433197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rs7UfBpWIxLC7Jr+xtU8Zaq8AwT4hRqE1Ff5cwCZBEc=;
	b=W/ywPRRBrm5RYM35bHBfB5uzW8e8lHZWifL21lAhjnaZ2L/fhGdzoEq1HUdTTBPY3ZDi
	 7Z2vhcuZdGg/AB8IHp5FpS2cNIp31H0I2G/POcbuNSMQ4S+QWLQ0vPR56IczRayzSm0m3
	 TROgxILeIT4qCgoWJKqi+3glOzNfM6dzktHi7wfus18M+V+9QGeAgaaesyrlfSS6XFvVA
	 AT2WCuTKHJb9SPNqC9oQIQU8Sxr33cw+GNkEWyMtatGbWQWdB1MKnnlGU9ElxmJG+LAuJ
	 0pc3NSgPRXl/2J+0r7GN+CqR8ZqGYj5H9KiyaPyjAm0wHoFTksotANMhAPd62W2kaOA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=steffen.cc;
	dkim=pass header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256 header.s=MBO0001 header.b=I6VZJaWU;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795433197;
	bh=rs7UfBpWIxLC7Jr+xtU8Zaq8AwT4hRqE1Ff5cwCZBEc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pjGpO5MxmHphH6VJzfpK9BwjPoq75wQaCJFCRv/AJeBGTXEiaDARaFLh9L+f8zWGC
	 xBRTnl/fRSG61gzlw0dezp99e3tJchX6e+Td0eYbB+LdLiJDHxtlcGVq3+2XB7k4Wh
	 P2/27tUGqdCarAdQkbJFfXc7J5QfeAXbFXMHIu5CftZbiPwGQ0U27AVMc949Bo+5zq
	 qXtIiy34Q1ZoSKvDVCpFBn+E9ESNpWKaiOQ5GiKbaDZZOm7V9u4uKeqjkLZcleoA4y
	 Ig8th+LZfX35x6vY039XKi3tZUb4aLgHvhHz7JrGGs4EL0DNMz3ud6wutJ1YkrwSnu
	 89IJhlOOtK4Ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3391480E23;
	Mon, 23 Nov 2026 11:26:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CDA3C260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B353B80E24
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:26:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X5Li3ad8HyyI for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 11:26:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6B7DA80E23
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=lists@steffen.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=steffen.cc header.i=@steffen.cc header.a=rsa-sha256
 header.s=MBO0001 header.b=I6VZJaWU
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B7DA80E23
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:26:34 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jY3YL4qRNzKmZ1;
 Mon, 23 Nov 2026 12:26:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1795433190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rs7UfBpWIxLC7Jr+xtU8Zaq8AwT4hRqE1Ff5cwCZBEc=;
 b=I6VZJaWUjXd1r0p35Y8fNMGdj/Z4JYxDNLB4k9cCNRDt9F/KsC5ZjMmdxP2H6E0ald7Idc
 Yqg3aMxE+E7Cn8l2q2QGEy7ISeYJpGxtSMoJR+QRFld2/UxVq1e7bKwXXBhYVda8Quqdcq
 Uv3e4h20qsgdkwYSiYCDcSDd+wOwjzXsuW7Mcd1RqF4arMHmC7bwwcO4wguLCdWSbRX6pY
 91ovFDY8MAZaD1vhBAL22HQzWmfIAJ3R17po6cKBPu71ImXZvoS8tMQ5qeJ7l3A99oFhH3
 Ej54zkraICf0VUoOMoNd0WmG4q2m40vBjuvFSuLkaPHkoRsv3phJMyGd4gUI2g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of lists@steffen.cc designates
 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=lists@steffen.cc
From: Steffen Dirkwinkel <lists@steffen.cc>
Date: Mon, 23 Nov 2026 12:26:22 +0100
Subject: [PATCH v4 1/2] arm: mediatek: enable the caches in SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-std-upstream-mt8188-spl-caches-v4-1-521e424fd1ad@beckhoff.com>
References: <20261123-std-upstream-mt8188-spl-caches-v4-0-521e424fd1ad@beckhoff.com>
In-Reply-To: <20261123-std-upstream-mt8188-spl-caches-v4-0-521e424fd1ad@beckhoff.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795433188; l=5347;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=+ZjTRbOYuUlhv1rTXa8fnQF1HrhS0YskGgRmTtQs12I=;
 b=tFTVsIa/UOSKBEIpMpc2L3dQeFD7MWgZ7rZuHCi5mLP642XwOxQaszR/bA9rNSN1j5ldkdOf+
 XGyMlIli3kXBbHh5NYehAegiMqBAMo+qr650IQ7iImkTb9zyTDTKa3Z
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=
X-Rspamd-Queue-Id: 4jY3YL4qRNzKmZ1
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

MTK_EARLY_TLB_SIZE is 32K, the largest get_page_table_size() of all
MediaTek mem maps.

The page tables are at MTK_EARLY_TLB_ADDR. On MT8188 the default is the
last 32K of the first 2 MiB of DRAM. This is above the SPL image, BSS
and stack, which end at 0x4013b800, and below the download agent FIT at
0x41000000.

U-Boot on ARMv8 can't run with the I-cache on and the D-cache off: with
SPL_SYS_DCACHE_OFF the cache functions aren't built at all and with
SPL_SYS_ICACHE_OFF the I-cache functions are empty. So calling
cleanup_before_linux() only with SPL_MTK_EARLY_DCACHE is fine.
rockchip spl.c does the same.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Tested-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm/include/asm/arch-mediatek/misc.h |  2 ++
 arch/arm/mach-mediatek/Kconfig            | 17 +++++++++++++++++
 arch/arm/mach-mediatek/Makefile           |  1 +
 arch/arm/mach-mediatek/early_caches.c     | 21 +++++++++++++++++++++
 arch/arm/mach-mediatek/spl.c              | 14 ++++++++++++++
 5 files changed, 55 insertions(+)

diff --git a/arch/arm/include/asm/arch-mediatek/misc.h b/arch/arm/include/asm/arch-mediatek/misc.h
index 2530e78a5f11..d21e09358f59 100644
--- a/arch/arm/include/asm/arch-mediatek/misc.h
+++ b/arch/arm/include/asm/arch-mediatek/misc.h
@@ -14,4 +14,6 @@
 #define APHW_VER		0x08
 #define APSW_VER		0x0c
 
+void mtk_early_enable_dcache(void);
+
 #endif /* __MEDIATEK_MISC_H_ */
diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index cdbcb6b3bc18..471622d22318 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -221,6 +221,23 @@ config MTK_BROM_HEADER_INFO
 	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
 	default "lk=1" if TARGET_MT7623
 
+config SPL_MTK_EARLY_DCACHE
+	bool "Enable caches in SPL"
+	depends on SPL && ARM64 && !SPL_SYS_DCACHE_OFF
+	default y if TARGET_MT8188
+	help
+	  Enable the MMU and caches in SPL and disable them before
+	  jumping to the next stage.
+
+config MTK_EARLY_TLB_ADDR
+	hex "Address of the early page tables"
+	depends on SPL_MTK_EARLY_DCACHE
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
index 4b1524e5e2f1..e797cc25de1c 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o mtk_ab.o
 obj-$(CONFIG_$(PHASE_)MTK_BROM_DOWNLOAD_AGENT_FASTBOOT) += download_agent.o
+obj-$(CONFIG_$(PHASE_)MTK_EARLY_DCACHE) += early_caches.o
 
 obj-$(CONFIG_TARGET_MT7622) += mt7622/
 obj-$(CONFIG_TARGET_MT7623) += mt7623/
diff --git a/arch/arm/mach-mediatek/early_caches.c b/arch/arm/mach-mediatek/early_caches.c
new file mode 100644
index 000000000000..62705529c162
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
+#define MTK_EARLY_TLB_SIZE	SZ_32K
+
+void mtk_early_enable_dcache(void)
+{
+	gd->arch.tlb_addr = CONFIG_MTK_EARLY_TLB_ADDR;
+	gd->arch.tlb_size = MTK_EARLY_TLB_SIZE;
+	dcache_enable();
+}
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 95e2157b507d..68f5cfeeb49e 100644
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
 
+	if (CONFIG_IS_ENABLED(MTK_EARLY_DCACHE)) {
+		/* SPL skips arch_cpu_init(), which enables the I-cache */
+		icache_enable();
+		mtk_early_enable_dcache();
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
+	if (CONFIG_IS_ENABLED(MTK_EARLY_DCACHE))
+		cleanup_before_linux();
+}
+
 u32 spl_boot_device(void)
 {
 	if (IS_ENABLED(CONFIG_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT))

-- 
2.56.1

