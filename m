Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1441C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 16:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48CB881CD;
	Thu, 11 Apr 2024 18:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C0087FED; Thu, 11 Apr 2024 18:44:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 163C187FED
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 18:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCD72113E;
 Thu, 11 Apr 2024 09:44:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.18.217])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 572AE3F6C4;
 Thu, 11 Apr 2024 09:44:08 -0700 (PDT)
From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] Fix references to trace doc
Date: Thu, 11 Apr 2024 18:44:02 +0200
Message-ID: <20240411164402.111244-1-vincent.stehle@arm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The README.trace has been moved and converted to rst in commit dce26c7d56ed
("doc: move README.trace to HTML documentation"); fix all the remaining
references to this file.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 cmd/Kconfig                   | 4 ++--
 doc/develop/tests_sandbox.rst | 2 +-
 lib/Kconfig                   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 38305197602..f9f271616d3 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2832,8 +2832,8 @@ config CMD_TRACE
 	  Enables a command to control using of function tracing within
 	  U-Boot. This allows recording of call traces including timing
 	  information. The command can write data to memory for exporting
-	  for analysis (e.g. using bootchart). See doc/README.trace for full
-	  details.
+	  for analysis (e.g. using bootchart). See doc/develop/trace.rst
+	  for full details.
 
 config CMD_AVB
 	bool "avb - Android Verified Boot 2.0 operations"
diff --git a/doc/develop/tests_sandbox.rst b/doc/develop/tests_sandbox.rst
index bfd3bdb9270..c2824834d07 100644
--- a/doc/develop/tests_sandbox.rst
+++ b/doc/develop/tests_sandbox.rst
@@ -29,7 +29,7 @@ Some of the available tests are:
      - test/image/test-imagetools.sh - multi-file images
      - test/py/tests/test-fit.py     - FIT images
   - tracing: test/trace/test-trace.sh tests the tracing system (see
-      README.trace)
+      doc/develop/trace.rst)
   - verified boot: test/py/tests/test_vboot.py
 
 If you change or enhance any U-Boot subsystem, you should write or expand a
diff --git a/lib/Kconfig b/lib/Kconfig
index 37ac14f7bab..efb77978a65 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -348,7 +348,7 @@ config TRACE
 	  Enables function tracing within U-Boot. This allows recording of call
 	  traces including timing information. The command can write data to
 	  memory for exporting for analysis (e.g. using bootchart).
-	  See doc/README.trace for full details.
+	  See doc/develop/trace.rst for full details.
 
 config TRACE_BUFFER_SIZE
 	hex "Size of trace buffer in U-Boot"
-- 
2.43.0

