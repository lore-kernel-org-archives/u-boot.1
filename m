Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC5AFD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8545283F2A;
	Tue, 10 Mar 2026 14:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="od/xV4kW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A05A083FA7; Tue, 10 Mar 2026 11:06:28 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113EC83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 11:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKEp9axQeU++JzL3W/zuI8t+N0zXjTZAs0l/BIoB+TWHqvC0yE25iCQbX8EUtk1dnrcuEs8Qb2K25tJug3clWDNm9+w/jRO1kKWU6PUlmbaJW9jsyE6vXyc0F3EbyhPDmVBJDktrMsvHS0SHf/D2pigGiJ6onJ6I+AMql8VpIs/cNp7kZWSFL1icwJnbZNmbgSD1YgfFDJXUEBu2Ff/FAZyhSIaM+3bWX0wUdcy0GOqKF1ntymlPOYcren7z7RlrjryK37/L1B5AWhaObKmP/ZIkaz3fPbOUTkZZhX78DP5mqf9x7znEcEnw2KbrhEnSDmHjMQZook4z42sYqw7Njg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tjQoMIHn1sbZxj+YjttcpPFs9am1dgtkn8m2jfnvUk=;
 b=TXbkxTD9YwyFZtpM72ADOPy5cnY4N3Y93d2FUi3RFEp3VwwwI7nn13KtCX+BlbqF5SpGGvuLigfCnv0vtmkhIWYw6yOnAyMPLIKpJW7fcb7AyakCPLx9YgjXvHoy6mGGClQggylg4vutkgzWsKoDA1SI4oXQSrxZtl7qcdB5Fi1/DWKwOUVrM2OD/dJFp1DzbjSzUb/VEZxMqQj5sW4omahnC4An8KLdhcAz7fOMXKoc7YPxWwESHxkNR7sVjRmRKYNhMBdZsbfp0DfgIC2zgMKSVufuP0HezQuO93+4w1tiiJltMV0FZqFX64A95JMUhO6d7q/wsD7E0l1orFTwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tjQoMIHn1sbZxj+YjttcpPFs9am1dgtkn8m2jfnvUk=;
 b=od/xV4kWoxo/mTxCy/XTPgdp3u5bWYciWTb7r9rjDoVgYkeRmDzxV3iFBxqjGhvoqnJ4twE0iNyZbk/ffroVtcKR5cqTQlrRGgp4r2scRTo2HVpxZiGlUDRcgq4qr2dzsyR9ft+OPl77Xdont+agFzvvgYZEFHjdyJtS5Z5dwUQ=
Received: from BL0PR02CA0006.namprd02.prod.outlook.com (2603:10b6:207:3c::19)
 by SJ0PR10MB5599.namprd10.prod.outlook.com (2603:10b6:a03:3dd::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 10:06:23 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com (2603:10b6:207:3c::4)
 by BL0PR02CA0006.outlook.office365.com (2603:10b6:207:3c::19) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26
 via Frontend Transport; Tue, 10 Mar 2026 10:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 10:06:22 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:20 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 05:06:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 05:06:20 -0500
Received: from akashdeep-HP-Z2-Tower-G5-Workstation.dhcp.ti.com
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.91])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62AA6Hr02355078;
 Tue, 10 Mar 2026 05:06:17 -0500
From: Akashdeep Kaur <a-kaur@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
 <msp@baylibre.com>
CC: <u-boot@lists.denx.de>, <vishalm@ti.com>, <sebin.francis@ti.com>,
 <d-gole@ti.com>, <k-willis@ti.com>
Subject: [PATCH v2 0/4] IO+DDR low power mode bugfixes for AM62P and AM62A
Date: Tue, 10 Mar 2026 15:36:10 +0530
Message-ID: <20260310100614.951573-1-a-kaur@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="yes"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|SJ0PR10MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: b9daeae9-13ba-43a7-887e-08de7e8cae8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: IsJkJm/X2kcyTAWkLo8XjjarGAM3faHOC50phSpLl9JTtDXDU20fhpmRmeONnqWKQSnzP405dXfOT8DQlKzMfl6fmsBxw7uz8UMGE+r9o491p14tP/gFjpwcXU8UUC08EZy/tQxCOGLYgzPaFguz/uTaah6Unlk8rlhv0CTNJ14NIbDf4mTZqkcUzRF+vUDJnzjCLIPVH71hY3baakomLMKxkemj7udzn4aZBRBx58WhIBreiLXqXM43Bf3uZZty8ZOJC1K3fr5cHJnNDYFLDBS0d4iPkGWqIJXvRrqHWtmS9ZoMNAAn2YfcnLNuWrtWQJazemmyXjHUuBa0esBahRbxejx+lcTJy4IV0UGBxBdTpJf/QFDZlUh7WZi6sbPr4sqA/QPx6VCoVwj1yupITRF3ViD9awTXltX2zsRZ/U+kahfg+EOnd43YCMoHaEkn2KhYSvkgp8AA9QmkTJxoaWcLNLkv7I6Bdw3/At2NQTzNvUVauSacHQeXVLxP1myQDpir/zYjdT9yuylSIlPsjyXU8060rmW4Uy6pgOJoOSVHUzb6UDOKXPcPf8gWgOjoa9abGeeLM0Iuli2PFbgKdlA9TYgn9Gp8aFMzFXb1rg7i8ZqPJRVytgCZ9fyea4wm1FVlmyWMC+BCqMv1xhJEs2fcv6QGKU4QKKwpcK08jTW2CLcdXiaRSDqFWZowT51Ve03h+g03D06tNjogOqg8hA3TFK97UKjmzeiNMb3ggy42mQEBlkxpPyVRTi5+HNPUHGF+lbPT+QvKb+HFvMRPYw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4ZzPxHJzAWZWdA4cgm7uWPNnUwCOFGxoz3IKJ+NluBko2zWgMRYrXY7S42gdyzBCJ7hqCqQWlOyHBdnsZ2fBQSQHv30/gXaQr/mz7k8PTySEIC+wp3ZP+iy9M/OjaNfDj1ssC16XZdHWgQrPSf7vLtwNTa+SfN0qpgATCzWIImet6y/p9MzYQUHt6vSREfrRnqhfnFymDYHxg7fAc/VQ7IYLLvkFUiMMnMtfkpDr6vHeY7IKjFh7MD4gVyt7h1mHqaQzAnV4JcY6EvghRFIZb4NJej3QvgRaZhGzhx07/XJLxVmEukbuW5IkbKMfqA+kQsg2ZxsdbfReeoCG+vhCbNnfEJNjralzGsiEz7Tqcil2I3kOFE0FO6Ax0QkWbTCyb0v1tFG7kTjvdmpWXCGJ0gdwnuWcdbHIs1YepHDZCxuJuFRw/PcsmY2j+SkDDfxf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:06:22.1087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9daeae9-13ba-43a7-887e-08de7e8cae8e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5599
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:02 +0100
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

This series provides bugfixes for IO+DDR low power mode on AM62P and AM62A
SoCs by adding DDR errata workaround and 32kHz clock restoration.

Background:
-----------
During IO + DDR low power mode, the system enters into low power with DDR 
in self-refresh. For proper resume operation, two critical aspects must be
handled:

1. DDR Retention Latch: AM62AX and AM62PX are affected by errata i2487
   where DDR retention mode transition may fail, leading to data 
   corruption. A workaround sequence must clear the retention latch on 
   every boot.

2. 32kHz Clock Source: The SoC requires an accurate 32kHz clock for
   timing-critical subsystems. Without restoring the 32kHz LFOSC early
   during resume, the system falls back to the 32K RC oscillator (±20%
   accuracy), which is insufficient for components like RTC that rely on
   accurate timekeeping.

Changes:
--------
Patch 1: Add DDR errata i2487 workaround sequence that clears the data
         retention latch on every boot and abort scenarios. This ensures
         successful IO+DDR LPM resume for AM62AX and AM62PX.

Patches 2-4: Enable 32kHz LFOSC during LPM resume for AM62P and AM62A SoCs.
         Add function declaration to common LPM header and call it during
         resume path for both SoCs. Conditionally enabled via
         CONFIG_TI_K3_BOARD_LFOSC for boards with external crystal
         oscillators.

Testing:
--------
Tested IO + DDR low power mode on AM62PX-SK

Dependencies:
-------------
This series depends on the IO+DDR base support series v9 by
Markus Schneider-Pargmann:
https://lore.kernel.org/u-boot/20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com/

Base commit: v2026.01-rc4 (0e0a198a68be)

Changes in v2:
--------------
- Combined DDR errata workaround and 32kHz LFOSC patches into single series
- Rebased on v2026.01-rc4 with IO+DDR v9 series applied
- Link to v1: https://lore.kernel.org/u-boot/20251211093232.3706673-1-a-kaur@ti.com/

Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>

---

Akashdeep Kaur (4):
  ram: ti: k3-ddrss: Add workaround sequence for errata i2487
  mach-k3: am62xx-lpm: Add 32kHz LFOSC enable function declaration
  mach-k3: am62px: Enable 32kHz LFOSC during LPM resume
  mach-k3: am62ax: Enable 32kHz LFOSC during LPM resume

 arch/arm/mach-k3/am62ax/am62a7_init.c |  3 +
 arch/arm/mach-k3/am62px/am62p5_init.c |  3 +
 arch/arm/mach-k3/am62xx-lpm-common.h  |  1 +
 drivers/ram/k3-ddrss/k3-ddrss-lpm.c   | 80 +++++++++++++++++++++++++++
 drivers/ram/k3-ddrss/k3-ddrss-lpm.h   |  1 +
 drivers/ram/k3-ddrss/k3-ddrss.c       |  5 ++
 6 files changed, 93 insertions(+)

-- 
2.34.1

