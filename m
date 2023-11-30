Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A31CC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A88F5876C7;
	Thu, 30 Nov 2023 21:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="akJOvQpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA22087660; Thu, 30 Nov 2023 21:13:58 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89959875FE
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6d8029dae41so809658a34.0
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701375235; x=1701980035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dQ+OJ+v+4GaZBrUVXfZxpg4MaQ0769sAE8M5OwE8rI=;
 b=akJOvQpMIyPRdCtafpQfhfYITQlsi/FLO9hDR9ulXeXn7tRPJYu0QlMRhlAW4pRqLp
 vnSZct+FNorh68VOleU6zCEYiftk2iF9VV4k5I1Jf9cmBRHMmuWxW13RrDK3vQ25sPPk
 6bwNTUmLt4ybXqhIjP3aKhbXRGEzmRboZXCSMjZ+rlwirENDgpXkR73TgQVoJdqcx00K
 46+3tb9keIKCTb4C4QW+3o4Uy0q/Y28wfD7CFk0+0QFHEaSdtol6nq7cPdxE4I+EoXTA
 SccZRHq7FzNActZhbFiVqKQF/1M2QJ4OrrChHQXTItjODgEArG53PAz1Hw+kZ/oLu6aq
 e5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701375235; x=1701980035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1dQ+OJ+v+4GaZBrUVXfZxpg4MaQ0769sAE8M5OwE8rI=;
 b=Rf3CkXgNly6LVdJjCV+3BrIFyK1UNJsFByCSdaeNQIqqvh67mQcDCTp/+MvQfsF09s
 bbJ0QObAbG+LKP7luF+qHkkPdAtCNwfOjeXafQCEGtpGq4VvghAUoFZZjOOkDiCIyJIy
 KWWOMDhI2c552tl4szCSBVLmGYcrxXv0QcSCT2rKJJE2Mb/PgiIt2y/jCOB+EFnuCWiM
 QmieKKyo1l2JwZJ2YlSYT+Q0sghY+KafIwClwFmoM+FW2YuQqqz5Bx/pJPl8WjM6dkC1
 wHf59FNGm7+zubeyXHo9/csWO9fMVc28svJtppEz8RT+SgBDEmFWJeGhq/hPEo2w0X3n
 9xCw==
X-Gm-Message-State: AOJu0Yx4r9X6t/sIpOcpxX8hvTRaDrh619Oyy7nD+XSTDqYGR3rbf/YQ
 b+knJSENz4lz4aoW2DwncWIWeg==
X-Google-Smtp-Source: AGHT+IESVC4cfPSk9Um/MsWQ47GU2B4C339kcPFNOciKt7f+Jys4rKf2l8gmgXjNjY/uI2wzJbcBzg==
X-Received: by 2002:a05:6808:c3:b0:3b8:4021:2b51 with SMTP id
 t3-20020a05680800c300b003b840212b51mr668590oic.17.1701375235218; 
 Thu, 30 Nov 2023 12:13:55 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 dj16-20020a056808419000b003b2e7231faasm289822oib.28.2023.11.30.12.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:13:54 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH 3/7] pinctrl: exynos: Rework pin_to_bank_base() to obtain data
 by name
Date: Thu, 30 Nov 2023 14:13:48 -0600
Message-Id: <20231130201352.6379-4-semen.protsenko@linaro.org>
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

Rework pin_to_bank_base() function to obtain bank data structure by bank
name instead of getting bank base address by pin name, and rename it to
get_bank() to reflect this change. This in turn leads to the extraction
of parse_pin(), so the caller has to use it before calling get_bank().

No functional change. This is a refactoring commit which prepares
pinctrl driver code for handling different sizes of register fields,
which will be added next.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/pinctrl/exynos/pinctrl-exynos.c | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/exynos/pinctrl-exynos.c b/drivers/pinctrl/exynos/pinctrl-exynos.c
index 2d194ba0a4b5..d908927135b6 100644
--- a/drivers/pinctrl/exynos/pinctrl-exynos.c
+++ b/drivers/pinctrl/exynos/pinctrl-exynos.c
@@ -50,17 +50,14 @@ static void parse_pin(const char *pin_name, u32 *pin, char *bank_name)
 	*pin = pin_name[++idx] - '0';
 }
 
-/* given a pin-name, return the address of pin config registers */
-static unsigned long pin_to_bank_base(struct udevice *dev, const char *pin_name,
-						u32 *pin)
+/* given a bank name, find out the pin bank structure */
+static const struct samsung_pin_bank_data *get_bank(struct udevice *dev,
+						    const char *bank_name)
 {
 	struct exynos_pinctrl_priv *priv = dev_get_priv(dev);
 	const struct samsung_pin_ctrl *pin_ctrl_array = priv->pin_ctrl;
 	const struct samsung_pin_bank_data *bank_data;
-	u32 nr_banks, pin_ctrl_idx = 0, idx = 0, bank_base;
-	char bank[10];
-
-	parse_pin(pin_name, pin, bank);
+	u32 nr_banks, pin_ctrl_idx = 0, idx = 0;
 
 	/* lookup the pin bank data using the pin bank name */
 	while (true) {
@@ -75,15 +72,13 @@ static unsigned long pin_to_bank_base(struct udevice *dev, const char *pin_name,
 		for (idx = 0; idx < nr_banks; idx++) {
 			debug("pinctrl[%d] bank_data[%d] name is: %s\n",
 					pin_ctrl_idx, idx, bank_data[idx].name);
-			if (!strcmp(bank, bank_data[idx].name)) {
-				bank_base = priv->base + bank_data[idx].offset;
-				break;
-			}
+			if (!strcmp(bank_name, bank_data[idx].name))
+				return &bank_data[idx];
 		}
 		pin_ctrl_idx++;
 	}
 
-	return bank_base;
+	return NULL;
 }
 
 /**
@@ -93,6 +88,7 @@ static unsigned long pin_to_bank_base(struct udevice *dev, const char *pin_name,
  */
 int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
+	struct exynos_pinctrl_priv *priv = dev_get_priv(dev);
 	const void *fdt = gd->fdt_blob;
 	int node = dev_of_offset(config);
 	unsigned int count, idx, pin_num;
@@ -113,10 +109,15 @@ int exynos_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 	pindrv = fdtdec_get_int(fdt, node, "samsung,pin-drv", -1);
 
 	for (idx = 0; idx < count; idx++) {
+		const struct samsung_pin_bank_data *bank;
+		char bank_name[10];
+
 		name = fdt_stringlist_get(fdt, node, "samsung,pins", idx, NULL);
 		if (!name)
 			continue;
-		reg = pin_to_bank_base(dev, name, &pin_num);
+		parse_pin(name, &pin_num, bank_name);
+		bank = get_bank(dev, bank_name);
+		reg = priv->base + bank->offset;
 
 		if (pinfunc != -1) {
 			value = readl(reg + PIN_CON);
-- 
2.39.2

