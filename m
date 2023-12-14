Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EAEC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B51887AF6;
	Thu, 14 Dec 2023 17:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fwf6Mz6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1409287ACF; Thu, 14 Dec 2023 17:51:53 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB4A887822
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-35f6f9963c1so2195435ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572708; x=1703177508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ReOUyomU4fB1P1AFxhRKN6Uh4gupGbxBYceimJFMlcI=;
 b=fwf6Mz6y8ug1NUYGo/GGuBIaE+Nqw1gxatK9WxHGJfl44dS625fIcHsTt9Nptpfenx
 OpP+V0qSSRCkXgP6+99bjVUavnRTtpnWCmyPN/pqJMbIDiKAdK29pgMxODP4Hgpe4GYw
 +zih+EFWjrxaHSISwp5O3VmMyjNXqvBEiAlW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572708; x=1703177508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ReOUyomU4fB1P1AFxhRKN6Uh4gupGbxBYceimJFMlcI=;
 b=O9WQOvGlyOkHE1UzSn+wgj0SyDNqmryyjdbWaf0NtH2bibWvuanZltdRxaa7+9CPDx
 +YTFgawbgtVZHSPYPP9apQuAUB07230uKXYdt+ejGbrm+Z4kWivso+xESBtWAaG+/vho
 tNAMZq0HA6AkafiL5apirxBBFcZ7JskfAJArqnP5ykVbz2fW693YKUPaxu/jo3/C8VXP
 mb+L5I/kP+KOImSWy4i0BwwAtLlVREsMkN1d0xDCHQxu/g+0wrawBfA36vAtgH6KYfz2
 1l7EIQvEqFpqR/i7or2xjt2OFbGgjHzbTtJ6uo3W0ybsC+58WPjhw2uc9lzC3lNdlGSJ
 rfbA==
X-Gm-Message-State: AOJu0YzWe77IsVZrz7MHS6LrNayfBaVAdFbnmzYicbGo2f5mNYoeIR31
 XSP6Yc1cdMo7BjgCLAgLVSeVogJIiv1MarxRB7Vk4Q==
X-Google-Smtp-Source: AGHT+IHZCU39WTX3Kxktpp/8WgUQIJ7vlF/Re0GR+qQzxTZJlR7LJEICII10O1lG1ZKNHoUDBmOZCQ==
X-Received: by 2002:a05:6e02:2148:b0:35c:a889:76f2 with SMTP id
 d8-20020a056e02214800b0035ca88976f2mr8408095ilv.8.1702572708178; 
 Thu, 14 Dec 2023 08:51:48 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 06/21] bootm: Adjust how the board is reset
Date: Thu, 14 Dec 2023 09:50:15 -0700
Message-ID: <20231214165112.2182274-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

Use reset_cpu() to reset the board, copying the logic from the 'reset'
command. This makes more sense than directly calling the do_reset()
function with the arguments passsed to the bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 301cfded05cb..8a0dba5074e8 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1140,10 +1140,12 @@ err:
 	if (iflag)
 		enable_interrupts();
 
-	if (ret == BOOTM_ERR_UNIMPLEMENTED)
+	if (ret == BOOTM_ERR_UNIMPLEMENTED) {
 		bootstage_error(BOOTSTAGE_ID_DECOMP_UNIMPL);
-	else if (ret == BOOTM_ERR_RESET)
-		do_reset(cmdtp, flag, argc, argv);
+	} else if (ret == BOOTM_ERR_RESET) {
+		printf("Resetting the board...\n");
+		reset_cpu();
+	}
 
 	return ret;
 }
-- 
2.43.0.472.g3155946c3a-goog

