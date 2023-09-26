Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC320E7D248
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E92E086BCE;
	Tue, 26 Sep 2023 09:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="H9US9sSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8827A86BEB; Tue, 26 Sep 2023 09:46:34 +0200 (CEST)
Received: from mgamail.intel.com (unknown [198.175.65.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D8086B70
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695714392; x=1727250392;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OnzvIo0raAIhy3fuUwFYnow04kunM2KLlL92JhUfipc=;
 b=H9US9sSJTmNAMaAu6rJX/rc52675RFG6jrQqkq2UMsnbHh4NIDe7udoD
 g2ak3eaJpq83R3KqLrd+bgd/5QXIoL6kI2CQyrUo8bwY71Ci/+uNWaEdc
 OqmBO06HwwR4VqdWt2OPyZjGPuidt0v8TXBq3LQZerUGzKrqd2PKhFDrv
 4siaoaDEiFHW1ryWdnO/1jsPHGnZIRaZdqWO+EJB2nyeHgZMCpiO1yLcr
 0WhM6YQN5vP4NSjnzR6fASVsadg7Mrvr69nNMDEIif3T6sSXAHf7Zjw1p
 73RPc8ij5ORhvvJ9lOXqvNhp2uRSOGhmgksm7aYINJoZQf7+QQ7e+1X0E Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="154513"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="154513"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 00:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="1079614105"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="1079614105"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Sep 2023 00:46:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 00:46:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 00:46:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 00:46:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 00:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tqy8OBIgpQj41hN7SoMrQ2P0iwJwWYxRIo4nscNrjItotUeIWk6yLm88i45NgKRqZP09NvILVy7qzGe6/em2eHWVWeclYwG/jcLkDW48gLzc0bMX6CSGoXUadt71ymZ4txL96nIXEPtxmOjGwCSDw0k3jFbLDnGS02GnckORKWCv2IXflh2xIJe6OqyACkN5IJtyzxVyVvvl7/2P64u9Vkva9D69SeLwVLtbSmCBKs2WReFhObtsHT9PcGrT/Bo8NedTlimAHHP5bRvQEcgEe+D8KthxD7tKn6uP0oeuAE6JX4Ghq0ggxtnUeDNV/V+TxREecGitVoJ524l+fN/kgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZGDote/J6VBnFJa2ZwXiJpuT/GESV7iJFMhfW71rU4=;
 b=F+Rf3BtpVR2/pyGL8QsowLx9RWHdpLavoVDWMKZEaPWjxoq5Yjy9k0V49KjjfAcxnL6MffuxlIfE6A7z/C6uBWmZVd5yrwJ0sXEE/bohaPwx0rtdIS7xTlcRSYL/pIQy0UC5dXx4kfXkNbbmIixyVdCqRr+IFS9XRClZJIC3xBsAHIywtOs1VlxEyzR2AncU0/D7dyYtFjqRfGttcDxiwVdS0ooi7zXLX5//2CsjJqrYfKSfUP5qAkyCAHBNArAuYcVmbXItue8zZ6w20dzNTXytvVzYdoKHt+7CbCIstzJo79C/Rh5LxcQ2QWelCtNZ5mAq/Lg3xBfDzUeKHEZ4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB4511.namprd11.prod.outlook.com (2603:10b6:208:189::18)
 by PH0PR11MB5950.namprd11.prod.outlook.com (2603:10b6:510:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 26 Sep
 2023 07:46:26 +0000
Received: from MN2PR11MB4511.namprd11.prod.outlook.com
 ([fe80::b88e:70d1:efe3:2716]) by MN2PR11MB4511.namprd11.prod.outlook.com
 ([fe80::b88e:70d1:efe3:2716%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 07:46:26 +0000
Message-ID: <fcc91051-81c5-7b0f-fd93-d971200e5c2d@intel.com>
Date: Tue, 26 Sep 2023 15:46:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] riscv: remove dram_init_banksize()
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>
CC: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 <u-boot@lists.denx.de>
References: <20230926071634.22016-1-heinrich.schuchardt@canonical.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20230926071634.22016-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To MN2PR11MB4511.namprd11.prod.outlook.com
 (2603:10b6:208:189::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB4511:EE_|PH0PR11MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e12bb7-d44a-45a4-629d-08dbbe64af47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzx+piEqoMW+eeINjmDO6vvNunIx80F3SEG7w3vg4y6BXrlSCRaBPNK6D2vXoSrjf+gmkEUwRADnlzutUe/jg3MQA2BEzLOVWR06s8fDghZcHMeOYcZxtwiBUgSZB3ts3J3wIJldoxteOKlwsYaN/XOlHRDizd6aEUChYguUPEvtxJUagENa7Qns89shdZe4dMtXAf837xb2pK4gKDnfsAmCpSHAH5wd7fKQ3yN6Octer6+gFtoYUSGfxgB/LeEQyLUB8KtCCzFwcesCO92AWb87ezKpb3u5K0GXGv4mYVl0xWvuzCE91pTACoiU0z7UvA6snTJ4hGBT69U2KiOLoYW42QUluwkbOX0hsqgd4bnR67xomKVuueZJ+Ls7+N/Z5OQrQN8HfOP4FEs0KRyTK0Jr0eqyDhOZQmcqfI173b86cHXl52Ct1MPszAfztAkMn+D+Zj7zk8Gd8RaPkn8KiugBoEMT+uOEqibvUTtV8DgP4Jg9WREZULbgoBeVJHNVoKryCHBxYqfFJ8Vhl+bJupWYoheU35sWSPAcN8Oe33oV7mkEcb3VmqIOaylAn1xIS16M3OEqCT3o/NkbLoV0zH3KQcZMOdcat1bZNpaoV75PKcOIELOMG2fmplpVfQXl+MF9p3g6f2kOtGzjjkXCvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR11MB4511.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(82960400001)(38100700002)(966005)(6666004)(478600001)(4326008)(8676002)(41300700001)(8936002)(5660300002)(316002)(110136005)(66946007)(66556008)(31686004)(66476007)(26005)(2906002)(86362001)(54906003)(2616005)(31696002)(6486002)(83380400001)(6506007)(6512007)(36756003)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNSUWlmc3QwNENoa2JZNzIxYnAwbUZ1dDVONkluL2pBeWhLZFpOQUpkTDA4?=
 =?utf-8?B?VHhFbjNrZW5oUHhqZzNTSUVFYnM4ZHFxbUd6VmdNQVByczhhbkVvREdUcHFE?=
 =?utf-8?B?ZXZlUGFjQlQ4bXdOQ3lmUTB5cjBsZVdJVzdPNjVuaEJlNkszZnFtVlVRc2F4?=
 =?utf-8?B?RGtmSlhNK25pV2UxQldSdWRtR0ZyYUtrL0RSQXpUSk1ycVZBVnAzNmUvNHp3?=
 =?utf-8?B?eG1LR2s1RmVDdG5UajBZb3FlUXZVeEg4OElzSEQwZE12L0MydzArK3lCMVVt?=
 =?utf-8?B?blNHalhxdlE4Yys4SFM0U2pEaER1WXEyUmZyQkRlNEZraGRvNm0vYktKR1dP?=
 =?utf-8?B?bDhDbkU0ODkwVE03VWN5ZFN6K0hXRnUyQy9YL1hIVGpsZ280ek5CNmNlNXJG?=
 =?utf-8?B?aDdJQlJLYk1mTlRIVmxnUTc4Tm9pQUhNV0VHaHdIb2FyOUQ1d3pZUFF1N21Y?=
 =?utf-8?B?dE5meWt2ajdqNmR6ZjNCemcvZkNDRkk5YXE0VC9kOXM0bVJ3SVVqbXpWVGZ4?=
 =?utf-8?B?VFZrNXhlbFE3NlZ1S29Db0lET2czVVhHSnlPSUZjZ0RYY0g0bjluS0FEcExP?=
 =?utf-8?B?TXRJT3BKUktIZlkyYmU5SzdPREliQTZmVHRucXpwNkcxSW1FSGZ6enk2ZWdo?=
 =?utf-8?B?dnozRkpTWGwzSEtqTkNOMWhud2hiTGVESGlWdHpPZW5QUHBPem5lclNsWkcr?=
 =?utf-8?B?SzZubGRoK0dNVnJ0REJ3dGZ2UlB6VGNpellIdG9yNmhJV05odWlZRmt2WXlU?=
 =?utf-8?B?LzQ4VE1LYTlQV0d2VGF4UXh6SkQ3T01TeDdvemd6d25kTjM4SUV5RUM1MnV6?=
 =?utf-8?B?WkUxcVFodE9hTHlEa3pRQXprKzJBNnNLTCtEeDRDRVZXeVhVczNUd1NDQ0hS?=
 =?utf-8?B?elJaM3NIcVNKUndKMHE2NXRoYWNnRkt2ckQreE41QnZkL0dqL21kQTh1UmFp?=
 =?utf-8?B?ejl2QlFFWmovQnlxS1NrREhMWXhKbFVQeld0Y2xJNGtCaVhOa01EcXZMYjlq?=
 =?utf-8?B?Yy9EWnNnZWR1TTVHbzhXS2FRMEhjR2xFc3ZrWG1rdmMvZ0lJODhsY0d5YXRY?=
 =?utf-8?B?UkRPSVNIemtlYXZqSXRxb1dhV0JIUzhVaG5xbEdpNzRUa2lsNWhOSitoUkFZ?=
 =?utf-8?B?MjhLZERhWTEzMkJockFNOVlucUxnWm95NFJ1RDFVb3ErWkJwSmNiRjdVVjh4?=
 =?utf-8?B?V2huNlhrWTBPQzJTSDZ0dytxQVhyZHduWTB3YjFWK0JEd2Z2UThnZHV0Q2g1?=
 =?utf-8?B?RVhkbmZ3MU1HWENjOGxsb2gzWFkyM01NNzVEb3lkYlhucXFKZTVHZGFkbkQ4?=
 =?utf-8?B?a1lGRkxLVUhLY3NIcjIvN3g2MDdZekVWeHd0TzhwNXJpY0s3MlpvM1RjNzJY?=
 =?utf-8?B?U1VYeGY3bUxBN1RwWVV0UDNnNFMyY2hPeHltemNKd0RyU3VBMjFmUWs2MDdr?=
 =?utf-8?B?SFprM09nZTV1M043QkNqS1VPUlZrTDF5eU5hZjJJUVp0UVNXbk1FNGZ4VjlC?=
 =?utf-8?B?TzZhY2RQL2kvaEFJU3RhRmR6NEhMRG1neGFabG9aVnNzVm93T3ZySmdiRmtl?=
 =?utf-8?B?TjRRZkl3cm5RTEN3Y01xUWhlSlVmMGhaYVlFa05nQUhmb1RSRk9OWVc5UW5W?=
 =?utf-8?B?bzZuYzhYWC9DZmNEaGQwaDR1VmNVSDBBeVl2QzJZU2NDNTByWTB3bTdhTTIx?=
 =?utf-8?B?Vk1GSWU2L1BmWUZSUE9FdmpUdlg2M2kyRzgrT0VrSVI1RDZsYmgwYmlnMHV2?=
 =?utf-8?B?eFVCVmlUWmoydytIZVQ3VTVuUllTZWpHZFc0bDgwR3dlZVVHYjJNTW5FSm9u?=
 =?utf-8?B?NlVNWjN3OEtRak56V2xPNkkreWpEY2VFa0FENC9VQnFSZk9jYi96cXBDSkQ1?=
 =?utf-8?B?TVZpZUV4bm9aUVFaOUEvRTJpWDRFNEFvUllTZVNwRzVMTFdDWDlQR0h1elFQ?=
 =?utf-8?B?Y2xja0VxTkRqMjR3aHZOTExtVHdsTFU5ZTBBU3pYWmQyQlIxMVQ4elR5RnBB?=
 =?utf-8?B?alBjS0FNeFpQODk4K2haZjdka0Fjb2dXRXFFTHh2d3JQdytONGR0U2lXZWNt?=
 =?utf-8?B?UXpURDN2dnlaN3c5cS9WaWc5UWpHQU5vWnY0cWh3bEdoTHdEejBYSWpRaEM1?=
 =?utf-8?Q?KFYnU3poop7R3nKvh8DpKSk1P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e12bb7-d44a-45a4-629d-08dbbe64af47
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4511.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 07:46:25.3073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgUVPw/4ZwZNXou0l2ATmuVtLhbeJMyK2twICzjX2TNwiMOTcTuFbCJv63mO5Bxs872FgFZy1ue3gsbU51l3zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5950
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

On 9/26/2023 3:16 PM, Heinrich Schuchardt wrote:
> Remove dram_init_banksize() on the architecture level.
> 
> Limiting used RAM to under 4 GiB is only necessary for CPUs which have a
> DMA issue. SoC specific code already exists for FU540, FU740, JH7110.
> 
> Not all RISC-V boards will have memory below 4 GiB.
> 
> A weak implementation of dram_init_banksize() exists in common/board_f.c.
> 
> See the discussion in
> https://lore.kernel.org/u-boot/545fe813-cb1e-469c-a131-0025c77aeaa2@canonical.com/T/
> 
Thanks you Heinrich, this patch itself is okay to me, but it still
doesn't address the problem in that thread. In setup_dest_addr():

#ifdef CFG_SYS_SDRAM_BASE
        gd->ram_base = CFG_SYS_SDRAM_BASE;
#endif
        gd->ram_top = gd->ram_base + get_effective_memsize();
        gd->ram_top = board_get_usable_ram_top(gd->mon_len);

ram_base is modified in #ifdef so that ram_base and
get_effective_memsize() is not well paired. e.g. two ranges of memory
[2GB, 3GB) and [4GB, 6GB), ram_base is set to 2GB of 1st range and
get_effective_memsize() returns 2GB of 2nd range, ram_top will be set to
4GB which is not desired. Will you address this too?

Best Regards,
Fei.

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/cpu/generic/dram.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
> index 94d8018407..1b51bae9b6 100644
> --- a/arch/riscv/cpu/generic/dram.c
> +++ b/arch/riscv/cpu/generic/dram.c
> @@ -20,19 +20,3 @@ int dram_init_banksize(void)
>  {
>  	return fdtdec_setup_memory_banksize();
>  }
> -
> -phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> -{
> -	/*
> -	 * Ensure that we run from first 4GB so that all
> -	 * addresses used by U-Boot are 32bit addresses.
> -	 *
> -	 * This in-turn ensures that 32bit DMA capable
> -	 * devices work fine because DMA mapping APIs will
> -	 * provide 32bit DMA addresses only.
> -	 */
> -	if (gd->ram_top >= SZ_4G)
> -		return SZ_4G - 1;
> -
> -	return gd->ram_top;
> -}

