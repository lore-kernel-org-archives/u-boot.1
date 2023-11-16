Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BCAC47071
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA42A8750B;
	Thu, 16 Nov 2023 05:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HyjdEbxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9AD874D4; Thu, 16 Nov 2023 05:11:50 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30152874C4
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7a6907e9aa8so13307339f.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107906; x=1700712706; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=khEj+gVWPXK+4Nn+QI2f+qdcjpPSJgfBVud+o3+kNOU=;
 b=HyjdEbxupsDPDTO6Gpkp7UbJHr+WNN2Mx13pOeWuYYELK5Cp9aUJ35jpHNJw+5l6LI
 ykaCB3bgAo6bqsIG65Imeir0jh3a+Yxjx7CLRDPs9einY70KUcWUmbL5WOIJ4YqFSmQw
 JCFtvBG4RNQYuIx/8ADh/JhIRmNc1lCKTlT3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107906; x=1700712706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=khEj+gVWPXK+4Nn+QI2f+qdcjpPSJgfBVud+o3+kNOU=;
 b=jBrlbyNW+HxzqrpnkZDKFGwlzWiGcRUobv1wq8jmW5qHeMXQZZIerffEdscsRtR3pL
 pVlhHc/GiovWhGmLxw5rGlKLWTF8qSnor9NxtCN1EBc+81UbfBdFwfS2vyKfo3lTxEBV
 YpA1EETBfKt078NGRKuE1Oz2YefkT/9xORr740xKhVT9ix/AuT317d7o1vaPO/TQS0Wr
 apNpVhTAwAEEeZ6Txo8EH4tE8f1Zoz2Uuhl7JO7m8TsoaBm0ju2pC1qmeU25C179XEye
 SbuG+3zc25nqa/GE4fplZxTjQ76PZ/Kf6E11iKFCCwwOgWF865Eit1B+5IgN2eaezNzp
 MDBg==
X-Gm-Message-State: AOJu0Yypmwf6AC+2WSnZDrRd6jl9fIguZoQoH7tJhQz8noyXCpsnmdg/
 33vx5VayFJzrQI80AeL0YQl4Lm6NooOGvn/H+V65zw==
X-Google-Smtp-Source: AGHT+IGWmrm2ljypciVzSuJeMfuo9VkBYSI87EkPOftTvx5j1CFbqVjgIbJn25YmcyE0ttFl0+oYPw==
X-Received: by 2002:a05:6602:3a11:b0:7b0:1c03:55c6 with SMTP id
 by17-20020a0566023a1100b007b01c0355c6mr18976633iob.11.1700107906770; 
 Wed, 15 Nov 2023 20:11:46 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 31/32] bootm: Reduce arguments to bootm_find_other()
Date: Wed, 15 Nov 2023 21:10:31 -0700
Message-ID: <20231116041043.362055-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

