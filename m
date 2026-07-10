Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D95C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 22:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61F94841F2;
	Sat, 11 Jul 2026 00:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="VvRbUc5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E8F849BA; Sat, 11 Jul 2026 00:40:25 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF6F38407E
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 00:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 84F7E11955F; Sat, 11 Jul 2026 00:40:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1783723221; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=rhJJTQSwwhCUy4hQ1UIgfOmNV162W0iviRHutkVsckQ=;
 b=VvRbUc5j2kQ6iyCq63WE2bmGa6xev0DLXJIZhkQ+r4ceWvfJ044lNJ4DCftLfyJBenXYSN
 rIq/ZZ227DQaqIKjNCDIS7JpGSA+E1uD/Qrp5vkiiA021LmObXu7XtbGrDFsBC0VD61US2
 XO3c2rVspDuE/ML0gX+3VJhyF0//boRIDV0ZJdF6q3cbsIWP/hkaVCf/WF/eu4VfPC76CB
 JPQ2xFUKtaEuXbZDAZgqJern/SfZJfynC6Dc7x+6PLpYjIXjqcpRNzqEaOMSOmPayRn65X
 RfeUE0UF6C8b/3tTeQ3QwqFlTkVMedZ/sdulwZwGEOWDApVYnB6ostwX2awjFA==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: imx: Handle both MMC2 and SD2 boot devices on Data
 Modul i.MX8M Mini eDM SBC
Date: Sat, 11 Jul 2026 00:39:50 +0200
Message-ID: <20260710224018.566152-1-marex@nabladev.com>
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

Handle both MMC2 and SD2 boot devices as SDMMC device 1 on
Data Modul i.MX8M Mini eDM SBC. In case the system boots from
a microSD card, the BootROM reports boot device as SD2_BOOT
instead of MMC2_BOOT. Continue booting from that SDMMC device
instead of falling back to SDP. Note that SDMMC device 1 is
the microSD slot on this device, SDMMC device 2 is the eMMC,
but BootROM reports the numbers the other way around, hence
the potential confusion in this commit message.

Fixes: 0b97a394f6b7 ("ARM: imx: Replace YModem with SDP on Data Modul i.MX8M Mini eDM SBC SPL")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/data_modul/imx8mm_edm_sbc/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/data_modul/imx8mm_edm_sbc/spl.c b/board/data_modul/imx8mm_edm_sbc/spl.c
index c6a5740c7a7..6071fb405a7 100644
--- a/board/data_modul/imx8mm_edm_sbc/spl.c
+++ b/board/data_modul/imx8mm_edm_sbc/spl.c
@@ -59,7 +59,7 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	if (boot_dev_spl == MMC3_BOOT)
 		return BOOT_DEVICE_MMC2;	/* eMMC */
-	else if (boot_dev_spl == MMC2_BOOT)
+	else if (boot_dev_spl == MMC2_BOOT || boot_dev_spl == SD2_BOOT)
 		return BOOT_DEVICE_MMC1;	/* SD */
 	else
 		return BOOT_DEVICE_BOARD;
-- 
2.53.0

