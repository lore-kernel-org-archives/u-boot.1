Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84CCCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A59486DCA;
	Mon, 16 Oct 2023 18:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697473012;
	bh=YocRv59V1sqcC8mrdr44FB2FAdtm2MSDhX2vqBebGTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vLFMO8bjwAJkcycXT475518yTdmevcgvlSIO6Of1TpXuFfuY7k3CmF2C4WtVLdtZz
	 AgEzb7Cr87akK2yAGmS0He6pumiCKPUgKqQepq+9EskfM1RQefGYCVcJ/LaT/Ac+dE
	 o20oBhUVU6voGJIApO/yXp+S36NWd8kmKC/i9vPZ7fL6U/Mp1yw61z9yzXjWsM3ajX
	 Qip/TzeKBAFdlT62gex1ko3UZJH4vd9o9xzsid4/GKTzhYk6yKBJm2oiH1O0KaVPdo
	 LzBUm/kg9hnHpB9zINWaKTgP/4dutUCmqnSIYeae1hpSHMIpB5fg2fYIm8sPuWeO6C
	 fjkXsK4RT2kpQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3E08286EB9;
 Mon, 16 Oct 2023 18:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697473002;
 bh=YocRv59V1sqcC8mrdr44FB2FAdtm2MSDhX2vqBebGTY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BhPuiC3oGvtBMlkDTbALl6iWR/QkbXwJ4Lzchfl9V2ZQc8HokPuR/HcqXlrw48PB0
 4o1TUtryp7K1t5bvvnHzd9xe5NlcmlO74Mx7a/NmWOU1zTX/4h3MuMJ2ESPjh2J2Ml
 S9Qm7sW1ePy6yrISGwU80j4Jk97GN4BkNSiNVORlGQfNhtWI82eXLY/edTZPDo4qkf
 UBW54DBHLl56cixrZtOm4LRrLIH0EZr6aonKhi2uJpx/4xGUh/irbOY1LPmlmwu1x0
 wbbM1uw/1zshrp1iE3DpLR+zuKJtAHapYrfPJywSB9GZ9GOo6E6vFKlxJ/4YZ1uWtz
 yyW+Sbmkk+3FA==
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
Subject: [PATCH v2 4/4] ARM: imx: Add support for detecting primary/secondary
 bmode on MX8M
Date: Mon, 16 Oct 2023 18:16:15 +0200
Message-ID: <20231016161619.50744-4-marex@denx.de>
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

Implement the 'getprisec' subcommand of 'bmode' command for i.MX8M by
reading out the ROM log events. This event is set by the BootROM if it
switched to the secondary copy due to primary copy being corrupted.

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
V2: Mask out boot_mode_apply() on MX8M and newer,
    since this functionality is not available.
---
 arch/arm/mach-imx/Kconfig     | 2 +-
 arch/arm/mach-imx/cmd_bmode.c | 4 ++++
 arch/arm/mach-imx/imx8m/soc.c | 5 +++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 266bb20df9d..44e1e1628ba 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -71,7 +71,7 @@ config CSF_SIZE
 config CMD_BMODE
 	bool "Support the 'bmode' command"
 	default y
-	depends on ARCH_MX7 || ARCH_MX6 || ARCH_MX5
+	depends on ARCH_IMX8M || ARCH_MX7 || ARCH_MX6 || ARCH_MX5
 	help
 	  This enables the 'bmode' (bootmode) command for forcing
 	  a boot from specific media.
diff --git a/arch/arm/mach-imx/cmd_bmode.c b/arch/arm/mach-imx/cmd_bmode.c
index cb317499d54..5b2f4686230 100644
--- a/arch/arm/mach-imx/cmd_bmode.c
+++ b/arch/arm/mach-imx/cmd_bmode.c
@@ -83,7 +83,11 @@ static int do_boot_mode(struct cmd_tbl *cmdtp, int flag, int argc,
 		reset_requested = 0;
 	}
 
+/* No longer applicable to i.MX8M */
+#if IS_ENABLED(CONFIG_MX53) || IS_ENABLED(CONFIG_MX6) || IS_ENABLED(CONFIG_MX7)
 	boot_mode_apply(p->cfg_val);
+#endif
+
 	if (reset_requested && p->cfg_val)
 		do_reset(NULL, 0, 0, NULL);
 	return 0;
diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index d33ac06cab4..556611a04e7 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -727,6 +727,11 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 
 	return part;
 }
+
+int boot_mode_getprisec(void)
+{
+	return !!imx8m_detect_secondary_image_boot();
+}
 #endif
 
 #if defined(CONFIG_IMX8MN) || defined(CONFIG_IMX8MP)
-- 
2.42.0

