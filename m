Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E2ED111A3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 03:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E0E8915C;
	Mon,  4 Nov 2024 04:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=qrv-systems.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B718889EB; Mon,  4 Nov 2024 00:45:44 +0100 (CET)
Received: from mr5.vodafonemail.de (mr5.vodafonemail.de [145.253.228.165])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8993488E81
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 00:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=qrv-systems.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mr5.vodafonemail.de (Postfix) with ESMTPS id 4XhWSQ2hWqz1yBP;
 Sun,  3 Nov 2024 23:45:42 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XhWSH1KyZz91pV;
 Sun,  3 Nov 2024 23:45:32 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id D9BA62E01AD; Mon,  4 Nov 2024 00:45:31 +0100 (CET)
From: Yuri Zaporozhets <yuriz@qrv-systems.net>
To: u-boot@lists.denx.de
Cc: Yuri Zaporozhets <yuriz@qrv-systems.net>
Subject: [PATCH 2/2] bios_emulator: make CONFIG_BIOSEMU selectable in
 menuconfig
Date: Mon,  4 Nov 2024 00:44:37 +0100
Message-Id: <20241103234437.25639-2-yuriz@qrv-systems.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241103234437.25639-1-yuriz@qrv-systems.net>
References: <20241103234437.25639-1-yuriz@qrv-systems.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 838
X-purgate-ID: 155817::1730677538-27FEE466-1E102FC4/0/0
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

This allows selecting BIOSEMU in "make menuconfig", and provides one-line descriptions
for all three configuration parameters in bios_emulator/Kconfig.

Signed-off-by: Yuri Zaporozhets <yuriz@qrv-systems.net>
---
 drivers/bios_emulator/Kconfig | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bios_emulator/Kconfig b/drivers/bios_emulator/Kconfig
index 8f73d077f6..c0af4f403b 100644
--- a/drivers/bios_emulator/Kconfig
+++ b/drivers/bios_emulator/Kconfig
@@ -1,8 +1,12 @@
-config BIOSEMU
-	bool
+menuconfig BIOSEMU
+	bool "Enable x86 BIOS emulator (useful for running x86 video ROMs)"
+
+if BIOSEMU
 
 config SPL_BIOSEMU
-	bool
+	bool "Enable BIOSEMU in SPL"
 
 config X86EMU_RAW_IO
-	bool
+	bool "Raw I/O. This is possible only on x86 systems"
+
+endif
-- 
2.43.0

