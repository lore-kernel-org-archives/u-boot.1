Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2BF10F2867
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 19:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4088405B;
	Fri, 27 Mar 2026 20:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dY9h1uWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD1683FE9; Fri, 27 Mar 2026 20:03:55 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B754483C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 20:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d75ed779bfso2331876a34.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774638231; x=1775243031;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=shhhLY7oUlBxiZ2HRp3esMVpittlKVFVCW+Bn3Iaxa4=;
 b=dY9h1uWF/5BUQmguqTbkIg1z523zm/12CbOyvhq3ZDuZgz3BWJIgVZSYzjgBpB1N+g
 smTSJZTQ86NJe3EZTLHvAiNUMYYFVXkLfP9+ig4Adf4TnbgnM124eKGqoOlZfQlvheHF
 uezPVPoeCDji4dKgf9Guvvq5uINohPUWrYk4+SxzVT5YOOK6uJ4LQSX9VEmWaYJyer2b
 lkGbTSsrpWxwca1a2nyHIoCOPlx3X21tsDQLmKB3nyZPGHRddj1vjrBl46xbCqYbhLB/
 yxTl+UQyrPdVShCJTu4a1PigBFm0pVBn9U2aPh4Wq//7Xap7WczpKS2j2KtgNgtsTDO+
 kPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774638231; x=1775243031;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=shhhLY7oUlBxiZ2HRp3esMVpittlKVFVCW+Bn3Iaxa4=;
 b=bfEJaISo6DZizRacX5klsVUjUE6eZ79xVFQAAQL/Q+62OU/Vqoj7VcZozGp8F1LKBW
 ykVBS7z1yekjg7vK+qZ8DMRauYLgLs2SrxDwBooc6a8V5sAk7heptbol0a00pz6BlfKU
 fA2sYyZhgycfmZakjShM8BJ/sMHtKiBFQ7yXrnHBXZFrooie880r3VRMZB/Ja4CYRTsQ
 BriQIgvaP/ZZSnisCtCljkV7q1K/djgLqeCywWjcsI7BtRP8pAei6Pa63LFJMpLJG770
 gNeh38PJWKuyQAlkFYmwyqDymAmdVYsGuXMJAS8eyKPeZtNVDkXnVxZyr+aLXsVnMwzG
 u2Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWquuY2ZXb7+m5jdVSRcE7ilPCp9GRj+rODKQEZ8ZwzVPjhX7IrM8BMd2rodAbccIEWX7qUWA=@lists.denx.de
X-Gm-Message-State: AOJu0YyhoKB5OToRWM9l761cguTh8/niOAVyActOhzh/UvFafIm3dema
 uSbtqymdZnXLJZJsBYHCTRD2ozuzI6j5PZogNR3A6FALkr+GjVaZ8FMDzmr4hbdBXaU=
X-Gm-Gg: ATEYQzzFCP+lQ3Cz972/ZvLmA28y8BOxhC8enhfRMRj1MeySSQQ6BvDSuqFOxoxRHV7
 eSYgyPmsyeYn0LKp4ugNicO+q/oXSq7Zy5kdHycs3CZhFNZgSyBYKjYqsGpWezEbuHI8XCgypCY
 Lh4i6BEF8dLeyuCV44ZgOKqjt+NGaF3tYQ1Iy3c++7UnlougVFqOo7JRs174KADEVFbxN8+rmuu
 D7CznxLEGEK+HEKFVaZSPFfqRTg+jJQVkRLYtA67FdthKAGrgjOZEppjYGgJl9EcWSNWfBzxFAS
 m4IwXLAh/kRb3CXfaKx6XvMDoKXsR4Sx/xTi7wW2tpyBirTZVBPI+8F59ankQfd+/1pfdAIJaLL
 F0u0qRQtilwRAOfI0Xm3Vk7ynRJB6Y9WPgZr+NbJOyL8U9VXWgLhasqJVhH3lZQD9Xj+6+MbnIf
 nz5O+HDJahKG7gUqTVJiHgf5I5j1s6
X-Received: by 2002:a05:6870:d90d:b0:41c:f37:ede1 with SMTP id
 586e51a60fabf-41cec15408amr1873684fac.14.1774638231360; 
 Fri, 27 Mar 2026 12:03:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:54a7:4cbc:7d2e:3b99])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d0496591csm113534fac.8.2026.03.27.12.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 12:03:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Mar 2026 14:03:18 -0500
Subject: [PATCH 3/3] power: pmic: mtk-pwrap: drop PWRAP_SLV_CAP_DUALIO on
 mt6359
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-mtk-pmic-fixes-v1-3-ef874ca82409@baylibre.com>
References: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
In-Reply-To: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=mmGxvPf+Sgf9Z3mV96tolfMp6L/bdhbwbnjSylDM4hU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpxtSLqLpF8K9Bl9Ya+k4vZM12pxTVATGx+Lo+1
 3BQVMejhcqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacbUixYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9dIH/0X7x4BR3AJmfHuA+3caJsZelQZ9U4AXp5Nl3mb
 nmiF9sDT6gNxPJokAO3E1DfZFP6XE6H8KpTWvIET7IAUzLWSuf9euWO6fPPe15PzpifFks5i7Bi
 afNBwhHuxhUx4wRCUL/V4U+l/x8qFjsMqM57Yyj3DTj32kAQFhPHSfx9jlacq1SH4lUSHBVgvhT
 AR997vdsO5/JYn1+AB9kqU5wiF7BdrzFiVB/wSMVHix/BI9IdQEQeicLBPt8zfDZDhPG7+C7CC/
 3htyMI4dTVjMPz906yibErE+qGBYEOLsIgtXuOASiLw9mr95o7/983BTfMuTe2HLWDqWerSPSVi
 2INo=
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

Drop the PWRAP_SLV_CAP_DUALIO flag from the mt6359 PMIC definition. The
mt6359p variant of the PMIC does support dual I/O.

Prior to this change, the driver would attempt to write to the
PWRAP_DEW_DIO_EN register, which was not defined, so would write
register 0 (DONE2).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/power/pmic/mtk-pwrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
index d8498646921..6a2c9044b9e 100644
--- a/drivers/power/pmic/mtk-pwrap.c
+++ b/drivers/power/pmic/mtk-pwrap.c
@@ -665,7 +665,7 @@ static const struct pwrap_slv_type pmic_mt6357 = {
 
 static const struct pwrap_slv_type pmic_mt6359 = {
 	.dew_regs = mt6359_regs,
-	.caps = PWRAP_SLV_CAP_DUALIO,
+	.caps = 0,
 };
 
 static const struct udevice_id mtk_pmic_ids[] = {

-- 
2.43.0

