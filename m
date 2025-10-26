Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5247CCD1BF
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 01:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C5483710;
	Sun, 26 Oct 2025 02:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B8W5SILg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1814D83700; Sun, 26 Oct 2025 02:07:05 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D17C682C7F
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 02:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30cce892b7dso1872329fac.1
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 18:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761440820; x=1762045620; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DXaiSNL/4J1Dte4QAMa5wJcnxnZcOopdnGS80qFP54=;
 b=B8W5SILgss4nowoBSgmHQ7pN6siz5REaLQeNNQX5DgSyjLeCUCLHzl8w0c2iK37q4G
 6nYgpUWxWzq0lLPYVttRAHEwbK3n+d1RtVMAqrRZ/tE4vpn0vHrZ2fRznIJmAIIE/NVN
 QYSYTfO7EqoItb5D5fvVtcY63shxnQNjvSIAxefk/E6E7hr3pC4sxTEG4sgI7GHpotox
 1uGhCWjLY1JWftNYlwWTti/BDBrtPpWsrG8a+odEGEW5+fDEXnRD4HLoRP5dynJmBqAm
 wxGH6XuQMMIatIDJ52F/YqV18x1dBHDv7dJ1bZIWw/3O/u7G1iZswlWFxz3Z+tNlQJFZ
 8zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761440820; x=1762045620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DXaiSNL/4J1Dte4QAMa5wJcnxnZcOopdnGS80qFP54=;
 b=tsh71Iw4KSJF4Ng7yzTnzxMMGgqWQaTedSCBveRxYpZ1upfWevac4hK1EsxwzVsw3z
 7DiA5t8W9W+w2puPLHXSkNNGJRxIWG2ewSoPvIuhKIBiFkq6QJu5mC4VqizcHKIAnj4X
 sjYX+MKm7VqCLaDrj/Ncz90TZuFvC0gC7qA+0livLPxfgfTP5JIXn6oVtqKBy1W0m45d
 8IBkv/lRARplh9JQXrBoGqXhfV6hihFWhZb9HOJxQqhAa9yNxd3xvcQmHz506xaLA383
 aPwgZFBjOaJpQ+YSEvt1dQZwM63IdLK4r2iEUarC3AAyTdNLNu5Z/vIoiC9g4orfTmp/
 mz+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFlp5fBkK2HhG4qD0Rq4/5gipsYLFVUgHbitGCMR4Wl0vDXjq9iFCa1VDY0FNWzlHMfAnt4X0=@lists.denx.de
X-Gm-Message-State: AOJu0YxPWwQpuWhE1hPDBxGd5NhZRpy3x888fBJ5dt8drUfbA5m+QJUI
 yt2h9n8ktYFDXJ3NQnLC7FtCTaj9PiWJte5ZvrtgBXCEDTsT9BhrTMWGHyG1zl49sLw=
X-Gm-Gg: ASbGncvkrwkpIfestDv6r3udjnsvd0a032BLHxPJV12b8q5bvkWELkLTKMyGbTxkBa2
 7A6yoCn+cMM/uCBCj9GOh6o5J/fOf18dys0QrM9Qe2+QUh65ukViGj8Y8TME45HO5fRs0FWU32+
 N6jCU0TGt88Kri9GbIrt3gHfBHRAZAadOc5o4bV0yU8XMz0Ib6yb4fLQn1TCaZdiU87uTv32Def
 R6ZrQ37Cd238x/phYQa3/Let/ftbp1FgPOLJ28H35DMkUOPJheBTQI607Nlf1BMk4+vcEemAJtX
 D8nOW6CvlBMPnEPRdRLuIbvqdTMLx5jtow3momqU/kQ8LsN9+C1SJUUE1U2vgFaEXD5D6MWkZBH
 jE5eoDWPqnfIeL1DENAvCRVufXw1xSPMcJzbPYt6EfaxETmc5ZEQy/0qN8osYz07+VCh+/7p9XX
 1JkhDcSvZXVg==
X-Google-Smtp-Source: AGHT+IGakKDXK+wjtm8ZroFj6Mr3nAO7rcTxrw/FIJ8Fgdexcg0ksm93SscPZbOlGGziyzK/PtWCIw==
X-Received: by 2002:a05:6870:7d01:b0:3d3:9e4c:c246 with SMTP id
 586e51a60fabf-3d39e4cc610mr8425fac.36.1761440820453; 
 Sat, 25 Oct 2025 18:07:00 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e20f3a07sm1146874fac.1.2025.10.25.18.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 18:07:00 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>,
 Simon Glass <sjg@chromium.org>, Anand Moon <linux.amoon@gmail.com>,
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
Subject: [PATCH 1/6] mmc: exynos_dw_mmc: Extend dm_dwmci_ops without code
 duplication
Date: Sat, 25 Oct 2025 20:06:53 -0500
Message-Id: <20251026010658.19271-2-semen.protsenko@linaro.org>
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

Instead of extending dm_dwmci_ops by copy-pasting the structure code
first, copy the actual structure data with memcpy() and then set the
.execute_tuning field. Now if struct dm_dwmci_ops gets modified in
future, these changes will be automatically reflected in struct
exynos_dwmmc_ops, which prevents possible issues in future. It also
avoids code duplication.

No functional change, but it can prevent possible isssues in future.

Fixes: eda4bd29929c ("mmc: exynos_dw_mmc: add support for MMC HS200 and HS400 modes")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index b230e9dbbf88..190c6349380d 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -367,6 +367,8 @@ static int exynos_dwmmc_execute_tuning(struct udevice *dev, u32 opcode)
 }
 #endif
 
+struct dm_mmc_ops exynos_dwmmc_ops;
+
 static int exynos_dwmmc_probe(struct udevice *dev)
 {
 	struct exynos_mmc_plat *plat = dev_get_plat(dev);
@@ -376,6 +378,12 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 	unsigned long freq;
 	int err;
 
+	/* Extend generic 'dm_dwmci_ops' with .execute_tuning implementation */
+	memcpy(&exynos_dwmmc_ops, &dm_dwmci_ops, sizeof(struct dm_mmc_ops));
+#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
+	exynos_dwmmc_ops.execute_tuning = exynos_dwmmc_execute_tuning;
+#endif
+
 #ifndef CONFIG_CPU_V7A
 	err = clk_get_by_index(dev, 1, &priv->clk); /* ciu */
 	if (err)
@@ -480,14 +488,6 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
 	{ }
 };
 
-struct dm_mmc_ops exynos_dwmmc_ops = {
-	.send_cmd	= dwmci_send_cmd,
-	.set_ios	= dwmci_set_ios,
-#if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
-	.execute_tuning	= exynos_dwmmc_execute_tuning,
-#endif
-};
-
 U_BOOT_DRIVER(exynos_dwmmc_drv) = {
 	.name		= "exynos_dwmmc",
 	.id		= UCLASS_MMC,
-- 
2.39.5

