Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1829CCD19A
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 14:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 036C383AEE;
	Sun, 16 Nov 2025 15:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C0D9839A8; Sun, 16 Nov 2025 15:45:10 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10BD983AD1
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 15:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.48.119])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id 74825335D6A;
 Sun, 16 Nov 2025 14:45:03 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 16 Nov 2025 14:43:55 +0000
Subject: [PATCH 04/11] sunxi: a733: uart: setup serial console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-01-a733-soc-support-v1-4-fb4c8db78e75@gentoo.org>
References: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
In-Reply-To: <20251116-01-a733-soc-support-v1-0-fb4c8db78e75@gentoo.org>
To: u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=HEY6ljA+49V9GU+G/RvNk4lGqxDJ/xM9kA0o5do2Scw=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpGeNC2ZUDth9uXhwRvLRKcpv0xukyyDmH8nX/c
 QVZX3B2ksGJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaRnjQl8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277YN/EACDbMd46rzmu3JfET
 fYlUQV0XqxN/RfQGlJvlauJjiz0CEG/y4GcEOC4WoF7i4G7HgWnyGGmtNXa8zP3RlrBh7lF4Vzk
 qfRF1rB7tmN525adkY+btJywTNsWj1VXlvEaiH8mwtSnGQzdUK86GtLDdlKXFA6G3rIezU1tL6m
 G9FZm0468Kh7zzQxfRvyQ5fscqOQm7eujZzM+nxDhuNhhXo0hBjk/ahafl9Sba3lAlxmt+/yvxd
 05wvn7apI9fGlBop5Fs/pp88w7ExheAA5ulk5qtVhtLXCrK8gvbgh//Ir0tlczldJAxVxdvTpoE
 yg+WQMeNYwZto2j4AWhHgXbdqqL6YE0TdMelZSX349DStjgLA4cNXz1fGhamt85dxML5F7FZ9/k
 AplR4RIX6b0/9jwZNC4F/yhqpYSuQN9jU7J4FftoLSBNJzT2KVj6zJnAkN/0jJJuv7HmiV8Yo09
 rO3IOiUkIUCCnYSp9LQAhwxvVXJ76ZrjMu7Txxyq76QVSqVVtpFmhffTAfTu1TFliBDfM7s0ZUt
 ft3rsEUGATlSNFJW9N+zx/VCSnomfHZGcJmgiTU1D+HBmV57bKNoYvddvQo1fep4snINyGSTtcV
 WwAgx/zsBwacphH3ea7fCYsW4cIaQHXT7F+s7FnALzMNUFKnfKAejqe6LX9auoWqlfNw==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
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

Setup correct UART base address for A733 SoC.

According to Allwinner's board design, A733 SoC use the UART0 port
for serial console, so config PB9-10 pins to setup pinmux.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 arch/arm/include/asm/arch-sunxi/serial.h | 2 +-
 arch/arm/mach-sunxi/board.c              | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/serial.h b/arch/arm/include/asm/arch-sunxi/serial.h
index 9386287b65e..57b62ac8c7e 100644
--- a/arch/arm/include/asm/arch-sunxi/serial.h
+++ b/arch/arm/include/asm/arch-sunxi/serial.h
@@ -17,7 +17,7 @@
 #elif defined(CONFIG_MACH_SUNIV)
 #define SUNXI_UART0_BASE		0x01c25000
 #define SUNXI_R_UART_BASE		0
-#elif defined(CONFIG_SUNXI_GEN_NCAT2)
+#elif defined(CONFIG_SUNXI_GEN_NCAT2) || defined(CONFIG_MACH_SUN60I_A733)
 #define SUNXI_UART0_BASE		0x02500000
 #define SUNXI_R_UART_BASE		0		// 0x07080000 (?>
 #else
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10f92..72c9fc413cb 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -141,7 +141,8 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN50I_H616_GPH_UART0);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN50I_H616_GPH_UART0);
 	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
-#elif CONFIG_CONS_INDEX == 1 && defined(CONFIG_MACH_SUN55I_A523)
+#elif CONFIG_CONS_INDEX == 1 && (defined(CONFIG_MACH_SUN55I_A523) || \
+				defined(CONFIG_MACH_SUN60I_A733))
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), 2);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), 2);
 	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);

-- 
2.51.2

