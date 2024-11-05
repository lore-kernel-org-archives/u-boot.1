Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F5ED3E775
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE61891D0;
	Tue,  5 Nov 2024 22:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DQKv3Vy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD878917B; Tue,  5 Nov 2024 22:52:43 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100EE891EB
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730843553; bh=2HvX/Drl4VJdDfwEpD3/awo/KY+80SoYnNQQLcTidbg=;
 b=DQKv3Vy8m5enqgIxkAa9n098VSWxecq87l4NgZkx+WQ86sGd/VxZCy00/vXL/2V8opkYEXKhM
 s/j/lVTY05Hh3/34XW50MP5OKdCdX7x3qanKMbp/u/l85615iO7vVJEimelPvs4pTBt3NDpbB6Z
 lRZEUm5O4ywdTCicMvPUPAnpLyii+ttbLi2PO7HLbnXZRw/TuXjIAWgxfOWeFKhiSD4BExN36F3
 X98OM0pTaHEd7kf627t3Z1gZtG4Oi5SVtepSeGs0WXg2cBnP+L/rTA1ileqVmlNQ3MMDlZ7L2wU
 1dGo/EpXU0e/WiSdHILDn/eqEgh/30yyxT17N/t6zsoA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 05/11] rockchip: rk3288-miqi: Include required DT nodes in xPL
Date: Tue,  5 Nov 2024 21:51:41 +0000
Message-ID: <20241105215202.1491441-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105215202.1491441-1-jonas@kwiboo.se>
References: <20241105215202.1491441-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a939f059db14dd83d7b22
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

Add bootph- props to emmc, sdmmc, uart and related pinctrl nodes to
ensure devices and pinctrl can be used in xPL and U-Boot pre-reloc.

Remove the explicit bootph-all prop from the pinctrl node, any bootph-
prop will automatically be propagated to the pinctrl node.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-miqi-u-boot.dtsi | 57 +++++++++++++++++++++++++++-
 configs/miqi-rk3288_defconfig        |  2 +-
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3288-miqi-u-boot.dtsi b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
index 721d02086939..05e07425c751 100644
--- a/arch/arm/dts/rk3288-miqi-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
@@ -17,27 +17,75 @@
 };
 
 &emmc {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_bus8 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_cmd {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&emmc_pwr {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&gpio7 {
+	/delete-property/ bootph-all;
+};
+
+&pcfg_pull_none {
 	bootph-all;
 };
 
-&pinctrl {
+&pcfg_pull_none_12ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pcfg_pull_up {
 	bootph-all;
 };
 
+&pcfg_pull_up_drv_12ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &sdmmc {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_bus4 {
 	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_cd {
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_clk {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_cmd {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &sdmmc_pwr {
@@ -47,3 +95,8 @@
 &uart2 {
 	bootph-all;
 };
+
+&uart2_xfer {
+	bootph-pre-sram;
+	bootph-pre-ram;
+};
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 2bb8bf2ac060..0e3c2b38f22b 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
-- 
2.46.2

