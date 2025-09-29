Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD123CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD10835A2;
	Mon, 29 Sep 2025 08:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="j+fXA17w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A507800D7; Mon, 29 Sep 2025 03:48:50 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02E27800B1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 03:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzQe8KZlfu5uYDT8uWoj5t/xS4uVP1kgNIObN+MniPWWzL7Ksk28kUiZlE3gjZ3Vy9yroyuz6PT4h1PDGxEo61k73ZonQMHFHEZO5IdAwKByIiJ/2AT8iUUqvUvunA5tNedPKyjxKgpWLeB26jHPxdTgv/X6tK6Ha4xAfJLl13eWlzz95Y3+qh6OSWRYIEGTYXoGM5ZFjFs4rSQh9Gj9otVOBk9CpUEChk6W4YVgdF3VH41ApSiDZ4VcSrpKIq5R5e9hYfug8oLBDECTCcDi5fCVmT8+aGMhz8nW8+h6snN9iIICEUYV0GHh1vKE3OMo7+ThbRq5vx7jGmvQhWw7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI/LtKL+UxOQXtc/w9XDE2VVB81wVpP+IbGXOEZnfzo=;
 b=DAlrWfaPac0ApKiQzD1HpO2ULw3enGpUAhiK7TR1PY5ha0W8dRO7RUwo5TjeE0hR09iarZXrYXO87evC5RLFlJGysMhVSRpGQ1m5BNwjmNn7b+zyXYNQcDsKDgKa9ZtmbGI5P6k/F54ZobZgqKecWmqqZUaVrSoqGrIQoQ1MB6f2wb8SisK6X/ajrAi7cSWe96HTjyCRGGJTtl2s+k+WK4iabLOVXdH0INu8JsS4vQFlxZScpViL9SBKadYzIsHv5NwUDbsqszAKLl2zT8X1whVeVbZRP/7SsKUk72UnvofFKbiHMzesDjMLzhRP4OXdYsmI7cCi6Yi3OfS9kBFpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI/LtKL+UxOQXtc/w9XDE2VVB81wVpP+IbGXOEZnfzo=;
 b=j+fXA17wRpOdgAiNgG8GNzyVDeCq2Xw19GXvjFHjiCmYogpmus5BwXivnh29KLJJvAZWPa3/fvffvLgx5QpYRac1aZPuyVDNSR6DSBVb4QCpeMQL1mYnhGktB6zlRmrnkew+ryhJfZ5Y1wyUGJfPipYyKrMJ7E1jpDKpWuF8xBGScH36noJmdrrcexLjBFTscQNtiOsh7ZLEANBji9WXeEcUANTdxicJF7vo/aX1Hgb3MqOi76dfniy1gO2ZD+pH9iBqJ/skvTPd3U1BtJwY/1TVc0Eqo89oZQqJHYntAFtAK04XpP3OpiALb2xxxxccq/uv60qZIMmInuACpZA84A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by MRWPR04MB11520.eurprd04.prod.outlook.com (2603:10a6:501:75::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 01:48:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 01:48:44 +0000
Date: Mon, 29 Sep 2025 11:00:39 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul@pbarker.dev>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/6] power: regulator: tps65910: Cannot test unsigned for
 being negative
Message-ID: <20250929030039.GG4184@nxa18884-linux.ap.freescale.net>
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-5-42a4105336ec@linaro.org>
 <78a0767b-2508-4602-a37a-eb4e72b37120@kontron.de>
 <b44654c2-de9e-4bd6-96a8-aa338435048a@linaro.org>
 <d320ef0e-2711-4f86-9881-6aabdf6766c2@kontron.de>
 <5b5d3865-1bc0-45c5-adf8-0f63cfda47bf@linaro.org>
 <20250925143209.GQ197373@bill-the-cat>
 <dca01239-06be-4669-88c5-62a8ced8bca8@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca01239-06be-4669-88c5-62a8ced8bca8@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|MRWPR04MB11520:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ce9baa-c8ca-4179-7edd-08ddfefa530b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BchcBrQqNbEnS+K4NDSNR9aJIvQy0e8nWSP0A/e71FtUInF5/GeuhhcFiRG7?=
 =?us-ascii?Q?64hu6hbF1OZufEMa+QwNihADD1TP7FTTcKvAPKyvJ4hajJURdU58CV/7d8xW?=
 =?us-ascii?Q?C35XLGs3v++VKrUYlb0lcQ3vmNIJVduIoFBkMxg/nHZvi2rg0+o30fY/UmOL?=
 =?us-ascii?Q?RYnFafLoNUTRpviDfk+bzyDZkMPvLtyqAsxTAqiA/5wzcyQkivI2Xc6kS17o?=
 =?us-ascii?Q?Olr94RMqBk2c5iWVLSzWPnY3veFuJRNvA2J2Gt0JCYxVz8Zbri2RTA2fh8Gn?=
 =?us-ascii?Q?CdW2FgWsXL9s6d9FUvwOInKtWKpLPOatzbvZr52s9p9pmz7jGbDBGxi+ykDT?=
 =?us-ascii?Q?NrW0rYOEQqJMbviPlGS1yCBikOx5gctX8K2NWuQIE8QTHQjeNsAxyNrWPwZb?=
 =?us-ascii?Q?DddgmaVcra5aBuLNd1qvtYoppNek3ojYARMeHjxGDEAxGQwbAk8kLL9e8lE/?=
 =?us-ascii?Q?wWUhbt8WgaxH66Pw+99b0x7YSDn6E8toPikkeTVsNEThCRThhM3T2uksXTYw?=
 =?us-ascii?Q?M55JeS6TiDF2ncQnuwrRao84B7VK4z023GIfvvRr7FHXmGNkZ3qv9GxLMz5v?=
 =?us-ascii?Q?2AxO0UDyVZE6W76kSxyRsgticP3JpnS9VXi/VtuEQuBctqlsSQY20tM22Ic1?=
 =?us-ascii?Q?pbTf2kE8eN70A74hJnVbYox5VICy+mqr9H0UrWhlm5zCRMDYtZkCk8IXCjDp?=
 =?us-ascii?Q?EXRFNXb9TX5z5EWKFeus9/HjAShEGw0EZB+s99m1GzBiQn3nbQv3b8xoQxqt?=
 =?us-ascii?Q?dnOSdAV7bCMx8dZXL6goiZ9Qubw3o+bxdha9uMNCjmVjVbZShrUtq1wU/Ja2?=
 =?us-ascii?Q?1u5Wwwgbi09y+IpILZ1UvvPVgHTQjNLDCgGdbsq6yXuA17vIguHPY2IFighj?=
 =?us-ascii?Q?CiOZhTgQsOp0n1zYArhJ7t3a6bMDqKCNqH+QKH0KtLGieHIQr7XDDGmAKaYC?=
 =?us-ascii?Q?fCrJngS0dip/jeJ4XP4t34cYLxT8JC1PI0ARxrZNUvTqFVkcgvU/W6H9y2G2?=
 =?us-ascii?Q?y6dlkwLljwSxHTs4GVqBujfcFQedYsTVHrXkBBIoNOwZ5GVMI9srbP6hzm4k?=
 =?us-ascii?Q?VnVkx/kmtomMN86RXTWsGX1CjWLrVIzNBrEij/iRhfs4WqUAxZi0EylUqzdc?=
 =?us-ascii?Q?g6/m5VESkFjY4D0YGloilENtUHlc0peavM4FPG6675LZMLChxpL1I6ktg9D2?=
 =?us-ascii?Q?QAFuRofnbiEOCnB1XgJRpJNxxZV2LGx8mLbECbXTTkBEjRzOE3tFTcQGQob/?=
 =?us-ascii?Q?kP8OEstosSc4Z7L5FQuKTIDfnZy3pL1jRo/juYAjsbzNqvXtxhx1UBJ79/a2?=
 =?us-ascii?Q?37SuU6INNWgbUdVoa+/LiYXZnQ/AfGa/zAGIlG01UBDNLnF95G6OGUIVa0dO?=
 =?us-ascii?Q?lr6ppPc/e7iXteXjOnLeZFEd+EXZMD2DQRa8+wOP4jGczxqnuXgCwzLOdbr8?=
 =?us-ascii?Q?xWxho8w468v9ciM64V7tc4XiaW3pn9smc0JlsgRHdaNdVLPQEmiNSOcXREaE?=
 =?us-ascii?Q?JYnGpWsFzQxgWZZhLq98EbfsyBBq9w4511IW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OssWU/JbmprPtjT5zMb2FlodKk4qJcoP8Kua+VLeopY+pU2QxOpeBuwI2vNw?=
 =?us-ascii?Q?Ku2CpBDR/siH0DWXK0HigyOE0HSNq8/e5vJumDPUiqGdPB8faUa672MTxySg?=
 =?us-ascii?Q?FrGNuuOtJeBlirh0fKMYV06t1oP4yU7oY2gCYW/D3YuXhFwaZUYJAulkrC06?=
 =?us-ascii?Q?khENnJ+2Bq5SSwXHeueWH4D6zoI0ya1cXn5n26U/2y18zZh9eqL4jQB818M7?=
 =?us-ascii?Q?B3ECexSZbW+g6zn66FHS0wOJzhtkwOdPQkoDzGU89JwIprUbueeyC4DLJjCy?=
 =?us-ascii?Q?dDoM9AgZSjGCPT423ejosHxPUNIeVY4YTPXFccRhrr0TotXk6XBnlSmoj2rG?=
 =?us-ascii?Q?XdwhuR6a2Oes1bVgw29NgBXdKObOL5AWoZibqM79MWhSoF2yQAaLDcVIWncz?=
 =?us-ascii?Q?YWflGIH+xsCMShtjtQUtNplYgnU0oCFGbwBtbfiYqlpm7idZswj50AZeHDzm?=
 =?us-ascii?Q?/tJ1PRAnvojaog+vn41TI5Dae0tKfswU2APvbP202N/LdYsKRGiFb9CwuKBb?=
 =?us-ascii?Q?Z+s8MeC1hmbITklLVN1ycXDeiPBcwtgh5rXxOivMqmz0JxA9HAjkNMTCyfCu?=
 =?us-ascii?Q?IltHApPnI923Tk+XW4bU/pmsTZxvsdmHr1RqEdXf4iMFNah0BwzfiRcDQcLX?=
 =?us-ascii?Q?0UTWD4FTEWilYXR9rWMuBLpJN2sU0DJEKjfYX5WaqmqfqKAwN0xcbV1GRAxd?=
 =?us-ascii?Q?7uZ26CGcmYEdumYOjelWxd1dp/KIZQqYfCet98tXu7rJl4y8V+xtgQqS5bjf?=
 =?us-ascii?Q?q8iEIBtOp12HG7o/wgNHS1ezBfU6FxgzT+9bgzBfvCBPAzySuHXCn+3MDEKd?=
 =?us-ascii?Q?zUAg98NlHNsvAo+0+hT4NLCmZkRM5i0Bipo/PmcItLrjd7WsYqbFrOzFB9yh?=
 =?us-ascii?Q?QpYtN5CGDVLhuwj7DYH5Ze57AuiU2SIfcLMj6XZvCU4BChBZXK/MYQNURxHC?=
 =?us-ascii?Q?ffb28OjVFknZyjqNy8hbD+/INfq9wSQRN3UmAqcQgFtP9sejhy5fHKWGnUMg?=
 =?us-ascii?Q?GLj3ebv/JFk0vDX1xICM0GT5HkkFwQWVzgQ/CZf/n8mqiEzo4dzLIR4A6EMN?=
 =?us-ascii?Q?k0cd3MR/XESCEGV63LRJbxIggG5QbA0lkEOz5t3WMMaZzMkpnOCKkJj+uovs?=
 =?us-ascii?Q?kFJXoSJYsiColvgtHKlcs5Nnh1PZB6CClnadX2sSQivqdw5lH2fsvNz0GfB/?=
 =?us-ascii?Q?YITBTLmHrb/HkfXBc3l4jrzPV+KTOJfCEciv+9wbVPKxS1qpM0uXlt5pJMSj?=
 =?us-ascii?Q?Vst+mTyAI2N5B6pXEr5UhIN5l0QNCcXL1H0vs6786rxMRlx4pRNh33gK10zc?=
 =?us-ascii?Q?2E7aXUsvKh9iuXbAe2PtheXC2RGCUCkServCxu5XOqppV3ng8wV4+g3d2Vin?=
 =?us-ascii?Q?VVsAptdlPLlW9WcwfhehiXYnex9/zINL9W/2H/Mu8Y/hjzlIStAE5Bna7NF0?=
 =?us-ascii?Q?S1cnk73GSZwtSpq8NBrriwDd/bE4c/kwF79iK2CE8YmMlOkYLxFoeDr4yOuH?=
 =?us-ascii?Q?eYW2F4is2sQDqHbkyMSnErXeasfFhr0qaCGqPoVZpVM9RBVawlYJ+con+C5m?=
 =?us-ascii?Q?TyTarvFQQITBW4+38zmHQ2WzocIvLeFlBBobzwlE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ce9baa-c8ca-4179-7edd-08ddfefa530b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 01:48:44.7967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKXmUR6HkLCVkAXFX+zPWTTKIK/53VdKv72CPAW+SFYB5EPTXDMcaAwxQbm50eIApnczr4VyOO2BUbxSjsEUWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11520
X-Mailman-Approved-At: Mon, 29 Sep 2025 08:49:07 +0200
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

On Thu, Sep 25, 2025 at 04:28:15PM +0100, Andrew Goodbody wrote:
>On 25/09/2025 15:32, Tom Rini wrote:
>> On Thu, Sep 25, 2025 at 12:11:14PM +0100, Andrew Goodbody wrote:
>> > On 01/09/2025 17:58, Frieder Schrempf wrote:
>> > > Hi Andrew,
>> > > 
>> > > Am 01.09.25 um 18:26 schrieb Andrew Goodbody:
>> > > > On 27/08/2025 08:54, Frieder Schrempf wrote:
>> > > > > Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
>> > > > > > The code in tps65910_regulator.c treats the field supply in struct
>> > > > > > tps65910_regulator_pdata as an int and even tests the value for being
>> > > > > > negative so change it from a u32 to int so that the code all works as
>> > > > > > expected.
>> > > > > 
>> > > > > I'm not sure if this is the best solution. The supply field holds a
>> > > > > voltage value in uV and u32 seems like a reasonable type to use.
>> > > > > 
>> > > > > I would argue that the driver should be changed to not use int and
>> > > > > remove the negative value check.
>> > > > 
>> > > > Hi Frieder,
>> > > > 
>> > > > I would offer the counter argument that the TPS65910 has an absolute
>> > > > maximum rating of 7V so any advantage of being able to use all 32 bits
>> > > > vs 'only' 31 bits to hold a value in uV, when 23 bits would be enough,
>> > > > is somewhat lost.
>> > > > 
>> > > > As I say in the commit message all the rest of the code in this driver
>> > > > treats this field as an int and declares int variables to hold its value
>> > > > so using a u32 throughout this driver would just mean changes being made
>> > > > with no benefit. Removing the negative value check leaves the code open
>> > > > to unexpected behaviour and hard to find bugs.
>> > > > 
>> > > > More than that the field is being assigned to from the function
>> > > > regulator_get_value() which is in the regulator uclass and returns an
>> > > > int. So following your suggestion to its logical conclusion would mean
>> > > > changing the uclass and then that would lead to changes also being made
>> > > > to all other clients. This would turn into a major project which I am
>> > > > not very keen to take on as I do not see any benefit to it.
>> > > > 
>> > > > So yes, simply changing one field in a struct from u32 to int does seem
>> > > > to me to be the best solution. It achieves the aim of fixing the code
>> > > > with the minimum of effort and I see no downside to it.
>> > > 
>> > > Thanks for the reply. I totally missed the fact that
>> > > regulator_get_value() returns an int. When I was looking at the code, I
>> > > assumed that there are only positive values ever used.
>> > > 
>> > > You are right. Sorry for the noise. The patch is fine.
>> > > 
>> > > Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> > > 
>> > > Thanks
>> > > Frieder
>> > 
>> > 
>> > This patch is still showing as 'Changes requested' in Patchwork but I am not
>> > sure why. Should I change its state or should I leave that to someone else?
>> 
>> Please update the patchwork state. I assume patchwork also shows the b4
>> email from when I applied it. However due to patchwork being slow
>> sometimes the state change gets missed and I only run my script that
>> updates patchwork to include the git hash when I also merge next to
>> master (which is something I should look in to doing more frequently).
>
>No, patchwork does not show an email from you applying the patch. Actually it
>looks like Peng Fan applied the patch then sent you a pull request which you
>merged but no b4 message from Peng that I can see in my inbox. Also the other

There is a applied message when I apply the patch, I use b4 ty for this.

https://lore.kernel.org/u-boot/175873139553.3222.3482387473099940414.b4-ty@nxp.com/

Thanks
Peng

