Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBCDC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CF782CC9;
	Wed, 11 Jun 2025 14:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="utZvywu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0475682C30; Wed, 11 Jun 2025 14:09:02 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D5A82C44
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 14:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6077d0b9bbeso9108695a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 05:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1749643738; x=1750248538; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ugb6xj+m4RGElIwFQ1p0z5Cg2czp/4H7mC/vhixAl0w=;
 b=utZvywu/l04sMby+IK4KwXGtm9YolMUuHYAyYVxD9aB/YA6k6LBRX4hrhit7YvE3HN
 hqlbzkiwqIZuueiME7O1Dyf5WZ4ihNo3hk8cABq52nGsryMxc7GpF4tLn7jS2DXP0Bzs
 qctqMV04w31pyyes7xTMh5JYa8fV0fwRDttFePHomC/TpQ2L6wp1aeVRZs8yg05P13IN
 Voej92aPfLgMrML6Tkt5EvmvZpip8MpApowG1xYeIocr0UOm+3J/9ne71MKVkZAQ2/7i
 4Yvo07SzutU0SN74rdNQtJYbiR6VzYsFOC8wsgNow8JBx4p98gTn6LoxbKJTQKKCtjCl
 djyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749643738; x=1750248538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugb6xj+m4RGElIwFQ1p0z5Cg2czp/4H7mC/vhixAl0w=;
 b=RFP6cTaHHfzycdaKngekjoCvH7vtDev4sfEOTk2pX5M2NmXNDDgHAstLy7SI8AzTu/
 TqYErOv2m0hI0Cpjr5dq1/7kdC84w5EXB2xF3vQGB6tY2csMJGDaRSKgAxEu8gooTsFn
 D6lDE/Qd+rC9/TxbEFIQrMVsNdayPcyGxlQ1O/8lfKV/0oe7twahT0rrbMERtJ+FA3zM
 kmMmH/7buSCeiSOjCcX5KqEyLuj9kFlHEVfshNLY4rF5FwGfgUVP/pWDkYZ5190jxSh5
 4WcW9KmeWCD5ksZW97qpOG2Aew4KA9p6fQG4OsOn2iQ+SvxeCHpQOHovlb8nIy/3C3Mn
 aDuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyjLAkqsbwzEpLTKmHD1w3V85w1/0sDmLnSjLQURPjPv2flUyBHixUiAP+e5qNBSAjNEm7+aA=@lists.denx.de
X-Gm-Message-State: AOJu0YxJCLnywncHgHW7Zo6yDclR6el3yr5yPM+i5I1KCwflcnjacnt3
 D1e3LbIXGilmC3Mqls+s2VJAyH0fCvk1A6GFEsJOTOMpH8RaoJY+CJtipcLyu1pXQ6Y=
X-Gm-Gg: ASbGncvQH6U6hDjz9klqFSPixntXV3efHcA2n9ETVj6vUAQmD/J47vQcKU+enw8o3nX
 W1qkpsLZZzXXvy/QCMJ0DlC8JgspxoJ3QqnEFQb+55PT7Zd1XdWpBOSmjI+SdbKrI2sLNjoJhM/
 Yuh/d5tAejbkeuUFe7HaNxQamN9sjV3tMfvI7jca77C1ZaAFDtuORJtvAnLmWiQrU9maO+UMUrL
 s65wAAg9qzguJllsqWSluoiiWv6nw+62YFH6EloeanHf7HVMREXgRMR2nOWJzUpaMOJwGAPL6A1
 wECMQGuqTf+yFZng+GaZ9aOB23W16O0EXV8xV7RaU9sUyIm8psxLHdZGtP5YxB1/qIasJYxzj+H
 Q14dvu9JOK9yIsj58QNQuMYUZ3yRwxK++
X-Google-Smtp-Source: AGHT+IEcOzpbuYgiMwQqeU2QY6JRIpEn2lfFGnbzmEr0D1EbQpWWv4Cj+wGJPjKKTkvzfr5X/8CEPw==
X-Received: by 2002:a17:907:9688:b0:ad9:adc3:20d4 with SMTP id
 a640c23a62f3a-ade8c72b5a6mr266474866b.4.1749643738166; 
 Wed, 11 Jun 2025 05:08:58 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc39c34sm870512266b.117.2025.06.11.05.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 05:08:57 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Jun 2025 14:08:44 +0200
Subject: [PATCH 1/2] clk/qcom: sc7280: Fix variable name of msm_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-qcom-clk-variable-names-v1-1-37615b74daad@fairphone.com>
References: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
In-Reply-To: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749643737; l=1141;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=QBTwjAzEvDBX50Dt94eV7SrdKNaQcNXnR+TQXsrroRA=;
 b=enThvDWOrhM5uFUmpZkGtWwn2lUBD9sPzy0xASeqqjhvh+FVA09S6XazfjGvtCR5l9H+WlPpW
 Ll5ESekehvSBbzEnKlKpIyuJpvEgT1kQlbA2xOdcNBsnmps6g9ozo2J
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Jun 2025 14:37:25 +0200
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

Update the variable name to sc7280_gcc_data as it's in the sc7280
driver.

Fixes: f50e7be6bb1 ("clk/qcom: add initial clock driver for sc7280")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/clock-sc7280.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 9aff8a847ad1bd59b7ec7246f5719e4d7c32ec65..47e0ca5f0e5ce37b8c0f78f3be32ab9c519e471f 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -205,7 +205,7 @@ static const char *const sc7280_rcg_names[] = {
 	"GCC_PCIE_1_AUX_CLK_SRC",
 };
 
-static struct msm_clk_data qcs404_gcc_data = {
+static struct msm_clk_data sc7280_gcc_data = {
 	.resets = sc7280_gcc_resets,
 	.num_resets = ARRAY_SIZE(sc7280_gcc_resets),
 	.clks = sc7280_clks,
@@ -225,7 +225,7 @@ static struct msm_clk_data qcs404_gcc_data = {
 static const struct udevice_id gcc_sc7280_of_match[] = {
 	{
 		.compatible = "qcom,gcc-sc7280",
-		.data = (ulong)&qcs404_gcc_data,
+		.data = (ulong)&sc7280_gcc_data,
 	},
 	{ }
 };

-- 
2.49.0

