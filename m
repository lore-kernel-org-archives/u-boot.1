Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2276CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2005684894;
	Thu, 25 Jun 2026 16:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="eZufUUkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED8FE84894; Thu, 25 Jun 2026 16:18:00 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB7C846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 10FD31158D9; Thu, 25 Jun 2026 16:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1782397077; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Eb+ElvusCElitkrmif66zYoFr+S8zHRW/eCRRDf/6BI=;
 b=eZufUUkShveMDLvbL9obXEvDcXy2zrVssQq/UejAnUoVI0ClMqpmD3Nv0lc+KM+obelhwb
 h0Lm5qrQ9gHXeC2/7gtdXuxzA8AtE6pi2Ohs67P9Ve+xdP3+rqZuU2MbCPe12fvnPMaV84
 FmLazfakT97W1Zuj20RqSiWDvrEKyAnGq1/xNO3uMJ4Egun+lIZRqMXfuy30pPgfmvVusV
 K0KRHtW59npuCT0T/hN6bCLOg+rW+VPEWEU+3grGagULp7hONHW7j2oeA3Q7dUBD4WE2Jr
 /b+e1cTM3E3HcRUZ3y5F8S/RJNULHpOBXWb19f1BcJmI/dAUt0BTls3sfvWm3A==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heiko Schocher <hs@nabladev.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Michael Walle <mwalle@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH] mx6: ddr: Subtract half a cycle instead of three quarters of
 a cycle after DQS gating calibration
Date: Thu, 25 Jun 2026 16:17:29 +0200
Message-ID: <20260625141755.16568-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The current DRAM calibration sequence is implemented based on NXP
AN4467 Rev.2 03/2015, which in chapter "12.3.2 Calibration Sequence
Setup with Predefined Data Content" states:

"
9. For each of the DQSx:
- Read the HW_DG_UPx value from the MMDC0/1_MPDGHWSTx, subtract the
  value of 0xc0 (3/4 cycle).
"

However, the i.MX 6Solo/6DualLite Applications Processor Reference
Manual, Rev. 5, 05/2020, chapter "45.11.3.1.2 Hardware DQS Calibration
with pre-defined value" states:

"
35. Set (MPDGHWSTn[HW_DG_UPn][10:7] - 1) to MPDGCTRLn[DG_HC_DELn].
    (We set the DQS gating value to be the upper limit value minus
     1 half cycle)
"

The i.MX 6Dual/6Quad Applications Processor Reference Manual, Rev. 6,
05/2020, chapter 44.11.3.1.2 Hardware DQS Calibration with pre-defined
value lists the same information. So do the following manuals:

- i.MX 6DualPlus/6QuadPlus Applications Processor Reference Manual, Rev. 3, 05/2020
  chapter 46.11.3.1.2 Hardware DQS Calibration with pre-defined value
- i.MX 6SoloX Applications Processor Reference Manual, Rev. 4, 05/2020
  chapter 40.11.3.1.2 Hardware DQS Calibration with pre-defined value
- i.MX 6UltraLite Applications Processor Reference Manual, Rev. 2, 03/2017
  chapter 33.11.3.1.2 Hardware DQS Calibration with pre-defined value
- i.MX 6ULL Applications Processor Reference Manual, Rev. 1, 11/2017
  chapter 35.11.3.1.2 Hardware DQS Calibration with pre-defined value
- i.MX 6ULZ Applications Processor Reference Manual, Rev. 0, 10/2018
  chapter 29.11.3.1.2 Hardware DQS Calibration with pre-defined value

The NXP MMDC DDR Stress Test (3.0.0) tool seems to be have the same
way as the later document rather than the AN4467 application note,
and produces values similar to the values with subtracted 1/2 cycle.

Adjust the behavior to match the more recent Reference Manual and
the MMDC calibration tool.

Winbond W634GU6RB does show sporadic signs of instability without
this correction.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Adam Ford <aford173@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-imx/mx6/ddr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/ddr.c b/arch/arm/mach-imx/mx6/ddr.c
index 5a1258e002d..2447698cfe4 100644
--- a/arch/arm/mach-imx/mx6/ddr.c
+++ b/arch/arm/mach-imx/mx6/ddr.c
@@ -71,13 +71,13 @@ static void modify_dg_result(u32 *reg_st0, u32 *reg_st1, u32 *reg_ctrl)
 	val_ctrl = readl(reg_ctrl);
 	val_ctrl &= 0xf0000000;
 
-	dg_tmp_val = ((readl(reg_st0) & 0x07ff0000) >> 16) - 0xc0;
+	dg_tmp_val = ((readl(reg_st0) & 0x07ff0000) >> 16) - 0x80;
 	dg_dl_abs_offset = dg_tmp_val & 0x7f;
 	dg_hc_del = (dg_tmp_val & 0x780) << 1;
 
 	val_ctrl |= dg_dl_abs_offset + dg_hc_del;
 
-	dg_tmp_val = ((readl(reg_st1) & 0x07ff0000) >> 16) - 0xc0;
+	dg_tmp_val = ((readl(reg_st1) & 0x07ff0000) >> 16) - 0x80;
 	dg_dl_abs_offset = dg_tmp_val & 0x7f;
 	dg_hc_del = (dg_tmp_val & 0x780) << 1;
 
-- 
2.53.0

