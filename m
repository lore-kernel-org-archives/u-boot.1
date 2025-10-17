Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BB3CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 15:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8698393E;
	Fri, 17 Oct 2025 17:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="HlIQwFvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A2883826; Fri, 17 Oct 2025 17:26:57 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5064B83881
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 17:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1E86426292;
 Fri, 17 Oct 2025 17:26:55 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VOhOh5CMInZv; Fri, 17 Oct 2025 17:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760714813; bh=A+ye70vpjvTCZrQl0qo71J0WFOy9OTsKPWbQO6qOM5k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HlIQwFvSYn0GnMTp5tKcddkwLwcc5F5nCZlTSy++Tex3BaP08knFkYLzDe8Ttd+RX
 rXCILrVGhpng/gvtQn6deZm52S0pn9swzMUYxkY1eKSrAxLaxesmBBDXPlM33NpR7Z
 jqYoSv1uvZcJX1vOFCpfcSazBowl8WCn3evlyhH3LTsopY3wL9+VjuWqZ3OpPtvEjs
 JOPeqMislj22eqktWa3b4InOG3N3JWTCR39EKUlR2g1Xj7zp4cnl6unY4VC9w39Ggs
 c+OywLKb7qibMVuG/WMJR8dm/uJHhhvaNxmSRxblycy0MmtBr90DU/x2IQbDuTOwqk
 wWCG35k9ELatw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 20:54:14 +0530
Subject: [PATCH 9/9] mmc: exynos_dw_mmc: add compatible for
 exynos7870-dw-mshc-smu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-mmc-dw-exynos7870-v1-9-a2c5139d9afe@disroot.org>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Henrik Grimler <henrik@grimler.se>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760714654; l=1217;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=A+ye70vpjvTCZrQl0qo71J0WFOy9OTsKPWbQO6qOM5k=;
 b=XrkaytewWUqlzMGgoTjWvEyv9Fim8aGG1K8VGTt5erVuI+YRHrNzgJwJFiTfgUVGLZ5otaTeu
 FxVan4FbK3jAwj9shROJaXNH4GcJweRRdgA1fzlcrYyVRgMyTHM2qQ/
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 17:43:57 +0200
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

Exynos7870 is documented in upstream dt-schema. Add it in the U-Boot
driver.

Note that here it seems that Exynos7 DW MMC is perfectly compatible with
Exynos7870 DW MMC. It's not always true, especially in SDIO cards where
data from a 64-bit FIFO is read in two 32-bit halves [1]. Since SDIO
isn't used or implemented here, it's oblivious. But upstream's schema
considers that quirk, so that compatible is followed.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=7cbe799ac10f [1]
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mmc/exynos_dw_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index d436d33f53b36aadab3621a14e37ced71b23d96e..12d7411a72ef5cb80689bcb0ae1398f375ec9a5f 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -468,6 +468,9 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
 	}, {
 		.compatible	= "samsung,exynos7-dw-mshc-smu",
 		.data		= (ulong)&exynos7_smu_drv_data,
+	}, {
+		.compatible	= "samsung,exynos7870-dw-mshc-smu",
+		.data		= (ulong)&exynos7_smu_drv_data,
 	},
 	{ }
 };

-- 
2.51.0

