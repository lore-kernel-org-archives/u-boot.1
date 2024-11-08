Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83AFD5C0F4
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 16:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 454CF891E3;
	Fri,  8 Nov 2024 17:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qrv-systems.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F1C88D70; Fri,  8 Nov 2024 14:14:04 +0100 (CET)
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF98890FC
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:14:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qrv-systems.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr4.vodafonemail.de (Postfix) with ESMTPS id 4XlKCG5NpHz20pv;
 Fri,  8 Nov 2024 13:14:02 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XlKC72yyLz9059;
 Fri,  8 Nov 2024 13:13:52 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id 081F62E01AF; Fri,  8 Nov 2024 14:13:52 +0100 (CET)
From: Yuri Zaporozhets <yuriz@qrv-systems.net>
To: u-boot@lists.denx.de
Cc: Yuri Zaporozhets <yuriz@qrv-systems.net>
Subject: [PATCH] bios_emulator: add missing includes to debug.c
Date: Fri,  8 Nov 2024 14:13:29 +0100
Message-Id: <20241108131329.15193-1-yuriz@qrv-systems.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 739
X-purgate-ID: 155817::1731071638-1D7F9477-D6CD048B/0/0
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:59:59 +0100
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

When compiling with X86EMU_DEBUG, the compiler complains that debug.c misses
two include files. Fix that.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/bios_emulator/x86emu/debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bios_emulator/x86emu/debug.c b/drivers/bios_emulator/x86emu/debug.c
index b426dc3bc4..c63cf3d26b 100644
--- a/drivers/bios_emulator/x86emu/debug.c
+++ b/drivers/bios_emulator/x86emu/debug.c
@@ -38,6 +38,8 @@
 ****************************************************************************/
 
 #include <stdarg.h>
+#include <string.h>
+#include <vsprintf.h>
 #include <linux/ctype.h>
 #include <linux/printk.h>
 #include "x86emu/x86emui.h"
-- 
2.39.5

