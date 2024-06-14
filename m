Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD5CC27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 16:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1C6889E9;
	Fri, 14 Jun 2024 18:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77CFD88A26; Fri, 14 Jun 2024 18:54:36 +0200 (CEST)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [185.125.25.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B2488A03
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 18:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W153Y1vLBzhvC;
 Fri, 14 Jun 2024 18:54:33 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W153X591GzKDG; Fri, 14 Jun 2024 18:54:32 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 14 Jun 2024 18:54:14 +0200
Subject: [PATCH next 3/3] rockchip: ringneck-px30: enable IO domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-px30-io-domain-v1-3-9552966d3911@cherry.de>
References: <20240614-px30-io-domain-v1-0-9552966d3911@cherry.de>
In-Reply-To: <20240614-px30-io-domain-v1-0-9552966d3911@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
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

Enable the IO domain on Ringneck. Based on the current HW design, this
should do nothing else than making sure vccio6 iodomain is controlled by
the GRF and not GPIO0B6.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/ringneck-px30_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index e7594b7a67b..52a4c9710a9 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -80,6 +80,7 @@ CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
 CONFIG_ROCKCHIP_OTP=y
+CONFIG_ROCKCHIP_IODOMAIN=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y

-- 
2.45.2

