Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D18C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 11:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63AB18883C;
	Fri, 24 May 2024 13:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3B9D88442; Fri, 24 May 2024 13:47:05 +0200 (CEST)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787FE88676
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vm3DL0ClqzwVT;
 Fri, 24 May 2024 13:46:58 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vm3DK3yv4zDjM; Fri, 24 May 2024 13:46:57 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 24 May 2024 13:46:37 +0200
Subject: [PATCH 3/3] rockchip: theobroma: update URLs to point to CHERRY
 website
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-tsd-to-cherry-v1-3-3002bed55f19@cherry.de>
References: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
In-Reply-To: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
To: Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
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

Most of the current URLs should be redirected but some aren't already,
so let's anticipate more IT hiccups by migrating to new URLs.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS | 4 ++--
 board/theobroma-systems/puma_rk3399/MAINTAINERS   | 4 ++--
 board/theobroma-systems/ringneck_px30/MAINTAINERS | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/board/theobroma-systems/jaguar_rk3588/MAINTAINERS b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
index d14edadefe2..ab7051b427f 100644
--- a/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
+++ b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
@@ -9,5 +9,5 @@ F:	doc/board/theobroma-systems/
 F:	include/configs/jaguar_rk3588.h
 F:	arch/arm/dts/rk3588-jaguar*
 F:	configs/jaguar-rk3588_defconfig
-W:	https://theobroma-systems.com/product/jaguar-sbc-rk3588/
-T:	git git://git.theobroma-systems.com/jaguar-u-boot.git
+W:	https://embedded.cherry.de/product/jaguar-sbc-rk3588/
+T:	git git://git.embedded.cherry.de/jaguar-u-boot.git
diff --git a/board/theobroma-systems/puma_rk3399/MAINTAINERS b/board/theobroma-systems/puma_rk3399/MAINTAINERS
index 2b409f16963..2536e348887 100644
--- a/board/theobroma-systems/puma_rk3399/MAINTAINERS
+++ b/board/theobroma-systems/puma_rk3399/MAINTAINERS
@@ -8,5 +8,5 @@ F:	doc/board/theobroma-systems
 F:	include/configs/puma_rk3399.h
 F:	arch/arm/dts/rk3399-puma*
 F:	configs/puma-rk3399_defconfig
-W:	https://www.theobroma-systems.com/rk3399-q7/tech-specs
-T:	git git://git.theobroma-systems.com/puma-u-boot.git
+W:	https://embedded.cherry.de/product/puma-som-rk3399-q7/
+T:	git git://git.embedded.cherry.de/puma-u-boot.git
diff --git a/board/theobroma-systems/ringneck_px30/MAINTAINERS b/board/theobroma-systems/ringneck_px30/MAINTAINERS
index bf4bc452823..2aff91f4207 100644
--- a/board/theobroma-systems/ringneck_px30/MAINTAINERS
+++ b/board/theobroma-systems/ringneck_px30/MAINTAINERS
@@ -8,4 +8,5 @@ F:	doc/board/theobroma-systems/
 F:	include/configs/ringneck_px30.h
 F:	arch/arm/dts/px30-ringneck*
 F:	configs/ringneck-px30_defconfig
-W:	https://theobroma-systems.com/product/ringneck-som-px30-uq7/
+W:	https://embedded.cherry.de/product/ringneck-som-px30-uq7/
+T:	git git://git.embedded.cherry.de/ringneck-u-boot.git

-- 
2.45.1

