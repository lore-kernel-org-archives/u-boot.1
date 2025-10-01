Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0522DCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:30:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23970835FE;
	Wed,  1 Oct 2025 23:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nFqHj54h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D3A83544; Wed,  1 Oct 2025 23:29:47 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D45B80107
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8ca2e53c37bso27127739f.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354183; x=1759958983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPUh3HXPYbW7hW0JISqpZtNEjJXR/8dNrN8Y8tMz8wA=;
 b=nFqHj54hqfoO154V62SjWR49uUCISp5RmU5MZJOz/SHDQca6od8HeRB+srujmY9DQX
 pqb4fmKK4cyAWJyprS7xdrXysJIMnUSWBmiH+lDAQHXqAu6Kn6q9cAHwLhzFtpEDg8pj
 M7E57rQ1p7/Zji6YhbZr4a2jgDFsV+iq+vwfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354183; x=1759958983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPUh3HXPYbW7hW0JISqpZtNEjJXR/8dNrN8Y8tMz8wA=;
 b=uoa5ohMekUKhYjVHaMHgJHvfIFJRWgUunnuGM5PjxIa1+MtbmIuW6Blj1+3hJuyh6f
 L5q0g7ga+ecXwTMpv/PkgXiz0fPq+shHg1DD268+pIDZ1KYgXrd1qzbVxQLwyF/e3e4M
 SRcvLjUlnPMQ8riGt1c/XxlJexgM+lPmEcjoPR4M0VyAlS+Ish7QBeKKSDtxIYYEifOX
 omFmZ+/N4kGB0dbYxqya3J7IV77AgiIY9v8963T7KEeRAdqxDffaG+ahlsWA6gkKQtB1
 wYq65YA9kq2UtA11J0OvTK8zM/8ezg+69tzuY9awAt95v3xBwo1FznlfLO0cPqSyxF6H
 U30Q==
X-Gm-Message-State: AOJu0YzBwhll7WmJHrMEg/YrPM5mCs2buFroC026Ti4MPJLU3ielMPgu
 T9HnG5m1YCxGqMNK71QuGIskwbX7l0gAGnJTYUbCZHHQ1TmHrjvYLHluihNdk1i4fORHaKN2WZM
 p2sM7B2Je
X-Gm-Gg: ASbGnctvqBaQt4rW9SmdfIcyDfTwI52+08fUdhXIz/3QmjHMTukwI9/nsg0eIn8r7Ej
 Rz+ha7h1eb+FJom6xHLAVdFExDWuFbdWxJStbzuVHiW0mQIaWOeNHGcP+cHQcwA4dvJN5FsGNHB
 FqGCcqB2gjFiwE4kW6Qo5pm0B6U1xYy80xn0W8ADk+bclYOV1Os0AaHDXuAXswsvFMLOq5a80I9
 qK2WFO/E8QXyYAVRljtnSUhdAdSM3y7gXT5ReO3+NZ4T7y4AjVah9FfR6y2SGDjK5di5i+HGaia
 Up6WgTtkwWZ27irLOEBuB55JVog1ScNl9QPSPMHVTwhSUOWtWQZZvOd0Qg40xC2XogtLUgezIDk
 XGAPcwOXo+71T2RxN+0UtY4HZWbDgWf/7YUiLTTgg
X-Google-Smtp-Source: AGHT+IHMr+8SHLod8/RD4ytYDkqCNSDdGA9w9lO0/GTHs6G5jDC8xK0Ri02sADF1oPGWQOJ6uZ/frQ==
X-Received: by 2002:a05:6602:4005:b0:876:adf1:b263 with SMTP id
 ca18e2360f4ac-937a9ff860cmr766027639f.6.1759354182836; 
 Wed, 01 Oct 2025 14:29:42 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/17] boot: Add a new test for global bootmeths
Date: Wed,  1 Oct 2025 15:26:31 -0600
Message-ID: <20251001212649.3263574-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

These have different behaviour from normal bootmeths and we are about to
enhance it. So add a test and also an extra check in bootflow_iter()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootflow.c | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 73fe3d34d0f..f6661530848 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -307,6 +307,8 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq(0, iter.max_part);
 	ut_asserteq_str("extlinux", iter.method->name);
 	ut_asserteq(0, bflow.err);
+	ut_assert(!iter.doing_global);
+	ut_asserteq(-1, iter.first_glob_method);
 
 	/*
 	 * This shows MEDIA even though there is none, since in
@@ -388,6 +390,49 @@ static int bootflow_iter(struct unit_test_state *uts)
 BOOTSTD_TEST(bootflow_iter, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 
 #if defined(CONFIG_SANDBOX) && defined(CONFIG_BOOTMETH_GLOBAL)
+
+/* Check iterating through available bootflows to test global bootmeths */
+static int bootflow_iter_glob(struct unit_test_state *uts)
+{
+	struct bootflow_iter iter;
+	struct bootflow bflow;
+
+	bootstd_clear_glob();
+
+	/* we should get the global bootmeth initially */
+	ut_asserteq(-EINVAL,
+		    bootflow_scan_first(NULL, NULL, &iter, BOOTFLOWIF_ALL |
+					BOOTFLOWIF_SHOW, &bflow));
+	bootflow_show(0, &bflow, true);
+	ut_asserteq(3, iter.num_methods);
+	ut_assert(iter.doing_global);
+	ut_asserteq(2, iter.first_glob_method);
+
+	ut_asserteq(2, iter.cur_method);
+	ut_asserteq(0, iter.part);
+	ut_asserteq(0, iter.max_part);
+	ut_asserteq_str("firmware0", iter.method->name);
+	ut_asserteq(0, bflow.err);
+	bootflow_free(&bflow);
+
+	/* next we should get the first non-global bootmeth */
+	ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
+
+	/* at this point the global bootmeths are stranded above num_methods */
+	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(2, iter.first_glob_method);
+	ut_assert(!iter.doing_global);
+
+	ut_asserteq(0, iter.cur_method);
+	ut_asserteq(0, iter.part);
+	ut_asserteq(0, iter.max_part);
+	ut_asserteq_str("extlinux", iter.method->name);
+	ut_asserteq(0, bflow.err);
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_iter_glob, UTF_DM | UTF_SCAN_FDT);
+
 /* Check using the system bootdev */
 static int bootflow_system(struct unit_test_state *uts)
 {
-- 
2.43.0

