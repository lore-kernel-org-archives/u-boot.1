Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54ABCFD376
	for <u-boot@archiver.kernel.org>; Sun, 30 Nov 2025 21:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2138183956;
	Sun, 30 Nov 2025 22:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABC7E83956; Sun, 30 Nov 2025 22:46:16 +0100 (CET)
Received: from smtp.gentoo.org (dev.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD1A8312A
 for <u-boot@lists.denx.de>; Sun, 30 Nov 2025 22:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Received: from ofovo.local (unknown [116.232.18.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: dlan)
 by smtp.gentoo.org (Postfix) with ESMTPSA id C253A340F39;
 Sun, 30 Nov 2025 21:46:10 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 30 Nov 2025 21:45:12 +0000
Subject: [PATCH v2 03/10] sunxi: a733: uart: setup serial console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251130-01-a733-soc-support-v2-3-18bdd4376fad@gentoo.org>
References: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
In-Reply-To: <20251130-01-a733-soc-support-v2-0-18bdd4376fad@gentoo.org>
To: u-boot@lists.denx.de
Cc: linux-sunxi@lists.linux.dev, Andre Przywara <andre.przywara@arm.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=twLD1/GQXwXfnC89AnDWfhGb5WKizTT4jM1M5ct4ciQ=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBpLLr/pj/xnw7wboAfcMhD2FapvoKsTyYfVINsn
 53jufaf592JApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCaSy6/18UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277biaD/9GQxglQvyHlXbJZt
 hDf3+AaVC8jzIJVPLiV9xfoPOpjYvj5SH91TC98aVd7h1MYZqO+mcZjfR4EjxWEE/pyxEEuTmpX
 iPCjkmABal6SX2Fc2pS1VNybG/QKRV750d1Ku32WssSoDM9vvUWtpWXj5I8kHMQawlj8vRZBwat
 3AhF4BKZgtTXZka1CsXYHqGQPV7HiW2ffj+TECGj/FgIo9nBvCo9oYPExhgQd2iY6bAyicmQL9l
 +Uj2ltTY+PUgAzmG0SK/Qb6mfL2WRJmAuqY+mhuKPh7WEgkBHYwMnA1e6Mw1utMAVcXUuaWe/RE
 zg0bGvH17DJ4fIegX71GolLiRhmEG2kOhe3m724tR2HK9iDkuZ5kCHjy3NSdOcldpxbrMhyL5Cu
 +0fDayD6Saimm6oAVzCgAwAjCI++2Ad82HimpqKDu7oB6XGOEk5cJbKwla8TXut97iyi8gW4Oqx
 LIYsTP+sZ5hlvQTkjbTMbmu9ZIBDl0JJX3r2KQqS94ZKrv1weZnlSILkXH3LojTU88JrjfEpUXS
 kdCMRMvNeX3DMJFl5ctK3v2FWIs5VvEDJ8R7yLibhAV2Hd1+tGD/aKxX2Xv3a+vxCAL7p3Y3VLf
 UgTGtsQTn+hA7xGkgghO3NybV8cmiFl4E//6E+4+1n2vKnyYVXLiJ85qc4nbhM5uKxww==
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
 arch/arm/mach-sunxi/board.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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

