Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA62EE499B
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 11:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC378929E;
	Wed, 11 Sep 2024 13:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gFngaTRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 760918929D; Wed, 11 Sep 2024 13:48:36 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96E189299
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 13:48:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKS0tS+e5BHH5ChXOEtTuca2CBlGLWVk3A/36uOvcij/PZ9XedD0eKUcR/T+V1Bm0Cv1ZbY3E6s6E/eeFI3tJBNz87vKyWBhSFLo01ziKN17L060xDkC665IrN6/XrMQi+0Nh1pnPxS8IJU583TLWXd7aRxgo3vV4gLaYp1wzWa/3TNaJ0FfnV3ZGG/Mtw7geCeVvmCjhbFsHhJxqxSHeWv/NCpDCkGh2wyMRLxXQHDO6WXsw/64ZKbk7UkV5y9sT4sMovKX2iyPVEVK3QFl9df5TMnnWgTEXInslpaxcCyh6RHuhdxmuL2eiEMxvGiQyTciQA+11iGd3mNUUIqG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HIy82Zz2UBOBEtIgCLtMlv+7VbwYA4TYmgmUfNvX4M=;
 b=CdOrr4LzgRrOnIj7bQkfl9DwCbccvUYEzO/7NkLaOxRnyM6zJLGJazape2IqR4eOKJZBkVhQ9WlqdOkTqpfA5mvNMHk1TDeI2eQROeYo5tdjkumzYLMtoZRg71A+YoyZYiO9W51cZOHSxyWqhArEwANWCYjQYcLGBrd/wHZWDr8OmlZiUgMjG5JA9h/OwBDhGyYv/UWidkN4Y3WzUKJuj+YMq/rQg1KMynTRrOimlZxiJV861KRWZYy2UZfl/lccEvRm2vwITpFMpya0Vv9T/4RGAlMW7g9CmL/5K9unE3wbZfAGBRPUuDmhuCATypT/OpBmqilS7oMrC2f5SPvxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HIy82Zz2UBOBEtIgCLtMlv+7VbwYA4TYmgmUfNvX4M=;
 b=gFngaTRy5K7gVJrkVs+h93XdGBStDW3uwa6tA05LiWNEq/VXwbfWOuDPeLF2y80sNOFKMg0Lv02BzmxNH6pi6LKB29CU3G6brU5QDi2Ar6l60/6CByYZZOMo8J2wynGurLkkw0MbBf6E62nufGbcIlTCgRMgv+A0slcCMxje8C0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Wed, 11 Sep
 2024 11:32:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 11:32:49 +0000
Message-ID: <9fd1ffac-4045-44b1-b0b9-e2a7442d2fa9@amd.com>
Date: Wed, 11 Sep 2024 13:32:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cmd: sf: prevent overwriting the reserved memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de,
 git@amd.com, venkatesh.abbarapu@amd.com, padmarao.begari@amd.com,
 git@xilinx.com, jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
References: <20240910154344.1837906-2-prasad.kummari@amd.com>
 <CADg8p94Fc55EYFVca8V5NPq6xWePgLhV93ebRfFEf-H_GoFgpA@mail.gmail.com>
 <3f149f20-7663-4e37-8a9c-52e4f87b62c8@amd.com>
 <CADg8p97E-Kj_7Sf=_PmgrMAoQwks3wx1Gkqx4Mk9yHhG4Mz1_w@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p97E-Kj_7Sf=_PmgrMAoQwks3wx1Gkqx4Mk9yHhG4Mz1_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 088a878f-5117-4bcb-df24-08dcd2557742
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk9rblZZWVhPRXk1d08vUTNkVThaeFYvTkZOeW83MVJnZkdhNFVLdGZKVmFt?=
 =?utf-8?B?K2N2TDNLMmk0WFRJYUplcGZ2NDdTZzJGTGlFQXo5YnhETmp6SUJqRHN3YTVk?=
 =?utf-8?B?N3lLSW5HY2xjaWkzVTF3Yk8rQytQSnJZYlFvbS9pSmUzTEMvWGVsNVBZY0lx?=
 =?utf-8?B?RGJIeXlFUGtxOVpua091Wi9ZZzc1UFF3YTZoOWgxLzMzcUlRY1Z5S1FzOEt1?=
 =?utf-8?B?eDdHdElQUVZtaUVkMUdXRkJ4MUpEN251RHhkWExlbWNhN2IxSVRRUG51VWRn?=
 =?utf-8?B?Y3NXREg1aEdnemthcSs4WmZya1FESFJ1YnRtbTVESnd5c1psNi9zS3BMbWwv?=
 =?utf-8?B?ZFdPckIybWxNU2VubXBLMEdCTWtuRENOTXFLd0lld0JTMG1KTHN5ZjhXMVdZ?=
 =?utf-8?B?RU9DOVBPRmJkVTBPaW9rZFlmSDRydm1ISG84d2RLVnFIRkF0dEtWcGhCRnBa?=
 =?utf-8?B?ZCtEVndzdk5MUGp0MDZXeTE3SUlodkZvRXFZRVh0Ujl5TWEzSWdEalpmNmF0?=
 =?utf-8?B?aTg0MzM3Z2V4SnMreWVzV0Z4ckxVM0hsY0FVRmxJd05RcisrVmcwNDBCQ05p?=
 =?utf-8?B?a3RzdUk5VEdwUVdMTWFkc1RRMmJsZVM1VCt4S0VQVmhIWVVlUmxaQ0VZOWY2?=
 =?utf-8?B?SjhSODIxNWNFeDhQWVNEcm1RR2VsdzE1UFVGeUdMbCsxWU1odGxRayswbFF1?=
 =?utf-8?B?SFJTVEswQ2FHL1ZFRkRJRHhod0p6dFUvUUUvNlN2ZFRoVmpBRkxZV2pkOTRB?=
 =?utf-8?B?TmMveUVmTm94cEhGczVPZkhGcXBPNU9mNHBiSHdlYmNMWXlQMVpzd0lUNUlk?=
 =?utf-8?B?akxjdzdSU2IzSHlDSW40NWpQNnUyQXQzMk1kU2tpTHlKQ0V4dXY3M3c3Ly9j?=
 =?utf-8?B?dmlJQ0xMeHA4SkNDZ3hETWNsd2xpdXNVdUdRcWhzWTJEZXkrZkZXdHczUHh6?=
 =?utf-8?B?eXBIQ29TVDRaMTd5Slp1eU0zYTJXdEViekl6bC9jZExyY0JiKzZ2bDdmeHdh?=
 =?utf-8?B?cklneUFTckRPWWdUc3NTOFUrc3dmVzVBRk9FSmpRaTFvblRzeVl2NWVGSHd4?=
 =?utf-8?B?eTRnVUk2dy9xeE1Gc2RqbjN3VUM0OU9oN1JDM1FMcUJ5VTNKOW9NZURHZVNU?=
 =?utf-8?B?Tk1xOU9aOFJmdHJKOC93UlBhanVVTTJDSDNtOWYvKzFXT1EwRHpkenp1Tk9q?=
 =?utf-8?B?cUdES3BzanhHVG1FRmV0TGtzbnZCeUlBUlpPRTBqQU5KNnBWZWxiQnhMNVhZ?=
 =?utf-8?B?b2ZNeTB3WGVPQUFzejhwZGJMWkhkVjhOVEtkUzBHeTQwbW84K0xSOWpNUmc3?=
 =?utf-8?B?emhxWXZ4aldnVTJsdzk2QUJVWndOM0ppb0VobDJ1d2h2Tlp1bE04MzRaMm1H?=
 =?utf-8?B?bXVqNFVvWTI4VWZSV3poNlZXejJ4S1FKc3hkU0ZHRDMxbTVUeEJzdmV4NnMz?=
 =?utf-8?B?c21Xbmx4KzBITmxKMkFuaHNacDg1RE5mem1wNnpHcFVWbTFPK0h1L1pLcElp?=
 =?utf-8?B?UzhwY3dOUXRtZWFzWmVVQmV0TXQ0cFhkQWlsZW8zNHpabXZIRDJXZzZYZDhF?=
 =?utf-8?B?QmxJdTdBMlZPblJGVEZCYjhJazhwejFxME0vTmpscUhZUG4ranlCVW1yWlU1?=
 =?utf-8?B?Q1VYaVh2WTA1NFNrWWRLZHUwbmxkOGhVblc1Z1RRT3RobzVFZnQwYm8vVm1Y?=
 =?utf-8?B?V3ZBWUNwWXFkdE5RaVQzQ0hqRXJzKzM1K3NJajNtcVl5K24rUDhXSlhlYW05?=
 =?utf-8?B?SkRvWGFrM2c0TjVGSUR5c1JLT1R1VWhjTjNqNkVYZENYd25KaXRKb3BqZjNl?=
 =?utf-8?B?b3RhZFdhaC9Pd0VwRU5HQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJpbWlEQWlHYitpaUdlSEFrMmhGWVo2ZTRNMTBYV0ZLenRZOUhzUk16NGli?=
 =?utf-8?B?UlFGa2lBOHQrZ3AvbFdrSXpBRS9HbkZjNEhkT0NWaFVsbnhhZWRLVlNRZHJq?=
 =?utf-8?B?eU5Qd3dySzZvcUhJa2JJcHJEdjI2U0t1Njl0YUF3MGc4UC9taVVUT05YZHJ1?=
 =?utf-8?B?ZmlUQlZhMjZWNXprUmQrYTVyV2N0Vk0xZTR0UERtSGdMZkd4ek00cGkvQnZ1?=
 =?utf-8?B?NU1PUGNad1hLV0tpc3ozMzlHOE8yTkJ4aHBvcU54Rmt0VVpwZEFsOU43b1d6?=
 =?utf-8?B?NEk5L0xQUk4wUFAyOWhXTUxORnpaRFJERDAxWmNMYzlReHNTZ0RJNlI3SnB4?=
 =?utf-8?B?Zm9FVFJCYnpydSs0Uk1jcTM5dEd6aUpwN2FQdXRiUFh6M1lOd1dFOTZtUjlY?=
 =?utf-8?B?ME9ERTU5d1ErVXRhWkY5aHdESmpUM1V2eGsyYVcrZGJwaHBqZHprS0laWGRY?=
 =?utf-8?B?ZC9sUUNScTA0RWlCYkN4MzQxRDErTHE0ZlA4ei9zTWdZbENBOWQxaDJPUVBL?=
 =?utf-8?B?eWpQMW9RV1dsOVM0ekRLZ1o4NDF6WHVXdERPa3ZhbjVRUU54dDZCY0JlTG5n?=
 =?utf-8?B?d2ZhT3dBV3RlS2VWNVRHb0tPNWx5MUdzNm9uN3F2dmxDNGFXeEMySjZZTnhy?=
 =?utf-8?B?eUt4b1hXT1l3YTl5MlVQT2FMMUYxaXQ5ZVZDSkJzcDNRSnpBVDZRYXRienlM?=
 =?utf-8?B?SDUyTTlqWE9wZUVyVk5iV0Y4L1NIYTh5QXhpeTdXc01BUEFTMEdJOElGSnVK?=
 =?utf-8?B?MlR0OWUzYUp2bVRHVmkxSHFPWU40bWFzTW5YK2VmcHp1aU9NZVR3NWpvdGlO?=
 =?utf-8?B?RlpYSUVqZU1YM1RaY1poK01kaDNodDZZdCt6a0RSRlFLdWJxeURtdWVNa0tZ?=
 =?utf-8?B?OGltZGQ2WGZXcUlSS045Y2l4ZWRqU01JbEZZSGdndFdTcVVtdithSzJxUGw5?=
 =?utf-8?B?cnR0YnF2ZHlBOThuZ2V5cFYzNEQvWDdkVlVsejAvU25mME5JVkFOS2lJYm5R?=
 =?utf-8?B?OW9oL0dZNU1aaHdRRGlBNEhOUEwvdHlxYWdlYzRYU1VBek11V0lVNVpITlBZ?=
 =?utf-8?B?UDd0MmhSL0RwWWlMVlQyR1EzSlpPaHZjWTQ0UFgwOHBnSlp5bFRjcFU2dDJx?=
 =?utf-8?B?L1VYRVFwY25PZGM5RFVRNG1FVld3SUtwM0QvZUs1amttY0JOTTZlRlZlcFlR?=
 =?utf-8?B?N0xkYlZkUkl2YTV0cXc0djBKVVBia0poMU9VYkZkQUxtSXZwbE8zU3BsdTBY?=
 =?utf-8?B?Vm5TcmFVZnpxN2ZLQzZpOVFiWG55WlNyUVpFenUvVGQ4anVJc3EyWTg5TGds?=
 =?utf-8?B?Q3QxTHEraDZweGpLaGpxbzdWdUNMaVptamFSM3lyM28wRnZEem5kbk5PTzBT?=
 =?utf-8?B?dTFjUks1Sk5WZ3JkUWVqSkVmaVlmOEx0Qk5uWVRQU1Rlb0d6OG9FMyszZXNJ?=
 =?utf-8?B?cWVIRHBZYTZiOHE4djd6QjBqb3N3NllEbFhuTVYzU1dkcUtLZTFWczhiT3Ix?=
 =?utf-8?B?SDFkK0dYWUNTMFhQakZrSVlJem9HQjh1TnNYZDM0Ym4zVTJYQy9Od0hpWGJy?=
 =?utf-8?B?SENkL3JjQ1NoemFyakdvd3oyZDZ5Z2NlbXEvRkRwUzRUVEdSR3IrVXhyNENO?=
 =?utf-8?B?MlNUbXVhSDR6dWxlZHFVd284dmJ4L01wbVF4V0tRMi90ei9Jbld0RHlBbmF4?=
 =?utf-8?B?TUpGMW05Y2YwZEpuYUsvdlAxY3VwSHdrelB5NWZnaUZwRmxidTl4OUo0STBo?=
 =?utf-8?B?dU96SklicTVoVmU4UFBuTG85UjV4NjJVZmUrelFxRTFqL0FpMGVlRDhMWTVE?=
 =?utf-8?B?MmhOSk1oK3R2SDY3b0xEaEk2L29LMGF4RDRsMVMwQ0MrT1MzcEsxZWtzZ1lk?=
 =?utf-8?B?V2svK09JMkhuTkt2VzVzN1hwYnVEd1dLR2d2alJkYkQ4ZmJkZFk2RzMxN05m?=
 =?utf-8?B?TWZuSURTRHdacktHakk3UjFRSS9lQWdHS0lqbjNQQit1dUxYODFKd1o0YmVp?=
 =?utf-8?B?dC9QSmUvdFVSdjJBcTdwWVJhNDYreHA5YVl1a2xBbjR4UmUzdHN2aDZacS81?=
 =?utf-8?B?bjJ0SzFPRkE0YW9yUGZYaEhDNlNscEpCVE9IaXJtUmV5cm9kcTdCMUFUdjhT?=
 =?utf-8?Q?AHGru/5N7O0aqmdggHWsBBmYD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088a878f-5117-4bcb-df24-08dcd2557742
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 11:32:49.7003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsqrDEkrIW7923oL78fTcD9poZ5VGG+2mLdqI+NDtizkfUBJI7lmpimk2puQR6LB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529
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



On 9/11/24 13:29, Sughosh Ganu wrote:
> On Wed, 11 Sept 2024 at 16:53, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 9/11/24 13:20, Sughosh Ganu wrote:
>>> On Tue, 10 Sept 2024 at 21:14, Prasad Kummari <prasad.kummari@amd.com> wrote:
>>>>
>>>> Added LMB API to prevent SF command from overwriting reserved
>>>> memory areas. The current SPI code does not use LMB APIs for
>>>> loading data into memory addresses. To resolve this, LMB APIs
>>>> were added to check the load address of an SF command and ensure it
>>>> does not overwrite reserved memory addresses. Similar checks are
>>>> used in TFTP, serial load, and boot code to prevent overwriting
>>>> reserved memory.
>>>>
>>>> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
>>>> ---
>>>>
>>>> Changes in V3:
>>>> - Removed lmb_init_and_reserve() as part of latest LMB series.
>>>> - Error message moved to one place.
>>>> - lmb_alloc_addr() is not required because the given memory address is
>>>>     being checked to ensure it is free or not.
>>>>
>>>> Changes in V2:
>>>> - Rebased the code changes on top of the next branch.
>>>>
>>>> UT:
>>>> Tested on Versal NET board
>>>>
>>>> Versal NET> fdt print /reserved-memory
>>>> reserved-memory {
>>>>           ranges;
>>>>           #size-cells = <0x00000002>;
>>>>           #address-cells = <0x00000002>;
>>>>           tf-a {
>>>>                   reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
>>>>                   no-map;
>>>>           };
>>>> };
>>>> Versal NET> sf read 0x70000000 0x0 0x40
>>>> device 0 offset 0x0, size 0x40
>>>> ERROR: trying to overwrite reserved memory...
>>>>
>>>> Versal NET> sf write 0x70000000 0x0 0x40
>>>> device 0 offset 0x0, size 0x40
>>>> ERROR: trying to overwrite reserved memory...
>>>>
>>>> relocaddr   = 0x000000007febc000
>>>>
>>>> Versal NET> sf read 0x000000007febc000 0x0 0x40
>>>> device 0 offset 0x0, size 0x40
>>>> ERROR: trying to overwrite reserved memory...
>>>>
>>>> Versal NET> sf write 0x000000007febc000 0x0 0x40
>>>> device 0 offset 0x0, size 0x40
>>>> ERROR: trying to overwrite reserved memory...
>>>>
>>>>    cmd/sf.c | 36 +++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 35 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/cmd/sf.c b/cmd/sf.c
>>>> index f43a2e08b3..7bb8bcfce2 100644
>>>> --- a/cmd/sf.c
>>>> +++ b/cmd/sf.c
>>>> @@ -10,6 +10,7 @@
>>>>    #include <div64.h>
>>>>    #include <dm.h>
>>>>    #include <log.h>
>>>> +#include <lmb.h>
>>>>    #include <malloc.h>
>>>>    #include <mapmem.h>
>>>>    #include <spi.h>
>>>> @@ -272,6 +273,31 @@ static int spi_flash_update(struct spi_flash *flash, u32 offset,
>>>>           return 0;
>>>>    }
>>>>
>>>> +#ifdef CONFIG_LMB
>>>> +static int do_spi_read_lmb_check(ulong start_addr, loff_t len)
>>>> +{
>>>> +       phys_size_t max_size;
>>>> +       ulong end_addr;
>>>> +
>>>> +       lmb_dump_all();
>>>> +
>>>> +       max_size = lmb_get_free_size(start_addr);
>>>> +       if (!max_size) {
>>>> +               return CMD_RET_FAILURE;
>>>> +       }
>>>> +
>>>> +       end_addr = start_addr + max_size;
>>>> +       if (!end_addr)
>>>> +               end_addr = ULONG_MAX;
>>>> +
>>>> +       if ((start_addr + len) > end_addr) {
>>>> +               return CMD_RET_FAILURE;
>>>> +       }
>>>
>>> This is one way to get the load address, yes. But please do note that
>>> with this method, if the region of memory has already been marked as
>>> reserved, the call to lmb_get_free_size() will fail, i.e. return a
>>> value of 0. Whereas if you call lmb_alloc_addr(), and if the memory
>>> region is marked reserved with the flags set to LMB_NONE, that call
>>> will not fail, as we can re-reserve memory marked as LMB_NONE. Hence a
>>> better approach would be to use the logic used in the fs module
>>> function that I had pointed to in my earlier email.
>>>
>>> Also, like I mentioned earlier, it will be better to refactor the
>>> functionality, especially if the plan is to introduce this check for
>>> loading stuff through other interfaces like nand, mmc etc. You can add
>>> a function in the lmb.c like lmb_read_check() which does that.
>>
>> Is this something what you are going to work on?
> 
> Can that not be done as part of this work? It is about having a single
> function in the lmb.c file, which simply does a check for
> lmb_alloc_addr(). It's not very complicated tbh.

It is more about time spent on it. If you know how exactly it should look like 
it would be easier for you to put it together and Prasad can validate it on our 
platforms.

Thanks,
Michal
