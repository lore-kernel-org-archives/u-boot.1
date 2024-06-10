Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C58C27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 598DF8853B;
	Mon, 10 Jun 2024 03:12:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uhq4sEgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC5A088511; Mon, 10 Jun 2024 03:12:50 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8796F88528
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6f94cfc5101so2337316a34.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981967; x=1718586767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DfZcccyAMkc/tLeZTfCqhTQ6IpdwbmKD97DahjONA8=;
 b=uhq4sEgdz0tn2qHNQfetaefSiT2hT2vnPLqM2oRFDAA8jDTKkZWjQi5rvc197P+3TC
 Nhxy1kFRoO+EBt6tK1iB6y4J6dONSh7vSQFChp49nbLMsITzWUlhJYudZVyn8ckrqI2L
 jVASNt4CvJBnN1zOKj+HA6J/s4JTL3u2YTIb/AkEhGeXGTnj71pN67PnwgQKiIBUOncP
 f4ydEIslJ5taBS6DOS0awBsBPksT3heMnGHInLjjkVA69Tl/ivYBo8cjpR9uqqvhZzpJ
 ls944i1wIChdtv0uqJ31jBNDCTRzOxlW848rTzdW8KMJfT8hTDBb1gVO5iomZ8rL0Zbk
 A/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981967; x=1718586767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DfZcccyAMkc/tLeZTfCqhTQ6IpdwbmKD97DahjONA8=;
 b=VWSwUg0OJ4towgtXRkoJeEh4TFlBhoyiW4s3nzd/L9UU/nGXh/di0TNn/47z5TigD2
 o+3iGMyKR8AGT8dFDn73G2Z8QnBSl4/3sMWWZ5uGrhPPjFnKqTvfpzEWGD8nZUU9eQo9
 slNt2PKStuRrdSPkSpeNe7lgcBLjSJ0Y8OsG6wW8gZet1eUiccWsuuAy1/83vpyDb2bs
 C82YiM23LV60jW6DqKG5QqujNdSBgeOyyctlNPKRDxNZ4Uo/Ni/mKwstTvh9AziOfRQ8
 edyVXD3TRCzHD50M/Yh9aTu0zaW9g1hvJIzgwsg6toNkTrrZ7By4D8w3FA8T9CShSYyR
 bkPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqi1PbOa9DUeyaG5wo6bqdOB6jfqUg1b0s5bhucdvTAP7X4+XhdUHldDbnH7ZJK0At5gwtrmnWxAk6areSu6QjLYIwiQ==
X-Gm-Message-State: AOJu0YxxjkrQiaSvuwpp89KgUazelaaC9PZukG1awxghKr4PuF9wjhl2
 +vd2vOJt3efvj30zI7NuAJ8VyrW5wNnhjfuyWFf5EJTIEH7HsI6sYHffffyB2Uc=
X-Google-Smtp-Source: AGHT+IHvBiRXYEUGCvEZK1Fp8leMICtG5vvPbGisM7cjUNliLR2oXXwoVvzYUD0d/Pv5PwnHd3SrUA==
X-Received: by 2002:a05:6830:4118:b0:6f9:5dbf:d3af with SMTP id
 46e09a7af769-6f95dbfe52fmr9171384a34.22.1717981967172; 
 Sun, 09 Jun 2024 18:12:47 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f9a4564028sm369310a34.6.2024.06.09.18.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:46 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 28/40] mmc: exynos_dw_mmc: Read common clock-frequency
 property
Date: Sun,  9 Jun 2024 20:12:14 -0500
Message-Id: <20240610011226.4050-29-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

Instead of using non-standard "bus_hz" dts property, read common
"clock-frequency" property used in upstream Linux kernel. It's safe to
do so, as "clock-frequency" property was already added to corresponding
nodes in all affected Exynos device tree files.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 01e6bbb123f1..5ecee403c416 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -307,7 +307,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
-	host->bus_hz = dev_read_u32_default(dev, "bus_hz", 0);
+	host->bus_hz = dev_read_u32_default(dev, "clock-frequency", 0);
 
 	return 0;
 }
-- 
2.39.2

