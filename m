Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E6DC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 23:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFE083FF7;
	Tue,  5 Aug 2025 01:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yWI72VeL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E342C8406A; Tue,  5 Aug 2025 01:37:25 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9301E83FF7
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 01:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 574NbJMD3911149;
 Mon, 4 Aug 2025 18:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754350639;
 bh=OgidHO4+9pMDQMSo/vI2qaETAH9SGXOHDzd5+cfnkT4=;
 h=From:To:CC:Subject:Date;
 b=yWI72VeLqip9bz7csuw84hWCitcT64ETuPYR6smpLF+1VqSITuLvcZIJPojQ1B4Ks
 hW4cyI824t3Ts5Zlq7RjuK3LKuJPEQLFdBFg4n3/LGO8h9381wwCHMPUy/ssHYvxGQ
 suDLu7cQk1VSAhHkWpxlFhJQKsR9UVVHdS77DE7M=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 574NbJc81859504
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 4 Aug 2025 18:37:19 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 4
 Aug 2025 18:37:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 4 Aug 2025 18:37:18 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 574NbIRI898934;
 Mon, 4 Aug 2025 18:37:18 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/2] Add support for AM62P SR1.2
Date: Mon, 4 Aug 2025 18:37:16 -0500
Message-ID: <20250804233718.1471877-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

This patch series adds support for the AM62P SR1.2 silicon revision by
adding support in soc_ti_k3 to detect AM62P variants.

Also disable HS400 support for AM62P SR1.0 and SR1.1 in sdhci host driver.
For AM62P SR1.2, eMMC HS400 should be enabled by default.

Logs:
sd boot: https://gist.github.com/jmenti/5eb1068f563c9248e907b5eed2a957a0

Judith Mendez (2):
  soc: soc_ti_k3: Add support for AM62P variants
  mmc: am654_sdhci: Disable HS400 for AM62P SR1.0 and SR1.1

 drivers/mmc/am654_sdhci.c | 12 +++++++
 drivers/soc/soc_ti_k3.c   | 66 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 73 insertions(+), 5 deletions(-)

-- 
2.49.0

