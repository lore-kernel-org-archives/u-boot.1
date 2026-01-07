Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ADCCF6BE1
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7385F84042;
	Wed,  7 Jan 2026 01:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BCCyfLJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5485384035; Wed,  7 Jan 2026 01:32:41 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E9E83A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-65e94e128beso221227eaf.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745956; x=1768350756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93lfvt31+bMUtXK2txhANCrj9v9Zo+gqSnDtOo6/3vE=;
 b=BCCyfLJDjCpFMA1H/M9tUp2ISax2hpFJsqf38423huJXjnnbkbA7kPYTbMBM902Z/j
 10zO0lHBsy8GOdvcC9bKHu3BMurKc4hoXYnE1eI7N6aFuLn0CfoSMr+MGB7pbg30BOI9
 uIK6vK0ouRMSvGcRTTVNY0AeS0d666ISgFKH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745956; x=1768350756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93lfvt31+bMUtXK2txhANCrj9v9Zo+gqSnDtOo6/3vE=;
 b=TLJsGAHUEALvT7+BARy1YLlf0iFn6tLFsXma0KZ2LyAB/N3yT2e6EMbqGG26glW4i7
 vUIqQ32uNMcYca9TkLbDhuCxBYP9hO2owXotKflnp1ZOki4rPnlM5/600mF05h5WQ16V
 IG+sDROkcvUIyo6NCnyFzoW6KVhYeOnwfES+r3HQOWrwYdf2NAsro5pPNCWEZonGn5Me
 W99VIQwGjzrr04JVwe/HJCBoiAPA9OUfsDnw8ez9i0yEXi/FZJQway0i0JTFDI44/jg1
 hcees5h2ug35bf2lforD5gB0u03ZCfVvjTSD5A8RtlkpgwcL1vjNJZVslFIiv7V3efzn
 9tUA==
X-Gm-Message-State: AOJu0Yw/Ct6C8lOvgfOOVnHj1iUz2rrq5LuFStExKs8kPx/I3o+Q5rqN
 3zL/c1kRnllA1uRgqIDiZz05wdP58zGAF+egHJ1/1LZSc0Hta2zaQ9l5OSbyRLEqdBwV/MZbHKF
 Z2C8=
X-Gm-Gg: AY/fxX6hgRqAdim15ATbSHnbG1famV0HZP2M5mS47CFusjRp1eg8msZz3OKv+J2ojdG
 aIedFkckjat6NWfShckxCHCYPZ0+RAllka7iENAcQ608KPx8ChSfOonsgPURztpXY46G7nn91Cc
 AHInoUmngAuiBDU3557sHoHA6Dtwpv7dNh/DL8lC7Kep51E6LGkW8fPujKRo0qOtsd5X121FdfG
 nAmin94Zi2+lmhzvvoUDr3gQik4JhhswffjuiNR1Fjy3M4373A8L+16/CljMvVxYw/seg7wjgXj
 aRvFo77d5jzvr9gpegRjbnA3cvhjiPveFj0GspE5SGaE25xYs5rPZmzDdbYpq3M3zQN+m+4YkrP
 SdZ8u1JsPHuRyeoNMx/DeWzzS7Nhvx2++hca0vTJakFflWKsGNj93hc/QmmMudE/v7A0MZq8UMt
 jr+UNdnOedVRnVcpwD
X-Google-Smtp-Source: AGHT+IHjDW5u63d5Epw2vgOhN/COkTVsKmaAgvfEBbH4Df3yvD7rnUsy5/WQ+IPYFP54kP8ato3kbw==
X-Received: by 2002:a05:6820:4903:b0:65d:38e:40f2 with SMTP id
 006d021491bc7-65f545b30dfmr380929eaf.2.1767745956130; 
 Tue, 06 Jan 2026 16:32:36 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH 05/10] bootm: Do bootstage processing in bootm_final()
Date: Tue,  6 Jan 2026 17:31:22 -0700
Message-ID: <20260107003131.3064800-6-simon.glass@canonical.com>
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

Mark kernel start before booting. If enabled, show a bootstage report.

Signed-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 boot/bootm_final.c   | 6 ++++++
 test/boot/bootflow.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/boot/bootm_final.c b/boot/bootm_final.c
index 71661334e11..dd7cac55f1e 100644
--- a/boot/bootm_final.c
+++ b/boot/bootm_final.c
@@ -6,11 +6,17 @@
  */
 
 #include <bootm.h>
+#include <bootstage.h>
 #include <dm/root.h>
 
 void bootm_final(enum bootm_final_t flags)
 {
 	printf("\nStarting kernel ...\n\n");
 
+	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
+
+	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
+		bootstage_report();
+
 	dm_remove_devices_active();
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index a56435d053f..80adc074070 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1381,7 +1381,7 @@ static int bootflow_efi(struct unit_test_state *uts)
 
 	/* TODO: Why the \r ? */
 	ut_assert_nextline("U-Boot test app for EFI_LOADER\r");
-	ut_assert_nextline("Exiting test app");
+	ut_assert_skip_to_line("Exiting test app");
 	ut_assert_nextline("Boot failed (err=-14)");
 
 	ut_assert_console_end();
-- 
2.43.0

