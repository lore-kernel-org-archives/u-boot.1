Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18734CD5BD0
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 11:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A7C846BD;
	Tue, 26 May 2026 13:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="tWtwkYhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BE49844CF; Tue, 26 May 2026 13:41:08 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 861EB844CF
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 13:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1779795664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DaI0WKrs+dWckpszJ/e8jrPAecCwsmOv27wV4Or9SxI=;
 b=tWtwkYhchAYxWAhLdU4o7Ba+1hR1WoRmTnSy0KU4ctBaMXIFWfCFnCG+b1hXqr8s2Z9va1
 yoyavzGC/jVexDVNHlZE63DALWX41qXZA90s5xkBFhv3bzEx0s88ToDSe8gVnWKmHu0wI5
 yjIW0vcNVEXjRbtIwD8XIdWAl64ebeOqEsTba2FkEp+At2n5Ky5uozsIFtZh7OmCr5CeT6
 qe/cyXRz5FPd7dBDENI4SoBYCOFvD8rRTuQD3uK5iv8az2T6MX9LYYakna1vVVvf03lkvA
 RBdu+OjVQQfgsJNUM16LcRaVnLgq8BLaKluKIOKg2LtfDizyestb6PdYHnAV3w==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: uboot-imx@nxp.com, Annette Kobou <annette.kobou@kontron.de>,
 Eberhard Stoll <eberhard.stoll@kontron.de>,
 Oualid Derouiche <oualid.derouiche@kontron.de>
Subject: [PATCH] imx: kontron-sl-mx6ul: Enable CONFIG_DM_MDIO to fix boot abort
Date: Tue, 26 May 2026 13:40:59 +0200
Message-ID: <20260526114100.816424-1-frieder@fris.de>
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The following failure occurs right before switching to the kernel:

data abort
pc : [<9ff60162>]	   lr : [<9ff79d13>]
reloc pc : [<8781c162>]	   lr : [<87835d13>]
sp : 9bf30f78  ip : 9bf4b140	 fp : 007963a0
r10: fffffdfb  r9 : 9bf3bed0	 r8 : 00004600
r7 : 00000000  r6 : 9ffe5a0c	 r5 : 00004600  r4 : 9bf4acf0
r3 : f5f5f5f5  r2 : f5f5f5f5	 r1 : 9ffe0c5c  r0 : 9bf7c130
Flags: NzCv  IRQs off  FIQs off  Mode SVC_32 (T)
Code: 9ffe b158 e9d0 2300 (6053) 601a
Resetting CPU ...

This is due to the fact that the board uses a shared MDIO bus for
both ethernet controllers, but FEC_MXC_SHARE_MDIO is not enabled.

This results in a double free in fecmxc_remove(). To fix this
enable CONFIG_DM_MDIO so the shared MDIO is correctly detected
from the devicetree.

Fixes: 048fdda977ab ("imx: kontron-sl-mx6ul: Enable second ethernet interface")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 configs/kontron-sl-mx6ul_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/kontron-sl-mx6ul_defconfig b/configs/kontron-sl-mx6ul_defconfig
index c6d450419cc..4203c3e8a4b 100644
--- a/configs/kontron-sl-mx6ul_defconfig
+++ b/configs/kontron-sl-mx6ul_defconfig
@@ -96,6 +96,7 @@ CONFIG_SPI_FLASH_MTD=y
 CONFIG_PHYLIB=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
+CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_FEC_MXC=y
 CONFIG_MII=y
-- 
2.54.0

