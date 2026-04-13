Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B6BEBFD0F
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 08:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A29E2839D5;
	Mon, 13 Apr 2026 10:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WXBVzC5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AD683F75; Mon, 13 Apr 2026 10:13:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E27A8352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWBoTJ8DB0H1SI21MQj+tm4dxGOdkmIdt0uNRcSqqbLTzrfKP6EXSzcMBzlEWgM0cpPtJuYw/1IlA/Q1ztWiT0ZbwFwr0RbNR6hu6ItqMt7I3RGQi8HKoa5/6kM80u/HrJKi+K7ZizbOXG48Sxh76gcEqSal7P/ctZsCK0pPzo28sEavcPbcGJjG7PZYCe/HDvqU2TSYBZWmTCCP0RHM/P7AaQEJABRw2lXK9aPs2A5Q9eILw8ub7Dzkvp7l+l0fdpXgsyP0gVMMw0P0zgy8/C/QmKVjUgnpPdkHi9bLFxz8a1mjIk5Zoq9+itoIDt4djTjSBhcl07b+qM3pbIOVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfZEz0gqDPucUbyzAC+EwUgkGmtcQSFDPyuM8ZS19yI=;
 b=x3NMBTpNoEKEYHN3Tl7xamZ//oKhiZNc/Z5VnIfYt7Xoh/5qZ60Twyevf7lAOLOAQq/20pJH2qnpTcKqllEBYYbbnoXLvTLGADOmlbOWDfBqXY4gaEbv/WyGkAG9+ncCH0a5KqI0PzmnZajvlt7ufyvNeI7pXpfLEqB/fnAgki4xN98nw9op5lgmZDzRWwklYZqgzfyjMAVsAugzSxPwIsp9QoKKv3IliyBbEngXTilAyL0sRAeL7Q7A6m6ifqmrrv5AV2FEhllS7mv1+n/pFEgKzq972D5+XCmFnfngtphj7ls9YXc4B3esDZljpa1CHUNFPgNf/VMSJ/CE/0+HeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfZEz0gqDPucUbyzAC+EwUgkGmtcQSFDPyuM8ZS19yI=;
 b=WXBVzC5dSB7Y9GKf6IT5nV7eZOEJv/yI4NkYIYfE6LD4T0EnWLP021Yj7CRdJxnTyh1bgbMT4VBto5S/IuGeRCl9rG2Wbglzh9AXoSwQq1VqfJ2PrJaVZGZ522tkHXj84M5rZ38ioKF3mLEmpbprEIwRNPXOToli77mug7K0TLY4NaW2or8Cnc4urRW3JwB86BbleYaEHXb1s9C1MHGQ0TZVwq7+UzhxmG357IjtxOqlKBGFRUaOIc7wVQ3wV8SRcxOuxx7lTvdqdNqUFcxusO1cPiYR6ZxMbaHlUxBwRx0gB8pfTQhgb+m/lizGl0B5NXxKdNtbq9JQaiOUDxU+SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by BESPR04MB12612.eurprd04.prod.outlook.com (2603:10a6:b10:101::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:13:25 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:13:24 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/2] net: enetc: add i.MX952 support
Date: Mon, 13 Apr 2026 16:15:38 +0800
Message-Id: <20260413-netc-v1-0-8670e5ce2d49@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqm3GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Nj3bzUkmRdY6MkS0tzI1OjREtLJaDSgqLUtMwKsDHRSmVGSrEQseL
 SpKzU5BKQfqXaWgCHCz8abAAAAA==
X-Change-ID: 20260413-netc-32b997252a99
To: Ye Li <ye.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Michael Walle <mwalle@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Heiko Thiery <heiko.thiery@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|BESPR04MB12612:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed766b4-e81f-4a33-3729-08de99348894
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|366016|19092799006|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: yEIj0k+ArEJCeOLCc44xuO0OAI4+MMsl+AY63+fB52mI+/c3eSnbgr+WyLud/JCzHIjI7lrMpGWx2XZuyROSmJid2mvEwX+bo/eZKMbHrqCq4UvbPy4FbSYO2c9xWSnBQHHZ8FH9gevs2hSe4G4RdpNGF7APnFsCic4Al9suhW4ms+nSLRRx+vDuA4g2TcFHvmgRCjsldhxuotF27VI10x0xTR3uDs2uWCgzRh0cuQue7/Eu9rdlQ7ZTjo9Y7J2bRbq7LkwUn19uPsCLpWwf3+UcoQjAFDdEhh02D9DkmQgIUhrqH5MKv7yc3WfiMFZwoIFcrefKwotk5G/dusogCw2ZEjvNG7kAVwsMvannFHSfzanCBanHCXD3BmoX7HbcAvdP8+Ei5PYD275TVIYjYzUg+4MYKoAmO9TnO9o1cTPDZXPfs5r0inF9AlRpP8A/Th52zqvLH4LIPj09tN1mPdMzvd2ZLGqzB1gr985Qc6hd+AxRxCXxqgFZYQbm/EzRB45ZOWzVFqwNIHo9hGuB9fKPSuyy1oO0dM9/6sDAk7yCSRqm4+z0QYZkIL6vXSxRqeOLSOZOkin2NHto8vCb8EWDl9dCY6F8sE8dkXnA95K1bh+Jo4/jewBTN0gxjnu49Gby0cHVIqtrvRin43R0IRE9WdAVAAlRujC5XswYFPZcOgaTSvrh7DwwrJx1sYxccny5OXvqRbCz0y+l3VuXUTvXlhO6l+UKDZZo+ZtFzVietxmonsBLvx+o3NgbeoKstMweHYR5JGbzYiUUro8CAoyewptOWopYkvXwuA4fDeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(366016)(19092799006)(1800799024)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHhmM0dOQTdjWWtmM1VLWU1yWTVvL0pvc21sZ2ovaFJvUDBUNlFwa2tSc2Vr?=
 =?utf-8?B?VEJFamNJQ0t0NGRQZEdpOEdCU3g1RE1DMDJmclowWXBNblM4anU1Z1NMTHZh?=
 =?utf-8?B?VUZUSllhUDFMaGR0WkdrZDIrb2hPZytXTUVaVkp4N2pkL1FIZ0dKdzRWVkND?=
 =?utf-8?B?WktoOHpqWmtaOTN3Qm0xaEd0VTEzWUZXaDhiSG5jNVdQaU1lcTB5RUc5S2lF?=
 =?utf-8?B?U0oxZncrbUQrRU1KUmNQYWlzQkphcnNNUFNUMmJmWTVhRk1xTUVhTE5waWlp?=
 =?utf-8?B?aVNBUXFKZ0h4ZXR1cnpwN2VsSjk2VFFKT0tyazI2V2d3Si83d3poZDJla01J?=
 =?utf-8?B?VFJMRURGU2Qwa3BUcTFaQXJmazVVU25FdFljeDRuaFJXWStYcTMyNUp4dmVh?=
 =?utf-8?B?a0p4TVpqdVFKVUx2c2ordzRSVlRVbllOTFhNY1BvLzdpa1hRUE9XRGFCazlX?=
 =?utf-8?B?OGY1SnRtTEQvaGcva0xEM01VUmF2bk9iSmVDZTgrSmVySDlmOHdrTVdtS1Fm?=
 =?utf-8?B?cjlkdFJtOC9hNFIvMEVGaFoxWjgyS0pYZ2E2R01XU3h4cm9OVVRIUklFMkoy?=
 =?utf-8?B?Y29PQVN4NVVwRVJDWHZ1bmN2aUFBd1JITUlSOTFZckN1WE03RkJwZCtlVjZj?=
 =?utf-8?B?cEVhZHhUWlduU0JPaVBIWE8xR0VmWEJBOGlWTkVKZDR3SkgvT2ZtNTVlWnZt?=
 =?utf-8?B?MEM3OXNETFFSVytDa0E4SVdkVGM1Z3NrODNsSE1PTTFzeUNiYWlHT3BKTHZJ?=
 =?utf-8?B?dy9CczB6L3pWUjF0SlFGck5Gb2lvN3RSZCtyaGtFSkQvSmsrckNEVkt5cWRY?=
 =?utf-8?B?aDJrMEI4NVdIanFlc1RNT05jTmRuTGpIOHpWSVVpSDJTbzZhSFhsVFZPM21w?=
 =?utf-8?B?TDVseGJSMi9VSnlXMXhGN0lEZUJJOHhkUEZBQUs0NDFEMHNuU3hSeUszR1lE?=
 =?utf-8?B?VUlpaWNtSjBpR3gyRnIvM1hrNGRmN3RpMFpLUHVESDI2Rnp1c1RXTDNDZU1u?=
 =?utf-8?B?Y3VEYVJGa3ZYanBsaG41SVNXWjhiNnpreXNsRi9JZG5teExHc3dqNXFiQm9X?=
 =?utf-8?B?YkpRVSs5aFpKc3diZ0xOcm5XZDhvUkxWVjlWb1MwWm5Ea05vUk4rRXpEcWxR?=
 =?utf-8?B?RmhRZzVTT0M3WUNlU0c2Vm9OYzV6RWVraUQ4UzhURUVhOGR1eXd3Ynp2ZVMv?=
 =?utf-8?B?ZVZ5L1FMeHJtZmYxU3U0NGRhd0lnME9yMFQ4a1k0ZFlQb2lUdGF6MTB6TXRM?=
 =?utf-8?B?d2dBR2xkeDdtYlVUdVdyQjRmMW9JdWlEUEtiVEVXNm90a1ROam5KbHdmMkFn?=
 =?utf-8?B?WUxBV2Mwd29iQnpIYnQ0WnQ2blNFMUx5SjRmaDdnUFBPbTdZRGhzVzRWVFI5?=
 =?utf-8?B?emtmT29OSm1RZlc0YUYvbk9LSXhLYU5LUDRGcWd3OXkwVVlFTHA4MkdZUWd1?=
 =?utf-8?B?VWpRbHJzNWRERkEwKzk5K1N3NzJseWxaYkpZQkVaTjhxVWtIT1p3c0pJQW5l?=
 =?utf-8?B?cXZDaGhmcHNpTGJoa1lRaGZ4aGVraDkzT3FkQlpzdTVLLzdFOEY2YWJRa29w?=
 =?utf-8?B?Qlhad0diL3BqZXA1Mm1pNWZ1K1JHRUZVdjY0NDlEVGQyeVU2cWNTSlFYWks3?=
 =?utf-8?B?b2FLRk9hTVl6U3htWkUwK3ByaFkvQkMya1Rtckx6UUN4eXkvY29qNnZNQ1NI?=
 =?utf-8?B?eGI3bWpUQ0c1aVRueGtxRDZKT0FZWmRRTmdpU3R1MnF5WlJIbEdjeHQvRmo1?=
 =?utf-8?B?c3hnQkVSQ1NoejhZYlA5NDFQcENtOWZWMWw2dTB0cDZMN2RZQ3VqbCsxNExC?=
 =?utf-8?B?cFUxZExuajBNdWp6OFg1Tk1uMGEzSnFWMlcva3lwZGlJYWd5aVhRcWVJWkoy?=
 =?utf-8?B?L093clhWbG9UQW4ybEhHZnBzMDcxQ1pUYUVFL3ZnOGpLVFQ4bE9IZWhqWGJH?=
 =?utf-8?B?TlF2L3owOEo2eFdmVm9reGFkekI0cW1sN2hONnN4eis2VHhNaHhzSVBPVHlS?=
 =?utf-8?B?TWpEWUM4cW4rSlkyc3d5TTVpaGVsSThQbEdFclB1Yks3elhDMkRqUG9WaG9R?=
 =?utf-8?B?SktsM1Q1SG1HTXhqNVcwbk4vR1BmQldpQW5WRzk0TzJYRURDdnY5NEZ3N3U5?=
 =?utf-8?B?Q0ZSeUZCTjZPSnU2a0UweXkzYVpiYVVOK3Y5VUpUVVh1L25tZElqNkJDTzJ3?=
 =?utf-8?B?NUIxNTd6bWlqK1Y5bjRlYjdzdTNjWGU4VENzSkkwbE9ZN2dSaVN6YjlFZC9k?=
 =?utf-8?B?MXYvNWYrZVV2alJ2MDVrb3RWem43RVV1dExqRWRlQzB2eVFpZGRnSVk0WWJv?=
 =?utf-8?B?QklrSnpVeTlYamliT25pK3pGUkVnOVFxU09PR09CNWZZaFEvNGMxQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed766b4-e81f-4a33-3729-08de99348894
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:13:24.7471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3jGvUxw94PoAfL/eXINJo/G0UdLEdUvjMql+mnU7v3Kdpdy0I7Fj4vzvVOw7HkY2aNBfol1f+epLJOpYIrU0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12612
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

Changes in v2:
- Drop DTS-related patch.
- No functional changes to the ENETC support code.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Clark Wang (1):
      net: fsl_enetc: fix the duplex setting on the iMX platform

Ye Li (1):
      net: fsl_enetc: Add support for i.MX952

 drivers/net/Kconfig                   |  4 +-
 drivers/net/fsl_enetc.c               | 46 +++++++++++++++++-----
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 72 +++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 12 deletions(-)
---
base-commit: e2fa3e570f83ab0f9ce667ddaec9dc738bcf05b9
change-id: 20260413-netc-32b997252a99

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

