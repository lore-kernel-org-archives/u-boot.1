Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C442C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F6E1874E4;
	Thu, 16 Nov 2023 05:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ex+zspvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4369874C5; Thu, 16 Nov 2023 05:11:45 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF36874D6
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a68b87b265so12519839f.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107902; x=1700712702; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxPGYQBGECC7Y/ZXsWgO1vbN7ibNUVjCT6MaJMvpeLY=;
 b=ex+zspvtNEqL4pTtWuMlMrMH23OdeDDJ3MhMQmiZWKN+H3U+rP7y88aR/L7sO2fkZG
 irwOucoJ6bR/8NdWy1K4VyJDIXBG1NRDNW9BjA6dyor4ypLsCf+k2vqI/8wsxxyvOlft
 FDzCwz4aoePY1JTWu4IoQOWzzKzRAhqLPIgE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107902; x=1700712702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TxPGYQBGECC7Y/ZXsWgO1vbN7ibNUVjCT6MaJMvpeLY=;
 b=tiosSw6rES3CMZGllYFMQOIQJRhAb4dstfp7FfYgpMUNhGYew0cGAR3OGvst0lMgJv
 8SPuts8MRC7g1HFrik8dM4oIeVEuue3nuQorrC+7B2Ldl93nfGFanFFDQ/nnJj2mtyGf
 I7bR7Xn9ewiSwAhyhYdSFJdF0cy2wgIdV9ztcEPOpNMuKWyC95P8NwE6yl2lRPM9jD1s
 +Kk1PdqCUnzbOd2O/tzA/U54awLxtx+InaF7WwvKAdO5+7opd1G8tCfC4+aN4M2oJvst
 IFV8SENrFa2bddJ/KKcgejvYXCGQUkUAMKxBBgXE8/e2BdSbyoRzvEyYSbTFH5FZrwuw
 vupg==
X-Gm-Message-State: AOJu0YxF4uZffu2JM4BZ+wr24E+nz3XLZEF9BfB5yXpWjde5VthuFM3s
 lov98QNgYQr249YI/rQNGZG5HMA4R2ldbyftLDPnzg==
X-Google-Smtp-Source: AGHT+IGC3p3wKB/1hYrIZw/Kubv4piTkY8woNHUxa2HRSXZArPWPLlGJVGRUqrfvmz0zbOORkDUcgg==
X-Received: by 2002:a6b:e20b:0:b0:795:c6f:59ff with SMTP id
 z11-20020a6be20b000000b007950c6f59ffmr17285479ioc.17.1700107902228; 
 Wed, 15 Nov 2023 20:11:42 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 26/32] bootm: Simplify Android ramdisk addr in
 bootm_find_images()
Date: Wed, 15 Nov 2023 21:10:26 -0700
Message-ID: <20231116041043.362055-27-sjg@chromium.org>
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

The Android mechanism uses the loadaddr envrionment-variable to get the
load address, if none is provided. This is equivalent to
image_load_addr so use that instead, converting it to a string as
needed.

This change will permit passing img_addr to this function, in a future
change.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index aae097df0c7f..db1466cecf2d 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -490,15 +490,20 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 		      ulong size)
 {
 	const char *select = NULL;
+	char addr_str[17];
 	ulong img_addr;
 	void *buf;
 	int ret;
 
+	img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
+
 	if (IS_ENABLED(CONFIG_ANDROID_BOOT_IMAGE)) {
 		/* Look for an Android boot image */
 		buf = map_sysmem(images.os.start, 0);
-		if (buf && genimg_get_format(buf) == IMAGE_FORMAT_ANDROID)
-			select = argc ? argv[0] : env_get("loadaddr");
+		if (buf && genimg_get_format(buf) == IMAGE_FORMAT_ANDROID) {
+			strcpy(addr_str, simple_xtoa(img_addr));
+			select = addr_str;
+		}
 	}
 
 	if (argc >= 2)
@@ -525,7 +530,6 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 	}
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT)) {
-		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
 		buf = map_sysmem(img_addr, 0);
 
 		/* find flattened device tree */
-- 
2.43.0.rc0.421.g78406f8d94-goog

