Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AEED78319
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 13:01:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE4C88B9F;
	Mon,  2 Dec 2024 14:01:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF26C89076; Mon,  2 Dec 2024 14:01:35 +0100 (CET)
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864C088A3C
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 14:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Y23nn0DB1zkbN;
 Mon,  2 Dec 2024 14:01:33 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Y23nm2Zxxz4Wg; Mon,  2 Dec 2024 14:01:32 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 02 Dec 2024 14:01:26 +0100
Subject: [PATCH] doc: board: theobroma-systems: fix feature list in
 introductions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-tsd-doc-fixup-v1-1-1c9bb6c7b1c9@cherry.de>
X-B4-Tracking: v=1; b=H4sIAKWvTWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIKFbUpyim5KfrJuWWVFaoGtukpZoYplmkpRsYqoE1FNQlAqUAJsXHVt
 bCwDGGEsHXwAAAA==
X-Change-ID: 20241202-tsd-doc-fixup-74fa49f4bc45
To: Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Board introductions have a feature list which isn't formatted properly
according to rST and is thus rendered incorrectly.

Fix this by adding the missing newlines in the appropriate places.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/theobroma-systems/puma_rk3399.rst  | 1 +
 doc/board/theobroma-systems/tiger_rk3588.rst | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/doc/board/theobroma-systems/puma_rk3399.rst b/doc/board/theobroma-systems/puma_rk3399.rst
index 5bc6385e451b73075ffd63994191721676ede8b0..a2a5e7bca4b90c7d85084c7e5dd8abb0d5108d4c 100644
--- a/doc/board/theobroma-systems/puma_rk3399.rst
+++ b/doc/board/theobroma-systems/puma_rk3399.rst
@@ -27,6 +27,7 @@ RK3399-Q7 features:
  * Camera: 2x CSI (one on the edge connector, one on the Q7 specified CSI ZIF)
  * NOR Flash: onboard SPI NOR
  * Companion Controller: onboard additional Cortex-M0 microcontroller
+
    * RTC
    * fan controller
    * CAN
diff --git a/doc/board/theobroma-systems/tiger_rk3588.rst b/doc/board/theobroma-systems/tiger_rk3588.rst
index a73eec7fb9b4dfdf8a2010b5b177959bd5b865c4..46112544c8241a286567146906e943f76bc9523a 100644
--- a/doc/board/theobroma-systems/tiger_rk3588.rst
+++ b/doc/board/theobroma-systems/tiger_rk3588.rst
@@ -8,6 +8,7 @@ connector) system-on-module from Theobroma Systems, featuring the
 Rockchip RK3588.
 
 It provides the following feature set:
+
  * up to 16GB LPDDR4x
  * on-module eMMC
  * SD card (on a baseboard) via edge connector
@@ -18,14 +19,20 @@ It provides the following feature set:
  * HDMI input over FPC connector
  * CAN
  * USB
+
    - 1x USB 3.0 dual-role (direct connection)
    - 2x USB 3.0 host + 1x USB 2.0 host
+
  * PCIe
+
    - 1x PCIe 2.1 Gen3, 4 lanes
    - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
+
  * on-module ATtiny816 companion controller, implementing:
+
    - low-power RTC functionality (ISL1208 emulation)
    - fan controller (AMC6821 emulation)
+
  * on-module Secure Element with Global Platform 2.2.1 compliant
    JavaCard environment
 

---
base-commit: 12fcb9825758a6ad84a22999eaaaa4a0c6a8ff94
change-id: 20241202-tsd-doc-fixup-74fa49f4bc45

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

