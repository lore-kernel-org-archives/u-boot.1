Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B56C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 13:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F158006D;
	Mon, 14 Apr 2025 15:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mqcdeuYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB4F81F30; Mon, 14 Apr 2025 15:40:02 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA3538003E
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNneVFPwzwwK/lStpByhOzsx/7RPeKZNpxhYW68GvEX6Zx/IEkHfqPH6hXCbC14msEyRT2lbBwieYTMabACLgEYKmc8h+F/EhIBNyUa1xwjSwFDQEnm3QUi6TOZTtWcoOnFZ1ADkUcqaa3iKbEqSTLEHVzZYWr1tWRuT0BmLNSQr4gSZeqquN/3Mnf9/ItPnEXRp6YOcVLLibwhOKmSaFs32Nz3pkF7A/ug1bWkyoLY34bZ679dqTcNHckk2+D3EWy/SJ1yd06uZ2zQZ/ozioQQE1/SbyrJKxmPkCVkyyLQNmgu7fOSYCx2uHKc2ErcQwM8hFE7uegLLNRTuZg2ryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDKyVsnTiQeBTL/FnrA8KFeTpoi3fDadT2bqZVC3B6Q=;
 b=XcLTTW+mKce0O8RRTpRpcA2LgVBlT/QGokH5rWyxg6UPhIAXRAsgI0QC6K9CPVKezbNQGbvGs7866nvyeNJyEG2daUSY1oTgdTOo48sM3+uMl0/sfP/1CXjs0UJgzhSrzpnlkwz6bSL0R6HJPt/j1/XaZ4znhxPjnXNv4cEvMwsqmLLwivfskNd/sQIIjGzfHuqXt0QSjxdcrldBFnykNbm3aC+OgMUEKr9I8IzCz2acbxTXR3ivAkf4/qp5AdDtGH7yVkOS4A/jhyHN795/1RxCphZYnxEO+enRnCJvUPW3jKkVeJ/Yjwe8VyLbl8LN+I3RP0WcenrUyrBPe838Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDKyVsnTiQeBTL/FnrA8KFeTpoi3fDadT2bqZVC3B6Q=;
 b=mqcdeuYSuczjVu3Rg2IRWd4qfGHrGWKhptIUJ9fRAfxZCAhcLQ20tQUD1+S0AmEiCkLyaLO/LL2CnhlV6HUep8KoaIJfeZhe81qS5z+5Pbmw0SDyyY0qLhVXeE1kBn/AX+o5uwljBaiRgnxDK7KV1NRasf7T5bZAKRonS/bxVbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS4PR04MB9552.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 13:39:58 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 13:39:58 +0000
Message-ID: <912e416b-f02e-465e-b150-e0290ffe3be9@cherry.de>
Date: Mon, 14 Apr 2025 15:39:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: Remove CMD_NET protection
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Martyn Welch <martyn.welch@collabora.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <a28c1113f97c4b480ba6b75ed695147eb17a20ec.1744353078.git.michal.simek@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <a28c1113f97c4b480ba6b75ed695147eb17a20ec.1744353078.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS4PR04MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9f5187-7dc8-43d4-6c79-08dd7b59d8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1ZCK1czNUNEQXhOYjVyYmtrYWVhc01vMW9hb041b0lGVlJBUzBGUGxZV1Jt?=
 =?utf-8?B?c2Uwc244akRyMlpwb21yekFWNEJ5Si9sM3FNdGdBa1ZYcUpKVVBNT1VTbEts?=
 =?utf-8?B?cWtHeVRDR3VnVU5LWWlreDhPTzNHQzQxREJqb1V1ckg0NjMzZ3Z2Mi90NUQ0?=
 =?utf-8?B?b09pdXlPNEorZytmRUhrL2pTaGM5OWNiZGtpRzBlS3FJMTFob0NrSE5vT1VT?=
 =?utf-8?B?YkdBSU9tQmlORHM0b3U1ZlNIOXdFN0IxTlJTRHkwa24wNUxvVUZBdldsZHFj?=
 =?utf-8?B?U0twRFBCQ09EQlpaNUlOcnJTM0d2WUU5VzdhMElxLy9nc21oclp0RVNsMHU3?=
 =?utf-8?B?RldkaERrYmNPNnh5Y05IVGs5WThyaU9sVHFEbGdKRy8yTldyM3VYU1YzdTVv?=
 =?utf-8?B?dUk5SVRrTkJrT0lGcGUxNmN1N0F5MHZPVUF0RDFWR3FiaDVpek82bmhxMk9j?=
 =?utf-8?B?OCtDK2tSaWRlWEpxaWIwWXVUZ1pqOGFuczRBK0tiNm11RnhBL0hQNEZBbUJJ?=
 =?utf-8?B?OCtJWnZ3ZURJcFhqZ3NuTGJvR1VkWUk0NDFsYStaY3JYbU5EU1BYVDl0c3RC?=
 =?utf-8?B?Rms3ZkNuNUZ1YjBNMGZ1NXVuK3ZNYnZJN0hsNTZCM3l5eEV3SVAyMmU0azlY?=
 =?utf-8?B?THhCeENZWmQ0ZmN0UFRWTExoQkZJNW5wcHpjOWRtWHpHNVdZOUh5NWdtMmhs?=
 =?utf-8?B?bDVCUFBxOVdoOFppTEJpMmYxcWZXVE1rMFRuRXE5YVVyQlBaMEc0QWlhdkFh?=
 =?utf-8?B?bFJqYlZMQW1WUWhKWXpjT25lT0pWOVQ5NmNyMTRHbDNhbGo1eEhXY2xnbmcz?=
 =?utf-8?B?L1RmN1FVZnljVWtFb0tURWVKdUFIOE4wUGV4dERRZVlnNWNqOVo5a0NJTEpK?=
 =?utf-8?B?OWF4UG9WdGFGbFhTVjRwTTRzbzZ1eVRVNU5HY21zV3MzSWM2Zm5paEw4eDJ1?=
 =?utf-8?B?N1pRV29IdTRXV0xwTkRBLzNqUFBibW56MndrZnBQZVpQQzlnV2Z5RDlISUYv?=
 =?utf-8?B?aU41SVVESDQvS2VzNFFXUmRpT3NPZGExb3hMZ3BqMG43UXBWTHhCWFdOdkhH?=
 =?utf-8?B?Ymltd29pYUdEUGlKZnhhb0t5Z1orcDlmTmg5WU9WTE4zR3pMNHRVbWhxbFVh?=
 =?utf-8?B?SkZrZXNIRkhrSXFZWDlMZGVFa3EzWjhiZ0ViSXBVUzJUV0E4NWZ4TXYwakhW?=
 =?utf-8?B?Y05HZGg5cWowZEw5d2xNcllqYnlza1BCNU8xL2JYVzVzZ09kS1AyNGdzaGN4?=
 =?utf-8?B?UWY5Tk1GcU44bnIwZ09VZDZqOE1iMitnbzFEZkdhYUR6R3hKeUpjVHBnY3Uy?=
 =?utf-8?B?b3pFZ210dGtnMHhUVlRRYWFtZlAwWU5acjVGMVJmWjlaRjlwZE56d3pDV3p4?=
 =?utf-8?B?anNnajZubXErMmNMclFpbGp1N1oxbXZGck1FYS9CcjNKNUJXRmdHK2FYUXZj?=
 =?utf-8?B?WlUxUUV5U29jQVd2VWUvdkdIVmlpMytGck1IOXpITEZPcTIvK2pPSjBycDdq?=
 =?utf-8?B?c3dSMzVTc0Z2L29yU0tzMmhsVmIwWjBFSGdXR0wvNXZPUzBuZGtYaVo0TzdF?=
 =?utf-8?B?NVlZSnhGUGYza01VN3FXb1VlN0d2aWw5ZmpYVWdVanZ3VkNOSnkyZnZtbVFB?=
 =?utf-8?B?VEdQWmtrdVp1aUpwaTJwK2VkaDBzZU5ycDBKYXM1RHRFdW81ZzQ0aUMyL0gy?=
 =?utf-8?B?cjZ5UVR6WVAvQlFYZGRvcUpmT2ZHQzFEcFJYZnpjUFRMUVF1Q3pkSWtuSE1K?=
 =?utf-8?B?dURBb05RQlNDa1N3OGEvRzhnb2EzNHFGWUhKUUJuYnJDU2tzR2lWWExobEtK?=
 =?utf-8?B?b1k1SG9kWE95S1FBU05CS2VlbkdvOUZETk9OT21GaEt3NTdzT0g2R1lrTEFG?=
 =?utf-8?B?ZTdVRlhKYVZKOVVjV2RoQjZsYVFkT1NkbExQbkoxUytnRXAyYXJBL2xnVDcz?=
 =?utf-8?Q?E2MaMY6ISls=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3hpa0hRd1BIaXhqVy9Oemg0bnowY0FOV3I2VHQ3R2orK3lwc0pnZnFMWFhF?=
 =?utf-8?B?d0xVWTNOb0VMTzBWWGRxTmJ4OXFOZXg5eFpObXlKWC9DNnhGdk93b3hqT3VK?=
 =?utf-8?B?dVdOSkR5eGxmYjhwL3BpQjg1VE5iTG5vaVVYWlNQS2EyRld3ZHJvdWs0QXNP?=
 =?utf-8?B?TitnT3pQbW1YRmRBc2VuTTcreEtvU1lBYWJqejhYZzRZQXZZYXUvUDl0ckFW?=
 =?utf-8?B?R2NnenVqNUhhb3pUMU5meXdlcXkyeWxaY1VhUjFqNjJPUGZpaVlYWVc3NmIy?=
 =?utf-8?B?cVhWK1YrYks0NC9vYldmWjJwWlJxK2JRWVVnTGxZSXpQR0xhWkxpMmlxNHdv?=
 =?utf-8?B?ZXlWbUwrdjZ5ZkxyNVpwY3oxSG05RTFCZ3Q2TTV3REs2NStJaFhvS2EwYk5w?=
 =?utf-8?B?OWtuL3kzcHNkUG1XNTJmWVNwODhpbnBvN2VHWXZPcUUzbmdaOUVtSEt5WGI5?=
 =?utf-8?B?STQ5Qkl2VHRkejI2U0MzQXZXbWlWVDlkUVVSaDNkanpzSVlseDZ5K1BUeUk2?=
 =?utf-8?B?WWxTeEJwOU5aTml2OGU4YmNMWmR1ekx2MXEwWXVlSE5sSVpUMFI2eG1nd3Vn?=
 =?utf-8?B?TGhmS3BmdEtpM2VPZVVhcFgxZmZGRHA4cnMvQmtlNThralZuQzZ4QUtxeXRl?=
 =?utf-8?B?TVIxL2s0dXhlVEl3L25wTTU4Z1BFcm9vdzlKSnZ3WEhLZDFybkpNSjd5THl5?=
 =?utf-8?B?eXBhOG42dTBTaWNMbTU0UGNZWHRLYmh6ZTVaaVlXL29ZNWtlellSYkVnOUNL?=
 =?utf-8?B?ejZBUTIwakE2WTByTExKMDBEWHFJMUFCbitML1A4TmNXaEMya1Uzejd3bHo4?=
 =?utf-8?B?c20xSTY4Z3BVUGNodDZOZkIxT0tzVG44SDNXWHdlbFJtZDQxZklMNVRDdWxZ?=
 =?utf-8?B?aUxwNU1maWxYNVVQMnpsckFzc25DUTQ0Q1ZrbUlZamgwMmNxRDl2TnlzZG4r?=
 =?utf-8?B?UzRCVS9wV1ZhRWFkbzB1RXRjR2Q5TldxN0JLWHF5bzVjTkFBTi9vQnFUWS9i?=
 =?utf-8?B?UGNxV0ZWY1lnZ0JQaFhnT2djTVlKekFweXhYR2xVdXFjbEMrdEwwUTJ5V3Zy?=
 =?utf-8?B?cVVGRGVxNHhhZm1aNjhlNjFrKzlyVHpLdHgxQ056VGlqdy9PMnV4QklZenlD?=
 =?utf-8?B?Z1ZOZTFXSWNSTzBESUMvdy9RVHQvd2tXV1c4aXVwbjducGUzVHkwQ2pTeUJy?=
 =?utf-8?B?K0xvWTM5NUdlWERSVnYvTFhCWUk5NFdqNmZZYzVJNG5UL2ZYWUQrMHhUL0t1?=
 =?utf-8?B?OEF3NmpzODlKVmlnVEo1NTNDT0ZRNHZwVHhDVXlRQ2FBdU5jSlBnUzRHK3ZO?=
 =?utf-8?B?TU1HVUQ1V0ppQ2dqVXBxUHJoMWNGMnN5TnFTQXk0YmllZVpYUk0wd0xMcTk5?=
 =?utf-8?B?WXhtZFU0VURYUDRnZnpqWXh5dWJxaWpxMTNlZlpXMFNKWkFldmxqeG8ybGJY?=
 =?utf-8?B?M3E4WEFuS2FjeCs0SldDM0ZzN1NkbTRSdVNzTitHcnZDZndMS1FPRnN3QSto?=
 =?utf-8?B?aDlST0IrQVVYclhsWVFRWnNuaHRCMVAxY1p2NHRxRU1PQ0dXa0QzeEpSNjdN?=
 =?utf-8?B?UHkzNWRWRUh5RWJnTWdmRk1qYXBySS9CT0VLWkkvNHNBc0xsSWE0bm9manVT?=
 =?utf-8?B?THRIeU44RmtnSFNMcFVRdUw4UWNsMm5vcitwZXh3MXZWN2h5YUZSRGllbTB0?=
 =?utf-8?B?UFlrcTVqK1djd3dPNVVMdEplL1d4M3RSUFkxaEZneFpZU2NYTVBTWkN3NmlH?=
 =?utf-8?B?TU5nSHI5R1ZUV0N1YjJmM2xyNUZiWGN1aW9iVWs2TzhSeGpEajYzeDFpU1VN?=
 =?utf-8?B?djZJdjFzRGpTSEY0cWd1ZUZzL2ZoQTduNFZ5ckptT0VnSURrQlN1Z05CL2U4?=
 =?utf-8?B?UlpvSlNnZTR6MHJJSTBqUU5OWmg4eTRqODI4K3ZFM0xrL1E3SG5Od3FNcStY?=
 =?utf-8?B?dWlmdXhPY0xEWUh1dmU1RzQrZHMxSUtCN1BYUTdoS1Z4dVQ5Y1hiT2RTbUF3?=
 =?utf-8?B?cFREeWlVTHlqNXNCVjFHZ01HdWlvazFCdTdWb3p1UlVkY0Jzc2NYeVRxV0x3?=
 =?utf-8?B?VGwwTDY4Q0U5VlhuUXJpU1ZqUVRuVEVPTHZBelgwSTdRbDQzdEYwV0U3MXZ2?=
 =?utf-8?B?SVZDTXVvTzJNbEQ0V3hhbVZxeElLaUhjMDdIM3ViclEzQWZLS3R1NHU0cUlP?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9f5187-7dc8-43d4-6c79-08dd7b59d8d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:39:57.9206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqRlCSAdAzGzhvyDF/OgZQTGFQ7GTg5MNacWa18w7VJnAhCGIolOBni0NucBYy9yWe6UwBzWCuUgvhXTXjw6YuZ3KCQVl6LVGIlvZo1pkFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9552
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

Hi Michal,

On 4/11/25 8:31 AM, Michal Simek wrote:
> CMD_PXE is already under CMD_NET in Kconfig that's why make no sense to
> have another ifdef inside source code.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
