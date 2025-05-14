Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930E2C3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 16:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9903A82A59;
	Wed, 14 May 2025 18:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0731982A25; Wed, 14 May 2025 18:18:40 +0200 (CEST)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::1908])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 195EB80050
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 18:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZyJRx5f5ZzssL;
 Wed, 14 May 2025 18:18:37 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4ZyJRx1GkhzVM9; Wed, 14 May 2025 18:18:37 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 14 May 2025 18:18:16 +0200
Subject: [PATCH 4/4] configs: puma-rk3399: enable exFAT support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-exfat-tsd-v1-4-83c10d714da3@cherry.de>
References: <20250514-exfat-tsd-v1-0-83c10d714da3@cherry.de>
In-Reply-To: <20250514-exfat-tsd-v1-0-83c10d714da3@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
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

Our upcoming Mass Flasher solution will be storing boot artifacts on an
exFAT partition so enable its support.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/puma-rk3399_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 95ed6eea953d4564eaa2777b282d31cf5dd77c89..4e8cee06775aa020a14c656ce2f810f38354613b 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -104,4 +104,5 @@ CONFIG_USB_ETHER_ASIX88179=y
 CONFIG_USB_ETHER_MCS7830=y
 CONFIG_USB_ETHER_RTL8152=y
 CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_FS_EXFAT=y
 CONFIG_ERRNO_STR=y

-- 
2.49.0

