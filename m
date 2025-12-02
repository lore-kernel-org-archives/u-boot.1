Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B994FD116F5
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 21:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F16E83F15;
	Tue,  2 Dec 2025 22:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uR8+HUgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A876683F2E; Tue,  2 Dec 2025 22:20:38 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E04C83EDE
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 22:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-450c65f3510so2668486b6e.2
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 13:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764710435; x=1765315235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s3yhfC6MyLWQUu9Q8Qyy3Rq/1uKU7pkWTbpUocPNBrY=;
 b=uR8+HUgoQxvEVCgbJLY2BB5DfRiEawDn6u8zjnn3XEKdwn0dkvb2agSGTc15VR6vuE
 1thOonm9aUpRdEM9Nv5eBwN9ZBVOvNvN7M4KAXSj4NMF3cPjZXYIpGHRz0BuUlzURPu4
 FVA8hYXiuZ5+kme8obkWUjYwm/aTOmH3sgL20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764710435; x=1765315235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3yhfC6MyLWQUu9Q8Qyy3Rq/1uKU7pkWTbpUocPNBrY=;
 b=BgAvSNzlGTeQpd+YItqzR5syi2V3f+f52CWaVVDwefZckLNNBMrqcfbrZGoivCFRXO
 8qqnDtmW8GF0v28+w21HQyZQpthcYoi5Bfnco8Zae+RU3XH0fGVUCKZh7ZSFs3laNEkc
 /tE2iOeYhYc+yCgak/ukb9CCYTkduKIgXncTFLJpSpGAkc9vL/RFzTPu6bpmCO2ZArQ4
 Sl9go+fbjogalvFU58j/k5Ti648A3pQhsZ8COgzd7bAsR9pFVyzr8qrzOf5NXTxJf1zR
 AKD+vyG/dvzWfQ9PzNsz4o22U6+G/W9B6CALbip41PSGMTuVIivSEqyuEKwQOk+jmrWq
 Usmg==
X-Gm-Message-State: AOJu0YxmEzNGcDVfAFNZzxe2ofbvv1LcFG8cI0BE181xDLXFly1hOEjy
 u9mU2inVI32ifBzl5ynF/uEWMBQ48xCc68O65Jg1AHAtxEkKbCbHkklKemxLKaihqdog2S4gLGn
 3JaDAMPE=
X-Gm-Gg: ASbGnctJ+UpQkMwRM8hEM0OaCdaNqYHOXV6ocJ/LbHL60RdgX6lsgKGjZWyi7crl/sj
 UoVU9oIXImpJJyiRy/AkEAZ/GfCxRKXchWsHENl20LPcvHw8Cv9Zr+13nDkKEGGscAv7tjPm+Oj
 B0NFtnwKeXtLAzr5gQ+9PsT8o6MKWmzBqKcGqbCzygQy9zrwr/wcWGFfl1Ww9+7a4PouA27CqEY
 Dl5xT3KeVchCTTVM2dt8QSXrSY4qTKGY+L/tTwl2AhfbM22Lwi2z5gJePwrX6LJ/4MIGwnSGHxr
 suPZRwsUgWcP6Z3xfnggwEX9kLvI1st4/FuPDRN+Dk58LMCzqh5a5vupbnjOyu1PMqITudafqCX
 3wdXECPIozOZqp3kkR6hI5rxaF4SXrVnG3pJQD7vcECl66DQpcfki5XZMnduOMmoIgiI9sgNDyh
 YubmBa2HRobOAecuwvBe7MEY6Zm1Ew9MsSsXiXGgep4V7KMktN/rx+lHfTHSuOkyo=
X-Google-Smtp-Source: AGHT+IFPGh639NErzpx2FC2GdApt0wvkORPxA7QseiAoqCQQWSOiTXktUrOp3tKaQpHnFnYJIRxnCA==
X-Received: by 2002:a05:6808:2228:b0:450:3b8b:b472 with SMTP id
 5614622812f47-4514e8791c9mr15803033b6e.63.1764710435190; 
 Tue, 02 Dec 2025 13:20:35 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453170cc9desm6096008b6e.15.2025.12.02.13.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 13:20:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCHv3] boot/image-fit.c: Use aligned_alloc(...) not memalign(...)
Date: Tue,  2 Dec 2025 15:20:33 -0600
Message-ID: <20251202212033.2692954-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

With the changes in commit 8fbcc0e0e839 ("boot: Assure FDT is always at
8-byte aligned address") to call memalign(...) we now always call
memalign(...) rather than malloc(...) when allocating a buffer that may
contain a device tree. However, memalign(...) is not portable among all
of the host OSes we support. The C11 standard does require that
aligned_alloc(...) exist and it takes the same parameters as
memalign(...) does. Change this file to call aligned_alloc rather than
memalign, and for the non-USE_HOSTCC case define that function back to
memalign.

Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>

Changes in v3:
- Per Heinrich's suggestion, make use of aligned_alloc(...) rather than
  memalign(...) as C11 requires that function to exist.
---
 boot/image-fit.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index cccaa48f6839..fce3a320eac7 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -16,6 +16,9 @@
 #include <linux/libfdt.h>
 #include <u-boot/crc.h>
 #include <linux/kconfig.h>
+
+/* C11 standard function for aligned allocations */
+extern void *aligned_alloc(size_t alignment, size_t size);
 #else
 #include <linux/compiler.h>
 #include <linux/sizes.h>
@@ -23,19 +26,21 @@
 #include <log.h>
 #include <mapmem.h>
 #include <asm/io.h>
+#include <malloc.h>
 #include <memalign.h>
 #include <asm/global_data.h>
 #ifdef CONFIG_DM_HASH
 #include <dm.h>
 #include <u-boot/hash.h>
 #endif
+#define aligned_alloc(a, s)	memalign((a), (s))
+
 DECLARE_GLOBAL_DATA_PTR;
 #endif /* !USE_HOSTCC*/
 
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
-#include <malloc.h>
 #include <upl.h>
 #include <u-boot/crc.h>
 
@@ -2279,7 +2284,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 		log_debug("decompressing image\n");
 		if (load == data) {
-			loadbuf = memalign(8, max_decomp_len);
+			loadbuf = aligned_alloc(8, max_decomp_len);
 			load = map_to_sysmem(loadbuf);
 		} else {
 			loadbuf = map_sysmem(load, max_decomp_len);
@@ -2293,7 +2298,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		len = load_end - load;
 	} else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
 		   ((uintptr_t)buf & 7)) {
-		loadbuf = memalign(8, len);
+		loadbuf = aligned_alloc(8, len);
 		load = map_to_sysmem(loadbuf);
 		memcpy(loadbuf, buf, len);
 	} else if (load != data) {
-- 
2.43.0

