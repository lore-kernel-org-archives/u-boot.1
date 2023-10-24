Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0503C00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D58687971;
	Tue, 24 Oct 2023 20:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lADxKVhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA197879AA; Tue, 24 Oct 2023 20:18:43 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9998687989
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ca816f868fso31233445ad.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698171519; x=1698776319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRQnmPPOzk/6seJShGi+0RxKxqJWtnJ5afu2XIA9PVw=;
 b=lADxKVhCSNF0GKxlfsPgn23mJQc+Q//Q6+QXrs24MBDJw0hN0UgnuF0foqQOCVQ7Q1
 y68PiTwkT64QhSw6EXSijAcf0At5Nglu/KbhzDYjI2cb0rDQ83IWwmyDfk01ZGk+NdO7
 Q+QgIUbSQZSq5M4eyacVeiEFA5hu6KwBl7FvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698171519; x=1698776319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRQnmPPOzk/6seJShGi+0RxKxqJWtnJ5afu2XIA9PVw=;
 b=N4irqsDMHJgSWZv27d3p+//yGxrf9slhCJQWjtssREFNTFqfFBH0033WuKO32bhb0h
 lq0vXejDpwsP+oqHlz5/nLD5CU+lP7/zxzaHPcucH4d+2iwliszQRjebU8xwFXnyOi5p
 PCSxWWOiud/3sApIoTfw9Dw9kbI87ODPfYq2Sl8yKJBq0lHTvVA/gmaGriSwqMG9xWiO
 K6LJxMMPccJI/sb9ZvBzXFiw6JRcQSitPHND9Ud/YbbM38V8egtrmsWA2i1GvN7tS3K4
 kfH22YWZ2zjafT/s1gqcQYrEXA0YZuCKuEneOpsVOILm8hqULNtOtrSdyceBVU006vYM
 znzg==
X-Gm-Message-State: AOJu0Yzb7RjPNAtzGx6L81UP93trdsWO/qmV+ql2YCp9BtW3dmbnd3yg
 ZK9YU5FS8ph1fOX17xoNFDAekmfQCVPfFZYeK2QL3w==
X-Google-Smtp-Source: AGHT+IGPiPgpmYpYXK9POkRmYoqChrnVGFweKWcuVqsyBouUQU2+CPRSCCiYYljSX/h7T3B8ai1E0g==
X-Received: by 2002:a17:902:f689:b0:1ca:8abc:1072 with SMTP id
 l9-20020a170902f68900b001ca8abc1072mr11461689plg.63.1698171519685; 
 Tue, 24 Oct 2023 11:18:39 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c62c9d7289sm7718691pld.104.2023.10.24.11.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:18:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/2] bootstd: cros: Correct condition for read method
Date: Wed, 25 Oct 2023 07:17:37 +1300
Message-ID: <20231025071736.2.Icae3698db8f3c247e629777903db3a1fdbe374d8@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231024181740.1938934-1-sjg@chromium.org>
References: <20231024181740.1938934-1-sjg@chromium.org>
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

This has a typo which makes the method inoperable. Correct it so that
'bootflow read' works correctly for ChromeOS.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_cros.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth_cros.c b/boot/bootmeth_cros.c
index 20e0b1e89c36..cd72db8250ce 100644
--- a/boot/bootmeth_cros.c
+++ b/boot/bootmeth_cros.c
@@ -406,7 +406,7 @@ static int cros_read_file(struct udevice *dev, struct bootflow *bflow,
 	return -ENOSYS;
 }
 
-#if CONFIG_IS_ENABLED(BOOSTD_FULL)
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
 static int cros_read_all(struct udevice *dev, struct bootflow *bflow)
 {
 	int ret;
@@ -419,7 +419,7 @@ static int cros_read_all(struct udevice *dev, struct bootflow *bflow)
 
 	return 0;
 }
-#endif /* BOOSTD_FULL */
+#endif /* BOOTSTD_FULL */
 
 static int cros_boot(struct udevice *dev, struct bootflow *bflow)
 {
@@ -458,9 +458,9 @@ static struct bootmeth_ops cros_bootmeth_ops = {
 	.read_bootflow	= cros_read_bootflow,
 	.read_file	= cros_read_file,
 	.boot		= cros_boot,
-#if CONFIG_IS_ENABLED(BOOSTD_FULL)
+#if CONFIG_IS_ENABLED(BOOTSTD_FULL)
 	.read_all	= cros_read_all,
-#endif /* BOOSTD_FULL */
+#endif /* BOOTSTD_FULL */
 };
 
 static const struct udevice_id cros_bootmeth_ids[] = {
-- 
2.42.0.758.gaed0368e0e-goog

