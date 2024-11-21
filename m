Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FA7D6ED0E
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 12:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A68D8975B;
	Thu, 21 Nov 2024 13:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="di+ONNpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E10C89760; Thu, 21 Nov 2024 13:03:06 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC6838975F
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 13:03:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ALC2wAT152965
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 21 Nov 2024 06:02:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732190578;
 bh=eh9eiwbd1rCdKPDFJ+CX7fgKJkujV13legQzzczD2Oc=;
 h=From:Subject:Date:To:CC;
 b=di+ONNpnifeBqn2qwscNwsyimVJ+k3d1ABsg6S2oXddWk4d1y13E0sMqleD3xEBDO
 G7WmcrkrT89GqBZlNevFrWyqD0xzwl7BOQLIr76ew4aIbJ/6uMMr1paNxl2aA+jOWW
 Vg2t4gr1DoNWX4gzj27HE+A0LfYQ3BJIPxyhf1w0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ALC2wud023441;
 Thu, 21 Nov 2024 06:02:58 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Nov 2024 06:02:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Nov 2024 06:02:57 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ALC2sLb007780;
 Thu, 21 Nov 2024 06:02:55 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH 0/3] PLL Sequencing update
Date: Thu, 21 Nov 2024 17:32:50 +0530
Message-ID: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGohP2cC/x2MQQqAIBAAvyJ7bsFEivpKdNDaasFMtCKQ/p50n
 IGZDIkiU4JeZIh0c+LDF6grAdNm/ErIc2FQUmnZKYlW4xXSGcnsGJzDhR9sbWO0kma2toFShkh
 F/9dhfN8P4+W9NWUAAAA=
X-Change-ID: 20240920-b4-upstream-pll-fix-7b6a420adbb6
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Vishal Mahaveer <vishalm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Chandru Dhavamani <chandru@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732190574; l=1470;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=K38qgF8p68lPaj+KpAmSeFH6+BIB1W7THngSMJcjEdA=;
 b=m+uc6ex4kg9wV03KyEEKHTs2sK/lRAwHExBvdlhRMMRVv39sNiDEAf0Rehu2IrxfZAtp9DBAA
 gRQy0RaTjbVCSBTXtCvlbjLamDacQKOWnnDlptoHcMZxXmRvkqxKf27
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

It has done a re-write of the full driver and the commits aren't split
to keep the bisectability intact. 

Boot Logs: https://gist.github.com/manorit2001/1eaba109d722715a233244da693133d3

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Manorit Chawdhry (3):
      arm: dts: k3-*-r5: Remove clocks from mcu_timer0
      clk: ti: clk-k3-pll: Change variable name reg to base
      clk: ti: clk-k3-pll: Add additional robustness steps to the PLL sequence

 arch/arm/dts/k3-am62-lp-sk-u-boot.dtsi         |  10 -
 arch/arm/dts/k3-am62-r5-lp-sk.dts              |   9 +
 arch/arm/dts/k3-am625-r5-sk.dts                |   9 +
 arch/arm/dts/k3-am625-sk-u-boot.dtsi           |  10 -
 arch/arm/dts/k3-am62a7-r5-sk.dts               |  10 +
 arch/arm/dts/k3-am62a7-sk-u-boot.dtsi          |   5 -
 arch/arm/dts/k3-am62p5-r5-sk.dts               |   8 +
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts |   4 +
 arch/arm/dts/k3-j721e-r5.dtsi                  |   6 +-
 arch/arm/dts/k3-j721s2-r5.dtsi                 |   4 +
 arch/arm/dts/k3-j722s-r5-evm.dts               |   8 +
 arch/arm/dts/k3-j784s4-r5.dtsi                 |   5 +-
 drivers/clk/ti/clk-k3-pll.c                    | 357 +++++++++++++++++++------
 13 files changed, 337 insertions(+), 108 deletions(-)
---
base-commit: a38390284ad4261723d3a2411ba988828e994535
change-id: 20240920-b4-upstream-pll-fix-7b6a420adbb6

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

