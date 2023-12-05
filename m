Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDF3C07E97
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 13:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B74878BA;
	Tue,  5 Dec 2023 14:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k+LAhg9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B9D87626; Tue,  5 Dec 2023 14:47:06 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B10387745
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 14:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c9f57d9952so37987361fa.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 05:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701784023; x=1702388823; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ToeRg/qTzycp+tXwM62aTvWEHWd1IbuiLlCcu4hbrf0=;
 b=k+LAhg9nktRHJ/i6RTFz07vim1/dSgSKSP8YRrRnHVxLtgr2Jw+U6uXhdxDWZ1YEmi
 6MPjEIkw6mLH6Px1Rhj/WNj3hNZuww06AMA857MZ5orpENH6oJeQTxcNQUlu3xeGTMBr
 +Z9bWIJ8SzdfAtpmRt26H/GEycH4OARHN/sHQIKqKk7nxZ/NcH4opP8Lcd0rOu/Z8U95
 0R62Eu8HwnVHhHt7ZfFDdQd8FGKXQpQagqZ1b2QelEHOSayg25JR4bOjKx+gO4uQg408
 ujj9qzQKPu62B4bP4HDa+BpMtSgzZESzxqlDYTM9fqur6XdLo7NAshhHS/AC+K55Biui
 n4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701784023; x=1702388823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ToeRg/qTzycp+tXwM62aTvWEHWd1IbuiLlCcu4hbrf0=;
 b=TV05IotwO0lH6ogEBemahcMbe+oicPSXtUp0QNfLq0PczxqvmindrUO2vOID5UbHzE
 7HMNH33/KWAgdmPFOYl/YNzv30IWpF6yb1WqbC84XG/jpFl/HRdFkJg02PN1MdnvSsT5
 Ax4qymFjHuZqlkVx47enVgCijC1QxpQ9YfpEH6XFPVNN9hvRCDpX2BPVzUqlwynu57N2
 uzwZM69uv52Fv12oPdQYrUq/V88MoU3b/Z/J0JsQzbx8ED4Qj9jetkHJEUsw65UsTf7Q
 rxuw0O0tePAxfQgiA3TzaUEHgKMfn4gaFpB7a9EpHauWWWhejv/kcI2saMWmPBI+n4gr
 DrWw==
X-Gm-Message-State: AOJu0YyfMcpCcY5YLQZtkKXgF7+ppCIFPk0D2X9c8rTujnDJ3AbYfoMb
 AJvMQ9kEY3+UNFzjBVWFUBymbg==
X-Google-Smtp-Source: AGHT+IECcx4BH2DncGE2ya1YBvfsnAZbn9y8Nh+PsiblsJyaU6KFaD3Oi5I50BnpfGT9hsY3KzaISQ==
X-Received: by 2002:a2e:8181:0:b0:2ca:dc7:6596 with SMTP id
 e1-20020a2e8181000000b002ca0dc76596mr1150249ljg.77.1701784023734; 
 Tue, 05 Dec 2023 05:47:03 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a2e928a000000b002ca0e0c837asm369688ljh.100.2023.12.05.05.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 05:47:03 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 05 Dec 2023 13:46:50 +0000
Subject: [PATCH v6 5/9] gpio: qcom_pmic: support upstream DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-b4-qcom-dt-compat-v6-5-61d104a8f920@linaro.org>
References: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
In-Reply-To: <20231205-b4-qcom-dt-compat-v6-0-61d104a8f920@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1856;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=tryPUJEelsn2aYdAYdxSHQ9xFfUTee+qQvSaqHDrkvA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtR8zXPbN1haas9m3u6bGfOvJr5ws3Ssi92OPTL6S2ImG
 4l9dzbpKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABOJf8zw3+v7oW1bTzzqu/Hh
 6u8jl+UytiX++fU1aumOe0HLhCfUTuBkZFi4V++iudFxsYmLHWf775aOlvxhqCbx3H3dqyqVt47
 vvDwB
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

Upstream uses the gpio-ranges property to define the number of GPIOs,
support for parsing this when gpio-count is unspecified

Additionally, drop the bank-name property as it isn't used in upstream,
and we can just hardcode the bank name instead.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/gpio/qcom_pmic_gpio.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
index 7b83c67fa464..5221bd27825e 100644
--- a/drivers/gpio/qcom_pmic_gpio.c
+++ b/drivers/gpio/qcom_pmic_gpio.c
@@ -245,14 +245,39 @@ static int qcom_gpio_probe(struct udevice *dev)
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
-	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
-	if (uc_priv->bank_name == NULL)
-		uc_priv->bank_name = "qcom_pmic";
+	if (!uc_priv->gpio_count) {
+		ret = qcom_gpio_of_parse_ranges(dev);
+		if (ret > 0)
+			uc_priv->gpio_count = ret;
+		else
+			return ret;
+	}
+
+	uc_priv->bank_name = "pmic";
 
 	return 0;
 }

-- 
2.42.1

