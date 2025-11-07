Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F22ECCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 15:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B460283D8B;
	Fri,  7 Nov 2025 16:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NCN6jJBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A3283D90; Fri,  7 Nov 2025 16:07:36 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094CC83BA1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 16:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URc3voohYuoj426MdaiQQ0mO76vTYfi4Js5U7wdY1Xdt8MMYrf2v1+uXWMpy2ZaME6hS25J/mny+Wpwyuf1qgTksFxqu811N9KfoQeiFMvNij5P2oZJ+YivbwHmeBJuvI9NyyVRzWawL7M3lGS1N0q0NbzDlRARO0NOnrpkAw4s0bIuDA0plkkXZe67vLXWdAmq4G5yBOCm8TySS7Jbqgv8dJ2IO0wPR9jTkFz4yYdbBtl8vPHk+BOKro/EPNudsmsO8pT9Ty+A7UXdNU/hrWhzO9h2j9L5NFPuCfIn0yhMqhnvKpXx47sdlvMpCgzmRUK6d75stoG9UUDxeiZ9uHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOMhne2pGqid2+Zy7yiajcR1YTi8cyyULbl24Lus4wM=;
 b=PFUDa9C+m+SOE2ZsDqYwRAM31/EJRpQiIDiZOEkP2G2W0QkIHZmx3iN2lSWSDnhPpQ2TMI8y6sX3zww7SG2F0zUMyoFGBID+jwxaB+9M2sRG8tkqJ/y1NnjOVAsrseoulrKRhIZ1oawIGwQ9QzR5CFCAXdqVApT5QwNKCv1Yz/5Kz+vAi2uB05NNyB+4HeZmK1spZRI1fGNDPx6irM/O3aAueF6vOgWCo/tTcST2iFxpfe1jg3bWo7l1uA2O0JguIAjBy43PFQUHHAdor7VuuAUIWFDHTfU+le75iH9YjwogNUNhedif0z09WjCJt/v9cHhvoaJltQgzeU1OywJOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOMhne2pGqid2+Zy7yiajcR1YTi8cyyULbl24Lus4wM=;
 b=NCN6jJBSkYAaYV7RVl02Xv/b7FnMDrYnwPMEintAFtHmjUUGLnD5u8CxYAYUpSz+ifNwQSgIeLwUcHGHNU9W4GpNaIr3/+ETvBJuJq0+JUgSjS+JGEYHfkiRJPL6FMSUzpjergzBHtZiW3Vz7P3akFcFeMy19Q3DZpUxLlZBLsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 15:07:29 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 15:07:29 +0000
Message-ID: <04fd00f4-1bb6-4a29-8e1e-83cdc1b03b74@cherry.de>
Date: Fri, 7 Nov 2025 16:07:28 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Binman creates a single image 4 times
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZRAP278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 17988e03-127d-4f58-ef6e-08de1e0f5e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE5GVEpQdHVFdE1WOVlydU9BMGIwNXA3U0JhaFF5Rlp1M1VKSUY2VTlwYkZu?=
 =?utf-8?B?RmNNcnJNNDM2ZWpRdVZkeEc5Q3JoSzJkOCtNcVAxb0xxZGRobUs0ZVIxSm8v?=
 =?utf-8?B?d2lxdzZKaE5VN2hSYlJraC9tVFBMT3JBb0d4VjFTUEM1d2hBL3FDSmJWOUVN?=
 =?utf-8?B?ZEpSZVVFSWRlYUJuZTR3VEVNanA4d1hOUmhUUndJT2ltUjA5czgxQWRtN1J0?=
 =?utf-8?B?dVFDbUwvVjdvYTdvWXFZYmRNTXgzcERmcm55MG4rSDgrelo4L2tBQTlKSTZx?=
 =?utf-8?B?a1JxSW5uSENKaHd5WFpNUGdnM1cvZjRjS1NyMjNKeDZIU1g0cDVvOU5YSmZ1?=
 =?utf-8?B?OGlHbEtra1VsVU4yT3dpbitNK2U4YU5UK05QLzRBbzJLLytlU2QxMWx0RzU3?=
 =?utf-8?B?aDBvMGZXcW5rKzNhWWVhMkJZNGRkRXlOTFEvcXhONk1PS2RUOGhQNzl0UE9z?=
 =?utf-8?B?QU9JRkpCUEIzcmM4dGR1TzUxLzZ4SlpvWnIvdHNXT3dGNDFmbWRlL1UxdytT?=
 =?utf-8?B?SUtpaDR3a0U5VnVzUDVybmlvUVFCdW0rdkR1L1hiMGduZG96aTRGeHlWNlZB?=
 =?utf-8?B?emdPRVMrOTBoN001QjBDME5qQk5lVi9vZjMxS2VVUmJJVnI4SVltVnU3ZEVn?=
 =?utf-8?B?UFNnQ1pMVGZIc0pRdW1YU08yNzRuQXNISmhPd29Jdlh2SVlMNGQ5QldCN0lU?=
 =?utf-8?B?c0pIUHplNDhyaS9tVUo0ZDhQdkNnVUc5UG5qeDZtUkZ4OWZVTEd2RkYwQUtE?=
 =?utf-8?B?eFNuU0N3Um8wMDV6L0VGZ3o4UFZYL1VWbVRMQTlXWVRTaW15cnUxb1Y2blFk?=
 =?utf-8?B?NjhnMnAzYmluQVZ4RWN4Qld5aGUzdVlyalQzL3lYSS9PQTVEQkV0aUxMMUtl?=
 =?utf-8?B?aFN0ZHJjbE9hU3hXYndYNHB6V014TldJVnJEOTFnMSt6Vy9FdXRMTFF2dnBz?=
 =?utf-8?B?OFhwS0hxTFg4eThHSUFEUkVMUm8xbnpBMjJoUW5zRzVncm8zb3ZTVWlyNGYv?=
 =?utf-8?B?dVVSZDBZWGlHUWhNY3Q1emxCN0k4Y3NrQkF4b2k2T1FQVHlZWS9kT3ZxV3pz?=
 =?utf-8?B?bUFMUzlsNFc0dVVQc2tLcFdZbVl0Wmx5ZjBJaUVDVkpZM2J0NDdWSzVWL0Rm?=
 =?utf-8?B?OWRNbDNydEpmRXlVQldWTTVzV21BU3pQZmZNUS82bFVsMm85R2JOdzhnVGh1?=
 =?utf-8?B?YmpCSjAvek9jOS9mV3V1SVFmMHNFZE5rSXV2MHBKSTQ4VWJadm0zZmVzMzJS?=
 =?utf-8?B?Uko4SlNDVUxyQWt6YjVHUldtakVmME5uMWxaZTBDZDZtTTZOaDQ0VElOaXdz?=
 =?utf-8?B?RzVJanUxbnZpdXpmUnkwdVpuNERUYXEyUVU3MTNHeTM3K3ZHeml5LzZiaitJ?=
 =?utf-8?B?NUpGeWhFd2VzYkgzQW1FOUhMZDVGZEpRbEh2d3dPM3VTNXM3azhoYXMrb0tw?=
 =?utf-8?B?YXpsSU5jVUxvUjZrSjNIdFBwQzJXL09oUzBaLzJvZ2tKdEFRTzVHZjBKbm90?=
 =?utf-8?B?WVUra2QyTkZVVHlzUmJUSnNsNmg1Ulp1QXNBY3ZOK1lOeG5OSGhVandobWJS?=
 =?utf-8?B?Lzd1eFhQQXEvQW9ZVTU4RG1TZUVXSjJJOFd6R0Q0bC9MaGJiajMwNm9XeElV?=
 =?utf-8?B?b3BDNjdGY0dZRVNJWlgxTzcwNzNUM256QzlwbnBvbGRqcllPOTNQWWJiUWNU?=
 =?utf-8?B?VVFZYlJFYmVEcDdGNXdZeVBJeVA2eU9NNzdqL21YZlcyQzNkUnNvQUFuRnQ0?=
 =?utf-8?B?TXBobWFVOEt6RzZ0TlNZUWlqZEZva25xa2U3d24zM0E5QklRcDhhMVRkaUFk?=
 =?utf-8?B?QksyUG4wNTRDTHVuUmVtcEVkL25FSVpldk96VzVGUDJSZXg2QWl3cnE5VnE5?=
 =?utf-8?B?bnNWQ0lBa1FKWGE4R2Jzbm9uSXllVG5LWkljaHBpSitkSkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0E4SFJNWDR2V3ZXSnZXRjBLRG9kbGQrUnE4YTFVcWYwZHlOZ0xCU2UvT051?=
 =?utf-8?B?REY3WnFLVzROMnhnaXl2TnBaNHQybHFUai8zUE5FdTRETmFnZktUcDUwTUpI?=
 =?utf-8?B?L25rOUQ4VlJVTWFCNG9YUHUvVi9DVmlMbmRhRS96dk02cFZERERkYmRwdHdp?=
 =?utf-8?B?N1FOYWVFVE9rSE4reUdacE9FR0o2cVMyc2kvekY5a1JYUnhpb1BsdjdteFlW?=
 =?utf-8?B?eXl4OEIwdzNOTDVoM3Y1QUNLQVFyd3hManlrcTdBL3AwTEJtZzhkZm1yTDRp?=
 =?utf-8?B?dFBWSTJWeDRMYUZwOVZMWFp6SHkrM1A4VVZIbjA3cG5lT0VjYldCQXZROUts?=
 =?utf-8?B?Y29VcnlTcy9GanBiVlRxNlQzSkxLMnpxRG1pRGFhb0ZUL2JDQ1Q0YVc5bUZn?=
 =?utf-8?B?VDFNMEwzTFVPQWxhdkJSajVvK1ZvWGx4ekZNWk1FQy9qUlUvRXYrK1hmaE5q?=
 =?utf-8?B?VStJQ0xCV2FWTy9wUVQwTU1oZkpwMFVSUEI4K3E4UTdqU0hwSzZpb1VXelJx?=
 =?utf-8?B?ZGJwbEt6V0lOT1ZWUWRqSHNwb0hPOFg3REd4WlBtNXZXWjJpYktqMFlWbCts?=
 =?utf-8?B?M1JSb2lhbHBERVhCVlBBdGMvKzR3am5nTmNmVlNtWGRqUVc3QWJtUFhFQTBj?=
 =?utf-8?B?M1dkOEpuOGpzMldQTnBYUnJOYmhycDBudlhrMmE5QmxNc3ZTa1RQVkxXSXF6?=
 =?utf-8?B?azR2cFhOaThuUXZTNnNnN1M5ZmRaTytublpha3BjMmxkZTZJMkkzeWZaaVJW?=
 =?utf-8?B?UVZCYkhuMGtjLy9CSFVGZDhjMnhoWitCR2NHRjIxdjU5TE9wdGNXQldOYkFQ?=
 =?utf-8?B?bUUzM2FxakpEcG9rZmxNbzZuQXNmWGxWL3ZEVFVDWDNXZ3NOYmNIUGZ6N3Vt?=
 =?utf-8?B?M2RKNmhVenVBRzI4akRiQjRvcjlCREJ4OEQrcHlVTDBkdzRQT01zQmdpVHRP?=
 =?utf-8?B?WnF4N25NZFVENXpCOCtTZ3JjMkQrcHNoazFleTZTVUw4Q1hFWjhDeUZ4eFpx?=
 =?utf-8?B?UUV2WkNxOVM4YVpzaHFGNWczRHlVSStTanZzTEM1MEdUZjdNUTNQTzhEZTYz?=
 =?utf-8?B?ME42eFc3YldlNTRlYTB3WkJMUWwxUlhZbW1aeEVXMGZyN0tDZUVtL1VGK09D?=
 =?utf-8?B?WXNGd0R2Wm1lekpQM2gybE9YMG4wVlI3a2RrajNTMmJUVHIrUE9CK1A4eTZv?=
 =?utf-8?B?NWN4bUV1NGM0ZEVLNWlOWFVEU044UmhLOTYxd3dCcmRZQ2pETnhoZEgrYnli?=
 =?utf-8?B?VWxhc0JjTmNEbDJKZ3Zla2o0eE9lejIxNnNxVzc1c2xFQm4rT0NzbWRtelpl?=
 =?utf-8?B?UzVBcmtDMjZvakd6T2VEUXByb0R0RkR4ZzBnRmt0bCtrQkFBV1NiVXdlOVdU?=
 =?utf-8?B?bng3VDZ6clEwVlZwYlBSYzZ2Q2xMWlhrWU5zQ3hLM0xaZXhJS241Qno5NmZw?=
 =?utf-8?B?TnNGQjZmSUJrb2RSYzdDMEhMT0RvZ280RG16elJTRFFyZEl6YW5DcHVkcUs1?=
 =?utf-8?B?UC9vbHdRdlVoUCtudTJCcjNScFJLak03YmpTMk5Td3NmdFFHeU5PY2EzQmEr?=
 =?utf-8?B?VDJFN1JFMnJuaFpFZXJlYmt1TlloUHVrNnRtY0ZUdnBqSTlaRWtvNnJTT2ZF?=
 =?utf-8?B?VFV5bXpVYXplaDVhUHkxZnVDZlMvb0RPaEZyTnJQQ09ZVllhQnAycVlpbEFB?=
 =?utf-8?B?WFFubGo1RW5pS296UEVZWjYwM0xUTEMzNk8wam1MVzVvcnZIeUYvQzJ6bzlX?=
 =?utf-8?B?NGlpMHlWbnlxMUVjb0o0VEUrZG15aDN2QTdqQTIycUZZQnhsMkRUWDhTbFdY?=
 =?utf-8?B?NTRCMzFVRjdDWTV3S2g5Mlp4elB3b283QUp0bTBReVhPRGwxVkg0WGJvRTFs?=
 =?utf-8?B?RzdIeStacVZ4RmkvVGVZbm1XRVUyaUtkTkdKNWl5enhaN1dwVTZ0MUVWcHBl?=
 =?utf-8?B?NkxReDF0SzR5dXNSWXV2aEFFb0JTWW1ocGFmY2M1NFJySzFYZjlBeUlzK1hC?=
 =?utf-8?B?L0tlQ0RsMGpQczdzZXZ0WHg4dGRmbkc4aFFCTVhCSXhWcSs5Q3ZTcWx2eWhF?=
 =?utf-8?B?cUxiTW5YT1Q2Q3VnTW1iRllyTGJMNVlYeW5sdDhnSWRoN0VSS2dTeE9HSkYz?=
 =?utf-8?Q?fuwNkjq8UMj/XtI7XUI2VcBMM?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 17988e03-127d-4f58-ef6e-08de1e0f5e8a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 15:07:29.6244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuzGXv3ExdN7iPOeJjpVOlk2lCI/+vE+jEUkZAMf6Gydinly/GgGz2x8ESI75xrwbb+jmPnnA+2h/jh8vVFKl6L2YgwpymelsPxJ8w5Oubk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072
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

Hi all,

I'm signing U-Boot FIT images with binman and that takes some time. If I 
build twice in a row without any change, the build process takes about 
15 seconds, most of it spent in pselect6() according to strace. I have 
yet to discover if it's related to the engine or mkimage or even OpenSSL 
itself. Anyway, nobody likes waiting and it differed from my pre-binman 
U-Boot enough that I "dug" a bit.

Even when not signing, with 
https://elixir.bootlin.com/u-boot/v2025.10/source/tools/binman/bintool.py#L294 
used to report all calls to bintools made by Binman while building the 
image, the expected bintool calls are all unexpectedly (to me) made 4 times:

bintool: mkimage -d 
./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-section 
-n px30 -T rksd ./idbloader.img
bintool: mkimage -E -B 200 -t -F ./simple-bin.fit.fit
bintool: mkimage -d 
./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-section 
-n px30 -T rksd ./idbloader.img
bintool: mkimage -E -B 200 -t -F ./simple-bin.fit.fit
bintool: mkimage -E -B 200 -t -F ./simple-bin.fit.fit
bintool: mkimage -d 
./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-section 
-n px30 -T rksd ./idbloader.img
bintool: mkimage -d 
./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-section 
-n px30 -T rksd ./idbloader.img
bintool: mkimage -E -B 200 -t -F ./simple-bin.fit.fit

(in that order).

Printing the stack, it seems like:
- 2 calls are made from 
https://elixir.bootlin.com/u-boot/v2025.10/source/tools/binman/control.py#L789
- 1 call from 
https://elixir.bootlin.com/u-boot/v2025.10/source/tools/binman/control.py#L802
- 1 call from 
https://elixir.bootlin.com/u-boot/v2025.10/source/tools/binman/control.py#L813

Is that intended/expected?

Can be easily reproduced by building ringneck-px30_defconfig for example.

Cheers,
Quentin
