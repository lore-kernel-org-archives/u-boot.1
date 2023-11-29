Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BD9C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 11:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1210286D4C;
	Wed, 29 Nov 2023 12:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GvAXR3YT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5430B876FB; Wed, 29 Nov 2023 12:32:21 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B2C86D34
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 12:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv72T/tNPvWSLlro9QKU6URNnJNh7r+uuyP9twwwiQpVfteHGWgl2q2Q8lNxBjJNhLJKoAhluWw2pp7V4gKctDcfNvmQp3SMqjTa/qF2v4h649HhsG8TKthRc5BQStRAF9PT5YPUMb2ZFCCYzl9tzTjpzrRGUpkgUnMSo/GqgX2KlZHvaFTkrTb9p07RTaEnLzTailj20Gd8lc5pW/iAbYBJscDnWHClwPEszZJAzv/QXZuIjTKM3WfEg3TUtKhiPsBgfR/q0LxntC9RD8E2qtpgnoeFgqCEcWWp+yTR/3H9nxZjOXQLrxupNeBBfJBVGAW4b5UPjBypvDTHbRi/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQoHCjnyXA/uvJrw8Y07gQhkWN4CX/bE6oLaDQ4zlCQ=;
 b=iXfiWapDL1MtpdU+opv7i5jLll6+4ehhtDlZ3ftmEWzHpg+m8t5VZiYYkUVTRBGaSbPWiYATwwpZ91tMmC9Wx4+7BYnmomWSYJTkHrPyv8+Bsef0Ert9udYFU8cWUJliV8yDUzUI8bQB3hPuDu7QD7keUWHSrJoWYqFSLE0CiiUz5Mw5/IiMlLKvTzyEvSXvTUXZWLTPUqKo/l133rEmYoQArGol+bo9aEEWs9bkrylTbjfbJWDgf8ZeT+A6d+km+9gnuPvWxkHd+U335qilVQMLFKJO+/1IBwgcbrF56HOJO8OrnCDaz/6ujsGmR5b1K7DJJIxvBJZES0aOEg9hdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQoHCjnyXA/uvJrw8Y07gQhkWN4CX/bE6oLaDQ4zlCQ=;
 b=GvAXR3YT/EqezAQ6hyTYabPC2/pvx6hEuwDb9BQYIj9veooQXvSix626CnnqV9Ogu8hUqUYSE1UQP2o3jxJjey0h0PXjBiBiLS39nhlU6RyE5eG8TMSfHGEZAdfH4OQphltDn7NIioUGtxzZqGGsXckFQ/qIZ332n/khhq2WUrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 11:32:15 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 11:32:15 +0000
Message-ID: <2160a555-81f2-4173-bc1c-c6703000d63b@amd.com>
Date: Wed, 29 Nov 2023 12:31:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Xilinx SPI driver enhancements
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231116164336.140171-1-mchitale@ventanamicro.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231116164336.140171-1-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0138.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 759c48d2-4c80-494b-74a9-08dbf0ced5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SlqXiebfgSViT8HUHKXB6zhbb3V7vqXTQyfJoYiXZUDDN6jdfcgT9GBI5aTylfFBF3f92CrZKjuWYY4UX7tkWkH1WQB1A9o6GRc9yFdlM1ije8DiGREo6JSqgqEc8xXBSAa2HSGrSE7102nBmnSE+yy5Adb4cviPrrF9mU8A/LtyJlgALfEOx/0BX7hdKqELMFjqbrNLMyzxKAVRY73yV3ruXs7Q8TI9m/G+hWQIEf9synsLoWjU2JSChxpQfEqeeMiFUcjLGg6DoWKWct5IAZ0JW8GGTUUN1Yyf1dvk8zWdE90+qmO9SVU6xgjIyqiDk/3qeUwEObHdL3C+j21N1L5usJlb4PAiKF76c+w0AwwdB1jv1dM6Yb9JanG57cvQGqWDoKyJTyG6cvJJzjG1RNQaZ1CsIOQhLyPtKME9P7Vohu6hGZ/DRuWWRBAdcrLMZF249E2sSYVOrWB0yILKvQ2bmra9oEEzMksiom0mbc2GxYhamXdvBuOGa/GoIU98fyXb0VQyLU9HyAiUUp2Xg4k8PC/9nsMnwz0MouRsDVgiAA2FvsZKRhBRi2P0Fc/KPumll1Vw2PjSktMQ998QnMFu61INaz/6Fx9eIFhDmAXeLfQd7REnLu6AM1pmhe/5p8AnelTjOGgVOFc1znQNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(6666004)(4326008)(8676002)(8936002)(6512007)(6506007)(53546011)(316002)(54906003)(66556008)(66946007)(66476007)(110136005)(6486002)(478600001)(41300700001)(36756003)(38100700002)(4744005)(31686004)(86362001)(26005)(31696002)(44832011)(2616005)(5660300002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czVvZlhqTk1LQU5ibGUvS1RLUTRva3NTMkJQL0JwQzNrbzU5dndkUVJ4eFh5?=
 =?utf-8?B?MUhjNFEyWi96cWhrQUxubmJ4dTBlZXlTMEE2R0d0TDdnZHFleE0vM2lYaUVk?=
 =?utf-8?B?ck1PVnpqbG1rdm03RUhzeTNXR1RrU0ZVQW5pOHBvZDlvNGxDT2hBU25YTkNr?=
 =?utf-8?B?eVN6bFZmZCtUMUEzdHd1N2M0dmhtSkI1SmgzLzdmUWxmOGQ1YlN0S0J0UENu?=
 =?utf-8?B?RE5NUHBReDZnVS9xYkV6aFJwTGhuQlJiM3ZERnZSRWtxUUd0aU04N2VhMXd6?=
 =?utf-8?B?dVdLRlNNUnlGWkJuRGRycXZTVUNMdjhXNmNTV0lhR1dJVE5lL0EvQ1BwWHRH?=
 =?utf-8?B?K2dlMnBqclVCYW9tZnMzOUhXUVUyOVM5T0tSWkpadUY5ZFlHVnEzYWoyZW52?=
 =?utf-8?B?WEN0SkhwV0JBT0NSTWZCNlBDV0pad2RxcXIxZzFSUStiUU4wN2hKMnZFenl5?=
 =?utf-8?B?WnFKZ1I4UkROWUlDcXNYaDMyTVk1UU9GT0FJc3Z4VFFYNEN0Zk9MUUsvT0xr?=
 =?utf-8?B?Vy9kTFlXREhXaHZ2RnBkMDVnckJ3Yld5clNCUjNScWM1TllzeU9ZbWhyeUF0?=
 =?utf-8?B?ejk2R0s0TzFFdXR1anRwcDZXVnMvdkM3WHRDUXhRdkp0QmdtU3FxUkZnU1o1?=
 =?utf-8?B?M1hIdnY0T3ZXSFRDMms0RWYyeEQyaFZRNXE1Y3JybUZXSS9peXFhZFhUbG1V?=
 =?utf-8?B?bmo3clFEazBMQzQrQ3p6b0tZYVZCWjYyRVlMeFZ4Um8xM1owVS9EZlNOSkJD?=
 =?utf-8?B?TkpjL0ZzVkFkZm9MenhWV2EzRHdlVGVaYnhiakZoMWtIUTVEY0F1MTE1cUxY?=
 =?utf-8?B?TmRjaWJCM3RhRHlvMXJvYmtPRW80djBwT1ROczIyd2tXME9RZG4ycEpmOXJ6?=
 =?utf-8?B?cjBjMnY5ekZTQTJwUDFCWVJXU2Z4OERZSXlwaEZyWWtlNERVRGFZYXh0bE9K?=
 =?utf-8?B?aEk0Tk4zOUhTYlNlZ1g0QTZGbk9XaTZqRzJIYlVDNk5TMkE0ZDI1Y0cvbkxM?=
 =?utf-8?B?TEdaMm9JSkFrMmsyV0VGZjRJRURBdmFFcTQ4UUVQTUhIOEJ5VmZSTVVrWjVl?=
 =?utf-8?B?RDFhNURKeFVLYTNJNUVLdEhuUTUwUlgybTcvWXVsU3NkbEZ0RGphYVpNRENh?=
 =?utf-8?B?ckpVQW1BbVd2RjhFY2NiUTNocFZIMVFRemhLVlpkMnRPTkZ2VDhlbDZobG8z?=
 =?utf-8?B?TE5iR0RDaUc5ZlZyemJ4STJLYnhOb0Yzdzd3aHl0M2VBTndDTUNqQUJZeXov?=
 =?utf-8?B?aG9QeUtWYUxHeVRIWTVSL3ZXT0Y4WS9sOWUwVi9Xc3cvZUtzbit4OWtncUp2?=
 =?utf-8?B?cmJZQm5lQW15bDUxamhPaW9ndCtzRUxRRnozdjRGRHk5K2htMDZFUENhTXlC?=
 =?utf-8?B?eEx1NHEyRk5aMEJTZmV1c09UNERMVmFwa3V4R0JNUlBGay9qa01LeUI3emZ1?=
 =?utf-8?B?eS9IZk5WT2s0NTBMQ3hYU0NOVHUzUHV1ZEY1b1dIMldkNUZSaDI5QjhWOGQ3?=
 =?utf-8?B?NFhwODI3VkxUSjJ6aGtaeHpSMERsNzN1RFovbC9OYTRhV2Q0UEZMWitSTHoy?=
 =?utf-8?B?MXZKamhrQWZCaUZpbFlGMFE2NldSaDZPMUhIdnlLYitwQUNYanFNN01WWDBT?=
 =?utf-8?B?ekY5d3pubjRSYU9mbUErdUd4MGlvQnBETlBsUUJJOUNjNjVrVnFNSFVXdTRi?=
 =?utf-8?B?UVdFZzk4bjAxT3VnN3B0V1g2MHhPQ1M1RGdveTI1RlRSQ0g3TEc4bHcrOEY1?=
 =?utf-8?B?WHVsZWxiQXkySkg4ZWluM2FJdWdaRm0yc2hDamsraXJJMDJrVWRHMzgxdGp1?=
 =?utf-8?B?SDRoWnhxcUZNTnhRMFVZV2lWS210MFBsRk51Mko3RjJJSkhqZkxGdzJJc3Yy?=
 =?utf-8?B?YlpFa24yNWxReHVxbis3cnVnN3RiQ1QrdXY5cWlmRkNJNUhSVE1ZY2dmZlAz?=
 =?utf-8?B?Y2xmTHRqVldDUFdiZU9jV1FFS3ZZdTNZV2NvVmFKcFY4V1VnS1d2d1lQOXg5?=
 =?utf-8?B?ZytEbFBmZ0I1RGJvc2VNMTVONGRaWVl1czQ4ek5NRVpDZzM2WHZud0FKaTM1?=
 =?utf-8?B?WjNEWWpvOTJVeUY3SzBYZ1BHYzNFY3hHSW95cXhPQ2YraDhJS1ZqWllKVVRC?=
 =?utf-8?Q?GImJfaxWbxi31Slw4gSxeALC8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759c48d2-4c80-494b-74a9-08dbf0ced5fb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:32:14.9530 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaANejhLDqO9kwRtHFiu2gmE0l7JCBAgBblneu0tIhwV3yM8x/Tqmw0mL+0FxbAN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
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



On 11/16/23 17:43, Mayuresh Chitale wrote:
> This series makes the Xilinx XPS SPI driver compatible with the MMC_SPI
> driver and also includes an enhacement from the corresponding Linux driver.
> 
> Changes in v2:
> - Improve comment and add reviewed-by tag in patch 3
> 
> Mayuresh Chitale (3):
>    drivers: xilinx_spi: Use udevice in start_tranfer
>    drivers: xilinx_spi: Add xfer callback
>    drivers: xilinx_spi: Probe fifo_depth at runtime
> 
>   drivers/spi/xilinx_spi.c | 68 ++++++++++++++++++++++++++++++----------
>   1 file changed, 52 insertions(+), 16 deletions(-)
> 

Applied.
M
