Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA56C4167D
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF8C86F8A;
	Mon,  6 Nov 2023 13:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DIyP+lal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558A2869DA; Mon,  6 Nov 2023 13:43:50 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF92867E2
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 13:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrx/9BRaexamCG4sfzXWmFfcTx3ZGCLi2GXNuAQVqMlIJ4sxsJVbiCQ+kdMZT4r8geAWCAaAGZGEoSJGwDYNGf9NSpHyV6lX+ytYr1tImSTny8WIEzGr7rULhlN7OIAGsF9GOHMqrDbSFNBQ9tjgSNu+0sNh24o+F28+ZkM7+QqCc23VTFgjr+n1d2ymP+y2FuLstLkxNGQJkeG38yihBh32l+PSt/luZv0CZKhvS+e4C8q4qabelnplIyHMMMElCJ+M8CGgNxcoiVn9GrhFZyZS46ubH/vlvsMVuTNj0DhORuGyEoh4brcjwcYnVQDOobuJvSJJeZVvzrjz1Cz4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRrZy20YS6Fm6JrW40gorh8KzgGawnKpzy8+XORmG4o=;
 b=NWjbBUDzMcT1S2cUtEqLptmfKslyFikI7DA7TEUHQHmzFRkRecdPESvVJMqubNooAEKvG/fC7KAEyG6I8KUBXcWIeq2Z9wkzTZEhNWl4N39G41tFelULKW7PdeOyI45ZNn4NzqJzQxTay0923qLPelFfn2Q4QsT8q+CTgu3eYjc7gt4WgrckvQvYarR9PWA5QHvLHB3YJImE7qJEKvbv25bf0sGQitOyitE+/E15cmibxA/SsYIElPIRpqyEGbvoZNhOgolNAUvoMGUr58oPX+4BLQzTzOLbUR/KZ5oYhr16A+RttSyfSkYsK7W6yY4urfDWDrDrqLAJhrc39WvJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRrZy20YS6Fm6JrW40gorh8KzgGawnKpzy8+XORmG4o=;
 b=DIyP+lalkTd2tzn5lyOzElUk2V4HmyRXY6nLn9MVBG+J456rYXJXXyyH4zYf4KR+qVn0jzi1XgyfE9ER5Bf5VExCB65FvL84myv6piRtkVkk5pdC0VFn41LJ7SRghRKDaDQ1VpSZj081pOQbu4rRD+hqidjWX1ZXdh3YQc5vOpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 12:43:42 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 12:43:42 +0000
Message-ID: <2e0bd77b-9b42-4407-ae07-87403e58910a@amd.com>
Date: Mon, 6 Nov 2023 13:43:40 +0100
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] arm64: versal-net: enable CONFIG_MMC_SDHCI_ADMA
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20231027030446.4009-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231027030446.4009-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0024.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: ca7ee161-1751-4810-31d2-08dbdec601ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u14ecV+4z+X7dmblSwdueZRX36s32gSNWjDgNEU3Wy4JxkdYxfKw4QvY1icOi4TID15EGbk0AjLPQV+2ZRBsOGBh5DeKPD2iQF5znsBrUG/M6bdPGn1q7Yee8KB0GJ+j/wuthsYnvD719RelRKiAa+7+FZ0F9kHZ2KWGYR6jew6tmRNPXy0gRW4UrLmEEr2RiYyFyEzNTsaNQouTe4JTSVBvfbfj8gS09+nOlFlAofWniT+v9Hu7e9SaL3y7qFhrQkno6UK8toc/GQgbFEsZuTAh4z6qWXkyPNqifGEZs3N7Vg7XiV8THTqlZdZVX5u4OJI/jseMiormT1gRHYq+YZMGjhCCP6wmopYOQzJtdzXjmWgdnp2Zo9IqwMLm/6jo0CLmkNOB1FpxNp0FD4Zg5nVlvn37uTnma/Y25LLsE7RJpQ2Sn4qQwtfC9CgIyUrOs+G8rk5CvjnEpTGPeFPdd+ifTYwjs+JwzpcXvaEg2Ao1tpEVkmv2nQ3sV9qzg7UVWxqZE89dvwBzBr8K0TayPCyNxgIlc8i1yIi5eX2I3f2gUuM8WSqx/Ctn6EPH8+vh4LRU0KSXzeNID7AMsRJ0M5P9FRFn21j6YSk1C47pPgeKBkbhWJE5Xo5Z4NX5yGCAF1ggSIFwGV8bUj73lfJmdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(53546011)(6506007)(6512007)(44832011)(4326008)(8676002)(6486002)(2906002)(26005)(478600001)(41300700001)(5660300002)(4744005)(8936002)(66946007)(66556008)(66476007)(316002)(31696002)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c21lSmxEUk1iZVJTSXNBbHA0b3QrL1FZM2F2bDc3clJkVHIwZFBsTjZPTDhN?=
 =?utf-8?B?dXltVFFQc3ZrdVNNNUlKWWpYN0haVkYzM25SS2JQMmNYdmt5UmFIUHB0VmVm?=
 =?utf-8?B?WXZKUEthUExRbjZMeVh4UWJLK0JDb01IZTc4UDBzK1psU1FUeGRSdVY2SHd4?=
 =?utf-8?B?NlJ6azRJOS8vRUFDVHg2RFRyZloxVlFvTTFIN2UvK3pnaTBvRmVLSlNteHVD?=
 =?utf-8?B?K3RJSHNhUFBBdGlLanNGVm5VNGZCSUd6bXZ2dVdNbU1oSkEyUlFvT2NBbXly?=
 =?utf-8?B?Z1Q2R0grbkdMb01RS2dMOWxCQ0JMVjBCTkE4WHhwWEJjNlVkVTJJa2ZrTDVn?=
 =?utf-8?B?VCttdEVMQXZiMmhFYUIyRGJYQnNESTV0OVBFdnNqaEZuNXh3TVM2UkRkb2w0?=
 =?utf-8?B?c05WQ25oZlozWjVKM3J2eFlCL0h1UUNTSHdRcDBQSDNqUmdaSFgzNk55ZFNj?=
 =?utf-8?B?L0xHTlJ4NWtTK1hIR0RVY3lDWlptVDVOR1JkNkgzTHc1MHpPOTFsc1dhdDZt?=
 =?utf-8?B?T1VFa1ZmTUFjanVSSWpwWFFEYW4ramlhWXVVOEltWVMrLzdlUE9MZVhjNmRx?=
 =?utf-8?B?SXN5Z1JxYm9NRERlUnRFbEhYYkVEM0JjcHdNSEppazBLbkl2Wmd4YzAwN1Fr?=
 =?utf-8?B?Z3ExUGdNemtiQ2IwZVNHSndpSDZsYjlsOUErSnZJYTI3SFI5aEpFNi9BR0dR?=
 =?utf-8?B?T1JhaTFmL3dtRGcxWXduSGRoUXFyTzUzakl3Q1BCVUg1SGFNcjhncFFwVHdU?=
 =?utf-8?B?WHY1d0ZTSnV5Vzl5UnptUjlIRWxKc3hPbUdFZ3B0NzFLMWRUK1ZmQUZ2aTlK?=
 =?utf-8?B?dG5MTlphQklReEJSUmdGTE45eWhnRWVMN0haeUczS1dLSkw3N054YXIybG5T?=
 =?utf-8?B?ZzlGMjdjWDNvTlo3c2JFakVYamQzTlVIYU9rblFkSU1NV1NPOHQ3b3E1M3pK?=
 =?utf-8?B?R21yaXhyN09TdFIwRUJ1RVNyeTc0aEpMQTlGMmhCWVRSVXJ0U1FlT2Y5QU1N?=
 =?utf-8?B?UXVxZWo4RjBScW1HOXRDSWw3eGdxaCtKTGFyL3FZQXlOb3p4M05EZ09iUndQ?=
 =?utf-8?B?VDR6Q1BrVkNNUzlXL3JmVi9mMjE5N0tFUUpmSDl5SnJ4bnJNZis1TGlLOEVR?=
 =?utf-8?B?RmlkQ0tHTGE4dUVRbXI2R1d6cFlTN0V2bm1ZcW80eWtFaFR6eEUxRkE2QWx1?=
 =?utf-8?B?Q2ZaNmU5VmpvZG9ETTV6U21SbFJOMnRyMm5HUjFGWHp1RG92L1NINGxjSjVn?=
 =?utf-8?B?U3BqM21maXMyRG5WMlEvby9HY2pCblVlTXZEK2xwYU1YQlRpNlZVN1pNei9o?=
 =?utf-8?B?eHNtbWZhY2l1TCtDWHRuWEhRTnMzNElPL0Jib3gvTVc5Skg1SUIwM1VTanNL?=
 =?utf-8?B?VVRzUlBHK1RtWWZaa1FQK3V1WklUY1V6MU5sUFlZVldadXVjbE1vZW1NdFdw?=
 =?utf-8?B?djA1L1E4UHhuejZvbHRUNUVpVXVKWXN2ZEZ2MXloektkV2pmVEFPTzd1YTF4?=
 =?utf-8?B?Mjg3ZUNobE11cW41cjBaWTBzOE1RbmM2QXBhYU5QUHI4cUhvcHJuR0hUSHhv?=
 =?utf-8?B?RDA1ekpxR3JOZElCL3BMa0hTZ3B3TkFhUG5lb0xLaUp6WUZZVktyVzZJNUxV?=
 =?utf-8?B?TjZQRm5hOXpPblNCUGl4dXBvcm05NWp6MzdVWVNXV2pqcTZWQWpILzNLTmRr?=
 =?utf-8?B?M2JZOG5MSVg0aGVVV2IxVVNhNWhnaTVjRWkxZk9YOGJqWDFadXQyT0Y4dFUr?=
 =?utf-8?B?bkl4alZzYTFTUUF1UE9lakhyaXpRUUFJUDBMY0p5VHhySlBhT3M5UUFsSnF2?=
 =?utf-8?B?a1JzM08wR1lIMEI1WmppUGRRNTk0VWlpTzhaVEMvRm5mNE9jK2dHUVlBTFJr?=
 =?utf-8?B?QmpwOGRja0hMTkgwVmRzUnZ1N1NjRmsxTW9tMDRSTU9Ob1B1aWdxVzR1aVNs?=
 =?utf-8?B?TmRQU2poNE50aGRWQVpzcThIbUt3UnNvT1ZoRDNyZ2hZUHpla3N1QlBxVHZ3?=
 =?utf-8?B?MHlzQU42d3ZmcHFibGdoNGxSSEtUT2F0OUwyOTlhU0RkenJtNXBidXkvOFFN?=
 =?utf-8?B?WElLaHVQbjd3L28zZk13czhFMDBSMWJOV2RrWGExK2VJU2o3UER4NzUrY0RS?=
 =?utf-8?Q?+OKRKKyAQKc4enQ7F2plCcBX4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7ee161-1751-4810-31d2-08dbdec601ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:43:42.0669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0B94kvg9w5r8XmRV2McB8y9+NhNhbs5qShasXBLP0rAeKZSnL8irK13YnD/rStR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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



On 10/27/23 05:04, Venkatesh Yadav Abbarapu wrote:
> The Standard Host Controller Interface (SDHCI) specification version
> 3.00 adds support for Advanced DMA (ADMA) for both 64 and 32 bit
> widths of DMA. This significantly improves read and write throughput.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index ccc9431ca8..0553ac6b17 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -85,6 +85,7 @@ CONFIG_MMC_IO_VOLTAGE=y
>   CONFIG_MMC_UHS_SUPPORT=y
>   CONFIG_MMC_HS400_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_MMC_SDHCI_ZYNQ=y
>   CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
>   CONFIG_MTD=y

Applied.
M

