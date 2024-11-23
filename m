Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C5EE6ADE3
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3516289412;
	Sat, 23 Nov 2024 17:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380805;
	bh=BGcHytLB8olZ4NoklB+K917x7TtRnmAyb8MBag9kf2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AY/QghyUKg1Fivx0KRc0Koq+xL8Vd/uI81W8Zu7LGhqPeQLm/pmRa2Oi0gz326dsQ
	 aaFuxsb33DoJd8jWzBcZWiR5h1KlOV1IjtRjRQC9ctmqGRPsA52UKTN+Z2+MXq0pnZ
	 woA6JkErD8/3AEPADKrzzzz2WhI2Rnte1gyTmZkx5nw/sa3nz1+5CIzGTYLlf+UIpT
	 klKdWQzUDj5Rj7J5eiNZSUmvoXZcYGg+iHdN8odBALB+evb+n9cIVAaWqOgP+JIfRY
	 EWdSEES42bkEdFtfHxwEkGXrIr+R12mtPGCjE4VYyOhXBQXILz/92HBHEBZ5dIPgrH
	 v0FntXsbmyIig==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 15741893FA;
 Sat, 23 Nov 2024 17:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380801;
 bh=BGcHytLB8olZ4NoklB+K917x7TtRnmAyb8MBag9kf2M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hnBwBFt85gprK500WFeqR2u/Ao/hZh668SHpoGTHesBoanwazFBn3UlAoZhxLCAPO
 1eipjf0qGZGZ3itHDRl8c7A0+Zitv+kdIhwSXZSVazOMFxOT+VbO87RSxFMuMn71aZ
 sxjcjJbSsteH5h0dX66ZVlwZwFriXgOx/HNVGeSR6LNIoF3DirOD/ERuRvvCQJoCvK
 bwvq9b+3clClj9gce7Mpn1nqFbMpvdqLf89pcEGTtAeD1YAPDdQd5Xc1fk67rBp6o7
 MPutSJCoj9xAmTcIR/fJ0scFL1cRLkDjY39qD5BA9wX2rj6zKNf2MwzZ8a8ZUrg+rp
 gk37qpmzY+KqA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 11/20] siemens: configs/capricorn_cxg3_defconfig: updates
Date: Sat, 23 Nov 2024 17:52:55 +0100
Message-Id: <20241123165304.100538-12-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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

make savedefconfig and add SCU_WDT and fix environment
offsets, as since silicon c0 the boot container takes place
at offset 0 and so the u-boot-env must be moved outside of
the boot container area.

Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---

(no changes since v3)

Changes in v3:
- use renamed Kconfig symbol CONFIG_WDT_SIEMENS_PMIC

Changes in v2:
- add comments from Fabio
  fix typo: silicium -> silicon
- add Reviewed-by from Alexander
- use renamed Kconfig symbol CONFIG_WDT_SCU_PMIC

 configs/capricorn_cxg3_defconfig | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index d2bcc46d306..276445528a9 100644
--- a/configs/capricorn_cxg3_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -10,7 +10,7 @@ CONFIG_NR_DRAM_BANKS=3
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0x0
+CONFIG_ENV_OFFSET=0x200000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8-capricorn-cxg3"
 CONFIG_SPL_TEXT_BASE=0x100000
@@ -26,7 +26,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80280000
 CONFIG_SPL=y
-CONFIG_ENV_OFFSET_REDUND=0x2000
+CONFIG_ENV_OFFSET_REDUND=0x202000
 CONFIG_IDENT_STRING=" ##v01.06"
 CONFIG_REMAKE_ELF=y
 # CONFIG_EFI_LOADER is not set
@@ -56,9 +56,10 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x120000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x3000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x4000
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
@@ -113,10 +114,13 @@ CONFIG_PHYLIB=y
 CONFIG_MV88E61XX_SWITCH=y
 CONFIG_MV88E61XX_CPU_PORT=5
 CONFIG_MV88E61XX_PHY_PORTS=0x7
+CONFIG_DM_ETH_PHY=y
 CONFIG_FEC_MXC_SHARE_MDIO=y
 CONFIG_FEC_MXC_MDIO_BASE=0x5B050000
 CONFIG_FEC_MXC=y
 CONFIG_MII=y
+CONFIG_PHY=y
+CONFIG_NOP_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8=y
@@ -130,5 +134,7 @@ CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_SCU_THERMAL=y
-# CONFIG_SPL_WDT is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_WDT=y
+CONFIG_WDT_SIEMENS_PMIC=y
 CONFIG_SPL_TINY_MEMSET=y
-- 
2.20.1

