Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DFECF6BE1
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C529F84033;
	Wed,  7 Jan 2026 01:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZI2LutN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCC1E8404A; Wed,  7 Jan 2026 01:32:43 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75BC784033
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-65e94e128beso221258eaf.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745958; x=1768350758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tz+g/mAa7kyC269hE9cSKE9PYirKyiKm6PgEoQlIkbc=;
 b=ZI2LutN+0cnjt/4/4WmBpMy/rktxWC8GkpRDGGD+8LnKsxr5Vr8fOXHnibwneZKB8L
 2E+u78R5kXFXof3NggT5msqUHRggm/abQhMFIde18faEx3gx2H56l6rh3UsJbzTT7DFl
 Zw0J/BcdBDnkvadF7Blg3d1wxqJQCbQUqd1rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745958; x=1768350758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tz+g/mAa7kyC269hE9cSKE9PYirKyiKm6PgEoQlIkbc=;
 b=L/Lwfg5HVt1U5JttrUmVApr2OmJiC+4JawaKK05QQxoRun3sZTZ8pPu3v9ixkApIWq
 FmS+X4Z6oE7x/cjewyX0t9Ytv0B6rxbFDFATMFZO3xuDNKhOl7k4+k7vZQNcTxr2nc6p
 YyZp8wJBQ01+yn4GS93MwqAJ36CGVcgp/5AuJqL4EWvU3yx7nSFAwo08N4UfgzfzP4Jt
 Vmv4UYT2Gw2ZBfWEPjUv3U7/hmHIGCCPlLQ3LZGJmz8zId5CoBeyvwGexLbw3GlqXSix
 wq96rqST39TjB5P0y49wk7kEga/7LF15Q6Zi1/yPx+Q2afTQZrcC0nUygBlvNJZpDWQP
 cjGg==
X-Gm-Message-State: AOJu0YyQwGTaZim67zoSKWbm1x2U23yJsmHIruw6qzkP9aGXc3lmAlre
 W1CrfFyz95GjdD4VZ8pijsM0nk+VYLZcxafVRyU/4bPZiOHSzaxA/waHlypJ1px+NsUkxCvZfn2
 Z3Co=
X-Gm-Gg: AY/fxX5nM/w/BQIvjFQzk3k7UusR0M1g9GcsI3o0E8YB9CUQlSujxFDlMJ7d1my8/pb
 2gYIDXSzt8khkv6EuNyGRzQRNWpaErbkWTYOtT1MwXdGlWz5ShEb/go1tBX0JDE/GHrdZwOqxH+
 znJk+qX0DXXYEOeWKIFal1T5k5gaHnj+AYmA1xHxaW2sY1RH0cA4ENHolP5nzm2GdwSZLLo6YBA
 bvIFErNzSYsPzqkqfwec2GvfSe6Jhv6aG+Wt/SvM7LDasnVPV3UR/2qKnyKE0K781NHmev67gku
 gPewYKkjLDYtT1OprGpKQuvAzHnIHftc4+9g8teh1Vi7WsF7ctadsGZTaLzsPyoUDMJHW5mqA+H
 LToKlZEuvz5JsjfbFPiHHANHmat04u4Cg5zw+xB7fT94NUZLtiRnEJf4gGIHyWarHSUhNb8VsqA
 j25VNMmmYu4OD5rdS8
X-Google-Smtp-Source: AGHT+IH9Kwdouo/nezXqWHEsP99Id+58ZM5rY7zDedN31106IpTc1rxZn4ZLIv3GGmi9S7H/kA3FYA==
X-Received: by 2002:a05:6820:2281:b0:65c:f583:d3e4 with SMTP id
 006d021491bc7-65f54691c47mr487753eaf.28.1767745958468; 
 Tue, 06 Jan 2026 16:32:38 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 06/10] x86: Call bootm_final()
Date: Tue,  6 Jan 2026 17:31:23 -0700
Message-ID: <20260107003131.3064800-7-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107003131.3064800-1-simon.glass@canonical.com>
References: <20260107003131.3064800-1-simon.glass@canonical.com>
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

From: Simon Glass <sjg@chromium.org>

The x86 code in bootm_announce_and_cleanup() is very similar to the new
bootm_final() function, so just use the latter. Move over a useful
comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 arch/x86/lib/bootm.c | 14 +-------------
 boot/bootm_final.c   |  5 +++++
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 0827a884b1d..8e54fdb5178 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -34,22 +34,10 @@ DECLARE_GLOBAL_DATA_PTR;
 
 void bootm_announce_and_cleanup(void)
 {
-	printf("\nStarting kernel ...\n\n");
-
 #ifdef CONFIG_SYS_COREBOOT
 	timestamp_add_now(TS_START_KERNEL);
 #endif
-	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
-#if IS_ENABLED(CONFIG_BOOTSTAGE_REPORT)
-	bootstage_report();
-#endif
-
-	/*
-	 * Call remove function of all devices with a removal flag set.
-	 * This may be useful for last-stage operations, like cancelling
-	 * of DMA operation or releasing device internal buffers.
-	 */
-	dm_remove_devices_active();
+	bootm_final(0);
 }
 
 #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
diff --git a/boot/bootm_final.c b/boot/bootm_final.c
index dd7cac55f1e..7077702d8c7 100644
--- a/boot/bootm_final.c
+++ b/boot/bootm_final.c
@@ -18,5 +18,10 @@ void bootm_final(enum bootm_final_t flags)
 	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
 		bootstage_report();
 
+	/*
+	 * Call remove function of all devices with a removal flag set.
+	 * This may be useful for last-stage operations, like cancelling
+	 * of DMA operation or releasing device internal buffers.
+	 */
 	dm_remove_devices_active();
 }
-- 
2.43.0

