Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25639C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7317F87572;
	Wed,  8 Nov 2023 17:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w46tInyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54948875A7; Wed,  8 Nov 2023 17:21:07 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96CD78754A
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32d834ec222so3643682f8f.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699460462; x=1700065262; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VCAIZbVxHMpTnsm7TVx+XTK2iDbZ6+ydra9nYJxmJOo=;
 b=w46tInytVUc9WtTT+aUWo2kjvgNBH37oyLYWsoH6kJPrT76PheEiNbYIiHRj9aqDlw
 eYYFy05VOFagmZrZvt9Fkp7XKr03QPzw9WiFYWWyN7g0S75SBSTy5h3ALnZMW46QT4BT
 PeTfm5Lnqcm5QwX3Qq7LAikTM5S02sjnDJwJ6+2kkcAbQmp43O2Bt7EZcC3jctTCte/n
 rS8MAewg1TFLN9t/7C85htD/ACNzTSItLYsQ1ONphtTDrPFWeCG++CLOEQvRB4SLdReP
 GAnPWpdNwskw5qOls9dAd2CmXppNw9U2ZHkvYoNf5Wx5Z2MA2bYMKvwoXbXln0FnRzzl
 e5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699460462; x=1700065262;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCAIZbVxHMpTnsm7TVx+XTK2iDbZ6+ydra9nYJxmJOo=;
 b=lCw15zKEfLo+uRMgrklRTgWuczjGxlB25KcrLgxkcn0kwMAXQWJ8+tLXRnBgEEsAnM
 dp4EuMNnmj+6I4XxPDrys2lvRT3dqL/0fNrysnWjV4NrzukqCl1AmelnnvjEF+m3D67J
 iIplVAkzozrJHV5xCir/a+PP0eUiQeKi+BQe2Ti5/ir+KDJLOrbfHdxQars9y5L8eRaf
 ld1IxEBbQtdPgQ4YtdY9VMomh63Rd3iXUt3IGD2aIpdRvQLpg3oh/WLK0wvELQbxiO4R
 f6N8ukSOfIwszqZQIRGYm7XaQCFd1h33Rilf7gdFdgdS1ls4ZSQ1KURdu5B8/DL5qkLY
 3Oag==
X-Gm-Message-State: AOJu0YzLJ0Pu+Ir/Mj9whWjY6yEZb9BBpfuXYJY95W6TTySWwrt/7R+x
 sojaAfxHOYT0uaDbsAnNR5qFliwFAUgfbSqs8GhJIA==
X-Google-Smtp-Source: AGHT+IFPNpOmbgLQeAmx/H7YlpnYQG1zyxogjSReYz6O5kTlvwydNulIWhM9pok60qlYhj4OP4FMzA==
X-Received: by 2002:a5d:4f0c:0:b0:32f:7967:aa4d with SMTP id
 c12-20020a5d4f0c000000b0032f7967aa4dmr1857855wru.68.1699460462552; 
 Wed, 08 Nov 2023 08:21:02 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n7-20020a5d6607000000b0032db1d741a6sm5273660wru.99.2023.11.08.08.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 08:21:01 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 08 Nov 2023 16:20:53 +0000
Subject: [PATCH v2 1/5] gpio: qcom_pmic: fix silent dev_read_addr downcast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231108-b4-qcom-dt-compat-v2-1-713233c72948@linaro.org>
References: <20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org>
In-Reply-To: <20231108-b4-qcom-dt-compat-v2-0-713233c72948@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=yUdSWNMLnPJpyCscd/Vnde7MMn7arQIEoSvg1f014Lw=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTvrTnTW+ezZog8njT/hVqVhm4gm9mPTTfme7H9mZPxf
 8KZKT21HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAingkM/3Teb5qdc/7zl7p/
 KauzVtWnOYqYLuJaZ9308rfgFqOdzf8ZGRbf+r97uypv2rqoMqOFlfOZA46LKGU8mrQwteFN26P
 N/lEA
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

