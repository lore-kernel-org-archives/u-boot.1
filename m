Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BA2C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 09:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6827887BE3;
	Wed, 24 Jan 2024 10:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Orh9bF+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D6C87707; Wed, 24 Jan 2024 10:02:39 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB3687BE3
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 10:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O92Ynn066965;
 Wed, 24 Jan 2024 03:02:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706086954;
 bh=twKiwza86RazBGhbbGHlxRVHyUlqCAHEym+tFQ5yswQ=;
 h=From:To:CC:Subject:Date;
 b=Orh9bF+ezfQEgtin+x1IErOSyS/Ch3s7mnE90+vqmZJSz/16ckCga63nYWyxJQbmn
 S+/8kCREFn7YfPCz6VktWsR/UEHYsgOp0mXUsPDcWnes1l44v0q6xYFX6l3MKPZAVw
 pvKbM18ca1scB2SNjfC3kCeo5mTnFJdSirTPE4o8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O92YNj068847
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 03:02:34 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 03:02:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 03:02:34 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O92XQt016388;
 Wed, 24 Jan 2024 03:02:34 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <n-jain1@ti.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <devarsht@ti.com>
Subject: [PATCH] common: splash_source: Don't compile ubifs splash cmd for SPL
 build
Date: Wed, 24 Jan 2024 14:32:33 +0530
Message-ID: <20240124090233.301308-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Don't compile ubifs splash mount command for SPL build as this command
is not supported (and also not enabled) during SPL stage.

This fixes below compilation error, when CONFIG_CMD_UBIFS is enabled in
defconfig along with splash screen enabled at SPL stage.

Fixes below error when CONFIG_CMD_UBIFS is enabled in defconfig along
with splash screen at SPL stage:

"aarch64-none-linux-gnu-ld.bfd: common/cli.o: in function `run_command':
u-boot-next/u-boot/common/cli.c:51: undefined reference to
`parse_string_outer'
u-boot-next/u-boot/common/cli.c:51:(.text.run_command+0x10): relocation
truncated to fit: R_AARCH64_JUMP26 against undefined symbol
`parse_string_outer' make[2]: ***
[u-boot-next/u-boot/scripts/Makefile.spl:527: spl/u-boot-spl] Error 1
make[1]: *** [u-boot-next/u-boot/Makefile:2053: spl/u-boot-spl] Error 2
make[1]: Leaving directory 'u-boot-next/u-boot/out/a53' make: ***
[Makefile:177: sub-make] Error 2"

Fixes: eb9217dc03 ("common: Enable splash functions at SPL")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 common/splash_source.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/splash_source.c b/common/splash_source.c
index 7223a1aae7..2ce0768833 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -216,7 +216,7 @@ static int splash_init_virtio(void)
 	}
 }
 
-#ifdef CONFIG_CMD_UBIFS
+#if defined(CONFIG_CMD_UBIFS) && !defined(CONFIG_SPL_BUILD)
 static int splash_mount_ubifs(struct splash_location *location)
 {
 	int res;
-- 
2.34.1

