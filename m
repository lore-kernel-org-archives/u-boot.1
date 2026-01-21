Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F739C44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 16:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56B483A8F;
	Wed, 21 Jan 2026 17:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="F9uwRphq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4D1183A6A; Wed, 21 Jan 2026 17:33:40 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01ADD839DF
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 17:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niko.mauno@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kT/3qAI0+KeqyHkhhjfbWkuHbJWpbW1DK2rvMOOagxKwIezcdOyCMrQ3ZvrIp2PS9TncWRkf9fUw8SgfXVc9vo3Egdtl+UBsLAfs1L1ucSvyYCcvJ7pln+f+t3rcXWm8pZoy17TfGyzGiqD1v7ltltSMvhVNw63ParMYBEATq42Cp5ySfu4sSbdB1soYnMVgEX2DMFfWvRsCtH4SdExzDXHVWsVUsYiNpYyKct6gmECNegfRjX9loyjlkHFcAxFERblUf2BGzmRUZFIs/1fO+1SSejHswhOoxThiO7smQEaWkCcXdKfLf3CdlL8zc0ZYyzyqOMJ+9AA5uDW30//PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJwiIki1VBrbATrUUberfmbBjrNrMQBbOIJHxRZTcf0=;
 b=nwNyfyUlrJHo2Y8emYJdtCGvBMpBMsSoJL9La0+iJrqRE5ij0XCaTqUeLSzsnLhZoh+vsqfHPwIyIzfxEU1B6ifnOH8J7c3FLtxTDLddKC8M4F5TukDJscyR8uF6NsaIiA8qlY3pWY799tPuWGfh1u9IoInEpTNorr1W6mWc6mDrQeAcpRPi6bHV9Zg7/6Q8DVYW8gCG2ktHD5RH5H1dJ8I+dZiLAPTi9ewEqmDnNfDtOdfjbV1JCSeoEIkmwGOrZjIBXzw3S4YtR0Vv8ot1/hBmdtsmkg0+2ET3CdkgP22S5AQgs71MNgaknyQqy7VLHEl4d7Wzs7BGzRsxmvoXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJwiIki1VBrbATrUUberfmbBjrNrMQBbOIJHxRZTcf0=;
 b=F9uwRphqpIhZo/MBuaYXNIBIZurnUcfA3W3N2p1sJpgR6JShjuc72O4LPjVayRfAJ+ceTFNXGDw1OwnYjqhJQd20JJ6EfiMxmyIQ3MF2L1wJS57ziK/LCaRGJk3gga0DmEikxe8uG4iGzkBVFj2NnG0S6QfBdlQUL+oOXoNvc50rT1Tu/J6mjl0z4QfgBZT8GY4HsEhetCecXjusKBCNWYa2tkwqxi2U84b+EH+JLD66vfYlC7HrMLouWWdlLhGUDzyODE1DSi28cyNUityWkZcaw6hE4MiIjzfUBsbP6LuggH5o+Bp/nl5zSLaunKMcIGZFCGxIeA3KJs1QO4lluw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by AS8PR06MB7750.eurprd06.prod.outlook.com (2603:10a6:20b:335::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:33:33 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::af93:b150:b886:b2bc%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:33:33 +0000
From: niko.mauno@vaisala.com
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, vesa.jaaskelainen@vaisala.com,
 Niko Mauno <niko.mauno@vaisala.com>
Subject: [PATCH 3/3] imx93_evk: Enable AHAB_BOOT by default
Date: Wed, 21 Jan 2026 18:33:58 +0200
Message-ID: <20260121163358.21322-3-niko.mauno@vaisala.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260121163358.21322-1-niko.mauno@vaisala.com>
References: <20260121163358.21322-1-niko.mauno@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF0001DBEC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::305) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|AS8PR06MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 2730f177-59f9-4438-a523-08de590ad154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1ZpaVN6emt3cG1HVE5LRzFoREg3S2tRbnpGQzk2dzJib3VwTHJKK2dyUjFs?=
 =?utf-8?B?MGhhZE9xUnJkeEJSbGNLMHhtelFtaEZEbEl0SzN6SzFNb2dzNWVyeEhjVXVR?=
 =?utf-8?B?cGcxNHpIUXBEVlZGY0hJN0xXOWpldkc1N2M5SWd2dEI5SHg0YmxCRFFpYjdD?=
 =?utf-8?B?YXQyRmNmdmltUGVDWUluZmp3S1VnNEY5OXZOUUZpQkl5cXp2UG94LzVGaGNI?=
 =?utf-8?B?TU1sekVqMkRBcWk1VVlHRVIzWFFSMkVvTFZmcnp1TzUvMWRNRVpuck1LWGJH?=
 =?utf-8?B?TkhJZmxqOWpVSmE2dmQ5OWFVYlA1cDF1ZWJrQ0VsQW9xNmhESDNlNmJwRG9k?=
 =?utf-8?B?Vkc0NHNOcHlETUVaMHF1TUNuNURjOG94akdnakdFWjI3Znk4cWVvdlhFRW5x?=
 =?utf-8?B?dVg2TTdMWSt5SE5zMm9PMVlkMXFYYmhiL0Rxcm9FTkVLWWJhOGhJRXdYZzdy?=
 =?utf-8?B?cEVMMkNWOWRYMUYxdXJHOXdRL0YwMVMxUW5jSXFOZytJRGx3MlZsOC9hT2lt?=
 =?utf-8?B?b211SFFndEtwakhhVzVGMGlodlZHd2lmMlRlZUZ6VEVINnl2eDQwN0g2am91?=
 =?utf-8?B?WFViUEZMNWpFWHZJNVh6M2ppWjM0RUZERE1DUUFOTjhiQjJ5NS9yNmhDMmYz?=
 =?utf-8?B?SXF6VEI2ZG1wY2RmSEFSbFViR3lET0lYOE9TYWZkTDJlbGFwY3FKdVByVjdF?=
 =?utf-8?B?dzhENEVUT0RqUm1qeUJUenhKZ2hDbUdvbzlwdnRBMnovaGF2VWJVaG0zN3RN?=
 =?utf-8?B?ZEh0eG11dUZ0aXloRW5kZCs4N0ROQVZMd1cyY0I2UEJ4dGVUTTVTUG9ZVEtx?=
 =?utf-8?B?a2F2elZjN2l5YTVRMklDMkxVeGtweXNmUk1xRjBuMUR1RVdaZkZQbWRGc1g1?=
 =?utf-8?B?NjlQT0xiWkRNdGpFVEdFS203ZTB5ZnhyTmwwMVpnRGx3aHBWNlVCMjhjWmxW?=
 =?utf-8?B?NXp0ZFVxWlFGamFVRTlvM3lFMjZ3c3U4VEwzZ3JSaHlsVThwQnM3eElBNkRX?=
 =?utf-8?B?YlZQOTRKM1FkSG1kL2w3S0ZxSm5tVzlnVTczb2FCTVgyU2g5eXVlVHNiVFR1?=
 =?utf-8?B?VWlRVzhqNXBQVDZBdkR2ZFN2MkV6clNnT296b1FiQTY1REtiKzlWK1p0blZ5?=
 =?utf-8?B?SFFUVUdTZk5VYWtzRVRxSi9scmpXOCtVS1Q5QUM2SzhDaFYzUThCWGc5UUVo?=
 =?utf-8?B?QzdGTG1wZ0IyOEFaZmFnYkFvZWJ1Z1JFNEtmSTlCbU9JR3RwYjRTUzRPeFgr?=
 =?utf-8?B?T2ZXd2VKVkJVaDBrckRuOUkxVENZd1p4Zm5ScDBRcVZTdU91VC9DS05WSWVP?=
 =?utf-8?B?TzMrYmZqNWJsSDNIYVBVdFpic1BPb3VoQUxzbUV2QVJOWkZvcUMxMXBLWUUx?=
 =?utf-8?B?aC9GdmxwYXoyR1g0RnpJVnF3Vk85OXpHbFQ5ajEzMXIvclV6R3UyczZsUkYx?=
 =?utf-8?B?STBMMUdLdVR0aC9nVGkvdm9VREc3UmQ3N1hjcWVMVml0K29mSHZtYUhXSWxO?=
 =?utf-8?B?emwxVnFzd1pPcWxFWE9KcXlyUGtPbGhwZm5qcE5iTTZHMGwzcWZ4VjAvdWZ1?=
 =?utf-8?B?dENickY1REdtWWJGSWdlZU93b1NoR3JOZ1lVb1ZlbGNXY05WanQwV0NwQ1NX?=
 =?utf-8?B?SzBoM0RXSHduMHZFTkZmYmcydm9CQllNR0wyb2w4YjZ4SGRTTU5CNEZSbGRG?=
 =?utf-8?B?b1ozQ3JrZmc1Nmt0TXRnc1UzRjFmVkh1ZFRHLzR4NVh1dy9jczZYV3EvSXJM?=
 =?utf-8?B?bEV3UjdpUXowUkhFR2pJVCttUHVUcC9vTjBubm5SUWY0RlV1SFJNOXdsWEdG?=
 =?utf-8?B?Zm5XdFY4WWZUdTNVVE1GVHE3VkdrZFNwOTRMUFNnL0g2aTFpVDE0eGVDNlJJ?=
 =?utf-8?B?RnBQblFGaTZ1L3dhVzZlZ0cxRHpDcnE1U2t5aDBFRkZ6MWpVSWsycVp3dlBZ?=
 =?utf-8?B?SjZQMDNsdFlQY0hQNllOTlBVbmhhM0tQdU1sc3o5bDFLbjg4R21PQlJOdlBS?=
 =?utf-8?B?ajBMS0JQU3Q1VjhnQUVob1hlQkEzRlE2TWlZdzVIcU5PR0VVRHRKQjlpaGRo?=
 =?utf-8?B?R21hU0JBSDIydzFZamdxVkVQazlUSkFkb0VCY2FrbHdqdlFhL3JkRzlVdUpy?=
 =?utf-8?B?NGg3TmowRzV3d1UwdlVJbGFyUjNrbWlFZ3hYQzk4bURHRmJNZmdOM3NIK3NH?=
 =?utf-8?Q?nDrzED8S0UrhiAORnmkqgiE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR06MB8447.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDRQNVFnb2hWK0NiVkprQmFRYUwzS3VjWGljU0xhck5DQXhLdmUwMFpIeTMw?=
 =?utf-8?B?dWdnNDlkUXZ0UkJSVnV0eW9sL1plRzM1U0V4TFM1UGQzYjI0MkFhZGFWeGxQ?=
 =?utf-8?B?SWh3NUIrenNXUVJOanJEMmQ5VlVSTnFLYkoyQkpxNC9LT1E3dzdjcWNXNFMv?=
 =?utf-8?B?V01rQzg0dG53SUIyZUJoNldwd2RwUDBqT0F0TzYrQmZsZ0VZREJWcVFBVUpj?=
 =?utf-8?B?MTNwcFpRMEV3TExMTkhGMUhNdmJnZTRpTy9iZVpzRjVLSStlQUxLUFYwVkFW?=
 =?utf-8?B?UCtkT21aelZiWVVHV1ZsWVdVSUl6c3J4SlZQK1hFOXltYnQ4ZjhkeVJCdTNV?=
 =?utf-8?B?M3Q4VTBEaDZwMmZRdER4anVWTDVmcHRxVmNia3ZuSWxCWGZHODlRQ3VMWDFK?=
 =?utf-8?B?cmhXWFBaZEJ4cVJYRjIvVERsMmd6dWptNUdETEhydkIzU0xVNHJLR1NraW1Z?=
 =?utf-8?B?aG10OFk1YTZBbnVuWE5vTUw2d0pSS1QxYXBMWENkNndZRXpDY2taM3UzVEN0?=
 =?utf-8?B?MWZsU3R1WFNZL0hmc0NhVU41SzNBWEFHRXdTcC93ckdTaEd1d205T2ZWUnFG?=
 =?utf-8?B?VGNoOHlkNHZVby9nekN3MVEwOW5UdU9wTHB5NXBzbUFmbStHZkdhMkEzdUV5?=
 =?utf-8?B?QytpRUdXNlNGVEc0aUp3RzFhOTZuenM0TFlUYVA1WWlKZWRXcWtNRFl2dkhN?=
 =?utf-8?B?MDR5U1E2bEdyVlNLSHdZanhzNGl3QWlOQnExdGJSYkdBU0hzRzNlSkFoQ3ZN?=
 =?utf-8?B?dXVCbFdNUXR1bzFkTWVtaG9XRGI5Rmg5OTdNVXBDNVc5Nk5CdXZEUjJORXlh?=
 =?utf-8?B?NFFzYzJIWWN6aUF6WENvOHBVT2ZSTENaUnYxbXZjUTNEUU5mVVRMbXRkWjc1?=
 =?utf-8?B?OTVFbjczM0xSbjJvV1psRE1WV05adTFlaWlnU1pVclhtRWRNZU5HL3Z0MHhv?=
 =?utf-8?B?blJ1N1o3UTczUW11RU1lOVF5Nit4TlpZck01b09OcUljQUZZUnQyYnVmcW5s?=
 =?utf-8?B?SnlxcFIwbnlNMWsyNkVoUk1lWExzZ2owdThUcDRPZ0w5cHVCYkJkTHgyQTNB?=
 =?utf-8?B?dnBZUW5BenU1c3dFWlNIaEZwbTl4Uk1pcDFBTnY3YzlaOTVTYnh3OXQ1QVlp?=
 =?utf-8?B?YWtGWU9UR2lISHlKc0VWcnExdHF5eVFGRndLWE5YUHplS0ZmZ3U2NEU1K0Ro?=
 =?utf-8?B?dkR6ZDA3a1o4dmhJbzNVVmJTWXhzakJ6Wk1yVW12ZDMyT3haVGhWNVVjL1RX?=
 =?utf-8?B?Nll0WGtFNE5oWnRTVmFkOWErVmp5YW9wQUlNWEZnNkwwUU1VQ3ltcHVWNTdR?=
 =?utf-8?B?ZlFTQTFkaU1CTFo3dklXTEszMks3WExVVHc2dVJsZzl2TE1BMlhEQ3lwWGQ1?=
 =?utf-8?B?dDMwUW9TZXl0bWU4RmxBRUg0Q2wrZjBrdWZBQm9xRzNxc1N5UTgyUVVDbUNM?=
 =?utf-8?B?cUp1UEhzT2xQR0IvNFdVUCthMERUTlhUMzM5ejlucHpDU08wMmw2SDZnNzZS?=
 =?utf-8?B?eS9ZTkhJNkhCb2RPOFpmVzJPWE9BbkdyS2ppZ0pXS3J1eFVHNUcwajRNdm9m?=
 =?utf-8?B?eVMrOWNyVk9hSEthVVBmZVl6QXk3UWtlRVBlTlRNOEV3VXM2Z2RINUVjelkw?=
 =?utf-8?B?Y25jU21pZDF1d2x3QmdiN1NCSkR4b2FDWTV0NnhEakJqczZZd3NWV0RjZ0RN?=
 =?utf-8?B?emlHWXJiOHZtZXgyTkxQd0pBeXdZVVNLYlhQaVJWUFN6ak9Va1dZK1drZlMw?=
 =?utf-8?B?NFl6eGF3aHdnaUpEYy9JT0plM2VzaWQ5U3BLaWxkNkg5aVpsN3liZzhUYzhi?=
 =?utf-8?B?SGh2WFN5OUVhWk9RTmxPS09hcHR4Vm5QNkI3eXhUc3NzOWNQTjJpeVpvcklE?=
 =?utf-8?B?MXg1MEtUak4rMTdGQjRyVklEMXVPZ0pNaUpRWE5hL083eVhOVGpiT0xmMlpG?=
 =?utf-8?B?U0FMQnhMWDMyZVFxSjlrZ0pNVVdqYkJoNVBGMmNtQlhEK2RQaUVmOExVWFda?=
 =?utf-8?B?UkhYNzYzR283YlBZK2N2STY0Q1F6RWNZTVVJaitoak0rVkUwd0ZMSUI4VDJa?=
 =?utf-8?B?eUVGd2hsNlluQ3JKZ0tjNmtSSEsvQVNKNjgyTDM3T0Q2aFl2d1k5bmp0NFR5?=
 =?utf-8?B?My9ZU0M2ZzRZbDJiV2dsTlJoQnh4K1RENGkrSjFVSm1Xa3V1MURPTzdMRHNr?=
 =?utf-8?B?K1BtS0tCN0tzTjk5VG9UNGQvbFlYMFBSSTlNTGtBOTl6VmR0T1IvNkFUdEZl?=
 =?utf-8?B?bU9Cc1NJYjJvK2ZFWXVSS1dBeFIvSWVuOHJuek1DWTNWR082NkhRVlR1Z2Fo?=
 =?utf-8?B?UW5jMGQ4ZllvcktoblBwR3RRN1B2ZFIydVV1UFNvQWg5ODBKK21tTFBzUDRX?=
 =?utf-8?Q?ab5ltCqdyeVP7wE8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2730f177-59f9-4438-a523-08de590ad154
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:33:33.1015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCSEK7q3+OIH8vOD5vmqTk7Qlg7IMYfv+DlwB7e4oXE8Jnyr/Bci22HvDCHL8WQvQTYtWHSmLFMxzVYbjOLtHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7750
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

From: Niko Mauno <niko.mauno@vaisala.com>

Enable the support for AHAB secure boot.

With this change, one can issue 'ahab_status' from U-Boot command line,
and see e.g. following kind of output:

  Lifecycle: 0x00000008, OEM Open

      0x0287eed6
      IPC = MU APD (0x2)
      CMD = ELE_OEM_CNTN_AUTH_REQ (0x87)
      IND = ELE_NO_AUTHENTICATION_FAILURE_IND (0xEE)
      STA = ELE_SUCCESS_IND (0xD6)

Suggested-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
Signed-off-by: Niko Mauno <niko.mauno@vaisala.com>
---
 configs/imx93_11x11_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 7d3463a57ea..7cfdd402e64 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -11,6 +11,7 @@ CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-11x11-evk"
+CONFIG_AHAB_BOOT=y
 CONFIG_TARGET_IMX93_11X11_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y
-- 
2.47.3

