Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A916DCFD2F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 14:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3AD83E76;
	Tue,  2 Dec 2025 15:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4227183E40; Tue,  2 Dec 2025 11:00:20 +0100 (CET)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com
 [45.254.49.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6297683E28
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 11:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=amadeus@jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.79])
 by smtp.qiye.163.com (Hmail) with ESMTP id 2bada5f50;
 Tue, 2 Dec 2025 18:00:10 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de,
 Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] binman: fallback to importlib_resources on Python 3.8
Date: Tue,  2 Dec 2025 18:00:00 +0800
Message-Id: <20251202100000.372409-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ade8159a603a2kunm6f41a7bd8f91f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0lKVktIShpDQ09NTRpIGFYeHw5VEwETFhoSFy
 QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVMQllXWRYaDxIVHRRZQVlLVUtVS1VLWQY+
X-Mailman-Approved-At: Tue, 02 Dec 2025 15:06:33 +0100
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

Python 3.7 and 3.8 lack the files attribute in importlib.resources.
Use importlib_resources to fix build errors with Python 3.8:
binman: module 'importlib.resources' has no attribute 'files'

Fixes: 538719cb6a77 ("binman: migrate from pkg_resources to importlib")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 tools/binman/control.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/binman/control.py b/tools/binman/control.py
index 1307222591d..ef69e5fc4f9 100644
--- a/tools/binman/control.py
+++ b/tools/binman/control.py
@@ -9,8 +9,9 @@ from collections import OrderedDict
 import glob
 try:
     import importlib.resources as importlib_resources
-except ImportError:  # pragma: no cover
-    # for Python 3.6
+    # for Python 3.6, 3.7 and 3.8
+    importlib_resources.files
+except (ImportError, AttributeError):
     import importlib_resources
 import os
 import re
-- 
2.25.1

