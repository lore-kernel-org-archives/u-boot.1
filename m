Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5C1EE6457
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 07:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E7188EB9;
	Thu, 12 Sep 2024 09:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aIPlQuS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A37B88EA2; Thu, 12 Sep 2024 09:30:19 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E22A588E95
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 09:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374b25263a3so430315f8f.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726126214; x=1726731014;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pztbBW6jhyQi1hDI6OAYOqgoDHcf5DnOA6jVADXjB6g=;
 b=aIPlQuS5Q2t+j3+tjLK40Qy1IiPTPwDCj2GnurZMspmQvvBU3qb2sNylFPgCSaX54F
 OMJFnjPfI6a3siR5VT+vUMvmjItj2E88HYhocEBRCLHHWxBdaTDtCtHf9tCtk9/5oepo
 nTbNG3Zvn3NKSPKcnSvXwFJWpRjz+4xHkusPv0A8u2hPh21SryXLFJz/zofLdIAxIjOT
 mKVNJ2yi7reQKwF8cwRhQ8ReKBcVaCp5QJzUJpxaN9yBy8QzHBr9SmQW7YoHANKU/gV5
 cC4xU+5cvtJRBLJfa1SRGq3aH3k5MoabnhlG03TjR3DAdkuAge5zcNY7KTLdCyJjy4oS
 HDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126214; x=1726731014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pztbBW6jhyQi1hDI6OAYOqgoDHcf5DnOA6jVADXjB6g=;
 b=Cqd5jBFjeRVZ5VPXWG4ZIE4gxq4PcM9OzK3N4yOOsUy94LL/mZX/W/SWviT/jT1Yje
 p73h48IFdmrpEPZWWfDdtOdz+0L0TDEP6pXE5ORkKwYMSE8AmgcMDBssG0rMQK/b3xOq
 m8z/Ql4qwwYyO9vQJIjXWZQA9MnMsnhAEVE4j1j4Z0fE6peEXhEavA4Bxb+J8dKqprP8
 PFZwSY4rtRTMzlLPZHdHvCNgDOOB93y4MieK07Fs8svlp4R/oxTNYKR6bx1Ay8A/EA/c
 3n/2TbXA8IaEpO2Z2qiISw+02GXf66Owz1xdXnsHZ8iOuwd026enVyLKBeq4jrEqsvz7
 2+Kg==
X-Gm-Message-State: AOJu0YzPX/i3q9ysyKkynyoP7lK8+hUVQpmi2auA+CnIi9luhQl+Msof
 jmtLwC36p3SS+ARpoJap8I7+7+Q2GqzKgXv02BclT2PIpvZoqAChh0UValRiUw4=
X-Google-Smtp-Source: AGHT+IHS7r2HpNsl02ceru3vU99b0Ca/KRnkfF78lWSQFuGS6X3lee/mjXOe1m9GA8acsr8Cog3GMw==
X-Received: by 2002:a5d:6450:0:b0:374:c3f7:6af1 with SMTP id
 ffacd0b85a97d-378c2cf3663mr949322f8f.15.1726126213712; 
 Thu, 12 Sep 2024 00:30:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:ce21:4d2b:8554:e76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb21a5csm164330065e9.6.2024.09.12.00.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:30:13 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 12 Sep 2024 09:29:58 +0200
Subject: [PATCH v2 2/3] board: beagle: beagleplay: Add android bootflow support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sitaraupstream-v2-2-2101323d3fa5@baylibre.com>
References: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
In-Reply-To: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
To: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Nishanth Menon <nm@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
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

From: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Beagle Play has a different boot flow than the AM62x SK EVM.

AM62x SK EVM:
1. Boot rom reads UDA (User Data Area), looking for tiboot3
2. Boot rom finds tiboot3 and loads it

Beagle Play:
1. Boot rom looks for tiboot3 in mmc0boot0
2. Boot rom finds tiboot3 and loads it

Because of this difference, we need to have a different
partitioning table than the generic TI one.

Include generic TI android support and override the partitioning table
to boot Android.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 board/beagle/beagleplay/beagleplay.env | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
index 354bc987d12b..fc29d49712db 100644
--- a/board/beagle/beagleplay/beagleplay.env
+++ b/board/beagle/beagleplay/beagleplay.env
@@ -17,3 +17,33 @@ bootdir=/boot
 boot_targets=mmc1 mmc0
 bootmeths=script extlinux efi pxe
 rd_spec=-
+
+#if CONFIG_BOOTMETH_ANDROID
+#include <env/ti/android.env>
+/* Override Android partitions
+ * Required because tiboot3 is in mmc0boot0, not in UDA
+ * note that += is needed because \n is converted by space in .env files */
+partitions=
+       name=bootloader,start=5M,size=8M,uuid=${uuid_gpt_bootloader};
+partitions+=name=misc,start=13824K,size=512K,uuid=${uuid_gpt_misc};
+partitions+=name=frp,size=512K,uuid=${uuid_gpt_frp};
+partitions+=name=boot_a,size=40M,uuid=${uuid_gpt_boot_a};
+partitions+=name=boot_b,size=40M,uuid=${uuid_gpt_boot_b};
+partitions+=name=vendor_boot_a,size=32M,uuid=${uuid_gpt_vendor_boot_a};
+partitions+=name=vendor_boot_b,size=32M,uuid=${uuid_gpt_vendor_boot_b};
+partitions+=name=init_boot_a,size=8M,uuid=${uuid_gpt_init_boot_a};
+partitions+=name=init_boot_b,size=8M,uuid=${uuid_gpt_init_boot_b};
+partitions+=name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};
+partitions+=name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};
+partitions+=name=vbmeta_a,size=64K,uuid=${uuid_gpt_vbmeta_a};
+partitions+=name=vbmeta_b,size=64K,uuid=${uuid_gpt_vbmeta_b};
+partitions+=name=vbmeta_vendor_dlkm_a,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_a};
+partitions+=name=vbmeta_vendor_dlkm_b,size=64K,uuid=${uuid_gpt_vbmeta_vendor_dlkm_b};
+partitions+=name=super,size=4608M,uuid=${uuid_gpt_super};
+partitions+=name=metadata,size=64M,uuid=${uuid_gpt_metadata};
+partitions+=name=persist,size=32M,uuid=${uuid_gpt_persist};
+partitions+=name=userdata,size=-,uuid=${uuid_gpt_userdata}
+fastboot_raw_partition_tiboot3="0x0 0x800 mmcpart 1"
+
+adtb_idx=2
+#endif

-- 
2.34.1

