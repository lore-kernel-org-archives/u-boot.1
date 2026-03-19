Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535771091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9BB9840E0;
	Thu, 19 Mar 2026 21:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ha1F6+CM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A711C83FC5; Thu, 19 Mar 2026 21:02:35 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F5AF840CC
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d751ef36ccso737402a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950547; x=1774555347;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/BXhUFXgVQoEp5M9kAXrMRFM+Y9gHQvgAZpZhqNZamI=;
 b=Ha1F6+CMLrn4qUg2hXkjOLwYVy7Jnzld3BMSMoeXNcwHmPvRyKw6rP8ZiuVT/rcc8w
 Z/qgV6Hjzp33qOlduhZL+tpulhEZXaecaURdEYz0GAmWPBJbsJ5nV0AVDYLfo0+QClKR
 fRJbEaBixmFuieArvczX1GnpvbSzG0NkVi+Zx0Twi+GHw6PrNz2nROH6rQPoz1WITD74
 STr4By6MvigFxSw6kusRkDCw6bLvKawbL7Yx+1Wu8JWmpbgPEYaP8uqVQ7bHFwbHfZUe
 l/edrKnsiQG5H0DvZF8pXxP5LJaFulhv4EkNtF/zPLm3SZ4F9UhVKNHLY27UuVet0HbO
 fe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950547; x=1774555347;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/BXhUFXgVQoEp5M9kAXrMRFM+Y9gHQvgAZpZhqNZamI=;
 b=G9UHkEslJ7+UdbSi3wtDCnFMnBptrwcT8X4D6A/vyiZK42lKOxG8ZTJN0YmA/gjHhD
 H7flT0o8096djxCmL4fW2fw1WvBTm9fPdkP/WaLQBBWZUIiH45zLhdbHCRDq5uEuDEYW
 uHO+RWJlZTWSEprTbzy1IvvAnN5xOJlP4yBa/qrGH9IDFxlQA/Q2WGm8C2BwhPTD5XcF
 nN88VG3imx1OyKjsJnWzvE8Lqus/h+RHUQYOCE3ZrwKCTH6+PuCghjpgMsxtI2yE38w1
 S8b8rCE4/15HIxi9guxvB+tVhceVTMVozj3chkh8l2eG1Tet7OCK03q7NkzyKRgazoBC
 zJIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOaN47gRVQQxx8YMmA9wyFGyRFeYPb6f2UJFvtoUv0l+p4umNV1iRLCLzFe0yzuYe81pBZDHg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0mFWx9Q2WKZLrl1qrnQeXcYvAmeINVrkiMY8zQT/hpv51GxB5
 tw20B5ud424TYLrNTLjZ/sRoDWyJlwEUWEOa9wumfx5JwWzF4yFPyKl5eUpWkeT9lb8=
X-Gm-Gg: ATEYQzyoz5elr6GkE/Curxogvop+Ad6qHfL2q/c9iO5efA0/kkg4XhLjH0bU0qtXn5V
 Hb9uwJ5wE4eYmdTccig/F55YqrG7G7CdZ2WTGdtnqYhh6MqkercYH17pg2EJSdXaZqOo+kSntwP
 DdaydZglXAg71fd1wndKSJ/gZc/zId9u+9slDlFwVhvoWKq7Q6dZTgQ4jpUw0t3+KIdF7pRk02w
 SRGO9Pyk1I0sqq9tV2LUgFCnxqna5DTUYNOeEjKFc2mZR1gZKpCJkiLC0//qGPPWOLlsdQcmLPT
 syD5D8Wud53Ep5yYWLDaFBeulv0Wx0WOmQ2xD05G3XuSoUS+kRB9Ga+DLwwEDQmtp7R033TFWYb
 zAi1r4HFMvhsqom9OT7dRzKa0ND/QJ5PRKLyAjENEz69Q3xZ7BtiLUohuRVeJuZLKm3lGK8n+4L
 lgDWNSyNjx8QnxYBS1IngUxW8rdXbh76o2WV/O+2Y=
X-Received: by 2002:a05:6820:81c5:b0:67b:ae35:afa5 with SMTP id
 006d021491bc7-67c22ee5124mr556462eaf.27.1773950546815; 
 Thu, 19 Mar 2026 13:02:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:20 -0500
Subject: [PATCH 17/17] arm: mediatek: mt8518: remove call to
 fdtdec_setup_memory_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-17-6171ec141f40@baylibre.com>
References: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
In-Reply-To: <20260319-mtk-init-fix-dram-v1-0-6171ec141f40@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Yo0LIsYeYQYOtd1tOXDBDaTiU5biwAZM9gUuPrwsaGg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFY3UXVUmJz5aesWIqI3dPp1MOS2DLbjNUDLq
 l+s10Flho+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxWNxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ARXcIAIx1gUyowKIpfH56tx6d7W1OoFv0OovwQI57Lp5
 iSVCZKYrd6+rjj+VVT3wMdtuWCnypyYkm3v8BjnRNIDBaqq6bomIOkF6n13oh+2xlv3T7QYNyfB
 sijtUIG54RQDgfh0HeFqES/KZeiR4/fK8XXtBfE+DV1QeKM5wE3ozJQ3fokH1JMF9/5eySv41oL
 a3YMibVdQiFlhFC89IOktpMlSvv5z3wls3E5ItEJRwagkOO1ML4qiBNmZE5FQyv1CqE2ODl4teP
 sTfddqgT80+b+m4Y5Fgz2zMPqfT59XfnKk0jYKUE7vEzzsROxAZfNVdX99/ZjzEthTNO9Hvl6oA
 iDoA=
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

Remove an incorrect call to fdtdec_setup_memory_banksize() in
dram_init() for mt8518.

fdtdec_setup_memory_banksize() populates gd->bd->bi_dram[bank].start
and gd->bd->bi_dram[bank].size base on the "memory" node in the device
tree. However, calling it from dram_init() is too early because gd->bd
has not been allocated yet.

gd->bd->bi_dram[0].start and gd->bd->bi_dram[0].size are already
correctly initialized later in dram_init_banksize(), so we do not need
to replace the removed function call with anything else.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8518/init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8518/init.c b/arch/arm/mach-mediatek/mt8518/init.c
index ca64f5d4767..9cedf337743 100644
--- a/arch/arm/mach-mediatek/mt8518/init.c
+++ b/arch/arm/mach-mediatek/mt8518/init.c
@@ -24,12 +24,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
-	int ret;
-
-	ret = fdtdec_setup_memory_banksize();
-	if (ret)
-		return ret;
-
 	return fdtdec_setup_mem_size_base();
 }
 

-- 
2.43.0

