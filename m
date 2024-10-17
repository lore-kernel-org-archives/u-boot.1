Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD07D374BF
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 16:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D50C89065;
	Thu, 17 Oct 2024 18:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wez2e70V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE048907E; Thu, 17 Oct 2024 18:10:54 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD6489059
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:10:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d4c1b1455so901160f8f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181447; x=1729786247;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eek7gRBW6g+Iapx/5zEf6sS/TBDPdHF5a1htgBIWQQg=;
 b=Wez2e70VFF9vib70OZksvdZNsXyjEtWraEfx6kusTDD8/xfvhYGIO+nwVpKcrdjsgD
 gGycNZ00cVe82FzemYBz9rbQsJlvw1pIch4dXNLzsJUg7TC75zjSFrFfB3LaSmJWxKnv
 OH1hmPiO/+Ughdu8yHovD/Zjy+bHr3uuiLtRbpSbzhfJ1vxX/pIYB8P3qR72ofXZsQPF
 l7bWrz7cvi2CU0XYQCcAEm7YP8pRCtSPu5dYP/oKyzl1fOZT+m35HncZEZaAexIPbuPF
 MBAp8oaMd7CIjTCqMJjuKOVf6Jee5D+mneifvWMRVLjBrisszOVa835AayExrTxspLKi
 Em2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729181447; x=1729786247;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eek7gRBW6g+Iapx/5zEf6sS/TBDPdHF5a1htgBIWQQg=;
 b=cfJ8tHXxPNfhpCCJh0u60A/GEDeia7MRub49PYgoF1If9sg3SQHbRmu74gcgeontTB
 WZziMhwD3DhYHYzfzMev+UUx/z2nq/tPLRD7ZhbvNxRyALgFwH5Xqz5lGO2hJpYh+FIl
 w71iD/tLowEvEmmxdXLzcjb126mDr71BHW0V0LeUAb0CGMhN6M8qgdcSas2YFbHrJo1A
 MSNKDQw+ST8IC5m/sKJYQOldQSloFM1xhsVaLXS6H3cjOIFXGnntLzf+JVAfZa2l8dLJ
 O3ViGTAgb+bPGvYkA+vhP+S7BX8lnEBp1ycJkUjlgDkQArb0e6rS1e9NjN6mdp7u80Z9
 e4dA==
X-Gm-Message-State: AOJu0YxV1Ni6+YOHMQSmXGYDGzDvX3g+ymS6WQNb1mGmq4rQgTuKFJYI
 oafR23Id9iYcP8ruSFpW7jG8fb348j9qPnEgZ9WMu0jWR35EzQCq2SHyO/t+o/aLIGaqlXSLXxh
 y
X-Google-Smtp-Source: AGHT+IHLxEIBMQzPy2d9LZ5WMJTJFVui5jEuVkjRgsMH4DB4Qlx0CqgWUHdQwrTv7wwYrhLDqW8ARQ==
X-Received: by 2002:adf:e908:0:b0:37d:33a3:de1c with SMTP id
 ffacd0b85a97d-37d55262ad2mr15901805f8f.38.1729181447313; 
 Thu, 17 Oct 2024 09:10:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:10:46 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 17 Oct 2024 18:10:27 +0200
Subject: [PATCH 3/6] configs: khadas-vim3{l}: fix userdata size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-adnroidv2-v1-3-781c939902c9@baylibre.com>
References: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
In-Reply-To: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
X-Mailer: b4 0.14.1
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

After increase boot and recovery partition userdata was not resize.
so on VIM3 16GB and VIM3L `fastboot oem format` or `gpt write mmc 2
$partitions` fail because end of last partition is outside of eMMC
size.

Remove 64MB on userdata partitions to fix it.

Fixes: ce138d9742bf ("configs: khadas-vim3{l}: Increase boot/recovery
partition size")
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 include/configs/khadas-vim3_android.h  | 4 ++--
 include/configs/khadas-vim3l_android.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index fc89efb4c36e..0e2953fe71b3 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -24,7 +24,7 @@
 	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
 	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
+	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #else
 #define PARTS_DEFAULT \
@@ -37,7 +37,7 @@
 	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
+	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #endif
 
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index 5b2aed1cf62a..f39a3782d663 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -24,7 +24,7 @@
 	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
 	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
+	"name=userdata,size=11218M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #else
 #define PARTS_DEFAULT \
@@ -37,7 +37,7 @@
 	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
-	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
+	"name=userdata,size=12722M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
 #endif
 

-- 
2.34.1

