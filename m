Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB406CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 16:31:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7252788C50;
	Mon,  2 Sep 2024 18:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NWccar4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0EC888860; Mon,  2 Sep 2024 18:31:28 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56A488C50
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 18:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42c2e50ec13so20605575e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725294683; x=1725899483;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cC1hNtijWJaYPRuR8NyE71yasvS/p+S3tcruCs/845k=;
 b=NWccar4Kszru52HZvxuicYSijowryh8/QB1MgdithJUpPyN5Ie4AJ8fBW9xUf/PsLi
 0G2XQj/8VeK6/NDYWoUrbDsM6LcDlIiuFBjz+8DP40tfl89F/tkZ4Yu2J+15CAGix870
 siHitCAMFT9qFlbKE5Eg6MWJzMDDO08EyeoKwwc+2OG/TKlzwkDqjNyQ3td0IGE901jm
 YjjoTXhhb8bCFclwy4mPD5VmVVs8TzFcfp2qdeR2+2ClYQlbt9LgWx1lnU3w1b/PCcls
 Oe39U2YUJuZCg6fNRCLoMECOlCrX0KdVuaTAUipLj5XxTIP/904+3Smj0Epx0kQerQn6
 kpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725294683; x=1725899483;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cC1hNtijWJaYPRuR8NyE71yasvS/p+S3tcruCs/845k=;
 b=bwbJeP/uRbka5ik+OyMdQKH6NTOTm5iEg6LqEFeCV3ayyXQPjiZ0UrdzMxERKdjuhr
 HoocO0eU1CAkO1BneQpp0skSP2FixcY5qg+CXV0QYGPM/wkakLkznRDmfq5NirOLDPFp
 NSEKTWRFAFbNYdDW866/vOLcYzvfIZk6G+sMDrDvbSsuJvQGiPfrFYPLXaA3yYT4hzGs
 hKIQdraMkZaI1scEtdVx3ek5Ua8HvxqucWk/62zmvJNeUaymVXexCPBcLjgYOg5mCViV
 p5NYKZ63rEDxKFLONmbS68H8XG19hzItVQEhwtFHjVmdGI0HOB3uGkNs00fWU2ADVOi9
 cIGw==
X-Gm-Message-State: AOJu0YzjDEO/EDK6EMw21gXIevGm16ScwdazQfrYBkikJdh+3Cd8gj2N
 9zLNcK9feJYxWGAH4MFP7V3vh98F25748mGnKj2WHGuo5B0mjrFQvVh5Rmlj9dA=
X-Google-Smtp-Source: AGHT+IHbCEnNgV4HDMeQMN2Wvz3HMIUZhHbFGYX2LytsSPvE+Jfo55XETY9bjKuPEvJcX4AyU/DcAw==
X-Received: by 2002:a05:600c:1d1d:b0:426:5269:1a50 with SMTP id
 5b1f17b1804b1-42bbb205a6bmr77599995e9.11.1725294683198; 
 Mon, 02 Sep 2024 09:31:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:36ea:3dbe:c83a:7e39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e274ccsm145122185e9.37.2024.09.02.09.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 09:31:22 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Mon, 02 Sep 2024 18:31:20 +0200
Subject: [PATCH 2/3] board: beagle: beagleplay: Add android bootflow
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-sitaraupstream-v1-2-0c478c33c08b@baylibre.com>
References: <20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com>
In-Reply-To: <20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com>
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

