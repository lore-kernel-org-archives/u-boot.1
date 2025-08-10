Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C58C87FDA
	for <u-boot@archiver.kernel.org>; Sun, 10 Aug 2025 22:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDF8B83429;
	Mon, 11 Aug 2025 00:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TTcg8f5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC3383438; Mon, 11 Aug 2025 00:27:10 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED21283423
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 00:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f248=2X=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754864826; bh=0rea7eb3lbo9vqK5wOMqOSgNdhUGOfvbkVkR6T+vhbM=;
 b=TTcg8f5HvRa190Tp+ZcChVZUKCpM8YF+rS4g2lehLQd48yr86EWPOxEOf2Qs3+k00WcHo8PMY
 c+AqIjfPMi6yPIp0ZH16SOTW3SZBcdYMxhyOGgXAp/F8NGbnY861umvLedDGpl2qYaWxW91Om+4
 vm7s8LLsWnLUprwByAY0/WWxAljb9SoKnMNfuqILePTbsASOMi3XJG/BFWkJIc+nL7SSf5zNOKp
 W8eD4ct6/Iayk34PHBGtXmaibZSeDA3AWb6lOgOlNYeUT4pIQzV0Wx4uaS5ZL/XJRG1WLmHTnMv
 ggH0zpA7D465vmYbYbfIXVyS60Hu3+QFM9lCxpH+y8Iw==
X-Forward-Email-ID: 68991cb4b34c1b14a67b38c8
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.denx.de
Subject: [PATCH v3 2/3] rockchip: rk3588-generic: Enable support for RK3582
Date: Sun, 10 Aug 2025 22:26:30 +0000
Message-ID: <20250810222644.4095072-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810222644.4095072-1-jonas@kwiboo.se>
References: <20250810222644.4095072-1-jonas@kwiboo.se>
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

Add Kconfig option OF_SYSTEM_SETUP=y to support booting boards with a
RK3582 SoC. CPU and GPU cores are failed based on ip-state and policy.

Tested on a ROCK 5C Lite v1.1:

  cpu-code: 35 82
  ip-state: 10 00 00 (otp)
  ip-state: 30 80 04 (policy)
  remove cpu-map cluster1
  rename cpu-map cluster2
  fail rkvdec1
  fail rkvenc1
  fail cpu cpu@400
  fail cpu cpu@500

and on a Radxa E52C:

  cpu-code: 35 82
  ip-state: 00 04 00 (otp)
  ip-state: c0 84 04 (policy)
  remove cpu-map cluster2
  fail rkvdec1
  fail rkvenc1
  fail cpu cpu@600
  fail cpu cpu@700

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: Update commit message to reflect updated policy
v2: Mention RK3582 in generic board device tree and documentation
---
 arch/arm/dts/rk3588-generic.dts  | 4 ++--
 configs/generic-rk3588_defconfig | 1 +
 doc/board/rockchip/rockchip.rst  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
index 6740f9866f17..04144e2ad128 100644
--- a/arch/arm/dts/rk3588-generic.dts
+++ b/arch/arm/dts/rk3588-generic.dts
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Minimal generic DT for RK3588S/RK3588 with eMMC, SD-card and USB OTG enabled
+ * Minimal generic DT for RK3582/RK3588S/RK3588 with eMMC, SD-card and USB OTG enabled
  */
 
 /dts-v1/;
 #include "rk3588s.dtsi"
 
 / {
-	model = "Generic RK3588S/RK3588";
+	model = "Generic RK3582/RK3588S/RK3588";
 	compatible = "rockchip,rk3588";
 
 	aliases {
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index dfa8efabe6be..7a8c176912e1 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 # CONFIG_BOOTMETH_VBE is not set
 CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 7a1385789c20..726eed4ea45b 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -145,7 +145,7 @@ List of mainline supported Rockchip boards:
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
      - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
      - FriendlyElec NanoPi R6S (nanopi-r6s-rk3588s)
-     - Generic RK3588S/RK3588 (generic-rk3588)
+     - Generic RK3582/RK3588S/RK3588 (generic-rk3588)
      - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
      - Indiedroid Nova (nova-rk3588s)
      - Khadas Edge2 (khadas-edge2-rk3588s)
-- 
2.50.1

