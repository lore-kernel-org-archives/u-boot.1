Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E522C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 08:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C676887150;
	Fri,  1 Dec 2023 09:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yqrg98YL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC59C8760A; Fri,  1 Dec 2023 09:22:06 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143F18708D
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 09:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwZlprYv+3IyHgsrswE9wG+Bs+2jizY93tlBcqgYR6ArcIWm0ZNGzlLo3EQb2ixGhyeAtqW/V1q4DoPO3H52R5vYlmk+idpA9M4WItwMBAY62+zAdEoxnUaOJDiCTZdxMGtnpZMYMqlX90R9J530F0Az1fkRf1KFNAx5k77Vmt/p/CknrspIlJhz8bONsfXQyJRroUzGoJl4ZJZGM8f1lcyB0bBChNKchAEw3iH3DuP3Ey5F0Kzn0LkHRRZ3rb9CpdK8/nFzwHflvIRRgOZlEzz7pLAHuIR/ZR1i33oV6xfndpdXO+8GwCxt1Dl8HLgBuV63J5LAOK6Rby9GAJ4Log==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0X2GCVf4zvb1c9RPhvVKMxUK/RQbpShT/gqnUgtHpcs=;
 b=XrfuWWyo184zpJHSoHBTZ5NDw9jtLAR1oGPsa3YYm/UlF0ANk+WDW4Ao+ixzwJULmhOaYZ0VidZuSvm4Gxw/Wh8u6iLMfGimFId1HpH5VfRJzC0APqwAZJoYAvMgA9PSQ5naWVPb751+VAk1HOzwVJTi3s7kX940/vidLyFNEJIoSQqanLIQJZWNHNVU4OxKlOULoDzFTIDC/6K2ZZm69BEBTSyJzbkoEoHJY5x8kzyGIfEW83sArmAJi66NRfP09Av0/4PghNEtoE1JGscbXLNFxJ/GfueneC1edsSnJ+x7DhYss+aACdJ8vZtNEvRPNEjaJWiVzxc0vo253cwaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0X2GCVf4zvb1c9RPhvVKMxUK/RQbpShT/gqnUgtHpcs=;
 b=Yqrg98YLUOyxamgO2rm7YS4LugcHG5dPhhvX5MjQtIFA5CZSO/mvl3kwPW68q75hUSYGVDe+XIK9GQZ1ML9JQf9YXAqi05hUml7gFEYNRGZLsiP0wjv+3jkn9ya5iDgwlcXQM54Huo1gXbINGX+YUYbORsxFqPjuYApnidAbKAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 08:22:01 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 08:22:00 +0000
Message-ID: <ff060b92-f4b2-4490-98ea-1d5ccf57e7bb@amd.com>
Date: Fri, 1 Dec 2023 09:21:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: zynq: Remove deprecated device_type property
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <70201ca4ad49ace6f7c27015af9df58a335d2a1f.1700831800.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <70201ca4ad49ace6f7c27015af9df58a335d2a1f.1700831800.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0216.eurprd08.prod.outlook.com
 (2603:10a6:802:15::25) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: ff33a9c6-a668-44fe-bc78-08dbf2469752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1jio947VBOnoNYhhiTdJ08F0k+inxG3pViZmWQjVXXvvHtUTQYClqEaLPPaL3kOG0r4VYpxjlZxldNwWCCytUXZzrWj0z9Ibe5rgjjUM0T6WqYoFYBClbcAGmF3qDU0y+LaqF7/6ih41hW4wTc3h5uCYLyiNrWTNTzkp7qUee5VZlyH6FFcikxI8Czd1qjYHWbVfKGKuXzyrEVY9wgGMJA/YH1BKyvffZZmJcUuwgdNd/VuIy60p66BYrdtCaWpYn5gqzYoz6tMTGNiBY9o5djGHQnuBotlweyeLb2Ax51bpwsVwAM4BvvWugjfTDBTZrklY14jcRRqPKFzJJIRyqAZMqsfSDKG3QAl9aspJXgvrqKS1vLgB0PXy2+dgaIgCGlC4U1ZF8I4auQA4x76YlWuGPs3+smGh6vwxRDF4wcmm3d5z6R9cpcxQVprU5DBSywrFAxqnbKrrO4Zg89AMztd+1Ubn79qfQLIvsHNXk3W3zKKptztbejt9joORRs52dz5+nBnuf6InGYcH8PHTK8wtxOzM/E2auq8h1tDID8aH1+O5yt8ke7ntpTBbS0rm692jO9uoAkVxHcBQj3xfZ/zIr6ocX7XnP7yzNhD63LOc5sJv7k6iRjzi89VD08LbN5fFu9hV6UeXkh3neaicQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(86362001)(66476007)(66946007)(38100700002)(36756003)(31696002)(83380400001)(26005)(6506007)(6512007)(2616005)(6666004)(53546011)(2906002)(316002)(66556008)(5660300002)(8936002)(8676002)(478600001)(6486002)(44832011)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NQZUIwSUpLNDB6NGtuZkVRRVJFOExNRFY4eU9OMFFiMythYmJlN28yUUpL?=
 =?utf-8?B?SWtKamNpSExkd2RaNytCcm5kRnVFQ2dzNnVWT3ByYzBnUFpESjd1djRva0hN?=
 =?utf-8?B?aDU1WDByeVJWQTNkcnNRdVZKelFDOVU5WldIcEpZUkNjVEN4Z3dDeW9hNWI0?=
 =?utf-8?B?cHdicWMwT3ArUURrM0hIdk5HeXdRRUR0enVkcnJsNWtvVURUVEZaYm1FOXdU?=
 =?utf-8?B?Kys2aXdSdnphM0ZoVVFNMzlNcjZDYjBPektBK3N4cWlPQXFFS0M3Zit4MGpu?=
 =?utf-8?B?eTR1YXZrSkhqSllESFU0SXl0TGdrSFJWSzJuaVZValFuYnh0M3ZsTXRkZVJt?=
 =?utf-8?B?MDFVdTJuWENMUzEzVlVyMXFEMTdDK2hCR01lYndkUW1PM2UvejdMTzRNOHRx?=
 =?utf-8?B?eW4wR08zSEdrMElYbldieFh3N1dJYWFtSFd3MG5kTzVsbU9zOWFHUDdQMXFZ?=
 =?utf-8?B?Rk82SzcrOTdmSC9xZjFuZWV5Q05DUmE4SGlRbGUvTjhya1ROSlQwTCsybFBn?=
 =?utf-8?B?dnljeXZYazgyYXBsazRzdWIxdys0dWkrYXcxSVQzc1pNajhzeVZITkNOV09t?=
 =?utf-8?B?Q05PNHBQeEQyRW1tN1pOYWU2U05DK0FXOHJkcGF0dENFZEhZWU5QYkpPbmZt?=
 =?utf-8?B?Uk5sd2JudkdwdEx5bDVSbnBadzJFbnhyVlFLTUFkaEZSUHJTM0E2ZlpkN1Av?=
 =?utf-8?B?YWRFdlBDVVlBUjRKbFhGQW5HandzQmJlTXpFQ2hDbmMvVEc2U1pEU2lTczFo?=
 =?utf-8?B?RVZ3VGtMNDQ5NFRvZ1BVVFhBUmJwR3paRmw4aXZjNlkwblpKR1NXRFA1NUV4?=
 =?utf-8?B?SUlHUWhLMUU5YlV4TnVBeTJvcDZZbEtjanA2NTArQmtZMlZwbUJsMC95YkRN?=
 =?utf-8?B?KzNsZTdZcU9XSlorVVhGbWNTMHhKdDR2eFZ6dVB3L1lWaGlvSDkreFRzZVo5?=
 =?utf-8?B?QUxSQ3RuNFRJTUNuQit5ZExpSWdGNVpLWEVUeUpZZ1p2U0lGQXhCZjZGWWRs?=
 =?utf-8?B?UjhYSU1pQXN1UHlmOVMzWVZxUEcrUjFpUFFhZVpIUUxpY09GMTVaOFQvZkYx?=
 =?utf-8?B?TXc1VTc3Q0JsWmlKNmhVa3QyZTV4SUlCemE0ai92TWlacmhXOTc5MHZjUVBG?=
 =?utf-8?B?RlN3WFZUcnozWFRJQXpBSXFQWGdpbi9nWm9hNWhaV3dLdTNlbUdSaURsM2RJ?=
 =?utf-8?B?RENYVDcrR1BnSjc4ZTRaZnBBSEdJR3o4WDEyK1BHS1dMa0l4cFV6NlB0Q29Z?=
 =?utf-8?B?VkY0eUJFT2Ird1hudVl3OWxsakpMeHlCQ0dOU3NYRmlWdS9vM0lCc3IwSEM5?=
 =?utf-8?B?OUp4VlFYQ1NkSFd5S1NybGllNDlzQTJ0WStFYzBLMXVuNUNSTlZEVHgyZmRl?=
 =?utf-8?B?QnR0UXdOb1FpSVltbUJjWlZOOHl4dkNXcE9OcFR0TVlMVWViZUZ3VWpuVUg3?=
 =?utf-8?B?TU1RY0ttSGZXdzJTWEEzWVBadnJ4L2xleHpUV0wvbzhKMTlmcUNCOVBweGdZ?=
 =?utf-8?B?VjV2UytVUTQ4d2ZlSDlBN3psZ2RBaWhsMmhhVVBkQ3BaQkgxQjhWY1JaRXZF?=
 =?utf-8?B?YkcxQ2M5M1kwNU41OTZ6SkJrbzhMNE5OcDRZWnZvV3hPYXBuVnl5SDZPZVcr?=
 =?utf-8?B?MlBlTXVwYzNCVEtDYzB3Rkg2MUx5UjY5dVZaS1k2VUt2OGtRaTMyZW5rcFE4?=
 =?utf-8?B?WmVhZGIrTVg3akN6ampwRmZ0cFZQVEFTRFJUeHE4L2hzWUs4Qmx1QkJGZjJY?=
 =?utf-8?B?UXdTekNCc3NrZExaa05hdE53NTVoeVZXSExpL2pVSzRWb0N1VlBwY3dpOGhk?=
 =?utf-8?B?TENLMk54bWJya2NabDM5S0xHdm42YUJ4TnppRWxZblpsTXJTQ1BHdExteXVC?=
 =?utf-8?B?VzR5SUhnTkVTQVJlSU1ET2tleUFSa0JYei8rUDV1VW5LaFlHQ2JYZFF2MExD?=
 =?utf-8?B?MVFseHFwNmhCZHVBdDJsNm1lWmtBbi9VT0oyMFluc0NoNEVGUGNiWGJwbHNE?=
 =?utf-8?B?TlYxYlJVWlhrNE56TGdscDYvbkhSMlV4Q1pGeStnNnoxY2NqWU5ZV0lER0N4?=
 =?utf-8?B?VTh4ekJjcnQzTVR5NEJrT1k5b0kraWNVd2JSZ2ltdUlkWHhuTmVIOFpSdDBU?=
 =?utf-8?Q?JYeshIQeMd8k8u4lkctUzu6n3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff33a9c6-a668-44fe-bc78-08dbf2469752
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 08:22:00.6775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKpA5N0r/ITHEfZ5LkB39b72gCaRUZgOjgLXvmy/iIxbjKrSdGflG3E29aXAsMwf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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



On 11/24/23 14:16, Michal Simek wrote:
> Based on DT specification device_type property is deprecated and should be
> used only for cpu and memory nodes. That's why remove other usage. In this
> case ethernet-phy.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynq-cc108.dts       | 1 -
>   arch/arm/dts/zynq-syzygy-hub.dts  | 1 -
>   arch/arm/dts/zynq-zc702.dts       | 1 -
>   arch/arm/dts/zynq-zc706.dts       | 1 -
>   arch/arm/dts/zynq-zc770-xm010.dts | 1 -
>   arch/arm/dts/zynq-zc770-xm013.dts | 1 -
>   arch/arm/dts/zynq-zed.dts         | 1 -
>   arch/arm/dts/zynq-zybo-z7.dts     | 1 -
>   arch/arm/dts/zynq-zybo.dts        | 1 -
>   9 files changed, 9 deletions(-)
> 
> diff --git a/arch/arm/dts/zynq-cc108.dts b/arch/arm/dts/zynq-cc108.dts
> index 593ca4a49cf5..ec39aad1c0c1 100644
> --- a/arch/arm/dts/zynq-cc108.dts
> +++ b/arch/arm/dts/zynq-cc108.dts
> @@ -49,7 +49,6 @@
>   
>   	ethernet_phy: ethernet-phy@1 {
>   		reg = <1>;
> -		device_type = "ethernet-phy";
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-syzygy-hub.dts b/arch/arm/dts/zynq-syzygy-hub.dts
> index 99f248d4e5fd..1b3eddc667db 100644
> --- a/arch/arm/dts/zynq-syzygy-hub.dts
> +++ b/arch/arm/dts/zynq-syzygy-hub.dts
> @@ -48,7 +48,6 @@
>   
>   	ethernet_phy: ethernet-phy@0 {
>   		reg = <0>;
> -		device_type = "ethernet-phy";
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zc702.dts b/arch/arm/dts/zynq-zc702.dts
> index 0106d7bb1778..6083f99dc8d4 100644
> --- a/arch/arm/dts/zynq-zc702.dts
> +++ b/arch/arm/dts/zynq-zc702.dts
> @@ -88,7 +88,6 @@
>   
>   	ethernet_phy: ethernet-phy@7 {
>   		reg = <7>;
> -		device_type = "ethernet-phy";
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zc706.dts b/arch/arm/dts/zynq-zc706.dts
> index ceea982546e8..bbdbf99aee99 100644
> --- a/arch/arm/dts/zynq-zc706.dts
> +++ b/arch/arm/dts/zynq-zc706.dts
> @@ -49,7 +49,6 @@
>   
>   	ethernet_phy: ethernet-phy@7 {
>   		reg = <7>;
> -		device_type = "ethernet-phy";
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zc770-xm010.dts b/arch/arm/dts/zynq-zc770-xm010.dts
> index 199384bec967..ff475f868249 100644
> --- a/arch/arm/dts/zynq-zc770-xm010.dts
> +++ b/arch/arm/dts/zynq-zc770-xm010.dts
> @@ -46,7 +46,6 @@
>   
>   	ethernet_phy: ethernet-phy@7 {
>   		reg = <7>;
> -		device_type = "ethernet-phy";
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zc770-xm013.dts b/arch/arm/dts/zynq-zc770-xm013.dts
> index add75999f47a..02298b981631 100644
> --- a/arch/arm/dts/zynq-zc770-xm013.dts
> +++ b/arch/arm/dts/zynq-zc770-xm013.dts
> @@ -41,7 +41,6 @@
>   
>   	ethernet_phy: ethernet-phy@7 {
>   		reg = <7>;
> -		device_type = "ethernet-phy";
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zed.dts b/arch/arm/dts/zynq-zed.dts
> index 70bc41822e36..1d967bd1a285 100644
> --- a/arch/arm/dts/zynq-zed.dts
> +++ b/arch/arm/dts/zynq-zed.dts
> @@ -44,7 +44,6 @@
>   
>   	ethernet_phy: ethernet-phy@0 {
>   		reg = <0>;
> -		device_type = "ethernet-phy";
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zybo-z7.dts b/arch/arm/dts/zynq-zybo-z7.dts
> index 83b841309798..b621860705c8 100644
> --- a/arch/arm/dts/zynq-zybo-z7.dts
> +++ b/arch/arm/dts/zynq-zybo-z7.dts
> @@ -55,7 +55,6 @@
>   
>   	ethernet_phy: ethernet-phy@0 {
>   		reg = <0>;
> -		device_type = "ethernet-phy";
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zybo.dts b/arch/arm/dts/zynq-zybo.dts
> index 0ce5238c9a8c..c3d97858d7f3 100644
> --- a/arch/arm/dts/zynq-zybo.dts
> +++ b/arch/arm/dts/zynq-zybo.dts
> @@ -45,7 +45,6 @@
>   
>   	ethernet_phy: ethernet-phy@0 {
>   		reg = <0>;
> -		device_type = "ethernet-phy";
>   	};
>   };
>   


Applied.
M
