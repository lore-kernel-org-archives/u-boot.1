Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94261CA0FF0
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6DDE83966;
	Mon,  1 Sep 2025 08:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XzqCykJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA39D83965; Mon,  1 Sep 2025 08:17:07 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27E16833AD
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5816H3Ax2745378;
 Mon, 1 Sep 2025 01:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756707423;
 bh=gfKuTzByVCTGG0ISZpq6as5/bgAaHyol/liOGxD9KIA=;
 h=From:To:CC:Subject:Date;
 b=XzqCykJuvU+NURYjSEBhkpY4bhy3n3PUE0GZnsCuhCJz9GXx6GEhE0Is7U9Klue50
 JAO7OqbK0PwFIwEyguznEok5rjzkgKlpKqGU+UU+cjrJIJI+8y/Iwr1rjNYEKTbJgg
 Fsuviz+PQw09InBeMiRvDdRdJs5yBEo4LZEItuxc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5816H3F11904062
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 1 Sep 2025 01:17:03 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 01:17:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 01:17:02 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5816H0GR1998362;
 Mon, 1 Sep 2025 01:17:00 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <u-boot@lists.denx.de>, <a-dutta@ti.com>
Subject: [PATCH v2 0/4] AM57 boot fixes
Date: Mon, 1 Sep 2025 11:46:55 +0530
Message-ID: <20250901061659.986164-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
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

Hi all
This patch series migrates from .h to .env format for am57xx/dra7xx.
Also, we do relevant changes so that the fdtfile can be set from C code.

logs : https://gist.github.com/anuragdutta731/82560cc9bc958ca70a25a95a7031eeea

Changelog: v1:
1. Converted to plain text environment for am57 and dra7
2. Added dra7 support as well

Link to v1:
https://lore.kernel.org/all/20250425053431.1622267-1-a-dutta@ti.com/

Anurag Dutta (4):
  include: env: ti: Use .env for environment variables
  board: ti: am57xx: Change to using .env
  board: ti: am57xx: Set fdtfile from C code instead of findfdt script
  board: ti: dra7xx: Set fdtfile from C code instead of findfdt script

 board/ti/am57xx/Kconfig           |  12 ++
 board/ti/am57xx/am57xx.env        | 162 +++++++++++++++++++++
 board/ti/am57xx/board.c           |  14 ++
 board/ti/dra7xx/evm.c             |  11 ++
 include/configs/am57xx_evm.h      |  19 +--
 include/configs/dra7xx_evm.h      |  24 ----
 include/configs/ti_omap5_common.h | 228 ------------------------------
 include/env/ti/dfu.env            |  53 +++++++
 8 files changed, 253 insertions(+), 270 deletions(-)
 create mode 100644 board/ti/am57xx/am57xx.env
 create mode 100644 include/env/ti/dfu.env

-- 
2.34.1

