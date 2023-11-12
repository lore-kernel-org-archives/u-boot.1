Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57DCC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63EEF877B1;
	Sun, 12 Nov 2023 01:11:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y5RNENtn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F047864E8; Sun, 12 Nov 2023 01:10:46 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DAF187168
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-359974f4c7eso13064395ab.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747792; x=1700352592; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rs4IoPuTPIKpbQiROzTBv5O0bVrLUnm3Q/GGnCNjCyc=;
 b=Y5RNENtnPRdsNTnHjcQa/1Trw2kFhVa7iikVzQ9907S0wtimsl7xYPJhYZ18gNIqZr
 iPghemNpqxI0Wi5dYm/VK21XsQReCNzXAbLVqUBDp//i9rQ8EBhpUMN7ypGjavlIUcMN
 p9mfnLMsLxqTm3RJBtdh5ywD87oTbGOFEiUlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747792; x=1700352592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rs4IoPuTPIKpbQiROzTBv5O0bVrLUnm3Q/GGnCNjCyc=;
 b=rLT58Z2hq49M4ByIPeOD0WvTU4jMvDbKD40n4NaH3OUl5CJxgi+UZ9UUbnoXhebDzm
 AnkKmn2QdlUVd4nsYaGxZncqgUUb3fTtYXFg6LdOh3YPDb6YsGUEtnKorVlQf29ozZZS
 NsA5gpTIModMU1K0V2Cnu4Z6wCzgiECOAjjT85tvDEs4AAYq/hK+i9CuZhEEPRb88LIP
 UVw/e2PqQK55FSjcjZVCKPcX3n7Fhw9t5fRMCixq6+56Or44kMmanm8wpZmEq+i526BF
 /J2z1EaowWMzOnfNRjdNULDDWSIYoRhT6TVBe0lgGzKATl99d2Xfp1dwcSkTnmAMS425
 LNLg==
X-Gm-Message-State: AOJu0YwcVXkdlBqihlKmd1BzuVBQWvOLFF6OZBcLU+qElKpyZJOsBbo1
 NY2dd/uyvo5xnsl7ErRcHqnlwbqGgC5CwltSh+L6iw==
X-Google-Smtp-Source: AGHT+IG3oQqiwt6cyitGMMXKz+N+qd4l+6rGbWHolMnEbuqbOt4/MrUl2fAN8u1yfmPsCwZOvujF9g==
X-Received: by 2002:a05:6e02:1bcf:b0:357:438f:6ecf with SMTP id
 x15-20020a056e021bcf00b00357438f6ecfmr4448404ilv.13.1699747792266; 
 Sat, 11 Nov 2023 16:09:52 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 24/29] bootm: Simplify Android ramdisk addr in
 bootm_find_images()
Date: Sat, 11 Nov 2023 17:09:09 -0700
Message-ID: <20231112000923.73568-25-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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
---

 boot/bootm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index c71368431c48..41cb52fb72c7 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -489,15 +489,20 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
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
@@ -524,7 +529,6 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 	}
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT)) {
-		img_addr = argc ? hextoul(argv[0], NULL) : image_load_addr;
 		buf = map_sysmem(img_addr, 0);
 
 		/* find flattened device tree */
-- 
2.42.0.869.gea05f2083d-goog

