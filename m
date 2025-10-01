Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AE8CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 11:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F9583526;
	Wed,  1 Oct 2025 13:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UGxDEKqF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63C718349B; Wed,  1 Oct 2025 13:55:40 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACDE81D6A
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 13:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-421b93ee372so1799892f8f.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759319738; x=1759924538; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vgDT/Uoc5k0ZUr0n7WnppAklNoAwzgkgQ5hvD9Ef5PE=;
 b=UGxDEKqFzRykFkSs68TwHS3TslPpoITwqG8NumBfvOJ6NOLuLuilAYpkEXPcMbSr1a
 E+nJPbzMvxQZVTWtlFfPdZCBDpeZ2XdWb+04V/vOUVZfAEbMEQAhVxJAIRvFGEfS4EG0
 3KlreOdplU4vm5DTtF6Fp/h8kIBHtBt2DWD+b8m8bfzACKA44/ZvKzrosm3jjQtoIuDx
 sbYFzeVWsNXxw91Ps/cadZu1WbZ/QzR1TPPmYtF8kidvo3nzf9Pkhz956Wd8HOvNQhZZ
 NIHTfEr42ols/VDUhsOWYJ1B0oWf9F+na1sydKnOjwn8e8aZKjtFNbZ4e+o9yQZj7Ajw
 5pLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759319738; x=1759924538;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgDT/Uoc5k0ZUr0n7WnppAklNoAwzgkgQ5hvD9Ef5PE=;
 b=ewp9FEBKRIH887jbA6jwTtmCRwqFjL//nquYVpEGErf6mBvvrIfy/MO46HPgnjJCd8
 DAwZLbPJN9LeD5omSkzwxjykuXIJ04NOEX/q++wViTKVv4LjdmGGHiTjLoRPBhT0axQt
 u5vgJ1sjEx02LHhmYPkpDNlnZLAAHJrO03cYpmf8fGqCoyFfLHvLWh9Ms+Fyh+ipPfd/
 f3bs4qU4YBbszg6Xh46pnVI8r0AZ6sKPqLzu/pL/Mu+DLQssn7Cf2wnVaibKEj0sXaLy
 YbRgv+bzTa0tEdRdVMTicVDyITvz4rk6lMoAyWoWjqcQSzMxTcb07TJZH8onDJ166pO+
 oLDQ==
X-Gm-Message-State: AOJu0YxYHZS7yK1pB+qhpUeVQNZEZKXqmiKa8gpU/qYneC/XEHiLBart
 IyHuhr/z0RtE1/Y4/We0znPgOuR2+rDucEH7SwJR5QR4NG9L2s/JUfQ2tl/JmLvD9ps=
X-Gm-Gg: ASbGnctxIrkMAanduwcY9spbfO2WnnzNrTHI/QJvOnBA2aVpKnQffYRYbynuQ0Cz2Ry
 at2EfSbqJ3c7EKL5UXQE9w4bqdCYWsAJBK3AYNfnOsJQb/K4YNxaDkai6tAemfApIM55F6UslBN
 4WeNtxwY6VtLYlIXX3T5SVJqjM9ZCbnjASB/Hf1ENqtaR2oXwykLMntpuQTq9/b3497K+lDN3Fr
 dmgplOmJUd/GNIbgZ5/I1zLed2G8rmhHPyDaZwpi+HBStRjkbxtOUOssDpfXmc6atFZ4mm8Rd3S
 HSTaf65PBEGGNzEKLgi7LwCUDUIU6JCvO3uquAHa+m38Lyu8eUx6NFiu+uKsUFjEC9xAlrAZaVx
 t6YI+szMDmrZ3M12oOihAdtgSe7SCYnlFf9DockSeOdiiufXinUBaOYc5+ulPJJus4BFkohytie
 cYzB1Pw84skg==
X-Google-Smtp-Source: AGHT+IHS3VT28ViN/RGbxDGywfMa48sJA636Rq/ZfIvGinLY0SN0m8M8oryVxqVM3LpMsmgzZ13Xbg==
X-Received: by 2002:a05:6000:310d:b0:3da:27c2:f51d with SMTP id
 ffacd0b85a97d-4255781b83cmr2538125f8f.45.1759319737928; 
 Wed, 01 Oct 2025 04:55:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41855fc661esm19224117f8f.45.2025.10.01.04.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 04:55:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 01 Oct 2025 12:55:36 +0100
Subject: [PATCH 1/2] video: tegra: Remove unreachable code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-video_tegra-v1-1-faaf48dad062@linaro.org>
References: <20251001-video_tegra-v1-0-faaf48dad062@linaro.org>
In-Reply-To: <20251001-video_tegra-v1-0-faaf48dad062@linaro.org>
To: u-boot@lists.denx.de
Cc: Thierry Reding <treding@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

The goto immediately after a return is unreachable. Remove it and its
target label as redundant.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/video/tegra/tegra124/dp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/tegra/tegra124/dp.c b/drivers/video/tegra/tegra124/dp.c
index b95b14da77d0f4d552c214e3a3f9f241f1cd4361..611bf2f81a62094922c198955d43ce1e57b61caf 100644
--- a/drivers/video/tegra/tegra124/dp.c
+++ b/drivers/video/tegra/tegra124/dp.c
@@ -1515,7 +1515,6 @@ int tegra_dp_enable(struct udevice *dev, int panel_bpp,
 	if (ret || retry >= DP_POWER_ON_MAX_TRIES) {
 		debug("dp: failed to power on panel (0x%x)\n", ret);
 		return -ENETUNREACH;
-		goto error_enable;
 	}
 
 	/* Confirm DP plugging status */
@@ -1561,7 +1560,6 @@ int tegra_dp_enable(struct udevice *dev, int panel_bpp,
 	}
 
 	priv->enabled = true;
-error_enable:
 	return 0;
 }
 

-- 
2.47.3

