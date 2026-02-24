Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ABFF357AD
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF82383E96;
	Tue, 24 Feb 2026 15:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fji+j2Wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D02183EF9; Tue, 24 Feb 2026 15:26:33 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C2A883E1E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-46413b2c3d8so1799989b6e.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943189; x=1772547989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RYKOEEBrOK2LPI7YJ6jpuAWkCaypv6eWL7MkKEABUQ=;
 b=Fji+j2Wf6RGplC1GQDsHMENa/wc+sKdYHCypGdxBDE9JpUX6SfHEVyd4yA7HfRskw0
 +WaImJvaZB6wOvjfKYAzxl7SKqmfsJ/ouYWXIM+TVleU51IaB8ZUUiTNc+LjJHglgnTy
 h2IEFUFafB/iaF1xh8T2l/KgkyqYqDsfxz7Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943189; x=1772547989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4RYKOEEBrOK2LPI7YJ6jpuAWkCaypv6eWL7MkKEABUQ=;
 b=sp8gKV1uXWbnODHcGy3i+dTQB5xls8LrbPbe1Tu5f5ec4L+1aMcJ9bSjCUl7ARbKoj
 e0vNMzHxyaOJ0bzIxL0lpl6HpaH8k18a7mg3aYGjOQqXD3OO+ex7HaTW1OPfeSyyX68z
 HrHYPbC1qOVhU3mbxFClGgtz/wWaHX/yBqdCDbySvegyvqhYko02dwu1j1ceKqD2dl1a
 MK16f23gXtX40uQus4a49oaN+10bt+Hqq0s8/WanmqgceA3u3urGyC0jNoS00KCq+eQb
 TNIVp2koRjGdjFmU0vwCwqCHGpEESqkvwVspurC5zOx415ZPkC47ruX5A/PqOnAl3ifL
 Hxnw==
X-Gm-Message-State: AOJu0Yz/06HFaeRl5Tkx3Y0VK1bnbmhswzA9ra1NuD2rtfbx7DipgptP
 9a8VFksRm5xz6UjVj5oG34f6H+zwYNzlLvT+reb1Tc9u4HddaYBnoNIbbnEtE5D4yoDIDkHwnwr
 UiGo=
X-Gm-Gg: AZuq6aL9b9EQ4+b6TJyAdYOGTiZ7MFI18xS7PvldB2miCePPUSlRdEKLluvKFqioRlR
 67PaDvGiI8iZX6eZwgHdiQYVhei0OpWTrT9+ZRHQuYKAIJgx75suy+85OcxQTfqNGW5DGlXDzdJ
 +UQS2n9rDBlg2yqLSzvw+FiZs0mgZtaxUnRgSc8S7K5hb/o4mHdeH0BOwtKnsHwugJXbUNRxkpQ
 g0UM3IUoql2lN7ZpjBN7vQYBW4gArajRAzLl3PJ3IymU+B4GKt/IXaX2JpKNSqz+/z//WZVzb+e
 2qeEgK9GFMXfp/D35/r3P0uBNUvx9HVqu+DXDvc7Oh7Uw0px9+DJaTp/oC1PY40gK+JMK3UqQdT
 4esRsa3d5yRLp2wIBaqiN93IzCsjQEhJjA9akq4MBRk7dSCZbiWkYGEq0n7WFZoqC3cDbSuVAFh
 YTem+E0Qsiijv/slvUfob2Y2k7I9+hRw==
X-Received: by 2002:a05:6808:4f06:b0:464:3557:a73 with SMTP id
 5614622812f47-46446139355mr5907610b6e.11.1771943189480; 
 Tue, 24 Feb 2026 06:26:29 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/9] bootm: Do bootstage processing in bootm_final()
Date: Tue, 24 Feb 2026 07:25:47 -0700
Message-ID: <20260224142553.1608883-6-simon.glass@canonical.com>
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

Mark kernel start before booting. If enabled, show a bootstage report.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Drop the EFI change

 boot/bootm_final.c | 6 ++++++
 1 file changed, 6 insertions(+)

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
-- 
2.43.0

