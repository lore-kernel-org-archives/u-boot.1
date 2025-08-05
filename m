Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDD7C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 16:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E689684148;
	Tue,  5 Aug 2025 18:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WKAkiFJa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED03F8388B; Tue,  5 Aug 2025 18:14:24 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9306083890
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 18:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575GEK1f321592;
 Tue, 5 Aug 2025 11:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754410460;
 bh=Emsr1J8UCAcJ2BmosGX7BAiAXZKhb46lilb5a79Fd+c=;
 h=From:To:CC:Subject:Date;
 b=WKAkiFJaGLHdyWgguorcsnfxEAxEkFGLdsgx6gfNC+Bbssqf4lzwfWtygBYujYOVA
 ulgZLdtTYqwj6zc3PDLkmQZwFw7Bo/tYd69VSkaaa9aCNlqWZ8mMOJQtNUqYch0gD/
 jvswb7BpwZLJXoo8Eki9jkeIATDV9dgOBq7Z7eMY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575GEJiL3699519
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 5 Aug 2025 11:14:19 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 11:14:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 11:14:19 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575GEJqs2408213;
 Tue, 5 Aug 2025 11:14:19 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2 0/2] Add support for AM62P SR1.2
Date: Tue, 5 Aug 2025 11:14:17 -0500
Message-ID: <20250805161419.1781935-1-jm@ti.com>
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

Changes since v1:
- Add Peng's review tag
- Wrap functions in soc_ti_k3 with IS_ENABLED()

Link to v1:
https://lore.kernel.org/u-boot/20250804233718.1471877-1-jm@ti.com/T/#mb3f48d82a7a0be2b2ebe4ab800c5aa6e80b15dc3

Judith Mendez (2):
  soc: soc_ti_k3: Add support for AM62P variants
  mmc: am654_sdhci: Disable HS400 for AM62P SR1.0 and SR1.1

 drivers/mmc/am654_sdhci.c | 12 +++++++
 drivers/soc/soc_ti_k3.c   | 70 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 77 insertions(+), 5 deletions(-)

-- 
2.49.0

