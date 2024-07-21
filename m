Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E045DC3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4EB885F5;
	Sun, 21 Jul 2024 12:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SY7fJu0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0174687F8D; Sun, 21 Jul 2024 12:10:13 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A32C88373
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-368f92df172so1103775f8f.2
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556608; x=1722161408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ja/D2ziihdkTmFP+Q+oAy6MiqLXOGRQqokvJIJjNpWw=;
 b=SY7fJu0af37jhhmCuT/X1w62YKt96vhDgNv1LymiQH8XjdLFEIGR5U+7w9jNOrRHMB
 J6R+gCE5dS2ChmgZsFEAtw8qT+ZKQXixbkohFxoNz2NHunV8liWgsPPzy+1vXxBdnvpm
 YWYm8bUtMFbvp2iACASKNgaNZBDGcvvCBsqTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556608; x=1722161408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ja/D2ziihdkTmFP+Q+oAy6MiqLXOGRQqokvJIJjNpWw=;
 b=gMdFkDKZVdl3hkryj5MaQi5YdkWbpSjZgpMH4EWpi0Xz2rzg5fkmM5YOUrLKqLorR7
 zOzl4ft9Lz9XyWxnRBl5fSC8CiGV+1ql1q04X7URKE1lPGsWZRl1B2vw2dIvUbK0B0XL
 KeNgTx1mW3LxjHZWA5FV3zCb3qg8bNhBe4rtcbcEvJZw9xXCzM4G0O9u0GKi2mSjGswK
 UyMDV1L5VG/fjmGHf9pZs8Y+S/MBMXtopHqEU/d7Z+R0WuGo/0G5U153fdr8LzMfB6fC
 Xa0p36xJmmKo/BdmNPHRWfGbxmud03JUs9ODY4njT/JMDsj5+fcKRE6v4Bg3JgRc5kI3
 3IoQ==
X-Gm-Message-State: AOJu0YyWoO4DtJ3uNY1D4s3kgCo1CAeU368Is3jCnq5x7iHo55nXNzJd
 B5mJey7rRBwyzBjIi35NsUTU4WAlgP3tlGP1qwMRXwxOGYMgBdIQxMHQDCBORNSmC0+DxoauHoc
 =
X-Google-Smtp-Source: AGHT+IGBs+URla17pK4doGDSRQZUca9xTOx4dCq7I95oFYscvxp/BP3gaV9AsiB00QqL/2HrAUkpnA==
X-Received: by 2002:adf:fa92:0:b0:367:9625:bd05 with SMTP id
 ffacd0b85a97d-369bae3ec96mr1858908f8f.15.1721556608545; 
 Sun, 21 Jul 2024 03:10:08 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d69013fasm85096265e9.12.2024.07.21.03.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 03:10:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 16/21] upl: Plumb in universal payload to the init process
Date: Sun, 21 Jul 2024 11:09:34 +0100
Message-Id: <20240721100940.3202027-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721100940.3202027-1-sjg@chromium.org>
References: <20240721100940.3202027-1-sjg@chromium.org>
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

Read the UPL early in boot so that it is available. For now none of the
information is used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig     | 12 +++++++++++-
 common/board_f.c | 22 ++++++++++++++++++++++
 common/board_r.c |  2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 1fdbb0755c5..ca14a614152 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -754,7 +754,9 @@ config UPL_READ
 	help
 	  Provides support for decoding a UPL-format payload into a C structure
 	  which can be used elsewhere in U-Boot. This is just the reading
-	  implementation, useful for trying it out.
+	  implementation, useful for trying it out. See UPL_IN for how
+	  to tell U-Boot to actually read it on startup and use it for memory
+	  and device information, etc.
 
 config UPL_WRITE
 	bool "upl - Support writing a Universal Payload handoff"
@@ -765,6 +767,14 @@ config UPL_WRITE
 	  for how to tell U-Boot SPL to actually write it before jumping to
 	  the next phase.
 
+config UPL_IN
+	bool "upl - Read the UPL handoff on startup"
+	select UPL_READ
+	help
+	  Read an SPL handoff when U-Boot starts and use it to provide
+	  devices, memory layout, etc. required by U-Boot. This allows U-Boot
+	  to function as a payload in the meaning of the specification.
+
 if SPL
 
 config SPL_UPL
diff --git a/common/board_f.c b/common/board_f.c
index 22c180b2187..ebcc63f34dc 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -40,6 +40,7 @@
 #include <sysreset.h>
 #include <timer.h>
 #include <trace.h>
+#include <upl.h>
 #include <video.h>
 #include <watchdog.h>
 #include <asm/cache.h>
@@ -862,6 +863,26 @@ __weak int clear_bss(void)
 	return 0;
 }
 
+static int initf_upl(void)
+{
+	struct upl *upl;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_UPL_IN) || !(gd->flags & GD_FLG_UPL))
+		return 0;
+
+	upl = malloc(sizeof(struct upl));
+	if (upl)
+		ret = upl_read_handoff(upl, oftree_default());
+	if (ret) {
+		printf("UPL handoff: read failure (err=%dE)\n", ret);
+		return ret;
+	}
+	gd_set_upl(upl);
+
+	return 0;
+}
+
 static const init_fnc_t init_sequence_f[] = {
 	setup_mon_len,
 #ifdef CONFIG_OF_CONTROL
@@ -871,6 +892,7 @@ static const init_fnc_t init_sequence_f[] = {
 	trace_early_init,
 #endif
 	initf_malloc,
+	initf_upl,
 	log_init,
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,
diff --git a/common/board_r.c b/common/board_r.c
index d4ba245ac69..f445803d7a4 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -521,6 +521,8 @@ static int dm_announce(void)
 		       uclass_count);
 		if (CONFIG_IS_ENABLED(OF_REAL))
 			printf(", devicetree: %s", fdtdec_get_srcname());
+		if (CONFIG_IS_ENABLED(UPL))
+			printf(", universal payload active");
 		printf("\n");
 		if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE) &&
 		    (gd->fdt_src == FDTSRC_SEPARATE ||
-- 
2.34.1

