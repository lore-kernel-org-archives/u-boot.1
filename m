Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F991C46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 17:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E05D87F2B;
	Sat, 27 Jan 2024 18:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="q4jl9pAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5046087F2D; Sat, 27 Jan 2024 18:13:13 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 738D187F14
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 18:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4854=JG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1706375564;
 bh=aWI3ELDnFqiN3oDD7Sp+B5YmKM140JyMjmGzf/Q0MXI=;
 b=q4jl9pAvKrbNfilNE7+jjczS52o/mC7MvNdQafQN2hLPVJebRKR25GuJ0OZ61Zh8YmIQdAQQc
 yT5JBigbKVgTRzGYc5dU8il4Bh5HXM+k/b7ahuMGBm6NKc1htafcU+bggOKaAtc4J58NOoMZeCd
 Xwum4VQyg//23buRg/BdnzfSZFAwNYHik9klZ0lv/6p+ieRpSCS9uHdDBy4XHh7epVCvx5l24ML
 zJeL4fWePjbDOI7So1Bq+ySEYh5+xGSagD2vddGBSWOqAB6mI4NVn4ELHiwtmcWGbwvvBfiqBEZ
 4JeIu9zJ2HF/kjRRGo5rRTfirjYGJwVlB82WzBIn45lQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Ferass El Hafidi
 <vitali64pmemail@protonmail.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: [PATCH v2] mmc: Add SPL_MMC_PWRSEQ to fix link issue when building SPL
Date: Sat, 27 Jan 2024 17:12:35 +0000
Message-ID: <20240127171237.320834-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65b5398b6797215511302810
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

With MMC_PWRSEQ enabled the following link issue may happen when
building SPL and SPL_PWRSEQ is not enabled.

  aarch64-linux-gnu-ld.bfd: drivers/mmc/meson_gx_mmc.o: in function `meson_mmc_probe':
  drivers/mmc/meson_gx_mmc.c:295: undefined reference to `pwrseq_set_power'

Fix this by adding a SPL_MMC_PWRSEQ Kconfig option used to enable mmc
pwrseq support in SPL.

Also add depends on DM_GPIO to fix following link issue:

  aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.o: in function `mmc_pwrseq_set_power':
  drivers/mmc/mmc-pwrseq.c:26: undefined reference to `gpio_request_by_name'
  aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:29: undefined reference to `dm_gpio_set_value'
  aarch64-linux-gnu-ld.bfd: drivers/mmc/mmc-pwrseq.c:31: undefined reference to `dm_gpio_set_value'

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>
---
Changes in v2:
- Fix Ths typo
- Collect r-b and a-b tags

Link to v1: https://patchwork.ozlabs.org/patch/1839392/
---
 drivers/mmc/Kconfig           | 12 ++++++++++--
 drivers/mmc/Makefile          |  2 +-
 drivers/mmc/meson_gx_mmc.c    |  2 +-
 drivers/mmc/rockchip_dw_mmc.c |  2 +-
 include/mmc.h                 |  4 ++--
 5 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 17618c3bdcc1..a141007a576f 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -20,11 +20,19 @@ config MMC_WRITE
 
 config MMC_PWRSEQ
 	bool "HW reset support for eMMC"
-	depends on PWRSEQ
+	depends on PWRSEQ && DM_GPIO
 	help
-	  Ths select Hardware reset support aka pwrseq-emmc for eMMC
+	  This select Hardware reset support aka pwrseq-emmc for eMMC
 	  devices.
 
+config SPL_MMC_PWRSEQ
+	bool "HW reset support for eMMC in SPL"
+	depends on SPL_PWRSEQ && SPL_DM_GPIO
+	default y if MMC_PWRSEQ
+	help
+	  This select Hardware reset support aka pwrseq-emmc for eMMC
+	  devices in SPL.
+
 config MMC_BROKEN_CD
 	bool "Poll for broken card detection case"
 	help
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index e9cf1fcc6400..2b94cc2f1c34 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += mmc_bootdev.o
 endif
 
 obj-$(CONFIG_$(SPL_TPL_)MMC_WRITE) += mmc_write.o
-obj-$(CONFIG_MMC_PWRSEQ) += mmc-pwrseq.o
+obj-$(CONFIG_$(SPL_)MMC_PWRSEQ) += mmc-pwrseq.o
 obj-$(CONFIG_MMC_SDHCI_ADMA_HELPERS) += sdhci-adma.o
 
 ifndef CONFIG_$(SPL_)BLK
diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
index fcf4f03d1e24..0825c0a2a838 100644
--- a/drivers/mmc/meson_gx_mmc.c
+++ b/drivers/mmc/meson_gx_mmc.c
@@ -288,7 +288,7 @@ static int meson_mmc_probe(struct udevice *dev)
 
 	mmc_set_clock(mmc, cfg->f_min, MMC_CLK_ENABLE);
 
-#ifdef CONFIG_MMC_PWRSEQ
+#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 	/* Enable power if needed */
 	ret = mmc_pwrseq_get_power(dev, cfg);
 	if (!ret) {
diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index 72c820ee6330..ad4529d6afa8 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -145,7 +145,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
 
 	host->fifo_mode = priv->fifo_mode;
 
-#ifdef CONFIG_MMC_PWRSEQ
+#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 	/* Enable power if needed */
 	ret = mmc_pwrseq_get_power(dev, &plat->cfg);
 	if (!ret) {
diff --git a/include/mmc.h b/include/mmc.h
index 1022db3ffa7c..9aef31ea5deb 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -590,7 +590,7 @@ struct mmc_config {
 	uint f_max;
 	uint b_max;
 	unsigned char part_type;
-#ifdef CONFIG_MMC_PWRSEQ
+#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 	struct udevice *pwr_dev;
 #endif
 };
@@ -808,7 +808,7 @@ int mmc_deinit(struct mmc *mmc);
  */
 int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg);
 
-#ifdef CONFIG_MMC_PWRSEQ
+#if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 /**
  * mmc_pwrseq_get_power() - get a power device from device tree
  *
-- 
2.43.0

