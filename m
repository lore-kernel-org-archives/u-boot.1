Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3CFEED606
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 14:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1129E88EC7;
	Thu, 12 Sep 2024 16:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BLCNpAeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2820E88FCE; Thu, 12 Sep 2024 16:00:17 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C695188D57
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 16:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42ca4e0299eso8042015e9.2
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 07:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726149614; x=1726754414;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/l7SfMtwcV41khkbbYtMvqREAYomiCSewNmi/Ci7prU=;
 b=BLCNpAeIc0R3MiG3ns2Nm67qZTQQC6Vc/QhrJjvQV9aB8NqNpjWd5MwmPBNWa3x0zh
 kJdyHvFKizGf3PSZMGN/YfVC1jTdSfEimKo1rVdcK2DMM/pto6nhehxvJ1/RfhToR4ZX
 6WFAB++gZwweikhYsc4pEF7GErFcr1NOsmZsJ9ppROYggtbWPt70ZGSSl1OjSFQzhj6w
 aLOtlSP+pzOBYQ8u00tS+SE/+Zaksz2LPSw9tb4GWe+i1NMAS2t9ktdWjamfbW+yUMgI
 uwdLHsrmlTDIq61/o6sbpZCFZs1v+3aP9kju/py6KBM1Q8G+G0kmVt0Md39FpSp6zqwr
 kJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726149614; x=1726754414;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/l7SfMtwcV41khkbbYtMvqREAYomiCSewNmi/Ci7prU=;
 b=QXjQdyibx608jUZofsKM5cl5ncV/BZ0j05BEUA43DCpoj2kD5q8mX35AMPYeLJhNZE
 gmvO/E6yh7g3jurgpdL622pVK77tcqaHCDg6SJGZXyoyyzo05XgDGtVgJ1n/oxRqHv44
 LE7IvH2w0CsSoIuN8nZCffA1uPZtrZN/9sWlnk71UpAnThELxfyIXNWtgzv2+2vQ5XUs
 yk0M6gaZyHbtPHxzOIiFqwdLe+YwBfhSXntQ1YUOPtd0GKtGwWdMVtAW/v5DQURbbMgT
 JkhVxyg0MvGjR/JjQ1DQJHqoaCmlbsy88S19k/pdoHglSNTeN/1IB7hIQMG/fDh9S4Xx
 EfIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLscsW0Lg2kLKM9SIWFsFt4kFZ51rshye01+IHVAtAmI2zOQDAhgut+JHqJz5JAK0x0lbmnoQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzi9+SyzrEBpfu/MP6Lx8GdGSAuTMwQQaesdAEZwc2s/eJDM6pd
 P9JNAtZlrS6Bc9XZnh64VDIIgiY+zGcJC2NAjAQllCVWaQv6K2VXgaUt2FSipUM=
X-Google-Smtp-Source: AGHT+IH2f0MPBkwhC24pQFjAKYc3s7IFnvqA15xYQKo1xKQEdTPQhphiJv4Eb4vnObNAVoYU+9lCqQ==
X-Received: by 2002:a05:600c:510f:b0:426:66e9:b844 with SMTP id
 5b1f17b1804b1-42cdb529479mr23532565e9.8.1726149613902; 
 Thu, 12 Sep 2024 07:00:13 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb6db7ddbsm139726005e9.34.2024.09.12.07.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 07:00:13 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 12 Sep 2024 16:00:01 +0200
Subject: [PATCH v2] bootstd: android: Add U-Boot version to cmdline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-bootmeth-bootloader-version-v2-1-76d4c0b45024@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAODz4mYC/42NQQ6CMBBFr0JmbQ3UgtSV9zAs2jLIJEDNtGkkh
 LtbOIG7/37y398gIBMGeBQbMCYK5JcM8lKAG83yRkF9ZpClVKUulbDexxnjeIbJmx5ZJORjJ6S
 R9lYPDpUbIBs+jAN9T/uryzxSiJ7X8yxVR/ufN1WiElrftWmVbOumeVqzTmQZr87P0O37/gMTz
 byvyQAAAA==
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.2-dev-b7dec
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

When booting into Android fastbootd (a subset of recovery), the default
UI shows the bootloader version in the screen [1].
This is done via the ro.bootloader property which should come from the
bootloader.

Provide the U-Boot version via a kernel commandline argument so that
fastbootd can show it properly on the screen.

[1] https://android.googlesource.com/platform/bootable/recovery/+/refs/heads/main/fastboot/fastboot.cpp#42

Reviewed-by: Julien Masson <jmasson@baylibre.com>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Changes in v2:
- Clarify by a comment that we intentionally ignore return (Simon)
- Link to v1: https://lore.kernel.org/r/20240904-bootmeth-bootloader-version-v1-1-9979a8428566@baylibre.com
---
 boot/bootmeth_android.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 6e8d3e615db0..19b1f2c377b9 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -22,6 +22,7 @@
 #include <malloc.h>
 #include <mapmem.h>
 #include <part.h>
+#include <version.h>
 #include "bootmeth_android.h"
 
 #define BCB_FIELD_COMMAND_SZ 32
@@ -171,6 +172,12 @@ static int configure_serialno(struct bootflow *bflow)
 	return bootflow_cmdline_set_arg(bflow, "androidboot.serialno", serialno, false);
 }
 
+static int configure_bootloader_version(struct bootflow *bflow)
+{
+	return bootflow_cmdline_set_arg(bflow, "androidboot.bootloader",
+					PLAIN_VERSION, false);
+}
+
 static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 {
 	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
@@ -264,8 +271,12 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		goto free_priv;
 	}
 
-	/* Ignoring return code: setting serial number is not mandatory for booting */
+	/*
+	 * Ignoring return code for the following configurations:
+	 * these are not mandatory for booting.
+	 */
 	configure_serialno(bflow);
+	configure_bootloader_version(bflow);
 
 	if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL) {
 		ret = bootflow_cmdline_set_arg(bflow, "androidboot.force_normal_boot",

---
base-commit: 360aaddd9cea8c256f50c576794415cadfb61819
change-id: 20240904-bootmeth-bootloader-version-2a2b35fce4cf

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

