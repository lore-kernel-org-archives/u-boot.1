Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1487C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 09:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3390876A4;
	Mon, 18 Dec 2023 10:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gpqQiJDO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCCC887DEB; Mon, 18 Dec 2023 10:59:29 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419EB8768A
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 10:59:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d3c21a95e6so1489035ad.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 01:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702893565; x=1703498365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J0sHLCFvY6nXJCDnIu62Y8MNMhmglBgoMaH3IwSTlFM=;
 b=gpqQiJDObs62EjfkcyPHo8s9g86FjTa205hCmMGBijUtv3OuzhG16oIVlVadxcLqX5
 Xhty2vHwk+rS+yXnguo/plGMlkQlE4q3eJTp9QJqGP01eWpbClK1pRlusE2A+AS4Tk0B
 XheKrY56DS8fahYOFqdcNvG7oxwiC2R+5xNT+DrNmOl9wn0O9Bx0wS5ove/b31yC6dDv
 nuMx0kZMQrAIMxynyGj5bHGzQvK2hCRYz6iYLVxA/XaIQ/2P6mqinO499ItJJzXiQP2U
 2XBf/AIf7SwjkW74K5gUD9BlKCdNfN0NMIPyOhsY8ZM3MQfYzlpq7yJGoGvjqt69e1dh
 pH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702893565; x=1703498365;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J0sHLCFvY6nXJCDnIu62Y8MNMhmglBgoMaH3IwSTlFM=;
 b=RvqrUCi7TyBgqzJXeFjE9Sr8czkasqM0xVxH9WdjQpWtPBXd+DKfFN+Sb9mbDCGUM2
 VawLeCmiLVrrlUNCgA8KntTiGFrfIwL58Mso1lSDvwSV0ll89rMyOIhsZE43fm0bZi7Z
 QC8PM+Gk/CBWt8Tg1dI487349wphWYcRlCLqY1lzMgciPxNEzUYXB4vlZM+CeE41fPRw
 SmytH6/qcT0akpaKoNFkcJTfbAPb/wjDJAocgZnLisGGVk7xD6lO2ZrjJJlWSS/+/Key
 vhe5Uwj2U6NiqNYt2L7OzntDNIsB7S0t3SExj8yP8ksAy8uZV/cdKHQUqeU+uQM7+RIw
 7fDQ==
X-Gm-Message-State: AOJu0Yw0TChH61i7YbzHRJjCBK+iM+iUQREToZpplcXxUtmAL1sBdo6A
 o4TZNlFHu/pN6ONMtQJoHN8aUonUZwYxLSDgFQs=
X-Google-Smtp-Source: AGHT+IEkZ6iOYdObOL//ObOmofHy3rXmTHwH25ST5+2bKQFYsQWCqY2SKwo4UjonUU+Wqd8ZHttleg==
X-Received: by 2002:a17:903:2311:b0:1d3:6400:5532 with SMTP id
 d17-20020a170903231100b001d364005532mr4484181plh.96.1702893564808; 
 Mon, 18 Dec 2023 01:59:24 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 q14-20020a170902dace00b001d08e08003esm18664915plx.174.2023.12.18.01.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 01:59:24 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2] efi_loader: fix iteration of FMP protocols
Date: Mon, 18 Dec 2023 18:57:41 +0900
Message-Id: <20231218095742.376839-1-masahisa.kojima@linaro.org>
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

changes in v2
- add error handling when num_entries is 0 after calling fmp->get_image_info()

 lib/efi_loader/efi_esrt.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_esrt.c b/lib/efi_loader/efi_esrt.c
index 7f46d651e6..1f629a6023 100644
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
 
@@ -380,15 +380,14 @@ efi_status_t efi_esrt_populate(void)
 			 * fmp->get_image_info to return BUFFER_TO_SMALL.
 			 */
 			EFI_PRINT("ESRT erroneous FMP implementation\n");
-			ret = EFI_INVALID_PARAMETER;
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
@@ -406,7 +405,7 @@ efi_status_t efi_esrt_populate(void)
 		if (ret != EFI_SUCCESS) {
 			EFI_PRINT("ESRT failed to obtain image info from FMP\n");
 			efi_free_pool(img_info);
-			goto out;
+			continue;
 		}
 
 		num_entries += desc_count;
@@ -414,6 +413,13 @@ efi_status_t efi_esrt_populate(void)
 		efi_free_pool(img_info);
 	}
 
+	/* error occurs in fmp->get_image_info() if num_entries is 0 here */
+	if (!num_entries) {
+		EFI_PRINT("Error occurs, num_entries should not be 0\n");
+		ret = EFI_INVALID_PARAMETER;
+		goto out;
+	}
+
 	EFI_PRINT("ESRT create table with %u entries\n", num_entries);
 	/*
 	 * Allocate an ESRT with the sufficient number of entries to accommodate
@@ -437,7 +443,7 @@ efi_status_t efi_esrt_populate(void)
 		if (ret != EFI_SUCCESS) {
 			EFI_PRINT("ESRT unable to find FMP handle (%u)\n",
 				  idx);
-			break;
+			continue;
 		}
 		fmp = handler->protocol_interface;
 
-- 
2.34.1

