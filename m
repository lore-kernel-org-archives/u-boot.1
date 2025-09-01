Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08896CA0FFF
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 15:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617C283965;
	Mon,  1 Sep 2025 17:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a/STA0Th";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD65B83A02; Mon,  1 Sep 2025 17:13:18 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A387831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 17:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45b869d3560so18247695e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Sep 2025 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756739596; x=1757344396; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bVPU4a+mpaatylzJBZ71jTwdSmTvNezQIDsdfS+LTNA=;
 b=a/STA0ThiRTQjMQqITh1IdHuJJRl5oBSknE/ECE0S+d4iC3YFUoQ3Lki5Mpl5YM249
 DfI2MozpEiCTYCN61puFeRH+fjMuhWfwOJXrMiuq/3c3rGSJix+JCSWaf5UesCvBbSMq
 sp2NXcdExLuW08H/ZbjnVCRQJsKPkbpo++4+5P2jS/i/qZ8rV6cRvIAj2q8kT753lFI1
 wYbM0vMaFdKkqh4GipFuOQQfa1lLi96IIJDBAqLJuejMsWZGH59DsB0BukkYHtww5N7Y
 1iE6r3UII2eildaARhS6L/m1uNS9rpq1o3WOG/eeEZgFRKMVBfgT13FSEBYMg8JSxsxs
 FmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756739596; x=1757344396;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVPU4a+mpaatylzJBZ71jTwdSmTvNezQIDsdfS+LTNA=;
 b=eYOpOt4jZjosXadBJdeG6DlGArPBrKAbPT/B5k3PG90/1xwLSTFsCjvg96XJPimCcX
 9rKqD1SzMqOLv6iBbRlnKKJudxxb5662qA0LLGNqmJEvl952tXiu7+aSMSmb1f0PY2+W
 sEcVXM1r+Kqeug9B61chvqQTIS8J6OjsnQkVvQ3j8uAIMmU4n6hDR2DD+BJcCE6jXzm2
 w6Xp5Ml92eeAtQ0BVsDiZu7B+BHFmF/sc5eLt3+jn1n1/JTFUTR6vrg0A8a13e9393ze
 gQdBncVI+Rf0Fqf7lCl7/GgchmpW/V9InJd9axHlYDsagmzLLJZ6lGcKDvuiuUbEAHN8
 3vvw==
X-Gm-Message-State: AOJu0YxUQ1y0jGO3S+nOpuMUW2l8idP9Fc/VGf87DqUoI/oOt0f2UsHc
 xr+I++H57LCi/JLVQddN78TwXK0HszTsjlBhSLXDtSsB0OltKzMcGEy0mWJjEIPrOM0=
X-Gm-Gg: ASbGnctEJhYA2Vclwi8HafzE2BQjXVT+WZpOUi3jGUdJ2kMjZiT2eDIVBCHPHnPzYcZ
 OnmEnyXXWQVqvpMHiQ5CyLSFE5KMuk0SpEz2r1yA/q91JV/UxY9zPfDv4SLLjopIsrNYfYraamd
 zwzyyIdrE8PAXVcR5AfDIw3xFdGiC1X8EFnF/wd7Tq/m1PmGOvwiWSqed6xnNLBektfWBPPqjp8
 TYUhRGJJQr1+3ODurJoUrG6d/mdPwDp3LwrFnFCPiP7TgBTha3TvMQz0GYi+i8S1YBsfl7TprXE
 8Saf3AtJSOl/y7PuWKjPzZcdP4pw/HyBD3nrIoiTs7MDliHuu21eLUf34iZLFl6kkiib7pswuwp
 YZ8+ktrVfVZhKP+VVPtJx57qnTxIP6kYy/0GiaAaM8UQ/ETLDCcw=
X-Google-Smtp-Source: AGHT+IGcNsZ1vMq8FO5nm6Qjr9Jdp8F6QIK8myllqUX/zZYkj29HT35BeQSzaSrQhN6cpGqExrl0OQ==
X-Received: by 2002:a05:600c:3153:b0:455:f59e:fd9b with SMTP id
 5b1f17b1804b1-45b85570dbdmr88361925e9.24.1756739595853; 
 Mon, 01 Sep 2025 08:13:15 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:d654:76cd:40eb:b986])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8876c9sm161864755e9.11.2025.09.01.08.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 08:13:15 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 01 Sep 2025 16:13:14 +0100
Subject: [PATCH v2] spi: exynos: Remove extra term from test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-exynos_spi-v2-1-b467d4b75167@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAm4tWgC/22NQQqDMBBFryKzbopJsLVd9R5FSqKjDpREZiQo4
 t0bXXf5Hvz/NhBkQoFnsQFjIqEYMphLAe3owoCKusxgSlOVtTYKlzVE+chEqtZ3g6232tUW8sA
 7QeXZhXY8JgGX+dATY0/L2Xg3mUeSOfJ6JpM+7N/3pJVWvsva9v2tetjXl4LjeI08QLPv+w8BR
 4pIvAAAAA==
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In spi_rx_tx there comes a test for execution of a code block that
allows execution if rxp is not NULL or stopping is true. However all the
code in this block relies on rxp being valid so allowing entry just if
stopping is true does not make sense. So remove this from the test
expression leaving just a NULL check for rxp.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Remove the stopping variable which is now not useful
- Link to v1: https://lore.kernel.org/r/20250812-exynos_spi-v1-1-bd0813ff6593@linaro.org
---
 drivers/spi/exynos_spi.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/exynos_spi.c b/drivers/spi/exynos_spi.c
index 1b9bf004b7c..7f2965f8321 100644
--- a/drivers/spi/exynos_spi.c
+++ b/drivers/spi/exynos_spi.c
@@ -105,14 +105,10 @@ static int spi_rx_tx(struct exynos_spi_priv *priv, int todo,
 	uint out_bytes, in_bytes;
 	int toread;
 	unsigned start = get_timer(0);
-	int stopping;
 	int step;
 
 	out_bytes = in_bytes = todo;
 
-	stopping = priv->skip_preamble && (flags & SPI_XFER_END) &&
-					!(priv->mode & SPI_SLAVE);
-
 	/*
 	 * Try to transfer words if we can. This helps read performance at
 	 * SPI clock speeds above about 20MHz.
@@ -161,12 +157,10 @@ static int spi_rx_tx(struct exynos_spi_priv *priv, int todo,
 			while (rx_lvl >= step) {
 				temp = readl(&regs->rx_data);
 				if (priv->skip_preamble) {
-					if (temp == SPI_PREAMBLE_END_BYTE) {
+					if (temp == SPI_PREAMBLE_END_BYTE)
 						priv->skip_preamble = 0;
-						stopping = 0;
-					}
 				} else {
-					if (rxp || stopping) {
+					if (rxp) {
 						if (step == 4)
 							*(uint32_t *)rxp = temp;
 						else

---
base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
change-id: 20250812-exynos_spi-8172ecb31a83

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

