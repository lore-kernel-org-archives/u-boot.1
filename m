Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C260EC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:23:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4364E8808D;
	Tue, 19 Mar 2024 13:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xoC0PfjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087A887F50; Tue, 19 Mar 2024 13:22:46 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3DA188008
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e672e10cfso2853619f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850960; x=1711455760; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ik/CLzowJAROYo2NgNmeQLOoeZUcDXxXLIxLTfZ4zUQ=;
 b=xoC0PfjWXvUea8bI7H6KaKg5ggelweOeEpbR5/WfaVJwClT0pd9NitQknH2EKZuCmB
 V/dVrqqr6/JQ53FcUfKKI7E3Deci3os0LJ8BhXE3GPNpOtHOZ30E2BcIKnNd4xhiyAWg
 ZccK1JAaLAWuV0otHen3N05Um5YdeKEuWMLRc5ziXnQ2DYoQ/m74JSz4rwHG+ZiCPC0z
 ivlTY369Aj7lgx9MyZqltZQy1GaRwFNOfKNmWWDqnTO77LgwZqxdlJrpdgyGSeY8PR0Y
 IN0vtDZ6TqrpF+2i2EUlDdHNuMiwi1YIDRaUcFDveHG/lm+82OWtavpYHZdvw3dpGcil
 OWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850960; x=1711455760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ik/CLzowJAROYo2NgNmeQLOoeZUcDXxXLIxLTfZ4zUQ=;
 b=oM1xEqTISUdEqavnb8pJyRbtc35Edvg4ULC0sYqUrSsdfqrrIpOQQvCY0KTyMd619M
 cxQLIA3ZkD1YJglFql5yk2/E+SG7NocEKLHlDib0tZPHH1fFhs+0faot2utq3ShwSfav
 Q5mLTTN+QeCINBfsu+voVqeAjjcYYfbF0QR7cyESHI6AcMZ/ILXjgzozuh7bqjCsX5Ve
 vrGC0RCwr/r14olljDjZKklLT8TMVmMMZXKWCJ773OJLGQPcU59SKnjOI0z3pem6EqHW
 CF8TcRLLpUzJqwPOtK9kZoQaLhFD+FV53EhLlvcp6oUIxsFyUAktuG7K5ySjB/xufZlE
 PDgA==
X-Gm-Message-State: AOJu0YxsJah5ueeJrm0BSwdJr2oPF0ri4NJ6qDrDlR4n6/dCvWNyH21h
 m83IZ2jN0toQqtYuh4Mzi8JGRDwdFzpc2zBWJqO/6w8j8rZDqg5ksIEFCcucS2C42LrxndLNUNN
 7
X-Google-Smtp-Source: AGHT+IFFx6GmXDCjZQV7MT+jjpKMNZTkmx7HPQ716q+j+ZrcvpFlxCoyQmOOeKTm+2/TymTwqCshMg==
X-Received: by 2002:a05:6000:b87:b0:33e:34aa:d78a with SMTP id
 dl7-20020a0560000b8700b0033e34aad78amr1702756wrb.8.1710850960392; 
 Tue, 19 Mar 2024 05:22:40 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:39 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:03 +0000
Subject: [PATCH v3 04/14] mach-snapdragon: disable power-domains for
 pre-reloc drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-4-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=t1kvVGeh4i1zKEXYViR55Wh180+iwZWUeqzwnZOWrZs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzZ1vWo9V/rZMu7Tp8rmbdaVK22R6rmZ/Wl4+xfj59
 CV+phdZO0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBE/BMZGRZxiknpmYtEPrhe
 eStJe039nIVzak8nbk1pL97DPH3mBHeG/7F5tQLfX4SXr3u5VXB97Bz+8Js30tIOGgvucYndrJZ
 ntB4A
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

Some devices like the UART and clock controller reference an RPM(h)
power domain. We don't support this device in U-Boot, so add
DM_FLAG_DEFAULT_PD_CTRL_OFF to tell DM core not to try and enable the
power domain.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcom.c    | 2 ++
 drivers/clk/qcom/clock-sdm845.c  | 2 +-
 drivers/serial/serial_msm_geni.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 7a5938a06a34..6303dcbf8461 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -226,8 +226,9 @@ U_BOOT_DRIVER(qcom_clk) = {
 	.id		= UCLASS_CLK,
 	.ops		= &msm_clk_ops,
 	.priv_auto	= sizeof(struct msm_clk_priv),
 	.probe		= msm_clk_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
 int qcom_cc_bind(struct udevice *parent)
 {
@@ -410,5 +411,6 @@ U_BOOT_DRIVER(qcom_power) = {
 	.name = "qcom_power",
 	.id = UCLASS_POWER_DOMAIN,
 	.ops = &qcom_power_ops,
 	.probe = qcom_power_probe,
+	.flags = DM_FLAG_PRE_RELOC,
 };
diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index 36ffee79d966..babd83119e2c 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -182,6 +182,6 @@ U_BOOT_DRIVER(gcc_sdm845) = {
 	.name		= "gcc_sdm845",
 	.id		= UCLASS_NOP,
 	.of_match	= gcc_sdm845_of_match,
 	.bind		= qcom_cc_bind,
-	.flags		= DM_FLAG_PRE_RELOC,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index e5c3dcffc1c6..4aa0bc8c72bc 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -602,9 +602,9 @@ U_BOOT_DRIVER(serial_msm_geni) = {
 	.of_to_plat = msm_serial_ofdata_to_platdata,
 	.priv_auto = sizeof(struct msm_serial_data),
 	.probe = msm_serial_probe,
 	.ops = &msm_serial_ops,
-	.flags = DM_FLAG_PRE_RELOC,
+	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
 };
 
 #ifdef CONFIG_DEBUG_UART_MSM_GENI
 

-- 
2.44.0

