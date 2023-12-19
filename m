Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD473C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE85087847;
	Tue, 19 Dec 2023 17:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ncb56Mgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 704A98780F; Tue, 19 Dec 2023 17:04:38 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 229CB87732
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c236624edso52073545e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001869; x=1703606669; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LLfoUGx3ADWhlYThmfj/PaJlrmojVdY422ZpdR9iZNs=;
 b=Ncb56MgbFyUB62rjvL22S5bbBvKRZNuv4eHsmpwIfjlVCOUiKJMPZr7W+hNmUDpO7w
 Sq80+4B/BHTYu7tU4rMuZUS5qW5dLmRpdqatLyqK0vivkmdV18DGkdZhlabFqQHuTYmR
 C6vnLkRN3bkugtq4PPmf3ctEle1MKrt61HJm6ntdlIdeJspURWq812qUYDKKPUgYmany
 ycnv7ylDUZwxrX8D5iqLuGDTfLApfP5cyzs7Jfuh6ae8Yn1cuj9eugRJQcyvS/pT895H
 36Qao/L7ymfg/zmX1K+H3+yD/08u6vG9TSqrHonLoQQ+yHSiKRfYrM/TFqy8bo9r4jEx
 ZyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001869; x=1703606669;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LLfoUGx3ADWhlYThmfj/PaJlrmojVdY422ZpdR9iZNs=;
 b=hfH9+k+ldRA60ntaRqj4R9PGj4NaMtWbLykZksq8BWRds+qZ5HbgRHccMtkqQ2oCrK
 I7cUi7K65FNiRWGbsAANzmeKfQ2yIbo0BkiMoYr5u4YrWhq6lOEg80VkXOPZycZWfTE8
 ZuNUYxmxZxLobeJKa78tdGHl9hUb7thm20J0mzbBID9OLYivx7Dr6+YJrSV/QRPNMvFS
 5m38qRdIuzynzIC2KLLAGqYsyQtbD8qfi/G8f6O3vSugZHX6jGw7avDOXgyiA7Dp3TdR
 cQQf9FAkj1iYd9nUV8PANfFCYPrUiWeexf0wJEWP0whnMLtmmGD3vkTejjhg+hTtjdYS
 mCYQ==
X-Gm-Message-State: AOJu0YyZA8idHsucRA6idcsDMGr8z0rlE6z4TGzbWq8WaVBMB9n40vXC
 qb3/KMD6h30746QmIYHju4B/xQ==
X-Google-Smtp-Source: AGHT+IHi4M0aBWq+DgT4I5s/dE2zM9M0Tx4sV6H4nBLYvhuRkDQF3RZ+1O+j0mh7J2GLYgTjE5AJEw==
X-Received: by 2002:a05:600c:2317:b0:40b:5e21:cc2c with SMTP id
 23-20020a05600c231700b0040b5e21cc2cmr9742248wmo.87.1703001869488; 
 Tue, 19 Dec 2023 08:04:29 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:29 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:08 +0000
Subject: [PATCH v2 07/32] serial: msm: fix clock handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-7-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=V8tNP81M3Dat4HdQ6rMmiblGQ0MmNHo57qkosFhi/CA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/UzH66bPnLAj8LjuGrsTvn0awU+0i2rMNX/sMW3RC
 z/QXDSvo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEwkdS/Db7aOcP6di38nbW9/
 Ec4TefUiZ8Q6zcvK/FJSC+cZ7nDdFc/wP8M2u+q+ZaODysQ/XHMamW79vs62iod12jaxl5ksniw
 HQgE=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Use the modern helpers to fetch the clock and use the correct property
("clocks" instead of "clock")

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts |  3 ++-
 arch/arm/dts/dragonboard820c.dts |  3 ++-
 drivers/serial/serial_msm.c      | 24 +++++-------------------
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index 02c824d0226c..c395e6cc0427 100644
--- a/arch/arm/dts/dragonboard410c.dts
+++ b/arch/arm/dts/dragonboard410c.dts
@@ -84,7 +84,8 @@
 		serial@78b0000 {
 			compatible = "qcom,msm-uartdm-v1.4";
 			reg = <0x78b0000 0x200>;
-			clock = <&clkc 4>;
+			clocks = <&clkc 4>;
+			clock-names = "core";
 			pinctrl-names = "uart";
 			pinctrl-0 = <&blsp1_uart>;
 		};
diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
index 146a0af8aafe..86b7f83d36d6 100644
--- a/arch/arm/dts/dragonboard820c.dts
+++ b/arch/arm/dts/dragonboard820c.dts
@@ -78,7 +78,8 @@
 		blsp2_uart2: serial@75b0000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0x75b0000 0x1000>;
-			clock = <&gcc 4>;
+			clocks = <&gcc 4>;
+			clock-names = "core";
 			pinctrl-names = "uart";
 			pinctrl-0 = <&blsp8_uart>;
 		};
diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 19a5a3a788f7..0148ddb54df6 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -160,29 +160,14 @@ static int msm_uart_clk_init(struct udevice *dev)
 {
 	uint clk_rate = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
 					"clock-frequency", 115200);
-	uint clkd[2]; /* clk_id and clk_no */
-	int clk_offset;
-	struct udevice *clk_dev;
 	struct clk clk;
 	int ret;
 
-	ret = fdtdec_get_int_array(gd->fdt_blob, dev_of_offset(dev), "clock",
-				   clkd, 2);
-	if (ret)
-		return ret;
-
-	clk_offset = fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
-	if (clk_offset < 0)
-		return clk_offset;
-
-	ret = uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &clk_dev);
-	if (ret)
-		return ret;
-
-	clk.id = clkd[1];
-	ret = clk_request(clk_dev, &clk);
-	if (ret < 0)
+	ret = clk_get_by_name(dev, "core", &clk);
+	if (ret < 0) {
+		pr_warn("%s: Failed to get clock: %d\n", __func__, ret);
 		return ret;
+	}
 
 	ret = clk_set_rate(&clk, clk_rate);
 	clk_free(&clk);
@@ -252,6 +237,7 @@ U_BOOT_DRIVER(serial_msm) = {
 	.priv_auto	= sizeof(struct msm_serial_data),
 	.probe = msm_serial_probe,
 	.ops	= &msm_serial_ops,
+	.flags = DM_FLAG_PRE_RELOC,
 };
 
 #ifdef CONFIG_DEBUG_UART_MSM

-- 
2.42.1

