Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1A7C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097A586AA5;
	Thu, 24 Aug 2023 21:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mbdgq0jv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB95886900; Thu, 24 Aug 2023 21:59:45 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44F6F86A67
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79231457b7fso7433839f.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907181; x=1693511981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AJ5gtItTHLDlgFTYIlBil5hekrUHTIwUueXkzT1j7Ps=;
 b=Mbdgq0jvayMyPZl0+XuDzHEI3qzQrDnY1PNC5jqx7yhWoMn6YvtzlcmeyGLnuWeSSm
 z2H6V3YJx2E/ZvHO+hS9jp5xlZ4O67pfrQ/ATipp7fXEODozEAzuu+UGTGNzOVc2qHaQ
 QZucgfCPbyX9mxDJmoDhVWDTjIh+Ltkue0ZPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907181; x=1693511981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AJ5gtItTHLDlgFTYIlBil5hekrUHTIwUueXkzT1j7Ps=;
 b=Th7GVDF2DbUbI2WFDGXZTE0F+hk3dkrHwfZSdqB+Dsyz7nUkO4sDE1xJLkwRKld01i
 pmVb4904lN0Yd6AwQljeiUxsitpOyAn4jpZbnLKY53QRfVQlfbreqBhbR0Q4225bjWQk
 DWbKNsKTEwQLAwWNtu/RHQTaXtq+NTOGIpwlAuke2E0KHnQORU6E44t4Sv9o4JVxgSq3
 0gYuBkGXtisk+df8ad3zerJP4jm6JIX60EoTgaE6X2+ZGnOhgExsnpmnqfrI4y5yDPIu
 MGMYXY+m82tohzYAEVFMa+kNBd2/W1UcWVes6VAoFdBAixWNYicPnV6Iz6koxfXZbaxs
 piPg==
X-Gm-Message-State: AOJu0YxEhVW1x5536GOROpbxcZWYDfa+gd/6g4ACLjDRe0lue05vPq5O
 YRSTbJ1zJNN5df91L7W3EMgmCLy3hepB37fltgY=
X-Google-Smtp-Source: AGHT+IFlZ0M4yU4Rl6B5l/STPYp7u/WBgDzyo4UDTocVfjeUMxXlbu2vkJ+9vWniWGqtE6MnuG3Pfw==
X-Received: by 2002:a5e:d716:0:b0:77e:249e:d84 with SMTP id
 v22-20020a5ed716000000b0077e249e0d84mr7435024iom.5.1692907180988; 
 Thu, 24 Aug 2023 12:59:40 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Nikita Shubin <n.shubin@yadro.com>, Stefan Roese <sr@denx.de>
Subject: [PATCH 14/19] spl: Tidy up load address in spl_ram
Date: Thu, 24 Aug 2023 13:59:05 -0600
Message-ID: <20230824195917.1687886-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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
2.42.0.rc1.204.g551eb34607-goog

