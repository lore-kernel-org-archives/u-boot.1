Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBDEC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54B0982AE2;
	Sat, 10 May 2025 15:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lln53nlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E0F82893; Sat, 10 May 2025 15:43:43 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B3C82B33
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ace94273f0dso580473266b.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884620; x=1747489420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60OaQc3vtPxx/+o0EDS7vHOq5TOmQHdMZzviUKeEmtE=;
 b=Lln53nltxvYhTIYQio68GoD10gYNsRcWhissKLtyOsg6U/8L3ImMAyXQEQV2OGeCpa
 hPno24otnnZ1LuJ0WcFlbP7GL+e4ggIsDmXSdEOwbCgZtvj6XKYRStXBgXMyADTHazlD
 GbwFbPBZeTDKLY5+qh2pC1FqaOuAu73+7MJe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884620; x=1747489420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=60OaQc3vtPxx/+o0EDS7vHOq5TOmQHdMZzviUKeEmtE=;
 b=rsOZcGqAJ8pFOMFVqg5U0KA/WGtg14VGTzIFic/zFL+qk5LGZH/4KeJrf9aXpuQv9y
 g7D0bHXXyKVBo7++BqJb9B2I/pYDbumjFHgTJfwYhkmNkFgOnV//z2jt6wWQZO3EOgT5
 hS0fZnyaubvtayM75JyMNri/uroCIZDyC379WwjdRNz5+DMDGK1jCv+JQ4aB4w3naY/3
 WCnsD99whDwoNCk8tcWnYSYIrgymYSiZzsQ8xRJlTRJ0S3Nj1bPhSEFhhmsG5jJDiu3r
 Xgz+y6AUTje6lYyxVPUfxtwz61ahKxO5xra6dkdYv+s36JF26U6mGadWy9PEY/6T5i73
 R1fQ==
X-Gm-Message-State: AOJu0Yx8fnnC0ygzmOJ9OjDSa/waukjisIxqNhXikl+ffmDgWwC6ySrD
 cJq94L2VYbiLmwQE9myUq+X9eHMHBo9Fze2TBgmmrZUffUOoY9FPvugVjNo+8AKnoVAyKm4fWM3
 DSLBbBrrkjA==
X-Gm-Gg: ASbGncvQWCaIM5rBGVVTJnOaYH1nFvfUOeu6lmwYXeBVaqUfmcS1xWVjR2LKZBZS+rh
 QfiBvcJVu3BZ1J/yTN2jLGUXAV4bLtTkICwqEBPdOJP9Qb42m95+R86KXOYvZWQFmuWLJQHcwbA
 Z8UljDyAlSEo6sAGODtSwiguAWvfGOMSRk1RMhb1OdoFXwFQNbx12gOFNbQf4ETH7HJ5DDIqrE2
 GBtuuY0vCofAiTAm/gwG7PTsLUHLDqo4ZimQ8BxJWEYDBo18OHG+eJOr01EKaqNyhzNF/pmSR/s
 x83U97S2IDnJIw896LeLD5I2sQk/NaYO9A5p0ffiAWIM7MUgGgHyyBqFXHjAJvYnyBFr
X-Google-Smtp-Source: AGHT+IHv98l6ZHlNJ2xfdPDwBHNkBl34AympaKRn/XvzJdGXOAKnDjh5zowkny/fDktpzoude/8mqg==
X-Received: by 2002:a17:907:c80c:b0:ad1:d396:130 with SMTP id
 a640c23a62f3a-ad218f23b9bmr564680066b.24.1746884620427; 
 Sat, 10 May 2025 06:43:40 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:43:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: [PATCH v4 06/22] fdt: Redo devicetree setup
Date: Sat, 10 May 2025 15:42:04 +0200
Message-ID: <20250510134253.1581164-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

The existing logic for handling receiving a devicetree from a previous
phase is quite complicated. Simplify it in preparation for introducing
standard passage.

Add a Kconfig called OF_PASSAGE which indicates that the devicetree
must come from standard passage.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v4:
- Drop now-unused label

Changes in v3:
- Add new patch to redo how a devicetree is set up

 dts/Kconfig  |  8 ++++++++
 lib/fdtdec.c | 35 ++++++-----------------------------
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index c544f948a15..57101bddabb 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -159,6 +159,14 @@ config OF_EMBED
 	  and development only and is not recommended for production devices.
 	  Boards in the mainline U-Boot tree should not use it.
 
+config OF_PASSAGE
+	bool "DTB is provided by a standard passage, in a bloblist"
+	help
+	  Select this to read the devicetree using the standard passage
+	  mechanism, i.e. from a previous phase in bloblist using arch-specific
+	  register conventions. If enabled, the previous phase must provide
+	  the devicetree, or U-Boot will not function correctly.
+
 endchoice
 
 config OF_INITIAL_DTB_READONLY
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c7..8559616873b 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1689,35 +1689,13 @@ void fdtdec_setup_embed(void)
 
 int fdtdec_setup(void)
 {
-	int ret = -ENOENT;
-
-	/*
-	 * If allowing a bloblist, check that first. There was discussion about
-	 * adding an OF_BLOBLIST Kconfig, but this was rejected.
-	 *
-	 * The necessary test is whether the previous phase passed a bloblist,
-	 * not whether this phase creates one.
-	 */
-	if (CONFIG_IS_ENABLED(BLOBLIST) &&
-	    (xpl_prev_phase() != PHASE_TPL ||
-	     IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
-		ret = bloblist_maybe_init();
-		if (!ret) {
-			gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
-			if (gd->fdt_blob) {
-				gd->fdt_src = FDTSRC_BLOBLIST;
-				log_debug("Devicetree is in bloblist at %p\n",
-					  gd->fdt_blob);
-				goto setup_fdt;
-			} else {
-				log_debug("No FDT found in bloblist\n");
-				ret = -ENOENT;
-			}
-		}
-	}
+	int ret;
 
-	/* Otherwise, the devicetree is typically appended to U-Boot */
-	if (ret) {
+	if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
+		printf("Previous phase failed to provide standard passage\n");
+		return -ENOENT;
+	} else {
+		/* The devicetree is typically appended to U-Boot */
 		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
 			gd->fdt_blob = fdt_find_separate();
 			gd->fdt_src = FDTSRC_SEPARATE;
@@ -1752,7 +1730,6 @@ int fdtdec_setup(void)
 		}
 	}
 
-setup_fdt:
 	if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
 		setup_multi_dtb_fit();
 
-- 
2.43.0

