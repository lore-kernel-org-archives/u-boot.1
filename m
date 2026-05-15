Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D70CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 12:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBEC83EF9;
	Fri, 15 May 2026 14:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xGGWW8jE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1EE844BF; Fri, 15 May 2026 14:06:58 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59AB78341A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 14:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbjpHc7AfxhOzBc5mDx0kjr1ed5Bo6Np/rWl2IWPtPfp1/q49IeNJ7wH15p0axO/WrcVNN42rTlTPGD4oGvlAx9j78zW/8q6klxAyeGgDLiMUQxv+Rb5XPdpf8WZ5ErZaxGEbzVg9V1gLhrdE3A4kjc/yRpGzFNCU9aykoJ6s17YfPgF5agNQjKvNsw7w0V2OB+hPx6X1uglgI/qFCwEcdpYm2yRhNqIPyP3LmgzLD8YMJf72aTbzAzPBtuEyVkYiVrTuok8t0vGU/n0D9KDNKPbMtVoXgXVlriTQCYx1GCaEa18m+3c+msf163LmgAiE0uSJQkAsX81xbuHS5hnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIJHLu7GsCO5LyglFAqLtL6dpfneKrkgygXaqjzoZEg=;
 b=Dc9OgHIUlyT8Bg8zY5UAWH4dFyZvyt6pcQodG5ssQIZfvYioTcUPbVr6hMAidHNHwWICFc2z6/UAzQv1sHw0N498PO6OPjT4mjyPGCPePTnUjkj2+9K27BVHLLiIghSsUVd+TPxns2/cm7/66ew16gA4DojA+7t/ggbQcdq3/oMnox4mei5SSJG5gEQzrdOCBTl3FgybpilpkOoqtEiIsd2eOSARQZjBWkNDc4up9qekg118s8UjMG9//y3GWl7tbqAqfkRpFJueHN1neakdsoSq/IudRFRqOig6Xy/GpPhBy+TNCxK7qjTsjlRKBpg1+O+Q4OqM41+qQrpDkFhIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIJHLu7GsCO5LyglFAqLtL6dpfneKrkgygXaqjzoZEg=;
 b=xGGWW8jEc3cawW0c/sfzqWw+vmuyOcCXWmH2BHqYAIWXQ8bFidL7nfOWu8qYXKZ2Sug0TncPMGJ/WtigrTKlX5W6YJerm/OG4boeA5RfHGULAF1OrW3Jnx9Ha7bJR9xMN7L6naR6IB9QrdDLlISPwHzMfTdenS2qtHuppO2fA/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 12:06:49 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0025.020; Fri, 15 May 2026
 12:06:49 +0000
Message-ID: <d931dd5f-f6b2-422a-9220-095f2dbf5b4e@amd.com>
Date: Fri, 15 May 2026 14:06:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] riscv: Make RISCV_ACLINT visible
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>, Leo <ycliang@andestech.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>
References: <7e80b87009b327aa618117baf223973e10c5b611.1777886786.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <7e80b87009b327aa618117baf223973e10c5b611.1777886786.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0164.eurprd09.prod.outlook.com
 (2603:10a6:800:120::18) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d24cc7a-c029-4186-664f-08deb27a7149
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: y1FAu3dCPMmFxdkzImjNSsslX4JXZUc+03izbYrUWDWrSGo+bdt4S+iWr7K6jCtuDTobGUSti6wjI9i0rnnA9+0/LJBY7jx27PqOW9blkpwOHlZ2FR4qM74uKiJuNN8I5f8MCRl6vPuqnvCOeIsnq4gO6mnBPoiO1LKpadFXc3BmzWJY0m2iV9F4VFjpI+8JwO+Utsq4jIS2UpIsfut/j8jD5LDEGXw1uOci3Aw/LNRDusfOIt++yUy8J3RZ9H31x722+zEb1eeYwQykY3MUdVxzoIMpGV0h6QfBvR+rFGEJZ0tDc4ZIGbGFH9DqDy6Y5OGXYF2Rt9BfZh51NEak0LE0b1QHqcNBhAHsMNmZ07fIXaGofZIy2gs3sWhNV6/blQnjsrvBFwxKhdezq1De7nJ4//u3h4qqI7aPnMZ32hlGUw1K8IsVwsqixp8eIYfIgX9Hel7/EdRvZRp9kyjImGZ2dBz+LytOsBZ4TaX+tnnHmzt0bqzf65LI/ynykUy9mk6MycNsFMs48v3clbmvRg3521oZ8WtZkarUadnSqDBZYTD1OaP79Lz8U86bOcmyykr8mYXBdQVQTKBugtZWdWVGJhDlMbzVhiG61kBFnVpAv8w+RLS8g7Sapwch9KJ6bsf0b1G67Y9vOhWjUKY8DAHE9p5CngfKm9qgHSQ7k6+4JFsQKVMS57RIhpfxHH5G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFVPeklsQ3hnbU41U2hGM1hTTW1zWVVLSnNjL0NCSmpseU1HN2F5NERPMFA5?=
 =?utf-8?B?TG9BeDdQY1JmMnNWR0hPT1J2UW11bklzLzJKOEpIM2RKYWc3ZFpGdGl3enVX?=
 =?utf-8?B?RVcxaEdYVDRlbUREY01zTFFodzFNdW1BNHgvcFRvZGtRZWNHa0ZteEg3RzZm?=
 =?utf-8?B?WjFzUzczZ2Z1dFVGM0cyamhPS3UwKzhpd2sra29xdXFhVmVJaElkUFdNM3ZY?=
 =?utf-8?B?WGJhM3JJOFE2aUNMYjVIV1I1amdGbkllcXlaRTVpc1NwcEt2WkppbFFUZVNy?=
 =?utf-8?B?WDdZTU40UnZNNHVxNmUwT0NqclBCTlhsdTlBR0tzcWhzOEZYYjYweHZnR254?=
 =?utf-8?B?S3pYTk9SSVZZNDA2SjJTMDkzWmhZcTUybXc1M2lJU3FFamRqRGkrOXVmb0w0?=
 =?utf-8?B?ei9XUlFGbUpsTlp1SVNaTzR0ZWQzZlVYV2g3VTJLNXk3UnVxSE5MMm5GeC9U?=
 =?utf-8?B?azkzcjJtYjFPKzFXWEJlR0tqaVBHa3NncTZ6SjMrY3V0MFdwZTJkV2cwZmlO?=
 =?utf-8?B?SWpUKzQyOWNFVWlGdGtybVc4aDBQNlg1VkVxejExeXR6TmdyZGs0SHFWQjEy?=
 =?utf-8?B?Mi9uUzVxWnFuVVV6OW5PV1FjRlBkL3NxR2VZSmdJZ2owbVUwRWt0aUY5UTN2?=
 =?utf-8?B?a2E3dTJPTjBFMTFVTjdvNGdVQVNpaDA1RUVaNUJWTlpxcER2QXFySGR4QVBt?=
 =?utf-8?B?N2lwYVN5cjIwazkxU2lBK01Bd1VSZ2dJZ2FXeGtOSXl1eGVZZktZVTRnWCth?=
 =?utf-8?B?dlJXSjVJaTgyMnNXRW5FcUlrTDdlMlNkM2w5QzcxeGhjT2UxRGduZFNRa0Nm?=
 =?utf-8?B?S0JaSUovRnhjQmZ3c3VIampXWGlSSnUyd0Q4RFE2aVh1OUZST2tDZFI0RHlu?=
 =?utf-8?B?MWdYOS9Oa2VReTNOazJlb2w4K213M0tUZmZKY25Rd3ZvaHpDOEU3bjRTMVZG?=
 =?utf-8?B?NCtaclU4R1krQVkxLzFNVHpRd1ZTK3FhZXVwUDJPUWxwR2dkazljSEpoM3By?=
 =?utf-8?B?M0VoY0VuVE9aZzlReVQvdzFyK2Vhc0dFK3BmbTdsaUlHYVJFSGFWKyszKy9P?=
 =?utf-8?B?L2JTWGo4TUN5RlN6VGJuNmdRc091UllxSldqQVMyUkZQY0lCTUV0UDR0NW02?=
 =?utf-8?B?cW1UcGRMbW1zcXRZeXhJSmhlQ3VOUkUzMGFJK2lwQnhxVHF3dk50enlPZm50?=
 =?utf-8?B?VTh0ZUNPUncra2diTHJZYjVuZUdPaTVRZ0RRYm5VeCt4UTc1Y0dKaDUzUnQ3?=
 =?utf-8?B?LzlqZWwvR0g5cGpmcHF2amtiM1dlNksyK211TVgzVGl3QVc1SlJJVFhGZXBh?=
 =?utf-8?B?VktjZ3MwWXl1S1ZCOGRoM1QzWHNtNUxTVjF1bWZwU3RIbzZkT1NJeXVCOW9O?=
 =?utf-8?B?elIyRlhXcllKMGdNTHFHd3haaHJiWEcxZjlGblVqd214QXQ1cEZuOUxNd3FC?=
 =?utf-8?B?aXdhcXdvZm5LOE5jMkJCMHNodmY0b0pSTlpHRDR4R2srUWJ4YmFSRlBxNnly?=
 =?utf-8?B?RGM2KzhrS3BOMCt0Q2hEZmphU2lOT1hLWnJOSG1nam5FVWRkZjJLd3BmRmZS?=
 =?utf-8?B?SGdHVjlJY1Nza2dsNTlvemZHU1A2MW1SaUQvRnh2TC9MVDA4SFZ5YURaTjFX?=
 =?utf-8?B?Y1ZZYnVvL1VDdzdVdk40ZHlMUUFmVno3R25ReFAvRzA1YW9yVURXYlpwODU0?=
 =?utf-8?B?NnRZYWRXd2c1bmF5Mk1yMjhYR2tTM2VTOHZ1N0ZCN0l6THZkVkZMZm9YdUhT?=
 =?utf-8?B?UFpHZFErMEpHdXB1aFdBNTVjTVNxQ09zZEFGNUpEeEswamU2MXlGMnROU2R5?=
 =?utf-8?B?ZzFva0ljcXEvcHBvOHdNNXcwMWdUTTV0QUZnNkNPbzk5aHJZaVpaeUNyME1R?=
 =?utf-8?B?NTZISS9ESHV2cEU5bW1LQ1ZPM2Y1blU5Y1hJN1l1L2Y3b1Z1N0JUckxtUjZZ?=
 =?utf-8?B?bFJGV1F5NitLeElSSWtML3owQWdzVm01b0llNTZQUVlSQk9lOTVBbWlNVFg0?=
 =?utf-8?B?cHo3a01mSFpFSUlwMW9UWXZ0SDB0NFpVNXNtVzN1VHdjMW5JNFdpSldSM1lk?=
 =?utf-8?B?eHpUU3FuWmYwWjN5QVd5dXdGZXg4aDFHOUhQOFlvQ1RydTdONW1GWTdBUWVI?=
 =?utf-8?B?OVUwRUM0bzNsWlBUYi9sejVRbEJ5NWVJL0plZW9QcUwvazVpTWwwb1B3TU1Q?=
 =?utf-8?B?b3g2OVpFcEIrSWlDMkFSVmhDNzJHVm91R2xxMldlSS9WVUlOWmw5bFhkRThM?=
 =?utf-8?B?dDA3YnFQeVVveGxySWRwZ0M4V2QxVUVOelV4UHViSVVvbnFsWjliZFFKYlVw?=
 =?utf-8?B?UndWdlJFZ3NyM2g1ZmQ4NUFJYVFXQS9nN0YyL3dXeHZGVlRxK2NDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d24cc7a-c029-4186-664f-08deb27a7149
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:06:49.1110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5+FNVPbtl1m0/5uT4kUhRC/aM2IDrL3rH3JolUUWYbEnyFktqSmTjKV0Oe4w7Q8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968
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



On 5/4/26 11:26, Michal Simek wrote:
> A platform (like Xilinx Microblaze V) does not have an ACLINT (Advanced
> Core Local Interruptor) hardware block.
> 
> Make RISCV_ACLINT and SPL_RISCV_ACLINT Kconfig symbols visible with
> prompts and enable them by default
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Make symbols visible and disable them per platform basis
> 
>   arch/riscv/Kconfig | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ad7589123c6c..d14086e9f4dc 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -378,8 +378,9 @@ config DMA_ADDR_T_64BIT
>   	default y if 64BIT
>   
>   config RISCV_ACLINT
> -	bool
> +	bool "RISC-V ACLINT support"
>   	depends on RISCV_MMODE
> +	default y

This is breaking ae350_rv64_defconfig targets and likely others.
Default shouldn't be setup.

Anyway I will send v3 when CI ends.

Thanks,
Michal
