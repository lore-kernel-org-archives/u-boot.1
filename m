Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C31C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD4586553;
	Thu, 31 Aug 2023 01:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nwC9s4cE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A9286586; Thu, 31 Aug 2023 01:30:11 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167F78652B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso11389339f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693438205; x=1694043005; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96FF+qgeVQJLOVNFsGL4Cg3ta7KpGyCbfLWFoLLdV6M=;
 b=nwC9s4cE35+zxucJYWfGVSSgeHpiDvMp2mmwvtHQ/09Un/X0Km7rrFjjltFiAZnTEN
 nFjsL+E4wCt7daXEtExHGZMrmX5BmkkJAOaquEk1VamSkesTAPCIlMPQl+OJ4J6dOs+6
 wUATo2X8JrWPeB80eT4QMXk2HJHdK9QLNx0Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438205; x=1694043005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96FF+qgeVQJLOVNFsGL4Cg3ta7KpGyCbfLWFoLLdV6M=;
 b=HSIyP24329laJ4boEP1vWdF1DeoDDffw6pMNKMeMCwbS7ydKvE1qYiZewl6vGPGhDa
 Tjcrwz5te+iq3OG1+NELH8STu2PrOnezxTaYcesCQA4Kq+7uEdYijxr5En0rNAnGvh/f
 OOrH2jHUEcPMvR3tg4T4Rn/wX1bnrDRz5bMB46bkarwa4coz7kcU4Xnx389gPOjCIJVh
 XD9i2Gc6IaCkP8MAf4a+SSCSPgV5qAzyoz2eJc3spq3Mg+drEWpEJIlLkX/Fz9ECxAO7
 Yzl6wsYhw7rHNC/UMP91dTuDJ6FS69aj8m6ZmurRMqWQ9w39zsiJwKpqU/U5rjqApiKn
 Npfw==
X-Gm-Message-State: AOJu0YyzjkXV7Kp39ogaE0zX67DuRrtaiUE3aZyYy4YBfuhk5Mg2+sjJ
 P+em7PRgXDKb++nJte1UcyNxyPmeL5GMpbu/z5M=
X-Google-Smtp-Source: AGHT+IFHvMUw1Cr3FwTkL2zxP/swz44x/VVEELC0AHbjuWN2LX2bwNkFBX8XUpSxgP6QeXg/3l+ZGA==
X-Received: by 2002:a6b:dc03:0:b0:794:eaef:f43e with SMTP id
 s3-20020a6bdc03000000b00794eaeff43emr4126186ioc.1.1693438205689; 
 Wed, 30 Aug 2023 16:30:05 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dj14-20020a056602256e00b0077e35ffac2fsm78512iob.32.2023.08.30.16.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:30:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 6/9] spl: Plumb in the Universal Payload handoff
Date: Wed, 30 Aug 2023 17:29:20 -0600
Message-ID: <20230830232928.2590178-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830232928.2590178-1-sjg@chromium.org>
References: <20230830232928.2590178-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c     |  6 ++++++
 common/spl/spl_fit.c | 22 ++++++++++++++++++++++
 include/spl.h        | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 0a9fea4f22d..1bfefaafd93 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -792,6 +792,12 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 			printf(SPL_TPL_PROMPT
 			       "SPL hand-off write failed (err=%d)\n", ret);
 	}
+	if (CONFIG_IS_ENABLED(UPL_OUT)) {
+		ret = spl_write_upl_handoff(&spl_image);
+		if (ret)
+			printf(SPL_TPL_PROMPT
+			       "UPL hand-off write failed (err=%d)\n", ret);
+	}
 	if (CONFIG_IS_ENABLED(BLOBLIST)) {
 		ret = bloblist_finish();
 		if (ret)
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 03ff9a5db9a..89b5f624340 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -13,6 +13,7 @@
 #include <memalign.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <upl.h>
 #include <sysinfo.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
@@ -621,6 +622,8 @@ static int spl_fit_load_fpga(struct spl_fit_info *ctx,
 		printf("%s: Cannot load the FPGA: %i\n", __func__, ret);
 		return ret;
 	}
+	upl_add_image(node, fpga_image.load_addr, fpga_image.size,
+		      fdt_getprop(ctx->fit, node, FIT_DESC_PROP, NULL));
 
 	return spl_fit_upload_fpga(ctx, node, &fpga_image);
 }
@@ -745,6 +748,9 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	if (ret)
 		return ret;
 
+	upl_add_image(node, spl_image->load_addr, spl_image->size,
+		      fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
+
 	/*
 	 * For backward compatibility, we treat the first node that is
 	 * as a U-Boot image, if no OS-type has been declared.
@@ -788,6 +794,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			       __func__, index, ret);
 			return ret;
 		}
+		upl_add_image(node, image_info.load_addr, image_info.size,
+			      fdt_getprop(ctx.fit, node, FIT_DESC_PROP, NULL));
 
 		if (spl_fit_image_is_fpga(ctx.fit, node))
 			spl_fit_upload_fpga(&ctx, node, &image_info);
@@ -824,6 +832,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		spl_image->entry_point = spl_image->load_addr;
 
 	spl_image->flags |= SPL_FIT_FOUND;
+	upl_set_fit_info(map_to_sysmem(ctx.fit), ctx.conf_node,
+			 spl_image->entry_point);
 
 	return 0;
 }
@@ -868,6 +878,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	if (ret < 0)
 		return ret;
 
+	upl_add_image(ret, fw_data, fw_len,
+		      fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
+
 	spl_image->size = fw_len;
 	spl_image->entry_point = fw_data;
 	spl_image->load_addr = fw_data;
@@ -887,6 +900,9 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	if (ret >= 0) {
 		spl_image->fdt_addr = (void *)dt_data;
 
+		upl_add_image(ret, dt_data, dt_len,
+		      fdt_getprop((void *)header, ret, FIT_DESC_PROP, NULL));
+
 		if (spl_image->os == IH_OS_U_BOOT) {
 			/* HACK: U-Boot expects FDT at a specific address */
 			fdt_hack = spl_image->load_addr + spl_image->size;
@@ -916,7 +932,13 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
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
diff --git a/include/spl.h b/include/spl.h
index e958ace2cc6..ed51e6c862d 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -250,6 +250,9 @@ struct spl_image_info {
 	uintptr_t entry_point;
 #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
 	void *fdt_addr;
+#endif
+#if CONFIG_IS_ENABLED(UPL)
+	int conf_node;		/* FDT offset to selected configuration node */
 #endif
 	u32 boot_device;
 	u32 offset;
@@ -921,4 +924,12 @@ void spl_save_restore_data(void);
 int spl_load_fit_image(struct spl_image_info *spl_image,
 		       const struct legacy_img_hdr *header);
 
+/**
+ * spl_write_upl_handoff() - Write a Universal Payload hand-off structure
+ *
+ * @spl_image: Information about the image being booted
+ * Return: 0 if OK, -ve on error
+ */
+int spl_write_upl_handoff(struct spl_image_info *spl_image);
+
 #endif
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

