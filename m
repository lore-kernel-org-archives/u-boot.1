Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1287C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:05:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440AF87786;
	Tue, 19 Dec 2023 17:04:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q0iLPdAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84BB5876F7; Tue, 19 Dec 2023 17:04:34 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 907DD87705
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d2e5e8d1dso3980085e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001867; x=1703606667; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QiBmtbjZUgEcqLlXdvcmsZskO1Rn1r1FSdqFrkP2Nt0=;
 b=Q0iLPdAW0RRAJIcWZ0g7QzHVYikBnj73gCPqnT02KxWC4FBhWwSsHRvb2/8mZRLyL3
 QcTeIL2W6bbcSVngufk48u25nEfbWdJKH4/v+FvAFqmKGtC0HbzMRP+8NpjQgEzNBJvI
 3qiQndDRTgtOzHlRxvD3kYcNZnVWsC38RXhvEIXlRu6H7LnRHQHxhJUJZEpEAv0W5wQy
 BM56JzQBnwv2KBfgCfq4Tkvqs2ygdW5+Bl/+rO3STnOSjohfuapN+3rnUAs1khh14HNr
 XQKuBh2iMYm6umYrQJAD0EwwmKFAA6HCtkyLjEBcfnT9SjejcscgA5gTVJMw9z23f9+P
 w3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001867; x=1703606667;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiBmtbjZUgEcqLlXdvcmsZskO1Rn1r1FSdqFrkP2Nt0=;
 b=o94+dcbs49P8Thvjo+rgjgg+ENTMZuUmOtzHV/rNOJX8oaSmtyLAVga/t9Is+6VRui
 8/xKJ9Z2y6d5vUW2Q56eoZelnd+S3+PMn8XTMhpe9ZxSJ29UQ9E5SvuadKenBIvfDwiU
 FNudI0MSItwSf9PVTcOjqXFRQVn7xCKLfmpt06ZWfnCZktG4kMDLG7Qc2n7ZIPAZAO35
 lcuyttG/YuRATvZOeM+SJ4XeZ6Kbon/brdNOpW0CqoEho3CsDUnCgvx+/NfeOmZlXoHG
 71riNDjln76lS8z+zH5vW99Rekj5GecLG6BWAIt7pcirg23RgUX8I1hjfr/cMnW4vgge
 rI7A==
X-Gm-Message-State: AOJu0YzTQzNdg4wi93Erp7AipA2paA3DX76fpVo63CHQUw6QyZIo2H21
 RT68Z9b3fEfr6rb+42DkjFab6A==
X-Google-Smtp-Source: AGHT+IHcBqkYigw27vW//AU1Qo3hqjLJdcMFJEeQUpviXA0QZeuyJWSVxGVp5nlvtrZTc2XJ4Wfq4A==
X-Received: by 2002:a05:600c:2a8d:b0:40c:1da7:a5fe with SMTP id
 x13-20020a05600c2a8d00b0040c1da7a5femr6722536wmd.25.1703001867189; 
 Tue, 19 Dec 2023 08:04:27 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:26 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:06 +0000
Subject: [PATCH v2 05/32] clk/qcom: use upstream compatible properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-5-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gKr87lVRqUOoN68BAsbJs8gqpiVUVEWCMjXxBq6PkmM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/UxCJv/fiVy4O3VPj1/fxiLJyo13Q5ZzXZH9s2zlH
 WfmaOH2jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCR/byMDMsmiDdO6z34pzxH
 Z8sPjvbwpEfNxadErz/1S4mdkT5logbDX9ltIazRqXvSIr4eCgiM+/TN7m7vGz4dIY0gcZn/Kw6
 u5AAA
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

Adjust the apq8016 and apq8096 drivers to use the upstream compatible
properties, and adjust the associated dts files in U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/dragonboard410c.dts | 2 +-
 drivers/clk/qcom/clock-apq8016.c | 2 +-
 drivers/clk/qcom/clock-apq8096.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
index 6a4e3ccf17b1..02c824d0226c 100644
--- a/arch/arm/dts/dragonboard410c.dts
+++ b/arch/arm/dts/dragonboard410c.dts
@@ -75,7 +75,7 @@
 			};
 		};
 		clkc: qcom,gcc@1800000 {
-			compatible = "qcom,gcc-apq8016";
+			compatible = "qcom,gcc-msm8916";
 			reg = <0x1800000 0x80000>;
 			#address-cells = <0x1>;
 			#size-cells = <0x0>;
diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index c0ce570edc79..0af7191cff52 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -145,7 +145,7 @@ static struct msm_clk_data apq8016_clk_data = {
 
 static const struct udevice_id gcc_apq8016_of_match[] = {
 	{
-		.compatible = "qcom,gcc-apq8016",
+		.compatible = "qcom,gcc-msm8916",
 		.data = (ulong)&apq8016_clk_data,
 	},
 	{ }
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index cf1a347309a5..1e6fdb5cd42d 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -123,7 +123,7 @@ static struct msm_clk_data apq8096_clk_data = {
 
 static const struct udevice_id gcc_apq8096_of_match[] = {
 	{
-		.compatible = "qcom,gcc-apq8096",
+		.compatible = "qcom,gcc-msm8996",
 		.data = (ulong)&apq8096_clk_data,
 	},
 	{ }

-- 
2.42.1

