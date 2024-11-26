Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1AED5A6E2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 05:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C4488DA0;
	Tue, 26 Nov 2024 06:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G8lhfCvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1FC388DD9; Tue, 26 Nov 2024 06:34:46 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C5EB88D9A
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ5YgLJ125177;
 Mon, 25 Nov 2024 23:34:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732599282;
 bh=0MXsqLUP8tjBlAcVxwVCgqnJcgOSn6eofR3XmOgYLr4=;
 h=From:To:CC:Subject:Date;
 b=G8lhfCvz8UYmxt0Vz4uahs/2518PY1a3dcOoh3psarN+2EOL6zKaDdxOraKQdBN9i
 YTt4ZxoKNqVl8T/3mf6oArHuG4CM7AcWE5JJr85N2Crh10TXgqRe69V3clgnXpy+xg
 Ju+tf5YHrJ+2fSNjejX6zvSjxdSvWlc53iL1tvjs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ5YgEf026256
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Nov 2024 23:34:42 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 23:34:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 23:34:42 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ5YcKo107360;
 Mon, 25 Nov 2024 23:34:39 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <n-francis@ti.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <m-chawdhry@ti.com>, <j-keerthy@ti.com>, <p-mantena@ti.com>,
 <j-choudhary@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 0/3] J721S2: Enable ESMs and related PMIC
Date: Tue, 26 Nov 2024 11:04:23 +0530
Message-ID: <20241126053426.2627686-1-u-kumar1@ti.com>
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

This enables the ESMs and the associated PMIC. Programming these bits is
a requirement to make the watchdog actually reset the board.

Logs
WDT reset J721S2
https://gist.github.com/uditkumarti/93cfe863d1f3fe3abb82b1821105f274#file-j721s2-L2708

AM68 boot (this does not support WDT)
https://gist.github.com/uditkumarti/93cfe863d1f3fe3abb82b1821105f274#file-am68


Keerthy (1):
  board: ti: j721s2: Initialize the ESM & PMIC ESM

Manorit Chawdhry (2):
  arch: arm: dts: k3-j721s2-r5-common-proc-board: Add esm node
  configs: j721s2_evm_r5_defconfig: Add ESM configs

 .../dts/k3-j721s2-r5-common-proc-board.dts    |  4 ++++
 board/ti/j721s2/evm.c                         | 23 +++++++++++++++++++
 configs/am68_sk_r5_defconfig                  |  2 ++
 configs/j721s2_evm_r5_defconfig               |  2 ++
 4 files changed, 31 insertions(+)

-- 
2.34.1

