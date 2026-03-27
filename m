Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE96F10F284A
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B4FE8416C;
	Fri, 27 Mar 2026 17:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="m61Kfs4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E8483C14; Fri, 27 Mar 2026 15:10:52 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A94483C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5asMIK/jdkXGZMIh+OnhDr0/AoKfxNT/2sNe6PzCv6VDBru9RVA1Y7Veix94tm5rADve51mgoqIq7Cw2g/BNufea+1CjH8paGYEyFG9eNVn6ayxpJwwLAQKf2tfAxSFtpp2MJVB2cQtdg6RH1uoQbRg/rh6CPYgpUpKApNWIuX/UgE6R4XHAFmaMSNdRbw4Fxojfph+hdrywSP2zgakdlvEeBx3tPvNWQ29q7+HcnrvgREP6qFwFlAblOSCsF4gP2uc1x8BORDdLlu3J03ocqaZRX7yzwCUXA+zar2UtgfsXTaGPFlcXRCfRHECDLd1drDjL5tzu20Zai0Gt/laVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKB/VfFt4oCo8sz6K5vsOvB5DuFdoLpUBCI3D7ypx4g=;
 b=yhWDdfWEZGxWVzpz1+yf3nFHD+RqgWI6iKnamBtayYu1oOx1FkfeoB3kup1NkRIUKhg/7X2bb66YQyF6WOcPURqZ86pD4uJhor6OLZedGNgCg0I0uig9dIsp5ETM3nCNSwuQ8N2Oox5YBVQaGz/m771i7KHSSuBrMdpGoLGfihs30c4cxKOMTpqLJTvRtxAyJrFUEdgyz5ULW9fIPagZvLyLGMwPLcIvGsU6IVss72ToRGTOZwsLZ0xkSyxrkRoFdzBkp6YVL/mEzC0BUNdLrNiOz6zQ7KX0+fj4JVJeSFTeNkKXHzSIvb11H8giCLDJV4PWzbWD8Km/jIXdeX/iKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKB/VfFt4oCo8sz6K5vsOvB5DuFdoLpUBCI3D7ypx4g=;
 b=m61Kfs4bkLG2aezL1IshT/JrwGMOaizQ/U0MvXLlxvpVBC70HVC7Y0VNxoT9dMpa/WF3ojnoZYn38lJQ/5k9wH5YwHQIFC180zbuNfkeiBrYVrEfiEMfiYN492TJ3TtDOGEmPm15qwjrdcOkKJ3IudN10qLDjC3UtUZAIKZTdwukdWp8sHs59yAA0JrYQjlTrtxaBrjW9n6EN3aTO/i6tW+93zEQx8T3554gRjScAO2XfPfVxcdSN7TY1tyWUB9vXJem1MKVfrCb2Bj8Z4gRX9j1JDguouptDR2AzAssT4PaBwtzV+orP521i0npyRrnyGv8I93gFe3wvB0nZazsqQ==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by DU0PR09MB8167.eurprd09.prod.outlook.com (2603:10a6:10:5a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 14:10:47 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 14:10:46 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH v6 0/7] riscv: Add support for P8700 platform on Boston board
Thread-Topic: [PATCH v6 0/7] riscv: Add support for P8700 platform on Boston
 board
Thread-Index: AQHcvfOB06iJFzr3GU6YuT14ReHoOg==
Date: Fri, 27 Mar 2026 14:10:46 +0000
Message-ID: <20260327141029.628483-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|DU0PR09MB8167:EE_
x-ms-office365-filtering-correlation-id: b464a1f4-30a8-4ead-c084-08de8c0aa46a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003; 
x-microsoft-antispam-message-info: HsW/JJXHqIZTaLpuX7lcV/dcnV/Ri5yczllHwt+fAM+GdXEF/A2ydA2yOMCs2VxeaSMC5y0KS0aDgj0eWFahplUw37LwF7ATgfG4F2eGg/RwZZGcNeGKCiDY5liQf5+DmOl0kCrsKD5PseuuY4h0AVRCh71PAXQ1gkCZn/iGpeoAymWAILrVYVqCKQrnRTPow5EcGsaBTiDblwP+Cl09Ru8N2pVpH3zf4LJUt9WwU6WqB3rR4zvAm9d6s0Nt5SGiMTGaJtZPXqOSbl7S/hPW9pGYaADEcqU6xXTfwbFO3bQ26J6BggWOZofV6CouZ4Ne8wXKvvA6JnJO2tH1MT7cnXKN0vjdhtl5hpj8LGmNZ0rPu37nt1dzD8kYFkvThlu6pVCLCKHxDX+5JtAHTF+Azevf0QDb+Q2frDDAXHOOWRvMqSgF4muFrrKA+9NwMfktmF5ls4idraGiF4mm9EhCHDMVAknRNc2MtSFb2Uisw2cMU4PFSLm14x3gLABI1+1wmuQziu2A1TrpWBYRbBhtGrAjN8ups0YHj8w74qOSOX70SdHxa2V3O+VLAQlfyYS4lv6AafQXGEmbkU/k0m1L4YviE9gPKdYK9m2yyomwfE/sJ64/ea9VpLqUzOjOufAwW1e7D+Zg7F5PHFPj1R0v/sUof8HFPRR+sFK2YXJkQIpGe00HAD8jc1nLUrsx03EfVX5vCAqiJdKhjoPARY8xuV8HW3SMCtBRRoBLaRSyjuOiAvF8MSBLd5kQeQaaJ/JHxIWfrzzk43PXdWvm64oOjdVtn6eo3C6/LLR6mmm8+Jw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4b+n7mCow1TJYwzJ7EkMUGzr0z7NU+vj8ovy3QHCbxqJA71lTmmiL6tgZQ?=
 =?iso-8859-1?Q?RYRv8EA9h4GTy47czusEzw3CzAz1vAqIXjtEHmJmwRv7aSVmtIwf/J+7Z2?=
 =?iso-8859-1?Q?p+zmZiv1PC/A6dNrCVKivvG24O0SSoqEtIqgNsg8KW1VAWTj9es/vOQffu?=
 =?iso-8859-1?Q?qVdeVN0YaFuhOPsF1kLiKhQUM92gRLySnNLhlGFRX6fjGT+ys4w+bhpmH4?=
 =?iso-8859-1?Q?gFuM3g8+Seu2f94Fh1Sy71iCuzGHNxt3+g4rNkafVq1lr5rwbOtz6DLhry?=
 =?iso-8859-1?Q?1wAVNWtcsDMuNGWsiMDuKBArHgyVUxJ5DmjSbpU9gDTiPdM2HfCmHZLs8d?=
 =?iso-8859-1?Q?B7728npxfjSSkUKKgug4hNbHoWXl4Yfh+8ejuHhuRHbX3qau+IawwnOiku?=
 =?iso-8859-1?Q?uS9W2+fWtU1coIMTP3tFKqCTDKnmAzd/wnP6F31zP6hyQYOsFveJZLfmMm?=
 =?iso-8859-1?Q?uSAVHqVR7MmgkBeGXyTNeT9fyYz4GzJIv9K0ZA0OVQj7N5TfgNZwFHmTmJ?=
 =?iso-8859-1?Q?5Lxn5WTBDGLnbPV8J20oOM72FGkOKhWaFymVFmQUkFH4n/i8S1F0iCqT/+?=
 =?iso-8859-1?Q?V5U/+t/vSXJq5C3zLONRbjFutwt/HNU9FsI/VQ3uToxfrrA3j2t35aQOeF?=
 =?iso-8859-1?Q?KVx39r32NSXDt5tSyUyk6Wfan6pbwWpLkwMUz9tPehgvwAc6db7yzTqA7X?=
 =?iso-8859-1?Q?s57PTvSXZULOw+hOIPzoX6vsuCBUD8O0deTPOWbGH2WBZOkOjZBze+4oLu?=
 =?iso-8859-1?Q?oG3PdbIMLoY3eQdIiC6wNLj/fIWccBXwfNPhg8NCSc/d213S5Aqe2FFrsM?=
 =?iso-8859-1?Q?njTL/wdMBK8TJskcJSLROqn97yWdT8Uxy+wQViZr9/j1iJnc1rA5h47VyM?=
 =?iso-8859-1?Q?BR93J8omQZoEawyRDapQ+NER9kRnaXY4vuSRa8tzFZ2bPMRemG0OyXRPbR?=
 =?iso-8859-1?Q?j2ozamPn98lG7q4Uq1ZkJFhHltDjYSxFXxCZnukEzq6PoPffSaNDx0G6fg?=
 =?iso-8859-1?Q?MYqMRuUAlxQXa0zoXzXbtf9iOtCPnn0vgltDCQ2pSIamzMM2s5PHDUU5N9?=
 =?iso-8859-1?Q?I4/dWwTyEFfwl92M1AKcFd4kjr5YEQACnXWvEmtAoBS2S5vFvRYHHO75lS?=
 =?iso-8859-1?Q?HCPjqxckZ4a3lLNNI5kWa/0IO8fyGwTA7Mxu/Ix0BYHTx2wVKRD7TIdARl?=
 =?iso-8859-1?Q?iQ5N512seruYHdgfVEOzBIW+rvZuYCAt5he4EV912TJ3YPsvOlrjYAadsT?=
 =?iso-8859-1?Q?AFZQh2YylLmMHsMwKStJ8cvrni381utEkV4WiqKMN2qY3qgmCUcBLF+wx9?=
 =?iso-8859-1?Q?MKsR7it/hn+gfx5veJUureiT0vC8h6VA5Jv+L7WfGMfiuoZABstNdg3RcG?=
 =?iso-8859-1?Q?VOH1uGlW8JkSx71uU/xYlDeySYd/h5/P6btZNwMVkIs49QD6pzNcehqEIT?=
 =?iso-8859-1?Q?1TwBVsmg1N6Y7HrquWMf+/guTeNzttoSldHUdV1VIRuNBp1sCZBSMxZj3f?=
 =?iso-8859-1?Q?KwOOSwy72fbj2dKnzXDvc0HwNO8WIsFYDuV22XwC7CBSYEcd+B+aLcWDZu?=
 =?iso-8859-1?Q?YG6uJCFjpSv9yY25oT2CNzb9e/jeKvnv50juKmFuQdD4hiFPMJM2EHVil1?=
 =?iso-8859-1?Q?pgZclE8PqbCG90Rc1Whz8T0K0q2byEQ7G0/nEjGCfOlBUl9QCOptNVB0MR?=
 =?iso-8859-1?Q?L8fEMl62Mo8hIOvEW/oBFdGRTFvcpKu1QYIojRqaDp3q5SvNUZe5GEAyuc?=
 =?iso-8859-1?Q?xXLp666emGmHlyC78LeQu1FMU7ZGBHZ3CqcLSrAtSWWu+5D0/WXeWpvyKK?=
 =?iso-8859-1?Q?ji0Hcm0fbOjns3xCcqMMltndTADhy9w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b464a1f4-30a8-4ead-c084-08de8c0aa46a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 14:10:46.8971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJTypt4poMB/dpheLDNqZrpmIiB+93nWMADYD++3HAxyClcwMQIHHokuvxV8Daze3mCSAkhZYKz1p2M/aXnFNguYnP/0ItjPmcikOzintWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB8167
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:54 +0100
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

----
Changes in v6:
- 01/07 - Fix the BOSTON_PLAT_BASE redefinition warning
- 02/07 - Update the DTS compatibles and make minor cleanup changes
- 06/07 - Replace <asm/gpio.h> with <asm-generic/gpio.h>
- Drop the libfdt memreserve alignment patch

Changes in v5:
- 01/08 - Drop p8700_platform_setup.S; move the early init logic to
          harts_early_init()
- 02/08 - Add board_early_init_r() for Boston RISC-V.
- 02/08 - Defconfig/DT: set timebase-frequency to 25MHz, enable PCIe2 node,
          and move bootargs to CONFIG_BOOTARGS
- 02/08 - Set CONFIG_PCI_BRIDGE_MEM_ALIGNMENT to avoid PCI BAR allocation
          failures seen on Boston/P8700
- 02/08 - Drop GD_FLG_COHERENT_DMA; use a platform DMA-coherency check
          instead
- 03/08 - Update eg20t-gpio driver to use the PCI API
- 05/08 - Refine the commit subject/body for the MIPS GIC syscon change
- 08/08 - Add p8700_dma_is_coherent() helper to determine whether DMA
          is coherent
- Drop 'display' command patch
- Drop the 'startharts' command patch.

Changes in v4:
- 02/10 - Use riscv_aclint_timer and update CPU timer settings
- 03/10 - Fixed inconsistent empty line usage in gpio-eg20t driver
- 08/10 - Replaced inline assembly accessors with generic macros
- Dropped AMO instructions emulation patch
- Dropped P8700-specific timer patch

Changes in v3:
- 01/12 - Split original patch into CPU/Board parts
- 02/12 - New patch: extracted board-specific logic from original 01/12
- 01/12 - Relocated object rule for p8700 into p8700-specific Makefile
- 01/12 - Explained .word usage for mcache instruction and replaced it
          with symbolic macro
- 01/12 - Replaced inline assembly lw instruction with readl()
- 01/12 - Removed p8700 code from start.S, moved to harts_early_init()
- 02/12 - Fixed operand spacing in assembly
- 02/12 - Replaced hardcoded address with properly macros
- 02/12 - Switched from riscv,isa to riscv,isa-extensions
- 02/12 - Sorted DT properties properly
=20
Changes in v2:
- 03/11 - Remove redundant pcie_xilinx_probe() and update commit
	  message accordingly.
----

Chao-ying Fu (7):
  riscv: Add initial support for P8700 SoC
  board: boston-riscv: Add initial support for P8700 Boston board
  gpio: Add GPIO driver for Intel EG20T
  pci: xilinx: Avoid writing memory base/limit for root bridge
  riscv: Add syscon driver for MIPS GIC block
  net: pch_gbe: Add PHY reset and MAC address fallback for RISC-V
  riscv: p8700: Add Coherence Manager (CM) and IOCU support

 arch/riscv/Kconfig                        |  30 +++
 arch/riscv/cpu/p8700/Kconfig              |  14 ++
 arch/riscv/cpu/p8700/Makefile             |  10 +
 arch/riscv/cpu/p8700/cache.c              |  99 ++++++++
 arch/riscv/cpu/p8700/cm-iocu.c            |  75 ++++++
 arch/riscv/cpu/p8700/cm.c                 |  92 ++++++++
 arch/riscv/cpu/p8700/cpu.c                | 105 +++++++++
 arch/riscv/cpu/p8700/dram.c               |  37 +++
 arch/riscv/cpu/p8700/p8700.c              |  14 ++
 arch/riscv/dts/Makefile                   |   1 +
 arch/riscv/dts/boston-p8700.dts           | 264 ++++++++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h    |  61 +++++
 arch/riscv/include/asm/arch-p8700/p8700.h | 133 +++++++++++
 arch/riscv/include/asm/global_data.h      |   4 +
 arch/riscv/lib/Makefile                   |   1 +
 arch/riscv/lib/mips_gic.c                 |  47 ++++
 board/mips/boston-riscv/Kconfig           |  47 ++++
 board/mips/boston-riscv/MAINTAINERS       |  11 +
 board/mips/boston-riscv/Makefile          |   9 +
 board/mips/boston-riscv/boston-lcd.h      |  20 ++
 board/mips/boston-riscv/boston-regs.h     |  42 ++++
 board/mips/boston-riscv/boston-riscv.c    |  59 +++++
 board/mips/boston-riscv/checkboard.c      |  43 ++++
 board/mips/boston-riscv/config.mk         |  15 ++
 board/mips/boston-riscv/iocu.c            | 102 +++++++++
 board/mips/boston-riscv/lowlevel_init.S   |  18 ++
 board/mips/boston-riscv/reset.c           |  15 ++
 configs/boston-p8700_defconfig            |  98 ++++++++
 drivers/clk/Kconfig                       |   2 +-
 drivers/gpio/Kconfig                      |   7 +
 drivers/gpio/Makefile                     |   1 +
 drivers/gpio/eg20t-gpio.c                 | 141 ++++++++++++
 drivers/net/pch_gbe.c                     |  37 ++-
 drivers/net/pch_gbe.h                     |   1 +
 drivers/pci/pcie_xilinx.c                 |   9 +
 include/configs/boston-riscv.h            |   9 +
 36 files changed, 1670 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/cpu/p8700/Kconfig
 create mode 100644 arch/riscv/cpu/p8700/Makefile
 create mode 100644 arch/riscv/cpu/p8700/cache.c
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/cpu/p8700/cpu.c
 create mode 100644 arch/riscv/cpu/p8700/dram.c
 create mode 100644 arch/riscv/cpu/p8700/p8700.c
 create mode 100644 arch/riscv/dts/boston-p8700.dts
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 arch/riscv/include/asm/arch-p8700/p8700.h
 create mode 100644 arch/riscv/lib/mips_gic.c
 create mode 100644 board/mips/boston-riscv/Kconfig
 create mode 100644 board/mips/boston-riscv/MAINTAINERS
 create mode 100644 board/mips/boston-riscv/Makefile
 create mode 100644 board/mips/boston-riscv/boston-lcd.h
 create mode 100644 board/mips/boston-riscv/boston-regs.h
 create mode 100644 board/mips/boston-riscv/boston-riscv.c
 create mode 100644 board/mips/boston-riscv/checkboard.c
 create mode 100644 board/mips/boston-riscv/config.mk
 create mode 100644 board/mips/boston-riscv/iocu.c
 create mode 100644 board/mips/boston-riscv/lowlevel_init.S
 create mode 100644 board/mips/boston-riscv/reset.c
 create mode 100644 configs/boston-p8700_defconfig
 create mode 100644 drivers/gpio/eg20t-gpio.c
 create mode 100644 include/configs/boston-riscv.h

--=20
2.34.1
