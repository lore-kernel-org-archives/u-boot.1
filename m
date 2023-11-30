Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1391CC46CA3
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89420876FF;
	Thu, 30 Nov 2023 21:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XGHSQ7q3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA7F87483; Thu, 30 Nov 2023 21:14:02 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D940A87698
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b898c9b4cbso788331b6e.2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375238; x=1701980038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz7g8RyqOHqcuJRD1Ca00DNs6X4nhUazkR8kMGsHWm4=;
 b=XGHSQ7q3LoIclTpkS+4vGrifmE8K9eQLxR5SigsG2hCAz+/heLV4tPUButqjocPPz4
 ZKgj39uMSmZFYGZUyuLJ5IGsNW2vz7/MM3VPFIoYgwNYNglj3yccULZ1eMy3FjyfkXnV
 bWuY6MZG9PbG1Cwc8RVoyMJcAbGh6m00zc2LTiS40ihxVOfhmvhctSlTeNFmpTUUH12B
 SFZqvS4PA9uYvW3lMzHpIxF1M5ZZzZ3VHS1RS83I1fe3JwQrBqQDoImynev0zQT5EABR
 4Gy6QhlcHgG3x1cf1GtzpZEadWi97nrPhOXxK5EzkqskBJgXa4Xo8R6P6+Zeki7zQP9D
 4wsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375238; x=1701980038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uz7g8RyqOHqcuJRD1Ca00DNs6X4nhUazkR8kMGsHWm4=;
 b=hY4QQ6VjdtHUKYcWkTg6HeUUm2Z2+5BUt6kUleuxexQbTyUALPvmq6mM8T4bdomZzO
 zAAQEaGCZe5HETRGf6Xn0XbgeScqs9HL8Ig1XqetJ7tUDcXhqSbHCXl37YbFgvMEF+Lk
 87EW6OpG7fpUvUS5zgxTkT7y++YItI4IugU+CUicQM87fxQk0xJqEstiliGbn65+jZan
 LXopRIXKymnaZmf+vKXlLTqSAEM7BT4p7ee2v2reB7pDFFXqkDvK2kGvmPCUCzxkHNEe
 8vSwwFLO84Fca+Y6Jnucaq8rG+b6FthHuLhiOeFt9buntDf/GdnoeDcbvMTqd8BtO4Vu
 +e5w==
X-Gm-Message-State: AOJu0YxP1Oj7sEYevxjNuCRdHtEia3jbrN0vVx9MyPQdTYSKFTXkrbVF
 73002p+KT5q4lp6QiXcauc6AkQ==
X-Google-Smtp-Source: AGHT+IHAshjzo6hUXU1eQoMpEBB1xnPZG3foluFWkWu4agjwA2SaNgTKs/DDKL7r9kRanYBBA89CYg==
X-Received: by 2002:a05:6808:1703:b0:3af:b6ea:2e2 with SMTP id
 bc3-20020a056808170300b003afb6ea02e2mr742998oib.59.1701375238516; 
 Thu, 30 Nov 2023 12:13:58 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 bg3-20020a056808178300b003b274008e46sm294182oib.0.2023.11.30.12.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:13:58 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 7/7] pinctrl: exynos: Convert to use livetree API for fdt
 access
Date: Thu, 30 Nov 2023 14:13:52 -0600
Message-Id: <20231130201352.6379-8-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130201352.6379-1-semen.protsenko@linaro.org>
References: <20231130201352.6379-1-semen.protsenko@linaro.org>
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

Use counterpart dev_read_* functions instead of fdt* ones. It fixes
checkpatch warnings like this:

    WARNING: Use the livetree API (dev_read_...)
    #54: FILE: drivers/pinctrl/exynos/pinctrl-exynos.c:137:
        pinvals[idx] = fdtdec_get_int(fdt, node,

and also makes it possible to avoid using the global data pointer in the
driver.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index b6af3befbf9b..8a045cdf7aa8 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -9,12 +9,9 @@
 #include <common.h>
 #include <dm.h>
 #include <errno.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include "pinctrl-exynos.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /* CON, DAT, PUD, DRV */
 const struct samsung_pin_bank_type bank_type_alive = {
 	.fld_width = { 4, 1, 2, 2, },
@@ -118,8 +115,6 @@ static void exynos_pinctrl_set_pincfg(unsigned long reg_base, u32 pin_num,
 int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
 	struct exynos_pinctrl_priv *priv = dev_get_priv(dev);
-	const void *fdt = gd->fdt_blob;
-	int node = dev_of_offset(config);
 	unsigned int count, idx;
 	unsigned int pinvals[PINCFG_TYPE_NUM];
 
@@ -127,13 +122,13 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	 * refer to the following document for the pinctrl bindings
 	 * linux/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
 	 */
-	count = fdt_stringlist_count(fdt, node, "samsung,pins");
+	count = dev_read_string_count(config, "samsung,pins");
 	if (count <= 0)
 		return -EINVAL;
 
 	for (idx = 0; idx < PINCFG_TYPE_NUM; ++idx) {
-		pinvals[idx] = fdtdec_get_int(fdt, node,
-					      exynos_pinctrl_props[idx], -1);
+		pinvals[idx] = dev_read_u32_default(config,
+						exynos_pinctrl_props[idx], -1);
 	}
 	pinvals[PINCFG_TYPE_DAT] = -1; /* ignore GPIO data register */
 
@@ -142,12 +137,13 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 		unsigned int pin_num;
 		char bank_name[10];
 		unsigned long reg;
-		const char *name;
-		int pincfg;
+		const char *name = NULL;
+		int pincfg, err;
 
-		name = fdt_stringlist_get(fdt, node, "samsung,pins", idx, NULL);
-		if (!name)
+		err = dev_read_string_index(config, "samsung,pins", idx, &name);
+		if (err || !name)
 			continue;
+
 		parse_pin(name, &pin_num, bank_name);
 		bank = get_bank(dev, bank_name);
 		reg = priv->base + bank->offset;
-- 
2.39.2

