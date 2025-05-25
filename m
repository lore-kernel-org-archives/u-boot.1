Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E1EC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 481FE82C84;
	Sun, 25 May 2025 12:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LkeG7gLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53BED82C13; Sun, 25 May 2025 12:48:15 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5789F82B53
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442ec3ce724so11065625e9.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170092; x=1748774892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPJlLfL9ED3hHDK4ycl9EY2VqcSS0gEp0vfDFhYakHQ=;
 b=LkeG7gLyaIwRERGbBz8gZnI2rx5XzxB6valZmAIiYKZ7RXFVsvTLJDGZdQTJaTi/PS
 G27DQh7yTcutN9B2NlCCkdDcXouTsDv1JV84R0R531bZdimzhJQzJYQjHsQIVWIJF88c
 5fAYCmCmoVyFosZCxbZCuetdY2ASpdW0qwRu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170092; x=1748774892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPJlLfL9ED3hHDK4ycl9EY2VqcSS0gEp0vfDFhYakHQ=;
 b=ElNAdO/S41Z+8or4/FjvxUQKhzHCuHaQKkc0wekuWwdgRz5lR4gpRr9uYUfmJ1f0TT
 8Ajcd8zyOP8NtdGQunTGEggg6fz+xIXm6rTBdUr+YMCz0Tgm43r0miU6J1LXVbY2WGSH
 HlsqIBK9VsmeUSFpKh13SgpGsbNFovmTjm9+FDfVBSVm63hOuVgDfKSZ4fc0QYZYXtpk
 1ep6y14gAlwP0JolXNWiAPqUzedSZxpJoI7l3OYPkbRNoaUxQbegCXH3NRHrtgAQGrv/
 lc26y5Rd1yolG4Av8Uy34p4pIXP7zCbDb2mnXdiyVFVDNM8K1zLAvmk5R9hWEn3VJv0i
 XfRw==
X-Gm-Message-State: AOJu0Yw8rCedIK4nUOMbxobasrkY7chPUe/ot5N9SlyNKqLDiabdWUXQ
 rPatxM47TIpqkCGrbSVMw2R1ElZLkD4dnyU5brY4bCKjqxs5HwxvBv0s0/vb35cYk18JYbkYO99
 7E61sanD0
X-Gm-Gg: ASbGncu6jtckIPqyZs5hbNODhWawkYhAT4nQh3fh/lr9q/UUfWYS1jAPZZtt/VBBc2z
 DC6nkvKUAZ/i4rBfSP277lQLs5jX1QcUcK/O/OCmY+QAxdJCfO8QIDrTuG+E9yuTteJlO+BghnT
 LEFLnjyYuJG2lSVcqvOncJyuDElvneL+jg1ZXCRPebTMHavFDL/IfjKlK1g8v+IbVh3yaWqtXO6
 X+oPOGvxPmc1gqwjjSNvgp1clEbYg+hKDAui9HzRTf36aQQPYAdE0NxCTzbOTqZC/x28hJw3F9L
 bdVbVxSZ1+v2BoJ8flGZbFqxeAbDmbO7eIxzqclNDZvo8iqyhaihsC12jsQJCsl26rbe8hI=
X-Google-Smtp-Source: AGHT+IGMOkWqtehGAPLWKOGWyaSvkKr0/ghQFccQUJzydXS7YD6f8pk1GkkKvk+6I3qgMxC1oOwtOA==
X-Received: by 2002:a05:600c:4e8a:b0:43c:f1b8:16ad with SMTP id
 5b1f17b1804b1-44c933f020dmr50600615e9.30.1748170092308; 
 Sun, 25 May 2025 03:48:12 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 03/25] vbe: Show the margin when using SPL_RELOC
Date: Sun, 25 May 2025 11:47:39 +0100
Message-Id: <20250525104801.1440260-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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
2.34.1

