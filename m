Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAB9C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 11:16:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF2D80885;
	Wed, 29 Jan 2025 12:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1738149408;
	bh=XIGG95rZ6secAEdf8RIE0nUhfpKlj+L6OQTDPv7UCEc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RZ4vex5ri2zVc5ee//+1R5qrpDJh1fubr84YQRKJXbnEbKj1wd1c8FShffW3hpOTo
	 aSEYY3rq3u93n8JiMC5skUtP+Xqz1Um2+4PbiFhvnQ/BGdI/rAnaQv0TEsBHvWhQEA
	 NOlsSp1nWFTLgf2p78U6aOad3msWt/X66pi7DJjqZ6LjNaAS/cMqNUu4nJEZawqixq
	 7Ff8yBNEnJtxlKo2c6ateRkglE4a7Uvloamkhq6QAGDXKduokANtSMrtaj4P+O2anT
	 m++X54L+pMCfa9T6lsRq5RqIIIqY6cZXjc3vTUTVVC8IUDBnfevOvE1/jtx+ZFXkAl
	 Qr1os/988CCeQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B07C80EEF; Wed, 29 Jan 2025 12:16:47 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 275C880815
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 12:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="THPcQV1s"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A580C10382D08; Wed, 29 Jan 2025 12:16:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1738149403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XIGG95rZ6secAEdf8RIE0nUhfpKlj+L6OQTDPv7UCEc=;
 b=THPcQV1sEInOe1ZVCb5alM8OdLOYgiO723wS73dXsRMIsJ4ptbjLk2jOoCkJYXwa5YKGtb
 jIsGqZIg6ILXKoNX+Z3wVmK7b3YSJh+zY6VIOwsl1lMVZ24x5zca6y/5Cs4td2HW5wRLav
 Dra12wmRwYTGahBLxaQiEOW8dzffY7bozLnLo/jvPmhNsHrF7wWz52n+JT/1jdCpaxQnTX
 nc7quplQaPa3/oV0EhLxIYyhYTdFBb5M2WpdwR80NeO1rQrrpgeptEnsfCaIcCewRElHLr
 b26pH6APVsAJBs1YFTAvyCg97hL/uavS47KHmUdmIHJOMHNGZ6O4BIcgEH8E6A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ronald Wahl <ronald.wahl@legrand.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 u-boot@dh-electronics.com
Subject: [PATCH] mmc: Fix size calculation for sector addressed MMC version 4
Date: Wed, 29 Jan 2025 12:15:54 +0100
Message-ID: <20250129111613.11106-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

For eMMC v4 and newer that is smaller than 2 GiB, the JEDEC JESD84-B51
section 6.2.4 Configure partitions indicates that EXT_CSD SEC_COUNT
should not be used to determine device size, and instead device size
should be calculated from C_SIZE and C_SIZE_MULT.

This is not exactly accurate, the 2 GiB limit is not a hard line,
there are eMMC devices which are smaller than 2 GiB and still
require device size to be determined from EXT_CSD SEC_COUNT. The
hard line is instead OCR HCS bit, which indicates whether the device
is byte or sector addressed, the former applies to most devices
below 2 GiB, and the later applies mostly to devices above 2 GiB.

However, there are a couple of devices which are smaller than 2 GiB
and still set the OCR HCS bit to indicate they are sector addressed,
and therefore the size calculation for those devices should also
use EXT_CSD SEC_COUNT . Use mmc->high_capacity flag to discern the
devices instead of arbitrary 2 GiB limit. The mmc->high_capacity flag
reflects the OCR HCS bit state.

Fixes: 639b7827d1ca ("mmc: fix the condition for MMC version 4")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ronald Wahl <ronald.wahl@legrand.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 drivers/mmc/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 799586891af..31a72366206 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2376,7 +2376,7 @@ static int mmc_startup_v4(struct mmc *mmc)
 				| ext_csd[EXT_CSD_SEC_CNT + 2] << 16
 				| ext_csd[EXT_CSD_SEC_CNT + 3] << 24;
 		capacity *= MMC_MAX_BLOCK_LEN;
-		if ((capacity >> 20) > 2 * 1024)
+		if (mmc->high_capacity)
 			mmc->capacity_user = capacity;
 	}
 
-- 
2.45.2

