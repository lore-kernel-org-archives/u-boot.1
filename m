Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648ECC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4650786660;
	Thu, 31 Aug 2023 05:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GsJVTwfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F1A86584; Thu, 31 Aug 2023 05:53:45 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32078658D
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-44d58933a17so224731137.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454021; x=1694058821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brfd6J1tt1YFoZBmdGG5qXRMIoy6uqi+wB95w0Jvp4s=;
 b=GsJVTwfarE4ygCOZA2kqLpzfwAg39G0GDIv3GMXgaM/n+ZsqYdboLQphTIozHqHzut
 m+Kh6vS8622iIWj9N8ktgwQ4xEN1L0l+9TUApyXP3UWHd1+I0bDQ4Ctdh1qc7621+xsF
 Ql4Wbg67nZaBpdxTpJXOidLXw0ScUqx+4WViw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454021; x=1694058821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brfd6J1tt1YFoZBmdGG5qXRMIoy6uqi+wB95w0Jvp4s=;
 b=glfbUABjDcUQLrtNonhknZrJJN7imndmSqJdjNwx1OLnZaL7SvA/K7CutEAZPRS2m9
 pOB2Z9fC6UrHp2OM9Kln9P2Kh7Ed7B2U+/VC3q36pEUVJN+Zb67irnRnDrD0IZq7ixHz
 XggrfTjsJ0M44uRUIhQIGdafkkeAVvKr3tqbLPZIj0eEeSub5dbqBPCalhg3qkvBeFN/
 spMZh139W8YpqHThgGUAyaie9uy2tLpasVBccPpgIr77WlJSBVTbmAe2BE5vL3COod+E
 gzPPGtyXbDTU6JEJX/PiW8EedSEVCYtM3Dz06HKzV9WzIwycGFYD/sFEv/yvhopCcfX3
 AF0g==
X-Gm-Message-State: AOJu0YwJM3c4kT8+7+o3rkgOE57fuqmVtReq56QIGSy/S2mC6rVYffF+
 i3S1bWeN9PPNuhmKzFkp23GMWCjD4qECjGpMEps=
X-Google-Smtp-Source: AGHT+IFIf2YjdlqIUkcet+/Ek290Ef22W5Kl8Lh5eyPrkPsIh93O7OY3AqVa/SNtCue7fPPllOKtdw==
X-Received: by 2002:a67:b30d:0:b0:44d:590d:28a6 with SMTP id
 a13-20020a67b30d000000b0044d590d28a6mr4113220vsm.27.1693454021418; 
 Wed, 30 Aug 2023 20:53:41 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 14/19] spl: Tidy up load address in spl_ram
Date: Wed, 30 Aug 2023 21:53:08 -0600
Message-ID: <20230831035319.2316665-15-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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
2.42.0.rc2.253.gd59a3bf2b4-goog

