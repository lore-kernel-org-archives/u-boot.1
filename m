Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D38CC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F14807EE;
	Mon, 20 Jan 2025 22:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KGOmj92E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE1E8082D; Mon, 20 Jan 2025 22:54:14 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34D9080771
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844e9b8b0b9so395169739f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410050; x=1738014850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzYttPDtL4GoVICW3W9I+OcmB3ANq5iAs76otxgKSrk=;
 b=KGOmj92EJEixDnPcsSf/u5um2cPrhLyLrP0XA+dDX1WZDbCCkXeM9LUOjHBh2SKir6
 tfgKbMRCTs46QaeWODaWi5/2IKE/5hE1z6pgJyWHXucpTwEqKyotdyy6rqnC64KHH8z1
 S/Cx7aBvo4wnihwSPG7DqIV3N4sF7gZi6hnkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410050; x=1738014850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dzYttPDtL4GoVICW3W9I+OcmB3ANq5iAs76otxgKSrk=;
 b=sYM9v+YTGrkaoBpSm0OCBsHeRgPKjfUUcpwZXiZ1oXP0B3qsUbI+2gRXhJ2BVXp67p
 VVG5iA4/6Ry/UsA84XJ5vJqOXungSjyQ9LKFBqIL4w3gw0PUgSmExo3IglvkjNjuysqY
 o52r6QFaSwFLJfeZppZtckZbxPU/OTpRpNvsqr4g31+WlalyTclZN0r+9VkHLpqudSkb
 qhud4rRtfcoIyhJjFH3ckij46AeKyZiNJBPl6nONuYtP8Y16dvn4HRcA5l+QdL1uSEda
 m6YTlr/cjKSmYZld5NhF1fO8EUo+zhntEZWXzMnbakMzUtsjw2c0v1zdpZmDDC1kT82b
 r+FQ==
X-Gm-Message-State: AOJu0Yx8QYYG9ZOB0K3ue0OteNjoI0kzl4vuRTANRae83tBtw9hZi5NP
 UlDZQd84CxAJbYrlP75hZT8i15thOHKXvbVXadkXJCXJfLRwK7I/Dh/iBf7EQ+FW8b9FADQs1pY
 =
X-Gm-Gg: ASbGnctVfmWgWxx2zIKMHdCxArvDMf9wpmo/t9GlTjwWwn203K7aOkds4MTsbuHeS1U
 HYqXt5WIlW1G4r6YVTppdtGDjrKNEUfhdXS7I5N3yn7RtGUqyfcjZwF9SDJAdY1U7H+kipocimz
 jf55TceHjIFCIA+/Y5SG0HYL6B0iHcYeV8SXuPHcU2KcfxVMjHpBK6wkMSYYhlwXbiDKRRbrXsL
 0KekzlrDyZmqXZubK5O7kbN6NVnoll8lnoo1JI91SSLRNzVcfKMlzZ6Q7zBCic4WOM6t4YTXfm8
 VYA7PEHLArV+Le1acMnK53ncQ2nrLhI=
X-Google-Smtp-Source: AGHT+IHhBNJbx6WEE5z/T8vklaHt9WcbVxjWnRV0Tu1/9eWA9g07ebSVAFskUjtEnQM/lzz+mJtm6A==
X-Received: by 2002:a05:6e02:13a8:b0:3ce:7cf3:27be with SMTP id
 e9e14a558f8ab-3cf743e096amr124328535ab.4.1737410050447; 
 Mon, 20 Jan 2025 13:54:10 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/28] test: Move fdt_overlay init into a function
Date: Mon, 20 Jan 2025 14:53:12 -0700
Message-ID: <20250120215340.617194-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

