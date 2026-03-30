Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E279F1061B1E
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F24FF83E7A;
	Mon, 30 Mar 2026 22:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EK6IWlY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B16E84010; Mon, 30 Mar 2026 22:23:50 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA35783E7A
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d751ef36ccso2691340a34.0
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774902225; x=1775507025;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yfUPTNckqmGiFOlI+Yd0XG03DIsWZ3M+NREj0jbNjoQ=;
 b=EK6IWlY+/xjz9LsQt1bK9bkTCnmju4bkgUI2a7NYB9SOH7Yud75lm79atPM/UK0TlT
 UZYXUPX+hM7qGIQq9aZCRZKohViFr2s927RTpBOZf2mnhY36O2VMc/jrLhzdiQS9ZNjX
 jWdFDM957Io3agbxdInDSIhwnXZrcA6Xg1L4mtVKkqmiD/ZJQuK/gbegwMbdHk4m4Z8Q
 EDa08UQqmhiZPFE93eLaxxmlXoHLlKmKA3xfNEfQSBweqn4Q1scWGrZS0CKokvMSUK8t
 Nk0yF373bbduwnHjy2jbSyjUgWJ3uw8XS+CcQJ2VQ/ZwcWtlPHCYm1c2HgA6CtpoU7wZ
 ooAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774902225; x=1775507025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yfUPTNckqmGiFOlI+Yd0XG03DIsWZ3M+NREj0jbNjoQ=;
 b=iRKaHBTMT0GYnmQ2ryjbcft4eq+f5frD0XvMHGpzbvWsTDoXg5JhUhI6VdH8HXYKA3
 qr10NFemOPR85/vDLaw87fubPj6yj/eJJ4DSWma9H5g+pO5cNmejdp8LSj/E3mHDO4cz
 G3aFFpLUNxXvLs9cXZVBwog++w/taGAQHHxMMNl0WjvVITpd9My30tbRzDuHwb6VwZVQ
 mSzzpvxme5UwOKJYBhpmooN0X+TfPUZeQgQnrPXxbTmlaOYLMuzOQzBtFMYjNCDRC2ts
 aiMOOwbxrZruhj9gz+8BBGPGm2cc7XvADIC3bXauAY/hfEbeGnGPG9Y0peYm0lNBm4nI
 DCBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVepaaVfBKxrtDI6whpeHtYjj6ko1YG4a1oO2HR3mO5t4/E9/O7DoX2CvVUGabDPr3v5sdyOT8=@lists.denx.de
X-Gm-Message-State: AOJu0YwZkd3+7Tt1xfYXYiB99Y9tgjRx9lZd5XmDTjsZbpcPVTjVx+km
 DCr4/FFXKmzWUQ1azIXBqIne9mILu86HLYCR+J6TIIg7+PGVDt+Abo0vmkoWYnhPu4A=
X-Gm-Gg: ATEYQzw0feP9tkVZilNuPbpuI5tChZdH3Ii9YUSL+XROY+q+BhmiwfsQfvnM9Rhj/Ez
 TZXgkTZrheKkHEX8UxeSge0QweonRdyC4VjiOr+eYwpb5vxcb9iwaVLh1e+Qgbi9QSWtnwmeRud
 nWatcjqMrBJPHexiA7V0XHDzsbOYJlvHWSEOuJQPRCC+p8ivuX0xtVuh1zUS6DAMdeckVyj1rzU
 xbZSUQBDe9/m5wX+4CbFWljxhy00+vlWbLS9FZDpEDjhiRoAaVU9BsNAVMByXMTpTO44dcQUvkd
 TURLamlzdax9Q6PJ40UcR/X4vvU59D8Q+9zLrETc3cczrpk+9+xieX1UsfcOxFi1e7i7F67hLK1
 xWANEYnR1VZR9zAQrrVlLQq0JW2zYV3PSQBu7pXThHumchf/QdRyG09dbcnb+ob5Xq+prI/cTv3
 YRkADVoRHY0DCFGTuQCo8yQaHnMI46
X-Received: by 2002:a05:6820:62a:b0:67e:17fa:c7b3 with SMTP id
 006d021491bc7-67e1867a226mr7340385eaf.30.1774902225421; 
 Mon, 30 Mar 2026 13:23:45 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d048e1984sm5882608fac.4.2026.03.30.13.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:23:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 15:23:19 -0500
Subject: [PATCH 2/2] arm: mediatek: mt8189: print specific CPU information
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mtk-mt8189-cpu-type-v1-2-4059c3b52761@baylibre.com>
References: <20260330-mtk-mt8189-cpu-type-v1-0-4059c3b52761@baylibre.com>
In-Reply-To: <20260330-mtk-mt8189-cpu-type-v1-0-4059c3b52761@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=c2lQ+j7XSMIyRJp9Ld3yPMAFS5cYxTnpEH4W6CJn4pM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpytvI6IyZUfuxcg4WuVH1qRpRjYEdR6iNium0T
 Ic1rG3hiG6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrbyBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AkZMH/ipHp2mr0/kRG89l8/OoSCKUI7oHydemiMytmiX
 890pKitRwuby3C7TVM42uQFoXMHxM1AzlgvrJJJN0BHXhYxAvAix+OC6A6e2O8ZaNNImaDwTAY/
 RpBU8F3VGLguaKclWhxAKAAfMGn5CyM1BxhBY1jOW5/jTHMpn8zmyLap5P1A+GZ6/b3U8Xos7Hv
 9ALUeylCw9C7Zz4QAhXUEva0IVdrA0T2njZoPDUgW+pxjC1UQKtkthj9AnL0be5BaFXcClofw8a
 YitIidEke2AYUzFtzpgEDGvGDTrze9Idw1XcnSpQXl5UztSzLi0hCDBcnELZ3fm0mQu6HOC2y/d
 wPk8=
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

Modify the print_cpuinfo() function to print a more specific CPU name
when possible.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/mt8189/init.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mt8189/init.c b/arch/arm/mach-mediatek/mt8189/init.c
index 648c17ac305..ec7587c3586 100644
--- a/arch/arm/mach-mediatek/mt8189/init.c
+++ b/arch/arm/mach-mediatek/mt8189/init.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/sizes.h>
 
+#include "../cpu.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
@@ -33,9 +35,37 @@ void reset_cpu(ulong addr)
 		psci_system_reset();
 }
 
+static const char *mediatek_get_segment_name_string(void)
+{
+	u32 seg = mediatek_sip_segment_name();
+
+	switch (seg) {
+	case 0x80:
+		return "MT8391AV/AZA";
+	case 0x81:
+		return "MT8371AV/AZA";
+	case 0x82:
+		return "MT8371LV/AZA";
+	case 0x88:
+		return "MT8391IV/AZA";
+	case 0x89:
+		return "MT8371IV/AZA";
+	default:
+		return NULL;
+	}
+}
+
 int print_cpuinfo(void)
 {
-	printf("CPU:   MediaTek MT8189\n");
+	const char *seg_name = mediatek_get_segment_name_string();
+	u32 part = mediatek_sip_part_name();
+
+	if (seg_name)
+		printf("CPU:   MediaTek %s\n", seg_name);
+	else if (part)
+		printf("CPU:   MediaTek part MT%.4x\n", part);
+	else
+		printf("CPU:   MediaTek MT8189\n");
 
 	return 0;
 }

-- 
2.43.0

