Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB146D47CDA
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC0383923;
	Fri, 16 Jan 2026 11:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="iU13vR0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 010E08388D; Fri, 16 Jan 2026 11:56:24 +0100 (CET)
Received: from mx-relay48-hz3.antispameurope.com
 (mx-relay48-hz3.antispameurope.com [94.100.134.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CED88389A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0469552be2=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=JrQRh2aUldShwa0Avn3u3OSuRtScTyjJSXDSkot7GM0=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1768560980;
 b=rWpUF5FVS42jK0R0/VyliyOw0u83dR5zV9jIo/Bo0ZAT4knfdS0yz1uexhFqwTKM7uvUd49D
 jDR2rxMyJspkRJ/BXftk6kSGrxF4+TH9kq7noPLrDvBSO9+mi23/wj8W3F1sY4QAlUCgxIrOMMf
 AIrMF3UqZFY9RlC5/UblyAyDashbatalHHVhI9IYXp/Yq4OBHO+SQJlxX4rRLDqt+mLrqM73exI
 bdtc52HCHaONTj5PI0FrjkLP0ouFQY81z20G/qeStBcuXy279lIZBfFGZKyXfV4qOsudZCjsUxe
 Dpsxa7CZEbNEIAaNAY9IoHIzCp94kO+EYJNWrGkz1+rkA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1768560980;
 b=rpO/BZVHNU4zgWTXXg201NCOjuMvPOrk5ODOeLXo1iFX93TJaNyeJ2hixlF+7rNt6+Xg5hgd
 E4cKnwnmfZD4w3fPWPvtD1imjioBJcMm5WunskKlKq2gbTVaTIrtqXUATXuuICB/Bu6Zz0r+95H
 I8H5IFu4LUYwkS8+oVw3jM7/U6+qTdtOxYkPOgasvO1CxO4+T5OI6Aul93tc17hzAvkBSIaMA73
 sRxp//c3THEMtF61cexY/SERHRActXLyUt7Aptn5VOhJWJ/D+RkogowOMMC9G2CNxOjKpq4dHON
 fHbpEHdQyeG9UHlfTAwJiU5ZkO9Zo/7E+zcsQIkn1iAOw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay48-hz3.antispameurope.com; Fri, 16 Jan 2026 11:56:20 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 4B443220D9E; Fri, 16 Jan 2026 11:56:06 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 5/5] board: tqma6: update RAM timing to verified settings
 Rev.0300D
Date: Fri, 16 Jan 2026 11:53:39 +0100
Message-ID: <20260116105351.2934665-6-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
References: <20260116105351.2934665-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay48-hz3.antispameurope.com with 4dsxbp5RyYz1kNh4T
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 343b85adee10b0a0f76109c654a577f3
X-cloud-security: scantime:1.847
DKIM-Signature: a=rsa-sha256;
 bh=JrQRh2aUldShwa0Avn3u3OSuRtScTyjJSXDSkot7GM0=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1768560980; v=1;
 b=iU13vR0c6POiNMunr/xmOCby6HCKlJdZKywDB8cQCj8bd8ovRszkn0OuMpveP2+zi4MfQtqr
 l2+iFf15wRTYbV+uIF5+d4XLEo0skPCALzdjMeFSWzGOMjYtWJ2vE+Rg4UwfP9a4Aj2w/6FyPxN
 e3WJa+uS3z7v5gb5uBpa2saM3DAslgApNieHoVuApJDD/YlKLnVpsoe9UT1Q7eSwR6hN5scW5R+
 IhTU3OQ/0cGuaUinYCCAW4X/7EXvqKeaCGQh1BaAR6NAYUg9Jbw8mt1TXIHhf2EGNykGsKUeieQ
 aWziIPEyvQ1dVBzj9nsBZv7DI45nPcWlkjDkNlTvKBnBA==
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Input from TQ-Systems hardware qualification team.
Fixes performance issues if ethernet and display are used simultaneously.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/tqma6dl.cfg |  8 ++++----
 board/tq/tqma6/tqma6q.cfg  | 37 +++++++++++++++++++------------------
 board/tq/tqma6/tqma6s.cfg  | 25 +++++++++++++------------
 3 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/board/tq/tqma6/tqma6dl.cfg b/board/tq/tqma6/tqma6dl.cfg
index f7289adb40a..17a3d010517 100644
--- a/board/tq/tqma6/tqma6dl.cfg
+++ b/board/tq/tqma6/tqma6dl.cfg
@@ -29,7 +29,7 @@ BOOT_FROM      spi
 #include "asm/arch/iomux.h"
 #include "asm/arch/crm_regs.h"
 
-/* TQMa6DL DDR config Rev. 0100E */
+/* TQMa6DL DDR config Rev. 0300D */
 /* IOMUX configuration */
 DATA 4, MX6_IOM_GRP_DDR_TYPE, 0x000C0000
 DATA 4, MX6_IOM_GRP_DDRPKE, 0x00000000
@@ -38,7 +38,7 @@ DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
 DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
 DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
 DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
-DATA 4, MX6_IOM_DRAM_RESET, 0x000C3030
+DATA 4, MX6_IOM_DRAM_RESET, 0x00000030
 DATA 4, MX6_IOM_DRAM_SDCKE0, 0x00003000
 DATA 4, MX6_IOM_DRAM_SDCKE1, 0x00000000
 DATA 4, MX6_IOM_DRAM_SDBA2, 0x00000000
@@ -104,7 +104,7 @@ DATA 4, MX6_MMDC_P0_MDOTC, 0x00333030
 DATA 4, MX6_MMDC_P0_MDCFG0, 0x3F435333
 DATA 4, MX6_MMDC_P0_MDCFG1, 0xB68E8B63
 DATA 4, MX6_MMDC_P0_MDCFG2, 0x01FF00DB
-DATA 4, MX6_MMDC_P0_MDMISC, 0x00001740
+DATA 4, MX6_MMDC_P0_MDMISC, 0x00011740
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00008000
 DATA 4, MX6_MMDC_P0_MDRWD, 0x000026D2
 DATA 4, MX6_MMDC_P0_MDOR, 0x00431023
@@ -113,7 +113,7 @@ DATA 4, MX6_MMDC_P0_MDCTL, 0x831A0000
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00408032
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00008033
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00048031
-DATA 4, MX6_MMDC_P0_MDSCR, 0x05208030
+DATA 4, MX6_MMDC_P0_MDSCR, 0x15208030
 DATA 4, MX6_MMDC_P0_MDSCR, 0x04008040
 DATA 4, MX6_MMDC_P0_MDREF, 0x00007800
 DATA 4, MX6_MMDC_P0_MPODTCTRL, 0x00022222
diff --git a/board/tq/tqma6/tqma6q.cfg b/board/tq/tqma6/tqma6q.cfg
index ad862535c50..673482b543c 100644
--- a/board/tq/tqma6/tqma6q.cfg
+++ b/board/tq/tqma6/tqma6q.cfg
@@ -29,7 +29,7 @@ BOOT_FROM      spi
 #include "asm/arch/iomux.h"
 #include "asm/arch/crm_regs.h"
 
-/* TQMa6Q/D DDR config Rev. 0100B */
+/* TQMa6Q/D DDR config Rev. 0300D */
 /* IOMUX configuration */
 DATA 4, MX6_IOM_GRP_DDR_TYPE, 0x000C0000
 DATA 4, MX6_IOM_GRP_DDRPKE, 0x00000000
@@ -38,7 +38,7 @@ DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
 DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
 DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
 DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
-DATA 4, MX6_IOM_DRAM_RESET, 0x00003030
+DATA 4, MX6_IOM_DRAM_RESET, 0x00000030
 DATA 4, MX6_IOM_DRAM_SDCKE0, 0x00003000
 DATA 4, MX6_IOM_DRAM_SDCKE1, 0x00000000
 DATA 4, MX6_IOM_DRAM_SDBA2, 0x00000000
@@ -75,18 +75,18 @@ DATA 4, MX6_IOM_DRAM_DQM7, 0x00000030
 /* memory interface calibration values */
 DATA 4, MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003
 DATA 4, MX6_MMDC_P1_MPZQHWCTRL, 0xA1390003
-DATA 4, MX6_MMDC_P0_MPWLDECTRL0, 0x001B0013
-DATA 4, MX6_MMDC_P0_MPWLDECTRL1, 0x0018001B
-DATA 4, MX6_MMDC_P1_MPWLDECTRL0, 0x001B0016
-DATA 4, MX6_MMDC_P1_MPWLDECTRL1, 0x0012001C
-DATA 4, MX6_MMDC_P0_MPDGCTRL0, 0x43400350
-DATA 4, MX6_MMDC_P0_MPDGCTRL1, 0x023E032C
-DATA 4, MX6_MMDC_P1_MPDGCTRL0, 0x43400348
-DATA 4, MX6_MMDC_P1_MPDGCTRL1, 0x03300304
-DATA 4, MX6_MMDC_P0_MPRDDLCTL, 0x3C323436
-DATA 4, MX6_MMDC_P1_MPRDDLCTL, 0x38383242
-DATA 4, MX6_MMDC_P0_MPWRDLCTL, 0x3E3C4440
-DATA 4, MX6_MMDC_P1_MPWRDLCTL, 0x4236483E
+DATA 4, MX6_MMDC_P0_MPWLDECTRL0, 0x00180016
+DATA 4, MX6_MMDC_P0_MPWLDECTRL1, 0x001F0018
+DATA 4, MX6_MMDC_P1_MPWLDECTRL0, 0x00130023
+DATA 4, MX6_MMDC_P1_MPWLDECTRL1, 0x00040018
+DATA 4, MX6_MMDC_P0_MPDGCTRL0, 0x43500364
+DATA 4, MX6_MMDC_P0_MPDGCTRL1, 0x034C0344
+DATA 4, MX6_MMDC_P1_MPDGCTRL0, 0x43580364
+DATA 4, MX6_MMDC_P1_MPDGCTRL1, 0x033C031C
+DATA 4, MX6_MMDC_P0_MPRDDLCTL, 0x3C323438
+DATA 4, MX6_MMDC_P1_MPRDDLCTL, 0x383A3040
+DATA 4, MX6_MMDC_P0_MPWRDLCTL, 0x3A3E4440
+DATA 4, MX6_MMDC_P1_MPWRDLCTL, 0x4834483A
 DATA 4, MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333
 DATA 4, MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333
 DATA 4, MX6_MMDC_P0_MPRDDQBY2DL, 0x33333333
@@ -104,18 +104,19 @@ DATA 4, MX6_MMDC_P0_MDOTC, 0x09444040
 DATA 4, MX6_MMDC_P0_MDCFG0, 0x545A79B4
 DATA 4, MX6_MMDC_P0_MDCFG1, 0xDB538F64
 DATA 4, MX6_MMDC_P0_MDCFG2, 0x01FF00DB
-DATA 4, MX6_MMDC_P0_MDMISC, 0x00001740
+DATA 4, MX6_MMDC_P0_MDMISC, 0x00011740
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00008000
 DATA 4, MX6_MMDC_P0_MDRWD, 0x000026D2
 DATA 4, MX6_MMDC_P0_MDOR, 0x005A1023
 DATA 4, MX6_MMDC_P0_MDASP, 0x00000027
 DATA 4, MX6_MMDC_P0_MDCTL, 0x831A0000
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00088032
+
+DATA 4, MX6_MMDC_P0_MDSCR, 0x00488032
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00008033
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00048031
-DATA 4, MX6_MMDC_P0_MDSCR, 0x09308030
+DATA 4, MX6_MMDC_P0_MDSCR, 0x19308030
 DATA 4, MX6_MMDC_P0_MDSCR, 0x04008040
-DATA 4, MX6_MMDC_P0_MDREF, 0x00005800
+DATA 4, MX6_MMDC_P0_MDREF, 0x00007800
 DATA 4, MX6_MMDC_P0_MPODTCTRL, 0x00022222
 DATA 4, MX6_MMDC_P1_MPODTCTRL, 0x00022222
 DATA 4, MX6_MMDC_P0_MDPDC, 0x00025536
diff --git a/board/tq/tqma6/tqma6s.cfg b/board/tq/tqma6/tqma6s.cfg
index e50fe3f57d7..a5057689d64 100644
--- a/board/tq/tqma6/tqma6s.cfg
+++ b/board/tq/tqma6/tqma6s.cfg
@@ -29,7 +29,7 @@ BOOT_FROM      spi
 #include "asm/arch/iomux.h"
 #include "asm/arch/crm_regs.h"
 
-/* TQMa6S DDR config Rev. 0100B */
+/* TQMa6S DDR config Rev. 0300D */
 /* IOMUX configuration */
 DATA 4, MX6_IOM_GRP_DDR_TYPE, 0x000C0000
 DATA 4, MX6_IOM_GRP_DDRPKE, 0x00000000
@@ -38,7 +38,7 @@ DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
 DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
 DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
 DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
-DATA 4, MX6_IOM_DRAM_RESET, 0x000C3030
+DATA 4, MX6_IOM_DRAM_RESET, 0x00000030
 DATA 4, MX6_IOM_DRAM_SDCKE0, 0x00003000
 DATA 4, MX6_IOM_DRAM_SDCKE1, 0x00000000
 DATA 4, MX6_IOM_DRAM_SDBA2, 0x00000000
@@ -75,17 +75,17 @@ DATA 4, MX6_IOM_DRAM_DQM7, 0x00000000
 /* memory interface calibration values */
 DATA 4, MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003
 DATA 4, MX6_MMDC_P1_MPZQHWCTRL, 0xA1380000
-DATA 4, MX6_MMDC_P0_MPWLDECTRL0, 0x0014000E
-DATA 4, MX6_MMDC_P0_MPWLDECTRL1, 0x00120014
+DATA 4, MX6_MMDC_P0_MPWLDECTRL0, 0x004C004A
+DATA 4, MX6_MMDC_P0_MPWLDECTRL1, 0x003F0048
 DATA 4, MX6_MMDC_P1_MPWLDECTRL0, 0x00000000
 DATA 4, MX6_MMDC_P1_MPWLDECTRL1, 0x00000000
-DATA 4, MX6_MMDC_P0_MPDGCTRL0, 0x0240023C
-DATA 4, MX6_MMDC_P0_MPDGCTRL1, 0x0228022C
+DATA 4, MX6_MMDC_P0_MPDGCTRL0, 0x42440240
+DATA 4, MX6_MMDC_P0_MPDGCTRL1, 0x022C022C
 DATA 4, MX6_MMDC_P1_MPDGCTRL0, 0x00000000
 DATA 4, MX6_MMDC_P1_MPDGCTRL1, 0x00000000
-DATA 4, MX6_MMDC_P0_MPRDDLCTL, 0x4A4A4E4A
+DATA 4, MX6_MMDC_P0_MPRDDLCTL, 0x484A504C
 DATA 4, MX6_MMDC_P1_MPRDDLCTL, 0x00000000
-DATA 4, MX6_MMDC_P0_MPWRDLCTL, 0x36362A32
+DATA 4, MX6_MMDC_P0_MPWRDLCTL, 0x34322832
 DATA 4, MX6_MMDC_P1_MPWRDLCTL, 0x00000000
 DATA 4, MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333
 DATA 4, MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333
@@ -104,18 +104,19 @@ DATA 4, MX6_MMDC_P0_MDOTC, 0x00333030
 DATA 4, MX6_MMDC_P0_MDCFG0, 0x3F435333
 DATA 4, MX6_MMDC_P0_MDCFG1, 0xB68E8B63
 DATA 4, MX6_MMDC_P0_MDCFG2, 0x01FF00DB
-DATA 4, MX6_MMDC_P0_MDMISC, 0x00001740
+DATA 4, MX6_MMDC_P0_MDMISC, 0x00011740
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00008000
 DATA 4, MX6_MMDC_P0_MDRWD, 0x000026D2
 DATA 4, MX6_MMDC_P0_MDOR, 0x00431023
 DATA 4, MX6_MMDC_P0_MDASP, 0x00000017
 DATA 4, MX6_MMDC_P0_MDCTL, 0x83190000
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00008032
+
+DATA 4, MX6_MMDC_P0_MDSCR, 0x00408032
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00008033
 DATA 4, MX6_MMDC_P0_MDSCR, 0x00048031
-DATA 4, MX6_MMDC_P0_MDSCR, 0x05208030
+DATA 4, MX6_MMDC_P0_MDSCR, 0x15208030
 DATA 4, MX6_MMDC_P0_MDSCR, 0x04008040
-DATA 4, MX6_MMDC_P0_MDREF, 0x00005800
+DATA 4, MX6_MMDC_P0_MDREF, 0x00007800
 DATA 4, MX6_MMDC_P0_MPODTCTRL, 0x00022222
 DATA 4, MX6_MMDC_P1_MPODTCTRL, 0x00000000
 DATA 4, MX6_MMDC_P0_MDPDC, 0x0002552D
-- 
2.43.0

