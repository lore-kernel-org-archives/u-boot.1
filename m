Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD9FC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D3588266;
	Thu,  6 Jun 2024 14:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N+OEjkoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A298839C; Thu,  6 Jun 2024 14:44:29 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B901188266
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNgR5/DEvase1hhku7rC58i88Zy+4ZmzG5kfiXVspFimQdvV3Y0tsNV3TIYy7zcnXzRiQTQhjgsXK5NBm4tTrtNZ+gBcAe5E9nBQFr6OiLfb7KnETBDXQuzRez4iAiIoi/mMSahaMmHVx4kwGY1vh/DF7kLeDg5rIZgHKzUokCOpzR/MO9z+prVwuKImhNkUXpAAt1FB5csWoKoiH5OCBVPm4DTYt3TOeZf8kc3efGy3h6pqpisP1CvaYij+jEp0GFRXudB8d+cwzrFcFrxqleMfsBDX1saqFHeVAgat7YtXfR/+L9Ci4nbtc0s/6rGUPdvVbdqIMTaFtWRQV+iarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uUw2u+xmCkY/MVQT/7izIWb8xVqfpsLfmywFHT0mGI=;
 b=cPVVu9Yb/aitOxH5zEJmkCmN1mD00/FMt9nR3dI1gBDHWI3eeTK/h2EJpoyTEHd0eSlm4FXzdP2WdG8gktePxk4fXv6kJg1zkBa+otOmBAE+t9SvTkObgxFrFqwtDWVnKXuqz7Y/HkhhhsuFPLBkGXjfgMjmCqTly1n5cHaUA3sKhzNOm+2c8y0HcQU5QAxdsVcf6s3BjkwWOCEkLCt7egUiXHgloDqw0YRCfvleExv7eoFNYbG8AzFPMS5T+QAXzh+Dfu7F0gylxFNuwtPheCaQ584Q8Hayxuf4d2bUzYLaMzXcbGgBM83pIe0DeYK636+5yIFkiJt/p2XncqpI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uUw2u+xmCkY/MVQT/7izIWb8xVqfpsLfmywFHT0mGI=;
 b=N+OEjkoK4+J+27L1LthCx9IylAZCjYI+ERn4AjB/RzewBzE3HZ0eBmm4UwrLNdSgzE0ypgFxV8E+FTHraFSA/a2OhryC5GnMIqQUMBsv3o+Rl4YJSCqrONjEQtgIncyc9cUCv/6lITE7mfxOdpc0Xq08+8Cha0YNmE6dneWbeto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 12:44:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 12:44:22 +0000
Message-ID: <6b2bafa3-1a8b-4f15-a921-5edac81de41f@amd.com>
Date: Thu, 6 Jun 2024 14:44:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com
Cc: santoshsagar.algapally@amd.com, vasileios.amoiridis@cern.ch,
 LPolak@arri.de, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, sr@denx.de
References: <20240603164738.437834-1-vassilisamir@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240603164738.437834-1-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0027.eurprd08.prod.outlook.com
 (2603:10a6:803:104::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: a225531d-38c3-429b-b54f-08dc862663d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUNaNzVIbU12UzVEVlJYUDlmVFFzOS9qM3M0VGgrWUNGeTBmTXVPSERkb3VJ?=
 =?utf-8?B?bkp1c1Bva0M2MGcwKzhuc1NYdC90dEtyYVdGRk5vTUg5cndqd1hyL1NwdGpK?=
 =?utf-8?B?R0Zyb2pDeUtuYVY2VjBzS3ZzVHFkbUYwWmFUenl6RFVnWlFFVE91Y2NZaXQ0?=
 =?utf-8?B?d1dYVXFHdEN0OTkzTFBjZUlLd3JBc1RWRmtSZExxVmxLY0tJOC9mR3BlakRE?=
 =?utf-8?B?aU5mWXlzL3pUSVAzMG03bkZXYm5KdlVZeWU0YkRJQ1FZcXJYVXVya1FCaDV0?=
 =?utf-8?B?TXlnNXJ3eVplaDZkMVdLcmdGYlcrQmdxcVdjbHNjS01CTlBqUytkZndvSjE3?=
 =?utf-8?B?cC9YLzVJcWJoUHVjSk1Rai83a1hYYVBLV2lHMkUzQTVnSS81Q1RnVHE3eXpU?=
 =?utf-8?B?TklhSWJLTUx6ZnlhK0lHMTRHQTcvUEVnUForaDNicVFNZnJKbStISjc2OTly?=
 =?utf-8?B?WCtlblhaU2NTb3JDSGdENWJkczc5S0VJZE54MUlnVEZ1UVpkTWEyYWgyZ2l3?=
 =?utf-8?B?SXk4dG1GaHQvdEd3dk9ZYzhiM0xqaXZjYmlRL3hobjVXaXdXSUJlR1N1MnQv?=
 =?utf-8?B?TFN4L3N5eG1TZzhpc0dnQ280K3JFbjJrVTI4T1BoaUJZeXJXc0tlemV2NTdU?=
 =?utf-8?B?clZHVzEzS2M2Nkc1c3F2SkhyZlcybldCdEFmUUFtTlI0NTBjR0hnKzB5NGRZ?=
 =?utf-8?B?UTZaRWV2cklkTHdiTkoyaDh1WmJXQjg4cUJhdmlzd3ZuOEdhL3dVMW1Qb0dJ?=
 =?utf-8?B?eHhTcW1SRG5Ud1pvdmViY1V2RWVFRXFMblpqaTVrSlE1V3grZFBmMHVTdjB5?=
 =?utf-8?B?ckpmcCt3KytZMXVKSXhITlJsbVV0aVV3aC9NemIySXd3bnA5bWg0TlladU53?=
 =?utf-8?B?cFlOQ05IVWw1V0JuSWNvQTVwbVd3VWFWTkMxR0YzVVFmeWh6SFd6L0lkdi91?=
 =?utf-8?B?dEhpa1ZHSE03THpGZHFSQzF1K1ZBUnNBczE2WFJYYmZZdzlOeVczakMrSVVI?=
 =?utf-8?B?c3NHOVNvdUk5WnR5aWtTOE1DZ0ZJdHQzTE1iYXpVTjVDallLais4Nk5oT21h?=
 =?utf-8?B?RE5KWHE4QlYzdzdoQkxLSkdKdDhlNEN1bjRiajV3ZTFoVlByVDJBU0hyREZt?=
 =?utf-8?B?U2svdUxPaTJYUXU2c2drQ2lKNmJBT0RiM1JJTkJWNjRtd3FjVEN1YmJwVU0z?=
 =?utf-8?B?dUFTWG42MzFEUDJtTTFxQXQ0NmRnOXVCbmRuYjF4MTlLNFJlRnl2RXViVFdh?=
 =?utf-8?B?aW4xeVIwNi91bUlYaVRVL1lwQ3dEZ1IwQVVmRytvRzJiUUMzdHpHUHlSb2FU?=
 =?utf-8?B?TlZ0S3JDTTQyekRWVE1tU0E0a2toNk5sQVpJRlJkSFNpTVZWb3ZlNEcyNmJS?=
 =?utf-8?B?QkFkczBQUGNWWXo1bHF1UFB4K0VCUnQ2VFZQcTgxTkF4Qzh6bG5ieUVPbTl2?=
 =?utf-8?B?WFZNd05FWGZVRlc4NEFaYUpQc1lDSkdPbEFLS05IQ2w1eVV3S0ExQmtqa2hy?=
 =?utf-8?B?RkR1ZUQvWHVLV2t5NDBibm9mdEdXZ1JGLzYvTG9YT2pxTUorSWd4aXQxdVE0?=
 =?utf-8?B?MlllaEJ3R09McnFndGxoRVdtUWVva21WdWxla1lTclU2T3J6RW1wajc5amJO?=
 =?utf-8?B?azl1TVMrdjZhekpVeGQ0VEZWNC8rdXRHRW1NNUx5V0VwNExaSDF5Q1Uybml1?=
 =?utf-8?B?cUNJWFNPYjlIeWZvVGY2bmk5c0hOWWNMZkh6Z2JJK0dEYXhyYVIwUE5DOXh2?=
 =?utf-8?Q?tmyYmKv8zYyycrxTPSdVRux5o/eppQjYFwleH4P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhwWGFtVnFlbUoxYTQzMGdaeXpWY29mVGlGN3JmMEJ1RlpRdzQwaDkrcDZh?=
 =?utf-8?B?WTlDcjBLdWhsZXZ3U0p0VVVyNDMzbjJ3d291WStZb29MbW16NFRSdXJOeGxT?=
 =?utf-8?B?ZGdRL1MyKzIxQm5yQ01kaW9yVktUSG00d0dsZ1RHQXQyK3hMUUxhcHhrdUZp?=
 =?utf-8?B?VGpNN21OUm5Ra09uMnhycEpaQzhlYjFXd2JITHFacUZhNG1KNS92WTdhSFlz?=
 =?utf-8?B?NUJqMXBtNWxWa0dYbTBEVndDcFNSaklJdjhYTXZzWFpiZDJtbHFlQlVubW5r?=
 =?utf-8?B?ZmQ4OWszSDQ2ZGFNK2FCdGcrblo1bU9CTU5DR1dqTHRuVzRqQU1DbmZKbWxt?=
 =?utf-8?B?ZE5xMjVBemV4MVZndkZ1SmlxVkRPWG0rUEJRMU5rbmpFbUhsVlZIczNGemlD?=
 =?utf-8?B?bmJxdUE3ZkJzc25oZDF3VGl1LzB1dzZIUHFnL1p0anl1ejJMNTBQLzh4WUVo?=
 =?utf-8?B?QUtDb09yN0hmNGFQTm9IWTBzZnlMMVVXdDVkbVROWkpGT2lnWG1naXpKSFZq?=
 =?utf-8?B?ZjdrbVNMR25vemtaNmNFaGMzd2VkZ0paSlZEcDdwWmo3dVA5RkdVOVFDQ2My?=
 =?utf-8?B?MERkMlh5VTBQTHZreWNvaytGZDFlT3BqRU4yZCtwMjE3M0xqM205dC9XR0tL?=
 =?utf-8?B?a21DS0tCQjJtUUhpcWpqRE5uVFBXZzFyNG1pSFErZ2UzQkticU9HV1BTOWEy?=
 =?utf-8?B?clAwZm5ENUN4Z2tOajlqWmp1TzdEaEZmbGVpM0dQWWlobDU1eGJCeTZUNkl2?=
 =?utf-8?B?NEZYTkE1MTNjMUxMdUZuZHhhbnpPQWhYSVVueGQwM3NHMTMwMzVBVFlxaDhE?=
 =?utf-8?B?dlN4cU14Zng2WDdqM3IvNHZUek5waVNveG52ekY3SGllVDNYMktvVzJEVkps?=
 =?utf-8?B?M2g2djhTWnZXelozYXhhbXFSeVV5d1lobkUwdzc1M0FoT1MxVEhaU0FtTERR?=
 =?utf-8?B?ZDZMdlpOY1J3T3MrNVltMUFGOWNVeTJod05DVHZuQ1hlekxTVUdHRGVKbkZt?=
 =?utf-8?B?QVoyelhxdmxkbGtPOWkyWFJqZm8wOU5tK2JLV1hiVUIvUE54RnZOcDk0VEdw?=
 =?utf-8?B?NS9TeklsYlJ2T1NRRUtUK3oxV2hBbkk4eG9HWDJPMmFvRTRmTXhaTjdkd0sv?=
 =?utf-8?B?eFpGZmhPdHN6V1FLUEU0MlZzeFJqZXdGQ09zWEYzT08xQ2Q3MXpsNWlldkh0?=
 =?utf-8?B?ZFYzRGhZdHdLZjRpUFBuOXdMZ2RUZDd4K1dwbVJFdGZNUWdKSHBjbXhQSzVM?=
 =?utf-8?B?UkRORlAycEk5WFJ5YnBkQmhMZXBhNDBqbUprN1MxTW5nOGhaa2dEZDlkYmk2?=
 =?utf-8?B?aTVTLzRxRlBJb2w4dXY4TlJIbHRpZ2JRQUdZbDE1MWJlWkFHZFFyVmxpU3Mz?=
 =?utf-8?B?bXN0SlUvaHNDdGxpcjBtM0RrM0ZmT092WkEvOGJxOVY1TVRYOVdDMFdtelVr?=
 =?utf-8?B?eHhFLzdoZWJ4UktMNDJtRUN4VzZxN0ZJUGF3VWx5T3RJRHNwcDVMb1gyblRF?=
 =?utf-8?B?VTlYbloyMUdpQUV6U2pPdGtRb0VMaUpBNFRlUnlJMWtxamFGL05IaGpKNmpK?=
 =?utf-8?B?OWR2d0h2cmd0ejN6T1ZtOTl4UGpzamhlOW1JM0N3QVFtT2VTcDdlNmRPVzVt?=
 =?utf-8?B?c3RqS2NJVmR0aEh4S2Z2SmNhdCtzTnJtcVAyZU9XVENMVC9seWFLS2Q0K0FO?=
 =?utf-8?B?R2VscjZhY3RaTjdpNlR2KzI1SVBOSDlFMk9xb2x6TEpIU3VRMXpsN1YvWnVK?=
 =?utf-8?B?WEQrdXZPZGQ4UjR0anNqWElMOEN1aWQ5QkU4NUs5TGU2L3R0S1RXdTVINTRL?=
 =?utf-8?B?cWxENlNMVEl6Q0FGN05xQ0dZSFp3Qk54ZUIza3NON3FPbU5TTVdyZ2t3TzhE?=
 =?utf-8?B?UjFyc2FYMXhNSkk5MFB4anJhOTArLzZCZ1Jzb29DblBKb1RlOFV4a0FjWk54?=
 =?utf-8?B?WjUyaGVwcnVtczNUeDFjT0p5akp3VmlJMnFpT0N3Y1RGSWpMSmV0aW4vTDV4?=
 =?utf-8?B?WTNmak1mbXd2Z1V4MlN3bHZyek1aNlc1SndNSnAzYStHaFViVjlJRFZ2a2NW?=
 =?utf-8?B?KzVJbnFtNHMwdEhBQkJ2b2VTRzhuOVVDYlp2NTBDWTBuOWk2aWxOMmdrM1Zn?=
 =?utf-8?Q?Xglmlw4u1SOLFRdVF818AgiIc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a225531d-38c3-429b-b54f-08dc862663d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 12:44:22.4162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ednM/p1oHNRPqwHUXyJWqmHV5NlfBmLV0tw/vDN7Fz1UQYd8xN/m75ghMOvbMvk0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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



On 6/3/24 18:47, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> 
> Changes in v2:
> 	- Remove duplication of custom hardcoded env_locations[] code.
> 	- Add implementation with general arch_env_get_location(op, prio)
> 
> v1: https://lore.kernel.org/u-boot/20240522174738.73522-1-vassilisamir@gmail.com/
> 
> Vasileios Amoiridis (1):
>    xilinx: Add option to load environment from outside of boot media
> 
>   board/xilinx/versal-net/board.c | 47 ++++++++++++++--------------
>   board/xilinx/versal/board.c     | 47 ++++++++++++++--------------
>   board/xilinx/zynq/board.c       | 49 +++++++++++++++--------------
>   board/xilinx/zynqmp/zynqmp.c    | 55 +++++++++++++++++----------------
>   4 files changed, 101 insertions(+), 97 deletions(-)
> 

Applied.
M
