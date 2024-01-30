Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F0CC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EF4D87E21;
	Tue, 30 Jan 2024 15:05:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sB3imAKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADAE787D74; Tue, 30 Jan 2024 15:05:19 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA12387DFB
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51032e62171so4145605e87.3
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623515; x=1707228315; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KU1YHoCgnWIVFbuhh9OyDISgcFujxFWKm0Q2AwhSJUo=;
 b=sB3imAKo3QLLM/xINxFiIoCRWn5Dod2TX96EXxQz4Uf2+3M7WBKobvt7MAUCfL/PHo
 u8lKVCnYaPYgGpPy9lh/jHuNs6Ria1T5y+vvNzwDqrDlofEyFtozDouZJvz6Nbhz70w7
 uv8nU23HgBtz1+QAvNGOKQAq3iyJQJDKBGUSjvg5pcynr92R8VeIwJ/SyytmTksSQ5LN
 xoyKGJklkc0QtelNoAbTjVALK4YJH8ldYOoCf/jGzFd6/dfTvCOwu437futyn8q1Twsy
 DN7RJyL/rbEN6bx9fUrtuqbMzlsx3vCahXtX14bUqQ9Eme3a4nmv5Wy6bgekFV4NtaMq
 FagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623515; x=1707228315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KU1YHoCgnWIVFbuhh9OyDISgcFujxFWKm0Q2AwhSJUo=;
 b=ooCn61Y9xD0rRwFezwnQPx6k5409+wi3beM5aoygD0IDTFUtjeVMszmpf7QQXItPLe
 Jj9aZe5LNt0EOyWYs4PeyXKz6i3J2jHudrm5g2+wiJH5APnGn6O29O2pb3O7xcIrTGrI
 Kir3e4wXEK+LD3V9VzGQbvYZZXR35+DqEYvr2gdVJS5nQ3bxp4VmQn53eUfcAtjkaIF1
 1JLExiMifFtdsP1FdwUPhwvarGyc1JrmJqY5iAO1jwzDC7qyiJh67ThntadjiY6SfEwM
 yNLmT7R5yV5TRtAcOyalpMOuwn5qxF8l1Uwsuiq+Wh5pg3e2mmVNd+APENB/SoyF5Qer
 FtlQ==
X-Gm-Message-State: AOJu0YygiPJAWRYuRlIzPsCoufUHHL8QJ0rPH0+TPmQRhrcEYVQtx+wM
 wtFncBpjBjf+Fk98S4neI63set4oqIYzeu7j5voE2QmZlDlUjpwyqkpMYTBTFd8=
X-Google-Smtp-Source: AGHT+IHa+veB1OPdc0ZtEsm9+ZHGFpL4d2WzmD8o82DSK5frVevtQb376+PMRjGhxEk+9tYG1qsubQ==
X-Received: by 2002:a19:6406:0:b0:511:17b6:5dc5 with SMTP id
 y6-20020a196406000000b0051117b65dc5mr1933067lfb.12.1706623515066; 
 Tue, 30 Jan 2024 06:05:15 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:14 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:04:54 +0000
Subject: [PATCH v3 06/36] clock/qcom: qcs404: fix clk_set_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-6-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ZOd9uPKxeZ3ipUmnwBb71i0WJ7wJt+3B4De0gEOoyPQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTALcJzIbLdyqkw66XBXWeXf64oK2xbGs07p/eRdtL
 c5MmpvaUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbiP4eRYe9t4w9vSrRYYk62
 KOvc2NO/Jykg/MvnYMW4oGP9LB5/eBgZ+lYcjj+1mC9rw06NnzGMtj8+zH9WrSt9nqWAj/NH1Vq
 79wA=
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

We should be returning the rate that we set the clock to, drivers like
MMC rely on this. So fix it.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-qcs404.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index f5b352803927..03fd65a9328b 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -207,7 +207,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 				     CFG_CLK_SRC_GPLL0, 8);
 		clk_enable_gpll0(priv->base, &gpll0_vote_clk);
 		clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
-		break;
+		return rate;
 	case GCC_SDCC1_AHB_CLK:
 		clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
 		break;
@@ -224,11 +224,10 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
 		else if (rate == 5000000)
 			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
 					     CFG_CLK_SRC_GPLL1, 8);
-		break;
-	default:
-		return 0;
+		return rate;
 	}
 
+	log_warning("Unknown clock id %ld\n", clk->id);
 	return 0;
 }
 

-- 
2.43.0

