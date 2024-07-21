Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A27AC3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17173885A8;
	Sun, 21 Jul 2024 12:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YGx3p5nw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8938088464; Sun, 21 Jul 2024 12:10:11 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4869C87DEA
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42795086628so23155905e9.3
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556607; x=1722161407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmLlbJwCCZB/5EvQ5ochur3SVGPaQKOuGnol8FHQ1Lk=;
 b=YGx3p5nwGdqXFPpIyRgUhzWIhfdXxZdcqUY1MqQ5wq1m4ByDCg2l/pRLFuAVIVfVWJ
 YsQ7L2fozxQCIrf0AjfJBPilpLwPQgsK02vZyeGjFSEIx+bjiaN6WMta5HyR2qdTZ08j
 hPBLQwhkaUqMAUKWG0TGwE+qY8WGYPuifYK2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556607; x=1722161407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmLlbJwCCZB/5EvQ5ochur3SVGPaQKOuGnol8FHQ1Lk=;
 b=UNBHIxWFvKqDNWubYqL9qOLu/c+UCwecp1O7jnHtpxJiwAGftyNp9fDVu14xU/y1NE
 hjw3E2RqJbYz8GuDEG+jcATR5ziGKec3v2Q7EZl70zeCr2zuhxcWEagSPFPe+l80erjo
 RvdBj+HHPEZfOEqEUQoFXfC7f9duQyJ4LiohZcvuDhwfsS3TTQFCav8twrY1QQe9BBI+
 dc1un+ItJlzRv21AwgegLor7ArTzk5oRXWr6p/xybZBXRstz+Me0wbY0/EhwjRFpAziI
 7PKFl9kGpSmSwoa8HLzoL/W7hikSZNcad2FJgLMknJ+YteaSMhTYJr4yoVUMv1dTy+zH
 bpVQ==
X-Gm-Message-State: AOJu0YymlnLIkJOYebLULx4zJaXcLjJL12YaDojBZCSOjeszQ5JC12Eo
 GglRN/ap7o4nCzMTihoJBx4ZgUF96wlwSfBek3c+lhmGAOynwDIwpk54mOsOogHPkbx79Ss3/Xo
 =
X-Google-Smtp-Source: AGHT+IFCvKhW5lKV0OObfKIGFJJyFf+kz3Xoj78J0JahbtKXc8OCPOhddrG9a9PPzcxHQqk8fC1d9g==
X-Received: by 2002:a05:600c:474f:b0:427:dae6:8416 with SMTP id
 5b1f17b1804b1-427dc5865ecmr19050495e9.36.1721556607362; 
 Sun, 21 Jul 2024 03:10:07 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:10:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 15/21] spl: Plumb in the Universal Payload handoff
Date: Sun, 21 Jul 2024 11:09:33 +0100
Message-Id: <20240721100940.3202027-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

Specify the FIT and include information about each loaded image, as
required by the UPL handoff.

Write the UPL handoff into the bloblist before jumping to the next phase.

Control this using a runtime flag to avoid conflicting with other
handoff mechanisms.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Hang when something goes wrong, to avoid a broken boot
- Add a runtime flag to enable UPL
- Put upl_image() calls in a common place

 boot/image-fit.c                  | 4 ++++
 common/spl/spl.c                  | 8 ++++++++
 common/spl/spl_fit.c              | 9 +++++++++
 include/asm-generic/global_data.h | 4 ++++
 4 files changed, 25 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 9253f81fff5..c38ccd6754f 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -36,6 +36,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
+#include <upl.h>
 #include <u-boot/crc.h>
 
 /*****************************************************************************/
@@ -2294,6 +2295,9 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_LOAD);
 
+	upl_add_image(noffset, load, len,
+		      fdt_getprop(fit, noffset, FIT_DESC_PROP, NULL));
+
 	*datap = load;
 	*lenp = len;
 	if (fit_unamep)
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 7794ddccade..d6a364de6ee 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -810,6 +810,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			printf(SPL_TPL_PROMPT
 			       "SPL hand-off write failed (err=%d)\n", ret);
 	}
+	if (CONFIG_IS_ENABLED(UPL_OUT) && (gd->flags & GD_FLG_UPL)) {
+		ret = spl_write_upl_handoff(&spl_image);
+		if (ret) {
+			printf(SPL_TPL_PROMPT
+			       "UPL hand-off write failed (err=%d)\n", ret);
+			hang();
+		}
+	}
 	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_finish();
 		if (ret)
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 527a5691ac6..03a2ad4ebe7 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -12,6 +12,7 @@
 #include <memalign.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <upl.h>
 #include <sysinfo.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
@@ -336,6 +337,9 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			image_info->entry_point = FDT_ERROR;
 	}
 
+	upl_add_image(node, load_addr, length,
+		      fdt_getprop(fit, node, FIT_DESC_PROP, NULL));
+
 	return 0;
 }
 
@@ -847,6 +851,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		spl_image->entry_point = spl_image->load_addr;
 
 	spl_image->flags |= SPL_FIT_FOUND;
+	upl_set_fit_info(map_to_sysmem(ctx.fit), ctx.conf_node,
+			 spl_image->entry_point);
 
 	return 0;
 }
@@ -943,5 +949,8 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	}
 	spl_image->flags |= SPL_FIT_FOUND;
 
+	upl_set_fit_info(map_to_sysmem(header), conf_noffset,
+			 spl_image->entry_point);
+
 	return 0;
 }
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 98d822530d8..37643a4bbb9 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -716,6 +716,10 @@ enum gd_flags {
 	 * @GD_FLG_HUSH_MODERN_PARSER: Use hush 2021 parser.
 	 */
 	GD_FLG_HUSH_MODERN_PARSER = 0x2000000,
+	/**
+	 * @GD_FLG_UPL: Read/write a Universal Payload (UPL) handoff
+	 */
+	GD_FLG_UPL = 0x4000000,
 };
 
 #endif /* __ASSEMBLY__ */
-- 
2.34.1

