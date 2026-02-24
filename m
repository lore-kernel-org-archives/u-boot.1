Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4B2F357AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27EF83D3D;
	Tue, 24 Feb 2026 15:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J2EajYJj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A333783E63; Tue, 24 Feb 2026 15:26:26 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C10783D3D
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45f10d7eb81so2174824b6e.3
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943182; x=1772547982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBcsoJNFnKy3A/unPBidag5O1euYThAXR/8KFzoye0o=;
 b=J2EajYJjb5Oh+hydHIE5VrBo1GgSWkd+SGNSZ+G4kTlqNJ1hjUt5GyD1BSkgkyOK5s
 FwmL/JRnOP48FIGxybvYbhI4kRkk2EudeHvcWX8gkvjVUTyEmLxoS5NmMdPa5TGr9qNS
 9Y6kpn3uVSKc0MQpTL/3sW6Er3yypIH8PnPSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943182; x=1772547982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FBcsoJNFnKy3A/unPBidag5O1euYThAXR/8KFzoye0o=;
 b=bMmCiMRbN9aDT1hpvXBNtCjr7l5/i67BiqBD3q4BGWmWClcuI0tw1enrqNa97iboMa
 wfqk7MO9hIpn3w8bRH9J2lyUadMEI7sXcitZHRi14cN1ExadSsSlJrwNacR/5yb8zgtY
 6nKskW/gYRfe6lfmahnDoSOEoIIuqQSGAKZFeSda0rYBhZy0viG08R3YiMdNiRngPz2k
 dlYckjiBEO9kZ3yE3auPQh+LjYybzKu/8/kEnodCvlqm4Jc+YkNt3RT37vzp1kkN1aI/
 7aFl7YbfJs3YVtqmExqynbau2ceOhGjPJ5PupFjDbv4ha7tWFSjG5tZm4+V76OoIUEP9
 Befg==
X-Gm-Message-State: AOJu0YzeXfJMTZCOWGbipDsS422sjVOpJnK6eKEiRB0R112ApaDvvflJ
 EWZUece7scEaKy7tVXHkTxN8sdMZJ+gYt+42ukq56NPyDmDn7mPhMUhmQs76wO1+juu/1FKJgi0
 8wo4=
X-Gm-Gg: ATEYQzwAVn+CDBtQYFltgrdnEmYfsDVD9bWk+JI7KGALWAiUr9jycxuwEJTG3u94iSg
 KPHoZi8TYUclPgj2kCERwXzoz1ZL5g95W8G7ANTG2VzNoawZvgvgVx07DYh20VC+pSHRTtuhdSO
 o5dz1CV9+4LzaBeFi8RSpj5lVfsS5Hl9azlCFbTRbju7YtGLqcdJufZsJxjyksPT2RomIqV/09/
 tkRNcoVVn+lX7GtYRWHbQ6GPft0jzp0ZE3spD4Z92ZyA5O4GO8NrwacZHdBa04hDb2N5ghfAi71
 swrwk+asDUCsVvWDWxq49FMPL0dm3S32lonuOXQNkwyF8lFYJpzjcWAUBTkg6/PndrQsYvLLRMi
 mjSqMx+lW/bhTtY7hnKLQKt20FMj4NAHo7tG3g/a6ko+qtOrcyjtWq7LH3bMMJqn1u1T5XmdkST
 fWsvNAgV5f2v0LdsMmpxqwGRruCbxwNQ==
X-Received: by 2002:a05:6870:7193:b0:40e:e60d:16dd with SMTP id
 586e51a60fabf-4157b18bdddmr6056577fac.48.1771943182549; 
 Tue, 24 Feb 2026 06:26:22 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH v2 1/9] boot: Create a function for final pre-boot steps
Date: Tue, 24 Feb 2026 07:25:43 -0700
Message-ID: <20260224142553.1608883-2-simon.glass@canonical.com>
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

There are various functions which announce that booting is imminent and
do related preparation. Most of these are arch-specific.

In practice, most archs do the a similar thing. It would be better to
have a common function, with perhaps some events for things that are
really arch- and board-specific.

Create a new function for this. For now, nothing uses it. Be careful to
avoid using BIT() macros which are not available with host tools.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

(no changes since v1)

 MAINTAINERS        |  1 +
 boot/Makefile      |  2 +-
 boot/bootm_final.c | 12 ++++++++++++
 include/bootm.h    | 17 +++++++++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 boot/bootm_final.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f8d4f6ee8b2..beebb491f28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -983,6 +983,7 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	boot/bootdev*.c
 F:	boot/bootflow.c
+F:	boot/bootm_final.c
 F:	boot/bootmeth*.c
 F:	boot/bootstd.c
 F:	cmd/bootdev.c
diff --git a/boot/Makefile b/boot/Makefile
index 7fb56e7ef37..12477fabe28 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_PXE_UTILS) += pxe_utils.o
 
 endif
 
-obj-y += image.o image-board.o
+obj-y += image.o image-board.o bootm_final.o
 
 obj-$(CONFIG_ANDROID_AB) += android_ab.o
 obj-$(CONFIG_ANDROID_BOOT_IMAGE) += image-android.o image-android-dt.o
diff --git a/boot/bootm_final.c b/boot/bootm_final.c
new file mode 100644
index 00000000000..15ddbbe5e74
--- /dev/null
+++ b/boot/bootm_final.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Cleanup before handing off to the OS
+ *
+ * Copyright 2025 Simon Glass <sjg@chromium.org>
+ */
+
+#include <bootm.h>
+
+void bootm_final(enum bootm_final_t flags)
+{
+}
diff --git a/include/bootm.h b/include/bootm.h
index 4060cec7fc0..32711eabb2e 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -16,6 +16,16 @@ struct cmd_tbl;
 #define BOOTM_ERR_OVERLAP		(-2)
 #define BOOTM_ERR_UNIMPLEMENTED	(-3)
 
+/**
+ * enum bootm_final_t - flags to control bootm_final()
+ *
+ * @BOOTM_FINAL_FAKE: true to do everything except actually boot; it then
+ *	returns to the caller
+ */
+enum bootm_final_t {
+	BOOTM_FINAL_FAKE	= 1 << 0,
+};
+
 /**
  * struct bootm_info() - information used when processing images to boot
  *
@@ -321,4 +331,11 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
  */
 int bootm_boot_start(ulong addr, const char *cmdline);
 
+/**
+ * bootm_final() - Announce and do cleanup before boot
+ *
+ * @flags: Flags to control what this function does
+ */
+void bootm_final(enum bootm_final_t flags);
+
 #endif
-- 
2.43.0

