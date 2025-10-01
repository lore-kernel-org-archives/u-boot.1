Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5D2CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 11:55:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B298344E;
	Wed,  1 Oct 2025 13:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="irP1OHhI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56A47835A2; Wed,  1 Oct 2025 13:55:42 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A5B883335
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 13:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-421851bca51so2050470f8f.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759319739; x=1759924539; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l5UgcHrYdKQslDL6vCAyGblOG8ZSJfJ8XuYb9sV7EOI=;
 b=irP1OHhIcFiPr0qpcOXIFNOinxNqBtbJ7M2C30QbNObEG8IYJliMpx1td3weDkQ0xi
 JCMHejix1nZvl0BP20HOkvGKqM8/HDjtiJ+f4SQ08iwCgRRGWZ4+4uJr4ZLWtPvM27g0
 KidayQ7RnTwLENSD3QvIMEUUs1AwkTKvuIMLTVh5fWlgclUMwlOZmx8Se4pDblDjZ4MZ
 uFAf0XsX/Pq79YAmZGRLv0WLc0A/LvOyiBnJXJlrJmqMfViJ4atDa38nW7Bga1I7yrjO
 RM0/Hev1EqgXAvvozsOGgwTiYqUyonSbCla1/tobzTeOxKYLbI4BHFbesnTl7L2oPSVv
 M49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759319739; x=1759924539;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l5UgcHrYdKQslDL6vCAyGblOG8ZSJfJ8XuYb9sV7EOI=;
 b=RqyuG6CqvaI1PcwfhkC/Qm+6bWtonwgBSdo2rie96aKy07Li8HvjECeDBvyg47Pq9j
 gaez6yW9XTrHoTpQL3+H9HbYb+eXP6s3ALLRPZLiLhl1WR41aVFCHWhXDI0N/uE8Vrjx
 AlGeBS81L0CaOdBx6P8NoU48oBhGtUZs39j26mbf9twWp2tWcIlJI38LHOi9onWvhaWi
 PCHZlo9OliAsbogCKenGUiGxZLz+1IJaFKz/lW1GjVf5mrQdVk5xNA/o6m43CUcSCAXU
 W9bTQFcbfvv/iNE6aoDEUwJp8npdVH/Wc5v+HMXc64JASkqhrJcZHisRduuWu30R6VlN
 UMtQ==
X-Gm-Message-State: AOJu0YxGkaO+iaJwiJHSTMvZ5wWaATE2QiCLvST/Kw+9w4N+cWcXFou6
 l1wa4Hmke/dfsQMSmoELOCRiE7PAQ0EoizGQomnbOChNbsds3Iuf69DL9X6VcQD7Wh8=
X-Gm-Gg: ASbGncsWwFaDvoZzdVERqn5MV1GDjHCz2JMuSuMh1en5cTNM3ZrXgcpN4HyiB2AMW9I
 GtgELfNZF3q3ueiDN5ru/u5yslSQzHy5zTatqR9RXdkGr3O/4u0I5ARxIlrSat8Vr3IaYDWMjGr
 xqop947GWglqFOb9aX+511SWwC6swAZIHa6T/EjVkqhKOWBcnJXnJh0CbRBHajLQmPNWuWL8ns2
 0UCzGKvawa0TEnQtZcX8GsiUWNGtJGgPxqnUgakmmHUkApWlQl3r77DbbMSXSayLQtWZecRwuD7
 ux19zhAJK9TjAMCH++MX7YG9RRWG6GwfW0mmhcqRm8pbdkfAt6Ckmbg7g181RxCLMEkw1A3Ssw1
 1Bb3A2R8o8qS0kQV8seO7mveX9C3ntkSQk3Vfly6n1/gd+vmXBhegyQczWsIWp9qiKLHK1iqwMU
 fN4uidVeSTCw==
X-Google-Smtp-Source: AGHT+IGRCQhaHcq4nt9wNIcgRnx99KEaexuqqfglHdBMUOAdciBY/o1VEmRfybh6FCzYFIzCbd7tpg==
X-Received: by 2002:a05:6000:616:b0:3cf:74e0:55b9 with SMTP id
 ffacd0b85a97d-42557820083mr2775059f8f.63.1759319738603; 
 Wed, 01 Oct 2025 04:55:38 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41855fc661esm19224117f8f.45.2025.10.01.04.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 04:55:38 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 01 Oct 2025 12:55:37 +0100
Subject: [PATCH 2/2] video: tegra: Incorrect operator used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-video_tegra-v1-2-faaf48dad062@linaro.org>
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

Combining two bits into a mask requires the use of the binary 'or'
operator not the logical one. Correct it.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/video/tegra/tegra124/sor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tegra/tegra124/sor.c b/drivers/video/tegra/tegra124/sor.c
index 1ce5330c6bcf8750c5a5adb3c92ccd8743d01b59..ccdeefbcbb1edb15a4bacfbbe770da0f88f55300 100644
--- a/drivers/video/tegra/tegra124/sor.c
+++ b/drivers/video/tegra/tegra124/sor.c
@@ -336,7 +336,7 @@ static int tegra_dc_sor_io_set_dpd(struct tegra_dc_sor_data *sor, int up)
 	}
 
 	reg_val = readl(pmc_base + APBDEV_PMC_IO_DPD2_REQ);
-	reg_val &= ~(APBDEV_PMC_IO_DPD2_REQ_LVDS_ON ||
+	reg_val &= ~(APBDEV_PMC_IO_DPD2_REQ_LVDS_ON |
 			APBDEV_PMC_IO_DPD2_REQ_CODE_DEFAULT_MASK);
 
 	reg_val = up ? APBDEV_PMC_IO_DPD2_REQ_LVDS_ON |

-- 
2.47.3

