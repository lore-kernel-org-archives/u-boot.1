Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D21FC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:07:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF7F087E3D;
	Mon, 11 Mar 2024 12:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="mWNbfoqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D9987E87; Mon, 11 Mar 2024 12:07:12 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B714387E1E
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 12:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMXskwizdz9vmoD8p6JgaqeyinTYPUiJpL47gj9guUMzKXOj42kuyTsRb1KDvkAc2o5+OqYHllP2RI3lyBY+Fn72pDwZdgY6AZtKZjgbMGtYwoBr9mQF1X+ccbtWjzGCKqRCOBzy9YynYNLLhuMswX+JHGbDG6A7dVxw/EVwwsmjDpc6X27ZqX8l/yatOvWVzHxgokAGTX8yU+y6QIPk8x6q8TdlNR7Zw+5rKiQinuOEPVUHvH+oV2y9xpaR0QqPZfZPlhS00X/ebU1Pj5hwClSkbhSRGtw8lsNP53Y3OtQRlqA80urcoOc1a537Qu39YzAdlWc18I+al2RICRz8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwkUDr/TKxLNPj+vcmfPJPhJgv3R08/4C20o/PWlUZQ=;
 b=SCpGD5YMQ2BAM+7e+3psdnOUVzRJkZxQ4ehpfSzquRdmsswVXpV7HEh/ZjazUFAooKZyq+xCoCHLeJiQrBpLjyBLO1LOhoy8JbwfLa5MtyZlX0LLR7nY2V0/hnDpkAYwqWGasE3OZN0bgunSpImu77rc4LheGrxHQnVfkzLxLuFg8VWiiWKm4lQ3nS1CF9vjUbRO6Ln0LFtaOMLW6K756OoPVteYiJV6NpEM5UniZh7QL1RyK7nAeuB75QuJoKfdCdK+CDD1NfYxb0pTEJ9lyVJs8ZdogCxaa9gHIvRkANAsHnq8l2faXD57+95KKBPIFwHlLz12vvlQK0c9LzCO6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwkUDr/TKxLNPj+vcmfPJPhJgv3R08/4C20o/PWlUZQ=;
 b=mWNbfoqv+YwIeTaGeRY0sbUb1jMjpY9T5hz2O56/GeYszrXoYarDRf6Rf8zTuY5yrpMhv7Gay3a+14hLMChzaLyS0M08sEo9BllydJDTJpqL27zQ33tJfPmbBcnD/mdKbYu3n0BYeBZacKQ5jHTpwCSCiyKPF0iPuo/HYB7iC90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB7779.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:647::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 11:07:06 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 11:07:06 +0000
Message-ID: <11d45dcd-9955-42c4-b527-0ec8e55658ed@kontron.de>
Date: Mon, 11 Mar 2024 12:07:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] mtd: spinand: Add support for XTX SPINAND
Content-Language: en-US, de-DE
To: Bruce Suen <bruce_suen@163.com>, u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, dario.binacchi@amarulasolutions.com,
 jagan@amarulasolutions.com, bruce.sun@xtxtech.com
References: <20240311101246.13697-1-bruce_suen@163.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240311101246.13697-1-bruce_suen@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e49bf04-ba2b-4a21-d66f-08dc41bb6365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqBUou7XnxmyeI/bEjlpqWfW0qzlJdDcnTor0FbvkPrBVm4stFmkxvecKzSe43QltAfhfXjhxdZkFc032G/JTud5oTdQKJ1rhp1N3BW1WELqZoGzhwpBKDM2+9aHdGFL4Ie5v7RUOhHZQXWvyj0p5z6Nq2y8aD4mDVku1QKI4+FGk9IDyVW7yfoyp2cYCg/e2Aea4uYzzFFTFCxJ1UPmgzNIGQyEAbf4bAtDtPBpoWfgMM9VvI6SZf+8NwhIF3/uvq0eNU2l0CoJkEJRvlDlGLAMeIdi6tQdxlQCGlaH4RLat7eXepYYQRe777nxyeo5Zi8tueXvRTBAAPyK+VudTgICZn0vKd37TbIHF2o9xu2ji9wIg55YkN4Etxdh/V/jtnBZSo9TLZQdclEaQSwAeTTAjRSAdhgXan0E75lgCAiA2JuAifa0g/VShekm0EklWk5YAdQuf1rr4tzQ2Um2SQ99R5owJR3gUQ1MNHoY8fnSM7DT12Sv937tIHF2Im6Q20WmYiHjMOBezC4ZF2F2kZd/83O+BxIu4L/RuRW16TjhpA85N/yg/htad+UlB+crHc7kvEsRRn735FhrpXNv4jRFmSFtox+Ozf5+Gz4qhYGCMC6sDBEBqQZlHSbs3BX/WNkn9BJt4OJvhbsTIQCidw0HD5ZwGR5K9pty03IQBbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2k1T1p4a05wVUJmRWhRcDZBSCtERVFoN014VVJZNURjTXh6c3RLWEFmYnlP?=
 =?utf-8?B?c0tKZ0RYaUgxcXkyZ3h6QVFBdGlSa0tBNEpTKytGY1ZheTNWaFp3dVVPbEZW?=
 =?utf-8?B?ejdEWjRubHZveGZPQjc1dkJiVGplcmRhRGMyalJNY3ArNVlIWWNwVjU0NUNB?=
 =?utf-8?B?a01NZVhteHZCTVc0cE9lb0N5Z1UvUkE0SkRycTJEbU9Tek5pM1ZtNi9PZzAr?=
 =?utf-8?B?RE9PaFd5Z05NYmJ4NEVlSEprZHRobFJpL2szVHRzcUVxRkk2Z3RtNlZJV0FR?=
 =?utf-8?B?TkRUSGtJaE12am04emRsclVXSkdzTHZXNmpkRVNYQjdtZ3ZlQkZGL214NkdT?=
 =?utf-8?B?enliVTZzMU1jelRjN1RVSm1uZVpaMkRQTE5lOW5nWktLQ0I5cGhYN2RyKzRp?=
 =?utf-8?B?N2ZUcG1yYjdXeXJObFFRK1hxeTQ5RXVaaGFWL1dnU2ROWE5DVFJhSnNEOE5V?=
 =?utf-8?B?UWdNRWN0YTF1cGZuRHZieml3UGJGZ2ltRTJTZUN1Ny92TytveTJ3V0V4WlpI?=
 =?utf-8?B?bm5TTHp6WEkvaExhbmZ5QnFGVDlHNWx3ZGtkeHliNWE1SjZ5RWR6K05VV013?=
 =?utf-8?B?VEowMDlOZ1Y4eUdrOG9PMUtKdzJhbXAyS2l5bW9XR2lma05DMWhvcEswUWdP?=
 =?utf-8?B?M2pZajJLekZDTjF1Z1UwYWJDeTdNMkRYaUozZDYwRlpDZlBLMmxaWWRReEpU?=
 =?utf-8?B?dWhDUTNjTktwREFVMU8xcUh2U3dCOUVhUGdmV2Z6eXF2NWo1YzdBSHVoUGF6?=
 =?utf-8?B?Y0ZMakhFMzYyQXRzcWM2RDJ0VnRPQ2pOelk2R0dvODdsUlFzWmNPTW9rNVJF?=
 =?utf-8?B?YzY3eG1FTDZveStQaW1WeVorcUk4Rlk3eWViSE5taTgyZnZRdUh5RkFBV0tZ?=
 =?utf-8?B?d2tWeXhlRnoxbVR2clAxUzVOd0lZdHFHdFdEcFZGYmxDVmZjRldOTkNnK0p5?=
 =?utf-8?B?TjZ1aXA4c2pDNFFUTlNOZjNTTEFyV1l4dVpEb3dVU01SWnRkcmhtN2tGZTBy?=
 =?utf-8?B?VERwTHlRRm81RTVnUCtXSWc3eEtIMy9aQXA0WG96NC8vQUZ3SksvYmFiUHVn?=
 =?utf-8?B?aWp6ckRJdCs3SE5taURoN3YvblQxaElPdktNczAxd3UyM25sZW45bjFHNmR4?=
 =?utf-8?B?bStoaEthK0VkdXREbWRUcmZlalliRFIwa2Qyb3lKeis4TTlUQUFXdmJ2ak5v?=
 =?utf-8?B?U2ZzcnlHSjU5VWNMK04zUkdRYVplbDkybDJxWGNxOW5EQWxWczdhU1dQRWVn?=
 =?utf-8?B?M0tTeVNnQVE0K1N1QkkvaWM3SkM3QmQwUnF6SUlMbFBqbzFUeVJzRmt5Yk1p?=
 =?utf-8?B?anVGYUpQT1hHdUUvc3VvWGtLc1dmc25lQ2tRZVV6anZkbkprZDJGZ21SV1Bi?=
 =?utf-8?B?NGdsYU9xWVAxTDNER3J3Y0FVN2JUZVNXNFk0c2FacmU1ZDdJVDU0emlwMEZr?=
 =?utf-8?B?MmlxVlg5T3c0bHI2UEYwbi9QZ3Uxb3FGcmtkLzhLWXlETGs4U0JxT0pFOWll?=
 =?utf-8?B?TFhUNW0rWjRuY3RYSG1zWU9QTXcrL1R3NFF1dG56K3VCZ1NhVGE3M3U5aHlO?=
 =?utf-8?B?K21TQXlIMitsdVlUQVg2UlIwQVNqUlphRUdCZFFWVjVobEhQTktqUk5YSWZs?=
 =?utf-8?B?TGwxWkl4RUVxWjhZS1o2T0hXa3loTGxnWXpQc1RZNm42bHZ0Mzg5Y1hFZGVV?=
 =?utf-8?B?R3RXRldlcmVoTmczcFRndENnREFYM2RlOUVhTlAvaUxqYnJWbzRFWUVEN1JQ?=
 =?utf-8?B?NE43bGg2QzJlbVlERDBKZ01zSWpuLzh5NGVaRTVZcHdVaFlRaEExQjJpc2N5?=
 =?utf-8?B?QWU2bE1BTXFOZWZyKzhXejlwUVN6aEhmZlhDemk1M0hVNVVjbm1wWWY4MTRh?=
 =?utf-8?B?WkdBYjgyTHVCVklVYzJRTE5zS2VWekhaOUJSL1FHZWdiUnVIbzZMaG1GeGJk?=
 =?utf-8?B?Q2w5MkV0QndzNHh5N2pVdXJvRllFMkJza1hGLzBnek9WcjR4azR3c2J5QXhK?=
 =?utf-8?B?dUU4YWQ5aW5PZjk3ODdkdjBkZStBMXJXczJMVml6U3B6MmdpaHNFZExkbU9k?=
 =?utf-8?B?L2M1WGhUQzRIdDAyd2ZFNW9FSk5EcFJCVi81ZTBuM1g5UzEzdUt4NWRPUWlK?=
 =?utf-8?B?eCsvayt0K1VTUmxLOEJSeVhwbjg5NktLckdUZVBjY1FTTzI4RTM4bUxrV0g3?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e49bf04-ba2b-4a21-d66f-08dc41bb6365
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 11:07:06.4097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bq8yCxAL/3rGq589nVZviNejHAQVkftYTRkdhEPCldyd+pI7RHZfCCGkTJLtfxB4HUXrqQ4J8noXLYqIpC7ddiB+TDbwdefMQlOE8dHypx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7779
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

On 11.03.24 11:12, Bruce Suen wrote:
> [Sie erhalten nicht häufig E-Mails von bruce_suen@163.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add support for XTX XT26G0xA and XT26xxxD.The driver is ported from
> linux-6.7.1.This driver is tested on Banana BPI-R3 with XT26G01A and
> XT26G12D.
> 
> Signed-off-by: Bruce Suen <bruce_suen@163.com>

The commit message still has some minor flaws like missing spaces after
the periods, but anyway:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
