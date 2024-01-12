Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6EAC4707B
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 00:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CD28792C;
	Fri, 12 Jan 2024 01:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fMrTK2ih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D1CE8792C; Fri, 12 Jan 2024 01:21:32 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4AB878C6
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 01:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3bbbdf0b859so6282642b6e.3
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 16:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705018886; x=1705623686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejKH3PbnB5egZiczLwA//aVuAqzhtujQe4vggYRX1f8=;
 b=fMrTK2ih6uvPOR6EKprkmBA1WIEw22eR6hTua1D+YSG6Smvd58hAXz28XRCetCQhmi
 QJTH/+TbUTjGXCP1D3zUho9UhAvZQSRaaPpeMUDilozZj6A3iS5R/PMdwsr4WBdx0vdt
 OkU9n1B4Ous40Fuj9I9Nhdi4JUa85oHBmLRFNI/dRF5mD9RrXND56eJ8gFryh6IQl0JV
 RBoKf21BHxhmxwumgVoZAop2qEbJmTMOq2yHB45TOncwzgj1p2GucbC0R9KGIQ/hUTKs
 ICM/qpdl95HiiIhATV9hHKBZ+YIw0yUhoNY6mc+TpCYgy/BvX+cBZSn54Z5i8yakydrG
 jkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705018886; x=1705623686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejKH3PbnB5egZiczLwA//aVuAqzhtujQe4vggYRX1f8=;
 b=VlpBYt3LrSkunwxKRIkmsiNpSPoNAgdFQr+my9oV94oD/N8hkbWWj4Jdwk9ymcCgbS
 WJLblqsXawZdhIlknABuJ/u9FMMgp5G4XO6XhKDTghleP3Jz+Z7Kq5dktfcQQ/Iv2SsW
 iEXLHhP2GX2sPnzjOaJBTwG9sxiYibFz2px85kByNmHQ6UZEFHowgf0eTWLIP6nUeLAN
 Zr1lX8nAgjLtC3/++WSRont+ZNHEG/x3VRQm1KJKuF6WuGQIWMFuibOn3FpmEE0oDDmc
 Xbvo7/40KuVHMN85haM/OgM1okhiHwMTbFWa8gwP+i0KCQ1AD6TyIYAeFZu9JHpUHWn8
 /7sw==
X-Gm-Message-State: AOJu0Yyh/6QOu0t8h4q4IlnLiqOred4kMipPjZDSqDG0vpZkIFVmqX4K
 1V46qJW6jaa6e1MoUWS6dTHgxUh4V1Df3arPtQTQZloneGE=
X-Google-Smtp-Source: AGHT+IH1JU6Nm7cbYBgHDOFsjcXljTjtStBiDV4vWnBguq3pSt9l1rD5SZFhZaJ6p0youT/w1TUKKQ==
X-Received: by 2002:a54:4503:0:b0:3bd:5a9b:f505 with SMTP id
 l3-20020a544503000000b003bd5a9bf505mr165249oil.65.1705018886507; 
 Thu, 11 Jan 2024 16:21:26 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 j186-20020a638bc3000000b005c67ca3c2c2sm1838843pge.21.2024.01.11.16.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 16:21:25 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH v3 1/3] efi_loader: rename check_disk_has_default_file function
Date: Fri, 12 Jan 2024 09:19:21 +0900
Message-Id: <20240112001923.976414-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112001923.976414-1-masahisa.kojima@linaro.org>
References: <20240112001923.976414-1-masahisa.kojima@linaro.org>
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

check_disk_has_default_file() function checks if the
architecture-specific default file exists in the blk
device, and fills the default file device path if it exists.

Rename the function name to fill_default_file_path().

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a032d3ae04..eda2619142 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -307,14 +307,14 @@ err:
 }
 
 /**
- * check_disk_has_default_file() - load the default file
+ * fill_default_file_path() - fill default file device path from blk device if default file exists
  *
  * @blk:	pointer to the UCLASS_BLK udevice
- * @dp:		pointer to default file device path
+ * @dp:		pointer to store the default file device path
  * Return:	status code
  */
-static efi_status_t check_disk_has_default_file(struct udevice *blk,
-						struct efi_device_path **dp)
+static efi_status_t fill_default_file_path(struct udevice *blk,
+					   struct efi_device_path **dp)
 {
 	efi_status_t ret;
 	struct udevice *partition;
@@ -361,7 +361,7 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
 	if (!ramdisk_blk)
 		return EFI_LOAD_ERROR;
 
-	ret = check_disk_has_default_file(ramdisk_blk, dp);
+	ret = fill_default_file_path(ramdisk_blk, dp);
 	if (ret != EFI_SUCCESS) {
 		log_info("Cannot boot from downloaded image\n");
 		goto err;
-- 
2.34.1

