Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B01D4920C
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:57:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2AC87F19;
	Mon, 18 Nov 2024 11:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dANDRwSX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9A188DEA; Mon, 18 Nov 2024 11:57:22 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE98D87F19
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AIAvIm6026840;
 Mon, 18 Nov 2024 04:57:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731927438;
 bh=eh6Eko4LSTllvxeC+NCZS7mHqDZAZ/sj8gMizA1GOps=;
 h=From:To:CC:Subject:Date;
 b=dANDRwSXjhY7jtupePtWCiF81DVByKaBrV2FFnog/B8JAquX+pUGnfyWO0YKF4A46
 HkT75a7auLG7uhckF/vk6v3fBacTEXtPl10TXJpdZ6smx9TdI7YcQFtGtfVpdPcz6U
 oF4BhZA2q7UsDFF1Reh7EhmFoBTfm+t84OBON/Mo=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AIAvIaW012860
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 04:57:18 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 04:57:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 04:57:17 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AIAvETR051199;
 Mon, 18 Nov 2024 04:57:15 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <b-padhi@ti.com>
CC: <sabiya.d@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/5] Enable AVS support for AM68, AM69 and J784S4
Date: Mon, 18 Nov 2024 16:27:09 +0530
Message-ID: <20241118105714.1973573-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This series adds AVS support for AM68 SK, AM69 SK and J784S4 EVM.

Boot logs:
https://gist.github.com/nehamalcom/db5dbf98357ebac46f648c24ad1a17e2

Neha Malcom Francis (4):
  arm: dts: k3-j784s4-r5: Add VTM node to R5 stage
  arm: dts: k3-am68-sk-r5-base-board: Add VTM node to R5 stage
  arch: arm: mach-k3: j784s4_init: Probe AVS driver
  configs: j784s4_evm_r5_defconfig: Enable AVS

Udit Kumar (1):
  configs: am68_sk_r5: Add AVS Configs

 arch/arm/dts/k3-am68-sk-r5-base-board.dts |  5 +++++
 arch/arm/dts/k3-j784s4-r5.dtsi            |  6 ++++++
 arch/arm/mach-k3/j784s4/j784s4_init.c     | 10 ++++++++++
 configs/am68_sk_r5_defconfig              |  3 ++-
 configs/j784s4_evm_r5_defconfig           |  4 ++++
 5 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.34.1

