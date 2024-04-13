Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8388C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 13:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D254387B77;
	Sat, 13 Apr 2024 15:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CB008800D; Sat, 13 Apr 2024 15:44:05 +0200 (CEST)
Received: from 189.cn (ptr.189.cn [183.61.185.101])
 by phobos.denx.de (Postfix) with ESMTP id 3963687FA3
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 15:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dazen@189.cn
HMM_SOURCE_IP: 10.64.8.43:57670.345399815
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-14.145.245.88 (unknown [10.64.8.43])
 by 189.cn (HERMES) with SMTP id 86364100236;
 Sat, 13 Apr 2024 21:43:58 +0800 (CST)
Received: from  ([14.145.245.88])
 by gateway-153622-dep-65f4d5f786-dtfkj with ESMTP id
 c8947411125841bf8a0dfa1ae1e68334 for u-boot@lists.denx.de; 
 Sat, 13 Apr 2024 21:43:59 CST
X-Transaction-ID: c8947411125841bf8a0dfa1ae1e68334
X-Real-From: dazen@189.cn
X-Receive-IP: 14.145.245.88
X-MEDUSA-Status: 0
From: dazen@189.cn
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, andre.przywara@arm.com, trini@konsulko.com,
 dazen@189.cn
Subject: [PATCH] DRAM_SUN50I_H616_TRIM_SIZE
Date: Sat, 13 Apr 2024 21:43:52 +0800
Message-ID: <20240413134352.46495-1-dazen@189.cn>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 13 Apr 2024 15:57:03 +0200
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

From: lalakii <dazen@189.cn>

Add "DRAM_SUN50I_H616_TRIM_SIZE" option for 1.5gb board.

Signed-off-by: lalakii <dazen@189.cn>
---
 arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h |  1 +
 arch/arm/mach-sunxi/Kconfig                        |  7 +++++++
 arch/arm/mach-sunxi/dram_sun50i_h616.c             | 11 ++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
index a8fdda124a..2d2526fead 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h616.h
@@ -166,6 +166,7 @@ struct dram_config {
 	u8 rows;
 	u8 ranks;
 	u8 bus_full_width;
+	bool trim_size;
 };
 
 static inline int ns_to_t(int nanoseconds)
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index fe89aec6b9..255a498557 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -108,6 +108,13 @@ config DRAM_SUN50I_H616_TPR12
 	default 0x0
 	help
 	  TPR12 value from vendor DRAM settings.
+
+config DRAM_SUN50I_H616_TRIM_SIZE
+        bool "H616 DRAM trim size"
+        help
+          Due to unknown issue, some H616 based boards may need to trim
+          size a bit.
+
 endif
 
 config SUN6I_PRCM
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
index 37c139e0ee..4598d60a57 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
@@ -1349,8 +1349,15 @@ static unsigned long mctl_calc_size(const struct dram_config *config)
 {
 	u8 width = config->bus_full_width ? 4 : 2;
 
+	unsigned long size;
+
+	size = (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
+
+	if (config->trim_size)
+		size = (size * 3) / (width == 4 ? 4 : 8);
+
 	/* 8 banks */
-	return (1ULL << (config->cols + config->rows + 3)) * width * config->ranks;
+	return size;
 }
 
 static const struct dram_para para = {
@@ -1379,6 +1386,8 @@ unsigned long sunxi_dram_init(void)
 	struct sunxi_prcm_reg *const prcm =
 		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
 	struct dram_config config;
+	if (IS_ENABLED(CONFIG_DRAM_SUN50I_H616_TRIM_SIZE))
+		config.trim_size = true;
 	unsigned long size;
 
 	setbits_le32(&prcm->res_cal_ctrl, BIT(8));
-- 
2.44.0

