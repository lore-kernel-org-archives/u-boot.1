Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6641CC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9661E811CE;
	Wed,  5 Mar 2025 14:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jlu6wmtH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F8B58129B; Wed,  5 Mar 2025 14:29:19 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C995807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZoN4jmKlnxv6PBAdbgIHOE0aQorXRSXtW6T5L3YtV/NOvZpBs/5fJxYkS59m8dSD6Klt6G4FK6cu9QuQHsGRxziRfF+x5a0OXv1CNKaL//Wd/V2whsMUt2B9HwkTUD0RTDI6eJs2ODyGCmZ4iFIzHSO+P+hVyFQkLn1/AiHDfan1bl/UVQlJYRjp2EuFHFM74uxSTIZ9W5aFUbQrw8T8/QXJkB51fB1MaYTA1MJTuqxu+jbrPTrhTMwS1M3SXGjoB7Wa8GuL+mFAAJlgPT9yVmB5xAXWlCNHw1gJlSZEoJ/4YCHep41DzvEhn/LR9Qzsgb0sxtKOYTzxXBGvCoqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYOuXCA2y0VohT56bSbQOwfWldkYoZYopXV2k9/B+dw=;
 b=TDLNIZxB4ZC71MvA5RHiIMZ5qGz7L47iSsdAqZlJlA3IgQX/yridawZWSTkHFiagD086tOvXmARYRVQf92mLtcPK4ze7+mMiZ+lur87cpXjuwIVq9KFAZA2eV0vtFclofISJ6uFJUi6J14U1q9duVBlTCBC8IYQU970me4cfNmBLUkv8aCB2KNrPSa1cnC6+SWQxalJ7fTsq3sMjiYhBpUTE+KIs+6KTtB5X1NrgiwG1R3P0V9TuKZcT6Dh69U+EiAEFHbkuV+6B9AYfJ7A07ODFwfdSmNCJ7mU8TtHxLTkKlxC80lnWgOmxEHmOO8Zb2Jz7D7KdlPbwCqmRvmzX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYOuXCA2y0VohT56bSbQOwfWldkYoZYopXV2k9/B+dw=;
 b=Jlu6wmtHflYm+njTsIjZS0TxzApYW+7bKxKwvU383o2GLriqv/l0hHryD3P7/iAdkTd6z+Bw8vOqXdf6Uz6ic/tS+PhZYmRQi8LiEkchF7hb0aebwMK+xP+P8ddj1uXoWS8or2D5cD2vgwvCnd5uqIAJ3LYn3dR4Owxjr0YqqTuqXkluKBQx0sCpcukz6kNdGXmetCWEr9wR8brLo0Mm/Bd5h7Tb7tp1pBPwHtavI8uRYOBtcDQmVLtHVGiJtpz8YkiAmvF+VWTHOfA1//jlyW83kzw4l48pxv6SfliFAg/iyIJXmzewGymi4dy/fUxLTEL2ZvFO+Lj5Mr93uaTBaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:29:15 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:15 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:18 +0800
Subject: [PATCH v7 06/19] clk: scmi: add the command CLOCK_PARENT_SET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-6-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 135b8e15-57c0-42c0-734a-08dd5be9b96e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czFEWERnR2JaZDhxaVhzY0pTZHloZDFHQVMxRjN5QVN0Zmx2NEVCb1hxQ1Iw?=
 =?utf-8?B?Mm5TN3BaMlhhWGh4eUJTckg1UlJ1V3Q2VUtRbU1FQUxDNFdHZ0szZnE1ajYx?=
 =?utf-8?B?Y3ZKQWRWQVlZc0JDZUYwV3RxNzVGUFc2SXZkM0NmeFBwZll2dEFicUlQakV0?=
 =?utf-8?B?R2NWaG9wcWhobDNvOE5pQzlEYk4yQ3I0WWFxUzVHcFptWjNHeVJGS0lOalFR?=
 =?utf-8?B?NGNzL0M0cnVmQ2NJaGJ1dGkveGJKZmdWWnU0WkVSMTJzV0tSdXhoN0ZmNlJ2?=
 =?utf-8?B?d2g0S1FuUUFrd2Nnam1rYTB2akRQZnh0UXZGNStJamV5aEdWVVlJOHI4bUJh?=
 =?utf-8?B?bUY1Nm5uVFdjdXMycE9zNzVTdFZnT1BmWnUyK3I1THFEalpCWnRFNmhwUWFE?=
 =?utf-8?B?Sy9LaktkOEZsVlRYbWFNMjJoSVpUYXErMWx2NFhwQ3lIeTZiM3ZQZHdLbVhv?=
 =?utf-8?B?eXJvTjBrN21BSUFKK25xSldhdVdkVDYrR3V3NFZOTHkrNzBWZ1NZaDdmTzB3?=
 =?utf-8?B?S1ppOXNCQW9wcndMNWhZZnRhTC9qdlRuUFdWNld6ZnkwbUp0dVl4ckwwbElu?=
 =?utf-8?B?RUNQSXl5bVg0ZXBPTndTUVZaaGM1dmdjaFJtTktqZGVPZFlHeDcwYmdqcHo5?=
 =?utf-8?B?ZkkxR3JVUmVNMWIxZzdvMmoveUtjSWVVbFRZVUJJbzJkY3FRUzlyTXZxSzJi?=
 =?utf-8?B?bEdSWE5PZzdFWkRZdGRBNFZSN29ESEJkeUFVZDVveTdidDhmcEZhcGtpd01x?=
 =?utf-8?B?Ny9QdzNPbm1aZHFNZW8zYTB3UU9RcmpuMURreVNMR1RxZE41elJtaTJoWnR4?=
 =?utf-8?B?NTROOGhlN3ZVd0tqWXZZOHloRFVtU2JUU2xRNTUyODkxS0RKSnFlN2M4V0xo?=
 =?utf-8?B?Y0Z1K3hsUVJ2ais5YlV4bXNnSmhjbUEwWFp2SDdScUM0NU5MT0ptbnlNekh2?=
 =?utf-8?B?SlF4V1JGTytrU3ppemxubGJyUEdvdDAwT0VoWWJQWHc2QS83dVlYN2s5Zk5D?=
 =?utf-8?B?V2E0alNvSWdzRGR2NTFhUytMK2hqallHV1lmWVpRL3JWYUd6cU02K2c2WXZK?=
 =?utf-8?B?MU1iU3pyS1pPTkIyZWF4L1ZocWUwRzYxSSs2RUo3dE9YWXQ2WW5YNXBGRkRN?=
 =?utf-8?B?VnBJT0JsYVoyb1hqSHlGbUh1MlRaVzgvcGVTc0g3ZzhFeHhvRlNKcm5kZERN?=
 =?utf-8?B?ejNxVSttRHdIV2lpSWM1MW5aUERhWXZxWmJGM3pNOEp0cFozYk1naXFFQVBM?=
 =?utf-8?B?TlBhbmpNZHJQY2c5a0dvbzlDY1ZlRXpFdXF5NTFWNlp0RzhoYnUwcEovazF6?=
 =?utf-8?B?aUpodHB2dCtRY2wyT0ZOa0taaXY5K3NNTWVSQk15d1JqUXZqbkJMNnFJVjUx?=
 =?utf-8?B?V2ZCMFNMd0tMNzdUZEtpNVJGdFBGQlhSMWNueGVJWE5oTUoveC8yZ0pGS2Vi?=
 =?utf-8?B?NDg1eGZyUjd2Y2dadEQ4VXJwZWR4WWxZaHFNd0tNYUszamp0NXdPL3IrRlZS?=
 =?utf-8?B?aHVXd2tBNUZSZ05EY052M2JvWU1GNGdKWG96U2JhZllQUkdLcmh1Tm02aTNx?=
 =?utf-8?B?dmxKdUd6TWRybUl5UUxIeGNrM0l2TWpoMmVQUnBmNUdWSzZ5RFAwNTNHS1A3?=
 =?utf-8?B?R3pFUWpyKzczTkpITGZjd04zT0Zvb1V1UWVFZXplaGpRb2lzNzBNRVRnUDRw?=
 =?utf-8?B?MG9JdWVqNEx6QTB4MmIydFBkR29lYUxOOUp5aTZUdHJ4MkU2QUM4cm8xdVl3?=
 =?utf-8?B?RWRJUDkzNVBobXB0V1gzNUJiTThSYWRxdUN5QTlseEljN0N3ODdnRVpTK1hD?=
 =?utf-8?B?ZFdLaXQ5ZFFLMHVueEZBWXdOcmx5SE9SZGw2VjNiRDVKOWMzeU9Fb1VCZW9K?=
 =?utf-8?B?cVBkQjBUaFpYek9rYk52OHhSbHgrYTl5dWlyY2tYVGZvSVBXWjhPbkVmNVFv?=
 =?utf-8?B?eWZhRjVJYmRNaE1RWVQwVUQvSTBQNnhiSWx3SGdFUU82Nk41UEJaMVhzdFlu?=
 =?utf-8?B?VjJ0WDdDTmdBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDJSbTd1eE04YkhNS3ZQdnZoZktrZkhSNDBhTGptaWxwOW8wNFFaK3JFSWZV?=
 =?utf-8?B?Y0hmRFgwYzB6R203YzBsMGEvYTZyUGxzdzBKMHBROElHN3pNRzlIeW1DSUQ2?=
 =?utf-8?B?QjBCOXJYelVmWXVoRXYzQ0M5QngybitHamRyTHhGN1ZEQWNnMm4yU2FrUG9W?=
 =?utf-8?B?WnYyYWtNaE8vS05NR1F1U2hSc3NFSkdqWklZL1Y0aXNUbEtKVkpPNkNmNkFR?=
 =?utf-8?B?V25SN0dBUVBpSkdPYTRVTlE2RFV4NHVGSGo0T3U0dFYrZUtjYUJidkpGNkNJ?=
 =?utf-8?B?dGdTQ2lkcDNkTHI1NGF3R3Njek8wa0hOYnpqMjE1UjJwVXF1OEg3dUViZWp5?=
 =?utf-8?B?SE52M2lORUlJeHkzNFB5NlBwOUtvZjg2bHZPMWd4UG5NUTVZcjk0RDN0ZEZV?=
 =?utf-8?B?NXRpQzBUTWRSL1B2MTkvYUpxUFRaUVNGdFUzeFR2ODlNYnJiWkxDTW92YmNp?=
 =?utf-8?B?VnA4bHZHeVBtcENkVTJmVGR3UGs5OHlVQklPQXFGU2thcEhvWHpNNk5EM090?=
 =?utf-8?B?MUJjbndBbSs4dnAzUXlUTFhOa0hCd1FEcEw1dDN5SEQwd3pocUNGMEd5Qmo3?=
 =?utf-8?B?QmxHZ0hhZ2FCaEE2dTYyRGRjaXVJQWpIYjF1YWVNVmhZSUpPK3U0dnRyZ3dF?=
 =?utf-8?B?ek9TWFB4aUppclYwKytOVG1XRmVsOUdVUERyTXpMVXdTdVpVTVpXZjNISVZh?=
 =?utf-8?B?NzZUZU1VRGlpMk9aanlDVnNiYzhYcEJyb29rV0hPWDdnRmw0NVkzVG1Ma0gx?=
 =?utf-8?B?THdQaXk1RU01V210RE9mcVlNRDRoU0dwOG41M2F0UjlXaUQrYUJ0TE1sUHJ5?=
 =?utf-8?B?QjByckhtVExLU2pGN053S0YzMEMxK1Y4L1BYRmtkemNmQzUzVWpjemNLQUhs?=
 =?utf-8?B?d3dDcjZEOHdYZk94dWVWRDd5TURqQlMrT0EyK0FhS2EwOVdLb3BocmlmYU5a?=
 =?utf-8?B?Yis2c2JDRTM3WnR4a0FLbTdQN21yaVpzMktLWWtIVU1lVXVtbmwwZWJvNHEy?=
 =?utf-8?B?dDY2ckkzNnFlQmJ4cW1IV293ZVJUREYwbUx3aFI3RG0vME9Vayt5OWhVaGov?=
 =?utf-8?B?dFJmM3N2SWVvOXppYWZpZEhhOUhKcngyWTRCbm80TU01VVZxLzN4OVdZbXJu?=
 =?utf-8?B?ZnRFd1NoV2VBNUN4dEM0RHpwMUJHTWxMQXFTM0Fjc2lvdDVPWkVwTDAvYy9h?=
 =?utf-8?B?OCtldDAzelZnKzFyL05kVnN2Q0VNcVZEcUhmY2NsNW1iYTlWd1NKb1pXNE1R?=
 =?utf-8?B?T05RZTZ5RHd6bmNVRjRQTlJBWlg0VW5HajRlS1hNeVBrMUxTNDZlMkVKT29s?=
 =?utf-8?B?NnA0WFhYblpaNmlldWlqTklHZmpkUEhDVWNpZEszRXhKREdWcEtOTnZJWFdH?=
 =?utf-8?B?SVBieGR6dmROaEFFUjJaY25tRk9jNFlKMkR3NHhGYzZpNUUxNC9vOEhmaU94?=
 =?utf-8?B?Um1CbGVoK2ZoZ1Jld09qM0dtOXdaN1ZWak1kM1NZZzV3R0xST1RxNXFPajVu?=
 =?utf-8?B?QmI4cVF2Z0s1Rjc5eCtXUVdqaWE2NHNoNm9GNXVuaFl5ZHdLTldmMm41d3ds?=
 =?utf-8?B?UlVYc3E5Mno0OERhMnpWcGk1eEFDcXZMeWptQXRMK1lOdzhDR0h5NlVPR2di?=
 =?utf-8?B?ZnNWUnRYUCsyYVRBVldMMkFUWE1VbnlyOWc4R0tQQkFBUEpHemVjQysyRzRi?=
 =?utf-8?B?R0s3V0M4ZmZHUUh1bjdTOTRlNmhaVWQxQkcxdFdKbFRxQjYwb2NPaUtYRkhy?=
 =?utf-8?B?RVRGUytSTHdmTWc2b3Rld1ZzbjBMQzFJbDRBa2N3Uzh4bnV2MzBDNEhPdkdu?=
 =?utf-8?B?UXVnUWpRbWdwSnprTVJTUFkrb2UrVHNSdlVITFZWeGlGbHJERGJJa0s3MDNZ?=
 =?utf-8?B?WmVEb0pIR252dnNGYlIzZVpzdVByckRoUkx6aGthVGszbW5vU2p0UERkSGV2?=
 =?utf-8?B?VlFINVQ1U2hNenNuanowdVBiRGQxd1lSRTdIckVxazV5RXk5UHY2Z2plNzcv?=
 =?utf-8?B?U1psY0Z6Rm9xSVZzNVpZSGpXQnFCOHgvT1Yzc1kvUllyR1phOFQ2a25rcm9v?=
 =?utf-8?B?MnQrRnlJdTdtczVNYmgvTVZ3VE5qZHVGd0hLME5LVERvTXFCa2g5WEU5ZC81?=
 =?utf-8?Q?YUJ6UAIvZT4KVoJFyaqWSzERq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135b8e15-57c0-42c0-734a-08dd5be9b96e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:15.5002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8n0NwZ6dyL3eKfyxeKNYGMrBYIjvH6dUjJQA/bkwQv5ncqkOrZe1bWUujH6R5NOCL5JQBXekUQUe101YynZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
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

This patch adds the command CLOCK_PARENT_SET that can be used to set the
parent of a clock. ARM SCMI Version 3.2 supports to change the parent of
a clock device.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk_scmi.c   | 20 ++++++++++++++++++++
 include/scmi_protocols.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d4..84333cdd0c 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -178,11 +178,31 @@ static int scmi_clk_probe(struct udevice *dev)
 	return 0;
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct scmi_clk_parent_set_in in = {
+		.clock_id = clk->id,
+		.parent_clk = parent->id,
+	};
+	struct scmi_clk_parent_set_out out;
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					  SCMI_CLOCK_PARENT_SET,
+					  in, out);
+	int ret;
+
+	ret = devm_scmi_process_msg(clk->dev, &msg);
+	if (ret < 0)
+		return ret;
+
+	return scmi_to_linux_errno(out.status);
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
 	.get_rate = scmi_clk_get_rate,
 	.set_rate = scmi_clk_set_rate,
+	.set_parent = scmi_clk_set_parent,
 };
 
 U_BOOT_DRIVER(scmi_clock) = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 34f272c448..0d8c177025 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -737,6 +737,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
+	SCMI_CLOCK_PARENT_SET = 0xD
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -839,6 +840,24 @@ struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
+/**
+ * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * @clock_id:		SCMI clock ID
+ * @parent_clk:		SCMI clock ID
+ */
+struct scmi_clk_parent_set_in {
+	u32 clock_id;
+	u32 parent_clk;
+};
+
+/**
+ * struct scmi_clk_parent_set_out - Response payload for CLOCK_PARENT_SET command
+ * @status:	SCMI command status
+ */
+struct scmi_clk_parent_set_out {
+	s32 status;
+};
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

