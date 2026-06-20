Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FADCD98F2
	for <u-boot@archiver.kernel.org>; Sat, 20 Jun 2026 01:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F85D84901;
	Sat, 20 Jun 2026 03:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H0CralS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F89849A4; Sat, 20 Jun 2026 03:04:46 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33AD584874
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 03:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTTxtO0q3Bgw/RwszkC6ZO26xyBdaC07UecL+F00Q65z9+qBy1A1+sdAiO/SnM4WT5qG0/cxpWnAWWCYYPjQk0kdmdRWAOiEvLltX/u2Ybm90tBPgr1BbX+98Hbwr0SRKnTtwZ1MVPT+BRmPdlyvtJSDLNmkfLrFh3/pCCnHX8t+nGV84pg1e2DUR+HfiCA6r33IMdDnAz2owUjBRpAA8lq25eYux9ISBAyoBeqGFlaGpOFoR58pQo6gS32V5hqmAS8brOUwa5sgzsW2SEkpygwBGNFhB2NueLUX2MwgreuhysEhLS1d0xfyun7bF5NLCjcLdJNGyEw1G4+931jCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hzkvc3mRzX0znAz8P+pRmbiGBGm4y94aARNrDD8QKA=;
 b=tzfTOFnB2vDQ0yvM+bdBECKQWbiQ7fvD4ZJ2QCbFIiMCd30k7hSKcE2o/t5zh5dEOs3VoGxumJZp9STKgLRDUbngSpXN35LEQwHgJVNGNLfIsgA8JX5FnIJ3P28bAd8S+EzUmMdp/1c4Fesm8/OBGSBXLoUYM0QcvuULVAIZMxImBvZQXmNuBj47WlxP0le9Hd/Wx1QuRVYmYwnPL2txh8+gv3vlaYVHtUGGSJ0aFRq++MJ/A6kWNnbyq7XfKLrswl/K8n/G8SpjZOoMRB88DzRY15gtTN2u0tGEqxIHwMn+iPI6XWKqJum4GmKMi2t6u0vMvgU37DCwNKwTwSl0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hzkvc3mRzX0znAz8P+pRmbiGBGm4y94aARNrDD8QKA=;
 b=H0CralS9KFtdaM/oZWUi+KfnHS/OZnZ6wz1620gB2L3zFAR3o/wG6MKWho7ujm4plMcl/3u8/Rg+njnKvOHA8kT+izJDX5ZG8SzKXbWsNikmEeugBmrvQnK/+HSHJ7paDrQ6P+JxKIZW1IhTsid5ig4Wghu6WsiePN2vD/XJMwAmQY275LUh5no4mXsvXAxCrm54vjqfTXj/DzYdIzXvkmBlo31UJQajjWfXOyNk4dZ1TQP2tPrye0WxGD6kClhLlV5mcaqxzWgzetGa4C4yOT4xgKQ2Zkq8N/QX0xnG6g536O0Age1xCkMSQO9hCZYgp4JG9xhGpv3qoMRpnC5VHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DU6PR04MB11231.eurprd04.prod.outlook.com (2603:10a6:10:5c3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sat, 20 Jun
 2026 01:04:41 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 01:04:40 +0000
Date: Sat, 20 Jun 2026 09:07:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 uboot-imx@nxp.com, Eberhard Stoll <eberhard.stoll@kontron.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH] imx: kontron-sl-mx8mm: Enable the watchdog at boot
Message-ID: <ajXn7jnm9K1czBaV@shlinux89>
References: <20260618061325.8547-1-frieder@fris.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618061325.8547-1-frieder@fris.de>
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DU6PR04MB11231:EE_
X-MS-Office365-Filtering-Correlation-Id: 096225be-9046-4e21-fe02-08dece67e817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: fC6SgMTVXZX1y/1hE9qv5/gwqsc+9qf8FCFOvpm5Zsd8wRxAfwk8uLYrRGM6qVBuJONg/qk+aR6wWap/slmTXwaXvyQEKPd33k4NIuXrYEtVTZiubRFzVa5fROhL9supAvHBrPWIdcMYcROCcGNVORTyEVmRSDoaM5aUqYhZrvcYe1lEuqix49L2pdnbOOn82Ltdq68UXw2d+LchkD1843hcQ5kkSS7pLQYCgJ1s72RaYK9V0caABxqKD3orwMvkmKAg6rereOFnFxTYretYWdcoq9a87iUuBKtyf3V1jTA4CGH+qIRywmcP0WQkYDT4o9c9a6acLl6SitwVSpt5ARDPsnajentaU2CCyhFAtnX+06BXmy93XpK3sor9hQSXdKXMDwdtvUXulyARbLlDcv4Jro9G3U1XExynN9KQ9CCNeWu0jNhqBvm2kwa2N8R3TtXgO15JZ27c57ZZtc5Zj5DMTUtcnXM6cCNugxOTO/sItE6y2uY0CpYnwlQ9J12484ZNIwYNpbcp/1DmPJ2a8CQCo5umWvxXaltJAc4fVgoPMkGVMgpze4zyt+NDvxYe+m0RYBfhHEIb/HQIz1ewXki3/qnHjDX8FIvlUjRHoCP1FdFaPf5OxoWTRKj+DDeq7b6sFvFj6AbbEdhV4aYBUxat0QwSBYJwwV+f1wZGnMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rQjSllEkXcJUsYOa8SgjkXjiAnyce7Qlo08niL+Qg7NSWYllwqeazQijp/UX?=
 =?us-ascii?Q?QNv8nQsEUc42FFZSdfkPlNoUnRIo2jg6jqVEahDqvWekfFIUyF2D7ELMvuKZ?=
 =?us-ascii?Q?OY+mIsZooWqzAVXf62xYrzTQpxRuP5PmmbMNPV6aGODRgqdxNaDvOet2PFSn?=
 =?us-ascii?Q?LmG3kt6IViUYd/pDywH6AiK0HkVdDynj6BCU9tbALm9+y8RjM2u/iHtkZ8mw?=
 =?us-ascii?Q?y6JT8njcSJixbmVuL/GBAW9Ox7owIWRPUOua+E+sCtTGUSNiScpU0O6g6LCv?=
 =?us-ascii?Q?EdF0bk1YJvdP4Z0I+r4OSc9NIDSDCQaMQLXJdruywR24/jrS5jVwHBZPPvHA?=
 =?us-ascii?Q?ALVTK8eTDLU18pAZErqLUs1ur+bAVxVBSKihNiQVzdiwT/XETmOoUSpCySlz?=
 =?us-ascii?Q?3zjX/jwFdQ2EKaadvyq31Q+VN5wv1gHmBVcDpr7yxuwMYB11murs7GMPyHg7?=
 =?us-ascii?Q?3EkHJ98pmOWKeT8Yo3aXxv3viO1EGl7gwUJKJQ/SlO2AlmJhKKtbcsbbA4V2?=
 =?us-ascii?Q?hoD0nkwuScTXCT6+/YVLK9Wj7P/l0IMhBPFxZrtEutbl7ABz9GahH5aVCS4b?=
 =?us-ascii?Q?zkqqhNCdORfFEhOxUJmjrfW3RXLa7REAw7pV+g8IJX5m6oXOm8XZglP/AbLu?=
 =?us-ascii?Q?aatml689KOfTu68NwwbicW+y4XVqW7+QPGnlYEGTguM66SoxHEMQI2swr+eB?=
 =?us-ascii?Q?N3BJhZiuOWR2miqJXoe75Em9AugQ5oHBHxwJ/lG8Ex7juvmEyzdom2ta/0ki?=
 =?us-ascii?Q?SuW82d1UWM8zN6hEVQYDO+IqEmwW+LKpJtFejcr8uU2ZY4cgczvcg39RomBc?=
 =?us-ascii?Q?CAsIh33IUa1+pM85/U/rEt3huoXqYk6H+yiFDa70tAwBnw90MVaTwSpn/9+b?=
 =?us-ascii?Q?2IF8R8UCwAs6QBzUf4ViOwUvDRE0SBTMq5d8Sx94qR1CQzEC/EZ63kholhxH?=
 =?us-ascii?Q?ol3EEkQBiemsS30MiFe6VC+OBqwD4GvYgHjsKJhxScCkBOKrBTh7NsFRSm8m?=
 =?us-ascii?Q?UdcHqWW4C5X9knCghGiHZV7PKoLPDTij422wKwcLuhdkZIqnGEY2+AALiQCh?=
 =?us-ascii?Q?DhKcIrH7GdHS5UPywYazzqKzwghgtSRmtFkzDTpG/X1iZTAOsg05+MYj+j4K?=
 =?us-ascii?Q?QO/z6TK8JnHNOvuVP5W0kKmkb7JKhubMkdMhu9Xl6ZyiYcYfvFik9iVU6/WU?=
 =?us-ascii?Q?RK8Ks9jQJPt1x6ZSoEe/7HnaU/scoWGHu3XHDDntj1rDwZb2WJ2bmd9Ardt7?=
 =?us-ascii?Q?nH1UDdT3gwNQRp2DmEe+fzvNmVhjB1kIzTNnVjE8rHOlRfqicF5+Tb9WxHfv?=
 =?us-ascii?Q?+VQGOJlsNPpYXmYjtGTmhDcdnH8x1dNfLlV9JgedAwHPXC9miVLp6525eo9O?=
 =?us-ascii?Q?NKh/BKbqnMkkxEBRMnek3XhKZhnIA/M8DDFWE3xwfJlgmfssqXnL8Y5Dy9bq?=
 =?us-ascii?Q?sC0iHo5Oc+eWbH7SdZ0lWxrrrphu8gegV2sj15VfTC/X2mDETAdHjMhUhQQ9?=
 =?us-ascii?Q?7kg5vjMjQ7wpgwS1v1FH3ykJrqDE6Yw2oJGQroOox9zO0un4R1jfutzKmdIX?=
 =?us-ascii?Q?Kk7flthu1eATPMjS+IlbvBY6ekVS8kFu6mVSfy6HoWxO5dbIc+uk+cSJy0D5?=
 =?us-ascii?Q?Gj+nVVt5iZW8Ts470UKWiIIEYJ0UooLF7CfHnR4eDbHqSa+0Gf1NQ7qQYLWS?=
 =?us-ascii?Q?8Wq7ClUhM13CNlC21fkHVnkzqUiCsuGDXhDwe4DFik1ZLICIi0ZRcl7m0oMK?=
 =?us-ascii?Q?uYFwrg9uWv0su1Y6qeNFAA7VZS3KFK7jll/2Khg5pXHo9kjBsczO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096225be-9046-4e21-fe02-08dece67e817
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 01:04:40.5646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9la0BrECsY4pvnA8IM7VIQoWiavfrOCw1FDmAUOOl/0kTHO8mQwpi1TPO0fWtUHW7ZrpBetul2Q7MxHIbEb+YJ274nKsVEPCsG5ABQcibjtVnCGDJBULXUdK6hbW9TkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11231
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

On Thu, Jun 18, 2026 at 08:13:24AM +0200, Frieder Schrempf wrote:
>From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>We want the watchdog to be enabled at boot by default so it can
>handle emergency situations in any case.
>
>Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
