Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161B5C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3692680A23;
	Fri,  7 Feb 2025 19:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jv0+JS1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921AA80A29; Fri,  7 Feb 2025 19:32:01 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5934E80A23
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-84cdacbc373so74629439f.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953115; x=1739557915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QULWIa8StrVRK3raFlZM1Mh7YzX3fkGi+pAeq7SoeLE=;
 b=jv0+JS1hNnu+CaRm2CcWC2oxEs8uFANY7ErAoAHBmZ5jqWneNGl4N+GFsJo+KmGzpI
 WCvLDY+upusYuUwriArEyvO/YE96he9mfA4XcvuOVDNC1SWf1pRGOzH5eJPMZgqGc+m6
 AzGSNpWyf9rDdxFfBjCIkE5cvufKum5Ivm4cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953115; x=1739557915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QULWIa8StrVRK3raFlZM1Mh7YzX3fkGi+pAeq7SoeLE=;
 b=NgtbhYfnlj7BLUL8EP7/IV7jxBly4cgTGughdf9K6mSCBhnEukZpbzxAK8L9ZKLq3Q
 WdZGVvtzRJ20Aee4dOysWV6uYzDnmq3TNz+0e27jQZ2L1/orgercFBGjvZj2nIHxpt9+
 wcXoXBCtyHTNH40fEXWbgVqtvnJXlNPeGW1rFenUeJQhYftLhxGKckeR1bS5JqvHwR+U
 Nyx5//Jwg8oUhdLY6MirrF79O+3DTlqAj6JqOkcoEbliy+t42XMwUNMmARTcVuHVvyLG
 8wiB3tSWoI7DE3j1P/fS0wfVDsZknFekPysN0IiepWymo6fLW1rwb+6JfyVaOkGeRbII
 HUgA==
X-Gm-Message-State: AOJu0Yx0Cfif2QKS8cRFtyksDwpAB64/38I3vceTuuUCkinxqfpvfy2H
 iKo/h9abR5Q13fe/bMv/tkqsKrDKgEz5JZU83v1a2f6B9j1NZ3CH4ZrCmZwlJbK908UFRm6rHZc
 =
X-Gm-Gg: ASbGncthdMluodS2iTMlNB0XTjXTFGNu+w6H1VYI/VyzXprioElzGS/3ZdgQiwFFwD9
 digo/VzGaQwNaFVN3b2ocxRC2xmfZaEMZPMOf9pW601XgsNultfWGj+Um/wakAl6wujFlL512/X
 42wmJsnKyfV/fPgs7TO+Gei0mmz3gvo0pzS0OtCvlORVVjMpVyTn1r4bj1SSDytCxQqt8AXbOao
 FQ0pc8xCpWQb2Bfxqm2mJRI7taBMp8DTFNXC7ezRB3odQT+sxpwsAulbSTINDTuaFJhpSG1jyK9
 egM9hGLFo4qXN4KSc1WAu6MX1Ny+obb3f0lpdQw3DxugPUpMcu99
X-Google-Smtp-Source: AGHT+IF60jYQiLV7jwE7qI1ccR8dnhjcuAOdcW3sjc3enBX22aZEvLMud4NZRqozl6ZTB2+//nIc5g==
X-Received: by 2002:a05:6602:3995:b0:844:c750:3d9d with SMTP id
 ca18e2360f4ac-854fd8972c6mr532397339f.4.1738953115481; 
 Fri, 07 Feb 2025 10:31:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/29] test: Make all tests depend on UNIT_TEST
Date: Fri,  7 Feb 2025 11:30:43 -0700
Message-ID: <20250207183121.117663-13-sjg@chromium.org>
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

Rather than having this condition defined separately for each suite,
bracket all options with 'if UNIT_TEST'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

