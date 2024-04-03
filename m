Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DF7CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 11:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF2A8823A;
	Wed,  3 Apr 2024 13:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lI/C6chd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32DF58822C; Wed,  3 Apr 2024 13:11:46 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513688823D
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 13:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5D2F13F3BA; 
 Wed,  3 Apr 2024 11:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712142703;
 bh=J3gq9LPSTHgOEAlLrvPUhWt2BQDy4lwHP4nURRCRoOc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lI/C6chd5nDHjnkPqxsTGVDQNVJRODOjodVFfR6f60CUSCn95UpjJb5mLKvz3EHrB
 aWNSTicWlBWYOV0bgZy38VSeX1DCBjYS0eKiFXab4COmAvBr3DLHq+ETkGbygafZ/M
 vYh7ezK065qbPHHevds1wNESiBcDXb+fqD4teaKheRycF39Ee/NJsVIHKztOZsQCU/
 FPUiGdC7EPax33/ALkW708tRXuCW9gYvy9WB8KBL9ra3+wkFny3FV8x50gKtmLPXHS
 XbpEO+ysnYPHCkGsuuBLZr67y9W0a/6cA4otyP3ZSRV4kbC0jb7HsW8fQo8wev6hFx
 i5Tz76+MYvTFw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: remove unused import from pkg_resources
Date: Wed,  3 Apr 2024 13:11:41 +0200
Message-ID: <20240403111141.54189-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

load_entry_point is not used.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/test.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/test/py/test.py b/test/py/test.py
index 95859a66e29..7c477903d6b 100755
--- a/test/py/test.py
+++ b/test/py/test.py
@@ -11,7 +11,6 @@ import os
 import os.path
 import sys
 import pytest
-from pkg_resources import load_entry_point
 
 if __name__ == '__main__':
     # argv; py.test test_directory_name user-supplied-arguments
-- 
2.43.0

