Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85D9FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85D10843D1;
	Sat, 25 Apr 2026 18:10:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a8ek9myv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B1E84150; Sat, 25 Apr 2026 18:10:38 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CE584353
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from DM3PR10MB7911.namprd10.prod.outlook.com (2603:10b6:0:1e::20) by
 CY8PR10MB6489.namprd10.prod.outlook.com (2603:10b6:930:5f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.20; Sat, 25 Apr 2026 06:58:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iw6q5iA+jjwNZwy5AvmEmSEjxYbdHeJ9HdVmVc/qiGnJPnKz4ebzRw7WMArGhdcQtoYcfcMuK3TYRWmcqEVwikKXC1ENzZeLwyauAaKJiJb7rtJGQU5zVJ3BRkkqELcV056hBz/DNj19duEc9hv/154iwLaRYVgvr+Aj8DUk/LhjMRjTEzm61px4ax4Tzr/IySu+S7f+hno/w1DfDfbTkmuNPqi+PPK1gPMyh2i+/CpLRJUi1EzhV6Jv4ti/gmevxAmrwR4WIMcP+CQvlGzqLMRjE3M7TmSD3WSuUaheM043DNYz6nqwvFLirQtz5/VNp9/GkIvONb9Eg7uJOCNtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vO1PIG5XVx6mitI+Q0zACDtIFRXPfT4yjCw4x9hn1NE=;
 b=AqbMAE+USngioE7Le5B251jvjaw9MX4D1DlBjWFDTOnfxR4OtmcJJbNoU9pO7LGggIX7ITGLpcReB6mKF/CqGaH5vRA92CnNBt/4wAzF18evnht+JRPICdYrviIP+KLbgamF3laZMRMMgSqJ3v20ehjcTpvg1yrtb0FJH89uNxx5DPJfFHHZeqQnUPWg+rtinFM1DIl9hfKgIM9o0myV2YtJP2sy7K+dHI7sl7MZZP9/bvU5YvikFioMC9zDouFgnahWtoRG1RA4TAq3Y6rNkd12/IFlxsbngDsMnW1W2LADAQBTDDZvJwidgAMM7uPmzlB1w8jzy6X9px3j1NwPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO1PIG5XVx6mitI+Q0zACDtIFRXPfT4yjCw4x9hn1NE=;
 b=a8ek9myvtChdQfg3UYjXwh1fn2eSIyYNftQFZSvTxQM/d4GjapzTI2CnzM2dcqAbnt0NLYiMACUGph5V9hSDd/Oybak01aV6VH2va7XcPDQP5ISN6n7R5GwmU017o8VWAEOYX3+9TSR09UnMetEzVvgpPAXvhzYkXHrgA0iwKX8=
Received: from SA9PR13CA0130.namprd13.prod.outlook.com (2603:10b6:806:27::15)
 by DM3PR10MB7911.namprd10.prod.outlook.com (2603:10b6:0:1e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 03:37:50 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::a6) by SA9PR13CA0130.outlook.office365.com
 (2603:10b6:806:27::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.19 via Frontend Transport; Sat,
 25 Apr 2026 03:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 03:37:50 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:37:49 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 22:37:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 22:37:49 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 63P3bk7x2903263; Fri, 24 Apr 2026 22:37:46 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4 00/11] Add support to boot TI K3 HSM M4 core
Date: Sat, 25 Apr 2026 09:07:31 +0530
Message-ID: <20260425033742.1519298-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DM3PR10MB7911:EE_|CY8PR10MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cac420-2ab0-4e9b-0996-08dea27c0681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LdlzrxK/zPONzBQq2icshVdlnzLe080bS9vmsFtAfRkEx3aCgpOPmNDvPXDNKl1gw7bPNkHCaaXHj4lBje1B56wnt//HnVvmC6D0bOTqjAKnk8aJUcPg3D9Pt1BbeEB+1/73iDDGmUQqwC3Xt6kbTN3vU6lwzNwHtC4KWCWR1WNghRlG/URV54NeKEeMF0EUWiW8NtajfkeIp6Rl34MsHMjAoga9DnoGn0ciUGy1CtpfXmk7sEpPWOujjMuVxMM72vPjPYjcc8evy1WvQPlR3vtW3+6R+DHfB16VoCE5BVRRCzwJgnP6jXGmt8E6XV8ckwu1eBEKZHcJIYhRxtKCLr7kp70tzMqxFnkRDBSYHpLM+tzAidWbRDJASdla1yl7UC/wQ6k128k0AYRjDIg2KrMclHfH9Nz+UNTDKnxIuzf6KyaOCaNSitUgxSa17mRZfvUDX1w+B/2awByzqwRuxtLtnBjqSuHCcn9J9tcypUi93woJHdfWpDmYOWi8wDATz4pM7S47ZxIBasE5F5FAXU+bg7hyEM23rscJdJf0IZHp3jkxiZH8X9ATjZ/C3b00+FpYg4FU2f8pXxbDnZxs88DaCiU2e5x9LHFtE4HUazcCTqdBy6L5oiaCKXxT9bfLbbAn87y5m8lxv0Ves/jGrKdxUcf8g5YJgJ7hdtlBkOciPaWeKpa2AKkoqcs/3X6YkJFzvsjgoh87EqHU79gDhqVVmLkmq79Xj66VnQvN7uemr+j9H9mlSdwadpxCqvt132W1LH8Cs9h1NccKc4Y+hDbtM9ZtMsQ/BENg+SFDYvk=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f4kYsOgN5Iq6duz2eP0nw4JeeSE50wbeORiuirgRfGNDjF1xLpkTwB061pzVVArGsAGJjRC5rhopX5cfMg1v+FYkykfW0PCGI4sNQXMlyQoAhDUhObjCF36C+D7fJ7Q3yU6XRxxpiS5avZbwYnHvc8O5acpwkbs2VPjbJIwmK3wrSC+jkitBD4FTWS4h1gKaAtlMfrweP3Vk9Eqqh8CcAyXREul5CHPAKsilF6A2no20LYAuBWGC+D6ioQ5NBxXiaRrLgbx8cGmxP13TG79iuUQTF+upIoW6aqXtWv5Ldq4InUqu3xS0qH7ToxaDHYOWvmEiY55Wrzl59WjFrjYulMDTxnJQIkski+WzFNMhD5I8c/PUx/gDz9/M19cbH35ApaodZx/mNdA37TZW88WgDG/o1iECLFkr5GobzStHpICDR2HRMpafgEqCKd2/SpAV
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 03:37:50.1309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cac420-2ab0-4e9b-0996-08dea27c0681
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7911
X-OriginatorOrg: ti.com
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

Some TI K3 SoCs like J721S2, J784S4, and J722S have a HSM (High Security
Module) M4F core in the Wakeup Voltage Domain which could be used to
run secure services like Authentication. Boot flow for HSM M4 core is
different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. Request Secure Entity to Authenticate and Load HSM firmware into
   core's internal SRAM memory region. For GP device, load the firmware
   manually into core's SRAM region.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

This series adds support to boot HSM M4 core from R5 SPL stage. The HSM
firmware is packed inside the tispl.bin fit image. The firmware is
unpacked into a temporary DDR address which is then used to load HSM
core. The configs to boot HSM M4 core are disabled by default.

v4: Changelog:
Re-spinning after Device Tree Syncup happened from Linux to U-Boot.
[Andrew]:
  1. Reworded commit message on [PATCH v4 03/11].
[Simon]:
  1. Add a binman test for the boot & load extensions in certificate in
     [PATCH v4 08/11].
General:
  1. Drop J722S defconfig changes out of this series. Will be
     posted/discussed separately.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-1-b-padhi@ti.com/

v3: Changelog:
[Andrew]:
 1. Added dedicated remoteproc driver for booting HSM core.
 2. Added support for signing HSM firmware images in U-Boot. [Anshul]
General:
 1. Add support for booting HSM on J722S SoC as well.

Link to v2:
http://lore.kernel.org/all/20250506104202.16741-1-b-padhi@ti.com/

v2: Changelog:
[Andrew]:
 1. Added support in SPL to load FIT images with no 'load' property.
 2. Removed 'default = n' in CONFIG option.
 3. Used __maybe_unused to decrease preprocessing.
 4. Better error messages with error code. 
[Udit]:
 1. Added 'HSM' entries in enum at the last.
 2. Added error condition in if-elseif-else ladder.
 3. Hang System boot when HSM failed to boot properly.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-1-b-padhi@ti.com/

Testing done:
1. Tested HSM boot across GP, HS-FS, HS-SE device types for J721S2,
J784S4 and J722S SoCs.

Logs after enabling HSM boot configs:
https://gist.github.com/3V3RYONE/ad33683652c8c49e4fedab49f0493e79

Beleswar Padhi (11):
  spl: Use FIT data address as fallback when 'load' property is absent
  arm: mach-k3: Use FIT image data addr as fallback if 'load' prop is
    missing
  arm: mach-k3: Explicitly identify TIFSSTUB images when discarding
    buffers
  arm: mach-k3: Add config option for packaging HSM firmware
  arm: dts: k3-binman: Add template for packing HSM firmware
  arm: dts: k3-{j721s2/j722s/j784s4}-binman: Pack HSM firmware inside
    tispl.bin
  binman: openssl: Add boot and load extensions to x509 cert
  tools: binman: Add a test for boot and load extensions
  arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM core
  remoteproc: k3-hsm: Introduce a remoteproc driver for K3 HSM core
  arm: mach-k3: r5: common: Invoke boot of HSM M4 core

 MAINTAINERS                                   |   1 +
 arch/arm/dts/k3-binman.dtsi                   |  20 ++
 arch/arm/dts/k3-j721s2-binman.dtsi            |  12 +
 arch/arm/dts/k3-j721s2-r5.dtsi                |   5 +
 arch/arm/dts/k3-j722s-binman.dtsi             |  12 +
 arch/arm/dts/k3-j722s-r5.dtsi                 |   5 +
 arch/arm/dts/k3-j784s4-binman.dtsi            |  14 +
 arch/arm/dts/k3-j784s4-r5.dtsi                |   4 +
 arch/arm/mach-k3/Kconfig                      |   7 +
 arch/arm/mach-k3/r5/common.c                  |  42 ++-
 common/spl/spl_fit.c                          |  16 +-
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c          | 252 ++++++++++++++++++
 tools/binman/btool/openssl.py                 |  49 +++-
 tools/binman/etype/ti_secure.py               |  18 ++
 tools/binman/etype/x509_cert.py               |   4 +-
 tools/binman/ftest.py                         |  10 +
 .../test/vendor/ti_secure_boot_load_ext.dts   |  23 ++
 19 files changed, 496 insertions(+), 9 deletions(-)
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext.dts

-- 
2.34.1

