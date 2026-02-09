Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371B0EF06FC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D6F483C5E;
	Mon,  9 Feb 2026 02:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nRMal3q5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58B7283C2B; Mon,  9 Feb 2026 02:29:03 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A463805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl98b+cFWX6tQ8gkdJiX76jcEp1MV9DjVJz/zweOHgeb0mcFqZNdOrBuy4EiwUs+ndcKZ1LCA8K1M3bvXanboXND7lES2Sg5YUOMTqpWfz2L2dkDBTPdcbP9ja6eVwvgwC29qAqgIs+4R4ZyQzM5bUFMlLRWz6qGWC+T83BnUj61c0b12z7WtLwBy7nAIKdbch4DxCWUXeGxxhmxrpqGz+XQCUWisy0iyK/59JZYEtjyOsmwDPdKoDRjxIOetT1qc9Y7E2AyC52ZlD/VIbJn0011MXSicqmvyxFic9xmyhYjypTogK1e3jRhZoh0lKqu8Uos0hBtfYoEIQTJjaukMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfNIjXlzFleMlM5Sbj+07/Y7FJm025AMJVxfxnXJVNc=;
 b=qEdWBxtuiIFCXUIT6MBcNPp5+OsNO73lIabHrmpDuNlDgq+RqHAO2fpMHooCCnl+ZBxvdaiJcHcy5yPDIq3lt+im46Hgl0DbgMnxx3mWLc/z/dDmeyFRi6+rHRsiBTDyzMbB564+hNCyqqGO4RAEYQcbJhM73DvPEwf/nZQolMYmmSfrZ4Hp3UWerWgnYqoZCPfnPKWedcnsexDe8ShReU+4PT0aHfw34iDePa6hljwBDnsiCuDNaPQIdKXFlALdv6lMDT1NNBjxa7MoretRGhTBvxYC2xNwaNqR2xPhinlyp81QP8Q2Jv8gxHIX59/SD+NPlTd6rnl/17SPhCQsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfNIjXlzFleMlM5Sbj+07/Y7FJm025AMJVxfxnXJVNc=;
 b=nRMal3q5+uJHtFNpKPsj5S/Y1xst7zFrH6uUELSrKiD5PQd35N3Zuvi7tRWfjnwpj+EmLGM83XIjJtCxBwZ/yzQDfsVHNp3IfWqpm45vSAL1UxZEIZ1MC2iOcVy6t2N7TkNrSGX1j17wzY3oC+Y8oa8bL/dLuJGs+Fui1gB3S/DG8iIzRWmxZfcW4CE2WGokYY67nCyb0kJkRT9HuJ+nhxxGJO8gGcZsFjwx5Q4YiHlkow/9r0V/jOZLC5UJtI9P7PxkyTBEv5VGabABPb+zlH3uFLsyJ2r+VnBB1ipmmpPaL+TXJ5I5oEiXPiP/0JrZbdwsnHSszQTF89Gq5Tw2xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:28:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:28:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:08 +0800
Subject: [PATCH v2 04/14] cmd: mem: Include vsprintf.h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-4-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ac84b4-0188-4b84-6f98-08de677a998a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjBMYjJJblZUd2tuZ0RUaE9xTFlsVzFwR0s4czR2YkErUmlFUGlmdjYrdnZK?=
 =?utf-8?B?V2FCV1dQWXRRWkg0VEVjb2lFS3l6cisxWTVRUmNmbC9FMmVEOVhPMEdRMnlJ?=
 =?utf-8?B?Sk1CQy8vQzU3M2JDWVF3UE8wMS9uS3RrYnRQcm1DQWV6T3I4MzI2QzZ0alp3?=
 =?utf-8?B?QlNvR2RITmI2czdXdEIzVnNWOGk4dFVpRTlaU0NERGNNdExuTkVjU2FQeEs5?=
 =?utf-8?B?djBDSmsrYVdQaDhSYmw4Z2hIQnh5T0JnSTdYd2hkc3RLcHloMkZoNzY1cXhO?=
 =?utf-8?B?UkgvZ3lPRTk4Sk5NOC9tTDNva0tuMXJRVkFUWFN2UmdSbXhMOE9VaG1hUk5V?=
 =?utf-8?B?dk9qcGhTMFRzdFUremZWZnZWSjAvdGdpd2d5YnBENUc1TXFqblZhTitOVUQr?=
 =?utf-8?B?WU1xSGdPRFV1WGZ3MjZIaXkzVWdmaWJIcXgxc1ZscHBhOFZhNk4xbmdHSUlJ?=
 =?utf-8?B?S1FIM1hjZjJnMUZsRnF0U0NtenF2VnlOSzd4eHBub29Ra2ZmZ3NUWWM1Wks2?=
 =?utf-8?B?YWJxY0RsN0pDa29QcFNiSWZWSWszYUFXMWJVTHQ5eSt4RjFTY2F5UXV4Zld1?=
 =?utf-8?B?QXNjR2MrV0tYUGVKTFA1UW9YZ0RuY1pyQXp2WG42b3pnUHIvek5BUFVJRzN5?=
 =?utf-8?B?Z1RsQU9NNDRra0FmUktBamVsdTNveFZMQTFybnB5RHMxMm5PakZlL2RHUWRL?=
 =?utf-8?B?SUxDVWdBUitCdkczNkNqeGk4RU9Ta3A5Z29aMU8yWTBzQy8vbWFvQVh0MzI5?=
 =?utf-8?B?TWErNmlMWVZONUE4L0VjYmFDNDZERnYwNzg1N01rcnlZY0FmU2ZSUXo4M1Fo?=
 =?utf-8?B?T1g5Z1Y1TEVvQ0hDbFRtaUE4V1BvUThLNXpFRnA2c2tHOXRRb1N6dGZRSVp4?=
 =?utf-8?B?ZVVnOWhVb3hoS1p3Rll2eUp3bWtOUk9DYlJPUis5YU94N3JZdmMzRHBhNlp0?=
 =?utf-8?B?eVk4dFVSZ2lhb0hJa3VwZEVNOGhoRW13cnJHT3pEUStqWGJjUzFHOHJ5RENL?=
 =?utf-8?B?NXo3OHIwS3JvdHdTRW1wZG4zK1RrZGhabExFbFUrL2ovTUxlMGJETGRrTU5z?=
 =?utf-8?B?enF4bnNFcGlxaUVuR1FYdk5aQWI2T1lxR3lOZHU0RXd4MVU5Q2hoRXJOOWhw?=
 =?utf-8?B?R1dMSzJxSkV6NmN5bU5heFJuU2pneE84dmRjNnd0bFBEeG41TlR6M0Vzd0sv?=
 =?utf-8?B?WGk3blNGT0FicndrMmtsM21wYlVmZ25ZRFhvV0EzaDBZZ2kxQWZHWFlxUDJ5?=
 =?utf-8?B?ZVAyTFBLUFFkTWNjZWVzSUN2OWRJMkVTWVEwU0grT0dRTUpZQmlCYTRGY3dh?=
 =?utf-8?B?Syt6UE1CT1l1VFpJY3pLZTZLV1ZCRUdZcXo0dUM2MXhoV1h2M1BpcTVZdWJK?=
 =?utf-8?B?Y3JMVVFJSXRnUXVFZVd5SXRTbXZsQ2lFKzZmKzdWUFNjRlRiMmtMVEkvRGx5?=
 =?utf-8?B?cWN5WUlSVGpwOVVJNm9QTkFpQzBxbkNHRW5yUG1JM2RYM2xaLzFHVFFUQ2Vj?=
 =?utf-8?B?V2lMV0RGbXAyMm1yZVFscExNMVR1ZzFRMUtQNUtUNUpsSGxrNXhQRHBKc2tI?=
 =?utf-8?B?V09IS292V3VqSUtpTitManhuejNYelVnU01vVE1LZ3U2aFU1R2Y1WHFBMk52?=
 =?utf-8?B?ckhKYVA5OHRSRkVXMWFmMXFjVk9VUmo2NUc2SmVFNGJGeTg2VzdsNVhrdnB5?=
 =?utf-8?B?cjVuK0NGL2FsWTNOT2FCa3FiL3JBb3QyQy9Xb1B1T09VMVNBTFhvd1MyVXpM?=
 =?utf-8?B?Y01rVzhlakJ3QkRCWCsrOFZDWnBEeFgrYVJqNnBPSW1kTG9mMmZ6YlZXWEs4?=
 =?utf-8?B?NkRrN1h1RzhuaXN2bC9ibm4zcVpxZ0UzakpMeGhHdXNuZGVZNXplZzNqb1k1?=
 =?utf-8?B?YmtNZnBLc3VBVkV3NVBiNTZKaWpXMFVEaDNiMTNBdlROeFRRRGFEWkdublo4?=
 =?utf-8?B?NHBxaFA5ejBXUE01YWxUV3BWQ2lWZVZnQkduQ1FFbk5ic1NEM0dzcjhsV1I0?=
 =?utf-8?B?bkxHa2wvV3ltOE85bGNoWWtwcks1R2IvaTF3Vm9YeDVxcFcrRTBhRmszeDZB?=
 =?utf-8?B?RHQ0VE5uVkExQm1JMjdzSWpGcWdIV2xIM2x0YVoyMTZOQ2tZdTFmZjVFOFJo?=
 =?utf-8?B?MC84UytaMHZwT25YL2llNGN3dnBwaWFSM2JHVzdwMGlmTUx1NVRWMXhQaVFJ?=
 =?utf-8?Q?Sb/yMi7ycVR+ThaJKw7M7bc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRLaGZic3NPRVVDUS92Tm12b1Z1NlFMYUlySGx4NzJJM2IxQzlobDhpSnB0?=
 =?utf-8?B?Qm00RmVWdUlrUEUzMzNCMkk5Q21tRXF1QWtReWhQSlVjNzhPSWFDWFVwaFFu?=
 =?utf-8?B?Wnd5ZldxeXJuMWd6TmUwY2lLSTl4ZXJxQ3hhSDdEMGxCL2trNnV3U2VqQUFB?=
 =?utf-8?B?TzN0RmkzZXJIU0lHeHVyMzM0eXNDWW5mSTdZQ3k4SnpKOFRQeTdKQkZDbEdv?=
 =?utf-8?B?cXNadjlVb1BHaFVhbUlwMllMWmpDK1hjQzhySWdSWkd3aitVSEFOQzhMMHUw?=
 =?utf-8?B?NC92VVJocStPSENUR3J6TG5NajRwNFVwcG5kbXBCTExFM3hibzJ2eHVhN1ZQ?=
 =?utf-8?B?dFJXdHdGNDhiT2FxV25VaHlORS9iRzhNZkk5eE1ocTE3UCsrVFlKNVl1dXAv?=
 =?utf-8?B?a2cxR2djalhtakM2K05sbUxPTmhZQldXRFUvMlVxZUozOUNtUW9MK0lJS1BE?=
 =?utf-8?B?d3ozUFZDZkU4UFVqK3RYMGYzQTN6OGszcWkvZWpqbllMenB6MTQ3T3A1c05Y?=
 =?utf-8?B?Mm0ySFdlSnR6SlBFYXZWTUZKejVRektHMFBneXMxTU5xK0ZhNDJiaUYrKzMy?=
 =?utf-8?B?MjZnTzVCZTR3anZQcGZ0TE1XQlMxRVpsMjgrU255WTltb2pVTDJhZU14cyth?=
 =?utf-8?B?YnUxMFBJUWlvdHF1Wm1RdVoxc2pKRmF5Zi9HZUZaUDFZWlBDU1dTc1NXbzdp?=
 =?utf-8?B?c0licWU2L1Y0RFJYY1BTZGlScEt2cmNuTUp0QjN2elZ0OUhOdE1xTTlncFZx?=
 =?utf-8?B?OS9yamhyVWwrbHRheDFkNmVRd0NUWlBYc0VEaGc4clQ1cWRJSmRVWVVDSTNz?=
 =?utf-8?B?QzhlbitON3VybHZoRmh0VUY5R3VpQzJIa1E1Qm9kTlJuK1JiU3I0alJLaHgr?=
 =?utf-8?B?SGtYZk5ONng3M0ZkRUhjUDBhaXZibDhESzFSNCs0eC9JeVJlbTNSQUZCWnVN?=
 =?utf-8?B?NlIzaVBrYkNtRFhMbHRKVGpYM28wQ0UvTzFrNmxxb2E5MVJZd0M0dnU3SzBk?=
 =?utf-8?B?WnBkNUdhZmVrbW1vSXQ5U1FQNXFKdnoyYlI1aGVwaWlWN3QvNHRBd1lVU3ZD?=
 =?utf-8?B?TksrQitLQkRlWU0rWkhGa0NFZHI5RWVLckl6a1gwV3F5K2x3RmpvcjVaYS85?=
 =?utf-8?B?UFl1SXBRTTA5ZVh6MFFGMlhxTXNJYVJJK3hLbktSTzVHcitUSnlzLzlQeFVP?=
 =?utf-8?B?ZnlPYjVqVU1WbmlQWFVCQ1FPcTZpWnBYeHd2ZHA3L09jTGJVcDQzblBRcVNt?=
 =?utf-8?B?V1dhbXMrc3lDVzc2ZTV2Wm5oUDYrb01IdU45R2I5amtnREl4clMzWjZ3bmRk?=
 =?utf-8?B?MjBkTUYzMG5zK0l6UVp1TlhCcjJ5RVZRc0pTU1k4QUU0djN1NGU0eE5MalJE?=
 =?utf-8?B?MGhWdDdWMm44eHVpYXFoeTdEOTR2b1Z1ZTZhdHNjTGNhUkU0cFV5VkxHYWJ2?=
 =?utf-8?B?U3hDT3l4NmZCUlltUThuUmZVSDY3dHBTNjJHVjhrTmU2SFJxaHpjbmZ0ZUZT?=
 =?utf-8?B?Q20wbTFUaGZKSFJKQnBvZEIxUGF0NUx3Tm0yczYwVWJGa3JrVnpTelJ1TG41?=
 =?utf-8?B?dk5uMGU0TEcrejRBTDdNVGh4K3hDOHNwNFBpejZ6a1FIT0oyK1ZMeDIvZTZU?=
 =?utf-8?B?K3FjcTd1a2xQRW9lVThhUk9HK0ZmdmFrc1VZK3cyWWVDdWllNTlVVWtPa0RD?=
 =?utf-8?B?Nng0aWZjQXhTQS85UGpsVGx2bGRKN0VPdFpTSXl6M3pVUENkMjgyNndraHJa?=
 =?utf-8?B?MGlBZ1hFNTZQVVFRUVhjUUwzc0hjZ3hIWGdiRFlRbXNDRWg1ckpTTlpud2lu?=
 =?utf-8?B?SUJUVEQ5bmUvSDNzZWRZUkNXYVRhb2ZJM29ORnJKNHh3U2FMVmVuNFRPUXFP?=
 =?utf-8?B?STUvSjd1b0crNUZHamZlc21YbWRjQVRDQTMzS0EySE8vcjVFeTZlSS9RWVEy?=
 =?utf-8?B?UFN2RnB0YURyTGUrZmpoazRtdXE1RXFmY3h4QUlnUit2K1l5dm1SMVZZTGV5?=
 =?utf-8?B?b3NSRnVWbkZyZC9SaS90V2oxcURwYTJpMlprVkJxbExPemJscVNtZDVkZDd2?=
 =?utf-8?B?T1dpYlM4SDl2aU9LZHI1OHQ0SXcvdnVITlhHTEZJNXROQnlJV3h4TWhVeVhN?=
 =?utf-8?B?OTc1MTYrV0F0MExkKzdKYjkwUmswTkdtTU56eVVOQVduMmdRVGdHbVg1OEYz?=
 =?utf-8?B?M1F0TkxQa0lHdXZsTS9PaFY3N1NZakRvUEhwZ1p6NHVLWlJUTlNUaWZTT2dC?=
 =?utf-8?B?WUJCcGthelZjd2Y4a3FZQmk5T2REQWE3MUZWbGtWNlBFOHNHVkpzNzI4YUJK?=
 =?utf-8?B?MGE0K0ZoN0RDUlVmSDNxUGt5UGhaM1BJOEkwcHJpcE5FUHJITWZXQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ac84b4-0188-4b84-6f98-08de677a998a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:28:59.4233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxbx5Gu+CDigF7GdPBweu4T6PR+c845bOuzUMjxDrfpFiJOUJ0/hN49I8anbK1uzXjRMDAr5N5GJcBr1s8hJQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

From: Peng Fan <peng.fan@nxp.com>

hextoul is used in this file, so include header file vsprintf.h.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 cmd/mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/mem.c b/cmd/mem.c
index d5d7ca2790bdf2d100606963c0c2d48b1c6b6978..8690fc1e4e6b93d78b48cf4c080c7f52bf2504c8 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -26,6 +26,7 @@
 #include <mapmem.h>
 #include <rand.h>
 #include <time.h>
+#include <vsprintf.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
 #include <asm/io.h>

-- 
2.37.1

