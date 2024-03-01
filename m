Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A18C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 15:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE71B87D31;
	Fri,  1 Mar 2024 16:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GUUkwFkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C7687D06; Fri,  1 Mar 2024 16:07:18 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB26F87DED
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 16:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412ce4f62d9so737315e9.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 07:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709305634; x=1709910434; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UorTf1gyoKpk6eLMIM9vRw1AESuTeaYz0UGhxwG9BDY=;
 b=GUUkwFkAZWO0KXWW2MEawRQCWHpRp9D/XRLmAmeWq/8GtlwqMwO7bzHwQ0wdFT5Pe/
 UYWHhfizOBRGBLCLUi/6CvXabe1N0BvIJpkeAoc91OaZ/qMjiJ2YcSnDzN5qnJJ7RWZp
 QO2mwCd5ccqQs3zSUa88He4K3iBbHk76t4Tp179EZJxq2sPGamqmB2yJNPdV4F60iGUn
 AzvWZPJgl4qlDbGQSZO2q+pG1vkev9vAXEG9u2ql3V3VqROqK2/3iMd/pF7SeTyDfVtJ
 T/AT3pwMzOmjy+UVV6sdGqiwi5qB6UrLwJi/0g8TZrouwOm2iRwObswpwjplcDEMjcxS
 ts4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709305634; x=1709910434;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UorTf1gyoKpk6eLMIM9vRw1AESuTeaYz0UGhxwG9BDY=;
 b=rtdpycP/EPQPgGrf+8YGY+tqnObYWliKZihlMlTpWja62Lc8F1UFpWhMCc2Em3W27E
 0D5xvC1YYqmMofZ2Eu3nAp2l+nZ7RGdFJHTm/xvrl3mqvonOQEbdsnum33rXofv9YpYk
 Anntake+ylC9ooD9bWrJfJRq8Hw4R1vOBhpt4/k0y4kZOLMqGFDLLzZz6iUT3EiRS3FQ
 JvRnSiOnMhSYo+NVlLpzcduCy0SwdBl7CHC/oW4dvK2+zhRqQ8xRKKPv+uK892C+P/D5
 ShlrF1zlikN8h7MuSgdxYEtFookxJHNrQVJ6u/QGCgH2Sv9t+fARDsCsDZ/FdJMhI+ZM
 5Cfw==
X-Gm-Message-State: AOJu0Yzbns2vAVM92big7HI1K+bK4mTN36RmetEY7YgWOxAm4s8stGQV
 O+vjXYRjrzoJOiO9CCyBrsIvrPdN6qBYEyenbhyziShu0csJOFQBecMNLy3gQcY=
X-Google-Smtp-Source: AGHT+IFWCOyY48osn2AZ2SDwaFZa0ErNU6Y3VyyArXI0HwHW85vYLZ9C2Q4z877OmflxuyNoOUL26A==
X-Received: by 2002:a05:600c:1d8d:b0:412:a436:e5d2 with SMTP id
 p13-20020a05600c1d8d00b00412a436e5d2mr1672886wms.9.1709305634100; 
 Fri, 01 Mar 2024 07:07:14 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 z9-20020a05600c114900b00410bca333b7sm8601636wmz.27.2024.03.01.07.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 07:07:13 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de,
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] clk/qcom: apq8016: allow apq8016_clk_init_uart() to be called
 externally
Date: Fri,  1 Mar 2024 15:00:24 +0000
Message-ID: <20240301150651.4181574-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.43.1
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

When U-Boot as running as the first stage bootloader on MSM8916 devices,
early debug UART requires turning on the clocks (for some reason the
pre-loader turns them off?!).

To simplify developing for this platform, allow the
apq8016_clk_init_uart() function to be called externally. Developers can
call this from the serial_msm debug uart driver to configure the clocks
before the driver model is available.

As it is only possible to enable early debug UART in custom builds of
U-Boot, this solution at least gives developers the option.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This patch was meant to be in v5 of my Qualcomm generic board support series[1],
but got lost somewhere in the mix.

[1]: https://lore.kernel.org/u-boot/CAFA6WYNXE3x8sKRB8BBpODCfXbZeeVpKPu0-qt7ezsY-R7unQQ@mail.gmail.com/
---
 drivers/clk/qcom/clock-apq8016.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 9de0ad5ed32d..e6647f7c41dd 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -102,22 +102,22 @@ static const struct bcr_regs uart2_regs = {
 	.D = BLSP1_UART2_APPS_D,
 };
 
 /* UART: 115200 */
-static int clk_init_uart(struct msm_clk_priv *priv)
+int apq8016_clk_init_uart(phys_addr_t base)
 {
 	/* Enable AHB clock */
-	clk_enable_vote_clk(priv->base, &gcc_blsp1_ahb_clk);
+	clk_enable_vote_clk(base, &gcc_blsp1_ahb_clk);
 
 	/* 7372800 uart block clock @ GPLL0 */
-	clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 144, 15625,
+	clk_rcg_set_rate_mnd(base, &uart2_regs, 1, 144, 15625,
 			     CFG_CLK_SRC_GPLL0, 16);
 
 	/* Vote for gpll0 clock */
-	clk_enable_gpll0(priv->base, &gpll0_vote_clk);
+	clk_enable_gpll0(base, &gpll0_vote_clk);
 
 	/* Enable core clk */
-	clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
+	clk_enable_cbc(base + BLSP1_UART2_APPS_CBCR);
 
 	return 0;
 }
 
@@ -132,9 +132,9 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
 	case GCC_SDCC2_APPS_CLK: /* SDC2 */
 		return clk_init_sdc(priv, 1, rate);
 		break;
 	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
-		return clk_init_uart(priv);
+		return apq8016_clk_init_uart(priv->base);
 		break;
 	default:
 		return 0;
 	}
-- 
2.43.1

