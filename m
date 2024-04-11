Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2006ECD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 05:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC6ED881D7;
	Thu, 11 Apr 2024 07:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="uvtU2G11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A4E881F4; Thu, 11 Apr 2024 07:17:17 +0200 (CEST)
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E3087F52
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 07:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712812635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5uStB7++bBThNYvnj1YA7zfk8Qxucygl9HpI7BwFnsk=;
 b=uvtU2G117yYm/pLRN+GcnIh6HWVlMuK+s3w74QQ3qLLmjIE33sjZzedRlZ4l0Xoe/TNh7J
 ib7COcJiuUJkebscZ9Ta2/tMSbShWiqAzpAZLWvBDu39Z7tA/CvYDy1fvqIweL8Srw9Ih9
 vu/bMR6AGogBVrRxnO9QrftIpeeeOUXJ84e978MqxfIJ+yC2jr2ikqH9YLXUPf41B9y/Qg
 XtyHDKtAf36FtdF5sa9cdEgl5l6Y4geb9PqkCQ9IAcR8nBwS2h9LzZav9yjNawdjAm+HI/
 Deqx7SKmoEj2khIVEzE6srQVuua+3rfu0DsCgDqK5A8hASoQyOurNusDaqbyhw==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 15:14:16 +1000
Subject: [PATCH 2/2] sunxi: Support UART2 on the T113
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-t113serial-v1-2-41ff858a1235@jookia.org>
References: <20240411-t113serial-v1-0-41ff858a1235@jookia.org>
In-Reply-To: <20240411-t113serial-v1-0-41ff858a1235@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712812478; l=1427;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=UCkGo8K3i7+lyNDtP9C/5IK7SiwLDMKJvQ/l1rRUaMg=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABABOqHwirLWqKqIQj++r5C9Jc
 a66BdKdCSXTuXg7hHGvdpD/BLqeDnc14R0lg0rlVyJTh3dbj3Cc7FOJ1mMNvPBAUAAOmy
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

The T113 supports UART2 on PD1 and PD2. Add it as an option.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/mach-sunxi/board.c | 4 ++++
 include/sunxi_gpio.h        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index f5da50b43a..4176543cd9 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -166,6 +166,10 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(0), SUN8I_GPB_UART2);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(1), SUN8I_GPB_UART2);
 	sunxi_gpio_set_pull(SUNXI_GPB(1), SUNXI_GPIO_PULL_UP);
+#elif CONFIG_CONS_INDEX == 3 && defined(CONFIG_MACH_SUN8I_R528)
+	sunxi_gpio_set_cfgpin(SUNXI_GPD(1), SUN8I_T113_GPD_UART2);
+	sunxi_gpio_set_cfgpin(SUNXI_GPD(2), SUN8I_T113_GPD_UART2);
+	sunxi_gpio_set_pull(SUNXI_GPD(2), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 4 && defined(CONFIG_MACH_SUN8I_R528)
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(6), 7);
 	sunxi_gpio_set_cfgpin(SUNXI_GPB(7), 7);
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index db3742c039..88ab1d192f 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -120,6 +120,7 @@ enum sunxi_gpio_number {
 #define SUN8I_A83T_GPB_UART0	2
 #define SUN8I_V3S_GPB_UART0	3
 #define SUN50I_GPB_UART0	4
+#define SUN8I_T113_GPD_UART2	5
 
 #define SUNXI_GPC_NAND		2
 #define SUNXI_GPC_SPI0		3

-- 
2.44.0

