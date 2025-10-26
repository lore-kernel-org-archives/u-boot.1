Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F686CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7898384E;
	Sun, 26 Oct 2025 02:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GHhtiy89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE72A83623; Sun, 26 Oct 2025 02:07:08 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848F183623
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c29466eabaso1142224a34.0
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 18:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761440825; x=1762045625; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqwraUWJLkWV0tUxp4HuiKs//4MfKTQFsJNXM3dO7wo=;
 b=GHhtiy89eTLZV9Eh8lZReYp+jiEV3NceVLCbv0fyYyiNbXdWqy0pzU5Yhha8qx8Fn4
 /5g7sP3IU/9bA+rg7ouWH5LN3N+AvITPjhAMzIWZM9WN420Xv5UBOqbahD70O4JBTnDh
 tJ8FcP5ArDgoL91YtlwL5llEtAg6KWb/lNng8qqtQ0GtiP+9mVklcpmIDuV9WKb4vR/g
 AA4DiPnNIxYN7qT4gLV1QN7s1HCicH7TmM1Pngu7gnS7L9Fat9E8Qs9/Z9nxx95BYig5
 ZeiNq3FpgcrfaddCQCpEd+avvHFFnqx0lhizf5DSoBp++OHzVtIWDRnGt8nnEsgGVJ84
 R1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761440825; x=1762045625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vqwraUWJLkWV0tUxp4HuiKs//4MfKTQFsJNXM3dO7wo=;
 b=JDzvadqifuleP1p6actU11dSJHR1f+y5csdG2jmECl+ny0KQNIX8LiVH446FNo6icK
 6FDFh+ve+04XUKcxePE6q/yED5f0pWr2fPMYk9YIFiHKmqM9pWFQwHNBJWgDY2kbjctX
 TH3kz/Z34EUiruyM9cobciZSvgAe/gJ0NbGkzzoANFloOipH/6MVXpaQsO298b6NpmDj
 Zfg236ElJof8fjEbJi6bqf7vPRp6cKhSemjUjadVA41eMsh/zuNoqB0xPd8UtBM8tOQd
 OWsjIs+L4PRtbH7W4bq8wmkFRm4Anps9wL5fShrMn/7Mskv9NuCFsglEg+jJOgjq/93N
 WfVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFgk49hTNcaSNvkPTiJQxra/0/CjLPN/YkpM2faA+M1zQd1MdOH3aJv0g5PEHdffj9FZyu/LU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1wMdQsnYfqrWiUo6XOd+x7+YllcubzuZbQIiq8dggHq2VZ8kI
 2eI+Hwdk0vy8nuLDQM1j5Jvr/80Nu5vWmgmNOGPR1gryJ3p4yDk+e9wRE4e83s6IuUs=
X-Gm-Gg: ASbGncvPy7UE1pF5Z6f6Ko7hSCB59+tXByHCO9dQe2JAbT1pUIZR26481ShCtz941+l
 M5DH6WqWLvNxz378hVNf+Qt9QBYlPNgIauQQhzsJy4gnaSuCDT/CB5JsWiPtIkwBuLfIEmsMDOx
 2mn/LgIGIbLCHriGlvppFXOg5Yy45v8whZuiDk2oeqKGycbXDrMvykeFu6ssH0drO4QmUydMofp
 Gm6UvR6yXC7Muc8bOEDURu4XXiimXVLQ+v7Itpf6Xw5w96N9Sb875PHu+CznpFan+pk0wS1VAjv
 63pLIaZyp1D0ZVnaeb5gwwLATEMScWkDdHGvgz+qlN2PM4vZxzy6Dhv5Eh54fXd8qnyw5qahlMo
 in+9tMd0nYQWMkq0bm3rgRkdHN/EuVnvrEpeaQfMG4qwQUyYCMdvAslDkAuVWcEZWDa8w5Ld7CT
 Y49AO4Qti83Q==
X-Google-Smtp-Source: AGHT+IHQL0f31ixmZOP35ut7r0WXPWiZqHPr8hu22oFMrFJJFmB2eASeRK9BKlj3ckHxHWlnbG66vw==
X-Received: by 2002:a05:6830:4408:b0:7a0:239:80a1 with SMTP id
 46e09a7af769-7c27cc8d18fmr12263567a34.29.1761440825269; 
 Sat, 25 Oct 2025 18:07:05 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c53013645dsm987632a34.14.2025.10.25.18.07.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 18:07:04 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Subject: [PATCH 6/6] mmc: exynos_dw_mmc: Disable FMP for Exynos850 chip
Date: Sat, 25 Oct 2025 20:06:58 -0500
Message-Id: <20251026010658.19271-7-semen.protsenko@linaro.org>
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

Add DWMCI_QUIRK_DISABLE_FMP flag to Exynos850 driver data to make the
driver disable FMP in case of Exynos850 chip. That makes eMMC on
Exynos850 functional when U-Boot is executed during USB boot.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 2027fcb82243..7ccd113bd796 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -490,7 +490,7 @@ static const struct exynos_dwmmc_variant exynos7_smu_drv_data = {
 
 static const struct exynos_dwmmc_variant exynos850_drv_data = {
 	.clksel	= DWMCI_CLKSEL64,
-	.quirks	= DWMCI_QUIRK_DISABLE_SMU,
+	.quirks	= DWMCI_QUIRK_DISABLE_SMU | DWMCI_QUIRK_DISABLE_FMP,
 };
 
 static const struct udevice_id exynos_dwmmc_ids[] = {
-- 
2.39.5

