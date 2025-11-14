Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94B1CE8D5F
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CA5842CE;
	Fri, 14 Nov 2025 18:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="cUAMvMRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46468425C; Fri, 14 Nov 2025 18:13:46 +0100 (CET)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349BE840B3
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 18:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202511141713420fcd56141d0002073f for <u-boot@lists.denx.de>;
 Fri, 14 Nov 2025 18:13:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aFB7V5GNRlc8d57SQWNSclaiP9wvQYah/pci8JsH0MA=;
 b=cUAMvMRnH4VNF0o7F28wM7YAceG8fUF6Pqj+tTEsFWmUXshNaUtXGZw6gnkuW3yRs6Ttm1
 0D12h49rbMN1hBSqndbbQSlw5VKB3WRl/5c7nKfPlfo6kv5u2uWXLPvSllMQoko/DzC0+T64
 YZKoIQv7NTA8UxoR1rInNbGZ8vwtzl1Pox41qfdpa0r+/nEzY8ROO5PlAERod1EF2hDg3dsb
 CxVKbxqemLm7CuYQ8GQMIvyZ8qd3b+kbMijJlDh57cRF8FiifaVgqKeyxMPVSWnBehOefv43
 c666T40a4X0HHScLWVohs8TNVN1sK9jNCF/DnLRXPInJRVOtuf+A+/WA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/4] spl: mmc: Respect sector value passed to
 mmc_load_image_raw_partition
Date: Fri, 14 Nov 2025 18:13:38 +0100
Message-ID: <28ff4f1c094e15ef1f301bcbf409ef628c9cca91.1763140421.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1763140421.git.jan.kiszka@siemens.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This function and the sector parameter evolved over the time. By now,
sector is influenced by spl_mmc_get_uboot_raw_sector which allows to
adjust the read sector with an offset that U-Boot proper may have inside
the partition. That used to work by chance if both
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR and
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION were enabled. Since
2a00d73d081a they are a choice, and we need to drop the condition to
maintain this feature.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 common/spl/spl_mmc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index d8ce3a84614..467114f8d9a 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -136,11 +136,7 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
 		return ret;
 	}
 
-#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start + sector);
-#else
-	return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.start);
-#endif
 }
 #endif
 
-- 
2.51.0

