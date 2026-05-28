Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E047CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A489884671;
	Thu, 28 May 2026 19:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m5kRqq5Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1347846D1; Thu, 28 May 2026 19:11:05 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3CB984659
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7de7dc85b74so12048614a34.2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988262; x=1780593062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nL3BiFPnVkV52asiESoGn6WGwRJDqU76dxSZ+d54tns=;
 b=m5kRqq5ZmMYOfm5riz9EAuw59BywpUoqRkzVNwhzTKDdB3bZLLx7m15CRbux8gA+Lz
 UpH1J/sJqgMxEmw+9YaicEepFWbLXEdiG4wq3DUN8GnaXKorofRD4vCNCk3LJ/KXEHGy
 yqvQLsfw96wIldXfMgJotuY84Crsz3wm0XWks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988262; x=1780593062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nL3BiFPnVkV52asiESoGn6WGwRJDqU76dxSZ+d54tns=;
 b=A6x8jxruM1Ww7GmEOKbcbCil9ahoBa4eINhiMEbgvEDQk5tQwsyYo/M8EM+oxYl8XE
 p88TXoWkZmyAFlUPGIlfU+BXSOysUMJERUCjsShAmyt/AQB+CagX0uucH3XBAOgk+pD9
 mYj+eYlaMQP+3Cyx7TkjZ3kq+3A4Dt8iN0wKtKlZLsF9RGkqB5KC9B3VBRLznAuzDxeG
 Q1PIlkSWN85W9+H9m1nYp9FvEjjBotf7u+T8cO/nUHWzajQ0Xzsvoc7kWRUv94kAOI89
 pgH6X8i9BjHO28qWS98nqejj44cFTuJBkazBB0Hh3nm97IwjOqoL44ajz493TaBFnTX+
 nE5Q==
X-Gm-Message-State: AOJu0YzfByDDOUh/AeQ7DMEesGz2tPkdyyQK42HVJWPLc1CGuMs1lGGo
 JIrPBuy7L11whinJsTfTOi4/fyns3tLCfnJaRnIBuq1a1sKN5j4tXorkAhrSBa1RJ9I2AC/1keQ
 MmnCRZxauaco=
X-Gm-Gg: Acq92OEgJaclmwRVVHmDpa6BDtJz3lvJYWnYBNXKjUr7V11/LqWvA4KRxJkzJ4TBGUx
 /I6YrEoWGUvXhLK1PPjWieZPZY2K66SVY63O7yDxOZxG69VjjKmD+ABnOC1zOU9L35v3XSR/mmb
 4wCMkxX99feB6mBjUoipUPMjQsaK7ghZeS9GoRuMRenNLVrwgn1aJeXIK4NJEgFvtuDzWAj3XBK
 saXDJD/wlkEME0ys4wdFs3AIg3cIl8bZDbWre2jEz1QgUBzmgtjk1uZuGOnv65q/U9PD9J97jvG
 nLmzqtCxZ9COqJBTDy2kBB3fkCSXdEFsPEC1+oZSiCkbBxYVXIXsGKM5t0MAgU4i8KyTAlKI3v0
 IiSqDFyvJEOEv4xe04NloYCpKk5xyyRvvnSgicEjEGvf92fFN4f8Z716Moja9LxszSZZifqsqcx
 0hLV4RPP7+yTe9zeuqR7vdkDCzZbTU
X-Received: by 2002:a05:6830:2650:b0:7dc:dd58:50c3 with SMTP id
 46e09a7af769-7e5fee98590mr17054278a34.13.1779988262115; 
 Thu, 28 May 2026 10:11:02 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 03/22] vbe: Show the margin when using SPL_RELOC
Date: Thu, 28 May 2026 11:10:10 -0600
Message-ID: <20260528171043.910264-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

