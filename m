Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB89CCCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AE9783869;
	Fri, 17 Oct 2025 17:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="hgk67x0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8662883852; Fri, 17 Oct 2025 17:23:28 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABFEA8386D
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7FCA02629C;
 Fri, 17 Oct 2025 17:23:26 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 83yI5l8MrAV7; Fri, 17 Oct 2025 17:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714606; bh=odnG3u+jyKMCtHYqiJEdhmwpe68TsE+04tiicOy6PYI=;
 h=From:Date:Subject:To:Cc;
 b=hgk67x0TdA4hqUmcotfhejmACUdq5Pi5tRez57qtT2jca779BKeNfmuHQPG431qdQ
 mA+ozw1WznBlrOgf5Jg02Nh9sQB7pnlOTEA5VnK94BzcZCSnKGRMNwZJNNc4YdLU0T
 LCwEsJvGwqd6F/YtECUQYoggQFfValremz0ZogCOSl5LJ7UZDMjBmyZt6AtfntIcvc
 zlzDfI82mdbi0Dw/dxRl3ziquGxlAhWN0G+SrD28FcRMKcP6Gu2xlg7DTyfXRwfJvv
 vl4M6ODmKFW2vjQlHAZqbL92AlgH8rPk/K22DxA4BcibjJv/dS7RKvR4jDcddP3diQ
 xXFN3A8mPKXQw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:53:11 +0530
Subject: [PATCH] gpio: s5p: increment bank base address only if bank is
 initialized
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-gpio-s5p-bank-fix-v1-1-41050462cea5@disroot.org>
X-B4-Tracking: v=1; b=H4sIAF5f8mgC/x2MQQqAIBAAvyJ7bsGVguor0UFtqyVQUYhA+nvSc
 QZmKhTOwgVmVSHzLUViaECdAn/acDDK1hiMNgNp6vFIErEMCZ0NF+7yIG1aj94ZS3aC1qXMTf/
 PZX3fD0mjkWRjAAAA
X-Change-ID: 20251014-gpio-s5p-bank-fix-1d008cb2a1a9
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714604; l=1736;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=odnG3u+jyKMCtHYqiJEdhmwpe68TsE+04tiicOy6PYI=;
 b=CJZnRaLTuOiDYlruU46lc68eo9oIXNzrKFWNB+iGjmyrDpnFEwZfp9IonufuPBaMn9ZJxY0mS
 oSDXDatlPgCBksOfgn6HkWSdDzpKCji/cde+KrJVDqZujJNlqy29BOA
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

There is a condition guard which ensures that the GPIO node, indeed
describes a GPIO controller.

	if (!fdtdec_get_bool(blob, node, "gpio-controller"))
		continue;

Since the bank base is being incremented in the loop, it is done so
irrespective of whether the node is a GPIO controller or not. This leads
to the incorrect resolution of bank base addresses.

Move it out of the loop, and instead increment the bank base address
only if the driver successfully binds a GPIO controller.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/gpio/s5p_gpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/s5p_gpio.c b/drivers/gpio/s5p_gpio.c
index 53dbbe97b5a02d09fbf0124268faaffa31b1315f..c072f146514c63cdc98e907983a904f05cd118e7 100644
--- a/drivers/gpio/s5p_gpio.c
+++ b/drivers/gpio/s5p_gpio.c
@@ -319,7 +319,7 @@ static int gpio_exynos_bind(struct udevice *parent)
 	base = dev_read_addr_ptr(parent);
 	for (node = fdt_first_subnode(blob, dev_of_offset(parent)), bank = base;
 	     node > 0;
-	     node = fdt_next_subnode(blob, node), bank++) {
+	     node = fdt_next_subnode(blob, node)) {
 		struct exynos_gpio_plat *plat;
 		struct udevice *dev;
 		fdt_addr_t reg;
@@ -341,9 +341,8 @@ static int gpio_exynos_bind(struct udevice *parent)
 		if (reg != FDT_ADDR_T_NONE)
 			bank = (struct s5p_gpio_bank *)((ulong)base + reg);
 
-		plat->bank = bank;
-
 		debug("dev at %p: %s\n", bank, plat->bank_name);
+		plat->bank = bank++;
 	}
 
 	return 0;

---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251014-gpio-s5p-bank-fix-1d008cb2a1a9

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

