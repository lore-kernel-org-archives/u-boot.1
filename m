Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD19C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 09:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4974D869A7;
	Wed, 16 Aug 2023 11:23:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hbPjqAJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E350869A7; Wed, 16 Aug 2023 11:23:30 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89BCF847C3
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 11:23:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37G9NOAE031844;
 Wed, 16 Aug 2023 04:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692177804;
 bh=xlwHSyVhsWsYoi1YnpB4hQmCIg99QR/FZd3lWUTbqsw=;
 h=From:Subject:Date:To:CC;
 b=hbPjqAJqiWZncNHGLtUIo19tbIkNcbxx3xP9R8eJLuYqSQpps/Pc6R7G2PcL+BSCh
 w9Xw7wXOGATPccTygorDfdn2NqbLcdBIXstI5bVzhNUsDtqKEDXHIB6jY4N8SCV3XP
 A2so1Bo4DSiAfnpYGzJQLsKZpNQfE6o2cvurFlfA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37G9NOaF062338
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Aug 2023 04:23:24 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Aug 2023 04:23:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Aug 2023 04:23:23 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37G9NJBi059893;
 Wed, 16 Aug 2023 04:23:20 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 0/3] DTS Sync from next-20230815 to u-boot
Date: Wed, 16 Aug 2023 14:53:08 +0530
Message-ID: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHyV3GQC/z2NQQrCMBBFr1Jm7UATm1q8irhI0tGO0BhmWgmU3
 t3UhcvH47+/gZIwKVybDYQ+rPxOFcypgTj59CTksTLY1p7bwfQYOlyzLkJ+xtfFGrUoDjOneS1
 oXezi2Jtg3QA1EbwSBvEpTkfkP0xUlsNnoQeX3/3tvu9fD/yH8o4AAAA=
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692177799; l=2466;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=bGL0pd01ZoSvVj+RHdkG2PuNUr4gErao15HT45LawsY=;
 b=9336wzETalRC1s8iYW/aEdLdRj602G65GYtrO1C0zGVLmyjjhuAnsLJXFr5j9FkyLwQiQhGv7
 hd1OzuSRWNIAr/KxrX6gUJQY364Wwm2H3nYRa3meK2QWsVq2HCOUrhc
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
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

The sync tries to ensure that U-boot remains functional with the updated
Linux DTS and all the fixes from Linux move to U-boot during the sync.

The series tries to sync from Linux next-20230815 along with addition of
the documentation for J721S2 that had been previously missing.

Linux next-20230815 has been choosen due to certain fixes of mcu_ringacc
being merged to -next recently that helps this sync to remove overrides
for mcu_ringacc from -u-boot.dtsi

* 702110c2be99 arm64: dts: ti: k3: Add cfg reg region to ringacc node
* 4f1e869915b7 dt-bindings: soc: ti: k3-ringacc: Describe cfg reg region

DMA fixes are also being upstreamed to Linux [0]. They'll be fixed in
U-boot post their merge in Linux.

Test Logs are included in [1]

[0]: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
[1]: https://gist.github.com/manorit2001/dbad09fd00e8b7c3872e85874c8e648c

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (3):
      k3-j721s2: Sync from linux-next tag next-20230815
      k3-am68: Sync from linux-next tag next-20230815
      docs: ti: j721s2_evm: Create documentation from J7200 docs

 MAINTAINERS                                        |   1 +
 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi     |  57 +-
 arch/arm/dts/k3-am68-sk-base-board.dts             | 524 +++++++++-----
 arch/arm/dts/k3-am68-sk-r5-base-board.dts          | 109 +--
 arch/arm/dts/k3-am68-sk-som.dtsi                   | 112 +--
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |  52 +-
 arch/arm/dts/k3-j721s2-common-proc-board.dts       | 376 ++++++----
 arch/arm/dts/k3-j721s2-main.dtsi                   | 777 ++++++++++++++++++++-
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             | 374 +++++++++-
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    | 110 +--
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 | 172 ++---
 arch/arm/dts/k3-j721s2-thermal.dtsi                | 101 +++
 arch/arm/dts/k3-j721s2.dtsi                        |  12 +-
 arch/arm/dts/k3-serdes.h                           | 204 ++++++
 doc/board/ti/j721s2_evm.rst                        | 228 ++++++
 doc/board/ti/k3.rst                                |   1 +
 16 files changed, 2407 insertions(+), 803 deletions(-)
---
base-commit: 5d3758178bc23d731897f05244bf564f8d1caf48
change-id: 20230816-b4-upstream-j721s2-r5-pinmux-25c4cd61b258

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

