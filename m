Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F10EB8FB0
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 11:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F2186722;
	Thu,  7 Sep 2023 13:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uRJnAzJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E6C8676C; Thu,  7 Sep 2023 13:21:39 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C29D86410
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 13:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0D7393F6B5; 
 Thu,  7 Sep 2023 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1694085696;
 bh=LWxaxvKVIXsww1bCXiRJyrVmmGG2TC0kyZb/Pmiu9o0=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=uRJnAzJ1msIv82jLXuhnwEkaXKTmEEl5WS57o0/tXFvd81p2VTN3T18KPLQm5iNgZ
 eW2l6Nh5ZrWW7QPNRp594gGHMczlzzSHn8RV7fLd/Lxuys/ZKBJ+gr5L4AWaqV1Ukx
 pxCpycdWyOwoY/DjUUbk14kH1P1I73srIS0RV/U/DJt825sTS8be+fwgHI/i4ULzd1
 uNtTVinKoOvN9MxXNX76/fCCrTyUTvNiSF83xo0PBUBFhYL7LC2iS1FFEi08XUUZfL
 Bu3U57mTNko6L+5ZbLLNc4K6M8Pkq55q9shIhBK2vkw+JGgWgoBvZvssrpsMCHeOio
 XqHRQzu7TTAkw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: set fdtfile on VisionFive 2
Date: Thu,  7 Sep 2023 13:21:28 +0200
Message-Id: <20230907112128.342315-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Multiple revisions of the StarFive VisionFive 2 board exist. They can be
identified by reading their EEPROM.

Linux uses two differently named device-tree files. To load the correct
device-tree we need to set $fdtfile to the device-tree file name that
matches the board revision.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/Kconfig                            |  1 +
 .../visionfive2/starfive_visionfive2.c        | 43 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6771d8d919..1c62c2345b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -26,6 +26,7 @@ config TARGET_SIFIVE_UNMATCHED
 
 config TARGET_STARFIVE_VISIONFIVE2
 	bool "Support StarFive VisionFive2 Board"
+	select BOARD_LATE_INIT
 
 config TARGET_TH1520_LPI4A
 	bool "Support Sipeed's TH1520 Lichee PI 4A Board"
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index d609262b67..05d8d2d657 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -5,14 +5,20 @@
  */
 
 #include <common.h>
-#include <asm/io.h>
-#include <asm/sections.h>
 #include <cpu_func.h>
 #include <dm.h>
+#include <env.h>
+#include <asm/arch/eeprom.h>
+#include <asm/io.h>
+#include <asm/sections.h>
 #include <linux/bitops.h>
 
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
+#define FDTFILE_VISIONFIVE2_1_2A \
+	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
+#define FDTFILE_VISIONFIVE2_1_3B \
+	"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
 
 /* enable U74-mc hart1~hart4 prefetcher */
 static void enable_prefetcher(void)
@@ -33,6 +39,31 @@ static void enable_prefetcher(void)
 	}
 }
 
+/**
+ * set_fdtfile() - set the $fdtfile variable based on the board revision
+ */
+static void set_fdtfile(void)
+{
+	u8 version;
+	const char *fdtfile;
+
+	version = get_pcb_revision_from_eeprom();
+	switch (version) {
+	case 'a':
+	case 'A':
+		fdtfile = FDTFILE_VISIONFIVE2_1_2A;
+	        break;
+
+	case 'b':
+	case 'B':
+	default:
+		fdtfile = FDTFILE_VISIONFIVE2_1_3B;
+	        break;
+	};
+
+	env_set("fdtfile", fdtfile);
+}
+
 int board_init(void)
 {
 	enable_caches();
@@ -41,6 +72,14 @@ int board_init(void)
 	return 0;
 }
 
+int board_late_init(void)
+{
+	if (CONFIG_IS_ENABLED(ID_EEPROM))
+		set_fdtfile();
+
+	return 0;
+}
+
 void *board_fdt_blob_setup(int *err)
 {
 	*err = 0;
-- 
2.40.1

