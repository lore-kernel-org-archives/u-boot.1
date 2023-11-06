Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB7EC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C988709F;
	Mon,  6 Nov 2023 21:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GO/X9nDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3631C870B3; Mon,  6 Nov 2023 21:57:56 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 442128701B
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5079f3f3d7aso6641916e87.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304273; x=1699909073; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VCAIZbVxHMpTnsm7TVx+XTK2iDbZ6+ydra9nYJxmJOo=;
 b=GO/X9nDWijlokjFLksTIlE7cNGDP0uuqX/7Z125vFPHv5xOsSaWO8aQ2+lY0Zdrgxf
 uy/qc+sorDY1TzFf7A4bdXEX/sdXFgbXaZU6BSpVuIS/3cIGHCYEJKxQdAAzi4+JXNEb
 0Q/9+bGY71nfO0i+EgRph3m4y5+QQrFFSKFGvB2TnhDiQ9RIIHbN53945LYMaQtO/zXP
 GoyCk9pW8+YpW8z5qlEXRLVddQKPksZCs9bmgFK+0Ur6MFcinGzHGD/3Sm0GXddrHdR8
 IfFFAb6Mc0phtUto+lv5jmBaFIeZ/NuL1BO9kznL1LC9zIDz3oSb/RD/E72WnrsptAlE
 tAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304273; x=1699909073;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCAIZbVxHMpTnsm7TVx+XTK2iDbZ6+ydra9nYJxmJOo=;
 b=LF2RarRUQMVnBN7GnEWeRU3+jjW4y9ZIF8o1QBJPm5nwtqGy7wtkVLaUI19NuSj1MJ
 37Eq81rgyzjPr+dH/kC/uaWL1xydz8TpzHv6d5/CgkWIJUBV7MQ+WuxMZy8FkltOcpU7
 4yhcKIVxu7JatF4gjnjYlb7FFOkNWVWfTak4LLTXVNMkF3l/nGsAe0UN+eqCbIv3ybM7
 pynsBnTD69fW1Z6ssLejR4BPtRp7MHsbqOJb4S5UfwYHPwwaFgpBUgHq3gjBNAPSUpl0
 ETde5p7PXngSIenNWKjfO6w5PCDxUEvhEyySh8/JD+x/zt1/RqmRrwoOHN2BZPRcmYBL
 nHgA==
X-Gm-Message-State: AOJu0Yy+2NTwnPyziLTPHMyFMMBcqiq+bnsif83wVUVCr0RYCD71zpgO
 URQ9qV4XlLHmeP+LGvxQS4r3p8S/7oig56CIMxGD3A==
X-Google-Smtp-Source: AGHT+IH8Fs1Qn3gcuNXT/aeqCjVj0mHefOFs5S19D8CT/2Hn5egLkhmOsqG9O34yCZC2S2+BQH39Kg==
X-Received: by 2002:ac2:4db2:0:b0:509:441d:9bea with SMTP id
 h18-20020ac24db2000000b00509441d9beamr11916685lfe.20.1699304273520; 
 Mon, 06 Nov 2023 12:57:53 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d4c4b000000b0032f7d1e2c7csm511210wrt.95.2023.11.06.12.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 12:57:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 06 Nov 2023 20:57:29 +0000
Subject: [PATCH 1/5] gpio: qcom_pmic: fix silent dev_read_addr downcast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-b4-qcom-dt-compat-v1-1-0ccbb7841241@linaro.org>
References: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
In-Reply-To: <20231106-b4-qcom-dt-compat-v1-0-0ccbb7841241@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=yUdSWNMLnPJpyCscd/Vnde7MMn7arQIEoSvg1f014Lw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTPYH9J1ayL1w3VdpX+5hFZKfeRTTnYzubleU/5XK6/K
 jsio+d3lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIlozmdk2GsfdmTrqdqcKUX/
 HcJ/nw8wPp/3gy88Vo6Nwehc+7IHSxj+J727ZDRT47yd1etHi9hKApa/kll9KuRV/c1zP2ukdI2
 ezAYA
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

priv->pid is uint32_t, but dev_read_addr() returns a uint64_t on arm64,
with the upper bits being used for error codes. Do error checking before
downcasting to u32 to prevent errors being silently ignored.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 65feb453ebc3..e5841f502953 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -221,11 +221,14 @@ static int qcom_gpio_probe(struct udevice *dev)
 {
 	struct qcom_gpio_bank *priv = dev_get_priv(dev);
 	int reg;
+	u64 pid;
 
-	priv->pid = dev_read_addr(dev);
-	if (priv->pid == FDT_ADDR_T_NONE)
+	pid = dev_read_addr(dev);
+	if (pid == FDT_ADDR_T_NONE)
 		return log_msg_ret("bad address", -EINVAL);
 
+	priv->pid = pid;
+
 	/* Do a sanity check */
 	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
 	if (reg != REG_TYPE_VAL)
@@ -328,11 +331,14 @@ static int qcom_pwrkey_probe(struct udevice *dev)
 {
 	struct qcom_gpio_bank *priv = dev_get_priv(dev);
 	int reg;
+	u64 pid;
 
-	priv->pid = dev_read_addr(dev);
-	if (priv->pid == FDT_ADDR_T_NONE)
+	pid = dev_read_addr(dev);
+	if (pid == FDT_ADDR_T_NONE)
 		return log_msg_ret("bad address", -EINVAL);
 
+	priv->pid = pid;
+
 	/* Do a sanity check */
 	reg = pmic_reg_read(dev->parent, priv->pid + REG_TYPE);
 	if (reg != 0x1)

-- 
2.42.0

