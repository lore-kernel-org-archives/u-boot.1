Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25B3C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32CA387CB0;
	Tue,  6 Feb 2024 12:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OjelF+pl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646D987CAE; Tue,  6 Feb 2024 12:34:53 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431D587CB0
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:34:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwsXbjocWxmfwpv/VsT9sbAiN9GGRztmFAwd2APqT3XPvqghgzp9LyfLCgZfzbRcwFx3b3D0AM0HKzvKk2MeV/qaP3CZgcKDugUMusx1EkHuBrtR/QoZKFhTSGCQIKmWmV4m0FV395Qsuwr5TYkv54crGwhH1XM4Mxhj8XxFRituXTLPzF6zeNlW9mqHKFmqCQxWHepmO5/wuG7ljdlxe80balI6Ns1GQ5sO9yqxm8Z0xKU9K1kdDo3iQ6d/kyA5XPohOdm7y54Mtsnx+sVzc+yTQZ0WUzhg9lJxIuh4aoaWCWyz79TTA0d712RkQOTcTAqT0tI+xuwn1B0c+loOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVT4RKjpUSEQPL9kd6/xGjrJA67DsyNTcfoWiRKavzs=;
 b=cbeI69UPbjR2xkCq2XEVWIm9URRpuTIZ21yMjOYIPPVS6JCu5RXeKXf20MY5QwvtQMYH1cv2jiHRHOMToj5xL4TAaUdKSbFlxn421LxFG7ZgZI2yciFshiN/2JWJ3bA2H5V4y9NFOQgyc2miOvXGt+au8w7gputd0sN7gzTviZ1K613h38VES9WYAoJxmnm3h1OMU9f0eA/j9xLu4Rkrw3LVitkuUweD0XPcUMCOELals7qYz76uxGvdxPlAxmsaxApSCdtiV9ztjSSYq3GNqy/Rf9VZD8AkzGyHSslhD8UGgtaLbsb/RWeLSYhdt05Unn64t13vc9W3hFQIQ7np9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVT4RKjpUSEQPL9kd6/xGjrJA67DsyNTcfoWiRKavzs=;
 b=OjelF+pl6IvaeNFwf5Byl5nfsh/JoP9lvX8v5dysgmcpN/0p/YbeGXZN4wd1XLBk+C/8y9lYzyp9MUutXFdWg5iv47iDg7oMMCCaPJABwdvW1pP6sMRkFw3+Nn/zVEq7+rY8eByl0Z/ld2DQHeVMlGXv4UiA39VyxEgyhmwNgW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 11:34:49 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 11:34:49 +0000
Message-ID: <ed37b580-7a97-48a7-a2fc-cb9c79a47af0@amd.com>
Date: Tue, 6 Feb 2024 12:34:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: versal: Enable CONFIG_LTO for mini qspi/ospi
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20240126080900.3209323-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240126080900.3209323-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0073.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::26) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: 8416144a-7dac-4d87-8423-08dc2707a04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aipxEL9x+zLlV6XpiGwOYNT2eNuxGNSsEa+04Y7GJm14WbTvD2xRVLVYTOozdZ09EV8sJY0YnfzuuRUgb0U5/rMHjYy1PD0nKzPe3RY6R68pk1eUb9YLePrs3fdNuRW7HkYDkVmY0Nu+TJOyUv21ieNlD3YYANv4dBN8ADTFTwjHwO2WquLEz6wzPWUZeRH4DTA87Gl/N5lRNb69qJo0A+89xOCSTJCYkDZD33uP9WQGXpCG9O3+GT+AS9LDTVVTFpkC+jLOo02ojUupm5CQbLF0QhLdljycT7PVwVbRH9xxpYHnt3pZZk2VySufF9tLAQEOtKkOgaN958/Zfmd4VeyFKq8vguepCx2tDdCaDnrnWXOF84vpWHFJnhW8J2j6LDnvmVVnobyrt5/00wlxerI18fNA21A7NcrQ+bdzFk7IYI047y1jOBkL8lsaWmaRjLKfGgZMS59U1fGGYrU4IX6N1ZrwzLfEbo1IKkplGbigqgZQDtyHf/g5L+lcC3t9WwKnn+/yS3iXFTaq1CuEXUsIUDeKqhyYOPZvNnxNTKPqqSM2/AYC3pqm4/faxuE82c6XfwE5kOYVz30vEEazT1FLvbcnEsFb0RldDYsgR30NY4OpUX62QQqQQd4Hn7bt0HqneCT696rNRq809LuMqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(86362001)(26005)(2616005)(478600001)(38100700002)(6666004)(4326008)(8936002)(66556008)(66476007)(8676002)(5660300002)(2906002)(66946007)(316002)(6506007)(44832011)(6512007)(53546011)(6486002)(31696002)(36756003)(31686004)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlYei9zcW5LZHBvaTdESmYrenhBb0ZBenltaFRuVEFLb2phcS9YVDBBL2p1?=
 =?utf-8?B?Z1pHWkNTUmoyUU1IUE1CKzhSb0lDUUFiRDNYd3I1VUsrM2o5djdhVHc0SjdV?=
 =?utf-8?B?dWpSYmR4T0FCcGFKRFlUeE5TNUhZZ2lBZm4xVjVRZXFBZ0RQS2xBYnRNanVr?=
 =?utf-8?B?Skk3amxZWlpxK0tTRDJpMkZOU2Zuam1KUWVyV0ZrU0hjU1d0blhoMFpaV3hU?=
 =?utf-8?B?a2doYjVNRU9vUGdWdlN4azlIdzVqV0xJWjFmVlEva3BZaWlDYjZUek4xd1lP?=
 =?utf-8?B?UTFBczEyY0ZEZXZnT1pTQm5rRmd1YUU4NEl3S2F0Q0w2dzBBak01d000WUxP?=
 =?utf-8?B?RnYveXRRZGx5cmVzT0VOdEMydlVhMmd6WWFmWCtZeHlOTGxyTkNXNTF6bDY1?=
 =?utf-8?B?RUlaK1ZFZXZoOFdvdGhVUEJCM29OZkZaUHF5U1dzNWZRb3ZjMGVyQ0ZFUmMw?=
 =?utf-8?B?S0lOYTBPeSt6dStEbTlPRW1jWDZqZjdaQkE3OHhBQVREcGc5Z0FSTjNMNFdr?=
 =?utf-8?B?WlRnZWNyMGpVc2xCd3ExSGZnV2V3bWdod0FhMjZiY2ZtcXU2Sk5KLzVMbFBG?=
 =?utf-8?B?dHJnOWxmVlM4SVdUN256cnpaRDRDSSswbWJVWFplc0o1TUUzZG9ZeWRLb1pE?=
 =?utf-8?B?UmFDMm1xOUx3Qm9FMTU4eUJTWDlaU1NtNVE4OTAvQ3V3QlBhcjV2T0R3V2tY?=
 =?utf-8?B?ejdsbHJCczhaNWdpcVZQcGdJaGJlbXBDeWZUTGRuV3praHNuenV0ZDVvVmVK?=
 =?utf-8?B?Q3llQmVkNUordGhhWVhZV2Q1MDd5ZlMrcFNUR0d2c09KYk5KL1RCYnJ2L0Uy?=
 =?utf-8?B?OERpV1BXcXZvWkVZK3BRZFJncXRHdGtLZkxkSjVraXEwcDhMbDEyMnJyd3ZY?=
 =?utf-8?B?M28wTU5FVnZIRlBENVVjdS9nUndNdUVxb2d3UXRoSDI1VW5UYXR0alZRcTAx?=
 =?utf-8?B?TTUyRFEzUXBFSENPdHBrelRuWmFJTzV6VVVNM2JjQ3lhYlQ5Szc0ZEliWElj?=
 =?utf-8?B?cmtmMnNETldrMS9ObzdDM21JK0oyaTJqTnQ4UHRES2NsbHBVa3lodkd6cnh1?=
 =?utf-8?B?MjlJMFQ4RjkyMnh4TEZoaXRGVGYxazVwNjVzVjhvTkNJOTlqUk1HMUNJNnVR?=
 =?utf-8?B?UDlQQWoyNDJEOHNJTTZ1V0xxbjIyeWxqUEdFV0xKb0duK0QwbnFGVGJvZm5Y?=
 =?utf-8?B?RUIwc28wS1VjdXRublh1cllPUUlTMDJGekVDdytyUVl0NERwZG5JREU0U3FK?=
 =?utf-8?B?eFdNT1lSMUh4ajRwakNEY0J5eC9FeVhKSXlKK0NOL01EZXd3TmRVUFZkSFdH?=
 =?utf-8?B?eXVPeW00ZzZPL29QNXU1RFIwYU4wQkE2TFY2TjB6Sm85cElaNHBUODd4SGZQ?=
 =?utf-8?B?TUJiSzA3NG94MllnbHNSK3dYb3JoRCsvaUU4cmUyYW9JRmxTY3lQVmx1NW9n?=
 =?utf-8?B?eG92dEtVaEExak56U3pLR2lMeU0rSDQ2cjFzcnVqdGpyYTN2aG95MlVXeHFG?=
 =?utf-8?B?QkFQOHlNOGl1WUhRdVFLbW5odXIwVXBCVkJhWW4rcGRmcGxteGNxdjNnNTV3?=
 =?utf-8?B?aUIzdWxrMzI5SDRkVUk2enM5RWl5Z0JBM1lOdkgvUjdDQ2M0T0RKNVVHaCt1?=
 =?utf-8?B?eEV2WGVjRkhZcGU2SjJSL2h5MHZ3YVpkZlpLVHkybjY0RkJTcGRsMnd6Yzd4?=
 =?utf-8?B?ZEMvSXI3K3FrRmgrc0ZhY29YZUE3MHhlTGFyM1FiUVk5dUJiRHAxNFlQalN6?=
 =?utf-8?B?YjVieDdoNjM1L0JUSzE2RXo3MEF6RTBObVNKZzBWTVZGWjVuZ2tZb0toa2VN?=
 =?utf-8?B?Y3RrcVNvZitEdVdxdyt1K2IxNENOU1NFeHVyZXpqOThWNkpycGVnTTNDNjdx?=
 =?utf-8?B?bGJYQnpBZEkrcVlZMnZLWGxtOHdDay9GUFgzWEFzajd4bU5ZcjJTRURjZW5G?=
 =?utf-8?B?TENiaTNBM3Y1bUZyeUI3Uk9FZUFZOWdNL3pOaU9jL1RXdUY0dERWVEsyWXNH?=
 =?utf-8?B?bVdrTGQ4Nm9oNlRqN3V6QUlsYWNMYm1QRVM0ZTJUMFE3bXpiTEY1WXQ4ajVy?=
 =?utf-8?B?emxiTitqRGVkemx0dUs4dVAwL3ZpY1lJalllUUVvUUlNTlg5U1locksrd1F6?=
 =?utf-8?Q?qj6EfHNFjcvzKvPCrsCUXrfFR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8416144a-7dac-4d87-8423-08dc2707a04b
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:34:48.9429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoPXrhPQkNxeSI3QgsMxBGBIu5UawWHs2r+rykXaaouuhoNx7zvrqQHPpRZNkhL/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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



On 1/26/24 09:09, Venkatesh Yadav Abbarapu wrote:
> Adding a tiny bit more code for mini u-boot leads to a OCM
> image overflow. Fix this by enabling LTO for this board, so that such
> changes still can be made to the common U-Boot code.
> 
> Enable building mini u-boot image with LTO, which results in about 8KB
> reduction in size.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/xilinx_versal_mini_ospi_defconfig | 1 +
>   configs/xilinx_versal_mini_qspi_defconfig | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
> index 72a123d965..7a110350c2 100644
> --- a/configs/xilinx_versal_mini_ospi_defconfig
> +++ b/configs/xilinx_versal_mini_ospi_defconfig
> @@ -16,6 +16,7 @@ CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   CONFIG_VERSAL_NO_DDR=y
>   # CONFIG_PSCI_RESET is not set
>   CONFIG_SYS_LOAD_ADDR=0x8000000
> +CONFIG_LTO=y
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_AUTOBOOT is not set
> diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
> index d9fbac986c..58945a1cac 100644
> --- a/configs/xilinx_versal_mini_qspi_defconfig
> +++ b/configs/xilinx_versal_mini_qspi_defconfig
> @@ -14,6 +14,7 @@ CONFIG_SYS_MEM_RSVD_FOR_MMU=y
>   CONFIG_VERSAL_NO_DDR=y
>   # CONFIG_PSCI_RESET is not set
>   CONFIG_SYS_LOAD_ADDR=0x8000000
> +CONFIG_LTO=y
>   # CONFIG_EXPERT is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_AUTOBOOT is not set

Applied.
M
