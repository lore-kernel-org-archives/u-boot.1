Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC943CD3436
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A21FD83CF2;
	Wed, 12 Nov 2025 18:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C40A83CF2; Wed, 12 Nov 2025 18:48:53 +0100 (CET)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 572C883D7D
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d69r30qFMz9jx;
 Wed, 12 Nov 2025 18:48:51 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d69r21n0sztCK; Wed, 12 Nov 2025 18:48:50 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Nov 2025 18:48:16 +0100
Subject: [PATCH 11/11] doc: remove u-boot,boot-led and u-boot,error-led
 from "binding"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-led-old-dt-v1-11-2892d49517db@cherry.de>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
In-Reply-To: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
To: Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Klaus Goger <klaus.goger@cherry.de>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

We're aiming to reduce the amount of U-Boot-specific and out-of-spec
Device Tree additions.

Those two properties haven't been doing anything for a long time
already, except when read by board files manually. This is still the
case for STM32 boards but those will be migrated in the near future
according to their maintainer. In any case, let's not encourage people
to add either of these properties to new or existing Device Trees and
remove it from the bindings.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/device-tree-bindings/config.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/doc/device-tree-bindings/config.txt b/doc/device-tree-bindings/config.txt
index fffb69e75de..3756f57bf44 100644
--- a/doc/device-tree-bindings/config.txt
+++ b/doc/device-tree-bindings/config.txt
@@ -26,11 +26,6 @@ bootdelay (int)
 	images is being packed for testing or a user holds down a button, it may
 	allow a delay, but disable it for production.
 
-u-boot,boot-led (string)
-u-boot,error-led (string)
-	This is used to specify the label for an LED to indicate an error and
-	a successful boot, on supported hardware.
-
 bootsecure (int)
 	Indicates that U-Boot should use secure_boot_cmd() to run commands,
 	rather than the normal CLI. This can be used in production images, to

-- 
2.51.1

