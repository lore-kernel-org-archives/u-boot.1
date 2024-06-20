Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC77C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 10:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77CA888527;
	Thu, 20 Jun 2024 12:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 108608853B; Thu, 20 Jun 2024 12:25:04 +0200 (CEST)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8faa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCB788521
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 12:25:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W4c7K2FKTzjPZ;
 Thu, 20 Jun 2024 12:25:01 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W4c7J3lJKzn12; Thu, 20 Jun 2024 12:25:00 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 20 Jun 2024 12:24:50 +0200
Subject: [PATCH next 1/2] rockchip: theobroma-systems: migrate git URLs to
 HTTPS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-tsd-http-git-clone-v1-1-666e8d6a8949@cherry.de>
References: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
In-Reply-To: <20240620-tsd-http-git-clone-v1-0-666e8d6a8949@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.0
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

It turns out only Puma had a working git:// URL. Though that is now
fixed, having HTTPS URLs make it easier to directly reach our cgit
webserver to check what's up without having to change the URL manually.

Depending on your terminal settings, this also makes it possible to
open the link from it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS | 2 +-
 board/theobroma-systems/puma_rk3399/MAINTAINERS   | 2 +-
 board/theobroma-systems/ringneck_px30/MAINTAINERS | 2 +-
 board/theobroma-systems/tiger_rk3588/MAINTAINERS  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/theobroma-systems/jaguar_rk3588/MAINTAINERS b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
index ab7051b427f..370d0a1272a 100644
--- a/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
+++ b/board/theobroma-systems/jaguar_rk3588/MAINTAINERS
@@ -10,4 +10,4 @@ F:	include/configs/jaguar_rk3588.h
 F:	arch/arm/dts/rk3588-jaguar*
 F:	configs/jaguar-rk3588_defconfig
 W:	https://embedded.cherry.de/product/jaguar-sbc-rk3588/
-T:	git git://git.embedded.cherry.de/jaguar-u-boot.git
+T:	git https://git.embedded.cherry.de/jaguar-u-boot.git
diff --git a/board/theobroma-systems/puma_rk3399/MAINTAINERS b/board/theobroma-systems/puma_rk3399/MAINTAINERS
index 2536e348887..1a5b78bf535 100644
--- a/board/theobroma-systems/puma_rk3399/MAINTAINERS
+++ b/board/theobroma-systems/puma_rk3399/MAINTAINERS
@@ -9,4 +9,4 @@ F:	include/configs/puma_rk3399.h
 F:	arch/arm/dts/rk3399-puma*
 F:	configs/puma-rk3399_defconfig
 W:	https://embedded.cherry.de/product/puma-som-rk3399-q7/
-T:	git git://git.embedded.cherry.de/puma-u-boot.git
+T:	git https://git.embedded.cherry.de/puma-u-boot.git
diff --git a/board/theobroma-systems/ringneck_px30/MAINTAINERS b/board/theobroma-systems/ringneck_px30/MAINTAINERS
index 2aff91f4207..4d4544a2a3e 100644
--- a/board/theobroma-systems/ringneck_px30/MAINTAINERS
+++ b/board/theobroma-systems/ringneck_px30/MAINTAINERS
@@ -9,4 +9,4 @@ F:	include/configs/ringneck_px30.h
 F:	arch/arm/dts/px30-ringneck*
 F:	configs/ringneck-px30_defconfig
 W:	https://embedded.cherry.de/product/ringneck-som-px30-uq7/
-T:	git git://git.embedded.cherry.de/ringneck-u-boot.git
+T:	git https://git.embedded.cherry.de/ringneck-u-boot.git
diff --git a/board/theobroma-systems/tiger_rk3588/MAINTAINERS b/board/theobroma-systems/tiger_rk3588/MAINTAINERS
index e5aab4b29f3..a95135616ad 100644
--- a/board/theobroma-systems/tiger_rk3588/MAINTAINERS
+++ b/board/theobroma-systems/tiger_rk3588/MAINTAINERS
@@ -10,4 +10,4 @@ F:	include/configs/tiger_rk3588.h
 F:	arch/arm/dts/rk3588-tiger*
 F:	configs/tiger-rk3588_defconfig
 W:	https://embedded.cherry.de/product/tiger-som-rk3588-q7/
-T:	git git://git.embedded.cherry.de/tiger-u-boot.git
+T:	git https://git.embedded.cherry.de/tiger-u-boot.git

-- 
2.45.2

