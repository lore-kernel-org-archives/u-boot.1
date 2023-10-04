Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76ADE7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1816875D1;
	Wed,  4 Oct 2023 18:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="clWjlO7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3C887575; Wed,  4 Oct 2023 18:56:39 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF3F87594
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 394GuUDo120534;
 Wed, 4 Oct 2023 11:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696438590;
 bh=toOVVWdqWWzabTUdmo58UhH+o6jf9nToTlxIy3eNkyU=;
 h=From:To:CC:Subject:Date;
 b=clWjlO7JLbg+Oh1STZoUJblkPfcXcebAfOqvbYEsZVDI+O6zZ+Oc9O8GWRsa3kqm6
 ryQkRxesc8PYPujNL5Mb8yyRH30FyRGe6Bu6Tm47R464UMkOr+JQiEFoiUyE5fM6Wu
 mrF+7DSkG+/0p3mU/TB5VXTzThEYVm8IIt8uhZUE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 394GuUbA129124
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Oct 2023 11:56:30 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Oct 2023 11:56:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Oct 2023 11:56:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 394GuTQI086693;
 Wed, 4 Oct 2023 11:56:29 -0500
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: [PATCH v4 0/2] J7200 device tree sync from v6.6-rc1 to u-boot
Date: Wed, 4 Oct 2023 11:56:27 -0500
Message-ID: <20231004165629.506664-1-reidt@ti.com>
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

DMA fixes [0] are currently being upstreamed to Linux. They'll be fixed
in U-boot post their merge in Linux.

Previous version of patch no longer boots in next branch due to a
recent change with how bootph-pre-ram now works [2]. Changes have been
in this version to avoid future issues with that.

Boot log is included in [1]

[0]: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
[1]: https://gist.github.com/reidt1/3bc6c5a0230346a5136aa857485b2cdb
[2]: https://lore.kernel.org/u-boot/CAPnjgZ3MgWX8T0A0SofphEr_Xd77pE3hte9DNye1RuBVeB9N8Q@mail.gmail.com/

---
Changes in v4:
- Changed bootph-pre-ram to bootph-all in response to [2]
- Removed serdes.h from series since it has been added already
- Rebased off of "ec6f06bddc configs: Resync with savedefconfig"
- Removed reviewed-by on patch 2 due to changes
- Link to v3: https://lore.kernel.org/u-boot/20230918171813.11407-3-reidt@ti.com/

Reid Tonking (2):
  arm: mach-k3: j7200: Add mcu_timer0 id to the dev list
  arm: dts: j7200: dts sync with Linux 6.6-rc1

 .../k3-j7200-common-proc-board-u-boot.dtsi    | 208 +++----
 arch/arm/dts/k3-j7200-common-proc-board.dts   | 186 +++---
 arch/arm/dts/k3-j7200-main.dtsi               | 535 +++++++++++++++++-
 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         | 286 +++++++++-
 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 311 +---------
 arch/arm/dts/k3-j7200-som-p0.dtsi             | 154 +++--
 arch/arm/dts/k3-j7200-thermal.dtsi            |  47 ++
 arch/arm/dts/k3-j7200.dtsi                    |  30 +-
 arch/arm/mach-k3/j7200/dev-data.c             |   1 +
 9 files changed, 1212 insertions(+), 546 deletions(-)
 create mode 100644 arch/arm/dts/k3-j7200-thermal.dtsi

-- 
2.34.1

