Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70F0CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1A1836EE;
	Sun, 26 Oct 2025 02:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EDXDusTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD8D807C0; Sun, 26 Oct 2025 02:07:07 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD47836C8
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-44da4b1500aso461350b6e.2
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 18:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761440824; x=1762045624; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrjg8F2d81Z0viKOFG6fdMZYpMqtbgDUBJeutHN+r4o=;
 b=EDXDusTuaHzG+ut/w2xpnduLNejcocI9WqVI4Yfxg522EI4PtmcRVEKoZbUzP8pav4
 b3y4qtswDFcIrUJJib/PljuDo5IIPKKUh3RKFmPFP70QHy/wTtvRTeydmMzwALvXrGIg
 MiRB0Wk+WXGGin1KLEpCBVh7K8LXkJkAboi/wqvrv+fy4aHgEtDe/6sThwSdF/+D4SEy
 935Rm+XFbUk6cIKOh/ou2rwY1LO8WdjttoZh5DIdUmenYjzgJRXsvlyInsyz9AE4s2sI
 GesB1A9GAP5VDQoF2JmpQ1PEKXo/MoJfLqp+8DUkqpHec2hlGSO1GR3F704zEZhdlCO3
 TlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761440824; x=1762045624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrjg8F2d81Z0viKOFG6fdMZYpMqtbgDUBJeutHN+r4o=;
 b=GsBctWN4A5gaXjtVCyss8B81UcvcuYn2qKHk5wN5jltczgk93bR069JVah4Ho0oMZJ
 3IHhMcMDXBCJHWwANW01JPrHZcRrBVKK8qCzXHbceClvn/oDG4GgDFxu6/p/jCtBd9vK
 mpax95cu7zob9mVEt9td/RGiFRmwojawXytGhE1k+l4hjATdhwavOB1MXh8b4r1Wu6gI
 PudgYwxDWDQhJFhUlCttqVFJIkf84zNdJmlK49llnSByLRhUwrlcBI32cQdyjZhSFcT6
 KlgKxFGZ3vj5Z5Z4l+qrsRX7rmF1Ks1/cvshJnJl9eEyqXeyeElIij8Bfji3K0J1/EZB
 Ao1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrIlnM5NmswEUV3SzJ4dOW97R9kzjFDMMup4BCc9yUagcqizkoNwqU380sel9LXDIEhcIRV2E=@lists.denx.de
X-Gm-Message-State: AOJu0YzACZ/1erBIhd4WxfNG8OZ7wInYMNSt8X3QVwVlnub7w7AtvQnw
 prTabRA7UgCG7vn5MuG1uRe17CrinVVMEzCEdlMfDtyfTWgLOFAYN8T52Lt5RBktwrl+rr0Zmsx
 mMGTn
X-Gm-Gg: ASbGncsY+eAaGgi0a4eve+YLaPZbbjXLf/mafYk19LN9sydct7jb4eDyTr8W5fCXvOJ
 8YDJhSaDpiMS4YPTXHDa7Nn/jY4Wgks7smwDemIqYawJqPL0vY/acRURoVpQAPBe4ecHzWk3III
 diXGdJ+7jYPFUQovt34OmZ7D/Su6Vo+B+Hjbk8Vsq0SXS7XSwrbIx0AQvOuKb91+nJVwsfmkSZw
 45jipgnoBSKKTogx0YQft9IqjgSJicUqRbBHsf2pNIqtLu88hfENExn0Ax527lkaEbvD4pBB2qP
 fWc6/g+SHR3X8ys9ZkHKQSglM20T36SkSmvFmSJ7rb0CJrGQ0hvBkjD5zyLuLH+VsgTK5ZHvtmX
 lWcuSNx9h53Ww76lf2NdL63+OUUiLxksVqry4qcHKnVoL2BdVqhoxa4YW6GldpWUYB6HZGsCeDa
 UNKGeFUXVfNlgra9BgWpbu
X-Google-Smtp-Source: AGHT+IFKZw3EprCZmpzf/zAphmA3mUeJ9qVKHViKzxmpWyp+eDYoGDOGZOL/5S+PvU7Cmj7QoxFGFg==
X-Received: by 2002:a05:6808:2f12:b0:443:a060:28e5 with SMTP id
 5614622812f47-44bd4307e34mr4442139b6e.48.1761440824413; 
 Sat, 25 Oct 2025 18:07:04 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-44da3e9ccd4sm844724b6e.19.2025.10.25.18.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 18:07:03 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Subject: [PATCH 5/6] mmc: exynos_dw_mmc: Add exynos850 compatible
Date: Sat, 25 Oct 2025 20:06:57 -0500
Message-Id: <20251026010658.19271-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251026010658.19271-1-semen.protsenko@linaro.org>
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
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

Up until now "samsung,exynos7-dw-mshc-smu" compatible was used for
Exynos850 SoC, as it's present in its device tree. But Exynos850 device
tree also supports "samsung,exynos850-dw-mshc-smu" compatible string.
Add it in compatible ID list in the driver so that it can be matched
against this string for Exynos850 device tree.

No functional change, as the driver data is just a copy of
"samsung,exynos7-dw-mshc-smu" data for now.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index be17bc4692c1..2027fcb82243 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -488,6 +488,11 @@ static const struct exynos_dwmmc_variant exynos7_smu_drv_data = {
 	.quirks	= DWMCI_QUIRK_DISABLE_SMU,
 };
 
+static const struct exynos_dwmmc_variant exynos850_drv_data = {
+	.clksel	= DWMCI_CLKSEL64,
+	.quirks	= DWMCI_QUIRK_DISABLE_SMU,
+};
+
 static const struct udevice_id exynos_dwmmc_ids[] = {
 	{
 		.compatible	= "samsung,exynos4412-dw-mshc",
@@ -510,6 +515,9 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
 	}, {
 		.compatible	= "samsung,exynos7870-dw-mshc-smu",
 		.data		= (ulong)&exynos7_smu_drv_data,
+	}, {
+		.compatible	= "samsung,exynos850-dw-mshc-smu",
+		.data		= (ulong)&exynos850_drv_data,
 	},
 	{ }
 };
-- 
2.39.5

