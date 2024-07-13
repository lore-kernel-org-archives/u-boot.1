Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C8CC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D2E88852;
	Sat, 13 Jul 2024 09:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oQ6Vq2JN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCC7488851; Sat, 13 Jul 2024 09:03:58 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863668855E
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266b1f1b21so17743345e9.1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854235; x=1721459035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HO0eh08uvLAnXaoNZ/cm+mcHYY7bBVkf5wIO3KM+xD4=;
 b=oQ6Vq2JNfj5G6AwvlpKASj8ONc6vo69mNAZpaXsADm/2JpbmlRRUQYJg53q2lVau1Y
 Hg8LDV0iTF0CO6SZZ1r9b3PKheTu+F4jVZKu1lfhLaiJnL5nSRYFyktGlhYHSmCd7M/S
 P9qK6yeSeIftR0P8b9bhKsjBqRlxts4IAmwtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854235; x=1721459035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HO0eh08uvLAnXaoNZ/cm+mcHYY7bBVkf5wIO3KM+xD4=;
 b=DO4qn7uO9ndCvuO1tPK6CFA6QRWPL8yDqW0USWeLr9QuOGLMNNEuI6rNbgs3UK/VqF
 e15ozGDihywqOteXtz10AQg7dIga3iCKLZPTihvxXSkrRAoToOO57u5O6gNUWIftSpQJ
 Mnm1vqZVfOvLoiqrIWB39pEBCruYGGxiXDcCdLrbnrHFQGbrCeE6eKoNziRuqt6ar2br
 fjgFXIlk2gGIapDRpKPpYPwERXYSHaVV6GhlYu1gPWcTQuCByBbNdJa0bUHxIUPJVU+V
 6jtptWLClpRqqpwoI6eM3SZaKaYgrOJHh+BSMxHxqeN0fIwykATFTfUWQy6XEjwLxLx3
 IU3w==
X-Gm-Message-State: AOJu0YzaQ8tv15Fql/VcJh/mY6pqZwZKOK2IGIRXeFbocwoMj3yQkHdH
 eK+L3VQmlGjbm0YJD2+ZSYLEYo5Np9pEZgOpclGzCynf/llmiog6QB0rnPDjErpjxSwsRlDHhGI
 =
X-Google-Smtp-Source: AGHT+IHmC7KeKY53woNoBIGSVMhD2bqAeioXEL5pxhyZu8bkfPI55vLFEHNuTRkqlqJYE7zB04WRgw==
X-Received: by 2002:a05:600c:22d8:b0:426:5fe1:ec7a with SMTP id
 5b1f17b1804b1-426708f1dbfmr85444685e9.31.1720854234829; 
 Sat, 13 Jul 2024 00:03:54 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v2 15/21] spl: Plumb in the Universal Payload handoff
Date: Sat, 13 Jul 2024 08:00:49 +0100
Message-Id: <20240713070055.2172883-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

Changes in v2:
- Hang when something goes wrong, to avoid a broken boot
- Add a runtime flag to enable UPL

 common/spl/spl.c                  |  8 ++++++++
 common/spl/spl_fit.c              | 22 ++++++++++++++++++++++
 include/asm-generic/global_data.h |  4 ++++
 3 files changed, 34 insertions(+)

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
index 2a097f4464c..b288f675ae3 100644
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
@@ -645,6 +646,8 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 		printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
 		return ret;
 	}
+	upl_add_image(node, fpga_image.load_addr, fpga_image.size,
+		      fdt_getprop(ctx->fit, node, FIT_DESC_PROP, NULL));
 
 	return spl_fit_upload_fpga(ctx, node, &fpga_image);
 }
@@ -768,6 +771,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	if (ret)
 		return ret;
 
+	upl_add_image(node, spl_image->load_addr, spl_image->size,
+		      fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
+
 	/*
 	 * For backward compatibility, we treat the first node that is
 	 * as a U-Boot image, if no OS-type has been declared.
@@ -811,6 +817,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			       __func__, index, ret);
 			return ret;
 		}
+		upl_add_image(node, image_info.load_addr, image_info.size,
+			      fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
 
 		if (spl_fit_image_is_fpga(ctx.fit, node))
 			spl_fit_upload_fpga(&ctx, node, &image_info);
@@ -847,6 +855,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		spl_image->entry_point = spl_image->load_addr;
 
 	spl_image->flags |= SPL_FIT_FOUND;
+	upl_set_fit_info(map_to_sysmem(ctx.fit), ctx.conf_node,
+			 spl_image->entry_point);
 
 	return 0;
 }
@@ -891,6 +901,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	if (ret < 0)
 		return ret;
 
+	upl_add_image(ret, fw_data, fw_len,
+		      fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
+
 	spl_image->size = fw_len;
 	spl_image->load_addr = fw_data;
 	if (fit_image_get_entry(header, ret, &spl_image->entry_point))
@@ -911,6 +924,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	if (ret >= 0) {
 		spl_image->fdt_addr = (void *)dt_data;
 
+		upl_add_image(ret, dt_data, dt_len,
+		      fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
+
 		if (spl_image->os == IH_OS_U_BOOT) {
 			/* HACK: U-Boot expects FDT at a specific address */
 			fdt_hack = spl_image->load_addr + spl_image->size;
@@ -940,7 +956,13 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 				     &img_data, &img_len);
 		if (ret < 0)
 			return ret;
+		upl_add_image(ret, img_data, img_len,
+		      fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
 	}
 
+	spl_image->flags |= SPL_FIT_FOUND;
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

