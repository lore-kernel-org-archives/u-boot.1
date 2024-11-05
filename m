Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04FED3E775
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E3E891F8;
	Tue,  5 Nov 2024 22:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="OdofX2G4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7102D891E8; Tue,  5 Nov 2024 22:52:47 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A46891D7
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730843558; bh=EIyFa8prNEOsn26tOsy+YiYKFgIUQeMGMI8CnipCgRk=;
 b=OdofX2G4BbQ0FAqxmVHrUex+YYkf5ouQMp2M6IifUb5AOcHa7HMGUhIpiv5oE93kaILWQ9gu3
 I7Ev+uZgQK4J0v6eL+cBEOchqEm2q24gLtPYYKelLZZGEIuSI5Uegxv8eCRwEotRD7ATsC43eIy
 fNvNNAvmp2/axaswVMZLEbXjRjjP5I2iAHdoFJh8dWGHi62mnZE78swUZ0hcJHi4JnFwG4tfvDa
 4QuMmMPWnh6wA/smJRb9P5Eoqw7S7Lrc9Pz6NCk0fpD+0kqk7XDPcfSGGpsfzuXumm/HUq/+b06
 eGdbiWsTL2s96cJ8vrulLn27wZr31wmOsfYDhYAxDUEQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 06/11] rockchip: rk3288-miqi: Include sdmmc regulator in SPL
Date: Tue,  5 Nov 2024 21:51:42 +0000
Message-ID: <20241105215202.1491441-7-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 672a93a4059db14dd83d7b34
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
 arch/arm/dts/rk3288-miqi-u-boot.dtsi | 5 +++++
 configs/miqi-rk3288_defconfig        | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/dts/rk3288-miqi-u-boot.dtsi b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
index 05e07425c751..4361b35d6c8f 100644
--- a/arch/arm/dts/rk3288-miqi-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-miqi-u-boot.dtsi
@@ -43,6 +43,7 @@
 
 &gpio7 {
 	/delete-property/ bootph-all;
+	bootph-pre-ram;
 };
 
 &pcfg_pull_none {
@@ -100,3 +101,7 @@
 	bootph-pre-sram;
 	bootph-pre-ram;
 };
+
+&vcc_sd {
+	bootph-pre-ram;
+};
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 0e3c2b38f22b..87fd256c8a53 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -4,6 +4,7 @@ CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
 CONFIG_SYS_ARCH_TIMER=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x01000000
+CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_DEFAULT_DEVICE_TREE="rk3288-miqi"
@@ -40,6 +41,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
@@ -62,6 +64,7 @@ CONFIG_DM_PMIC=y
 CONFIG_PMIC_ACT8846=y
 CONFIG_REGULATOR_ACT8846=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
-- 
2.46.2

