Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E2CD0D7BB
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 207E089388;
	Fri, 11 Oct 2024 17:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c28Cgh8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264D08937B; Fri, 11 Oct 2024 17:51:26 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 630F78939A
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53995380bb3so3036706e87.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728661872; x=1729266672;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uW8IdV05RANjzdKmGhDvEMhEwsA9h4fg235gPLYTrYA=;
 b=c28Cgh8/YjYSrYtoHQBgDBeSfqXZ8nN/YObolaG27B1Hms3sYqczlMEhpOHhxpN/bD
 y5tT7QGGlXmIMx099Kwgxb/C1RrgSmHZ6df/LjuM/q85LRoeqDaRYe4wJg0lnGDwM+CX
 gyDsvD52dckE+xbZYWU/IJMvkKBwBOsC5euVA7m0zp85+kRh4eeBQIRg5sJKK0CH0g8B
 zAWkXHGBCaP6aYQ58USuyOVlBPBiPzD6yUrsD1RyogyL8hhVeQF24Scog/g/ZyfRaFiY
 HqbRNREqcEiobFmJFeWuubWL3w2nGwrm9IuRp1Qk+fzVXVm2ft3nL5t5D+r+D7+1qaP8
 n0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728661872; x=1729266672;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uW8IdV05RANjzdKmGhDvEMhEwsA9h4fg235gPLYTrYA=;
 b=abVsxWdxFizTCJkSj3IfnLrYxnlaG6g5xiItl0T02zq4p4EgW0DbGNC7zdfAkGn3Vf
 NIISjHvYW04HMgakTVGQxAdvqMbLvGiypRZc/d3VO4Kg1A8MG4X59uN3beeB9eeXZ0Js
 MwD1gTW+o+QIy4VCCQ76zOHWLrqsBjYS5q5hncAjgHfTr8mJ9V28N0qsiTJoxxmaCWqM
 zaTkXaLjDiusyiVLWHUFviQbhc4XlxcZzFW7vVMdOh9ZdoGA+ySkvDGP5RxBZsEdSeEI
 mJ99yLIHDlYBmb4u8V2ojIyoVOlc95mBI7SpD0fSKVgaMrNu+4bSnHRcZrqGYV7R7qun
 Jr/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgZx7RgiTakFLe6GFhGl5xO1nRrtVSBnY0PboTciU/I2svYTQ3qExqr12EgPGCaletfl3l7PI=@lists.denx.de
X-Gm-Message-State: AOJu0YxzhBlFP7YlAJcHLAzYE1Xiw/+2nbEXwqWarJDj9Br+Ulis9LoR
 kx5Umj3Y2N3G1y33eAWpBiXkgyd4K2U5jtgFfX4evMBY1F2f1mIjb9slfh31O5s=
X-Google-Smtp-Source: AGHT+IHSPTkof1aGdCl/QXztBgg35wZz+4EB6/AbGyOxHxjwVuKBoF79QBlDvZ/oVeonq4Dyv5ZPPw==
X-Received: by 2002:ac2:4e16:0:b0:539:d10b:e389 with SMTP id
 2adb3069b0e04-539da3c6469mr2175158e87.13.1728661871686; 
 Fri, 11 Oct 2024 08:51:11 -0700 (PDT)
Received: from mkorpershoek-xps13.home
 ([2a01:cb19:8941:9800:3dae:610e:6435:d98e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182d794asm45769005e9.1.2024.10.11.08.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:51:11 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 11 Oct 2024 17:51:02 +0200
Subject: [PATCH 1/2] configs: khadas-vim3{l}: Increase boot/recovery
 partition size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-yukawa-aosp-parts-v1-1-7d74aa13ff8e@baylibre.com>
References: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
In-Reply-To: <20241011-yukawa-aosp-parts-v1-0-7d74aa13ff8e@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

The Android Common Kernel is over 34MiB now [1]. This does not
include any kernel modules nor the Android ramdisk.

To make sure we are future proof, increase both recovery
and boot partitions to 64 MiB.

[1] https://source.android.com/docs/core/architecture/kernel/gki-android15-6_6-release-builds
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/configs/khadas-vim3_android.h  | 8 ++++----
 include/configs/khadas-vim3l_android.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
index da6adf6c413a..b76e049f09cc 100644
--- a/include/configs/khadas-vim3_android.h
+++ b/include/configs/khadas-vim3_android.h
@@ -21,8 +21,8 @@
 	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
 	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
 	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
-	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
-	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
+	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
+	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
@@ -33,8 +33,8 @@
 	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
 	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
 	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
+	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \
diff --git a/include/configs/khadas-vim3l_android.h b/include/configs/khadas-vim3l_android.h
index b1768e2d8211..0ab8ffd372a4 100644
--- a/include/configs/khadas-vim3l_android.h
+++ b/include/configs/khadas-vim3l_android.h
@@ -21,8 +21,8 @@
 	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
 	"name=vbmeta_a,size=512K,uuid=${uuid_gpt_vbmeta_a};" \
 	"name=vbmeta_b,size=512K,uuid=${uuid_gpt_vbmeta_b};" \
-	"name=boot_a,size=32M,bootable,uuid=${uuid_gpt_boot_a};" \
-	"name=boot_b,size=32M,bootable,uuid=${uuid_gpt_boot_b};" \
+	"name=boot_a,size=64M,bootable,uuid=${uuid_gpt_boot_a};" \
+	"name=boot_b,size=64M,bootable,uuid=${uuid_gpt_boot_b};" \
 	"name=super,size=3072M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=11282M,uuid=${uuid_gpt_userdata};" \
 	"name=rootfs,size=-,uuid=" ROOT_UUID
@@ -33,8 +33,8 @@
 	"name=misc,size=512K,uuid=${uuid_gpt_misc};" \
 	"name=dtbo,size=8M,uuid=${uuid_gpt_dtbo};" \
 	"name=vbmeta,size=512K,uuid=${uuid_gpt_vbmeta};" \
-	"name=boot,size=32M,bootable,uuid=${uuid_gpt_boot};" \
-	"name=recovery,size=32M,uuid=${uuid_gpt_recovery};" \
+	"name=boot,size=64M,bootable,uuid=${uuid_gpt_boot};" \
+	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
 	"name=cache,size=256M,uuid=${uuid_gpt_cache};" \
 	"name=super,size=1792M,uuid=${uuid_gpt_super};" \
 	"name=userdata,size=12786M,uuid=${uuid_gpt_userdata};" \

-- 
2.46.2

