Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A32CCD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 743D1846B4;
	Wed, 27 May 2026 14:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="hKP6jUVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27C7E8341A; Wed, 27 May 2026 13:16:11 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E3F080087
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 13:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-95cd9bc6398so7549709241.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779880566; x=1780485366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I6UdNaBniX0VTuA4hXcyYWXPmWzCxxMMUNMQdcMFgrE=;
 b=hKP6jUVPPVS/bgNu64KrKLNujaxUPjW2zoPRUeLVRjzQrsCQ5xMn54CSs9ToqwsPEO
 IP2LVoccERDRnG/jXD99J2zYTJX4WwS0Gao2KxLPMbgJqreifFAKbD+GGX29O4CXRNFm
 sGNuvd9RT+PDl6CihNyMuFicjaBudTE5vUv7JnJheXn9lZsbEck9T3wYa6T/s7OFL+G5
 vF0F+klsjPwS+Uz10Wlt9cH61GZssekZD1E7gfACxy7peRIenQnkHp4JzHLtqCjPfdAe
 aCFLlAUxQsZSOWe5v354/pM4VKYNCqmxcLdhjSi5cepOIouTIyh/LkHbFdyyEQHykhpK
 kk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779880566; x=1780485366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I6UdNaBniX0VTuA4hXcyYWXPmWzCxxMMUNMQdcMFgrE=;
 b=sZaljlFeQDMgjqLHuWrGjsvfL8a2RY7npcRMnVIpjgDYMjhlQ3CHyL1ymoPkrv2WrA
 bKhoDCQVR6NElgbHjUyZZalNbkD9zOPzTxM/lATypzgj7D5uT6CaWxcUM2piwF8pm3EK
 tOF2puTbsT+f/UHXeR2/aj6rLGoYnPhJIcwJaA/D2s5C8sWP5kmrFwDyc8Y3+JmsYWM1
 t/FZxkalE0lA2T94K9jN2cvZAqKsI71VTc+hSxuAIbwl6WYo9cYXtwqV7Pqh0WpQIlYC
 S1RHD4hdOpJk7e2iH77X35/jHok6JvRvncO7ESOirI++lJff5+0uy/DFJGc71skOA6b9
 312g==
X-Gm-Message-State: AOJu0Yx1L4hYz3aRwydlso71RV8ySunYqZzApxkPDl7l4ZtykLeudPDf
 8LBgPfolLSIPPiQFt85iyLtj+WPn0q2K2s10Xouk4bkYRSWCwfxgR6hrjUmmBb3HNaRirHjKZKB
 KaL7FCgjtXQ==
X-Gm-Gg: Acq92OFMDhRywUpiBx54nFRgUTTMP0hvWiCrXX0iGmgoSC73pUG3T7SOZF9xWlS93xz
 lb2xCB62paIkx8rd2A8jdjWkIcmevkuovj+8aDaSnEfSSuj7YTAsJTzxOA+hJa6u/veqmiWUZmX
 wmJYrzYNocnZhztIC1bQAhwTEX0i+eN8fTjuxBsTFPdipAyV+CHgjrc5S81NPVhNdPlK0iZMlKs
 82uz7XL59OdzYMOJJxQW+WexOr19VXooDdqhJOYnKjKFbI0XHRWbQgQcCuEfNZd1meFGlcy8sjZ
 kcXG4NugdbDLR22028lkOdQFTyJ5x4ciG+hEHS0/y8xgVMPGs/AEqwyzrPHtxbSaTslBck5SKuT
 Pgf/CCpLEkwADuhQMfij5CBHxFWjDFsGgrJb8X+pt8qz0bV/V1YVSN8dI/bpSnZVi3zAqeYbaJE
 1G5Qf95ZbU5BK2SxHAd9deaifI69L+YW6nwoHoiiMNiGJgow==
X-Received: by 2002:a05:6102:3ec9:b0:610:6e69:5235 with SMTP id
 ada2fe7eead31-67c7e6e4594mr12411826137.22.1779880565828; 
 Wed, 27 May 2026 04:16:05 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4907e6284e5sm24120055e9.0.2026.05.27.04.16.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 04:16:04 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de,
	sjg@chromium.org
Cc: trini@konsulko.com,
	vr@binarly.io,
	Anton Ivanov <anton@binarly.io>
Subject: [PATCH v3] fdt: Check return value of fdt_get_name() calls
Date: Wed, 27 May 2026 12:15:53 +0100
Message-ID: <20260527111553.82161-1-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260526104744.33248-1-anton@binarly.io>
References: <20260526104744.33248-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 14:57:27 +0200
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

fdt_get_name() can return NULL and set len to a negative error code.
fdt_find_regions() does not check for this, leading to a potential NULL
pointer dereference and a buffer out-of-bounds write. fdt_next_region(),
fdt_check_full(), and display_fdt_by_regions() also lack validation.

Add NULL checks and propagate the error code from fdt_get_name()
to the caller.

Signed-off-by: Anton Ivanov <anton@binarly.io>
---
Changes in v3:
- Update From and Signed-off-by to personal email

Changes in v2:
- Rewrite commit message to be concise per maintainer feedback
- Don't mask fdt_get_name() returned error

 boot/fdt_region.c           | 5 +++++
 scripts/dtc/libfdt/fdt_ro.c | 3 +++
 tools/fdtgrep.c             | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/boot/fdt_region.c b/boot/fdt_region.c
index 295ea08ac91..f0f2568955c 100644
--- a/boot/fdt_region.c
+++ b/boot/fdt_region.c
@@ -86,6 +86,8 @@ int fdt_find_regions(const void *fdt, char * const inc[], int inc_count,
 			if (depth == FDT_MAX_DEPTH)
 				return -FDT_ERR_BADSTRUCTURE;
 			name = fdt_get_name(fdt, offset, &len);
+			if (!name)
+				return len;
 
 			/* The root node must have an empty name */
 			if (!depth && *name)
@@ -553,6 +555,9 @@ int fdt_next_region(const void *fdt,
 			if (p.depth == FDT_MAX_DEPTH)
 				return -FDT_ERR_BADSTRUCTURE;
 			name = fdt_get_name(fdt, offset, &len);
+			if (!name)
+				return len;
+
 			if (p.end - path + 2 + len >= path_len)
 				return -FDT_ERR_NOSPACE;
 
diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index 3e7e26b4398..d7b424c658f 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -940,6 +940,9 @@ int fdt_check_full(const void *fdt, size_t bufsize)
 				int len;
 
 				name = fdt_get_name(fdt, offset, &len);
+				if (!name)
+					return len;
+
 				if (*name || len)
 					return -FDT_ERR_BADLAYOUT;
 			}
diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
index b4c041070f5..dba7240001f 100644
--- a/tools/fdtgrep.c
+++ b/tools/fdtgrep.c
@@ -355,6 +355,9 @@ static int display_fdt_by_regions(struct display_info *disp, const void *blob,
 
 		case FDT_BEGIN_NODE:
 			name = fdt_get_name(blob, offset, &len);
+			if (!name)
+				return len;
+
 			fprintf(f, "%*s%s {", depth++ * shift, "",
 				*name ? name : "/");
 			break;
-- 
2.53.0

