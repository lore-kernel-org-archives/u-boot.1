Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7E9D11707
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 16:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD1883E8A;
	Tue,  2 Dec 2025 17:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BXVlD+3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E15283E8E; Tue,  2 Dec 2025 17:22:56 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF58183C01
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 17:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3ec3cdcda4eso4027904fac.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764692572; x=1765297372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QH/PPYzKRHNRyhJkfqjpkhnBufLbc/qVzXgfynxMoxo=;
 b=BXVlD+3/2ACikfAYo1QEpHHWj/+NAbQoKIill3sQBEaUyuUGpVvCcV5/ENMbXh2mEy
 6C0873+SIaxL8Wy4Hwh3hf0ePFLQAy+o3CLKSS2jQmTzpgCSzm1D1NsZwO8V4rGbSQoW
 ER5wLn9bmynoqYpNjgocsVc0k7/RKPKu+h+Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764692572; x=1765297372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH/PPYzKRHNRyhJkfqjpkhnBufLbc/qVzXgfynxMoxo=;
 b=eJB9DfYYkuV3Z3KaiFM6VLWvp/viwJ/y+gF5yiitOU04Tl6vqbJIFZTJriuwylw1Ez
 w6v8gAJSJ1O/2vTZfKa6fdxrv+vBSCMgVWGJVoOQ8uA40bwKpvy5Xb8xNeblTrwgePVj
 sSmHaq2K2rvdkaJC9X7P9BTJ7BtU+IUt6XJofTHzBVPaG/semco1VmoQtg5WUevudRyQ
 byiPC9UPZd2yPoE0AK+qRh2pLSDXL7Byn0ORCqW4wQic6M3I3F6q9SsN2oJnQt/zkIZM
 /VLeSv3o9gZRBPe1BCeKg/9+gkVC9OAC1H6vPrEZBPhq7bESrl/PV0glFXybAI/1C0mr
 19Uw==
X-Gm-Message-State: AOJu0YxJ6e3iv2JNU/cd04nuEqW7pPLL5uSu659koMjzZW+6wb8OlUy0
 h5GGonnbFyeQO4wCuczdnrL62SaCATZWst7R+otsRmW4i1fRIZ4qItj4FbQGMig0vBubd6EfEXr
 3hoJtg2Y=
X-Gm-Gg: ASbGnct3xnNg6a22XC3H6o/jMZblw18SthDyd544zRXYX5CKxzNS5YvBgcvHkR7R78Q
 Wky+DFPN0uZ/IrLMAa4/4wHoEBbtqBFwdFUy+sv5AWW8+dhKrLuKM2xiapWUZCWJzhTBbrr4mxU
 mUien8KB5atJe5i0oyJFyI9OYX+2XC4oOJYuZFfv2iDJb4SIEv09K0+tx5bOXgIeF+BeHfM5z+7
 4YDUEk2FccVYmqrquXUiEnKUd7EngNutQaHfYBL8y3vVuBIMbQBhMbNIBCXv2L+u9lRvFVQ3E3+
 BhbtSXx7IY+iN+ucYuscRjn6QL0uvhDaLmysTITDMkanCYv48JsTUk9pupy+ZS3yyREoiCT8Hu4
 Lupt6y1nRylyPiUXlBzkT1Fchti5gfztqmfd2ZEk4eBbz7ZDFJZLisH5YAKR31Z2pOw87wEoD19
 DQ+5cciTFbsvelS0E7rhdaJV3ehnOq+ZBbBlb9Tb5yJRG977E2o0Xa
X-Google-Smtp-Source: AGHT+IHq262ubAjQkAG+Towq8lt4/UG3GKr0dOMp7areaz4Jeuvc0TgXhxbr69qUNyaIMSpwaB8IFg==
X-Received: by 2002:a05:6808:2108:b0:450:e36:999f with SMTP id
 5614622812f47-4514e65c1e7mr14246601b6e.21.1764692572501; 
 Tue, 02 Dec 2025 08:22:52 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4531708f2fdsm5819796b6e.14.2025.12.02.08.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 08:22:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCHv2] boot/image-fit.c: Resort to using malloc for USE_HOSTCC
Date: Tue,  2 Dec 2025 10:22:50 -0600
Message-ID: <20251202162250.2613085-1-trini@konsulko.com>
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
of the host OSes we support. Specifically on macOS it isn't seemingly
possible to get memalign exactly. To keep alignment we would need to
rework to use posix_memalign(...) for USE_HOSTCC and memalign(...) for
U-Boot itself. This would get rather tricky. However, given the limited
use case in question, it makes more sense to fall back to malloc(...)
for the USE_HOSTCC case.

Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>

My biggest take-away from this is that I need to move up the plans I had
about asking if anyone even uses the host tools on Windows / macOS from
post-v2026.01 to instead be later today.

This change is a work-around at best. Ideally, we can drop Windows /
macOS host build support and revert this commit at that time.

Changes in v2:
- Rework things entirely, and elaborate on the commit message.
---
 boot/image-fit.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index cccaa48f6839..3323ca1020d1 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -23,6 +23,7 @@
 #include <log.h>
 #include <mapmem.h>
 #include <asm/io.h>
+#include <malloc.h>
 #include <memalign.h>
 #include <asm/global_data.h>
 #ifdef CONFIG_DM_HASH
@@ -35,7 +36,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <bootm.h>
 #include <image.h>
 #include <bootstage.h>
-#include <malloc.h>
 #include <upl.h>
 #include <u-boot/crc.h>
 
@@ -2279,7 +2279,18 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 
 		log_debug("decompressing image\n");
 		if (load == data) {
+			/*
+			 * This could be a compressed device tree, and device
+			 * trees require 8 byte alignment for use. However, in
+			 * userspace we aren't using the tree, and getting at
+			 * a portable memalign is extremely difficult. Continue
+			 * to malloc in the host case.
+			 */
+#ifdef USE_HOSTCC
+			loadbuf = malloc(max_decomp_len);
+#else
 			loadbuf = memalign(8, max_decomp_len);
+#endif
 			load = map_to_sysmem(loadbuf);
 		} else {
 			loadbuf = map_sysmem(load, max_decomp_len);
@@ -2291,11 +2302,13 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 			return -ENOEXEC;
 		}
 		len = load_end - load;
+#ifndef USE_HOSTCC
 	} else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
 		   ((uintptr_t)buf & 7)) {
 		loadbuf = memalign(8, len);
 		load = map_to_sysmem(loadbuf);
 		memcpy(loadbuf, buf, len);
+#endif
 	} else if (load != data) {
 		log_debug("copying\n");
 		loadbuf = map_sysmem(load, len);
-- 
2.43.0

