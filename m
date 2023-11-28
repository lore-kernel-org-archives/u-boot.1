Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DB2C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 16:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 449A387759;
	Tue, 28 Nov 2023 17:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yRQZ1AMM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B42B8776E; Tue, 28 Nov 2023 17:30:54 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9504D87741
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 17:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40b27b498c3so45367695e9.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701189051; x=1701793851; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZD3xWJFTddk3OTmdBUhNqHlWq/BUIyH8Xi/jMrAbFW8=;
 b=yRQZ1AMM7I/Z/dVIMxE7IF4yi28FuyJhSSu0nWjfd2wFu6S/5a5BlnfXQAXf6m7tK8
 n9Mm3eQC5LB0+PFm6boL/McHf0QV3gqQGdoYKVmwT3t5jwgfa9sAOYARTU3DWQNOEPw6
 xRp1Kprqkun5yFukC8+PG9JxKzY+LndKZfN9+nK4MbLi6Eo9wKnxQE2BEtw4H3W5O20N
 wF7CAKbNLifHbmoZxUjtXy+pyxWLku9m/ZGUFxYc8cALVy4eC/M12Crse+gQxdykh4L/
 ndkrLHuFn+GT3Yi79T/2jdFseYE+jLLcrNm0M/BzUOaLwClztN1/iIyU4ke/mX6pLD56
 qfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701189051; x=1701793851;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZD3xWJFTddk3OTmdBUhNqHlWq/BUIyH8Xi/jMrAbFW8=;
 b=j6+9JW/AZ5J+TsXE8YT5w7tc6QPCaDfOV5W6oKya7buHtsDTOZmYlma8co2zi2ZQQA
 PY2lBFRgRl+8qC0GP6jt4eQsWilWd+Kug6xkLLzJ/PoKLKwp5z0Gb2h3hHJ5AivEq81u
 PUCHdZUMSFfdJAD9raIMpi+VL0oAhE+ESEfwIn5eJBLi+583tFZZMqntLZN3AUqBeFAl
 yeTP7Z6GCHEQSh65SY143DF762bsXK/srPhzy1izMbU88nlcZxHnB26Qo7WXnBUR1vfA
 J2H73ixnp821pgOXUCp66pujniT4lxgaEkAuBkMWqhB0eQ/Ku8zi7AO9+/OPyImPz3BI
 j2CA==
X-Gm-Message-State: AOJu0YzXG+t8Pm/08Y8I4JGc+DEsE6Ec72+oB7UNa2yEoHH4iRQejyNJ
 xT0D1hb7NYfBP9494qmDKmcwKNWx/zjWhx5X/XLJww==
X-Google-Smtp-Source: AGHT+IENWCVNl2goJrkksumMzv9nu39lrTIp9dlX6A8iI9RJgfrhrm4KGSbAurU2LhFE/CRuya4lsA==
X-Received: by 2002:a05:600c:1c11:b0:405:3dbc:8823 with SMTP id
 j17-20020a05600c1c1100b004053dbc8823mr13277768wms.12.1701189050693; 
 Tue, 28 Nov 2023 08:30:50 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d21-20020adf9b95000000b003316debbde4sm15530041wrc.48.2023.11.28.08.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 08:30:50 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 28 Nov 2023 16:30:25 +0000
Subject: [PATCH v4 1/5] gpio: qcom_pmic: fix silent dev_read_addr downcast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-b4-qcom-dt-compat-v4-1-949d0982d1de@linaro.org>
References: <20231128-b4-qcom-dt-compat-v4-0-949d0982d1de@linaro.org>
In-Reply-To: <20231128-b4-qcom-dt-compat-v4-0-949d0982d1de@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Ow6e+BYI9LfPmrbAV1SHSrFbCMy8//JMJxsRN55OU2Q=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ00e3Gp84Y+ddkG9n5r14XdlcxY3LGbFYpp5TGfZ9uT
 xNgyDbtKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABOZM4XhN+sC0ec278qjONWy
 FHx+/RBY8+qyHOM65pc707dfZ1+q+5iRYWuC3twz+85GRgs0akltCI/g/7bZ6YuM97ItuYylF9l
 4AwE=
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

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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
2.42.1

