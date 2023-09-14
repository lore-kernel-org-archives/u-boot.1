Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E86DEEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E78F5870B0;
	Thu, 14 Sep 2023 18:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R6k022hy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22BA87062; Thu, 14 Sep 2023 18:56:45 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7653870B2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34dee07e676so3621955ab.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710602; x=1695315402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38UvI0BudTmGT8JBfKY5dU4kpUH8yPPwbVpjmw6CTrQ=;
 b=R6k022hyjaaND9anxQqXg8MkYtK9mdCpaTiI46CBZq/wIje+fohvYnhvEJQIIJmAM5
 f11CJ+2IVwm6v1FA4Menej3LCWG2DbIeQKNoGIquDLVsMR9Xfp0gYBzSXHD9c+13uzaT
 q4dgOf2ufnxNa2Ne8jfLtM2RbesjIjgjXxkXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710602; x=1695315402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38UvI0BudTmGT8JBfKY5dU4kpUH8yPPwbVpjmw6CTrQ=;
 b=OZHMAP01jUpSBKH1BkFArd+uZwpRO1QFX4zNRpShaP5CcJ4KmE+BK5i9LvAMpxzqr9
 L8ossIeBRCjTpQ/eQfLxhIw+JUwLMvGM2fqBPM6frmVkCHS38GYVHirLBtyALWqcPMzj
 +wOtnHLyTBGya9x9J84bf2PvjP9kqF2Q5J/bd3aOfIn7oQuR/lWsM71103ySZ+GymJA1
 gkZwXBHJE5TTmiXvjCnSU3YfvHv99BCSp06YvBbLhDbya+neV6u+1KA2z5/MlWPlpg1n
 Ak1sLK/yHegnOLKoLsSe7dhCz6pydY7ze8bKsZA2LhdyBt3fEJtjaKaA/o8zrrUnf/Bq
 L9Fg==
X-Gm-Message-State: AOJu0Yw0t1s+E2Xrbn2UoIozJweWU7MDlYo9ECOy9Ww2IT0z5ep0rYNU
 5cOLJLDsLTFtQPrWUwIJIyVYH1HdtAUBnRSjmtg=
X-Google-Smtp-Source: AGHT+IGUccSaraZ9yXKI9uIgoY5fU9qAA9KFCUx28lq4R1ePeKbyNS41/KRfX36G8UZyQU9LjBV4Qw==
X-Received: by 2002:a05:6e02:c63:b0:34d:f0d4:c436 with SMTP id
 f3-20020a056e020c6300b0034df0d4c436mr5316128ilj.3.1694710602316; 
 Thu, 14 Sep 2023 09:56:42 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Nikita Shubin <n.shubin@yadro.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v5 12/21] spl: Tidy up load address in spl_ram
Date: Thu, 14 Sep 2023 10:55:50 -0600
Message-ID: <20230914165615.1058529-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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
index 93cf420d810..4158ed1c32d 100644
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
2.42.0.459.ge4e396fd5e-goog

