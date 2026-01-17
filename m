Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342EEC9830C
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 02:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A5708367F;
	Sat, 17 Jan 2026 03:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aUgDndYL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA82836AC; Sat, 17 Jan 2026 03:31:08 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 591D383015
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 03:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8DSKhQHTgCKqllfwbZ/Typ5/EoLkm4oN6sjlSCsUUl73Dpll61FsFLzdQJKmX606rAMLw/LTuIVjBQf2xOhbWTq7Bp+tuPOOY2BX21ZSGuDuDFMkQW7Ha7yNk8NS1yV/HV8GQ7L0FTEARbz+oLWTsg4vUpiHZbqrQLI1lOiZTRVwioVtcwuJ48nQASE1U2a3RHi4EF1InEMxy0PSAjjG5MCrfcNJ8mVJbz/M6yDRaCfaGV6/7Jg37sK4wloROIovqGc3Yn5cvyQ6zzMABt0nqKxtc7ZXaNSO+o7AJ7hQvep6yE8sn7zQn4FxLWwWh/pyPiMvLEbr4B1NMf+OXYZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQ2x1zzH+TwhaArKbRfOPoB5k2yHyk9KEIkm2V+wYwI=;
 b=TZWLDjheHCv1X78z17p/q6FqqdFddfXePClHWl5YPeT0qXaQjOktXM2oGmDb8WDQBKIz/GDmhfWk2lDfW0TM2IggtgMsIE8EcvgoFoR86nvcM7FqTmyucyufQGNtjgZOF59b7f5pTsYc6F3PCa4MfhMLn+PmJJJwCCl8IEYYqE5chbZG1/XTIH0v0kEY2JIu+YjvzCHEyz3xrLU+lUz0ZHiMlwq1/PCZqyihTyuXptBJ/SxBa/2FLAgW8xTLizW2tfshBbGifge83HPGUDkXYtpZkNcwVfWnhM/8d7T1YcbpsSgwusMnp7iq9R1nyjsAoaehLSpcGvoG2MfQhDA+Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQ2x1zzH+TwhaArKbRfOPoB5k2yHyk9KEIkm2V+wYwI=;
 b=aUgDndYLuP6N30OSV7NEgBIDYs/pOh8Ia1MeOaKSj9G5vY4SVt/iJHFP82E0IrPEcaLgoc2QKPLoIo3yBhRYw0r1b+VGXQFsRLYAhLDXENXH/k8ZMZrNQGNLOTnddux632A3CztAqS/dZuqWKjYC5qw08kJviJP6Tdvot16fz6I=
Received: from BL1PR13CA0152.namprd13.prod.outlook.com (2603:10b6:208:2bd::7)
 by PH3PPFD7011BF84.namprd10.prod.outlook.com (2603:10b6:518:1::7c8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Sat, 17 Jan
 2026 02:31:01 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::86) by BL1PR13CA0152.outlook.office365.com
 (2603:10b6:208:2bd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via Frontend Transport; Sat,
 17 Jan 2026 02:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Sat, 17 Jan 2026 02:31:01 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 20:31:01 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 20:31:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 20:31:00 -0600
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60H2UvWN4103681;
 Fri, 16 Jan 2026 20:30:58 -0600
Message-ID: <b71dc5d4-e751-47df-8d3f-ad86b32c77c0@ti.com>
Date: Sat, 17 Jan 2026 08:00:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: ti: Add AM62D documentation
To: Bryan Brattlof <bb@ti.com>
CC: Nishanth Menon <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>, 
 <praneeth@ti.com>, <vigneshr@ti.com>, <khasim@ti.com>, <afd@ti.com>
References: <20260105183545.4108567-1-p-bhagat@ti.com>
 <20260105185909.t7xv4xjl3xzw4d6m@granddad>
 <d00d6af8-2c14-4d33-a24b-68a13dee6aba@ti.com>
 <20260108133154.5hitufe7wnsyaraa@bryanbrattlof.com>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <20260108133154.5hitufe7wnsyaraa@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH3PPFD7011BF84:EE_
X-MS-Office365-Filtering-Correlation-Id: db63e9c9-68f2-4452-3c38-08de557074b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUV2NnROemRBQnJvMDJGM0hwNjE0U2ZUallmcWVOTDZCZFNhNmdKbUIxUm9B?=
 =?utf-8?B?Mkt6a2d6MXVCYUJYcnBIdjBVQUo3T29DY3F2dXR0ZklId201WHd1SlRTWVFN?=
 =?utf-8?B?ODBSek9LenRWcFRmZnpNcjNFd0xtMG84bnVISUw3Z2lWeXJCK3lsUkpRUHMw?=
 =?utf-8?B?aXA4VXpuY1FIZ0lTOUlMNGdjSDZUNTQ1TXpUckpwN2tGMy9MRlZlMFBUTmxm?=
 =?utf-8?B?NmwzVGNtcnIvR21rSVdYUW1yeVBrYVpabkUzRDY3R2RWUlFNbWFBZ1hXVU0y?=
 =?utf-8?B?ZFlSMTRoN2lPd01RdjFkbDczZGM4ekhxR0xlU05PckgzT0JzeVVXS3dHMGxS?=
 =?utf-8?B?bUpKNDloME4zemVJajNqNm1sU0o3M1hFVU82U0ZXZmZ3anNhVkVpQTZ0eDA3?=
 =?utf-8?B?Mjg1UlRWb2E5cXhyd3JZSDJKSWlwV092MmJvOEYwUGppSFlISE9MeDMyMXJ5?=
 =?utf-8?B?dXFSeU54aCtsL3hHbXhyY0RLbjZmcUxSYzdRckJtcWYyRENZYzRYY040NUdm?=
 =?utf-8?B?OVdTRXBMWElxbUlhODlwL2hmVWxoeFZheSsyZFIya1B0eHNLcUZ3Z2h3TXpC?=
 =?utf-8?B?eERWWjhEUWZHQkpZTUtSYXJJY0d1T3czZlBiOVJ6dnBtNXpXUCs4c0ozYUlr?=
 =?utf-8?B?dTVRZndZeEpwdXQvS0NncUx5VUNmTjgzNHQ2N1d4dC8vb3RGVDlLVnhBRFVS?=
 =?utf-8?B?Y25QMG8vR1FSbzdGVW8yeDZRcm43UC9KT1F0ZzN3c01ENENhT2MvMUpwVk1z?=
 =?utf-8?B?K3hUWmFSTWtIQzVyNVU3amttbjZiZXFQbXR3S25HNFBWdXpMbS9WK2F5b2Ro?=
 =?utf-8?B?VGxyQjE3OUdxTDQ3bHFiUWNCWmI2bHJFRDMvL1kwRHJKWXdFTGFEcVB1UFpi?=
 =?utf-8?B?OXhhMHBPNjFzODlpUkxKSVFwR0lYeENRU29pRFplOFdDaFRzM01NVmJHSzVQ?=
 =?utf-8?B?cUwzMGxVdjBEUXFYbFdlVU5uQ1EvK2xFVS95VGg0WkdqNUJyQWZpM3RTa1JE?=
 =?utf-8?B?MFpRU01NV3pXaDlYZzJXKzFpSTlQZXpJTW5ocUhHUlNoYWNBU08zNkV2Q282?=
 =?utf-8?B?VkRlQTF3VDBCY1ZUeTB2WUFyL2FwZ1JpNzN6RjRteW92WVhESlBuNDBMTGsz?=
 =?utf-8?B?dEE2UjFKb1UwS0hpK3FjdGhjNlhYTm1aOXBHa1gxbWc1aGJZcWh1ZzljS1p6?=
 =?utf-8?B?SEhmSDQvODRhd1JXKzRZelI4c3l1OEZNK1h1SXFSU21vM0hiNkIzQTFnZjVD?=
 =?utf-8?B?aG5tbkJVb1VaUDNOaE5pckg4Mk5OSUxPb3hRQkpLVm9GdExtdi9VOFlXSXNU?=
 =?utf-8?B?MzI0SEVNRFhiT2ZJRnBKVVE2WU5td3NLa21NK3dCVFFhN2lXcXhOZjNsaFlY?=
 =?utf-8?B?cHNUYjRpdXlIYU50OWNiV0ZLdHNzUktOTVFOcWl5b2NRZWNldlpheVhwakRY?=
 =?utf-8?B?VU5JUXhwQkcxVmdKNktXRi9WM092UFRpdEZGZURJOXNQc0hnL2RkZDJRQXQx?=
 =?utf-8?B?QjN4M3E4N1cwZmdyUGxkUHFhZ05kelQrYmQ4eGhndUV0Z25hOTdWUWp2THdM?=
 =?utf-8?B?dVB3RWlISWtVaS9HNHVtZ3NoZ3hSczRtRUhlamxUd0N2Qmk0YmJrTk8reFBt?=
 =?utf-8?B?ZUJ0dUNyNjRtTGVQWTVJckJ1cEpWSytaTWNHT1JDM3FVaGJkRXZrRDFWV05W?=
 =?utf-8?B?VGpzeE9QbnRUUktQVnB6WWtaUlBURXVDb2U4Lzh5dXRjM01uVk9nVjViMDFF?=
 =?utf-8?B?K21aSjgxcGh6MW8veXc1NWkvUWxYMm5pbUtFTS9RQU84aXZNRUZmRlpqTGdD?=
 =?utf-8?B?SFVRRHBOL1Job09lUW5xLzExTlpqZnpheHVVNUVXRUlGOE5zd01sRWtaQWxE?=
 =?utf-8?B?ZmNHS2VidGdzOXNJdDFTblJIdTMzZ1lSMnJSc2VmWHBNd1BIclovV1ZCWEpl?=
 =?utf-8?B?dXRiZjVqRzlvMzRWNkVWMWFPU2RZNlNNZGVOUjVTRmFUbnQyaG9UcGZDT0J2?=
 =?utf-8?B?MEhiT0UyMnVhM2hPaUJUdmFFRWtyYnlTemZYWnpqTFB0Y2xtZzFUb2E3aDk4?=
 =?utf-8?B?QUZXU3Z5bVV6dHljMW9vOEhGeDJ1NHdHcUFhS01ORXRVMmFpN2s0N2VMTmFZ?=
 =?utf-8?B?RnF6NU92b1hpcGZ6QUNMNEtVL1RQcGtUTTVxUUttclluUjR0eThyUHNUYlhR?=
 =?utf-8?B?cHoyeGFnY2hjSXduYU9PUG10ejZTaWJXcE5pUHVFSzhMUmNDb3ZJVFBSazZT?=
 =?utf-8?B?a1pFTXQzSmUzSi85T1RIc2VSL1V3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2026 02:31:01.4741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db63e9c9-68f2-4452-3c38-08de557074b6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD7011BF84
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

Hi Bryan,

On 08/01/26 19:01, Bryan Brattlof wrote:
> On January  8, 2026 thus sayeth Paresh Bhagat:
>> Hi Nishanth,
>>
>>
>> On 06/01/26 00:29, Nishanth Menon wrote:
>>> On 00:05-20260106, Paresh Bhagat wrote:
>>>> Add info of boot flow and build steps for AM62Dx EVM.
>>> [...]
>>>> +  **OpenOCD support since**: August 2023 (git master)
>>>> +
>>>> +  Until the next stable release of OpenOCD is available in your development
>>>> +  environment's distribution, it might be necessary to build OpenOCD `from the
>>>> +  source <https://github.com/openocd-org/openocd>`_.
>>>> +
>>>> +.. include::  k3.rst
>>>> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>>>> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
>>>> +
>>>> +To start OpenOCD and connect to the board
>>>> +
>>>> +.. prompt:: bash
>>>> +
>>>> +  openocd -f board/ti_am62a7evm.cfg
>>> * Are you sure this is the location[1] ?
>>> * is am62a7 correct for am62d ?
>>
>> Yes, since they have same core architecture and count (also verified
>> locally).
> What version of openocd are you using? You might need to update some
> packages on your host.


My bad. New versions (~0.12) have slightly different path and filename. 
Will update the same in v2.


>
> ~Bryan
