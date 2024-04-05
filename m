Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25ADCD11C2
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2F41884C4;
	Fri,  5 Apr 2024 10:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ls36ZdF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2562888433; Fri,  5 Apr 2024 10:27:34 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C07688433
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4162b7f197cso9454245e9.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305651; x=1712910451; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PUa2jS9ewfWLrBpdAbB+JHzljYSnIAk6QET7uMcSglA=;
 b=Ls36ZdF7glhOM4Qb1Eb7vsBMhf8fpXr5ABjhuhN4tPYgguniPxlLm7xmXUCwsyM460
 5q+ZbrYOGVoqyL0q01o18G0lX5rfni3q5xbXdM/WY3Flzr+XIC33rKakoSUYgg6nmwrt
 CMgHoVMAkyOMoaBhPTiyz/7EivJDLXoZjTU51mdw91SFis/nPGNJWNK0KM80EGZs+i1p
 gMj4Ek73Wc4Fe56GBRlkotceR5m58s+pbwzD1iRRgJQSp6B5LLDnLwZ70CquFIY08bEc
 D+/49lC4Cw+PMKALpA5+KUs2Peq3ib73krSQQlvyYMMEz4F2Jf0TDREAxdbr0V3sE9iq
 pj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305651; x=1712910451;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUa2jS9ewfWLrBpdAbB+JHzljYSnIAk6QET7uMcSglA=;
 b=aZU7Z+aP3BCe3UjcfraBze2YjbOwXwQ8TMUHbNhOjr9EikrAv4oNdJaODyRI5LEyrP
 Ufb67OT5vYvt/8YLlBLcyt4UxSWO7GUjubLBbPLeJ1rA9CK69IFvfR42OFIu022WribL
 qoFan9w3c/3kRZxR6ny477djAV3800ODwPJpd73eUTo/tBwKuJILxVL2dN5oJW8qCTNj
 voEPA6qqkA+E4J5S55Wceb1/EXYe9IsHghsMRRswb5erKR2VFeLhFP02gD3pWyWmG575
 U59J6+VXZDgi43eay+GYNe4erVIVOcqzlsvgRAU0wrndwrXmRCBJ4wFMYd2JDiFZwlVm
 f87Q==
X-Gm-Message-State: AOJu0YxqXdP8EdiXY+2a3N0F8HdrP09IA38/IWqyTu1Qh/l12ww5Pt0x
 pSpdIt1pQ0aMFFAOsUDo+/FfdM/ZaookdLGOWKzAXdJ3SZ5Q9faG+iGxg+O4nzk=
X-Google-Smtp-Source: AGHT+IGJkroa6FLrSTNU7GbzM1DniHn09UxIUXfqZNCmb0ddWMMHvrvPQeCM0H27vh3h0eljgY/AIA==
X-Received: by 2002:a05:600c:1f82:b0:414:bfd:379d with SMTP id
 je2-20020a05600c1f8200b004140bfd379dmr639532wmb.22.1712305650595; 
 Fri, 05 Apr 2024 01:27:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a05600c45cb00b004162d06768bsm2721593wmo.21.2024.04.05.01.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:27:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:27:26 +0200
Subject: [PATCH 3/3] button: qcom-pmic: add support for pmk8350 button configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-spmi-clients-v1-3-c28603ebcf18@linaro.org>
References: <20240405-topic-sm8x50-spmi-clients-v1-0-c28603ebcf18@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-spmi-clients-v1-0-c28603ebcf18@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wCokJfViuQinUBF5rdS3P5CD0DYzO3mK3/6aTEbP6Wk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7XvyKKW40bGR7EotITQAOt2s3Kd0LF/D6tSecPC
 GBRc2iiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+17wAKCRB33NvayMhJ0eNbD/
 9zpuTFoSStnheFq80xA5XbnZwBfc6rbylVCl+y7Sbaeb1G4gZkY4h1N9QBFZUQseqEhWRAWUoQf3kr
 bsGZo0D4wNgdY7FXTC7HJnFzTufA2OE0X9ckHjDivBF4Maqej7bpKgCW8IXSJELNj/Tl1BzIyXzF22
 3SSdbNLMtiSfdJXNWePBkT1XGPQ/wIz1VfBWRgqqUqmulw6LyshLYA6YAAYI5A5vWOBIVjBCYrDkcF
 3raYr36xhiD81scsy9b1FAmXRmdcw+McF//Xt4Jicu+PD2bc8l2PCDAtZAjffD8arbCRhVGJtFdfs7
 QrG+ZSF2BnO+BU8S84XSOdhFExYJXiQgC47VqSMjCnjJDDFI+YP0GKmdxq8V8w5+v7DMVfqEmZYEkl
 Pg3wj5NxxsY3SZoHouNaqzAsc9bq7UVG6UD+6RgOVL6CokpSUSEIvyOTvpp/zLZB7UhVQpHZYq+bwH
 D7OGyWe1wYg2Xg1DJ1yYMMk9vN2lm+Hmvu/FAEthib6VEzETnFM5z4vuYUHgRaRRxuCyD7czui79mK
 gsNaSrzXWRnaZHLjH1tQxrSNdZX2Pe17vSxHCOoi0G7YtyE2GRfaIUsfcRum8j/J08LdfVvg3OJUYb
 N9iRhkY20yYOuAXRwirzIuEDfgkMIbU2wnz7T8NX5pqmyFskOdD4sfV9znQw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Finally add the entries for the qcom,pmk8350-pwrkey and qcom,pmk8350-resin
found on PMICs used with SM8350 and later SoCs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/button/button-qcom-pmic.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index f6da958097c..6153601017b 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -36,6 +36,8 @@ struct qcom_pmic_btn_priv {
 #define PON_INT_RT_STS                        0x10
 #define  PON_KPDPWR_N_SET		0
 #define  PON_RESIN_N_SET		1
+#define  PON_GEN3_RESIN_N_SET		6
+#define  PON_GEN3_KPDPWR_N_SET		7
 
 static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
 {
@@ -69,6 +71,18 @@ static const struct qcom_pmic_btn_data qcom_pmic_btn_data_table[] = {
 		.code = KEY_DOWN,
 		.label = "vol_down",
 	},
+	{
+		.compatible = "qcom,pmk8350-pwrkey",
+		.status_bit = PON_GEN3_KPDPWR_N_SET,
+		.code = KEY_ENTER,
+		.label = "pwrkey",
+	},
+	{
+		.compatible = "qcom,pmk8350-resin",
+		.status_bit = PON_GEN3_RESIN_N_SET,
+		.code = KEY_DOWN,
+		.label = "vol_down",
+	},
 };
 
 static const struct qcom_pmic_btn_data *button_qcom_pmic_match(ofnode node)

-- 
2.34.1

