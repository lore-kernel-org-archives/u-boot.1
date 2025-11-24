Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1025CFD31C
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 07:58:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740E883D17;
	Mon, 24 Nov 2025 08:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EmVuB3WP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C351083C7B; Mon, 24 Nov 2025 08:57:35 +0100 (CET)
Received: from mx-relay110-hz1.antispameurope.com
 (mx-relay110-hz1.antispameurope.com [94.100.132.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F5B83C96
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 08:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0416cdc3b4=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate110-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=00Pi691BZg8ZNQGXwzSD6yZR3DAhyJpYn2Ac0+evmoE=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763971050;
 b=CcOjeRIOSGyWpJnSgc/SQzDe8iXt34lDpOp4CQgr3Z0VlY+J6/flQ2IrlOKZ8bP9D+L7Rep6
 mygxQa2FJJdkWSH9nIE4nRb1pV3Sr/zwOmI+tKnGc4xdjQy7E/PpYuHSmFKJX0I1R+XG/N/W+DH
 JiBiJ2PDzpikpkPhbIHYb+lqyvNSD7xdQ9AWUwJEjFZFuNswobKyN7Uzgr5Tx8rKz4Twj0QuyvE
 h30bNHBBxqhlcr5RgyD8t6iLEA/tt1X8+DoE5NI0J7pcW9PIxJfSxh2HrzzC0ABtx+uK/GhqreA
 FY1ZRbV9E0yyUtpiyvtzD5C5sYw+VBMHnKlU+8CAs6f/g==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763971050;
 b=C/OtfHYLPw/kNriTh58YnhyQ/iVGBI6/78b/71WzGvD0hXTKDyY7JaoCyS6lccKxPBIBWXZN
 /LQl9jf7n5TTBFYAsXcVG217ZXjH+vc+N7Wva0prHbgbTd6CGRUAy37eNWciahLfU/Wui3QU2Qf
 FSp4uJZEmkQsxc3dqJzjX5oS1Lrttpw21pEzovN9WJyfervhE/00+sNpo2ptiSzolK7aTiLB19M
 /JhR5Ah4/4YnvJf0/lmcvLE9Pakwr+YBt6uXZ6xdO9unHed3DsDMxYaFkqgFpKBp8EcFo+s36vL
 0FwER1efJaBFNKIfjFxJNzkczz0K7tsiinOZMFf1ffzzg==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay110-hz1.antispameurope.com; Mon, 24 Nov 2025 08:57:30 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 5146ECC0CB7; Mon, 24 Nov 2025 08:57:16 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Paul Gerber <Paul.Gerber@tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH v2 2/4] board: tqma6: style fixes
Date: Mon, 24 Nov 2025 08:55:24 +0100
Message-ID: <20251124075540.14930-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124075540.14930-1-Max.Merchel@ew.tq-group.com>
References: <20251124075540.14930-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay110-hz1.antispameurope.com with 4dFJ7w585Xz3GBmY
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 3a834c8677f2f561bd54f22f88b151a7
X-cloud-security: scantime:2.205
DKIM-Signature: a=rsa-sha256;
 bh=00Pi691BZg8ZNQGXwzSD6yZR3DAhyJpYn2Ac0+evmoE=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763971050; v=1;
 b=EmVuB3WPVDLr8r4pcZtX8xNXdfUcGsFskfRAE6DHN3gIFt+/NzzpAVO/sRrYwOwrCzN5eRon
 wv0yPx0xK/E7XOdhjidN3RR6aKoMRnfmPFN1Mq4e9DVLlA2d74vktzrGvfvKJ+1/7BQriWb25j4
 9tzfEj/NZx5KxVSpx9UomM/sz6u8VSz5cqBtofY55o5ZeUizr/DgOtg4/IB93UqKq9rmHI+OWg5
 JaaAQvoVQ967bRBeTZcBgqAzTYKuRip1t7Vg6nnd/Q8CTDRgxVeFYNzK3/qGKXiOUkhd3xxyYw8
 SltMfgQlfJstLegB6iDPBIXGHgljPzzIgpMPiNoImVGTg==
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

