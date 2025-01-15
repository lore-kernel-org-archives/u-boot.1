Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5159C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E674480761;
	Wed, 15 Jan 2025 14:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x7RKUo/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83C7680753; Wed, 15 Jan 2025 14:29:43 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7843180726
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JziVy1Xe0oc4uFS3qqCUFCzDvTuAbpHiTo+z+bOfH20OMd7/LU5D1LrXwx6mTkFbPjbf35w2RGd9XR85FVNu7qD4jFATTNwYt9B2LzSAaHo8TUEwjDLnkid4jf/TWtaNFnNTcgQ0XiscfMOe542yanJHT3q6IJSYvQM+mMXPJ1KDfKDFEnWBAhD48usBwqaKW00pfqtdnxq6HNTka7HeYkYOaQtNo1Jg0AWh1s8lgM6weZ5IDB2eyK4yr6OJyCbetxTyouoGEeeqyWDEeHHHCq1NdgZxmKrlrM3A6NbShCSFiUo+ehnh/qYHWLYaHN9tJPJcdqKMXbbeFHdPRvAeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gsKhsohElbbGo6eurhrhnAhb1W66FkKf/flOs8ZIm0=;
 b=KMz8FNJOHOho0N4yN/NWxSj9t0lxNfMpY55LR+lSN3zLTu0eldi5VYu/XVINMQglmlj+OJteSzf32Zbc3xkGJ0UXhfl2G8uuxqftgK1790lqUi1Qa2d6atTPQHh3br07Pw2CXTiWdr7IFi6UVUMl6HiTawjIcNhTdxO4HVOYQZzWHhgnNgD5KGqlOf2b/48/cbxcEcJxdV3DXBCOs5yOXWSrD1UaohwqFj73huP4wqyjIKVOqt6WUTGRCu5zXGjuvgZ5WOxuvIr5uKOcZTorjYmy1Z0AGlpZ18KFbx7Pberm/FCK/v+8lxkWpMkmoU0WKXSVybBnxlf8LTub3qsHrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gsKhsohElbbGo6eurhrhnAhb1W66FkKf/flOs8ZIm0=;
 b=x7RKUo/xm6/zV1LxAmb7tdKYLJyRDW8zGiFFrmRurVw5RQ7Bhuu63CuLKhiGsB+v85sLB+wPihDjdjenNxLQEbC5D+1Q8RWHzREFPeWB8mieg4Cv2PpNFT6UrCAjNpkGuJ5CBvogDzKGtjiN9R8igPYCvIJ8i+P2LBWH2Xr8IO3vnAtcGNtEioOEqjCi7rXSLm+yLk+K3TaEZleq0+dLurBMpHkxwlyoXvEJSGIpEKeN9hfprXvlkUamAbCylkgKEq9Njcofoo+WSLtpOpzh63sVCc4MrruQpLTEcm5DAckmgnGPtMlcn9sl7SsGXBRkQtIhCGN/jLnVwiLt/sAKqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:38 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:37 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:54 +0800
Subject: [PATCH v4 07/20] clk: scmi: add the command CLOCK_PARENT_SET
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-7-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=2503;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=l71ScTKWtHtOdfZx9OnBCuYLXxuAQFWJgqyLe8SCfWo=;
 b=eZpqh1mvw2oyaUPvnvK1l+AR1MOpuksX34R8k/y0IG7YO+PvZSF++lzyo5BKs06vSx3Mt1s1d
 /HZuP+aE8L2CDdOBXQTxt6GfLjd7of0jwcAJZ2bYTeBleYa5Fghm4UN
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 55da3658-178a-42e6-ed98-08dd3568a826
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlJxRGZBdU9JSDBHWHNQR2hxRy9uNEVsc0lKZmZ6NjNsRWphVE8ySmVjUjV6?=
 =?utf-8?B?dFk1aEZ2WXZxUzZoaEl5b1BCTm5hekRNYlF0Z2lqYmtlb253a2cxcEhxdzNX?=
 =?utf-8?B?cjZtU3oxQlV0RVNRdkhzeHk5QUwxRFhuK2NYUGFWU3Vta0lTRjJmYjlIbHR1?=
 =?utf-8?B?LzZ3MjF3alkvalk4ZjlvRmxsTEtIaXBwSnkxempxZEZGeUhYZ094MzVmNEQv?=
 =?utf-8?B?VzhZaWxMMHZOOG9TSng0ZEVmLy9lZDE3Y2t4RGJtTkgzeDM0NEpRRTVnRk83?=
 =?utf-8?B?WDVxc3c5SXEveXEwdklveWNpSVJ2b1FReFRKSEN5MU5OTzNtYS9HdFlubDhS?=
 =?utf-8?B?WDZzSFdZRU9zbFFBWjFjTjNtMXByQ0RiV2lHd3dVVkdFTHJxZ1E4elNUUXc5?=
 =?utf-8?B?WThpdWw5c09qN25jaGJiVWJHZEZvUkp6dmZILzk2TnV2RTAvclpacnBFQ0pu?=
 =?utf-8?B?ZHB4aXNxM280c0JCd1ErTlJld09wNkxmMmM1dmFoTjB3THhCaGRCUmd3TmZG?=
 =?utf-8?B?WS91bTcveGxhRnNWNGZtNGNLUWl5cUJPcmRKQm5YelhuVW03Vmh0T3BHVnVH?=
 =?utf-8?B?MC9WNUkreElneXJnRmN0MmkycFFiYzZiRzdLUGNTTm5pWi9icnJZK2hkR0R4?=
 =?utf-8?B?VG5NaUczY0hOelhmUjVuZmp2cWZoTDdwTkNZSTN4WkRnK3FtcGQ5SHlXWERS?=
 =?utf-8?B?SC90V2tIQmhzQlJyMGh0OFREU3BrbGo1K3JFNENmVG96UlpudXg4cFN5ejF1?=
 =?utf-8?B?ZzY5UWRaM1pzdXdWS29kY1RlTW5qMEVZZWZRSmFHSlZmMk53WkJrUkRMZ0Yr?=
 =?utf-8?B?VXRjYkk1cm5LM2o1ZzJzK3M1SUZkdjkxeld0WjRxTG9ZZWVCM2hXbGlkOVN6?=
 =?utf-8?B?VHREeGs5RXQ0ZUFNNGNXQzZ0SUdKdXlGZVp2QU03a3RoeFMyQ2ZUZkhZM1pS?=
 =?utf-8?B?VkNmUkswVWU4dFhqamErajc3bWt6SHpGeFZIRHhVR1g2OHY1QjFDNmdFS3NW?=
 =?utf-8?B?czBKT0xadnJ1RW56WFR3T0w4dUZEN2NHeHlYcWJnbHRQSHJaR2p4NTY1Tk5N?=
 =?utf-8?B?QklSbkNNUndFWHZHalhXeFNtakJzditPTUZSUXZRbWRDNlppcVI0Z2xGMlpK?=
 =?utf-8?B?ZFhiMHFvNUlxdTNISDdZdVo0djhOQll1dkp0YU9jazloN0xaQkNjYTE3V0ll?=
 =?utf-8?B?ak5vTWVIeSt6YkZNVjhjd3B0NHc4RVg2RGlUbVFmK3orSld1S2Zka1lsay9l?=
 =?utf-8?B?dnlVem9sTjlHcEFjV3RleWhpZUgrS2RGL3RSbkdEY2NlNVp5ZEpsRjUxODRy?=
 =?utf-8?B?b2NDLzJKZWxidW1HcVFqd2RJQkN6K2NPZk5FWU9ubTFUN0pmYUxlSlZxMU9j?=
 =?utf-8?B?T0xaMCt2VFBSbEpSS3VpeHA0Nm5yT2dGYndRY0NtVXNtKy9uNytyR0lGOGxT?=
 =?utf-8?B?aTZ0NE1aOTJnd21VNHk1VHA0c1l4Q05Yb0FFWFJoQkphUmwveCtDdG43S2xp?=
 =?utf-8?B?UXZwa091QTlubzdHNkQ0MlhCanEyNnpBbHowcGJPN2R4N0lWYnhKanRpMXBj?=
 =?utf-8?B?RTIzeFF5RDJXK3hCSCtZeWRydXp5cWNzRmY5UUliZjBRTVVhUHpCOHFvR3F5?=
 =?utf-8?B?dGU5VXFOemx6OGFXeHV4bzQvek9Na1JKSFJnMXg3bUlYLzlEZHFWNHFXQ3E4?=
 =?utf-8?B?V0dWa0ZWTmlKc25KZGdCWlpSbmZ1RHQybVRCUk9qL0FISnlXM1BTZCtKVll1?=
 =?utf-8?B?UUM5TWpKU2pNZzJpaUM5cXhIMGZXaXQ1cVBWNHVTaEhvaEU3ZUFldVduTDFy?=
 =?utf-8?B?cGNnNmZtcGhvYkdoSnRDV0Z6V1dyRkhVbEpSOSsvVkRoMTFFUUtlWjdXRm5W?=
 =?utf-8?B?Z1pCMng1eGxlcTZITVVSMEdZQk5QS2QzL0w1ZnhaTGtQWE1oeHhKK1VrMzdv?=
 =?utf-8?Q?+y65fI5yY+pbYgrWkGaA38xsGKMOZjnm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mnp0VVhiVldCUjNJVEViaDJhNzNBTXo1OG5QS2EzMkl6RGNHK1VNZzZFU0xQ?=
 =?utf-8?B?ZkFQbVdmVmozY2tUNEgxeVA3UzROV3IrNXcySDFUZnlsMno3dG8rdEFBUkda?=
 =?utf-8?B?VGhKTzMwZXFiMlBpaVlnZTBjcFNWOThrVWZxQmxacmtYNTBnelhVQ0JCNlN0?=
 =?utf-8?B?SkFEVWhWRXFmcmw1SGtpSWlTWDlhbW5BRWIyeXlSakg0MGFIQWtKd1ZmekJr?=
 =?utf-8?B?cmNLamNUdStaOU9ScjB3MlZrU2o1NCtoc1B2NFROaDNQWlRpV0xTUW0wYXVO?=
 =?utf-8?B?U0p2dGFTS2hkdnlvQlNEaXAweG4veDc2NElnN2dYTEpncjFRMjJlcTYzN3pn?=
 =?utf-8?B?RmE4eWRDN2F6aFk4L2xjeStnMWJSMG1ZM1R3cFVwazZNU3NyR1R3OGdnSGJI?=
 =?utf-8?B?YkZIYWcrK2VJbkV5NmNMYk1PQmEvK0g1OU5sVHV4U3hoWHZtR05qandjcDlh?=
 =?utf-8?B?RjkvUjJaSVVuUEI5WUVUNEt6WlV2OXJka0JoUE1yUUxsaUV6MzVDNmFMQjRp?=
 =?utf-8?B?Rkk1NW9tUE9PVU9FQUYrZzNIMFI0TGg0OVpMSkw5NXpuR1JvVnpHY2RZWFJq?=
 =?utf-8?B?TXYxYldPYzhSZXkwdXZ4VHNhUmViUHlNNkZVZklRNVdwbStCcmtHNHhjUmNh?=
 =?utf-8?B?MExic1lrcjh5aVBDWG9HbkJYbGY1Sk15WG9MenFtRVdIcGFseWVwQVpGT0RB?=
 =?utf-8?B?eDNLUWZyMkZWZmhQWUZlZ3VHUEozWGpTcDJObTh1QkZrYUxKUDc5NjdkRFFk?=
 =?utf-8?B?cEJzSTZIK3Z4YWRUc29QR2VOWm16TFFGV09iYjNBUHhxTjlHNnNrRm81OGht?=
 =?utf-8?B?MndNYkVpb3ZPUXBDRXBlWUkzVDdUY2hhUDc1L1M0b294akREN3hRZWlOazFa?=
 =?utf-8?B?WFlJZy83a0RVREljWXAvL3NuUFptTEF5TTF1VXk4WjJrWi9kQ2QrQU1DZjNx?=
 =?utf-8?B?b1ZwUU02WVVyeXQ0UnpWSmRFMkl0cldKbkJMREE3NWZaYWJXVHVyVzNxdGxM?=
 =?utf-8?B?QVR1UzVsaU1rK01sMWFsQm5nYkFwOS8rWWVyd0czdGs0cXpndWFQcWsrdytY?=
 =?utf-8?B?Z21ybllFbU82Zmcrb3hXdkpkcDdTYnZEaEtwZ0k4a3ptdVFRWG0zNUlzenFa?=
 =?utf-8?B?UUlBWlkydDdXNS9vbzcwQlR6Yy9XOGNRNGNFV1c1dVFWZmNqeWloVzFqTTVv?=
 =?utf-8?B?R3EyTzFIZGdtY015TnIwdkYxb1g1eStEY0VpalBhZ0FLSjhzd0swU3I4WkhQ?=
 =?utf-8?B?RUhmVG1hc1Z2U0lzVDgrMlo5UWhFUytuZkpJWXN0UkFPRnRUb0JZQlRaa2FK?=
 =?utf-8?B?M3dmL0pLME1KY1JYL2o2QnJiODdjbEZBcU5VZkxlY1R3ZzlteXV1S3R4L0p2?=
 =?utf-8?B?b2tnUDE2bmp5bUh1SkJnanMvanlycGxKc3Yxc2dvQnZlR3BYT21Bei92Vkdh?=
 =?utf-8?B?Y2F4MzBSU2F0VmRSMDhuWE1EVTFmVEJiMWU1bFdvZEduL0FTNExaVUsyZE85?=
 =?utf-8?B?bzcwSnlqeElLajJpWnI4cmZzZi9DSFJ4ZmlHMmhXK0N0QzAxT3VuTkIzSUNB?=
 =?utf-8?B?Nm1KcjdFcnl4S2NqM2FWSC9VNDQrdkNnVy9TZnBraWFTM3BvWVRMSVhEYW1C?=
 =?utf-8?B?QmVveC8yTjN4UXJpVGZxcTFtR2NvRTlvNXdHSnI3elh5VjVhUFNaNnNVTnhh?=
 =?utf-8?B?UXhWMms1Kys1NHVhaVBVc3kwVEZ2Rlg5VnBHUzBSV3N3aUFFbk51b3FaS0kz?=
 =?utf-8?B?UXNRcXFsTjZCc3FUZGJpc1FKWWJpU3ErYjhSSjBPU2dKY0VEWTF6eVplVjcy?=
 =?utf-8?B?OGowVFdVRm9Zc0lGelQzSHVSOXhzcEs0cVFCTGk2b01RYytINk9QeWlhZktP?=
 =?utf-8?B?VXBWWDlxSW1mVk14cEdRU2R1eU5GWEsrMCtRVFVhTWdOR2Y1WWZYcUx2TGUv?=
 =?utf-8?B?bW9qUm9MbmVURXBHWVVLUmpvNExYQUxSUnNGaFlJWHdnLzNSaEpKdHFSZTVo?=
 =?utf-8?B?ck9oanc1Yzl5YitFcVlibkZWSE5TOWxhNGNwRkVnNGs4bk11QlNhb3FFS0VL?=
 =?utf-8?B?TTB4aWc1S2NPNCtVbGFsOS91SXZrMGRwMlZGbkJJVnhLZnpWNER4azFKcEkw?=
 =?utf-8?Q?YBwzFwcjte0itqzvFEd4kTze4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55da3658-178a-42e6-ed98-08dd3568a826
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:37.1868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZyinsedN88AU5nfsNYnlEMNjLZFWfknr6RR0CMViKIGlZgq1WMEQTmGMox3VDvF1dPsmuFrQPEsV+Eg1BDV+dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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
index e42d2032d45e011b751c19b395b6f99d5c54e78e..84333cdd0ccfe566c269f776f39725c69883c25c 100644
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
index 08c86a642844570424dddbfcf9670d1e6757d8d1..d529f8e2697472e60d0cb9c275f34ef0ecaed3ca 100644
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
2.34.1

