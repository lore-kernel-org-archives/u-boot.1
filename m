Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E51EEB58F
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 04:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5AFE86E1C;
	Wed, 13 Sep 2023 06:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XR9j+O3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF17786E26; Wed, 13 Sep 2023 06:39:47 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3E8786E1A
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38D4ddtB033711;
 Tue, 12 Sep 2023 23:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694579979;
 bh=x9V3g08WV7P734UsuU7UEqB1KLrOGzWSThUtRJXtGYc=;
 h=From:To:CC:Subject:Date;
 b=XR9j+O3PAi/GIFC6vXAsU6GXNylOQw0VeyhN3/OwHSRRdoBL9f3zEMTvWc79uJwbZ
 8b1iwiOSfvY38sCEnswIeBD5hlKNXUB2Znm6Zvo893ePxWbs+JZo5t8pwiTwWpam/t
 NOnAUkFdNgCvJKHtseiSwuskdCVZ+quE8cvfNuto=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38D4ddD7102851
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 23:39:39 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 23:39:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 23:39:39 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38D4dZNZ028334;
 Tue, 12 Sep 2023 23:39:36 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>, 
 <seanga2@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-nandan@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH v3 0/3] enable power and clock Kconfig conditionally
Date: Wed, 13 Sep 2023 10:09:27 +0530
Message-ID: <20230913043930.1316130-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

This series, updates enabling mutually exclusive power and clock configs
for TI SOCs.


Sorry to push clock and power changes in one series,
managed by two maintainers. But In my quick grep,
I am not able to active PR raise from both trees.
So copying maintainers of clock and power for review.

Change log
Changes in v3:
- Patch 1 and 2: Added reviewed by
- Patch 3: Corrected Fixes in commit message
link to v2:
https://lore.kernel.org/all/20230912130645.1202325-1-u-kumar1@ti.com/

Changes in v2:
- Patch 1 and 2) Added conditional support to enable Kconfig
- Patch 3 No change
link to v1:
https://lore.kernel.org/all/20230911111946.749270-1-u-kumar1@ti.com/

Udit Kumar (3):
  power: domain: ti: Enable single config for power domain
  clk: ti: Add support to enable configs conditionally
  config: j7200: remove not needed power config

 configs/j7200_evm_r5_defconfig | 1 -
 drivers/clk/ti/Kconfig         | 8 ++++----
 drivers/power/domain/Kconfig   | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.34.1

