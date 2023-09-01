Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F04ECA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 08:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E06867EF;
	Fri,  1 Sep 2023 10:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hBCP//ld";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aPeF3bZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D6A48680E; Fri,  1 Sep 2023 10:48:33 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B8E08669D
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 10:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RcWsB2QM1z9sqn;
 Fri,  1 Sep 2023 10:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693558110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eKvkXJceJiCQWRmvP1MviTR0JiABsvxBDUh0ZQYm3Jw=;
 b=hBCP//ldPZkW8Mp+DPgYkYVynjgh5hVGe3J3mC7BKn8BlG8TMxOSFfzHRCgu77g5Y1zquT
 E0YHaukY3q0NGI65mfbFEdD2HqPDn2neWtQJyIzG2KvJBNDyMjeoeKvsDf9bkMunY+GcLL
 ZyYWcoocDs/YBe2irN2kYV89txXFjhipr/l8vV9A/l9wOYYd+y+xkP1avQ/m17wDEkmJng
 pzwVqwfKJKqUZct+UPNwMFASGAyt5ME1COth3eYAhBGik/rv6dAaLJQbuAlQMkN1Z13HFn
 ZuVwKzSupq1Gj0Qb8xJPL+pR6Y0+60G/xgFPphGIg6JkzrNBSM0IUJeqJdZkkQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693558107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eKvkXJceJiCQWRmvP1MviTR0JiABsvxBDUh0ZQYm3Jw=;
 b=aPeF3bZ0aBZnCv5xRl0P1jyoftQSOsrIwKpoTzoruJcun5sjh/FUn795VMfLz5tBedpzUR
 T9q1etqxlfAgPE2uBE6Jr3ilyNJoQeXt5EQNrj3icfV0lBmxeo9cYmniTygmsMTRHby4CE
 pVlQVxykwVdLm2RkpbvbOSyJotCMB4sqAXbJppLdDKWiyV4Z1FJrlHnQi1peg6+7lhTkxt
 aVDKMgJPgXXzA1FReBVq3T6lJEKyZX3XBt88zPg0nZcxDjAeDP+Q8VKOZI2tSyfmykaQLy
 J15v7dPJ74uvHVhRDzzy0ycmOMUsA/8RXpa/K8v7MEGiupP+GvI4v1yjzhfPZQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] .gitlab-ci: Test sandbox64 board in addition to sandbox
Date: Fri,  1 Sep 2023 10:48:10 +0200
Message-Id: <20230901084810.238594-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fbdcdddbe62017bac44
X-MBO-RS-META: 6jrtoin7djmj4imfm6nxa1ke1xbpeoqe
X-Rspamd-Queue-Id: 4RcWsB2QM1z9sqn
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

Test both 32bit and 64bit sandbox boards in CI.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
DEPENDS:
- [v2] test: print: Fix hexdump test on 64bit systems
- test: dm: test-fdt: Use fdtdec_get_int() in dm_check_devices()
- configs: sandbox64: Enable legacy image format support
---
 .gitlab-ci.yml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6d7ffdd1bbc..a7282be3181 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -291,6 +291,23 @@ sandbox without LTO test.py:
     BUILD_ENV: "NO_LTO=1"
   <<: *buildman_and_testpy_dfn
 
+sandbox64 test.py:
+  variables:
+    TEST_PY_BD: "sandbox64"
+  <<: *buildman_and_testpy_dfn
+
+sandbox64 with clang test.py:
+  variables:
+    TEST_PY_BD: "sandbox64"
+    OVERRIDE: "-O clang-16"
+  <<: *buildman_and_testpy_dfn
+
+sandbox64 without LTO test.py:
+  variables:
+    TEST_PY_BD: "sandbox64"
+    BUILD_ENV: "NO_LTO=1"
+  <<: *buildman_and_testpy_dfn
+
 sandbox_spl test.py:
   variables:
     TEST_PY_BD: "sandbox_spl"
-- 
2.40.1

