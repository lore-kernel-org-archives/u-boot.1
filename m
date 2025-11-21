Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5299FCFA468
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E273802C1;
	Fri, 21 Nov 2025 09:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="CVl2+Z2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC286801CF; Fri, 21 Nov 2025 09:14:41 +0100 (CET)
Received: from mx-relay47-hz3.antispameurope.com
 (mx-relay47-hz3.antispameurope.com [94.100.134.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10D8830A0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413995d28=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate47-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=00Pi691BZg8ZNQGXwzSD6yZR3DAhyJpYn2Ac0+evmoE=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763712878;
 b=sxi+wQQJRmhpAHQSDcRO0Af23EE7WjDmAsPIuFtFOdnHaHMhKbGZUKf4eIDJ19i19I+c2hZY
 4WO0ffyGh/rDfVWFfh5cE/cONXa8jzlHo/waJW120RPeCq/EiPhKyO4fV0PdD5SekP4PgD7X53A
 wOXWiA1xH/SWSZjhARXa9MBqqY1HjzOcr9kf59smOKP7/zTPzfalbM72pPuHd5vbL6HKrQjjQGH
 z3P6zKCI1Ybf27742kmT2QkdOn3QqMdOro5/mnHS7N+LK7aDChaDRxVcdV7cd9iJkaGDCMQ6dlz
 H5pO92QnqBmf+/DToiF4raxWYWiepOh0udq3DuFhOkV3g==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763712878;
 b=oOboHjHjpf8zAF0H0KQbi72BFcXRxD2L1SG+Yx1Sz8dief2ePc0ThrBXDOFja8p3DAkVDsAc
 B1znIe4fJ5WCj3LCHG+ZmaqXUDkYpcasly354SNXISLbKB5DqjApeGkmuKv7cmlqtQtBjCLCIrT
 MW2WO6riZ+4Iq1oIu+lfIJ81pQcC6eVLe13XhVu2OoZ7NqELTc9qemaNa2Gmq0yzF3uPRUfdZrJ
 2QcYqw4nJTqlPj2z+p7Q/EJpkCWr5S6ZN6Zh8lo3GvGfUXEOJ1inqqVFrlD4UbEJF8zM1kMsTqq
 yy8JwHKarTKmVHlq/f1h8ceH1CHnOmMFLBOxFEnqh2NVA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay47-hz3.antispameurope.com; Fri, 21 Nov 2025 09:14:38 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 E5100220C57; Fri, 21 Nov 2025 09:14:20 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Paul Gerber <Paul.Gerber@tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 2/4] board: tqma6: style fixes
Date: Fri, 21 Nov 2025 09:11:28 +0100
Message-ID: <20251121081138.73285-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
References: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay47-hz3.antispameurope.com with 4dCSg13TzRz4MMNy
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: c8dbdf97de70e2d5361ac586c52cc0f4
X-cloud-security: scantime:2.441
DKIM-Signature: a=rsa-sha256;
 bh=00Pi691BZg8ZNQGXwzSD6yZR3DAhyJpYn2Ac0+evmoE=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763712878; v=1;
 b=CVl2+Z2X608gSr1fjyNVFJusQAkbLwiCDGhI5fudsPCRyHO86xlv8HSXUfsKGE/ruj/0pW2X
 iDZM8EcQQqaKNDQ57zlZS1OW4AvkKGNSuQ77J6HbYwDF8RiUXQsAG3jvSCOgvTvchiZgnJSRdz6
 9jydThyjjq46jXGPCNVqwcgAeOgqCQvj/ezzr5EvqAy5Mnc5wjs4mXBzYEeNhr85/HU8XjvoMVG
 SXxIsOpI7AYoE12EOzR8F6U+61tcvn5VSpiKNjBZpCRBdIQ5QiTTiLb3TVGXwlIj9ztlTWVly1r
 zm8gdjEfOslMevkGt1kelYeQa5WEBFCIAFFJ5XEtSTiHg==
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

From: Paul Gerber <Paul.Gerber@tq-group.com>

fix checkpatch warnings

- WARNING: break is not useful after a return
- WARNING: Comparisons should place the constant
  on the right side of the test
- WARNING: please write a help paragraph that fully describes
  the config symbol with at least 2 lines

Signed-off-by: Paul Gerber <Paul.Gerber@tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/Kconfig      | 23 +++++++++++++++--------
 board/tq/tqma6/tqma6.c      |  5 -----
 board/tq/tqma6/tqma6_mba6.c |  2 +-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index b42c8e24ade..599b3a72f70 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -13,26 +13,29 @@ choice
 	prompt "TQMa6 SoC variant"
 	default TQMA6Q
 	help
-	  select the TQMa6 module variant. The variants differing in the used
+	  select the TQMa6 module variant. The variants only differ in the used
 	  i.MX6 CPU type and DRAM
 
 config TQMA6Q
 	bool "TQMa6Q / TQMa6D"
 	depends on MX6Q
 	help
-	  select TQMa6Q / TQMa6D with i.MX6Q/D and 1GiB DRAM
+	  select TQMa6Q / TQMa6D variant with i.MX6Q resp. i.MX6D
+	  with 1GiB DRAM
 
 config TQMA6DL
 	bool "TQMa6DL"
 	depends on MX6DL
 	help
-	  select TQMa6DL with i.MX6DL and 1GiB DRAM
+	  select TQMa6DL variant with i.MX6DL
+	  with 1GiB DRAM
 
 config TQMA6S
 	bool "TQMa6S"
 	depends on MX6S
 	help
-	  select TQMa6S with i.MX6S and 512 MiB DRAM
+	  select TQMa6S variant with i.MX6S
+	  with 512 MiB DRAM
 
 endchoice
 
@@ -46,12 +49,14 @@ choice
 config TQMA6X_MMC_BOOT
 	bool "MMC / SD Boot"
 	help
-	  Boot from eMMC / SD Card
+	  Boot from
+	  eMMC / SD Card
 
 config TQMA6X_SPI_BOOT
 	bool "SPI NOR Boot"
 	help
-	  Boot from on board SPI NOR flash
+	  Boot from
+	  board SPI NOR flash
 
 endchoice
 
@@ -59,7 +64,8 @@ choice
 	prompt "TQMa6 base board variant"
 	default MBA6
 	help
-	  Select base board for TQMa6
+	  Select the baseboard variant for the TQMa6 module.
+	  By default the MBA6 starterkit is used.
 
 config MBA6
 	bool "TQMa6 on MBa6 Starterkit"
@@ -80,7 +86,8 @@ config MBA6
 config WRU4
 	bool "OHB WRU-IV"
 	help
-	  Select the OHB Systems AG WRU-IV baseboard.
+	  Select the
+	  OHB Systems AG WRU-IV baseboard.
 
 endchoice
 
diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index a7317b9e761..83db2d1ad38 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -37,7 +37,6 @@ int dram_init(void)
 
 static const uint16_t tqma6_emmc_dsr = 0x0100;
 
-
 int board_early_init_f(void)
 {
 	return tqma6_bb_board_early_init_f();
@@ -60,16 +59,12 @@ static const char *tqma6_get_boardname(void)
 	switch ((cpurev & 0xFF000) >> 12) {
 	case MXC_CPU_MX6SOLO:
 		return "TQMa6S";
-		break;
 	case MXC_CPU_MX6DL:
 		return "TQMa6DL";
-		break;
 	case MXC_CPU_MX6D:
 		return "TQMa6D";
-		break;
 	case MXC_CPU_MX6Q:
 		return "TQMa6Q";
-		break;
 	default:
 		return "??";
 	};
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index b8f76591006..630ffdd63a9 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -74,7 +74,7 @@ int board_mmc_get_env_dev(int devno)
 	 * the boot device first ...
 	 * Note: SDHC3 == idx2
 	 */
-	return (2 == devno) ? 0 : 1;
+	return (devno == 2) ? 0 : 1;
 }
 
 int board_phy_config(struct phy_device *phydev)
-- 
2.43.0

