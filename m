Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2962C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 08:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2B688E0E;
	Wed, 24 Apr 2024 10:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LkECptzg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4607788B5C; Wed, 24 Apr 2024 10:23:57 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FAEC88E01
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 10:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av5jl3nEvwyDE9dHBMo8TXmv+GKGL2ciGAdbJGjRtcNvZmfcp5MP8B4PKC//0BNwjtFAmgP0l8+1b+Ai9ke/ifJPrhSCnJ3mg3AR30Eju9CyRaPBQKEkQRx7c0olfc0qkaY7aCFCdVjMJR5TPtvzRcvrbK7PscUTeBORzaSZbjCVrcXq15bfo1EkmS2DzALq0IZ/y81/CHpuGL3myU3KOieZMCSuTL1ELCWXYaQXHtuj2mJB4VtSuBRUx1N5qRYIE6eJAXgVemcjkJbUQ5XcZBxgvx2ZjlsYG2buKVDFvC3RU81J+DUa2SafqSpQKHGET/pbRprxJsymoSmJlMmeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wn81lImP7FYQtVf3Xhv1NgurJOzLcJnddSi1GVcJgUA=;
 b=hZpBH1ffy/W8+23EyPzWoxkfIBJCrAo74gy54F8VJNRg5ELPuCKjcp9wwO3wrwaeXTCVg3e8Ohgz5DL2q/OjXiwswGubadUQLs2UgxQCpEfVgEP35YbMMNY+tCSm6+qEpByYa1l0/+r7nJBKIf7Lb8mFg+pWmWgwGzcY7o5ztS/9bMyrN32Z8MIUDfFp0Yzt+5kbEMSi62PCjqOC0hkP7qpCWJAEYLVjY22Jdjpcy5ueg/5eZlFIhVgR0fz0znqzSFu261gq5U0Pv3bw3knNqDrQnxYqBjZOwCcGMclj8DcsZrAONR7b8UcUSHi4TJfZqN25rjeJepZ7EDsbPzCeDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wn81lImP7FYQtVf3Xhv1NgurJOzLcJnddSi1GVcJgUA=;
 b=LkECptzg/rCR61HoqxBk/uDwNDe34ck7rMY7b+MWB3vMJM7S7wWwK3bJmivnOJTXId3Pr4Xq4oFq8Kl+NCAPvBS9FxR2618FTE2svwF/782TKBR4to6jgYOVeglgMF1H/4zFqM4lZ+XQF0MmfYwSwThcmJtU+4v5//+dWfidrBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:23:52 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:23:52 +0000
Message-ID: <4abee51b-d2a3-4781-9a66-09cc42f7d244@amd.com>
Date: Wed, 24 Apr 2024 10:23:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Clean up xilinx_zynqmp.h
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <fa117ac482591d3d5957af54fe99e6acc89972e3.1713167731.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <fa117ac482591d3d5957af54fe99e6acc89972e3.1713167731.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:802:2::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BL3PR12MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: b10b908f-a67c-4ca8-6e05-08dc6437dfbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEdGTlg4Rno3bjNxOGk5RnEvcmpMTTA0QlFHS0hXbEZHUXAyNGZseno4ZUE3?=
 =?utf-8?B?bTdVZHd3cE4zMGUzODVWbU1aNmpRM0R1eDFyU2I3NXp2eGNUZUFTMENVWmZ6?=
 =?utf-8?B?L2JLRkh5Zy9MUkcrYlMxUUd1K2Zmcll1aDhXa1FDU2o1ck1JU1RvVUg2VU91?=
 =?utf-8?B?RUNmRGJLMjc0STFSdXJsWmV4amtibmc5RTFNWFBMNHNuUjRWL2FzUEoxS2hM?=
 =?utf-8?B?eGFSb0dpbUFUYWNMSXBnYjNTRWVmOGNqdXNEd1kyeTFua21TVndvejJ2d3B2?=
 =?utf-8?B?WjFBOHFEMkp6aWdPV3RpSzBWbHhxazh3bElXWUJFc0N4MWlYYTdVWCs3Qkha?=
 =?utf-8?B?bisyRHJoL0N6c3lBSHE0NXJpTk5jRW9CNEphRnVlU2RrOUYreC9ROWdaSFhP?=
 =?utf-8?B?bFBCR3k1enRwRkxGVkQ2RHN3R21EOXdJSVlxSk9wazc1bUduc2ZJUmFOZG05?=
 =?utf-8?B?azRzbFQ0a0lLYmdpWjNuNnhrbk5sODdhYWZYaDdHb1pyWTlWZDROc0prS2di?=
 =?utf-8?B?TGhMNm8xbnQrcmJzOEI3NjJ4NFdCUWhtNnR3eWJBbVgwMmFjUmEwcERvTkJ2?=
 =?utf-8?B?Ynd5QUtaU3ozT0xEbTRIZC84a0VnaElKbk5WcnJvQVdmeGw4QnMvV1owRGZl?=
 =?utf-8?B?aCsyZ3JwU2E4ai82OUNueHMrTDkxbjFiME1pSSt1ODdYWVhORmUvK0tKeGsv?=
 =?utf-8?B?MGtXUDJROFU2RTVhcDFXdnZIV1lQSnJsak5pYmRKdEFaU3RJdVdDemNFTkJM?=
 =?utf-8?B?aWlQbnpta3hZVTJGNUNvSU0xYXRyQXNSODRCRyszcTdHejJidkJCQUdNUkJt?=
 =?utf-8?B?M0YvZmlZeTJ5WHVNL2J6S3VYR0hLUVZJY2N0aVl5RUNtVjllemFURXRmcURX?=
 =?utf-8?B?UWs0VnN3ekVlWDlTOC9hcm90SHFQRTNaTHdFMG1FRmY3U0xNeFlZN2V5bUFR?=
 =?utf-8?B?U2NPS3hvVWpCMEtiU2R2ZkxmK3YrMXlJNnlkSFpZSU8xdTl3Y2VSUXpsdkNR?=
 =?utf-8?B?ZnJZR2x2ays5dE5IUTk5Zi9zVnZLUE9KRFEzTUd0RDVqY2k2cFNlUlNTenlW?=
 =?utf-8?B?akVnT2UvZTloVTdTanBvUEZZRU9RN0pQRm0rYnpwSDRjdG9SRVR5OTVOMkJx?=
 =?utf-8?B?ODVQRERYMW5VbFMwWEZpOGdUQlBvSkFQUENwb2xRZHhtcjkxNFFXVjZFWkdK?=
 =?utf-8?B?bzBmTFp0b0xBTUtHb3F1eVZXQTlKbWd5R0lVRmJEaC9IbTdsK1ZuRGJCYStZ?=
 =?utf-8?B?U09BNWU2RFhLR1l2LzZJazR3ZVAwUFh3d3VEQ0lKRnNUdjF6c3BRZ1c2ZERM?=
 =?utf-8?B?emwwdWxBc1F3b2FBak9xSEp0cXo0TEZCbEFYL0RXKysrNHdSNDhaTUx6K01h?=
 =?utf-8?B?TkxhL1NDWDRGMjd6cG1aYmpjdjZ4MVV0dmh5TVpMWDhYMXdKM0Z0ZXdwZFRJ?=
 =?utf-8?B?RTE5ZkpaMi9OS0wyRkltclNhY1BtQ3haVDYzWFRSQ0JpekFwSUlDM0R4VkRh?=
 =?utf-8?B?TUF2ZUkxWk1LS0ZHVEVTT0FpQWo0bk9yRTcrTEhUaEp6RU1XSzFpMUhXYmxJ?=
 =?utf-8?B?b3VVUnR2STdXS0pJcWcyTFhJaVVGNkZMWUVTRXVMaytUYUNQV2hHNUFPTHRi?=
 =?utf-8?B?cEV0UUkrYXdUaXFTdEtmcnNuOHJscitLd3dTeHdRc0xlUDI1djJiZUtrMkxC?=
 =?utf-8?B?bWlWTFdjaGlaZUdIOFAzZDJVbllJQ0NPSmZCZUFqdEpkdjVvQ3ZFcGJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hnWWhZWmFXZXpFdjZXQXlVYXdrRTk1QWU3TkhnUGxlRlc3RkdIOE95OVdk?=
 =?utf-8?B?SzVqM0IyUFI2SzJlbFN5THJ5djhZU1piZnU3SXdRL1dRYlZmYUFQOUtwYWpF?=
 =?utf-8?B?QzROU2FlbVBaVjNtK2hMNVMzTXZsSURMQkRzTVlPMUZiRWNVcEwwSzFCUHpO?=
 =?utf-8?B?OWg1bFJ2dVl6RzlsdEdoMVYvMUR4Y0VLb2NjUng2eXF4RTBQQ1ZQNEsxZUFm?=
 =?utf-8?B?MXZLdnBWZ08xcTlZaG5KaXZMam1sVUE0MTA2Z1EzUE54OU90NmZBRlNVZmFm?=
 =?utf-8?B?aTVwSkhWaEtsTUc4cFRUSFZyWFo0NVdaTENHVGpNcjZleHdEM003Q2x4QjVU?=
 =?utf-8?B?UTJtdTVVZ1IrY2czTDgzMGtCY0ZGcFk0K1FacVRPUmV4ekZYZHcvNjYxTGZo?=
 =?utf-8?B?WHByd2xuaHZWSkpiSWtud21Kb3hHdmswV0pna1lwOHZ1Tm9JTjQ2VmdBTDZq?=
 =?utf-8?B?WUhKMXI4WGdGQU8rYUlwK09NcWZnYXNncGRia29GY0ZMS3A2cnhqVnNXUCtX?=
 =?utf-8?B?Y0JVekd3OEVlNXl4dFdyS1pYYzRRRUF6WVRIdWtjMjdMdEhER0g0Q3NpVWVy?=
 =?utf-8?B?WGNWY2k3R0hVM3VmOVZsRElqdnNvbnVQdGJzT1ZySlBxRnE5TEZPTmJtVUhr?=
 =?utf-8?B?bitQbHhvb1BnNVN6bUpLaW10aFFSSGQvbFRjTENPN04vSElXRWhqTHA0T3M4?=
 =?utf-8?B?a2lZMW1Yb0Y5OGRlZC85R0JmaEQ2WmltRmc2b3dIbUdCTnowVGFQWFRta05Z?=
 =?utf-8?B?aFN6VUQ4cnN5eUhmQmZiMFpRMHNWcnVvQmpQN1FadWtkdCtwWmJobGZLK0dD?=
 =?utf-8?B?aGxCbTVndGNUMEt2cUhUanYyVlB4dEtMWG0wbFRua0xCRXZ3ZTI5bGFNQ3FB?=
 =?utf-8?B?UmovUEVVMTRGM2NuYlUxUkxEUGNMMWswMXhjRTdjSmt6bVZicG1DemgzL3FK?=
 =?utf-8?B?TXJQbXE0TnY5ZGZwRFZBOG5ZN1Nldmx0bHVxQ05MOTRTUENuMmRXNFo1ZVo2?=
 =?utf-8?B?Wk5XRG9aNkNnWHo2a1o3Y0Vxd1RjUzVrMTdvYWJBQzVyRVp2cnNKdStUMkkr?=
 =?utf-8?B?bWZKU2dQWVQ0MWpSYzZNRFBtalphVHUzamdPay9BTzN6YlhUMEZyV0JIU05C?=
 =?utf-8?B?azZpNTBlaG5Tc0UzdmFxcEIzS1lBMGxFVjJnbFZldmliTlRvNFlBYzFlRzRF?=
 =?utf-8?B?MWpVQTdlelhEVWxrMTExS0VnY0lXVUF4bTlUSGp4Vm03S3hnKzUxLzZVQ0Ur?=
 =?utf-8?B?VDNKRWo3UXB5U2YzK2t2TFBORjkwd3V6V203OHUxV0xzTEwvT3I0elk2YUVH?=
 =?utf-8?B?bzN5eXZwUjRNbEthbzl1SkNWbWgxUCtjUVAzL1FMQTdJTnpMNHc5cHlzS2xS?=
 =?utf-8?B?MnVSNUlvaDNpR0xUNFd1NS8rd28zS2F4cUpOcnlvdTM4K2c4UVIvRTdTN0ZR?=
 =?utf-8?B?dzlXTGVTa2dLK2JTMjZ3djA3L2VMRXNDQWNvclorV0RJVmVlUTJtSVNSKzNt?=
 =?utf-8?B?MmRGVjVqRmVXZjZpM0tSWHRvYlQ5NGJGQ1ZkbE5JYytGNmtjUkdMdzhPcW51?=
 =?utf-8?B?RnpsNU12bjc5RExoZ043dVZpWG1mYytMalA4Q1RmcGp4WHhGcFFuVVppZHRK?=
 =?utf-8?B?NW02TFMrL1RvbXA3NUJZNFBUdU8vcE9aL2s5U0k5OGdpUGFiM3Nwdmt6WVVO?=
 =?utf-8?B?NFdJTzV5MkhQdzJ3T0RFakREbmx1YjhoSkhZa1djRXNJVmJMZSt2YUNGazZ0?=
 =?utf-8?B?dmFuRWlRTHJiV255RjZ4bmdRMURNcytuZEdoSEZYeXVpTldMTlkxOXpnTWxM?=
 =?utf-8?B?QkU4VFJMOFpyY0pBc1V2Ujd3cVl5WjlFd1RBZG9venFWbExEeHFLRnkycGtZ?=
 =?utf-8?B?UG9RSTYxMFVQOUJ0T3JpZXdHWGI3WlovaDlTYW1uemFSTHFlWStaN25EVUl0?=
 =?utf-8?B?eCtXZGpWRWxscmQzR25hUk1kWkgzYW10M3o3ZzhIWG9iUFN1REptdEZIVFl4?=
 =?utf-8?B?ODBiVUh6b21teWxBRmRrUWtMVWZzQWdhZVh4ejk2SGNwdUtzRzZybVk2QlhT?=
 =?utf-8?B?Mk1PSGN1UjIyb2Y2cHM4Vk5MVEZFaG5QK1o5am0zZ2JsbmtMaFJuZWY0d0NZ?=
 =?utf-8?Q?mJZY/5bgx3JyR7xOwq7upgYzd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10b908f-a67c-4ca8-6e05-08dc6437dfbe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:23:52.2024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZTAeTcrRMR/dIwAnOpamkqb02IoKL6yvwCM/KdrdaMYfKpYkPDnHxOU08EHbsld
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
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



On 4/15/24 09:55, Michal Simek wrote:
> Options are moving to Kconfig by running sed and comments are staying in
> that's why do clean up and remove useless comments.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/configs/xilinx_zynqmp.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
> index 5bc117e19000..c5cbb76645ef 100644
> --- a/include/configs/xilinx_zynqmp.h
> +++ b/include/configs/xilinx_zynqmp.h
> @@ -42,8 +42,6 @@
>   # define PARTS_DEFAULT
>   #endif
>   
> -/* Console I/O Buffer Size */
> -
>   /* Ethernet driver */
>   #if defined(CONFIG_ZYNQ_GEM)
>   # define PHY_ANEG_TIMEOUT       20000
> @@ -204,10 +202,6 @@
>   # define CFG_SYS_SPI_ARGS_SIZE	0xa0000
>   #endif
>   
> -/* u-boot is like dtb */
> -
> -/* ATF is my kernel image */
> -
>   #ifdef CONFIG_SPL_SYS_MALLOC_SIMPLE
>   # error "Disable CONFIG_SPL_SYS_MALLOC_SIMPLE. Full malloc needs to be used"
>   #endif

Applied.
M
