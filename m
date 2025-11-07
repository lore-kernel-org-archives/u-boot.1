Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619A2CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 04:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3CF83C96;
	Fri,  7 Nov 2025 05:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eQMiXRda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 209F483C60; Fri,  7 Nov 2025 03:13:11 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9AC783C40
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 03:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzzywM0G5tOolCgix//OE+82DAaUkw+rR1E0SIhPVnW7oJXe3dDmVdL/spOBIHD62pEhpUZgIFSpdElbI8MXJBLbZ2lkE03n1Ums2yfs16nKx1KWdQL2j9bUxj5/3GPRdnhi7q8gjxGSU66SMGj4ToBiARPcGEyOgjeIfggN7VSLThW6tiArnSOlitiVxS8CoWXlpiKwNDDxY6gEs8hEj2kboLkLRy5LTxe2mlEl8u13fwBOjJI3c3Ajby+8miC3xH4iVA4GS48txLsnqZajwpxYaVfXj6ib/Np2I9cphlD9ZJBfe5w+f8kZzz0j1vCH/P0MoM47xt+FQTuOY57ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQqY1+Peayd4zTI+6cgea8Wy7V2RFWrAThTAWWx04zA=;
 b=v0yk7zwUtYe/+MQYeyQlqoxHBMfISMKou6TnzTVSW9oCCXfPYcP3Bq/drcg3Gm1kmoW8FhQSaj+b3NaSji7bc3XSqnZ0589yP7aWNdfnXIMyME25K8yh76La7J+i62JLAzIMjo/TX3xHOj3EfXNVDeDC2nOwkwH8Cd9jkZZ4gj5flQS1t3XHTbg2l6dAgAOBGvc6+les1lQDMlXep5uuJCdod2Ny/+CTtdWh4RUCwvA6qkW3iHQUndrJp/tVFqQg6cERdfh0Prehq3+nbvw9c/0m74NwKu3KULnVm6BkeCGbW+3VmGJHjWPfzXc/Zgd4R/8K2Wo9izUYLDiE6N1Euw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQqY1+Peayd4zTI+6cgea8Wy7V2RFWrAThTAWWx04zA=;
 b=eQMiXRda1bh/G7yxLy4riod/WiN+3TLxGMXJSil8SsyLb0QwyAAUpyy1aOdEtji3291PsLK7nR1CLlsNnLZhI2u3C3kCDg5D/VN6erFDp8+f4v9yznZIt0TvZhFCHLGRz2eJHECPn/BArB5SJC8pXrA6XZNboTajNfuWs/VUrWXO2EdE/781iCF/fqx93TXHHO6bhL5Qar3UGxtGARDi/N2coen8eaEL9DvauCULpu2CzXt4IVTyO06n/bprYnD0JIO8jXPeGr+gtt1owJIjsLjRV07zcPoQT9lnNj+SIn25MgMsUZBzlsQX6yyxQEd+Px4J5EVH9f/qmowoOyQlpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10484.eurprd04.prod.outlook.com (2603:10a6:10:564::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 02:13:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 02:13:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Etienne Carriere <etienne.carriere@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
Date: Fri,  7 Nov 2025 11:25:29 +0800
Message-ID: <176248589257.804143.833356483859501792.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10484:EE_
X-MS-Office365-Filtering-Correlation-Id: 173f86dd-0e4a-4c96-4c72-08de1da330c3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmdvR0dkYk5HSHoxS09UOWZyOWdIaUM0eTZIZTdRbm83STVEM0xhbjNROVpi?=
 =?utf-8?B?SlgzMitDVzlXdkcxcmNyajlseWRuRHpwUWVmVzBxY3F5TFMvdlZaQjVXaU5k?=
 =?utf-8?B?akNKNytBY2N4M1BHQVZrdThybFR2R0lpUis2ZTNuajMvOGhnaFJZT3pBSkgw?=
 =?utf-8?B?cE83NXZDY2xCTDAxNWJaRkhRR3BwcGlaNmdnSU5ubzhIWExyTzlJUUlEdktK?=
 =?utf-8?B?SmowOEdDWlU1NFZQU1poLzdZL2FCd2ZZTDdDM0dhdGQ1OExvaURXcW1lNVhh?=
 =?utf-8?B?MFhNZmV0MWUyUVYxNVRxVzZFUGVKZDhHQnZRRWthNWIxaHVFTExkVUNVc0V0?=
 =?utf-8?B?Z053emZ0dzJZNzhlYVZMR2YzWFpFdzhWUi9BbnE2MjRpMHUyZnlaODl1ZnZW?=
 =?utf-8?B?SkdEd2czN1RUNnpQenVVcmFYS3YxN1NrZERLV2padUhrQ3V2aVRkYngwZjJs?=
 =?utf-8?B?NmZ5VmxPVzJaWjQwa2RjS3ZmdE5kcWF3VFZVbXAySHlWYldsWjhiUm5DMVdI?=
 =?utf-8?B?NFNFNGpaMnI1OStyVG9xWGdxZkIyZTVRZDVpU1NXelZLZndCVVczZWdqcjRp?=
 =?utf-8?B?ak1xZjg2bmUxRytPZG9VZGttbUdtYVhOODNHSk5ueXR6WlZzUDhVNlJVZkJ0?=
 =?utf-8?B?NTRNcU9UcENnL3lmVFVRTEU5bnNub3RVNGtTVVBvbzltMGxzRU14YlBIZjRY?=
 =?utf-8?B?dGdGVmhLK25nY3RnTXRSczBxcEFxcGVQdUJDbGRCbUp0VjMxblI4K3VRa3Zu?=
 =?utf-8?B?ZmF1OHhmUEYxNVArNTRaNlJzbGtNZE9GelovSlJsd085MDNzWitHUlBiTys0?=
 =?utf-8?B?T21VUkJiU2tKUEpXMDlOWHY2VWJOdnYwVWF4MmQvSm9EbDdaMGtuSVNtOWtG?=
 =?utf-8?B?a3hwNkxnMWY5M1UrbjZ5UmNFVFVyc2txc3JVdnVHY3JDcGlxNHFZRFoyTWhT?=
 =?utf-8?B?a0xyNTFxUVRIb3UxbjlycDNVZko0WjlWL0JNOHpJdFkyRnlXdUV5dDdHY0xt?=
 =?utf-8?B?OVZyZU5ZN3pObnU3YWNiVkJGMEtLMWVDaWM1Y1R0QnZqRkhMMWxoSm1QUElk?=
 =?utf-8?B?YkxlRm1SdVdIcEtvTmFJWmk4N1VpYWkwTzQ2aHZvZlJLWEI0RDB1TjJ6ZU5o?=
 =?utf-8?B?dkxTOGhDTjBIa0N0Mzl0RXdaK3RnQTQzR1hPTVBmRnRjU2w2VzlwaWhSY1h4?=
 =?utf-8?B?cVlnT1NhK0hOS01BNEduU25TYUxBN2xMU2NkOERtT0RZWUZGREFDUXZxMXo0?=
 =?utf-8?B?ODVRNVk1K0V1NndFMzFWZ2JnQkNzb2FwNmhLcFZYdzBZVmxYY1N4R0diR3hJ?=
 =?utf-8?B?alVrQnhBUjRlblZrZGZJZ3FJVFFjSm11WXBzNCtUNlJ6UkY3Qk9KUWMxUkVX?=
 =?utf-8?B?WUovUkM2RGRSYVhEeVhydEFRVkF5eDB3OUF0cjhPcXNpK3BFaUt5ODBTY2pV?=
 =?utf-8?B?TWM0bjRBaW9TVWlOalkyZFBkdGZ0QTZSSDFWQ2ZCMS9MYkdtOThoZSs4QlF3?=
 =?utf-8?B?UTFNbExzbnlFZmFnVGxWWkgvK3drRm0zUTVhd0VsaDlPY1R3UEtVUEhEMGZN?=
 =?utf-8?B?OEJIUVpsa2tGUlY3S2VkcUsrRlNqZStVTkJuWFhsKzFUVWtlMHlvZHdKTjMx?=
 =?utf-8?B?bVo1SWwvOG5ScVZMbnRoNHp0UU4wcC8zSm1PbmZYR2l3aHR5SUpTdmJhMndI?=
 =?utf-8?B?R0hOeHk3SDNXdHpKcjlSdEVoclpqODh4VE5YemdwWkRrQ0d3M0ZzSzVRUVpu?=
 =?utf-8?B?RVBxN1pucWcrdm92d0xZZHRjRWhQbGhpc2doaGxqSE1JTXRWQm8xYlRqTjNv?=
 =?utf-8?B?ekp3M21CWTI2VCt1b2Fhei9rL0VTRWIrSTRTUTFMd2RkZy9kT004ZVJWaG1h?=
 =?utf-8?B?SUd3aWpjUnNVenJYeU1jWUNyRGt6Ky9BMkNrclkvaGRoUEl2Y2Jrd2laeWxa?=
 =?utf-8?B?bytKbEdKb2p1QnhVZmJzKy9JVUlQQS9OWjZvSEIrbWZodThPUmE1NndqWk96?=
 =?utf-8?B?aTdiVXVWY3JsK1gvak1saE5RMjAwK2NXbjcyM1d4UGFQVkNwN3N3TDhQcVZK?=
 =?utf-8?Q?vI/mTd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxldi83cUYrRDBXeW0yNnU2WExFdlZSNG1lTkJRQkhkY0FEcFdNYVRDNjBi?=
 =?utf-8?B?MSszd21vNE9HT0RLUENmQ1ZqdTl4WEdrZDEvL1FjaVRUVTBLU3U4NWRSR2Rp?=
 =?utf-8?B?NXgwdEFaczRtd2dqSVpTSURLMjFYNmJ4SS9xVWgrN0M5cWlIOWt3RklHT2lV?=
 =?utf-8?B?eXluZ3NRQng0OUtaM041S0dESm9kM00wWE1JTTJGV0I4YkR1enUvaWNsVnRI?=
 =?utf-8?B?V0R1ZmdDWWNHd1pWMXpoOVNVOVVSTUUwYi8vWlh3QzN0LzZVQzlPcVlqemNM?=
 =?utf-8?B?eWJRRFlKVXlqcjdMOElGOHBsQXZ4dmhXZ1A5WjY1dXRJMFdRbnFLTzFxYzUv?=
 =?utf-8?B?YU1vWDc1dVJHSmF5TW1GMTJyeGo2Vi9SQnpaOHR0VVcxOC9LamRHN0lXYlRj?=
 =?utf-8?B?M1NyTk5aaFlMVjNZa2FVcCswclBVQlFrYjAxcmdCRjN6Y1lIelZkVnVlZnFL?=
 =?utf-8?B?SnhwNXEwUW1IeVdCRTE0Z2dsNTR3Ny93ZTdsb2hGZmR2MUZhdGVEZWJFNjYx?=
 =?utf-8?B?dTljejZLZXh0SWgxcWxsNVpOOXdBZ1NRVkxaOHp0WnZBRmFGRlFJRkZJZ0Mv?=
 =?utf-8?B?WFZkSk9ENjJpeDh5R2o0TEZhRFUxWFJsczdBK2dHZ3kwRGg0ZFNscjIrUTZK?=
 =?utf-8?B?UFVLVGNSVVRQeFVBbldUWFQ3N2JDbzVIdFJ5VlNyTlZOTjZOaXBVVnlXZlhv?=
 =?utf-8?B?TW5rWW5sdXRJRGFidHpYb0RFME1XeFhYaElyT2ZXOEo3WkllZXViNmFlSmJJ?=
 =?utf-8?B?YUhSVk5JV090UDFPRklXZjRaU1lWSDRZVUNwOWFlN1FSaE5hSUJoK3JaTStI?=
 =?utf-8?B?UDRBMXlDaEl5MFZNU3FRTm85WlU2enhSbUNEb1Z5a3hWUGUySldwNUkrSzB0?=
 =?utf-8?B?NnV6ejNab214UTZHU1B0OFF5VnVhNm1yT1oxeWRyUUxzcGhlQ2paWUl2QUFG?=
 =?utf-8?B?bzA2Ny9jUmdETE44SS9UNjk5akIyMUdJVE8vaHpCUEdFajBwK1JXa215aitv?=
 =?utf-8?B?bFZkWllRNHVXYWJrSmwxL1dsUytHdkF2eVF5NEhpMWdoQkdzZ0M2c3NqZDJi?=
 =?utf-8?B?WmlSeE5XTUdUWEp4em1PejQxWTlNQ0N2YllZMjc3UDllVnZRSExOd3JkeDNp?=
 =?utf-8?B?d09nWDIrbDFMeDFvdjEwaUpDRjEwQStuY29UTjR0ZTYvVzBmaGlVV3hHQzI1?=
 =?utf-8?B?UXB1YnZPTVpLa3gzaUh0TnEycUhYUWY2MzJIUE1oOWtWWGd6TmRXcVJyL0RW?=
 =?utf-8?B?bW5iQ3UwS2Z1end2WjNqbWFMVnU0cU5HUE1aSG5aYUtrSWs2R2VrTjdNcXN2?=
 =?utf-8?B?bDIzZnNLd29aVXFic05ncFgzNkxRNVNveFMyS1pwM1J5SFpNS3BOSjNVRkVh?=
 =?utf-8?B?WkNJWlVGTno4SkdyeUxNdHFWVWQrSVgzajZ6THAxbCtUNFBDVVR3czl3a1Vr?=
 =?utf-8?B?YXFKQWpUUkttZS9UVm9nZWgrRlJQbFhMUnNjTDNONTRPZ0dSMDB3bm9RMEZk?=
 =?utf-8?B?Y0JNTHoydUhLT1dCNWI5TXR5S0xsMExUaUR3WGo1dWh6WWIybXJVSHV6RTE3?=
 =?utf-8?B?TkhuMWthUzJrRExWYmxMeGVZaHR2M0lFMDFoUDdwNmt0TXU2MVI1bEMvT0Rq?=
 =?utf-8?B?S0R1cHlXNjJtOTdZVEtpTjRzL00wUVNTenc3SDdxNExxR0JvNlZhN21pc2h6?=
 =?utf-8?B?Y0FiZUJCczhwM0dXa0J6bWJlZDV1SUU2Q0tvREY3RlZHbUpDa2pvRURJUjFw?=
 =?utf-8?B?Rk4vZjYzcVQ0QmZId2RpbFd5R0NCMDkxek1WR0ZNMVlVd0toMDM2UXdxbFhv?=
 =?utf-8?B?R3ZBSnlwZWY0Zmc4RWhFSUYreFl0bEJYY2s1Y2prNk5zbW1NQ24rbVY5LzBi?=
 =?utf-8?B?TWRxRWpjNXY5STh5QjNxSS9HZzRkTVIxS0pLNG9pR1NzVVlTMGpSQ0xvamZU?=
 =?utf-8?B?clF4L1VkQzl2UHZVcUN2emRvZW9PcWdONmRYSUlCT2l4R1VCUFRON0VtVjhU?=
 =?utf-8?B?b1ZWczVLT3I5S25iWUpBeDJ6U3orOEV0dGNMZzJhUWRxVGRMYThQSkhybzlI?=
 =?utf-8?B?NE1NNE5heElHb0dEalJOZkM0a2JVQ3M2bStFN2x0ZWVRZzJTQWVFSUo2aHo5?=
 =?utf-8?Q?RTUvChX0O5zD7lyOTPoPJ46ap?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173f86dd-0e4a-4c96-4c72-08de1da330c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 02:13:07.4201 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5k9Y9USR+vCG+L/u1EbYj0XlV2XRkRfaxapivinsmYKvjN0AOm1fkYcsjQ2klwKYizjLUZY58x45mpe+kbpUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10484
X-Mailman-Approved-At: Fri, 07 Nov 2025 05:40:31 +0100
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


On Sat, 25 Oct 2025 23:35:09 +0200, Marek Vasut wrote:
> MMU region cache behavior configuration for SCMI/SMT mailboxes is
> platform specific. Even on ARM systems, the mailbox memory may not
> even be located in any cacheable MMU region and may instead reside
> in some SRAM. Remove this non-generic cache behavior configuration
> code from generic code path.
> 
> It is unlikely that any platform is affected by this change if it
> did configure its MMU regions correctly on start up. Platforms
> which might be affected are i.MX94/95 and STM32MP.
> 
> [...]

Applied to fsl-qoriq
ext, thanks!

[1/1] firmware: scmi: Drop mmu_set_region_dcache_behaviour() misuse
      commit: 3594affc210b890b322961c2e83eb48e4b0061ca

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
