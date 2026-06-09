Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA3FCD8C85
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E7F7841C2;
	Tue,  9 Jun 2026 09:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UsAa4C6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A72838BB; Tue,  9 Jun 2026 09:19:18 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B65880087
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsSj7050ZTxvYPT7SR5W1ZlbSYuVGvdX1FJMzTl17jW3/GTRJchuTZEV+uopCUvo1U0Tt2tNJMcIF1RxiLqP6i1YFfaLuPh4y/81v/P9Ae4UjQ5vvR4GOU//jt83jAPE2vsGtchQPQMzc4O6G6mHXKMGuROiNz+D2rwY9J4nooHFZsh5ScMqc4zzTkXjyGirvnS6yTGRIA2E1IehlNaKwuw1LD7mZF7jk4jsOkmDeT/ngn2CwmsGVgqCvthgIwEUUOSon9duQKlr4aN4dSjmqzl3T3qchXursT/oOqhx5xseVzJ+gKrJztRdDyNazN24UENnmlD2eXAfRGJbD8KpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGLEbvp/UsXFyLndE2V+2yAEUJMHCENJY27xwvga6As=;
 b=c2ixRpbvh89wleWf9CDwWZ/Fh9toDiE2SXBJsADDo/YGUknWxmwV/2HStgxMhdIF0H5dXSbY06wjSyrJaXKIX8NdkNTOBKdaBOLP+FzGQAxhpVfRjoeQVCufSsoet++7JjprHDzKLLmZvhuvG3CY45xNJRlTHCP5vhC0HW2dduJx146dI2QnONRd6wtY/z0tSqtzFnmynMeYfYYqA4ykErXkrOOM0zjCeWWdVXjqZhjiMdXS1MnwNsXiLczOlAEgjLEMmStrbiZSyNK+JTyrROlAboq128JPQGnPA6UjMw72Z7nB4Q/AmZL4ek/STf8zpwQC2u/cJBL/2+r6gHliHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGLEbvp/UsXFyLndE2V+2yAEUJMHCENJY27xwvga6As=;
 b=UsAa4C6PDiB/6b0utNTRebHOsrqwjBR+qMTXtpyjgGZuwOGB2qdXoAj9Q99Bh/pSysLNuYbDCq1AmmS2STMHVCQhmilNxEdwuroqHrDWog9iqNTtS31VGUt/OETedUxqn1LcClknCvsZ/QL660iNs8p14tD9jouwIHyQrSiznJVr37EtWygrZNT6iiX7cCvXEFwK+DjOMiy9t4DRvo0X24gIoVYXUDTzW9h/AU2WOrulUJUg8WQn4a9zs7xUE3eYGCkrQ2CBIi6+Fi1oUzWgGM0HIcNh+z8C815nIhQzOfgCCU3+PkSSvwuM1MHoz9Z3ah6o5ryLLoeztPDwasfXaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI2PR04MB11148.eurprd04.prod.outlook.com (2603:10a6:800:293::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:12 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 00/13] imx: Use livetree API and cleanup
Date: Tue, 09 Jun 2026 16:36:17 +0800
Message-Id: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIHQJ2oC/0XMQQrDIBCF4auEWdeihhbtqvcoWchkbGahCVrEE
 rx7baB0+T8e3w6ZElOG27BDosKZ19hDnwbAxcUnCZ57g5b6Ki9aCQ5VBM4o1GxGZ9GTRIJ+3xJ
 5rgf1mHovnF9reh9yUd/1h4x/pCghhTbWoCV01pt7rNsZ1wBTa+0Dj6r3wp4AAAA=
X-Change-ID: 20260521-imx-misc-1d83a9cfe0ce
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI2PR04MB11148:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9b3893-6593-4b7a-fe84-08dec5f767ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|6133799003|18002099003|38350700014|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 08IzI3EpHvsJNqhRs3UC1Bd4SgF0VP+Cvlgx9eayIJya37WJCgdIlCORKmmG0EJsWytxXH8GWejStAZ7Y/w5wn6hOQAeY4R/NTDmR6CV+2EAIdyt3WASVdm4QXQwkKeoxA5naR7+3YokSoLjf4Hlo04jSii8vD5a7B5tj1n1A95wpkH1oLb/UC8Lt+kEhul0tjbvA6azyYiDn8yGKcOym7K6nQtoJb4KfYhYxgnIsg3puB4PBQ0cvy/4AGzfXFSPAjncx3IyLyJhFeOEDaP+9WZlaSbeVYwf+F0NgQ8oIT5KVSeUcSEqAB9WHwrrauxmr4UFsxyfaCvzHgK8TtAK1T0lRiQufVRGQ0AfWAs35qPQG7jMlhHtxTTVfJg44sDuHTNt+Gzbqsp7pzPZxTD27FmYXAcxeitEX7BrmiuYLYCtswHVTnRTaYz8jwrswUuW0aE2wCm4xAljcQqOgRv1vLXcOQq+MSt8qjDaOiABs/qwBeM/idFAwoKPvYnu56wF2nC1ZdrfKRXqW++3JVx7bv38zFt1Wp/JkzHFIsNHoItShTblAJ6+dZAp7N3nqFRmukLEL8e3BrdzmSbLrXEgjJvJ8+c8gE6v6DuKhsRPJRa0zecI4kij2uDoR8QWUYZ/31hOUy4MwnTFLPMdtofA1qTI4gW1PS1pylv6jAFbK+B2iwDtXiFSZQtOkq4nGf+FWr6G79xYp/68aL2IeVLg8+U5+IjTOBqwWXCi+eTpgEGhRo1IO0f7l7z6QqT6c+h8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(6133799003)(18002099003)(38350700014)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkp3MnV2ay9jbzhjdGd6VkJzVFZuWDJRUEMxbHBZMnpGS29EQ0ZyRWJRRGF3?=
 =?utf-8?B?MkdHOVBIc0w3VGl1OVlLMjVnanBLTjdrcEdTVDQrajVTS0VkZEpSaEh6SUdV?=
 =?utf-8?B?a212RS80NHBzQUVzWnltcUdib01Cb0FUQnVOY0QxMmRPd1lDV3hPTlRDTFVJ?=
 =?utf-8?B?aUVzUEduOWpHeEcwNWUvY1daQ3N6Q3RkNWZ1ZXdhZXlaOU1Ld085d05hLzFa?=
 =?utf-8?B?QW5GQUlvSHZraVdMNnRiWXBWN2t0TnY1TWdLZldraXlXSmtKcnVlb0d5UFFo?=
 =?utf-8?B?dXcvTHZzZDZuYXdVdDhUeFBJTCtSeTYxMHZhU3oxK0RZdklETXpTRzduVXQ4?=
 =?utf-8?B?eGJnWDVmNjFBT09zNndKbCtIa2Z5U2Y5Z2g3SzY4dEozME9lNVZwWGlncExM?=
 =?utf-8?B?djdJY1d5NUhZd3lzbzlqUkd5dGcxWEFRQUUzTkZ3bmFPQ0ZNQ010cG9YRlA4?=
 =?utf-8?B?SStacEdCTzFNNUNkNnRxVCtIdEVBWXdaQ1pHeDFWQng2aU1ub3djS1JQOHpC?=
 =?utf-8?B?RmxVMnBqb04zSW9naG83bzIrZlZ0eFZPOVI1RnBSdW1Edkw3ejhYZUhmTm9t?=
 =?utf-8?B?RVNleVlzZjlXNTJJOXh3NVcrRUxTNjlxODBFRTNBVlpmOTBoZEdTNkZCUE1L?=
 =?utf-8?B?WFFDNHRrUU0zRXVaOCtNMzZKOGEvUU8wRzI0TXpzVmRFd09lYXZjZzNlUnY5?=
 =?utf-8?B?NW94RXZXTHNZRWJjM1ZVTmQxMVZ2S01wZVdTYXhBT3JQRHN0bUtRZ2NIYVVw?=
 =?utf-8?B?VWFPWGFEU1lpd2NvQWZlblJGWkhRbldBRzlwYWkxd1ZRWW51R004S3BtUms2?=
 =?utf-8?B?SGhvUlFvU2o5MG9uYzNMSlg1Zm1LOStVSml5NkIxSkFZRzcrVFhtMU5VamNp?=
 =?utf-8?B?QjVhV0VCbThLZVNvUm13TERTTnVOQllNODY1Ukc4ekVEelJocTJJK3NOMEJI?=
 =?utf-8?B?VHB0OUZmWFZOODFGUTVWTXBvZkVteXZDZUdGY3VIQmJ4S2swYndIaHlqYkpZ?=
 =?utf-8?B?QjVUVndTaCtpREVBdUVtODM4VktWOWJrQ2VIc1VCZ1R3SlZRcDVEUGQrSzdJ?=
 =?utf-8?B?dURyRmpKSXNwbHQxbDNmdGJxYnhtMGFhZW5hSURmdFR1YXdZeDA2SGxGOCtB?=
 =?utf-8?B?NDI5OUYrb3VsT0FOZmdYRng0YzYwTkF4aE9PTDNUQ2MvSGsxVE1FQ0xhclJt?=
 =?utf-8?B?aGtWN2lYZjFobk82b25vYjJNTVhub0hmRG1OMVMweFpTa3dmSmsrN3F3WFJN?=
 =?utf-8?B?dEFFbURCVURmNi9YL0NpaWdZN2JqVW5YQXhaSUs1MkJyQUo5aHpEMXdFMjNm?=
 =?utf-8?B?cGRsTXF4dlpMVTByVkh0VEtyTUF0dFNyMkpncnRzT2paNDZySEZwNThlV3JP?=
 =?utf-8?B?Vm1RcFVZYzBReUowbGtsaUptNGJnQXpkcXh0dnpqMms1T3Z3S2NuYm1CcDlO?=
 =?utf-8?B?S0hmaEJLdU9uRzVSZUcvTEQxbS8rb1I1OEY5L3BLR25GcTZQbFFSUjg3Qmw4?=
 =?utf-8?B?Tk1EVnlBTXJKczRzUUc5ODJMaUIrRm1MQ2orVW5nZ25pemt2SHg1czhBWjl5?=
 =?utf-8?B?ckEyOVFXekRQeXEzWFAzMUQ0alBYSEtUTkhvb1F3Qzc4UG56MGpNQnF5Zmkz?=
 =?utf-8?B?TS9SaURCR3RkcE96VU5yTmwzRzhnZDE2cnU2SEpNandtN0xFSlNaT1Q4OWdh?=
 =?utf-8?B?cVFiSG9pRHkrejk2ODBOQXBxS2pWeDBnODNsOTZQS0ppSEFLVmh0cTNTS1pX?=
 =?utf-8?B?TjVrUGFqL05pTkc2cUwzRHF1QVZBZjAzWExsOGJHbXFGQVZWa0ZhSTRnSGk1?=
 =?utf-8?B?YmJmY1JFZGxrMjEwQUpTc2JGSjA2TCtVOWJUd0NJRHNncHFaNVFTTHJPdzJk?=
 =?utf-8?B?VzdkL0toYzgxdkZCTXYyZlpDOXdXczNGUnEwNGhjRTgvVTd1UTRhNDRSdVVv?=
 =?utf-8?B?TVVOc2lvRXdVZThoTlAxMTFHMWYzTnRyazMxQWdGWFZLT2JDdGEzbzQwWGtV?=
 =?utf-8?B?cW1CVEd5TEYrbHdIaml5cENnWmpBYmhsVW9CQmlZd3ZKaXE5QmNOTWkvNDlw?=
 =?utf-8?B?UTY2aFhUTE9Uamg2SUdiY3VSMlJkNWxNVDRTd2VjQUhSZXk1cGg3MTJ1Zlpa?=
 =?utf-8?B?d2lXbHVYTUl2aXRzSGxZRktzZy9obGFZaE1YeXpkR0xUbVUxeER2VjlCdmoz?=
 =?utf-8?B?cXRraUNiNTFKeExiOFR4bTZwVWJjMGdnZkVZNGNhaEcxNDhhdWdManhGQkQ2?=
 =?utf-8?B?V1Q0OWNJWERxNHBaMDdxWjFCQmhLL2pZb2laOVBwWVAydVNRemxROE9MR3Bv?=
 =?utf-8?B?SlU0V3hzNGFiNytWVG1zWUNQNmVZZW1xWUVPYWNXTC9hc0NkME1RQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9b3893-6593-4b7a-fe84-08dec5f767ee
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:12.5971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KAdRhnEWtJM/9xbUxVeEHAd5yaFTlWdxMILP9kvR3NMPV+w3uawkTI/V/Nwv9qsu7/iLBWnFgF/WagVvKOguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11148
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

This is a misc patchset mainly for supporting livetree API for i.MX9 and
cleanup get_imx_type. While working on this patchset, there are a few
minor other updates

Patch 1: IMX_TMU depends on DM_THERMAL, so imply DM_THERMAL to make sure
         IMX_TMU is selected.
Patch 2: Update imx952 gpio reg.
Patch 3-6: Cleanup get_imx_type
Patch 7: Update ddr firmware name
Patch 8-13: Enable OF_LIVE for i.MX9 and i.MX8M_EVK. With OF_LIVE, boot
time could be saved.

CI build pass

More information could be found in patch commit log.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Rebased to address conflicts
- Invoke get_reset_reason in arch_misc_init(), since imx8_cpu.c not
  supports printing reset reason.
- Link to v1: https://lore.kernel.org/r/20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com

---
Peng Fan (13):
      imx8m: Imply DM_THERMAL
      imx952: Update gpio node regs
      imx9: scmi: Drop get_imx_type
      imx8ulp: cleanup get_imx_type
      imx7ulp: cleanup get_imx_type
      imx: Guard print_cpuinfo with !CONFIG_IS_ENABLED(CPU)
      imx8m: dts: Update ddr firmware name
      serial: lpuart: Use livetree API for fdt access
      gpio: imx_rgpio2p: Use dev_read_addr_index
      misc: ele: Use dev_read_addr
      imx9: soc: Use livetree API for fdt access
      imx8m_evk: Select OF_LIVE
      imx9: Select OF_LIVE

 arch/arm/dts/imx8mm-u-boot.dtsi               |  8 ++--
 arch/arm/dts/imx8mn-u-boot.dtsi               |  8 ++--
 arch/arm/dts/imx8mq-u-boot.dtsi               |  8 ++--
 arch/arm/dts/imx952-u-boot.dtsi               |  8 ----
 arch/arm/mach-imx/cpu.c                       | 60 +--------------------------
 arch/arm/mach-imx/imx8m/Kconfig               |  1 +
 arch/arm/mach-imx/imx8m/soc.c                 | 30 ++++++++++++++
 arch/arm/mach-imx/imx8ulp/soc.c               |  8 +---
 arch/arm/mach-imx/imx9/Kconfig                |  1 +
 arch/arm/mach-imx/imx9/scmi/common.h          |  4 --
 arch/arm/mach-imx/imx9/scmi/soc.c             | 10 -----
 arch/arm/mach-imx/imx9/soc.c                  | 10 +++--
 arch/arm/mach-imx/mx7ulp/soc.c                |  8 +---
 configs/imx8mm-cl-iot-gate-optee_defconfig    |  1 -
 configs/imx8mm-cl-iot-gate_defconfig          |  1 -
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  |  1 -
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig |  1 -
 configs/imx8mm-mx8menlo_defconfig             |  1 -
 configs/imx8mm-phygate-tauri-l_defconfig      |  1 -
 configs/imx8mm_beacon_defconfig               |  1 -
 configs/imx8mm_beacon_fspi_defconfig          |  1 -
 configs/imx8mm_evk_defconfig                  |  2 +-
 configs/imx8mm_evk_fspi_defconfig             |  2 +-
 configs/imx8mm_phg_defconfig                  |  1 -
 configs/imx8mm_venice_defconfig               |  1 -
 configs/imx8mn_beacon_2g_defconfig            |  1 -
 configs/imx8mn_beacon_defconfig               |  1 -
 configs/imx8mn_beacon_fspi_defconfig          |  1 -
 configs/imx8mn_ddr4_evk_defconfig             |  2 +-
 configs/imx8mn_evk_defconfig                  |  2 +-
 configs/imx8mn_venice_defconfig               |  1 -
 configs/imx8mp-libra-fpsc_defconfig           |  1 -
 configs/imx8mp_beacon_defconfig               |  1 -
 configs/imx8mp_evk_defconfig                  |  1 +
 configs/imx8mp_rsb3720a1_4G_defconfig         |  1 -
 configs/imx8mp_rsb3720a1_6G_defconfig         |  1 -
 configs/imx8mp_venice_defconfig               |  1 -
 configs/imx8mq_cm_defconfig                   |  1 -
 configs/imx8mq_evk_defconfig                  |  2 +-
 configs/imx8mq_phanbell_defconfig             |  1 -
 configs/imx8mq_reform2_defconfig              |  1 -
 configs/kontron-sl-mx8mm_defconfig            |  1 -
 configs/kontron_pitx_imx8m_defconfig          |  1 -
 configs/librem5_defconfig                     |  1 -
 configs/phycore-imx8mm_defconfig              |  1 -
 configs/phycore-imx8mp_defconfig              |  1 -
 configs/pico-imx8mq_defconfig                 |  1 -
 configs/toradex-smarc-imx8mp_defconfig        |  1 -
 configs/verdin-imx8mm_defconfig               |  1 -
 configs/verdin-imx8mp_defconfig               |  1 -
 drivers/gpio/imx_rgpio2p.c                    |  4 +-
 drivers/misc/imx_ele/ele_mu.c                 |  2 +-
 drivers/serial/serial_lpuart.c                | 15 ++++---
 53 files changed, 70 insertions(+), 157 deletions(-)
---
base-commit: dee0168d5771df98740d91f44dc5d56a4ac171a9
change-id: 20260521-imx-misc-1d83a9cfe0ce

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

