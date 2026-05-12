Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6B9CD4857
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 06:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D452280398;
	Tue, 12 May 2026 08:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="osS8fbEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B916683015; Tue, 12 May 2026 08:50:20 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD2C801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 08:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQxSmtqK1Jel2SvMdQ1vjT/2FI0mLvgLCLPcHltiMO4gkH4kXAB+NZc1pcaBr3yHWgcX8fJgckoL4ubyGxUrMXKKNr/PiICoBf8qiGWvWTl6ukPmXPRuUCCvg8NmNEiLVbeColhoV/A+WydbRCvoQzChKgVchlBr9wtXGd/EVa8BeIfRcEZpKcYB/208aND51fjfBxHHtiYbENrLSMkARsggiyvjoaj1fbO20L0YCJJkB0W709mNvObVGc0xihlHLn0/OCKyF2PeFgAicx1BjGoX7ZSOsBQqAxmSK8wDQ+UDfvc3s6n8EVZSrRr8zdfNkPrhwqzAXbI0rKCjDMYt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+6724VRUgthZE6ZdeGVOLwFy769PST8kz6o6FdA6kk=;
 b=mNTH9dPowzQinZptcGQqoE7m+GeSpaCdxcdErd735QNGKEbTx6MwDRyMX2jxREPxfJzg64RLKu1jsS6ZLYGlkBpIYwcGu4IPeHWBS06HOERZ0GoKxzgBy0Ha3LxdQpl0iXbjCqH/CYE6G+xIjwd2aTk1/ztX0KmQpfl6cXYv0ECJzx3ZhAV5MP5ukpAa0mB1cz0e+G/Jbd0yw0uPmH0zFHJ96L42a4lmzceTU7EZtf/oVA7rMjd7e59dnxmjBj1JpOB7wSKMj/1pJmDFG1qcJ8qE/lmauCm8M5NFYRlw625qRSEpjZ7J/lbszIF84dJhJm/uV5m/PDwRL+bleW/x0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+6724VRUgthZE6ZdeGVOLwFy769PST8kz6o6FdA6kk=;
 b=osS8fbEtfeUc+v0i1c2lROuYsW8tg0/axRZJ8u76V4GEgRLCilLgh6stmKrH1ZOv4jgdkv64vZF9kxYYZU6I6+OAKai8RvYS3r3UYyh1UR45Fi/zcOPJXSlqWGZY0Xi3w+5y5tom6llc+2OBdMSZI8DZSlwluwpqVTQAc0qecWp7YINfJwF50D/ucN/MkEn7YXk6y+HhBu6/z+RO0ntj2FSPv/GA69fnDcbwoqL+pRhCO30/ckN6ZAeukc3xZS7bf7ZD451dmYLSuKMTLgLrJ7KoYpLroGZfPer23HU/bUmMPvoOrTxipFo1awS8Gdmj/vwdnFlGoas3zsshVrZWgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH4PR03MB7697.namprd03.prod.outlook.com (2603:10b6:610:237::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 06:50:14 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 06:50:14 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v3 0/3] SoCFPGA: Update DDR Support for Gen5/Arria10 in U-Boot
Date: Tue, 12 May 2026 14:49:54 +0800
Message-ID: <20260512064957.32497-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH4PR03MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 79078d43-6ae0-4bea-d3b4-08deaff2b805
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|55112099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: Yn+vDxR5oaDhOhx/WkwOlyiwHxa8RsiE6Rk88+25v+8XhHHr69bgs15qnh+2rxjAjwQxiIXVHkXZGR4H0iw0OaS+iYB6IsvGkX7sJ8n372p4pnPXGKjfLGB3xKkAm0RAu04vnn9MdLruWsTR9u0X0erJ5rL4ubDg1enq96wFs0X0l/BdrOoHv0Y0EIBTEv5YdxK7v9pGsQ5QKFdhIZDvGdUDTQxh2ZVF4SvgrgLYSqX1Uj7SOkwPS/34BtzcefhWoCx4z7nz7cMMo2zhYFTjEQPPGv7o6xZiDIN3x/HCRM16QTV/LPuYTGlFOY6eHEtX34DcskpX84Yj4sQ6rMNS1lNvRV+3+d0yEJk4bl7xCvOWJfA67GD+lRU0PgmdbaucBmIIwkDrtmhGc7drLFkpiqOAfYIgPj4T1xpwEz0WN5MWiYK6RXxpj3YPmq8rW5hUQIG0raAIkLxHhnpuBcy+44rL+B2bZhIiIZNRbObaWqK0wL5ITduOgEcIsvokgWJ5qw0+dHzH/LhQ76lKonHnnOSLxDcoZtGwrGliXOs5dQKZb4MsYWuzzYctcCf1r5fdQ2ponbb/V0hAqHYwgjpvE3bcaDdsUqWq/8k4u1WaDFXi+ATmTsNOUxe/AcsOUmLxlxXJ+wkFaJQOGeq9jtHPXsAORjYM1L7gXG1P5Em6oYtNUaXTUyqWZp1/Sp/hL6GM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(55112099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2WvmpIzqA8/gB4jhs/WJmE1Qk/yKWFJ8pjlIfYk8WgPS8/wyZhvdKJjhChbx?=
 =?us-ascii?Q?4aTIvafGh2PlYEsMK7nrkv1w0+oO/I63plu+0+7Ad0eh0hT5whn4y6lfemF9?=
 =?us-ascii?Q?lx0Pbz6UAspgTYN9lNfb3o7X78CLnkRFtf4jNN6gyZha00+DIX3TRGRWpbZM?=
 =?us-ascii?Q?8vMlQNgQfl7oJ9ONBHI+dmnj7812bTagKhXQ2ieQJGCus6cdB/FGhBPJkYtf?=
 =?us-ascii?Q?6irtMoZE4pM6KSDp4s+7SLXZ4yWj5Iag/RTHrmC5xuNh61HAsf4GqEOEE1na?=
 =?us-ascii?Q?CE8QNRLFcZiDrzEF9AqxnhsfTmosBVbDLG/7feFEW7rXK7swwOUTQca8yFJA?=
 =?us-ascii?Q?Wp9NapCAbwEVEBnFh39Pac+JT5zLyUd0jYJRAltwwyG/rZRMvE0BSKDvgFoj?=
 =?us-ascii?Q?7PiSZD9LXSMoW3ZsQhTbzu30HfPXMx+IJ3UFPARzXUkuhlAB+wclbvb+Em1e?=
 =?us-ascii?Q?SPR80fegcENl4Z5VBKmg/Z/4td4KJE60hfOTnBob1ffDv26TCweIm0l+Oy4T?=
 =?us-ascii?Q?sdfpUo6gFM+yygqwGa2qsHyvKl7Idzr9Y9NbAtyZbehDkq5sOkC+UsXTj8CU?=
 =?us-ascii?Q?qsEA9CSXCSV1kAd1VJhcr6gNetZ2ueED2HKlXrgNsNCF0oke9wwrNVw9RyUT?=
 =?us-ascii?Q?MGuIzXO1oYlqRRLce2XGNXAGIObG7s8xJyBBCt2WExzChJEzXV6/ydWQn/tk?=
 =?us-ascii?Q?QqjXkBSBytxJkD6bz8LIGTYtcsd5pPygSjqlFsVF4X0o8JcYO4Ca0riXF32R?=
 =?us-ascii?Q?dLt4zJ6ya/9UWSf4s1sazZkkqpZ6Oq/s6HVu3H44hZddX8gYvcdjAujSBz3n?=
 =?us-ascii?Q?DUqZ2RrAfgHH/EWWGcVc19qvnK8RvtPbvFy9iZxvH3b0izTavTKoa3ydrHri?=
 =?us-ascii?Q?b4ckhjFGlj8kmkxXXc5yN92dl+ge5bNsfrOHqMMvLTpF6vRl8Dd5EdMGFsfm?=
 =?us-ascii?Q?6w25tlzt5upZLbr78UEHJcUSOH3MDvtyFMnnzQe932/U97vC2z3eW5qvklR3?=
 =?us-ascii?Q?SkOYRb4+r183I3dEYD8mM/WN+f1l0DYyv0l+W31y4kvkORaqAXtsLqxx0jgR?=
 =?us-ascii?Q?63pg6EewdhbBUi4J6yibFcs0utaXCh4fsUjpOTkzb/Dv94dAnGJPZ2Oq6KE8?=
 =?us-ascii?Q?hJQXJPhvHvL2D/VHJHapOAjqJ1lMCLbsalHVwyUk7ofsL7t7YoVvVVuj5Otu?=
 =?us-ascii?Q?RQek2uWqacL+bVgSG615YRLHuspW1xzLVa4tjYS0EXKLUg5WoKgVbhYQDMHh?=
 =?us-ascii?Q?w90G7c6u1vxctI3rLqK7htVnXWE0foubBfzlr6ZI/8sehwMLD/4EYRnTyp/x?=
 =?us-ascii?Q?vR38VxExQefrBbE4T0TyxkP8IXTIL1hdp6gGPqRlPPPdPDH59qOawUlYNoRK?=
 =?us-ascii?Q?NFsXDTtycWQcR5rcQckxnzrngUO5E40ZS32OKm32EEKQj62U4qvQkKght3nC?=
 =?us-ascii?Q?vqLui2cCk+hCEUdigY+JZiUB/x55akvwcbx6CQR++yPrJZNSjdIkz9+cDPn6?=
 =?us-ascii?Q?7tohqrGyT/ZiNrFKmzzLsJNhuf82Ip/9ebfjl73i5sRNaRSL/ViCNL+qnyOs?=
 =?us-ascii?Q?9JIqJEjJoQFgydiR3YnXsVLMm6XbRcyEUw/qGnb4JyrupAhzk8e1aYVZDbb0?=
 =?us-ascii?Q?cIAvmReSW6bBdDiuxzAgH8z6zATGxBANY7j05/j/pRO6atQ1z9mFMEZOqmXl?=
 =?us-ascii?Q?ihG35INe4L3MYD6PuMsBvWUKnsliEVoSASCDYFl4TIIH9eodnFI4hzDVfRyU?=
 =?us-ascii?Q?rU91LovhXemDn3O6JE9BSCm+caouIDw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79078d43-6ae0-4bea-d3b4-08deaff2b805
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 06:50:14.1646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dkm54BRlWJhkgccbAfzSeSHjRFBKRwKqxsSnwR4/ZkYkGMS7f/RMXMyQhPZOS7Wu4E2Dfom6/OgIj3H3LEOBOfzflI2GDr6telDPQ69U+XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7697
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria10 platform in U-Boot. The changes include:
        1. Update MMU/dcache setup across Gen5/Arria10 using common driver
        2. Add ECC scrubbing support for Gen5/Arria10
        3. Add DRAM size checking for Gen5/Arria10

This patch set has been tested on CycloneV devkit with SDMMC boot and RAM boot (TFTP & ARM DS debugger).
Tested on Arria10 devkit with RAM boot as well

Changes in v3:
- Removed 'select SPL_CACHE if SPL' Kconfig guard from this patch and
  applied this condition alongside SOCFPGA_ECC_SUPPORT on patch 3
- Move the bdata declaration and gd->bd = &bdata assignment from spl_gen5.c
  in patch 3 into this patch, making this patch self-contained
- Updated commit message
- Removed legacy HW watchdog check in favor of current WDT DM for Gen5/Arria10
- Dead code cleanups, indentation fixes

Changes in v2:
- Shared dram_bank_mmu_setup() is set as optional via Kconfig and defaulted
  on only for the reference Arria10/CycloneV boards to avoid SPL overflows
  on size-limited Gen5 defconfigs.
- DRAM size checking is set as optional via Kconfig and defaulted on only
  for the reference Arria10/CycloneV boards to avoid SPL overflows on
  size-limited Gen5 defconfigs.
- ECC scrubbing is set as optional via Kconfig and defaulted on only for
  the reference Arria10/CycloneV boards to avoid SPL overflows on
  size-limited Gen5 defconfigs.

Alif Zakuan Yuslaimi (3):
  arm: socfpga: Consolidate dram_bank_mmu_setup()
  ddr: altera: gen5: Add DRAM size checking
  ddr: socfpga: Implement ECC DRAM scrubbing support for both
    Gen5/Arria10

 arch/arm/mach-socfpga/Kconfig        | 21 +++++++
 arch/arm/mach-socfpga/misc.c         | 31 ++++++++++
 arch/arm/mach-socfpga/misc_arria10.c | 26 ---------
 arch/arm/mach-socfpga/spl_a10.c      | 11 +---
 arch/arm/mach-socfpga/spl_gen5.c     | 17 ++++++
 drivers/ddr/altera/Makefile          |  4 +-
 drivers/ddr/altera/sdram_arria10.c   | 31 ++++------
 drivers/ddr/altera/sdram_gen5.c      | 62 +++++++++++++++++++-
 drivers/ddr/altera/sdram_soc32.c     | 85 ++++++++++++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h     | 15 +++++
 10 files changed, 246 insertions(+), 57 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

-- 
2.43.7

base-commit: ae8987f4e690f397f507c4b1efabd68b3ed08db6
branch: master_soc32_dram_mmu_setup_v3
