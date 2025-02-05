Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF81C02193
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 01:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65B0A8070F;
	Wed,  5 Feb 2025 02:56:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="McZ7Dk1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F44480711; Wed,  5 Feb 2025 02:56:37 +0100 (CET)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82B58078B
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 02:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f304ac59b9so3149264eaf.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 17:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738720591; x=1739325391; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N58AhordiDj5onulb6wSd1qadHIB/qR611HvIW1WETg=;
 b=McZ7Dk1x++3LrKgGvWrXeT2txnYdOK+Gljrz3N1lPBvXwFhnR6Q7nA1GWJgK+Mi+nb
 /WCrxfWju+Lu7p7fKoABwOhu/nKhTzWPvXe/Gd9KD0ZVGnzKqxTLPwaciskTNmxnERdf
 PEWzhAZvK+uzWPFG+Y6Nk3nGiJFBNK/0f7+YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738720591; x=1739325391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N58AhordiDj5onulb6wSd1qadHIB/qR611HvIW1WETg=;
 b=MMAL+vWhf3gRtftxhVzpH0TYnbpopIROWqt7hc3t/WiCSg2s1VYXH/4M3QUbby4hWp
 5ml+Hf5Ys/XXbXDwcyAv/3iR7mY7fb1sEM20AIJ/T/PcRlps5Z3v/U5NoUtJ+29MxLfJ
 8ON91xyI1tuy1+ZOxTr1YIqOaw5q5MxkzYD7dPoOjBi8+ZIKxlZsaMpWZOsqH6aLWw8g
 CGfn1DknFOdTuLAXs8X+UNvt5IlIiWAF6261K/NqMW/wu1EqMdqpomDn3xDlV8L0bfUA
 ahITZqF8CeB+UYCqfxRFXY/Xtd//1DZrNUJ3A9Df2Lb/el/+BoPwrshbgN6qsqfXT5oC
 lHhg==
X-Gm-Message-State: AOJu0YzvgwHYcgi16+DRU6Cm59KcAitG0X14LG7cCGElArNIbohZiivz
 XVfCYqurzOgaKwOiaBnx/nDx5IifDGjCyJwdwizr/zzt5m1GWk+yGWDQQLymWu/QTorO4H2CEDc
 =
X-Gm-Gg: ASbGncumovVX1+30UH//4pOPCRsseHwOkByvUg0ZyKcwY4snpS/rXPC501tDJkPYo0u
 YD+R4UH6UNtu12VPChKceKZwzvkmNC8fjSNVXUTQaONiZhUnDviwAXHtmQyjN5mMMjjGlEvr2mV
 NcQ6bJ+etW5958LNZ779wQJicQF8NEtlLKk071ZQqaPAcPeWQUBFfoKgJBorG0+6VB6+3XRgMTd
 /LaN/L71AxhZWNu7jQTwMG8xqEV3q3H5ftelf4XnbGuWJQDEWfl+E1jLDwWNKZA+2jSTA9eqXoK
 WM7N7HZO/jzhi+h/V0wG7klRb4hACUzzBIAUrB7i2j5IAbiTEVdq
X-Google-Smtp-Source: AGHT+IFXE3KgSwcVL0bdOHwm5iU8h4Bnmd70+4ip4dVatFG8dUmHBhqFpqOaL2ffdPhXw7Wb3aGSCg==
X-Received: by 2002:a05:6820:178c:b0:5fc:4582:42a1 with SMTP id
 006d021491bc7-5fc478e75b3mr872266eaf.1.1738720590954; 
 Tue, 04 Feb 2025 17:56:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc104c2e7asm3543676eaf.12.2025.02.04.17.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 17:56:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/29] vbe: Show the margin when using SPL_RELOC
Date: Tue,  4 Feb 2025 18:54:54 -0700
Message-ID: <20250205015606.2686149-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205015606.2686149-1-sjg@chromium.org>
References: <20250205015606.2686149-1-sjg@chromium.org>
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

