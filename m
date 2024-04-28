Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFB0C4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 14:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFC1883D1;
	Sun, 28 Apr 2024 16:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bq0qQjFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC5C98828B; Sun, 28 Apr 2024 16:24:27 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC82F8829C
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 16:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heesub@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ed01c63657so3541278b3a.2
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714314264; x=1714919064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgDgv9rbi79bbRE2XNnELd24eGnIyO4W82Dpxon/rpE=;
 b=bq0qQjFkhoP5etJFccLCO1BVE4qB2NOGrxvRy1Tra0n8KxHRQIG6E45XB8QcDxE7Nm
 oAO2A92VOZ8SOxjoEcLCOJL3orxBuqTxOkGnD4EgMtSkp/c4k5X3yDdOmjNGGCHlb55z
 R1fLhWhW8mvG/GRQtJ4GhN6m7jy3B/U4oqm+4gf39AHgEYJkgX8tiYY4tNDsgJZ/K3jR
 nVsucqORVMmcjXkfDup1O8hB3FfB6hnX7lYMdon9SmwSEerX/qMpGGb6CJQaHS44WjEy
 TExdyxsgrbnXHypzHodaQjQCwPnI/fzY9a02uAOA3b8D3LGW0d0SBuVGvJXV9j+GU63j
 Jc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714314264; x=1714919064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgDgv9rbi79bbRE2XNnELd24eGnIyO4W82Dpxon/rpE=;
 b=p1FQL8WlVP0EGD395WQ1HGSf1LRzUIhgwSs2fzAS8ATb0XRDUvA7poJr+tx9INzMtn
 QtMoiS1o0f0GWAcCKBEEu+o6Qzm/TA45KLtk70Ym8Tj0BbuC7iVEUbUygnUfstT7hdp5
 INwS8l313SlNQgPTebqhsrK+YhFK4aplwWSuJk2dGhQTKtqMAoBx4a7Vjcd5UCHjIi/g
 rmS6Q2hM4nbANDginAd9JFPlKmBum3WtR7U0Pk7GHZN77T4gI0ckejn8fahO+SfpihWO
 DQbbuBkMqIT/3etiCsiEvXd8Qc74Fy1XDTJfyDjTjw8WXeSRsAK4+yug7BFjuoxmazTo
 ZPxQ==
X-Gm-Message-State: AOJu0YxJuD32e6u59qj7YSrX1vjc49dnEb5Ivcj53b51zVRR9RS4LNRD
 pKAQKGbYFdV8SQx2EAEXyD7cOukkzzQ6A1YrGx0+IYaRpxcpY9PcrP+yWw==
X-Google-Smtp-Source: AGHT+IHXEGWOLV8LP4HDgwAoOV4ad9CRBnWTrNHM+gSll6NK0LoscEUYviGDSbgMfQxBDONTFXLOxQ==
X-Received: by 2002:a05:6a21:7887:b0:1ad:68c9:7e4c with SMTP id
 bf7-20020a056a21788700b001ad68c97e4cmr5735117pzc.43.1714314264160; 
 Sun, 28 Apr 2024 07:24:24 -0700 (PDT)
Received: from heesub-ubuntu.localdomain ([58.229.217.38])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a635343000000b005f077dce0f6sm17568744pgl.31.2024.04.28.07.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 07:24:23 -0700 (PDT)
From: Heesub Shin <heesub@gmail.com>
To: u-boot@lists.denx.de
Cc: Heesub Shin <heesub@gmail.com>
Subject: [PATCH 4/5] net: dwc_eth_qos: add support for phy-reset-gpios property
Date: Sun, 28 Apr 2024 23:24:05 +0900
Message-Id: <20240428142406.28445-4-heesub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428142406.28445-1-heesub@gmail.com>
References: <20240428142406.28445-1-heesub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Apr 2024 16:40:40 +0200
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

This commit adds support for a property 'phy-reset-gpios' to reset PHY
chipset.

Signed-off-by: Heesub Shin <heesub@gmail.com>
---
 drivers/net/dwc_eth_qos_stm32.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos_stm32.c b/drivers/net/dwc_eth_qos_stm32.c
index fbc08bba1d..cffaa10b70 100644
--- a/drivers/net/dwc_eth_qos_stm32.c
+++ b/drivers/net/dwc_eth_qos_stm32.c
@@ -266,6 +266,12 @@ static int eqos_probe_resources_stm32(struct udevice *dev)
 	if (ret)
 		dev_warn(dev, "No phy clock provided %d\n", ret);
 
+	/* Get reset gpio pin (optional) */
+	ret = gpio_request_by_name(dev, "phy-reset-gpios", 0,
+				   &eqos->phy_reset_gpio, GPIOD_IS_OUT);
+	if (ret)
+		pr_warn("No phy reset gpio provided: %d\n", ret);
+
 	dev_dbg(dev, "%s: OK\n", __func__);
 
 	return 0;
@@ -277,6 +283,21 @@ err_probe:
 	return ret;
 }
 
+static int eqos_start_resets_stm32(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	if (dm_gpio_is_valid(&eqos->phy_reset_gpio)) {
+		dm_gpio_set_value(&eqos->phy_reset_gpio, 1);
+		udelay(2);
+		dm_gpio_set_value(&eqos->phy_reset_gpio, 0);
+	}
+
+	return 0;
+}
+
 static int eqos_remove_resources_stm32(struct udevice *dev)
 {
 	dev_dbg(dev, "%s:\n", __func__);
@@ -292,7 +313,7 @@ static struct eqos_ops eqos_stm32_ops = {
 	.eqos_probe_resources = eqos_probe_resources_stm32,
 	.eqos_remove_resources = eqos_remove_resources_stm32,
 	.eqos_stop_resets = eqos_null_ops,
-	.eqos_start_resets = eqos_null_ops,
+	.eqos_start_resets = eqos_start_resets_stm32,
 	.eqos_stop_clks = eqos_stop_clks_stm32,
 	.eqos_start_clks = eqos_start_clks_stm32,
 	.eqos_calibrate_pads = eqos_null_ops,
-- 
2.34.1

