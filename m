Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E77C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0D287804;
	Sun, 12 Nov 2023 01:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RR7WK5hl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC50E86F40; Sun, 12 Nov 2023 01:10:36 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 721588709F
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35950f04d98so13543235ab.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747785; x=1700352585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+8ea5Ajh6XYw9WIzXWe/WfoDbocU1ow18D+4dJgJ/s=;
 b=RR7WK5hlBpGx01/W7c8wADoSma8Ey30MNcndmjDjDNIB1Z4TJClPTs/Km8+LWx/I3c
 s1a+5wANJH7Mdb2IOnNHZ+z+ONNogN6rbcM/h1hbyp7VtkZXb11EtA9+3SmD1FQYIkaA
 oQYzGn4MX7zN+chrw6nuLPHPSMQfbe/jKeQfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747785; x=1700352585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+8ea5Ajh6XYw9WIzXWe/WfoDbocU1ow18D+4dJgJ/s=;
 b=uCos+BFzBmSVCTZ0pAGCngmF9oZpdLF+M/MTx9csMxAdOXfTz5mZt8S8DpzXwmByVF
 +gfL09hwkKP0qxmQUH18iDyGJ9uNeUUKBbyFUkvgSCEbpWvoqsHB8V9GqLqSmcGffrPo
 ssj1mx+RyDEIKEE/rwFXNeb2cF3fDE517d3GBrcqpVZhPBszW/KhYxHgA6Y5IxY+qKbE
 Asekvl3tnLUmPV3uZ9ECYPCzLnYxbkl6QcCsRctAnfymp+5d1Xhdnm3MT4N/lX7MOqoI
 er5SmFNNsMTA/tLCBezVnI9KfC/IqTLOm7D/ZQCw9INT040Gb2zKLgSl5eAcNxtbzA3u
 IM8w==
X-Gm-Message-State: AOJu0YxKv8flUGvE8I9FAFFUdwg11rtyQnVJcy2IzLhHU9JpFa4T8x+U
 8eEtI4bGHVQXMCU4xFPjmqT6+XITv/8tXdE1brQhDg==
X-Google-Smtp-Source: AGHT+IFv0iSoQ5w4SehUIPpE2hcX+c1xDMqLzsRq9vIz2bIyeQGTiqfy7QvPiDnwszV1lepDhLJnwQ==
X-Received: by 2002:a05:6e02:1749:b0:34f:c7f7:18b with SMTP id
 y9-20020a056e02174900b0034fc7f7018bmr5703892ill.2.1699747785035; 
 Sat, 11 Nov 2023 16:09:45 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 16/29] bootm: Reduce arguments to boot_find_os()
Date: Sat, 11 Nov 2023 17:09:01 -0700
Message-ID: <20231112000923.73568-17-sjg@chromium.org>
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

This function only uses one argument so pass it in directly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index ec43d4e7e8ba..2358d68c2861 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -304,8 +304,13 @@ static int bootm_pre_load(const char *addr_str)
 	return ret;
 }
 
-static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
-			 char *const argv[])
+/**
+ * bootm_find_os(): Find the OS to boot
+ *
+ * @addr_fit: Address and/or FIT specifier (first arg of bootm command)
+ * Return: 0 on success, -ve on error
+ */
+static int bootm_find_os(const char *addr_fit)
 {
 	const void *os_hdr;
 #ifdef CONFIG_ANDROID_BOOT_IMAGE
@@ -316,7 +321,7 @@ static int bootm_find_os(struct cmd_tbl *cmdtp, int flag, int argc,
 	int ret;
 
 	/* get kernel image header, start address and length */
-	ret = boot_get_kernel(argv[0], &images, &images.os.image_start,
+	ret = boot_get_kernel(addr_fit, &images, &images.os.image_start,
 			      &images.os.image_len, &os_hdr);
 	if (ret) {
 		if (ret == -EPROTOTYPE)
@@ -986,7 +991,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		ret = bootm_pre_load(argv[0]);
 
 	if (!ret && (states & BOOTM_STATE_FINDOS))
-		ret = bootm_find_os(cmdtp, flag, argc, argv);
+		ret = bootm_find_os(argv[0]);
 
 	if (!ret && (states & BOOTM_STATE_FINDOTHER))
 		ret = bootm_find_other(cmdtp, flag, argc, argv);
-- 
2.42.0.869.gea05f2083d-goog

