Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87405C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 09:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0DA87CE8;
	Fri, 23 Feb 2024 10:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE742871C7; Fri, 23 Feb 2024 10:06:25 +0100 (CET)
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::190c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A458887BC9
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 10:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Th3yr26KTzMrnZD;
 Fri, 23 Feb 2024 10:06:12 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Th3yq59wFz7st; Fri, 23 Feb 2024 10:06:11 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 23 Feb 2024 10:06:03 +0100
Subject: [PATCH v2 16/16] rockchip: boot_mode: fix rockchip_dnl_key_pressed
 requiring ADC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-rk3588-saradc-v2-16-11c046b7e94a@theobroma-systems.com>
References: <20240223-rk3588-saradc-v2-0-11c046b7e94a@theobroma-systems.com>
In-Reply-To: <20240223-rk3588-saradc-v2-0-11c046b7e94a@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

ADC support is implied by the Rockchip arch Kconfig but that means it
should be possible to disable ADC support and still be able to build.

However the weak implementation of rockchip_dnl_key_pressed() currently
blindly use functions from the ADC subsystem which do not exist when ADC
is not enabled, failing the build.

Therefore, let's encapsulate this logic with a check on the ADC symbol
being selected.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/boot_mode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-rockchip/boot_mode.c b/arch/arm/mach-rockchip/boot_mode.c
index eb8f65ae4e9..f9be396aa55 100644
--- a/arch/arm/mach-rockchip/boot_mode.c
+++ b/arch/arm/mach-rockchip/boot_mode.c
@@ -40,6 +40,7 @@ void set_back_to_bootrom_dnl_flag(void)
 
 __weak int rockchip_dnl_key_pressed(void)
 {
+#if CONFIG_IS_ENABLED(ADC)
 	unsigned int val;
 	struct udevice *dev;
 	struct uclass *uc;
@@ -69,6 +70,9 @@ __weak int rockchip_dnl_key_pressed(void)
 		return true;
 	else
 		return false;
+#else
+	return false;
+#endif
 }
 
 void rockchip_dnl_mode_check(void)

-- 
2.43.2

