Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D79FCD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:42:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F8584D68;
	Fri,  8 May 2026 17:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7833D84D5B; Fri,  8 May 2026 17:42:51 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A43D84D68
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 3532B68C4E; Fri,  8 May 2026 17:42:48 +0200 (CEST)
To: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
    Tom Rini <trini@konsulko.com>, Andrea della Porta <andrea.porta@suse.com>,
    Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
    "Jan Čermák" <sairon@sairon.cz>, u-boot@lists.denx.de
Subject: [PATCH 3/3] configs: enable NVMe
In-Reply-To: <20260508154108.336B968BEB@verein.lst.de>
References: <20260508154108.336B968BEB@verein.lst.de>
Message-Id: <20260508154248.3532B68C4E@verein.lst.de>
Date: Fri,  8 May 2026 17:42:48 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
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

From: Torsten Duwe <duwe@suse.de>

Enable NVMe in the Raspberry Pi 64-Bit default config

Signed-off-by: Torsten Duwe <duwe@suse.de>
---

Thanks to this series, U-Boot now supports the 64GiB address offset
used on the Raspberry Pi 5 for those inbound accesses.

Remember that the other prerequisite on Rpi5 is the PCIe support
for bcm2712.

---
 configs/rpi_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 38af5029403..18f8213f3b3 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -41,6 +41,7 @@ CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_BCM2835=y
 CONFIG_MMC_SDHCI_BCMSTB=y
 CONFIG_BCMGENET=y
+CONFIG_NVME_PCI=y
 CONFIG_PCI_BRCMSTB=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
-- 
2.54.0

