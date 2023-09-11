Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8ACEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D924286D2F;
	Mon, 11 Sep 2023 16:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OB7+GEOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90DCE86D2F; Mon, 11 Sep 2023 16:03:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863C286A82
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BE2vDQ042440;
 Mon, 11 Sep 2023 09:02:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694440977;
 bh=hbWXyU21Fcy7VfJ4bSbOe0LeFHwVcydlOvjjj0Vfyhc=;
 h=From:To:CC:Subject:Date;
 b=OB7+GEOS+owUw4yFsody/YK4LlsWz3dkHLDEo+QNof+ySLm85/MrqJ4HMSCaAfBv8
 QSmeEk73BCk8QndUAO5ru599+x77NbpCFhtOu5nQXuzR///U8J5B3UEH5YRx8MqR6W
 eLBo4nLMhpBZDsHQPyw+m+AqujxR7c/14mQ1x5BE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BE2vl4052634
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 09:02:57 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:02:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:02:57 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BE2voR031000;
 Mon, 11 Sep 2023 09:02:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Marcel Ziswiler <marcel@ziswiler.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] arm: dts: k3-am625: Sync with kernel v6.6-rc1
Date: Mon, 11 Sep 2023 09:02:54 -0500
Message-ID: <20230911140256.945074-1-nm@ti.com>
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

Sync device tree with v6.6-rc1

Bootlog: beagleplay: https://gist.github.com/nmenon/b46863248e8cf0cdaaeca0d55c966af4

Nishanth Menon (2):
  arm: dts: k3-pinctrl: Sync with kernel v6.6-rc1
  arm: dts: k3-am625: Sync with kernel v6.6-rc1

 arch/arm/dts/k3-am62-main.dtsi       |  52 ++++++++-
 arch/arm/dts/k3-am62-mcu.dtsi        |  24 +++++
 arch/arm/dts/k3-am62-verdin-dev.dtsi |  50 +++++++++
 arch/arm/dts/k3-am62-verdin.dtsi     |  45 +++++++-
 arch/arm/dts/k3-am62.dtsi            |   8 ++
 arch/arm/dts/k3-am625-beagleplay.dts | 154 ++++++++++++++++++++++++++-
 arch/arm/dts/k3-am625-sk.dts         |   2 +-
 arch/arm/dts/k3-pinctrl.h            |  12 +++
 8 files changed, 337 insertions(+), 10 deletions(-)

-- 
2.40.0

