Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D7F1091915
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 20:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC34A8405A;
	Thu, 19 Mar 2026 21:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CKuxWOQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C8384006; Thu, 19 Mar 2026 21:02:30 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA4184088
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 21:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-67bb5e4cf7eso640956eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 13:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773950541; x=1774555341;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1NlR+cCwL/WZA9sOCSgSwS+K30cq3WOE5tkyF5OtrkQ=;
 b=CKuxWOQukSI9DKWkEvNxHFxqrVxtweQmMNGnAsKfAhm3UNK+Bo82ti2AHxlNxWIGBW
 73bfLf4N2rce4QxEUAGlOR0Zyv7cEcV2eexGJHTdMV/6WJciJT7yU/izfqadgg/aCtfH
 gcmvsqXr6Djra8CXFleDujjjMEpU+uRxQuzw94ZqAyzYgM2Hye/miu2FJG5QbrQt8V0p
 vNKwrVIpl4/4Vg4fFmXq4cfdRPF1xf8COSLoUuZDF5zC8I4u0KJlMkcyaVLEXTMeNVdI
 dseJvXRcu9QuOADeKYOd2zgET5xYcZm9BFkon3YDDnGp4YMUoP4+c4s15rnatqf2m54f
 idxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773950541; x=1774555341;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1NlR+cCwL/WZA9sOCSgSwS+K30cq3WOE5tkyF5OtrkQ=;
 b=FJqDknI25zKSnuw2/ZWDrETq1uli3MEjCcUmTDC4IfnKHYyHD64Mk+32/faSbg6ccD
 JoyaNypCGKcWcr1xEdT991TtuF1kBj+Rij7KKzdGRP98XfGuk1yFvN1riOKhixEbKcDs
 VsbnYZWH2eZybvj7ymXZkWv5IEI/CKH0wYvCIhuqY7OAU7u+gmfrYJYUi4jsVp7XUBQ5
 j0iPaVMjjixpetn0W7wsRuVdqwKfPlePx56e1uURB65VLHvfVhw1R8+yiaD0METddjTr
 D5e1wmSWzvGxguvLAV0lXA8I/zXcilMXkcEYVL6idEusIyaHzOMgMqNhrsbtmdkgGHdZ
 YtHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT/XXAYkTruD31VTKjRxamVBLfEAMCpz7eAb8H+2rqfNzx3KR52awpegORfiiqNFN06gI3zPs=@lists.denx.de
X-Gm-Message-State: AOJu0YxOusuThm2UxI5dzkQFCiVBZQNrLE3u5F/D/SK6fmagyPeiJkfM
 iCyzr8MQcE7IFNA/gosRz5oKikAzxuPYtgLX5O3k4fNLmDoAPMuIrjYJIOBbiUuUQ0E=
X-Gm-Gg: ATEYQzyKdBz/NmYwV/iYxdYHXtgLZ/xwjUDAPLioam0yobC5XwzfsR5l2zjHJPVG6YY
 z/GGEBMXNhFiI5vORPEMJfMuPfEjPUkqzm9QDswYqIoR+2ZF15eW3fqW9sLSrYK9rsfpResKCYO
 iZPWDqr2zFnYvL3Yp9AMxxICOJBbtSBVa8lR1XX8Hqaq07FbxNz211YfJVrHkFozmljJ+oKfdsE
 16mfS2oJRhFESgQJ3AaXBatUa+jMiD/KLKI6E8IK3ob39Ot3QRnBRqWNCn81IrFYekoElv354WY
 XAPKutPbXCc2nKmb6QeNsVzwWpyd20BdMniwpSKM/MYYAMMnyE8aDNQ9O6jG7A+NtOxZLW2CQbh
 +T5Jc8CvzSVp1SEmxNEEVthMXb+eSMbq30J3FB7ap4HrLddasSgOqUYQO2VcU9djdEdyUdNLAME
 UP/ZHY+4rr3oqO0kwnuIiqDtrZcfcWOCk9hi1ZO1I=
X-Received: by 2002:a05:6820:1f06:b0:67b:da68:955d with SMTP id
 006d021491bc7-67c22ff5bf9mr532930eaf.66.1773950540668; 
 Thu, 19 Mar 2026 13:02:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:244c:fc8c:8216:1344])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c252acd32sm2826eaf.3.2026.03.19.13.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 13:02:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 19 Mar 2026 15:00:15 -0500
Subject: [PATCH 12/17] arm: mediatek: mt8195: fix gd->ram_top limit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-mtk-init-fix-dram-v1-12-6171ec141f40@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2129; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=PFMy6+sMDobNF+3R33TkIp5uwaPgZJN1yyEC72jKDRs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpvFYVyqV3lCV6lw/0OdHC1dvgbBQxNCsIjyezw
 mc5p/egPSmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabxWFRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A2XYH/jztRHDojNOMQkU4imBEarDycZQwVbMUZdo8ZPR
 Vea4yUdW2Hs/hut/GSIVSFlxKMfEUMbONlrH8TqNucGYsQHVVmLVaI/TOTk2F2xrytj/bdX/yDV
 ddx4I5WHDY1xT1Qqsqf605sImuBG3EppstlPBYAnbybcYhTifSglhOJFPS7UAeZkOey2mKSLJmn
 Id56VlViJD1I155C0BOFhem6zQbAxEI/TzF3e/n6HuS5MYxJ3swjOnXKf4QgdujD6LBCDayFZkU
 xuoGHZYPixffX5CFzirCVMMZF6a5pup5HOIg8uXt0PMuPpN3v6jIO2GB/N5ZIGdC34du2n/OzwQ
 jrfQ=
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

Fix the implementation of the gd->ram_top limit for mt8195.

The intention of the comment about MMC/DMA is correct, but the
implementation was wrong. gd->mon_len is set to the code size of U-Boot,
so trying to set it to limit gd->ram_top does not make sense.

Instead, there is already a get_effective_memsize() weak function that
we can override to implement the required limit on the usable memory
size. This is used to set gd->ram_top in setup_dest_addr().

The comment about the extra SZ_1M needing to be reserved is not correct
as U-Boot already takes care of this (with the actual size of U-Boot) in
the various board_f functions, so it is removed.

This fixes DMA not working on MMC on mt8195.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8195/init.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mediatek/mt8195/init.c b/arch/arm/mach-mediatek/mt8195/init.c
index 6b47ca4b059..e31d4eec0fb 100644
--- a/arch/arm/mach-mediatek/mt8195/init.c
+++ b/arch/arm/mach-mediatek/mt8195/init.c
@@ -9,6 +9,7 @@
 #include <asm/armv8/mmu.h>
 #include <asm/system.h>
 #include <dm/uclass.h>
+#include <linux/kernel.h>
 #include <linux/sizes.h>
 #include <wdt.h>
 
@@ -16,23 +17,16 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
 {
-	int ret;
-
-	ret = fdtdec_setup_mem_size_base();
-	if (ret)
-		return ret;
+	return fdtdec_setup_mem_size_base();
+}
 
+phys_size_t get_effective_memsize(void)
+{
 	/*
-	 * Limit gd->ram_top not exceeding SZ_4G.  Some periphals like mmc
-	 * requires DMA buffer allocated below SZ_4G.
-	 *
-	 * Note: SZ_1M is for adjusting gd->relocaddr, the reserved memory for
-	 * u-boot itself.
+	 * Limit gd->ram_top not exceeding SZ_4G. Because some peripherals like
+	 * MMC requires DMA buffer allocated below SZ_4G.
 	 */
-	if (gd->ram_base + gd->ram_size >= SZ_4G)
-		gd->mon_len = (gd->ram_base + gd->ram_size + SZ_1M) - SZ_4G;
-
-	return 0;
+	return min(SZ_4G - gd->ram_base, gd->ram_size);
 }
 
 int mtk_soc_early_init(void)

-- 
2.43.0

