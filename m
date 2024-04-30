Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D39C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06F2488A56;
	Tue, 30 Apr 2024 17:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Ns8BWggq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF4088A62; Tue, 30 Apr 2024 17:33:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E12A888A56
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:33:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491152; bh=xLF7G970im7TYuLEdVvA0tVzyEXwL+uVlSSBljKE9yo=;
 b=Ns8BWggqDG51xMAMMmigysyil26weOz+AOerKkJ5DiOr1Apimwomxo2GXjZuLPPOp8Ffvz29w
 YFyfzAaSArzkS4d33p+RqFotFnTwReQhleML8OOuDZzAomdHEjpwqVxuopZGoeKDPpQJP1oxuaQ
 0C13WHlaVNlCgMa2zLp/gXdOoEFcUiDusLI8Pjt1sxYLgm3QcOTschj/fXjq6MiyHJRHWqnAJ4t
 TcB7GhBVzhLCsUdueHDYeJZsVYIXeqWEqSXD/5vE1o0BlF9ezcZVBtF3arNEfGwaV12lZ42UYJF
 Yxus0VsWJm5OsPouLXtyLbX8Oj1ebdchAz9GMxR3g48g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 16/18] rockchip: rk3399: Include uart related pinctrl nodes
 in TPL/SPL
Date: Tue, 30 Apr 2024 15:30:23 +0000
Message-ID: <20240430153053.308788-17-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310efdd99e42224315b925
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

The initial serial console UART iomux is typically configured in
board_debug_uart_init() at TPL stage on Rockchip platform.

Later stages typically use pinctrl driver to configure iomux UART once
again based on the control FDT.

Include uart related pinctrl nodes in TPL/SPL control FDT to make it
possible for pinctrl driver to configure UART iomux at TPL/SPL stage.

Following debug log message may also be seen at U-Boot pre-reloc stage:

  ns16550_serial serial@ff1a0000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19

This can be resolved by including bootph prop for U-Bood pre-reloc
phase (bootph-some-ram or bootph-all). However, this has intentionally
been excluded due to including it unnecessarily slows down boot around
200-400 ms.

Also add the clock-frequency prop similar to what has been done for
other Rockchip SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch split from "Fix loading FIT from SD-card" patch
v2: Change to only include pinctrl nodes in TPL and SPL phase

Hopefully the clock-frequency prop can be used to help speed up boot in
a future patch series, loading the uart rate from clock driver currently
delays boot at i.e. U-Boot proper pre-reloc.
---
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 16 ++++++++++++++++
 arch/arm/dts/rk3399-u-boot.dtsi             |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
index 390cf24152a6..d1912a2ef6a9 100644
--- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
@@ -113,4 +113,20 @@
 
 &uart0 {
 	bootph-all;
+	clock-frequency = <24000000>;
+};
+
+&uart0_cts {
+	bootph-pre-sram;
+	bootph-pre-ram;
+};
+
+&uart0_rts {
+	bootph-pre-sram;
+	bootph-pre-ram;
+};
+
+&uart0_xfer {
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 9815dc53e8ed..b39fe39fa2b3 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -136,6 +136,12 @@
 
 &uart2 {
 	bootph-all;
+	clock-frequency = <24000000>;
+};
+
+&uart2c_xfer {
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
 
 &vopb {
-- 
2.43.2

