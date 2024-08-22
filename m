Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE418C52D7C
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDD3A88CA3;
	Thu, 22 Aug 2024 15:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WXuuwjhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C611A88BD4; Thu, 22 Aug 2024 15:58:35 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE6F88C3A
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-39d2e4d73bcso3513155ab.1
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335112; x=1724939912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMi8OEP5VtJvdjvKDTrZrzIsNyNA9Zq8N6JG85JpVGQ=;
 b=WXuuwjhjRf2V0Hy3UbkiEyP29XZLJGNt9lOZRhP6qiW0O+0/wMq4FjcwMB1BTEnilk
 VYHqxrZQdXz0hQH2BaERUsbrvL0hr5VuQrAJVq72ZcFHhB/SJgVTsJzUT0A7yokjAK6Z
 +byVhrz2p+in54Nak/9E6qmyJPG/szW7101l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335112; x=1724939912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMi8OEP5VtJvdjvKDTrZrzIsNyNA9Zq8N6JG85JpVGQ=;
 b=rNwhltItuZDLa9VSb/lxqWkmBV4D69XaW+nFmtn9saKn+rDVITS/gvPx/800mS43qW
 irr4xVT4AR+5LMcKzB0SBmdZjaTg0VFhjUdFxoe9qNiHIRX1pJiCtW6gz4DIwXZrw1VZ
 41/b+TpsOJHmxvimVSo4mC/no1J2Z9EtgHq6qEBJUJSzjVhCFc1eyYOeYaWleW5eOWfU
 t59SJYN77H9ej1eXI6u3l23IdAMmelNcLZC30HG+wL7mk2b0XtNnLaKY6jet3zIixRBa
 fuSRf6jZy7op2t9VZmrzmnAM8dfp3PcsWZPKfx/gapCymnr7JGjTKJ+W49QSQmu5Ak2H
 ax7w==
X-Gm-Message-State: AOJu0YxtQehH1x3mHhriAc/lz2huJiQ4lTZ84jDo+4y+VQAlI1dUTAZW
 vVLjINexnxQSHEN24X+T6xbr2x9k1ODUV9xmQn2ZuFrhYGlksqkhV+trhujnccxvMYR20CM8Esc
 =
X-Google-Smtp-Source: AGHT+IF6CVo7bf6rK6+yrd4JD+O07LPX3dVPpFMZN/yKey0S7e54OIMEtXv0nPaq8HJammrjn4lrvA==
X-Received: by 2002:a05:6e02:1b0c:b0:39b:2669:4e44 with SMTP id
 e9e14a558f8ab-39d6c35a070mr73360925ab.8.1724335112154; 
 Thu, 22 Aug 2024 06:58:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/19] doc: Add a few notes about how to use console
 checking
Date: Thu, 22 Aug 2024 07:58:04 -0600
Message-Id: <20240822135804.2375959-20-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

Tidy up the existing docs in line with current conventions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Drop wget patches as they have been sent by the author

 doc/develop/commands.rst      | 9 +++++----
 doc/develop/tests_writing.rst | 1 -
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/develop/commands.rst b/doc/develop/commands.rst
index 6427844f143..77a7a4d9c02 100644
--- a/doc/develop/commands.rst
+++ b/doc/develop/commands.rst
@@ -197,7 +197,6 @@ Here is an example:
 
         ctx.current = buf;
         ut_assertok(acpi_fill_ssdt(&ctx));
-        console_record_reset();
         run_command("acpi items", 0);
         ut_assert_nextline("dev 'acpi-test', type 1, size 2");
         ut_assert_nextline("dev 'acpi-test2', type 1, size 2");
@@ -205,13 +204,11 @@ Here is an example:
 
         ctx.current = buf;
         ut_assertok(acpi_inject_dsdt(&ctx));
-        console_record_reset();
         run_command("acpi items", 0);
         ut_assert_nextline("dev 'acpi-test', type 2, size 2");
         ut_assert_nextline("dev 'acpi-test2', type 2, size 2");
         ut_assert_console_end();
 
-        console_record_reset();
         run_command("acpi items -d", 0);
         ut_assert_nextline("dev 'acpi-test', type 2, size 2");
         ut_assert_nextlines_are_dump(2);
@@ -223,4 +220,8 @@ Here is an example:
 
         return 0;
     }
-    DM_TEST(dm_test_acpi_cmd_items, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+    DM_TEST(dm_test_acpi_cmd_items, UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_CONSOLE);
+
+Note that it is not necessary to call console_record_reset() unless you are
+trying to drop some unchecked output. Consider using ut_check_skip_to_line()
+instead.
diff --git a/doc/develop/tests_writing.rst b/doc/develop/tests_writing.rst
index 404d158ec40..a328ebfef33 100644
--- a/doc/develop/tests_writing.rst
+++ b/doc/develop/tests_writing.rst
@@ -151,7 +151,6 @@ There is no exactly equivalent C test, but here is a similar one that tests 'ms'
       buf[0x31] = 0x12;
       buf[0xff] = 0x12;
       buf[0x100] = 0x12;
-      ut_assertok(console_record_reset_enable());
       run_command("ms.b 1 ff 12", 0);
       ut_assert_nextline("00000030: 00 12 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................");
       ut_assert_nextline("--");
-- 
2.34.1

