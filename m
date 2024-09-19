Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC8CCDD561
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E01BE890B5;
	Thu, 19 Sep 2024 02:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jh5N0Nok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5318A8906C; Thu, 19 Sep 2024 02:15:24 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6254D8907F
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aO+ba+q3MZnUBs9qJDHfjNI720Q05ymUBPHbxANnXPkEIyOj3Ue0tbXErOWIDsJn6RP4gbd7DYXBc8r+wMNPqjmT4Lihswy30PdVQOrz/fnV8+tDzBS7Jgs4RUDrlOSAciXZF7L96kDkydnAaqpo2tH873yxSC8Am7twiK8cUo78+Zk4ewJ00HYQc4gMKDIE1RLMk7n3v0L+3eAywkBbNtFjXryKsi/qYx3LltvYxizgqwfwx0mVPPAifrtMwVENN6f9S/MtlCo7ewVaa1xaC1h0pP6kbmndV6f7sBJnT7GsSFBLpSK3p0s5wGwE0MyVyPaeROvrWdzxLHvvQAHM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYLgxBcCgvFVhLCk0CE1dak0hYn6A3h9u/Pjwah3V7U=;
 b=XJNkvrZ5OjxscadNe9W4NUM5NfztvGLNNvQwdK57dljy3W6/Ieyv3NIztGE9JxPLFNchHIOMqXYCglMDa4LdqvcNcjqTX8pRP6A+0rt7VsVPaB2gzYEKTvL8vGNsDyCrGNSgunX/T7UtyqcYjVDF1+FCWs0vyYJ7Nzc02+vN7w/6o2x/qZEQ8qFIBD9i3TahX+tyO9mC4gKWvZ7nnGevymwgT2ZdRiUx9ZTvIfGP8Zu/PrGZbt5KhzHAO1f3lolO3zClanW2hLPG9Iu1gfOGTtSPCFk5NG54bUArcBINpfMsBTILyjeYwy1484OgldzhdVL6aEBZzVtARB92aXRm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYLgxBcCgvFVhLCk0CE1dak0hYn6A3h9u/Pjwah3V7U=;
 b=Jh5N0Nok2Bd/1C5tVpWj+foJVCMfZ+iosXHltQg4Ei0JhEm0EjMOTQY+UCsE8Th4/kFhKQpD5NDe8B5nlc+8T6yeoztDf95BS19LeWb8X31dFYLlBzBpfwx1IY/nxkV5elavELdBLFV3vwyqrlrxTOqDbX8/6/6jknTZmNrLezOBVADVZJpRo7zN1fGjrQhxeVnQECTaR1P8QP/KlOPrcQHATiLf9h6oEhyhTAs4N0gTEUm1Zcv/Xrra7/QFgq0mCX8gYiEroJxwiaV2Zt4zIOdngCP9ORmDyppyrFJrFNrLKre8wTBywEvHbZMes6+1YtxtC24VSHWWbaCtIZc23w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:17 +0800
Subject: [PATCH v2 18/21] imx9: trdc: introduce trdc_mbc_blk_num
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-18-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: d7d4c49f-e8b0-4a8b-190b-08dcd8402609
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE94TkdBb1ExVDh3aFRNZ0h4cWhqY3FwY2ZIRVpEam13eW9nUnJUdG5iWDBP?=
 =?utf-8?B?dlNoWUo0c3NTNHhHS3g4L01jV0VrbWREcmtMY1RWRk5kTkl5eUpmU2V6Vlll?=
 =?utf-8?B?REdDdmVyWVdHUHBPcXNTenlTc2M1SEdkRUJKMkRhaGhZdllzbHBKdkg3MU5Q?=
 =?utf-8?B?S3ppMjZPYVRFM3NRbnVOaEdzQlF6Q0Z1MW16NDF2d3ZOSzZiZ0R1RmFuWDJS?=
 =?utf-8?B?R0lBVENWc0pzN000NzN4QysrUWtkcW0zODRzbGM1MStvd1pqTEhvYnF1MDlF?=
 =?utf-8?B?T01RNDQ3UjZSTEVxS0xCS2duWmtIQWRUNzdFS0prQ1kxdm00MnhUUmFTVDJv?=
 =?utf-8?B?ZDVsYVZVcjZqblJjY2RPTTg5OUxqSnpvTXZ6a0pSamEwR041bG1NTFJrK1g1?=
 =?utf-8?B?Lzgxc0h1QnpGdUwwN0h5ZzNhemQrN1JhZ0MrQ0J1WUY1QVEvOTZEZ0E3RUZz?=
 =?utf-8?B?UzVEai9Qa2tRbHRrM2txWVA3TWdhRlNqZVozdGRNWDlrL2NUZC80SE9keG9o?=
 =?utf-8?B?bmViTzBmR2ZhRXowc2QwS1YvNyt4bW9SempEVVk5RWRNZjliODFwVkdSVEJK?=
 =?utf-8?B?Q2FUcllSbjRGbnJEOStBQUEwVXAzMnlrcFVSMWQ2cnNaSWZ1bkJ2TDJzdkNE?=
 =?utf-8?B?QmhSNFMwOGx5NGw2dzNaSjlmNUp3OG91V3hQTnJpZUNsenlld3F2MSt4a2lt?=
 =?utf-8?B?YmNNMXlkRjVrT1VNaTdSSklZcnp1MWl6MERhTHBhQ0Z6aGpvZ1ZST3JidTMy?=
 =?utf-8?B?ekN2Z21xd0J2V1A4d1MvQ0hJMTdEOUVKMGl3bkVEWXdYRmVPSWo2YjdQek9j?=
 =?utf-8?B?RmhNTFR4djhNeWlienhJNDJFckhlNXErYmtUdHJoRVJwTFUyQkNWR2ZuaGZh?=
 =?utf-8?B?aFhjbUQxZytkNnBTYTFyV1lUOEEyZ0dLRU9JM0k1N0FLYnY4THJ4U1NFR29a?=
 =?utf-8?B?eTlBL0ZEMEh1eHBlUzdrYkFuK0FRM2p0NnZVelUxRWZFZGk4L3BtOXlDQkQv?=
 =?utf-8?B?aThwRVc1dlc3RUduMnMyL1ptR290bENQbklvM2pHK2E2WjNWcHViRjJSd0xp?=
 =?utf-8?B?aHhWek9hK2hYREpTOWJWb3E2WDFmU3psb1lxZ0Z2dmJEWWhLVUQ4RFFQODUx?=
 =?utf-8?B?N3VJdWloUHNOWWtsaEw0WjRQeEExUkxPMzhuNE1jZEk5cHZTdDl4eEpERGg4?=
 =?utf-8?B?amhNckQ0ZldHZTlHRUloMHVGSjNPaWdLWDlseDl2VEx0WkhzOXhkSkpUMzRM?=
 =?utf-8?B?c0VEYW1DaWVJQmhmSW5TY3ZFbUFoNlQzWnI3V29wVDI1OGlHZVdMbDBpTWNq?=
 =?utf-8?B?bUI2VFIxd2hUZms5MFZCckJraTdSeU4ybGswb3pzb1QwK29YRS9EUmt1UW5u?=
 =?utf-8?B?ZStlWHhFcWQva1lTUnpjTGJ1eXUxME5neWJLdE9sZDJ4d2RTbk8vYXpld0lx?=
 =?utf-8?B?dGI4cWVsL1pVS1RielhrMmhEekhEV3JDWGlBNUZaMFZXSzlueno4bEdNS2Rt?=
 =?utf-8?B?aGhNRERhVERsZmxjWWtadnhtcDZGdFVUaFFPR2F4djNKTmxvcnpkRG1IdjdH?=
 =?utf-8?B?eFZGYWs3NVFscHEwZDRxSUFVQmFtVVBtRlRoajM2MzF1TnNBdkd0Sk5ZU2dz?=
 =?utf-8?B?SlY0RmpEQnBiQ0xCN1J0NHdwVUJDTkRNZkdOOGgrTkhnV01mYU1lOG5rVmhD?=
 =?utf-8?B?SDJpYWpNWm5XbEliejBEUzh6Ukh0ZHdVdVk5QTJJZjA5SzI3VGl2M3BEZXYr?=
 =?utf-8?B?blZyc1lqTjArNjhJd0JwYnpDQzN3VWpRVCtrS1lNci9yU2dhNG14RUhIT3hI?=
 =?utf-8?B?eWJxaFIwT0d2cWxjNXdZK2lOajZFNXBHT0NoR2QrR3ZVZUIxVXFia0UxOFVr?=
 =?utf-8?B?bVJOUll6cVV1M0hGVUd2Sm1MN2xpSEg2NUZLZitkRlRCNFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGZmNXZPZk40M1ltRHB0TmVZRk1BSWZWOWZVUVJ4QmF5ZzJtMTFMOUdCWjZu?=
 =?utf-8?B?dEpISzVaL2lRQ29LK3h3MSs3RTFlQWZ1T1BiWVc1ZnBxc202aDNLNjdJZ2JR?=
 =?utf-8?B?WTljbDdhdzJQZW1VZTFGZE1iUUZaeGw5QWp5eWN5NW9UWm9nVHlnTkJjSUoy?=
 =?utf-8?B?d2J3TmhIak5wb295VGJVTmpBY0N6UGxXRktCMHFrSmwydnpEZ1NGcm1tazlW?=
 =?utf-8?B?aW9nbk1aRTJScm11RkpFWlQ4dHIxMCtwQThqbjRqYy9uWXlYVG1LYnFOUTBQ?=
 =?utf-8?B?SHpNbWdwbTlPekRhYk4zNG92blNoTjgvNU1OaUxsVEVTQ0FTNkxkOEZ2bzVU?=
 =?utf-8?B?S3BZd2dXLzBxUjhjVlgxMW5NQmpQS1REMnVwb0g5RHFRVDdOOG1MaFcrL1JH?=
 =?utf-8?B?eW9IZTIwUkx1STUyajg1OUpUUVBZMm1rdVpOcnpYRGdhWmRNUzNwRmprMGR5?=
 =?utf-8?B?cWRibCtxK3hpTE1IeGxCcHgxYTVhQklxWUZrbSszdVl6dXBMTDUrUEtNc1Jm?=
 =?utf-8?B?Z3pVTEswUnFNQjBjZmRsY2ROcW9JQXlwUGM1SDRIeUt1THdpeGlLQzA4OUJS?=
 =?utf-8?B?cEFFcnBRWm03aG54bi94RTJOOHVsVlBTK3dBbUNwdi9laCtyZ3QzeEN5Vnk3?=
 =?utf-8?B?aXNTU1J2dDB1TmVKajNzZDBkd0V3M0ZhcmlEbmcwcVJtTmZvalM1WUhsTm84?=
 =?utf-8?B?bTU2NFRRK09NQTlqNXRyZnhIa2dLczZaNGFqbTZsTC9ZRDFKZzBqdDRhUDdm?=
 =?utf-8?B?am84bWNVR0I4Mmk4RWF4RHZDaHg4aTFWQ0puWmJlMjJEL3RkaFJOWDZzNmlz?=
 =?utf-8?B?QU5DVTJQb1hFcDY4Ymxvb3hTZkM0YjlyanB4WlZWNjc3cGdsbXVsS2hibHlS?=
 =?utf-8?B?SU1VaG8xSTMrQ0FzRkZ4RlViSjF5TmFtdGN2MDlrdDRwTWNNRHVNdE11ZWpN?=
 =?utf-8?B?YlQwakNzVXJvaitnMk8rU3hXcm5UK2RRbHJoZ253cC84My9xdHZibGkzaGdS?=
 =?utf-8?B?MTczYTJJaFdiWVBjdXZlVDM0bmx2NHltRFFJOTA1a01ramFPVU5XanQydUVY?=
 =?utf-8?B?MUVDZy9WSVQ5Umd1cldMdlVzS2FUeHhKdEFIMUVseG9IODNFL1AwRjRWOXpK?=
 =?utf-8?B?c245dDVLYlpwRWpoRWcwSUM1VnlhQVJtb0pIV203TXRwaXBBc2dPVDF5eVVh?=
 =?utf-8?B?YW1Vd1ZVaThkdHBVdURQZG1lTkNnYXZpdDNpMGxSbGcva05INXNiK011b3RR?=
 =?utf-8?B?cERWb1o5SThWZTBqZEIwMXhIZFNtVDNNRkZsZGVqOG9zc3lOVm93ak95QnpI?=
 =?utf-8?B?R3d5dnpzaGowNjJoQ0F4QlEwUlZIWURVVE9aZlpIajJ0UGszcHNWS3o3UmJZ?=
 =?utf-8?B?SEMvM1FhTlZ6Q0pock1ibzZaTDIycGhwRkZpSkErb2JBamlrcXFaT2tmVFBz?=
 =?utf-8?B?UHh3ZWJIYlZsK0QzRlloS3BCQmNBc2FzSCtTZTFGa3pPcmxvSEdBOUdjTE9R?=
 =?utf-8?B?MUlBUFIvN2NXYUlJcGQ5RzlTSmlWUkVTcmJVRmN6eGxjdDRqWkVVOWdqbnZy?=
 =?utf-8?B?WHh1TzFqdUdIUmhEbE52K1lRb1VBTE5PSzBrTGJxNkZLWFdBSHF6a3FJRVFm?=
 =?utf-8?B?aFZVQzhOTkJQU3FGSS9EZTNFUFd6K2FRMEFOUUk1VVQ2ZXFCNXpUNDNrS3Z2?=
 =?utf-8?B?ZGhkQ3ZEVzBHZFlTOW9QQlNkRDlZWFcvaGtFNE43TXpoVkNSbDRhN29TdWFr?=
 =?utf-8?B?NjhDQ1h4ZE5ZSTNVbFRMczRWUjJrQVVoMlZGK2hyczN5Q0M4RHJPV2VoK1hx?=
 =?utf-8?B?enNoZGF5Q3JTNmxISDNqU3pJYjdqY1F0a3ZuUS8rL0JIUFRNRHZYRWVmTTUy?=
 =?utf-8?B?NE85R2UyWHFPNEI4aURpbnl2ZE9wRHFKU3B2K0s4azBMZmtrVTE0ZHljcDRj?=
 =?utf-8?B?SXk2OGVLcWNLVEdFelJ5em9LeHBWV3NYRGJUTHo0SzZtNU5KaEtrZkF5VWZz?=
 =?utf-8?B?N05jZ0pVRDRGVWtUQ0t2NjR5enNJdGl1ODV1WFFZS3FVcEUwN2FTWndqb2Fz?=
 =?utf-8?B?dmUxUlZYVFBab2xxOG5OMU5rcEtQQU5aeVZEQWU1MG9iTnN4M1NhL2JIWFBn?=
 =?utf-8?Q?8wqWuRuGTKzIauIgkpuWTULCS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d4c49f-e8b0-4a8b-190b-08dcd8402609
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:20.8324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zk5B72+3nF8YVSBRk2Pusme4CImSNag0oQwPhqNhkFMFfxyKRxgFm5p6VAX+Rw54Q3xocDNPDbjW9OnOVrVleQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

Add trdc_mbc_blk_num to get num blks in a MBC mem slot, then drop
the hardcoded value '40' for NIC OCRAM configuration.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/trdc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/trdc.c b/arch/arm/mach-imx/imx9/trdc.c
index ae1a46d1331..ef0f8b52a4d 100644
--- a/arch/arm/mach-imx/imx9/trdc.c
+++ b/arch/arm/mach-imx/imx9/trdc.c
@@ -19,6 +19,7 @@
 #define MRC_MAX_NUM 2
 #define MBC_NUM(HWCFG) (((HWCFG) >> 16) & 0xF)
 #define MRC_NUM(HWCFG) (((HWCFG) >> 24) & 0x1F)
+#define MBC_BLK_NUM(GLBCFG)	((GLBCFG) & 0x3FF)
 
 enum {
 	/* Order following ELE API Spec, not change */
@@ -154,6 +155,22 @@ static ulong trdc_get_mrc_base(ulong trdc_reg, u32 mrc_x)
 	return trdc_reg + 0x10000 + 0x2000 * mbc_num + 0x1000 * mrc_x;
 }
 
+static u32 trdc_mbc_blk_num(ulong trdc_reg, u32 mbc_x, u32 mem_x)
+{
+	struct trdc_mbc *mbc_base = (struct trdc_mbc *)trdc_get_mbc_base(trdc_reg, mbc_x);
+	struct mbc_mem_dom *mbc_dom;
+	u32 glbcfg;
+
+	if (mbc_base == 0)
+		return 0;
+
+	/* only first dom has the glbcfg */
+	mbc_dom = &mbc_base->mem_dom[0];
+	glbcfg = readl((uintptr_t)&mbc_dom->mem_glbcfg[mem_x]);
+
+	return MBC_BLK_NUM(glbcfg);
+}
+
 int trdc_mbc_set_control(ulong trdc_reg, u32 mbc_x, u32 glbac_id, u32 glbac_val)
 {
 	struct trdc_mbc *mbc_base = (struct trdc_mbc *)trdc_get_mbc_base(trdc_reg, mbc_x);
@@ -383,6 +400,7 @@ int release_rdc(u8 xrdc)
 void trdc_early_init(void)
 {
 	int ret = 0, i;
+	u32 blks;
 
 	ret |= release_rdc(TRDC_A);
 	ret |= release_rdc(TRDC_M);
@@ -397,7 +415,8 @@ void trdc_early_init(void)
 	/* Set OCRAM to RWX for secure, when OEM_CLOSE, the image is RX only */
 	trdc_mbc_set_control(TRDC_NIC_BASE, MBC(3), GLOBAL_ID(0), PERM(0x7700));
 
-	for (i = 0; i < 40; i++) {
+	blks = trdc_mbc_blk_num(TRDC_NIC_BASE, MBC(3), MEM(0));
+	for (i = 0; i < blks; i++) {
 		trdc_mbc_blk_config(TRDC_NIC_BASE, MBC(3), DOM(3), MEM(0), i,
 				    true, GLOBAL_ID(0));
 

-- 
2.35.3

