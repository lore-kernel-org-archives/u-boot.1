Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DED7C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 795498753E;
	Wed, 24 Jan 2024 13:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BnxSJSmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7484D87BEE; Wed, 24 Jan 2024 13:47:30 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F170186D37
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 13:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40eb99a72dcso18698195e9.1
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 04:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706100447; x=1706705247; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PS6AjdPWBzKVqYOhBMydmkOHJ51S3TlLpazatsIz2lg=;
 b=BnxSJSmcxC92dxSPwARMeDmVy1zYJfU7/O4p391d/L6G6WaRC13ipJ8wYKDkOgMZEu
 BeO1VesFHJtiL4okHiT9UeOS38mKc7u7f9u+L2AU784VVKJUort0xcHiztzRErKG8PRV
 axck/dRHqDedi/MtpXJfA/JxARvXgXT08vdrfP2VV+dOthRzrdy1JJGonnyvv/f9mU9r
 4Da5lZfFFQYcV7Y3+HgEpXqEEyHXw4dxB3+bTBKENemto1kFVolbtD7kXUOpsywXInA4
 u1nzUARQ1wRL/h1bP4UeZt36/u/5YcfcaSMFrK4k0qfCnZu7H8yNjsUM0tmL+UMX/L22
 TNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706100447; x=1706705247;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PS6AjdPWBzKVqYOhBMydmkOHJ51S3TlLpazatsIz2lg=;
 b=oxNlT+JtoPxiIIGSut/TfP20JPW9kSTryhWHyhlLqf7JXAvoqz1slI1ojqgzVT8x/k
 EQCsCy4sE1F0trwSI5lDKBFlXxW7+RBTf1lOpu/1t6GoF64EZCE3zYRIVidpDm0HytbQ
 cx0CFFl1PSrTLvX776+Yk3M+oU7hU76fOsJLKqBuzMTh7Lnnu5WeFCfeDwxChQSyNNYy
 u+NcgNufbcWN8LnyyvvKMIj+ca2V5ZIGHOPj3mcyCuohh6bePYdC0G9Cj+mbBCa83aS4
 ntpnBlL3gW/ST6sErg0u8iF/NjZpp4ZnHyUo0OKxoqL/FM4CqtlUS5lrbj3yBN6Pz+NG
 T7qg==
X-Gm-Message-State: AOJu0Yy648VzHmI0a6mGIFS9d9g7JqMHcDvjJZaVGrxe25+WFbSKGhGG
 9ucQiE631bmAuTFBEZ52LLO9Vh7prJTEPrkFwQDvBumPbjkkW1wY6bqjd2Ks0yHj3NOmKTUOb8C
 V7RxQaw==
X-Google-Smtp-Source: AGHT+IE+TxL1U/FUABslv/x1K0v4nmNHquDwuz6r+ngtl5UaXKKrx71KBVLgc/RLKeAqafTwKyXQZQ==
X-Received: by 2002:a05:600c:3ba1:b0:40e:ccde:8a2b with SMTP id
 n33-20020a05600c3ba100b0040eccde8a2bmr26991wms.119.1706100447304; 
 Wed, 24 Jan 2024 04:47:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 p30-20020a05600c1d9e00b0040ec8330c8esm546060wms.30.2024.01.24.04.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 04:47:26 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 24 Jan 2024 13:47:25 +0100
Subject: [PATCH] ARM: meson: stop printing board model after sysinfo update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-u-boot-model-print-fix-v1-1-484960069623@linaro.org>
X-B4-Tracking: v=1; b=H4sIANwGsWUC/x2MSQqAMAwAvyI5G2iDC/oV8aA2akBbaVWE4t8tH
 mdgJkJgLxygzSJ4viWIswl0nsG0DnZhFJMYSFGhNBV44ejcibszvOHhxZ44y4OTIW5KU9VMGlJ
 8eE76H3f9+35dc7NhaAAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jlYHdtqMwvyt6WVSzocgomE9PmyhY7ElSsh3ssl7e9I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlsQbe5GMhrWfEXmtWiWFJ/gzUnG2JVLn0NOmfZ3FJ
 lTw0+TOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZbEG3gAKCRB33NvayMhJ0TMREA
 CbsXY9V8/BB0KmEw1IGEmYbqtacp9LFE7MA30fOfJch7+VWQLBrn8YbwZonJC88g5kPI2rqKWzdODc
 Z9NY1VxW9dmylHR9Ik37CeV2p8pM5lO2KqX9oyFZGy5YZubFYOOTwlwFxhpBdQbZ9TP0Mj9ASymhQh
 QuskkCnIvseKvLqlyiwPaaOdjEdcQfC4mRXIJ2oZIt5vxICaECchHs4UlPJ5PlTRUwwA5WDJxbneW1
 cKW3koKjGXLH2zUt0mEMsNZXSVCBy4zz3h3ev67ydtMpumQ66eW0ecPhYQpmjn+H8DJDER5Zh0BgkV
 FBEwJnlVz79ZV8r78f6Nyg2FFUuPb/vIoiKgbagNkqJGkhTZKT+JyCs/uBtj+y8lYDIVD3UcPI68HD
 Jzf9GtMkSiQmVK6qmGubarWzgIkX6h/cljgQjvdxDADZLloeyutcrE5w1xMrPqpDIJxoDyqoXcud36
 D/L5MsgDQrymoxXWVSQUKdMLAK2RQNqHORB56XGvzkyHhM/t/yir+2ASSK//ruSRXYtF2Om3mYOTPN
 0iAOHIDYL4bW7WRmEup2VhiQdtKuim1uW4bCZkkRuoSDMoI2HRLhVN0VxJtK6vlOPqGZS9FEe7sq7H
 C5+u+U9rjsxzfjJN8vVZZq7ivPvyTUcBmgMZWrBnlz/DY7FDYNqFYgn++3oQ==
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

After the sysinfo update, Model is printed twice, remove
the now duplicate Model print from mach-meson/board-info.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/board-info.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
index 95a29da072..d51d9b8f06 100644
--- a/arch/arm/mach-meson/board-info.c
+++ b/arch/arm/mach-meson/board-info.c
@@ -126,13 +126,6 @@ static const char *socinfo_to_soc_id(u32 socinfo)
 	return "Unknown";
 }
 
-static void print_board_model(void)
-{
-	const char *model;
-	model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
-	printf("Model: %s\n", model ? model : "Unknown");
-}
-
 static unsigned int get_socinfo(void)
 {
 	struct regmap *regmap;
@@ -172,9 +165,6 @@ int checkboard(void)
 {
 	unsigned int socinfo;
 
-	/* print board information */
-	print_board_model();
-
 	socinfo = get_socinfo();
 	if (!socinfo)
 		return 0;

---
base-commit: 15e7927b5a2d33666af19879577bf0c30ab088fe
change-id: 20240124-u-boot-model-print-fix-cd2e95d67e21

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

