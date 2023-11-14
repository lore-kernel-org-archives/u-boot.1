Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB79C4167D
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 09:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F86687440;
	Tue, 14 Nov 2023 10:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zEnpK2sm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5534F86FB2; Tue, 14 Nov 2023 10:26:41 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A2C487269
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 10:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2800bdf888dso4082425a91.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 01:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699953997; x=1700558797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3Vyj8zH1wilO2p+N0KC7xECw+I4drVeJwtAwojUGV0=;
 b=zEnpK2smXYUWLBFswzipt3JUpoJdlgYWNGInL4SYUhEo10Ni7HTJj3ult51r9BIpIC
 JZYbHy53jqM1Cv+PVyQuSl5Wy0p+wez+TwcaLNz+R9AeOYLd/l12IsxtFwHDB7gPp6fJ
 bGzns/pjvn4vQ1pvWwqDz4LYI/o6B9kHd7pr9hYnJdb+E3G6ewqUZE73QStwymEAX6cI
 O7kKePA9M3CcXd2dkG/bJRuQU4k0LzcMPcncPR0DcX8V9TkoRCQk7k57AJas7uDXdgZZ
 56zSKpi8PYa2+aw+mAnYAHpkOZImIbGD+vpB2pHKanr3g0riVtAhZBwZHZPVxtmXNc6h
 GFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699953997; x=1700558797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3Vyj8zH1wilO2p+N0KC7xECw+I4drVeJwtAwojUGV0=;
 b=h2PeQsvs9OeiqcpLS7Gv2mnJ5d9zdJAY+r1bDWifkZuvHYGfWniX0g7T+GT2yz2VF/
 ata96VpTUUBRJpec04tJAAOqNWmk7AZTAzOz+lkpLTKda5JkSQQ3G3gUSxDhcwgKsAmQ
 zEY0IjTvH4QsJlhhh7hBwZfsIvuHw3Ukbzn5lNST5AyFQW3jdv99xzdp/vH4mv5QRpml
 Vnov9gjStPriTD4VtFugRGp2gDEAu25MlHzs7tP4+QqMkUpXuI06L3Mh+zXklMiuE8zv
 811jJ73AGCMwe8s7oXKQvGdrnnC6i2PCUeY+0YmdMO++JQ9SQZc1SUKIMaspBmuuXNg4
 abOg==
X-Gm-Message-State: AOJu0YzzFqHVH3wSB/axpQrtt7O5EwGNyZwUIJ7W4vd6KCY4mHoGN2k/
 RBuu7+1HQYS1lpsjx0wpsw22FNll5j3dbxCXbmg=
X-Google-Smtp-Source: AGHT+IFQQJV5ThDZl+Bm+TSPLStZeYXzZQRuaRRCUAWn7XcnBb7HtPo1wq+cui4PqPyD5WUjTlbeWg==
X-Received: by 2002:a17:90a:d348:b0:280:6cde:ecc2 with SMTP id
 i8-20020a17090ad34800b002806cdeecc2mr2936766pjx.11.1699953997049; 
 Tue, 14 Nov 2023 01:26:37 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 22-20020a17090a001600b0027ceac90684sm5526577pja.18.2023.11.14.01.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 01:26:36 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 1/2] efi_loader: use original image_index for FMP versioning
Date: Tue, 14 Nov 2023 18:25:07 +0900
Message-Id: <20231114092508.3955838-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114092508.3955838-1-masahisa.kojima@linaro.org>
References: <20231114092508.3955838-1-masahisa.kojima@linaro.org>
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

FMP versioning uses the image_index argument of
EFI_FIRMWARE_MANAGEMENT_PROTOCOL.SetImage() service.
When CONFIG_FWU_MULTI_BANK_UPDATE is enabled, image_index
is updated by fwu_get_image_index() function. This commit
saves the original image_index argument and use it for
FMP versioning.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_firmware.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 9abb29f1df..9c1a273926 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -612,6 +612,8 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 {
 	int ret;
 	efi_status_t status;
+	u8 original_image_index = image_index;
+
 	struct fmp_state state = { 0 };
 
 	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
@@ -641,7 +643,7 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 			     NULL, NULL))
 		return EFI_EXIT(EFI_DEVICE_ERROR);
 
-	efi_firmware_set_fmp_state_var(&state, image_index);
+	efi_firmware_set_fmp_state_var(&state, original_image_index);
 
 	return EFI_EXIT(EFI_SUCCESS);
 }
-- 
2.34.1

