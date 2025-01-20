Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEB3C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229CE8081E;
	Mon, 20 Jan 2025 22:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gPKZcscY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6371807EE; Mon, 20 Jan 2025 22:54:12 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE8C807DD
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844ef6275c5so155756139f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410048; x=1738014848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSNNYOI7FqiFZ91lR3IQwsd35T+ngsN+g+8zmrvJvEI=;
 b=gPKZcscYp2rVNsST+iW+lMo72AF0jMmDGk2cmtWabh55J+pd+3YsJep6kcpNqDZJW3
 mm+cFMBwmPqTYT43JiFy0ykcDwq5JU+0tFExdtoILPwGs7PRdwZJ/izVIOmaS+juWXkh
 bDBph6FQ9xDuez6RO5OKn3jMSMLqGgdYnfsb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410048; x=1738014848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSNNYOI7FqiFZ91lR3IQwsd35T+ngsN+g+8zmrvJvEI=;
 b=v2M8S8ZHMvmEzlCX8fHQnXtUKZ4Rj/YYQerXI2s6HttgDrJy1Vz1bHc9GSI5Lyj5Ht
 0tmB94AmaBzoNSF7eNoLQkMhGWDSH3EHqPYj98BTc7K/39Er2p+KUEg8sSpXBi29r7l0
 G+HGF633R8LvIdTxS63+OQf6tteZcNr0FlRfoqHk+Qzc11ZRwgbKtYa2tgBz6WLa0lIc
 rfDJs/diA5VrCh/xbBXGFRlKErkYquAelhwcVJ90ZgCiFflLsKUVCl0oM2gTpus/FJFp
 jh0TOv0f741RPQ8q9AQR4VeH0qDoySSR7olHjnNIScWFfhFrkV8mheN/QZveRviFsunH
 9fqA==
X-Gm-Message-State: AOJu0YwVt+u0DEJ0qMKZ4+DH4kgbsgyL3YBFBfqRSbPBNGUkwEb0XscW
 fON+ntAg7dCIws9I3w5yutDNM1VHEz2RZ7CwGaPXbZvtxrgqmi0vP1jfJWhXbIuhPy8R9NwkTl8
 =
X-Gm-Gg: ASbGncu3ke/Eqfdei1rb2FfrxscpaDOR337U9yOIXC6YOGnGoesaaWC58BNWkpOSXLO
 pWpOZDbfYA+6rcAmXJ4jGZur0xHLLakIIwsMrCOSxuUqYNZyBASs5h9ODSg/r47gJRnLsu/PWVB
 wGxh9n8mMknr9K+SRWyrtA6oChxz9d57MTpbWxmLeewsA2RWeqkLZYcBJNV+IrmDMPCsMTIjg1E
 KRcz8s62do2q+VWq/oUrbBu0oIJX5vEmNHsAacnTE68dd2EcYM4fOu5fZfGmWXl87GNvA9sJ9UA
 ZFOkgz3w4sjN1m63maMuhgYMqtUlnf8=
X-Google-Smtp-Source: AGHT+IFI4R1syQEqkjKLOCEmVytCMijQlqLzrTG/jqQQGTNyeUs2tGJGHvrKKoi9LrYAUZRV3hK3jg==
X-Received: by 2002:a05:6602:26c5:b0:844:e06e:53c6 with SMTP id
 ca18e2360f4ac-851b64f7425mr1143933739f.11.1737410048481; 
 Mon, 20 Jan 2025 13:54:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:54:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jens Wiklander <jens.wiklander@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/28] test: Make all tests depend on UNIT_TEST
Date: Mon, 20 Jan 2025 14:53:11 -0700
Message-ID: <20250120215340.617194-12-sjg@chromium.org>
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

Rather than having this condition defined separately for each suite,
bracket all options with 'if UNIT_TEST'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Kconfig             | 14 ++++++--------
 test/dm/Kconfig          |  2 +-
 test/env/Kconfig         |  1 -
 test/fdt_overlay/Kconfig |  2 +-
 test/optee/Kconfig       |  2 +-
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/test/Kconfig b/test/Kconfig
index 01d64642fdb..31016eedbf8 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -20,9 +20,10 @@ config SPL_UNIT_TEST
 	  of-platdata and SPL handover. To run these tests with the sandbox_spl
 	  board, use the -u (unit test) option.
 
+if UNIT_TEST
+
 config UNIT_TEST_DURATION
 	bool "Report unit-test duration"
-	depends on UNIT_TEST
 	default y
 	help
 	  Enable this short the time taken by each test suite. This is reported
@@ -31,7 +32,6 @@ config UNIT_TEST_DURATION
 
 config UT_LIB
 	bool "Unit tests for library functions"
-	depends on UNIT_TEST
 	default y if !SANDBOX_VPL
 	help
 	  Enables the 'ut lib' command which tests library functions like
@@ -72,16 +72,15 @@ config UT_LIB_RSA
 	  Enables rsa_verify() test, currently rsa_verify_with_pkey only()
 	  only, at the 'ut lib' command.
 
-endif
+endif  # UT_LIB
 
 config UT_BOOTSTD
 	bool "Unit tests for standard boot"
-	depends on UNIT_TEST && BOOTSTD && SANDBOX
+	depends on BOOTSTD && SANDBOX
 	default y
 
 config UT_COMPRESSION
 	bool "Unit test for compression"
-	depends on UNIT_TEST
 	depends on CMDLINE && GZIP_COMPRESSED && BZIP2 && LZMA && LZO && LZ4 && ZSTD
 	default y
 	help
@@ -90,7 +89,6 @@ config UT_COMPRESSION
 
 config UT_LOG
 	bool "Unit tests for logging functions"
-	depends on UNIT_TEST
 	default y
 	help
 	  Enables the 'ut log' command which tests logging functions like
@@ -99,7 +97,6 @@ config UT_LOG
 
 config UT_TIME
 	bool "Unit tests for time functions"
-	depends on UNIT_TEST
 	help
 	  Enables the 'ut time' command which tests that the time functions
 	  work correctly. The test is fairly simple and will not catch all
@@ -108,7 +105,6 @@ config UT_TIME
 
 config UT_UNICODE
 	bool "Unit tests for Unicode functions"
-	depends on UNIT_TEST
 	default y
 	select CHARSET
 	help
@@ -122,6 +118,8 @@ source "test/lib/Kconfig"
 source "test/optee/Kconfig"
 source "test/fdt_overlay/Kconfig"
 
+endif  # UNIT_TEST
+
 config POST
 	bool "Power On Self Test support"
 	help
diff --git a/test/dm/Kconfig b/test/dm/Kconfig
index e5b341e523a..640421c2a79 100644
--- a/test/dm/Kconfig
+++ b/test/dm/Kconfig
@@ -1,6 +1,6 @@
 config UT_DM
 	bool "Enable driver model unit test command"
-	depends on SANDBOX && UNIT_TEST
+	depends on SANDBOX
 	help
 	  This enables the 'ut dm' command which runs a series of unit
 	  tests on the driver model code. Each subsystem (uclass) is tested.
diff --git a/test/env/Kconfig b/test/env/Kconfig
index 6cb82337b36..21d88f47a6d 100644
--- a/test/env/Kconfig
+++ b/test/env/Kconfig
@@ -1,6 +1,5 @@
 config UT_ENV
 	bool "Enable env unit tests"
-	depends on UNIT_TEST
 	default y
 	help
 	  This enables the 'ut env' command which runs a series of unit
diff --git a/test/fdt_overlay/Kconfig b/test/fdt_overlay/Kconfig
index c2bb70fc970..c50b8822544 100644
--- a/test/fdt_overlay/Kconfig
+++ b/test/fdt_overlay/Kconfig
@@ -1,6 +1,6 @@
 config UT_FDT_OVERLAY
 	bool "Enable Device Tree Overlays Unit Tests"
-	depends on UNIT_TEST && OF_CONTROL && SANDBOX
+	depends on OF_CONTROL && SANDBOX
 	default y
 	select OF_LIBFDT_OVERLAY
 	help
diff --git a/test/optee/Kconfig b/test/optee/Kconfig
index 2f6834aa3b4..63e2cbf79c7 100644
--- a/test/optee/Kconfig
+++ b/test/optee/Kconfig
@@ -1,6 +1,6 @@
 config UT_OPTEE
 	bool "Enable OP-TEE Unit Tests"
-	depends on UNIT_TEST && OF_CONTROL && OPTEE
+	depends on OF_CONTROL && OPTEE
 	default y
 	help
 	  This enables the 'ut optee' command which runs a series of unit
-- 
2.43.0

