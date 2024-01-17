Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750D6C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 09:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501CF87B1C;
	Wed, 17 Jan 2024 10:46:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JDxO+1ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0992D87B1C; Wed, 17 Jan 2024 10:46:57 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 469D187B48
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 10:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5986d902ae6so4389416eaf.3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 01:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705484811; x=1706089611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBpcYrQWRI2JAJfzQUSkVa9gBNfch/09fTVSYRF+OE8=;
 b=JDxO+1ruqqDi9CP2HuQlsQ9XRSPV1AxPgArFLQ3zhrgJ63KDCkzJIbUdq9O3j6/Lzv
 6mnuWCJSV2KM0K16e+CloNAH1PaV//QS/zyu3WKcW9LQy35MTinRiBEzV5kf0zhQ6He/
 m2KzixbOfzpH46UPL/gILYIj+1BWfbNcbN/BSVHcPWRPEFccieRd2QkoLB3kYEfGmCAz
 bFDvUHeDOgd7ar1w/zJ6+A4nO8EH0+4SRkhFJ0GOcfam/2NFcLVBdt/vqLDwcu/uDrnC
 AhKvLhrX+qNOdP163ZAGkArhdkds9vT+/6SwatvIPrywbQuvD5LzF7KbFKduV9YpoVnY
 wlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705484811; x=1706089611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TBpcYrQWRI2JAJfzQUSkVa9gBNfch/09fTVSYRF+OE8=;
 b=qWXAIRSWfcSCage3HniCI4ywO2vOgzif72SNp2+4nHp+hqFtWKR6NT9erob3qBUzvu
 GircXpNq/7/AcHIyx/tVtS6gyhdL66RMg1C6hNZCDC0G2mFwjcXNkJHjA3myJJU1s8i2
 ANKxGmgpzNl8jtHZIUb4+MDT/yALStBOYR0MJBwi+Za5fNg0gX5M0TkqoLhRDZr0KlFH
 JhHKOZtj4z60iR7j1e72C4yDqlfVdsjZHAkHua1WbraFwacamoilGfj8i8Uv99D/cW3d
 wfHNeJHtAYZXGQE6NYq2+a/kwwJ3+EEBnA3E1MnThENa0xec8EcyhdpnU5UBEzZBL2Dd
 PS5A==
X-Gm-Message-State: AOJu0Yz4UGWCeCoVDORt51ueJK7+RhO9cHgPG6fKYVFmvdo0PZ0DJKDD
 eX/zw0gzlsRjpQFF1eat2/B/pqs/XPUjnGSaHF9MKGic3r8=
X-Google-Smtp-Source: AGHT+IGZxcj1M7CSf++hpzdBt9ojXSz4VVObCQoN6lV3pV4E6HrYRAUVbPcy7inQVMZKkhHGxhTeXg==
X-Received: by 2002:a05:6359:2d05:b0:174:edd3:b3e9 with SMTP id
 rl5-20020a0563592d0500b00174edd3b3e9mr6330247rwb.38.1705484811510; 
 Wed, 17 Jan 2024 01:46:51 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 h13-20020aa79f4d000000b006d92f081d9fsm1004698pfr.31.2024.01.17.01.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 01:46:50 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v2 3/3] efi_loader: return immediately in UCLASS_EFI_LOADER
 removal
Date: Wed, 17 Jan 2024 18:44:32 +0900
Message-Id: <20240117094432.1049168-4-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117094432.1049168-1-masahisa.kojima@linaro.org>
References: <20240117094432.1049168-1-masahisa.kojima@linaro.org>
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

In case of UCLASS_EFI_LOADER, EFI handles are managed by
EFI application/driver, we must not delete EFI handles.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_disk.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index 4897a7a7a8..cdf8a4560e 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -734,8 +734,14 @@ int efi_disk_remove(void *ctx, struct event *event)
 	switch (id) {
 	case UCLASS_BLK:
 		desc = dev_get_uclass_plat(dev);
-		if (desc && desc->uclass_id != UCLASS_EFI_LOADER)
-			diskobj = (struct efi_disk_obj *)handle;
+		if (desc && desc->uclass_id == UCLASS_EFI_LOADER)
+			/*
+			 * EFI application/driver manages the EFI handle,
+			 * no need to delete EFI handle.
+			 */
+			return 0;
+
+		diskobj = (struct efi_disk_obj *)handle;
 		break;
 	case UCLASS_PARTITION:
 		diskobj = (struct efi_disk_obj *)handle;
@@ -747,10 +753,8 @@ int efi_disk_remove(void *ctx, struct event *event)
 		return 0;
 	}
 
-	if (diskobj) {
-		dp = diskobj->dp;
-		volume = diskobj->volume;
-	}
+	dp = diskobj->dp;
+	volume = diskobj->volume;
 
 	ret = efi_delete_handle(handle);
 	/* Do not delete DM device if there are still EFI drivers attached. */
-- 
2.34.1

