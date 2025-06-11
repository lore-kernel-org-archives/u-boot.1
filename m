Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F057C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 12:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F4382CD9;
	Wed, 11 Jun 2025 14:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="D0/7FjS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C05582B63; Wed, 11 Jun 2025 14:09:02 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA1282C4D
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 14:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-605b9488c28so10550783a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 05:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1749643739; x=1750248539; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WeOfVW1VqhkxWbehjih5ntesVttPt/Ce2tw/6ZQ0ZEI=;
 b=D0/7FjS2bzqSuCZFElrYFovWVa9PPa6h0IdrCrnrHJkz3u7FiRq0BKQnVy8rLP+qwg
 BM7k3SaNJwIH1KB48R/MoVv6n2gwesIvBc7YrtqVCe33hj4rMFLH9SednI4uvsjVr97r
 dbfRKTk6JMWtsmmdSTSqmYmFBUN+WNDtki7qsI1qjO/QuemczNPbYheuGfEMXIi80gvy
 RdGhzExBxFP4RS5N/ac8k+EYFe68N+L9JQ2oDGQ4PlGPAiUaB7MKJ+BqBWodHqCoBMEp
 FpzunePlWI1oiDUPfOtbUNBs9PK8MpzFwTjKDYwIPvjhw6wGYHXqUCxaSpIYFzlgflfy
 wmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749643739; x=1750248539;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WeOfVW1VqhkxWbehjih5ntesVttPt/Ce2tw/6ZQ0ZEI=;
 b=qGcqgmYjJvOEFbGBcrsbHRdBQoiCbyotewRNqicvZTEww10WC9fFnJ9XixI+uM/P5Y
 AlYTiYi8+rGIDxYCIq/VJNT+Tph4nXmeq79bXWvrMjqFcUn2k/35lyI8HLa0FZc5NHlz
 T0WEuVcTYlRaixHRG8NajvhB9u2/+M0u1+sSl0LxZPhcAnNz4O4wYnssbJBgiHAXWip4
 oeIAuPyZ/tX31CEPh95eRcWgnn0wwxCiFxzPkd4YNhhu1nCD9OTYK5hBnFHGAPAfKItq
 w7NrDqjsaFcYIaDROrt9OvsT0S1wqnI8t654zP9sPDiTBTSnbAiI2TPMUdwXBYs3D5/k
 KQEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJXs0ZiYdrvhmcjGN11UAInDYOh3fR69IR2pdDVidJSOOIIjF7F58Rw9TnfX9Qae/wc0Kj/dM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4vUd+A6t+BBS9zmq3TzFVLuo2RswT/YEKySuseelhsDvHlU1g
 r/UFO2lAMjDDXtX9t0XG8LkA6COU33Pg4L6/xMhMQ0YfBBTdRGIpAkmXsYoAxOdT/rg=
X-Gm-Gg: ASbGncs4woJ/iQOOv7Kyz2JBpEk6t36HT8jIpivMi6Jxt8zmdE88Qr5mM9P8TDtUNhF
 gdKcwa21ajG1yiPv0KLqWJXc9QXFCB67glG4aWXKNmmTcOxjtWW/sINBeounl+xClbzeseNW012
 ZaGD9Y7vg8ssrUXmT2F+BJxIuGVQiCs4J0TPIhDAzXNhqIMDY7DlMHgYB+qWVWWvs3fsyMKOZoD
 ZbI2Mq/Px0Y7PF/J0nrfQDRYXtPzIwZhfmxLx1FHk1GtenNXLN+HheAYFL503wWH7CxudnqAqqx
 VPKM5GxHb5fDqMx9pAqc7N5qpIJR2QzFrOZs1R9AK5GZ+BNoPtMwpZGpRXWKM6MrIyrZ3eDfeq+
 nkyn0j6+g3as5Fo5GLtBM5gpW5sjSnP/6Dv65jmNZrg4=
X-Google-Smtp-Source: AGHT+IFWiA7PKLUD7r0q7g3OTGxRBo610ojHbxsRXRSntX4i9xq4eiml4xiJMubkosZPKf0nIW1Rtg==
X-Received: by 2002:a17:907:7250:b0:adb:428f:f735 with SMTP id
 a640c23a62f3a-ade8c72a119mr266823366b.12.1749643738958; 
 Wed, 11 Jun 2025 05:08:58 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc39c34sm870512266b.117.2025.06.11.05.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 05:08:58 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Jun 2025 14:08:45 +0200
Subject: [PATCH 2/2] clk/qcom: sm8250: Fix variable name of msm_clk_data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-qcom-clk-variable-names-v1-2-37615b74daad@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749643737; l=1131;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=h/2F11bQmvZzKmJNVdfrqEo87+lIaGG3+yCmwRHbimQ=;
 b=pp5DcLa0heEshGxEmda8hT35m+mzQfQF/lnCHem5S3VbjTyMrjzLQTKgRMPCcQw0djbPp4kbd
 vEzzOnmsSxmD1uJJp1Er48h5+g/8MOQfdnWL+8GtSI4ovWiz43530ob
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

Update the variable name to sm8250_gcc_data as it's in the sc7280
driver.

Fixes: dcd688229cb ("clk/qcom: add driver for sm8250 GCC")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/clock-sm8250.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
index 26396847d85964d5056cf9af62b8bc89be34dc43..cc481258d2266a40c54d51fd2c5faee22ea9f2cc 100644
--- a/drivers/clk/qcom/clock-sm8250.c
+++ b/drivers/clk/qcom/clock-sm8250.c
@@ -360,7 +360,7 @@ static const char *const sm8250_rcg_names[] = {
 	"GCC_PCIE_2_AUX_CMD_RCGR",
 };
 
-static struct msm_clk_data qcs404_gcc_data = {
+static struct msm_clk_data sm8250_gcc_data = {
 	.resets = sm8250_gcc_resets,
 	.num_resets = ARRAY_SIZE(sm8250_gcc_resets),
 	.clks = sm8250_clks,
@@ -381,7 +381,7 @@ static struct msm_clk_data qcs404_gcc_data = {
 static const struct udevice_id gcc_sm8250_of_match[] = {
 	{
 		.compatible = "qcom,gcc-sm8250",
-		.data = (ulong)&qcs404_gcc_data,
+		.data = (ulong)&sm8250_gcc_data,
 	},
 	{}
 };

-- 
2.49.0

