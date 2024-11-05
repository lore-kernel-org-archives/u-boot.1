Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA85CD2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2D1891E0;
	Tue,  5 Nov 2024 17:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="a4w5WT5O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4403891EB; Tue,  5 Nov 2024 17:01:37 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76965891DD
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822485; bh=Q9B5UqICLjFamRUIU82yQ403bZqurvQ+pPCAqEkYvcw=;
 b=a4w5WT5OL0jXyvCWRjI6Y2mCeUgpGI59XyrTEEbBQjlLVKySGCYwdHt48/07U5VHLYWXVnWWn
 RcBW3krbe7NxgRgxsgtk4G300HZpZjJIVmJzkBQGvsi0bqMHqHzI5a2/qD7wAtl5dwvMNoMB++u
 HRcIY9aRvNF8yUzYyRanwNiy/yz4VNSmUfiROiZ6pMORYSCDLv2B8MCfwDvdl8dTgAUgUEQGjyJ
 nELQmsiAWgIJjj0acYsTBjfdBfs0HiBqcfNcbPMeaEF456VUTMn3kUafA9i5h5sK7CwNY/uNMht
 VRQpbIzSrP2dtZL1EM0xE4IPMXWdK3aXC6EcEC6/PFvQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 06/13] rockchip: rk3288-tinker: Set cpuid and serial env var
Date: Tue,  5 Nov 2024 16:00:29 +0000
Message-ID: <20241105160054.1373319-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a4153ff3e144e4725e100
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

Enable MISC_INIT_R and ROCKCHIP_EFUSE to read cpuid from efuse and set
the cpuid# and serial# env vars.

Change to read mac address from eeprom in rockchip_early_misc_init_r()
to ensure the ethaddr env var is set before rockchip_setup_macaddr() try
to set ethaddr based on cpuid.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/rockchip/tinker_rk3288/tinker-rk3288.c | 2 +-
 configs/tinker-rk3288_defconfig              | 2 ++
 configs/tinker-s-rk3288_defconfig            | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/board/rockchip/tinker_rk3288/tinker-rk3288.c b/board/rockchip/tinker_rk3288/tinker-rk3288.c
index e966e9f201ab..dfd553d1aa5f 100644
--- a/board/rockchip/tinker_rk3288/tinker-rk3288.c
+++ b/board/rockchip/tinker_rk3288/tinker-rk3288.c
@@ -22,7 +22,7 @@ static int get_ethaddr_from_eeprom(u8 *addr)
 	return i2c_eeprom_read(dev, 0, addr, 6);
 }
 
-int rk3288_board_late_init(void)
+int rockchip_early_misc_init_r(void)
 {
 	u8 ethaddr[6];
 
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index aff820ebfdda..851c312d4db5 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -29,6 +29,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-tinker.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
@@ -63,6 +64,7 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
+CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 6aef775a5717..2269d04ee644 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -29,6 +29,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-tinker-s.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
@@ -64,6 +65,7 @@ CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
+CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-- 
2.46.2

