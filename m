Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0881DC3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 08:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EB5482A46;
	Sun, 13 Apr 2025 10:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744534702;
	bh=Qe8Xy4LGiBOtMqojVWqfW89Ki/IE56xdJT2HCOlSZx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y36Na+aQj6RO+GZjfEWv/FYh5igSJu8RxXAdh48AUNmkdE4z+jmrkhWd4CbCuZAO/
	 oPSvH90vtlnrqMYJ1OApEEzMWqVFvjBQ6aXfrfwDeR6i8vGIXpFiYntv4XcLwCR/88
	 3jYNhlHM21OPe2r3oROOHJS0Nk6Ko3WaGOckfn2naFMj7vMiMK00Bz05ozb2a2fxBP
	 2hUv80ErqC2Iy3U/zMB3bJgo1Hu6gzT75dv7qtjHw/tol25BwrR1yXaTablfhXg/JU
	 qIE6izuZhKfq4bxghr64/Q2BNtIbTrp9IVKA5heZNYKePbd/byOZCzhm5WQkCUZvQD
	 MtaWumgFgbscw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A150B8294C; Sun, 13 Apr 2025 10:58:20 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF1582917
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 10:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JOVWgXVH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9CB8110271405; 
 Sun, 13 Apr 2025 10:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744534698; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Qe8Xy4LGiBOtMqojVWqfW89Ki/IE56xdJT2HCOlSZx8=;
 b=JOVWgXVH7zRK4+ucdHXqKkZVKXeyhFq+8HGp4R1UOkqNwZaChPFvWAchzhzXnaHFbUmpbk
 iht/sroDRze5odf6ggAph+MMSv6hZ2u7Gppjc9Ez87BlkRpYkE7xfjHZInyyaHPVfv2cs2
 /U1R/h4B9jYTCkNgCwLNT+B3AlNT9cH03FC7MA4MUKr/wNKHXVeQKDRbiqmQPrnWbw0fM4
 QY4WeQ+K5QuYsnOR71keg0NoiF+EpUsi6ado+49HZ1Tv26A7a9IqnYqemvQdBlHTtVzaVO
 GZQvrbQiIFDPImeiw3mH4vLr6Nz+cekmFZ5T0k+2xp4idC604ejQATkUZgE12g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/7] test_fs: Add test -e test
Date: Sun, 13 Apr 2025 10:55:03 +0200
Message-ID: <20250413085740.5953-5-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250413085740.5953-1-marex@denx.de>
References: <20250413085740.5953-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Add test for the 'test -e' command to check for existence of files.
This exercises struct fstype_info .exists callback.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 test/py/tests/test_fs/test_basic.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/test/py/tests/test_fs/test_basic.py b/test/py/tests/test_fs/test_basic.py
index 64a3b50f52a..88b163ce305 100644
--- a/test/py/tests/test_fs/test_basic.py
+++ b/test/py/tests/test_fs/test_basic.py
@@ -35,6 +35,19 @@ class TestFsBasic(object):
                 '%sls host 0:0 invalid_d' % fs_cmd_prefix)
             assert('' == output)
 
+        with ubman.log.section('Test Case 1c - test -e'):
+            # Test Case 1 - test -e
+            output = ubman.run_command_list([
+                'host bind 0 %s' % fs_img,
+                'test -e host 0:0 1MB.file && echo PASS'])
+            assert('PASS' in ''.join(output))
+
+        with ubman.log.section('Test Case 1d - test -e (invalid file)'):
+            # In addition, test with a nonexistent file to see if we crash.
+            output = ubman.run_command(
+                'test -e host 0:0 2MB.file || echo PASS')
+            assert('PASS' in ''.join(output))
+
     def test_fs2(self, ubman, fs_obj_basic):
         """
         Test Case 2 - size command for a small file
-- 
2.47.2

