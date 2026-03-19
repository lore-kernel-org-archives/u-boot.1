Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02EA1091916
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4284840F1;
	Thu, 19 Mar 2026 21:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pKqtXLO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C7284006; Thu, 19 Mar 2026 21:02:26 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32DF484065
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-66f747175d8so716855eaf.0
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950540; x=1774555340;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ursN2O5p9FIAaGQs2C1NStVIgwMDdb2v6HfTzxlg7JI=;
 b=pKqtXLO9RmPHIt4F9yQhmcdsnZkrn9BhVNTv2ViyhelQkIWzqZzAw/NZz1K63dUqn5
 398z114oWHDd+3nzYcHNCQsrQQ+9ta8T4CO4D9DfDHsPdt5qGy3DprBMkSWHql3E+5P+
 zVhJ3sf4anCaddKseTV/V0jU8555Guy/qadXfS/tmKpX/4TjeNNnLRQJeb8FTHV0/LPH
 mFxMXl42r+L5d8WfjPpDZTbAvFCXFEm045Mch7OEgbwEUa9dW1tlCvRKUamVgXGtDIfx
 h/zKFF4P+aKL7UMYEesweCzfnLqQUSeaQigUXKRxyEFI+1aKIWYj9QpleeRqzmDxdS9Y
 DTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950540; x=1774555340;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ursN2O5p9FIAaGQs2C1NStVIgwMDdb2v6HfTzxlg7JI=;
 b=QpTIWDH7gR0DC/BnIlEiJ8b1JsaQ0WJSdyi1Or6W4wkalUw7zrZLE6hXD8I76l4MzH
 SdDVz/MXyGqIYJWJ8HhuE4CU8ngPq36kcSiLNSbjfCxvCtxS/fiw9T/ARDYp6knpg8jh
 tCFT27lUswvrNj4kw3ZZN+RECsdx70iAdffMVyyD//ZDFQJcSwpfdHGeuh1epk+8dDCP
 7GAl2OynkWKvGXLvcdVi249jfV4HAcofBjVGuIwVqrwOTaLMQFAlLWvvzGLN2uIWHZI1
 uJN5962kspfrseCBC7rCoxi9fJRrarGucpEPV99oLrEryw5LokyhoCRHJ9jH9JBAfg2m
 5wwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFQoJLrRHWqSEze8VtTinFwA8yQc01zU6l/tTY7+9R0t54XoZz+KFWTzk8RV010z0+H6kBVFY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6+jGGvABU2HcINl0nUHCQFRBH1+ncmosO5GbL5ogn+6gkbsB9
 sZqwBprrTYuhxI4msvFVle4bfY6rzwpXZatzBx+nUNbt7pE5xCkVszttfZrHtEC7gIE=
X-Gm-Gg: ATEYQzwjJNK7o/fBzV1L593DKqYbQxSmgNFH+yUMX0OOmxc1SBjhguvuICtVVInXpTq
 sRiIQnQEFJAisHPZxwuyg1SLsJgYoJr3ihlTSfaUrw7Bc8CD6w17NKFctqpsWKEzo18TU8tuH96
 uhUjlFNll/zfH7B6ucnAIzEMVw1swX7FDLQZrbpgaDKRhG6UsaWN2QD9jFTLsdiFMTto5cfAlbp
 do0wKsFUkqIi4mUPTah0CcxGs1+Q+o9I6s9qndoxXhJGxZvRKF0dxrXRhoAY7QfmiUD+MTcoNB4
 +GMQlHThg9qL2llpmyACmphJDzzebRtmmwCABfqrOmZUDjjmEKbOT9NeEZBKHnDo0XlxLCmQXKx
 6K97dYmH/I6hTsmWQgvyfcl4QSpry2GPASpr8T5O+CKH+Ky9dqUQrjU++hDN/Lh3cjmf4vCDIus
 Vn2Hq/yIoV64uXdM3w0Q4nR1GYR+Eg59ymG3f3WfI=
X-Received: by 2002:a05:6820:1990:b0:67c:212f:c126 with SMTP id
 006d021491bc7-67c22bbe351mr594392eaf.10.1773950539660; 
 Thu, 19 Mar 2026 13:02:19 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:14 -0500
Subject: [PATCH 11/17] arm: mediatek: mt8195: remove call to
 fdtdec_setup_memory_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-11-6171ec141f40@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=fVpvhxpiur4v+yAcxiOHBMN8b/8gUfBd2CRcK9oq1FM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFYPam15Lk2pgGXzwRtQm7Wsirlk7a5MN2Ioa
 /8GPDPvetKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxWDxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AHy8H/Ri6rgw3Ytgyv6fO6WVgLw7jbsJVptHvLMjq+AT
 ir/7HsVV91kjZ+omLtl/l/tQ/Mm9gf3SUz1nUwJfuzdnP8Xtn6D26fxLfFIrTjJtTqTEAebRCFX
 IWHjUymCWwRMPoi8Pe6d0gQJeodU4Bs6o1J07zZos8KBNtP2Ypt0ZDdHSerIPaMM/VIbSa84kZL
 +2PQwmSeZEKqm/Q25TOfQ5fTLGMCPFCGLsb2QF5ieo5l/i2Z95mVjKe6UEm9zqSc5by3cs/q/cW
 3q62kkP3WAcNQRBRAqCaf/LxKpXxymB/gFV/2zN4r3uhWytOKRRGg7AK2XL+uTF4dS8c2u2lOHh
 auRM=
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
dram_init() for mt8195.

fdtdec_setup_memory_banksize() populates gd->bd->bi_dram[bank].start
and gd->bd->bi_dram[bank].size base on the "memory" node in the device
tree. However, calling it from dram_init() is too early because gd->bd
has not been allocated yet.

gd->bd->bi_dram[0].start and gd->bd->bi_dram[0].size are already
correctly initialized later in dram_init_banksize(), so we do not need
to replace the removed function call with anything else.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8195/init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8195/init.c b/arch/arm/mach-mediatek/mt8195/init.c
index cc9a2c68e0c..6b47ca4b059 100644
--- a/arch/arm/mach-mediatek/mt8195/init.c
+++ b/arch/arm/mach-mediatek/mt8195/init.c
@@ -18,10 +18,6 @@ int dram_init(void)
 {
 	int ret;
 
-	ret = fdtdec_setup_memory_banksize();
-	if (ret)
-		return ret;
-
 	ret = fdtdec_setup_mem_size_base();
 	if (ret)
 		return ret;

-- 
2.43.0

