Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1A1C3DA4A
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 08:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D838888E0;
	Mon,  5 Aug 2024 10:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="sY0jPJTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FE1888C2; Mon,  5 Aug 2024 10:44:24 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 422A2888B9
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 10:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722847448; bh=K7Yd1v40Gcz1WD+vangAV7JamXB3SyoS0tlGeUvZC0U=;
 b=sY0jPJTmLM34LlJEncz6b4/w9Yl5+f9iUGvIuRt8OaXhnT2RinguYMSfXUy4j0OTPPRI+k0AT
 xvvCt5meNLi46D/dhkwud68nSflLyMQvIVlv+W05Qzv8fZeNOLcmzNQeGtTN/23agAoeDe5+fqx
 6OfPGDCq0KMOdr1MsdHjtplVEfGBxt6qgQoELIzqlwEpOb4js3wkD9zhdJfeclTC5vnHDUbFIzj
 kjywWja15zHzB+rvy21V55v5kIunJ1DBg3DGOc5N1w4wt8ZsXLrZqY/6b8tX7UtLz9iKuENclAK
 FJCW+EhKur/l+NyvxsiWMm5DOEmji+JnBV5jO9VoZU7g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Klaus Goger <klaus.goger@cherry.de>, Quentin Schulz
 <quentin.schulz@cherry.de>, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/4] rockchip: rk3588: Skip serial pinctrl at pre-reloc phase
Date: Mon,  5 Aug 2024 08:43:43 +0000
Message-ID: <20240805084350.3895788-4-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66b090d7ef96678d293a4ef5
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
- in SPL for DEBUG_UART in board_debug_uart_init()
- in SPL using pinctrl from DT
- in pre-reloc phase using pinctrl from DT
- after relocation using pinctrl from DT

Skip including UART pinctrl for the pre-reloc phase to save time during
boot. On a Radxa ROCK 5B this reduce boot time by ~150 ms.

After this a warning may be shown with LOGLEVEL=5 (or higher), it is
safe to ignore this warning as device probe is successful even when
pinctrl cannot be applied:

  ns16550_serial serial@feb50000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi | 3 ++-
 arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 3 ++-
 arch/arm/dts/rk3588s-u-boot.dtsi             | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
index 275ae6fdaead..08ebb0af4482 100644
--- a/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi
@@ -33,5 +33,6 @@
 };
 
 &uart2m2_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
index a50bcc45f216..59886b9828a4 100644
--- a/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi
@@ -17,5 +17,6 @@
 };
 
 &uart9m0_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index 09d8b311cec5..df7e93d19c52 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -154,7 +154,8 @@
 };
 
 &uart2m0_xfer {
-	bootph-all;
+	bootph-pre-sram;
+	bootph-pre-ram;
 };
 
 &xin24m {
-- 
2.45.2

