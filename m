Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5155C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 08:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D4B86F1F;
	Wed, 29 Nov 2023 09:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vgMPyE0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0E286F87; Wed, 29 Nov 2023 09:24:50 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EEC86D12
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9kN7MPB2VCW6kqjxIHeUeogabHh8j99oLtpz0f/H103Kly/DzOxjpmdMfFq4ZZA2eDbHModetseOSuWapAktrIxZ7tUTNZqjqIAzm1snJi+V8xq/Y8GOEutph/qxywWeFJP9P1ufmPynpwTTVcdd3uGPqGRhpMqOzxKe9WTQS6TyT4Pl00oSjZqq0ioiNgPkh+rAx2LM4tWVmpZVIeDrRvayLIQNSXlm70i7az+NnNd6ZX4b07F18uelmuW/CcnRacvCttUtaUyQzYrAaz8KT/4AU9GO5M585ROxXteN+X3yHWHYINMdQSfmnmkqh4074VorLe01LwH4Xqnz53mwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+jzyrgmxOEMKCyiTUIve6yN4QvfvjfPcfWPtsQF/hg=;
 b=Erml77uFZE9t2HkgaBX8Nq0vY6QgRJYfjKi3Ga6zlRxHuC9xE8gMd7faWwOLiVVI+JM0fVAjU8SJHK5XvOIsji4kKpEBx4mrEdoJJJP2e3wd3z+V+EjNnr1XwYHoZAmyYQXtem6MAA3TkhDzsnQXvidyJ+IjHMH7i82Hdxs/T4EG+/eyP/yHfOsfXbN4I3nVqmnnUCdXXSmJsAaBSlYtQvfv6noSy9ACw9ddNaZudUuuqclX6pA+U+C3zebpf/Wtn+bOyc/BwhvhneOzvI+VcPiIdgpBfMa6hIL8CTKrWlCWnFSJaP5muJHOFKywQ/yRVVrsGnL0mGddhsBfgYlbGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+jzyrgmxOEMKCyiTUIve6yN4QvfvjfPcfWPtsQF/hg=;
 b=vgMPyE0ktufKlOkFA9aOA9tsyE19Wv4DBaXQbw56TzMQZ/cDTnvARd3Ex6KtoFwalKtsoae5SNWGGWr9xgihAG2tdRDBwhmheaKzcPIxtNTFwjBG+B6zjRmyBUpnAJF+t8lAkTbQv31OdrMVH9CC28MA8Rx/f9ZtcQ59nElVEBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 08:24:44 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 08:24:43 +0000
Message-ID: <3a926efa-2246-43d1-bb3d-e7d028f8d529@amd.com>
Date: Wed, 29 Nov 2023 09:24:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Xilinx SPI driver enhancements
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Love Kumar <love.kumar@amd.com>
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
X-ClientProxiedBy: VI1PR08CA0261.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::34) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f332e1d-ff2a-43c3-cb18-08dbf0b4a377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIXjaU6paAK5JOy3QcP8zAuJG1XDcD9MCRMrJmpFQqFo+MgCd4MwoNl6NEILokkfE6IZNEfpixeQgUNmszNe3ciZVZLKptLIIiQWuNicwLf9CNjZytc8D9iXEPKy94sDledaovSsWQtjCINVHzQ5NV8WL4/heQyzF4PB4cSLQv3c6f+dL7IoDWoMGBcCPdDMFm484/LfxDpXiZAGBuF5lO9oENscQjCCC6emf26cjDEF+jqG7Dbv/DdtMM/PchWe42JqSxPHb/IjmZwUWes4PckX+ohxb2drMtUm5ZRvgIElTIphmwaFrqhAxptRqWr9/KBbZ2l00KabwpNke7TW9hiS0CR4pueGZnc95aFd0MPpsQjVeBpFIGz6FUFRdQLVVEz2xN/2IBd2z2Ki/LVHyD701S6rlwannQvVBcE0LocwHG7CgUTt+NFOmuTMl1ueRxFM1+IzeEd8MMj3I0feYDOridn+BjqpL06Xq3X3B3WEymDixPdER5MKZacFyo/ouH5Iy/VAw94ewT28IgNV8DJKl30kDKnTodSaDlkHkldc3wZ4fVruXmxRZJ1jApRdM0RFmkmWQ85OzRjma195T8B0MlBa8MHk3c6v/GWib4DlwzjB1/pDboy5WDrP9cUNoaI0nvuTwJFdQmwinubztw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(478600001)(2616005)(6486002)(6512007)(53546011)(6666004)(6506007)(83380400001)(4744005)(2906002)(316002)(44832011)(5660300002)(6636002)(66946007)(41300700001)(8676002)(4326008)(66476007)(8936002)(66556008)(54906003)(110136005)(38100700002)(36756003)(86362001)(31696002)(31686004)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SE1TcW5ESHZBdmY2RE02SWhlVnI5K0JTcWs4VDluU0hUdG9nRldrMWN5VEZX?=
 =?utf-8?B?ekJYMXAzU0J3bGpHYzFzWExIZ0dyRkFXMkJlZ016SHh4aDNVeHRVNW84eS9Q?=
 =?utf-8?B?YjdDb3A5bFJqUHY5ZVl2ZEhCNjVpU2p4ZFpMOFhFTjdhWnE0SFVCUC9rSDM4?=
 =?utf-8?B?ZFJTNWJqSXdXUjBCK21FRDh5ZHhQZnFSODFzYzI0SmFiL1E0SmdXS1lwWDNm?=
 =?utf-8?B?Qi9IRkpWSWZ1NHZTOWx6QzdzTW9xL2xnb2l1V3lhb1pqbmZ1YnhZNlJ0RVVP?=
 =?utf-8?B?MkQ2VmIyTW53dzNIc0FnemNENTZyd2FDQTZEeFJyRmx0c3NJclhIYVYweVM4?=
 =?utf-8?B?ajU3eDM5RzRsM1IxR1lCMDhSL0I4MkpPTjhZdWtMS241VFFwZUl2VXpjeVg5?=
 =?utf-8?B?TWZCSjBFTmJ1Y1BtZzRQMzZoNnliTW4xWDd3amR0T2VZUGpXb1pPUUJFUk9P?=
 =?utf-8?B?RXA3QkhDa3orVDQ0dW9ZdVhWQ3VINFN4Syt3T0t0ODhrN3JXQXRnWTlCMXZM?=
 =?utf-8?B?cVlObDg3TjN2SlpJQ3YycVE1WHVPZUJxejNldHFlTGcwek5DV3BGeUp2aENN?=
 =?utf-8?B?OXl4UEFTZnRsaWRYRFFHWTNJK1UxS05ueXFhWHJldVROcGNCN1ZySVZYb1Rj?=
 =?utf-8?B?Mng4SXgvVVZqY0dIWHV2WFRVdmVHQU50eWhiOGkraHJuRjhhOXd3L1dSM2wv?=
 =?utf-8?B?eHBMS3h6VjhnQkx3cFh5cE1rWk00a2pYa2tMR2FiZm9OWFB0K1NRajZwMUN2?=
 =?utf-8?B?ejNhN29IUytvZnl0VTFsdnZVTXhCSDRTbFRrRFdaT3dUV1MvS0hGdXQ3RFJF?=
 =?utf-8?B?ekMvNkZ0VldOam1PTmIwWkwzUE1CSU5DVFkyWjl5VFRiTFo4SnpDVEEvc1BD?=
 =?utf-8?B?UlJhUmYwMGFEWUo2aXFIZjkyK0NTNHdxcmdiNFRoRzJUdjBmU29nY28xMWJN?=
 =?utf-8?B?N3dlSGRQaDUvTHhqOFRmK21VajNNK1N1OE1JVFpWSGRjSUJSalZwZXlZRXUz?=
 =?utf-8?B?ZHhwVi9OMVEzNUxiWk5kbTgvR1V0ZkhOWERqbUZwaS9FclNiejBWWkxua2NL?=
 =?utf-8?B?WStvMzlEMDhGZUJLT0E3STJQL0J5ZGkzMXE0WW8vNkZUK2ppVmRJaWdpejNM?=
 =?utf-8?B?MmtCU1pYYjNZb1k2VExId3dxSVRCQlJqYUlvVFZNYk5kaFRhbTl1dTVacU9Z?=
 =?utf-8?B?OUNXY05yTDh0WVFmdXUzL2J0Q0dReFZMei80Nmc1Qy84M2FDQWpCLzZneGFM?=
 =?utf-8?B?VEVWeGs4eUFoSFhER3U5QW9mS21td01sTWRSck40Rnk2bHpRTDJ0d3IrWHBT?=
 =?utf-8?B?YlBFQmFVSjZVYXZDUGVwU0ppRHJqdEowWUdZQWt0SlR1NkJwOWlsQUlMNzB3?=
 =?utf-8?B?RUphTlo0WTNVVDJYamQrc21FRWFFUC9LNXgvUEFkbUsrbzV2bkd1eFJTemFZ?=
 =?utf-8?B?dUJObzVXZXlaaFI2bVZXYThzZzBjS3dnd0svUzJ5RjZuSXhiejV0b1l3dDNp?=
 =?utf-8?B?Y0RRMk5SMFZJaXFPM0tOTkQzd2F1TGxvWDFmMGJSa2FFcjVXb2JHdjVMZWF3?=
 =?utf-8?B?N21uTVU5a3hBZHpPL0lWVUNzeGIxOGJoZ1ZYYzQ0L3BNbHhHVFIvN2E0ZE10?=
 =?utf-8?B?SXFKbE1uSFV5Y3YwTmV5eGVnUlMwbnhUcERnRWZOaDcwVlBQNnNXT3ZzMEtM?=
 =?utf-8?B?eDFjVHcrMnRVUVdhQkxnYXFYczNjRE5Qc1NXcG80WFR3UFp6Z0Z5UjAzZTEx?=
 =?utf-8?B?NzhZRVpwU3B5VHVLRnU3RTJOc2lWdVRUNTlQVllzR1dXYVhMMmNPQ2xJRGE3?=
 =?utf-8?B?NmdnMFF0VkJiRzJFZ1l4aGwxL2xOY2JubkcrRkdrVFJKbUNnaWFaSUhkQ2h5?=
 =?utf-8?B?cGxBSEhKdGZBZndVV2RqNGxRM1dzN1ZMVVhIL0hHMGhRYkh1WW11SGdUQUM1?=
 =?utf-8?B?emlGRDlyNHpkYWVzU1dwUGJaVjNxVWcrTkV4ZExZVHJnYUl5UVNNekxDWFNK?=
 =?utf-8?B?bUFMNmhWNmJzTksyWWRBeHdNdmNMbFY1YWxyZFJrblNRUXJyRkV0Q0hYUGdM?=
 =?utf-8?B?c2V4TzEreVlsRWpRNXNyMnV5a0EvL25URWJ5Q05TbGZZZjhUN2xHalZ2aWN2?=
 =?utf-8?Q?taryhI5V4gbMijQ//lSkWEYSB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f332e1d-ff2a-43c3-cb18-08dbf0b4a377
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 08:24:43.2930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IdHiSOpZhJ3B/7NhdEGn8mO0h5Fc83F9+wl3nwbc9ZVaQtIWGgNgpdWn0TvjdSjy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173
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

+Love

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
