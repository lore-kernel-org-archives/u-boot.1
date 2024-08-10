Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0904AC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:55:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48FE888C51;
	Sat, 10 Aug 2024 22:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J06iw+W7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1524A888C2; Sat, 10 Aug 2024 22:52:44 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D97688891A
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-81f86fd93acso117285239f.1
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323158; x=1723927958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQNnmC/fEOmcEOkgfXl8YqB+oIIVF+SDXAM49Tz2aRI=;
 b=J06iw+W72WdbblYJ3Tw4ObHgadd0f05bgKhHvk4gpSaK8BD9aOWJrKFxKrZ4BybP4E
 cBr/AEftgiCvLW9kTQJ4f7Y3i4qO1t26/m8KIY50iA712Q/yHfQkKBIeEdgP9B43YLjN
 N6ydrqfYhj79fVaAFVkTIlj4eNznO+rQoK+es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323158; x=1723927958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQNnmC/fEOmcEOkgfXl8YqB+oIIVF+SDXAM49Tz2aRI=;
 b=KZ32gWVav0ZUvmmxRZdT9CJFCoHLN0WjqFiQeJjEM2CnovB28ge4zXiZcf0QNxQNeN
 4Y9QSFWLcJabwav/+GDbvP40APuCajLSRtx13WwmVBD6sINRCWzE7DT0r8VVRc2Bycht
 nFy1S6cV3Xwo5PUlfgQXlJMaeh6+h9WuLApxPqeRthmuvSMyG8I5qMspOCG2zPjiOPnM
 Av5/N+vu1D13l4gYV5YxV+cyBYuApbE8MbBNlGKXrDLGymB8p/ULVmFNBizQTRvvS/xU
 hL7p9zPwlwESqlUftQH74g8tlrOn8nspgLGQosHj32wzhd0QVhBHguE9Eyp8pk49HDj3
 LHOg==
X-Gm-Message-State: AOJu0YzRsnxl6vc/y2+ozN1s0Bu5cTFzWR1sb6KWd+Cb95H/1qP3GbDE
 n+fbJTx2y5g2Zy+UrvoF/yRsj7/fW467kLzonI3Y+oVhX6z6IfdGGXafXR2cKBkozSvbh1f5nso
 =
X-Google-Smtp-Source: AGHT+IE5IJAYTkKQQnW/MnCIlXLbTENOL4tpL8tSd96Tcy9ItBGxbDvKkkPSlnfGu15EbkPQqDF0gg==
X-Received: by 2002:a05:6602:160a:b0:7f9:510b:6078 with SMTP id
 ca18e2360f4ac-822603c51b9mr629321339f.4.1723323158447; 
 Sat, 10 Aug 2024 13:52:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Dahl <ada@thorsis.com>
Subject: [PATCH 21/21] doc: Add a few notes about how to use console checking
Date: Sat, 10 Aug 2024 14:52:05 -0600
Message-Id: <20240810205205.3403177-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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

