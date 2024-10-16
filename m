Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB51ED206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:20:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BEA688E3E;
	Wed, 16 Oct 2024 09:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tw6oNbj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE2088E31; Wed, 16 Oct 2024 09:19:29 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CC088DED
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egDYTYz9TJAX71SgFwohcvl1fs8UqVpS4KLoVp9N0g5VhEYQFvfHyy98ivSVjLBi4UJBEqVS/KVURGfRvWR4n8hj0/AO3npJeoyeVsCW3ZRmF3U15K9n0I39uSG+UNpOwmIxvv0FeQgutwHMZLs+73618SCCb3+WgIpgbLCK5q6OFfyfFtp7S+iGW5dSvz4CMMy0yCOz+HIf7m6VOy5P/51FwnteiNPvQChBVVTic8ZKAkTPI8eRKwFIC+QWnOsSlAAFsO9XQ+LAHBz1HMZe28JZx+7BpmbtcD28n3PRBC+UsgnlX5iDcy8yxninQCWSP79QT7TyOi1Uq0InZHInkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82u0Exb2x3qu1qoFGu3C2wpRPHztr0u5U24loB6VySQ=;
 b=T6aTjzBB251Zb3zD9Q2tfMEdgy/XCX0faIBPRQqjaqfufnwR+HPSVprhyKv8BppXEp/22/a6EFwiQQ08jUY6m+Fj6JgEMFnTpAeRh65JSHZW0tJxpm0w8LQWW9f/INs9+msOR3slTLOmd1PSbe5UdvlwbxCR5n4OYnHe+KmiWhNbBvgNyaTA65Pr1PhNcZwrMNyXjlLGgXpqMf85pqkHfAxAqsqX88i0iyCalaLzOD3DIuC0Fp3+S8lwl7XQuuRhgollu87V05vgef4UDn06jPJZJCS1ownpeMnVZ9UAiJhZQeWaNVz7o+fFKspDiwlUGIWyr8ZaiComGOi2or5idg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82u0Exb2x3qu1qoFGu3C2wpRPHztr0u5U24loB6VySQ=;
 b=tw6oNbj3QTfKsgGjc05v95pRkzApmILoynuBTzR2agu1nP/6ovpCmls45Iq/m7AIDipl4Qu5F7ekcRRbU+a7a+pnIUwRMX2YiAXilDKilL1tUkR7dQcQA5eS3ei7E1LfXMTQey/gtul6DanY5GbbhPtjEpa84fclnnGOhygvKIpuGH7AFIrO5CV3e8si8pcALSVOuK5Pzd/Gk4cryqI8UtNME/XwUU93xUiB1bMUz4wSViCX5EQgyBBEI9qtnsrG2D6ZS3azwYagHw4u9pnksa/AbQv61PkVAmjps47+SCj+rhkg0/IMM2ExSMjZCf+4iZ2O+SoExEFKscNPcwX54Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB10235.eurprd04.prod.outlook.com (2603:10a6:150:1be::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 07:19:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:25 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:00 +0800
Subject: [PATCH 07/17] clk: scmi: check the clock state/parent/rate control
 permissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-7-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GVXPR04MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ce4bc6-b48e-4635-46b4-08dcedb2dd2e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2JVdER3MkpuMUh4U0xqMDg5RkNZMkZ5alo5MlJ0WlJnTlVqeUNCNENVT3Ri?=
 =?utf-8?B?WTl2eWprY2krTXpSNy8yS0Juc0hrQVhxbDA3bWNPUXRld2FrWTJuT2o2bDJT?=
 =?utf-8?B?R1lXNE04RzRTUVJkL3B5NHQ3eHpWRVo4eENjVG5ZR0UzcFNvd1BETG1Cemht?=
 =?utf-8?B?QmhWd3dVYTM2MHRvLzh3SVVucGZ6Yjk0SFBjdkRLR0RZQzZwZjBCM3NlazRx?=
 =?utf-8?B?UVZKKzRNbUtldkhPTEtxZVp0RVlLTkJNUDdVOTZvcHY5UGVEeHJQN0liUGVh?=
 =?utf-8?B?NzhuUTFlRkVZcHEvWGUwSDlUNS92WGY2bE5xNUFLQ3RmQ2lYZEJQTStwK1hK?=
 =?utf-8?B?eWk0bDJodWxWTG9XVVg4K2VTMHh0MnFKVk5QVHNSVVRYTll0TnlnUEViaHNW?=
 =?utf-8?B?eUx0bmJCYVN4bDFhSVluR0VqZlVCNWhtOVhrbU1ZYXRWSVZERWpTZEwrOHZR?=
 =?utf-8?B?Y3hRMSt4OVh6WjgwcEozOThqM0h3NnViUFJqUS9GTkdrNXFpUHkxSHJ5QWlC?=
 =?utf-8?B?YzY4WllYaW04YWF0RTEzam84UHhoQjl3Q1R2WGhSOUwrQlhaNkUweFU2RlJp?=
 =?utf-8?B?QVNnR3prSGFaNEJ0a0tHK3J1OXdSWlMxcGlUcVdTcndndGMwQS9uT0JuWnVy?=
 =?utf-8?B?d2ZxYVo2VTJzU2hKRm9Jakk1MHlSODRhdk5wcE5hRitWb2l2ZEVYb1g1TmNN?=
 =?utf-8?B?RFZsL1BtNVI3ZEIwVHlqbys5TWw5TDZ0OVBZaHZqZmgyZkVzczYzUm56N2pV?=
 =?utf-8?B?VDF0R2l0cjk3TU9wMGlpQVpXWUdqSnBhbm1PeFNhZU8za1BlcXh2Zkp5TnA3?=
 =?utf-8?B?eVRNNytxOGNMWXhFajFnQXpQdWFSWTdYZnQvbzBleGV1YTJqSFZpRVZCYkR2?=
 =?utf-8?B?cU1mT1BIVm4wTGpwa1N2cTlKQ0R5SkF1bE1Yem1aQWwzODNpdi92a1N4UURL?=
 =?utf-8?B?Q0ZtL1NaYUJLOGRzeUE2c2pmV2JVUFZidElxQVZxaEh1ZDhXMVNCSjMzbUdU?=
 =?utf-8?B?ajU0bTEzWGNPL1F5Z0pkaEVFTzlTV2UrdFRWb0Mzc2kzd0NlSmtVcG5TbnFS?=
 =?utf-8?B?dGFGOTdRK1QzYkFDeitZOXVQTVlSa00rUkRsRWZJMjNvODMxczVsVGVFNmRl?=
 =?utf-8?B?UGdIM3I2bTRYMWIxK0Q2YzF2Y0JoaGtpcDR4bVlwbWVTcGl6aVhQY2pyQW9N?=
 =?utf-8?B?MnViUlRsUE11bHo1ZmxpbjRvMU1GV0xDNTZtRDYwSHdQZVJHSUNIRGFIWE96?=
 =?utf-8?B?YTBzUnllZitOOE5PaFdPaHFRRWpTWi9zcGI0OFZlbnAxU3JkaFdrOXhIZy9F?=
 =?utf-8?B?cjBmN0xiUUhSUUhzOFVCNGhUN1laM2F1eDhrK2dGeTBNUUh6dDI0TFVtSUdR?=
 =?utf-8?B?SyswdE1xdlVPVUdRcThOQ1BKdjZjRExNQXRyQ3lkU0IrS3JVZmYxS05rL1lS?=
 =?utf-8?B?ZjgyRVd2ODZTZ0VoVWVsK3ZJV3R5QkkyN0NobWxXR1EzTjlldkpZaDFoYjdy?=
 =?utf-8?B?SzBYbWdQcG1rVStmTlNqaGF6Y0cyMHVCRm1LSlYwSFE4NzU4Z204ZzQ2Vmt2?=
 =?utf-8?B?aFIwdU1vT3phSTFhS0w5VG1Qa1NuT3l4T29Tbi81Uy9hdUJKNmVkWEFSdk1D?=
 =?utf-8?B?azgvdXp4MERXalpnUkJ1WkpMNmptVnhvK2c2bDhzQWlqRmFpMCs5NTVsTHpR?=
 =?utf-8?B?Sy9wREphZlU5Tk1SK1E2Z2sxaXREY3FJUWVlZXhlQklWVk5NS21QN2xXWUhq?=
 =?utf-8?B?cytua2kxOTBDRWlNVFZxU25Rd05JQ24wL3BUMHpYcFZaMlhoeVJvV2x4eTNa?=
 =?utf-8?B?OXIrVzZxeW5GaGw1Ujc3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGMycDVZaWJLTG1JNEw4bURQaTVVWTllZnFnSVh4TmRpdHc4MWs0SFBUb091?=
 =?utf-8?B?NjNTQXRBcWwxMWZ6aEpyaXpCTW4vbldCdDdIbnZKb3llMmJ2Q1l2aGhqNW1O?=
 =?utf-8?B?MStIQ2crZWR5U05TTW9lLzlPVkZpeklLaHljRUVyQnQwMnBLUVhzdjVTWGlM?=
 =?utf-8?B?Q0xML2RDam5QOE15WkFzNHpvT2JKNEdxWVpRL0k2ckJ3S3A2Mkh6KzRMc01Z?=
 =?utf-8?B?MDN2RmlkNFNmbGEraGtJb0pCbzAxaHhRaUZuUDY2RG1CdWdBam54NkR4VE13?=
 =?utf-8?B?VnhwZ0xteTE5QUJ2VE1nckx6MThvRmRWczJkem1ybElFaVVldjJOOEpkMEhN?=
 =?utf-8?B?TVRZTzhOOTZrZmUwUjNsdjVQZnB1NUhyMnhMYUlEUjlBaUJwbDRqQTEwVVhU?=
 =?utf-8?B?eXJUOXByMGlFMHpaZzA2Ris3cmFvOVkvU2VXL0RpQVVPK0U4OHRzQ0pPSWo1?=
 =?utf-8?B?Q1dPWWlZSTI1NUNoOGJVRmQ5S2tzZndEa1BwMWxTaDM2bTU4cWRUQnkxNllt?=
 =?utf-8?B?aGNlcm5sc0VVV0FreTNoS3AzTW9PSzJsRDF1NWk0TEREQWtYR1JDSFpELzVF?=
 =?utf-8?B?TzJzN3NmNUlkaVFBQmlSUHc1aEViTnZaaEhGdGUvWTRvdGlueC9tc3ljTEVz?=
 =?utf-8?B?dEdPL0tvZFM2bXNHcXNsMDNRQzRsMmxNcXZCTExHSnowUW1jUXlWcy9SOHZS?=
 =?utf-8?B?YnMzRnpYaTZPMlVRblh3NHBFK1g3cGhNQmpiQjBGT1NxMzJjMlFvWDVPaUkv?=
 =?utf-8?B?U0MrQi80aXVObnVmVFdwZHo5enVZQnFDOTRrVlBFMHNtMTdISURSZ2NndHZE?=
 =?utf-8?B?bWx1K0JVTktZVlYyRnRGc2h2bGpUejlFRThza0ZKWnFQNzBVRFdTUFdRMHU1?=
 =?utf-8?B?dk5Pdkc4L3ZXKzV4NzlLWkJMcndtUUlXNEZ3Um9xbXJTaVpTN2dKbWhEYTR2?=
 =?utf-8?B?ODFyTDVjZVBzelNTVGJDd21EeXdYRFBJNksvOFpxYWt3MlJqdHEwN3h0RnIr?=
 =?utf-8?B?anp6VW5SZFlJOXdqVW9lQWUrMitUdzMzNDJhTW1yWFA4cTFaTXNzTVZ2TldR?=
 =?utf-8?B?UzIxUDFTaWlKMFJhZVVxcm54N3liUFp5U1MweHZXMmp2cUsxUFhSTkR4YTRM?=
 =?utf-8?B?YkNsNGRaNXl2SlZtbUdGZGFTenZodEU2MXVwY1QxRkJuSDdyMHNKa0V1WmJu?=
 =?utf-8?B?VXdjaUZjdDk5cDU5VDRyRDJ1Q2VMNnVCTjNSQ1oveXl5Z1ZNbHFMSFFXU3U2?=
 =?utf-8?B?emN0d1U2WEVmSzkwVzJmSFhOOGtHNEJyUzBZQUNVdlVWVVRuWXViQjJFd0hl?=
 =?utf-8?B?Q0FKMVZzVmNWUUhwOE9CYy82aTQ0M2JVYXBZNzhRMnB0aFQrM2wxcjRKWVZO?=
 =?utf-8?B?UFVlSVpNZjUrWTdQNFpzTWMwUnUvNURDZDR4RU9SK1RpdlZwUFVJdzhpc2RE?=
 =?utf-8?B?VlJTNk9OWncvekE4VVRoTUhHb2JLWjFveUx6Q25rZ3UzMCtsemhVRHdOeHNG?=
 =?utf-8?B?WG5rUE04UzEwQ3NPNCtYRmZTNzVRcmRIUjFtaDNCMVRyRGUwamhLRXEwb1Qy?=
 =?utf-8?B?UU1jYk1jR3FlWUw5bHRNc2Z0UmZxZ2xEb0hPU1R3clRXOWlwNlF4Ym4vazdV?=
 =?utf-8?B?QzR5RDYzaEdOZm1aeEFidW0rMmhJbVZtTWExcTc2OXQxRmU0Y3MvbFRmakc3?=
 =?utf-8?B?TjJkSnNEc25vU3ZDNXd4bnZGVkN4dEk3aGtKTFlqM2VKbUdpSUlGcHpGM2M2?=
 =?utf-8?B?NUlLbU1OYjFZOTh4QWFqWWZrYSs1NkxmOElVbEN3S2NNUk84UnNJQVJ3RlFJ?=
 =?utf-8?B?emRaQkRKUEdQRnMycXVpZlBIK3BJbXFycCtWbHU4SWluY0VGMU9DNlA1N1Mw?=
 =?utf-8?B?ZFQ1bk5BQ2FhQUhZcXVqNXgybTVMUWhBcHpQb2ZjSWNJNWt4MnFTSnhPTjlB?=
 =?utf-8?B?NFBySjZhYTQzSE1VY0ZFYVhXc0FETW91QVB3bXJ0RzlBTnV2c1pBQThGS2x2?=
 =?utf-8?B?aDNsbkFOYzZycHJrQjRZVXpMcEl1VHlzVm9zMk5URlFLelJnOVpaT21zTnlZ?=
 =?utf-8?B?K1NpTlhTSkFxYWhtOFJ6NXRzSmM2ZWlCdGdTR1lDSmZ3SExzancxVUgzQTlT?=
 =?utf-8?Q?oWLxUsBJt07NeBvqGUwnnJbho?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ce4bc6-b48e-4635-46b4-08dcedb2dd2e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:25.1709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qA4tTnMDnFSOvjHSCEo9M8H9MpJReSGbRWEJq6+hLDHJIvVcxBJI9NL5u5NlaQqq1rq+bscvVh5h3DkqPt7OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235
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

From: Ye Li <ye.li@nxp.com>

SCMI clock management protocol driver in Linux checks clock state,
parent and rate control permissions. To be consistent with the kernel
driver, add this check here.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c   | 116 +++++++++++++++++++++++++++++++++++++++++++----
 include/scmi_protocols.h |  25 +++++++++-
 2 files changed, 130 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 84333cdd0ccfe566c269f776f39725c69883c25c..cbc7be718a5e123be8cd0865d71cff3577d506a2 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -12,6 +12,53 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid)
+{
+	u32 version;
+	int ret;
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
+	if (ret) {
+		debug("get SCMI clock management protocol version failed\n");
+		return ret;
+	}
+
+	if (version >= CLOCK_PROTOCOL_VERSION_3_0) {
+		struct scmi_clk_get_permissions_in in = {
+			.clock_id = clkid,
+		};
+		struct scmi_clk_get_permissions_out out;
+		struct scmi_msg msg = {
+			.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+			.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+			.in_msg = (u8 *)&in,
+			.in_msg_sz = sizeof(in),
+			.out_msg = (u8 *)&out,
+			.out_msg_sz = sizeof(out),
+		};
+
+		ret = devm_scmi_process_msg(dev, &msg);
+		if (ret) {
+			debug("get SCMI clock management protocol permissions failed\n");
+			return ret;
+		}
+
+		ret = scmi_to_linux_errno(out.status);
+		if (ret < 0)
+			return ret;
+
+		return out.permissions;
+	} else {
+		debug("SCMI clock management protocol version is less than 3.0.\n");
+		return -EOPNOTSUPP;
+	}
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -78,12 +125,26 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 1);
+	struct clk_scmi *clkscmi = container_of(clk, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 1);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent not have permission */
+	debug("SCMI CLOCK: the clock cannot be enabled by the agent.\n");
+	return 0;
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 0);
+	struct clk_scmi *clkscmi = container_of(clk, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 0);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent not have permission */
+	debug("SCMI CLOCK: the clock cannot be disabled by the agent.\n");
+	return 0;
 }
 
 static ulong scmi_clk_get_rate(struct clk *clk)
@@ -108,7 +169,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -133,9 +194,21 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi = container_of(clk, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+		return __scmi_clk_set_rate(clk, rate);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent not have permission */
+	debug("SCMI CLOCK: the clock rate cannot be changed by the agent.\n");
+	return 0;
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
 	size_t num_clocks, i;
 	int ret;
 
@@ -158,27 +231,38 @@ static int scmi_clk_probe(struct udevice *dev)
 		char *clock_name;
 
 		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			ret = scmi_clk_get_permissions(dev, i);
+			if (ret > 0) {
+				clk_scmi->ctrl_flags = ret;
+			} else if (ret == -EOPNOTSUPP) {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL |
+									   SUPPORT_CLK_RATE_CONTROL;
+			} else {
+				debug("SCMI CLOCK: getting permissions failed.\n");
+				clk_scmi->ctrl_flags = 0;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -197,6 +281,18 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi = container_of(clk, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+		return __scmi_clk_set_parent(clk, parent);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent not have permission */
+	debug("SCMI CLOCK: the clock's parent cannot be changed by the agent.\n");
+	return 0;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index d529f8e2697472e60d0cb9c275f34ef0ecaed3ca..8a5830d582d8baf4b4781ab860f09f49d335a023 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,13 +731,15 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
-	SCMI_CLOCK_PARENT_SET = 0xD
+	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -858,6 +860,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * 					Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.34.1

