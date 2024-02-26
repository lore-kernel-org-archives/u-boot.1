Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CF8C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:27:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C9D87F2B;
	Mon, 26 Feb 2024 18:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TEKzpBpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C7F87F6E; Mon, 26 Feb 2024 18:26:33 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F60F87F34
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412a7b68809so6056395e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968387; x=1709573187; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PLCxfquOFP5eGC757z8vqBm6UqLEUigh/y7meanjeTA=;
 b=TEKzpBpvsHRA/tR9ToX3r/2KUWxjLfgYf4RwSe9yP0R1U2LnR1gYMUP5ZBTEAsaB/y
 lXc7ng/mCAm/fpNN0MRH6+Nha70KBQOsgJ9aFReLkPiZTIzM1lGAldohlkKKC7vbBYOX
 iUEu4oh+lDBWTthng/y964y29NSObZRfoHDe5ul3Uf4+qE2waeQF6FHtXCzxum5aeHys
 iwr/rGiS3eQ6fd1cUaU7iHNy1fJQ5/U7bMw2XRRJWfSgyemVhPEznWFGuyQ/Uso1bw7V
 fNm+FdBECmEHPo6zy2ffJiwpwfTNArHS/G/6H5K+joPOftLYsThUF48lM7q0x1/GFuqU
 LiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968387; x=1709573187;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLCxfquOFP5eGC757z8vqBm6UqLEUigh/y7meanjeTA=;
 b=pBxT35bTKDZL1wvsDPrXhBbQb0eqiA6OZU9jr3MJFvfa3F8AF+zzLGAFH6nkaBcwSj
 flla0CsgFeV154/rhdkN2KFSOgEOIq/vH7gw7I6itBoqU3Cpzv20MYpcQwCe7J7pYkSJ
 fUDYZxUCoJdzzfg6HfF+r9hB83vQKAfYAKBI6zVA2kz0Qnc+lSa6TW/ETUdZyJW2kLSP
 i0F07LAx/ByewD5Yt3H6eicD8dLGQRLLasHhp1z954bkwOyCGMfsBReRPbiP4ZIqLXOH
 i/HxI/ge2Zxm5BtD2Ohg8RB5ot12qW2A7u6ikNyr3PscrLf0Lz616uVCl5trkPL437Xk
 KVlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsMWbY3JK0OxKphmCjGVmAZja4YxppocKRbtbNns5pntZnnJXfNPh9DjfKw/xO0R07ontswFKXi14pRF45KBiUEKAivw==
X-Gm-Message-State: AOJu0YywfkmLAE108f7abbo8wOpzWgwbC7TB4d20AnN1mrOkyEVERczC
 CsJgEhimALMNLkWdl9W0nr1zPgZdLaxyfuVfdSDHkg3OPzYJr/QLXi7aa34k6bY=
X-Google-Smtp-Source: AGHT+IFaW3r3MrFiXEzcOyDlBSxJEdY5VkIQ+FPgWh9S2sxEWCOOlK00w+FTdUorLxCu90Bo4n1dfA==
X-Received: by 2002:a05:600c:4f0c:b0:412:a123:492f with SMTP id
 l12-20020a05600c4f0c00b00412a123492fmr3808334wmq.35.1708968387080; 
 Mon, 26 Feb 2024 09:26:27 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:26 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:09 +0000
Subject: [PATCH v5 05/39] clk/qcom: use upstream compatible properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-5-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=EPnr5aaQ8q6sWPeR3jcOX1xa/jyqbhitNxQLHwc8lKQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3caPOrqX3RCvGW99z7rsyu+ZXiKRdqove6MsGucF
 GzznOt9RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIUimG/0FmdauvG14N3Vfj
 NbW+/+jNU9dsU0uvccrPXxjLyxBboMTwz8Z39qpft6+4t8bac/+TLCiYcDuh8MH042l//xc21Ka
 vSwYA
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
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
@@ -74,9 +74,9 @@
 				bias-disable;
 			};
 		};
 		clkc: qcom,gcc@1800000 {
-			compatible = "qcom,gcc-apq8016";
+			compatible = "qcom,gcc-msm8916";
 			reg = <0x1800000 0x80000>;
 			#address-cells = <0x1>;
 			#size-cells = <0x0>;
 		};
diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index c0ce570edc79..0af7191cff52 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -144,9 +144,9 @@ static struct msm_clk_data apq8016_clk_data = {
 };
 
 static const struct udevice_id gcc_apq8016_of_match[] = {
 	{
-		.compatible = "qcom,gcc-apq8016",
+		.compatible = "qcom,gcc-msm8916",
 		.data = (ulong)&apq8016_clk_data,
 	},
 	{ }
 };
diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
index cf1a347309a5..1e6fdb5cd42d 100644
--- a/drivers/clk/qcom/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -122,9 +122,9 @@ static struct msm_clk_data apq8096_clk_data = {
 };
 
 static const struct udevice_id gcc_apq8096_of_match[] = {
 	{
-		.compatible = "qcom,gcc-apq8096",
+		.compatible = "qcom,gcc-msm8996",
 		.data = (ulong)&apq8096_clk_data,
 	},
 	{ }
 };

-- 
2.43.1

