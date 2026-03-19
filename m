Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAA71091915
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 117ED83FC0;
	Thu, 19 Mar 2026 21:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hYT5Hbho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A1484065; Thu, 19 Mar 2026 21:02:28 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FFF78405A
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-467d9ca391cso424275b6e.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950543; x=1774555343;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xVlcPkturgyeHzuofVMleT0D1Ry9PjMI9RnEZ1VdR7Q=;
 b=hYT5HbhoRWcWvQGlnunEkFj1IkoB9eR6QTN5MXdZg+DotS1zj7z9mBoykHiKQWkvs4
 UNGZiJYCwLX8VwLfAVXPefPBA0nA8A4KDp/CgjBsMKFshWips4u9Cow31JXLmnynHKMh
 gXzUTLCxBg3eJQxkl3nQZwXeSqBrAD4IEQIASVGewsagF3rGPEib7iwGJC/8kN5wt0ja
 9YimHb34uRxoSNKPv/OiP+2B8Z6PT5pJ/GYR7M1DV+hyETg+dQSa+SRIVYJqLZVIHZ/W
 BeT8o0sckgO1O85ajSZEMAcJEmp63/ubLvS189EYe2qa9is/+UDfLkx7QQ1hU+UvfHqF
 gr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950543; x=1774555343;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xVlcPkturgyeHzuofVMleT0D1Ry9PjMI9RnEZ1VdR7Q=;
 b=ArHBxdbyL1+afmGgFDWN4X2A+Cgu94ZZiUcLjF2lcbBdfFlN7bapsKHPCBAisqvxTU
 ayYXlUyWnDRLE7z7c0oLhAZMpWU7jG5B+VR2GoKhzv2PzPimx6VeUKczt10SPrevCSQZ
 WGyJokPVfQCQolotT5CI6H7pygBWuOVr70E8UX4vtwDN6MD3nLIVRgY9ojcf1uzNgR19
 KonCsDb4mz0Z+Rp+KU/4NGEJqfFX6JPBJih1ZYC45tn8RWaNov1B38ZXIFhqJ5stttun
 e7eoZjVE2zUdxAKKWqoulC6WBmkmV/5jE5ISz8b5gxdbkXHYVswrnC0CwBLsVdxZzLvE
 xTEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7GhoYL464BuU0vkQZKRphW5KFvU2mnRzuCGPGVCKxqCEH9iPKUzijWUL08CyKBJa7DWt4pIE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7FJrgsk5W91mlH9007fS17RJtw2JhL3BqtxdyAoAZnNRO5CFl
 DjmCPlyZFdrU6Sh1eS0MG86SPCOEyg0qo1dTsOShb4LgncdzfO27g1CsZRxJmbsL+/A=
X-Gm-Gg: ATEYQzy9eTuT9m+0Pm6+zArrwfofiROIdhPYCam6JrSWLXEP0Am1Je368EudsCwai9G
 HUh0z0ob3vTCWYfcLUKNx3FcqiRZnTJzUaYHVqWdN/0khuNgxNCVGv3AXTlIeUI0wML/Ehgq2yb
 notJ8qTabKlDVpagA74UgDWaS4YdugdUjz77302reb6LMnkpWlhD4brMgCTB/qPCnNlIkH6Zs9l
 oJ+Wt6tojLO071zOIr95b4vy0lnKW/XEVGc8UefFe7s4uBFxX6yNuNIOE5Cs1xbvKiZUtTpRXdZ
 vvt11tTS/nFRuJkGPdJ42x+cmu0gvUfziStWXIVzNNqqIH+9noCRg99TKZky3N9rl3+nb+YfpxY
 Ecxe1xXGrObkcB8+DWyrndcG+wAhJevX27WI0w957a9tW80pNiTCQoLWZ4DJMZvpi/OqN2b/Al3
 ebTS8BBOO2LRntWtn6lDBUQxY+5isG
X-Received: by 2002:a4a:e84b:0:b0:67c:1ea0:2c4 with SMTP id
 006d021491bc7-67c22ef416bmr542511eaf.6.1773950542687; 
 Thu, 19 Mar 2026 13:02:22 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:17 -0500
Subject: [PATCH 14/17] arm: mediatek: mt8512: drop dram_init_banksize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-14-6171ec141f40@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=18lUawDdxpR9HyWMFmBKHmJsRnez+pZWdd1y2nM3b8s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFYiiM5ZXzBXhW/fIyDytBtCUWqPXgoNyrZR9
 N4qwlMSCuiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxWIhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AtlsH/Au/euYbrZbzErEhoamPMd4syuewpXBFBic10Yv
 MiK/MqkyxmS18wZ5Bkgqyr60iT+Z07e/yrJUoVKOzseJfDOoULKKtScLXd5Qa7673mQFOVhSKfY
 LEUkWetGttPXsSxvYnD4jKLAg5hGuBXROsILVj8Azbtg6DTwY4sO+I3vRFpIepSXaPPWcpybWNk
 fxBG4QJa3S26xtZFlp1kw+5dv3lw/tG6dEe29HkmwEJPWIaP0L8tIX3aZodjw1U2WpDib2lsckD
 W2aksw86yS9//qcJNbr9VOH6R+ejhlX3zNcuEUOS2FBRqw/KD5ovyYU4I1EP2RFJJW07SLl6MdX
 UFbI=
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

Drop override of dram_init_banksize() weak function for mt8512. This is
exactly the same as the default implementation, so we do not need to
override it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8512/init.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8512/init.c b/arch/arm/mach-mediatek/mt8512/init.c
index 361c589cbc2..bc1d515fcca 100644
--- a/arch/arm/mach-mediatek/mt8512/init.c
+++ b/arch/arm/mach-mediatek/mt8512/init.c
@@ -35,14 +35,6 @@ phys_size_t  get_effective_memsize(void)
 	return gd->ram_size - 6 * SZ_1M;
 }
 
-int dram_init_banksize(void)
-{
-	gd->bd->bi_dram[0].start = gd->ram_base;
-	gd->bd->bi_dram[0].size = get_effective_memsize();
-
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	struct udevice *watchdog_dev = NULL;

-- 
2.43.0

