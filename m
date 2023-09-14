Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2FCEDE987
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 07:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5191786A88;
	Thu, 14 Sep 2023 09:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bkngquF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 286EB86A8F; Thu, 14 Sep 2023 09:18:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F4A86A82
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694675879; x=1726211879;
 h=message-id:date:subject:from:to:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=rWWucnzEXcs38lDDrgYarFOOz4RP7mnBcWtkPfRHPVM=;
 b=bkngquF8BNyr+BTlumNa1qZ+CLXfxrcpoOWAXBY4HZJXwGlNDwf76zxz
 J8HN1hoaJdcnORVaycXMJwDC13pobSKAH3dwkotS3Rw5qfrh2zSFb+5sn
 0fm4L0GR4cL8qc5XYi9JBTYCyT1rocfBZAxC9owoKe4yJQevpPh3+kFNS
 wdYFY+RLKk/bLTpUJiNkqp1S9wf2t54BRwDlGf6lLIDJ4jGSnaSCPZyBU
 2N45qPzFwwGVhiOgx1xlt7kEHRslKlguYeElFTR6X6lY5IePKDpfcKsKF
 bpiVJv3jcvDTv+INWeJZJgBtXKrgDhbdQDpyVDKv3EZAVpsBKiNN76wEI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369148175"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="369148175"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 00:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="694150316"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="694150316"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Sep 2023 00:17:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 00:17:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 00:17:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 00:17:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 00:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ia1r7NN6dTWQVf4U8FD+1orXhKDSKNl0BP4GdokbeOkzcPe+4Q8v+C1Um1efwzF8weBAgWpKLkDP3DVcmKvf8wpU+WESj+anIUmgSI32qZqmEDSmJUUHCxmcocwMNe0RA7c+Cowm8kepTaIX8S7O9F9L6jmMXApuAiv58CwTLajxWrVWhw6w4CcGizq3j6xpvwq90tbtdbJmU8kd1cRMWupKSjdd71XZHgr12az8T/ao1V5KPu1DIJR0KW+DXP5M4dnvdsffztD8nVJ9BbpkOrRgDKW972tVX4dcZmuqpohePaPGWX9kfCigFvj/pkRt8SzmiZzrLt314CZt12Yj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc+K8IuUYJQ4CuvTQblsYQYHjPpJ1+Vt9h5wdgGO57s=;
 b=dUdtqdM/shoUoFkgSYMTAVA8VuSMmih/RoGUDQ+cmxGoa6jgHRAJTJJvQpvfd9saBhz9koeJHk7EVMNctzu6ZLjOPEVckUjqZUgFys4UX1zuWFDW0YSuXnjcZMsSVl5LCRqlW0JrsPf6P0cGP26OWB8HJgcpJtEWG09E/Ay2/cQ8j7itVlvvPyMCfRiUzARNMaKKziY85AnTGlPK1Joqi8Wh2TW0udUjyTC+gU2fsCvpDS6Cx+53LPzjoPpubvButl/sAeedabAfYQxHa6NhxKihuSTwTMn+jTXZyaXTciUewvvBZHKjtVMXBZKckrsLTKYC56t2UzoWbJeOrVBraA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Thu, 14 Sep
 2023 07:17:54 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 07:17:54 +0000
Message-ID: <57cfa13c-7dd4-496a-b4c6-af7b497e7d87@intel.com>
Date: Thu, 14 Sep 2023 15:17:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, <rick@andestech.com>,
 <ycliang@andestech.com>, <bmeng.cn@gmail.com>, <sjg@chromium.org>,
 <pali@kernel.org>, <u-boot@lists.denx.de>, <andrei.warkentin@intel.com>,
 <sunilvl@ventanamicro.com>
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
 <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
In-Reply-To: <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CY8PR11MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: d00d52c4-35c3-49ad-1fc9-08dbb4f2b679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyerhJtCKkFOhXPzBQ9J9toKzzWjZM3yT04z8HltUQCO4BQByYawAh6Wv41OlIMhmKfTfZKwHOsyLhwL1+D3PGc69T0ydR+4/2W+0YzeNK5AFyeIVwypeSesoQZTGCa4HgYVvqlAL35yl3Iy3lh3UQAO1We65iBhoedEhnBrOtoFUSkrGrvMG3zSb75LlBV+pK+8WRQfJF6HIum6PTeLOzbqs92r60TDg/tTL+IskxYbEHQ3eDCS/4pZJivgD8kHCxbnkgiAkT+jLD0Y9HxcyS8V+77itzDzlRrrVDuskFogH8Q4n0L9YCXzr0qEk7nViKhwMh75fdE7t/gRJwgwN0h/GHkh8E59PcZ9LE9387fo/7Ya4+u2ZH0WP5CjqBduH5M8oWzKMhLaz4p/+yxA1iGjxwzhgArE0sN1PnmFBhGZkyaPJeNaWv4MbAO/KrRMwQPOz/53e4iyCLZvOCiSK5105VGz6i4KN63fXWHPBtfSA+xbffo4rCrzky6W43X/PpQoZtATdzrUMXKtbR8gDzD7+beaMggxu+PEzdkvwm6JsM6jJzzCf4kzi/L2RRiVHZnq/qJyOnlwa4m8rda3us0gcC/M23M1XsMI/NwD8Mn+b8Muwi+xdbDOjupyUDZ8Kf/g8PnnBJqb6QfTIT+phg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(186009)(451199024)(1800799009)(478600001)(31686004)(8676002)(2906002)(86362001)(31696002)(36756003)(41300700001)(82960400001)(5660300002)(38100700002)(83380400001)(8936002)(53546011)(26005)(6512007)(6486002)(2616005)(6506007)(6666004)(316002)(66556008)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blBLdldEUmtzdVpCVmpnb0I2azkrWmNuQkdCdUVQRkhZek4wUnUrZlhybEhw?=
 =?utf-8?B?QnhJSTJBbzRGQWpkWHpZNGxYRnVwaS9IOTF5M2F1aDFUSC8wb0kyQXliU3gw?=
 =?utf-8?B?eENJYUNoQlQ1L3Vyd3J4aW5LOTBmdUpXR2UvVzNKSUFuSk9tNzdvSDVYWHhK?=
 =?utf-8?B?b0h4ekdZSVN0ZjYrbkxEYjRXdEd3V3BRR3F1UnhaL2EwTFR4eVljYktNb3g0?=
 =?utf-8?B?OFo2WVZSMUtGNzF4akFTTUhvWjcrWjV6WUYwSEZjcFR6aHlCcGJGSUpwcVVP?=
 =?utf-8?B?dnJ0ejB5dytkTFRoRitCNUxyeFEwSno3Y3NLanZVbEdBZnB4UHJxaHk0eVI1?=
 =?utf-8?B?MXRMVzhSNys1M0lDVm5zZ0Q4OUIvOG0xb1FEL1BzUVpvbFJ6dUg2Tk93QXhX?=
 =?utf-8?B?UU5ES2J0V09kdXVLZkFTVzVPZkhLYWJZWlZzb1R0UVhoak03ZlZlakRFcVlB?=
 =?utf-8?B?THNNdkR5ellZcjg4blJyVWpRbUI5STBsK2NCQnY2OUQxUEJKRVJOQlpYcHNC?=
 =?utf-8?B?L0tEb3ErNnZaa2R3c2ppSTlmNXFDRWh2Z0ZNdmYycEZFYzQ0YjcrY3NHTVh0?=
 =?utf-8?B?TlZMcnZKMXF3bXR0YW5GanJocGN3YWg2UHpNUGJNdk1QdG94Mk91ZlpXOWdD?=
 =?utf-8?B?M1c2Q2UyWko1bE9MY0l6NENHREFDSjlKdFV6a25VaE02T3F2bTMvODJWcXVS?=
 =?utf-8?B?MmdCU2tCbjV1NDVKUy9GcVE4dGpSN2doVDFLeDMyTDF0QmdIMm4zVSt5d25Q?=
 =?utf-8?B?RnEzK05aaDB3UHpvY2lqVUtIK04vVmlpSFdSQXdzRUI3bUk5eWd6bEhUT3Vy?=
 =?utf-8?B?amcrbU41TWhlLzh4USthWDhsM2R4SVFjZUI1SnUvUVl5bHNreW0raW1RODdQ?=
 =?utf-8?B?RzNHWldwTy9qVm5EMFlqdlNFMGNlRm9pQjJmMVZsWktZZm51S0pJaTdUL2Ji?=
 =?utf-8?B?dklMYW1wRHY4VHQ1RkJhaVY2U29sUmR4ZXF5aUpPQ0dkZXErU3pOY1g2cDRG?=
 =?utf-8?B?c2x3Z3BRWG9qSXhmd2JnZTUzZ3RmUWhaN0lLZXhFcnV1akZyMlczZFFVMWJM?=
 =?utf-8?B?bVlmLzVpRWNLOGRlOUltei9TZExJSi96MEcxZ1FzL0VBUWQ5OFk4d0VkTFB1?=
 =?utf-8?B?MEVwT2wzOFBKQzZPUWprdjB4OXR5TDFVMUpVbTdDWVJDYkg1eXhQa3dWS2p6?=
 =?utf-8?B?ZHpUSW9XQndsdUR2UU56UWxFbU5CdFNGTFkvSlAxd2Q5Y0VCcHdmR2NNZGdt?=
 =?utf-8?B?QUd1VDFZUmVDRWwzTnE1bnEyNFZmVVoreDhCQlVNemdtUm9taVg0a3NiWEdm?=
 =?utf-8?B?Zkxld2t2Q3hyTm5MMWxXeGVXa2EweFpxWWlmSUJtQ094WjBoZHNqQnUwYnVo?=
 =?utf-8?B?N1BsbXVubFdTRUJjVHFaUG9MM1JEb3h5UytoSTZ1SldkQWxXNVI0SHpLbWJN?=
 =?utf-8?B?RUhqWGV2QWc3aW9oNVVKM0lyTTd4UWlMVm84YVRpSXNRTk5IMGo0WFZnWEdE?=
 =?utf-8?B?c29CSUd3UFR2SlVwTmpERTNWSTIwbXJySlpIb3VoK2ZodTliYVlXeFplbGlS?=
 =?utf-8?B?ZGhUcGRJdWxHL2Frcy80bEIxODk5WEo4eURWOVY3a3pFZzF0OXNKdkRyaUJ4?=
 =?utf-8?B?Q1hnNnc4bEI0ZzI5aE85Yy9NNE9qWEtibWxmdW5rMlEvYUVNUSs5d3Q4Uk1l?=
 =?utf-8?B?YTQvU3J6Q1c5MkZCRGtHS011TDNsRkRVOEd4NXFTb1dJZUdXRXhRUlg5bGU1?=
 =?utf-8?B?ampNQ1NqNDJUcittMmMyK21hWFU5cXVzNGZIamtFQndHM0EzMjVhdnBhUkxh?=
 =?utf-8?B?QlpoV2hWdDJUQlA5cXkyQkJ4dGRlTTNLQW9QMkxDQVdqQiswS3ozcjRwbTI4?=
 =?utf-8?B?YzhXNzR5bDFITW9INDMxZlVka1dLYWxBVmplRVBqSVFoSVVhMFJOQnVyMldw?=
 =?utf-8?B?d2RaVmowNlFZaUc1ZU9sUTlGYkFkbWlJVWRxcHh2UUhmRUJ4WWw2L1A5NlJ2?=
 =?utf-8?B?Z2N0K0xnZTA3ay9TcmJxNUZQemtwR1pXSjJycnNHVGhObzhISjBXZlRxbTg3?=
 =?utf-8?B?WFV5ZE80VVY4R3JCYld6akFZUG0rdGV3eEFSZ1J3dk1lbTBwZjJwY3pFUFht?=
 =?utf-8?Q?01mDJnoxnmHFAiH3ZjwnwABcf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d00d52c4-35c3-49ad-1fc9-08dbb4f2b679
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:17:54.2227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZQFWpNFjEPHwnWYEHhGeLQeEkfdpIQylxyjIEUaQJPmPs+NSNkYOss6lvBqfR9SiT42oh68N6QO8OTBcP8oQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
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

On 9/14/2023 2:48 PM, Wu, Fei wrote:
> On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
>>
>>
>> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu <fei2.wu@intel.com>:
>>> In order to enable PCIe passthrough on qemu riscv, the physical memory
>>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
>>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
>>
>> This should move to 7GiB - 1 in your example on riscv64.
>>
> I'm describing the current implementation of board_get_usable_ram_top()
> in ./arch/riscv/cpu/generic/dram.c. Do you mean this function should be
> changed? Is the comment about 32bit DMA device still valid?
> 
> phys_size_t board_get_usable_ram_top(phys_size_t total_size)
> {
>         /*
>          * Ensure that we run from first 4GB so that all
>          * addresses used by U-Boot are 32bit addresses.
>          *
>          * This in-turn ensures that 32bit DMA capable
>          * devices work fine because DMA mapping APIs will
>          * provide 32bit DMA addresses only.
>          */
>         if (gd->ram_top >= SZ_4G)
>                 return SZ_4G - 1;
> 
>         return gd->ram_top;
> }
> 
>>> board_get_usable_ram_top(), but that address is not backed by ram. This
>>> patch selects the lowest range instead.
>>>
>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>> ---
>>> arch/riscv/cpu/generic/dram.c        | 2 +-
>>> configs/qemu-riscv64_defconfig       | 2 +-
>>> configs/qemu-riscv64_smode_defconfig | 2 +-
>>> configs/qemu-riscv64_spl_defconfig   | 2 +-
>>> 4 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
>>> index 44e11bd56c..fb53a57b4e 100644
>>> --- a/arch/riscv/cpu/generic/dram.c
>>> +++ b/arch/riscv/cpu/generic/dram.c
>>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>
>>> int dram_init(void)
>>> {
>>> -	return fdtdec_setup_mem_size_base();
>>> +	return fdtdec_setup_mem_size_base_lowest();
>>
>> Linaro is working on allowing to download a distro image via https and installing from a RAM disk.
>>
>> We should not artificially reduce the RAM size available for U-Boot by restricting ourselfs to 1 GiB.
>>
>> We must ensure that ram top is in the upper range.
>>
> How do they handle the case of >4GB? board_get_usable_ram_top() attached
> above always returns <4GB. And it seems like
> fdtdec_setup_mem_size_base() cannot ensure the upper one is picked, it
> just picks up one, but which one is selected depending on fdt.
> 
The whole idea of this change is to find an address with backed ram,
because of the current implementation (or limitation) of
board_get_usable_ram_top(), the lowest range is returned as a solution.
If the Linaro work can remove that limitation, likely we are both fine.
The next question is when will this Linaro work be upstreamed. I'm
changing the memory layout for PCIe passthrough on QEMU, it's better to
see u-boot is ready before QEMU change, or the system is not able to
boot up.

Thanks,
Fei.

> Thanks,
> Fei.
> 
>> Best regards
>>
>> Heinrich
>>
>>> }
>>>
>>> int dram_init_banksize(void)
>>> diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
>>> index 9a8bbef192..aa55317d26 100644
>>> --- a/configs/qemu-riscv64_defconfig
>>> +++ b/configs/qemu-riscv64_defconfig
>>> @@ -1,6 +1,6 @@
>>> CONFIG_RISCV=y
>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>> -CONFIG_NR_DRAM_BANKS=1
>>> +CONFIG_NR_DRAM_BANKS=2
>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>> CONFIG_ENV_SIZE=0x20000
>>> diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
>>> index 1d0f021ade..de08a49dab 100644
>>> --- a/configs/qemu-riscv64_smode_defconfig
>>> +++ b/configs/qemu-riscv64_smode_defconfig
>>> @@ -1,6 +1,6 @@
>>> CONFIG_RISCV=y
>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>> -CONFIG_NR_DRAM_BANKS=1
>>> +CONFIG_NR_DRAM_BANKS=2
>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>> CONFIG_ENV_SIZE=0x20000
>>> diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
>>> index bb10145e6e..66dc2a1dd9 100644
>>> --- a/configs/qemu-riscv64_spl_defconfig
>>> +++ b/configs/qemu-riscv64_spl_defconfig
>>> @@ -1,6 +1,6 @@
>>> CONFIG_RISCV=y
>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>> -CONFIG_NR_DRAM_BANKS=1
>>> +CONFIG_NR_DRAM_BANKS=2
>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>> CONFIG_ENV_SIZE=0x20000
> 

