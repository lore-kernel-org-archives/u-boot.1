Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97369C4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 18:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0962D8793C;
	Sat, 13 Jan 2024 18:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705168799;
	bh=u6LayEthrZXYIPzMEYyPP6Z36QGi3m/52fjPd9vaiUw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=A9ljclFBW1mUDAk8BIH6zLBm/asaQK54hhE6hUQ/HwEhfrQqD9+eUU0uNOX52DPN2
	 chHTtsisADurnw+tVCHqy3cAVyAVZwqr0pYGSPkplC+h4G/2pSQaSyUI9yJ42ZGg6Q
	 c4uEEW0++ZsEMG6+uHxMfWLbhk+DWWwo2BYz8I7wi4OIFBOH2y+mYz9mFlBUbE2z1r
	 f+nFKqrsQ0AxhXoLNWq0zWVFD0/CLCYgsx8YCxfRSodvNdzXWIdg/xfgKjNiE+hpxK
	 a3Hy/B0cp/SVAyzewrUhUEleEAsrSbYJbXPso3lIVxgB/ZWVfm4kokUjQnM2OR3c2o
	 LYFLLQXW20rdg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 261E287134;
 Sat, 13 Jan 2024 18:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705168797;
 bh=u6LayEthrZXYIPzMEYyPP6Z36QGi3m/52fjPd9vaiUw=;
 h=From:To:Cc:Subject:Date:From;
 b=oreXoWqn+NLVRT8jUBd54Gsy8M4Pv8x3+FgjZmf8xl9XZ7PL4mOP18OnTUY0Sij6e
 75fB3BIY0NIyISz1S23WnxYiDb+g49g33TL0rxQn+S9NI3/pVnGRv4ISZXav2tQFhx
 UoCk+sXZRGhqZmrHC9CCnOmE5Ex3GnHkGI1nqagEkTCJdgqiPGGBvPjBGr2sz6fEjt
 L3Vo1owqPJIt//wdejN15L7Mr7NVSSPPDPMsZ6FPVEtNnen85wJ1JB3mOgg4vqZVJ0
 7TZPPh7iw8i5N/9PMyDfrYLJjFy+Uat+FOQjKNWwe6xgFLGPJqEGvFN7tiNz/4UKkN
 +0J2EdAcrImug==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH] ARM: imx: Set stdio to serial on Data Modul i.MX8M Mini/Plus
 eDM SBC
Date: Sat, 13 Jan 2024 18:59:13 +0100
Message-ID: <20240113175941.157275-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are enabled, the console
stdin, stdout, stderr must be defined in environment. Define the default
settings to fix the following warning on boot:

"
In:    No input devices available!
Out:   No output devices available!
Err:   No error devices available!
"

Sort the default environment as well.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 include/configs/imx8mm_data_modul_edm_sbc.h | 11 +++++++----
 include/configs/imx8mp_data_modul_edm_sbc.h |  9 ++++++---
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/configs/imx8mm_data_modul_edm_sbc.h b/include/configs/imx8mm_data_modul_edm_sbc.h
index f7d2b660c1f..b777fe6073b 100644
--- a/include/configs/imx8mm_data_modul_edm_sbc.h
+++ b/include/configs/imx8mm_data_modul_edm_sbc.h
@@ -34,13 +34,11 @@
 #define CFG_SYS_FSL_USDHC_NUM	2
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-#define CFG_EXTRA_ENV_SETTINGS					\
+#define CFG_EXTRA_ENV_SETTINGS						\
 	"altbootcmd=setenv devpart 2 && run bootcmd ; reset\0"		\
 	"bootlimit=3\0"							\
 	"devtype=mmc\0"							\
 	"devpart=1\0"							\
-	/* Give slow devices beyond USB HUB chance to come up. */	\
-	"usb_pgood_delay=2000\0"					\
 	"dfu_alt_info="							\
 		/* RAM block at DRAM offset 256..768 MiB */		\
 		"ram ram0=ram ram 0x50000000 0x20000000&"		\
@@ -76,6 +74,11 @@
 			"setenv stderr ${stderr},nc && "		\
 			"setenv stdout ${stdout},nc && "		\
 			"setenv stdin ${stdin},nc ; "			\
-		"fi"
+		"fi\0"							\
+	"stdin=serial\0"						\
+	"stdout=serial\0"						\
+	"stderr=serial\0"						\
+	/* Give slow devices beyond USB HUB chance to come up. */	\
+	"usb_pgood_delay=2000\0"
 
 #endif
diff --git a/include/configs/imx8mp_data_modul_edm_sbc.h b/include/configs/imx8mp_data_modul_edm_sbc.h
index 11ac3c00f7e..8d7954004c2 100644
--- a/include/configs/imx8mp_data_modul_edm_sbc.h
+++ b/include/configs/imx8mp_data_modul_edm_sbc.h
@@ -29,8 +29,6 @@
 	"bootlimit=3\0"							\
 	"devtype=mmc\0"							\
 	"devpart=1\0"							\
-	/* Give slow devices beyond USB HUB chance to come up. */	\
-	"usb_pgood_delay=2000\0"					\
 	"dmo_update_env="						\
 		"setenv dmo_update_env true ; saveenv ; saveenv\0"	\
 	"dmo_update_sf_write_data="					\
@@ -40,6 +38,11 @@
 		"run dmo_update_sf_write_data\0"			\
 	"dmo_update_sd_to_sf="						\
 		"load mmc 1:1 ${loadaddr} boot/flash.bin && "		\
-		"run dmo_update_sf_write_data\0"
+		"run dmo_update_sf_write_data\0"			\
+	"stdin=serial\0"						\
+	"stdout=serial\0"						\
+	"stderr=serial\0"						\
+	/* Give slow devices beyond USB HUB chance to come up. */	\
+	"usb_pgood_delay=2000\0"
 
 #endif
-- 
2.43.0

