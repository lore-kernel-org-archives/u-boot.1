Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD3AC61CE7
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 12:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C87A82A65;
	Sat,  7 Jun 2025 14:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="utaLzvoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25C7382AF6; Sat,  7 Jun 2025 14:03:32 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B3781F0D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 14:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-175-200.46.114.pool.telefonica.de
 [46.114.175.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 3230D4B65C; 
 Sat,  7 Jun 2025 12:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1749297809;
 bh=ZS1cuKzmnhqH90BlNoHn85PAkfY6KVR6vjFscq31fdo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=utaLzvoGK2itnCb2Qr7QotWIyLWq1lid32xv05Or7iDN5n9XXOuih+7hM8x9uckKB
 hXMbn8KTCnFIy9yu6WHN5fy90PPU+rAZ0uBFCiNwAJx2lP7gk0kT8w6MmWQ0j7HXsR
 aXE5fMwU2+scGuly0EG4wkb2I3qU2JE1yUBe20Df43ZUqwrMgi3JjIjplb5hLVCqMF
 As/gZxc+xRXzg8Hxds4fsoQoJI+iWWPPcDcCKjUP3Gm1rYgxR8eGueVj8K6HT4z48s
 ILvCHYr/JgbOWQuO9PlqCLHGjdSW9wtfGvb2/DhGxRItOq419OaOfsp578PnQzCCoF
 trWwzz++IMw+A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Tom Rini <trini@konsulko.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/3] verdin-am62p: include linux/sizes.h
Date: Sat,  7 Jun 2025 14:03:01 +0200
Message-ID: <20250607120303.210990-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250607120303.210990-1-heinrich.schuchardt@canonical.com>
References: <20250607120303.210990-1-heinrich.schuchardt@canonical.com>
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

Avoid build failures

In file included from include/config.h:3,
                 from board/toradex/verdin-am62p/verdin-am62p.c:9:
board/toradex/verdin-am62p/verdin-am62p.c: In function 'dram_init':
include/configs/verdin-am62p.h:13:33: error: 'SZ_2G' undeclared (first use in this function)
   13 | #define CFG_SYS_SDRAM_SIZE      SZ_2G /* Maximum supported size */
      |                                 ^~~~~
board/toradex/verdin-am62p/verdin-am62p.c:63:65: note: in expansion of macro 'CFG_SYS_SDRAM_SIZE'
   63 |         gd->ram_size = get_ram_size((long *)CFG_SYS_SDRAM_BASE, CFG_SYS_SDRAM_SIZE);
      |                                                                 ^~~~~~~~~~~~~~~~~~
include/configs/verdin-am62p.h:13:33: note: each undeclared identifier is reported only once for each function it appears in
board/toradex/verdin-am62p/verdin-am62p.c:65:28: error: 'SZ_1G' undeclared (first use in this function)
   65 |         if (gd->ram_size < SZ_1G)
      |                            ^~~~~

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/toradex/verdin-am62p/verdin-am62p.c | 1 +
 include/configs/verdin-am62p.h            | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/board/toradex/verdin-am62p/verdin-am62p.c b/board/toradex/verdin-am62p/verdin-am62p.c
index 8b246e9d304..5ca4f8ee21d 100644
--- a/board/toradex/verdin-am62p/verdin-am62p.c
+++ b/board/toradex/verdin-am62p/verdin-am62p.c
@@ -15,6 +15,7 @@
 #include <fdt_support.h>
 #include <init.h>
 #include <k3-ddrss.h>
+#include <linux/sizes.h>
 #include <spl.h>
 #include <linux/sizes.h>
 
diff --git a/include/configs/verdin-am62p.h b/include/configs/verdin-am62p.h
index eef360ee9b6..c3464bdb838 100644
--- a/include/configs/verdin-am62p.h
+++ b/include/configs/verdin-am62p.h
@@ -8,6 +8,8 @@
 #ifndef __VERDIN_AM62P_H
 #define __VERDIN_AM62P_H
 
+#include <linux/sizes.h>
+
 /* DDR Configuration */
 #define CFG_SYS_SDRAM_BASE	0x80000000
 #define CFG_SYS_SDRAM_SIZE	SZ_2G /* Maximum supported size */
-- 
2.48.1

