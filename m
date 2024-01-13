Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C12EC4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 17:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E18C487941;
	Sat, 13 Jan 2024 18:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705168712;
	bh=OzQD8RTLlgGkKaYlxGEhy6j8cS4l6OmbZOuN4wdlSe0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UK9NdeVYrGvBPHk12wuLsM8VZsZb/8nFKFGEomt1SVW4W2EGkyGkW2cjXXgoTStl9
	 vYkBRR1HRvLTbUYoSyuTIPP0GsO5cHXkaX3uMRIvglc3xThst1LoVTOB/jvPOX0ADF
	 qkFA1CBlZwD8m+ndq4LP8ZMcQNob7MrUt8WTWNL+GJeKIDSEV90hW4abcPT1DwdTkE
	 KYuBS4wzkTvY2unAn+nioGHfGhtbHIOBMuFVfdmmzyZaHWsWyovsV1ihBg3LLDFNgZ
	 NPoJDekNuHqlukLOWba3j6c4/G4qNBSF1StXr1wqkC5OiWX0LWvuUFTXwsCjlr7z40
	 8ltTGAoSHhxng==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EF42C87134;
 Sat, 13 Jan 2024 18:58:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705168706;
 bh=OzQD8RTLlgGkKaYlxGEhy6j8cS4l6OmbZOuN4wdlSe0=;
 h=From:To:Cc:Subject:Date:From;
 b=I0/c6qMI5H4ALupYQukQokWHR6h0LgevL5SlzcqDY4kZHVHdfRRY4Yo4T74+pOYRk
 4GZewKiXp9Jkr1+jbYTtCwLB/XFr9m7YU1XuuL3SvdusuOeSC8sQHUVC7J17RvtR6O
 YIq47nPkAkodctG41xlUOE68JcrlY9EWijnJ8K8nHEVyrPgYz0xb92eM412bnpb/e5
 q1HCb02QYa7j99hb340XM16YZWxJzvDC2CXjyjBd2FUKpoQVq0Zpq3hbTqVSF4ADD+
 E0G+auHJwBGgxH3HulY2pOoLUMhVGANLO8bDvCFe8Am5C5bbLgkeEOChHBB/HkO3WU
 KsE0PIKlsulRw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Set stdio to serial on DH STM32MP15xx DHSOM
Date: Sat, 13 Jan 2024 18:57:27 +0100
Message-ID: <20240113175811.157221-1-marex@denx.de>
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
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 include/configs/stm32mp15_dh_dhsom.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index 8ff882264f4..de39b19219d 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -12,14 +12,13 @@
 #define PHY_ANEG_TIMEOUT		20000
 
 #ifdef CONFIG_SPL_BUILD
-#define CFG_EXTRA_ENV_SETTINGS					\
+#define CFG_EXTRA_ENV_SETTINGS						\
 	"dfu_alt_info_ram=u-boot.itb ram "				\
 			__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS)	\
 			" 0x800000\0"
 #endif
 
-#define STM32MP_BOARD_EXTRA_ENV \
-	"usb_pgood_delay=1000\0" \
+#define STM32MP_BOARD_EXTRA_ENV						\
 	"dh_update_sd_to_emmc=" /* Install U-Boot from SD to eMMC */	\
 		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
 		"load mmc 0:4 ${loadaddr1} boot/u-boot-spl.stm32 && "	\
@@ -49,7 +48,11 @@
 		"sf update ${loadaddr1} 0x40000 ${filesize1} && "	\
 		"sf update ${loadaddr} 0x80000 ${filesize} && "		\
 		"env set filesize1 && env set loadaddr1\0"		\
-	"update_sf=run dh_update_sd_to_sf\0"
+	"stdin=serial\0"						\
+	"stdout=serial\0"						\
+	"stderr=serial\0"						\
+	"update_sf=run dh_update_sd_to_sf\0"				\
+	"usb_pgood_delay=1000\0"
 
 
 #include <configs/stm32mp15_common.h>
-- 
2.43.0

