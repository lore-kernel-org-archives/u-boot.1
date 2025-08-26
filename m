Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ACACA0EE4
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 06:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B74783071;
	Tue, 26 Aug 2025 08:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="oNnzJe2f";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fKBd4EGz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 396948307F; Tue, 26 Aug 2025 08:32:45 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ACBC828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 08:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1756189963; x=1787725963;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PFt+/6GZPoN8nPSskWXSDPvBP26/U6i8rYc1LwuZdzY=;
 b=oNnzJe2fhJlSlHCsBijBAmgz1iy1wVeezM2tZ/I6BTATSuSzRFUFTuLF
 ez0St+FUr1qnQyPrkj680HWx5CgtO4ORckcFx0+keZgWwLdKYQUSSzloI
 heloNPQG60LzntTUmPqA1gxpfJS/9x9MVcNF+ajBJPeHXozcT9MkPJjUW
 MbAboSB0Gn28uX6z2csNm8KK8QkgomuwCc93fF/4ayB2dbEDbLhbcY2Ei
 QFK1Zd83bHoe2o5WF11X7nDpEDseGuzmFtn36c91Sy4dm7mu0y1LSwW4v
 EjKNWEefxDTMuu+Vuj0beHgkeZIGaMjtyWp/78Hkx3Ecfv6FwWEWsFXr+ w==;
X-CSE-ConnectionGUID: V3rkHdVDTqWvLDZ56U+vtA==
X-CSE-MsgGUID: dXjaVgkgRcyaaKHcbkP4Yw==
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; d="scan'208";a="45905806"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 26 Aug 2025 08:32:41 +0200
X-CheckPoint: {68AD5509-2E-9821D066-F5C64F68}
X-MAIL-CPID: 843878970D639EF93B142E0865AB119D_2
X-Control-Analysis: str=0001.0A002110.68AD54C4.0070, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B1F3D167A60; Tue, 26 Aug 2025 08:32:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1756189957; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=PFt+/6GZPoN8nPSskWXSDPvBP26/U6i8rYc1LwuZdzY=;
 b=fKBd4EGztTpjr7gfWnrDTGdbAxuj/SQ6lP3DY6glHDpXs8MZnzBb3Kfj41p0r0RbvRoL8e
 BLR/WTfsMPz9WEuzfZVokRBaL/3dlYZ4Ot5twfK1dK/ITeWlcfA7bUZxcRDY9qc8J2dkwe
 tBroELuN4DyuPN73oVWL91+W1ADigyHYSrmiC/zyZT1fnwa9u/lKg8UJFnXGEVMXirjBru
 sK6VbRPV5sSaI1F6giFdVAdoE9dJWS87BHFB1921ZuW2XimNHUTLbknfJ9B5Qvu/BlrVGC
 nx0U+RqUKJfvac0iKvZb9U/62jt0729tN+7XL+nALvGooHE43MBrt+eHhU7vfw==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
	Roger Meier <roger@bufferoverflow.ch>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] tools/libfdt/fdt_rw: fix SPDX-License-Identifier
Date: Tue, 26 Aug 2025 08:30:29 +0200
Message-ID: <20250826063032.2642263-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
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

Currently, the terms of both licenses (GPL 2.0 and BSD-2-Clause) must be
met.
However, before switching to the SPDX license identifier, the license
information in the file begins with:

"libfdt is dual licensed: you can use it either under the terms of
the GPL, or the BSD license, at your option."

Therefore, the missing "OR" between the licenses is added.

Fixes: 3508476 ("libfdt: SPDX-License-Identifier: GPL-2.0+ BSD-2-Clause")

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---

changes v2:
- commit message
  - correct typo BSD-2-Clause
  - change from sync to fix
  - add information why this is a valid license change
  - add Fixes: 3508476 ("libfdt: SPDX-License-Identifier: GPL-2.0+ BSD-2-Clause")
  - remove link to dtc repo
- add Masahiro Yamad as cc
- add Roger Meieras as to (Autor of fixed patch)

 tools/libfdt/fdt_rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/libfdt/fdt_rw.c b/tools/libfdt/fdt_rw.c
index 7189f014295..3d3395b125b 100644
--- a/tools/libfdt/fdt_rw.c
+++ b/tools/libfdt/fdt_rw.c
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier:	GPL-2.0+ BSD-2-Clause */
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 #include "fdt_host.h"
 #include "../../scripts/dtc/libfdt/fdt_rw.c"
 
-- 
2.43.0

