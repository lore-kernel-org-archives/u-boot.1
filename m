Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A77BE77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 13:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1688C8036B;
	Wed,  8 Jan 2025 14:43:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R3EuJHw/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9736805FB; Wed,  8 Jan 2025 14:43:32 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A445D805E2
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 14:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso166581875e9.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 05:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736343810; x=1736948610;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Lw94X5+nAaAuwULL3PYA3IMAy6ir4IIif6gRnwgPU4=;
 b=R3EuJHw/Nkxwahwpj6fgvikrnnd04bnMCjMAN3LEsA2HeUEzBojBmeod7FSdj81Taj
 9dc1N3rN1OSwOi5c+J9g5h04qKzREcjWGNfpLUiPAxjnRcLxiuGFHdH5Ph6b2QJBKlu2
 cvuVHNgqOv7Vd/LS/VVN391yQBiXGSbiwJSPJotJnHJc0bGUbP+8ZfMrI9iCIbca7+nI
 sE7sOAvdmuc5pA/cDA6zQjJaBOuKkuAfrJ9dBsCeCA3xVJXidwc2yMbTJSc/6e2WF9lW
 iQSi/L+uMq/BAjDf8YPx6uLzRvhTUv1knYES0EQczol3jCq22/aiCV2zB/0X+URdUdN5
 z1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736343810; x=1736948610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Lw94X5+nAaAuwULL3PYA3IMAy6ir4IIif6gRnwgPU4=;
 b=PcflVP3LGGk9m3BC57GFTfEVZHcfqvbMhejIoJPblUfgeyky01UJwy9ceFYmBA+9/5
 +l8CwwCB/vkRefgNFnZWC1DWu+m/pX1hc/ocuxI8T6kpQSChde2fvRVHNMm3wzrlH091
 DXcXnQlEy8/fQRcRdRSKJ9d9DVnaqdyCItNAa5I0cl+NOkWQnALIth80VASZe2hnXv5c
 UxFMc3+ZchnFJnlU0x/1nJJlypFuwRw1VTddHnmm1oA/rz1W+c7hJcpWJekmiLuF3Uxx
 DZLH4xi2EtyoRfI1XGCU9tVMHM12ZGq0hfW/rMqdaquQScfrv+6lk2lBdE7S0gDUbTPr
 zeuw==
X-Gm-Message-State: AOJu0Yy660WH8zEopoFqiwSIvut6yiOB79/HAMcbRTkAcsN6y0aqZWE/
 l7TWASNZTDz7qE9RY+MR4jWedHA9pniGhkkTIvIn5ODrMy7Cctx+qqS0mJYsmPs=
X-Gm-Gg: ASbGncvprXYCR3pO/d7/DtDHFnu+aw+ief1Wc6xPWQDejbly5ATXUewMK8yye3RSW0Z
 4UKibu0pyVlL6OTX+xyetFItX/gplFIm4FTyQ7nRue2A4k+PHYTV1FIFT49wpzzkmjwL+bNLo2M
 QE9iJv5EyU7O4HLovLSxxI5j1QGUSrtxYL5g8mH2BFdUjP2QajvW7LZ3N/8DHJ9d+KfaXEk5nYF
 s5/5LUPp5XOkx5TDayPDaEoL9yTH8QGLeUr825btMcZiCoTiWWWsrx/fi8DST0/1zBP0Hyl
X-Google-Smtp-Source: AGHT+IEVPirKiI4w/m0G/KLV0Zc3w6xzkfGGBwMRIE85hiGP8fCiQ4Lmpdj5fzITQ1NA8BdREvoqEQ==
X-Received: by 2002:a05:600c:138d:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-436e26c4a1amr25376705e9.13.1736343810079; 
 Wed, 08 Jan 2025 05:43:30 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e22767sm21166045e9.39.2025.01.08.05.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 05:43:29 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 08 Jan 2025 14:43:14 +0100
Subject: [PATCH 1/2] bootstd: android: Add missing NULL in the avb
 partition list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-avb-disable-verif-v1-1-009c35710ef4@baylibre.com>
References: <20250108-avb-disable-verif-v1-0-009c35710ef4@baylibre.com>
In-Reply-To: <20250108-avb-disable-verif-v1-0-009c35710ef4@baylibre.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.3-dev-86319
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

When booting an Android build with AVB enabled, it's still possible to
deactivate the check for development purposes if the bootloader state is
UNLOCKED.

This is very useful for development and can be done at flashing time via:
$ fastboot flash --disable-verity --disable-verification vbmeta vbmeta.img

However, with bootmeth_android, we cannot boot this way:

    Scanning bootdev 'mmc@fa10000.bootdev':
      0  android      ready   mmc          0  mmc@fa10000.bootdev.whole
    ** Booting bootflow 'mmc@fa10000.bootdev.whole' with android
    avb_vbmeta_image.c:188: ERROR: Hash does not match!
    avb_slot_verify.c:732: ERROR: vbmeta_a: Error verifying vbmeta image: HASH_MISMATCH
    get_partition: can't find partition '_a'
    avb_slot_verify.c:496: ERROR: _a: Error determining partition size.
    Verification failed, reason: I/O error occurred while trying to load data
    Boot failed (err=-5)
    No more bootdevs

From the logs we can see that avb tries to read a partition named '_a'.
It's doing so because the last element of requested_partitions implicitly is
'\0', but the doc explicitly request it to be NULL instead.

Add NULL as last element to requested_partitions to avoid this problem.

Fixes: 125d9f3306ea ("bootstd: Add a bootmeth for Android")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/bootmeth_android.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 19b1f2c377b9a51ff1683259085e1d636c939413..2cd167f80280801618a317a65e93a10e70a0d9ee 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -380,7 +380,7 @@ static int run_avb_verification(struct bootflow *bflow)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
 	struct android_priv *priv = bflow->bootmeth_priv;
-	const char * const requested_partitions[] = {"boot", "vendor_boot"};
+	const char * const requested_partitions[] = {"boot", "vendor_boot", NULL};
 	struct AvbOps *avb_ops;
 	AvbSlotVerifyResult result;
 	AvbSlotVerifyData *out_data;

-- 
2.47.1

