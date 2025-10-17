Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C108CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04372838C7;
	Fri, 17 Oct 2025 17:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XAKIsIOp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E696283857; Fri, 17 Oct 2025 17:24:46 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190FD83826
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id DBFCE2625B;
 Fri, 17 Oct 2025 17:24:44 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R6rAeauzEDT2; Fri, 17 Oct 2025 17:24:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714684; bh=QCFvi70upqEZPLp/07bhXwyF68xa/rfLXzphOE9u9SY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XAKIsIOpBWdce37cglvwP+CeE4yoEubfDb9CqG989rGqjw1VGutA0xpKbPo/QRI+g
 vjhsNrchB5qvs1cfGkeGz0OvVRi9BybOMfAv6gvVgSknORuIiuptHytarqy83dKVrF
 A4WJFdnOg8pMPB/kzVwUCilnEaB2nC+zMBM6+8dTrzFh4yp1ppjzMIPTymJZgcRzRR
 zGIzmmua9PZa2jDkYuiRUcS4JU98vkFU1Y3huLC1iL5GeGLZ65Bxw+wtIHrKElJZyH
 X9OUVlPH6YhcaauCGw9BmVnWjqwrTKgyEF/vMNK/DTE8rk6o3w8SEbmG6PYBXYqynX
 aA0vecHnwt6hA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:54:06 +0530
Subject: [PATCH 1/9] mmc: dw_mmc: export dwmci_send_cmd() and dwmci_set_ios()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mmc-dw-exynos7870-v1-1-a2c5139d9afe@disroot.org>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=1830;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=QCFvi70upqEZPLp/07bhXwyF68xa/rfLXzphOE9u9SY=;
 b=OQsoGuVfzzomIPhFYWPaFvYcCToyOY9a9A8q7roHCjDctTKLFMTrLu4ZfDYHSWvBHIKUcfDjz
 ggcno56r9/ICBegw3csTp0oRh2oVJeluRBe2t2pmPwLNFvpN7ngcs5c
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

These commands are required by struct dm_mmc_ops. Any platform specific
driver may use some or all of the functions in their own ops. Make them
accessible by moving the prototype to the dwmmc.h header.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/dw_mmc.c | 6 +++---
 include/dwmmc.h      | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
index a51494380ce0119f6d7128c3bc74a2edb87ce11e..c6a18a5427ac64cc74a0a95f9780156b52beeee5 100644
--- a/drivers/mmc/dw_mmc.c
+++ b/drivers/mmc/dw_mmc.c
@@ -482,8 +482,8 @@ static int dwmci_send_cmd_common(struct dwmci_host *host, struct mmc_cmd *cmd,
 }
 
 #ifdef CONFIG_DM_MMC
-static int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
-			  struct mmc_data *data)
+int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
+		   struct mmc_data *data)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
 #else
@@ -585,7 +585,7 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
 }
 
 #ifdef CONFIG_DM_MMC
-static int dwmci_set_ios(struct udevice *dev)
+int dwmci_set_ios(struct udevice *dev)
 {
 	struct mmc *mmc = mmc_get_mmc_dev(dev);
 #else
diff --git a/include/dwmmc.h b/include/dwmmc.h
index 87ca127cd6cd53a9a68f77f0981356e77d88ab07..639a2d28e7860f2ceb09955ee11550e406fd1bd2 100644
--- a/include/dwmmc.h
+++ b/include/dwmmc.h
@@ -334,6 +334,9 @@ int add_dwmci(struct dwmci_host *host, u32 max_clk, u32 min_clk);
 #ifdef CONFIG_DM_MMC
 /* Export the operations to drivers */
 int dwmci_probe(struct udevice *dev);
+int dwmci_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
+		   struct mmc_data *data);
+int dwmci_set_ios(struct udevice *dev);
 extern const struct dm_mmc_ops dm_dwmci_ops;
 #endif
 

-- 
2.51.0

