Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175DFC5B56A
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 12:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE177607D0;
	Tue, 11 Aug 2026 12:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhhZDvTyIRb3; Tue, 11 Aug 2026 12:03:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 927F36065A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786449798;
	bh=fW71jAKmJ0uh1BjJKE/+TgvZe3sEXU3ZMjue2cpvem8=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0EbpNUlv6x3b01N+1nrnqYYVgF1GmKgXg7PEdCNSDAVBKRUSvs/W4u2BXja/b7tep
	 LBgZG8TXnVC96nyqZxmuPQcKOes1T7ARFyT7kysmLS+PlqYPjjamOspxS8xywLy3x7
	 /f/TN2IRH8QwReaHhdmMvQN2e6mRkbxq5ptJJxGVYDvD0WTAcw341V83B69MXeTg4d
	 b59NvFYfvwJ34JHC/5oZt/7rGFBpukSHo/S7FUdW1E9IwquAUbzT5tDfrNwaRQzNlv
	 MtJ08JrYoy8/b0fDTcbolCitHk7RQSeTg3AA2G+oTswbSNLUtI/QEcKMFMspF0YWAX
	 Nx9D9yc+zW/Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 927F36065A;
	Tue, 11 Aug 2026 12:03:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 93253345
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81E0E6065A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pH60dUt8aVxO for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 12:03:16 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 342D7605FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 342D7605FD
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 342D7605FD
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:03:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+t7IPpg5W53Q1bV2m/unAkqL9/RJvDyxbXbk8/c5sbcSvflY4n3Z2wUoAHvcvBp5gnop2NEyyzB4/KGeOzP1lqRSj8FCepSmOT1hTdhhXYybKEovkT3IXA6XLnRksoBv/yC37O0KiZW8Wt56FKBZiMTiWlYFHRIGx3O9taHorgf0O6eHVH4ACuldy0eL6YGqVnoLE5UoO2qzDY+Aq19ec7IF+bs523V4DHNfhK274fDGMXZd88qvDSFVddgi9hCIaQH75jgoSaXjCFRKl4gb9vPnC5n/Pp6xHOMR9oMZkMAXVnRzk6+T6SyJ97HB42Edw2mal/zTCxsNqJ3smsC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW71jAKmJ0uh1BjJKE/+TgvZe3sEXU3ZMjue2cpvem8=;
 b=b3CDo0mdP0/dVgDH7UoXDjf/IUgwKnNscwNtaXvfZYBCFAMtuT+8mosCfdiiPrZPMqFp9OyFdaZZDOlupA8B8LJAAT2YqxDERIOLwPVkWpGqFxw5Tc/APkpTcpXfYNBeGYQplPowOSjgw/dG/lI5oDY3x9kyCaa3yP6hAwDoh1ERZyb5I2taeIVIqMxl4WY5dh78bKhHZojDflM8eu3rYTr4gzrpDoq/FCIO9FcZN8AcGWfj5BLkZKNwQUwucqKb1c/82DcHd6Zq78jpNlEafRMldeUW5GkxlbsiZ0EG+KhQX/9Tk/EYZm1h1kypP7Ysg1q+S4s7BrFpBmnHoLrEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM0PR04MB11856.eurprd04.prod.outlook.com (2603:10a6:20b:6ff::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 12:03:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 12:03:08 +0000
Date: Tue, 11 Aug 2026 20:01:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: pbiel7@gmail.com, u-kumar1@ti.com, bhimesh.matsa@gmail.com,
 vjardin@free.fr, michal.simek@amd.com, u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull fsl-qoriq-for-2026.10-rc3 for main
Message-ID: <ansPDn7F7PWS6vbV@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM0PR04MB11856:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b5cae2-9491-474e-3fce-08def7a08223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|366016|1800799024|376014|10067099003|11063799006|3023799007|56012099006|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info: WWZ4EQxozrhllwYXjxVrOHS6IqRM3mDHZe5TM48D4bx9vIx3kNeUVymmfdX56FAvkQUtCi2pAodgAmxoRJfzdi9TRFOfYFt+Nph6Hqjtiuh4tXAfhdkQRAka0/jnex2uuDr2TtDcC93Ym7B3zQ2CuRdBm6HgZhZVzA346bE5Zew5s0+gT589QXcgOuWmwXLZStafx8PHtNRaSHgFamgkPV5XaPMG7CEeXI+DjWmi6xrbt9IwF/lM6CvteeEf/5xSz0xId0Mxttrd+qBi8uEE0uyaPXgw13IIqoBNNnYg85+//4pxRAV79MmIIT/Om3egh/hHYN+k/sRY3018qi0/vtiYeSMWF32drhbetE3dORMrV5jeAHMaRpSJuhswSIYDVh2w+JSlqWSDYiWepuTBvJVxdgId9+y/DOhYrVIJOVGYTb9ttZyYegyD7KWvG0cKdN6FrggwOvoowUn6SOiAcmXRJrK3HhTaXtCmmpiMnzRHHPI2dDMxoMY2LTNtQbdxyqT4dJLPovZZz4vPz6RTaMNvh1GOcuWEboyz9FY5GdnABEC9hDZlPUsTgfjmP3MzWLKXcMtB+MM8xgY5+tD0u3jyvommrNQO0mvk7WskVgQJO4xE1V+XsP9F9NMRCu0uY4+KguxiUNtQnBzA6MSW3TigIvTNiJTe6Upcw2J8J08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(3023799007)(56012099006)(18002099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kTwfys6L0+j9S5eGKeRB77uFXfFSpnusXdu8ZQeKHpNotpSlV5T+2LdTbeD/?=
 =?us-ascii?Q?rCxYErujRxlwoFX57lS0E7B2kVujWoQWlKei78BnD81n4Qvet9gIj/kTeauo?=
 =?us-ascii?Q?fnCvD1SLlulA7LOS6Toy5+PKilwthFYf/pmkOZ4pi+tcY5FrIqfxBhi6Fesa?=
 =?us-ascii?Q?BlKUee6XTbTkqYdE/BuHuYzNnf+IeZdVsGbiLvjF3oN4VsWcznPpSsdW1g9K?=
 =?us-ascii?Q?ogu4cLcwp+rfcBnUwILg4tYpvZp0x+aDABztln8k1AA4Z6aZ1HOeEZHOGfvn?=
 =?us-ascii?Q?bRVFs8iaIrLFZ8ivxGdO+BEe9ads0YW1ZQyv4PNzkxpWutuNHdDRUVRczVrE?=
 =?us-ascii?Q?RLo+sF/JEWwYgq0n0t+P+Z2MAYhJMxIgU2AgG2tlPikN6CmdvhiuSsqmzoVB?=
 =?us-ascii?Q?Q8Kz+dKkmYZencxCRN7Zf4/9TA//+Tgs1WFm53LMqToVcxErp6r8oUAxGuNT?=
 =?us-ascii?Q?C0OT7DTm7fCMnQedoPOdUn7pjtOYpi69UxU+EFh2+Md6FGU0mN6/OEZXvBy8?=
 =?us-ascii?Q?pQyeRrQbXwRt9ksjOkXJDv5hJQCo7bPx2rAKhbn+j+S975qbJsqwGo3kV7Cd?=
 =?us-ascii?Q?xPeufS0UZt8yJtx+3P1wtDDLewnKPE8SHjHYgvK+fa+AzIDAHYjKfHE59ex8?=
 =?us-ascii?Q?bATppIpEIZywKVKj2jCG30dbCDJezEzztX/zRjsQbqdUP39g1I8M7ST0WR4O?=
 =?us-ascii?Q?+zh/uqwe94wvAMNxj7CAHCQsHqmDMoI1oqbTFuKjBnGwc+LiiAv5jkPS8L14?=
 =?us-ascii?Q?XxTqqaRsQqWfXESEAKFvydJ7o/lWPGjxhJ/gwBJxvK2BAdi1Ox3KN2UOcWHS?=
 =?us-ascii?Q?joAiU9FWg08FqzzNv3mjrBB1MbojzaRnGSETJnzWV1r5swV+GZ21zC3Rzm5i?=
 =?us-ascii?Q?GXPx4IsWslcvRap6su1wzJHYD/aqsF1e4LAcOZA4OIBuxuCFyQyRMnORdPyw?=
 =?us-ascii?Q?hi/V1x/HrVkJZXqs4ME5r1H3yTYwd8mJy6gylKkuCNAphTlyqBhCmFjia/4q?=
 =?us-ascii?Q?4dXGdlpH38z1zvk1EiTQ6kyHgjD/zH/WhFA4oMQhW0hfHYoKTlIhUTa6EEaW?=
 =?us-ascii?Q?Gbsx7XrYWjGswkoAzJNhIXdIhdq0yAe/Z2Cz8srT5nCfGO6l3lGyXtgPV7T1?=
 =?us-ascii?Q?DsbsOuI3fzp9yo+sLMeg2rMv6q5TrVYy1MRccR1O63sUtbd2a1C9YbuMgcW8?=
 =?us-ascii?Q?Depf4J90UEX0WYBQWYAaKt3rVFTbMxWA6Dfg4rOgCpjLo1ExuSB8/f/5CpA+?=
 =?us-ascii?Q?RxEcT6tLc17Wr0cnUUULn72je79D8PqcijK5yUp7lnseZK78A9p+znL/FISR?=
 =?us-ascii?Q?rwfUuMxQazUxIydH4xvtRf4aYRXWBSB+rXAtfU8KjZaBKHqPfum05JdLEvLW?=
 =?us-ascii?Q?WLIWqoxeqDN7T+mwk2LC2FUS33TViMaO8uxbHJMy+8ez9TVI09FJJ11uuOxF?=
 =?us-ascii?Q?+qVWpFgptQ4f0MqkYNFbnHop6cLU1j4cL79TXD04FUKEy/meTtPSyPcZPPMO?=
 =?us-ascii?Q?yvzrHcncWYMzNwQUAxTaRRJ2RkYFDG6iYdlE0b9M+/Caou0AI0SBClJQ58T/?=
 =?us-ascii?Q?P20QyfuB+zTer/rUXsa6uDR49jbtROA+gEcyArPGt/huFZXjhYLlts92qmxy?=
 =?us-ascii?Q?yAt55fwnfw8E5GQIvLqikKUasAm2rRh5aDxZbaZyZQeDHCjsHEPPEOj9rNH+?=
 =?us-ascii?Q?OUvcUt4W4YjW/RVZQAG/t4+Bbtm1lyfGqwFMaeT3ykYKvTz31lp2n1cY3q3h?=
 =?us-ascii?Q?LsH1TYfW16E3TF+KA0BHt/lw/pEfe840nyScVQsr/2MYuj+0nCMI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b5cae2-9491-474e-3fce-08def7a08223
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 12:03:08.5690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRJTFuXrd02KYySfPzltY4tggfzuH40E/rA6SCMcfw7XtDjIfSnZBBiwRN3AAdhi9dRSqI5pZn/eWoF0ZJvo0h3KsI2XsgWh5kUwKFmv0KzntyxDciZpSJHB6RJKp5T5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11856
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW71jAKmJ0uh1BjJKE/+TgvZe3sEXU3ZMjue2cpvem8=;
 b=v83oP2EGsX6PFZH7+dcOfw83K5vADNg5RCVFd+VMRdVfirVv7Sv1KKfuH1RSocvTPjV9K4ROILgUEQcL/bKiBGCUkp8/B6pUo1qtxgrA8Evs7/GD+iEbomWFW5wHiKHri9ufiC5NG5Vt28uRSwQ4lRuHhxxwq26lI7CJXqXFW7+szXwIYYJV6QE/5ds4y6QM8yTvIwJ1TWrzgvbVTSIO5OQxzB8IVoiFQTa1+gis8EeJQ+6ReSHawaC0ncfYgVg75AZ+oQS6hW5c2M4eO2ashRXHMNWW1bDkWdMJOjCM0HpG4J1V1RgwDUrp7AiB2y0eAVyHNcSm7qnv7A/deYwxEw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=v83oP2EG
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

Please pull fsl-qoriq-for-2026.10-rc3 for main

---------------------------------------------------------
- Add support for vendor protocol IDs 0x81 for SCMI
- Fix LDO selector boundaries and make the driver fail gracefully when the
- regulators DT node is absent for TPS65219 PMIC/Regulator: 
- Fix a hotplug issue with pci_iommu_extra on Layerscape platforms for
  PCIe Layerscape.
- Fix a GIC LPI table corruption on LS1028A boards with 2 GiB of RAM caused
  by an unbounded TF-A DRAM bank loop and an integer underflow when
  gd->arch.resv_ram is inadvertently left at zero due to empty DRAM banks.
- Also includes a minor DT cosmetic cleanup.
---------------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/946

CI 1hr timeout, I ran build in my local host and pass.

Thanks
Peng

The following changes since commit 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5:

  Prepare v2026.10-rc2 (2026-08-10 16:43:34 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2026.10-rc3

for you to fetch changes up to 5a32ebc96295795a7325d6cbaa2d8b0bdfaa6d75:

  armv8: layerscape: Fix TF-A DRAM reservation with empty banks (2026-08-11 16:05:24 +0800)

----------------------------------------------------------------
Kumara Bhimeswararao Matsa (2):
      power: pmic: tps65219: fail if regulators node is missing
      power: regulator: tps65219: Fix LDO selector boundaries

Michal Simek (2):
      cmd: scmi: Show names for vendor protocols 0x80 and 0x82
      firmware: scmi: Support probe vendor ID 0x81

Patryk Biel (1):
      armv8: layerscape: Fix TF-A DRAM reservation with empty banks

Udit Kumar (1):
      scmi: pinctrl: Rename SCMI_PIN_DEFUALT to SCMI_PIN_DEFAULT

Vincent Jardin (2):
      arm: dts: layerscape: drop leading zeros from unit addresses
      pci: layerscape: fix pci_iommu_extra hotplug

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c            | 33 ++++++++++++++--------
 arch/arm/cpu/armv8/fsl-layerscape/soc.c            |  5 ++++
 .../dts/fsl-ls1028a-qds-x5xx-sch-28021-LBRW.dtsi   |  8 +++---
 arch/arm/dts/fsl-ls1028a-qds.dtsi                  |  2 +-
 arch/arm/dts/fsl-ls1088a-qds.dtsi                  |  2 +-
 arch/arm/dts/fsl-lx2160a-qds.dtsi                  |  4 +--
 arch/arm/dts/fsl-sch-28021.dtsi                    |  8 +++---
 cmd/scmi.c                                         |  3 ++
 drivers/firmware/scmi/Kconfig                      |  3 ++
 drivers/firmware/scmi/scmi_agent-uclass.c          | 10 +++++++
 drivers/pci/pcie_layerscape_fixup.c                |  5 ++++
 drivers/power/pmic/tps65219.c                      |  1 +
 include/power/tps65219.h                           |  6 ++--
 include/scmi_agent-uclass.h                        |  3 ++
 include/scmi_protocols.h                           |  3 +-
 15 files changed, 69 insertions(+), 27 deletions(-)
