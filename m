Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C84D1091915
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 963CD840B0;
	Thu, 19 Mar 2026 21:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J+6cp/MK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B6483FE9; Thu, 19 Mar 2026 21:02:23 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF7C84051
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-67bd4e63606so417515eaf.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950535; x=1774555335;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=of2EqJzj1/NLqjqVdKVd/oUdsj+uiNUN6zwnHLBTcIU=;
 b=J+6cp/MKI1mnM73SMiFxhf7gNiu/EWRLfswL9G5e/PyCXuQARZM/YBt+62L3H1SVza
 mENdf6dvh+e07LRZniES0vp0FvuaoJJJCBB2PGlwrdXB+QzzDD1ZsmWN6hzQbcaFiq/d
 brf4gBSdcPQHdrTHWZ+k6pR+/I2bREyl1Lp3HhyBNZtU9l16pZIubK0lqV3P1N1IkZ6y
 N/KEV0o2sqf6TrkkkudMLWGrLV2OUn40TsvS/osN2Zl+ESkcIVJJDXYfAQGLrm9GT/qP
 mFXIdtwDtiLtT/8gbPmflS0p5ubc2fc6yYdndh5iOOQA2V9AK2/IUlgBunz/1HsM3ail
 lzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950535; x=1774555335;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=of2EqJzj1/NLqjqVdKVd/oUdsj+uiNUN6zwnHLBTcIU=;
 b=CY4FzsYPNEZIYjU+oh38yGXgtm4btpR423G7h5F3+f4kX/JGJ8jD37v2HY2NJI4Mtu
 Xx38UUtqPQT2hd1FgzDvTpBj359hBZnaGLsxF3RAJb9/MlyyNO2jAY9oK7XkSNsg406L
 1bdIc2R2lGN26yf81R5hgUp7bERi9P2MgwsMU71dv8YXZZDGDXcQbFswS/sX98APjVRS
 7nMZ12D9lilXK/TWiXnvE9CxCKq2ARN4KWqLlicoxxMDaobDsyrj3xPEtup1SuBxwLKf
 RO+gsulNrufSaWECQzW/ToguyyiA1FtGTsR0ZBUwxeeApVnILYo3cpTajleH3c68fczZ
 hfHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPpQM4Wa1Ru/FWXNXDNZ90VvVVjmZVxnL8RBlAN/32TkZLenGEDnJcj6oTeJJ9MTdwd9UoFvk=@lists.denx.de
X-Gm-Message-State: AOJu0YyshOqkatVjO/7wY99xMmwgK7tCiyJr8oiTYTK2IxPy6dKNeswm
 p4/LOZSKMlW0sNE8IhqCJfIZOaj7hiToSu161yYw0+0CbRBstSw4cvfiDSAMAImlCJM=
X-Gm-Gg: ATEYQzzHhvmnIUkS909cKt/9zsNrq0jsmUuPEqxTQPxTscQzuMYAP9P2FrSr1N49vFa
 nDwtFlDVVrP2DXM18zPdz8JjJylMB8ZjDTpqyeDu8ZL5TIYFr5Ds4Py//LKeympH5TI8zoWJTS5
 z4fQAx1xYJbSozStuUCQ3NUr2e/6ZaCNYaBjZ3ev0OFaPuU62nW4W+flwFv2/0Wvf/awStOw22F
 syxxiPulz9GTsvxNaDV6GhL67fWLwK2Prw4wiJ4C5QjQWjMCLdQ2kzK+tBoV1+GFVrv2NEm+B/m
 jasG7iVwEoqtY/G4Qe3+f4Bew4HGy7ZfbwOIdzHbQMIH3Eh21uyiB12gtC7sQ5WT2NkR3P+VMEI
 wVgoh/DvffXCBj+rdwqkxvR2jA18QLAqSTseX4ZtB+6ZnlrMLUkX8vHUWxxUHolAdh4B9t99rL2
 USQ1B+QxC4Y+giA1ONYzbslsYAZxW3QJFy6EI8yJ0=
X-Received: by 2002:a05:6820:1b13:b0:67b:f1f0:28b9 with SMTP id
 006d021491bc7-67c22ed1405mr557226eaf.16.1773950535442; 
 Thu, 19 Mar 2026 13:02:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:10 -0500
Subject: [PATCH 07/17] arm: mediatek: mt8188: remove call to
 fdtdec_setup_memory_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-7-6171ec141f40@baylibre.com>
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
 bh=0wNF1x4RcXvbVr+/TZlLNxchBhZl3x4JelWsY152ZLA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFX0sb05Z/oYnsTDjg2VCfdcNtmvQ+H4k9ceW
 9KQDp9q66eJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxV9BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqxAH/218LiXYTKhruvmaP+FrPUlvFjoDioykFh2PHK6
 1miCGkAIryHNqgKiXUoex40SvDWIKULyHMMy1O9AZZPcboG08OAO496Sz9vBGtWUL2qqHMzGj1X
 87OcRvVamJNz34HBETntdwRWi7ez7dA6wftNm2D4E/dc5xcLsUcUMEYQIVLmzptgfWMi70BuTa7
 M4DqR8zDoxLV3P6si13VAemLI3FIKNP8ZC66jtqBj2vX1HeWM9UpFVGfyK55CszFPMKbSwDY/sB
 N0w4kDewrr0a4lLbfaDMjipOzyLjNlfBujxmdN1KeKo3GP9ustyZ53XR8xDbCF1q71VXdfpYFiq
 O8DE=
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
dram_init() for mt8188.

fdtdec_setup_memory_banksize() populates gd->bd->bi_dram[bank].start
and gd->bd->bi_dram[bank].size base on the "memory" node in the device
tree. However, calling it from dram_init() is too early because gd->bd
has not been allocated yet.

gd->bd->bi_dram[0].start and gd->bd->bi_dram[0].size are already
correctly initialized later in dram_init_banksize(), so we do not need
to replace the removed function call with anything else.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8188/init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index 8f0db7455ed..fc80bc92bd8 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
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

