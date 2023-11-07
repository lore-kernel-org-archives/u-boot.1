Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F38C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40314876BA;
	Wed,  8 Nov 2023 00:21:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="klEZy+sU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B22F876AE; Wed,  8 Nov 2023 00:21:51 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8417787447
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:21:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A7NLgbX087124;
 Tue, 7 Nov 2023 17:21:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699399302;
 bh=xdcNtvZGDMewsDlI+t401xOZaSlVv7dmmeVKOqtIzFE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=klEZy+sUGmJSe0y/ER7HeFS4UgJ22gHSBQ2YZ2J7Ohi31uYVLqKpkwtEHKD95Ivnr
 GQxnhmORFt/ImIo8RUwGBn4N6SxcHGBN/yzEOMT1X16S3J/gHDeaR8f8kkO9+IIAzs
 /cl3wGo+uezW5OiKO+tghpo7lD5ngtHcSEhonhiA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A7NLg8p003608
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 17:21:42 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 17:21:42 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 17:21:42 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A7NLgXW050585;
 Tue, 7 Nov 2023 17:21:42 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Andrew Davis <afd@ti.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 3/3] configs: am62x: move 32K RTC crystal to common
Date: Tue, 7 Nov 2023 17:21:43 -0600
Message-ID: <20231107232139.2839534-8-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232139.2839534-5-bb@ti.com>
References: <20231107232139.2839534-5-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=bb@ti.com;
 h=from:subject; bh=orDp2R8rEEGSeoTmMQ24oYT0U2P93WXL1Py4VcYGHoI=;
 b=owNCWmg5MUFZJlNZ2hdoMwAAaX/////7333lmf23Xf/JdtKP/Xh+9v1f3evNxXjauvPP/v2wA
 RsYx2oAAaANPUA0BoND1A09QAAHqAD1ADQ0AAaaAAAGQNDQPSHpAyHkj9U21Q6ADRoaZNA0A9QA
 0NA/VNGhoNGhoAAyA0GgNGmmRo0GExGmnlA9TQepoANDQyPSHRp6QaZA0MjINAaGJgjENAZNAGQ
 NGjRiYCDEYE0ADQGRoGg0yDQDQAMAAIRttMxKYCQ3AyEQYGEvEtQhVeKggEE0jLSYJ+8Bc1kDXT
 EEGRR0Hoo0ivfDbd5SdRbGOjIwHJAQuyvYlJTH9wwiO27pvCTzdqZAmVcr0x1ee7wWaIIF+Mnrh
 iDjztSdkDQI0WXKrjmJuqxez1XtumLICrmiwqLZhiYqwaaDSNWPvH8iNSeDAPJBXTj7nLR0gPax
 QuK9vA/zAfhn6CKkW0uTZQemUZ3yrYH6PBbjq1KVpkCH2g/8Yvok/c7JVdMR/G86N6+R/FpFX9R
 ECWTyKVcgNzJKpNYFS0usVltgT74MJSjaZDCmoDEC045OhK/C71Su8lAN7R0PM8jHPAWIDoluNX
 Xi9EYAS0VWIhRHhg1AK0c3gTAYbhQiFiZsAWkhYpUosdmJwwwSRe9MiCFk2+0Ky5RAqIuDFXvAJ
 QNApGELuSKcKEhtC7QZgA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

The am62x utilizes the same 32k crystal for a more accurate RTC clock
source. Enable the configuration to set this up for Linux.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62x/evm.c            | 5 +++++
 configs/am62x_evm_a53_defconfig | 1 +
 2 files changed, 6 insertions(+)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index ad939088402e4..1b2ff7e5c2443 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -19,6 +19,8 @@
 #include <asm/arch/hardware.h>
 #include <dm/uclass.h>
 
+#include "../common/rtc.c"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
@@ -46,6 +48,9 @@ int splash_screen_prepare(void)
 
 int board_init(void)
 {
+	if (IS_ENABLED(CONFIG_BOARD_HAS_32K_RTC_CRYSTAL))
+		board_rtc_init();
+
 	return 0;
 }
 
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index df2511546eab7..e9ee265fd7a91 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_BOARD_HAS_32K_RTC_CRYSTAL=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
-- 
2.42.0

