Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58147C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 08:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 547AA888F0;
	Mon,  5 Aug 2024 10:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="DKh5FtRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67887888D5; Mon,  5 Aug 2024 10:44:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1FB888BF
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 10:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722847442; bh=yPLdZU+eQZW31bnj2WBPY84nIkPJ8XsGedEu7iinkZw=;
 b=DKh5FtRiy8prWmuRlGMpUSKhd6MaxmMY0WT9Zi3Ss4dah49Cs5reQT6veGpQuHnf021+2dUsG
 ioJCUu+3rr//nc9meejVKk0/MFNYfUzmLq4zoIAs6DJkDLTi4dfDMdsjK+WPnmz8K0l++vN/ERz
 tfBXl8Pw7BmbDANZmE/VseinW2YtnitPxbG9Eq5XVi/js7IADJh9jMASOtmQd8iAUaoI497HSA3
 cwtRwDRzip49xyMqXidegkNH2md3YuzfODC5bugWBdsBcWdElvYj2omporerb77Ff9E5m4qrXUa
 ZuNB67nT3mFbgz/i5zUeTGtAuGi8JXM8MSddqrNvztug==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 1/4] rockchip: rk3308: Skip serial pinctrl at pre-reloc phase
Date: Mon,  5 Aug 2024 08:43:41 +0000
Message-ID: <20240805084350.3895788-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805084350.3895788-1-jonas@kwiboo.se>
References: <20240805084350.3895788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66b090d1ef96678d293a4ec0
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

UART pinctrl for serial is typically applied multiple times:
- in external TPL
- in SPL using pinctrl from DT
- in pre-reloc phase using pinctrl from DT
- after relocation using pinctrl from DT

Skip including UART pinctrl for the pre-reloc phase to save time during
boot. On a Radxa ROCK Pi S this reduce boot time by ~80 ms.

After this a warning may be shown with LOGLEVEL=5 (or higher), it is
safe to ignore this warning as device probe is successful even when
pinctrl cannot be applied:

  ns16550_serial serial@ff0a0000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3308-evb-u-boot.dtsi       | 3 ++-
 arch/arm/dts/rk3308-roc-cc-u-boot.dtsi    | 3 ++-
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi | 3 ++-
 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi   | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/rk3308-evb-u-boot.dtsi b/arch/arm/dts/rk3308-evb-u-boot.dtsi
index 007a69f9a60e..ce826667dcc2 100644
--- a/arch/arm/dts/rk3308-evb-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-evb-u-boot.dtsi
@@ -10,5 +10,6 @@
 };
 
 &uart4_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi
index 3e01e7af6113..72b6f223838b 100644
--- a/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi
@@ -29,7 +29,8 @@
 };
 
 &uart2m0_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
 
 &vcc_sd {
diff --git a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
index ff5bab316a34..3059a0246086 100644
--- a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
@@ -14,7 +14,8 @@
 };
 
 &uart0_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
 
 &vcc5v0_otg {
diff --git a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
index 84ca2ee0d5fb..dd4cb8660b8d 100644
--- a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
@@ -13,7 +13,8 @@
 };
 
 &uart0_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
 
 &vdd_core {
-- 
2.45.2

