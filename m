Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E1AC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59EA283123;
	Tue,  8 Jul 2025 13:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="B9wonGDR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D65083242; Tue,  8 Jul 2025 13:37:43 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 368EC830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 073FA3F27F
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751974660;
 bh=aYL08g+5X1s8G4bu9C+A14GfRdCDZHbqjfJbf5jzyo4=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=B9wonGDRQD33FtutyZkSuch4LhDGNjK4qIo1u+r6AQhlTZ/h3A+50ctWkUrNRM9nZ
 rNm9eV7VPH28UPfJ/NZNJRkQLPP59BbA83tf6ZMq0j6ThGyq7FPoatiUcifF7hdMdq
 Vnsu/w9m9VkCI9LeSVFXeCyy4aPZKGbe85kPcphYoVo2+rBgZO5NMBDhEjssIlkTJX
 9nVutoyNhkGR4nhlDO3Si78f0TQZ4g40vI7bB03Yzn1Yr8ljAlcoyZy4X4ISiYrG0x
 UK+UsHGDR3HVNi67AOWBA1a8oQSzEta9qkUfxwj5WulBhD3weuujZ/TSIfacPvfxDW
 ixxU1cJn8+7Tg==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ae0a3511145so280575566b.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751974659; x=1752579459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aYL08g+5X1s8G4bu9C+A14GfRdCDZHbqjfJbf5jzyo4=;
 b=kpKHbz7pUTYVI22G/XYY/UCbVwrkHQjZoA+2jU6NJ/JsGx/trQK+h11qk9CneI9L0t
 Bp1QkwQKbAXBVK/rhTMLgHefABumYUpDi6a2gPZivkFBpGyY8cOuq8OJZ4jAy7oDqnO3
 amkwAdpTApVRbKZMMtNYoRPsrmELvMyZ2WUtSKyfQdLC4hSc609yWS00jsHg476vktMx
 OXHGv08Gd3zpO53CVt16pkwN4emlTqVj8ybN9dNQ65xC30GtISYMiTP6Rc4QCdd0H/tM
 uzSBLbsIgFIyfReJwzzeYjDlP+yjm4QqYcN2wqfGF9Oqec/ncngWuFw/35cPN0qbKysP
 GEWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoJrRhtL7y5+Ip2nzZt3tv/3bHIVupBMBOiSnI6A+qf2umkexHnZ5bJqR6ALgyZWVgTbwLf1Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzkMRWn8pnrIQazY90OnNrquzjjqS23nMyyBs7aD8QkSlk+4von
 /gVRR1DGww1/IADp8r8iNtJo5mq1g6mPB44znBdaEKD67Bbg0/zm1doeK4jPfcuDJkG5KQQadWF
 9aJFCb8O54XvmECcMQnIAgRaXruzfZ+ghMZ/rDxRXjw2XdWYsFSm79lITQhQBB4aer9AvJSI=
X-Gm-Gg: ASbGncsdu9o007QkR2r09xSIcCuMpICSs0pveYShIAANNBZXbNJibjoCd0i7bG4JPU7
 BnhamQwbjNSXig64EPEng0OPkxANrWiSREt/G3Oa3sX/FKz/dGifJRSHyI7KE9QrMbjqS6r6r+9
 WdZ2Hoqoj+lzEKuYKwfXgsKqcm7PATJEsjprMHX2QzrbGrUgsnxOB6w+5HX3G0IUZ2ytfJcFIVu
 O9t/+vwuiqEP9rJNuxbAm7aedH6YeLE/zZa0hpv7kWnhl7WDGrtnvi/AXCDhs68V+wU/Tyy04j0
 Ibt8EXJzircAoG8OBb5r8s6viMhb8DGlTyGCLPiwdPSPmNo4Rreztp4vEd2zNsHRGde1xBRwDVF
 nvaHoMjBP/PWiWuZhpogUd+FI
X-Received: by 2002:a17:906:f5a7:b0:add:ede0:b9c4 with SMTP id
 a640c23a62f3a-ae6b06d9230mr283464466b.42.1751974658800; 
 Tue, 08 Jul 2025 04:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUB5IMLR1NtO/tIhAazAoBT6YGzBQ2c8GA0xKJyGLH3UhkaOv3E9901/esvR9rGgY9KBPbrQ==
X-Received: by 2002:a17:906:f5a7:b0:add:ede0:b9c4 with SMTP id
 a640c23a62f3a-ae6b06d9230mr283461766b.42.1751974658372; 
 Tue, 08 Jul 2025 04:37:38 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6b02788sm878883066b.113.2025.07.08.04.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:37:37 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jose Marinho <jose.marinho@arm.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_selftest: fix ESRT creation tests
Date: Tue,  8 Jul 2025 13:37:32 +0200
Message-ID: <20250708113732.74017-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

The code foresees that parameters descriptor_size and descriptor_count
might be NULL and then dereferences them without further check.

The size check must take into account the descriptor count.

ImageInfo might be NULL. In this case we must not dereference it.

Fixes: 4ac6041c3cbf ("efi: ESRT creation tests")
Addresses-Coverity-ID: CID 569497: Null pointer dereferences (FORWARD_NULL)
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_selftest/efi_selftest_esrt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/efi_selftest/efi_selftest_esrt.c b/lib/efi_selftest/efi_selftest_esrt.c
index b7688deb496..7eadac90fbc 100644
--- a/lib/efi_selftest/efi_selftest_esrt.c
+++ b/lib/efi_selftest/efi_selftest_esrt.c
@@ -69,10 +69,12 @@ EFIAPI efi_test_fmp_get_image_info(struct efi_firmware_management_protocol *this
 	if (package_version_name)
 		*package_version_name = NULL;
 
-	if (*image_info_size < sizeof(*image_info)) {
-		*image_info_size = *descriptor_size * *descriptor_count;
+	if (*image_info_size < sizeof(*image_info) * TEST_ESRT_NUM_ENTRIES) {
+		*image_info_size = sizeof(*image_info) * TEST_ESRT_NUM_ENTRIES;
 		return EFI_BUFFER_TOO_SMALL;
 	}
+	if (!image_info)
+		return EFI_INVALID_PARAMETER;
 
 	for (int idx = 0; idx < TEST_ESRT_NUM_ENTRIES; idx++)
 		image_info[idx] = static_img_info[idx];
-- 
2.48.1

