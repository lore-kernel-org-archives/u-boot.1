Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DC1CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F95D83AB8;
	Sat, 11 Oct 2025 20:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="repG/Lis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB09883E11; Sat, 11 Oct 2025 11:13:46 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F177083C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoPPFRoTxckdgkdO3O/12z4nQWiznGTy6YzcxmDtbwcVewiu3QeUTDYbYJtABJeJABNuiI8hUSK7Ppk4KR9wpivUMmBwuU1UBXbbBnP4urTfd0ooQ+X+0xbGgeOGrlHq+2oheoI6wNiQZSRzRi/dRsOm70feXwwTlEV2RZpNKh+KKhZnDfcqwk73WAut3gauTwQqJ4ITTt+/DSccD5I+t8UO/sr/AgM1KJwy2itlyfvRgnBnb8o/yWJNteL7/2XlICm19Gm2kI6l8mGwNJtYnI4oHMqKXbbgchDSAbt40fEKcejF+mYhlYIygrdbWKjj1TifxBa6NT0tRpCUAEGDmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wGqX4clhIDD//T1SvSyRCB068QUVTxDjzgHbvU/0Kk=;
 b=lFa0kfYbYi3fQamIHR9xMNNJG/6Os/4P6d4kaqbFbzJiZ017rdmU64OFDDOLcpH0Z5t10RvVQ6gyL0V1iw8av2wgegnvl6yLXq7JULP0SuiGVd9umkZCo8VZfL3+dGoBlUqJiigjpRdczZhpmuUh0xSgxAiDflaIAPr6AR/5X59tQvkETwtNCaqvh+Sm031NukcmPP4z/27Z2xC1wBIZVI02YBbHL/1IYo7DRXV5wjRI4ty/FBN5utb8tImlzuuVJXNyGOqw+ST454pfgmdCXlybl2QwL9bo4sxFmUZ9q9DSmr3FttBRFPqEcxJ8HT9KP4EODQawnYoDsYSlBeEVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wGqX4clhIDD//T1SvSyRCB068QUVTxDjzgHbvU/0Kk=;
 b=repG/LisUMTaM962R6zGIftWD0gkeRkl8C+wywYdAi5GRm0pkaKfaUlPUCsy5EG/u922dlxB9dGnAPuyGtRYV6pl5F8UpStSEgf6MGd8YGyuAHKSvYLz2DAmc+j6gyUrn/0vuNFBg6KvlZN/2PJgbRUtIogdItMV2D4iGfuuQDRQXH7s7MES1IF4X0ABrPlvdqJP+cF2X+iwXjXt2yDWEFoQGqgfRVD+uB9/RVqE7kY/qCBS+x/ZQ6U/xGRUH3JYoGehee+DfSXgD+R7ajh5X+Qy+u+/lT/HzBIyZJqjW4eq2bkuxd7BeoMK6CMFe8QEBiEenNy81KkKy3n4Hac2Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:13:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:13:40 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:49 +0800
Subject: [PATCH v2 01/10] usb: ehci-mx6: Extend support to i.MX91, i.MX93,
 i.MX94, and i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-1-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 348417d7-4301-41c2-51cd-08de08a677e5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVVGUFNJTDFaZmg1UStjSU9WVFpjZ2ZGNmZhd3l5RTlnSG0raHZlVGV1dXlL?=
 =?utf-8?B?ZGxhVTAzcUI4NGJwczl4MVlqSTVkUTVpTXFIQjNwb1FnVytiSVFhakJxS2N5?=
 =?utf-8?B?SjRMNVI4VDFXUlJiWEJPaXJxanFscStwckZrWWIwNDNHSGVzdmhhZEE3akJY?=
 =?utf-8?B?Q1N4dHIzc2FFWk13OVFiNWV1cUkvdy9qcUZGUlJ4U1lJVGlIR2ZjMnBYMVlK?=
 =?utf-8?B?S0cxbHBkSTVCTnAra2tUa0I5Q0FmanZaekRKck92SmtVWkQxdkY5VHo4dnhC?=
 =?utf-8?B?Z1h2T3dUdllGa1ZUdXM3bS9lZnY3Qllnd2RwZ1VRenRCVG5SUmhqL05YL3Fn?=
 =?utf-8?B?MG4vOExVdGNHZVF0Vks4YWVoRzRLejZST0UzR1NBaFFoTm5QMmxzMkFTbHpu?=
 =?utf-8?B?QS9YWVZCNVZnd3FwRC9Dd3JpWEMxdllFMlNpNytyZTB0UktDc2RvS0lkb1FW?=
 =?utf-8?B?VVF3V0RQQmY0S0hDWWxacTVwYVN4d3UzTVMyOTk1MkJ2Zy8ydDZLMFBEMmFK?=
 =?utf-8?B?ejJ5Y1dBeTBUK1AvdHUycVY1dG5ld2JhZjVNb2ZxRmlLUmNsbE82K0psekhi?=
 =?utf-8?B?dm51VlRYQW5qZzJqOUx5SHcwYlN6bzNPUFhjSCtJMGE0RnR1Z2M4UlorRzZE?=
 =?utf-8?B?cXlhMXJnbXRmY2tPRjlNRTg5T2NWaUxzRDlmMklTNFZIUy91WlBlOUFyM3Zr?=
 =?utf-8?B?OURsKzI4RmxmYklPWEo2MUtEdCtnaGhpeWdDTVV4V1I1dHlFNEhwc3pUdGE3?=
 =?utf-8?B?QUVEUmRSUk44VFJQOTdWVnJmNUpwNTBpTytQR25VN29KblY0d3ZheVpjTjBX?=
 =?utf-8?B?WG9ZdjBtemZtV2h2QW5ueTZtem5ibWZrOFNwUkF2MzNocHNyUTNoYnV6TVZS?=
 =?utf-8?B?TG93RFcwV3dINWdNNnNHWXJTS3RzQm11K09KYWlzMnFER1V3RlY1MVlUZXNj?=
 =?utf-8?B?MWNBRVRqMXA5cHhmTHVHRFZDcExsTmkwYmRJejFjWHJQRTRMVmFiYWRRaytZ?=
 =?utf-8?B?WExFOGpzVGNGRVprQzlSNjVJRktKdVAyZ3RaRUI1QkVyK0tWNkZ1c2lBeDZo?=
 =?utf-8?B?Z200cFVjdUhBTExTZWhDUHFnV09Rcyt4c0dtcW5QVUttaGcvRG5KQUhGSkE2?=
 =?utf-8?B?VlB6U2Z2U1NaM1pET2NTUm9meHJsbXJnK2p2Wkt2YzV5NmRsdmozOGQ3UUFi?=
 =?utf-8?B?U1N6L0FNaExKWElrMnE0N2ozSERxUHoyRlZ5UlI5NDVPTWU3T1lFd29HSEhj?=
 =?utf-8?B?YjZrVHFQVVgwc3E4SG0ySy95SXR6WlJnM0pEVWUzY2dKNXdmSDBrR2NGV2xF?=
 =?utf-8?B?WkF3cVBURWVvdG5jVHRjQUlYOXg3UmFlME5HZjBzTW1tVWpFUTU4OFBhZVZh?=
 =?utf-8?B?dHY5bWQxV25ISStzVlBXR01yeWlNaVJVdGdvZ2FyMG9nLy9TWGpxS3RnNWVM?=
 =?utf-8?B?cEJPS2pIOHJCTzZlNlBIbmNmV3ZjMDljbGxsUS9GMUd4Y052RkpVZGtjdGk4?=
 =?utf-8?B?aHpYUkNZZXE3K2Q3SXkxMFhVaW5YTWRlN0xkMU5LZ0NONTVaVjIwNmRGSnNm?=
 =?utf-8?B?Z1g5aE1VZDFsaUlYMUt1aUpUVGI5S2NteG84U0hFOEEyaTBDTmZkUFNyMVAv?=
 =?utf-8?B?dmtZQWVUclJkbThlTFppVWlBeHJRa3YvcG0zUHYzS2NVZ3VtSEdlUElnMGRa?=
 =?utf-8?B?cG84YjFuTENaQWRhQTNVWjVuZVJ4c1daMU9LYWdJY255N2ZzUlBQL0w4Mzl4?=
 =?utf-8?B?SXZyVm5kN2w5c01JTTVaZnF4WFBYZVNtRDV3MGFMamVNQXM4SVVwRmx0WWY5?=
 =?utf-8?B?T1hGSFJWSktPSVYzak5JK0RYR3oyOEJiTU9nTUVJU1BUNGNwcGp4Q01idllR?=
 =?utf-8?B?Vml5Zlo5T29ZcnBnQ1I1WTh2M00wOHpFbEMrVkZ0S0h4WE1XQTlKUVQ0T2cv?=
 =?utf-8?B?RE1SRjQvYkdYKzRlQWgrelZJRlFZdzVCZi8vOFFBd052ZzA2OXkvWDg5QUlz?=
 =?utf-8?B?eS9BcWh5WWdhSDVZVFJpbXRmeFdDcWl3eHM3ald4ZS9SclBBa3oxbzgwQTdE?=
 =?utf-8?Q?EEXcC+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RXczdmbU1mNEIxNG5hWG5tbVZIcHkrSVhuVGhOTENmUjJlNitnOUNQYmxq?=
 =?utf-8?B?Um9ld3FQRHNJcmZXVWxrQkJpajdhaGxneDJYdXY5VUNHK0c4UUp1M3djQ1pM?=
 =?utf-8?B?UmVtUXlNRFR0WDlVSWM2VWxiZkVveHBZT2dETCtHNGtCNUpJU2x6cFNMMWNw?=
 =?utf-8?B?TnlROTZYbWxRZlBRWXNONHNFQ1M1ZllFQTRiYUlRL29ON09LOW12OXpIUita?=
 =?utf-8?B?Y0NsTURYOE05Q3lRL0ZwZVRpOExOaXlKSmxsV3RaajFrQWVvVVM1SmF5R0hF?=
 =?utf-8?B?S3BNdzFNRXVPNmRKbWlZaS9OM3dISjBWSjM2T0c1Q0JTaFBaSGh1UXRmT09M?=
 =?utf-8?B?Sk9oMElxQ0dLQ3RyYmpnK2xuOXVVdHo4UHk3aUlRelBOYkUxZmdHMTRjcFZD?=
 =?utf-8?B?YUFCMzg0WFloeGVxS0lYS2dybEhNQW9MWTZPWGxpWjVoOEVZZ1FDMW9YUHU0?=
 =?utf-8?B?Y1JXYXRHcEpkZ0NRbWdTWGEzVk00TlZBQVNpRjAyaFN5a3VscDREUWd3Ujc3?=
 =?utf-8?B?T2pUcXZjbVZHdktCdWJVeGN3V3Bxc2kvTi9uUnMvUHVPbTNIckZZSEljZUNV?=
 =?utf-8?B?YStIZGdtd1hIVEZQV21kUFllcEVpdExlaXRqdTJzSzJkcElHd0tNcHRyYTkz?=
 =?utf-8?B?djMxNVhpcEJ5cUUyZ1E1Q0xhNTJPTzVvcmptMG83M3lnMWtHY1N0c0FjOTcz?=
 =?utf-8?B?b29aaG9hOUVDRGxYK2FSM0x4Z2NQQS8wOWlQQkZGcWJPT25OL2FpZnR3Q09h?=
 =?utf-8?B?aFdxeDBqRU41U3hTeS9GZ0ZIZytJSjhQd3JxRVJDaEF3NTBtQXc4T3c3Nzk3?=
 =?utf-8?B?WkxocmIvTnppQytqejJBSnVUSy9nZXk2VzNMMStUNFFVMG9waC8vb1VRQUkx?=
 =?utf-8?B?VWREVFJTRXFJdElHc0xFTnBOS3Z1Nkwwcis3YmJ6amJwc1htSlFDYWQrTE5y?=
 =?utf-8?B?SGhEZmlscnViSHF2ekNFN0hwaXZrL3hZY2R1dGVCUnExcFlHQnkvY3A3M3Vv?=
 =?utf-8?B?UG5MUjYyRzk4a3orVDFPMDFZbUhoTE9wTjg4R3hXbEoyejVhOVdsSGVZdElM?=
 =?utf-8?B?cmVIemRSVWhWYnRsMmI1ZHkzM3ZaQnp2UDA1MmNHY3hVRlV4NXhtb01sTUdt?=
 =?utf-8?B?Ym9tb3owRURVOHhWbkJ6aUVSaHliSjlyZHgyMWpNSWt1VGJjRGJoSnFZL0NM?=
 =?utf-8?B?dGE2VHlnL0libGdqbmRHMlNyL0JMdzZ6N2wweGRCTXBramRvNlo3ck5rQWlX?=
 =?utf-8?B?OEpwRDlOOWxVcSszQ2ZZV1owWEgwd3dadU5pNDBHMHhFYmlvY3ovYzBXTCtI?=
 =?utf-8?B?WFFwNjMyZ0EwSXBFUXFja0VtcmlPVzdpc0FmVmZYeTdHVnYrMlFNSGJjODcx?=
 =?utf-8?B?RGtzSUtzR2Fnekg0cFhTbVBrazdwb3BwOGovZmtuZVRweG9lNi9SVWR4VS9U?=
 =?utf-8?B?QUhNRUNGMTlkT0JUaEdZTlluekUyUFd1c3Q2NFhTMXgrNjFaMG1NaUxpTU5X?=
 =?utf-8?B?USt0cnhqWGFZVExNZWVkaGdsOHRGWXJ6U0VhVC9jbDV3dllGZlY4N2RFVGFy?=
 =?utf-8?B?SDB2OGtrY2FaNm92VitwQVIxV002Nk54UGgySEp4c0MvYlJaZkZGeVRFeWVT?=
 =?utf-8?B?c2tpMmd2TlhtOW5FN0pUMGNSNGhGSWJnTHAzOGFsemNIaUhaVGlpMWMzVWM5?=
 =?utf-8?B?eDlrUW1kWmRTbnkra0ZDUHZRZ3MrOXZ1dHpSZ3hCbEFYdkJEd2NTMFlsNkRz?=
 =?utf-8?B?SXdlWEQ5azRBS3ZuemNjUXk4aWVQVEIwTVYzaXFhYVRkcE5HR04wc21tbWww?=
 =?utf-8?B?VjFzejVVMG5CYzBiN2UxdnNxcUw3T1F5K24ydzIxM0k5VzZPWmZ3dWt0RXNi?=
 =?utf-8?B?bU12T0E5TDZJbktESDRDdjVRZmlTZkZZZHFZcEgxSUsvQ2NsdkJUVkRsaUZy?=
 =?utf-8?B?dTMxbThOOUJlVnl1eWVuL0VKTlg2RklWUWp0WDkramZpblJBT0QwcEhxRFh0?=
 =?utf-8?B?QklNTEZKRHFHU0ZyZmVIMEQ5V1NWZTduR1VlZFZPL3orZHJDNThEeE1LeGw1?=
 =?utf-8?B?YmJlSUJHdUV5cE15V0Q5TnlDNHpCRVdTaVI2a09Obk5kMTRxaXUxWTdrVDRZ?=
 =?utf-8?Q?Mm+YNvgKxL5hAtBRZG1BUimPd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348417d7-4301-41c2-51cd-08de08a677e5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:13:40.4078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: penbwytHZ30BjCoSqxrNEP81s3CZp7ip75O0BYCCQLRw3QJQfcNHFgVPXowcMqWufZz5ehF35/GXbNM8hvXyGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

Since the EHCI USB driver is shared across i.MX91, i.MX93, i.MX94, and
i.MX95, the condition check is updated to use IMX9.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
---
 drivers/usb/host/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 2cf687fc4f3..427b62e934b 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -210,10 +210,10 @@ config USB_EHCI_MX6
 
 config USB_EHCI_MX7
 	bool "Support for i.MX7/i.MX8M/i.MX9 on-chip EHCI USB controller"
-	depends on ARCH_MX7 || IMX8M || IMX93 || IMX95
+	depends on ARCH_MX7 || IMX8M || IMX9
 	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
-	select PHY if IMX8M || IMX93 || IMX95
-	select NOP_PHY if IMX8M || IMX93 || IMX95
+	select PHY if IMX8M || IMX9
+	select NOP_PHY if IMX8M || IMX9
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on i.MX7/i.MX8M/i.MX9 SoCs.

-- 
2.43.0

