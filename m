Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B45AC4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 16:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B931874A5;
	Thu,  7 Dec 2023 17:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JieTxUeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A91DF87474; Thu,  7 Dec 2023 17:52:28 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CE38722C
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 17:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B7GqMm1101600;
 Thu, 7 Dec 2023 10:52:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701967942;
 bh=Y5tqMy+XvblHMveTuuyn3u+UbjmmJhX6mBZmrtZz8uI=;
 h=From:To:CC:Subject:Date;
 b=JieTxUeu+7GrQvJfcCXNppLq8VH0fLHUxjNAwGetzzCRHSV1CJ4zYKTYnEmAhcdRo
 f1yZOdt4zgr806vzRKR1L2Bd/nuCV83/BLM2nlbfGRJaYqxPLy8Ykq2xkaTo9nDUn/
 1hNr+pQs0HzC9H0CpRfK758gBSZG2tWhXFL5Hslw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B7GqMVs044082
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Dec 2023 10:52:22 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Dec 2023 10:52:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Dec 2023 10:52:22 -0600
Received: from localhost (reidt-hp-z2.dhcp.ti.com [128.247.81.215])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B7GqLKX030121;
 Thu, 7 Dec 2023 10:52:21 -0600
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <m-chawdhry@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>, <bb@ti.com>, <a-nandan@ti.com>, <vishalm@ti.com>, Reid
 Tonking <reidt@ti.com>
Subject: [PATCH v3 0/2] Fix J7200 kernel boot when using upstream u-boot
Date: Thu, 7 Dec 2023 10:52:09 -0600
Message-ID: <20231207165211.2319475-1-reidt@ti.com>
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

Since the 09.01.00.002 release of ti-linux-firmware [0] upstream uboot
has led to the kernel hanging during boot [1] for the TI J7200 S0C. The
issue was found to be a few patches that had be added to ti-u-boot, but not
yet upstreamed. This series adds the missing two patches to allow upstream
u-boot to boot the kernel properly [2].

[0] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/commit/?h=ti-linux-firmware-next&id=952fd03e36a50ec070e73560dc1060102d637ce0

Boot logs:
[1] https://gist.github.com/reidt1/5f4e85a0db258bcf20d7168bd0caebd0
[2] https://gist.github.com/reidt1/e950dc97f15ad0a09623d64f81edac39

Links to patches on ti-u-boot:
https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04-next&id=d878fbef4d4460e87608d8d2dfe5311499de49c5
https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04-next&id=543e735fe495be233a8a75b19b3d7f8ed44251e0

Changes since v2:
- changed platdata counts in clk-data.c to use array_size instead of
	hardcoded value
Link to v2: https://lore.kernel.org/u-boot/20231206211753.2225158-1-reidt@ti.com/T/#m0a035ac752b812b67c7e83719b5e2b34edab7b26


Reid Tonking (2):
  arm: mach-k3: j72xx: add new 'virtual' mux
  arm: dts: k3-j7200-r5-common-proc-board: Set parent clock for clock ID
    323

 arch/arm/dts/k3-j7200-r5-common-proc-board.dts |  3 ++-
 arch/arm/mach-k3/j7200/clk-data.c              | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.34.1

