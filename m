Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C37C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E781E888BB;
	Thu, 23 May 2024 01:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SIthj08h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 696DF8858F; Thu, 23 May 2024 01:32:13 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9123D8858B
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6f7c661d597so158222a34.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420727; x=1717025527; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAbT09mQMrVOW56Q4+Gpj2H/+bzDkARKpMavwrkd33w=;
 b=SIthj08hXdgnOBm2w85/w2TGS+iLznHXKMUC9nYdnew1dERWvT5z3ZVolkbF1Wyu+B
 QpW+zkGlkOxMbeUhpqydOInf7KTV3iQtHYlsbXPPoLHBnCg/gh6PwHSgNsOek1V4VitZ
 5oVdGMaVcf6o6JjR7mlJZeO2bVlJTpn/z9EET44Cb5WhBFzwMpkOXpUvin+yd0Ync8pl
 tBypYoJrJOr95rmMoWZBTJ704LsgTtdaK2vBSvc0/jlASbfK9i9yPQep6YCOI03dYEKE
 I0LuMAYC0l6ZHFwB/DO2TiP6vV47N1no9+bnvQYJ+lmpC2PiSFnmrF9dIK+G4jWsGPxv
 48XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420727; x=1717025527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAbT09mQMrVOW56Q4+Gpj2H/+bzDkARKpMavwrkd33w=;
 b=c5tLwU6LjeiBA1C4tDQcZA6aDhL6EHsnhKCMupmoSWwvaF/P+T4Os0o0qSjZp9n7h/
 q7mTwq+TPcndCV75UeKNqTFb53vBbs4mUdioXzUJ2kUBEcu61ACIKAuVujIfiS24LAq3
 GzrRZxZhz4U8tEcwYuCFWGiIgOVtcynFaLS0E9fK92R2tvjCeaeRYU36jRiJIPaHIlqM
 v492z9RX5PXA+QF+UqulfPxvrl6lOKtuh/ur8VhR49t7UeJL9zEQmhCqqTUb9UgnfNf/
 X3qDIECEdEke9/nALh8QOPfHQZ7UZfRDQwVLQ2Xg4jTp23fP9xwcKt6aAldaBu+LJ3lc
 xRKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpBhr7nfifVWcrZy0iMM1boeD8phmMj9B1c2Nfcbj49LCumo6C3vUPjtJkM6zI/v71CaDXy8MU42w3fcXWN8y8Y5+qYw==
X-Gm-Message-State: AOJu0YyClFBUjK1IcsNtHR/sI+klIjVed/P+JXW1TxUHZO7JzoJ2EO4D
 t5GyHQEN5O3Rgr/jfKZEz+tcg58uCV7J/tmOK/CMKVpvOughpm0mHOdhzEGoyl8=
X-Google-Smtp-Source: AGHT+IErNsBhngSte+pwpuSbceya9fLgA2iu4ovVXSD4Y12DG8nu8rpkJst/xaMOphjS0v9eIyQJCA==
X-Received: by 2002:a05:6808:2183:b0:3c8:42ea:ec52 with SMTP id
 5614622812f47-3d045932848mr301136b6e.16.1716420727218; 
 Wed, 22 May 2024 16:32:07 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5b2783be1f1sm6123481eaf.35.2024.05.22.16.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:32:06 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH 37/42] mmc: exynos_dw_mmc: Don't call dwmci_setup_cfg() after
 add_dwmci()
Date: Wed, 22 May 2024 18:31:30 -0500
Message-Id: <20240522233135.26835-38-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240522233135.26835-1-semen.protsenko@linaro.org>
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

add_dwmci() is already calling dwmci_setup_cfg() internally, there is no
needed to call dwmci_setup_cfg() again in case when add_dwmci() is used
(for non-DM cases). Fix it by calling dwmci_setup_cfg() only in DM
cases, when add_dwmci() wasn't called. Also, this assignment:

    host->mmc = &plat->mmc;

is wrong in non-DM case when add_dwmci() was called, as it's creating
mmc object internally. Fix that by pulling that assignment into DM case,
when add_dwmci() isn't called.

While at it, add also this missing assignment:

    host->mmc->dev = dev;

Fixes: 3537ee879e04 ("mmc: exynos_dw_mmc: support the Driver mode for Exynos")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 19793e7ad460..373dd2df206e 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -333,19 +333,21 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	host->clksel = exynos_dwmci_clksel;
 	host->get_mmc_clk = exynos_dwmci_get_clk;
 
-#if !CONFIG_IS_ENABLED(DM_MMC)
-	/* Add the mmc channel to be registered with mmc core */
-	if (add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ)) {
+#if CONFIG_IS_ENABLED(BLK)
+	dwmci_setup_cfg(&plat->cfg, host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
+	host->mmc = &plat->mmc;
+#else
+	err = add_dwmci(host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
+	if (err) {
 		printf("DWMMC%d registration failed\n", host->dev_index);
-		return -1;
+		return err;
 	}
 #endif
 
-	dwmci_setup_cfg(&plat->cfg, host, DWMMC_MAX_FREQ, DWMMC_MIN_FREQ);
-	host->mmc = &plat->mmc;
 	host->mmc->priv = &priv->host;
-	host->priv = dev;
 	upriv->mmc = host->mmc;
+	host->mmc->dev = dev;
+	host->priv = dev;
 
 	return dwmci_probe(dev);
 }
-- 
2.39.2

