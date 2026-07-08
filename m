Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A46AC44501
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 22:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D85C84A63;
	Thu,  9 Jul 2026 00:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Wp7s0Eg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BB384A90; Thu,  9 Jul 2026 00:25:07 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94F284A1F
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 00:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4955cd5da3dso540190b6e.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 15:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783549503; x=1784154303; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rK6N2symD9JWjnOuf1k6v61fBmxWS2ZRcmNUZP5dlfY=;
 b=Wp7s0Eg8f+HHoMXPSaIWDOpGpg2ptFFl+u9t2PjU8E9YnPmd7vuGj8pO7iKDtprZ1Q
 5e0iIEp28VS5LgR+CIib3SImqAGPFgUYZXgSENPsY/TG36IgKZ0o8mioeIW4YcsqcIZM
 3yHhiTOY8ODSKOTlsAYd6S1XTkuabPoEySjaFL9pJlK7f+x4XujPViUluteJ8ZJjjWSY
 zc4ggR/zVNlmOHxC/ZU/Q4KvFrFPZ7JAg7qNXL7VZ0/iL3W5IVgICe3Ppx7E3QZS9Nze
 DCnWUPY5gUNoLla3I9htqFgopOHyH00weR2udndu11L96zVQaR61vFat34lggWQIm2yj
 dTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783549503; x=1784154303;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rK6N2symD9JWjnOuf1k6v61fBmxWS2ZRcmNUZP5dlfY=;
 b=Mo/cfctuLyMGOivnFNLzf5bh05OdDo5H0OnoQPG5Q6Bo4gaGVTeFecP8laXapEad4s
 QgmmsdtzJiUc1fup46mlnL2u9CvS221YsnXQW3zdz8Mjm5tl6JMEGivxFhoFKcTuoPh3
 pSpcnxWmerJzUGMCNYH/NPhK/AWAsV/5UFfaGplh6kVqr6Oph2eTbsK5uTMH48W0dRhj
 1K0+wRAKxvOJoHAaNTa1EofgxdekZGM0N0lf05w8hYL7NmqdhJMmuAX2P7uMaGmFLlDz
 aO93lQGbYpDK9K+kuSYjANQtzKCtCuLtPeWKUGGVdRT2XfJacfWXkoShM2zlos1woSfH
 tHrQ==
X-Gm-Message-State: AOJu0Yx/CobgI41/vz6pMTtdUxm2nAnTJWrlQ89e23N5XRLqYNNT/MED
 u/r3H2JeFlB5YTgV135HhKdbRA7nJKzStkXWJ+hQ+88zVGnVjsf5x3v9vCjO0mMxGsQ=
X-Gm-Gg: AfdE7clNlmQ/fR/RrT08986CQn9AVaBZrllMBl/6ygZYIhcpBS5YwDLrk/HUfWx4w00
 1RnfUgT4nsX3f4I0v4tkF+QpEePjojhn9ppfxVphXSsAGdzWrcFWkue0P7hHQtfUP1RtURH+gCh
 ZSU/9VaH+4TIQ2sCPAJ0UWFektliXwjUasXeiS2UlPTAnFrK+LjDSH4HYVOtCduoLvJNeaaSoSg
 y8d3KSrtsi9PMmJ0Gv66fE0WLsW6uHKU+Ls1jR8IQhwfgvNay0KdTecSCvbKLvbZg0ZvxNVtSAA
 Nvsk2zMr2qBewDnRH1wPKcnRKORQttsbsam9J/tOqV2CUVWtO2SJS2JovUYzqqsSbB2FwCcwxNr
 0Wc5oKpLjsISY3Z+UIfStQT5DSFPi1mQTOlGgoU07m++k1y/w+eggWMufwcjA9vqHi5XSekepl+
 +8jVjNKD371SyVvU9W2w==
X-Received: by 2002:a05:6808:1a02:b0:496:b7c:23a6 with SMTP id
 5614622812f47-4a204ffdc75mr3073087b6e.38.1783549503000; 
 Wed, 08 Jul 2026 15:25:03 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:19a8:8ead:9ca9:cb30])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1acc82f3csm2636343b6e.3.2026.07.08.15.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 15:25:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 08 Jul 2026 17:24:43 -0500
Subject: [PATCH] arm: dts: mt7623: remove duplicate topckgen override
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-mtk-mt7623-remove-dup-dt-override-v1-1-efffd4b6c12a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNSw7CMAwFr1J5jaUkLWngKogFTVwwqB85aYVU9
 e4YWDxpZjNvg0zClOFcbSC0cuZpVLGHCuLjNt4JOamDM86b1gQcykvXelej0DCthGmZMRVUFOF
 EGHtbh1PwzdFa0M4s1PP793G5/j0v3ZNi+YZh3z/n9GczhQAAAA==
X-Change-ID: 20260708-mtk-mt7623-remove-dup-dt-override-cf1389864511
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=774; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=vDE8wHMwTKfQpnjst3lYfn70JYWQcEPo52O5o6YISOQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqTs4x+ZiIePBrvoPOmeLx3OD45SLeYAjuHODoY
 sHh/AxP8VGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCak7OMRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ao+QH+wZSLXbukn8iFtt+ykiz5Bhh/d85IUJpAEeALnW
 CmfVYzgQ5V9ECzCqhIHTv4RazHllG+0NiDEN8CgSOoXsg9oWvKa0OUg36UZ3Innj2enC+w7ALfh
 0KSGRG/t03/Uz8E+jTnFGJZ4cQjaA+o/X2ylFdrCjRF1QDQujftAqpZctGORbI+IwbLA1ldUrYS
 DIPVZpW4XMC/XhhsVVhGCiS/OozxLYdqPhN/YFGAXWzhBUgPfmC8gTACkM1jORGGQ3vVNZ3QjN+
 31EftROaaK5a1OTE2U/FuQzC3Swd1k5frNFKNGzrEGlVnxReZAPt24DWCqniBjRLb0w3p0swjTc
 a7iU=
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

Remove a duplicate topckgen override setting `bootph-all;`. The same
code was written twice in a row (probably copy/paste leftover).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt7623-u-boot.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/dts/mt7623-u-boot.dtsi b/arch/arm/dts/mt7623-u-boot.dtsi
index b9fd49900ce..06414180f29 100644
--- a/arch/arm/dts/mt7623-u-boot.dtsi
+++ b/arch/arm/dts/mt7623-u-boot.dtsi
@@ -8,10 +8,6 @@
 	bootph-all;
 };
 
-&topckgen {
-	bootph-all;
-};
-
 &pericfg {
 	bootph-all;
 };

---
base-commit: 913fedc816570c07bfc7f9c4046dc2a3a55e4099
change-id: 20260708-mtk-mt7623-remove-dup-dt-override-cf1389864511

Best regards,
--  
David Lechner <dlechner@baylibre.com>

