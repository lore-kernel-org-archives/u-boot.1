Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CE3C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:44:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C90B0869BC;
	Mon,  4 Sep 2023 16:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b9bXasFE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57BB3869E2; Mon,  4 Sep 2023 16:41:58 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 985CB869E9
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34b4b2608e3so5507645ab.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838514; x=1694443314; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aR6/Tltza0UPaHtMUyuss531V93lIyPJZPa7rL323sQ=;
 b=b9bXasFEoL6LxmO3E1XPkNC7WO+EXQPpX4/awA8RFr9tjYjmUlYe/n4sUcNJKupnQY
 uXtfsK804AscJUUdRLKRouUAxB73A8YnNixqGbxwSPqIHRY/FV9pFxWvN88BN7jDFAYL
 IL9jm82MhOwpwTt4H4vMQU1zgEYzrGC/CSIsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838514; x=1694443314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aR6/Tltza0UPaHtMUyuss531V93lIyPJZPa7rL323sQ=;
 b=T+EojBK8/L9yfbuTDxYIVIaq/lcogFgvepAfve53z3Qjn+ng9pJnsWP2oCqiGguLjS
 ucdnwqAANg5kCwQDH1GnBsmrczHj2LLwDCjoAibGXJ+qOOX4BjSVd/JYKntqrrLI47tP
 uKdjfZUnXv7xF6sohNGf7UT7NNWLsCqQIpfmc0OD+3yQX2LmJR5BNy1w/ZXxkk5T9IJJ
 2QHKd81iRLSb1j2fZBu9G+kIF8cIFDkQIKZLCpYlMRgxw8X9/H33D1bBGaenddhe/rNG
 arGB2HU+N4+y9ayl+vA0vUfJCjk8yEJgvz1NzkI/Jxy53lUa8eJ7S2x2RQM0iHQpztk6
 OYIg==
X-Gm-Message-State: AOJu0YxaZ394g+RXaW2GBUzwdrAFUDe5jxCwPslU/pyv9zf39pnVE2vk
 7aRj7Ngv46TTY3tGNLkBxTAB0m7wp/CJeE2tJo4=
X-Google-Smtp-Source: AGHT+IEp1r3ymLA6DrDtr7FuZwooSXJ3XMXpSzTL9Mv6OScNvv5HjGfK4Pm+e1QmzL5rp9BxeHjODg==
X-Received: by 2002:a92:c261:0:b0:349:862e:a863 with SMTP id
 h1-20020a92c261000000b00349862ea863mr13361407ild.15.1693838514320; 
 Mon, 04 Sep 2023 07:41:54 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 14/20] spl: Tidy up load address in spl_ram
Date: Mon,  4 Sep 2023 08:41:17 -0600
Message-ID: <20230904144131.2699824-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

