Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A7FF8861
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 07:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1480E84150;
	Mon, 27 Apr 2026 09:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="hurwMGA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF2A83693; Mon, 27 Apr 2026 07:53:09 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1876080077
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 07:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id D6AE42761A;
 Mon, 27 Apr 2026 07:53:06 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WVSAa9jW7slO; Mon, 27 Apr 2026 07:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1777269186; bh=LiGNG0vr+GoDjbIMmwjPVAbENdFYtTKn/SGzlsJwvW4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hurwMGA0GViHFMGeUztUCBCX8hk1h/MqrbxfFgDyuyFm8eFLxUb0TQAKPdL/JiStE
 JNQ2xkwFIDZu2akZkC+txm+XGdBa+XEYzey4SiM1KcoM2FVOvQl2oUngPfH816lisu
 gRlURBBxZO5ikoPPtrBPnvkv4v/wvkeeaEc3usfY8Prx2LdngIsW1dp7tgmohkm14y
 3su9TlEmbtH5NJdDNhdIdnOJtFpBnI46vQOL9Il8fUNRgORxT4ypdJMQwN6wzYnaeP
 EZZi4AVLDb417MaEwxTkI0S4se0RbewAo4uAhZrQsZHzPYPE1MqDmYLcdb0UZEXpoo
 6ERvwgdWEjFxw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 27 Apr 2026 11:22:50 +0530
Subject: [PATCH 2/4] mmc: dw_mmc: setup set_enhanced_strobe ops in driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-dwmmc-exynos-hs400-es-v1-2-3495df40a9ac@disroot.org>
References: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
In-Reply-To: <20260427-dwmmc-exynos-hs400-es-v1-0-3495df40a9ac@disroot.org>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukas Timmermann <uboot@timmermann.space>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Mon, 27 Apr 2026 09:28:50 +0200
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

At the end of HS400ES initialization by the core mmc driver,
mmc_set_enhanced_strobe() is called. This expects the host driver to
have an ops function for it.

The DW-MMC driver does not have it, thus the call fails with -ENOSUPP.
Add the ops function to allow control to be passed to the host side.

Since DW-MMC driver implementation depends on the platform, the above
ops function is made to pass its control to the implementation-specific
function available in the platform-specific driver.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/dw_mmc.c | 19 +++++++++++++++++++
 include/dwmmc.h      | 10 ++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index d9c05b223d5..0a245d72881 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -730,6 +730,19 @@ static int dwmci_init(struct mmc *mmc)
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
+static int dwmci_set_enhanced_strobe(struct udevice *dev)
+{
+	struct mmc *mmc = mmc_get_mmc_dev(dev);
+	struct dwmci_host *host = mmc->priv;
+
+	if (host && host->set_enhanced_strobe)
+		return host->set_enhanced_strobe(host);
+
+	return 0;
+}
+#endif
+
 #if CONFIG_IS_ENABLED(DM_MMC)
 int dwmci_probe(struct udevice *dev)
 {
@@ -741,6 +754,9 @@ int dwmci_probe(struct udevice *dev)
 const struct dm_mmc_ops dm_dwmci_ops = {
 	.send_cmd	= dwmci_send_cmd,
 	.set_ios	= dwmci_set_ios,
+#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
+	.set_enhanced_strobe = dwmci_set_enhanced_strobe,
+#endif
 };
 
 #else
@@ -748,6 +764,9 @@ static const struct mmc_ops dwmci_ops = {
 	.send_cmd	= dwmci_send_cmd,
 	.set_ios	= dwmci_set_ios,
 	.init		= dwmci_init,
+#if CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
+	.set_enhanced_strobe = dwmci_set_enhanced_strobe,
+#endif
 };
 #endif
 
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 7e1a6646518..49488709a82 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -225,6 +225,16 @@ struct dwmci_host {
 	 * return that value too. Then DWMMC will put itself in bypass mode.
 	 */
 	unsigned int (*get_mmc_clk)(struct dwmci_host *host, uint freq);
+	/**
+	 * @set_enhanced_strobe: (Optional) Platform function to run on enabling
+	 * HS400ES strobe
+	 *
+	 * @host:	DWMMC host
+	 *
+	 * This is used to enable the enhanced strobe for the HS400ES MMC mode.
+	 * The caller invokes this at the end of the HS400ES frequency dance.
+	 */
+	unsigned int (*set_enhanced_strobe)(struct dwmci_host *host);
 
 #ifndef CONFIG_BLK
 	struct mmc_config cfg;

-- 
2.53.0

