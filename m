Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B227C71153
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 17:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4611B86E63;
	Mon, 11 Sep 2023 19:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GEl8OqdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7420886E63; Mon, 11 Sep 2023 19:33:33 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4152786E39
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 19:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BHXRob119034;
 Mon, 11 Sep 2023 12:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694453607;
 bh=IEhdyB9EHjSLiXzlfOgXE4uQxNss+oXWmUuoXQuVqEE=;
 h=From:To:CC:Subject:Date;
 b=GEl8OqdQgFA6s+HVKpKXTbM7gP0k6KzyhWSz20Az2Rlrwx1pYYfr/svxWuedSxEiL
 R22gcEwE+sLQKYKA4DhytbCESqN8EKiAkQ4B7RPrMTJdCFwo/QlbsJEOLuFLU5scWl
 UpZkEq0T0yeBqr6NJfTlc/GIB0FMTBRH5TMTp5NE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BHXRQg013173
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 12:33:27 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 12:33:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 12:33:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BHXQE2038796;
 Mon, 11 Sep 2023 12:33:26 -0500
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>
Subject: [PATCH v3 0/2] J7200 device tree sync from v6.6-rc1 to u-boot
Date: Mon, 11 Sep 2023 12:32:44 -0500
Message-ID: <20230911173246.97988-1-reidt@ti.com>
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

This series tries to sync device tree files from Linux v6.6-rc1 while
making changes to the u-boot.dtsi and r5-common-proc-board.dts files in
order to remove duplicate nodes and achieve successful boot.

This is dependent on [0]. This patch was originally a part of v2, but
was spun of as a dependency for both j7200 & j721e dtb sync series.

DMA fixes [1] are currently being upstreamed to Linux. They'll be fixed
in U-boot post their merge in Linux.

Test Logs are included in [2]

[0]: https://lore.kernel.org/u-boot/20230907180635.89011-1-reidt@ti.com/T/#u
[1]: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
[2]: https://gist.github.com/Glockn/ecbe92606a8a772486fb9f636dd1f814

---
Changes in v3:
- Sync is now ith v6.6-rc1 instead of v6.5-rc1
- &mcu_ringacc property overrides in u-boot.dtsi removed (patch 2/2)
- Change to drivers/misc/k3_avs.c is now a separate patch [0]
- dropped the trailing white space (patch 1/2)
- changed wording in commit message (patch 2/2)
- added k3_sysreset node back into u-boot.dtsi (patch 2/2)
- Link to v2: https://lore.kernel.org/u-boot/20230905181309.61666-1-reidt@ti.com/T/#m8d254c1d912aae3b636fadb23a0c8aacdd9ea484

---
Reid Tonking (2):
  arm: mach-k3: j7200: Add mcu_timer0 id to the dev list
  arm: dts: j7200: dts sync with Linux 6.6-rc1

 .../k3-j7200-common-proc-board-u-boot.dtsi    | 150 ++---
 arch/arm/dts/k3-j7200-common-proc-board.dts   | 188 +++---
 arch/arm/dts/k3-j7200-main.dtsi               | 535 +++++++++++++++++-
 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         | 286 +++++++++-
 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 301 +---------
 arch/arm/dts/k3-j7200-som-p0.dtsi             | 154 +++--
 arch/arm/dts/k3-j7200-thermal.dtsi            |  47 ++
 arch/arm/dts/k3-j7200.dtsi                    |  30 +-
 arch/arm/dts/k3-serdes.h                      | 204 +++++++
 arch/arm/mach-k3/j7200/dev-data.c             |   1 +
 10 files changed, 1383 insertions(+), 513 deletions(-)
 create mode 100644 arch/arm/dts/k3-j7200-thermal.dtsi
 create mode 100644 arch/arm/dts/k3-serdes.h

-- 
2.34.1

