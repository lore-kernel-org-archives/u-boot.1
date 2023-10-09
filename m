Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A362E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 08:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C6C386550;
	Mon,  9 Oct 2023 10:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="QC3QXSQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B669866B2; Mon,  9 Oct 2023 10:24:01 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B059986504
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 10:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhfilxLpTbgWM81Qm3MAdDP4fDECk4UdNSiLVunDJv3at6il2RGoG2M0TdQ04HO/ZZTOwIFDHOU9tG1g8+lnS7kHpErjPQyLGftQK+uGzKrshtX9BcCc7gSEHQAsnuWuFItOuKmy7QZ8zDC/41RvC4wKZ4chgnTVpryo8S1Q5IcR6ZhcFzxmTp0pSrqK1JIY1kczB1ifmjDxShJF9Ku682WJExnIVxxYxHE9dVANEMqqzyWdcK7nuQmaIO+/lFD5Kvzg84yNeA0irmU8ONSlsbshxEvvhP42jETw02l160eE+3l4jc3u8WSTkNZ3cchhjdS6x4saEpLr8J3p1CtG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tygqFOGIELrDR7qF96v3RgePO7vDJ7tRvAwjxFJ5ybs=;
 b=OJHAWQEbQ3memgwnc0MEg52/MTe0nXu/8DX732ZTZL4+CUk9xlOANM8Qk1bkTDJ5UAdTTTY+bLvJU/kmXCJnS6F9wgG/d/3MGkNhiZaA1d/3lSp2zn0D2v93fZk3gmwO22KEnDNeRUYFLDUqwu+GuZmNSZg0gLQKdG0PinWV9iw/oTcpEn2RJSzYl+MY2I+hV9Dg6TtPaNV7RQz7Y2X9ToQMWnyp71I0tCaMrQE1fjre4s+7fgye4HETNENbDLYipM+faip9XVJT55j/9JyTwGNXDKBOA0ZwT2iOOw8tnSUhjiJSwKETgwmOfLzArtHDhyoNUUEQUuj1KOojP9hrqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tygqFOGIELrDR7qF96v3RgePO7vDJ7tRvAwjxFJ5ybs=;
 b=QC3QXSQ3AwkRh1+9hm8Atc+H/3jW5FypKMVA9mDSkI8AlwWCDiQjCO9zIiTh52qGRxSZXcXnrBTgmbm+LB3/xrczeTpf0KjwPnPCrGvMHXKru7OtViN6v3tkQwQXIBqZyNVFbKq7nfkTveachVMq6WW/RY4BxaF5AFrWNP7L/ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 08:23:56 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:976b:532c:939a]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3e1d:976b:532c:939a%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 08:23:56 +0000
Message-ID: <cd1bc5f7-b8b1-41ec-ac0e-849ef3eece73@kontron.de>
Date: Mon, 9 Oct 2023 10:23:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mtd: spinand: rework detect procedure for
 different READ_ID operation
Content-Language: en-US, de-DE
To: Igor Prusov <ivprusov@salutedevices.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Chuanhong Guo <gch981213@gmail.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot@lists.denx.de
References: <20231004150704.49945-1-ivprusov@salutedevices.com>
 <20231004150704.49945-2-ivprusov@salutedevices.com>
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231004150704.49945-2-ivprusov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0153.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::20) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e1f71e-949c-482a-b737-08dbc8a1146c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8960fJj+79+VZt6gHht4Z9NVegC27zTTLEZ25tSWxYjtMi1wWgUsejd4d9ccbO8WqtCKDKw6CSRlVQcv6joK4kEa8t7d0HV/EYCKew2SsP5P60IpBz6JuyMqrnWVc4WCkoMlN7XYU9wmt/mAZ6d7mbofhwJ8FYzWM10YibERaSQ1Lp+nayRziCXEG9YDvx9gHet4uiqSX00J8a22rX4xs3Rjh/q4m9kncHtOMLaYyg8QkNt/RfB0lSqnKO+jjpDrpvaSZVyzREEU+aN6gBjifaTGL/fm2bIPvQeHTYF83DkI5mQZTFaPaEOg4k93iElpdWF12/5VN7JC11IHEMnWnKP5NViMDdRaOcwuOmDJ4Mha7Yf7UvYofGhFAcZzvkcScU1iY60AyXgqwblILUR3jMx8c8jqEyGoLqsWZCiKn16T0X79JVadhRMK66vrnH6BoO2//LF7B6p4VL8s7x05poKbuDT5OGuj4YI8hbttCUlcfPhXg2kr6Rp1KA/zw9sxGFvEN1lLq5b789cAMQadugvUg1ecjawzWNmd7haWY+oIN2pQ9AD9MgeHjhiCkBVh0I57gvXT8/zgeenWeiDjEtPQRz5Pi58XbwFoaHDGtNVCUSO3HjHhxIZTzIb2BTU7kTiFqKajKAUNEZLkTOw8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31686004)(6506007)(53546011)(2616005)(6512007)(36756003)(86362001)(31696002)(38100700002)(26005)(83380400001)(7416002)(44832011)(2906002)(6486002)(966005)(6666004)(478600001)(41300700001)(8676002)(4326008)(8936002)(316002)(5660300002)(66476007)(110136005)(66556008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0d1akZ3T3htOFJzellCWmlEa2NwMkowZ3Z6ZVRtcW02SUNNUlQ1NlhWU0dh?=
 =?utf-8?B?eVlaeWhzMWg5dStzdklvTTlhdkQxaS9WOU5WSVZPbUR5V2NaT09xcGFqeGFu?=
 =?utf-8?B?ZDFaaVNsM2NTQzRVS3lkU0dHVGFnS3RVMzZ5a3UrYWUvRTBBTlJIOFBGSk93?=
 =?utf-8?B?M0ZOL2FCZ0twQ3hQL2ppS0xOWGVLTVJIalRMckw1ZkZLMDU2d1U1N0dLRjdo?=
 =?utf-8?B?eGluT05iN2RCOERHZUZjcHNiNUVsTmpVOXFnelFTai9JSkQ0ckNMWnlETDNW?=
 =?utf-8?B?UVAwS1A0SUFZS2VKbnA5cWwyWFJYQnIwYXoxd1RKV3NrY1ZhRy82M3RzdWVp?=
 =?utf-8?B?NHlZWDA5RjhDa1pqd3h1YzdNZDNmNnZmdk1BWUZoNTc5bk1HckRVL25kdERC?=
 =?utf-8?B?VFhENjNYYitaT3MrZ2lSTDZ1RVBIS21LSEVYWFRCUEg0ZkZjbjB2dWZlaDFH?=
 =?utf-8?B?Ykp3bUVqNW9uN0lTUzE2aWYwNWxRWk40d3lKdEExNmJibXFIMnlWUmJWWEdD?=
 =?utf-8?B?ZngvUFBoL0FMbU9YR3V0cENHMFArZU10UWFJRWFsR1kyb1M2NnVrWHd3aTZH?=
 =?utf-8?B?R0JULzFoRC9adEcxWkZnRWVzU2ZTdUFUVnZYZ2w2VWFHYWFKTCtkQ3AvWG40?=
 =?utf-8?B?N0VOMG5IcDh0MVZLSy85VkN3a3ZtczdrTm94dERETENEOVhJTlJmTjRUZ0N0?=
 =?utf-8?B?bndLcFlGREF5S1FUbnVFa0pGRWl5bm4rTEYyZTc5NjRrUmRzSjlzc2JCTm1X?=
 =?utf-8?B?b1RBbXBONDYrUWYxU0RCbTI5azZFNjlqclFRV1NXQ0MzY1dxRkhiQkIvMDd3?=
 =?utf-8?B?eDZ3RnptL3crREtleElXcnBCSmdOS1BkcDlpSVZFOGt6NnVjN3NqRTRLN0Fl?=
 =?utf-8?B?NzRUWHVYUk9GT2ZBTU9ma0pkTUMzRld0Z2o2Z3ppV1lubGpFcVZHOTE5eUpP?=
 =?utf-8?B?ckZnYWdOUC91aTYySEVzSk9ncVlORVgzNGdlYkJxbWJGMm9rUlZSMnVSczRR?=
 =?utf-8?B?T0VsUkFVZVM4OTByaVNSR0JaakRxVUQ2NExLYTJUWCthQjR6L0poMzRpNStt?=
 =?utf-8?B?S2NtTEU2Uis2eHYxUE1IK1VaMVhPR3dCWVBQR3BkQjE4V2NTN3lrQ2xyVGds?=
 =?utf-8?B?TGpUUnlRbERraFZoZExxa2JSTmFFQklKMmZPNjdEWCt0Z1JqTXBXbWtPQ1Fh?=
 =?utf-8?B?MG1kMTFnaXQrZ0xscHdILzVnMjJxTDVHWFp1SnNRSDBwcVhzbElGM1lBWFJI?=
 =?utf-8?B?L1Z5RDZLTExXNzFxbjFpS2RmbjRBV1RBbDlEYU95WG9LVzJCMmVRT1RmUUVG?=
 =?utf-8?B?QUNHdjA2VzZ3bks0RGJzeHZtTExpWW0wM09HNldtVW5adWs0RFpkZi9sRXRj?=
 =?utf-8?B?QktjSFAzNndTbkRxaU9PY1h0ZXkweUpraGdvdDZlSnVYOXhPUFRadVhsWVZn?=
 =?utf-8?B?ZjNsMTVLQ1pXUmU2UytnbWdwaXVrZlg4anFnQ3dDRjZsbE1hUEcxT1MxeUNt?=
 =?utf-8?B?TXFGQUExMnRhVHZObVFNVTI2TEI3U2s0L2dIM1B0T2hSUDVKSlZrbkxMeEtH?=
 =?utf-8?B?UjlscE1WTE9DSE1yMHh2RFRIZGcyY3l1UzRrTnhCbTRLcVgzTDhyV2xmbUdW?=
 =?utf-8?B?d01FSWFycENXalJKWU1FRHgxUm9Qc2xYMFdjNUlpNTAxc1loVFJKSFhITmRN?=
 =?utf-8?B?dlVUY2ExcUNISXVQT3ovM2xQN05kZWI1eXRHMFBvVUpBQ2VkN2h2WFRPalR2?=
 =?utf-8?B?RUVXVm5FK3dkdmhjK3U2YXMySnBFaWh2MDZ2S2Qzbm9SMDE1c3JISUl6R1hX?=
 =?utf-8?B?Y1E0N29kTVROMVRMRW43V00rWUlHdmh1Ry9KMGxiNURsNzdjY2ZxcysvWHF6?=
 =?utf-8?B?emovYlVHQkVMZzFYQjZnR2xWVTB6RVJSNkR3TllRSGJCNWptUGpGdzN0K2JQ?=
 =?utf-8?B?NHVWbmFiZlIzTmpXRVlwakM1eXc2OEZBeXZHUEFncEltRFdzRXZyNHJCd3Ri?=
 =?utf-8?B?UG1EdUpjR1JiWkJJL015eHJ2NS9lNC9vTFRoUElQMm43STM2d3lIQ3ZXdWpC?=
 =?utf-8?B?VjJLR2xieFBwRit1TDJxQXl6OUxoNmFkN0Z4ZjlISGJtRHhJUlI3UG1KdnA2?=
 =?utf-8?B?ZEx0Q3ViV0xkTUMxTkVaNmg5R0h2a2NUN2lyeU9XVW1ZcmllZk9ZSkpSRDY3?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e1f71e-949c-482a-b737-08dbc8a1146c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 08:23:56.2314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPh1tjAN6ANC0EzaR5tnUxtZioDMiSehJvN71WQNw9PbspU6RFukNmeJHCVJWletkcIJkl7jcI8Nh1vvQM6EPQdJjMb7Cpv18VD4AWUTAsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6653
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

On 04.10.23 17:07, Igor Prusov wrote:
> Adaptation of Linux commit f1541773af49.
> 
> Currently there are 3 different variants of read_id implementation:
> 1. opcode only. Found in GD5FxGQ4xF.
> 2. opcode + 1 addr byte. Found in GD5GxGQ4xA/E
> 3. opcode + 1 dummy byte. Found in other currently supported chips.
> 
> Original implementation was for variant 1 and let detect function
> of chips with variant 2 and 3 to ignore the first byte. This isn't
> robust:
> 
> 1. For chips of variant 2, if SPI master doesn't keep MOSI low
> during read, chip will get a random id offset, and the entire id
> buffer will shift by that offset, causing detect failure.
> 
> 2. For chips of variant 1, if it happens to get a devid that equals
> to manufacture id of variant 2 or 3 chips, it'll get incorrectly
> detected.
> 
> This patch reworks detect procedure to address problems above. New
> logic do detection for all variants separatedly, in 1-2-3 order.
> Since all current detect methods do exactly the same id matching
> procedure, unify them into core.c and remove detect method from
> manufacture_ops.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>

An adaptation of this patch was already sent long ago [1] and Dario also
picked it up in nand-next [2]. Though it looks like this was never
merged upstream as there wasn't any pull request sent to Tom, right?

Dario, as you already seem to have rebased nand-next recently, can you
please sent the changes to Tom for picking them up? As the merge window
is open at the moment it would be good to get it done soon. Thanks!

[1]
https://patchwork.ozlabs.org/project/uboot/patch/20230110115843.391630-1-frieder@fris.de/
[2]
https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/commits/nand-next/
