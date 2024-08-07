Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE29AC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 22:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5B2888B54;
	Thu,  8 Aug 2024 00:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G/qoNLmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 976A688B21; Thu,  8 Aug 2024 00:48:20 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E52A888F8
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 00:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-81fad534a04so16436939f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723070897; x=1723675697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdailVy+8zumTOAYzd1EqJOtPkOB1qAptMu3B5++GOY=;
 b=G/qoNLmmzDQUYxa+n/9XdCCL4nH2ytZ/j/96aFYIs3sfwO/61ytmG9Gq37DQo8uK3H
 qZ+8np/YelNIsdhELg7VZQAybBwVlgq3DbNlB82i2eZA8T1Xzgrl3jB4BkpK34JgAM31
 KmNffOaPlmeJnBd0DA7Nc8neSp4rtiE2JQKFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723070897; x=1723675697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdailVy+8zumTOAYzd1EqJOtPkOB1qAptMu3B5++GOY=;
 b=QJOLwvtu7yuA2Vm0SqCXuit4vGRA/7+9bAOFt8riNtEzB6afBhHqVeK5B7ZounNZUi
 VzzkD/s+nzQdnTW3ptc9ml0cb5F9XLJ7ZdM8elJIZBvZIkhbwYqfLFwuVDq9BqkhUhmt
 86eo+Jo6do6yh2hAWnPdQDjnvHEdxl6/zaCIKMxvATOnInugfM3iRo1/nPecodP6tK0p
 I1/azRPcuZCVMUD6Pv456tjhzAVkSoYN98WX1/KaRGqgP7XGfgSPvcWSNE3iCAkD6hmS
 evF2jXdBna4vDOIwb3qbzg8s7uNWMOFRT56Rb6XdthUdW7xTKwTmrDYNCClMRB9THa7L
 6Jvg==
X-Gm-Message-State: AOJu0YxpGnVfCSqWo/L/gOx37m0LRDWVh0qWuop1mUS/wIKP/dfRRjNV
 nx1mRKTNeCXkZsCHWNju6fsvQa65aKdVgUht4yFzIbYPl5oxR6QB6JksRUszk9XCX3HLzbEZLUc
 =
X-Google-Smtp-Source: AGHT+IGJXpm8v0nwy68XJwb2litiviaaNJvGTBF2bDcb7vkG8RGgQeCFEG753y/4ozpgTsAwmCG6hQ==
X-Received: by 2002:a05:6e02:1807:b0:39b:4ec2:c5c1 with SMTP id
 e9e14a558f8ab-39b5ed0cde2mr902025ab.18.1723070896847; 
 Wed, 07 Aug 2024 15:48:16 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20af1528sm48275205ab.80.2024.08.07.15.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 15:48:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 15/21] spl: Plumb in the Universal Payload handoff
Date: Wed,  7 Aug 2024 16:47:33 -0600
Message-Id: <20240807224739.3858517-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807224739.3858517-1-sjg@chromium.org>
References: <20240807224739.3858517-1-sjg@chromium.org>
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
- Add a runtime flag to enable UPL
- Hang when something goes wrong, to avoid a broken boot
- Put upl_image() calls in a common place

 boot/image-fit.c                  | 3 +++
 common/spl/spl.c                  | 8 ++++++++
 common/spl/spl_fit.c              | 8 ++++++++
 include/asm-generic/global_data.h | 4 ++++
 4 files changed, 23 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 9253f81fff5..7d56f0b5e6e 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -36,6 +36,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
+#include <upl.h>
 #include <u-boot/crc.h>
 
 /*****************************************************************************/
@@ -2294,6 +2295,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_LOAD);
 
+	upl_add_image(fit, noffset, load, len);
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
index 527a5691ac6..1ad5a69d807 100644
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
@@ -336,6 +337,8 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			image_info->entry_point = FDT_ERROR;
 	}
 
+	upl_add_image(fit, node, load_addr, length);
+
 	return 0;
 }
 
@@ -847,6 +850,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 		spl_image->entry_point = spl_image->load_addr;
 
 	spl_image->flags |= SPL_FIT_FOUND;
+	upl_set_fit_info(map_to_sysmem(ctx.fit), ctx.conf_node,
+			 spl_image->entry_point);
 
 	return 0;
 }
@@ -943,5 +948,8 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
 	}
 	spl_image->flags |= SPL_FIT_FOUND;
 
+	upl_set_fit_info(map_to_sysmem(header), conf_noffset,
+			 spl_image->entry_point);
+
 	return 0;
 }
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 94d054ee54e..19c66e1fe5d 100644
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

