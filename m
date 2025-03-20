Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474BDC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 06:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D0E809D4;
	Thu, 20 Mar 2025 07:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h1BMGMCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A97518141E; Thu, 20 Mar 2025 07:30:18 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CAC8083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52K6U9LZ535593
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 20 Mar 2025 01:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742452209;
 bh=4DaytkhbtcqbHKLMcoU1gVFjXtJ0L2aZB1RDBqA1PyI=;
 h=From:To:CC:Subject:Date;
 b=h1BMGMCQuuYQ1NKH3fS7dePkkVZDNIUUMnLRhCjm3MWRF/0rye+zRdUBRLL6WUBzU
 Pi67gWuYc7TQV65TflhoFVjfnASz7gIaqWh7EqzCvuyg27MzuOL0hh7kQw6i2Jq6gX
 4nTIWjet9/bFlJidT6/XpEUS5/XLh65mlQgjiQNo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52K6U9Mc013831
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 20 Mar 2025 01:30:09 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Mar 2025 01:30:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Mar 2025 01:30:08 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52K6U5Xt055186;
 Thu, 20 Mar 2025 01:30:05 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>
CC: <n-francis@ti.com>, <s-vadapalli@ti.com>, <vaishnav.a@ti.com>,
 <a-limaye@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
Subject: [PATCH 0/3] Enable MUX_MMIO at SPL stage 
Date: Thu, 20 Mar 2025 12:00:01 +0530
Message-ID: <20250320063004.1069653-1-a-dutta@ti.com>
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

This series enables MUX_MMIO at SPL stage for j7200 and j721e 
as it is required for successful hyperflash boot.

Test logs :
https://gist.github.com/anuragdutta731/b4c79ef8da56d8c50b38d953c9da4d45

Anurag Dutta (3):
  mux: Kconfig: Add Kconfig options for MUX_MMIO
  configs: j7200_evm_a72_defconfig: Enable MUX_MMIO at SPL
  configs: j721e_evm_a72_defconfig: Enable MUX_MMIO at SPL

 configs/j7200_evm_a72_defconfig |  1 +
 configs/j721e_evm_a72_defconfig |  1 +
 drivers/mux/Kconfig             | 10 ++++++++++
 3 files changed, 12 insertions(+)

-- 
2.34.1

