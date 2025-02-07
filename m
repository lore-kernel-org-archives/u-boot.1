Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A75C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FA6980A55;
	Fri,  7 Feb 2025 19:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dcuIuXDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF2980A23; Fri,  7 Feb 2025 19:32:01 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D6580BA3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844e7409f8aso68249339f.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953117; x=1739557917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgDlTRlVoI8MxhopdwaOZqIkJ31QWXNeCfSVf4c8Ae0=;
 b=dcuIuXDdhOx561joQzXW8mbydkdgbsqKW5KCBH8UDPVJn2OVCTB9LrMKL0GzFFQUwY
 E5YRAqfh0hVPKdLD2ghbgesHUz404R/Dhr0YbHZEccXUCTjwwFgvmrZUkPjGVEaceIm4
 okS55biMFj7tJj/g7ySgFP+8imhDDZ5gTKmtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953117; x=1739557917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgDlTRlVoI8MxhopdwaOZqIkJ31QWXNeCfSVf4c8Ae0=;
 b=QgVzymq9wYmBxg69p3SVVTCgyITvToDQozsqsw/TwjGEY2IngY5SrBqNL89sw4Sp2g
 GX1iP7M6659OuJyK920v1yoXyKrijIDvtYA+BWluhnt4dMr60lTD8hpC69aoSAmabcKl
 W6WR2tWNFbkCrdbyLNixbxJx6W99lg77ux7bFBpVh+w4kOOj1XLYU6XfqNcWqYU1xcu3
 lUJdP2BqyVIltTAhTrkH3+RBLD6XI0DsmEGeRAO313pxPzocQWqfx4/M0QYgn2AOyzcS
 qvucL9cvl0ZuVe9szAiKuU1f8Q678SKt1hWtSWVDfGtsoZrWZQdF/o77MaNDYt/WPtoO
 sfwQ==
X-Gm-Message-State: AOJu0YxHk69AwL/0/VYKaTXIGuAwM5KUiHFD3a09fjXE/0ypJukiospB
 NluV4oWemjH01LJcKVWaJTrWzqdN5MGU7hGBCHaVC2aoHH3MB2CUo2kdgVUxlI/vGhzDxxQJkbU
 =
X-Gm-Gg: ASbGncs41W/ulKaM86IUmVrkbZzFsm8hQfpjDaLwf0rMDQoqy9Wg0ijjkXvY/mqlh+u
 rz1EhnrfFeJZDTgnf71qlTfGuu3ai5rdwGMCM5JuiE4PysZ9ExpAwYqFkBfAVjOdg+E8/A07vZH
 IOPNlNwmOhmn+admDV6V2epcZP+d6x61MfUOUcQe5aN6HYc+ECv66zHpkOU75PsCzvXPC04UKZo
 FF2lKk/7pehsDLrDTDv7sBTsvi3ROTd2Z2pu1myk+/+6X1RLYn+fHknzFoaLOFOPK5Ybnc/kwyB
 Qn5wSNuQToRywW1t0d44y3OQCOKgmlW1INOZM1sS/Hbry+622PCl
X-Google-Smtp-Source: AGHT+IHV9oSwDTNjJemlNFjF7neVYAaCvPG+VFHdUQ0GvcMEYIaTg3QcgSxTVGNZL5+t2GsbVNX/3Q==
X-Received: by 2002:a05:6602:4895:b0:84a:7906:eeb7 with SMTP id
 ca18e2360f4ac-854fd7982b3mr442178639f.0.1738953117338; 
 Fri, 07 Feb 2025 10:31:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/29] test: Move fdt_overlay init into a function
Date: Fri,  7 Feb 2025 11:30:44 -0700
Message-ID: <20250207183121.117663-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

Move the init code into a separate function since it is quite large.
Adjust it to use unit-test functions which have become available since
the test was written.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/fdt_overlay/cmd_ut_fdt_overlay.c | 113 +++++++++++++-------------
 1 file changed, 57 insertions(+), 56 deletions(-)

diff --git a/test/fdt_overlay/cmd_ut_fdt_overlay.c b/test/fdt_overlay/cmd_ut_fdt_overlay.c
index 9fe18b60aca..e4ed7de850c 100644
--- a/test/fdt_overlay/cmd_ut_fdt_overlay.c
+++ b/test/fdt_overlay/cmd_ut_fdt_overlay.c
@@ -26,6 +26,61 @@ extern u32 __dtbo_test_fdt_overlay_stacked_begin;
 
 static void *fdt;
 
+static int fdt_overlay_init(struct unit_test_state *uts)
+{
+	void *fdt_base = &__dtb_test_fdt_base_begin;
+	void *fdt_overlay = &__dtbo_test_fdt_overlay_begin;
+	void *fdt_overlay_stacked = &__dtbo_test_fdt_overlay_stacked_begin;
+	void *fdt_overlay_copy, *fdt_overlay_stacked_copy;
+
+	ut_assertok(fdt_check_header(fdt_base));
+	ut_assertok(fdt_check_header(fdt_overlay));
+
+	fdt = malloc(FDT_COPY_SIZE);
+	fdt_overlay_copy = malloc(FDT_COPY_SIZE);
+	fdt_overlay_stacked_copy = malloc(FDT_COPY_SIZE);
+	ut_assertnonnull(fdt);
+	ut_assertnonnull(fdt_overlay_copy);
+	ut_assertnonnull(fdt_overlay_stacked_copy);
+
+	/*
+	 * Resize the FDT to 4k so that we have room to operate on
+	 *
+	 * (and relocate it since the memory might be mapped
+	 * read-only)
+	 */
+	ut_assertok(fdt_open_into(fdt_base, fdt, FDT_COPY_SIZE));
+
+	/*
+	 * Resize the overlay to 4k so that we have room to operate on
+	 *
+	 * (and relocate it since the memory might be mapped
+	 * read-only)
+	 */
+	ut_assertok(fdt_open_into(fdt_overlay, fdt_overlay_copy,
+				  FDT_COPY_SIZE));
+
+	/*
+	 * Resize the stacked overlay to 4k so that we have room to operate on
+	 *
+	 * (and relocate it since the memory might be mapped
+	 * read-only)
+	 */
+	ut_assertok(fdt_open_into(fdt_overlay_stacked, fdt_overlay_stacked_copy,
+				  FDT_COPY_SIZE));
+
+	/* Apply the overlay */
+	ut_assertok(fdt_overlay_apply(fdt, fdt_overlay_copy));
+
+	/* Apply the stacked overlay */
+	ut_assertok(fdt_overlay_apply(fdt, fdt_overlay_stacked_copy));
+
+	free(fdt_overlay_stacked_copy);
+	free(fdt_overlay_copy);
+
+	return 0;
+}
+
 static int ut_fdt_getprop_u32_by_index(void *fdt, const char *path,
 				    const char *name, int index,
 				    u32 *out)
@@ -215,67 +270,13 @@ int do_ut_fdt_overlay(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 {
 	struct unit_test *tests = UNIT_TEST_SUITE_START(fdt_overlay);
 	const int n_ents = UNIT_TEST_SUITE_COUNT(fdt_overlay);
-	void *fdt_base = &__dtb_test_fdt_base_begin;
-	void *fdt_overlay = &__dtbo_test_fdt_overlay_begin;
-	void *fdt_overlay_stacked = &__dtbo_test_fdt_overlay_stacked_begin;
-	void *fdt_overlay_copy, *fdt_overlay_stacked_copy;
 	int ret = -ENOMEM;
 
-	ut_assertok(fdt_check_header(fdt_base));
-	ut_assertok(fdt_check_header(fdt_overlay));
-
-	fdt = malloc(FDT_COPY_SIZE);
-	if (!fdt)
-		goto err1;
-
-	fdt_overlay_copy = malloc(FDT_COPY_SIZE);
-	if (!fdt_overlay_copy)
-		goto err2;
-
-	fdt_overlay_stacked_copy = malloc(FDT_COPY_SIZE);
-	if (!fdt_overlay_stacked_copy)
-		goto err3;
-
-	/*
-	 * Resize the FDT to 4k so that we have room to operate on
-	 *
-	 * (and relocate it since the memory might be mapped
-	 * read-only)
-	 */
-	ut_assertok(fdt_open_into(fdt_base, fdt, FDT_COPY_SIZE));
-
-	/*
-	 * Resize the overlay to 4k so that we have room to operate on
-	 *
-	 * (and relocate it since the memory might be mapped
-	 * read-only)
-	 */
-	ut_assertok(fdt_open_into(fdt_overlay, fdt_overlay_copy,
-				  FDT_COPY_SIZE));
-
-	/*
-	 * Resize the stacked overlay to 4k so that we have room to operate on
-	 *
-	 * (and relocate it since the memory might be mapped
-	 * read-only)
-	 */
-	ut_assertok(fdt_open_into(fdt_overlay_stacked, fdt_overlay_stacked_copy,
-				  FDT_COPY_SIZE));
-
-	/* Apply the overlay */
-	ut_assertok(fdt_overlay_apply(fdt, fdt_overlay_copy));
-
-	/* Apply the stacked overlay */
-	ut_assertok(fdt_overlay_apply(fdt, fdt_overlay_stacked_copy));
-
+	ut_assertok(fdt_overlay_init(uts));
 	ret = cmd_ut_category(uts, "fdt_overlay", "fdt_overlay_test_", tests,
 			      n_ents, argc, argv);
 
-	free(fdt_overlay_stacked_copy);
-err3:
-	free(fdt_overlay_copy);
-err2:
 	free(fdt);
-err1:
+
 	return ret;
 }
-- 
2.43.0

