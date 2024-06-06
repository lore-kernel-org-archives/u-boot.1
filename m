Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F39C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 08:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0C5E8839F;
	Thu,  6 Jun 2024 10:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0786288284; Thu,  6 Jun 2024 10:45:46 +0200 (CEST)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fa8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F1A888216
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 10:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VvybC0Rq5zMP4;
 Thu,  6 Jun 2024 10:45:43 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VvybB1wgQzDkW; Thu,  6 Jun 2024 10:45:42 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 06 Jun 2024 10:45:32 +0200
Subject: [PATCH next v3 2/6] rockchip: rk3399-puma: remove default value
 from defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-misc-tsd-v3-2-728d721c464a@cherry.de>
References: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
In-Reply-To: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
To: Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
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

CONFIG_ENV_OFFSET already defaults to 0x3F8000, however it is stored in
lowercase hexdigits instead of uppercase like in the defconfig.

No change in behavior intended.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/puma-rk3399_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 34a0b575991..42819102d70 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -6,7 +6,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_SIZE=0x3000
-CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-puma-haikou"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y

-- 
2.45.2

