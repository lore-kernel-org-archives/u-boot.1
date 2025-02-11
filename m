Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F53DC0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01A1B803CC;
	Tue, 11 Feb 2025 11:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SHRvhM6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97128807F3; Tue, 11 Feb 2025 11:16:04 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D45380079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:16:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGfM3PPuTOft03w9cZjxt8ebYU7/gdya7ZgpVWSired3RbrOel7CC5GnGuJor4/0yPIQ743oz/hNnMQtTheQZj5Zbc07qdW5R/MOjC8oKzoXm9T7Laa/cfAdzCfvFbyaymPNs6WslXQbIRbUe501Pr+f8r6fxqfUx/lc7EI7g/f9hGL5ixu1+WEhJjNBqhvvNuwl2RBixrxN82oMTLVhgzVUizeXp2W6nMeTfMnqo1x2uGCWjxQAjhoUdSV8kfnbkkJBaOeMncCRCh5OcEvOFuhD5aWMglFmoJSn455zqHKYWrj4DATnRM8x4a/8F3dgbMJE0dP6muKmP93pqvgYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rp4mQqmSry15hiwskdJxtnODqIytShUoFD5eo/rPklU=;
 b=BlEG8lLe2ju1S5J3zt3u3rbNRDqLFhbCDGm/1FN5PN/epV+o7FjtBv5rJDTYx7MbWiBmYsx6odHg3kytCythGuPIXTSirBt/XOJ/PuZYY/yreetv2hfVVcAtJriukJ/f6iNZEz9vgqV/DY6i6urUCYLEsKt1bjFXRq7kjMZDQLB9LUzc6k8PmnC3WSzq3/M5dsgm3MaTp4T0+dxFKB3lbClgu0ApE8zs1hDF07p3BZoKhL3Yk8aOj2gPawyiaHLQq1GbhdicDHBSuRIV+qPvvl/R52g534eUs0ib/IEuvvEZrlnkHYy05z2UIXph0+rjK7VlUCeIA9oVjoN+vsnY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rp4mQqmSry15hiwskdJxtnODqIytShUoFD5eo/rPklU=;
 b=SHRvhM6X33j3il4+npT/GsCvuBgVchKiPG3Y+oxRVXMG4mIJ7Rr+Y4OTN78wKbdbtM+nMIYYlTBNUAHGMzaWelBgEBBwWUBp/4p8G2jT/XZ15wMJ0hy8FIKAmX4nIs6h1Bh9ZLpUDe4hw0YOIhJ8L2g+TCEounmI/I6oKPyE36oO8XCSxZvJHDTeJqKae1hKrRoXf+xGeNT5UJe3zV9aMFEg/Al9ctl7GRaj+uL6v9h3K0OFeR9/xR7wLl780l44lYgeXVK4eenIPxcTli8DeKjglrAlZU4NOa708cTnirUTbd57CIF7fwuafwUS9BSUNv/lSnFs1sCKLkWVCwga7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS8P195MB1333.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 10:15:59 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 10:15:59 +0000
Message-ID: <931ef657-ef64-401b-9cf5-a337e55e3424@phytec.de>
Date: Tue, 11 Feb 2025 17:15:54 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arch: arm: dts: k3-am642-phycore-som-binman: Add
 custMpk to overlays
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: nm@ti.com, n-francis@ti.com, d-gole@ti.com, upstream@lists.phytec.de
References: <20250211064205.45087-1-d.schultz@phytec.de>
 <20250211064205.45087-2-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250211064205.45087-2-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0061.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::17) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS8P195MB1333:EE_
X-MS-Office365-Filtering-Correlation-Id: e611da42-6961-4dbe-a1f2-08dd4a8514e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFZpVjlhUVk3WW1DZUZKWjFTdkRxRkdHL1JLc2NVaDhyLzJtN3YwdkVsbnRl?=
 =?utf-8?B?M290dkkvK0ROdHlhQmg1UyszSHZJWkRSdVNpQWkvdklYMzhtV1FDQUliMGV2?=
 =?utf-8?B?Ny9kUVZDSVVISk5zR1UxTWdwenEvbUtsOUFmamluNC8xMjBzeXlZazErRS9K?=
 =?utf-8?B?ZHVtWHZlZWZuQk1GRnFlaWV1S3Y0Q3pPUFBFT0RKQjhHZ0ErbG5sb012aG1i?=
 =?utf-8?B?dHFVdXFld1M2QWg1ZE5KSzRGM3VGZlNlUGxFVS9jOHI5TE43SElHMTlSZC9t?=
 =?utf-8?B?ZnhOTmxVRlpOM2JSZkNJbXJJRXN4c0REM21WTG5XM0RtTFNDMW1hUzM5UFpP?=
 =?utf-8?B?U0x3bUVHZUNTWVdwSVA4SGd4SGtqUXhSeVFPNHR1VmZlNjBXa1ltRStiUjQv?=
 =?utf-8?B?STdmdUlCU2Rpc0JMOGp2WUVjUjMzNTE5TmpPbDl5NVYyNkRwQktwL091a1NR?=
 =?utf-8?B?SWtiSzdFeml6VWpnNFA5eGZudEc2c0NTMFUvL1NpNU00NXd1OSs0RVRQcUZZ?=
 =?utf-8?B?WUFLZU1BK3JOaDVoS0piVFgvRkUvNVZOQS9UY3EwRzI0d3RGQmM2T0pmVFNJ?=
 =?utf-8?B?ekNpSEhBemNqaGl4ZEpyZWxoRGUwT2krZzdldEkxTGd5NWw2Nm5HQ3AyRkd6?=
 =?utf-8?B?Q2ppTEV1clZpNmxRdGVHMFp4TGE3NkRUUEJQRnl1TEdMbVZwSExyU2FQcXRW?=
 =?utf-8?B?eE9ndDkxQnFGZnMwbXNiMzllbkZHZjJZVmM4WmVBTW9UUWRpbXR1RVVuRktq?=
 =?utf-8?B?NEoxUjJEeDhDeWxKQWllaC93R3Z3MGUxVkNKNm9FYVlRN0NmSC8wVE42YTIr?=
 =?utf-8?B?NWl0RjN6R0JhK3pYeWxwVU5LRE1OYlJwSHduWWFlMnhZLzRLWG45OUhxYVMx?=
 =?utf-8?B?MndBaGpnaDNKL3BKZHFKZHJKOGordGMxa1VZSmVyNy8xMjlkMWhrZXEyS3lZ?=
 =?utf-8?B?bjNNYlBGZmxua3ZJb29KZ0dxdDgvQnBJLzA5eEswdTA0RGRmeDhPaU1xbVVx?=
 =?utf-8?B?SWJvL2RZNzh4VElmMTY2WjhEemNkNUVSS2tCaWJXQ3Y1ZGVYNWU4TlFzY3k5?=
 =?utf-8?B?SXZwZXNJZ3FDVlFiZnBrbHdhUDU2c2FrNDlUQ2JGZHNCc1F3SXgvZXZDTDZj?=
 =?utf-8?B?UnE5ZTRzN3k4TmY1OFArOTllZ3kwV0RaUDlvWHRGYXpuSEoxeUJyMzI3VDFT?=
 =?utf-8?B?ZGxoSWZ5MHNuNFZxUXlnVS9RdjFycGc1bThKSk5QMjVReklrUEJlTFFZNHNL?=
 =?utf-8?B?KzgvZGFDYVdFcCsxVnVzVElPejMyUjQ3dzlLd1JCemZQb0hTNldHQXVRTU9n?=
 =?utf-8?B?a25ib05jemZKdmplbGZwYVFzTm5WUnE3WHQ1TWxjSFpQdkI0NU83UlNFcWQ0?=
 =?utf-8?B?dkpxTFFqMkdBWnltb1dwcXZtNXVrRmhyZ1ZlRktUdjc2V05WVTlGcVQrUXNE?=
 =?utf-8?B?eXFna21ueDBpN0dMU1ZFam1EeEtKZ0w2Ull0dm5tOEgzclBwUEc0Witaa0Fa?=
 =?utf-8?B?RVhja21sOEJEcWk3T1Z2b2ZtbGNjY1VwVTN5Nmp5ejVHdkl2OHpQRkFsRDBZ?=
 =?utf-8?B?bkpBcWc5S0hkUkdpeUdzZEh4MVE5TnNrbzVTN0RqOTNZSG5DNmdWVmxvYmVD?=
 =?utf-8?B?cHpMbG9SWmpwYU1jdlovOG1TSnJ4UVV6NVp4dmp5V1R6MThsNmpsaEdyOVUy?=
 =?utf-8?B?ZXdSUnJQY1VqaGZ5QVZkODJjM25xS2ZYdlVvRUJQNm53bW13Z2RmSTdwQVdo?=
 =?utf-8?B?SGdpS2huRzh1YlQ4V1UydFNqaWV3eEZYRFBTVXBobGYzeVk4UHBueUVVUzNJ?=
 =?utf-8?B?aU1QZi9wLzNZdjFaZlgyVlZIN3MrMk9hK1ZaTVZ5K3ZsRndpRXZEUU9nbXlW?=
 =?utf-8?Q?gF1yu8wYQAjOj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJ1YzZ2M0xWcDJNNEVtajM2cnBERnhkdnNncnMwKzhBQUVmM2lVZmQrS0xj?=
 =?utf-8?B?dnJGZUMvVmxCVWZCbHdZeXdSVWFuUS9QNElab2dwM0ExNlc3ZWFKSzlObXl0?=
 =?utf-8?B?VXZWTUVTTXh5Uk11UjJ4eDlBRlI2NE5KNWJMOTljWGZrdzFhUXBhZFhzdXE3?=
 =?utf-8?B?WkFhSDNxL0NCQ3dYODNGeHBaU01SRjk5SUJFajVrNHJxbXdRdVJ4TUZBQmxH?=
 =?utf-8?B?bHZnTkNUelVST0V0MGpKWDRZbUFDOVJEeVA0V3dzTlNEcGgyS25zaGIrblJk?=
 =?utf-8?B?MlNSVld2bnFGMDNyZDd3U0JHWUVDSlBEQnhCYS9FTDlTVWpPWWdjK2ZLYnBX?=
 =?utf-8?B?WEVnRTQ0MU5RZnc4MFZsUW5zd2NjdUYzQ3BIWWRwZHpsS3QyaUtQMzU0eUE0?=
 =?utf-8?B?RHBvV1QyRGo4WEh0VGs5VksyQmVDT25PWVhuMnVYTloxSWd0emVnUEhIcUV4?=
 =?utf-8?B?SVFmNHBUZXgxZzNHdXV0YVh4Tll1azVrWlV4YnBhWUdUSlVQbWh4dnVjeUxn?=
 =?utf-8?B?Ti9XbnpSUWZkQk4ycU8zaGU1cUF2VlhSRzBFWEZtbHNiTlpsaHNSb0FPMndC?=
 =?utf-8?B?SlYzbmZSTFZnSXkrWXE4WWxZUXkwRklkRGtmZ3pHc1NnRlRwTDIyYkVBYVRC?=
 =?utf-8?B?VGlxY2Mwd1M0cGdXd1diWXZLc0Nnc1dKRjVZYkI0T2dhMHk4Q1pYdk1ENXVi?=
 =?utf-8?B?bG11cFZab0dBMUY5bEZNdDlGR0g0QW5UdnhyZWo4aWlwamlwOUNLcGw2Vlp0?=
 =?utf-8?B?NXN5VVhmUytsN2g1VGo2bnFtbW5DMnhMTk51K2R2OE9Sdnlic21hd1Y1WjNS?=
 =?utf-8?B?bjZyR25UWURINTFPbTFEcUJmMWI4OE9Gbkd5TG0wMlJxYXJGYTR3eUo1c2tq?=
 =?utf-8?B?MjEyc2ZiRU83QVNjbmF5VWNhOFRkaTVrZ3ZlTmk5Qk9Qa3ljVlVsYU9MVDYw?=
 =?utf-8?B?L2tnckFvdEpHL1VyTGI1Q2pxbHdlelRxZUxudW5xK3VKcTBWaUIvT0w5QkJU?=
 =?utf-8?B?blYwWCtyaDd3U1h3ZW53emZnZ2hXUkF4c3grYVAycW93NmpVNW9FeHg3S2VW?=
 =?utf-8?B?MGs1dUg2ZjlvWVo5MnpWdnhxQy8wSXBBejJQbmxUNldEbFhoN0grbU1jWGcz?=
 =?utf-8?B?aVBBdW8rQTdaWHhDMkxqRHY0ZUNOemRSbFdkMEw4WUZMcXlPZi9rWFpwQ2VJ?=
 =?utf-8?B?cUI3bzV4VTVtUFNpZ2xESE9BUmlQUGVacmJCd3hUakU5dUFYRnFGaG93Z3ZT?=
 =?utf-8?B?RmFQbGVHc0dYYVQyMGpEcmU5VEthOWdRWFdlWStCT2hlUksyNmpxN2VKWXlV?=
 =?utf-8?B?elJubzlpZEJ3N0dDclQ5bS80SGVGZ2oraXdYWmo0ZWp0aEJsZ1hQa21ZNGZl?=
 =?utf-8?B?blRHaFhuSCtyWFE3M3FKMnlqRFRQZDFMUHk3c0l1byt6Yk1EOURkbDRNeUpj?=
 =?utf-8?B?UnhFaTVpWXdXa0sxMHVWb2xhQ3FkWVhMOXRPZTVPODQ4QThBalFUTFkwZng4?=
 =?utf-8?B?a2xDQlA3ZzBZRG9vSnYrdC9JRHUrSCtiY0htT3lDNXA4Y3Z0V0krYnpFU3NY?=
 =?utf-8?B?aEFQdFpHZjI0VG1BaWQ5ejBZUDdXQTlaYVZqa0ZQd2p1cklIK2xNZ01ZY0dM?=
 =?utf-8?B?V2owWDd1OXYrNVpqeXljYVNoT0tnU2hhUGpQdU11a3plaHZ6YW1PalkxQXBt?=
 =?utf-8?B?Um5KWUExSUV3WFZGWmpad0c4SFJQakljYXFaczdOdlRQZlpZbjlyVE1mb1ht?=
 =?utf-8?B?emtOTEREN0dwQVRTemx5K0FGejErcHV2N1RieFowTFcyTDRBc0ZJeE4rRlNG?=
 =?utf-8?B?SEgwNThNU2FUOEJFMkM4QmtjZHVHeXpjVHhtWUIrdXg3cUtNT2dhYzVZK3VK?=
 =?utf-8?B?VU8rQ3JGd2IyUFVaTytSVkppOExocThEa3pWYmlNNTVhZXJNZ1hLKzBBcU5O?=
 =?utf-8?B?Yi9BV1p3K3phNEhmOVdBN2FTRWo1ZWhpTzdmNDRRZ3daNi8vaDdqY2FUbmk5?=
 =?utf-8?B?WTJXMUVqUnZVN0lNSCtXVmZBMkdrRnJWbldVWm9TT1NyaHlVZ0ZRVVRYNDBm?=
 =?utf-8?B?THMxbjVRRGxhaEZoZVQrVDFGM05MaTlPZGlhRnhlTm1zTWJJTFFZRmJIU3Vt?=
 =?utf-8?Q?XlfierxW+HhODahLmap5hQHpx?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e611da42-6961-4dbe-a1f2-08dd4a8514e0
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:15:59.8861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HsoKtnJnKnBPET2ugQ78QY/kiKcFURBqn6FlaYBXzANu0NOZFAGIKs8lTlDJ4Xab2CY3p5lqkFhLqP0plF2Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1333
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

Am 11.02.25 um 13:42 schrieb Daniel Schultz:
> There are some device-tree overlays with missing entries for the
> keyfile. Add them to sign all images in the U-Boot FIT image.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
> Changes:
>    v2: Removed keyfile definitions which are already defined in k3-binman.dtsi
> 
>   arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 28 +++++++++++++------
>   1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> index 3710564cd4a..5228eed19bf 100644
> --- a/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am642-phycore-som-binman.dtsi
> @@ -363,8 +363,11 @@
>   					compression = "none";
>   					load = <0x8F000000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_rtc_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_rtc_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
>   					};
>   				};
> @@ -375,8 +378,11 @@
>   					compression = "none";
>   					load = <0x8F001000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_spi_not_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_spi_not_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
>   					};
>   				};
> @@ -387,8 +393,11 @@
>   					compression = "none";
>   					load = <0x8F002000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_eth_phy_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
>   					};
>   				};
> @@ -399,8 +408,11 @@
>   					compression = "none";
>   					load = <0x8F003000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_qspi_nor_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
>   					};
>   				};

