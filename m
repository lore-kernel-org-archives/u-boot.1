Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BF6D1813F
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1805A89056;
	Mon, 14 Oct 2024 22:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YHVtG4h+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD87289063; Mon, 14 Oct 2024 22:18:01 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8564E89018
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a39cabb9b8so13302295ab.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728937078; x=1729541878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f3OxPYY3jLtNofPQaHShk0DnP5CxTb2DtCF93vuqVPo=;
 b=YHVtG4h++uzE1EIBPa4XGrKSphv1yHYp5ZgLE1XOeE0x3HEUE2dx+LhJvDS1MhwOjF
 CJvtgOJHkpNkglPVZMdbd4h09sjHKWDgYenWsRS/31fMw7P/lIntLrffojxMrpVMwtXB
 dHMHSyhMRgt+vJxmWRz9w/hmNuVP2xQ65HLAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728937078; x=1729541878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f3OxPYY3jLtNofPQaHShk0DnP5CxTb2DtCF93vuqVPo=;
 b=jR8lwRpZsF84hdSCogCSPsDAhf9ZgQcM9QWZJsarR5lFdnxTN6rXbtkmb0qzmZuWKx
 +1MY/qQRVmMgOqAjfRhHlfe4lqQI6N5oRLW7zH8bX7/atV9CaQfO1388lQadSlHtnDW0
 EgcCJYspaPce7eEvx68xBGEU+xORyoOHvrBE5CNFTnhhiTxVSpH02pB1G7nRruI9XeTP
 qav9cP4DbEV36C3m+dRRlepMuSatFMzsoZmOr7SBjlr4FXqQeNb0OKWUN1XeqxVQZqUq
 hxnu1014q4f9M4coctLdy9biO9AtEGhJD+FXQ+qKv0u3UI27EZdHkl9doQkszsEzBygJ
 ktJA==
X-Gm-Message-State: AOJu0YxDmQ+YJwtgEFkwxrwxZ2hTk3N+sz1tyUKQKuRZtZUS4KeI2jqd
 4ncNJ7yI2nheO5F+b3A5GYK6afn+ByR++9uYvPxA4g7AYvE5STOJdpCPAlTwHsb7l+4vyIVgGg/
 5eg==
X-Google-Smtp-Source: AGHT+IFa+a6j1U5F+giEfpNUEKbsbQoMJrD7Ko3R8NGdDjpcWabYGTxCkNLDkcfwEl/xHyA5kUyrng==
X-Received: by 2002:a05:6e02:164b:b0:3a0:a4dd:683b with SMTP id
 e9e14a558f8ab-3a3b5f683f8mr93701625ab.8.1728937078105; 
 Mon, 14 Oct 2024 13:17:58 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbad9b1061sm6976450173.11.2024.10.14.13.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 13:17:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] test: Drop mention of old flags in a comment
Date: Mon, 14 Oct 2024 14:17:53 -0600
Message-Id: <20241014201753.1902999-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

A comment in test-main.c was not updated with the recent rename. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/test-main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/test-main.c b/test/test-main.c
index 479dbb33b72..ed100eda847 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -294,27 +294,27 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
 	 * Remove any USB keyboard, so that we can add and remove USB devices
 	 * in tests.
 	 *
-	 * For UT_TESTF_DM tests, the old driver model state is saved and
+	 * For UTF_DM tests, the old driver model state is saved and
 	 * restored across each test. Within in each test there is therefore a
 	 * new driver model state, which means that any USB keyboard device in
 	 * stdio points to the old state.
 	 *
-	 * This is fine in most cases. But if a non-UT_TESTF_DM test starts up
+	 * This is fine in most cases. But if a non-UTF_DM test starts up
 	 * USB (thus creating a stdio record pointing to the USB keyboard
 	 * device) then when the test finishes, the new driver model state is
 	 * freed, meaning that there is now a stale pointer in stdio.
 	 *
-	 * This means that any future UT_TESTF_DM test which uses stdin will
+	 * This means that any future UTF_DM test which uses stdin will
 	 * cause the console system to call tstc() on the stale device pointer,
 	 * causing a crash.
 	 *
-	 * We don't want to fix this by enabling UT_TESTF_DM for all tests as
+	 * We don't want to fix this by enabling UTF_DM for all tests as
 	 * this causes other problems. For example, bootflow_efi relies on
 	 * U-Boot going through a proper init - without that we don't have the
 	 * TCG measurement working and get an error
 	 * 'tcg2 measurement fails(0x8000000000000007)'. Once we tidy up how EFI
 	 * runs tests (e.g. get rid of all the restarting of U-Boot) we could
-	 * potentially make the bootstd tests set UT_TESTF_DM, but other tests
+	 * potentially make the bootstd tests set UTF_DM, but other tests
 	 * might do the same thing.
 	 *
 	 * We could add a test flag to declare that USB is being used, but that
@@ -323,7 +323,7 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
 	 * pointers always.
 	 *
 	 * So just remove any USB keyboards from the console tables. This allows
-	 * UT_TESTF_DM and non-UT_TESTF_DM tests to coexist happily.
+	 * UTF_DM and non-UTF_DM tests to coexist happily.
 	 */
 	usb_kbd_remove_for_test();
 
-- 
2.34.1

