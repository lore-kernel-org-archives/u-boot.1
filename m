Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E7AD1953D
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 15:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96165840CF;
	Tue, 27 Jan 2026 16:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P7fqIc3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 162628341A; Tue, 27 Jan 2026 16:04:17 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47AC1840CF
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 16:04:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1CD7F60133;
 Tue, 27 Jan 2026 15:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF41C116D0;
 Tue, 27 Jan 2026 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769526252;
 bh=iAxBkkN70V8CpOqES8FYjB6nNMSA1BDeDMi2f22m/UU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P7fqIc3DBIfqJR0ClbfzODEaqvZXGiUJl5Y2ONYao/KMsMpl6esxEbpnzL70T5Qqo
 p37dpHxCtuWsSYWsFDab+SWcBD5GkXp3k423XOTMkGxux8aU7h2HfRqgLn6swfrX8Q
 O95oVz29pgwJxxoCbUiclPvjc1bWq/tUacX3Vjlvf2fr3t/90x2Adr20jPNDsGyhEN
 mF0Ss6N4LUweihLCJ7GGxFc4nVr/tysUZz1W11/yYWJ2z8P/BXlG0F6A2v4I1kEmK7
 MWmJEKY7e1COe1zKzwZK0NA7cisZqEeOg+bG1cc9eTpPUoxsCtC0voJ9iSVFNR15Lt
 ANxNfBTsWDaAg==
From: Michael Walle <mwalle@kernel.org>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/4] gpio: 3way strapping: add pinctrl method
Date: Tue, 27 Jan 2026 16:02:31 +0100
Message-ID: <20260127150401.1177176-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127150401.1177176-1-mwalle@kernel.org>
References: <20260127150401.1177176-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There are GPIO controllers which only supports static pinctrl
configurations to enable pull-up or pull-downs. E.g. that is common on
the k3 SoCs.

To switch between pull-up and pull-down, the device tree has to provide
a pinctrl configuration for both. These are then applied at once.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpio/gpio-uclass.c | 31 ++++++++++++++++++++++++-------
 include/asm-generic/gpio.h |  4 ++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 38151ef1bee..ab29a38d24b 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -12,6 +12,7 @@
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <dm/pinctrl.h>
 #include <dm/uclass-internal.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <errno.h>
@@ -1043,8 +1044,9 @@ int dm_gpio_get_values_as_int(const struct gpio_desc *desc_list, int count)
 	return vector;
 }
 
-int dm_gpio_get_values_as_int_base3(struct gpio_desc *desc_list,
-				    int count)
+int dm_gpio_get_values_as_int_base3_pctrl(struct udevice *pinctrl,
+					  struct gpio_desc *desc_list,
+					  int count)
 {
 	static const char tristate[] = "01z";
 	enum {
@@ -1065,11 +1067,20 @@ int dm_gpio_get_values_as_int_base3(struct gpio_desc *desc_list,
 	assert(count < 20);
 
 	for (i = 0; i < NUM_OPTIONS; i++) {
-		uint flags = GPIOD_IS_IN;
-
-		flags |= (i == PULLDOWN) ? GPIOD_PULL_DOWN : GPIOD_PULL_UP;
-		ret = dm_gpios_clrset_flags(desc_list, count, GPIOD_MASK_PULL,
-					    flags);
+		if (CONFIG_IS_ENABLED(PINCTRL) && pinctrl) {
+			const char *state = (i == PULLDOWN) ? "pull-down" :
+							      "pull-up";
+			ret = pinctrl_select_state(pinctrl, state);
+		} else if (pinctrl) {
+			return log_msg_ret("no pinctrl", -EINVAL);
+		} else {
+			uint flags = GPIOD_IS_IN;
+
+			flags |= (i == PULLDOWN) ? GPIOD_PULL_DOWN :
+						   GPIOD_PULL_UP;
+			ret = dm_gpios_clrset_flags(desc_list, count,
+						    GPIOD_MASK_PULL, flags);
+		}
 		if (ret)
 			return log_msg_ret("pu", ret);
 
@@ -1108,6 +1119,12 @@ int dm_gpio_get_values_as_int_base3(struct gpio_desc *desc_list,
 	return vector;
 }
 
+int dm_gpio_get_values_as_int_base3(struct gpio_desc *desc_list,
+				    int count)
+{
+	return dm_gpio_get_values_as_int_base3_pctrl(NULL, desc_list, count);
+}
+
 /**
  * gpio_request_tail: common work for requesting a gpio.
  *
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index a21c606f2b8..a69b8144973 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -525,6 +525,10 @@ int dm_gpio_get_values_as_int(const struct gpio_desc *desc_list, int count);
 int dm_gpio_get_values_as_int_base3(struct gpio_desc *desc_list,
 				    int count);
 
+int dm_gpio_get_values_as_int_base3_pctrl(struct udevice *pinctrl,
+					  struct gpio_desc *desc_list,
+					  int count);
+
 /**
  * gpio_claim_vector() - claim a number of GPIOs for input
  *
-- 
2.47.3

