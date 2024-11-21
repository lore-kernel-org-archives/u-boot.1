Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C97BD75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D0889699;
	Thu, 21 Nov 2024 06:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166782;
	bh=s+BIShXZuTF9i3XFqjJoCA+ilx8X9nS+XH2X02mWep8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rrYBpmw+Vm2jb7vyPY4iuyYY4tZfW/vFsa3zdRepa4zcYJiwTyQ6VTPGj3MjgFrF1
	 efPlKz3jE/DPwJ+k77ZAQZQYx9FJj7/rl95LZ1UcpcbRAotOiES+B1QNlJWBrCJrfx
	 lKZpRqt8NCyl4fBe3LM3Bzdy1Hd1CDg5zFmd1sHlgM6fUTXVUgtVGxnou74P5ERCOy
	 4cgfpRzEQKf6qndljS3jjlL5uB6DlBRVVhwatHhMxlC+iAGcWDhFZBKMLPYAe0rK13
	 wbItXngtnlq2KtxeN2N8mDndGPdwzzWWUPwCryWGTkuiKBLNjZuCrhnQLtv1YB5ku9
	 95JKQcmcAwG1g==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 669FE89668;
 Thu, 21 Nov 2024 06:26:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166779;
 bh=s+BIShXZuTF9i3XFqjJoCA+ilx8X9nS+XH2X02mWep8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QfjVkSnMY66yRc9RbJJL17FMtZ9xdLHLqVFlDOjW11sblYaNh/XaFWxLA3cU00SuA
 HJLaGhOjjCCL2pUYC/ngGt3qNxy9ER6fdA39q/8VwpQEFiApylgU/vGSL4bnK/b5ms
 sIuk4mOTTNnxMxJ8nM/j4xWKAhpgtbP8k2TV8vkqSpueywp++dIlH0uLh8jmZMrjnB
 WmuKJXD0Drkf/MmnHB2PECE8jAYUT1KOXO/+eSlYbvSrXfEMJ8POObZ816afDPW8vm
 C87uQewL15gafdubGaiaWwHTuX8tLhrkWgPaS/ItflRsQqyRsSSDaosBNYQksFTlxL
 nVjo4lQMCO7zw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 11/20] siemens: configs/capricorn_cxg3_defconfig: updates
Date: Thu, 21 Nov 2024 06:25:52 +0100
Message-Id: <20241121052601.72880-12-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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
index ce820e2c54f..dc40880b1f7 100644
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
+CONFIG_WDT_SIEMENS_PMIC=y
 CONFIG_SPL_TINY_MEMSET=y
-- 
2.20.1

