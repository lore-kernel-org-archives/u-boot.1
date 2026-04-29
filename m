Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BE7FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6752847C6;
	Wed, 29 Apr 2026 14:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="AfTB4Mbk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C15847C7; Wed, 29 Apr 2026 14:13:36 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37682847B0
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 14:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 74292112780; Wed, 29 Apr 2026 14:13:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777464809; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=aY0Y8iNl/knmPE3pSPdTSzkWG4UjAFJrHwSYSCwnln4=;
 b=AfTB4MbkoXhY+mqpVlnpjxRKkTYKHynqBwUwC1yVf1tHL0vKjooNUNRmu0TpAnoWHF13m3
 JN/fjD1qocu3g0ZnQNtAXEih2VM0Vo9K3IfQN26Y+COcT7vN+qKov91K5bw6w65n9S64Kf
 xLJgBUL2pjs1riQV5MeVGqtlQMAfVOImD6kXyixs1xW1DJI2KeDQxlTrw+lWLsV033kX2P
 2YZKhsv4jhfVNMtYOOmhdElQtJWu4xILKsCeMDywX2NUHRfF3BtIyc9A2h4QZfi/WgWAPs
 ya6lcOWY/Z4BUSU9Yb39pQsOQA3K2GgUhfpFmURgRwJiUlyaOdOe9wNugLnAIg==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jasper Orschulko <jasper@fancydomain.eu>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michael Heimpold <mhei@heimpold.de>, Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] env: mmc: Use correct eMMC HW partition size when calculating
 end of HW partition
Date: Wed, 29 Apr 2026 14:13:06 +0200
Message-ID: <20260429121324.391457-1-marex@nabladev.com>
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

When calculating the end of eMMC HW partition, it is necessary to
use the length of that eMMC HW partition, not the length of the
eMMC HW USER partition unconditionally, otherwise the end of e.g.
eMMC HW BOOT partition will be way past the actual end of that eMMC
HW BOOT partition. Add the missing distinction. eMMC HW GP partitions
are not supported, so those are not considered here.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jasper Orschulko <jasper@fancydomain.eu>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Michael Heimpold <mhei@heimpold.de>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 env/mmc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/env/mmc.c b/env/mmc.c
index 1eddba3b0f8..4c1448bd05e 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -239,8 +239,12 @@ __weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
 		return -ENOENT;
 	}
 
-	if (offset < 0)
-		offset += mmc->capacity;
+	if (offset < 0) {
+		if (CONFIG_ENV_MMC_EMMC_HW_PARTITION)
+			offset += mmc->capacity_boot;
+		else
+			offset += mmc->capacity;
+	}
 
 	*env_addr = offset;
 
-- 
2.53.0

