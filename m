Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73049C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3298655E;
	Thu, 31 Aug 2023 01:30:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TLIPkbYJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E9C786552; Thu, 31 Aug 2023 01:30:12 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC9286569
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-792965813e7so12095439f.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693438206; x=1694043006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTPIiEL2pqjwECqhyxHltIedmkyKv8twjW9Q3hP4Iw4=;
 b=TLIPkbYJz1zd7scAXCZZHg37U9wfx+hyd3j/JLaAwTcbCjLtvqY39OP6zwfl3nQh5F
 HVirrumtw6R14ML+py3KgBB+U+m9ez7F7aPFg0cWBioY8JaahPoyaji+PlX3EJ2vsUDS
 UmwOJNab6z6oORkei8FrCmwEs9RY5IYccyCmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438206; x=1694043006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTPIiEL2pqjwECqhyxHltIedmkyKv8twjW9Q3hP4Iw4=;
 b=VWJK3aCY5OkYnnK1V/Uqn2tGFl06EL+sPT9z01g6CKkydQrfLFqj3hL3ayzcmilKyc
 sLtxVKVsh+i/mKUCmaylmjvV5nBei1zZDqYw24A/mNYmOCw/r60dLUJcClT79nEwbSZv
 ewtlOM5hl0vHbHUoSiDfpG3YA7YUEKvhA4q8CSVht86Rl//XygfxVaFviWb8YGv5j/wB
 ovICH2OsAhQc/b+qxUXjrbR5tmFugqx71B6yr6ZZciQeUydo3ELGScJ2mad/b8zq6nP4
 +MiidB5ZUr21jRcRZ0bfNf+GHdNHDU0XuyrPV604+XW6xvteruZN0bVYogJ4eYKsBuPj
 /9Mg==
X-Gm-Message-State: AOJu0YzefqHYuUljX8drf3TIe/5QXzi/ji0wFRuzIU6yohj8V7cf5pSa
 f/u9VktWlmaFz6bD8FZjO+X5rRaa4248A4Idhs8=
X-Google-Smtp-Source: AGHT+IEUSFK4t84WlMkJm1Z9a1IzCc/w4mi6oYcT+0GDsi7EgXalNErnV/U3loE3TmzzCoQUEzM5CA==
X-Received: by 2002:a05:6602:4213:b0:794:d7e8:d239 with SMTP id
 cb19-20020a056602421300b00794d7e8d239mr4205452iob.17.1693438206727; 
 Wed, 30 Aug 2023 16:30:06 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dj14-20020a056602256e00b0077e35ffac2fsm78512iob.32.2023.08.30.16.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:30:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Suchanek <msuchanek@suse.de>, Nikhil M Jain <n-jain1@ti.com>,
 Ovidiu Panait <ovpanait@gmail.com>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Shiji Yang <yangshiji66@outlook.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 7/9] Plumb in universal payload to the init process
Date: Wed, 30 Aug 2023 17:29:21 -0600
Message-ID: <20230830232928.2590178-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830232928.2590178-1-sjg@chromium.org>
References: <20230830232928.2590178-1-sjg@chromium.org>
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

 boot/Kconfig     | 12 +++++++++++-
 common/board_f.c | 22 ++++++++++++++++++++++
 common/board_r.c |  2 ++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 1cefa7d6873..b4b78a8b5b5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -694,7 +694,9 @@ config UPL_READ
 	help
 	  Provides support for decoding a UPL-format payload into a C structure
 	  which can be used elsewhere in U-Boot. This is just the reading
-	  implementation, useful for trying it out.
+	  implementation, useful for trying it out. See UPL_IN for how
+	  to tell U-Boot to actually read it on startup and use it for memory
+	  and device information, etc.
 
 config UPL_WRITE
 	bool "upl - Support writing a Universal Payload handoff"
@@ -705,6 +707,14 @@ config UPL_WRITE
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
index 76ae415487d..716025601c5 100644
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
@@ -841,6 +842,26 @@ static int misc_init_f(void)
 	return event_notify_null(EVT_MISC_INIT_F);
 }
 
+static int initf_upl(void)
+{
+	struct upl *upl;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_UPL_IN))
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
@@ -850,6 +871,7 @@ static const init_fnc_t init_sequence_f[] = {
 	trace_early_init,
 #endif
 	initf_malloc,
+	initf_upl,
 	log_init,
 	initf_bootstage,	/* uses its own timer, so does not need DM */
 	event_init,
diff --git a/common/board_r.c b/common/board_r.c
index 598155c7753..1c1f139430b 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -549,6 +549,8 @@ static int dm_announce(void)
 		       uclass_count);
 		if (CONFIG_IS_ENABLED(OF_REAL))
 			printf(", devicetree: %s", fdtdec_get_srcname());
+		if (CONFIG_IS_ENABLED(UPL))
+			printf(", universal payload active");
 		printf("\n");
 		if (IS_ENABLED(CONFIG_OF_HAS_PRIOR_STAGE) &&
 		    (gd->fdt_src == FDTSRC_SEPARATE ||
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

