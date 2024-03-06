Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E73C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 07:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1578A879A0;
	Wed,  6 Mar 2024 08:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K61kY6W2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F6A887BFD; Wed,  6 Mar 2024 08:48:18 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95408795D
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 08:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2EfXwFBdhCSLtS8AwswR+7QxbodAVY9ZHxFhOP+rLW4LQYJ0rYB/ii/Rmb0ZKIRcy+nP9oKk4z7ZtENS8daKOSKr1YJUDI7aCzZaXU3NIuYit60MIvDgSbiTYbdy6LeZB3g9de8hoMqQ3HhBgzPPW6UQ9DNtbxSxCK6PZnJnhmlIhHWwu+eYLo/KR/5HuqOY0WHAYP330wjxciCa1fyzpGTR/3VMqN/+LNkp5AJgFNVYEPoC1PlIH2JJ2Wx2uVBUDK6XaUoORGzTVA+WTBE7j+tcTYG3+BF5gDxp3Qwzrf182fP7K7qVdNWLz79OuLmxketVkNQkvMnwWltRApZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZiwLQnOUUaB+kac+VGlk2Up7bYDmqba6AfK7MadYDo=;
 b=iD9zwh5Acwk161pNthTL1ptUK4XdHUswDWK7oHNq2/P20XtzsAsdGDVzGGWswf3mnvO54kOyzu1HaXlaVGSU133Jf2sv24zGMPlQ9/bNaMYN8od20y20eF+NH4a7OwHXJCXwGGBe+9QWaDQb13yx9G05adL+InbPQrRR5x6Apt4ZVPnK1LWy/dI0R7pCbuTPvD3CNLb+3AK1yEu72jUfvTIi3jp+gk0dAmj89TcgJysY4WjSDcEp/KzC757VYvqk1q4Zr3xmaxaIblQumAB2XpiXYiuJfFUCl+vdfr3lXLf/0xQolm6UwfM3i9//p/KhivJ1J1Ieavh4jUw21XV+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZiwLQnOUUaB+kac+VGlk2Up7bYDmqba6AfK7MadYDo=;
 b=K61kY6W2Cpq8NKvG+FYYlNfF+Mi8jB/J4wCyrwxAA2DCIt+hqeztENzeh2PUXxnlf2cj8VRrwG6MtMVhB0B4leOJAy+L7zIB1ERtEXzCbrQdOywLlFTOqIfy8LBri4a+wXgQy3jXgVwhqZEnwclQ/ObYHXwELrQr4ut79bjcm34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Wed, 6 Mar
 2024 07:48:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 07:48:13 +0000
Message-ID: <a3c1d482-2b2c-4c7d-96c9-2fe877d09ccc@amd.com>
Date: Wed, 6 Mar 2024 08:48:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Do not describe u-boot.itb if SPL is
 disabled
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com>
 <Zec-oE2mzj7Pngo3@hera>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <Zec-oE2mzj7Pngo3@hera>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0236.eurprd07.prod.outlook.com
 (2603:10a6:802:58::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 187a34b7-ae69-469e-3752-08dc3db1c66d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QVnmT7DoF9GYyJsTqebRcy9n3wsdbl49GsW+m9DDboVokEoG0uvZrt0IlmakxA+oeVlS9zJNS472sb3NMt61Ew1l/e9xB6Z+NZsWSpr0tEAgYgbIJVhVOC4llWQQAWJL5KxYlih6S8cxzzpXtf+7hCR0Oquos8fVwwPmvz85SOopkNvhFK7ASmncj/A/e8yTeLofEND4gkb+In8qwnNNBUOw9OIa9yhdQcZIU6D71pJDBlgGW3jAosqpqz5X3P/NG3MtK8HN7+UJomsFcojHe+3YSNJ3Edo+HWYd3GEf/DtpV6c9MTw++lZx1h67QT8rt64mpOAqpVa6KstzVgSM90TQhwyh0YbEhUE6WuF4J1alq5BG815gAzy2xtCX31qTFZQ9y/1C/gUBU5rhL+c8yEBsC54yvohcffi75debGvud16KAHQhHgBX0BLJGHCtsqgATn/1TAywA1RmutpA/PvfRLkVPnHukwb79NnLfzcveDjHUWd0BFSA/gJXTdL1C0BHe+M2Czhn0BH1wdOYlbDaqQzXsyYm7Xx+cL2ac9ZKe2os0ynfXGLO5ORnQASaeBJZXFUHOF//E3COW23c70JhJBJ5dTtTJED9LXyJ3TOUUSKR800J8LScJLJpcfzA14pZetXzkXjIuwVTGgUc+r5x6FmcSOSmyPd6HNVW+Hw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZFOVdsUmoxZkhGOFlaUTZtMkdBbVF6T1V5WHVsb2dZTk9BN2xtVGJFblZN?=
 =?utf-8?B?SVJoSk0yNzdoNk5kQnRKYnZyM0NxcGNOWDA4SzNwYi9oL0hjVEtXV0ZrZVI2?=
 =?utf-8?B?dFhnV3JnRWdSK0hML2w2ZWw3Uk1ZYUZVTGhucXMvcWs5cGU0dmQ4TUY2aUpU?=
 =?utf-8?B?a1MyZk9ZQmFkWDIwR1RjT01ObzJGWlB5WHBvbWs0VGl6UUpjWVArSXRGQ2RD?=
 =?utf-8?B?TXdpbVZONjJKUDM0TDduMG1PM0o0U1hEUFR3bjVTSEttWnlwci9YQWJjZ2JT?=
 =?utf-8?B?Q0ZYUDhGa3o1SnFaeWhjRWhvMHVleE1WRXQxNkZqNTlteEpHVGsvMnZxbkdt?=
 =?utf-8?B?Q2dIZUN3eStrV3hyakFlWE81QnRWTFFVRVY0T0Z6amF5OU83dzB1b2hNNkpn?=
 =?utf-8?B?THJrYWVmc2FGMlF4UFlJUHEyRkwvT3ZwNVZYWjMrOG41RW81N0xnU3JEODlw?=
 =?utf-8?B?SWJPMzlVRFZua2h2SnFELzBtZHE4RFRId1p3UWFCbS9LM1JJYzZ5NGo4NTFW?=
 =?utf-8?B?bkNuOERpVnV5b0U0UDJ1QzhjdUE3T2F4b3lQOWZIQ1I5aEsvVnJONlpyMEs3?=
 =?utf-8?B?YUxGYlc5OXllNHBBYS9tU21XaC9DVlo0d09hRjZ2WXUwbEY5RHN5WGxvUmUx?=
 =?utf-8?B?dkNRVGE0VVVDRHMzT2RHM09Qbjd1SWhybFB4a2lkMkNDTElTRTZnbWtSdyts?=
 =?utf-8?B?bzhvcUpBTmU4NWk3VitSLzdQdy9rMDlTQTJ0b2V5VXhnU0kyOVRkdDZaWkM4?=
 =?utf-8?B?ZTRpS0xLZFBoNTgzOVpRRmFXb21CaDBjbTNHalhoMXU3c1lEaXlhV0lCQjJq?=
 =?utf-8?B?YXlJNkQwNVBVZDV4bHdxYmJWNDcrUTZpbGJaaGFsdUR1SkczUTZNNGVsYUdD?=
 =?utf-8?B?ZGVWcXU2MmgvK0Y4anpQUGt5ZCs2QlVndFBRb0JnckZBNlVza2VjL1pieGlq?=
 =?utf-8?B?YXRZYWppdEgwZ3NQbWh5M0hoM09ldWpDL2hjaDlCOWpRWTVqUDdrNGVKNWVw?=
 =?utf-8?B?M1JpbDI3cEthZnpQNjZGK2QvVWdDeDA2Mkt1ckl2cWR4M1Z5ZmU5dFZXNERN?=
 =?utf-8?B?SnhXL2dOYnFNd0Z1cXppcUl3OVVYbEhuUWpmY3V2c0VVUU81VFMrME1vbE5z?=
 =?utf-8?B?MlBzOTJrbS84aHdoTC9KYmplTVpORUsxMW4xN3VqOFUwbTI2NFZWWU9WNXlt?=
 =?utf-8?B?SnNkMGRlRDVGeFl3NEptZVJaZXRNeHAwN3F5YlRNYWxwVTdIUDJ1RHduWW1q?=
 =?utf-8?B?UnAvdGF1ZHNId0xHSDNIaDk3VHNTN0sxRGlleGZvRjgrSUtidEJnc3FDb3E5?=
 =?utf-8?B?cGZCcVJpN0MxQWdhSDY1eVdPVEFkZWZJeTNQL3RmOU5OOSt4NGM4OEFEdk92?=
 =?utf-8?B?cDBHR3lwalNyTFRhaThqdGRqOEhDYlphQ0JuUjU4aUd1b2JOM2NRRkxNZmRy?=
 =?utf-8?B?bXN3cTNybU5KS2ZPYlpLeWhGOWJxQlk4azExUzlRQlNRSDdSMWRBUjVQb3c3?=
 =?utf-8?B?UGllZ1VOOGNyc3hBUkJ5NkdUb2FoaU5LOTRZWS9FZithMWlVRVFSc0JaNGVj?=
 =?utf-8?B?emdJV0VKZy8rRzdyMFZyMXUzMWtHZ0dHOWN6MitKVGJDUGlOeElubHFheEd1?=
 =?utf-8?B?N2ZEN0g1SU1iSld4enZwS1pERUJxMWthdFpyWjJGWlM4S0NOMlVBMEFiSWs4?=
 =?utf-8?B?UnFCc1hGZlJTck91d2x2ZTRCb3J1MTMvVXUwZVZsQldDdjM5cDdIc3Rrbm5p?=
 =?utf-8?B?Q1pSWHhybW9GS2tPR2hqa0VXbXloOE12bFAwZjBjNGlGaWI1L2lxTjdxUDk4?=
 =?utf-8?B?SmxQSmY2YUF5dGtQbmk3OEViNUI2enZLMmdxMXpvcDB0SUtsRkw1VUFYQkxJ?=
 =?utf-8?B?SjNuYVlzRkxxWlpWeGxESzhreXNuV2pWd1JPRkk1QXJVUitWdEVrMmk0ZFhw?=
 =?utf-8?B?djU3WUplMkpKK0tEVDNyenhCUlVUazBNajBPalJvZjZZOUhsd1ZVTXlFNmpa?=
 =?utf-8?B?bzNCSFVVNzRkNURsUy96VVhhbUJaQjVYY1RxOXBFMmFqS0tMSHUybllNL1NF?=
 =?utf-8?B?dXBOeU8zcGpLSGtGbGRTMmg0eHVrRHBmZ2dhczNuMmF4Zy9SQ2FBVE1LZjRL?=
 =?utf-8?Q?bMyGDGXTE5Hs49VTAI8lHZKNJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187a34b7-ae69-469e-3752-08dc3db1c66d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 07:48:12.9729 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDSimX0yLkS2sc6pVIUldl+oNrDr/K4SsXZ5PWABdXxlWCo012jg/eSsi5M79/7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
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



On 3/5/24 16:47, Ilias Apalodimas wrote:
> On Fri, Feb 23, 2024 at 05:18:42PM +0100, Michal Simek wrote:
>> There is no reason to describe u-boot.itb on system without SPL. Pretty
>> much this is cover all systems which are using only boot.bin which contains
>> all images inside.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   board/xilinx/common/board.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
>> index 9641ed307b75..4f38b7d27684 100644
>> --- a/board/xilinx/common/board.c
>> +++ b/board/xilinx/common/board.c
>> @@ -43,7 +43,7 @@ struct efi_fw_image fw_images[] = {
>>   		.image_index = 1,
>>   	},
>>   #endif
>> -#if defined(XILINX_UBOOT_IMAGE_GUID)
>> +#if defined(XILINX_UBOOT_IMAGE_GUID) && defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
> 
> What happens if this is defined with CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="" ?

Your comment is valid but I am not aware about any CONFIG_IS, etc which checks 
that string is not empty. If name is "" it will return yes and second image is 
doing to be defined.

But I found handling in the code like this.

  36 #ifdef CONFIG_DEFAULT_FDT_FILE
  37                 if (strlen(CONFIG_DEFAULT_FDT_FILE)) {

which can be used in my second patch not to describe second image in
set_dfu_alt_info() if string is empty.

Thanks,
Michal
