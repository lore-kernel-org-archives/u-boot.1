Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610AACD98E2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 09:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5DF784874;
	Thu, 18 Jun 2026 11:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="nWTwq7a2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D97848EB; Thu, 18 Jun 2026 11:29:15 +0200 (CEST)
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A767C847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 11:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=geanix.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sean@geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1781774951; x=1782034151;
 bh=6NANZRQunwNRp6/lgPXqgqmJ4xb07SUooP54XuRJ5H4=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=nWTwq7a2VHZihh7ageIIJiVoBscwssymErlYdGCYPdAqsmU1CQyk4boJQ1gTV4yDv
 La+UG6+VYi0IyiwYtkR0IIgL/xo7j4P5OvesNwWkfoTZ3cSaOtUFL2NZn05fsA758E
 ento5da652EICdjvW/0CDi55bzJ3ZFI9hpTcqC18vXO7nVfJfBYrmPhPIsC6shml0u
 lRWav4ARD7gAlqKuRWDTHPfhCS5hykhjltO139jnnzP9dLHSoOCOCtnYpVqlR+4cO2
 vozKfk7OR/cxx4wRu+5YvtHqAQAo5KfjMLsG5QIOkdzIH4WF0/Rgj0lDfEaLf2hYQH
 jbYjNcr7/OpBA==
X-Pm-Submission-Id: 4ggwQt1YNTz1DFT1
From: Sean Nyekjaer <sean@geanix.com>
To: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Sean Nyekjaer <sean@geanix.com>, uboot-stm32@st-md-mailman.stormreply.com,
 u-boot@lists.denx.de
Subject: [PATCH] stm32mp1: spl: support loading U-Boot proper from eMMC
 hardware partitions
Date: Thu, 18 Jun 2026 11:28:48 +0200
Message-ID: <20260618092855.3702905-1-sean@geanix.com>
X-Mailer: git-send-email 2.52.0
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

When CONFIG_SUPPORT_EMMC_BOOT is enabled, make spl_mmc_boot_mode()
return MMCSD_MODE_EMMCBOOT instead of MMCSD_MODE_RAW.

This allows the SPL MMC loader to honor the standard configuration
options CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION and
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR when locating U-Boot proper,
whether it is stored in a GPT partition or in an eMMC hardware boot
partition.

As a result, both U-Boot SPL and U-Boot proper can be placed in the
eMMC hardware boot partitions.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 arch/arm/mach-stm32mp/stm32mp1/spl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/spl.c b/arch/arm/mach-stm32mp/stm32mp1/spl.c
index d2e41b8e65f..d2af705a5d1 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/spl.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/spl.c
@@ -56,11 +56,6 @@ u32 spl_boot_device(void)
 	return BOOT_DEVICE_MMC1;
 }
 
-u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
-{
-	return MMCSD_MODE_RAW;
-}
-
 #ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
 int spl_mmc_boot_partition(const u32 boot_device)
 {
-- 
2.52.0

