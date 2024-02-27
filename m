Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB628C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 08:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F3087FAD;
	Tue, 27 Feb 2024 09:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2zh+a7vT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E814287FA4; Tue, 27 Feb 2024 09:45:29 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 993B487FAD
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 09:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPPm9FnU/gaH/xfqciigIg8+HCH6Ah2nhhfs+Uf3yJdNdwgAATf9vqMDJ4xGpPjToZpvZ9bNH/wQ29CEGbVURqxp+X0ZCZxZ0iUoGFlElFz3ys38QUP3ID2QcVntCKWVNtMQ+P3ByoAzS+BeOSRUCZmrIrut4OEfK6ZLivwDEbGv8bhuzaVm2HYL/zeUWDnkH8XfJclZbya2WAnHE17zPnVppvCV6/+yQDaQkCpeZ4eu8jTmTK1JX62372CcDtQfntgQGu23aclHMZd2GFIvc+8MG0kYr0piJlZWZ497HoqnHnWfQ6b9csNZsOSL1NybtAt1la8vTnZiH0qe7glEPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZgAHN4hlQ8CjyaUvt4FqsQJEWDCTHxMrPxTyTF7TAg=;
 b=Tyq43YBJpwHUR8FwftAOeC8MEq8y+VCNvesrIamiULyiuno6f6ttt6/vlkAJaKSNOuz5K+dAKPAhlPf/e3WLuijwVYuxfcC6yXyz1XV5y55lj+ik4fO/9b/jdClr0LwKG4Sq4QHzUj6HgNdx068zf+9xJM41Yxmzcwq2inc/9N81d0dUxUQyENxTS1ueXlXqEsuLd7LA/LTP+Hp2oImsPJZIbLBNXhD1CkDcvJoj+WJwONWCEvEjqlGSdwvBNoB2bqa3aHsYzeifFHbckfOR16G9dO+gorY6TAQlIGNlNnPkRchHgCzf038VFFhs6yUvzxa1mB4aGM+419SxAVFMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZgAHN4hlQ8CjyaUvt4FqsQJEWDCTHxMrPxTyTF7TAg=;
 b=2zh+a7vTUkgzqQQ2VCcYNfqIMOhRp4RA4JamlOYLUWhpiTo11Iyywvsqs/EqyE2tMQtKwzmJpkU9QIQ962DfYKEuWldSwnqsJdNCSof37WFewLTUTiVhBXZRf4lM3MDEyXREWscd5QpQXDvcplNz9c0wOQ1/RXNNBwLBQ46XlaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Tue, 27 Feb
 2024 08:45:23 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 08:45:23 +0000
Message-ID: <95f2396d-782e-42c1-8579-ca1a55d788eb@amd.com>
Date: Tue, 27 Feb 2024 09:45:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add label to pmu fwnode
Content-Language: en-US
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>
References: <20240227084008.2086287-1-lukas.funke-oss@weidmueller.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240227084008.2086287-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0243.eurprd07.prod.outlook.com
 (2603:10a6:802:58::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: 58bed2f8-f9b7-4b7b-a32a-08dc3770701e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yu/7cTcegPlCyworpWRfrHog/m1rIR8bWPMifssbJEbAgu7CJ+K60VekuUwkxST4sor/MtcDpc+FhPXnb4+4DfxaXtW9vzLOvSuuOj2i/OKnuQnF2IISp6FRuetBC9OWXsA11e/UwfBW7NikMiDa4AFvsbw52J7zmyTFUfMw3YOhIqZPUBSGiZOvvcD8f+qUql15IMrY8AG/3jInPn6MTtMPZz2UBQyhVUYiaKshQtwzAEaXQThcwryHPpnXOjXj/ZSv8c9EwmaYv+DwSP4NyXVeQCwacI2y7MLOdKNYKuyqj77NeK0c8TOx8OpmJjl3nGPhlGLd8SwUdIQyngacRt0chUjJPaMAeAKgi4aVAUEzvSPHOC+E1Hqo+pXrcMmgc6ycfcK8BsGXHo7WfOcx/yfBRblKZLSbyXI+gxG5lc0n3W6Ur1N7XrOS7CT4bJJC/d9JqGntAz8+U9LPHyFdF8i8zCcFrzXQ9ySOKWIBmZaZSevZAnGcgwhg5G0L0rLDTCluDberZ1A8pMC6SuxBpR1PeYm2yDC76YKYVq/3pufTsj4E3W8uweMbMheFv/6/lZiyxcxFMOJ9deszCJSF0FZ3vNluQhOwf3RJoKrZzEF2GXvSPF+klmQyVBhmyL/dxaz/YRsy/hEIlhyQTn+XnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpwNXVMV05HYkV0c05lSTNwMDl4T21Ea29RREhYWHlEVi9GTG5DRDVlejVt?=
 =?utf-8?B?SW5ac3BLNjk0emJZQ1RUNG9oUUlDQm05ZlFLaEdxYkZ5T1ZRU3JPTXcxS1lx?=
 =?utf-8?B?ZmU5MnRUWWdxaGNlNW1KR0xxU0NFbjRFY20zaW8xT0UyZnM2N2k1WW56d1h3?=
 =?utf-8?B?bXpMZnQycVJzY0RoWmNVak0xZjVsSHlPOHZoc25lZ0FIdDBsY0dxM293QVd6?=
 =?utf-8?B?Yys5SzBNd0Rmd0pwbTU4ajcyWm53ejRGUWhIT3ZOODNDRm0zUHVOYVloMncv?=
 =?utf-8?B?YW9jL0dXcmVIU1JnTkpJSEFYeFNHUFgvajErdCtyTEtXa0h1K2FLRW5vaFRq?=
 =?utf-8?B?UmNpb0M1cFpaL1BldllkcXpMTWhRZytxRDQzWnNTZnJvU2R6T2FjQWdBdzF3?=
 =?utf-8?B?aDZJYXdJOURqbkkzcU15MFhLRVhKU3c4TFlxdUJIajlJa2ZVYitudC83Tjdt?=
 =?utf-8?B?alNLTWFoTmdvc0JMRStRZmVSSGluOHlFRlpkQngvQ281NW9OaVlIYjFQSWoy?=
 =?utf-8?B?U0lkN2VrSWhpcmdVakVCYmNNaFZjUmFEbkhYL3Y4NEFFS0NyOXYrM25HY3pX?=
 =?utf-8?B?cmhVTC9sVUhobDZ1bDYwdDVwRUtVOTVSajBBbXlJTFEyUlFSQ29YU3JXUVJL?=
 =?utf-8?B?emN1VUxlVEVpRDBiam0zYU1lU3owTjc5Y0FuNnIzK2kxRmNhUFRlQ1FsYm9a?=
 =?utf-8?B?Q3RFRTNsRmJ6eS9wMVVnbkt5SXdFMllwZjN1Z09FRHU4VG4vS1c2eUdmVnl2?=
 =?utf-8?B?U1AxdHFGNkJMK2RVN25WQ2VGZnNSLzFNUWIxdnkza2h4Q3ZPdnFMbHJ2T3FQ?=
 =?utf-8?B?RzF3YUUrRjV0Q3gzcEtvUFluSmp6ZUJOaDhXWXJHK2JyOUxvTUpmaEp2VVNM?=
 =?utf-8?B?c1dLdGdYa205ZW5yWDlSaDlrZTJlSktvWVNqb2tLNDFMeFYvL3o4Y1FFRlo1?=
 =?utf-8?B?LzFxdEhQYmZWUWRGWEZuK25FZWhrSDhta3djUFpBa1doRzlsZkxieXlYYjdX?=
 =?utf-8?B?SndNbGRnNnFBV3FtVS9zb2NmZi8zVlZUU1BhRU1vUlowQkpXUTRXOVpzRERU?=
 =?utf-8?B?aXRjOGFPVWNlYU5MNVU3VDNlZzM1Y3UyOU01MUMzNnRCSVF4dWs1b3dCMXEv?=
 =?utf-8?B?WHJvUGRnNUlNcm9EdFp5ZFVXaFI3bXRCbStLcFBLbzJDSFlsZ05oZVdTVGZy?=
 =?utf-8?B?ZEk3RnEzdmVUekpMMlNmSXRZSHk1N08vNEJUcmt2bzNzTVNiYzNBdDJwV3pi?=
 =?utf-8?B?N2M0Wlg1TGxHQ0s2Mk5rZXhnVUJJR3R4aURuMWlsNUtwcmpKR3M0OXdVMy9W?=
 =?utf-8?B?elpMK0ZQaElrcy9aT1BlcnhidnBxS1lLVUhSbURHbGVUZjRBZmEwVnE3ZTFl?=
 =?utf-8?B?VlVIOWllNzFHM1JXenM0cy9yVU00VTRQdm5tSGJsd0U0UXN6OXJmY08rQ3NW?=
 =?utf-8?B?eWJDOWZjdGJpTEY2OVBOQ2Vic3NvVXNMRzBWVVNSOUQ3d25OQ00wN1lhZVdY?=
 =?utf-8?B?K2lDclZWR2ZWM09vb1JCa2xiVi9NN2Z3NDRocEFIdVlQWGJLaXV0Y004Ympq?=
 =?utf-8?B?eFlUbGl1UUZycVMxL3NJZEJMR0VJejF3UlJ4TnZWYWJ3SUsrdkVOaWloWXRE?=
 =?utf-8?B?c1FKZ0puajZzZzJaTkJhUlZPTlRaSEhJVXBrd3RhQ09ZNUFxckwwZ091NEdh?=
 =?utf-8?B?M05yVy9ZTVpzcytjQ0M1b21BeDN6NWZmWko3Q0dZK2pCakpLYi9ZVE9hU2hV?=
 =?utf-8?B?ekplc1Q1bGhydmZMTUpSdFJNRWJodnQwZnh2Rzc2OTJvcTFRTk1ERGVXaWZJ?=
 =?utf-8?B?UVpzaElsakpIeGRFZDhGdjRScUZLMEU4U2FiSWtmV0RnVHI4VTk5WFk5ZjB2?=
 =?utf-8?B?K3lYenpzYW9BRG9PbUdCcTA0T1dJTUR6TFZKWjdTTm9iOGVRZmxPZTg5UDZL?=
 =?utf-8?B?ZVZHbE5rbzlMbmVNL3RVV3l1VUVtUE5nbG5mS0g4OHl6NVlzWEhTNndUZHRL?=
 =?utf-8?B?Z2pRSkpLTjdaSkpUb2hJSkRwUUNYSGwzNkx5SHFJMXhmS3lVUC9mSlNVSlcx?=
 =?utf-8?B?bnV6SXVCTHdqbEEzeWZ1VkFSUzRaTFVLTzVaaERicWJlOVk4SnZKWHA1OWpu?=
 =?utf-8?Q?VKzHBX7fJfSOH/hsXRfciCcsr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bed2f8-f9b7-4b7b-a32a-08dc3770701e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 08:45:23.7647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4IDnTlLan+m8sCU2DhJzFiVTCm1Bm+A3wc2lnYxb4MRnaR7VRlWbcrPtgeE9Or/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
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



On 2/27/24 09:40, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Some zynqmp SoCs (the cg series) only have two cpus. Thus, for some
> cases the cpu-affinity has to adapted, because cpu3 and cpu4 are

interrupt-affinity right?


> missing. By adding a label to the pmu fwnode the cpu affinity can
> be adapted in a device specific dt.

Why do you need to do it? What problem do you have if you don't change it?
It shouldn't be different compare to max_cpus=2 right?

> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>   arch/arm/dts/zynqmp.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index b50b83b772..457f8e394f 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -168,7 +168,7 @@
>   		bootph-all;
>   	};
>   
> -	pmu {
> +	pmu: pmu {
>   		compatible = "arm,armv8-pmuv3";
>   		interrupt-parent = <&gic>;
>   		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,

And I actually prefer to have labels for all nodes to be able to reference it.
That's why patch itself is good.

Thanks,
Michal
