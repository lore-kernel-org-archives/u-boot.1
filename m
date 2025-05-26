Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C16C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC4082DFD;
	Mon, 26 May 2025 12:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ND9e+GLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2426982E6A; Mon, 26 May 2025 12:16:10 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E59F982DFD
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3dc75fe4e9bso9013495ab.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254566; x=1748859366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nL3BiFPnVkV52asiESoGn6WGwRJDqU76dxSZ+d54tns=;
 b=ND9e+GLTWkspco9f+qCk/zk3uafelcPSxulwpU+T1Wf7Pg1T9MXTUCxz1/aWswD7Uy
 Bja51GPaH54CxF4h4wZHHimdg6PMvEq2fpBRe1O6RQEPPMErhSbMJLVKiS22uI6IZnhD
 gZcobOtVnCRG1y4pL2Evd1z93PkSo7kQvOKuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254566; x=1748859366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nL3BiFPnVkV52asiESoGn6WGwRJDqU76dxSZ+d54tns=;
 b=WPvjxaB6zjif8gr4Cfo86kEhjwuv4UTnUjc1zrgvU2Ox2fMbeQzSVWNuftzhLBWRv4
 s+FRQMvCxXkoNdEnE8JesbgqcZg8y5JUoopwdaV0N5lWNqa/qdP8pnuW7ca52PtiaHFZ
 p9HNMKzmmLoSviY7bmoWHEmvOP1PHhVxKMRRXZN4zvr6w1b309elzt9l/T1MCxiatBGZ
 Xw0jisy950PMNCZSF1IjGmGqemVGcbg6K3Blzv/cCnknGAarbE1p6kOTmm13zGhR31SM
 Mk0WfxXywj181YOf1+8T9dV3OubuHmozkGtieXrbf4DJhGgYl3LVC4Q8ogo3dPyNS443
 BYqQ==
X-Gm-Message-State: AOJu0YwmSRkeuNQAl+Sr7lQVfQBRr6vsuH42ljm91XJCQYOgV9Bsdk2/
 KwMf+1PhTxm/DSu3aubgumNobCXYbGA8V668sB/Q/NdWhnOGAGxUjZD7uMXCyH7l/XyYBNrWHn0
 7ZPNNaRkw
X-Gm-Gg: ASbGncsV7fAzAc3RVXu1C89R2Sps7ylYHk0qmO/DaDoMFRQKD5/YLIDmxAoQwIldb4T
 Ae8nk08pK992mOUUrWrtQhNCVLcltn7aY2FpjGXH4ny2hej2mlC0Z6mDBVv2mLalztct48OVR+4
 youiFlsl0vqglZKebgN0wuLgg9IZWtxrpA7ncmBEERXReibTg9ZSFeC1mzs1QtIfrS4fgIYgvle
 v/CzN1pSpJVSC8vhddYoOXJwrfhClIsy50yBd4+/Fu84B4IvEI2gGXb05cc4JTW1XxEE60T8Glb
 ntfajQSwr3Jx1Kl8DcBxxibw8LzSd3gxe8oyqNbIEKw97XRPD9cEevOKuIBisGhD/ZnMmoz+qwI
 dlms+SXPmBaBh
X-Google-Smtp-Source: AGHT+IFjQ/VXKtKkbIh78tB/2WW13HK+TAyAgZHnzjHWpQvPh9EHT6Jvj/9qVyuAeTcmz84RrNVrDA==
X-Received: by 2002:a92:b104:0:b0:3dc:879b:be95 with SMTP id
 e9e14a558f8ab-3dc92bdaa3cmr79848515ab.5.1748254566043; 
 Mon, 26 May 2025 03:16:06 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 03/25] vbe: Show the margin when using SPL_RELOC
Date: Mon, 26 May 2025 04:14:49 -0600
Message-ID: <20250526101541.3254628-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

