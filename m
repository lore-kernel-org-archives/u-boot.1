Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777C4CD8CA8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A91848A6;
	Sat, 13 Jun 2026 15:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="hYo+5ajw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F9E8056B; Sat, 13 Jun 2026 09:44:24 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F18238005D
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 09:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B8366271D1;
 Sat, 13 Jun 2026 09:44:22 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FsfYxF5jN0yo; Sat, 13 Jun 2026 09:44:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1781336662; bh=LiGNG0vr+GoDjbIMmwjPVAbENdFYtTKn/SGzlsJwvW4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hYo+5ajwgf3gv+7vP8CwVICikipjswtI8O3eAUbK4l2SVJaati+HChBEGwez0rtzt
 HAKFPFoZ5amyz5Us/iNUOoMH+4O7E+lQt3PtMq1rjGlQy7nhHE8nu+W8/aqVzRsTzo
 1yBI0unBdSBNs4xa9gQkovzoJx6rL1rX6ZD9dteVHVrgzy9PGBDM+dbCiZ4DbwaAmv
 MlvmXFyVrKv7MYd2xN9z+dAcuPtHSfs1wEdp7i8hQJW3YKW4/Vpds0xW/RKxhZHMSp
 7Ue1kPU/TLn5i2AtxCqHpG1YDe3bQzMRT8kbsoiOd6Bv3LKRXUVuRPUfluLGNXKNw+
 eZRoaAVgC1Plw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 13 Jun 2026 13:13:59 +0530
Subject: [PATCH v3 2/4] mmc: dw_mmc: setup set_enhanced_strobe ops in
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-dwmmc-exynos-hs400-es-v3-2-d23afa0ad417@disroot.org>
References: <20260613-dwmmc-exynos-hs400-es-v3-0-d23afa0ad417@disroot.org>
In-Reply-To: <20260613-dwmmc-exynos-hs400-es-v3-0-d23afa0ad417@disroot.org>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukas Timmermann <uboot@timmermann.space>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Mailman-Approved-At: Sat, 13 Jun 2026 15:22:52 +0200
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

