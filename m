Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A19C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 12:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4F187A84;
	Mon,  8 Jan 2024 13:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FBaiTPPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC68787A07; Mon,  8 Jan 2024 06:19:33 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937ED87872
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 06:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-kapoor@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4085JOvG027556
 for <u-boot@lists.denx.de>; Sun, 7 Jan 2024 23:19:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704691165;
 bh=aEUFxFl/2kspIQTvu0Xi6vxLD7frooUpGb07oMQ3Rbs=;
 h=From:To:CC:Subject:Date;
 b=FBaiTPPQYtyho8R1aYNW9xvC4YCF60maWLReUbM/q/0+FPcSAaAyIoYr0t3HsQbpe
 5kG1opxF2BznaqMasiZOfO7UZM5iFS2ZsGi7AV0HDx45wdCbsiAiIZ1Ea+dS5fxU2O
 l1c0Njznlqt9rZzCDm8zb8ffHvaAwRuhRv6ePc44=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4085JOXu111748
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Sun, 7 Jan 2024 23:19:24 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 7
 Jan 2024 23:19:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 7 Jan 2024 23:19:24 -0600
Received: from localhost ([10.249.128.27])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4085JNZ1054314;
 Sun, 7 Jan 2024 23:19:24 -0600
From: Bhavya Kapoor <b-kapoor@ti.com>
To: <u-boot@lists.denx.de>
CC: <b-kapoor@ti.com>, <jm@ti.com>, <m-chawdhry@ti.com>, <reidt@ti.com>,
 <n-francis@ti.com>
Subject: [PATCH 0/2] arm: dts: Add Itap Delay Value For High Speed DDR
Date: Mon, 8 Jan 2024 10:49:20 +0530
Message-ID: <20240108051922.29044-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Mon, 08 Jan 2024 13:10:24 +0100
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

This Series adds Itap Delay Value for DDR52 speed mode for eMMC in
J7200 SoC and for DDR50 speed mode for MMCSD in J721s2 SoC.

Bhavya Kapoor (2):
  arm: dts: k3-j7200-main: Add Itap Delay Value For DDR52 speed mode
  arm: dts: k3-j721s2-main: Add Itap Delay Value For DDR50 speed mode

 arch/arm/dts/k3-j7200-main.dtsi  | 1 +
 arch/arm/dts/k3-j721s2-main.dtsi | 1 +
 2 files changed, 2 insertions(+)

-- 
2.40.1

