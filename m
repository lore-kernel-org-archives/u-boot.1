Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F15C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 03:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E551D8727A;
	Wed, 15 Nov 2023 04:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jngo0EtZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3E587259; Wed, 15 Nov 2023 04:29:12 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6782862DA
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 04:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF3T2Ft127238;
 Tue, 14 Nov 2023 21:29:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700018942;
 bh=tihkogSKMwyDhf6xMyncsHBfF6F7DAcICk+tXmktD+4=;
 h=From:To:CC:Subject:Date;
 b=jngo0EtZ49k6ypO2O5uErz1GFrQT2hO7B6Yvwo+uFVMcsFhfGxv5ONantJHzovFJ8
 LxEbMD/YtEymhQettXA8VjQjtO9tW+c4KPYJ8+WciAFJa1RV3xvpTYZlrpaXMkVXKY
 fVXTvky9y+M19NvlLquFtYAY7XyYfeTZ2OyBSsa8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF3T2K2016030
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Nov 2023 21:29:02 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 21:29:02 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 21:29:02 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF3T2ra054031;
 Tue, 14 Nov 2023 21:29:02 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Marcel Ziswiler <marcel.ziswiler@toradex.com>, Neha Malcom Francis
 <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, Bryan Brattlof
 <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra
 <j-luthra@ti.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Sjoerd Simons <sjoerd@collabora.com>, Robert
 Nelson <robertcnelson@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>,
 Dhruva Gole <d-gole@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/4] arm: dts: k3-am625*: Upgrade kernel dts to v6.7-rc1
Date: Tue, 14 Nov 2023 21:28:53 -0600
Message-ID: <20231115032857.3071474-1-nm@ti.com>
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

Hi,
rev 2 of the series to sync am62 with v6.7-rc1.

Changes:
- picked up reviews, tested tags.
- minor commit message correction in patch #4.

Boot logs:
https://gist.github.com/nmenon/d62c4795c6d3d40c83ba36d1cd047c42

WARNING: This will have  a minor conflict (binman) with:
https://lore.kernel.org/u-boot/20231104080137.9628-1-nm@ti.com/


I haven't had a chance to test this out on verdin (only build tested)
- going to depend on any checks folks can provide.

V1: https://lore.kernel.org/all/20231113145919.1928812-1-nm@ti.com/

Nishanth Menon (4):
  arm: dts: k3-am625*: Sync with kernel v6.7-rc1
  arm: dts: k3-am625: Drop SoC provided bootph params from board
    u-boot/r5 dtsi
  arm: dts: k3-am625-beagleplay-u-boot: drop duplicate bootph-nodes
  arm: dts: k3-am625-sk-r5/u-boot: Drop duplicate bootph-nodes

 arch/arm/dts/k3-am62-main.dtsi                |  12 +-
 arch/arm/dts/k3-am62-mcu.dtsi                 |   2 +
 arch/arm/dts/k3-am62-verdin-wifi.dtsi         |   6 +
 arch/arm/dts/k3-am62-verdin.dtsi              |   1 +
 arch/arm/dts/k3-am62-wakeup.dtsi              |   2 +
 arch/arm/dts/k3-am62.dtsi                     |   3 +
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  | 110 -------------
 arch/arm/dts/k3-am625-beagleplay.dts          |  34 +++-
 arch/arm/dts/k3-am625-r5-beagleplay.dts       |   9 --
 arch/arm/dts/k3-am625-r5-sk.dts               |  21 +--
 arch/arm/dts/k3-am625-sk-u-boot.dtsi          | 145 ------------------
 arch/arm/dts/k3-am625-sk.dts                  |  27 ++++
 arch/arm/dts/k3-am625-verdin-r5.dts           |   9 --
 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |  55 +------
 arch/arm/dts/k3-am62x-sk-common.dtsi          | 109 ++++++++++++-
 15 files changed, 197 insertions(+), 348 deletions(-)

-- 
2.40.0

