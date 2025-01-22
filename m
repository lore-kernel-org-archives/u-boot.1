Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D58C02182
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0735280D28;
	Wed, 22 Jan 2025 18:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i71Mgez1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC36780BAF; Wed, 22 Jan 2025 18:09:50 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A024080C6D
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so162542465ad.0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737565787; x=1738170587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3LdWReYUyUlLY+2xDHBhqeJKtbcO7L4d7/JfS6CVrE=;
 b=i71Mgez1b8K76INjX7DyR1E/K3V1+8ygkyxg6VOulFbCCrR04GH/3VtLhQldSqEiId
 EYINDm8GVFbb5ds4V1NBXAFBJEee+6CySM47g/0ry2UMncNh/ymBLoeJk0pMzgqLdCd/
 2OYnFpWHLJ2pEbgHTLKhwaNpHSJlUfkRH3j/EXYQ1vGUw39/zc1J7YT8CvKXwrDb/6/8
 v6dynBiVNtUoexWqh61/tJpnvYqvbkORmKzFOTkD8nHO0aQzvAaNBig7gBLAXM63HFgG
 Mj7PFv0p1dF9fQfhg1hHIgnwL5zJdmROMxU/uBgCD3J2MyFx634kXhgqILf0kGsx0WDh
 Ulmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737565787; x=1738170587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3LdWReYUyUlLY+2xDHBhqeJKtbcO7L4d7/JfS6CVrE=;
 b=IK2E2Pi8gCXb9MWWfFp5gKLHPA2fnwaauAbg1b/7paneGx6tihwqlGB8iRsWtG2NKZ
 RfczO8KLP5mRYlDc4wQKavorF9XLd77l9VtdQ3FNskn9eiJOiheuuOJ5qvEkChy1ukmc
 ub8LnXR0Re4aZTNU/IDG/CLa/zpXVLIsCgZCrBYCyARBZ8SuCwXavNsKWJQXsXpNagD1
 Vu7dQml4hlk6thkoquDAj2UaE6A+wwwzMCFaO92x4ED9jJHzBR8XCmx+bctoLnYil7GK
 V1r6OMF5i+Rp7TH7PcQmtdBrX6W7ZL2oRh2InR9DJpRH5kJSsAoqL4/4rciQzyaRWyjx
 qWfg==
X-Gm-Message-State: AOJu0YwrP7DGBaMCBFBaAglF11p6CoKfFc7USNf+IbXn0TFqtZkBxSm8
 vDuIS5pSYZkZJAJExXLiXC0aSF0BiEXOF7/pR1wSIRps1aSDFlJmLpgEggqH
X-Gm-Gg: ASbGncsh11qotFXfeuR6eaLVoLfV1x4EksY74hlKw24Cx0iEhxnwa170wnD+vorSfM3
 EEuUyPjXmIC6h4QicaEoPKUmN6wA24VXk1ulB9C7k550IZYMm0JHSI+olLxZL/eIt4x6nsU4PPS
 5VSE4DvLVyAMzMOH0rziAJOudeoTAlaS29kzLPCVW4Sam33UkNErFSuKpnkImLLOm2VFN8owXjK
 2C+3+hnDwQbwuY9l2o1cbf5XDgDT4uInBkZbVxY3MRxwobQcqiLWKeFBbWycsBrOiSjFDWz3ud/
 Tg==
X-Google-Smtp-Source: AGHT+IHyXCGZeOgrAYABFxowe7uXJKSl6xqAF3VX6e5irocVfcp+cUEYUXd8UPtGv8pSxbt7qkdYhw==
X-Received: by 2002:a17:903:24d:b0:216:2bd7:1c36 with SMTP id
 d9443c01a7336-21c353eeeebmr355988045ad.1.1737565787129; 
 Wed, 22 Jan 2025 09:09:47 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4028cbsm98095225ad.227.2025.01.22.09.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:09:46 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 14/21] efi_driver: efi_uclass: Add unbind method to
 efi_driver_ops
Date: Wed, 22 Jan 2025 14:08:51 -0300
Message-ID: <20250122170858.961359-15-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122170858.961359-1-adriano.cordova@canonical.com>
References: <20250122170858.961359-1-adriano.cordova@canonical.com>
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

This way when the stop() method of the EFI driver gets called
whatever bind() did can be cleaned up.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/efi_driver.h        | 4 ++++
 lib/efi_driver/efi_uclass.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/efi_driver.h b/include/efi_driver.h
index 63a95e4cf8..8f785f7945 100644
--- a/include/efi_driver.h
+++ b/include/efi_driver.h
@@ -36,6 +36,8 @@ struct efi_driver_binding_extended_protocol {
  *			driver binding protocol.
  * @bind:		Function called by the EFI uclass to attach the
  *			driver to EFI driver to a handle.
+ * @unbind:		Function called by the EFI uclass to detach the
+ *			driver to EFI driver to a handle.
  */
 struct efi_driver_ops {
 	const efi_guid_t *protocol;
@@ -43,6 +45,8 @@ struct efi_driver_ops {
 	efi_status_t (*init)(struct efi_driver_binding_extended_protocol *this);
 	efi_status_t (*bind)(struct efi_driver_binding_extended_protocol *this,
 			     efi_handle_t handle, void *interface);
+	efi_status_t (*unbind)(struct efi_driver_binding_extended_protocol *this,
+			       efi_handle_t handle);
 };
 
 #endif /* _EFI_DRIVER_H */
diff --git a/lib/efi_driver/efi_uclass.c b/lib/efi_driver/efi_uclass.c
index 6553141f4e..393d62d3ba 100644
--- a/lib/efi_driver/efi_uclass.c
+++ b/lib/efi_driver/efi_uclass.c
@@ -247,6 +247,10 @@ static efi_status_t EFIAPI efi_uc_stop(
 	if (ret != EFI_SUCCESS)
 		log_err("Cannot free EFI memory pool\n");
 
+	ret = bp->ops->unbind(bp, controller_handle);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
 	/* Detach driver from controller */
 	ret = efi_close_protocol(controller_handle, bp->ops->protocol,
 				 this->driver_binding_handle,
-- 
2.43.0

