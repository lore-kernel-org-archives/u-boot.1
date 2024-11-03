Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74EDD111A3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 03:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E15CD8914F;
	Mon,  4 Nov 2024 04:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qrv-systems.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463F088DC6; Mon,  4 Nov 2024 00:45:11 +0100 (CET)
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40878889EB
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 00:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qrv-systems.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr4.vodafonemail.de (Postfix) with ESMTPS id 4XhWRm6yDcz1y49;
 Sun,  3 Nov 2024 23:45:08 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XhWRd50bgz8snW;
 Sun,  3 Nov 2024 23:44:58 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id 2D2EB2E01AD; Mon,  4 Nov 2024 00:44:58 +0100 (CET)
From: Yuri Zaporozhets <yuriz@qrv-systems.net>
To: u-boot@lists.denx.de
Cc: Yuri Zaporozhets <yuriz@qrv-systems.net>
Subject: [PATCH 1/2] bios_emulator: don't select X86EMU_RAW_IO for BIOSEMU and
 SPL_BIOSEMU
Date: Mon,  4 Nov 2024 00:44:36 +0100
Message-Id: <20241103234437.25639-1-yuriz@qrv-systems.net>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 652
X-purgate-ID: 155817::1730677504-88FE8465-BB79AD3C/0/0
X-Mailman-Approved-At: Mon, 04 Nov 2024 04:30:40 +0100
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

The X86EMU_RAW_IO mode can be used only on x86, so don't select this option
always, and allow correct compilation of BIOSEMU on other architectures too.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/bios_emulator/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bios_emulator/Kconfig b/drivers/bios_emulator/Kconfig
index 3660576772..8f73d077f6 100644
--- a/drivers/bios_emulator/Kconfig
+++ b/drivers/bios_emulator/Kconfig
@@ -1,10 +1,8 @@
 config BIOSEMU
 	bool
-	select X86EMU_RAW_IO
 
 config SPL_BIOSEMU
 	bool
-	select X86EMU_RAW_IO
 
 config X86EMU_RAW_IO
 	bool
-- 
2.43.0

