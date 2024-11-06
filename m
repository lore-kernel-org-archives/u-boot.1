Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C875D59F68
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 19:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5402B88E0A;
	Wed,  6 Nov 2024 20:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730919933;
	bh=R4j0hGWTcRY/XzCSUrQNEPUCXXi8ckhyCaHhaGwejvE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NxxC86LS9J0lv5VLCwwm78ht4BWntENjLKB/sae3bB5oaEOtIgI6X5QdBEU34XmLw
	 sWvgPw66Go2UIRe1NuUf1YX0oxBUo05NzhaVuQTS0UJoJsaZIAzJutkSSMG+MIm+ep
	 LOrIwo9B8QNRvG6avct7EbhI4S45hLz1kr6UoQWqiWeSzRy+qNdatWyySDbrQAwXvf
	 tDfcgKt2fw5fwjPQfyL9/rAv0aP2pghBlC7WO4ctgjBpFw1yUrCM9vqT2ztN3Pk9+S
	 opTlo5YTMbM2cpwBG836avru94ghFLZwDFPDbqpvSMra+c8RKCOAV3cv3mI0LHBpc9
	 kOWvnO0oqJKtQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 5FE3D88E26;
 Wed,  6 Nov 2024 20:05:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730919931;
 bh=R4j0hGWTcRY/XzCSUrQNEPUCXXi8ckhyCaHhaGwejvE=;
 h=From:To:Cc:Subject:Date:From;
 b=OrSY5IS+4HWtNpWgauKzQEhrd+vdDSwjTaL+9SAbf4ssT8ul9zg+fWWVO/XR0y3Gk
 h54OFtgiJMJo4P4Bw6+6GMLy3iSJskVO1yYedFT0OPeYGqOI99fErIxBTVNxw9o5Ok
 +AQdYsafHA5Je+s/DlV8vf0m6VV9ElyH7Qr0MxJ978eY0DFNMysz+PCUoWwGPByJMj
 L4JmH4USqLA6VuuTkQj1HMteaAONQedWLyeS9JiKl8w1UCEVzbXGsyczlPU3We3Yk5
 Ujl0PoEu0ndShPc/62pDSz3h2iA3/BGsGrcESrVFHBl9vWEatAdC+AomCldmHf3V3R
 MnOs+AT5sdjyg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Add optional manufacturing environment to DH
 STM32MP15xx DHSOM
Date: Wed,  6 Nov 2024 20:04:14 +0100
Message-ID: <20241106190516.224197-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Add manufacturing environment into STM32MP15xx DH electronics DHSOM
configuration. This environment is part of every board build, but only
takes effect on systems booted with the dh,stm32mp15xx-dhcor-testbench
device tree, i.e. systems populated with factory build of U-Boot.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 configs/stm32mp15_dhsom.config       |  1 +
 include/configs/stm32mp15_dh_dhsom.h | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
index 4f8e98beec6..efc149577ea 100644
--- a/configs/stm32mp15_dhsom.config
+++ b/configs/stm32mp15_dhsom.config
@@ -64,6 +64,7 @@ CONFIG_SYSRESET_SYSCON=y
 CONFIG_SYS_BOOTCOUNT_ADDR=0x5C00A14C
 CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_SYS_PBSIZE=1050
+CONFIG_PREBOOT="run dh_preboot"
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
 CONFIG_TARGET_DH_STM32MP1_PDK2=y
 CONFIG_USE_SERVERIP=y
diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index 2797fc61d17..c004a8cec82 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -18,6 +18,8 @@
 #endif
 
 #define STM32MP_BOARD_EXTRA_ENV						\
+	"dh_preboot="							\
+		"run dh_testbench_backward_compat\0"			\
 	"dh_update_sd_to_emmc=" /* Install U-Boot from SD to eMMC */	\
 		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
 		"load mmc 0:4 ${loadaddr1} boot/u-boot-spl.stm32 && "	\
@@ -61,7 +63,20 @@
 	"stdout=serial\0"						\
 	"stderr=serial\0"						\
 	"update_sf=run dh_update_sd_to_sf\0"				\
-	"usb_pgood_delay=1000\0"
+	"usb_pgood_delay=1000\0"					\
+	/* Old testbench-only backward compatibility environment */	\
+	"dh_testbench_backward_compat="					\
+		"test ${board_name} = \"dh,stm32mp15xx-dhcor-testbench\" && " \
+		"run load_bootenv importbootenv\0"			\
+	"importbootenv="						\
+		"echo Importing environment from DHupdate.ini...;"	\
+		"env import -t ${loadaddr} ${filesize}\0"		\
+	"load_bootenv="							\
+		"usb reset && "						\
+		"load usb ${usbdev}:${usbpart} ${loadaddr} DHupdate.ini && " \
+		"echo \"--> Update: found DHupdate.ini (${filesize} bytes)\"\0" \
+	"usbdev=0\0"							\
+	"usbpart=1\0"
 
 #include <configs/stm32mp15_common.h>
 
-- 
2.45.2

