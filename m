Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0B9C282EC
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C163814B6;
	Wed,  5 Mar 2025 14:30:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="A8BJn9cH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B0CC816AF; Wed,  5 Mar 2025 14:30:00 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 624A88144F
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJD8v5XdgDXZeMLOmCDG2hqPIxm+FBWAUmOgQAhZFxeUwtEs8DYmvp38e5if2ZtZKVcWYIMY6XwSvsUnBPcveiNcslFtFyPaT3hx5WWO+k66N7zP2PyjM291frI7zz5Rbx8W0kqcvg2gU87qnRbrR+6t4CWuSzsi8rQEJ4r8MHd5Z/o/3HtAdIaUb3G9fL0p1aKtZpliCrZmjuCz8amDFgI8xb51kLq9l0SeAsUgosiLNM/yIsd4iXD/o7Ar+Rvw94v4rdFjHLT6ob6hduQ0EcssldY0GXYYw0LpPopspK7e4FUGUmJ5FmbG4DDn2dxJBm/Yaw8RSQ9hV0vm5yPFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOgfoRnk8zH4bBzNTJwMrZZcY/aB7Hv6Dgo68TvXILI=;
 b=tl2woaSslr7n0pSwq1uzJ+qmICagjYMW1BZC/4K+97pqg8tzHqBY5r7mxgxoIqqYDb38C/6QXzKMn6x25sTA67hMSiRB4JJ10w3eWBeqHj4LySUGzx/VcdsnQ+DzG6cUzhQ1x2QY+Dk2SsBk+L03JybVmd8EUZ4AZY0PXTPukvTkL1zzacVHFZF0+aXJWnEURLw89MOkIcBmz7grAZAgpOEyvijQUDeT08pqtkqQAbxOPdgdjnZzLZaqxWfzd86LqvnK5i5yChetNTmgKhr7ue21giVVQ2ZmWfUzlCS+Qb0ktf2DVhmLiSGFWgVstczxNpb5jWks9ydjuO+FT8Vj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOgfoRnk8zH4bBzNTJwMrZZcY/aB7Hv6Dgo68TvXILI=;
 b=A8BJn9cHSmXIYs4yVJ6LUdyXtuXLQ11xVrB7VscDFGzscyAyErMSp6NIzayiyJEPpvxFjgCWWR8E8pRnxyFPxydyXfplxI8ohPkCjcOciHSkCOEYPmWi6C4yRIxNW6e9p+CFtRFn94PU5da8y4HoGy5whgCNxVbcrUCkD/pJAJR9sSLQ5UMHRLnFxDAdM1QqD1+SPgiyQhGHf9qFSALzwjzRD+MKpsWKMrO3IS33tIW2pvjZL/7Kx0aX+xGUkncGxfCBULKfBWq1QRKkUPdBmRP9n19qrUYcOZeOvrClfJ7PNB6yD0iUFrab24Jh6xFh94Xdm2RE36jKDx+2zXbWKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB7037.eurprd04.prod.outlook.com (2603:10a6:800:125::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:29:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:29:56 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:26 +0800
Subject: [PATCH v7 14/19] binman: add a new entry type for packing DDR PHY
 firmware images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-14-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: c569b595-10ac-4eea-d4ce-08dd5be9d1fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djVJNXZGVjJZbS8vb3ozV0lsV0RPTS9JZHAvUmFGcVlzS25vQUh1emxSY2ZO?=
 =?utf-8?B?OTgwdmVKN2lFd3IyQ2VkR1hUakM5VjlzRFJRTWdVc3NkSXczQUFhSnNQUnpR?=
 =?utf-8?B?ZHppSXcvVExMZEU2SzU0THk5bjU2NDJoVkd5dFVOcGJyL1F3aS9xWmpnSkJk?=
 =?utf-8?B?Mml0Q0tydjdCc2dGTENZZW9aY21UV2VhT2dWL3dKcEhPeVI3d2xVSlV0L1lx?=
 =?utf-8?B?YWYyL0RuWDdZdjQ2U3pJZ2RnZWtOMmwzWjlGQy9JWHY3TWNCdUxZZll4Ty9U?=
 =?utf-8?B?czFHVkdtSHhUMHo4Q2dQQ3JUSEtUWWExd0pwdUdiQ003VVI3N1BtbVBiR2xq?=
 =?utf-8?B?WW1IQ0ZGSTRKMXltbURSbkoxMDJsazBYSCtQWnQzc1Mvd3dLTG9kTTJaNmNK?=
 =?utf-8?B?eVJlSmR1UGVITExhRlNUeE90RG44MGdIeVl3dlF4Sk1WenExbHpzTmt1UW1K?=
 =?utf-8?B?Ri82Ukp6L2R2MVFPNDE5S0VYUERZMEM4ZC9zUGFQQXRVQlNha2RKVG8xcXJF?=
 =?utf-8?B?cWhsRG5QbTUxbzM2RE5ncCtpdDJUREg4cldjdkQ1OUJBWmhaL0JoTWhmN2l6?=
 =?utf-8?B?MVREd0M5dWRLZDhTMXhVcjVlRlJ1SDNPMVdMcVUwRm1NdktMaVR4OXp4UW9n?=
 =?utf-8?B?ZUJEaHlpZUIyL3ltbmFIa2VGT3pHNHpvcmxlVUFhZkZkNURPemUrVDNqdkpa?=
 =?utf-8?B?UlUwWEVUQmJyc3BseGdndU5qekRYRStYZXEvTHhJSGxHSEY2VXJWaVljcmYw?=
 =?utf-8?B?Nis5T2hIOHdESnpxZ2g2YTJRT0VnN3Vwd2tub3kyZVhuNXZoVG5JRy9sTG52?=
 =?utf-8?B?bFVkOTdpRjlsVG1lTGpVWU1RaXU4QjZLNnRFeEkzL3pVMFhvanhsbnoyQS91?=
 =?utf-8?B?VlpCYmR4djc4VmpOZ3Jxb3VxZURhd2c1ZWV6NDA4WCtSMmljWStwcjZIeFF2?=
 =?utf-8?B?djFROVQwbDNJTzJ6Tm5xSW5vT0hzc1ovTU1qZnpIOTdlWmVYYUtZSzNSeXdn?=
 =?utf-8?B?SzJDSWc5RkVvSk5mdE9nZ1VmbXZRUHJtSWdVTlZZa2pvOEVZZDlHK0w4aHVu?=
 =?utf-8?B?cFpvdi9PRkxESzRFQ2F5aTZvWWh2ekUxNjJaMEdJWlhLR0dnUGdoVURLWUxL?=
 =?utf-8?B?RjlueFRRbnRGcEU0bk5zQWdLem84QmhSUGxWVWNyRkFJWU02VEd3dndqVGhW?=
 =?utf-8?B?cElNZ2JHREhMNGhkcUQwRFIxZ0NGK2t3b3dCYlZuam1TaDlvYUIyNkcyMUpN?=
 =?utf-8?B?SFJVbWJaRjY2S3Q3U3ZvYWEwL3M4QWxlRzJiejBFYnZxcjdwSXNCY3JjbHNU?=
 =?utf-8?B?STFPRUZUa21lbS85bzBFaXBYS1JRK05nMWlnZGV4QktQZE1zMStJclEvNEJT?=
 =?utf-8?B?WnJWM0MwT2NKUW83U2ptWGUzMi9lUzdoZWp0K0VIekxVWERaYlR2TmZGS01C?=
 =?utf-8?B?U3NrRmN4bWJRd0M1dEdrc0lmckQrS1RTZVVaTENiSVhBNWlkNXd5b0E5K3d4?=
 =?utf-8?B?NmhXckpSM2Y5a2F2eWgzSUhMTzUwVkdNU1dPK0l4Qk1ydktWZjFPM3k1RlhX?=
 =?utf-8?B?KzUwV0p2a29jeTFYa3AvSzBZL1hmZTdmL2t3RFdobHlFUXBPQ3JjdGFXZjhv?=
 =?utf-8?B?R3QvQzBpRXdwZWxNeFBLNUlrSnFFVERGSThjTVNQV1JleXYxWWE5NmR3MU1T?=
 =?utf-8?B?QnNQZkowLzNZSzVxWS85N3gvVnBKMFNEZVBBdzMvbGxnUC9jT3dqcjdNNXhp?=
 =?utf-8?B?cmk5ZEFnUm9tSFIvUXBCblJVY0RQV1JKNXdNQlBmZ1FudjZQZUpLWExyL2Rl?=
 =?utf-8?B?SVJadHhzaXdOZDU0SWJ0dHM3L21sVHkzVEtQVE9LYzNPZVpKUDVRUSsxdGpS?=
 =?utf-8?B?RHVXSjBSYWJaK2JHUUg4eVNjbnBkL29jWHh3MEFmMXd5UmJWMDFNU0ZEa09j?=
 =?utf-8?B?RnNJekVaYWdyVUdXNHJwR1A0OWYxVExnVDcvd1FJMXJONU4xWU84d0p4OFlL?=
 =?utf-8?B?M1dJMW5aVXlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5EdmdhWllId0dxMHhEeU9lR3lFREJtK3VWd0ZXSnpMQXpBUFlzMmloaWtk?=
 =?utf-8?B?bW1xaEt4eldmM3Mxc0txaTlZcm5lSkZKKzhaNHlGT3prcHpvU2NKVXJBaU52?=
 =?utf-8?B?ekNxTXJGZ3laRC9lbldYVVlsa3ltTGExcmRTYWtLY0ZCVThDVkVYdTFoTG8w?=
 =?utf-8?B?VUdkVk1rV1FoemhpT0FzcDNoUGZWck9jekc4UjdrRENkWmpITDR0VUFVYnhG?=
 =?utf-8?B?QzFFY3pVdHlJM0RvVUxwNENWQ0dDNkVFcHY5eFp4NHpjTjY5SWYxY2duT0gx?=
 =?utf-8?B?WmJCL1dLTStMWHNNa3JrVTlqRHZSejRIZ1JtVlpZVVh0SklWZ3ZkYm9HeVd0?=
 =?utf-8?B?SzZFNWZCVmVESCt3V09oeHBWaUdkRzkxNEhKN0k0RUlLMy84Y1AxQUh0T0RP?=
 =?utf-8?B?MTIzWFZvaHNPTll4VXgyYXU1QXplMEhYQ3ZxRGVuWEJTMGJic0VwZlBuLzJq?=
 =?utf-8?B?WmZySTRpem9IWXdTczluMjR5ZVFNWVpENHZ3cU5lWUhqWlRVSlQzeGx0RVNn?=
 =?utf-8?B?bWdsLzlFVFloVjFWdlRUMlBSckFDY01BRERvdk96NTl6cC95K25wTHZMVllZ?=
 =?utf-8?B?V0VTU0E5N2xJS2ZrU3Rtd0NGV2swNEVXTHhXb0JrZTF2QThBLzh6MHN5TTR3?=
 =?utf-8?B?OXc5MmFDK0NTeEJGUGRmTXlaVlZrQTh4M3V1YU4vZ3k3S1B2eG95SnRSSTlD?=
 =?utf-8?B?eW05ZEsydjF2dzFQbXltVXJtQnZrVHdoMWR0ekd2b0NOQ3kvdktlMk5wS1I5?=
 =?utf-8?B?WFBKMmhseUF0a1c3eXlJME80bTMwSlJUMUdtNXZ5bXkzMkFHNDhWYStXdG5h?=
 =?utf-8?B?WFF1MjR2RWd6aFAxNlhBcE5RZmxRYVFwYVREWjNYSjRxVFVJSGcyQ1ZZTHFV?=
 =?utf-8?B?b2d1NENKTXBWOWw5c21PUGh6NXNVT2VEMGM0RHlLYkVvUlRGVTRWNUlDNDQx?=
 =?utf-8?B?K2M5aTc3TWRlZkFvWktvNkNpazVwdSs0MCs3Y3NpSnVaQjlCVHR5UHkxSGdh?=
 =?utf-8?B?SC9qM1kyUXgyeEYyS00zQXE2V3d1QU1GaXpnRUhSR3NVNkxMeWZyUFBIWWp5?=
 =?utf-8?B?em1zOHRubXdxUlhLV24ycGpaaytQVFRjR05pZm50ekR5Z0NpWjJyVXVJOG9t?=
 =?utf-8?B?eEwxTGF1eWI4ZkEzdklNSHJ5SEIxd0JlYWY3V3Z6QTFTOWVPZFl4YmM2czl3?=
 =?utf-8?B?NEZDcWNZc013cmtBMjFCckMrWGZGcGxjQ0JqVms5V25yUThFdkZLV3BiaUhR?=
 =?utf-8?B?TTVlTm5kZ2JuQ2JlN2ZhUFZ1ODJyUXp4S3JZNnBad1RzNFlSUTBQaTBGYlhI?=
 =?utf-8?B?SUdtNDVCNHZYV2hvUWIwK0tkeXl4a2hnbkRqSUhsRy9KT0xqeXpCVWNwa1BP?=
 =?utf-8?B?akZ4YTFEaCt3TTEra0Z1QkZEY2pTTVZXaUxvbXJoeHZiY3VVRnpxb2NXVkli?=
 =?utf-8?B?eXc3ZWlScm1WSnd3ckZHS1h4K1d4d0VvaXBpd1F1QVlJUnVtMWxhNCtNWlQ0?=
 =?utf-8?B?a0RXZFgvNWFhU0FOZmtjZEFKdmlRdGMvZVBGdXVDbm1JYXo0NWpzdmIxRVdO?=
 =?utf-8?B?QTRWa3J5aWFuL0hVNnRWZWZzSzd0QUsrL1JiYnRlQ1V6cGU1ZEFQekNQOFJq?=
 =?utf-8?B?K01HQnFSWGNvYnppUTUweDY0VFpDTUFLQms4OEIwTzMvOWxVRTBrQ1ZtR2M1?=
 =?utf-8?B?bUNUMjJ0K3ROUWlleU5qMWtFcFZtVkhsT21PU1lqTklGY3hvQi9mSlJSbC9N?=
 =?utf-8?B?YTJ3Zm9COGJHVUFUUmVFcHM5M2l0NWxvQVhHQTg1NHg3dFJoU2plOStUd29B?=
 =?utf-8?B?dFltUHNjaFQwYVBZQjVWYU1UakJiSVZiWEczenpldmFSSkwrMnVTYnJtVWxS?=
 =?utf-8?B?RlcxQTdlb2JSTTdMRTAyUGVNSUgzUkRNeFZGcUZzRk9EdFJEdFFmWU54Wk9O?=
 =?utf-8?B?R0JDZTNiZWpVdFhrOTBSSDJNeEdoNTJSc1dEdlpxTDR1UnJXbWQwNXV1MkI1?=
 =?utf-8?B?SWNaMjNhMkNSTlRwRWJWNzZETHIvYlY1VGxidG93MHFKQ04zNDVmVVU5ZmFE?=
 =?utf-8?B?OHhZdWxaK2xvNUZibFJ1YUI0djhzSkJaVWxXTGxxS09teVpXTzBONFNpa0Np?=
 =?utf-8?Q?4qyKgTrtbB9YpO4mTw55AQ/+u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c569b595-10ac-4eea-d4ce-08dd5be9d1fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:29:56.6083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnYFde+HovHwtl1igxnct7p+i1GggeEXalzz0VZkEjhPkgSWD4NWdKKWSbZCgK+K8DRlAIM8Akx9XeJBbgszdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7037
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 needs to combine DDR PHY firmware images and their byte counts
together, so add a new entry type nxp-header-ddrfw for this requirement.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst                  | 10 ++++++++++
 tools/binman/etype/nxp_header_ddrfw.py    | 29 +++++++++++++++++++++++++++++
 tools/binman/ftest.py                     | 11 +++++++++++
 tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 ++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 780e9817fb..4f05aa0a32 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1663,6 +1663,16 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_header_ddrfw:
+
+Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
+----------------------------------------------------------------
+
+This entry is used to combine DDR PHY firmware images and their byte counts
+together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_header_ddrfw.py b/tools/binman/etype/nxp_header_ddrfw.py
new file mode 100644
index 0000000000..655699e6ff
--- /dev/null
+++ b/tools/binman/etype/nxp_header_ddrfw.py
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+from binman.etype.section import Entry_section
+
+class Entry_nxp_header_ddrfw(Entry_section):
+    """Add a header to DDR PHY firmware images
+
+    This entry is used for i.MX95 to combine DDR PHY firmware images and their
+    byte counts together.
+
+    See imx95_evk.rst for how to get DDR PHY Firmware Images.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def BuildSectionData(self, required):
+        section_data = bytearray()
+        header_data = bytearray()
+
+        for entry in self._entries.values():
+            entry_data = entry.GetData(required)
+
+            section_data += entry_data
+            header_data += entry.contents_size.to_bytes(4, 'little')
+
+        return header_data + section_data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 1bc2fca26e..0c0c469276 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -104,6 +104,8 @@ PRE_LOAD_VERSION      = 0x11223344.to_bytes(4, 'big')
 PRE_LOAD_HDR_SIZE     = 0x00001000.to_bytes(4, 'big')
 TI_BOARD_CONFIG_DATA  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
 TI_UNSECURE_DATA      = b'unsecuredata'
+IMX_LPDDR_IMEM_DATA   = b'qwertyuiop1234567890'
+IMX_LPDDR_DMEM_DATA   = b'asdfghjklzxcvbnm'
 
 # Subdirectory of the input dir to use to put test FDTs
 TEST_FDT_SUBDIR       = 'fdts'
@@ -202,6 +204,8 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('fsp_m.bin', FSP_M_DATA)
         TestFunctional._MakeInputFile('fsp_s.bin', FSP_S_DATA)
         TestFunctional._MakeInputFile('fsp_t.bin', FSP_T_DATA)
+        TestFunctional._MakeInputFile('lpddr5_imem.bin', IMX_LPDDR_IMEM_DATA)
+        TestFunctional._MakeInputFile('lpddr5_dmem.bin', IMX_LPDDR_DMEM_DATA)
 
         cls._elf_testdir = os.path.join(cls._indir, 'elftest')
         elf_test.BuildElfTestFiles(cls._elf_testdir)
@@ -7843,6 +7847,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpHeaderDdrfw(self):
+        """Test that binman can add a header to DDR PHY firmware images"""
+        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
+                         len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
+                         IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/346_nxp_ddrfw_imx95.dts
new file mode 100644
index 0000000000..889f6f2986
--- /dev/null
+++ b/tools/binman/test/346_nxp_ddrfw_imx95.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		imx-lpddr {
+			type = "nxp-header-ddrfw";
+
+			imx-lpddr-imem {
+				filename = "lpddr5_imem.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr-dmem {
+				filename = "lpddr5_dmem.bin";
+				type = "blob-ext";
+			};
+		};
+	};
+};

-- 
2.43.0

