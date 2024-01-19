Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F090C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 00:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA08187C8F;
	Fri, 19 Jan 2024 01:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c/Q5B5rs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DAB487B93; Fri, 19 Jan 2024 01:48:10 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B32C887C8A
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 01:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9b050e88cso266461b3a.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 16:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705625279; x=1706230079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=987e+i7Eq0JZrNoCQx7+nDA1NxECWTAY1oGiBHOp0Gg=;
 b=c/Q5B5rsgZQfTi8BJSq/rKlGfMzKtL9UwB+GXNps4IvRpUSIWZ9RYIfWqLsKvZM6C6
 Yvisq4d8S49Znz+ZbmBrIW/RpelLSK8lX4a0mXtAw/ik+OUwTvWwc5Ac/GDrXZ9LMn3R
 GBmUaZtePH22p0e8nq1fvH+ueMbb//ZwfHKqf66qRlg9OBJXgU+rjEtGT9oZhXRCS17V
 xOCShuOSddmwPsCjG/nAuO26VIm03AnBCnYC6JdNci7QoK23AwapS2r+zxETqB+P8jzI
 4wqypCBaYszuOj6/1+J7OmM8jUOFUrH8RW82t9fVZnRDUpudZs0pJJbToMHAKJuzXNZZ
 RICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705625279; x=1706230079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=987e+i7Eq0JZrNoCQx7+nDA1NxECWTAY1oGiBHOp0Gg=;
 b=Ut1D1EnZk7O4EsmUNo/6fVKC6aFTOXY5EbPhEa85rT9oOvqeRdp5zsFv/uoByNCtCT
 Ixjd/7BkHftDsLyZrLFnHTuDxsKjc678Gb0dV+lgdOdtvFhbnBcOBbdWw1bgu24NfNJN
 QBJNIwfezsUhgvnyHz+6nOjYHQyR/dVAtk1+iPd66UQUNZ6TBg+PivtVFSOaeg2CydeI
 1y+dcXkr5CBxZzAnpWaNWH0rXrKzmCa6W4WDTX07tmjfb+kHxZf5fGOLQzi0wJl2OdWe
 3oNYNPGBpF2E/MtFYsig1Hf57ZpQH6WrqOUtjlC8T51nimQkjVtWK6+wgsTW5B7VlDgC
 egNw==
X-Gm-Message-State: AOJu0Ywh58VFXN0WHQLTCcRIwfM4oflZ5GBwi41xLKDxFjR0nMWFLRML
 Pe3WHrilZ1Ce+c/YUbGXMuZCcXs1tedNWJ4y5fLSyHG2st2C2A0JCPx9CYfv9DvZFOA+U38GdpP
 d
X-Google-Smtp-Source: AGHT+IE0SK9BefkkqheG079H7Syak/USbTnU4rMzE49w/ipXjmOBifeT0nVrb12WNSxsxBtf/VMU0A==
X-Received: by 2002:a05:6a00:4b0a:b0:6d9:a651:4b07 with SMTP id
 kq10-20020a056a004b0a00b006d9a6514b07mr1837305pfb.46.1705625279649; 
 Thu, 18 Jan 2024 16:47:59 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 a3-20020aa78643000000b006db97e2c4e9sm3874522pfo.181.2024.01.18.16.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 16:47:59 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 3/3] efi_loader: return immediately in UCLASS_EFI_LOADER
 removal
Date: Fri, 19 Jan 2024 09:45:46 +0900
Message-Id: <20240119004546.1084018-4-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119004546.1084018-1-masahisa.kojima@linaro.org>
References: <20240119004546.1084018-1-masahisa.kojima@linaro.org>
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
index e2edc69fcf..b1739d9920 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -731,8 +731,14 @@ int efi_disk_remove(void *ctx, struct event *event)
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
@@ -744,10 +750,8 @@ int efi_disk_remove(void *ctx, struct event *event)
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

