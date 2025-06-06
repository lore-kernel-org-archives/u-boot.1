Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D2EC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 027E181FEE;
	Fri,  6 Jun 2025 11:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IAmWfcNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FD2E828F8; Fri,  6 Jun 2025 11:45:20 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F157803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4ttrw8qoWJL+GKF0RrEdSgcQpS+D9rJaZk40bUUOM98JxMwRPtggGjSyzdpDNbxDzZkROl+tnbqeEePgLA2Axwj+Tav/ur7y1nnMQCpPi0gf74BmCgBgNOo1PO/1uYuux9A2Hamk//jourht1AF3dbn6JX4/wu7UBGM4SY5+njw/UDa2JFUgnJ04my4c0JVVw4lelYOSucxD/AyNwEFR3kdRvmRm0n8f8wx8HgFnTy6qUH2NmOJ4sCwOBJIjrFgLlONNG/sZXe9c1W56D4F4GtXXUlpSfDcRda7g7iwFlnlgjtFg+eHsh7tQKdAgZqjgGJ1HAgz046A0YdGVO1xjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlA6FQnbl4Gi9LpOcYVs48LvMDbFzOfy8DRTdt1XTYQ=;
 b=jlP5I5VCfVZSfU7cei7D6ZtKBO4F7OBC1i1eg01mwjVsoEZq1AJfvcb8VMsvlN1aubNtPx7+cAXEx26yWe+nVGTmoeZ6NQdUJRhrm2JDE421gaTeTwpCOPf+GSkVxiHUNPngGiDwwpa+IRRYgsVwlcRtZfs5DUP7d2+I23SiPBvpb24mr8ga+lic0llTSvRPlQWmqHArmcuG6asRi5nKhSF1WAaVL4BpdKRSbHOjZJQYBHYbF8kACtTWcme778QiMWohROInhIXhZKIWxhBVvPaImqpU7YvtVKSxMwsfHPAIj1C8haP0FqRp+DYIO3XttvQ3g160VsbUvTn/hj9Rdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlA6FQnbl4Gi9LpOcYVs48LvMDbFzOfy8DRTdt1XTYQ=;
 b=IAmWfcNtrzuDQn4e07Hh5P/nWnVA3+R8G4Roqj7mx6OFc3pz1PX27QWjSuYxWju+H7xcO1QF79q9Kx0Doc1kGXL9BSGu+zWey9m0+ML4AllhU6CzY81PEGtLNhm47LgFwhNRl0Dc1fmrxY2dhp7GImJF8wHPt/F6EwDe3W87gMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7962.eurprd04.prod.outlook.com (2603:10a6:10:1e7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 09:45:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 09:45:12 +0000
Message-ID: <a2f93b49-aea5-4bc2-881a-11d3d85e4dc3@cherry.de>
Date: Fri, 6 Jun 2025 11:45:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: mmc: fix offsets relative to the end of the
 partition
To: Michael Walle <mwalle@kernel.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250605074610.1424953-1-mwalle@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250605074610.1424953-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0547.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: ba115775-9a4c-49b7-1074-08dda4ded547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnNmOUZvN0FFbnJpNXR2NnpOellQUTZzcEFJN1krSmc3NCtvNTU0ZFRBUE1L?=
 =?utf-8?B?WVgrQ21ZZXp6d2tpN2dJdFd3S2RtMDVOTzltdDJWVXZ3cFczcURoOG5USmw5?=
 =?utf-8?B?RnMvdVJ1bWRvd3p0S3ova0ZRQVRCdUhtMXJaTHRnWnhYNjBFSlpKdG1jYWxv?=
 =?utf-8?B?NWlzVXgwQ2kzWTVGQkNTQTZyZ0I1d3NEUmM1VHRoVHl3d3BUaTl2MTNxd1Ux?=
 =?utf-8?B?RUNTM0d6Zmhkdzkwd2ZYTjJCamtJaFpEbmVaSUIrN3NRSU1sZHdxZFlOL2ZB?=
 =?utf-8?B?UUh2SGIvbG9OVjNWMEk0YndSdTlLRkVRQVBzNFZTTXdkRXBPN3NSaDgzOWFK?=
 =?utf-8?B?b1gwN0lvd2JHclFpdVZCM0Z4ZkZKTmk1S2NJOEY2U2lPLzIvc0hudGNtOVFT?=
 =?utf-8?B?cFAvL0dHSXl2MDBSRlA5dDA4VTczc2NrL2NpM0FYbC8xb0s1d1laZUZoOFp1?=
 =?utf-8?B?Q29XMTZXWlVOcVdXLzNKU0dDckJPSnpJa1FhZVQxUUNOTlRabVozQjB4bis0?=
 =?utf-8?B?S2ZLOU55TzErWG9aNXVETWxHSDUvTTdxUUFLSFI5aFl5eHkzVElHRmhJQVUr?=
 =?utf-8?B?YXo5UDIycEVSMEZRSjAvOVA1bUtvRTJOT2ZLeW1xY2orZ3JCYXFLeEliUFRy?=
 =?utf-8?B?WFpmRnRCV3cwQWJIUE84TzNoVGkzZmR5TmQwcmYvemVyQkM5ei9GZWlYRUsz?=
 =?utf-8?B?U2ZYdllFTXZIRDZTSVl1M1FnMlNZT25rVUdrRWkwOWordTUxNU41V3FqUWNU?=
 =?utf-8?B?NVFpWE04MkNIMFg5dEhrVmZKT0lrQVgvTEpMcTljdEdwWjRwb3BvbnhPbXBN?=
 =?utf-8?B?aW5LRGxheXVuUnJLd2JrUFA2eHBFQXBKV0p1WXdXMXNHZ29MZGQ0NGhCVXpw?=
 =?utf-8?B?QmJWdDFGOVQramh6RFBDc2s1NHROMVFtVGphU1E0TkVpRy9SdCtHa0JDSGRj?=
 =?utf-8?B?NWM3MVNVazZYS3NSb3FKWEZuWHMyakZQdUdxUXVwMDdtdWttWU55MzY2anJQ?=
 =?utf-8?B?MUdrSjZuZHZkMXlBVUdqYU5HREVzcFJMWDVHQ21WVmtyRjk5QzR3RG1WV2xD?=
 =?utf-8?B?a25hemZZYjZtcitMbXN5TlhQU3BiRW1XK1h5WWh3WmxOTFJHYUl5ZUhGeTV5?=
 =?utf-8?B?YkJpWEdXdGZ6TkNKUU5HNmcyYkpWNVVoOUxKWm1nMG5xdytmMS9kZ1VaUXgw?=
 =?utf-8?B?cU5mdVNpTGlhSUNOL2kwOWxucjM5UDJBVWpEZkxwd1pHTzc3ZFdwbktkVW9T?=
 =?utf-8?B?THVHMUdEK2JSdzk4bllnK0szWWVyYWZFN0JRYTJXeWhrRkt4ZW1Wd011ZmlF?=
 =?utf-8?B?Z1A5d3hKTnI1RnI4U3JCZEVrWkIySjF4QVpWSU90WmZwTlNGQ3BZWmkvRHNm?=
 =?utf-8?B?cDllREFEL1h1cVFVWjd6ZXdaZ2M0emJJemx3M2V3UVpJWEZyR0Q1bjV0ZkhI?=
 =?utf-8?B?T2hrblQ2QkZCc3RJN0tPYU9UV3libVdxQm1mUTBha2JKQnI5Lzc0QXdYVkVz?=
 =?utf-8?B?RE5aalNhSXlzQ2tJVExZMEZmeUIrRXVCWE5uMDVGcytBZTNTdGtlc3F3M2dp?=
 =?utf-8?B?Qnh4aHFTS2w0ZzlaTDJYV1EwS2l4SWdiR1prNFZMTG1BY25XWmxBUVVrRTBT?=
 =?utf-8?B?QUVPaVVoUmRHUXF6bFBKR1owWDBab1RBNFVQT0dRMjdZUDZ6TVExUnYwS1V6?=
 =?utf-8?B?Q0ZlWFpMTS9HcXBSUmFXeE9TWUM4UHVvK21nLzEzenVpNmFVQU9IOHFsM1Vr?=
 =?utf-8?B?WmFXV284T0hDSmpieTQycWxlc1M0bkpNejV3WWhpVm96UWErekpORlRUSURK?=
 =?utf-8?B?WmQ5TXBUQnlublpubTFwYlcwdkFWNDA1YUIyMlQ4blV3RUZHUnBHZ3NiYjFU?=
 =?utf-8?B?QlhjdVhqRi9UY3VIYjZaZ1NvcTN5Z2dHZVhwTzg3R1NMN3FNVHJUVUFZVC9Z?=
 =?utf-8?Q?r1rsCv5ZTVo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTEvL0FXdE1icWtWZmtRampTUExsVXNMRXRCbTRrenBhUDE1KzBSWnJZZC9m?=
 =?utf-8?B?SEphREk0OEdKVmJIN3NNcXcrM3F3VGNrKzlJaEJWWHcxS0hLMUllWDZ3S1lX?=
 =?utf-8?B?VjQ0QWRKSU5rOUVFa0g4ZG9ZazIwWVRHem01QXpSRDJieHFRZ3JKUE8rOUNo?=
 =?utf-8?B?SEw4dHN5clp2enprS2M3dXp5NndtdVppVGhjUUNzbXdtaGpjUmZrdys1ME1P?=
 =?utf-8?B?cHZZaVhSWGpPTG9ROUhuUW82OEY3Z2JYOGVGdHlUOXNaRmQzbkR6aDlIV24r?=
 =?utf-8?B?ZUFSRTAvNzFpMGVXZloyRG1DamVvendYUlRYTlpKV1ZkTlN0NjhBMWEwdEh1?=
 =?utf-8?B?MFoxVXR5S3NIVmtucDhqMUVrQkRMNjlZSmU0RmVnWHF0YWx4QlowdW9wV3VI?=
 =?utf-8?B?TXppS2xxU1RyTkVpMzFueS83Z0I5YjdUOWQ1STl6TkxOcVNvenB6cW9ENnNv?=
 =?utf-8?B?M3p0S0tCaTNycW5lejZiU3M0dE8xc3NIdHZJRnVQMldWUkJlU2VDaVZDdWFa?=
 =?utf-8?B?ZEJyM20va1pZNzFUL0JUWi9UZThCNkJIME1TWTh3RkM1Mzk4bXp3Z0RYZlps?=
 =?utf-8?B?TEpSNGFpME52U00ycGZ4SXRveXdycUVxVGY5ZG95ZDJkWDNYd280QzNkK3FO?=
 =?utf-8?B?MXZ5TVVtNWtwYzN4VzR2Y25WZDB2NnhHRGN1cW94UU9rNi9uT3NYd25YWWVz?=
 =?utf-8?B?R0wxZ1dpbiszZXlqUS9zeEJJVEQ2SzQwTGZHeThPcnNqZnNVRXRHVm9NbVJF?=
 =?utf-8?B?a1BXckRqNkZZaVFHQlJXY1BZb3ErZGN5UktPQ09MczRQQXJDd3lIdmFtekJQ?=
 =?utf-8?B?czJCeE1NMUsySTFEV2ZUbFEyQzRPbXZzWWVKSkZXRnk3Rm0rbWJFYk9hSlNw?=
 =?utf-8?B?NzNRRDVnSzcwRUkvSTNxNEd6SHFvZzBpMVRSSGRyYWIrZzdlTHRoaVM5MnlL?=
 =?utf-8?B?dk9nazBwTVJ3cmtDcjJzOWNWL2IxSHZDZnpjaFBxdXBjS3NFdEdSWUh0S291?=
 =?utf-8?B?TERDT016KzhRaDIrOEZkY3lJOVNFSHBYZzRHT1l4a05yTzYraXlQOHl2Q0J4?=
 =?utf-8?B?dFFKMDZ1WThLdFExOUR3RXdkWUU3MTdvT3plc0xuSSt2VjJTUm83S0tBb1J1?=
 =?utf-8?B?TlU1dUNYRlpUYXZKYlRBa09XU0hhUkIxd2NuUW1qZk1LMTJBRExCbklGVXFL?=
 =?utf-8?B?VDUxL2hWOUtWRDAxYVZpMXA4aVNZdzlYditmTUpxb0dWYU5KNk9weUhkOTQ2?=
 =?utf-8?B?RU5EbG5tTVhaWnpjV2Jjd0ZqTFlvVnB5cE5YNm1BbWZhb2VqSy9lcGx0M0pZ?=
 =?utf-8?B?SjQyM3YzcGVmell4L3JLdHkrY1FObWowM3Z4V2pqa2JxL3Q0OVI1Vy9rYlRu?=
 =?utf-8?B?OHkvMXhxMnZPdDgwczdUa2pvakVMV2pZcXBPR0lqRHVnSmRUaHpERjJqSE00?=
 =?utf-8?B?YVMxVFBUbUtjVm9Ubi8vZTZtN0JkYThPWlNIQUJFVkt3UHBsT1Q5WExFR2ow?=
 =?utf-8?B?c1RmckJoWGlXMkFvUEljajIvaHFvY2xoOVhLWVloU05JMCs5VzhhU0NkZ3M2?=
 =?utf-8?B?djc0S05wc0FQalV1NkVTVS9VZWtLQ0VkUWFuSjJZRm0yY2tlNS9BdTZPdXk4?=
 =?utf-8?B?T2NGalBmQ2JaYUVXaEh3ZmNrbUdPend4V1c1bEdFTlpJeVhXcTcvYW5uRGRS?=
 =?utf-8?B?VkdidU5VQ0wrblR1cUllS0N1QzNOcUNNTVh5am1YMGpROGJuSStBM256ZXZK?=
 =?utf-8?B?TmRTVDJLazRJV3ZEekl4aTNiT3R4U2dNd1M2L0l4TzZ3Vm5jMUdUYUJMRzVY?=
 =?utf-8?B?ZGxPK01TdFpQYmRucnJISVNFUTJnYk1nZkdyU2gxZTFpNlVSbGhoN0tUUkMx?=
 =?utf-8?B?QmNoUGNkeFpIVGNER2ZLQ3JKek95Rlo4ektsZ1RrdGtFdkhsQ2Z0UEd4TElV?=
 =?utf-8?B?WEp2ZXlUWm9uNnVRekszN0tXbkowVmlUcGV5aDJhR1dIUXBjZW5POG01dVRE?=
 =?utf-8?B?N0UyMDVEZzIzcGIyamZVd215OHRlSS8xTjhEZFlzZHNyb0FDTEtka3prQ0J2?=
 =?utf-8?B?S3RkNmU2cjNCdEx4K0hHT1lIbitKSVl4SzNyTTNKOENsNUM1UWZGRUtQNTZx?=
 =?utf-8?B?aUYyYWh4Njd5NmRteURqUENITEJObUpYaFpGZ2JHY0IxbUlzbm1tSktnL2RU?=
 =?utf-8?B?eGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ba115775-9a4c-49b7-1074-08dda4ded547
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 09:45:12.5781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8LuuDJq05ezjyltVbsmDZlaLgWts+Qav8JR8nRRj6XDl9RijK7POvLnS0YVLwxN48O67tzIlZ/M3b28uK+iQT7H5NpyJYDRuhbg7P7IAHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7962
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

Hi Michael,

On 6/5/25 9:46 AM, Michael Walle wrote:
> According to the help text, you can set negative offsets to indicated

s/indicated/indicate/

> that the offset is relative to the end of the parition. But kconfig

s/parition/partition/

> doesn't let you specify negative hex values. I think this fell through
> the cracks when converting the symbol from a '#define' to a kconfig
> option.
> 

Maybe a Fixes: tag would be nice there, but since we don't have stable 
releases like the kernel, not sure it matters much :)

> Introduce a new boolean kconfig option to switch on the "relative to the
> end" behavior.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Not sure about the ramifications, but the change looks reasonable to me, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Maybe we should have some test for that to make sure it works as 
expected and keeps working as expected?

Thanks!
Quentin
