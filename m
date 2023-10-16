Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD60CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE8986EE3;
	Mon, 16 Oct 2023 18:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697473008;
	bh=qOlvXj3bjVrQ0FWDdclMPWmcsJH/L+z+aZAyHOC+H98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NvG37Qb0b6cCfWYgOiawhbYl/xFEfK2wXCCrpCljVc6V1g0fmyMrbwmoYGXaPKTho
	 aRNofni6kcczrS/c0+r9cVpbyz88OtoD9qU97TxlIPP05V6AG9iOHO2JdOoLI3+E/V
	 bBISwd81kPSQfrUUqtrBVhONhkMv/LNN5Y3Y0vRE7IaA+s0OX15ndpph7FMlfXqwLH
	 rvpfBCgcOkHhYESSXuFwi4DM9OIwkqEUYqxcvKlJYCR0rfVrYpQ2amBO+4X/Iyrgjv
	 uQj8Ozimwfen6KMPFEwTjujZo1lAQz9zYc77PblCjrU1Q+KdO0wY9Y6Rjdv9grLuix
	 b6tZ908llctZA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E635286DCA;
 Mon, 16 Oct 2023 18:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697473001;
 bh=qOlvXj3bjVrQ0FWDdclMPWmcsJH/L+z+aZAyHOC+H98=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uS9NkZU7WokdLb1gv+kl67c05iFYuPuL118bMVR9qW7lj0TiWN5cJ6iY+B3J4orzO
 8SxfFxePNzb0wyUcvHFAl3IZcoMee7lb8GUkoeyXFdKu10mhfNsUt7PAhTvdDplhWY
 k5MHpfy+SIJOJXDGnmIgicjRw3jOOfmWV1Dq9V+9KvLfTjqu0jkezrfcUlkd6NviOB
 C6TQ7P/F9zGaeC3bcxARV5buUdc8c8o5ppUTCVcdo9exrQeVMfmRsIO2Oj8f/zYvIi
 MMob8b6Jy5k+TGUjJR+h0Y4EaP+pQDvMN5a/RIdCGTEGuEJujP9jmecv9QPPnyGG+U
 0xeFE78kVpI3g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Chanho Park <chanho61.park@samsung.com>, Elena Popa <elena.popa@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Qu Wenruo <wqu@suse.com>, Roger Quadros <rogerq@kernel.org>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 3/4] ARM: imx: Use correct U-Boot offset in case of
 secondary boot from eMMC
Date: Mon, 16 Oct 2023 18:16:14 +0200
Message-ID: <20231016161619.50744-3-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016161619.50744-1-marex@denx.de>
References: <20231016161619.50744-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Fedor Ross <fedor.ross@ifm.com>

In case of a secondary image boot from the user area of an eMMC device,
the correct offset must be calculated. The offset is fused in the fuse
IMG_CNTN_SET1_OFFSET of the i.MX8M Nano and Plus. The calculation of the
offset is described in the reference manual (IMX8MNRM Rev. 2, 07/2022
and IMX8MPRM Rev. 1, 06/2021):

The fuse IMG_CNTN_SET1_OFFSET (0x490[22:19]) is defined as follows:
* Secondary boot is disabled if fuse value is bigger than 10,
  n = fuse value bigger than 10.
* n == 0: Offset = 4MB
* n == 2: Offset = 1MB
* Others & n <= 10 : Offset = 1MB*2^n

Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Elena Popa <elena.popa@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Fedor Ross <fedor.ross@ifm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
---
V2: Use arch_spl_mmc_get_uboot_raw_sector()
---
 arch/arm/mach-imx/imx8m/soc.c | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 930ee5f59f9..d33ac06cab4 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -28,8 +28,10 @@
 #include <errno.h>
 #include <fdt_support.h>
 #include <fsl_wdog.h>
+#include <fuse.h>
 #include <imx_sip.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -727,6 +729,43 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 }
 #endif
 
+#if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
+#define IMG_CNTN_SET1_OFFSET	GENMASK(22, 19)
+unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
+						unsigned long raw_sect)
+{
+	u32 val, offset;
+
+	if (fuse_read(2, 1, &val)) {
+		debug("Error reading fuse!\n");
+		return raw_sect;
+	}
+
+	val = FIELD_GET(IMG_CNTN_SET1_OFFSET, val);
+	if (val > 10) {
+		debug("Secondary image boot disabled!\n");
+		return raw_sect;
+	}
+
+	if (val == 0)
+		offset = SZ_4M;
+	else if (val == 1)
+		offset = SZ_2M;
+	else if (val == 2)
+		offset = SZ_1M;
+	else	/* flash.bin offset = 1 MiB * 2^n */
+		offset = SZ_1M << val;
+
+	offset /= 512;
+	offset -= CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET;
+
+	if (imx8m_detect_secondary_image_boot())
+		raw_sect += offset;
+
+	return raw_sect;
+}
+#endif
+
 bool is_usb_boot(void)
 {
 	return get_boot_device() == USB_BOOT;
-- 
2.42.0

