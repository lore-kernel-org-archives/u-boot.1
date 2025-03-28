Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68D5C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:36:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 793FF81DED;
	Fri, 28 Mar 2025 16:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kSks99A+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B639809A5; Fri, 28 Mar 2025 16:35:47 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8D681E1C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-854a68f5a9cso184117339f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176142; x=1743780942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nL3BiFPnVkV52asiESoGn6WGwRJDqU76dxSZ+d54tns=;
 b=kSks99A+isZvqHly7FA7sNEywrkYaq+Sj5xxCqhc5TATLgbwOnJz+o6AEwvw8fEe0j
 Wfox7wsNRWyT4vIZQTnPLe4KWfiDJJQN4nJ/lNvEl5FPyoOoYpmTnBAbKHeLorKOPqc+
 WXHGazRewB5GXfymaVWQqoR4hfIXLtkcq/QpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176142; x=1743780942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nL3BiFPnVkV52asiESoGn6WGwRJDqU76dxSZ+d54tns=;
 b=XmvJW+RjbQ8ZXvX/xkmPUe+0lDav7L+Prns/TsYx+RAuAIRMejR6JG69kanHCBKRwF
 NuuFniQlO2XVjgSPNvNPMK0rhjxesdF3DM5zf7+YUcsTMswPlAJyf14Y/G6gFGLHqKU2
 7tbXSiNjfPvnEuCVJRTvE+Q2MA6JeTzRPT6JQ2v4XYTOv7cRz0wBXSwMEMQIwDJd1Q9Y
 v3OAJXUhD37e4yf4s6zbGOliBYuoJcfgvEwlvN8/YhCiAmK8rMkR9kIQXTHLviYNCqlX
 HHGB29UsJuzqyzrQKAZBwtDvbkEadqipmzuO0YAozkdYljmvpa22jtwkUBTM8AHJJpWH
 ETHA==
X-Gm-Message-State: AOJu0YxvRBczEXYrjoJtR6vdgaPmCIyyle/iTuZFE1rrMnaLx6kQGqf1
 gu982c4dWf6TimanSRhXiK/5TLZthnE7W3IoGtHWejnkn4AkIMxupUPxWUan80yGNZfBEfyxUPg
 =
X-Gm-Gg: ASbGncufn9ztNYY5/igODKD81NGRBWuMdNVHJvzXu7L71ej3DS3SPEG1z1dS2fionBU
 8N4yymaLZ9ahB0WFiWDjmHxwzwsBTVcZx9DjJD6ko8zEURNZdBvn1dDqZmLC66RCqEUEZgLS68t
 k8ygq+gfTNKSELyqWQub7SgmnGbDj8TAIGBtRCos3FhYWwNX3hiOjvam8ywwGrIwBNano1Klsi7
 QnHkYKI2zH5ftcr5PKYOPPzUO1/u20sMg9JTJbXtK8hYDJknB6u4fYmRL272b2FBubwkjPiEDUQ
 anulkZU2yH54JaJXql5s1VVH5DbDKQkS5O1UNze7/icAgAYVNmjwLwS7AkSG0HffDQR4y/B42HY
 YTEsCbA==
X-Google-Smtp-Source: AGHT+IGzmym7oqeshQxRck2IHWOkRetms75atbdBAuNJlKg/Ox91Ldw1mbF/ymctyabiheIkMLbnPg==
X-Received: by 2002:a05:6602:358c:b0:85b:3827:ecef with SMTP id
 ca18e2360f4ac-85e8217505fmr1015839939f.12.1743176141802; 
 Fri, 28 Mar 2025 08:35:41 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:35:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 03/31] vbe: Show the margin when using SPL_RELOC
Date: Fri, 28 Mar 2025 09:34:43 -0600
Message-ID: <20250328153522.3555472-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Collect information about the memory-margin in each phase which uses
this feature. Update the 'vbe state' command to show it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/vbe.c              |  8 ++++++--
 common/spl/spl_reloc.c | 12 ++++++++++++
 include/vbe.h          |  3 +++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/cmd/vbe.c b/cmd/vbe.c
index 186f6e6860d..02d224ad286 100644
--- a/cmd/vbe.c
+++ b/cmd/vbe.c
@@ -92,9 +92,13 @@ static int do_vbe_state(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	printf("Phases:");
 	for (i = PHASE_NONE; i < PHASE_COUNT; i++) {
-		if (handoff->phases & (1 << i))
-			printf(" %s", xpl_name(i));
+		if (handoff->phases & (1 << i)) {
+			int margin = handoff->reloc_margin[i];
 
+			printf(" %s", xpl_name(i));
+			if (margin)
+				printf(" (margin %x) ", margin);
+		}
 	}
 	if (!handoff->phases)
 		printf(" (none)");
diff --git a/common/spl/spl_reloc.c b/common/spl/spl_reloc.c
index 216c0f36623..6bfc75bc484 100644
--- a/common/spl/spl_reloc.c
+++ b/common/spl/spl_reloc.c
@@ -4,11 +4,13 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#include <bloblist.h>
 #include <gzip.h>
 #include <image.h>
 #include <log.h>
 #include <mapmem.h>
 #include <spl.h>
+#include <vbe.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -58,6 +60,16 @@ static int setup_layout(struct spl_image_info *image, ulong *addrp)
 	buf_size = rcode_base - base;
 	uint need_size = image->size + image->fdt_size;
 	margin = buf_size - need_size;
+
+	if (CONFIG_IS_ENABLED(BLOBLIST)) {
+		struct vbe_handoff *handoff;
+
+		handoff = bloblist_find(BLOBLISTT_VBE,
+					sizeof(struct vbe_handoff));
+		if (handoff)
+			handoff->reloc_margin[xpl_phase()] = margin;
+	}
+
 	log_debug("spl_reloc %s->%s: margin%s%lx limit %lx fdt_size %lx base %lx avail %x image %x fdt %lx need %x\n",
 		  xpl_name(xpl_phase()), xpl_name(xpl_phase() + 1),
 		  margin >= 0 ? " " : " -", abs(margin), limit, fdt_size, base,
diff --git a/include/vbe.h b/include/vbe.h
index 61bfa0e557d..84a996cdf7f 100644
--- a/include/vbe.h
+++ b/include/vbe.h
@@ -11,6 +11,7 @@
 #define __VBE_H
 
 #include <linux/types.h>
+#include <spl.h>
 
 /**
  * enum vbe_phase_t - current phase of VBE
@@ -47,12 +48,14 @@ enum vbe_pick_t {
  * @size: Size of the area containing the FIT
  * @phases: Indicates which phases used the VBE bootmeth (1 << PHASE_...)
  * @pick: Indicates which firmware pick was used (enum vbe_pick_t)
+ * @reloc_margin: Indicates the number of bytes of margin coming into this phase
  */
 struct vbe_handoff {
 	ulong offset;
 	ulong size;
 	u8 phases;
 	u8 pick;
+	int reloc_margin[PHASE_COUNT];
 };
 
 /**
-- 
2.43.0

