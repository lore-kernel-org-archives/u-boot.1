Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC58D116E2
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 07:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC906839F1;
	Mon,  1 Dec 2025 08:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="E3M4JyEk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D09CE83A2B; Mon,  1 Dec 2025 08:32:54 +0100 (CET)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F1DE839B7
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 08:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20251201073250cee9cf8493000207ce for <u-boot@lists.denx.de>;
 Mon, 01 Dec 2025 08:32:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KzDNwFun/+Kqmfodd24n616rn4M2ZMNlJfGWsH4XC2A=;
 b=E3M4JyEkbysZyTmnhqYqg8PZRwFVNmYgZ02kYL+k9d9DdCnW7hAH6o9TFeUXJ3xpfCIcOx
 mERffz9B50/XS1wwVKqhrqefPaLO0ovTlgOE3Ld9Z+Ie2ghCVP0jvUh4uoQkDSmQvtzMfEdC
 in4u+kyQd50j1f1OSpVUpuJt6Vrnj6SZHNcWwl1bk7Ax0QSi2aMx6bZNm3SVAHFj0r8x7wBF
 N3xByHZRSwrS05oyWQS9EJYDpf7P5ulrjf3/h8Tep41Rhi1RNeYQBWD3tmV9ECzKin5Wp9J6
 ZMwzTD4JQCwP/+Drc9s80ReCEERei0L55IRT3PvzTY4E2IFlAkzdY25Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Sune Brian <briansune@gmail.com>
Subject: [PATCH v2 3/5] spl: mmc: Respect sector value passed to
 mmc_load_image_raw_partition
Date: Mon,  1 Dec 2025 08:32:47 +0100
Message-ID: <ada2fc90d01cb54e178853b766896f0f69b26451.1764574369.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764574369.git.jan.kiszka@siemens.com>
References: <cover.1764574369.git.jan.kiszka@siemens.com>
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
index 1942e417075..47cfe4aef58 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -137,11 +137,7 @@ static int mmc_load_image_raw_partition(struct spl_image_info *spl_image,
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

