Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2220FCAC58E
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 07:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286F483322;
	Mon, 15 Sep 2025 09:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lHaBiEaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE39833EB; Mon, 15 Sep 2025 09:27:44 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BDD8317B
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 09:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxK/+yQzlTa403+I6W77YPpJpg0g6w/RmINaTEcjzrNJSmZcgafJg1l/IB7g3dbAQsY7J6fbrXakeAThoTxDqBeEVp0HGP66scAeiG/vfvNrfD2cXCD0piQlj1xsvY52dAjEQAnCeA2pPO9Puvv8eFeOgdoyS+B7qPk4eykYFHsAjk+YTnrAhatQrehlx/FQdRn6HevhXqMWTvP3Rn35DWBlJLTQtEsYIaZbSKc5m902wbzJembyQVEFcf9CBBHg5DgFMflPIjCZtjjtHuMjLohXGlPFR+s+SnOmrizsqfjYwwlfdZVuBAodOuXxsFx69LqwkYXmpE8BUFhUBsRu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4rFNA0mZDpSZTPrLrJkZE3YHokxum8xEaoDfUgWl8U=;
 b=e0d4DOFRw0JnSYbqPuiBXiK5fV4mwOXr6DpoxTOny9KHRK6g2k4f6HQaJkLVcz/mZS2Ru6hY5z5PARMqNYDA9aJfT4oPonbipIg7UeA5j7U6JBs++9Rr7cMiFp8ae1mUCZEXwlOnelS41RPbO8+R+AXXB6xDDOAOAT/nwwpXi26g+7pyUw/2RgHubzMe7VltvR8rKZQaEPJ6BSBGjhBlecDbXRC3Luy8CgWHf35MIskFGsdVovhBWIusjmfFGyZWlTQJCtekx1h2MminnyEOUeL6VG8p1uMnHI0J11bDbD+rr0aWWHuw5neqOz253ti3RGA0fjWgcsauzSIW9/sAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4rFNA0mZDpSZTPrLrJkZE3YHokxum8xEaoDfUgWl8U=;
 b=lHaBiEaTldkhgVrpemouBwdg+1eQBH88O27/u+XXR6k99jYLPR26IXbCKpDqM5ksYUVddM5H+GBhoW34rCZEbndwi9GoVpXPYwJFzdMCuIf6iRFvP4G7oPWbWpoZfzVKEiCT64lUUpJY6YvN+ycu0invpN7Ju9YUaT6WqDwpONSGBtgGOg/OEWhoAiOznNwxlPgRGOlFCDxuhXfKQk5hSMvwz0zQOk48vuDKne07EUrr9DL20rtLg34xPdliZO8Y7AbTA8nvOY07z8EOjGKY+OdSG+qiPi8Dbc/Hc5dzN+ZVh3w23RW9+Kr9jiWBjHctU6xHXiS3PBfYqtCuMa7uqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7529.eurprd04.prod.outlook.com (2603:10a6:10:208::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 07:27:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 07:27:39 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v5 0/2] Restore support for i.MX95 A0 silicon
Date: Sat, 06 Sep 2025 02:22:02 +0800
Message-Id: <20250906-imx95-v1-0-f2a5231c1d0f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEoqu2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwMz3czcCktTXQOTlCRzMzMzS1PDRCWg2oKi1LTMCrA50UplpkqxtbU
 A7K7FNFsAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:4:7c::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f07ce7-632c-4efc-785e-08ddf42959d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXZZSEl2ak9hd3pGcHJBU2ZuZDE2YU1ucnRDd2QzR2RhTHdjWmdXd0t5NzZq?=
 =?utf-8?B?WUxiTGZ6OHZ3dnMxRHh6bkI5c3JINnB0T25CUXE1eWdSd0RDdjdUTUdreGpw?=
 =?utf-8?B?eC9JRURzd2JMMTlSOVZWNXI3WEpzVWlLK2VQT0JlbkdFREhrbnZWR1EyOWlp?=
 =?utf-8?B?bTllS2czM0s4K2cyLzdnOTkyR3grQndEVGEvVlgwd0FzdXoxd0FBVmk4UE40?=
 =?utf-8?B?WkxQUndzMlBQVTBXU0VIQlg5SGFjSHhBREdLVklxUHJmMGVPWVFyaURpaHlq?=
 =?utf-8?B?SnI4YmpZQSt6TnpIeXJoNlRmeTVQT29wQ2hGMm5ONHBoSzhrTElmQTNubjNF?=
 =?utf-8?B?WVI0WVFVYVFOMG5hak12K0w4dDVYaUpUZ200b2EwTHU3SjgvT0IrMXo5ZGsy?=
 =?utf-8?B?TkFsZ1RXNmQ1SjEwNk9jNVdMMUczV1gwdEVLSnJzdCsvR0JXREVnaDJwYmRs?=
 =?utf-8?B?K2ZZaTJvb1FxVG91S200V3NwSW15WWJMMXFJVmh2ekpBdmNyd3B4ejJDYnpE?=
 =?utf-8?B?dWw0OXdNVU5ac20rNk5TNE1YeExLclNhSnFKVU84S0VkOEJWc3pHSFZMQ1NK?=
 =?utf-8?B?S0t4NFBtWUJBY2tFYlFRWGNMQ1hJdkRhLzB6YXhhMGI3N0pZNzVKT2dxTE5r?=
 =?utf-8?B?cHU3WDJIUDQvRGtyYWtBaFJ4dXZLODF3YmY0d2tzeTJkS2tJdVJodnp2SHRw?=
 =?utf-8?B?T25ML3pEb0I3OUNESytXb0xrZEJEUkxKcXFmV2hlM1c5cWNiK3VvZWtkMmNl?=
 =?utf-8?B?bE04MElHdXV5Sy80aU9JUndtajUwODhiZ1c1bjhBdWZjeEphZ1BJZmNwbUs1?=
 =?utf-8?B?eno3MzVzNWRWUmNFQTJTSHhLTzFQQ3ZjM1FyRmlqVC9DTEk5d3NyUUNUMzNQ?=
 =?utf-8?B?dTA4bkVMSkQ1THdYM1ZscVZDU1podXZsL3o1cVRuOEtTb2I5WmVGV0lxV2l3?=
 =?utf-8?B?V0ZsZjNFcHFaQTNkdG1pdlQxalNBZVJoWnQ1RHVkL0Q4dk1vWnlUQU5lamdM?=
 =?utf-8?B?cnMvNTNkMDB0UktQeEhVTWlQNEpkUjg1cGdmaXBNKzA1eDRyS0xYLzduOERF?=
 =?utf-8?B?bmZKSnhGL1FQZTUvRldsZEI4Z0QyNHppckx3Ync5TFN5VUowZDBpN1piK05C?=
 =?utf-8?B?SFdRTVBKOEZ6OVI0ZTlmdHZBS0w5UlVrTkxVb1dGc3loODhLSFFaaW9vNzVy?=
 =?utf-8?B?UlBzbU1rWURLQjA2MjhpZlYvd2dwV3p4em8zTSsreWtyMlcvYU92QXc1ZlFS?=
 =?utf-8?B?bVNIbU5qdEdaTTRwbHNqTmExUHV0ZWJCa3ZFQmJFRDkzZ3hVS25GQzN2bkti?=
 =?utf-8?B?ZHNZTnpOY0l5dVdQVGpDZ2h6T21OMVRndGRxcWFJRlpoc0szUTYzc29TMXBp?=
 =?utf-8?B?ck5JMUZyWk41RjMwYVRKYkJ0ZXdSTUFKUWdHbWhPa0tobzFXL0NSYmdHNS9T?=
 =?utf-8?B?S2VIOGhpWWQxVFVodkVPdFk3VFF6MHg0a3Q3TjJOMmdsVXhaRHRpR2o5UnhK?=
 =?utf-8?B?MFNWSUM5eE5PSENpMTAwQUtpTTZyZEZiSFg2T3JMMmpwRnc5UVYwTDVwbC8v?=
 =?utf-8?B?YWw4R2hqMGJBd1JRMnVHQzJnUmp6dytscGQ3Sng4Yyt4eWU0TXp5N213czFY?=
 =?utf-8?B?K3FYTDFZUThCU3ZTMis0ODlrcU1wNFNqbjkvYzdXQXZ5cGg3bUpyakV0eUNN?=
 =?utf-8?B?eTVkTWdwN3d6Z0pGUkUycmdFeFpDMytMWUw4dXlUNnlrcXpmODZOTlo0enBv?=
 =?utf-8?B?WmNyb2lqUGNjUUJpVkJlRUt6SXNnVGxtVkxqVlZMSmc0aW5ZUE9XNURmTTZK?=
 =?utf-8?B?UEJoWlpuOHlNYU1RdFd5NGhRVmh1ekg4ay9CNmNEVndtWkdTNVRHbDVpcVI3?=
 =?utf-8?B?Qit0aUtDWkZMSlBlTk51ZVhHN1RXd2JvMHlDUGZHclpKVEJHV2pjUERBTk81?=
 =?utf-8?B?UWtRQW9EeHN4L0JNbWlsNm1iaDA2Q3VXckZySVFpbXJvVS9HczRrM1JWN0hC?=
 =?utf-8?Q?wQ4Nkrc1Pmq4lNX46lqnjRbQcyedis=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3pvRnZoWU80ZUt1UmdyaS8rVmw0M0hvd1o4TVB4OXI2YXhrWC9odWIvQ0lZ?=
 =?utf-8?B?V3czY2ViKy9ubCtIQkZDa2JtUkRuY2NJcVVCMWwrNnprZFd3UXEzeHNFNTkv?=
 =?utf-8?B?cE0ybHlsd0kvSFg1ZnhESTBEVm1NdThrS3R6L05hb204T3hjRFU3T3VTWGtV?=
 =?utf-8?B?TXZjZU85dHBFWUZXNEtMdnl2TWZVZWRSUVgwaG95NEpTRkh5VjlMcmFLUGxQ?=
 =?utf-8?B?SkJFRnk4eWF6ekt1clVvZUZaczZ4WDY5Q2c0VlpUYk5NRGFtZTZvUG90eW5T?=
 =?utf-8?B?YWJkb1NjQmxFTmszZVBzRXA0Qno2aDJEdGVOek43dlFiU2ROWGRiY001UGk4?=
 =?utf-8?B?blpPU214NkZMWG1NWVZtRjRlZUI0L0xvZGs5MDZLK25iZjI3N2xOZm9NNGM4?=
 =?utf-8?B?ZVRRSjFRYldiL3JaWWZTR0ltdGZBNEcxV1BWZHpxZFN6WXduYTdCUHJWSGlR?=
 =?utf-8?B?TUJvcWx0UEQvaTR4Vk12V3JwRWxhTEhpdSsyRDhpTjFIN00yZ3kzNkxzWmxw?=
 =?utf-8?B?VHRnd2NpSGVrNVJkbWljcVVLVllPV1VKSGRzV1R2dFJweVE3RCtPWVFMU0Nx?=
 =?utf-8?B?TGpXOHBCTVFNbVM4UXgrV1hjL1doWFFzZE9KKzJMR0dyT1U3V0VFL1h4WkRn?=
 =?utf-8?B?NDd1NnZFeU1xTDFFMGNvbnRhN0xEY0d2MWFmaUMyYjluZlo2LzVFcnhqTzVD?=
 =?utf-8?B?V2FUL09VSFdiTDlsU0NQNktQZDNyV0xPVWw0QWtzdFhvYk9RNU1HRFFzYkdl?=
 =?utf-8?B?d09qa3g5cXhwQnhEUlFGRmhhMHdYT2xwUDRZSmRkTmxMMWpnNFYwbGJWUEhG?=
 =?utf-8?B?V2Jpd0FpR0duemFFTHA2Zkw1SkRTUlRoWlJkV0NpdFd1TWNTYVlSSmt6czBN?=
 =?utf-8?B?SnlvUk8vcU5tU2Y5djJ2WGtMS2xiVjdFdWZjTm5NRVhSYkI5VVJhUVJCVmtl?=
 =?utf-8?B?bWJ2RjdWV0IvQVQ0aXRvaVJmVFJGTkhaNGwzM0htUk5YMUtrVnNTalg1TTZq?=
 =?utf-8?B?YW1zOHllT3FSZTI1a1hYanVlRUVPQlpGWDh5N1NWQzA0WldYcUdSVW1mSzZS?=
 =?utf-8?B?TUJNbTRSclBJdDdGVDlWTmdmdnpGR3JLbGV0K1hwNHM2OUJOMTRpR25jbXJa?=
 =?utf-8?B?SzlOUWplWGFOTVpYMEtybkw0MUo4UTExNGdZaUZxVWxsVjF2bFF2NE45cTcw?=
 =?utf-8?B?Rm1odVVKc3hWQjNxd2RQaVlINFNmM0tac0xrUjcrR2FGWFFiVjFtcEpKTTNZ?=
 =?utf-8?B?cC9CNDVZSkgyb2VFaWZjTlRVaXNiUVBybzhTeHFXVUI3SWErSWlDclNneU1B?=
 =?utf-8?B?UXdrM1BjZ1haZktwVFpKcGwzZit2VnBvRXRST2pmVnVPcE1XOE9vbXdHSlRH?=
 =?utf-8?B?WU5xaDBXTk1FWHkrS0VSVVhBREpXZFZSMk1NUHp4OVlnVmhReFVkVmpDRGY0?=
 =?utf-8?B?RUtpcGxPR3BNT1hBL1d2WG1FUmk0bUNTeVlYb2dvdmlLeDl2UytQTWRpZlZC?=
 =?utf-8?B?UUk5TDhGaVNtYmM0RzZqeTMvN1BPU1g2TnJCajA3YjI4Rkx2YXd3RFBVeG9w?=
 =?utf-8?B?dmd1djBieGs3T0VtVVVIbytqdTBrZHQzWm9WdmtULzhBRWlEZjM3VU5YWUVG?=
 =?utf-8?B?eHdxTVNKdzZERGFYeTNZNFJESFdkNDVaYTFEQXgxSEM0SjN1eWNjdExFUzZM?=
 =?utf-8?B?SlJJZklIeGJCaG1FZFEzUFYwbTZIUHVmYVJsTzJxdEpoTnRmQWdQdHhaMVFx?=
 =?utf-8?B?VjFZSllSb3ZPeCtMMGJ2aWpNRStGaHZCVjJSREJ4ZGxSMmhCUnJPYldIdUdY?=
 =?utf-8?B?QWFBaHJPenJURmgwOU12L05oTk9pdVl5REJUTUQrbkJvdHQxWGlEMDRhdERT?=
 =?utf-8?B?eVlyaGxUU1dNRFJhQWxveCtnMXNjNVNUWlNLY3V2SDduQnJndkRqN0JuVGdL?=
 =?utf-8?B?WHRYY0lyWGdBRmp1ZnNIekk0ZVpWV0gvdDRQS3FIdHNrNVJZRmlENk1ZWDIy?=
 =?utf-8?B?Z0l0MnZaUk1tcWRPbURLK2lWQTJMVk1nL3NVcktoTmo5K2tEUnVZMEVjQy9x?=
 =?utf-8?B?R1MzZG9UbEJtOHhlb2RlSWhhOEN5RXNvRzVocjU4ckZ5U0RsUmRsbVk2VjNG?=
 =?utf-8?Q?YzR3XrbSW1EffbNl2wqbehi1y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f07ce7-632c-4efc-785e-08ddf42959d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:27:39.6581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/kjMeyffYBDUTIu1H4OQFOq2h0nyZ/xR6NH89Rgh+M97bg4DIweKWKcQKeMXB5N7QCZ6hV7wBuMsi4wJY1iaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7529
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

Changes for v3:
 - update the binman etype to generate a configuration file and a .bin
   file
 - update Get ahab-container.img in imx95_evk.rst
 - rename configs/imx95.config to configs/imx95_evk.config

Changes for v4:
 - update nxp_imx9image.py and add testNxpImx9Image to ensure 100% code
   coverage of nxp_imx9image.py when running binman tests

Changes for v5:
 - update nxp_imx9image.py and add testNxpImx9Image to ensure the patch
   set passes U-Boot CI

CI:
https://github.com/u-boot/u-boot/pull/812/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      binman: add a new entry type to support .bin file generation for the i.MX95 platform
      imx95_evk: Restore support for i.MX95 A0 silicon

 Makefile                                  |   3 +-
 arch/arm/dts/imx95-u-boot.dtsi            |  44 +++++++--
 arch/arm/mach-imx/Makefile                |   5 +
 arch/arm/mach-imx/imx9/Kconfig            |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
 board/freescale/imx95_evk/MAINTAINERS     |   1 +
 configs/imx95_19x19_evk_defconfig         | 153 +-----------------------------
 configs/imx95_a0_19x19_evk_defconfig      |   2 +
 configs/imx95_evk.config                  | 150 +++++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst               |  42 +++++++-
 tools/binman/entries.rst                  |  12 +++
 tools/binman/etype/nxp_imx9image.py       |  89 +++++++++++++++++
 tools/binman/ftest.py                     |  11 +++
 tools/binman/test/350_nxp_imx95.dts       |  25 +++++
 15 files changed, 378 insertions(+), 191 deletions(-)
---
base-commit: 210702ae6ce820713773549c4e102b37f09d7cc5
change-id: 20250906-imx95-04db7666951a

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

