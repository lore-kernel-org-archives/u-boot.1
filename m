Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10828606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=APgbM2MZ;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tUl1Uzl+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF0714071C;
	Tue, 24 Nov 2026 06:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HKoKT4dDap9T; Tue, 24 Nov 2026 06:55:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EDD84405A6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795503352;
	b=JmE1dgxe2geWG4NKEDakuxsik0PS+2efvcDWfSGz92luY9cIduh4mZld3ckaqcF+SiVy
	 A3iVHld+qwbG4lPOdZ01zgG563+ONtIWu6/4YjTHxZb9qw7tT+UznqKQMCuo/nIGKz9Ge
	 VOgF5Vg1yNKTphjzw72KEnZoRkiAanqOwHHwABc1B+uz4U1ejr9enCXEJjLuIaCmo+wiu
	 FOn1rkbNhKW52scIKl1LX8gMiI4YyBrytgNz68hRfgUXJyFtNc3HrNoe3haDw80l6s7sw
	 2rOqPLpQLmYyKSVtz7ric3OlvobCxWnJKpxr66LtRE4E3msXQqCjmDZzJmb7MImKh8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795503352;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7c0RdsnrP++SP1S3pbnvbK73cMAUsMYUAOML+svfIao=;
	b=HUf52uW/SBchtS0U8IOxxxoca5OeL3h3bslU3JoVOlrdYIwsoGAJbiHketN8B+djJLBX
	 ayFeXfWeZf9MefwLlcQX9ha20m0ZIhntUsYVevXxQ8uwwekigDR/u08GnjbUbAXCq1Rki
	 /0pYngrYv+HhSGXccTfpk1wAWoeFECQ7YnoiYiq9omudChK48voewMfVTwD+jhjz/nLqx
	 ahM0GFZQMBGu2DRCCQtf5XBpIgwkuNmMYEfLrlAWnBNj/g/2Khn9Vz6f2kpmziTx5mQup
	 z1oM4vHVDoYVAxgDZTVIDbYf0c/uAFC5rYfQpuDaiEtqfNOAVGqwdzBKUNE1KXJV7Bw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795503352;
	bh=7c0RdsnrP++SP1S3pbnvbK73cMAUsMYUAOML+svfIao=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=APgbM2MZSnpo9RkW2GRUpDNGFgDlQNlQnPkb1xSaylTffjMdCbGgMCkzxY7BgPnZO
	 3WHP3//JxivO7rCUiJFwSkfuTfB3F0eddVNwcQmKpO/LKGpTHFpCuQrsxxv5Ic0HeZ
	 fKyJEbaBUXFPzSSeMwjuQaHp8tG1bzW8LaJjItjH54lYZ2hefX5YT8a+dDJexFfBBB
	 n1+yRkQgxFrF9PSBE5mzuw6Qff/MtQlYbmsE0CPPoIt/djGkEdCM8SfBDco2nEcG6g
	 j6TVE7zzCVOHUIxzAHh76M3vjp9RsALR8JPWr8CJerJ3aQLHqhFw3b3XB5u3WB7sLj
	 oMBRA8S0blAsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDD84405A6;
	Tue, 24 Nov 2026 06:55:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32723FBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17D1D40068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKcWXsBae1uD for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 06:55:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 41368400C8
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=tUl1Uzl+
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41368400C8
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 06:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c0RdsnrP++SP1S3pbnvbK73cMAUsMYUAOML+svfIao=;
 b=tUl1Uzl+RJm/vga9Un7NVlFfLTLrkNiVbuaZI+JoGCU4k7V7Y68/P3CSN5anJdBUBt7Ko3BiHo9b00S/8H+XO6DmhuEaqdW4rAVH+fIWMG7FAKwD7ahaGW/qUpK1tsxVK2mA5zZtmnf25K0kbe75kspOWANp1nplSYxWnBvrUyk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB052986.namprd12.prod.outlook.com (2603:10b6:8:47e::11)
 by DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 06:54:00 +0000
Received: from DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48]) by DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:54:00 +0000
Message-ID: <34e831ef-4673-42af-86a3-83fcd5ca26d7@amd.com>
Date: Tue, 24 Nov 2026 07:53:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: mbv: Disable -fpic for SPL
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Tom Rini <trini@konsulko.com>
References: <7e8bd7c06a0b5b32ad8b38b3a5c0bbd06c618321.1794228942.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <7e8bd7c06a0b5b32ad8b38b3a5c0bbd06c618321.1794228942.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::9) To DS5PR12MB052986.namprd12.prod.outlook.com
 (2603:10b6:8:47e::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB052986:EE_|DS0PR12MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: 313fcbb0-5b9a-4c22-7eb4-08df49f7b7ff
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|261021121427099003|261102123227099003|261026121527099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: +1OQ5AccV9qSTGbB9nmOARCgrMvS4xzGsdtqmwT9O/vA8y36FGPwKBZgOsPGq1LaThHQ0mzsh2OhvRzY1pPQEO1m8bsdmh9RyGv5xBvDI7Sn1huTPxsRGkg7HqVvHHASK8VVGTjNk4wGRb+mnSVgVWM11X7A3EZ2WbV5xREkX/8MgnJbB4v2rcBTiFVgK67C3GfnQ7mSkopmNa5lua5yqunBYAe6Otl/U0MUhFlQwu5zQ2xoH2VRklqmHvdiCmzy524h8Khg+pSmbt/oRkV2UHOVr1QBGe/AvSuoZDhW9RPhwRiySYtH7HnzeemW1AMV+zBdN6vy30N0LVD8K5IuG7xThYsqUIx7GBV9R2Xxvjme9AKZmF6F5onSAXvWgsySzlCFl/1v+p9hUivXsAGc1eDayen3p3MJ+sGJ2ddCbq5HurINv+MjBhWz6TwxJ7u1H0OeeA6XSgaPkKeE6wJOMkPUPaaXXckp0fx4YyjlUQ9jeuZyv8y5ytsHu+yZyjql6djwkE43buHJLEwWSZmzXF/7cS/LTw2So9gZC6L9B+jNaVab5hLLUx7prvV88R/xzQ/C30Wv64B5duUak8MrbdXrvXyshB9L2i9mX3tQyk5x8qTi+2l+m2NP/mQCiwy7yr3GCfLgXa4MVohGumpD/n7ZNqXRHcaafqcj0KKDKEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB052986.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261102123227099003)(261026121527099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDAvZXAzYXVUeWg1WVlNakczU3FHVzkyZ2NyY0E1eEg3Y2tBQ2RLcTZDM0E5?=
 =?utf-8?B?ZGE2NGlteDEydkIxeDVFMkRKWSt2NGZLbFdnSnBuY2V2NW1DNjU4YS82S0Jy?=
 =?utf-8?B?U0UwanRLYVZmbXJQcS9peFlJQTBsV2d4YVVZOWxvelFLY3VVOFZHcUJWSU8z?=
 =?utf-8?B?bFV3UnNuYnpXOFBDaGNUWVdSNkhFT2xXQlRhOWNSNHRsbkxSbzlNNUFFQmps?=
 =?utf-8?B?TFBFbEFucGt2YUN5VkVQNDE3M3VUOThVWENYU0dYRjZEcFNNWElEYThOcG1j?=
 =?utf-8?B?clU1YzB0dTc1Z1NyK3RiNlRZQzBWK1g0Nlo3U1BEY2Q5N3VvWlRUYWE0cVhn?=
 =?utf-8?B?YjVha0I4QUpBZEkwMGNsTXcxc0RaczBzaDV4OUYzRVVBb1NHL25CS1BpL3Uz?=
 =?utf-8?B?b1crZ29rWFpHTTVyNmlwOXRzYXFsdGF3ZStNbS9qNTg4N0xia29CdTlubkNW?=
 =?utf-8?B?WGtTOFJRYVhabVFHWDdKOU5pSElIczRmcENLSnl3d3J6ZXZmNmp1MXRSRjJu?=
 =?utf-8?B?RnBwUXl0VE1iUmRrdEJBNG9jZzN0cGlwNEQ0ZlpFcktoUXpwL3B6dk85UmR1?=
 =?utf-8?B?OEpoVk9WZVBKd2ZGUXJpTi8xL3lCSVlFNjd0T2JBUVcxZHJEOFg2aUQzWW82?=
 =?utf-8?B?ZlJyeVZoWCtNcytPaG5vS3ZiMk43VC9vbzkzRHk4SUhVdnBjbzhRT0lCM1pw?=
 =?utf-8?B?UXhSNkdIcjIrRkRueC80bzYxdWhlalRrRWtRd0l3RHcwWlVSemdMYVM0YmUr?=
 =?utf-8?B?N2pia0xncmY5ZVRDSGh5eldpOGlRdzdDM2dWdFlNVm9XNmtQd2lIQXFpMEJT?=
 =?utf-8?B?Ty9CeW1CSURlNTE4K2YxUVg2WlhyZXVUMEJKUzQ1M2xsd1lVMWR4Q1h2ZTEy?=
 =?utf-8?B?YmE2UWgyenRHUHpCREpmS3BwVUtYWEJEcjZmZVYrb1lxRG1CVnk0a3p1aW02?=
 =?utf-8?B?RDYyc1prbGIxY1F1WE1qbHBNL0N0WE9YWU1GNXg4Wml6TUhpU0hVYzlNcGhB?=
 =?utf-8?B?dVRlNnBycHZ0dmZ3Qk0vZGZxUU1SUkdPZjFPL3VIM0ZLZzhiYUhrMVJ5aEpX?=
 =?utf-8?B?MVZkamZrOEdlTVBicHpScjJHQ2h3NEw4NWtGSnREdTRsM1Zta201VWFKUVlm?=
 =?utf-8?B?eXNTUk9vN2pzbU9WbE5GQzRyUlEvY2xsZWhUVWt5enZBWXY5VDBnS0krMEhn?=
 =?utf-8?B?Ukg1aS9FWnA0WUh4d1VuaGxkOHM5dEtDZWs1MkFjV1NhTVV2aEJpSmhsYnQv?=
 =?utf-8?B?RVVnRjBIS3BMNmZzb2lYRE1VV1F1WFFrWkxwLzM3NmxkbFJhWE9vKytVYjQv?=
 =?utf-8?B?QXc5QjlsY0pPZnR5bVlnZC9LRzZxL1JxOGN6U1NUMlpLTlk4eEY3Ukpqa3BI?=
 =?utf-8?B?TmNEQThWRytWaWg1SXIwdU5lelY5Q3Npdm1lWVdzdmJ1TDVZVk5TOWh1SFds?=
 =?utf-8?B?eW5ac1NpK1RGTWUzelFuMzZuck5QcVcwVGdsOU9sT3I5UmdMM3NSdVFjNHdP?=
 =?utf-8?B?UTgwbmpLYzVmUnZsK3U2SnQ4Uzk2YW81ZUsyUUlReGliYWFnQnZ0YXM0WTJq?=
 =?utf-8?B?WFNOSW5hU2o2TTVpK0NjQ3hZT3pSWUNyMk1Sc2tTbVB5TEFNL3I2U2FQc2dP?=
 =?utf-8?B?SlFNc0x0Q1o5MHh5dGZ6Z05oMDRBQWNzbzdEeGxHclJyM1hBZkZrRGRSOGpK?=
 =?utf-8?B?Wjl2Y2FsZERTZEh4c3BWZUtjdWxNWUlvb01CV3BSZURKSFN4NWFGMll4VzNy?=
 =?utf-8?B?b2tvMndERExxdFNJaFZ2ZnFmMG5LZlczaERPM2tSRE10bnVtU0dma3RPdGkw?=
 =?utf-8?B?R0FsenM5QkdKMDdmSDlsWkY3aGxicm92dDVQc0FTaXAzMWZOa1Q4RGFxNHFp?=
 =?utf-8?B?UFJqTExRdFNRd3UvWVdtQU9sYjhHWEJGOFd1YVlCektMUnZ5OEJyVkU2ajMr?=
 =?utf-8?B?UzZ1amFNa2QrdE5QenpJUUljUGhQcVVIVkVYVWNHU3NOb2JmOUhRSVhqM3BC?=
 =?utf-8?B?SmYxV0wyOTl0YlpvRGVCN3pNTWN3M25xa3BuRU1BSjl5RW5OOElnVnkwZnJE?=
 =?utf-8?B?d0hONEZqeG9sMmd0TURabWx3UkR3eExMWENuam0zTEszSXVPZkNTdG95UEpt?=
 =?utf-8?B?YzVMNW1jaEhIbzA2dTVXNVZKWTBGTEZ3YWdFZGFVRWVaRVRFRGhMaTFzcGZw?=
 =?utf-8?B?WnV3YWFXWXBSTncyT3E4VzhURDhQWGNLWUtFb1ZPYmRJV05QNnZaOW5FVnRt?=
 =?utf-8?B?K0pTU1dOZnFVVmowSk9xYXN4dEFpSTFURHVsWjRRYW5VR1UxZXBMQkF2dUJs?=
 =?utf-8?B?eko4Zmhub3hmaWFJTTJ5Kzc2RUVjYVZHaGw5TGVrUjVCVzNwYWJtZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313fcbb0-5b9a-4c22-7eb4-08df49f7b7ff
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB052986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:54:00.3624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d7EB26Mkl4C1xEgJACKNVCEbhZwwf3s11AlmqYGuOzjjbIN0gwm0aTnj3gkghBf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7900
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/26 13:55, Michal Simek wrote:
> MicroBlaze-V SPL runs from a fixed address and doesn't need position
> independent code. Pass -fno-pic for SPL from the board config.mk, which
> is included after the arch config.mk, so the later flag takes
> precedence over -fpic while U-Boot proper keeps -fpic.
> 
> It saved more then 1kB of memory.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/mbv/config.mk | 5 +++++
>   1 file changed, 5 insertions(+)
>   create mode 100644 board/xilinx/mbv/config.mk
> 
> diff --git a/board/xilinx/mbv/config.mk b/board/xilinx/mbv/config.mk
> new file mode 100644
> index 000000000000..ec4d0412c27e
> --- /dev/null
> +++ b/board/xilinx/mbv/config.mk
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ifdef CONFIG_XPL_BUILD
> +PLATFORM_CPPFLAGS += -fno-pic
> +endif
> ---
> base-commit: 4b2c5fa37b4ce7235de2908f20ba433e79626ffb
> 

Applied.
M
