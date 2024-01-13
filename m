Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEF1C4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 17:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AA7A87968;
	Sat, 13 Jan 2024 18:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705168751;
	bh=unb5CfRDroclepYIbU8ri4tI66yqH1qSZaQV9BFLNXQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GDB0njiPaO8BTlBppemKKXc0S5k0qrsv4qhllvpsIVL0us9ZBDQAB+1HaOiFc7Kp7
	 2XejNsG/Pte+FGPzC7hwog1B42hF3ZpSPOuoH9OAoVEJuBwfDD6oLOYUpQl06WCdvA
	 saEPCU9eoaxqQWX471dt2QxqLcytJ4WgcEsdNOrZSmJfPq3w8SBDuqOKmVQmMMVftR
	 MLMaPGGEPyDABQPkBvG8evgHtrYoTfi+hO2d7ba3BgpSMctsNtZTGdQ6blfexPCxmz
	 FiyI29Qx3ByzstyQ7rAEFYaitnE+W5ubyYFAgw0dkkxG6rYuwGmVsDk2Zzpo+Liw0C
	 aEW9nR1IxgzXg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A48D78793C;
 Sat, 13 Jan 2024 18:59:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705168750;
 bh=unb5CfRDroclepYIbU8ri4tI66yqH1qSZaQV9BFLNXQ=;
 h=From:To:Cc:Subject:Date:From;
 b=Vm2zxSbdj4gHGZkdNu8qRTmb7RSUris2lqPXhuseV2dVBgoqtofmnLAYbuJxKUjR4
 UPZ0IJC+eBwaGsaKrtT+IDsmFAtWrfw4i2S4/52OPBqQ0Iv4UkdAuJcmxMebgbVKN+
 WqHQOVvy295r29fzFafMCMZAckCU7qEOhcxFMHcgOD7i1ubOfwH1P/l+mBgtP2FGbB
 Nnjr8Uago7L8zTbEtD7SEzaqB9BNN9D0wgQl/TtbylYxQL4QF2JOnD+H7JKkFSqhTy
 NM1ByDZJJ0YkV1C2J6+aSUlwLlf33oNOpxOSeQKeeJkztAe7HpdZpjTCRMlQkY/lT2
 Mv9ifUiz1Yr7A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Set stdio to serial on DH i.MX8M Plus DHCOM
Date: Sat, 13 Jan 2024 18:58:30 +0100
Message-ID: <20240113175856.157248-1-marex@denx.de>
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
Cc: u-boot@dh-electronics.com
---
 include/configs/imx8mp_dhcom_pdk2.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/configs/imx8mp_dhcom_pdk2.h b/include/configs/imx8mp_dhcom_pdk2.h
index d022faaa91a..ea32fe11a52 100644
--- a/include/configs/imx8mp_dhcom_pdk2.h
+++ b/include/configs/imx8mp_dhcom_pdk2.h
@@ -28,15 +28,9 @@
 #define CFG_SYS_FSL_USDHC_NUM	2
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
-#define CFG_EXTRA_ENV_SETTINGS					\
+#define CFG_EXTRA_ENV_SETTINGS						\
 	"altbootcmd=run bootcmd ; reset\0"				\
 	"bootlimit=3\0"							\
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0"		\
-	"pxefile_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0"	\
-	"ramdisk_addr_r=0x58000000\0"					\
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0"		\
-	/* Give slow devices beyond USB HUB chance to come up. */	\
-	"usb_pgood_delay=2000\0"					\
 	"dfu_alt_info="							\
 		/* RAM block at DRAM offset 256..768 MiB */		\
 		"ram ram0=ram ram 0x50000000 0x20000000&"		\
@@ -68,6 +62,15 @@
 	"dh_update_emmc_to_sf="						\
 		"load mmc 1:1 ${loadaddr} boot/flash.bin && "		\
 		"run dh_update_sf_gen_fcfb dh_update_sf_write_data\0"	\
+	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0"		\
+	"pxefile_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0"	\
+	"ramdisk_addr_r=0x58000000\0"					\
+	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0"		\
+	"stdin=serial\0"						\
+	"stdout=serial\0"						\
+	"stderr=serial\0"						\
+	/* Give slow devices beyond USB HUB chance to come up. */	\
+	"usb_pgood_delay=2000\0"					\
 	BOOTENV
 
 #define BOOT_TARGET_DEVICES(func)	\
-- 
2.43.0

