Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8CDEC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A0086B19;
	Thu,  7 Sep 2023 17:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IZOvEWK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED12186A82; Thu,  7 Sep 2023 17:59:54 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57D386A4B
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34ca2fcdf9fso4596495ab.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102390; x=1694707190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aR6/Tltza0UPaHtMUyuss531V93lIyPJZPa7rL323sQ=;
 b=IZOvEWK0QnycK6WXmJIUow0lsRtnDyEwCnvecz/+fsp4YYtRgnOKUuRBiqwaD9qmM2
 CAr8rnT7pVrk7t3TVyy7kFFAVbkH/afeUHmn+ZM/iUCFcNsqOwimENWrsgZZcKzl876S
 2ic4hauXpA92PfhqAm6VggBhZ3jwpJEq1rOF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102390; x=1694707190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aR6/Tltza0UPaHtMUyuss531V93lIyPJZPa7rL323sQ=;
 b=QR4EPIB1dhINeAd2zyO4YOYOXwAV8foF7ZnVaF+jo2G6zWMyNsrpFmMUBRrG0Nx9lW
 04HOgjU/7+LFyb1Tp5bu0OD2sk81ZBWe3KLma30WloDA18WjK2isvd2xFZmw+8jkGeA1
 A6gPgRQBeB2Q+yxjZ2Pr95aau6NDkXhc2sPMFGeAmAs5LL0iAhrmRo5RQhgZcKvLXHWJ
 Y7XcMepCFlN94SSzuCzHinlHADZ6SuAf2m56M7dRBn3qnRqT3t0kEh9Zgoy7eOHY9IPd
 JVKHyikAo4BUH268jFhNzs+kvyt53byPihNYLkr42lwc75aRIKMVc5wmTo6RCt38Y4JH
 FZ6A==
X-Gm-Message-State: AOJu0YylliWGWt8HzsuT4BWNVojwemIZg4GdwyJH3r6a9MG1u/fNPbIh
 EyhRQVu+vIzcAJjP1hN1ZXnh7mEXUxswneTPPi0=
X-Google-Smtp-Source: AGHT+IEpDxE98p7J+kBs2aPYZs+E7rKG1ZpZ3wHV+g3Fw8BtSBcM6jk1RXShXtQTpgGp9/DJe4dEuA==
X-Received: by 2002:a05:6e02:1c41:b0:349:9af9:d412 with SMTP id
 d1-20020a056e021c4100b003499af9d412mr223938ilg.0.1694102390347; 
 Thu, 07 Sep 2023 08:59:50 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 13/22] spl: Tidy up load address in spl_ram
Date: Thu,  7 Sep 2023 09:59:18 -0600
Message-ID: <20230907155933.48511-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

This CONFIG is used but is not given a value by some boards. Use
a default value of 0 explicitly, rather than relying on the 0 value
provided by CONFIG_SPL_LOAD_FIT_ADDRESS

This will allow us to make SPL_LOAD_FIT_ADDRESS depend on SPL_LOAD_FIT
as it should.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl_ram.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 93cf420d810a..4158ed1c32d7 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -20,12 +20,16 @@
 static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
 {
-	ulong addr;
+	ulong addr = 0;
 
 	debug("%s: sector %lx, count %lx, buf %lx\n",
 	      __func__, sector, count, (ulong)buf);
 
-	addr = (ulong)CONFIG_SPL_LOAD_FIT_ADDRESS + sector;
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
+		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
+				      CONFIG_SPL_LOAD_FIT_ADDRESS);
+	}
+	addr += sector;
 	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD))
 		addr += image_load_offset;
 
@@ -38,20 +42,23 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
 	struct legacy_img_hdr *header;
+	ulong addr = 0;
 	int ret;
 
-	header = (struct legacy_img_hdr *)CONFIG_SPL_LOAD_FIT_ADDRESS;
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT)) {
+		addr = IF_ENABLED_INT(CONFIG_SPL_LOAD_FIT,
+				      CONFIG_SPL_LOAD_FIT_ADDRESS);
+	}
 
 	if (CONFIG_IS_ENABLED(IMAGE_PRE_LOAD)) {
-		unsigned long addr = (unsigned long)header;
 		ret = image_pre_load(addr);
 
 		if (ret)
 			return ret;
 
 		addr += image_load_offset;
-		header = (struct legacy_img_hdr *)addr;
 	}
+	header = map_sysmem(addr, 0);
 
 #if CONFIG_IS_ENABLED(DFU)
 	if (bootdev->boot_device == BOOT_DEVICE_DFU)
@@ -84,7 +91,7 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 			u_boot_pos = (ulong)spl_get_load_buffer(-sizeof(*header),
 								sizeof(*header));
 		}
-		header = (struct legacy_img_hdr *)map_sysmem(u_boot_pos, 0);
+		header = map_sysmem(u_boot_pos, 0);
 
 		ret = spl_parse_image_header(spl_image, bootdev, header);
 	}
-- 
2.42.0.283.g2d96d420d3-goog

