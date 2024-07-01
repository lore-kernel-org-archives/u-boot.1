Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA25C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 05:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5CDE884B0;
	Mon,  1 Jul 2024 07:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BLgGCGO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9333788651; Mon,  1 Jul 2024 07:18:59 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD2488444
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 07:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4615It5D120131;
 Mon, 1 Jul 2024 00:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719811135;
 bh=VGGHo/1wRSpww0jlyiyGhR3d4OhaxtIlu20dxIIilrQ=;
 h=From:Subject:Date:To:CC;
 b=BLgGCGO8CO2ymRUzhxnd8Ng0M0+qk42lvH2o6O2B2zU+tZITI+5auGDxzhKraAywO
 DXRJSE4RtxUZOZRcc3QSHEaQPO8XNliz3c8QkFh6CEOEgFoEcGbrLzZLNgHBrVZO2/
 2FBQQwMOVsGmouh3rKF7X+sTIvmUJzCJ4Q1gMSNA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4615ItxF029815
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Jul 2024 00:18:55 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 00:18:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 00:18:55 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4615IpvV059517;
 Mon, 1 Jul 2024 00:18:52 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v2 0/4] Fix fdtfile for j722s and am62p
Date: Mon, 1 Jul 2024 10:48:48 +0530
Message-ID: <20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADg8gmYC/42NTQ6CMBBGr0Jm7Zi2/Ikr72FYFJjKJECbthIN4
 e5WvICrL+9bvLdBIM8U4Jpt4GnlwHZJoE4Z9KNeHoQ8JAYlVCEqdcGuwKcL0ZOe8TcTL4Ru0tF
 YP6MRQ12UeZXXnYJkcZ4Mv47CvU08cojWv4/gKr/v/+5VokBZV2WjTdOoXt4in3s7Q7vv+weIE
 GjcywAAAA==
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719811131; l=1188;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=U+VwP6vbU294tNfCJb3sTaYLjPfp8in+KH9ewNMw5vA=;
 b=v+IMrJieHvSlbSz5H1wqhICTZqQhGoLASoxBeuC5JSX4m8gfMI7VNK774fD2uhEyfjcB+1BON
 aUHraRhcSv7BBmw4IiiNQv5Yh5a7aG87N9HZOBNbE1DY7oCSfXp86ny
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

fdtfile wasn't being populated in these boards, add the code in evm.c
for the same.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v2:
- Replace findfdt with fdtfile as that is what the series fixes. (Nishanth)
- Drop findfdt as well for K3 platforms legacy support
- Link to v1: https://lore.kernel.org/r/20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com

---
Dhruva Gole (1):
      include: env: ti_common: Remove findfdt

Manorit Chawdhry (3):
      include: env: ti: mmc: Change name_fdt usage to fdtfile
      board: ti: am62p|j722s: Add ti_set_fdt_env for fdtfile
      configs: am62p|j722s_a53: Add CONFIG_BOARD_LATE_INIT

 board/ti/am62px/evm.c            | 9 +++++++++
 board/ti/j722s/evm.c             | 9 +++++++++
 configs/am62px_evm_a53_defconfig | 1 +
 configs/j722s_evm_a53_defconfig  | 1 +
 include/env/ti/mmc.env           | 2 +-
 include/env/ti/ti_common.env     | 2 +-
 6 files changed, 22 insertions(+), 2 deletions(-)
---
base-commit: 899b088674b6905710ce546f0a8848662904852a
change-id: 20240628-b4-upstream-streamline-platform-f0d7453637b2

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

