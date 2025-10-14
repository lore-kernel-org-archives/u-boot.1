Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77509CCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 11:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B964E80422;
	Tue, 14 Oct 2025 13:41:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timmermann.space
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E214F807C0; Tue, 14 Oct 2025 13:41:28 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB9B802C1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 13:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=timmermann.space
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uboot@timmermann.space
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cmC3S6K1dz9tQ2;
 Tue, 14 Oct 2025 13:41:24 +0200 (CEST)
From: Lukas Timmermann <uboot@timmermann.space>
To: u-boot@lists.denx.de
Cc: Lukas Timmermann <uboot@timmermann.space>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: exynos_dw_mmc: Add compatible string for Exynos5250
Date: Tue, 14 Oct 2025 13:40:32 +0200
Message-ID: <20251014114057.67215-1-uboot@timmermann.space>
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

This driver got successfully tested with an upstream device tree
and an Exynos5250. The board in question is samsung-manta
(Google Nexus 10) which we are getting ready for upstream.
For the u-boot port was just this additional compatible string needed.

Signed-off-by: Lukas Timmermann <uboot@timmermann.space>
---

 drivers/mmc/exynos_dw_mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 12e37cb4b78..0597cd7f0c7 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -378,6 +378,9 @@ static const struct udevice_id exynos_dwmmc_ids[] = {
 	}, {
 		.compatible	= "samsung,exynos5420-dw-mshc",
 		.data		= (ulong)&exynos5_drv_data,
+	}, {
+		.compatible	= "samsung,exynos5250-dw-mshc",
+		.data		= (ulong)&exynos5_drv_data,
 	}, {
 		.compatible	= "samsung,exynos-dwmmc",
 		.data		= (ulong)&exynos5_drv_data,
-- 
2.51.0

base-commit: 38e01c41a696302c38a8bd64d94d142155e42081
branch: lat3st/samsung-manta
