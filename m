Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE10C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF61F887C2;
	Mon, 22 Jul 2024 19:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="laPvU+8z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBBFB8863B; Mon, 22 Jul 2024 19:58:09 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801BA8870C
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-26119999171so1968143fac.2
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671086; x=1722275886; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zljk88b5uhIt622WVCD8ub/dXpb7gNcfzj+9ej5gn+U=;
 b=laPvU+8zfzgaeZKaddQuGXydd2pWMe/EF/y8EFUAUPkvVwqCJs0BcuvE/kZl4OH7FS
 Kr6I63bqfmhltwp6KRn6H/oa1I2xFUQJfga+It5WY1T3rwZLNkV4fe1v058euUCqjv/+
 6Itq5cwH+lF+R7tjRLHCTEb4fVRTtN6OiBV7Ip6V5tsxJdvDLQ+QGRuPOaJgNb2sD6S4
 iTUyIphQC7JDmM38fKBqhhvoPdez13YSLn8lDoBYFcxjhc3IhgcBCErappbj1RKQPC2d
 uSUZNGc4g7Kh73qDCqxpQ005jQE+ttrfWPw3ot6wmboC3g8uHqNsuhlneioZ3MEQbwAC
 Tu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671086; x=1722275886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zljk88b5uhIt622WVCD8ub/dXpb7gNcfzj+9ej5gn+U=;
 b=CQaK+VpQEgDgGb7EhrSvcn7vbBfl0ib1mnoSwohVZIgYbPY15L8bJ87Licc/sRbPSO
 HNz4VO9YxsOmTWFmEKDQgloYLyq4qm7i5AP+dHeRTOOUrpfQF8GvuGRVmjM1HF/e2dlK
 oEPH0r+vlyL9q2pQZj/U+pmCcHOQ821hBENX2PwVBux51BEVmcNE9w6qIB2al7M/aJkU
 NpVQjTxh3ZxpvDhljQfiUzIirfj9W+VxkMzdjCvhTOlwRvVNkq686MyccqaJmShs4N6E
 ab0j3FmcFDvl2jJB2rXS2nuex9r19qy2LW2/f1FwFQg6N4N6Vqdf7F0fXYwXAaqGH+1W
 gwBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3cozR9G25JIOzJR0ajnTl5peqHvHOdx1mN8dA03fHRue4jMYD46Od9Q1yKpX6EA2KaWmuJx2ts4QiUSjRrGfjMxzUVQ==
X-Gm-Message-State: AOJu0YzA3RMq0JtRGvpmIiGKbKEw453f9yf+rKXGy3RU7gI1KcYSg1n2
 EXmfJT0w0YyeyUcJx4jA5K3UIB7nqrCohp19vuxqghrPmStAjgEfkYpyW4cHqh4=
X-Google-Smtp-Source: AGHT+IEPB3NHPwIrmxGqTFoqEWwLU3W2YKTXhIhXULgjrXIzOcloSUQsufuotal/s7noZm9rOFIp/A==
X-Received: by 2002:a05:6870:e38c:b0:261:236c:2bc1 with SMTP id
 586e51a60fabf-2646906a752mr466938fac.12.1721671086301; 
 Mon, 22 Jul 2024 10:58:06 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2610c7cf209sm1766436fac.29.2024.07.22.10.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:06 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 34/38] mmc: exynos_dw_mmc: Use dev->name as driver's
 displayed name
Date: Mon, 22 Jul 2024 12:57:36 -0500
Message-Id: <20240722175740.6985-35-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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

Reduce U-Boot footprint by reusing dev->name as a driver's displayed
name. This changes boot device name (and "mmc info" output) from "EXYNOS
DWMMC" to something like "mmc@12100000".

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 43111b749a6b..a9e240fd91d6 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -327,7 +327,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		       "continue anyway\n", host->dev_index, err);
 	}
 
-	host->name = "EXYNOS DWMMC";
+	host->name = dev->name;
 	host->board_init = exynos_dwmci_board_init;
 	host->caps = MMC_MODE_DDR_52MHz;
 	host->clksel = exynos_dwmci_clksel;
-- 
2.39.2

