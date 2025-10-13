Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABA2CCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 04:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED8B838CC;
	Mon, 13 Oct 2025 06:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eZEjeZG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F81837E2; Mon, 13 Oct 2025 03:37:36 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF0783804
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 03:37:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKjTeKtAWKrArcmWpH4lmfwwmrlc8gN6oJ1L5U4lBoPnuL1ce/nY7yrEkSfOFOiRWKxben0EzE4T0mUz9thalYwqPM92jycGuBTho+uECWVVkCMXVSFaXqQE6MGy/s6/7J/sBNaY3bU6GmUad8f9GQ5YkY08QM15J+oD1RN9Lih8H0hi2XpcqUxv54u3QODERmVjm+Mp5MI21vTDU0977aCBbSycH946DFbJ28N/m7xBN+tS1yrqhZyo4wfu3zj5wcSg5Y++2X3vIo1g6nMhPVHxnUevu5y4EMsrFkTunUwVA7x1lgzqcONM59JfxDd94vYnBC+LvsL+qxr2RzdvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFvXMt3qTWxkXx08MWpEshdPL/PuxGGyjawqTw292cY=;
 b=p0MbOuEXmn0S0rqKZlo3JIYLjGiLOWUDf5SgPTNuvkF2yZNkEDBs/rVnH3Q4Le5FHpfCjA97Q/+B0fVAUVQcrlBU9RtyDFMjmLsyjfjPrA0rwrHhAzqupzZ49jt0WKqFm2ZB2o1ouTFV4BuVS9wy1r1QJEuAJxf4j/saDjVXWpvI5H05Aj+u+le0N88dBXMNUbn1+yWJWGFXFeqUaMiJbRLQxu5K2ES5rtY/ZUgD7MdpdaH76DOrY1s9gKXV8jLmBHSfOl3iwW9B0/2l8o3nAvn01JcpVZSjr1OY2Zc/FC+MbrK+2ibQRiqnypIVCYQ0smGDlcWF+SGfmbjGcjyMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFvXMt3qTWxkXx08MWpEshdPL/PuxGGyjawqTw292cY=;
 b=eZEjeZG2iN2Ln3PEesy7adlyRyhTcwRYRYyCgWOkrLgmeEPEgrfHcitfbd40j3Ixd+q+6Ezcwx23LR6oqetcpVS/jgAUVk2eIC0z5Dyw9eZ6HnlJ0uFaLaEbzsNjQZPpmIbNCPifCL5RGqZhJUtwRLFpkysGUyPTrBKDITuyQZCzl52rFbsD6mOeU7brl8syH8BpqxHEIuULYcUiFncegLyJ0+bSsdjYh3d/bdkWQFkPt83TeWxOYCSQBSzZkqEsOhW0vs1FOcohvdh6QyttQJiUvoc7rC5h4fZajaq18gYDIXlh7o+Ca45Xl8v8OWbcdo2+DOvwpYicIuWKXe43XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 01:37:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 01:37:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 13 Oct 2025 10:49:24 +0800
Subject: [PATCH 05/11] remoteproc: imx_rproc: Add support for i.MX93 CM33
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx-rproc-v1-5-fb43a3fafcd0@nxp.com>
References: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
In-Reply-To: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Udit Kumar <u-kumar1@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>, 
 Ryan Eatmon <reatmon@ti.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: c4566834-b18a-4b15-31fd-08de09f914af
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SG5VbjVRVnV1eUVkaW9sZUVIVkcxVUdqM0lrNnB5VkJXeXdmUHNxc00vS0p0?=
 =?utf-8?B?cXo4TTdDSmExZm1mUWYrVUUvOUFWWUlORUxibGlqZEFDZEhkM29jMmtGY25W?=
 =?utf-8?B?b0xXUld6S0VMZDY3MlRTVGh6WEIxbzF1WDdqa1ZDSW9IQVE3TjhqZW5maDBE?=
 =?utf-8?B?WGFra2VNY1BwSWtJbEExUmkyVnI0dkF4UHdEdVU4WDlRai9tc251VHB4NkJ0?=
 =?utf-8?B?bk8vbjJMeE1XcmJFKzU0NzV3L0trb29QcHBCc3RITmMyOE1oZGFjV2FJejIr?=
 =?utf-8?B?cnYxQUpFS3hZRk41QkU2UnY3WHF3ZHZ6YnJNUkJ3SUdJTFRiaXl1S0VSVzAv?=
 =?utf-8?B?SUtSaU1hT2JjRkw4VUhsTXc4dTRLMjMzQlRidWtVMGJGNnhnWi9wdU9RUjNs?=
 =?utf-8?B?WUJYTjQ1b1llNExmT1RMS3RObGYzeDNyUzVlNEU5WTRIZk9TbWgrU2ZVdzRB?=
 =?utf-8?B?MWFTVGwyWVd6RlB0TDJiNDVzTTB3UE96cXhDRVgyTUZNNG9VSUcyZHFRVTYy?=
 =?utf-8?B?aHQ0T1ZkeGorTGEwWmt1TExVY2x3dE1IY3draEZYQlppL29jUTNkT21Dd2RD?=
 =?utf-8?B?bDZrVWxaUjRzOFN2TzlSYlRvcTVrZXd4ZXlVQjcrbjBVdGpldUFFZ3dMZGlG?=
 =?utf-8?B?OXV6ZGhBNTRvL1RPOXJmZlFtcnRIVFFFTFhNbHIxNFBUTDBGV29nc2gwTVlB?=
 =?utf-8?B?OTVwODgxbnBLeWhQMGttNkdaeEIxbHZkbWV1TXNnU0pFd1NpSkRzaWFEK0Uw?=
 =?utf-8?B?YzA2S1g3SUtpbldpOHVNT1U3UU1JNjFGTm03djhDcEd6YlNQQ280dlNiZlEv?=
 =?utf-8?B?bFBzNmVyVkVET1JkenAwajNyOU1XMDBFVldMb25VNXQ3ZlVNRjZHdklrdlBX?=
 =?utf-8?B?TXUvMFVwOHRuQmcxNjNIck5kdVM1dko5c2ZpaGh2amxzWDNVOFdiM0V0RVB6?=
 =?utf-8?B?eXhpZlRUWUoyZDJZUFBtZzU3bnFGQkthRmVqZUovK2o0dTlhZFBxcEg2YWZO?=
 =?utf-8?B?U054L0hjbUlDREhQQktVa1RTWEFrN1J1MVBhT2xod3FBazBnbXV0KzVIOVRo?=
 =?utf-8?B?R21VVjduNUJ6cVg1a3V1UGlpRThpR3JqVGtnYlJMelNkdDFnL2hiN2Zna1lM?=
 =?utf-8?B?eEhCWTdHRlBEMkN3NE5GMEMvUk5Temt4YlFvSWpWb3lKaHRKSHpwOTJJSUxD?=
 =?utf-8?B?elYzRHlZZ3BNOXhMaDRIaENIc0ZWdkpUTXlwRkFIeEpBVmFsVG4vMGdFYW93?=
 =?utf-8?B?OHhJZTVZOW45bk1pM3JzRHZDbDlGbTk1V2FOeEFhQWVoazlpTitnUTl1bHFP?=
 =?utf-8?B?ejNOeVdsNWVZSVY0ZTdUSy9SZE83TG5UM3YzNUtyYW0vS2VIdmFsYjBZdXp1?=
 =?utf-8?B?VUdoa3NEeTZVeFlDTThtNGFLcTIrWDBTOWYwRENuWC9JeDY3T3pRd014SzN3?=
 =?utf-8?B?S0RIVzFDSGw5TWRMWGdNaCs5Tlkxc0E4UTRLSlpuNkd5ZjVDZnp3d3REOFhj?=
 =?utf-8?B?UmtiUzkrVUdTcGdnQzNvNzJqV0VIaHNYSXZEbFlWY2UwaEc3TFFHRnUrVFBn?=
 =?utf-8?B?eDhacHVpdXUxVWVoSEtzdFIxL3QvUGtwM0dlM0JRM2xtb0VMS0pmK2pOeHBs?=
 =?utf-8?B?eWVoaFVPQ0Zzc05xamRjMTlWbFQzMkNvb2htcDNINHNDR2tYM0puckVrNTNa?=
 =?utf-8?B?TEgxL05pdy9ZRkxxVmRRdXVXVDdnRFQ3L3VFTlBFZHV0ODdKaFA0UUp6bVpU?=
 =?utf-8?B?SGpLckljUGhvVnl6akFnV1RvcGJwYnNRM28ydktKekd3SUJpUEh2Mnd4TWJ0?=
 =?utf-8?B?aG9UNVhLaFhoQWkyOGpzU0dGWW8zRUVvSkJ0OFJSQzRmYmFWYnAvL3Z0VlFz?=
 =?utf-8?B?cGV1RWhWZ1ZRTHgvRnRWREVwSTU2a0xBYUZ6YlhIMlhqYVpmV01VaUNCQ2h3?=
 =?utf-8?B?T0JMczNRN1pXK3RYdFJxdUNKeldPNE5tNWs5OVZsYXhnY2NPL2NUWlpEUmN4?=
 =?utf-8?B?STI3cjZrWGxEVUJ4Q3NRQUZKcjlMeWs1YVFvdnJhNjhROHdlNzZaZUozRHlK?=
 =?utf-8?Q?GRC0Yr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(19092799006)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThTbFVaNTY1SnhEM0xSdmVRSFIzT1lUWFFHUWs2MEVISHBKTmQ3dS90QVhI?=
 =?utf-8?B?bW9SRExCSlczRmNiOU9pSmxUTHZ2dnN1NUlIWDFvaThyQnpPRFNqVC9lMHox?=
 =?utf-8?B?RmYvVkNxSW4yWGZYN0FydEkySHFlQjVWamFnOVBOYjZNMDNneVRVbnF3bEp2?=
 =?utf-8?B?MC9LU0wxZUc2blV1WGdKOTA5cnVETUNuUXNibG1PY0Jaa3RaQ0hhNE5QZDMw?=
 =?utf-8?B?TzV5T1VqbFFqWjVybkJiOEZBWE5BU0RiZTdRZjVaS3JmMVFjd1AyUSthT05w?=
 =?utf-8?B?VFdyZUIyNHFtMDM1V3hVZllKbW4zOVk4djhRa0pPT2Z4QU1yZlFXOGVOVm1B?=
 =?utf-8?B?YzdYU0t1RGJrNGtPNUJ1VE1kbmlkZmtYRUx4dzBqWGhVMVJnNmFwY1B5T2do?=
 =?utf-8?B?UVQ1VUhGbmM4SWlBZkVKQkJTRWM3NUVKck14UzJXdm1DK3dpVnM4b01td3Ru?=
 =?utf-8?B?K042eFc1Q3hsbjFJWm9QT0ptZlI3bENQdzEzTkRiWVJKUXdTcS9EQjZBcWs4?=
 =?utf-8?B?Y0c0MWhaS3JrWWs2WXp4NHBGb0FsdmpFRy9SQ2NqVVY5WFJMNEFEbFdIaTl5?=
 =?utf-8?B?STBCSUpzVlNkeTVFd240cjZVajRPa0lHMjN5VC9ra3RLYXZxdTZvbzZ5Qllp?=
 =?utf-8?B?QWp3bUppMFBNeTdLelVTL2RXU0VIN3UvdjNkU0IvYkx4bjRCUzlCR3FwOFhl?=
 =?utf-8?B?K2hVcVl5T0N0MGdFNHJDNDdvY2piUlh0WVlrRHlNcUJyam00SjBFTzdhUlk3?=
 =?utf-8?B?dGVpMkJLSk9pR0ZoYW40bTV5MkJzZCtpbUxMT0JGYzdWampCTmVvMnZ0ZVpT?=
 =?utf-8?B?aFdVbGRLaHNpYkRpeUx2OXlKUENDVDR0eWxjVUZjQWJUUEZ1WjVCRjJpUFJJ?=
 =?utf-8?B?Nzd4dWhnTVRSUjNnN0QyQ2FWWjYzYk9JT2pzZk9Cb1dQdm8xUERBZDNFekhK?=
 =?utf-8?B?ZnZPQ1V2YmlmV3VxUUkrUkliQ09hdU52VldVRFpPZ2h5MVo5SDdaeUpBYkNB?=
 =?utf-8?B?NGp0dWpTb0pwcjhOYXRHcUhPaUxiaEkxdkZIWmo4ejRlUndsNnZGTUlLSXNa?=
 =?utf-8?B?MVBueUgvOWw0YUhvcEZYMDh0S05MYWFWZnpzaTJXRmhMM1hSc21NWHlSdVRD?=
 =?utf-8?B?L3ExMGVIbFF1UzFQK1ZRQ2lORVV6NXNpTklOdndrUy9VN0hYUGNSU1d1SUhI?=
 =?utf-8?B?OFEyZkhLaUF2Q2l2Z0RXTGFYZjRYa3JycVhlYThsMXJqM0czc2xXL2FaalJw?=
 =?utf-8?B?QlNEUit3SU5nTXB0NVlxWVdVYXUrRGx4N09BamxtS1hvdHBXZHVkMlczamYw?=
 =?utf-8?B?eTFtUVVxeFR4VkZ0QVVlZnoyOTdEdU9NdTU3ODNveEI4Sys2ZjVTUkFqWlpE?=
 =?utf-8?B?RHBJc0JvYWhYSTRYdVdua25NYkFCMTVJVXNOMjR4ZVRMdVlNRFdRN2NDdng0?=
 =?utf-8?B?eUhuSjJrQXpRVEVkakRGQTVZYkY2S3RWYjhjbnJ5RWRXd3dIRUd4WjFSVE12?=
 =?utf-8?B?dGFhMVNWSEFjMS95ZXNzV3RQL3Rrc0ZTRW9vOGZFSTZOVVlvUFV5UmZMWWVv?=
 =?utf-8?B?Q3poU2Q0elUweUZOellFR29YR1dERno3UjVLdUl6NXRrVHRNWnhPWlJVSmJa?=
 =?utf-8?B?U0wwSWlXbzNyT1BJWnhVd0NHam9zWkpmU3djYkNrWTZBZzZKb0tpNDN3ZHUr?=
 =?utf-8?B?OGx2QzZBRW9OajZMQnBrWkRaTDAvb1pNRFZKQ3FRMzB5YStwMVdyV2ZGWG9O?=
 =?utf-8?B?SW5ycFhSL0F1cjRxcTg3UEg4dkN4YkRwVnhBWlFvY0UyUmZNamlEWGdrYzE1?=
 =?utf-8?B?V3FsUkJVUkVuMTIrZkl5b0E2Y2FubXp0bkZBd3RaVG1YdkNhMmlHdFZpL0tP?=
 =?utf-8?B?Uno5S21sQlg1WnNEdlc0emhhOUl4UE5qYnc0VFNUanlPTEdHeUhicEY5eEpl?=
 =?utf-8?B?RWZvZnBhcmJGQWlWRDdJZzJSWHg4MDRkN05GUGcyQlVtc2lJMVB4NEYvSjFH?=
 =?utf-8?B?bjlCOE5YNTJyQnd6TDU4YnRDUFVFb040YjRUOVF5UFNWLzFJTTJwdXJSVm0r?=
 =?utf-8?B?WDZZS3NxWHZrTEd2dytoSWk1V2lnNU1IMGJ5K0o0YUt5VHVXa2xvU2M1bmpF?=
 =?utf-8?Q?bqbv24+HCYoO9yB/MFmFtfm2Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4566834-b18a-4b15-31fd-08de09f914af
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 01:37:33.3291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UNho3qsJoyGMMih/BpXjOuWGiyf7JJZcBc1jr/WLrq5Ew+h/6tP/vMaLcGBaLWZ7A2Z6WzdCAjbfeoM9AHPkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
X-Mailman-Approved-At: Mon, 13 Oct 2025 06:18:05 +0200
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

Introduce remote processor configuration for the i.MX93 Cortex-M33 core.

This patch adds:
- Address translation table (ATT) for i.MX93, including TCM
  (secure and non-secure) and DDR regions.
- A new device configuration structure `imx_rproc_cfg_imx93` using SMC
  method and ARM SMC ops.
- Device tree match entry for "fsl,imx93-cm33"

This enables remoteproc framework to properly initialize and manage the
Cortex-M33 core on i.MX93 platforms.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index c71e409a00a55179b06434dfa190e8eb8ba559f1..9bb5532799803d05de0e125475b3dc41a452e906 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -322,11 +322,41 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
 	.ops		= &imx_rproc_ops_mmio,
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx93[] = {
+	/* dev addr , sys addr  , size	    , flags */
+	/* TCM CODE NON-SECURE */
+	{ 0x0FFC0000, 0x201C0000, 0x00040000, ATT_OWN | ATT_IOMEM },
+
+	/* TCM CODE SECURE */
+	{ 0x1FFC0000, 0x201C0000, 0x00040000, ATT_OWN | ATT_IOMEM },
+
+	/* TCM SYS NON-SECURE*/
+	{ 0x20000000, 0x20200000, 0x00040000, ATT_OWN | ATT_IOMEM },
+
+	/* TCM SYS SECURE*/
+	{ 0x30000000, 0x20200000, 0x00040000, ATT_OWN | ATT_IOMEM },
+
+	/* DDR */
+	{ 0x80000000, 0x80000000, 0x10000000, 0 },
+	{ 0x90000000, 0x80000000, 0x10000000, 0 },
+
+	{ 0xC0000000, 0xC0000000, 0x10000000, 0 },
+	{ 0xD0000000, 0xC0000000, 0x10000000, 0 },
+};
+
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx93 = {
+	.att		= imx_rproc_att_imx93,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx93),
+	.method		= IMX_RPROC_SMC,
+	.ops		= &imx_rproc_ops_arm_smc,
+};
+
 static const struct udevice_id imx_rproc_ids[] = {
 	{ .compatible = "fsl,imx8mm-cm4", .data = (ulong)&imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx8mn-cm7", .data = (ulong)&imx_rproc_cfg_imx8mn, },
 	{ .compatible = "fsl,imx8mp-cm7", .data = (ulong)&imx_rproc_cfg_imx8mn, },
 	{ .compatible = "fsl,imx8mq-cm4", .data = (ulong)&imx_rproc_cfg_imx8mq },
+	{ .compatible = "fsl,imx93-cm33", .data = (ulong)&imx_rproc_cfg_imx93 },
 	{}
 };
 

-- 
2.35.3

