Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A29C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 06:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FB2882CBC;
	Wed, 16 Apr 2025 08:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AEiqK/gR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 381B981F45; Wed, 16 Apr 2025 08:17:00 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11C4F81F45
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 08:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G6GtGl239928
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 01:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744784215;
 bh=vmALYXMesCj1kU3fJ2UWy1N35Bv8CzD3UkoY9n/RcCw=;
 h=From:To:CC:Subject:Date;
 b=AEiqK/gRAUzjHPjS3fn0+aNUcB0R//LewrAPOdZCxROPWGwm+2k+KRUH4Z9ToCTwl
 tp/SrslmtDfIDZ78hFUhsYnNsFnD5Ky8Mlq/VNnTICiNUTrAj+7y2c+xode407V7pN
 As08D6W0Fjq7iWFa6R0nsv4CzW233W1NAtVs63AM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G6GtUK087047
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 01:16:55 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 01:16:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 01:16:54 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G6GrRe092299;
 Wed, 16 Apr 2025 01:16:53 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <vaishnav.a@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 0/2] Hyperflash boot fixes for j721e
Date: Wed, 16 Apr 2025 11:46:50 +0530
Message-ID: <20250416061652.2394419-1-a-dutta@ti.com>
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

This series introdues a couple of small fixes that involves
enabling hyperflash at R5 SPL stage and Kconfig changes that are
required for HBMC boot on j721e

Test logs : https://gist.github.com/anuragdutta731/103e84e84f013093fa089803719d997d

Anurag Dutta (2):
  mtd: Kconfig: Add SPL_MUX_MMIO dependency to HBMC driver
  arm: dts: k3-j721e-r5-common-proc-board: Enable HBMC in R5 SPL stage

 arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 1 +
 drivers/mtd/Kconfig                            | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1

