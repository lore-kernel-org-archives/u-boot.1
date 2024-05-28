Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1049BC25B79
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A6388470;
	Tue, 28 May 2024 10:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ja7WjS6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D64AE88440; Tue, 28 May 2024 10:32:05 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE298841D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42101a2ac2cso4003905e9.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716885123; x=1717489923; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CVtRuMH7l26GoYmBK+IZ2kjg3Vz0LD7oKprQ1i3TIBs=;
 b=Ja7WjS6uFGtcsdFMDIuV8mLVQhfBWChuoLqMzAiXOKLzAJ4Dx+fBvbxg7F1MAV92V0
 UXrPTKEDXSI7l20oxBDNZGHnhpJ0l3nmFoTIjlulbAdsbFpw3CY7EXAA1i4WPg94W3KQ
 Iu345pehhN/P5eKN/r06IwAqoMi3IVJRNhQfXK5DUhpGqmoErBfPi1GKu8INPzd8U2SY
 dtUvP7+kTlxKZI3fEyr33iu3RhYbukk02DDkQ79XlaI66al4aRzPIvIpCz57rU0sownQ
 Ka5K3uyx4XzeFSu+iLGuUNYoDwLONlQP129aefkHJi6mXzLEFpLK7U4j888HLgYDHoch
 jPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716885123; x=1717489923;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVtRuMH7l26GoYmBK+IZ2kjg3Vz0LD7oKprQ1i3TIBs=;
 b=NqFoLpI88IihxneuNyHx81yRmtCprTyzT94OyvYW4O/7CSYhhuFNakSdXcCOilvDlQ
 v/TvsM2eKZIsnwt/Ga0Qv6OF3dGIpWVk1+5QTVYLibc4XgLvU5Cu3azV45all/w4xT08
 SjzJC7WL373b6o0x79cnC9hW7LfALLkFYKjPs13mJvmX2NLqiWw3iPH03/87IKSGWGkV
 1UCFnpQUnov1Xb4Gvfw1Cvi/mdcCnGoMw4bZS3kn+odVLkhP1TuLKHmO9HnAKfa/dq2c
 QiBLVd9t39m7KZPQ/I9KZjX7dW+ge/jIc6A7rsgnLFH2L0LITVT1BkFFkLvn8jyBuTNw
 ptTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn9CUF1AhcF5szKiD5yTl3E6ZE0/UZfyQWF8/s8fuADgH45PBTNyMPbbPfpIw5tVNJy2cCSnMzW+lkFmnSUxyGWqLdAA==
X-Gm-Message-State: AOJu0Ywk1ktmY0DjSlXVzvOtaSdgSQvk79yXHCbnVx+TQn9i/ekCsM8O
 SdTcpUt4tIDDN8SlFY9oX0ZfZMwEzGG6GB+/RzOrHd/5+npHcXPBflh7qjfR9fkreh0DxBnMkmU
 9
X-Google-Smtp-Source: AGHT+IGWS8Id1BFnXn3cZiCJJb32JPMXbVxJ9MWc8egId1C6wOkc1QkM1DNxe5rCNn65ZsB7aSYtiQ==
X-Received: by 2002:a05:600c:5104:b0:420:151e:b205 with SMTP id
 5b1f17b1804b1-42108a0d2a3mr77799645e9.39.1716885123147; 
 Tue, 28 May 2024 01:32:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee7f1dsm167122035e9.7.2024.05.28.01.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 01:32:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 May 2024 10:31:56 +0200
Subject: [PATCH 4/5] pinctrl: qcom: sm8550: add special pins pins
 configuration data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-topic-sm8x50-pinctrl-pinconf-v1-4-54d1e9ad7dfa@linaro.org>
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2477;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mCqdxYvyviBa+gYtwAdJ8kvTST3CqJK+05M0NWeGtiE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVZZ+B3guskyzsLYaJKsg+lzGm6J/IOVgPhRWSXi1
 h4CmoM6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlWWfgAKCRB33NvayMhJ0Z0PEA
 DQhlihuHMdQh9iwwrp4bun45Yh/zEtZ3sisGygLEYlLhclOZ4hDHfgCAD8pzluQdXTT3irWWWDqHvJ
 H9xRIHXB3EJYxiK5jR6LUZtJFrHn4k3MUpuVCsH6bope78p3Ws32Gortc86PVJaMPMgYmEiEPsFzVJ
 xNybmU7XbQ9oVSV8nk7ictpmprs2fUwvjPPASTpLfBL4h0+G+1y1V0a6VtuVKVU2FChP1WNUtGwbGq
 KM9U8GTBI+St3pzxJ7EkBRK+8zU8ulSL0p44/4/Vi26ZeRu5uGRQEyp7zRZqSlXC0kwFKMe44CKb/i
 qVhj7/rt1Oplz4MTwIMzYDzOqUx/lMdM39va50Jx/QtAqCvLGhr0QtYj7j0QrPQACHG7FiFQQD11Hd
 fBd9AQi/hjwpwEqPlnBnCSZ1HGE3dSYlp8t4LLlHjizl6Np1LHWxLORas87KbKET7eK1XllbLKQJcn
 C4l1gMz7ZpPRUWSh3oPNr8ZOZHPvry2UDkTdqeYmmdOTCLmCexdRU0M2TaxoiSexPEFRtAkprNF8CM
 GLasjbzDaOZ4RHotWE78xElWaMw6aBPn8AjOogad4uK/B//TeVNwQ1Eh4ClfHmygmMZNuou5m/ITM9
 CYx3fF3IzpW56n2K98nFavxS2DoARkmk+5RwQILKSI8ZvpjIXgWDm5MDyC4Q==
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

Add the special pins configuration data to allow setup the bias
of the UFS and SDCard pins on the SM8550 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8550.c | 42 ++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8550.c b/drivers/pinctrl/qcom/pinctrl-sm8550.c
index 7265cb73404..c65dfe0435e 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8550.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8550.c
@@ -18,6 +18,37 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
 	{"gpio", 0},
 };
 
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.pull_bit = pull,			\
+		.drv_bit = drv,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+	}
+
+#define UFS_RESET(pg_name, ctl, io)			\
+	{					        \
+		.name = pg_name,			\
+		.ctl_reg = ctl,				\
+		.io_reg = io,				\
+		.pull_bit = 3,				\
+		.drv_bit = 0,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = 0,				\
+	}
+
+static const struct msm_special_pin_data msm_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0xde000, 0xde004),
+	[1] = SDC_QDSD_PINGROUP("sdc2_clk", 0xd6000, 14, 6),
+	[2] = SDC_QDSD_PINGROUP("sdc2_cmd", 0xd6000, 11, 3),
+	[3] = SDC_QDSD_PINGROUP("sdc2_data", 0xd6000, 9, 0),
+};
+
 static const char *sm8550_get_function_name(struct udevice *dev,
 						 unsigned int selector)
 {
@@ -27,15 +58,9 @@ static const char *sm8550_get_function_name(struct udevice *dev,
 static const char *sm8550_get_pin_name(struct udevice *dev,
 					unsigned int selector)
 {
-	static const char *special_pins_names[] = {
-		"ufs_reset",
-		"sdc2_clk",
-		"sdc2_cmd",
-		"sdc2_data",
-	};
-
 	if (selector >= 210 && selector <= 213)
-		snprintf(pin_name, MAX_PIN_NAME_LEN, special_pins_names[selector - 210]);
+		snprintf(pin_name, MAX_PIN_NAME_LEN,
+			 msm_special_pins_data[selector - 210].name);
 	else
 		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
 
@@ -52,6 +77,7 @@ static struct msm_pinctrl_data sm8550_data = {
 	.pin_data = {
 		.pin_count = 214,
 		.special_pins_start = 210,
+		.special_pins_data = msm_special_pins_data,
 	},
 	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
 	.get_function_name = sm8550_get_function_name,

-- 
2.34.1

