Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522C0F419A5
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 13:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A821A83B99;
	Wed, 15 Apr 2026 15:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H8jhLZ4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C6484129; Wed, 15 Apr 2026 15:08:37 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D74C83936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 15:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYI0qi5SnNwAnemYiqdSBi6H2HdFXIdiqip15R6mUyXzfPFVHjFbmUIllOneMchtOmq1hB1Er9BcgM9mLIEcmNcBTamgDmyJHbbbujucNehCEa2z1+VmW023UwUcvrBeGmtO6f1RshOME5OjvWhNPqXaPWsPttbxLLHn1IvRe3BbTsGqO2149Gmk+WufWwyn7zxtkj8w/kRZxiqrhCN61RDU8Ng70aG9flXo407lC46wxgQUsuxZFSir7Klf2nOEu2gsGwVWNuXr2MOPeajdZTYpFdpWK3+5TggW5AOPxSTdhtvqzN1b9LLv/Ox3wdSgEwD8/4+kvoKq0+5WPo4Rhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjniXfYABQt1OoM95dxn3YXGen6+ItgYKLrFWe881Po=;
 b=kOmQVPoK/d9XrvtS+4oMPyFPtfatJUgIWEhEUmNcIYzCr24ajYIheEhmxAOAT6f5ZtaSEidanmPwYbX+fLw+/GpSi+1qVg3S+l2rQREA3tDgyMNtV8q6oFNxOiu87XaCBwNTF5Uhl84aGK4a1N6e9ZHItGANZw/GfLgvX4mvjnZXqxo2VXx2ckkXUGo0IJ5Bva0yUEn4tqAD4TqlTjJxcI89MQXQCRbG6tOA7zDWWQWsEikfa94eiEIgCc5B7Q8kaH4Lqlro8uFYEW+Z6yD2+wUWOmwrfhgseUnTbGa5aTU4C4+uQHtSeyOCHBzQ0Cg2w9I8gc9iaEtjED56M/KrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjniXfYABQt1OoM95dxn3YXGen6+ItgYKLrFWe881Po=;
 b=H8jhLZ4x7gmvHa9pOycz7c4yyJDInODEbWsneIoQTeQxxa9aH8MAJoUng/n8kAfzvpMx/SL3AojGRVhvv+ESlEzzTYK9ycV6YT281xYnu9I+xvStd6KrqwgKivs7z6/vKjpMGodEzxDWgoHNkKFFGfTvM5peR5irzP9uHeVoD9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 13:08:29 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 13:08:29 +0000
Message-ID: <ecf75d3c-da6a-47d5-a5f5-e3974082a1d2@amd.com>
Date: Wed, 15 Apr 2026 15:08:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fpga: xilinx: Add option to skip bitstream ID check
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Tom Rini <trini@konsulko.com>
References: <4951c9780b251212ee38ae0f368fd79e6a571c11.1775558028.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <4951c9780b251212ee38ae0f368fd79e6a571c11.1775558028.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: f3ef9699-f645-4101-7e11-08de9af01692
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 0jPnx0LSkS2wyNNPz4Uurz7Hx+PPRivkkZpoYAqJXIFpYd591VKXepMjSaexsmgblpuQ2YixmCLfEk409fdZt4W/Q267tf6TDuB3CLT7kfop28eF7gRXkTzYYIWUPdnC5aqM3LUr84lo2DR5viH6tGnxWpaVwO6kyaUppZRjx3SaQWR7v5WCuk49fh8bDx04HGrDdDAjz9cZCVJHY6/jz+YvppTFY65dvzpTBhVaD7U3q3+ey/jumJ/Bi/gRZflF98nbB1iv1XmfknHqLDtB/Sf/ckUKC+/LxWRCpS8pekbvpf7yEyiqHU4aHpSWGL3Wj81BoifNyuamW+IPjPUcIiz9Ahh2Ertyb3cxCiM2iaW22qc0cvx+N4B9N+BBcK2kPqtmVoqv9B/k/rYT312GG6rd/rYTwGKpE/ULRDXLGPrk9ELKlZVKfdFtuC1EuF68IDaY/ppRx/miHQG49YQh+bVnBwaSDCcGKlk3AceH43QQmn52vM6KUnrhi0ZYqRiz+foKffr9Mmr/f3Dc4RRPsfZMqXs7a+y7I0MnpsSxhu51L6ghIcTYTMZOXd6HC1RzheBfBQOxjTxwxw9oNXACF5Q4ke9QvM9ussekIsrGgp2LqKvj4kUYN+B4YAbK3pr45FRgbn3NB8BkpE6tPa6G4tIoN0ZbLHjW1XYOpRsfHPKuWzJfCFzzgZ6kVxpJejb/L026AINlid55xsiOFT7zyIWUTmLGkPfnuAHjMDa/LUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFdMYmhKZVhWRkIwM3lVLzlwcy9oaXNiMUlHYk5wcVdXWlNXSUF6T0REOVUw?=
 =?utf-8?B?K2Zma3hRTkJ1OEFoTHhFWjFVMkxmdUc4RlZ2R3BKQ0cyMXZ0QzREbG9GT2Ft?=
 =?utf-8?B?T2t2eitReWd5VU1JOFpsWEYwZUFGNjI1Y2dQNlpZOVNRS0l4aXc2MFExQ3oz?=
 =?utf-8?B?QWJDVWhXRFliSmlEdkQzbWxZYnVVNFJHTFVRUnpMUGV3ZkZtSDNiM21KUzBw?=
 =?utf-8?B?dHpDYngyMVZzcXFvK2RtcS8wYTFweGpQNXV1WFc4a3NuZHRBVlZIRm5Vd0Iv?=
 =?utf-8?B?YS9oQmJObDZwL2lKb0V6Zm51Y21VbkdSbzVBVVA0SFkzMkVJTk8xL1JzSkJK?=
 =?utf-8?B?MGdNbkNrKzRXQ2RZRXNQVmp5NUcraGd0dDJrbE90SVRlbzB6cmpDa0VHSVlF?=
 =?utf-8?B?em5hVlpxcXFtU05BWk9ROGUvMEFkVm5lUjJmZTdITUZaRmxnMFVib2pIS3gx?=
 =?utf-8?B?RU1jSjZ1dzgzUm8wZUxBNFlHbFJxUGlZaEIzbnVzL0h2ZnVWSEc0S1pSMlcv?=
 =?utf-8?B?dEZkOFVBa2F6QmNWY3FmY09rTlZuVlBVWTRnSDVUaVV5VUM2RWVnWUZhUEIx?=
 =?utf-8?B?Z0ttY2VBTW5rVXVFQi9WdG5wNVo0ZHB2RWR3K2VYanZmR1ZNWkxLeWxZSTYr?=
 =?utf-8?B?OEFhM1BZSDdwdERpeEs5Yk9SMVBMTXJWdmpNYkhUWjllRWRkQ1RPd1dWdmJy?=
 =?utf-8?B?Q0NsQlo2Z2s4b0RTY3JtUGxWejIzbE81YzJkQjNFbTFjSUMvRy85OG5kSUFC?=
 =?utf-8?B?TndHMWI4TGVINXdrZDB3SUhFMCtWTWlmTlV4WEthM0J6OXlvQzdCN3lUR3hR?=
 =?utf-8?B?UUhkNjVQdUtwN2hjNDJiTEU5NWtRSlY2SzI5dzR1UHFaS1U4TG8zZ3BML3Jl?=
 =?utf-8?B?U3pGMlorSENaMEZEeHRCaUYrcnE3bjVhM2orMkRwcEJTTjFJRVBNUGtSY0Qz?=
 =?utf-8?B?d2ZlM0dqS2ZHRy9nTE5YRlF0TUJObTF0RThQbVo0KzRlaDNuYlVrVFlrNm1U?=
 =?utf-8?B?TFNYMGRkUCs2czlvdFFpUHRucEw4akV6MWtMZWxpZ0g1ZkQrREk1MVRZSDZm?=
 =?utf-8?B?RnVWaXRXUmE0akdrLzBndmdzdi91R0dtcTRubjdUZ0JpazdQNEN6SVlzTG0w?=
 =?utf-8?B?QXpxVmlYSEFMWXd1eHhFRXdtTlp1b0cvWXZHeW9odDVpVFRrbENYOE4wMStC?=
 =?utf-8?B?WWhEaldmQXJoZS9DRlFFOWZqcU5NZzM5UHRlbDdFMzdTNTVKeEw2dGpWeS8w?=
 =?utf-8?B?YjNrQWNNV2w3cGxlMjlqV1hxOTNhSEZGQXl5WUcrOGZGSjlzMUxKWVdaTW9Z?=
 =?utf-8?B?R0hZc1BMRENtMFVHWDFia0hNaUxTclltbEZmZFdYV3BWL1Q3dFc4bk5BNGVt?=
 =?utf-8?B?YkVBZ29lUEJwd1BLUTVsVXZ0M2p5bWdla1JtY3NkMmhRNHIrOGdROFF2ejBD?=
 =?utf-8?B?TEhwVjllaUthSHAxaE5pQ1FPNDlYVXNmSEsrRGxib3VDRXhTUHdlM1JvTFVB?=
 =?utf-8?B?dVYyZDQ4QjdkOXUrZnVFSVdCMDdCMUlmTDNtc2dwYkxWMXo5QVk5L0ZoS3Nh?=
 =?utf-8?B?NVREZ2xJUnZNYSt1Ty9QWkRCVjk4bExIQlU2SUk3MUNTR1BaL0dZdk9qTFNv?=
 =?utf-8?B?Y0x3OXlwZFNJZlQ5K2xSaVlld1g5di9zMXZ4Y0x6cG5pczFvS25SVHZLL040?=
 =?utf-8?B?cEF1eis1QXVYRnZaZStXczd1ZnVIcG91RXJDVTRaUEltb2JBdStxcENZTXNT?=
 =?utf-8?B?N3g4UWFwbEpicUc0R1NrV1JlRXRTZXBlWTV5S0JIUVNwTlN2eCtIbldwOTk2?=
 =?utf-8?B?NXA4d1BNTHNIbmNuTm13cWdRQjRrWFpYU2JJeVp4RTlaWGNyVUdGYXVETkQw?=
 =?utf-8?B?dWZVcXZiRWJqOUdUNzdESzNJOVFrQXk3N0FEdFR0YzFzU3plU1JPSTdXMXdi?=
 =?utf-8?B?bEdiMmhrWWJXN05uMThJTkRUUTdGMVJXRnR1a3JxSTJnMlhmUXVzd0czUUg1?=
 =?utf-8?B?WFRORVVTMWlFYXhJNE1uenFDUUY1aXA1TXlyaGJBbFdSU3d3bGltNjJhUnlZ?=
 =?utf-8?B?TWJNbjBWSjJHdHQ5SmlVTkhJQVA4YU1EbjByT0gzdmNJRzNrVWtzbnhNZVdB?=
 =?utf-8?B?bnJ1ZnpmbDdla2REcWFzUWRNN2R2TmhWYWJrclhOWGNZZFIvMy92R3BEWjUw?=
 =?utf-8?B?V1Y2MElpUFZ1ODRFSkZ1SmV2Wks4WFAxcTdwdnlETkZObnZhZHo0M0R5VWJC?=
 =?utf-8?B?MmVRMU9LdmszQmZNT3RqcmVHb2V4RWVEZlNzTmNFNytqN2EwTzNIcGlna0Ir?=
 =?utf-8?B?RmY5U3JuYll5czdWYXByNisvZHEvMkk2akxzTGxsTVdXWXJvamkyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ef9699-f645-4101-7e11-08de9af01692
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 13:08:29.5720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cz/RtLIFHPLwYmL9Q9zIJ3MO3FWuSasAWk/XD7cDqZg6RPvNxvGhya7ZaIoDy0aJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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



On 4/7/26 12:33, Michal Simek wrote:
> Add environment variable 'fpga_skip_idcheck' that when set to '1' or
> 'y' allows bypassing the device ID validation during bitstream loading.
> This is useful for loading bitstreams on devices whose ID codes are not
> yet recorded in the SOC driver.
> 
> Usage: setenv fpga_skip_idcheck 1
>    fpga loadb 0 ${loadaddr} ${filesize}
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/fpga/xilinx.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
> index 25b348648eff..dd8888b908a7 100644
> --- a/drivers/fpga/xilinx.c
> +++ b/drivers/fpga/xilinx.c
> @@ -11,6 +11,7 @@
>    *  Xilinx FPGA support
>    */
>   
> +#include <env.h>
>   #include <fpga.h>
>   #include <log.h>
>   #include <virtex2.h>
> @@ -92,7 +93,10 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
>   			       __func__);
>   			printf("%s: Bitstream ID %s, current device ID %d/%s\n",
>   			       __func__, dataptr, devnum, xdesc->name);
> -			return FPGA_FAIL;
> +			if (env_get_yesno("fpga_skip_idcheck") != 1)
> +				return FPGA_FAIL;
> +
> +			printf("%s: Skipping ID check\n", __func__);
>   		}
>   	} else {
>   		printf("%s: Please fill correct device ID to xilinx_desc\n",

Applied.
M
