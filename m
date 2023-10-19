Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3F4CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7224A8714F;
	Thu, 19 Oct 2023 15:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XDoH88qQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26BFD8715A; Thu, 19 Oct 2023 15:54:27 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEAD987125
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:54:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so4523873e87.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697723664; x=1698328464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MvDcZo6hzT2EoEoXpP9UfYe6J8Fs39SzYPUQIAVRxB0=;
 b=XDoH88qQUquwij45UNBLQCxOwsmt9eV36nAwnFiIlMRd2ZvHExq7itS3rS8ksU3fJb
 vYy77olSSNejps89txbQ/MMtxdnMAQjh8IMUn5+HajWLcVFatLaTlOy7szgKc9RQXQ1k
 JJ4QRIIAu6pWaienfNsQZR081bi2jfwFcfgNmIgwzjOfnkicPNXm1OR8CjMth+/GpQI2
 QgpwImp7zbATTkcnqV7DjBBWe+g2tB+RdDcpe4Etz0L22aruUVMqSdWLp4UHDCdcZ5QP
 B0ha9ko3q+TNRsKoaH9lJn+bYOCaxk8tdfLM3HD1cVwfWiv2IlY26Je8/aGEn4cl0Ivt
 0OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697723664; x=1698328464;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MvDcZo6hzT2EoEoXpP9UfYe6J8Fs39SzYPUQIAVRxB0=;
 b=QSAhRZFGARPvut16F35xFLeStDjUn1MHaO3+iKeCDgtrVQblwFIZN94bykQ7EWGERT
 DqiICJXAHdholCqNcNnjHBh58gr/SJDPBokALaERfgB89Bwn6CWttsV9vTFOUEWFktkG
 H2mR5LtLXEwoWWp318ncm5KWJp3K7cPK2ltJgCKm5IrvZhKrucBEA9mwGSmTSLOkTgx7
 5H9ubPESwXjkOkXR4YiwN+H9Lu4I/4FfV/HxkJAcsKhfi8K1kPob6k8lOkOfQqlaRm2n
 697gIdn1GvXlzatBYRJx3HXCp4DOilmiYBkLSWsmU869IOZFBzI0KVO+GohAQpcGsfW/
 suCg==
X-Gm-Message-State: AOJu0YyUR+P1DICcu9uGMHzdwG6B1gozzrI1UOAafThOkiq97x2M20vX
 Lw24iQSbUQUBXDT+YBiRwJfjIy6AnulyLNTs5NXeJQ==
X-Google-Smtp-Source: AGHT+IEjwO3+LIN9+/5CwnwGqcTnB1eeO1OwMEk3MmoUKrNwco8V0J3K+IWJYwC02WgnIbZE1i75/g==
X-Received: by 2002:ac2:5328:0:b0:500:b74b:e53 with SMTP id
 f8-20020ac25328000000b00500b74b0e53mr1550207lfh.46.1697723664078; 
 Thu, 19 Oct 2023 06:54:24 -0700 (PDT)
Received: from localhost.localdomain (ppp046103219117.access.hol.gr.
 [46.103.219.117]) by smtp.gmail.com with ESMTPSA id
 cy23-20020a0564021c9700b00522828d438csm4459981edb.7.2023.10.19.06.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:54:23 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de
Cc: masahisa.kojima@linaro.org, ryosuke.saito@linaro.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] board: synquacer: Update the flash image layout
Date: Thu, 19 Oct 2023 16:54:19 +0300
Message-Id: <20231019135419.162726-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The SynQuacer Developerbox, in EFI mode, supports A/B capsule
updates and single image ones. The flash layout in the latter case is
outdated, update it with the new offsets and images

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 board/socionext/developerbox/developerbox.c | 23 +--------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/board/socionext/developerbox/developerbox.c b/board/socionext/developerbox/developerbox.c
index 9585944d80c1..ac4415ff3bbb 100644
--- a/board/socionext/developerbox/developerbox.c
+++ b/board/socionext/developerbox/developerbox.c
@@ -20,39 +20,18 @@

 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 struct efi_fw_image fw_images[] = {
-#if CONFIG_IS_ENABLED(FWU_MULTI_BANK_UPDATE)
 	{
 		.image_type_id = DEVELOPERBOX_FIP_IMAGE_GUID,
 		.fw_name = u"DEVELOPERBOX-FIP",
 		.image_index = 1,
 	},
-#else
-	{
-		.image_type_id = DEVELOPERBOX_UBOOT_IMAGE_GUID,
-		.fw_name = u"DEVELOPERBOX-UBOOT",
-		.image_index = 1,
-	},
-	{
-		.image_type_id = DEVELOPERBOX_FIP_IMAGE_GUID,
-		.fw_name = u"DEVELOPERBOX-FIP",
-		.image_index = 2,
-	},
-	{
-		.image_type_id = DEVELOPERBOX_OPTEE_IMAGE_GUID,
-		.fw_name = u"DEVELOPERBOX-OPTEE",
-		.image_index = 3,
-	},
-#endif
 };

 struct efi_capsule_update_info update_info = {
-	.dfu_string = "mtd nor1=u-boot.bin raw 200000 100000;"
-			"fip.bin raw 180000 78000;"
-			"optee.bin raw 500000 100000",
+	.dfu_string = "mtd nor1=fip.bin raw 600000 400000",
 	.num_images = ARRAY_SIZE(fw_images),
 	.images = fw_images,
 };
-
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */

 static struct mm_region sc2a11_mem_map[] = {
--
2.40.1

