Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970F91061B1E
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2718407B;
	Mon, 30 Mar 2026 22:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="byg5MkFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C1D8407B; Mon, 30 Mar 2026 22:43:12 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B056980212
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d7422b4ff1so1544183a34.3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774903388; x=1775508188;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cgE8I+1OiUgAb8hm1SxB3gqnD2Oth7hO5lGofPbY+/k=;
 b=byg5MkFnmPSmjujqoLsPYUIDeJwcVjVjheFR6szjOWcU14PInJyIIilk5/Fe/LPayp
 wzUoWjnZ97UIsV+bS4HRfP3a//ZW8v5bZ/Ndp3SSbx9n/cL3KzSzvOrSr2wD7vzDZuMw
 pMiXu/P6THJgXS3qU3oEslSdCKFh82rVRo/iEUjspdI681GoGpSuHCNpoPE/F0IcyVqj
 qwNq5kX3o9laEnde6pVmpw8LP4eTl+U8Bp/zIbkNL32Ev4hWTsD1dq+py6AZxlcS+rAB
 3Y+DHHpNH+lO4CCD+f6BC0YTv2Mt4EjI3LKrE/BOijsj83UxnN5dbNwkl0VZ1ws7bWcc
 P5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774903388; x=1775508188;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cgE8I+1OiUgAb8hm1SxB3gqnD2Oth7hO5lGofPbY+/k=;
 b=ob39iZjB9V4LmeMrHG3jS5i6cN0NcszU/M3jmtZ8bxh9GAMLTv18WridrU9HmERo6a
 uflpuFK6+Hm0zAb23oORvk0go/qse0TKWX7+dVuPJsh7HnzXUqhvzguGvJnsPNYRaLAj
 twL05t9W7n3ttL6SUksVMS/75Bzgv7t9ifmtaVZlHa9GhxXptQthbOPeJYK4fAGzu4ky
 bnQibU/MZlGv2AQXqLgzWhUpn1B4DB6wJBAyuPGosBfMBat/PDZT1gm0jZ5AUaUTs3Rc
 jro7kXkvgRL/bYc77uWdcGaubMBz6NI9MoltR/Sj842Zxd9KNCxYFp5K0qfyO8n6yzwB
 b/eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnc2Wfr/S7Kl0csK5wc7hppAvG9Ct+PK7srPl1QRWjoz1PV/y8y8LzcqgF/NHypZi5KnuieoE=@lists.denx.de
X-Gm-Message-State: AOJu0YzBQLFOgw8aExSjK0BkTOFLsdAsuQG0K2sYazEL3gijkJvzaeEJ
 FfpUo8I0EoTl9ragrPqZoefFU2cniZ7Sd1xlwz1uRyASIeFVJ86l0SGFdI9oh8+n/kg=
X-Gm-Gg: ATEYQzzrSS20eFfI4+yw09EjdJav3Zn//6Adq7rEE2+tcI5E6SCr49RSNRcM5gm/VS9
 m/bmAKNOMLXtomGp9qRhHQ1tVD9nnLQ3JEmCPFkE9C3W9DBcXa28eEGpbsH9RIFNFSrjs8PsVEk
 8jFDcV8H24Ez+UGvOty+V/oKEQwAeJB2gFS9BC05GJ30YSgI2eNj7u5rO7jhm30fa1dfwfg0+Zl
 7kHlWn1GuSSFn2QzH8R8lvhu5Y5IqkEOAWMk3w5p6c0mrWkZQULc2JkzPAWaDsrtQ2kQg2EtzTs
 80Rz6XM0T3xgeu4sb03TTee3XBnOSS5A/W9u+l3Gq++WqdB99jZjMNtsTJ+7CJIHkVmSKL6YK7W
 1EW+EsWikF3uhe12Anr4YJVYe1+WfkIBSob7VAE2hLMDbgQMqngw9pfCgN3TDNWei+O1/GIXmH5
 qcJDyuAQDKee3CbNAftTavRJlWF+Tm/Wahn/ha7ss=
X-Received: by 2002:a05:6830:43ab:b0:7d7:ef00:2909 with SMTP id
 46e09a7af769-7d9fae274ffmr8291341a34.13.1774903388357; 
 Mon, 30 Mar 2026 13:43:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a384631sm6595736a34.7.2026.03.30.13.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:43:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 15:42:14 -0500
Subject: [PATCH 2/6] ufs: mediatek: clean up zero terminator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mtk-genio-720-ufs-v1-2-3bad8362ed70@baylibre.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=m1V+FzFlAyRrMa8eRqEI3JsIkFeUW2dMC10BFd+hnkI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpyuA3MVsf6WrLq97cUGHavKjArou9xpDL1Zn0k
 GmkmDQ+MHOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrgNxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+WYIAIuKIyT35ib84bVeOX8jqyA54YvlDIGCwoCqdjI
 8jjr526zQ67GSX0XEI3dTUyVdLQgXWYPfdHZIAsKYXrmZnUkFmuBNNb+fl8Lo2n0sqTTNiGDXpl
 nZut9nqxR1LGrZu+cwXVVqUge/kcrR3r+QROUK2lDRn3xZPQt+sBYqXu5LRGkn2cNFHXjgF9+FA
 6UW7DPy+dJ6Rb+iJOudV3KCMwe0mfXDKYnKsypMi7zQwkIfkMMbe+qDu2jNA9vbPr+Nk6dBqCFd
 gLpWvKyYB07Zj9MEVUrevkU5JwlkMtWOR26sh48imBPOR+1ok6h08oLpLsYBCxVVQCEdv8M7fAi
 J8s8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Remove spurious blank line and trailing comma of the zero terminator at
the end of the devicetree compatible list.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/ufs/ufs-mediatek.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ufs/ufs-mediatek.c b/drivers/ufs/ufs-mediatek.c
index 2cf65a3185c..268627d5863 100644
--- a/drivers/ufs/ufs-mediatek.c
+++ b/drivers/ufs/ufs-mediatek.c
@@ -397,8 +397,7 @@ static const struct udevice_id ufs_mtk_ids[] = {
 	{ .compatible = "mediatek,mt6878-ufshci" },
 	{ .compatible = "mediatek,mt8183-ufshci" },
 	{ .compatible = "mediatek,mt8195-ufshci" },
-
-	{},
+	{ }
 };
 
 U_BOOT_DRIVER(mediatek_ufshci) = {

-- 
2.43.0

