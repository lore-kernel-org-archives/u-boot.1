Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8ECC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39389809A5;
	Thu, 24 Apr 2025 08:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oHBfk0iX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1977D809A5; Thu, 24 Apr 2025 08:34:47 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1325282045
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4nxFG/1HGX0RKQ+canO+mgoCezRpLHjEml+QqmphyDTCAj4MMEDlTzfI9Iwas6py85WE8yv7ZTvfgrne9R/1njZYERiff7AMdxVgnE0jKHF5q1e3fD8E/jxcKrTSMwV2n3CIOVKFAm62o/L+9TB0Q+dcg2RXNy0dCLgeOEPJgBN7raw9PlF+fLTMRFkE6EWQnIzJqMljnigj+G4GUcQEWzriUSQlKW6jdpYxFxPi+lEq0Fzzv7UbxB9j+pguytPt563tRC5WKzTqq1SyYyWa4HwG3TTN7LChGG+ltsZ4hJnksXVQL3PRDR+lSrW2Ck4RAAOqAvt4AWtqEha0AZtaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZZ7P8QF4jkU3bQPWK3PJswpNc5mmeiCkckixW6jTic=;
 b=TFpAqdvFLR3s8aISS5xH3h9X0OFl4oLxol7kbSpX2ORjBIaJuSEhmjzEHZm3Qad9a4aeRzJ9tB5sQpH7trTUJ4QEDBrV9RlPv8KCmsUrMMaZnCWeywFT+ZWJ3I6W8D921aUpUQFHPg4zRn0J8BeTVpaJL78YcPzRzrU8ecvuMG2gCfceZF9Qcandg31oacmFVi5YzFrnY8nhEY70EAU7y6QTzf82C6DHjWAgUVTl7ZfhLUSglc5TdnHRrUjGclYdjsee50YyNvThZdqJjl03dVkuuqEygHCbXoQf3YhgDiYNbfVneNGUxw7S2D4Hm4mr1CNkpgpFGKl43jifvwAQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZZ7P8QF4jkU3bQPWK3PJswpNc5mmeiCkckixW6jTic=;
 b=oHBfk0iX3IKxb0arn/H3AadcOqH23TL72lrEWDaHxvE+GiA96ZvNwHBy/mMYjMY+DbA6JwHoHgtDOtNrbGcWqKmIpdhdFe9oXVUiWtiNuknHhhbXyFd51qaeW2H8vrH5F6ZIg3u+SPFkKGZkT/QS1tIYpLAs0vfQqUz3c+uz5AtyhrmVWSqfffzHafZPk0DFF/sgm6ac0FE0HUdSiIQXofytsJzXYvGxUIOLG4jKlvK87TCIpuJ7uL25QofLFA1UZjxMqfgAmhpeUoGW/31vX+dufOLajcErrmhaQKnit8BWf8YweYrCvSoDRQKQ+LqmuKPm4Eh5fM4tf4ZoGUz7JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:43 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:09 +0800
Subject: [PATCH v10 13/21] spl: imx: use trampoline buffer to load images
 to secure region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-13-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c77f266-8911-4e51-3827-08dd82fa1952
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTIzdzBLdm8vampYODRBMUVVcW92aVpHQ2ozNkNaNUZ6K0o4UGs3dlF1WlJy?=
 =?utf-8?B?ajJYOWlMdkF2MkZZTXpqOEpIWXhLeVM1Qk1OSTcyYmEraWhMOFRVZUM5TWNT?=
 =?utf-8?B?NkxTdE5STGxNRWZrd0ZBUVBVbGJGMWpMbzRxMkc5WTFCdGRmR3JKZlMzL21l?=
 =?utf-8?B?Q0hIdkNTV3Y2UWxxMm1JK0x0djkybGFPRTBEU2ZDRFpqS0w4YURsOERQRDBX?=
 =?utf-8?B?VXg0V3BFL0wvMHBRUGVoNEM2Z3dhWGNvMEVjZE41UGVQRUlGazllalZnYlpy?=
 =?utf-8?B?dEZUd1d3WS9ybjlWRDBNT1JXNU5yNVphQXFveW1kVjFTRHFJTXNWdFY2ekF6?=
 =?utf-8?B?RVZIblNRSEFmWURPYVZ2QnBoNldwMjhrOWRwN2x1RVNJalA1dC9DOWRQSkti?=
 =?utf-8?B?WlA2ak9ubjBWVFQ2S3lzdFhFUzRGUjdDdnpnM3VBVExvUzdLaHN4RG9RbFpl?=
 =?utf-8?B?azhJWGNFblJHZFdqdWVlREw2M3NQSzFSSmRIZDRjYkFxR25jWVQwNmU3RFQw?=
 =?utf-8?B?eXNvd2pPVEZheFdvR2FrOXRQakhmR2oyM1FhdmVpOTRtUUtYT1JTWWw0VC8x?=
 =?utf-8?B?a0lxZStHRWlPQ0pEREdqTzd3TE1zcGRRTXZwUWtDNTIyakJwelJ0TkM1S1Rs?=
 =?utf-8?B?MERmbUEvN1ZOY0NDSWNuSGJEbGxIdjFOV2FtNG1ob3NaYzlKWWt5eUhtVWEy?=
 =?utf-8?B?VHFGVE96Y3VKMlRpZ0xiajhUSWVSM0VsNzl5WENtQUdDRXc0TjdBV3NTd2Zj?=
 =?utf-8?B?WURoWHRRd3dTdEFBNm9xUklUbFI0V0VLRzZFMHNvNUNCbzl3aEtOZk5IYUF6?=
 =?utf-8?B?WlMxSTE2czF2R1ViZEtWUi9VWUx6VDdRL2hKOXY5ZzJQSFRRZHlEZmx1U0NI?=
 =?utf-8?B?UEJuS0Q0bmVENmRkU1dRV1pKSDltSzJWWGt2SFAyUk1JYTc3NFNoT1dwamFl?=
 =?utf-8?B?dVFLNURaMzU0UVZrdDk3a0ZGVXNXaGNiWjlSejI1NGhKcEVtaXZzdExtTmk1?=
 =?utf-8?B?YzB3RjdCei9sOG13QWFod3J2ejB0SXM0ZElEQnErR0cxT2tVUU5PMEtIUWxn?=
 =?utf-8?B?QzZIZFZUWmRsM0RNdDVaVHRXOUlnWlFXSmtueFd6ak05Nk1JTWF6OXlabnNr?=
 =?utf-8?B?aFZiOUxYWTBac21aeHF4ekU2dnR5RUgwaEFGTzA0VWdXdmR5UTJtRkYwUHpp?=
 =?utf-8?B?YUJxNTFHQ2lzQVFsSTU3UUxKcWlWUUs4SmZ5VnRYWWt5bUNsd0cvT3Z6VGZY?=
 =?utf-8?B?cDBmdFcra3VINFcvdk5KQjY1cFI2SEEvNlNSWkZrQ0xlVWxsZTAzWGliV1Mr?=
 =?utf-8?B?dE90bjNDdXlwVXBWTGlDcll0RUtqbXlIZk53WHkvY1U5OWVKRnpNWWV5L2ZS?=
 =?utf-8?B?ZnBqaHlYY2JBKzdaQ1RqOGNobExLbW9nU1BWUGdmM2lac1oxWWl2ZDVyMzNO?=
 =?utf-8?B?N3AwREZGL3JZS1BWbFpSZW5iR29LK25QYnI2emh1RnN6TENBWk1RSkFvL3ZC?=
 =?utf-8?B?bXBKUmRIemdoNzZIdy9hWXR5NmpTclBrWHR1NldMV3RIeTNhRllPUlF6WE9y?=
 =?utf-8?B?S3AvM3VuN1RkZmpUdjFHM3IwVlBQTmhBK0NkNTZxM0JodEF2cXdramNZbjVs?=
 =?utf-8?B?N1VOQnh3WkpIZmp0TG0rUXRINkVjYkRLOHQyeHVnTXdSckJaKzE2U1Z3M25F?=
 =?utf-8?B?WFRZL1k3R09HZ25uMnpMc0REd2ltKzNQakUrSm5pOTBuc3dqMUZ1ejhHZklG?=
 =?utf-8?B?UERsaG95UHVWYTRWK00yLzJ5WUJ2YnQ0VEJmamtBVlVya2QxMGpVbW5icFBz?=
 =?utf-8?B?MzdQL290aHFTWlBaRDk0Qm45YXZBZWlsNWoraTZiNWNXK2g0WlJhY3pkZE9u?=
 =?utf-8?B?ZFJFZmEwOURBOWR0TFQ1aE5vSDFWN2hDWWhsODA1NGtmdEJpdmVrZ3Y4Q2px?=
 =?utf-8?B?L01TQTZwY3ZDVERkYi96QlNDVytzNGZHVVp4WDhldUZSVHFtWU5tSG1oSnAv?=
 =?utf-8?B?ayszY290dmx3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1JydDVEMUVpTzhBWkxvN05jMGJicHJ0aW1pbVZaeis5dDhMdFozUmRDZWdu?=
 =?utf-8?B?V0xKRGNlb21PbXpIZTJqWGRWQWpLbTdzaWxoNlJ4TnBRRHlybFh4Z2RudkFJ?=
 =?utf-8?B?M3dPUnNkdXg3T1MzdUpqcmIwZzdTck95Vnk0R3BzUDlQbjlpYXFkaTlHWUh0?=
 =?utf-8?B?Z2xIZW1xK05BZm5BcjM5V2NKSjFBUXd5LytQWlYwREJJVUd2bGhCRHlVSWxG?=
 =?utf-8?B?L3NCbS9ZMnp3TmVCVzF4TzRPN1JaUlQ1NjBJSWRyTnN3Uy91Zk9SMlJrUGxN?=
 =?utf-8?B?bzFhUkZhN3VlSHdzZXFvL3hoU29XdXJpT2theGhZYjA3UmJQdWg1UWUxSXNG?=
 =?utf-8?B?TmVOQVpkQ3BGRURyQlpSYU43WXRxQ044d204Nm9yR0xMY3pPbDhlTHBBWFM1?=
 =?utf-8?B?ZkVEdWNzT3E5eWVsdXlkaG1EVkRkREtkNXFmamlSTnkyQW9TT09FbDgxTWdM?=
 =?utf-8?B?YnRGbkFNdkRwWER5TU1zckViaGtsbTNjNmJleTVJWXFrTVhiL2gvZVF6ZEpM?=
 =?utf-8?B?VzlTdzBjcDN6UHo5UXRkUmo2Um9JeDQ5NnA3cVlKdHBIZi9SQ3RDMEhxTmJU?=
 =?utf-8?B?YXBoVW1qaTc4K0xkYmpoY0k1c2d0aE5RYmRzTHNIR2tscmVyV2VBeHpTajhh?=
 =?utf-8?B?SnI1TGZhVW1ydFp4ajJDWWRvWTVuWms5cWJyQThKYmlxV2hYUTlXbVJXbmRl?=
 =?utf-8?B?MisxSTlpamFPSkxESmRmNWdXZDA1SEZjSHpRNDg4ZG5rUDBDY1pwN2krZXBQ?=
 =?utf-8?B?ckhXbWoxaGVaUXZwcVYrQWxoenpsQVZuTUpvMEY3bU1ncXlNYzhmS0JuQSto?=
 =?utf-8?B?UjZSQ3dlVlZzRGs4ekpjTDJQQlV1RG91S0pzNmZOZlJsVks3Mml5MXNXUE10?=
 =?utf-8?B?cmZ1ZDlPVmxlQ2I2blM5aXZBRWlObGRXWVZ5QmlFelFrOS9GWVZzTkNJSVZO?=
 =?utf-8?B?U3lSTVE2NXQyVUhiZkdxZ1JSbTc3a3JyNXB1bGlscUUrbGU2VEVuNC9yaXhN?=
 =?utf-8?B?aU4zaWYwOXUremxRUkkwL21Eb05VVzlFQXhJSktxeDl0c3VJa0w5bTlUbHlk?=
 =?utf-8?B?ZG9sUXNjbWRXRmU0VEJjT1pDWHNFaXRGK216WlUrcnUza3NlSitRYVhMdk5V?=
 =?utf-8?B?VU9SNjkzVVNwL1dZT1Npb2JOTGovOFZPeDNWTU5QUHFjcG9nMW5tdkpOamRR?=
 =?utf-8?B?K0Z1Qlk5TVBtZmFEOHRJQzl5T216ZWFDSDN2eGhLVkVJVkY0WGRNRnZDa3pl?=
 =?utf-8?B?Z096K3g4WGZTZzlla2xlWkErdDZiaFRvSFcwUGdWS3lXem1hbkFvSkVPOHNR?=
 =?utf-8?B?SDVPTmlmcUduRldjc08xRHNmd09DMEFUd2FjcmczeXlCajhaZlc3a0w0ZVFS?=
 =?utf-8?B?d2RrNkpBTjZGREJhZnV0dVRpY2FIaW8zdHBUQUtHYmVydzRYNEVkMkdBNXBR?=
 =?utf-8?B?bWtYTDFVSnEzRm5Za3oyRW9FREd4bXBnUmNTUGRCVmtXR2dCSEhzcnJ3ZEZT?=
 =?utf-8?B?UFNDV2luZ1M1YjcwTmdwOXJFTnpEV2FJSkJNcmVMMFBBWVJiNXpmVk9mRENG?=
 =?utf-8?B?Z2dBV1lCTXdseHA5S2p4RHhVRUhTSW90THhQbFFKQjlwNDJYSTFuMnNpeVFm?=
 =?utf-8?B?bkYzVmpRdlMxY3hCRFJtcDY2Yk5rUnI5RUQ2Si9IMzE1K1lyZUJneXRlcjhJ?=
 =?utf-8?B?d3ptYnZrSFVFcnNjdVZiVCtGSEpIVjFpU1F3cGR4ZjJzM2ZTUm9wcmtSWTNk?=
 =?utf-8?B?a2JyOHNVQW15d2VsTm4vTmt5ZEd2a3ZQUFNqVmxzbi9rdUpZVXBoeTN4eGI3?=
 =?utf-8?B?bDZTR3dvUlRIR1BaODBualUwMWxwQ1JYNjRPT1k3UjlLdUY5VExGcm5BTEJY?=
 =?utf-8?B?WlIxWVM1am0xVmloY0o0OEliSzFhdE9uQjdJMGNpN1E0M042VUowM2VFNEpU?=
 =?utf-8?B?SitERGNvN3h1K2hMdTdnUk05cGE4azZFK0x0VUFuYlREdjIvRzJGOHppZHQv?=
 =?utf-8?B?ZmhTOWNWcWFLMXlSZkNxRTkyVXhTNWpUTU4rSkE2RXZHcGVmODJEZG0rV2ZQ?=
 =?utf-8?B?azNjaWZ6RkZSTXpuTUFlZDNiZ3BsS202U2NpOGpCSXJjNVpFUEtRb0pVWmky?=
 =?utf-8?Q?GsF8ltYeYExzNH5UdR310ycwW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c77f266-8911-4e51-3827-08dd82fa1952
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:43.6242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAXc/gg7ro/HaIYAyMx2cc0xwGKaotIdy12yo+RhNtF/+tp+8aTX8NJb0mLL9QjQlHLgLe6QCvavXTUpiWgNrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
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

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So use a trampoline buffer in non-secure region, then use CPU to copy the
image from trampoline buffer to destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 18 +++++++++++++++++
 common/spl/Kconfig                |  6 ++++++
 common/spl/spl_imx_container.c    | 41 +++++++++++++++++++++++++++++++++------
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 3a5bdddd785..d2b0455bff9 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -729,3 +729,21 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
+		return true;
+
+	return false;
+}
+
+void *arch_get_container_trampoline(void)
+{
+	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 3282e08a754..a2b214f3d74 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -361,6 +361,12 @@ config SPL_LOAD_IMX_CONTAINER
 	  Support booting U-Boot from an i.MX8 container image. If you are not
 	  using i.MX8, say 'n'.
 
+config SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	bool
+	depends on SPL
+	help
+	  Enable SPL load reader to load data to a trampoline buffer.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 2c31777fcd3..6e6afec1ff3 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -14,6 +14,16 @@
 #include <asm/mach-imx/ahab.h>
 #endif
 
+__weak bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	return false;
+}
+
+__weak void *arch_get_container_trampoline(void)
+{
+	return NULL;
+}
+
 static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  struct spl_load_info *info,
 					  struct container_hdr *container,
@@ -22,6 +32,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 {
 	struct boot_img_t *images;
 	ulong offset, overhead, size;
+	void *buf, *trampoline;
 
 	if (image_index > container->num_images) {
 		debug("Invalid image number\n");
@@ -42,12 +53,30 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size,
-		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) <
-	    images[image_index].size) {
-		printf("%s wrong\n", __func__);
-		return NULL;
+
+	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
+	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
+	    arch_check_dst_in_secure(buf, size)) {
+		trampoline = arch_get_container_trampoline();
+		if (!trampoline) {
+			printf("%s: trampoline size is zero\n", __func__);
+			return NULL;
+		}
+
+		if (info->read(info, offset, size, trampoline) < images[image_index].size) {
+			printf("%s: failed to load image to a trampoline buffer\n", __func__);
+			return NULL;
+		}
+
+		memcpy(buf, trampoline, images[image_index].size);
+	} else {
+		if (info->read(info, offset, size,
+			       map_sysmem(images[image_index].dst - overhead,
+					  images[image_index].size)) <
+		    images[image_index].size) {
+				printf("%s: failed to load image to a non-secure region\n", __func__);
+			return NULL;
+		}
 	}
 
 #ifdef CONFIG_AHAB_BOOT

-- 
2.43.0

