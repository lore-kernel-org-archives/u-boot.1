Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27C8C3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 08:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF01C88254;
	Fri, 28 Jun 2024 10:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ft490PG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F5D8825E; Fri, 28 Jun 2024 10:23:44 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1184087F13
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S8Ne4N019080;
 Fri, 28 Jun 2024 03:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719563020;
 bh=ZJHipp+zDFjfxcMHmqY6OY87djnOyi4pHIsBU9a/mSs=;
 h=From:Subject:Date:To:CC;
 b=ft490PG92flDyvGmm1ZlPhNK7Jv5alFEVNAQ4z0vta4PeMncNviFg0cwbXqNdPe1K
 Q68XBbnifTYG3jP8vMUxdbelychKfugjhMHrVNVU91Qq3guTQmQteN7hEfuFg1yX9F
 n8E/gtdHD+39mxRwRn6z/BtRiPUrt+EyhKZ3YGro=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S8Neb1021832
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 03:23:40 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 03:23:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 03:23:39 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S8NZY1119300;
 Fri, 28 Jun 2024 03:23:36 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 0/3] Fix findfdt for j722s and am62p
Date: Fri, 28 Jun 2024 13:53:27 +0530
Message-ID: <20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP9yfmYC/yWNywqEMAwAf0VyNlBrfeCviIeqqQa0llSXBfHfL
 bunYS4zN0QSpghddoPQhyMfPkmRZzCt1i+EPCcHrbRRtW5xNHiFeArZHf/Y2BOGzZ7ukB2dmht
 TlXXZjBpSJQg5/v4O/fA8L7ppvotxAAAA
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719563016; l=815;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=9/YLsP+yuRyi7+P0bvBHe0yHE5d0O138bKHZ/La3ClQ=;
 b=U+cmQV+j5Gp4KD7sJ6YALqUOXgEr6DCJThPx0FKx3pMs1TqP73f+rPOlkXJ5mXlurikZKNdF7
 TM29pnF/YnPDVMRg4BdKBnXnqxbWpINmyc+bNHhMuvSA+CEELWmLtxB
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

findfdt wasn't being populated in these boards, add the code in evm.c
for the same.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (3):
      include: env: ti: mmc: Change name_fdt usage to fdtfile
      board: ti: am62p|j722s: Add ti_set_fdt_env for findfdt
      configs: am62p|j722s_a53: Add CONFIG_BOARD_LATE_INIT

 board/ti/am62px/evm.c            | 9 +++++++++
 board/ti/j722s/evm.c             | 9 +++++++++
 configs/am62px_evm_a53_defconfig | 1 +
 configs/j722s_evm_a53_defconfig  | 1 +
 include/env/ti/mmc.env           | 2 +-
 5 files changed, 21 insertions(+), 1 deletion(-)
---
base-commit: 899b088674b6905710ce546f0a8848662904852a
change-id: 20240628-b4-upstream-streamline-platform-f0d7453637b2

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

