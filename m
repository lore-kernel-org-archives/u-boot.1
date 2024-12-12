Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8E1E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED46E80274;
	Thu, 12 Dec 2024 23:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Pmedyo7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560E8802F2; Thu, 12 Dec 2024 23:10:40 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A0780285
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734041435; bh=dNvtomnzSHmSYapSwe9SsoWBVoZGJoz2Y1pgHNQ41DI=;
 b=Pmedyo7lEMAXerKokXZfleTboc4ZT13mgKm18f84pp0LIf2tSaJtmcJwEy5gwHgEOpgzi4Ty1
 7cO18klDFNpzcyEafr9k8ZzVHENyJ5D9ntceDuvHEBjAy1DNLYRppCDS63f+z6aodeKFWkA5HjP
 k7sCes4b/h4V/qmHZtlUnCyfSgxo26YHWxt2utw67m6UCTD01ECWJcTef1c6hCRXM5aw4jR69YH
 Ai859WFg9ao8axlmCxL14iF/9czBFQvIKk7oJI/pzB90xzMpAYd6kpJxzRvEDVB8+Cng9+dTUVL
 dd7sxOQMkSTf9JuT8KbCZDScSXmkEtJsRgY9OI7emgdQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/11] rockchip: rk3288-firefly: Include sdmmc regulator in SPL
Date: Thu, 12 Dec 2024 22:09:39 +0000
Message-ID: <20241212221000.94501-7-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 675b5f58a511ed8f0b3fc866
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

Add bootph props and enable related Kconfig options to include the sdmmc
regulator in SPL. Also enable SPL_DM_SEQ_ALIAS to ensure aliases is
handled correctly in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-firefly-u-boot.dtsi | 5 +++++
 configs/firefly-rk3288_defconfig        | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
index 435a02acea5d..f953f6821326 100644
--- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
@@ -52,6 +52,7 @@
 
 &gpio7 {
 	/delete-property/ bootph-all;
+	bootph-pre-ram;
 };
 
 &pcfg_pull_none {
@@ -109,3 +110,7 @@
 	bootph-pre-sram;
 	bootph-pre-ram;
 };
+
+&vcc_sd {
+	bootph-pre-ram;
+};
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 862a17c84e07..2160474fe0f3 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -4,6 +4,7 @@ CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
 CONFIG_SYS_ARCH_TIMER=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_DEFAULT_DEVICE_TREE="rk3288-firefly"
@@ -41,6 +42,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
@@ -62,10 +64,10 @@ CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
-# CONFIG_SPL_PMIC_CHILDREN is not set
 CONFIG_PMIC_ACT8846=y
 CONFIG_REGULATOR_ACT8846=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
-- 
2.47.1

