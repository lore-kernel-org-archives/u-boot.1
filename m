Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1C1E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3498D80224;
	Thu, 12 Dec 2024 23:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0LG5ffY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7C1801A0; Thu, 12 Dec 2024 23:10:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D73F3802B4
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734041430; bh=z/uQCovnsR35F7L5Ohk+ylCMDsWHR2EtrmeuUG0o71U=;
 b=0LG5ffY8nPzUgjDyDMy3vj4VWtA8Qd99kBqq2n38bITk63PwpfoNRPdzqvjXJIOb+PenvVD1u
 NAJveCuO0y2PRfcqG6RPfqiwDafC/RnF5YjuUc1NOd0OEUQ8AJW576JaL5ovV0nkaYE8R1fV25u
 qHkz5yvIlv/5iGep55ZEi5G8W/YdHyNASnFp6H5h5BvpTOI/dLNIGhQtTzhNhCoGW18RgZGRWn8
 sZoaKjkjMNH4jcwuji3OkC3Lv6pECXRDs+2rBuxaeQZQHEqCb8fAQPqvsAZJKzn350KLWbI/GPg
 iKGCbm5pEL3FoeyBoBfRiaqE6d5AD4h3en30j5u4WSww==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 05/11] rockchip: rk3288-firefly: Include required DT nodes in
 xPL
Date: Thu, 12 Dec 2024 22:09:38 +0000
Message-ID: <20241212221000.94501-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212221000.94501-1-jonas@kwiboo.se>
References: <20241212221000.94501-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b5f54a511ed8f0b3fc850
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
 arch/arm/dts/rk3288-firefly-u-boot.dtsi | 55 ++++++++++++++++++++++---
 configs/firefly-rk3288_defconfig        |  2 +-
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
index 8870188e6129..435a02acea5d 100644
--- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
@@ -26,35 +26,75 @@
 };
 
 &emmc {
-	bootph-all;
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
 };
 
-&gpio3 {
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
 
-&pcfg_pull_up_drv_12ma {
+&pcfg_pull_none_12ma {
 	bootph-pre-ram;
+	bootph-some-ram;
 };
 
-&pinctrl {
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
@@ -64,3 +104,8 @@
 &uart2 {
 	bootph-all;
 };
+
+&uart2_xfer {
+	bootph-pre-sram;
+	bootph-pre-ram;
+};
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 87ed0c0d2aea..862a17c84e07 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
-- 
2.47.1

