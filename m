Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A97EDE987
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 06:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F15886A1D;
	Thu, 14 Sep 2023 08:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TmbvMVve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C498C86A40; Thu, 14 Sep 2023 08:49:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD69386A1C
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 08:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694674140; x=1726210140;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=YePM8ByZWUte4V0DQw3E3iXfw4yyeuB2W/SYx8Wwujc=;
 b=TmbvMVveNLS5ljPTGz3qAQh+PJnBE1QDq+j5r4TNkCw/VIs5JG0fJVOp
 4t/ZkdsjOPJVYeHtdjTtqQRiiRRg4aPdEK7rQ7vNFVH82v9ZyfBltprfz
 kNBG3UYiQICgdyDtskbVWaFI25+/+Gtg9cBRRw8y/zIY9M7K6hDROrsmP
 KvjAaIUEV5Nke60TtuR1uPTQ/tyfeX+OiJIcxo4L43G77JWHsGfqQeE00
 sgOmyG49zpC9h43gKGXig2rZ848uL/Gz7NbGqx4cCKf0ApMNglEg/KAYw
 ENrkyq9JmLUw+y9TRWzXFfggElJz2mT0yDxhz9/lu4+BP9/mDyhSLYQbC Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377779359"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="377779359"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 23:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779519376"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="779519376"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Sep 2023 23:48:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 23:48:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 23:48:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 23:48:55 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 23:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ix7Pisc7bsnrBxjone28wWzyEKHiWRehKEjRmnQ9IRk75NV6OKxanAGoo51f8C8B4ZpwJkLMMWIMaG0WQ13TdnvA9tQqONHsLH/lrf8dib2rQLbfZepOYqi6MLmaO4NJKjZlxaTDtFGu6opRBtLYCl3tQ8nCZ0Rp2d9h1WouPkTasCa+gMDItntIRtbYgXz+9L29vcjEeof18ODe3JH8uUqeQ9X44idD5ccd+0RIsjQS3x10EkOvBNHchonzaU6iYjZsTjN/e6KGOyPnuPLb4PO91Hb92uYaM64uChCFKQ3zwlKZEDbcBdAObkK+u0NRXkHWA+SZtKMJuPJRIGGsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndEbGl+btLTOijCXyCsqg8HY/Nf6u+O6UCB7R2DIE58=;
 b=Fa1CT6AN4Clbb8p+NaihE3mTmdxUh4J76K6DQxLCWMg7QGbk8hBYp7Ye1PsyNxAczMGSaWJB/5vxU5NKul9DvLZtR3Og4rgDtP4AAqoLThx0H6AviNjlVt3v17j3tMPnA5cj+L59wFM8ED4ReAqlz/6x3auVYYp19tWunbKbwAszZgEigg7VH8j93wY5H0bSi6YAQuGOAUiilHpLBPcJGnz9nk6LShlltsmEIt3lQ3wOPwvuZTf3S7vySbyYvJd6SVLKjj5UnoDT8LS5EUlzT7/yBt9YfPBBPbVurbaSiqV81c11QvsplDNNkfSARAkjGlZfAgJfGEcj3edvoW2iGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 06:48:48 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 06:48:47 +0000
Message-ID: <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
Date: Thu, 14 Sep 2023 14:48:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, <rick@andestech.com>,
 <ycliang@andestech.com>, <bmeng.cn@gmail.com>, <sjg@chromium.org>,
 <pali@kernel.org>, <u-boot@lists.denx.de>, <andrei.warkentin@intel.com>,
 <sunilvl@ventanamicro.com>
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::18)
 To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CY8PR11MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e0d6b5-6de5-4a8e-5de3-08dbb4eea53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGIj8O20iWXFyXXSru5YC6jwTzqTbRungyNzjcoEOS51Jp45GqwJoWNWslPfn0nSvdZMSLs5Dd0kkb17CRIcBBiHBxK+hrZpFoI+ScP4FU3PsxnOCIxuVihtlqarxySvz+tRHUxsczhZklOoEfdy57ypahNfxfxXzBYuEWzU+k/aAtGWYiUucH2K8tSsIZWI/4DUqRVKnhO4Rpr5uVJ1rvhqdgAGIHx+wbam93A/09mU354KY3Bcitl0JsHn2wOFT/MDBpPPrUVkjAkCQz69Nt/TDRmpxSN+5sNSuTjRCMW3cevpkZBEaoA/UKoQ9t7NWFyT14hHSqeqBIns12LU3/OKNN/lek1Na2bq0zVnp+7lupI9hmp/AZJGpr11cyvgO+KejJFUfsrGEBc4DD8gNAUg+HipBg4o76UgSbWDgyV71liPvnalNdydN3i2RRRfkcWoG4N4Ox3quPzjtYsxWUafM2Asgx/OqG89mz69uHaz3Nvj0j3hu6oonm/w77w9JJPK32TBhr3OEnw2bOs9u2yFUTH9n3TjJ10OMF7omszcVVRuAgItFn3lTwVzqhpVEXTh2ybM04ORUCVuqwqfYQ1I1uhpIZNiwLdw2nyrsklcrqPdQjCcM8WR+cPAtxL1Ez8fOHC/eniN+Nu0cyr42g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(31686004)(6506007)(6486002)(53546011)(6666004)(478600001)(6512007)(82960400001)(38100700002)(2906002)(2616005)(83380400001)(26005)(31696002)(36756003)(86362001)(316002)(41300700001)(66476007)(66556008)(66946007)(8676002)(8936002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVMrT01lVTdSVzEyMzNmUExCL0FXZjZjVm51S0RzY0NNSlZNTlhHbWxSRVVP?=
 =?utf-8?B?bWx1UFVJQTN5WllBMUNWMk5JZG5TOXkzQy9CL0lEb3hBUFN6UzVLaHNsbXpX?=
 =?utf-8?B?R2R4OVdXbEpWM3FhVHN2WUxaMjRNVlRpWnZKWHBEN3ROOUJWR2s3cFVudGZ1?=
 =?utf-8?B?dTRYUW9vN0xEcFZjR3E0YkRoRDdwa1ZRR0ZlWWlrUjNwWnp2aVJJQzkzWUR1?=
 =?utf-8?B?MU95bDVFZzJldU5oWWVOL0RhVnBHTzJwMXRYQm12OFB3NXN3UWdscHVWL0JF?=
 =?utf-8?B?Q2hVcHl2cEtkUHVZZUZHSFQ1ZzNzWXdZanZVSDhIUDFBaUo4V2JhSGptZU4z?=
 =?utf-8?B?TTh0K0lBVVB6akw5MGNSQnRIa1BjYSsydEIrazh1NGJUN0dnL2VZcXJqZC9Y?=
 =?utf-8?B?czZ0cWsrSDFURkgxUWZMa1lFNlNzUC82eWxUU3M2djNwTzY0SEVLdVM2bHJ3?=
 =?utf-8?B?d2ZNeFZtN0ppczRWZkE3U1REaDJaclJ2VUhYTkxkaGtoZ1B3cll6dmxuaFlV?=
 =?utf-8?B?OUYrTkM0dnFTdWUrWVFMVklBZDZPdVJzbERJRG15OUNySDNKQ0YzYmtyUzI0?=
 =?utf-8?B?YnMxN0kzWE43SUNYZmFlenRISnZxUzdyNkN2aHlCZ1dTbG5wbVRDVmVIajlL?=
 =?utf-8?B?c0c5cWxaRUNhTzlEbml4aXArRzNJTnZFc2lEenkxWVhSNU9aQzQrdSttRVBt?=
 =?utf-8?B?NGMxZWhob3BSM3FGZlhMZXI5WHYwV3IzYkNNY0dLUFdkTnFOdUtkaVJBV0Za?=
 =?utf-8?B?ejlNUGpZd1RmejV5NWliYlc5UlAzL3NaTEd0d2ZSblRQZ0xhRGJxb3lLVHZz?=
 =?utf-8?B?N1FVQzdPSHdHRFhUL3lUVGNwVFpTU1AzSmZNbjVhR05pNlJMN2NNRVplbEo3?=
 =?utf-8?B?citsMGJoODlkd0g1WFM3S053MEoxb3NBV3FYbXFKOHliYWtkRm9WVkNMNERP?=
 =?utf-8?B?dSt4bG1KYWdGVDV3NVNSZUd5aVMyMytvNE9PZ0Z3ZzhpaEJyazRTK25hNnQw?=
 =?utf-8?B?ektYU0xPWTd6c0s1V3JXeGRrVGNHYmxPSGNua3pPcWludUZVSzZERWJBZUZU?=
 =?utf-8?B?L01KNnBiUUFGOW9rZUdGUWNVUGR5ZmF3cVdSdFVPTjE5RXNVSzJWWHNKcm5G?=
 =?utf-8?B?empSRmhwbGVsS0NGWmhXU3BvM3hEYXk1RVlhaFIwVGttbzBKckZFdlNsK0Jl?=
 =?utf-8?B?OHRGMTdsY0tBSUZ6TUQySFBwdkduQmlrc2FOenA1bG56TVkxL0tQa3FtcWFk?=
 =?utf-8?B?ZVprWXZqdm40L1dqSVNUZjh4QVJXTDRobmNSenBCbEpoZzdKcGtyY2ltRmtr?=
 =?utf-8?B?cUpGeXRnQi9wMXJkZWphREtISHpLc1J3T0JWczc0QlpuSUhrRGVsUW1lYU45?=
 =?utf-8?B?ajdJeisvSy9jZ0RWdVNyQlNVTXhob2N6MUxFLzlJMTM2QWdtamdBUDdxNUZu?=
 =?utf-8?B?cWhwUDByTmdqWEEyRnFWMSswcFloSmJJUXdEWEdFWVhocVdmNk9aUDFwWkNp?=
 =?utf-8?B?YmNuOGZTYjBmQ1NaYXYxcENXYWlUQzdMeXUwSm5leWdsUHRheWRQc1d4MDhZ?=
 =?utf-8?B?Z2w3UFlDcElQN1ZLWjhiWm1EN1VSM3pSVS9MdUxEdUVXMlpVZmQwSjhvQkZB?=
 =?utf-8?B?VHN5bEN0N1hFdDdkTTE2c2pWZzlTZG1qNnpsS0t4UVdXNWpEYmVXZEd3RVJh?=
 =?utf-8?B?ZXUwYmtRbVhUSytsalpHZGFCSlEraGZJRXJCMjQySlF4RXpJVmMwSW1OTGx1?=
 =?utf-8?B?b0NrWjZSVURacjRDT1k1STB6NkxMT2FVY1YwUElUbHdua1A3NzlyRmJVVi91?=
 =?utf-8?B?enN5NVdDUmhvaHVJMWM5RHVJalFYUmJUekdSKzg1RXNrNHdlanhEck1jNm1F?=
 =?utf-8?B?ZytGUGYyUUMybHpBVW5FY29MaWxvUEZHTHhSZDNKKzBFTGt3VzFpNWZzZnph?=
 =?utf-8?B?c2pxSjZmMEViNVRaOEQ2czZFSXhjbU9qeFRiQnArNVNJY05ZMytweDkwbDBZ?=
 =?utf-8?B?SytQb2s4Y0VtY3lIZFgvN3RQaExNaGllNHVHMUlvWmo1VmFqREh0OWFydGxo?=
 =?utf-8?B?YWNaK1BFWUg3ZVFwU3k0YmVRaDQya3UxRVY1VzJIZWl5V2Q4M0srN0Nab0NK?=
 =?utf-8?Q?brsowFYxj33ectEg5qIrgzjay?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e0d6b5-6de5-4a8e-5de3-08dbb4eea53b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 06:48:47.2983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3cy6uUAPaHfj4XnJUR9AN9296EA4l1B7TXyspMT1OOp7xjX9wCxeB+O079Cc3d6ezx/AK/sCD+xHXJi3vReUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com
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

On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
> 
> 
> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu <fei2.wu@intel.com>:
>> In order to enable PCIe passthrough on qemu riscv, the physical memory
>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
> 
> This should move to 7GiB - 1 in your example on riscv64.
> 
I'm describing the current implementation of board_get_usable_ram_top()
in ./arch/riscv/cpu/generic/dram.c. Do you mean this function should be
changed? Is the comment about 32bit DMA device still valid?

phys_size_t board_get_usable_ram_top(phys_size_t total_size)
{
        /*
         * Ensure that we run from first 4GB so that all
         * addresses used by U-Boot are 32bit addresses.
         *
         * This in-turn ensures that 32bit DMA capable
         * devices work fine because DMA mapping APIs will
         * provide 32bit DMA addresses only.
         */
        if (gd->ram_top >= SZ_4G)
                return SZ_4G - 1;

        return gd->ram_top;
}

>> board_get_usable_ram_top(), but that address is not backed by ram. This
>> patch selects the lowest range instead.
>>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> ---
>> arch/riscv/cpu/generic/dram.c        | 2 +-
>> configs/qemu-riscv64_defconfig       | 2 +-
>> configs/qemu-riscv64_smode_defconfig | 2 +-
>> configs/qemu-riscv64_spl_defconfig   | 2 +-
>> 4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
>> index 44e11bd56c..fb53a57b4e 100644
>> --- a/arch/riscv/cpu/generic/dram.c
>> +++ b/arch/riscv/cpu/generic/dram.c
>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>
>> int dram_init(void)
>> {
>> -	return fdtdec_setup_mem_size_base();
>> +	return fdtdec_setup_mem_size_base_lowest();
> 
> Linaro is working on allowing to download a distro image via https and installing from a RAM disk.
> 
> We should not artificially reduce the RAM size available for U-Boot by restricting ourselfs to 1 GiB.
> 
> We must ensure that ram top is in the upper range.
> 
How do they handle the case of >4GB? board_get_usable_ram_top() attached
above always returns <4GB. And it seems like
fdtdec_setup_mem_size_base() cannot ensure the upper one is picked, it
just picks up one, but which one is selected depending on fdt.

Thanks,
Fei.

> Best regards
> 
> Heinrich
> 
>> }
>>
>> int dram_init_banksize(void)
>> diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
>> index 9a8bbef192..aa55317d26 100644
>> --- a/configs/qemu-riscv64_defconfig
>> +++ b/configs/qemu-riscv64_defconfig
>> @@ -1,6 +1,6 @@
>> CONFIG_RISCV=y
>> CONFIG_SYS_MALLOC_LEN=0x800000
>> -CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_NR_DRAM_BANKS=2
>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>> CONFIG_ENV_SIZE=0x20000
>> diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
>> index 1d0f021ade..de08a49dab 100644
>> --- a/configs/qemu-riscv64_smode_defconfig
>> +++ b/configs/qemu-riscv64_smode_defconfig
>> @@ -1,6 +1,6 @@
>> CONFIG_RISCV=y
>> CONFIG_SYS_MALLOC_LEN=0x800000
>> -CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_NR_DRAM_BANKS=2
>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>> CONFIG_ENV_SIZE=0x20000
>> diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
>> index bb10145e6e..66dc2a1dd9 100644
>> --- a/configs/qemu-riscv64_spl_defconfig
>> +++ b/configs/qemu-riscv64_spl_defconfig
>> @@ -1,6 +1,6 @@
>> CONFIG_RISCV=y
>> CONFIG_SYS_MALLOC_LEN=0x800000
>> -CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_NR_DRAM_BANKS=2
>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>> CONFIG_ENV_SIZE=0x20000

