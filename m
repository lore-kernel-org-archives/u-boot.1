Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A207C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 17:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA448036F;
	Fri, 17 Jan 2025 18:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="HfmxXC4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB538069D; Fri, 17 Jan 2025 18:27:45 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B300080077
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 18:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSbQ0g/W+buHzE4qpXinCOvfaQF3TULaMIeggyrZENhYDvJfiEx0CaOc1WyK8VFB3CQZJ/nzUFkMYEhelfWUsj9MgFwCMeivr0RWqXMpeW/UXJBDIpBUXxiUjubErOF2/uL0ZGOHfB7SwaAxMTCIvXDtu6CvWfdhULmFIyfJfqWMseUAEurl/kfit0r9CmmCxVp3yL2O8HvloUY7mhAejmUWJzVHFK+jwZ/TQakVXu6d56OTrsMQ5kWYRpRf35qUkcdvnwQCpPj5j0NWbKVNwSQSXUKpfrBXGuH4HVl/u+HlXn20mxke1xyY4EO02V6ytitkYZhal81/h46PefqJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfQywO4l2S+DsPQoW50LVUDw+zDr/pWcyWlRT85e/zc=;
 b=yc5Ovv/QLYo1MHP4Qylq3m9SnAFCMJCeFqkREKSNsJuRQ8Gyh4MxDYt3eF/1/FjSeYviAQLrlX02WfSTV0cjTqtYaEUgf/rZQJghngBqt+G1StT5mfAkIw6yVf3D2VjH71hac8U/2xdy5DK8R21EYxwLVktU04MSt0FIUNBPWcKPkuUfV934TTqqC0nWdu8I4yplzauI15W+v8dy1TTrouYnkYrWCbPTvARwC+jToldnB3joPaOcUtLVyVFPZA5tN8oqbk7i259ARCRGuze8oaWLny2I+Ns1gLq3ZeiouFMlB8rn2O3zCzS5Kcxc0/yutGOMl7WJnHfXVXDyySUPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfQywO4l2S+DsPQoW50LVUDw+zDr/pWcyWlRT85e/zc=;
 b=HfmxXC4nOapjRb6rSAslgmWV0aWQ6eAWfOzK6TvADzqERtb4ec2Ww518TolLAHSH8e4FfKXvhbHLAKpkmAE4VM/6PIpRU/sjwZpY24vlpj+BPWgFiVANnb1PBR9ng09MJc5Fvefd0FW6vAxtJqdVyVgCkM2Q830JiC76/gSHXyU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 17:27:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Fri, 17 Jan 2025
 17:27:40 +0000
Message-ID: <a56549fe-8071-4bc0-9f37-6e857f6c4eea@cherry.de>
Date: Fri, 17 Jan 2025 18:27:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Adding bootsource and reset-source* to /chosen
To: Rob Herring <robh@kernel.org>
Cc: devicetree-spec@vger.kernel.org, U-Boot Mailing List <u-boot@lists.denx.de>
References: <48defa98-9718-4997-86cb-b171187708a6@cherry.de>
 <CAL_JsqLJ86n8iX5wt4dEuZz6rudxXKFOuuEGXbk7f4ydvTZLjg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAL_JsqLJ86n8iX5wt4dEuZz6rudxXKFOuuEGXbk7f4ydvTZLjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 36248f5e-0c53-4cef-b2c3-08dd371c3e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzl6WFdDdzBhWVVlazNtb3ZxSi9pQmY5dDF2TEg0Z3BLcXgxTXZCT3o5MWky?=
 =?utf-8?B?U2FPdTNyRVRhMHhXcEQvZzZQT0pXUXNWTGFhSmlCZ3pPS1dyVTZ6anphL1B6?=
 =?utf-8?B?ZXo5Q0s2UXFZR0RNclBmaUpmd3kwWmFhM3hXY3BMT2ticm9UeEdtamo3SjRh?=
 =?utf-8?B?cjQ4Z0JidkZzOU4vd280Nld1VkVuZzRvQjlKUStWMlJXeHdEODdXNmt1eXlk?=
 =?utf-8?B?KzlvNGFqQjc3U0NVNEprTzN2NDkxZjJSUFZrZ1FhNmJJY2plUnZCd2YvZDB1?=
 =?utf-8?B?NnBYelBIQW9HRmZ4TWk0a29KWGdQUkR6NEVMQ0NjSzltejFxOE9oNFFEQ2FO?=
 =?utf-8?B?S0hvN3pPNWZ0MUJWK2M1NkpQNkNRLy9pSnYzZGNqZm5rTnJPMENQWEhtSkhi?=
 =?utf-8?B?aUxZTXlZaUxYSHMyZzAwOXpqZHcyeE9vU2taRmpDZnlDaFFHKzJnR0RYemxX?=
 =?utf-8?B?VTZBMitCRkhmRFFlQ2cxR0N0RXYzenE0VnB5SHRFUS9kZWZseUtmeHVhbmta?=
 =?utf-8?B?aDdLQnkvMVRVbWNmUW1JeUM5b1NkcmtEUDhvc21aUkZRQmRmcFBuRzU3dnEw?=
 =?utf-8?B?bVg2N1A0aWlSdWRVTUV6TFFaS05rOW1SSTBhN1NubHdsTDc0ZnUzUHRGZFFQ?=
 =?utf-8?B?ckNEY280NHpGSklYUlppK1dtZ2hYVGV4UER6TTdwYnh2eVRNcVRWMS9idlNO?=
 =?utf-8?B?dWxUNGduMnliQkdqcVlKaE1yT3VsUDg3Y0J1UEtQalZIdCtOUEdSNmIxN3lK?=
 =?utf-8?B?NW9WbXA3MlJWTmphSGVLdUNNVk15bCsvTmFlNEUxSFREVkxuWDh3M293U2NH?=
 =?utf-8?B?a2pycm1kVHkrVUh2MWxuK2pnd3J6Lzlnb0taVGZySFFWeUd5akIrV0ZFNXNH?=
 =?utf-8?B?aFRWZm1ZVFJJekRsd1EyOCtVQXJ4M2xSMGpRdUdONkhDR3JVbmZ4WVZvckVj?=
 =?utf-8?B?dTVveWJMUjlaVWM0VGxvd2grb1VCY2pwM2QyZkhNeFZ0KzZHVzRuZ1ptUHRu?=
 =?utf-8?B?Z1Zsb0pXdDRNTnd1RWU1YmV3U0Q2dk9yRGs2RzRJOXNWMkFpakJ6QnI4UXFu?=
 =?utf-8?B?T3dKQ3VhV3hjTE5VS2diSS9zUDdxS1ZpNkRZU3NwQ3F3MDVnbmVQdVVMSlgx?=
 =?utf-8?B?bFRJYS8zRFR1ckRKUUZXem5nbU9WMGpYSVlQM1hTTGFCRlVvM20reElYc3dP?=
 =?utf-8?B?NDdZTC9tcVdLWDJsWlF3bWtKVVRaSU5MeFEyWXh4NGZ4MURWcXpFeVl2Wllu?=
 =?utf-8?B?aXd6WTIwbFk3eGk1ams1THhQNmtScWtXaEtvemZBTXVRUWQvTDV3OUJZQXRo?=
 =?utf-8?B?cjZVVS83RnNETFJ6cU5YWmxKbzd3UWF3VXE2dlhidGRlT0hQekQyZTF2SWoz?=
 =?utf-8?B?VEM3UmZIK05Wc3dydEdGUFRFV1dlMjFrNnlhcGhQcVBtaHUrWUFxaVFPY0Fy?=
 =?utf-8?B?bGJxUWUwbDVkTnZ1Nkx1bEJrZkRLWnNjMk9taThHQUlVUG1SYzlXbitrZGNm?=
 =?utf-8?B?TjBNZmRZa3VQeEFidmQyejRnOVhCQWM3eFY0dk9LUTZhUTB4L3ZPQ3dML0xm?=
 =?utf-8?B?d3VmNUJuNnA4SXhja0hEb0FJNEE1UENBYVk0RzV0NXlzaWd4Y2ZxSndlRGJF?=
 =?utf-8?B?NS9Hc0wvNnl6Q0FYWWhjMjk4ckVtVm5veHh6MTR4cGNEQ0hiMFZhdVozNU5x?=
 =?utf-8?B?ZExzYVVWTWRpa1ROems0cGhyOVIyZ1ZjL3ZHc3ZEZGxlLzNzb01iRkxKbEhV?=
 =?utf-8?B?SDFaeTNKZDVBV1lTTnhTcE54Ri95Y0VlaldySUF5WDRIRzMvM1pyd1pjcVNu?=
 =?utf-8?B?UWNldGVNY1JSZmUzY0c3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVVQUy9IQmhtRENOc29QZkl6cVBnN0hUUE1haXR0b0hsTnJpMkdLV2ZSS0ZL?=
 =?utf-8?B?cmo2U1BOT2lFNEFhOHExY2ZQMENSOVN6SWFJSFYzZ0ZxMmMzZ0VlS3ZBeWpF?=
 =?utf-8?B?TnkrQUR5YkhqOE84L2tJYzVmaWtKYmM0TWtUZjVnbjV5UU1kWjhwTUx6NkNs?=
 =?utf-8?B?eVdKbDVPdWt5N1FjQXlReUJZRUJOZVFqMEJyUzZpRkp5cnlxRkxySS9IYldD?=
 =?utf-8?B?dThCZGVpWWpzWkZXbG1QQ2ZFTjNFLzVpN1FMeGwyMlZMYmtFZUZNMEtlU0Yv?=
 =?utf-8?B?V2dUdWVQRE9oM2g1SkJyWVUyYlVyYlhhTkg0VEtIQ1ozZ1kvSkhPYnJQMW9P?=
 =?utf-8?B?Y09oZXE2Q1dLNFcxV1lFemFuMXcyM01rUzJmMEFOb0w5SittVG1renBpTDlD?=
 =?utf-8?B?cjU5UkVtZTNvejUwT2tDSEVGY1JWZmdmZmRscEthMEhsaG4wSTlka2NmUWdE?=
 =?utf-8?B?dktmcjFySDZUTUw3NE9pQzlEUjA4VkFKSzJIMkMrbXViUGE1dUx1NFNXWS9X?=
 =?utf-8?B?S1hDMHRJODVsNHh0bGlRNndpMS9Qam5JV1kyQnVxNUNhL0JYNmxtdDlRVnd3?=
 =?utf-8?B?dkU1cFFUOGFLTHF2ckwvaVorZkFsNFlZWmFXTHVrNWloQUpEZGVGUFpuSDdS?=
 =?utf-8?B?enAzSEJ2amxvdEVuODZ2Sldidi9qOXdVaHFLdUFOS2JYYkYxdHE1ZGcwYm9C?=
 =?utf-8?B?NmMya3NiaTVDSWJGbHk0WmorQ2JJbkdOTC9JWE4xVHBaN1JIV0JiMDRrQStp?=
 =?utf-8?B?Y0hnT01yV0VUdEZvRHptV3FPMlZzN0ZhWmxsR2N1c010VCtCTE5HRVpSdGE4?=
 =?utf-8?B?Y055TFI5UUEyNzZFYUxibmFFUnBCTDNXYVpIMVdHZzZtdnN3dG52aEhIblEz?=
 =?utf-8?B?NkdZNXhIT3ZvZlRuY044SE1UbUplazZFSi92bmpEdDlQWTR0Z203SWRjRFR4?=
 =?utf-8?B?NDc0YVBKajUreGZKS256VmpxSFBwcWFqak9oUFR5b2NDb2pDeWoyMnU0WC9X?=
 =?utf-8?B?a2srV0dvSkN3bGlLWXFVTlgxTHlrOENudHM3ZE1tbUs1d0IzRTFLVDRxbGFP?=
 =?utf-8?B?b1RWZEhXVzVjUlRyaUE5VG5BS25HZUFyRlV2UURueU8wdCtuSFpJTG0rN2px?=
 =?utf-8?B?c3cvbUFyQ2N3L0JVc1Z5dFVraytCaUZIY3RGVzJ4ODVaWGEzRVFSOGlGTStj?=
 =?utf-8?B?U285Zm1uRElvQTdLOTA3NHArNjVWNWQ0VXJqMTFyYnhPOURNU1Z6eXhSZmFm?=
 =?utf-8?B?K3RqVTJwOFVyYVcyL1c2YWNqL3AxY3ZmK2tsN0JmcVEwRXpTcDF5TUVuZWk0?=
 =?utf-8?B?WUVuQ1lvV0RLaCtHMmliT1BsdWpQL0NKSjQxeHVTeHRyOHZsY25vQVQxZmlT?=
 =?utf-8?B?ejhIM1dQa2FHMko0SkVKZjN0QUxMRmcvUDU5QnUyWTN6WDdXZnd3cEZkcXdP?=
 =?utf-8?B?bVMxN2Z0UXltR1k2Sm9mQVAxY1hBS3FCOFJKZTZ4UFg5WCtqa3lMMkM4N2Vo?=
 =?utf-8?B?SW81dXMrVC9YSFlLbFN5UVBCejVteEN3a2pMOVNqcUNZK0owNEtMVGtQVCtQ?=
 =?utf-8?B?KzI2eEJ6VjlzQ090Tm9XYzNFNGFaQSsvWTcraWZ6akx1KzdZQ2VLYmg1RFJj?=
 =?utf-8?B?bTZLdXNxZTJ3akF4cWY3WVBXaGl1ZGdOMVdIU284SGpRb3N2Ry9WbE9PcW5j?=
 =?utf-8?B?Z2JMWTV0bGpoeTJsN00veVlQTk1tcmN1RDRzN2FlTUQrVzdrMHY2SjNTS2h4?=
 =?utf-8?B?akVvMFFpL3Rna291MVRwcjR6dFRPZGNSam12SGtKZldlbUw2b1dQYmFuK01x?=
 =?utf-8?B?NnM3dTZHR1MyVlhSM0pMcnZ4V0RrU1VZY0pZaWxISk5oZWU1c1lydWNlUXBI?=
 =?utf-8?B?aTVpek5XTzc1amE0ckk3bkRtTWFJaFlmS3NiSlR6OVNCOG4yMHd1SWIyVTBm?=
 =?utf-8?B?Rm9rU3piZTMzd3RzQitrVDd0SDVaQVd1RTl2QVRnV2lXMElGajdnQjFoaDRI?=
 =?utf-8?B?cWxNV2YvUUNyVmwvOWJhczk5NUpMcGc1eTVOQTVCVE12Nno0WU9ZbXRsQWhC?=
 =?utf-8?B?cmlWN2RLYjJPbjhSMkVJNlZjRVBUUzQ4TktpRnhpTTcxekhvWFlCSzZlN2JR?=
 =?utf-8?B?c2VSYmFiWnpJVzU3R21iVFd4QjB6cG5WYVpzeGVYbHNDYTZqV3Erb09TVjJE?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36248f5e-0c53-4cef-b2c3-08dd371c3e41
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 17:27:40.0857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKwxzMQEJ/P4e0GWf4z9KaKo8zUV2oNiOOQ3dIZX0AVfcMSyvCMLn1/Cf8e63gZhtg6mdP4quTlYoiZXLxeX1xRKUSgADEM23n2t1HFJaQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963
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

Hi Rob,

On 1/14/25 9:36 PM, Rob Herring wrote:
> On Fri, Dec 13, 2024 at 12:08 PM Quentin Schulz
> <quentin.schulz@cherry.de> wrote:
>>
>> Hi all,
>>
>> In U-Boot, there are multiple stages which can be loaded from different
>> media each. On Rockchip SoCs, it mostly goes this way, SoC BootROM loads
>> from a medium (storage or over USB) and executes the TPL (or SPL if no
>> TPL supported), the TPL goes back to BootROM and reads the SPL from the
>> same medium and executes it. The SPL will favor the same medium for
>> loading the U-Boot FIT image (containing TF-A BL31, OP-TEE OS BL32 and
>> U-Boot proper image), but in case it fails, falls back to other possible
>> media. In U-Boot we have the storage medium used for loading the U-Boot
>> FIT image stored in the DTB under /chosen/u-boot,spl-boot-device
>> property. But we do not have a property for the medium the BootROM
>> loaded the TPL (or SPL) from. This could be useful information. For
>> example, I have some CI where I want to check whether the BootROM loaded
>> the TPL from the expected location (important when checking that they
>> all work and don't depend on a bootloader flashed in a fallback medium
>> for example). Another usecase could be to detect whenever one loads the
>> TPL from USB (not a USB stick, some USB transfer; see rockusb for
>> Rockchip for example) and decide to do something else in U-Boot or the
>> OS depending on that (could be starting DFU for flashing the device, or
>> fastboot for loading the rest of the system).
>>
>> Barebox currently does that by setting /chosen/bootsource to the full
>> path of the device the BootROM says it booted from, but that isn't part
>> of the DT spec so before I add support in U-Boot for that, I'm asking
>> whether that's fine or if we should correct course in Barebox and use
>> another name and/or location.
>>

I don't see anything in your answer that would be applicable to 
/chosen/bootsource, am I correct in assuming that this part can go ahead 
and be submitted to the Device Tree schema/spec?

>> I've also been made aware of other "sources" that are added to the
>> /chosen node in Barebox, reset-source, reset-source-instance and
>> reset-source-device. I am not entirely sure what those exactly are for
>> BUT it seems that this is of interest to U-Boot as well since we do try
>> to report a reset cause as read from the CPU for Rockchip SoCs, c.f.
>> https://elixir.bootlin.com/u-boot/v2024.10/source/arch/arm/mach-rockchip/cpu-info.c#L14.
>> I believe /chosen/reset-source would be the reason, e.g. "POR", "RST",
>> "WDG", "WKE", "THERM", etc. /chosen/reset-source-device contains the
>> node path to the device that triggered that, that could be useful in the
>> event there are more than one thermal trip point (e.g. CPU or GPU), or
>> more than one hardware watchdog (I for example have a system with
>> potentially 4: SoC, PMIC, 2 separate in an external MCU). I guess
>> /chosen/reset-source-instance is for HW blocks that expose the same
>> reset but from two different sources which aren't modeled in Device
>> Tree. Again, this would be useful for the bootloader or OS to decide to
>> do something else based on the reset cause (e.g. have data on why some
>> devices reboot in the field, e.g. because of thermals, power loss,
>> brownout, etc..).
> 
> Is the handling of these properties something common/generic or going
> to be device (e.g. wdog, pmic) specific. For the former, then /chosen
> makes sense. For the latter, maybe everything being in the device
> nodes makes more sense. Then you wouldn't need a link to the device.
> 

I would imagine reset-source (the reason) to be device-specific. I'm 
sure there'll be some HW in the future with some odd reason to do a full 
HW reset or somehow support 10 different watchdogs in the same IP and we 
may want to know which one triggered it, I assume for that we wouldn't 
want WDG1 to WDG10 as possible reset-source? Though it seems that's what 
reset-source-instance would be for. Do we want to limit what the values 
of /chosen/reset-source could be in the schema? e.g. WDG for watchdog 
reset, THERM for temperature threshold exceeded, etc..

The issue I see with not having /chosen/reset-source-device but have 
some other property in the device node are two folds:

- in order to know which device triggered the reset, one will need to 
parse the whole tree for a specific property,
- I could imagine a scenario where a device not supported by the OS (or 
only auto-discoverable?) triggers a HW reset (e.g. from TF-A, OP-TEE, a 
sidecar microcontroller, etc...), I wouldn't be able to add the property 
to a node. I also concede that I don't know what kind of path would make 
sense in that property in that event, so maybe that's something we can 
just ignore for the moment, or is not realistic.

>> I'm reaching out to the devicetree-spec community before I add code in
>> U-Boot to implement this so we don't add unnecessary backward
>> compatibility code, were the properties or locations to be modified to
>> match the spec.
>>
>> Does anyone disagree with adding this to the spec? Does anyone have
>> another suggestion for the naming or location of the properties?
> 
> I always feel better if we have multiple users for a new, common
> binding. A new binding extended by a 2nd user shortly after defining
> it makes me grumpy. Here's a thread that came up with the same type of
> issue:
> 
> https://lore.kernel.org/all/20250113112349.801875-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 

I see...

The bootloader should be able to do something based on the reset source 
and reset device. Some HW devices do have clear on read status 
registers, so expecting the bootloader to not touch status registers is 
unrealistic in my opinion.

Also, as a user/distro I would need to try to get from all possible 
devices if any has a reason for the last system reset, across different 
subsystems I assume, so different APIs and all. This seems like a lot of 
work and error-prone.

The issue could be that they need the driver to do something specific if 
the device handled by that driver is the reason for the last system 
reset. If that's the case, then we could parse 
/chosen/reset-source-device and see it it's the same path as the 
device's and do something based on that and the other /chosen/reset-* 
properties. However, if there's a read-on-clear status register and we 
don't pass enough information through those properties, the device 
driver will not be able to handle things the way they want to.

Cheers,
Quentin
