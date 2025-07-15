Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBD3C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0452D82F8F;
	Tue, 15 Jul 2025 12:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lIfIfSqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68FD82FAB; Tue, 15 Jul 2025 12:42:21 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A8BE82F6F
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmFiZmlBYYQM6MLyzX7vecI76vEnz8uIo9tM21RYgGe8NvK2+tY5GZP9SyILYzyeAdvqYC0Ego/ZSlPl46VgllUbLw1kdUA2wWe9rzIsqrTNk7IMut1EBSuwbjzzDYdnTT/mC8ZuR2F4LXUmuC4K2JvSQZ+o7XhHqqoa00KBQwubdCl2rPwAWBJxLEIMYhHZ81OsUQ2cHo/OSFUGljM9jM3ITnUSI3yYM9Og4Ckp40baLFlnlJ9AOtI1uwWrWi92x5eOSlk+A1RLWbFL7u+aTJdXpti2BMZd5+vFqDnO8ZEeOb/tkzHQmNTHztDw2nGYL4rvS3b6s1GkntfpmtVxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDK0mdvcziajOtlyWo8uD4ivfyKUco9WdvrYBpoSuBs=;
 b=VxksDuJC0GZjkvoQK5MRJVW10eGEcBN23MhV4tIM7cYnSY6w2oo3EcpnVF626UBbVfCt3aJ1MIY35LnqUXoZXxiWHLS4LMjKish5RKCFB5/BgmLPhleT/cnSX1DbjPpracOxC+h1k8PZVUxWJInLRjLaGQlJYmX4ilYcD/T0V91EXMNNolrWTEgQnvEuiVgF0P7JCB4LzOp6DGSXSrH425y4cvT6n87KppGn2gl75QDx1kHt3k16agFnSDx5S4sKeHILiDMZ5dMauw1NJ//+92eG3lidr73N1K1EjUqhGuTblio5JGW5o69Tb9ZL7Jz/JLfnBT+g8qMhu9R/CtI7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDK0mdvcziajOtlyWo8uD4ivfyKUco9WdvrYBpoSuBs=;
 b=lIfIfSqLiiuzB0rXy1dC86oXXAlVxsZxx4RXCM3sHDayZyB0y0gScuE2pg4gZdw3t7T7UBlkFdEgsoW7WSwcAdCpkT5vUfFCY+HjKrCgEmyfS+mOf+4FCc83Skd2ZXpZ2flTxM/cNiu/f3cb0+/hyLuPTg4s4nyW5s9rIBUoGr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DUZPR04MB9748.eurprd04.prod.outlook.com (2603:10a6:10:4e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 10:42:16 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 10:42:16 +0000
Message-ID: <27fbb7c1-32d8-48b8-b38c-12e79d940fb7@cherry.de>
Date: Tue, 15 Jul 2025 12:42:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board: rockchip: Add Radxa ROCK 4D
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250711230613.217996-1-jonas@kwiboo.se>
 <20250711230613.217996-5-jonas@kwiboo.se>
 <6034d52d-36ff-469a-8113-afaa9c26682f@cherry.de>
 <4b2fe7eb-f6d3-47dd-a2e6-d577ba60a806@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <4b2fe7eb-f6d3-47dd-a2e6-d577ba60a806@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::29) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DUZPR04MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbfa990-4e74-45ca-1b0e-08ddc38c4444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alUyc01HTmJrbXFXTzhmeDhId0J2cDZ4bTRMNWJKYzlsUkZFVCtlbFdkd0pK?=
 =?utf-8?B?RElOVlU0K1pNMjU4cHI4Y0lhQTVCY3dYNk01MXMvQk9HUkowd2lGVE9SZ1Zs?=
 =?utf-8?B?bXlOZFp6STVMSndrOVlwcUZHcGhGWUdNTnh2QzQraDd0MU1ScWprOG1SWE9L?=
 =?utf-8?B?UExHc0JOMk5CdmFJK0lBNmxycEJYa1V1RmpKcGp2NmdmLzZHc3JqRW51cm9P?=
 =?utf-8?B?dUowY3FTRUlONUF6TUt3djQxRTlDWTNwMk53bFRpZFEzcFZNNWI4UVBtMHhs?=
 =?utf-8?B?UnppZHdXVkJBdVBmNWlDYVJHNm9GcjlFMzVhMWpINkVQOFZ5UXh5UFRTdnpD?=
 =?utf-8?B?OXJVc3BZSzZUQWRycUJ2QVVVamtUT3V0T1ZHeklyREgyY3Mxc05wc21SWTgz?=
 =?utf-8?B?MEYzQklCSVQ4eDlYSkJ4b1Yvd1dzYUhZdlVyaENqdXZqaDljZ0M2MVY0V2s0?=
 =?utf-8?B?UkZlUitNc3liRGJnc2VkNzdjYmh2VkE5UFdodnlUVElsQWd6WWxsRmJ1WTNv?=
 =?utf-8?B?OXN1MjFUNkg2SDNWYmQ0RUJ2SkUvaDg5NGM5aTdCcDhaa3RaanpEdDdVZjVR?=
 =?utf-8?B?OU8wTVBJaFkvM0VSdlhwMVArNEhibkFFaXJmUThCVDBPdnlaNXRFS3plZ3J6?=
 =?utf-8?B?aWlkdjQrS0RNM21iNmZrYmZkWTRZelR3YlIxd1R0NDFXVGZIM3Z1ZW9MRFNv?=
 =?utf-8?B?NjBQdjRXUmNMdW0rZkl3YnI2R0NmQXhPNWV2bE1lMHFHaEF1bWxQaHhYS0NT?=
 =?utf-8?B?Q3B1VjVTVndsSm5RSE9Mb0J1QnUydVQycUhBSkZ2UjZmQUZoV0ZXUVcwTzBJ?=
 =?utf-8?B?WXkvak5IeUJGNEphMWhsb2R0UE9wd0pDdnZFKzhsSjBaZXpWcGU3bmMwbFpI?=
 =?utf-8?B?bEdYbXRZYTIyZjF4YnZYZHFzelR5QmluZlJEZi85VEdLaWtWT3YrVWR1dE15?=
 =?utf-8?B?dnNFWm1OaGFSUEovWk9rdWVtN2NxVWhmNkY2SjRXSy9mNVc0VldGbjdPSzM4?=
 =?utf-8?B?L1J3WjJnR3JoR0tsTlVGQVpGR0hOdk9XVVBLRFRNZFcxaU1VemVXRnhhNkhq?=
 =?utf-8?B?S1ZHYUcxU1hleE96UDdEOVBhU2VjKzFreEF6RnZsZXpzeFBEV0VXV0FlU0sz?=
 =?utf-8?B?cWxGUUVUY2FGY3gyYzNGVFg2QVNOREQ2UDg3ZzdONTdFbzRCZzUyM09Bc2NT?=
 =?utf-8?B?SUw5TnlQQzEzU2tjZTU2NUZlaTF1OVVxc25FNmExVU5XQ2F0YWpaYmNmSitj?=
 =?utf-8?B?ZnVZQ3dvb1UxeFhxNmZsSWRnZ2pYMjNuWmJyVVhVMzBMRnlybVBlT2gvcWp5?=
 =?utf-8?B?a2xDaFQ5MGxoRzJYaldSbytvQ1ZNaUEvTHlEY3hXSEhtb3hTOTFDaXFCV1Uy?=
 =?utf-8?B?WkhmYWJ5M2tnUXpWTlRaYm1UNjhhNjRuLzdHMkFEQmZYU2dBN3hHNHV2UElx?=
 =?utf-8?B?LzFGNzc3cWhmcVBvRXgyWVRXczFCSkM3Qkg5S1VUcEIvK3dlK2hSYmk2Z2FZ?=
 =?utf-8?B?ZWl6RGlDWDdGT20yTDIxcC9uL1oxdVAxaUFLcUgzUi92WmN2WWhYZEJHbm1k?=
 =?utf-8?B?SjFheG1TSGhENjg1U2pHdWpQOVZJaEg0NmRWQWNsVmxWNlNCc255M1cwOVBj?=
 =?utf-8?B?ZmoxdWl1L1RuYVREZFNsdVMzUFZ1L3ZmdkZpZEhtZ1RyL0xLWEVGclEyamZN?=
 =?utf-8?B?MmZOcWZwUENjVE4vZ1BNSnNmTWNUcER1akVnM1dScTBOUSs2dmppV2NQUW1t?=
 =?utf-8?B?aUZzQXh4dFlrSWZTSlFGcEVnVTluUk12ZUMwcTRMdXI4WG5UR3g0TDljUVBp?=
 =?utf-8?B?b1FFU2FNK1Y1TzRteGhhN0RUT1RobDNpNERGdHNlVUlaV3VjaXIrQ0lkSktk?=
 =?utf-8?B?NFNUclFGOUJDS0twYzB1bHloekVkdC9QbTA1MmhzTGxlTUxwYWtlVERWZFNP?=
 =?utf-8?Q?oktDEFAZnUo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUR4MC9xd2VPTTIweXRmZ2FQZTZWYXdSUGRkcFlVeGdlVVNDU3VKcnNwcWtJ?=
 =?utf-8?B?M3hUaGRCdm9IV2p2TC8wZ0VINjhGL0xEcTZSWVU5MDZBTDNYU0VZRHpwKzhl?=
 =?utf-8?B?cm9hTEw2cWo3SkdPRHYxZ1lYb3N0Y0N0SmYvUHBVbkpsM1pzNWc1Ry81Q25G?=
 =?utf-8?B?WFM3ME5aTHh6ek1POU9wYk9VRkRBRjNyZUdta0x2VzJoQ2ZVYWNMcVZDWVVO?=
 =?utf-8?B?M0hkLzZSM1Q0d3lSRTIzWDB5OFRRRjlBV3JhaDFLdHZBOUlTSDRSek9zU1dF?=
 =?utf-8?B?MkR1VGxxL2srZEdPWjFvODNnamRuYmM5YUFaTXlMSDlsenBOM2xZYlFMbUtD?=
 =?utf-8?B?UU1JNThlb2dUZGpXQ2tmOE5Ccm9vN2RkckNGbTBud2hTR2QyYzM3NStZT0xq?=
 =?utf-8?B?WXNPcVdPK2EzcDJPZXh2azB1Tk55L3lKcndObnZwZ01jSUNkaWRCWWhGNUM1?=
 =?utf-8?B?OG9EdnVyelU4NHZrbjBBRWhOdWNxVnhDZi9pRFVyUW5sSkNCZllwMUc4YUVk?=
 =?utf-8?B?ZkJ5NFM3eUVadmFwNDlQZWp1ZmwxUmNwcFZaYk51cjh1a1pINVR0RThsd3JT?=
 =?utf-8?B?a2tjdUpVRXZmVGtxOGRvV3RndHNnTFo0akxQSFNMQmxkRWtJN3Nza0w0WU5a?=
 =?utf-8?B?azRZdldSeWM5UUZ5ekN6a0dERGhRUlowaXpodGtHZXpmeTdqU3JtejVQODVI?=
 =?utf-8?B?Yk1hTHNiNGFYTUVzTVJGZk82VGxFOVVLWGlqQ0ZaRS9mSENTY1pxWklkRWZV?=
 =?utf-8?B?TnBTalIwNHFmYVpnSU5ZYXBkTFUrVWNQTkR3TDN5ME9PV0JtSTBFNHhlYkd6?=
 =?utf-8?B?UGtiU29va0VLQ2tlOThLajFBNHVHVFdjMDhOYlFaVEp2SVVIR0pLOEswVFQ2?=
 =?utf-8?B?YVpQd3c1OHRXb1dsUWNyQyttNExFSEYyTmdFcmtkNjZaQkZFZ1Z2aWQ3RlEw?=
 =?utf-8?B?akFCZThLRjMzVndRdHhaOFV0ejJNMHpQREUzbjh6VTBORjF3N3FkdDdHT1BO?=
 =?utf-8?B?TG0zbDlTMzJYTnN4SFdVY1Y5NG1pbjQwZEdtNEs1dGtxWVdoOVZRbFNuN25Y?=
 =?utf-8?B?cGh6YjY1aTJtVll1by80VzFoVW9SWnJBWUdiYjJsckl3OXd2U3p0VlhlNUdl?=
 =?utf-8?B?bVBGY2J0cDdITlBCRTBUbStKYk1CcHd3MjdLSXBodlpOZk9PUG4wRUlNMnBy?=
 =?utf-8?B?VEwxLzc5YnQ1RmR0cG5YZEpNRGNNZjlDZlVPQ1VINVZoYW8vcU1ueEFVaWVv?=
 =?utf-8?B?dWlOYXMzeDNGTEl0NXRFNzFOVXdlSlZ2Uk1jckFYTFQ5QU94ejVyTTd2bTBJ?=
 =?utf-8?B?WGozMksza3ErSDc1STFBb2xOK3hEWUdYTURRS0s5UmJ0MEJobFhoa1lZSGlk?=
 =?utf-8?B?clF6TEp1OGRVZnphS1loenhMSTZnUmNZbXNkMm9TUFVWV2p1eVhEYWJHTU9N?=
 =?utf-8?B?QXNHWnJDZ2ZtQUMvdXZOODZCcjNPSU84cEJjZ3BwaWs0MHhCYXhaQ2U0Sy84?=
 =?utf-8?B?alppSWIvUkZjY2dQK2RTR3B0MnBlbjVJazR4dzFoOFM3WEFDNXdnRndSY243?=
 =?utf-8?B?dEFDcW9wb0svNFUzTVlLd2JWTDBPV2Q5aFZURXg2Y1ZTZWpLTXdFQTE4Z2py?=
 =?utf-8?B?SUxxbHIrV2hiQmZzNzVSSkdJbFBHYzUrVVh2MGxrdmw0WWppTS84Z3JBdy9a?=
 =?utf-8?B?RW14SE1BZ09qN0xielhQazcwM1YxaUNIbFJIVVd1SzRVNnVpeTZXa3lzOXNR?=
 =?utf-8?B?R1E3QjE2UmxFOGl3b1FJRy9CZThXTEptRlcrSEVnYTFMczR6SHdVYUVzRnEw?=
 =?utf-8?B?dHBvdkNHaklqWnFBNk9MNzhSa1lQQnAxSXhSWS9kYkYrOWlpbDJBUDhSaTBU?=
 =?utf-8?B?dG1WOHpCSkUrZ2V4UGNJblVDVUZ5Y0RrQWd5K3l3UTkwbHd0TUx4WTd4a1Va?=
 =?utf-8?B?WjZmQ3F3Vm5hWUlPYUN0Z2lGa2JCY0pTci9DKzhBTTNWdXpCTGFvMkl5ZkFo?=
 =?utf-8?B?VGtha1JHVXB0ZFEvekMrTlhzb05mK0FqanJqZWZZWkNHcGFnSXp4ekZSTXNw?=
 =?utf-8?B?VmJaVWl5ZXF1QXN4U200Q1lZUVVKbXY2azg2WXUyb09mRlZGTHRJRnFJSjFy?=
 =?utf-8?B?RXIwMTMwSlRZcTZxRzlnNjN3NXhEellKVU5SNDRIWkM3b0JTckp1MVVMYXl3?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbfa990-4e74-45ca-1b0e-08ddc38c4444
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 10:42:16.5968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cVxNXLvDuHfglxavCZy7NoYt3oOQEddsPc9qff9jWY2nGtLLhSTSe8hnOV3RNKrRvPjNYubO0yERminNLK0KswAkcZwHWCuKoVUSud2+kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9748
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

Hi Jonas,

On 7/14/25 6:46 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 7/14/2025 6:35 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 7/12/25 1:06 AM, Jonas Karlman wrote:
>>> The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
>>> numerous top-tier functions, features, and expansion options.
>>>
>>> Equipped with the Rockchip RK3576 or RK3576J SoC, the ROCK 4D boasts an
>>> octa-core CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 GPU, and a
>>> powerful 6 TOPS NPU, making it ideal for AI and multimedia tasks.
>>>
>>> Features tested on a Radxa ROCK 4D v1.112:
>>> - SPI Flash boot
>>> - Ethernet
>>>
>>> ROCK 4D boards with SPI Flash is configured to boot from FSPI0->UFS->USB,
>>> or directly from USB when the MASKROM button is pressed, booting
>>> directly from SD-card is not possible on these boards.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    arch/arm/dts/rk3576-rock-4d-u-boot.dtsi   | 15 +++++
>>>    arch/arm/mach-rockchip/rk3576/MAINTAINERS |  6 ++
>>>    configs/rock-4d-rk3576_defconfig          | 68 +++++++++++++++++++++++
>>>    doc/board/rockchip/rockchip.rst           |  1 +
>>>    4 files changed, 90 insertions(+)
>>>    create mode 100644 arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>>>    create mode 100644 configs/rock-4d-rk3576_defconfig
>>>
>>> diff --git a/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>>> new file mode 100644
>>> index 000000000000..5056a1cecb83
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3576-rock-4d-u-boot.dtsi
>>> @@ -0,0 +1,15 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +
>>> +#include "rk3576-u-boot.dtsi"
>>> +
>>> +&rgmii_phy0 {
>>> +	/delete-property/ reset-gpio;
>>> +	reset-gpios = <&gpio2 RK_PB5 GPIO_ACTIVE_LOW>;
>>
>> Why?
>>
>> If the upstream DT is wrong, please fix the upstream DT first and
>> cherry-pick.
> 
> This has already been fixed in upstream DT [1], however it is targeted
> for v6.17 so not pickable for another 4-6 weeks.
> 

Maybe it'll make it in time for 6.16 but I don't see it in Heiko's 
v6.16-armsoc/dtsfixes so it probably is too late in the cycle :)

Can you add a comment that this can be removed once 
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.17-armsoc/dts64&id=cd803da7c033e376a66793a43ee98e136bc6cc25 
is merged into U-Boot DT?

So this part is fine with me now, thanks for the explanation :)

Cheers,
Quentin
