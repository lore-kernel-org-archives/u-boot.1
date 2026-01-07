Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB15CF6BE0
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D1D83C4B;
	Wed,  7 Jan 2026 01:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q0rNptyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D62F983C4B; Wed,  7 Jan 2026 01:32:28 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA36E83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3ff4acb6eebso990724fac.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745945; x=1768350745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4fxMcBguZaediD/yk5mxYC7Py9Vend02aEKVYMiHT0=;
 b=Q0rNptydV2FKVd1H9ILrpxn90PmyRYLVVhTlKgSY0qqXlmi3W+u4jnE1QtOgwCZg90
 TpVm6F606YdHkvDGWA+9Dh4Fbh4KTN0s2rgDoNwwqPo6bRSKYJwz0NyEYi4eR2iAKK6B
 I3EKlwkfqZPOFRwq8ca/RetKpu0E8S0yRheuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745945; x=1768350745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n4fxMcBguZaediD/yk5mxYC7Py9Vend02aEKVYMiHT0=;
 b=ajup16tezAw0+onQErCyeILSGfHZnj6BYBSl94qbg9BfkcQbicOyUCalYmIApwD1or
 mj8+s1KJ13xMZuj7ZS4aN4WA1hMoikJRJYqTSCHtIm2LbQ/HHvpCdnUj/RLUieURRDoM
 bDHucBIG0mAHYwC79ZuOp74fOIvyaDjjUSysiiSHfEr2WaPHiSQxYUiTQT/FUrQB5e2s
 fen6K6fYHzbqwwtmGvR6GWVfWMH+HOp/HGXXGSve9MwhG85SY3knQCvZEcySSBKWXt7V
 o4HuH0Rujp41JHuoSfG9o8yVUQvLy3f0tu5S9/kaDEmAZVnRp5PbJUklQnY6fy1KjAdV
 fd+Q==
X-Gm-Message-State: AOJu0YwHMC5xNy5I2tW/TSvPB0IuUR2otiNp7UcD6i3FzebJJDOfYLwJ
 2nhky00JGG6vQpQw3gh0sTw5f+XV79oxcr1LT/lqDtFLK9w17d+I283gG589mPjdWrdByWKt9Um
 EGP0=
X-Gm-Gg: AY/fxX5Lq2uL+QzD/fol88dim6kasRabeCpyvGWfRYi8PhCrpjMqiRvBtUkG6Yhw7+D
 RTFmEuhW1W1BAADW7mDfaazuFHoIZsDiBHeNhsJazAMGugJryr9iWLGnRxpgEMAJ/+9gfQ1Jlfr
 x3SqoswiYpZqByjKRnXWaircG24PzLJEQCzEmRVrzqI5xNAzZuQGhPgbKQelm8rZ+CYH/qlxcaC
 FNawbNaVGjwut+jiRbRXQ9Cp62FtdJV/iPOx7x8SRCpiEY284PcbTERIuDj8k76BadGJb9icVWr
 DPfV+Nhjyxc3ObhUCmM8WXfU6Da7Q10AhFa/8lzvPKmUqDTQWCGpYwa03qSBQ4M4xMdi/69F84c
 d4x8Y4dQ5IUQWnUNg9zw5aSEqETUkr1JZ1sVvTzm4uIyvZhF/nJHFMAiAiJv72DlpyHZpabmqHb
 /8AISwimr7bl8mjCGi
X-Google-Smtp-Source: AGHT+IEWIslz068y4NNxrTyQTrkWO3KsDvHhjuO8/UwlQFDzxtnytFbVTtjxgJjYCaIESmtFK69I6A==
X-Received: by 2002:a05:6820:162b:b0:65f:54c7:3c76 with SMTP id
 006d021491bc7-65f54ec6c0fmr345065eaf.5.1767745944787; 
 Tue, 06 Jan 2026 16:32:24 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH 01/10] boot: Create a function for final pre-boot steps
Date: Tue,  6 Jan 2026 17:31:18 -0700
Message-ID: <20260107003131.3064800-2-simon.glass@canonical.com>
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

There are various functions which announce that booting is imminent and
do related preparation. Most of these are arch-specific.

In practice, most archs do the a similar thing. It would be better to
have a common function, with perhaps some events for things that are
really arch- and board-specific.

Create a new function for this. For now, nothing uses it. Be careful to
avoid using BIT() macros which are not available with host tools.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 MAINTAINERS        |  1 +
 boot/Makefile      |  2 +-
 boot/bootm_final.c | 12 ++++++++++++
 include/bootm.h    | 17 +++++++++++++++++
 4 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 boot/bootm_final.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ce73d83f4..f0bd2562f77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -981,6 +981,7 @@ M:	Simon Glass <sjg@chromium.org>
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

