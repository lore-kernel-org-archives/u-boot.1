Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E164C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88242839CA;
	Wed, 28 May 2025 10:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vb2sNcuj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85052839DD; Wed, 28 May 2025 10:26:34 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B3C839B9
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85d9a87660fso419354939f.1
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420790; x=1749025590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+y0vF6KtNavsDikWG90Il+CG70xBXmuEnAlNeSbpYs=;
 b=Vb2sNcujotSvz97Z+AjaTdgNNI1HnEqthy8Iro8jDH/P5ylkU6nbglznJKfYKupq71
 D3BACwqos748QyR87/MJaO/FUvN57xBvpk1JemuyOMZQzkv3o7tjS4e+SnGBuL0wopth
 jwna93EVn9oL6797cDoOhmBId5xDaHgHqS64o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420790; x=1749025590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+y0vF6KtNavsDikWG90Il+CG70xBXmuEnAlNeSbpYs=;
 b=bHUO1cNV6ZCw8D7gjoi6fhAvUtmQXpEzRiq/jNiUBe0TYr8xE/pLqAFaZOtECWVOZl
 bFA9NUAObAnILjRKLbQC0DpI+V0w220gotmvtjYMbfA0ZSY/DCWoiEZIKFwPWt5n7s4j
 M3yDsXulGM8FZjH/1LXfEYpITbVelWmXpoKXRXZP5DKGZvvp75oYfq0GibeRNIDSuNUe
 c2gsoFeCxdQx8ACGtdWcowPwDAmgFpdOWGMT1lGtjYS8TUUDOBNY401cazmbOABsQIWT
 pngEqHFfH1hDtUqbLEFp1o6gc6xlie+Q1CsncEZEVylrl+z2dUxqF+uoVdgPmbfb+1l8
 Fz5Q==
X-Gm-Message-State: AOJu0YxqB6HKPwKetk1qIGd73EttW/mT7WDjKV6gt1BfwmyOrCG7HN5a
 G6tRwfaIvRHlYzoelNw1OVLUGUFlpjKjG85HtD+/rSHQCJsr8VmhV6cUcRMa6bKza8+GM0FqtRY
 qdjKdmTmM
X-Gm-Gg: ASbGncvoA8/uHlLaHcF+mQ0SDx+dR01SMF5JdU2hJ1Sc7SSj/K2VnyePwX6OxihkXtq
 6+Z0fYb3dQ2LkPvWvA6jVk+79rkX8gRNR2ZrZbrm2fm6migxlIHdtdHqQvtOP3daTpFJncU5Ig4
 nMpSnpgJJjMKJUUhN65DadQXmJaMVYUy/Rd1s2BdE5b6GZ0Kak7esokg5SvumkLD9XCQp+qYHxc
 xQuweT2M9mrSUXOTyT0M/rGUnckDxlWzQBkmNl7JV6/C3c1JdrWsvAGBfhkXbyixHpfpkFd5iC3
 eDWpKSLUB+p6ugQKBJQorSbWRq3zqq7n4OZ35ybshx9izDs7PyT7exox33AJv3s6GgW+80+2Vex
 4yNq0+sGlX0XN
X-Google-Smtp-Source: AGHT+IHX40ibg065UrQQqUMX6oh1NxxTpkWWilIfTJ6OOl6GxVvWxfMAi6X3tVLxNFSoUO7rKT6OQg==
X-Received: by 2002:a05:6e02:164b:b0:3dc:7b3d:6a37 with SMTP id
 e9e14a558f8ab-3dc9b6a5643mr151111395ab.8.1748420779878; 
 Wed, 28 May 2025 01:26:19 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/27] efi: Add a bootdev for EFI media
Date: Wed, 28 May 2025 02:24:43 -0600
Message-ID: <20250528082520.152391-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

Bootstd needs a driver so that it can scan EFI media within the EFI app.
Add one.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/block/efi_blk.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/block/efi_blk.c b/drivers/block/efi_blk.c
index 9766cd6f832..6d67bff32bc 100644
--- a/drivers/block/efi_blk.c
+++ b/drivers/block/efi_blk.c
@@ -9,6 +9,7 @@
  */
 
 #include <blk.h>
+#include <bootdev.h>
 #include <dm.h>
 #include <efi.h>
 #include <efi_api.h>
@@ -79,6 +80,31 @@ static const struct blk_ops efi_blk_ops = {
 	.write	= efi_bl_write,
 };
 
+static int efi_bootdev_bind(struct udevice *dev)
+{
+	struct bootdev_uc_plat *ucp = dev_get_uclass_plat(dev);
+
+	ucp->prio = BOOTDEVP_3_INTERNAL_SLOW;
+
+	return 0;
+}
+
+struct bootdev_ops efi_bootdev_ops = {
+};
+
+static const struct udevice_id efi_bootdev_ids[] = {
+	{ .compatible = "u-boot,bootdev-efi" },
+	{ }
+};
+
+U_BOOT_DRIVER(efi_bootdev) = {
+	.name		= "efi_bootdev",
+	.id		= UCLASS_BOOTDEV,
+	.ops		= &efi_bootdev_ops,
+	.bind		= efi_bootdev_bind,
+	.of_match	= efi_bootdev_ids,
+};
+
 U_BOOT_DRIVER(efi_block) = {
 	.name		= "efi_block",
 	.id		= UCLASS_BLK,
@@ -103,6 +129,10 @@ static int efi_media_bind(struct udevice *dev)
 	blk_plat = dev_get_plat(blk);
 	blk_plat->blkio = plat->blkio;
 
+	ret = bootdev_setup_for_sibling_blk(blk, "efi_bootdev");
+	if (ret)
+		return log_msg_ret("emb", ret);
+
 	return 0;
 }
 
-- 
2.43.0

