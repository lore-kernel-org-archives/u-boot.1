Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F7BD5E396
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B943F89454;
	Mon, 18 Nov 2024 07:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911256;
	bh=mjH4W4DqyyLiirlJXV5viEiDaon73KF75Uxgfzj8bQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nuEShnD1LWf8PXUssgV5AxLW9S4Xu3BkyRgz8cdUm3/SH9P6Yd/lmAqIdAtDSPwK2
	 C8bVK6ujs6RQhx0p0Q3fqJKZV232lQvObgJbDJ6neha4wux7WKlPnOIvrWq7fjt+2P
	 hmASdvRX6hqL3vvq8fYEONkBYOjzrLbq0fuk1sQyBNouGgokoe+zlns1Nqt1jP5XEL
	 VMIVe6ca3MVgcvk3rbAULoN0zcSq3Or4TYlrShXmxYG5Pkadko803nyFrW+V3oSgAE
	 7oEMtzm2dakFOynub0S1+2VnhATjljvWQzn/1tvQedC/N2DO6onyCPAupy7BfX7rAT
	 /LmHSBW7k3foA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8377089448;
 Mon, 18 Nov 2024 07:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911254;
 bh=mjH4W4DqyyLiirlJXV5viEiDaon73KF75Uxgfzj8bQs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vfGnbhCrCw9kJVd/pAl9IP3fdCcZVG1E7moz5YIt39xPMngmkU32RMFjYdWzGcTBD
 oNcrZAyusVmBtkslRqEw3OaIoDCQOvS+gy/pDi5yhk81I7JlX7ikTfRsQfxsRxgXDr
 IQxAGK5eWdmD15f9CCEEQ7aURRVJ35jUTqsIxigeZm+mHfZmD44U+zYJX2ynd/XloB
 V+Ap1baJa2UjtekZ7nGmyRGAJK3vagwalmxInDBO+O/pe+689YEpNyQ6encyxIRkqB
 1vLvw7r91uYH5vyk3LdNcFjbdfIdZTJ8yRAaMZfdiwV26pPqJDoYTmidwMrQea196M
 yHAqkgLleFSLw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/20] siemens: configs/capricorn_cxg3_defconfig: updates
Date: Mon, 18 Nov 2024 07:27:05 +0100
Message-Id: <20241118062715.32989-12-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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

Changes in v2:
- add comments from Fabio
  fix typo: silicium -> silicon
- add Reviewed-by from Alexander
- use renamed Kconfig symbol CONFIG_WDT_SCU_PMIC

 configs/capricorn_cxg3_defconfig | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index ce820e2c54f..628857c9fe5 100644
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
@@ -25,7 +25,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80280000
 CONFIG_SPL=y
-CONFIG_ENV_OFFSET_REDUND=0x2000
+CONFIG_ENV_OFFSET_REDUND=0x202000
 CONFIG_IDENT_STRING=" ##v01.06"
 CONFIG_REMAKE_ELF=y
 # CONFIG_EFI_LOADER is not set
@@ -55,9 +55,10 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
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
@@ -112,10 +113,13 @@ CONFIG_PHYLIB=y
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
@@ -129,5 +133,7 @@ CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_SCU_THERMAL=y
-# CONFIG_SPL_WDT is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_WDT=y
+CONFIG_WDT_SCU_PMIC=y
 CONFIG_SPL_TINY_MEMSET=y
-- 
2.20.1

