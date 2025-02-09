Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95F3C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:16:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5836380BAA;
	Sun,  9 Feb 2025 22:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GQ0gjDTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBAD6809A5; Sun,  9 Feb 2025 22:15:40 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B80803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d146df0afeso15746925ab.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135737; x=1739740537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nL3BiFPnVkV52asiESoGn6WGwRJDqU76dxSZ+d54tns=;
 b=GQ0gjDTtPYMQwq4oWt4MA7+ez6FSHcjjGloouDwgzp8xHrXYyTe/LkuELSom2Hgx3K
 NlRbBK0xFNUF5evCFvaXTMvlT1juaUDxPag+ix7lAeYBsEhecrIeUe/iw4t4hO/aqcCm
 IcmR+GKS37ctxkI8063FvU3SU9+mOIa+mE8+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135737; x=1739740537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nL3BiFPnVkV52asiESoGn6WGwRJDqU76dxSZ+d54tns=;
 b=M/FyKgmu5isjzJj1h/Nzm3O/LL+rX7VWtIIpbVBIqUMLrn+JPMlu11Y25339IsPYDY
 emEGk2oV7DFE8I/85Gh5vWMImI2sM4UHS4hdeyU1BVcldWmj8VM1KM/Pr0djZwClACDr
 RtPQSxC567GwHGpffVJBsw4sUMxwk3r/1A7NfIpcqBIlp80M34Uu8DRMn7yLqfWmKrW7
 qzCvQEI8EgTLQu1wJNyd8BdvFpP59hmVns4zPW2o/12UweWx5YaNcP1e43cEDAkMryQh
 va4m7dyF6plOTxr5jHL9McpCLPTyIqEp0yzcIj7SlAuxV+lu66mKyHdWErk+9S9dQmPY
 AMDA==
X-Gm-Message-State: AOJu0YwgSlqfTw14it7D+XsBCm2JjcKCtckNyriuQtvUtOyGYeWGEKrW
 pYAL+meG9swvq6jZd/RxDBH6t+Ud18naDesm72mZiamqVWDC/q2VONvX7Ih8kSTeyMNWPh1Qs9g
 =
X-Gm-Gg: ASbGncuOn1BxJD2lEWhbhA7PLcrpaVsoZFPJEJpcoNDXe6mLp6Frz4Kr5UH8Cil7jtZ
 huXoUWv0KyEk8OLANSBr8qpIQHb6e3X5gjrsMvUS64iAAdvr+WaxV5wbDJyWtbeVnUT4ujYKmaO
 VE+ZK3QZhWk38zsUGALcyeKgXzGH8onwxUH0jfnBn14P1XigLHe7MBCuP9oKQ6JYLjoRCLVZGLX
 Z9fOCVIcTL8t+s5vaf21FoDEI6qeoO9SKrtbSZKtu8WcUCilDVepHofnyd5gSMNBuLU8/EoQUw1
 mXRp0xQJvjFpYNGkoQbAugn3HqHc29z7zHJmP4Kpu7EzxfiOmkJ9
X-Google-Smtp-Source: AGHT+IEQ4rjhs0jzYjk9eYvVRE2nuyhxAC/iVNq84OCPzgYxeLa1xL6+aYfPkwj2w5gccKjsEpuvyw==
X-Received: by 2002:a05:6e02:b23:b0:3d0:237e:c29c with SMTP id
 e9e14a558f8ab-3d13dd5e8cdmr95993195ab.12.1739135736870; 
 Sun, 09 Feb 2025 13:15:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/35] vbe: Show the margin when using SPL_RELOC
Date: Sun,  9 Feb 2025 14:14:28 -0700
Message-ID: <20250209211502.2299245-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

