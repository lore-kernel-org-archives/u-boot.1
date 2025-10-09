Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FFCCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 13:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67055844A9;
	Thu,  9 Oct 2025 15:18:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tgHS/nSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F09B84509; Thu,  9 Oct 2025 15:18:19 +0200 (CEST)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4278C84461
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 15:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-5c7fda918feso1145179137.0
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760015896; x=1760620696; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t0meANmABfpOyAjp5EPSfynnjLxzjF1QODoPdexKXtc=;
 b=tgHS/nSQdiSNoMsjNFgaIEI7aoek3Gvx0aatpFPFmDEhr/erGV7jvjmKCVxBpPtYcG
 AzeJaVVUL2/i1UJi0GtbTsceM7gZosSTS+GkxJAH2tDkBim00nPDAnVKegSjiVsI7AGT
 IzC6jLimsKezjPIJbcqZlzSOpnJ4AiJIN45mvRAohlT508V2idIzaPY27H+KECH6yuwy
 YXZC0+iakE+kpDrZEc8r3cVWTE6kM4Nbl4OD3hyG6JSw7JOH+GBrsiLNMA09FVFHExjo
 FWOYT+NralTd3c4SKn0IgBWXcSOHpsiIUjstKE7oGXdYh5QHUa8JUCzbAcYhBIDRJBHn
 IpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760015896; x=1760620696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0meANmABfpOyAjp5EPSfynnjLxzjF1QODoPdexKXtc=;
 b=iXo/Ik6URu9Ixu24JzXQlMXehh/PWLyAp5Bp7P/d7LViEwcCmXt6QI5V24jBpvhVVD
 pKV2C+ZPForNpggJxM38lHvz8nh4gc/4nUMNpByZDQXy6uqTwSqJ0O0VAcfHItCIUBAn
 0d0nlDVfLWfmPes186WVOvTOBr9c/NECcXbmVMDWubUa+EInEY/CvCB1x8n86xIGGapx
 FQcy7loNK1xL3uxkQFwRPnleWd3v+zsNOv6zgrIpI/VetVKjYuje7Wo3ZDfBtzzsJqg7
 ya9Pkp2AggIjEopbibiscYabTF0UKY4ZRmuUGWcYSBlvZVWWo040RmJAg06H7ymdNVR2
 EqPA==
X-Gm-Message-State: AOJu0Yx40gaIy8c+fGxVAHavvKAHJrQHyL5XYm+NK3aKPwxtp9AACWu0
 aCoCkpBsT5fTA4wPInKHEavnuov8NUihyrMa6P98sw6G50rNbWyVk7y0H9+CuFOTMpv16hco5SJ
 VflSQ
X-Gm-Gg: ASbGnctjy5J+NnHprrL+phsAFv9bk0I+x6oMK+GStno8yTPptbzm1MWP2pWb850sEzB
 qdl7F6ntXl2sipCzmU0GSnOYl5Koj92yflBkTsb8Qden2wAzvzD1eW3MnYlwVRXKpfuh9XSlpdv
 R2bEAlyHGKpZ0rxRowf0MRse8lGKuMk29kcL4gwdRSoey+vpybi43OdhiH2VaBnX2pJmalg5Bfs
 rs1G3pLhuTiyv45xUr/kryvBGX2aK3JtxCEhjdRGyfW1MoN7Sw6eyG/uPSkTjLRCXGJl2nKnm2u
 fWuvJUKQGdvBCP5aDzAJGnS3LPVnSJBw8HAgKxVOsLuCCuScMftxpEE+jXO2svR7/50UNiDv6iv
 yapbbVRIOD6jLExlksJQM4cokjpZLtEjZnvSzNOYsIqgnsNknJ21otAFHY72roJ7v1tNeiNH4Hg
 DYxjcu6+qJdKZIOdynFiA=
X-Google-Smtp-Source: AGHT+IFVVJHeGjPJLkqkg2u4yspJqk74Uys3OCQ6zH/PbRyIpagK/3WRAUFJIbHe0FtUmNWNNuulmg==
X-Received: by 2002:a05:6102:3311:b0:5d5:f6ae:38f3 with SMTP id
 ada2fe7eead31-5d5f6ae3ebcmr595646137.42.1760015896057; 
 Thu, 09 Oct 2025 06:18:16 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e.local ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5d5d3835333sm2400604137.3.2025.10.09.06.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 06:18:15 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
Date: Thu, 09 Oct 2025 07:17:46 -0600
Subject: [PATCH v8 1/2] part: Export part_driver_lookup_type for external use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-detect_disk_image_type-v8-1-a8b50a3b4acf@linaro.org>
References: <20251009-detect_disk_image_type-v8-0-a8b50a3b4acf@linaro.org>
In-Reply-To: <20251009-detect_disk_image_type-v8-0-a8b50a3b4acf@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>
X-Mailer: b4 0.14.3
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

Make part_driver_lookup_type non-static so it can be used outside
part.c. This allows external callers to determine the appropriate
partition driver for a block device, enabling more flexible handling of
partition types.

Add a prototype and kernel-doc comment in part.h to document the
function contract. Provide a stub inline implementation returning NULL
when partition support is disabled, ensuring build consistency across
configurations.

Signed-off-by: Javier Tia <javier.tia@linaro.org>
---
 disk/part.c    | 18 +-----------------
 include/part.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 66e2b3a7219..be2b45d5a29 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -47,23 +47,7 @@ static struct part_driver *part_driver_get_type(int part_type)
 	return NULL;
 }
 
-/**
- * part_driver_lookup_type() - Look up the partition driver for a blk device
- *
- * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each parition driver
- * against the blk device to see if there is a valid partition table acceptable
- * to that driver.
- *
- * If @desc->part_type is already set, it just returns the driver for that
- * type, without testing if the driver can find a valid partition on the
- * descriptor.
- *
- * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN on entry
- *
- * @dev_desc: Device descriptor
- * Return: Driver found, or NULL if none
- */
-static struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
+struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
 {
 	struct part_driver *drv =
 		ll_entry_start(struct part_driver, part_driver);
diff --git a/include/part.h b/include/part.h
index b772fb34c8a..6caaa6526aa 100644
--- a/include/part.h
+++ b/include/part.h
@@ -727,6 +727,24 @@ int part_get_type_by_name(const char *name);
  */
 int part_get_bootable(struct blk_desc *desc);
 
+/**
+ * part_driver_lookup_type() - Look up the partition driver for a blk device
+ *
+ * If @desc->part_type is PART_TYPE_UNKNOWN, this checks each partition driver
+ * against the blk device to see if there is a valid partition table acceptable
+ * to that driver.
+ *
+ * If @desc->part_type is already set, it just returns the driver for that
+ * type, without testing if the driver can find a valid partition on the
+ * descriptor.
+ *
+ * On success it updates @desc->part_type if set to PART_TYPE_UNKNOWN on entry
+ *
+ * @desc: Device descriptor
+ * Return: Driver found, or NULL if none
+ */
+struct part_driver *part_driver_lookup_type(struct blk_desc *desc);
+
 #else
 static inline int part_driver_get_count(void)
 { return 0; }
@@ -737,6 +755,9 @@ static inline struct part_driver *part_driver_get_first(void)
 static inline bool part_get_bootable(struct blk_desc *desc)
 { return false; }
 
+static inline struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
+{ return NULL; }
+
 #endif /* CONFIG_PARTITIONS */
 
 #endif /* _PART_H */

-- 
2.51.0

