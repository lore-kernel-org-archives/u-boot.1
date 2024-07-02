Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BADC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 05:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CA7884C9;
	Tue,  2 Jul 2024 07:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bGxt3wZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BD4884BE; Tue,  2 Jul 2024 07:20:30 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B082883D9
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 07:20:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4625KPnT063512;
 Tue, 2 Jul 2024 00:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719897625;
 bh=Codvon6n7RjyREwaj+qJecxG9qv4f/VODWAYLt5ifSg=;
 h=From:Subject:Date:To:CC;
 b=bGxt3wZj1MRKmzoyAu8DLOApn3X0bjUalg8mxGswNCINs8qvenwrMra5uIXMKf/B/
 sLglme3ToGzAoCrmzaYWyWoG682Iy7yzkYwOeMSIfSFiv3ZnH/XkFp72w4wDyTeOsn
 1IHSmugnzrOgeZTRUrJqHTQMRXqa3XBRtwlCKT7Y=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4625KPVI012812
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Jul 2024 00:20:25 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 00:20:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 00:20:24 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4625KKsJ070700;
 Tue, 2 Jul 2024 00:20:21 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v3 0/4] Fix fdtfile for j722s and am62p
Date: Tue, 2 Jul 2024 10:50:00 +0530
Message-ID: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAACOg2YC/43NTQ6CMBCG4auQrh3TH9qCK+9hXBRopQlQ0tZGQ
 7i7BRNd6mryzuL5FhS0tzqgU7Egr5MN1k052KFAba+mmwbb5UYU0xILWkFTwn0O0Ws1wvsMdtI
 wDyoa50cwuJMlZ4LJhqKszF4b+9gXLtfcvQ3R+ec+mMj2/d9OBDAQKXitTF3TlpyjPbZuRBuc6
 BeTmPzGaMYkZ7UxWIiGVx9sXdcX+V9tqBgBAAA=
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719897620; l=1179;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=p92YGB3WpwGEm1c3G3RWHjo+aMyyCQDrgtDV64UMjhk=;
 b=ycz/kuWaq3nkraHEQvp+6PYeuGodCVA3KsGxHTr1nSc+lLyfojovLZD0YZIhTt2j5bxScNpsP
 uJh1VLy0ijZAeWRymrdLtWopbqE9bDVKdEX7SqX8Amv3DdAZR50N5KC
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

fdtfile wasn't being populated in these boards in legacy boot using
bootcmd_ti_mmc, migrate these platforms to ti_set_fdt_env.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v3:
- Update the commit messages to make the change more clear.
- Link to v2: https://lore.kernel.org/r/20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com

---
Dhruva Gole (1):
      include: env: ti_common: Remove findfdt from bootcmd_ti_mmc

Manorit Chawdhry (3):
      board: ti: am62p|j722s: Add ti_set_fdt_env for fdtfile
      configs: am62p|j722s_a53: Add CONFIG_BOARD_LATE_INIT
      include: env: ti: mmc: Change name_fdt usage to fdtfile

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

