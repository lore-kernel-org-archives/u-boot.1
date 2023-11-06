Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11B4C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 20:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238ED870ED;
	Mon,  6 Nov 2023 21:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P+mls8sm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D736A8709F; Mon,  6 Nov 2023 21:57:57 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FCC86F5D
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 21:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso37837795e9.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 12:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699304275; x=1699909075; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EgUoKXKqzbGvXXPMNN+Di4BMa47JWNghl7VzfJepnMg=;
 b=P+mls8smvRjx9vOFjhELnCRYrbpzPKVEvqczMO6ID8dx9IqUJhLctAv2Udn8ZwLINb
 I/0bO8O798w3s/9xMENjq/Kv/bxyf3doFli/bkiJC+y8TnwfhB9oiPWSOJ9QUWuKA+pg
 ZdgmI86L+qeYUwwnwboAt7288XHKkzEHsebN0U5Qal4SyUIkrk7RQhLgcFO+eYidThWV
 CSgvYhS5BdhQ4ifdLsZb2dk4l9SSNkJ3YxSLEFQyUxsuNWqMk3lR7QYRsUuFTpl8l13q
 cDNZfK5bz42lnsEK+fF8bqtSb4nU3diqjWFz/QUIsnR52XV9qIYfvPoufg7ldUrNEv75
 +SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304275; x=1699909075;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgUoKXKqzbGvXXPMNN+Di4BMa47JWNghl7VzfJepnMg=;
 b=KOfzNZiPvmVw48AlWUYWkJEUfuL/UX+bVQFZGa9aOLwDt8MH7Tkz5VpPG3+pcr6kle
 arowN8IMk/2v+ZXgSN/AgKcuNKWDRKQHvIAnmVwz/TqWRqAzXPHk/IO9YOHRXoKiy/pj
 5mMT71VeCqhk82Lh5VDSYppiIfkAH2S/31QL6rQC3DfVLJWciFOt5Ynevxj8V/R/p07a
 zgb1ef9zn2DnDNNo4r0UsFDjt0nmj9flM0gYQ0/VI2UlkkZynzpw61Ircwhs40jgIhoV
 QhfUrUFu1JEuttgfZ31qUog1wmL/tojKoonVSHG+EoFTJ8uTcq1PYl/FEDVEk8T9j09S
 gi3A==
X-Gm-Message-State: AOJu0YzeY6VKdog1KqhNw3vAaQA6cFDIpVc9hFmQksEfngiYHsOF1W8m
 LNEUoEgpCSZYlilp9JMX9ycOHxWIkZB0OoePekGEJQ==
X-Google-Smtp-Source: AGHT+IGWWjAXlNn9BCgsjaejCpexzEH93rbrePSzY2a4B59yzpTKHQeoXLLZxx9AQJnZeGRqA08fmA==
X-Received: by 2002:a5d:6d87:0:b0:32f:908e:c7e0 with SMTP id
 l7-20020a5d6d87000000b0032f908ec7e0mr19047585wrs.28.1699304275338; 
 Mon, 06 Nov 2023 12:57:55 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n11-20020a5d4c4b000000b0032f7d1e2c7csm511210wrt.95.2023.11.06.12.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 12:57:54 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 06 Nov 2023 20:57:31 +0000
Subject: [PATCH 3/5] gpio: qcom_pmic: fix support for upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-b4-qcom-dt-compat-v1-3-0ccbb7841241@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1VfLHjE8wkBO4Peq2fBSUYFrT5F/hijlL5AW3vAqzFY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlTPYP/prdcjoj/xfPpRIrc5fZXr08A46X43gzeTOafkH
 9+tUVzZUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbSMZ3hr7TNIpOVf9SmXy8u
 3lzYuHXmse3vLB7+mhp3npWlf86BxDsM/3MEeN3VCkuqwqbu+iZwQ778k/SKS9aN9ddvtvifnbL
 YxgcA
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

Linux devicetrees use the "gpio-ranges" property, add support for
parsing it instead of "gpio-count" so that upstream DTs can be used with
U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 3dbc02d83198..e6405881c637 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -247,11 +247,37 @@ static int qcom_gpio_probe(struct udevice *dev)
 	return 0;
 }
 
+/*
+ * Parse basic GPIO count specified via the gpio-ranges property
+ * as specified in Linux devicetrees
+ * Returns < 0 on error, otherwise gpio count
+ */
+static int qcom_gpio_of_parse_ranges(struct udevice *dev)
+{
+	int ret;
+	struct ofnode_phandle_args args;
+
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
+					     NULL, 3, 0, &args);
+	if (ret)
+		return log_msg_ret("gpio-ranges", ret);
+
+	return args.args[2];
+}
+
 static int qcom_gpio_of_to_plat(struct udevice *dev)
 {
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	int ret;
 
 	uc_priv->gpio_count = dev_read_u32_default(dev, "gpio-count", 0);
+	if (!uc_priv->gpio_count) {
+		ret = qcom_gpio_of_parse_ranges(dev);
+		if (ret > 0)
+			uc_priv->gpio_count = ret;
+		else
+			printf("gpio-ranges error: %d\n", ret);
+	}
 	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
 	if (uc_priv->bank_name == NULL)
 		uc_priv->bank_name = "qcom_pmic";

-- 
2.42.0

