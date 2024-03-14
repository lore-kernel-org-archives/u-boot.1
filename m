Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB81C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 09:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6339987FAA;
	Thu, 14 Mar 2024 10:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE6186564; Thu, 14 Mar 2024 10:36:30 +0100 (CET)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [45.157.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD2F86564
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 10:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TwMhX2vw5zMpnrt;
 Thu, 14 Mar 2024 10:36:28 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TwMhW3jSkzy1c; Thu, 14 Mar 2024 10:36:27 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 14 Mar 2024 10:36:16 +0100
Subject: [PATCH v4 03/16] regulator: rk8xx: fix SWITCH enable on RK809
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-rk3588-saradc-v4-3-31cb41ff7362@theobroma-systems.com>
References: <20240314-rk3588-saradc-v4-0-31cb41ff7362@theobroma-systems.com>
In-Reply-To: <20240314-rk3588-saradc-v4-0-31cb41ff7362@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 William Wu <william.wu@rock-chips.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
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

From: William Wu <william.wu@rock-chips.com>

On RK809 in PMIC_POWER_ENX registers, in order to set or clear a bit N,
the bit at offset N + 4 needs to be set otherwise nothing is done.

This fixes the inability to modify the SWITCH state on RK809.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: William Wu <william.wu@rock-chips.com>
[reworded commit log]
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/power/regulator/rk8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 97d73ac95e0..e905df3a800 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -901,7 +901,7 @@ static int switch_set_enable(struct udevice *dev, bool enable)
 	case RK809_ID:
 		mask = (1 << (sw + 2)) | (1 << (sw + 6));
 		ret = pmic_clrsetbits(dev->parent, RK817_POWER_EN(3), mask,
-				      enable ? mask : 0);
+				      enable ? mask : (1 << (sw + 6)));
 		break;
 	case RK818_ID:
 		mask = 1 << 6;

-- 
2.44.0

