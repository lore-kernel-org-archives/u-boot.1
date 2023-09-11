Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A042EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5763086E37;
	Mon, 11 Sep 2023 16:44:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s96eVlyA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F9BB864AA; Mon, 11 Sep 2023 16:44:13 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 066388656A
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BEi4ci052578;
 Mon, 11 Sep 2023 09:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694443444;
 bh=HmQQiwlIJ3D3wuPJRvMTTn2y705vErg7Su3qt6F4kx4=;
 h=From:To:CC:Subject:Date;
 b=s96eVlyADsQHHp89K7FWRDv9A/46UYaPA8zxyYTPHTcvP8Xm/+MEnpFiEuzaeUZIU
 XowaII1K7T5jJihlqaR16omowhHHJjshxmi6xPVImpjro8Ov8yObTdNPFVnQeM9Xdm
 j37QYur6Fbm1e9qf1TWFD/zj2Fy40RRLrH6cRjRQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BEi4lB080116
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 09:44:04 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:44:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:44:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BEi4q3035464;
 Mon, 11 Sep 2023 09:44:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>
Subject: [PATCH 0/4] arm: dts: k3-am642: Sync with kernel v6.6-rc1
Date: Mon, 11 Sep 2023 09:43:57 -0500
Message-ID: <20230911144401.1011354-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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

Sync with kernel v6.6-rc1

Bootlog: am642-sk: https://gist.github.com/nmenon/35f509e2f63b0ab0b434625e68e4f37d

Nishanth Menon (4):
  arm: dts: Introduce k3-serdes.h from v6.6-rc1
  arm: dts: k3*: Use local header for SERDES MUX idle-state values
  dt-bindings: ti-serdes: Deprecate header with constants with v6.6-rc1
  arm: dts: k3-am642: Sync with kernel v6.6-rc1

 arch/arm/dts/k3-am64-main.dtsi                | 48 +++++-----
 arch/arm/dts/k3-am642-evm.dts                 |  4 +-
 arch/arm/dts/k3-am642-sk.dts                  |  8 +-
 arch/arm/dts/k3-j7200-common-proc-board.dts   |  2 +-
 arch/arm/dts/k3-j721e-main.dtsi               |  2 +-
 .../ti-serdes.h => arch/arm/dts/k3-serdes.h   | 90 ++++++++++++++++++-
 include/dt-bindings/mux/ti-serdes.h           | 70 +++++++++++++++
 7 files changed, 186 insertions(+), 38 deletions(-)
 copy include/dt-bindings/mux/ti-serdes.h => arch/arm/dts/k3-serdes.h (55%)

-- 
2.40.0

