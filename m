Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DE0C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99DE1870E2;
	Sat, 18 Nov 2023 22:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LUbksY5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CA487554; Sat, 18 Nov 2023 22:06:36 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF22F87239
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-35937f2fadeso11843995ab.2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341583; x=1700946383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khEj+gVWPXK+4Nn+QI2f+qdcjpPSJgfBVud+o3+kNOU=;
 b=LUbksY5fI+F4Z3jIUFeTfthoOVmEqBgUxuTjHL/afCyeQHHpp7dz9+dIPVA68JwRrS
 888AbTTdLCWmeEiuyJ60gUsB3EH25IG9uQ8JPCoV8cCl9TW4VLG3dh2zzxdPislTuIHY
 Kt7vp/EiUhwK69PGiJMoIBdAlYY4M5yDQtk+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341583; x=1700946383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khEj+gVWPXK+4Nn+QI2f+qdcjpPSJgfBVud+o3+kNOU=;
 b=JSb54JUUx7J62BfS5WW/GGYu+NA5DQ8x1kSgWHXPn3x1SnvUNzJE95JK/RFAxNCMkV
 pThxQzzCWuB72S3lAx8Eitc1RdPyvzXFECSLDRxLMYM1yKQXb72S8x97QlM025lAhhh0
 rb5meGUDtWtJ1YIK/K18CsJY2gkRvd60OEpAyY7GuTkO8MIc5acvZ+EVItGvflPkarOH
 oyf+hJbeOwDiuNa41zXiP4kkaJ8SClbGaQSHU+8jwWk+txzQs3KmWdwrgXzDApvE/VUi
 ubVa4FmyrJsfzkMX8ZWliq3RUIxY6iHRdxaWO9pGAzlfKjBEGZ9xqCXFPUFPV2ovyrD+
 LKxw==
X-Gm-Message-State: AOJu0Yy0pwJWjv4yClm3l16qI6lTvEb741ny4WG9nsmjXMDCSRsI+O+I
 I1gWIK9R+WzdJZ13amlc/5jY8MvUwRx7gnDUJuRjZA==
X-Google-Smtp-Source: AGHT+IHZkxREvlrPVjxAN6Oyn3mK2qOtdZ8kXYtg+9gKDNywowHT3z2YaDUhIzf23bfYWJZGM8S4Jg==
X-Received: by 2002:a05:6e02:c73:b0:359:4066:a2e7 with SMTP id
 f19-20020a056e020c7300b003594066a2e7mr3622394ilj.0.1700341583466; 
 Sat, 18 Nov 2023 13:06:23 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 30/32] bootm: Reduce arguments to bootm_find_other()
Date: Sat, 18 Nov 2023 14:05:18 -0700
Message-ID: <20231118210547.577026-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

Rather than passing the full list of command arguments, pass only those
which are needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 371f404a02a5..07aae26af01f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -572,19 +572,16 @@ int bootm_find_images(ulong img_addr, const char *conf_ramdisk,
 	return 0;
 }
 
-static int bootm_find_other(struct cmd_tbl *cmdtp, int flag, int argc,
-			    char *const argv[])
+static int bootm_find_other(ulong img_addr, const char *conf_ramdisk,
+			    const char *conf_fdt)
 {
 	if ((images.os.type == IH_TYPE_KERNEL ||
 	     images.os.type == IH_TYPE_KERNEL_NOLOAD ||
 	     images.os.type == IH_TYPE_MULTI) &&
 	    (images.os.os == IH_OS_LINUX || images.os.os == IH_OS_VXWORKS ||
 	     images.os.os == IH_OS_EFI || images.os.os == IH_OS_TEE)) {
-		ulong img_addr;
-
-		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
-		return bootm_find_images(img_addr, argc > 1 ? argv[1] : NULL,
-					 argc > 2 ? argv[2] : NULL, 0, 0);
+		return bootm_find_images(img_addr, conf_ramdisk, conf_fdt, 0,
+					 0);
 	}
 
 	return 0;
@@ -1013,8 +1010,13 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!ret && (states & BOOTM_STATE_FINDOS))
 		ret = bootm_find_os(cmdtp->name, argv[0]);
 
-	if (!ret && (states & BOOTM_STATE_FINDOTHER))
-		ret = bootm_find_other(cmdtp, flag, argc, argv);
+	if (!ret && (states & BOOTM_STATE_FINDOTHER)) {
+		ulong img_addr;
+
+		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
+		ret = bootm_find_other(img_addr, argc > 1 ? argv[1] : NULL,
+				       argc > 2 ? argv[2] : NULL);
+	}
 
 	if (IS_ENABLED(CONFIG_MEASURED_BOOT) && !ret &&
 	    (states & BOOTM_STATE_MEASURE))
-- 
2.43.0.rc0.421.g78406f8d94-goog

