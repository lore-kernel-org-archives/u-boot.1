Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF0DC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 23:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F138D8855C;
	Thu, 23 May 2024 01:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NJYjCwBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EB9088522; Thu, 23 May 2024 01:32:05 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0258884FB
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 01:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c998aed0e0so627027b6e.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716420718; x=1717025518; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJLdvwL8E0+ySxUpD2v1xdJRwuuyDQMbvYUmEzU68+Y=;
 b=NJYjCwBNsFEjIhhFmMzKy5bXkI0wZUMq3hy/Dckm2qpLj7XT5rASyFDTUupKz+USRy
 iL4MZFh+539kzkfmWgGjL5uhi/pAahdyr+vrrM3O1kIAtVMiZ/ghNxoY4tOXT1SW6AVK
 tAjUTP+K2rXJr+cmUTJFP5W51wYZzpvmoJUWP1Qr53srSZXd7BlyFNk5dR7c7a3kBZmL
 u5FwKsbSUmebkjkedKbLYslbbVyTXpMWdsV5XGpbic8X6iD3RFQrY/iZzT1UX2OpNxHn
 mRywJfF66ABbAChW2ejz+ueeuwTvjngpOHSOhnC2QAUnZK+BNg2TohZpmlZ2q11zUYkd
 hPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716420718; x=1717025518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJLdvwL8E0+ySxUpD2v1xdJRwuuyDQMbvYUmEzU68+Y=;
 b=CeZvpDdrsHjdUn0pewzHCMgF+KbQ2VFT+JlnzHBNYTFW1waQpXu9WvPRS5UlU+W3OW
 wJpWKr4sR97y31lQ5vSE1SP9Ao69PUXtvVdXL47V36hKKafiosFRA4/XbqalYgEBxbGF
 cYT1+Kiv0gGQeogaZsKpsGVRBabGKzTnvcf7d2iZPFF6lyKbHzfl6ieW30kfoJyr3+Dv
 HPVd1oFzOtI/ffuhccsnMf+sA2KDzYQp8+Nmy60H3ogbPe4vo7SehhzgzrnVxZG5xduJ
 s9izbA0/F0uKNayXvmnP0WHLV0Ls25U82u0QIoSD17Mtx8EVT6JHgJj40+qN8obAV8MG
 Y00w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMUHkwCu4rBhekaKYXuIc8yR3BVTO/kdCodc15y3DzbtSfYttJJFBaQNZ59svHgZLeaaODVtx+2GbWPqb/8qnWsMWUrw==
X-Gm-Message-State: AOJu0Yzg95MAxNCk/iKp18krCzqn95kKKD5tT8lO5kHrq3hdRf3OnbPg
 08BjOagXLH7+zfjebOlTUAbN9wKI1YblH5B84h0GawYf0cYM7JjYhztqMApPXfA=
X-Google-Smtp-Source: AGHT+IEiWGXtdwjRISWkce3shZsha+LElWj+D1ecm4WsOi+Z7zytueQyQMlRJeEYyG/vzZisGPtdcQ==
X-Received: by 2002:a05:6808:15aa:b0:3c9:66dc:7624 with SMTP id
 5614622812f47-3d04201b34amr354710b6e.0.1716420718471; 
 Wed, 22 May 2024 16:31:58 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3c9a5f0e6cfsm3861648b6e.2.2024.05.22.16.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 16:31:58 -0700 (PDT)
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
Subject: [PATCH 25/42] mmc: exynos_dw_mmc: Read upstream SDR timing properties
Date: Wed, 22 May 2024 18:31:18 -0500
Message-Id: <20240522233135.26835-26-semen.protsenko@linaro.org>
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

The obsolete "samsung,timing" dts property is now split into
"samsung,dw-mshc-ciu-div" (for holding the internal DW MMC divider
value) and "samsung,dw-mshc-sdr-timing" (for actual timing values) in
upstream Linux kernel. Rework the driver to make use of new properties
instead of the old one. All affected dts files were already updated
accordingly.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 84382c606a1f..788587b622ca 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -227,7 +227,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	struct dwmci_exynos_priv_data *priv = dev_get_priv(dev);
 	struct dwmci_host *host = &priv->host;
 	int err = 0;
-	u32 timing[3];
+	u32 div, timing[2];
 
 #if CONFIG_IS_ENABLED(CPU_V7A)
 	const void *blob = gd->fdt_blob;
@@ -262,16 +262,16 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	/* Extract the timing info from the node */
-	err = dev_read_u32_array(dev, "samsung,timing", timing, 3);
+	div = dev_read_u32_default(dev, "samsung,dw-mshc-ciu-div", 0);
+	err = dev_read_u32_array(dev, "samsung,dw-mshc-sdr-timing", timing, 2);
 	if (err) {
-		printf("DWMMC%d: Can't get sdr-timings for devider\n",
-				host->dev_index);
+		printf("DWMMC%d: Can't get sdr-timings\n", host->dev_index);
 		return -EINVAL;
 	}
 
-	priv->sdr_timing = (DWMCI_SET_SAMPLE_CLK(timing[0]) |
-			DWMCI_SET_DRV_CLK(timing[1]) |
-			DWMCI_SET_DIV_RATIO(timing[2]));
+	priv->sdr_timing = DWMCI_SET_SAMPLE_CLK(timing[0]) |
+			   DWMCI_SET_DRV_CLK(timing[1]) |
+			   DWMCI_SET_DIV_RATIO(div);
 
 	/* sdr_timing didn't assigned anything, use the default value */
 	if (!priv->sdr_timing) {
-- 
2.39.2

