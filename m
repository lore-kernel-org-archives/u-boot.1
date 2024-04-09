Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577BAC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493DE8815D;
	Tue,  9 Apr 2024 20:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pqhAE7iY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5538C88155; Tue,  9 Apr 2024 20:03:11 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6DC687F24
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e509baddaso2771040a12.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712685788; x=1713290588; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C5CkDixJhnhclQPO5wn6o1M4pgnGxZljaormasly8Ho=;
 b=pqhAE7iYw5qd2NbefyxFHRYCDvbnzFuRPA0KgNbD3hiOfMEyHV8dxsIWujEMQH1Q4q
 2epgXBEvao4ys3xZfjudK93sTIWUTg7x1AbivIk9KhuKCtYvbPoGq9/E1x9nZILRkSP8
 nWIDgsgXM9puBRfb8EDg42ahgqFKGFn/p5xMMMZ4ClZ4CDI6cRKhmtu1dCA8XN96Wogf
 Aj2zZFCsdomUFPve1IAQPXGy61HCGwCTn6l8+kwdD4kL4wsaf9c02C0jLqi11qzzorZt
 fB7OWoor7/vBA9N92C2R2D9tiEw90F55REWEdpi5J7+lEZU+EHfvc1WUfsZVQmb5rVHi
 IC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685788; x=1713290588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C5CkDixJhnhclQPO5wn6o1M4pgnGxZljaormasly8Ho=;
 b=ZtOdqkqgR0k2H/Z6suYdYebU+7bSd5fjTbhgnBoGDVB2uk3eRsrkpOFtdGeJ1oiLHw
 Sl93IBnVZB59sWreJ7g1IuMvaeWc4jlYpXp0g0UX9MCDIJqqOybUoZ9FLu9y5izIuNg3
 +LH6iWH+GZsW5HhjEHnu27J9d4X2jbd/dYhBjj/2siS64bnSjXvrCtmdM6AIuI5h7Jcc
 7bmXmVoQDFZUoCWSCQQ4kxMa8QIQgA69x7Ss81Q9dr20fMvdkry5Q6yPY1pp2e1jhftu
 kOblO2cn2LfKaXca7xVEYhv+tkJxo8+R5rVdlxO3uD79b2Pe/FYQnKrC+VhFjalNKDzS
 pERQ==
X-Gm-Message-State: AOJu0YwDJtUlOsSUNbnVm5c1GUZQ4VOb3Bj0wdfkt4ul8JoL1GnfOzgh
 g7BZOfpqIDX8HkfDMCvODFCznC3c3SrbGQ1WtO25LZH7ITj+BJtgPHFRziwGtrMf1qRSoxlcXgZ
 x
X-Google-Smtp-Source: AGHT+IH7ftorB7X+z2ULpjrc4kh6nmZraZpdcYqknQAL4Nz8RZq4o4zbmfYTNpLgVjPSNsx40uCdSg==
X-Received: by 2002:a17:906:b217:b0:a51:ddd3:6a4c with SMTP id
 p23-20020a170906b21700b00a51ddd36a4cmr117992ejz.42.1712685788027; 
 Tue, 09 Apr 2024 11:03:08 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170907272400b00a4e5866448bsm5928783ejl.155.2024.04.09.11.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 11:03:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 20:03:00 +0200
Subject: [PATCH 1/7] mmc: msm_sdhci: correct vendor_spec_cap0 register for v5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-qcom-mmc-fixes-v1-1-5039164ecbf7@linaro.org>
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=AgjHOoN/b4LUHuNMtAk2CVrQKJAGbzZ6iPs8yXn+1YM=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFYLYB23/QV7K050FxHeUD2gsUY3Vtbpl2S7e8
 qc0kbTAfOeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhWC2AAKCRAFgzErGV9k
 tn6rD/4xPodaCXhWKeT+ag1pRcz/YFIMcQXrwKVvMYNMfSlgh/wMamblr/kUjuVsTaoftnVduKf
 Z7Ikezhu+HBlEAkN9JFVk9abf8AOxFD5gX/iTKFB04a3Gy1dv5Uv6Tp7cruGy64TuIfmFBXAsjJ
 XYdauG/FP07VlS6msJP5itSV21pkTlkKfoOsGYdh8IMBgfnOeZh1fhoHeenhQAXs5uuM0CM97I1
 gVwVyqCpg9nhNPZhpQCVbmXf96z8zqYDWETY4SOkBPNxH+a7DVI54Ve1dcbsRHBZtM7qHoTGTLp
 50VA+t4QqOBgs6RDeCCN7ryR5+KuolYnyB9024oLWScr4ZuaHuxUH5lP4+2QVjqYPw5unzff7vq
 qqugJxo2eqdj5CZ7YC+2zQSr/7YsCWH69TTbbqWxmIWoDKs5onUHcuKa4p4SLPtEMDLwMxp59kP
 IFSnc7Xn54j6mAXvdCHdhjL1fzBEVC8F2Cyjk1tEnvoEnjGmJWvsSlQDxzxF11QFWsCO+e1kDsp
 Z9NCOjTM1H+qxlfnaQIsWrwaLc4B1sZYNGwe57XxuiAeTFk0bfE1WKlkHLz+3spouKtM9s45hlz
 OIY7ueFILBKQtGSZVXQBQNCF1ZuW5GggErJgbm7RAIqJlyX6LGEeXmcr7ySaZLW4nqa2WiaPc5E
 snyZ+p7Ma6+TcXg==
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

The V4 and V5 controllers have quite varied register layouts. Inherit
the register offsets and naming from the Linux driver. More version
specific offsets can be inherited from Linux as needed.

Fixes: 364c22a ("mmc: msm_sdhci: Add SDCC version 5.0.0 support")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/mmc/msm_sdhci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
index 059cb3da77c5..f23d425144ef 100644
--- a/drivers/mmc/msm_sdhci.c
+++ b/drivers/mmc/msm_sdhci.c
@@ -32,11 +32,8 @@
 #define SDCC_MCI_STATUS2 0x6C
 #define SDCC_MCI_STATUS2_MCI_ACT 0x1
 #define SDCC_MCI_HC_MODE 0x78
 
-/* Non standard (?) SDHCI register */
-#define SDHCI_VENDOR_SPEC_CAPABILITIES0  0x11c
-
 struct msm_sdhc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 };
@@ -48,8 +45,10 @@ struct msm_sdhc {
 };
 
 struct msm_sdhc_variant_info {
 	bool mci_removed;
+
+	u32 core_vendor_spec_capabilities0;
 };
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -180,9 +179,9 @@ static int msm_sdc_probe(struct udevice *dev)
 	 */
 	if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
 		caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
 		caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
-		writel(caps, host->ioaddr + SDHCI_VENDOR_SPEC_CAPABILITIES0);
+		writel(caps, host->ioaddr + var_info->core_vendor_spec_capabilities0);
 	}
 
 	ret = mmc_of_parse(dev, &plat->cfg);
 	if (ret)
@@ -243,12 +242,16 @@ static int msm_sdc_bind(struct udevice *dev)
 }
 
 static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
 	.mci_removed = false,
+
+	.core_vendor_spec_capabilities0 = 0x21c,
 };
 
 static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
 	.mci_removed = true,
+
+	.core_vendor_spec_capabilities0 = 0x11c,
 };
 
 static const struct udevice_id msm_mmc_ids[] = {
 	{ .compatible = "qcom,sdhci-msm-v4", .data = (ulong)&msm_sdhc_mci_var },

-- 
2.44.0

