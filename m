Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA530C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:46:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B678840E;
	Thu,  6 Jun 2024 10:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 408A8883EA; Thu,  6 Jun 2024 10:45:47 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471D18808B
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvybD6cbdzt6r;
 Thu,  6 Jun 2024 10:45:44 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvybD24ZmzDmq; Thu,  6 Jun 2024 10:45:44 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 06 Jun 2024 10:45:34 +0200
Subject: [PATCH next v3 4/6] rockchip: px30-ringneck: Update SPL_PAD_TO
 Kconfig option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-misc-tsd-v3-4-728d721c464a@cherry.de>
References: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
In-Reply-To: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

On px30-ringneck the FIT payload is located at sector 0x200 compared to
the more Rockchip common sector 0x4000 offset:
	SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200

Because FIT payload is located at sector 0x200 and the TPL+SPL is
located at sector 64, the combined size of TPL+SPL cannot take up more
than 224KiB:
	(0x200 - 64) x 512 = 0x38000 (224 KiB)

Adjust SPL_PAD_TO to match the used 0x200 sector offset.

While at it, update the px30-ringneck-u-boot.dtsi to remove the now
unnecessary override of simple-bin:fit:offset since SPL_PAD_TO matches
with the current formula.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi | 8 --------
 configs/ringneck-px30_defconfig               | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi b/arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi
index e04766ad09c..29ea2763636 100644
--- a/arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi
+++ b/arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi
@@ -15,14 +15,6 @@
 	};
 };
 
-&binman {
-	simple-bin {
-		fit {
-			offset = <((CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR - 64) * 512)>;
-		};
-	};
-};
-
 &emmc_clk {
 	bootph-all;
 };
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index dedf35d4347..a22d25e0089 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/px30-ringneck-haikou.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_PAD_TO=0x38000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set

-- 
2.45.2

