Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAC5D2C122
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B71891C7;
	Tue,  5 Nov 2024 16:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 733CB8900E; Tue,  5 Nov 2024 16:36:58 +0100 (CET)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85ABC8915F
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XjXWX12cjzZ2j;
 Tue,  5 Nov 2024 16:36:56 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4XjXWW3SBdzNb2; Tue,  5 Nov 2024 16:36:55 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 05 Nov 2024 16:36:32 +0100
Subject: [PATCH next 1/5] pinctrl: rockchip: allow to build for TPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-rk3399-sysreset-gpio-tpl-v1-1-12caff07a4e4@cherry.de>
References: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
In-Reply-To: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Paul Kocialkowski <paulk@sys-base.io>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

A later commit will make use of the pinctrl driver in TPL so let's add
the ability to build the Rockchip pinctrl driver in TPL.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/pinctrl/Kconfig          | 8 ++++++++
 drivers/pinctrl/rockchip/Kconfig | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index a1d53cfbdbed5ef1030fff04715e1436f167554b..cff7c3ef45b1c7c29017a4512d4970bce4bac26b 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -127,6 +127,14 @@ config SPL_PINCTRL_GENERIC
 	  This option is an SPL-variant of the PINCTRL_GENERIC option.
 	  See the help of PINCTRL_GENERIC for details.
 
+config TPL_PINCTRL_GENERIC
+	bool "Support generic pin controllers in TPL"
+	depends on TPL_PINCTRL_FULL
+	default y
+	help
+	  This option is an TPL-variant of the PINCTRL_GENERIC option.
+	  See the help of PINCTRL_GENERIC for details.
+
 config SPL_PINMUX
 	bool "Support pin multiplexing controllers in SPL"
 	depends on SPL_PINCTRL_GENERIC
diff --git a/drivers/pinctrl/rockchip/Kconfig b/drivers/pinctrl/rockchip/Kconfig
index dc4ba34ae5d581be76786fd05d679d26397fd467..6ad6b189715cee20f0e570d93b9b871e5acb99c3 100644
--- a/drivers/pinctrl/rockchip/Kconfig
+++ b/drivers/pinctrl/rockchip/Kconfig
@@ -14,4 +14,11 @@ config SPL_PINCTRL_ROCKCHIP
 	help
 	  This option is an SPL-variant of the PINCTRL_ROCKCHIP option.
 
+config TPL_PINCTRL_ROCKCHIP
+	bool "Support Rockchip pin controllers in TPL"
+	depends on ARCH_ROCKCHIP && TPL_PINCTRL_GENERIC
+	default y
+	help
+	  This option is an TPL-variant of the PINCTRL_ROCKCHIP option.
+
 endif

-- 
2.47.0

