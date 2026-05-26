Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710FCCD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4247844CF;
	Tue, 26 May 2026 08:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mIIXv4Qq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38F298469D; Tue, 26 May 2026 08:52:29 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B3E83EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdgVaTof+opK3Wix1lwku0rPpE1kaeLJ5o+sfzCUvASrupU73RX+NL/0lwKOiE+o4ObL+/n8v4e2TC9G6duGfrlMrr5fqh0Sbule3eRtSI+iIMHVMiancz9rkfkFc0Zh2iSHxFealfHd2CYl4ce0yMYCrEjN0kRFdQJkiSTmj7VplJcizuohV/QmhmalT2mp/up45uhtVbcPc8W5AHqhzur65tG+e95FvyyqWJ0/mjnLx59DACJlgSM1qZJW333fVs/13wtIQwCeiSXAWgDO2xGoUrNXCdWfDMaZ5k/vAiOiZ3Qa+Iw5g0CtpVAQiVp4PiuzWXda85d3UpkGXjBoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g81sYe8e+nRiBuM80WFDfzCIgcUkx68jVuRRXS9yEqI=;
 b=oKutjovEOXjjvFN1xNnKWeDbFIabozcludyKbAy5jCGKsf5wvJvG+vdYeMFx5oaYvjYW7UmM6fN4OgESYfWMLmwc6k5P+2Hn8c1ABZPFbShykxDRKoJWGJla8q6xP/xHEw+9gMPph9qTGqyluda70G4hC8fbKtF0QDoDz1StBhysYJ6lvHMRqcXWJorym7/kr6G7g7DCiyVQ2l9x8VPWwJEZUuhLrnPawz970hB1TQ7YRzCqR5dqnOAu/23MmeryyJA6bFEYfknwfWnqCbzkQJiA9dASJIC9xoB9okkcxeGTi+WiKz+N9VzGMgr8o/HBkDh8xslPdkJadSHs4zoxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g81sYe8e+nRiBuM80WFDfzCIgcUkx68jVuRRXS9yEqI=;
 b=mIIXv4Qquo7cJyjV0u2DPAuv4b+hQWUqjLOTtBF9C6D596Cb9zLB0lRpKoc+/vQ8hq+R2n5WD4VScr+E8eG4nXrrdYhnWJZSYTtpab2ddBGledvYjynkAxE0NWO5TUaIro7Nv2ZUJjShrb3S7WIbEPmmeE6MF3q7EvzxhW+rl4+dKKTmt5HiPDac5GduDqckQcqeSfbtUaGOdvDjD2r+wHO7G5+fq1oxhMN84ke6NRCSHekPFisHq7R572/JdLromOKTDdf14d2/8RqXPys4Gvti9ze5fQ5EdezucdBAOltfc4BNpy/De9x0DAComYfYfXBqW8LkgfSX45dJIEUoFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GVXPR04MB10492.eurprd04.prod.outlook.com (2603:10a6:150:1e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Tue, 26 May
 2026 06:52:23 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 06:52:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/5] pci: Use dev_read/dev_remap APIs
Date: Tue, 26 May 2026 16:09:08 +0800
Message-Id: <20260526-devfdt-pci-v1-0-ed7f31d73938@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRVFWoC/x3MQQqAIBBA0avIrBNU0qCrRItwxpqNiYYE4t2Tl
 m/xf4NCmanAKhpkqlz4jgN6EuCvI54kGYfBKOOUNU4i1YCPTJ7lrC2i8sHRomAEKVPg959te+8
 fD7TVj1wAAAA=
X-Change-ID: 20260526-devfdt-pci-415dd0cf6e70
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::9) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GVXPR04MB10492:EE_
X-MS-Office365-Filtering-Correlation-Id: 562304c9-dd10-45a2-ee45-08debaf356b1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014|18002099003|56012099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: Q5sZK87+X4twpHIDZkCNX0K9Sb3t4JJjQhC12JLSrwq5gta0eQ0XpuA1i0+cKLWk8HMzjF6bcmZWyPN1cD4GOKPO9OBioRT0QhojH1OusfsQ3O+capY8yYoveLN+Wr9JASdoWlkZpJd26De4RyGMmPNk6kjjUG+kaBtKtOa0MbpCtPs0lgcbJKQwKbPc6CXI57l898PnjZmJfXdH9b9ijtDnmQuDLTduJTMBc4ezDXHE8s9grMVMZXq4FdkmSK1xhBiTt0LNTgIO0v8Qg5Cj+s0uoOjGDIJhiMGFVl4GcgbC5Uryx8e0UYdGow/aoiOqChF26SSNdSH38Bxd0f2gvHHWrkDN6OYoqfopt+3yK/o+qIelHOj0ZQCAzcxf1OrJRIF4Kgw2Uht2eclej+sc+x3OZxzXnPjI4gKPmEOZxPMkXl3GEMKYOWKcqZ9WVIfhtVwFfLe3dJivUQHZchbzwADvijx/7HYSpnmg71Y9uQ54wZL4ruTqFSri6/YcKKRwldgTzppr1FyABrdLUrnt9q3OuIRTWmqg0b47YHwVtClclz61WC/a2GoWPJMTfVsMtpF0rqZdtRAXcby+CFIdqc2C6eomYrAI2HJZN8frZ6EZTljAj/Vmu5+ooeMNQqXJjeLLRxD9T65cup3jAgaJsTivydfXULVJBlGwvpYLbzCdpdod9E4JvC4mSqz9K3vwK/i1ofP37gSEaRZm7/W2bwgtIc4wvroSSNfZjsm9xhbTXR0KISv8lznl12SsMAVe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014)(18002099003)(56012099003)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjBsNnRuanozclJLU0JrMElaemRsZWdpOEwzekc4WTFqRHZnV0RDK1NQdVZq?=
 =?utf-8?B?SXY5ZG9IRmp5Ky9GL2FzUFh5SCtXSEVNVUhHYndERGw0UnhxV0s5MGpmc0ND?=
 =?utf-8?B?TDZCZHVOU0VnRTc5NE1xbEdjTHRxZjhrMVJqd21OMmtydTRwQWx2bUtGUmVq?=
 =?utf-8?B?bkRVTzNNSDFySjdhU1NNOUVnN01hZmRxLzNOMEFYdm56c2ZaMFB5RW9abkFv?=
 =?utf-8?B?Z3ZYN3Z2Yk1BQmc5eXRQT3V4ZGdyN3RPeGZKejhBRzl3MTRyZHRiVE4yUE9m?=
 =?utf-8?B?WGlCSW5MRnFnTTNyYUpjMGdtWTZwdkZuZlRTZG9QMFFRL3NYRkRFbCtxYkhx?=
 =?utf-8?B?cjRZbWFsTFhRUkdneDBONHVWNjZSOFhNRlJYWFlWbU9IKzE3QWxyV09JWm82?=
 =?utf-8?B?QVVsRXlDME53d3NycFV3Qmt6U0pndzNmVXZmTjNscWdKSGlVZHQvajZiREQr?=
 =?utf-8?B?RTlrZG1UYytoQ1JGcFJPbEFXS1U0dE9iMWJqa3JOTjJVOWl0dmJ6MTFndndV?=
 =?utf-8?B?WFhiTmtFLzVod0UrUCtIcFBBN2pHWGNHOHlsQzM1Y2o3amZCK3k0UDg1SENP?=
 =?utf-8?B?ZWdEbHAyRWFtdUhsMjh6SWFtVEdZbCtqVUpIVU12YmtERVFIOVR0TG80Q1FC?=
 =?utf-8?B?Z3hOZ0Ztb0dDMTMveFBTVDdLbGZNZzh4d1MrZDVPeDVmOTN6Wkx5bnh5b0I2?=
 =?utf-8?B?R3ZQNXFOcDlYTVhNRnRCN0V2V1JHQnlmcmhONnVHZ2FhZHZCT3UvTjMva0Q0?=
 =?utf-8?B?bjRjS2FhOGUrMy9GRzV4QStaV0phYzlIL05yak1OSFJDeHFjU0pMcDZTZllV?=
 =?utf-8?B?SVNrbjA5bk80bDhzS1lDNW1FcFRldEZFenB4YUl5N0NzL1Y0Y0NSdjd1OVRB?=
 =?utf-8?B?N1BYdEVPeVJLNHhJT25sR2xOYU9CRmtiTjB6cDVVMFZPL1BPUG5Qc2p6TjFn?=
 =?utf-8?B?MGcybDZZYnpBZGZ1UzZrTERzd1lMSnlQcDRSdXZLMkRXVldXUmFLQU5tV3RO?=
 =?utf-8?B?OE1LUUEvcTltSkNTeHlBZWkxWmxMODJHUndkQW9IYm85UWE4QzBpUXd3djJY?=
 =?utf-8?B?VUUyQmNlek92bkRYT3J5UjVhZXhTdzFncTNYdEczSkxwUXZmQmpsY2hpdkxt?=
 =?utf-8?B?R210bXFBU3VQM1g4TFI2TGdackpUL3l4NGVqMGNsTkVNZy9qdVRaMDBYOGRw?=
 =?utf-8?B?MTNFQVZLYTdZeWhteG5pOFRZR2Z3Y1A2SUVpR2lRTk4zdFBkNVdXaTZmakYr?=
 =?utf-8?B?b0dVWjVVSkJZVkJGUVJyYlg4OUdxNGVwWkdoUHlmdGNBQ1FOV0dpVnhEalJh?=
 =?utf-8?B?ejI5R0FTdXBsMFNGQVVxT2xVNHlNWDdhRHZXYTlsT0gwUUN5RW1FbzNpNFdt?=
 =?utf-8?B?bWp4bzNXS3VyOEVFQ3I1alNzRkx3UkhMa0VsQTh6RU1aZE84ZUUya3EwUnZE?=
 =?utf-8?B?TnFkL3Y3Y0s0aG5pZ0RCN3ROQy9ZUGs5UkQ5eml1UjJOSk9XYnJHSWtjS2wv?=
 =?utf-8?B?amMrcFQweTZYYVlTSWowVkl5Q0k1QVptQ1hkWGVDc1pVeTVEV01rRWFRSlNu?=
 =?utf-8?B?Y09YcDQwWUdHaDVrVDQxdXhSU1FFUUI3NEdUWUdycm5mN1lrRHpCT3NpMlBl?=
 =?utf-8?B?TzUvZlE4Z1FnZkhwSGZ1dWtSUU41RlMrWjJCZDBkSFlSbTd0UDEveUR5eFR1?=
 =?utf-8?B?TU5PYzlQVHRuSEJ2a0VRU2hlSFJ2aUd2eHI5VnlMNFNBQ09hL2kwL0YyNjNm?=
 =?utf-8?B?cU1ZWG9hWXlNNkdGQUZWNzN0UzhSOWJ1Nk5tN2h0bERhK3dqL2h1ZW5jcEdu?=
 =?utf-8?B?Sk5pQUJQeS8vbWZ4eWR4ZkNKS2g0bzhUalRHZ0MrRWNHaW9Ld1V5N2ZIMXlK?=
 =?utf-8?B?cDYwSGZKSWJndi9nUGhENk5KS2U2UmZ0SVR2T20vY2Uyb212Y3I4cW1qdUVX?=
 =?utf-8?B?dkdrNjQ3ZkFUOFR3L2dkYjlISDRSR3huNWg4aWNZZU43c0RYanBHOEY0KzBH?=
 =?utf-8?B?Y09QRXYyZi9iWFhUK3NTMHZxVUk5ZDhmd2J1cy9aM0lrbjZZODlIVWhmWHpE?=
 =?utf-8?B?MU51RmlJK1lKa3FPNFJISDJIRVdBclgyYXV1eEJtZlhQOXN4T1YzU3RnVG41?=
 =?utf-8?B?YTlNWFc1eHcvakJQMkVzSGdYWlI5QmtrRXRHRG0vMTFRQi9ZYkhsdnh5NHpV?=
 =?utf-8?B?UXp6WXJMR0EwSy9DUTUwekpUVENMTDZCMzQ0eHhySkphZmZpb2tGYng1RXNM?=
 =?utf-8?B?SjZzTklJRStWSjE1bXJGVExVSGhnQzUyNnZIQzZyUG1nUkJuaEdQTklUS3FY?=
 =?utf-8?B?ZVJvdVdIdFl6ejI2OUZjYmIybUNaVEVER3dEdkNQYVh6eTBwRmxEdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562304c9-dd10-45a2-ee45-08debaf356b1
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 06:52:22.9122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oc69oxxmEbLT7CN/6oUZw2F0Omqocav15SmiExqDZg6S/ZhQ9Hadbvj89CiJyMB6R8lCoH4svvlEeR928WGAvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10492
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

Convert PCI drivers from legacy devfdt_* and fdtdec_* interfaces to
dev_read_* and dev_remap_* APIs, enabling support for both live device
tree and flat DT while removing dependency on global FDT access.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (5):
      pci: rcar: Use dev_read_addr_index()
      pci: mpc85xx: Simplfy code with dev_remap_addr()
      pci: dw_mvebu: Use dev_read_addr_x APIs
      pci: imx: Use dev_read_addr_index_ptr()
      pci: layerscape: ep: Use dev APIs

 drivers/pci/pci-rcar-gen2.c      |  7 ++++---
 drivers/pci/pci-rcar-gen3.c      |  5 +++--
 drivers/pci/pci_mpc85xx.c        | 11 ++++++-----
 drivers/pci/pcie_dw_mvebu.c      |  5 ++---
 drivers/pci/pcie_imx.c           |  4 ++--
 drivers/pci/pcie_layerscape.h    |  3 ++-
 drivers/pci/pcie_layerscape_ep.c | 24 +++++++-----------------
 7 files changed, 26 insertions(+), 33 deletions(-)
---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260526-devfdt-pci-415dd0cf6e70

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

