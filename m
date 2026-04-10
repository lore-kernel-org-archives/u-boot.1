Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC615F44863
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A39848421A;
	Fri, 10 Apr 2026 15:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Bg1+pWxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5AD883DC9; Fri, 10 Apr 2026 15:33:03 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191358419E
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:33:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d43e09de5so1109372f8f.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827980; x=1776432780;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M0AVVRgwMXO8ZVImV59tKU5ASeTJzbt6wSQg/q02AyI=;
 b=Bg1+pWxtXTgmhrlaVD3/aO0vz6t0stZoIoWjQM/6VSpoQ6cERdA2Ewl4vAY/ITpBZx
 MpsdijTAtyMqvErRoUZTfJdtPZ1asCo4dVh9WhsoM87txOV7IQDpgOa7/vcFMtimdNi1
 m/Iv8BfWphYrJyRE9bxu05NEvWooaSwOSJP/XaxlLwAwklXpbDiCNrzbpUQxl44BIFyP
 MhFidUZ3FT5TYQQDr42NMvLRWyxnHIsr8bk/SuZ7fEg9F4bbgm89MQ3sS/D7sm3W8qM5
 4PqjBMyFkQGm5juie6qMnvPFLgQMTSd6hLlBA4GIEazmrs4bgoyIN3HG2yylDvteuueC
 F9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827980; x=1776432780;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M0AVVRgwMXO8ZVImV59tKU5ASeTJzbt6wSQg/q02AyI=;
 b=bvGjyZrk1V+SnqdIiEFS6JFNgCw8h5lwJIxCGgtstwSoQ6Y/VkAPHOb3cPJ96xwOC0
 6vN3QJdM6aoTsKhXYOQDQfTeYSmu3OPWjsRa2hP+UotkNdikkTMvlM7/e8AHMLcRZNAc
 W4uAwO5qyR20OSHaJMUSaHaonwxAnVtYHfYUbYZcxOCU/VlXHZaeVe1VntIjyh9F8g9m
 kO+rtyfm9IvlaGmqiXea1/1dMeBkeTN2KzoXLDElOnO49dPyw8npl6F7+tf2VC2FgcdL
 OEx1Xio3KWfnzlXLFl23L53E8KHXyxUexkd5mhUscYxh4kS6L1t5w2RRTTHcURA4tOb1
 YpMQ==
X-Gm-Message-State: AOJu0Yz+N2Z74kjRYUBR10uyYMJd8KpeN/YGRpL2e67S7O2vu9RIHMB0
 b6G+aQqaP0iUS0yji7M7I9E6G3Owh3tYsUsRVgfr+WKs3larGPo0vWAEKYsRuJ3L3kc=
X-Gm-Gg: AeBDieu7OcJi+iybwTtNAV53447TWVZFVqyZkUrunikMl2lk6RhChAfZ4TjZ1EvwAY+
 TSThbgTlFYtUyAX45dFeJWU/UMYclmMUW3IaH9X2Ieo7ogmMZjtSorhqUs/etJx0UQJFXAm2MgT
 iDMfGzwt4uxtfBv89sGw3DGgspmtekVNr8Rsi+1gcLR7UVYsPyEA9WKM29J/TNje34StZJbigx6
 QBVh9EpH6ngOOUQkDDx2osvTCoEpbcMXhOl+bZRbFUopQt3xLDHGovYgmFnXc4jiPfUrz7W1HRq
 VVvVseHMZeNu9y7fADPYEvB6EWRPUJwavrNBIvyRGKbDyYALSAKuguUQyNQ+J8RnEWwrxf7pNSW
 9zjARpcdHaMx1A1hs6FlQBCFPkWFX+tjKh5KmEYps3MN+d+4b4ejYnspTYD5xSuCWVSL4+O+Slk
 VIcgYfoiLb4f6tdb8zIc1+
X-Received: by 2002:a05:6000:2301:b0:43d:e31:68d1 with SMTP id
 ffacd0b85a97d-43d6428e2damr4564220f8f.21.1775827980497; 
 Fri, 10 Apr 2026 06:33:00 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e468d0sm7451364f8f.18.2026.04.10.06.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:33:00 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:48 +0200
Subject: [PATCH v5 08/12] arm: dts: am335x-boneblack-u-boot: Add lcdc to
 all boot phases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-8-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=741; i=msp@baylibre.com;
 h=from:subject:message-id; bh=qvek2SMvCpKdU83XcTliAlVyZ+xVpBwz/HfiBZIZ24Q=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbv589d3cUy5gQ/G+3+78ds0VuMX+fvtz4Wb8Xm4vV2
 R3umTf2dZSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBEVjcy/K+wy7V58UWZ8+Jc
 9/Qfqqx/yia8+uy+RrZ59ce8l7O2y7xmZFi0ZvH3+582vFCfq7tj3stZym0vo0+6bdL/Nv3gK49
 lF58yAwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

This is required for am335x to boot correctly.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 arch/arm/dts/am335x-boneblack-u-boot.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/dts/am335x-boneblack-u-boot.dtsi b/arch/arm/dts/am335x-boneblack-u-boot.dtsi
index e2afc77d9edc539323c73dee03511a9cd62d8ca8..366375bf446c4c49a12d210c1a24f1db2881f1c3 100644
--- a/arch/arm/dts/am335x-boneblack-u-boot.dtsi
+++ b/arch/arm/dts/am335x-boneblack-u-boot.dtsi
@@ -4,3 +4,14 @@
  */
 
 #include "am335x-bone-common-u-boot.dtsi"
+
+&l4_per {
+	segment@300000 {
+		target-module@e000 {
+			bootph-all;
+			lcdc: lcdc@0 {
+				bootph-all;
+			};
+		};
+	};
+};

-- 
2.53.0

