Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB02EC5475B
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 13:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 725F487EFE;
	Sun,  3 Mar 2024 14:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="R30Fa2/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA98987F12; Sun,  3 Mar 2024 14:01:30 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13FE887F03
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 14:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 37C4E4100F; 
 Sun,  3 Mar 2024 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709470887;
 bh=EIkMX+qO9blyu588Z7WGy11ZL64g7OXCgivRrcCkzHM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=R30Fa2/Q2+RopA0cAvjwGmlgc9LlRgVYXLNWrn76G5ghmqZ09Tp/kSMKi2sL3jVF/
 nYCVOi77wsg7j6EJFzO7PuDvF00wgCNSpIW2Xnj2hmkLTS1cWbLUwtsT8L7PfxBnEo
 m+U4ZdpXxDX+WkfTkwY46n11kRX/O5chMbc+KO3A0G2L+DxMb+ox3IVeAqZOdocCWz
 Dy6VTBQV/3mD/+XSOuTl3djOPuNcTalORy5+5U4vFFRllrY82ZwNlHWIJ601P7Fvi8
 FhHb5kJ+ihBbLL/rkb9n9XZ9ETJm2N7kIR2rIyfNk0ncsQWHDKKWQhuTy/0dyvMeH3
 4suBrfOgzxHHA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 2/5] riscv: set fdtfile on Milk-V Mars
Date: Sun,  3 Mar 2024 14:01:19 +0100
Message-ID: <20240303130122.29983-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
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

Set environment variable fdtfile to the correct value for the Milk-V Mars
board.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .../visionfive2/starfive_visionfive2.c        | 43 +++++++++++++------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 78e118d5a05..9970e309690 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <fdt_support.h>
 #include <env.h>
+#include <log.h>
 #include <asm/arch/eeprom.h>
 #include <asm/io.h>
 #include <asm/sections.h>
@@ -17,6 +18,8 @@
 DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
+#define FDTFILE_MILK_V_MARS \
+	"starfive/jh7110-milkv-mars.dtb"
 #define FDTFILE_VISIONFIVE2_1_2A \
 	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
 #define FDTFILE_VISIONFIVE2_1_3B \
@@ -48,20 +51,34 @@ static void set_fdtfile(void)
 {
 	u8 version;
 	const char *fdtfile;
+	const char *product_id;
 
-	version = get_pcb_revision_from_eeprom();
-	switch (version) {
-	case 'a':
-	case 'A':
-		fdtfile = FDTFILE_VISIONFIVE2_1_2A;
-	        break;
-
-	case 'b':
-	case 'B':
-	default:
-		fdtfile = FDTFILE_VISIONFIVE2_1_3B;
-	        break;
-	};
+	product_id = get_product_id_from_eeprom();
+	if (!product_id) {
+		log_err("Can't read EEPROM\n");
+		return;
+	}
+	if (!strncmp(product_id, "MARS", 4)) {
+		fdtfile = FDTFILE_MILK_V_MARS;
+	} else if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+
+		switch (version) {
+		case 'a':
+		case 'A':
+			fdtfile = FDTFILE_VISIONFIVE2_1_2A;
+			break;
+
+		case 'b':
+		case 'B':
+		default:
+			fdtfile = FDTFILE_VISIONFIVE2_1_3B;
+			break;
+		}
+	} else {
+		log_err("Unknown product\n");
+		return;
+	}
 
 	env_set("fdtfile", fdtfile);
 }
-- 
2.43.0

