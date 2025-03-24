Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F07CC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 18:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E38E9811AC;
	Mon, 24 Mar 2025 19:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LOqgVnsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF2DF809D0; Mon, 24 Mar 2025 19:17:51 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36D8F809D0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3913d45a148so3857833f8f.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742840268; x=1743445068; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zU6ohVIXEFl7wyAEdcIXuZ8oe5tYvcDPmifdWbp4rXw=;
 b=LOqgVnszyCoYizuHgzYfqRw+DCLOIbbuWmiFuqu/jvVZPc4pFp0ehRSuFKlADlgkmK
 o9NEO9FB1lEqhRhI5zt6pwyJYZl2hCp9AQuJAeFmvtpshN0uWt5gB8YQ7CC20bZLCiQC
 5s7OdNkX4oiazYS6pMmQf9Tv5/gr2D2mtQSsWc02r+Wp2SkzuMvzWKx8AQJ2ts4m/51k
 uovPofVXkprGMVmEzGTn9mEj+3Uv1Q6mAFP8dpttkLI9xEmL1mrq/3cbTpQbEhl/F3ax
 jWk1+2gi81gSVSE0gkX0QVN3kjQYESJU7GYYEGs0shlmwrlR/kmxVaq9SmhlAUKTx2lb
 ZbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840268; x=1743445068;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zU6ohVIXEFl7wyAEdcIXuZ8oe5tYvcDPmifdWbp4rXw=;
 b=q7m8KuI5SdTLntcpOHQJo3nLw8BDs3N+cbE1Hlsqn2DRH5TmO4mCwmqAklFnGsCnYM
 4papaqFd/pWciISFc5/KnfOiNrBy/calPoDwirjaITWYY5wthGVGeCOLdSXQix+ufv+G
 IUbjc3xDzFurYiWXkZYwVm0tSzYHtPSvZL0Q0WdBrRC/afEax6uVgcO6W78iNkCk3n7q
 dKY19kmGjjMLjMHsrjNcCndl04xojdTDspeAsQCEG5KFiZEoABWpQMDTNZewQLwBDVbQ
 VknEDWb1hDMKHN/pzsE2Dz7pCTlqSk9+iTFuW9QLDNPa6T3agHpArNcVZ/oRr1fjPKmM
 2lRw==
X-Gm-Message-State: AOJu0YxeQsYdP+APm7qVyltaTTlbCVHdZ2EurGZEX+wfveZUVCYdVgFV
 tJnG+bVvSk1FBEAbIz1CfO/2/LQ2OXi6FCebanHlPOFjLae4HCWY8ytyuwIAQso=
X-Gm-Gg: ASbGnctvKfMcu6bMHLCc1DjQdLoP0c8MHzw1sYk11rHAogS70uTyXU/tInf+cxffugY
 ifFvcZ8X3yPm4r6s71+raHIG/+Ero1d9p+YHDQWpYpOI/1ZCz4p+TX7e+8s1tdLqNZSXSFTFdfg
 fhBGM2x2/DTHRhiBG3hrP6nh6nJiWxDLR/9eRCqqxKp3i/5yLCQVAwyOrH75zlnmoHLDe0F22WQ
 mAxkGJ/nnuQYedhRrKH9ET0Cnh97JaLlj/8qRobnELOs74AtVJl3KjyTTGGqdIL1WrclDJ97VNx
 kZ5LVhW65rOJbufcvY8bSmhALUSe79p/NMNNnY7R32vWkHShs0A+f3hmdAINAMDtml4jipEbr8j
 2KEYVYmc/OjNV
X-Google-Smtp-Source: AGHT+IHjt3z3V5nnH/fGdcvummR9sPd+iX3GUAAu1ZJh8kZHSIqKQhsZluc27vCFDrKKWKw0FWYrJQ==
X-Received: by 2002:a5d:64af:0:b0:391:2bcc:11f2 with SMTP id
 ffacd0b85a97d-3997f8f8321mr12557058f8f.1.1742840268283; 
 Mon, 24 Mar 2025 11:17:48 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6450sm11690651f8f.70.2025.03.24.11.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 11:17:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 24 Mar 2025 19:17:37 +0100
Subject: [PATCH 1/4] clk/stub: add sdm845 rpmh clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-sdm845-fixes-fastboot-v1-1-d177a10f336d@linaro.org>
References: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
In-Reply-To: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=797;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=eYnxfSuqnF3eSWgKnc2Yc/SQptFMeqRMT9i/027n0NQ=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4aHHFzvxRZF74X4+q4sujIVLLImHr1QdBc4v7
 nCqWCS356eJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+GhxwAKCRAFgzErGV9k
 thvcD/9ZfQJN1XQoTxniNQIuMwn2M0kNlOS+BaKPKmz8WREvaUIGj8blEZNGVtP7IdATeaBHSrZ
 ROin+Xp4c47esfCxg+ur19OvnE8QBCY0zco6djd1cQKBgl3bEnVkuUQNFI/GvmYdUMrsNoJOwNC
 /e8miPViMtBDttn/KfPXhcia8nN9AJ4abFMxD1S6fuYr2pZPqhkBuY50szA/vJz5n3EUMbT95GW
 VJcRUJ/Iz+5n8yt9Oq4A8QLGS+JcLsQxmSBSIxiGUGK6lX+Z/93Lvs2wOJGVLvzkf38/TrrULmv
 B8xeHw03Tfprbcrr1BlKZE+032SlFov9z3R0llxTpBlexfFoPTRBLddkl+cYk9KP1TPNBg1mTj+
 4NXerhlbR4hRgbS5PMC/MEb2lk22MW/PQlcNlbDTsNp/V604XgbfXq8KkRteRmlXlOXTzJxdcws
 /LRsyeCirxw/Hd5A1cfFwnuJKtg3DKW8PpevSPLSkKUhaZYGjrEJ5bRArl3gTwi10udpeiov54D
 MSaZcZ511MDrcCdR47KPNo+RTFkHgr9KwYsNUfbpVwTZD4DwdBKGlyPxBJMT3LbHDxVInoYQnXv
 MkkuM2CMb+NebmNOy4DsS4+VlirM5gSJ+QU8jp/lvpl+SX58DXR9vKTS6VDvFZ0JkskGbE40g4O
 eMwkfir6JKirlOw==
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

Necessary for UFS to successfully probe all clocks.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 343fa5cd3fe1704c6bb15a8c9852b9b4e4990351..521ecfc5917b45f8ffaf2f25aabcc5abb4863cea 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -49,8 +49,9 @@ static struct clk_ops stub_clk_ops = {
 };
 
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,sdm845-rpmh-clk" },
 	{ .compatible = "qcom,sc7280-rpmh-clk" },
 	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
 	{ .compatible = "qcom,sm8550-rpmh-clk" },

-- 
2.49.0

