Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1810EDE98A
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 07:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E624D8648D;
	Thu, 14 Sep 2023 09:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M0245Nvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445F786661; Thu, 14 Sep 2023 09:43:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2642086431
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fei2.wu@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694677386; x=1726213386;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+Th08WvpBylEaHH1bf/5k79+uoxi1mv++EenG0zroOA=;
 b=M0245NvdcTujQcfKLckPfU/sPaxD+ZKggdmcuAycg0uuNiHw1UIcdLBF
 0h2Yssxz+02qWbSEbgYNSIvmcvYT4M6ZVf5zFUhgUbat+eBl79LRdy+42
 UMb4AdFkQJWvhFeoyjnGwvT+VGEkrAjoI80ukeZmthkSbqQrohTEEhhYE
 GwEG7Yu+9rAisWpG7QyRK1yHD84dw02ceWvB1oWEe75sIj0dYonMDh9ew
 00VLiJrhiNyru5rsemFda+4V+SDYIfPJ4mAWnhsL4JToxj1Gu26CnfTmA
 X7UlIS6/Rea1/BwvJkqYJy7od10RvOn1oI8QiMoMO7K0ElmxjGtloABoD w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363918659"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="363918659"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 00:42:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="1075265999"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="1075265999"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Sep 2023 00:42:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 00:42:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 00:42:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 00:42:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoxA/lN7maWvzxn11xpAjdL35m4HB6kUwQ4EFe93yzCgBzqTMtHIA2QOXPKlM/QhYYy/Xrayj4ID9NVn4V8pjLNPwMGlTDbCYm+YOuXJcf6+CRjUazSFusITLddhwZPoRETj1VWUmo9NIX11AgUKBGbzUBfzRwmprYmehRkMlxSNTJtRmbZX6/ukqGq+2YTdac4zqr4hsB6K79TYy+VB9rxTk2eYHLziIzeha/aHwFlfoCHIp8FXoNpwW/ACi7QAZr+d8D092msg4kFtfu3RfdAA4vsOmruGm/OWSUTxvjuHeg3un69grYC6h5/woOEUqZMLYlXKvA+7roMAM+r+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ucuHZOzAOsgF14kLaEqLiXs6lZdYuA1uH1AIDYJXs8=;
 b=i+CdEtX4BvrI0cLGkvGl8roupuNfC9UriKKELKspYIZZa5uV1sBJrVJLsJkq1FqpNldzQLWF2njKMXhFsqrTkJoVEFdSRH5AIFGaaxAEPEHYx9QB6JDBL31fh5EA+/MjRFgzfc27f9bLfp33+Gguf9znyTm+UH50E+H9Rcih0wGWgDKUXy8Czt6iube+fzSbAW19YAu99doJ0ueBtzx5Q1VhtsQwmauyIuRW52NzPHObhQvaEkrT+wF1sncEH7C+1YizL/yhQAzL43Qi2CTUA2+slPPAyABsjUDx1B/NR0209613Py9GqQ5aEzYbBXBB5YW/ey6pK5IG76sofQghZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 07:42:54 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::a71b:fe6d:968d:291b%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 07:42:54 +0000
Message-ID: <60f816cc-8372-0628-fb1a-0073dfd87361@intel.com>
Date: Thu, 14 Sep 2023 15:42:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2] riscv: enable multi-range memory layout
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>, <bmeng.cn@gmail.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>, <pali@kernel.org>,
 <andrei.warkentin@intel.com>, <sunilvl@ventanamicro.com>
References: <20230914053055.745507-1-fei2.wu@intel.com>
 <5D4FDDF5-5DEB-4A02-A423-C54662CCBFF0@gmx.de>
 <c23a28ff-475d-0921-502f-f475b0e51ebd@intel.com>
 <967f8765-67ac-48ff-970b-da8e431b5009@gmx.de>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <967f8765-67ac-48ff-970b-da8e431b5009@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CO1PR11MB4820:EE_
X-MS-Office365-Filtering-Correlation-Id: f75a28b4-0e16-452c-0628-08dbb4f63447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jxsh5eK6wX4H/XBBmgedsXt50MzVqpo3azubtivsU0iEghh10SoTCOlHFVG+R5Ic5SWnsX0LOJx0OZx45sVsaMSO3LiILZNUU00To3hGSk0mCp+w9cGD69KVx/NYBA2GTSkfekToqjWwbdgOpWOjZ+ZwKbkqehWeLNc8mpsLo1BwKCew8OBdH/MNoiHuSsb/upxb9moaqe77VQ9PCYvfmsI1X6sbTVIi7zB6D8oyLC69wMOL5qgr/LcBTYkdoh6lKm+ePA5NrQSB4aJSES0S6d7nc6aAt8cwC4f9RDhQiQ0aKML3Y31ftwXsJM3oErOHuyju8L6OSeAQU0o8cKWyEZMG5dsqK8LiZsm0QMJPv6eHDNMSfo2pfbQwD6o9SkDsHJ0w/taQLFhjtNPPBY/YfhcFzO2c2v/M/NHP2t9svCVeFmEufATPoDbJuJm/02A8KP+1SwBi6WT7aPEqLZLuUpbLbPdhYuxtgpVUTINY3C31vweDvFMz5pt9XveSuMXN+gVQxxuTG2z4hGTsB08+KwZnmQZxoNwv04twx61qtMfxyatPOuxD0zRTr0umv2dKeXDuclSMdIutlDCm0kKsX5ceLofq/yJHCWxUEmSUHp8yRJbYjF9zw7nfhgIBbEgIZrW/oqZ4SEpybfLB+07Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(31686004)(36756003)(5660300002)(83380400001)(26005)(31696002)(86362001)(8936002)(41300700001)(8676002)(4326008)(6486002)(6506007)(53546011)(2616005)(6666004)(6512007)(66556008)(478600001)(2906002)(38100700002)(82960400001)(966005)(66946007)(316002)(66476007)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm9rcDVLZEFGanEwQ2F5SkU5cnFGMmJxUlR0SHV3SHY3NGRucGwwbWR3cGtj?=
 =?utf-8?B?bmVyTDRzdE5MbU9ZSnJJQ09BNlpZSTcxTzB6YU9QaGZBWlFDbURvd2pZaVBE?=
 =?utf-8?B?TFdJd003bngva0tPSHViNy9jUUE3TlNkUVZ0UTZMSytUY1FYZ1pROExYQlZG?=
 =?utf-8?B?Q3RLOEgwaVpFa2JadFkvUVl2bjdmdDdZazJtRmVNVXplVmdWcGNWU05JNVVa?=
 =?utf-8?B?M0gydzZyWTJ6WldrVzNTR3MrcHp1THN4USt0Ym9DSU5IYTVFemt2Vzk1aTha?=
 =?utf-8?B?WEdXMHBlNTNxMVdLUGNkTkxBYThpazJ2akFXdG9iVEE5Ymsva2cvZzF4ZXdV?=
 =?utf-8?B?YXlkaldFR1hXNVRORVFDM3AzVjQ2K2JjOFg3R3pmdEpYY2lRZHhpSkdpY3Q5?=
 =?utf-8?B?YVhPMkJNdDJqV3Y3RUR3Z1djVURobnU1WlB5REZjcm53dzkyNjZqNVRZYmNS?=
 =?utf-8?B?RWUydW5HZUlqaDBBN0ZDaGJ1TEJHRWJFNnlpYlhuK0pxZW16RjRTRmtTZ3Bu?=
 =?utf-8?B?cTkxVE93Y3NXQURZUy94S1dkQzZqMWo4RVg4VXE4QktYMkhwaHJvQmRCQjZE?=
 =?utf-8?B?bUN2em5TMXFobzVOQ091aWQ5T09hTVJoa1pLelVZZFo0ZTVzQkZDaUhnaGlI?=
 =?utf-8?B?d3RKQVB2Qk5FUm13OW5BZEhpR00vZmYrd1k4Uzk2L1BLSnkxN3lxRWhRTlFK?=
 =?utf-8?B?MmJJWExoTjlKVjJLb2ZqZ0VZZzJxK3E1OERXYkV1azl4VXk5TmUxbjdjQk1K?=
 =?utf-8?B?QTZjcDBpSWg3Qk5waDBZMmVJWmpMcHFhMXM3M1VMSDBCTXdSVnhxWitveVBa?=
 =?utf-8?B?Vy9FVFRhcXIxR2lqdmI4bDlSZEtGRjBQVkRxb3NMbitjL1R3YzczaXp3aEg0?=
 =?utf-8?B?aGRPOU5CS1k3dDZjeFROdGVxZDcrbk5JUVdHYmFTK0hkd3g2VWk1a0h3emx6?=
 =?utf-8?B?Z2llUHhLSitsNVgvdy9WWGRYYjlGZzI2dllEQUsxdUdBdld0K0FtcFd1Q096?=
 =?utf-8?B?VStxZWJITjRGS2E3Z3BJTDYyRzliK2p5cWZqb3lvZ1BNQUJKTDc4bjRRU2lx?=
 =?utf-8?B?TllJcGxZRG5lNnBiLzFXN0k3R3lLZDhDczlDckdZVE41VjB2WjVpYWZ5TFVL?=
 =?utf-8?B?NHJtZmluUE5wM3I4djlIUi9HTmxyZHNhOGs0QTJMUU1XTmxZVmJxZUNBWWJR?=
 =?utf-8?B?SEphb1B3dy9WMFJ6RWk4aHBkVjlGM0xCQ3paRG9CREJ1azRJSEtWYkNJSkcy?=
 =?utf-8?B?SHMyNURzdHZOaEM2RXRET2p1c3dwdmZRNHhlZDVkWDRjODVFaEhCZmEwbkFG?=
 =?utf-8?B?bTY3ZHIzQlBiOE52em1rRzFhSTBRS0h6cnBLalVrbW5KcjVmV2Y2U3JIN1Ix?=
 =?utf-8?B?VGlmeS91aVkzWWhnbVdNRjJpSWF0QWJ5QWtFd1gvOGx3S1BNSWpFRTQ3Sm00?=
 =?utf-8?B?U1BaekV3eEhYVHNmOVc3YzlUTFJuZ29MQXNKaTdGOHBjL3dtTnoxMU9PS0dG?=
 =?utf-8?B?SmV5OURSQ3FQK3dDcVYzY3kyblJtcHZmR0I0aE5GSE5mKzZaa28xS1FpeDQ3?=
 =?utf-8?B?djBHd2p1cU4wOFZTLzNpOW9zUG9LOTJONEpodUZ6dWpDSTJpRFpyTWowL204?=
 =?utf-8?B?TVA2VDN1TDZsSm5DSTR5ZVZ6WlkzbFJTaXJIWDl1Mi9WQmJyeTJHN0FHS3Iw?=
 =?utf-8?B?cTVaR2pjUjJ1WERLdG9wY1RkQkFPOXA5TGN2R3hDV1VFbEFHRUZDWXJkMUQy?=
 =?utf-8?B?VjM1Sy90R1h5bU5NOFlxeEpidVVqOHZMK0l6TG55dTNiOHpEOG9YUG9tYWtH?=
 =?utf-8?B?WThzK1RXRHdwUldncnJrT2hJeTdjSjVld0ozOUJ6RTQ4USs3eVlCelFPOVZi?=
 =?utf-8?B?UmQrZEFkdXJ2VGtieGhUNTZhQWNIRDdlVlFqalp3aHpDNmxzQzg5NmJiQThU?=
 =?utf-8?B?NndBZWVsQ3BMN1ZxM3lJeUJudkhQYXRHUWlmdDl4K1N0N2Jmb1FFNUtIYWY3?=
 =?utf-8?B?anljUXZTUHgrcEZMQlg5MDN1bm9aWVRrdEZ0ZTIzMEE0bnQramkraXZMM0ht?=
 =?utf-8?B?UXBreERmdUNyNDJUdUlnRUF4dXBkd2d2OFkxbERGcVdObHp0eVljWFFBUjJy?=
 =?utf-8?Q?nSUzswDM6rg446UaPKdyzIliR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f75a28b4-0e16-452c-0628-08dbb4f63447
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 07:42:54.1438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01ZJjvxgrDL30EOFNpbPoDE5B0whduiSCF742AXvnOwcmS5ctCIK2LCTTO1BQRI8tW0ZzlHJa1mEQZkQN/F4vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4820
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

On 9/14/2023 3:20 PM, Heinrich Schuchardt wrote:
> On 9/14/23 08:48, Wu, Fei wrote:
>> On 9/14/2023 2:05 PM, Heinrich Schuchardt wrote:
>>>
>>>
>>> Am 14. September 2023 07:30:55 MESZ schrieb Fei Wu <fei2.wu@intel.com>:
>>>> In order to enable PCIe passthrough on qemu riscv, the physical memory
>>>> range between 3GB and 4GB is reserved. Therefore if guest has 4GB ram,
>>>> two ranges are created as [2G, 3G) and [4G, 7G), currently u-boot sets
>>>> ram_top to 4G - 1 if the gd->ram_top is above 4G in
>>>
>>> This should move to 7GiB - 1 in your example on riscv64.
>>>
>> I'm describing the current implementation of board_get_usable_ram_top()
>> in ./arch/riscv/cpu/generic/dram.c. Do you mean this function should be
>> changed? Is the comment about 32bit DMA device still valid?
>>
>> phys_size_t board_get_usable_ram_top(phys_size_t total_size)
>> {
>>          /*
>>           * Ensure that we run from first 4GB so that all
>>           * addresses used by U-Boot are 32bit addresses.
>>           *
>>           * This in-turn ensures that 32bit DMA capable
>>           * devices work fine because DMA mapping APIs will
>>           * provide 32bit DMA addresses only.
>>           */
>>          if (gd->ram_top >= SZ_4G)
>>                  return SZ_4G - 1;
>>
>>          return gd->ram_top;
>> }
> 
> The comment above says 32bit DMA is board specific and not architecture
> specific. So it is wrong to have this board_get_usable_ram_top()
> function on architecture level. It makes usage of devices with all
> memory above 4 GiB impossible.
> 
> It tried to pass through a SATA controller but received an error:
> 
> # modprobe vfio-pci
> # echo 0000:06:00.0 > /sys/bus/pci/drivers/ahci/unbind
> # echo 1022 7091 > /sys/bus/pci/drivers/vfio-pci/new_id
> # qemu-system-riscv64 -kernel u-boot.bin -nographic -M virt -m 4G
> -device vfio-pci,host=0000:06:00.0
> qemu-system-riscv64: -device vfio-pci,host=0000:06:00.0: VFIO_MAP_DMA
> failed: Invalid argument
> qemu-system-riscv64: -device vfio-pci,host=0000:06:00.0: vfio
> 0000:06:00.0: failed to setup container for group 5: memory listener
> initialization failed: Region riscv_virt_board.ram:
> vfio_dma_map(0x55adbde66f70, 0x80000000, 0x100000000, 0x7fcd6fe00000) =
> -22 (Invalid argument)
> 
> With which version of QEMU were you able to use PCI pass through?
> 
Please try this:

base: ccb86f079a9e
patch:
https://lore.kernel.org/all/CAKmqyKMtAzt5saCUMd4vXYfgAQibpzQJAhtTSuSb+yeKhcYpfw@mail.gmail.com/T/

Thanks,
Fei.

> Best regards
> 
> Heinrich
> 
>>
>>>> board_get_usable_ram_top(), but that address is not backed by ram. This
>>>> patch selects the lowest range instead.
>>>>
>>>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>>>> ---
>>>> arch/riscv/cpu/generic/dram.c        | 2 +-
>>>> configs/qemu-riscv64_defconfig       | 2 +-
>>>> configs/qemu-riscv64_smode_defconfig | 2 +-
>>>> configs/qemu-riscv64_spl_defconfig   | 2 +-
>>>> 4 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/cpu/generic/dram.c
>>>> b/arch/riscv/cpu/generic/dram.c
>>>> index 44e11bd56c..fb53a57b4e 100644
>>>> --- a/arch/riscv/cpu/generic/dram.c
>>>> +++ b/arch/riscv/cpu/generic/dram.c
>>>> @@ -13,7 +13,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>>
>>>> int dram_init(void)
>>>> {
>>>> -    return fdtdec_setup_mem_size_base();
>>>> +    return fdtdec_setup_mem_size_base_lowest();
>>>
>>> Linaro is working on allowing to download a distro image via https
>>> and installing from a RAM disk.
>>>
>>> We should not artificially reduce the RAM size available for U-Boot
>>> by restricting ourselfs to 1 GiB.
>>>
>>> We must ensure that ram top is in the upper range.
>>>
>> How do they handle the case of >4GB? board_get_usable_ram_top() attached
>> above always returns <4GB. And it seems like
>> fdtdec_setup_mem_size_base() cannot ensure the upper one is picked, it
>> just picks up one, but which one is selected depending on fdt.
>>
>> Thanks,
>> Fei.
>>
>>> Best regards
>>>
>>> Heinrich
>>>
>>>> }
>>>>
>>>> int dram_init_banksize(void)
>>>> diff --git a/configs/qemu-riscv64_defconfig
>>>> b/configs/qemu-riscv64_defconfig
>>>> index 9a8bbef192..aa55317d26 100644
>>>> --- a/configs/qemu-riscv64_defconfig
>>>> +++ b/configs/qemu-riscv64_defconfig
>>>> @@ -1,6 +1,6 @@
>>>> CONFIG_RISCV=y
>>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>>> -CONFIG_NR_DRAM_BANKS=1
>>>> +CONFIG_NR_DRAM_BANKS=2
>>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>>> CONFIG_ENV_SIZE=0x20000
>>>> diff --git a/configs/qemu-riscv64_smode_defconfig
>>>> b/configs/qemu-riscv64_smode_defconfig
>>>> index 1d0f021ade..de08a49dab 100644
>>>> --- a/configs/qemu-riscv64_smode_defconfig
>>>> +++ b/configs/qemu-riscv64_smode_defconfig
>>>> @@ -1,6 +1,6 @@
>>>> CONFIG_RISCV=y
>>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>>> -CONFIG_NR_DRAM_BANKS=1
>>>> +CONFIG_NR_DRAM_BANKS=2
>>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>>> CONFIG_ENV_SIZE=0x20000
>>>> diff --git a/configs/qemu-riscv64_spl_defconfig
>>>> b/configs/qemu-riscv64_spl_defconfig
>>>> index bb10145e6e..66dc2a1dd9 100644
>>>> --- a/configs/qemu-riscv64_spl_defconfig
>>>> +++ b/configs/qemu-riscv64_spl_defconfig
>>>> @@ -1,6 +1,6 @@
>>>> CONFIG_RISCV=y
>>>> CONFIG_SYS_MALLOC_LEN=0x800000
>>>> -CONFIG_NR_DRAM_BANKS=1
>>>> +CONFIG_NR_DRAM_BANKS=2
>>>> CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>> CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
>>>> CONFIG_ENV_SIZE=0x20000
>>
> 

