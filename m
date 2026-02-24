Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FB9F357AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2CF183EC9;
	Tue, 24 Feb 2026 15:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aAVX8SzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 632F383F1F; Tue, 24 Feb 2026 15:26:35 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D45583EC9
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4638e238094so2611367b6e.3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943191; x=1772547991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l62/Ne6Q7YquMtJssoyxi0nFhSec25xR3qASohNQjac=;
 b=aAVX8SzEmNgkmjsPvrLNE9Fli70BlgmxLK9FrzI/fVOrF5lfjd1B50MZtiqMElmQJm
 XTU/njroa3EhGbA/EBg2FJ/SPvfTolRzmseYnxNRIy2RFjCggSGc72IrAkBsBuENFn/X
 +ZB517ht81Caj66cw7GmBgwl7sL+7k7GUS9ZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943191; x=1772547991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l62/Ne6Q7YquMtJssoyxi0nFhSec25xR3qASohNQjac=;
 b=eIZwbwrfhLU1cSdFMAkzXIYoon7TtvjLPtDytsTvGJw9O0aCUnqTgTSA0+4/+30wYQ
 NVqvQWfMslGIGwdCl8Yp+ttKV63Stk6iOXO2iAlIsOHqPX9UEnW4zj96230qI6ZxAGRG
 GBWLMdfck1HDp0YAORmrHDCehnRT2G1xAX7cPdtStGcbI7Iq3+cQ7i4DDgcVC1S6es+g
 CIb9vR7fQzJZ2G+w7AbsjALBq519mVfWXfyAR1jefXS54EYpkY8TM6kkANZDqmQM1vIz
 BAkme4Qt1TDBvcKbHA8pT4FziehOFcUyiGE0boEG7xdIcLPGB5n5MuCW7JGVVJ0y+/Zr
 3o6w==
X-Gm-Message-State: AOJu0YzP2QbnAu1tfPQSihCiQLorcVW6U99sgDdR2XT2QlhJFJDd0rbB
 b7ZI+FgAN3z2m684vocykFNrsDF46OAmaeHdYmx/pmppswPlaDGDtSgzYfA0tdESESrUkGgAI/8
 450Q=
X-Gm-Gg: ATEYQzy4HEtBNtV+T1YXQ5FJKPoBUEAxHG+AitMoCeWE2py72CqkbRsmzBEKgkCYn0K
 USX46JEappVTfYDueNt0oQQitQAhODZmhDyJ6xASHmIDEa3OsgnDvKYTw6YGIAV1y4k9Hoz5E0/
 gPtbQYBdOMwbL0gAPsPEqb9X8+pl7uhKCGsw91RDWwBUmzkXWfOYKcxRXUY0HZNK1Tw47gPYZFk
 lHN1bXHnwDIOmbOmKozy5Yjt4CdHt0PMM8TZjcQXj/AZmXwxqGFL9AxpvHV040dbH3rNFcxEp9z
 BX2XQzS7oRTVIbFlGrEt0uvhqiJbhSBU/Q4F6YBWxcM0GRBEcEgvilJpV1zOKcOPOjGxGwCVQaW
 gr6g8Lsb+aLCAy7hto8Ki7pNaXFTzj4O/fynaVt7Ri/CuwHOvN+QeY5dU/aB/93pLPhn/D2wHyj
 6HX4EktV/HJ9sy3srX1CIZS06QVRYdWA==
X-Received: by 2002:a05:6870:e196:b0:3e0:ffcb:2f84 with SMTP id
 586e51a60fabf-4157b0ea219mr6021211fac.28.1771943191367; 
 Tue, 24 Feb 2026 06:26:31 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 6/9] x86: Call bootm_final()
Date: Tue, 24 Feb 2026 07:25:48 -0700
Message-ID: <20260224142553.1608883-7-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224142553.1608883-1-simon.glass@canonical.com>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
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

The x86 code in bootm_announce_and_cleanup() is very similar to the new
bootm_final() function, so just use the latter. Move over a useful
comment.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 arch/x86/lib/bootm.c | 14 +-------------
 boot/bootm_final.c   |  5 +++++
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 7a94dc877e3..cde4fbf3557 100644
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

