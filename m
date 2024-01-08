Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6273C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 21:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2074F87A47;
	Mon,  8 Jan 2024 22:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="1OL/7z30";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wieP+B2k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83E1487A77; Mon,  8 Jan 2024 22:11:21 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B38B187A28
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 22:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tdmg@linutronix.de
From: Tobias Deiminger <tdmg@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1704748279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVqaMuS+4hBOV4fe6swjQ+fvzb/M2F84COUO0eL7mGA=;
 b=1OL/7z30M9U2Cgf29BmDajcoIEnc8L3BmmuzUdWd1KT4V4D9S+D5sXKfQ6Qe2OzrH6o7Ub
 eyYpOM3YkDYH+19u/oyftvmUhRFdbVWt+Yn/to5KwF4wma+Tl2QyC4hzRaRx/4xNLVMPpC
 FpJcA+ZKwqo0YmdsB0+Tq/cJJ7RLZTUpdztvFZ1/zAAy++ES94oTrAVeRhr+RedPAGTqox
 68GI2EWMWCKXqUwtiTWrygaG+IiPqk/tLnkQ6ue9TBkmzL2fSsy5djxK7U7m4GRUgKMO/l
 6Qk+d0EOptQ74294EVW9Nc3vAauSW1peb0dbNRoNv3QjLz3ke58COle0ypGDTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1704748279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVqaMuS+4hBOV4fe6swjQ+fvzb/M2F84COUO0eL7mGA=;
 b=wieP+B2kBtdUm1DHje9abp9ndnTh0rG9OhVEgWnc70N66ZshyRPS2CZUT+w7T6Pq7ZkuHu
 gzXuTIk/5TJTnGDg==
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Harald Seiler <hws@denx.de>,
 tdmg@linutronix.de (Tobias Deiminger)
Subject: [PATCH 1/1] test: Skip cleanup test if not built out of tree
Date: Mon,  8 Jan 2024 22:11:00 +0100
Message-Id: <20240108211100.112730-2-tdmg@linutronix.de>
In-Reply-To: <20240108211100.112730-1-tdmg@linutronix.de>
References: <20240108211100.112730-1-tdmg@linutronix.de>
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

42c0e5bb054d ("test: Find leftovers after clean/mrproper") assumes out
of tree builds. test_clean and test_mrproper fail if the assumption
isn't met.

However there are valid scenarios where tests run with in source builds
(i.e., test.py --build-dir=.).

Automatically skip cleanup tests in such scenarios to prevent false
positives.

Signed-off-by: Tobias Deiminger <tdmg@linutronix.de>
---
 test/py/tests/test_cleanup_build.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/test/py/tests/test_cleanup_build.py b/test/py/tests/test_cleanup_build.py
index 5206ff73ec..aca90cb110 100644
--- a/test/py/tests/test_cleanup_build.py
+++ b/test/py/tests/test_cleanup_build.py
@@ -17,6 +17,11 @@ import pytest
 @pytest.fixture
 def tmp_copy_of_builddir(u_boot_config, tmp_path):
     """For each test, provide a temporary copy of the initial build directory."""
+    if os.path.realpath(u_boot_config.source_dir) == os.path.realpath(
+        u_boot_config.build_dir
+    ):
+        pytest.skip("Leftover detection requires out of tree build.")
+        return None
     shutil.copytree(
         u_boot_config.build_dir,
         tmp_path,
-- 
2.30.2

