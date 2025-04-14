Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D20C3601E
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 05:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3DA81F54;
	Mon, 14 Apr 2025 07:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LUsUnomh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E78681F66; Mon, 14 Apr 2025 07:49:46 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23DC81E1F
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 07:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nso/LxyFIj0GvZ6ASvk5txDjohc/w1ireeP+tW1hX26WMuozGnQXvRt4fsRHPRuDR/E2k6CW8Wh2FJA9ZlcAfvZ5JcUJYma7GPuNCyL+UqjwbQ7KGLTb2HXYhq2k457bD0//bJbkpXvk6zjOyKzkdHSlUsPz/disSQ+Nd0AmeFFQ6hqi21ourYXxt42mnDo2gLNfHGgXOmSKH3pgzX+s3EbnYvN65QLIgJeiIoKpHw1ZA6cs2dFqTSD+yntiWXJ7Qq4ksew0w7qz0AOQHvZ+lulD+crz7c2qcuTZdS6meKT7Zozv/XNkO1/IPmfCVlYPc7m+W0JYpbCji2ZO21Q3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQbiNLtrifJKuRgyqkzk64YF4Kank1CL4lxiBnftF2I=;
 b=yJ4GlEvmGrrKvnO6bdZkC02YepWT+OwpDcOVsD46sTWVB2n5AYF8pxYGJ1E/gMEqRgZVvgStnTv1wfD00FvhUKXi9+7+bvbG/85yJbqOlbJ3dyfVldsvFaFp5GMmAsANV+s/cV+YH3reZfi8PAvpWyTe3/2mEH2cthCf9ObnPvS9V8MpqQBTi2PjlSiBVvc2FsiWgbI5U24p1KAjAbLPOxez8dDLbB9D/TK6b32g6RRVdui4E+03l34Bc1EQ34C+mvYC5ufrU3msVRgE3Ro8az25PBm2eIn78MLHfcYsvaO8wGutPJhDJQ5urS56zLiJu8aI2qNgMvQFRvNs1uHVPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQbiNLtrifJKuRgyqkzk64YF4Kank1CL4lxiBnftF2I=;
 b=LUsUnomhRn/e08R74V9aw0b/B1IkI1JG3xiqyQwTq1xs5mDXEGeVddDdpHFHYiwZh9UZ0cwEAZbZiOggxn1W5Xh1Rwj9TmAqMsiY1OdUL4lij/EnyzZlhBZUDhrNh7rAdJvPJChx65irlUoUmUyJJ2w5WEwD7UqLQVh7Q+cLFlEpWzYqD9cK90Ao+gIdSfrXko827R9AH+T+8yXqD7Dgk7qiSYT6jOc4cqNbZiHjNEExA0vglKV8foMdwo6M0DwJmFV75W7d4P+DmMq+z1qQM/O2vjHjK4dO2nKR+BOErTsGeP8UZauK9zCB3sAwgD7oeQi9pucDs4pNNdVKMlikyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS1P195MB1448.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 05:49:41 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 05:49:41 +0000
Message-ID: <fce464de-2d1d-4346-9033-619372fa1d2e@phytec.de>
Date: Mon, 14 Apr 2025 08:49:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
To: Tom Rini <trini@konsulko.com>, Martin Schwan <M.Schwan@phytec.de>
Cc: "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <20250129160323.GV1233568@bill-the-cat>
 <da13999132b06d7891ffc85edfc3147e64cbaa93.camel@phytec.de>
 <20250130145104.GZ1233568@bill-the-cat>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250130145104.GZ1233568@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0098.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::27) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS1P195MB1448:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9c0149-447d-4463-80f1-08dd7b182648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDFQUlA2ODFGRHhMZnFXdmd2TThnU0YrOU1WRjRrY1Viak9IQnBmTFVuUXl3?=
 =?utf-8?B?M2pXcEkvMDlkT1d5MVdzSUJlQmR2WjE2RjQ5MGxWZVhjYkdEUEJrUjNHb3FE?=
 =?utf-8?B?QjVTUEIxMXFGV0JzVGIydjUrcnFZdno2ZmlxdndYak1Fb08yUGxNRDJiYXVU?=
 =?utf-8?B?SHhUZHFmcTVpMFF3SjRJOENKUERucWNMdUFyU2ExZUhGbGt0QkdOSHVFYldG?=
 =?utf-8?B?L3YyWnZIY0hLcXZwdkVtV0FYMDZQZnVQN1lDZFY5enlVR1RhbXlJRXFFcTV1?=
 =?utf-8?B?aERSSHY2ekIrNDM0Yk5oKytzTU1idWhZbk4wd1lzeFYreXp5L3c3VFAyRG56?=
 =?utf-8?B?c0JrZkZMWnVDaVk2NklMQmhML2xsK3NHempINVAvUGFpMlhQM0ptRUNycito?=
 =?utf-8?B?OVdJRFY1VWZSWEp5M0p6TFJQbzZpVGpqQmowNWJiRTZTR214Vk5CWmU2eVpw?=
 =?utf-8?B?eE05VThrUWxXUnppZy9FWXdqS3FHUENCZUYyT0hZalJxTWRXRkUvcmlvd052?=
 =?utf-8?B?dVNhR0RFMFE1TWRLWWhtZUhWNkMwTk9JRmZGUlB6bEtBSFYwcHFCMjNNVU9Q?=
 =?utf-8?B?VkVvMy8vMTFrWUt6TFBPcDNka01GWHJST2IySm1IdDJxWjlMVWtEd2R0Z0E3?=
 =?utf-8?B?RGpEOHczNXR5b0F5aC9VVmJ0cnBuZit0bXgzdmV3Q1pwMFc3S2oyY2NUYTh6?=
 =?utf-8?B?Y1R5Nnd3QzdVRjlOTm5aM25Vek1SdStNUE1SZDJCQkRYdXF1Zjg4bmEyMnFI?=
 =?utf-8?B?MkpNamgyZEFRSUpLWEtPN0t0K2VQNmlOQUkxL2lrTTV6UTY4ZUZzWElwd2ti?=
 =?utf-8?B?R1FSWlFKWXdvdzJoa3BZaTByQm9JSk04Q2Jza1JHYlhKZy9wODhHUGpwckps?=
 =?utf-8?B?K2VpK0xZV3VPUHRHc3ZubmFjbWZCcWIwcUpReUs4SCtwL1hSUVEyUHBNOXpB?=
 =?utf-8?B?dW9jUDdZeE9RRHBSd2V1ZGlVcmV2UFg0ZEFoakFUbFR1c1BiUEdtSlVFSnIy?=
 =?utf-8?B?bXViOUJLeC9ucllQSTVUZFUzSkVsUk9FV0ltRitSRFFWQUwyRmtNT2l5TVVI?=
 =?utf-8?B?MlJEekFGM3NFZUNFd2s1YmoyMmcvenNoMFEzU1hFS1IvQ3cxUGpKK2hSWU9y?=
 =?utf-8?B?eWxVZmVkeGRWUloyUkF3RkEzY2xLOVZHMmI0blEzSmJCQWRyRlU3dVBrUUZX?=
 =?utf-8?B?bmNUZE5Dd0lEOW9ydGQzTEdNWWRpWHpSbCtIZ3g4TjcxQ1ErV3BTK0h2aFFo?=
 =?utf-8?B?YmYzMkc3N0NVSGVKcUtRb1gwN3h0N3JJMTRHTEg4M0NJcTdxMElLYzBlRG1T?=
 =?utf-8?B?VHFvNE9HZEhHd0JKZ0Y2M0hwQ3l0aUlESk92MG9SeDZXR0hFUjdiSWtUUUUw?=
 =?utf-8?B?eUVlcjNRK1RjanVpdGl6cStoUG1vWkcySUVieHlWalpoMmN5NzBFbWtDYWdt?=
 =?utf-8?B?cFJEY1A1c0lESkdxUDhiR0dOYUVuREptT2lQL1dXOXhnRjBwWEllVkVINU9E?=
 =?utf-8?B?SjM0b3JwWWdKRENGUHNrRVV5d1VSK04xUFBEdFBBcVQwOW9lRU1VeU5XSzhP?=
 =?utf-8?B?MkhvV1Z5Z0hZY2ZDNDg5MlZtT05XeFVUdkNUcjdkTlk5WG9LY0dvWGVGblVr?=
 =?utf-8?B?Tm1KZXBqaU9SWTY0VjNXRGxJUnVQeGtUNVI2akxPZk1lWjY4dDJYR3NYdGFt?=
 =?utf-8?B?ZGk5QnJBZ3NWVjBhTlZrMHM3ajgydHhORjFVc0ZkMGNQN252VTAvZGFOTmNW?=
 =?utf-8?B?VS9VUmJXY1ROL0QvU284bmc5NWlVWUxGRWhQK2pnWlI0ejYwa2JESjBuSzI2?=
 =?utf-8?B?QTBQYzR4OUI1NVRYZFFQazVJUjJ1RUErRUpTdjBENXE3YUpLaXJlYjNTT1gz?=
 =?utf-8?B?WjNEZllpeFBsSDkzR2UvRnBxYjJXUDZLUnJhcjZRM1l5eFJwMkx6akhWY2xR?=
 =?utf-8?Q?P95w3thO6yQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3MySEdmM2lwSGdmZzB6UUpRN1BtTFJOcU9OMGh2SVdNWDJSS1RTT0oyR0Zq?=
 =?utf-8?B?UDBVR3dwUTFHYktqRnZLaUhIWmtBYzZoeWxvRDhObWJHWDU2bXhneDZmaDRE?=
 =?utf-8?B?Z3JOUUJBTDhHd1g5dXhmd1lkWVlVMU5TMjBSTjVQVi93dkcvL2pXdmtVa2I1?=
 =?utf-8?B?Q2Z6YU0rcGhiRFJoWFpzaHVLNndsSlgwRVBTckRKZ3dkZ1VhMk1QSnRVSm5E?=
 =?utf-8?B?TmhwNXYxUmttL0NFZ3h4Nnh4WlBmb2xham5MdXdoY3VDenpTWDlUR1RRQzFO?=
 =?utf-8?B?V2xRdjRxalROMEcwQ1dEcXVZUkYzREhXb09qVlp1NjlLZW9rZGFMU3VJUm9T?=
 =?utf-8?B?eEY4amNNQjBJR1VVUmpvUkVCZjBnMlZQMHhIR3l0QisyblNoSnFjajZRcXNF?=
 =?utf-8?B?WFpFNjdsZm9JYUg3THVvbjIvclhkYzl0UmpiNk9kMjBXaUl1MFh1M1VaNFF2?=
 =?utf-8?B?ZkFNdHBrZFFvQTlCNUVuRVFxNS9pWllmeGgwdmx3UlhoK0RpUkd6VnF2U2Jx?=
 =?utf-8?B?WWpDaTlPeEtmRmhTLzRwVUhzbXRwamFzek5VWWdTMUpJQmVhZVNXdU96NmNO?=
 =?utf-8?B?bGRQeWg1bkFCZ3pLc0pycHovcDhsUlV3dDY0d2RoaHdQeTRIRVovL21kcXZ0?=
 =?utf-8?B?TmtoTU9tMnpOWDJKbXRJelRqTy9kUmxaL1BZMlpveVlPTmhBSnJDVjFTMk1R?=
 =?utf-8?B?SDdISlNOYVhvQTY0Sk1TMzJCOGRsT2lYa0ZWYVRMODdIalorekttdHNJbGdZ?=
 =?utf-8?B?OFlUNVFLZVVROUI3QU9Fa1FtS1MwTFJSL05taUdHbXVrYm02S2dPanZnaGNG?=
 =?utf-8?B?TnNwV2xEL25BWlpyaGI1RHg0a3h5ejNJOVhHclJEeDVZOGUyZUhXSE9IdWto?=
 =?utf-8?B?WDVIaHQ0bXhLUmIyYVlBZUZ2S0V1ZW5mdDVEdkpSRkhneFZFK01WNDllejBx?=
 =?utf-8?B?amN5T1FPTHJBbUJXcWVVckIvSk00a1RQRDlZQWtwbi9FZGhkeC9aNmFqZ01X?=
 =?utf-8?B?dk1rbFBUZHRGNVp6TUFSTVNtQVpsL283OW5ua0kxTWZ1K1I2dDg1bHhrc1VY?=
 =?utf-8?B?RTdoV2s1RXppU2szTEs4RmIrK1Boa0ZPc1pSNEtmemQyRUc3SjFHZnFqQStX?=
 =?utf-8?B?SVl0SFJyNVZ6WEhZbDBBaERQOW9lZnZFOVFOM2hEMVlGb3ZhQUo0NWVYMUMx?=
 =?utf-8?B?eEZpRDdZMUp5VjFlZU8wNkZlOGJBWEU4amxQYWhwT2k3WUJpc2d0U2pYdmk1?=
 =?utf-8?B?WlpFZVQyVkdteUlFb3U3UmdjYVVIcHZWQnBWUDhkVkpweFI1RXowR1crUVQy?=
 =?utf-8?B?eFBwbGk3MWxuRDdhN1dXNUNXazNCSUZaQ042K0tzU095Y3pXYStuR0ZFOXp2?=
 =?utf-8?B?U3lQbkNnbHBJaWVoSHR5MTZYaU0vQUVXL2MvdXEzOGhSem9BMllpUzZaSmhX?=
 =?utf-8?B?NHY4cm4zL01KZVhodm51K01Sdkx0Vy81cUo4M3p6eC82VWdlNTNJY2QyQTFD?=
 =?utf-8?B?ckdBdVVJdWdVRUlhV29KYmhVUXBFNXU5Q04rNC81d2loRkM4Yno3T2ZXTjJk?=
 =?utf-8?B?QkkyTkdpNWlrT2tkRjRzRDdPSjlvdjdoZFVCb3o1Vlp3aEpud2h5WHZleXkr?=
 =?utf-8?B?UVRyR3FRcnM1N1VzZUNlY3VYZWJVLytYSUdXQmVoano0WHlJMTkzUTJVNlpS?=
 =?utf-8?B?UUhVZG5aSVhMOElpQlhoRzZ5ODRnd0pYMmkyQW5WK1FKUEdGWG90cTlhK2o4?=
 =?utf-8?B?cUZ4bjRwdDRHWUpJaTVhT1BxY1VpMnE2d0FQaGEvM1BVK2l1VnhQUHBXMXdY?=
 =?utf-8?B?V3BhTGt4UTlXSzllbDB5S2tHUG92NFpjVUxTTHNhOVdtdmJQaFdEYlo4aUZm?=
 =?utf-8?B?aUUrakl1Um02M1hCd3hrRjJzNmxvTXdsTjYwVlM3cW1LSElMVnV5Y0UxamlJ?=
 =?utf-8?B?Qkx2QTk0NVNtNlpjVzZPQ1YrZkhjc2V2T2NTMWd0Tmg4VUlVOHBlZnVMZG5T?=
 =?utf-8?B?Yy9zR1h6VmZZMUtXWnRsY2IyNFJwMlJEK21JeHJhZnJMSmxjVXZNUjZieDlO?=
 =?utf-8?B?aTV3WXFVS3d0ei90dHVvOTVLb1hjUUpySi94NjhhK3MvdWhOUnk3TE4rZ1NX?=
 =?utf-8?Q?Km5EbJXjB3IElYTq2qOp2lR5g?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9c0149-447d-4463-80f1-08dd7b182648
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 05:49:41.1233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rjqmdf3FOtPZUEZMxXo66ZAvEmQUYkVLxpLN0knT56h+UL6LDjjg9AJ7+Z8ETk1AWpltgoLhFTs03cOJmQAGtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1448
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

Am 30.01.25 um 16:51 schrieb Tom Rini:
> On Thu, Jan 30, 2025 at 09:48:19AM +0000, Martin Schwan wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> On Wed, 2025-01-29 at 10:03 -0600, Tom Rini wrote:
>>> On Wed, Jan 29, 2025 at 03:25:25PM +0100, Martin Schwan wrote:
>>>> Add a bootmeth driver which supports booting A/B system with RAUC
>>>> as
>>>> their update client.
>>>>
>>>> Signed-off-by: Martin Schwan <m.schwan@phytec.de>
>>>> ---
>>>>   boot/Kconfig         |  11 ++
>>>>   boot/Makefile        |   1 +
>>>>   boot/bootmeth_rauc.c | 408
>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 420 insertions(+)
>>>
>>> I'm curious, what would be required to have this work for any block
>>> device, rather than just "mmc" ? Just a lack of time / testing / this
>>> is
>>> v1 and that's a future idea? Or is there something more fundamental
>>> required within bootstd/bootmeths ? Thanks!
>>>
>>
>> Besides MMC, RAUC supports updating SSDs and raw NAND flash [1].
>>
>> I guess there should be very little to no adjustments necessary to
>> support SSDs (probably only adjust checks).
>>
>> For raw NAND flash and using UBI volumes, this would require some
>> additional code calling the correct read operations, but is definitely
>> possible. I did not implement it yet because of lack of time and
>> verification, as you correctly guessed.
>>
>> Network devices are not supported for obvious reasons.
> 
> Thanks for elaborating.
> 

Any other comments on the RAUC bootmeth idea?

