Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C573FC87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 11:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC89482E34;
	Wed, 30 Jul 2025 13:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 536D881E06; Wed, 30 Jul 2025 13:11:14 +0200 (CEST)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A431382E34
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 13:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bsTzd2T1hzX3x;
 Wed, 30 Jul 2025 13:11:09 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bsTzc4QwgzkX; Wed, 30 Jul 2025 13:11:08 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 30 Jul 2025 13:10:19 +0200
Subject: [PATCH 3/6] dt-bindings: usb: cypress,hx3: Add support for all
 variants
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-puma-usb-cypress-v1-3-b1c203c733f9@cherry.de>
References: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
In-Reply-To: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org, 
 "Rob Herring (Arm)" <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>
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

From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

The Cypress HX3 hubs use different default PID value depending
on the variant. Update compatibles list.
Becasuse all hub variants use the same driver data, allow the
dt node to have two compatibles: leftmost which matches the HW
exactly, and the second one as fallback.

Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family")
Cc: stable@vger.kernel.org # 6.6
Cc: stable@vger.kernel.org # Backport of the patch ("dt-bindings: usb: usb-device: relax compatible pattern to a contains") from list: https://lore.kernel.org/linux-usb/20250418-dt-binding-usb-device-compatibles-v2-1-b3029f14e800@cherry.de/
Cc: stable@vger.kernel.org # Backport of the patch in this series fixing product ID in onboard_dev_id_table in drivers/usb/misc/onboard_usb_dev.c driver
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Link: https://lore.kernel.org/r/20250425-onboard_usb_dev-v2-2-4a76a474a010@thaumatec.com
[taken with Greg's blessing]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 1ad4b5a7de16806afc1aeaf012337e62af04e001 ]

(cherry picked from commit 53aacaed0ad140b017c803d9777473c6c62f5352)
---
 dts/upstream/Bindings/usb/cypress,hx3.yaml | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/dts/upstream/Bindings/usb/cypress,hx3.yaml b/dts/upstream/Bindings/usb/cypress,hx3.yaml
index 1033b7a4b8f953424cc3d31d561992c17f3594b2..d6eac1213228d2acb50ebc959d1ff15134c5a91c 100644
--- a/dts/upstream/Bindings/usb/cypress,hx3.yaml
+++ b/dts/upstream/Bindings/usb/cypress,hx3.yaml
@@ -14,9 +14,22 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - usb4b4,6504
-      - usb4b4,6506
+    oneOf:
+      - enum:
+          - usb4b4,6504
+          - usb4b4,6506
+      - items:
+          - enum:
+              - usb4b4,6500
+              - usb4b4,6508
+          - const: usb4b4,6504
+      - items:
+          - enum:
+              - usb4b4,6502
+              - usb4b4,6503
+              - usb4b4,6507
+              - usb4b4,650a
+          - const: usb4b4,6506
 
   reg: true
 

-- 
2.50.1

