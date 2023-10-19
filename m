Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39202CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD1FA86FFA;
	Thu, 19 Oct 2023 12:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gii3ttL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2551871E4; Thu, 19 Oct 2023 12:31:18 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C05C286F8B
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRrHmRhgLfGtfWzQfiHRDwj6KAl2B85cYP0nj9N4CjXgqV/MI2+hmW9q8ilRnbUE9aB/6eUvitBk1oACQ9v2w/OttLHnbYm714gfQy2Gz5DmMc+XMVHpFrUsmwJLmxLj/d7LWMHmIRm4deMsMYA7RBem/TOFoJMvPC3HdQmslmfZvo1zJhC6lyPJFQXAyMJ6PJ2VcCsaz7Tb/WvbYUPL0a8E1uHtFdKqqXKgQKvDRGlhlvO45DP9DhVBMZhN2eg8nFjW3uI3qRD8FDiv+uLyWMjVPmJEvmjtZ3EuEg3obV5EOUFauJSHo6+ZRYLqDNjHCoBsz6CV11CdHRXlDlqVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTkWJCeJx0Z92DynbUSAh/Q0jxNQOlzNH1/mf+2y2nQ=;
 b=hO1r9c9T6wm/oIVyGdxRyJJkhZL2PD4XY+IYoq3lly/GKS/qtV9Hees+4WzBj4TCcMn7NJsVIyOgcfQdRg82QLa1BKOMB3FLjiH3/qs6SUZ/obnwfOlsxxbj2GZS9lzL8FFoDB4S9Y3QQbtOFCfi1eMGuFnQSYYZPV8nB1Oyz4JH+mZ9vPGz/VoK+fTXgh+C8ivaxcuzwjhQ/bzzWfSoileJBQo5yDshi5C3MHZ58eyNnPE/ghl+6NGGxXGXQJv/t3HHx5qJlIl6zAFa0vN1jgonct2WPSGrQIl1o0TyfRD2vZ5OuRyd3aWXH9km9Ta2JwbPgYHKGsbClwKum6w7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTkWJCeJx0Z92DynbUSAh/Q0jxNQOlzNH1/mf+2y2nQ=;
 b=Gii3ttL52aOJFsf7EIglwrQvpNljOuWcNhQ2PO+gKKzzg9lcXcIpAoO1oEV+0fSfhVsafwEhGP0PVWfHOSrJavNrUmw+OSbrm1jg32N50+aqrjRcr+qEacqM7Cn1MhVWJ1wUJ794SRSOpe3NqWvECvhBYP1rpBrKNe6JUp+Y2fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:31:14 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:31:14 +0000
Message-ID: <0cc5eeea-5717-470e-854c-636b80378fff@amd.com>
Date: Thu, 19 Oct 2023 12:31:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add spi flash lock option
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, git@xilinx.com
References: <20231003031715.5343-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231003031715.5343-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 8835be88-f627-47db-89ec-08dbd08e8516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1whD20wtQtkhdBxZj8yMSbni7w0BYOxV3QPwRufhwauSF5m0LhEjUAQQP7gsspocyIcv4J9xgRAxYi63Sqm/evD1YKJNiSMNPVwUcEwTgO0ha1r6uJbJztXbFhh6PM41cRwrYnDnw0Lc/WOMVLRBv2d0ZNNEstY77zH2Qb6WIUYb11fgL6U+3Ly/9Y5wgTt0rxAMVne534vvaDTRRACHNlCMct78tyXE1/f+C1fA/s5clzB8RwX/8pyf6gIl4Cib2sIR8UYYpwFFRBiXE0p/T0b8VQMVJFp3mRBRQ6DIRZwWF4wqPVIw/jtAHtEbVX92S6t9Dk73q8lJscyYi4HCGQDl8JVlj19CCPPjedRfgOvoY4kG+9dvSx4XDQyyta6ULr7GQuBntqFBaaHepcHzrI5Q8ci1YofpUgdxU6TjKXJiWm24WtIKiYeR//X2gLw/KsxB4RR2PJDMAAvTu2gIVdeKb+2oHaVlBw6DtVzdKTEk/ahOjq5bX1jUHNoEV6RkI7Gm2orHgIVgoto4wsX+tndegCFCMnA03celtWmSubdfY6SPBdoyqhsgr3Uaa7no4kIOuM5G6hO1Dbw3UmmSGyRoZaThIZI5eOUKuug2AedkKERoWPZJf7viYjHYjDS9F8jkjEC09ueZBonnRtJnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4744005)(36756003)(4326008)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUc3Rm8rVEsrVFpkbW1FWGhMMkR3bTM0TUludXhYaWlFMUlUaEh2a1VSSEhL?=
 =?utf-8?B?Z3NqUVozS0J5ekZvZk9YYWN1R1l2MjloeTNBK3I0QzFscTZ4RVZYYmNld1I3?=
 =?utf-8?B?d0IzbUtRSTJEaVpmUEZOeEpUQ1BGc1N6M0JLMGdSRkxYSkNCSk00b1NSbjdm?=
 =?utf-8?B?b2hFOW9UMTczNE5FQVFMdWtaeUU4dEhZK1VXdEN4Q1FiTC9YSEJ5QTZrVng4?=
 =?utf-8?B?dVdmd08zN1VCWDJjV1RSdkw0RS9DN3BodmVJMGFxTHk1L2NEeVpSbTFWM04z?=
 =?utf-8?B?anNDak5uRFdraXhyQVJKWFd6SDlnRDhRVFdJUExsNHM0ZzIrWXdOekVGTlh4?=
 =?utf-8?B?djVteXgvS21LY3duS25kclpEWnlVNW5zQ3VDMFJCZkc5MEwwUGY0NHRQVzNQ?=
 =?utf-8?B?UlJ3YXQ2MzA1Rkp3SmFWTFVQNENZb3ZoQkFqdzZtZlkveVROZGNTNVFIMHd3?=
 =?utf-8?B?R010aHNZRzhGY2UrRGVOQTJzNHcrU3AwSDhhdmVzTlpxb3FySGJNV29ZdWdp?=
 =?utf-8?B?L3BQWDF3WkgreTlZSnZqdVhpSWtDT1JUdnJzTWVMeGQ1UThuUG12T1RzZ2dX?=
 =?utf-8?B?bGJHRU10a3k3ZXB4aUQwbFphYnYrYVN0VHJiOXA3WDZ6M3Q3czIyUXdEcEhG?=
 =?utf-8?B?T2wweDJOYkd6R2p3MnI5Z3pJdGNoQlI1ZllsNGdyU2tBOC9oMFI1RjhNMllU?=
 =?utf-8?B?NGpMYWJ1YUhyL2tYdFBwdTlFL2thMzJQZ0dPOHZ3SHc2MjFTN0FmRk94SU5n?=
 =?utf-8?B?c0RtWWx1SnhwVEJQa3JxRVA0eTNUSXFwWEwzS1hSY095TDEyR1lkdXRYVExL?=
 =?utf-8?B?ZmlkWkt3cWVLSFBYK2c2YjVZeVhRYVF1RkM5cUI3ZklwZUtrVVVQOHM1dy9p?=
 =?utf-8?B?aHNWZ2xwY05xMGdQbTEvSm1xTTdmdlVHejlvT1I1TEw0SndiNU5Nc0g1TWdK?=
 =?utf-8?B?MGJGWHdua0lueUhEOE9Cb0pLUk1tSEZla3I4OWNkQlJ0RC9QbFRieGtiRFV4?=
 =?utf-8?B?S3pvTzNWMW9aSEg4L1NxRTMycS9BbXBYcVpoSU56bUxYanJySG9qVnhVejFo?=
 =?utf-8?B?eVZQalM3a0hqTk1qMEUyWDRDZ0xqQUxKRHNVZnB2NlM5SmpILzUzOTRlM0Jx?=
 =?utf-8?B?UVNHblpEVThka0xKR1N2N1I0ZkNaVFdueDJBUERkRzdOQ29pYjFBL2J1WDA2?=
 =?utf-8?B?YUlxZ2lKa1Y1WUVmMlpoU0lLL0ZjQlhXQ0h0cVZYVFc1S1FmSGJiNjR3Yzl5?=
 =?utf-8?B?QmwvSlFHR2RMR3pxZ2hPUkNnOVVnQmFSTW9CbFdFMDEzZlJZbDJySjNRa2VB?=
 =?utf-8?B?MzNqYjZEbGJOd1FmMWlPYTlmbmFLZDRTelpNVHlzSUVmYkdCSCtBK09aOTEy?=
 =?utf-8?B?RFI2aU9mVnNLeTZ5R2VMMHlPY1QrT1dpcEZIUFM0RWp3SXA0RGlnbE53R2R1?=
 =?utf-8?B?d09veUd2QnBob1I2cjNXYlg1d2lTK01hcDFQY1htS3ZxSnk5U1I5UVhqdDNq?=
 =?utf-8?B?STlHTnMwWHZVUjZ5K2FldkFuOFFMc0RlZmIzdncxdHN5RGdzSytPbEVKVHgx?=
 =?utf-8?B?YXdOOCtPSVA2UXh2dFYvTjdTVU9zNFVTb0NjQTRobjVvYXpGMm0wb1VlT001?=
 =?utf-8?B?VTlJZjRNTzVjREEwZThDcjVRbHlrL0owMVRrSWVXTWxWYVNzMVVqWHJTaWVo?=
 =?utf-8?B?MitzRVF5bFV5Yk9lOG1hVkR2SlM3SnB5ZDBhaS90ci92QmNzdVllL3l4dzFr?=
 =?utf-8?B?U3FDQ1JlbHpaNE5HQUNtUTI5NFFrS3hyU05pVDBLZHNtMzdqNnVkclljR0dE?=
 =?utf-8?B?REZrK3dXWDFYQnFYeFR5RmcwdTV3bDZJYnB3TjJPS1ltUjZFUUNkZWNkWFd4?=
 =?utf-8?B?dmJ4cjZ0SmNzMldlQjlFZW92V1d0WldjenZMcFc1cTVCcXltMkhMVEZZWlZB?=
 =?utf-8?B?aWJBM21HR29wVTI1K21UaHhpM2ZWUW1ycURpRXN2YmJJL0J6ZnFXcmh0QmNK?=
 =?utf-8?B?a1VrNFFCLy8rM2p1VzNrMkZER2hudytNcVlVbnpITkpiT3VET2xCaE5wcmpO?=
 =?utf-8?B?M205ZEdkUTk0dDBlQmxXbkFzSVFtNnF4c2tVZUlPLzlkYm9wRHkvSzZjTktY?=
 =?utf-8?Q?KB3O5pohDrOvfkpEsE06NW+Oz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8835be88-f627-47db-89ec-08dbd08e8516
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:31:14.2494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Pip95hGH+AaflZSqggLs7LHxqFw1GbB08asPrH9Fl+xPFUQF0tW9f9H1IZNiJzK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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



On 10/3/23 05:17, Venkatesh Yadav Abbarapu wrote:
> Disabling the flash lock option for versal and versal-net mini ospi
> and qspi defconfigs.
> 
> Changes in v2:
> - Updated the commit message.
> - Added SPI_FLASH_LOCK in cmd/sf.c, so when disabling this option
>    "sf protect" commands wont appear to users.
> 
> Venkatesh Yadav Abbarapu (3):
>    mtd: spi-nor: Add spi flash lock config option
>    arm64: versal: Disable the lock option for mini ospi and qspi
>    arm64: versal_net: Disable the lock option for mini ospi and qspi
> 
>   cmd/sf.c                                      | 4 +++-
>   configs/xilinx_versal_mini_ospi_defconfig     | 3 ++-
>   configs/xilinx_versal_mini_qspi_defconfig     | 3 ++-
>   configs/xilinx_versal_net_mini_ospi_defconfig | 3 ++-
>   configs/xilinx_versal_net_mini_qspi_defconfig | 3 ++-
>   drivers/mtd/spi/Kconfig                       | 7 +++++++
>   drivers/mtd/spi/spi-nor-core.c                | 8 +++++++-
>   7 files changed, 25 insertions(+), 6 deletions(-)
> 

Applied.
M
