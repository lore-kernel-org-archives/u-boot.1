Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A34C00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5114D88159;
	Mon, 15 Apr 2024 08:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D05188189; Mon, 15 Apr 2024 08:08:09 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA3088169
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYL0fnWz9tCl;
 Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vRzVWe4-QDZl; Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYJ6t9Qz9t0H;
 Mon, 15 Apr 2024 08:08:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E7FEB8B778;
 Mon, 15 Apr 2024 08:08:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id pGD5SjoE6jpY; Mon, 15 Apr 2024 08:08:04 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CF7908B770;
 Mon, 15 Apr 2024 08:08:04 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 02/17] board: cssi: Fix SPI nodes in DTS
Date: Mon, 15 Apr 2024 08:07:15 +0200
Message-ID: <d280bb0e5171d1f09a5e1b2ada4aae7fd8a64637.1713160866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713160866.git.christophe.leroy@csgroup.eu>
References: <cover.1713160866.git.christophe.leroy@csgroup.eu>
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

When adding additional SPI peripherals, the reg property needs to
be added, and this leads to the following error:

  arch/powerpc/dts/cmpc885.dtb: Warning (reg_format): /immr@ff000000/spi@aa0/temp@1:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
  arch/powerpc/dts/cmpc885.dtb: Warning (reg_format): /immr@ff000000/spi@aa0/temp@2:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)

Fix it by removing cell-index and cell-size which is unused and add
reg property. Also fix node name to be in line with reg value.
Also add missing compatible for eeprom node.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/dts/cmpc885.dts | 6 +++---
 arch/powerpc/dts/cmpcpro.dts | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/dts/cmpc885.dts b/arch/powerpc/dts/cmpc885.dts
index 7b9566a0fa..9a33e7e77c 100644
--- a/arch/powerpc/dts/cmpc885.dts
+++ b/arch/powerpc/dts/cmpc885.dts
@@ -83,13 +83,13 @@
 		spi: spi@aa0 {
 			status = "okay";
 			#address-cells = <1>;
-			#size-cells = <1>;
-			cell-index = <0>;
+			#size-cells = <0>;
 			compatible = "fsl,mpc8xx-spi";
 			gpios = <&CPM1_PIO_B 21 1>; /* /EEPROM_CS ACTIVE_LOW */
 
 			eeprom@0 {
-				cell-index = <1>;
+				reg = <0>;
+				compatible = "atmel,at25", "cs,eeprom";
 			};
 		};
 	};
diff --git a/arch/powerpc/dts/cmpcpro.dts b/arch/powerpc/dts/cmpcpro.dts
index c27d9dba33..78f8a9f4d3 100644
--- a/arch/powerpc/dts/cmpcpro.dts
+++ b/arch/powerpc/dts/cmpcpro.dts
@@ -142,9 +142,9 @@
 			mode = "cpu";
 			gpios = <&qe_pio_d 3 1>;
 			clock-frequency = <0>;
-			eeprom@3 {
+			eeprom@0 {
+				reg = <0>;
 				compatible = "atmel,at25", "cs,eeprom";
-				cell-index = <1>;
 			};
 		};
 		eth0: ucc@3000 {
-- 
2.43.0

