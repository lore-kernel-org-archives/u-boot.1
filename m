Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D42E92723
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 18:13:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E21686CE7;
	Thu,  5 Oct 2023 20:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fdn04bQS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C2086BDB; Thu,  5 Oct 2023 20:13:04 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C774F86546
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 20:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=reidt@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 395ICw3k108466;
 Thu, 5 Oct 2023 13:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696529578;
 bh=D5sliqoCcrdoo7YPb4Xv4rDUSrVoJPLGRbk+959Lb1g=;
 h=From:To:CC:Subject:Date;
 b=fdn04bQSeFoGB5U+IEE4580Y1D0ofPZHbJn86+zpekMXPlB/18Rut+CWLsbX8xOxO
 U4D2f3Tg0SKOk1USkzptjDt37/vIr7tSSo7y9L/LrXJwjYIkM0YjDrb/JnO/T8LjTW
 hW9dPvauKvnFPsAcLcPmCbFK2etg1MQPVGOoKqpY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 395ICwJd079281
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 5 Oct 2023 13:12:58 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Oct 2023 13:12:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Oct 2023 13:12:58 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 395ICwDY025854;
 Thu, 5 Oct 2023 13:12:58 -0500
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>, <reidt@ti.com>
Subject: [PATCH v5 0/2] J7200 device tree sync from v6.6-rc1 to u-boot
Date: Thu, 5 Oct 2023 13:12:56 -0500
Message-ID: <20231005181258.1004539-1-reidt@ti.com>
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

Previous versions (v1-v3) of patch no longer boot in next branch due to
a recent change with how bootph-pre-ram now works [1]. Changes have
been in this version to avoid future issues with that.

Boot log is included in [2]

[0]: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
[1]: https://lore.kernel.org/u-boot/CAPnjgZ3MgWX8T0A0SofphEr_Xd77pE3hte9DNye1RuBVeB9N8Q@mail.gmail.com/
[2]: https://gist.github.com/reidt1/809bafbab561bb148513e2b55ba11a56
---
Changes in v5:
- Replaced bootph-all's in r5.dts with bootph-pre-ram
- Link to v4: https://lore.kernel.org/u-boot/20231004165629.506664-1-reidt@ti.com/


Reid Tonking (2):
  arm: mach-k3: j7200: Add mcu_timer0 id to the dev list
  arm: dts: j7200: dts sync with Linux 6.6-rc1

 .../k3-j7200-common-proc-board-u-boot.dtsi    | 208 +++----
 arch/arm/dts/k3-j7200-common-proc-board.dts   | 186 +++---
 arch/arm/dts/k3-j7200-main.dtsi               | 535 +++++++++++++++++-
 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         | 286 +++++++++-
 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 301 +---------
 arch/arm/dts/k3-j7200-som-p0.dtsi             | 154 +++--
 arch/arm/dts/k3-j7200-thermal.dtsi            |  47 ++
 arch/arm/dts/k3-j7200.dtsi                    |  30 +-
 arch/arm/mach-k3/j7200/dev-data.c             |   1 +
 9 files changed, 1207 insertions(+), 541 deletions(-)
 create mode 100644 arch/arm/dts/k3-j7200-thermal.dtsi

-- 
2.34.1

