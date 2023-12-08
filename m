Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF87C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 05:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F00B786C83;
	Fri,  8 Dec 2023 06:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YvE3o4vo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D641987483; Fri,  8 Dec 2023 06:40:49 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4917286C83
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 06:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6cdea2f5918so1124480b3a.2
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 21:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702014045; x=1702618845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i94Vb7aQ78oSdljrWA4gwt5q0n0FTI08m1dkRq712a8=;
 b=YvE3o4vocsLNLgGzv+z+JMokMUox+ZToN7X+yoVN210ir1FMyyjDBZfSAYuWdfdHHG
 J7xe16EjIwgdx9FCGj5uNgSjQG3qYNcFw35IQ+fF2d4tWEgAYSZyMtQSRiQXyFM7C7t0
 Io2zLL0j1v4P2wfOOe+SOTcaBRzeiQ83VAmSqdwQg6EAE9xSOAp4Ys6rW/HnMmcFIyZF
 /UjrBwtqztkBPotv9kgEefMz8lofWsxWzoJhiGJ4Qcgh13L0F60/rnbo4s6swP+e7qoh
 t1xRx1eSGTbiN3vYPXyFqK5e43D3t6raMUE4jCALMz3LiPtAhtWNqqT/XD4rK3LbuEVL
 Ic0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702014045; x=1702618845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i94Vb7aQ78oSdljrWA4gwt5q0n0FTI08m1dkRq712a8=;
 b=NEaEk12qkBPweK44XjtVri/ocqnfYk13VERoYSuHPgQUSTK7FFEftsQ5WHd2qmW07b
 wWFjaowg/x6pOwY1L1Xyh9kSB4taDKpZq/Ap854TdANQswWjVN4BDEDUAzrZqo1FDzGg
 fj2vADrT24PGJ63BLXWxMz485Zmz39VpcfOpVyK9X6Zp9VsVodyHy4lQopYq3Sz7VQAN
 z0u6aJ06dmu8K6+ltKWaXyg22Cb38sTXfaoPd0AXBjiWhuIlJx5mjwTRx0HfBmjcTbxE
 NfmaKrlomUiAFuwJMCjb+N1tzy45WHOG77fIPrKe5bfCFBOXwi3VjMGin6EFd01ecthn
 Vu5w==
X-Gm-Message-State: AOJu0Yy0Dov2PzJKXH8EKfwUDHiHQARLKnhYzJ6jrO+XocdYj1SL/Odf
 kWpQJ70hX30GQHYLivSQgqGzX6ZEY9B57E2XU2o=
X-Google-Smtp-Source: AGHT+IGBTnLATiP4rO6blSjHaULYRcRBvTvcbZBEMJtgbRC+ceBe6dBqm6rVVUZUuflZEZLKwM0vGw==
X-Received: by 2002:a05:6a20:54a4:b0:190:4c21:b660 with SMTP id
 i36-20020a056a2054a400b001904c21b660mr65176pzk.24.1702014044755; 
 Thu, 07 Dec 2023 21:40:44 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 nc4-20020a17090b37c400b00285545ac9d2sm855406pjb.47.2023.12.07.21.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 21:40:44 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] efi_loader: fix iteration of FMP protocols
Date: Fri,  8 Dec 2023 14:39:14 +0900
Message-Id: <20231208053914.216413-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

If one of the FMP protocols fails when calling GetImageInfo(),
populating the ESRT ends up with failure and other FMP protocols
are not added to the ESRT. We should still add all other FMP
protocols to the ESRT.

With this commit, iteration of all FMP protocols continues
even though one of the FMP protocols fails.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
Note that this patch addresses the following issue.
https://source.denx.de/u-boot/custodians/u-boot-efi/-/issues/3

 lib/efi_loader/efi_esrt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_esrt.c b/lib/efi_loader/efi_esrt.c
index 7f46d651e6..e5670c4f5e 100644
--- a/lib/efi_loader/efi_esrt.c
+++ b/lib/efi_loader/efi_esrt.c
@@ -365,7 +365,7 @@ efi_status_t efi_esrt_populate(void)
 		if (ret != EFI_SUCCESS) {
 			EFI_PRINT("ESRT Unable to find FMP handle (%u)\n",
 				  idx);
-			goto out;
+			continue;
 		}
 		fmp = handler->protocol_interface;
 
@@ -381,14 +381,14 @@ efi_status_t efi_esrt_populate(void)
 			 */
 			EFI_PRINT("ESRT erroneous FMP implementation\n");
 			ret = EFI_INVALID_PARAMETER;
-			goto out;
+			continue;
 		}
 
 		ret = efi_allocate_pool(EFI_BOOT_SERVICES_DATA, info_size,
 					(void **)&img_info);
 		if (ret != EFI_SUCCESS) {
 			EFI_PRINT("ESRT failed to allocate memory for image info\n");
-			goto out;
+			continue;
 		}
 
 		/*
@@ -406,7 +406,7 @@ efi_status_t efi_esrt_populate(void)
 		if (ret != EFI_SUCCESS) {
 			EFI_PRINT("ESRT failed to obtain image info from FMP\n");
 			efi_free_pool(img_info);
-			goto out;
+			continue;
 		}
 
 		num_entries += desc_count;
@@ -437,7 +437,7 @@ efi_status_t efi_esrt_populate(void)
 		if (ret != EFI_SUCCESS) {
 			EFI_PRINT("ESRT unable to find FMP handle (%u)\n",
 				  idx);
-			break;
+			continue;
 		}
 		fmp = handler->protocol_interface;
 
-- 
2.34.1

