Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8527DD2CE17
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1893A83C08;
	Wed, 10 Dec 2025 08:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3lqfzoZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A5783C39; Wed, 10 Dec 2025 08:37:13 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4CA483655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRDgemf/7kNvCAfg38/tQ5Vw6KF1OVZ9aUtG0nIvHeNTU+ZY4Fvhi26nN9zmmSWRoioJqKxVj/WbdtlX++uFwcK43Xq/NZ1Lqra4tiA3w+enekDihPc0Mzi8UlkBm7yMya7aT1aXB7ucBNCM0GTh9NWb4dgY5xdBdeZUDZgan0GSGrdRYPICmNodkHVNUREuIXi87cVqGlz2nkWycqOoC6kJv39C3d2bqfHSlWVwaoylAQMNcsTgBKqA1baUWIh0oqHawe2cRHPwroxS5FovRQLPCZF/gR+Yq1noqiw2XgDeFnGBWZcUkH30Wf/5mPq5a8+ebh/sURXpMnrZJOC29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0uJzw6OiEgqCPkWZ2WFKMIxpjCtttd/lsOv/qPIKSY=;
 b=FlctyAebPzq3sfuWBqGLyd8uGXmrvA0dXw9ORHiayvGmxQqpgIlLmG7S/dQzkYxLCMA2kCon677RWf/WrcvQj8GwFh2w4kAI9iZeoeQ2qICGoDKE8p7zEOjEPucPsexB7iIxald/DUpRaN2AzTDFIF3Yj+ISbOmtmnpoz8vMWH/mLPHlv9Fj3zaJnVT9Z4N1e3sHes7qqUB///cBomR7T5BxF7Y0pDC11HEz3a9Hrp3+ujKySS8g0GXmjwLmmKS4D3lcbAx4iU8xHSf883h6QfxeBxPHkUEWZ+JzEAMYlpmMJxsYNQhG7CEbStqOSIMU03iW8KgX1NZAdTYpz2aDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0uJzw6OiEgqCPkWZ2WFKMIxpjCtttd/lsOv/qPIKSY=;
 b=3lqfzoZtVICQFXg9vYfBB6tGsKYYQPyyOdG0pFGcWU0jG9bBMaAdPg0S0jXlXY+vJ6WaP9n8AHjF5C4lfRVJ9vOo1FXzDzT6eUFYgW+h2tsPTW/MqRBgxm2ITUPTlj6tNMo5RFA5F/VL+ukEg3bCoUA9zp63Sui9d4iTAkhiHtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:37:06 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:37:06 +0000
Message-ID: <8c0a792e-0695-41b6-9c25-733e7126d09b@amd.com>
Date: Wed, 10 Dec 2025 08:37:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Read and show multiboot value
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <fd7564ce2f51d965c273e939e98de01beb92e6f5.1764232124.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <fd7564ce2f51d965c273e939e98de01beb92e6f5.1764232124.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:303:16d::28) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 3914cb97-ac1c-4bc6-4644-08de37beeb1e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1lFRTVscmFsQndjeHR3cmN5ZnllTVR6L2dXWGhmaDdIbkxVTlh6OENrbW9j?=
 =?utf-8?B?MjBQWkdkUVlFTUxKVUVBMFBzQ2o2R1FxWmUxdWNQbG11UTBrT2tNQXhTSDVM?=
 =?utf-8?B?VTkrY290K1pka3M1aUV3RUxqeng3bW83cW00Q2NramJqYzdFcWJDMjZSVG1V?=
 =?utf-8?B?S1d0SWpSYkxIK09Xc0xSbWVjY09sS1oxUXY4M0xKb0ZTU2V5M0d6dzU5Undq?=
 =?utf-8?B?UHRqS1BUZUYraTdyZDI0bWIrT3Fud0NEUm42UWIvRlI0S0taVnEvUm54RThp?=
 =?utf-8?B?cUxVRFp1YkgxZjRzOWVPdlR0OHZLMWJ2Z1RuOE9ESmRSaWJ1cC80UWkwSWNX?=
 =?utf-8?B?RDFFaDhDeU53TmphdWNmNHRPalRTdFFDOW9RcnlZcGJoWnVnNEFsQUZPblNv?=
 =?utf-8?B?OTc5MHBaV0lzb2Iyd3o4TE9SeEdWalJsVlYvTlNIdnl6UGgvZVB3TWNjSkkz?=
 =?utf-8?B?MkJXczR2dXV4V2xHbk0yODRML0lxS29seFZScm4wVU9lWGM1c0JJY1dMOGJV?=
 =?utf-8?B?NGk5WGU0clNidVJFbUV0ZWxkQXZrSHhSL0k1YzBXQkFSZlhhcDdBUjl5TmZW?=
 =?utf-8?B?R2pIcjh0czM0aGNzY08yNGQwRlpFc3NtdEkvR2dVc3habU41bkxvNUgwUXpP?=
 =?utf-8?B?ajd3MXp1TjdLbVpmbmR1bDJEeWVHaU0wSFVSaXhOM1dFU29NZWpDUDJLbC8r?=
 =?utf-8?B?MEQ0Vk1zUEU3OFlYWGd4V0U0WkQ4aktxV1JqUG9qZmtCZFgrTVE4YlIvZTNU?=
 =?utf-8?B?YURwbUtCT1BpalR5V3ZHbEh2UFV3ZEdTT0RnUngxVnJwZXMwUHJYcFEyZ1VW?=
 =?utf-8?B?UjAvdzFLTzhJaDFLWGF5Y1hkUUNETzJNZ2xMZnpFN1FZV3l2YURWV3FQSjJh?=
 =?utf-8?B?Mm5hWlltNXZkUytPZXhqWUpBckZETmw4WHUveVFCcVVXYmk2V2FaUzJIR1Ry?=
 =?utf-8?B?ZXZnQjFJcjJhT1ppbGlNa1hJT0IrRjBKTVgxR0tWcFJQVTBLbkxWQ0d0Uzla?=
 =?utf-8?B?aEdHanNOM2N1bzBsNm5SVUNFVFZmQ1ZORHhMV0k0T21YRlpzdnpCRDZFdWg2?=
 =?utf-8?B?eUpMTkZ3VGY4ek1qVDY0OEtVazdnZXdxNTlLYmRUeUx4NVFmSG1WcXY2dkZm?=
 =?utf-8?B?WFlTcUdTK1grc2s5S2dyalN3WmJGSzlqbTRmZUZ5MVorVDJ0RlRETHVaYUhZ?=
 =?utf-8?B?OTZTcWh2aHZmWnNkSUZLa3hwb2ttVzUyTWtwZ1VCdWljMy9TV0pVNHFXcHha?=
 =?utf-8?B?SkcyYmxEbkttQ0VkZVNjNlFOMWJqZlhKVDROeWdadGJ3YzVhTkpQNE82cngv?=
 =?utf-8?B?VTFBVW9ZY3ZHR0RhTUlmazlIbVZiZ0xHYWhPc0huZW9JYTMrdVlncGd6TXNZ?=
 =?utf-8?B?N3lDc1BjdXRBbU1wT3pmQVkrM2pGMkgrcmZodEV4ZlA4dlVoWFd6dWYvRGkv?=
 =?utf-8?B?c3crMjFsdTkyZUtTa0JYL3BLVmd1ZjVhRzUvRi9FcnM1bVBvbmM2T1JJY0hp?=
 =?utf-8?B?a2QrMDBJeisxOTdvWUg1eFFuOFhYK2NvUzZIcnFIN0JsMjVuNXhlY0JDTU9E?=
 =?utf-8?B?MFh6RTZ4REN0UDloSHF6aXlrNkhMSFF3M1FUZGpnUFlSWFo1YWp4TGN2YUIy?=
 =?utf-8?B?dThKdE43Wk00QjVrd25vWDBBZzg3dTBueDd2QVNUSXVMZFlwbU4zNUlvK2k3?=
 =?utf-8?B?djlKa2tpNGgvTTBLMVdqaHBGZmdLQjE2VEFEZVNScUwrdWlqQVo4ejdtR1NJ?=
 =?utf-8?B?TEJoVnduLzVsUFBCR0Fwb3hwZnk3cE5EQmVOVW9QbmpqT1hMcW9GTjlHNHF5?=
 =?utf-8?B?QmhLTk1BTktHQmtkVUJQSmRGSVNWTXMyUkpLaHFGRTFhMm5qbFVaQlZtK1Nm?=
 =?utf-8?B?RE5WY1J4TUVqeUpKdVdwUXVjWjR5OU5ySnI1Q0tqTWo1RUxiWE5Fc1Q3N1hR?=
 =?utf-8?Q?dtFrk7rnG8Bmvtv5zncS3ydk9OgvjrfK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpsZGFXRlNiMG5wMzNwdmFqWXdGVmduMDVWWkcxQ2JBb1dOYVZlQXpHOUtZ?=
 =?utf-8?B?WGlBdUR1SkFYUXRyT2tlVlVaV0NqU20yYVBJNmF1NzZlOTlvWk5uU0RWSXVr?=
 =?utf-8?B?TS9qeVU3eWw3ODhyS3dMVVkzN29NdHpjcTRyWHpicEt4OXl5OUl0bmFQMEZ6?=
 =?utf-8?B?U1kyUmdGNGtlSS9CV2duNlpGMkR0ZysyN1V5L3VIOVlFYWZMRkE1b1BIUkMv?=
 =?utf-8?B?cTJUL3R6YXRoNm8vU2xXNXhSUjNsSm9DZHhrR2poS1hVSy9qTTF0TXFWUjMw?=
 =?utf-8?B?ZytTWTB6eVI2L213TDRnUHdSb1dKVG9kZXNnelc4OU5GYnVnT0dtcnpOV1Rt?=
 =?utf-8?B?dk1KWllkU3pIRzZoaUZ4T1oxTGhJdWtEdURXcStOSnBrYXk4VVpXeEtzYTVt?=
 =?utf-8?B?ZGpDTTN2Kzg2Y0hHZGZhZ1NpTWxoNno3NDI3SW1xZzJRYVlFMzNQL0RiRFpa?=
 =?utf-8?B?Sy9jZHphTDVpMTBGalBCa1lpS0pyZHM5T1BCcjJvL3Eva1BscFFISmVMOUpN?=
 =?utf-8?B?S2g3WnZEQllicnNhZHRmZlAzQytQWjZ4OUJRcy9pTlRpaDZISi9FcWlmUDdh?=
 =?utf-8?B?VjhQM215Z0xRbW12Rk5kNG1UekFaaC9UME9ISlF4VXZQQndPYnRjZVlWaTh0?=
 =?utf-8?B?dmZFTjE5Um9lK3NGdTU2VG1mbFdLREVKU0hrUGpCenJ4TExWZzI0TnVlTFRi?=
 =?utf-8?B?eEZzUEV4aU5wbVR2TWZVNzB0clc2NEFyWlVHbVUwYnV2QXVZRmZTcDdUejFm?=
 =?utf-8?B?RFc0QlF6RjlQN1RYVUN1ZWxZcTRTWW1MUm9PVGgzUkZGeVloaWFqMjQ2WXhE?=
 =?utf-8?B?ZTJjSytWK0hwYkc5TzY4U3owdW1TSGlKaVBmRWZHK1VZejVidDlRT1pkVVF5?=
 =?utf-8?B?eFIrNkkzNGZKUUpnZC9RYk5GcDdXaTRoZ0hqWlNRTVZlZ01WVUd3cS9ML1k2?=
 =?utf-8?B?SUlwRGJkN1lMUTlxb3lXK2tsdGRKR0xWUGhpSjhtWXpjQ0liMGhiajFRQXRK?=
 =?utf-8?B?ODR4em95NC9UZDBEQk1ETERmMDhnMUNxUGFmQnFydTRyeDZWUHdUeEtKa1gw?=
 =?utf-8?B?N210NlY1MnAyMVlZc3h2MDRtQzN3K1o0M2lXOGM0aEFJdGFtRWM0MFFDdjBT?=
 =?utf-8?B?dlhFaG9OdUlTajZOWXVYMmhaN0hxdk1YZitXbXVHc25sN1lxRWlKRTVqTTZY?=
 =?utf-8?B?em9FOVN5Y1NZMkN4SVJhVnM2NzZjZFJYVkN5czJYL05KWm1xbndXUy9PZFZ2?=
 =?utf-8?B?eVBkVUdRbHA1SnRhaGJWWWE0MDllZFNpOVBNTU41VS8rdXp2cGlpMVZWNG1T?=
 =?utf-8?B?UkNZczVjR2ZXOTVoTkdYeFgyd2RrVGNRYkc5NTdGZjRiSEE4SmNPTnJBbmJl?=
 =?utf-8?B?R20wUEdBcEZMazUzS2Z3Q3Y4UTE2cm1tc3RNN1VzdDRIV3BML0t3OEQ0NDRF?=
 =?utf-8?B?aDU1VmhjVjBzV1hzdDl0SkQvSE02dVp5U04vei9ERzU2Yzl0SWtab1JlaHRY?=
 =?utf-8?B?enFja1pWTW5XQmNJdmorZXRYSERGU3ZsNTZQa2kwMURKdFNMOWtrOXFaRzNs?=
 =?utf-8?B?MDFxRHRHUXZTZGFtWVdpRktXdDUzNThzemdnbVpPL204akNIenIvTXAvQitM?=
 =?utf-8?B?U3NtSk5PcFVxRVp0ZUYrWG8rc2RIVU1aMnVNQndMTy9RQUphSUlHL2F5a3V1?=
 =?utf-8?B?NEk3dHpVVDE0aDA2TzIrYUk4RTM0VTNHbDU1Uk5LSzNCeWdyRXBHMXFsa1g1?=
 =?utf-8?B?bXJzUS9SRGcxWDFUWjZKNGtqS0xQaE42cFduMTdGL0ZtUGFzbTh6Y1IxUDlO?=
 =?utf-8?B?QU8vNWdVUm83OEo3VzJmazhaKzJRaTVuNkYreXhKUjRtdFhtZHhlS0ZRa0E4?=
 =?utf-8?B?dXM0WG5vSGxUOGwxZTROMFBmM0xuV2RYVkd6cjVVSU90NjF2TFBIU2N4b1JG?=
 =?utf-8?B?Zjl3aWJJdGlEdjdSR2JoLzEyVmUvVzlPN3paTUgyMkpLLytuSDA0NjhNNzdu?=
 =?utf-8?B?Q0tHTFAzSGVQV1RCdHY0REpHZmwyckVTUldmZ2UwSGpPcktTVmtkMjY2ZmdL?=
 =?utf-8?B?azV3NWg5MVRLRTVQTmZhV0tNNFFzUExLUjFOaVZPeFp1b084QXZUcDMvOVA4?=
 =?utf-8?Q?3QSzzzMFV83lckCtptYcTq+a9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3914cb97-ac1c-4bc6-4644-08de37beeb1e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:37:06.2916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svpW4u2z189dsriAiGijnsqPR+HvkjTiz/XsH70KhbN1JF8PYi2zCHb+GKHISuoB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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



On 11/27/25 09:28, Michal Simek wrote:
> SOC can boot from different boot medias and also different offsets that's
> why by default show multiboot value to be aware which image system is
> booting out of. It is especially useful for systems with A/B update
> enabled.
> Also limit zynqmp_pm_get_pmc_multi_boot_reg() usage only for Versal and
> Versal Gen 2.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-versal2/include/mach/hardware.h |  4 +++-
>   board/amd/versal2/board.c                     | 22 +++++++++++++++++++
>   drivers/firmware/firmware-zynqmp.c            |  2 ++
>   3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
> index 7ca2bbb7550f..81a0df893574 100644
> --- a/arch/arm/mach-versal2/include/mach/hardware.h
> +++ b/arch/arm/mach-versal2/include/mach/hardware.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * Copyright (C) 2016 - 2022, Xilinx, Inc.
> - * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
> + * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
>    */
>   
>   #ifndef __ASSEMBLY__
> @@ -73,6 +73,8 @@ struct crp_regs {
>   #define JTAG_MODE	0x00000000
>   #define BOOT_MODE_USE_ALT	0x100
>   #define BOOT_MODE_ALT_SHIFT	12
> +#define PMC_MULTI_BOOT_REG	0xF1110004
> +#define PMC_MULTI_BOOT_MASK	0x1FFF
>   
>   enum versal2_platform {
>   	VERSAL2_SILICON = 0,
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 7d91d288d2ed..1fd05a1157ab 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -21,6 +21,7 @@
>   #include <dm/device.h>
>   #include <dm/uclass.h>
>   #include <versalpl.h>
> +#include <zynqmp_firmware.h>
>   #include "../../xilinx/common/board.h"
>   
>   #include <linux/bitfield.h>
> @@ -180,6 +181,23 @@ static u8 versal2_get_bootmode(void)
>   	return bootmode;
>   }
>   
> +static u32 versal2_multi_boot(void)
> +{
> +	u8 bootmode = versal2_get_bootmode();
> +	u32 reg = 0;
> +
> +	/* Mostly workaround for QEMU CI pipeline */
> +	if (bootmode == JTAG_MODE)
> +		return 0;
> +
> +	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3)
> +		reg = zynqmp_pm_get_pmc_multi_boot_reg();
> +	else
> +		reg = readl(PMC_MULTI_BOOT_REG);
> +
> +	return reg & PMC_MULTI_BOOT_MASK;
> +}
> +
>   static int boot_targets_setup(void)
>   {
>   	u8 bootmode;
> @@ -319,6 +337,7 @@ static int boot_targets_setup(void)
>   int board_late_init(void)
>   {
>   	int ret;
> +	u32 multiboot;
>   
>   	if (!(gd->flags & GD_FLG_ENV_DEFAULT)) {
>   		debug("Saved variables - Skipping\n");
> @@ -328,6 +347,9 @@ int board_late_init(void)
>   	if (!IS_ENABLED(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG))
>   		return 0;
>   
> +	multiboot = versal2_multi_boot();
> +	env_set_hex("multiboot", multiboot);
> +
>   	if (IS_ENABLED(CONFIG_DISTRO_DEFAULTS)) {
>   		ret = boot_targets_setup();
>   		if (ret)
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index 2ef499bf4084..f8a9945c1daa 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -248,6 +248,7 @@ u32 zynqmp_pm_get_bootmode_reg(void)
>   	return ret_payload[1];
>   }
>   
> +#if defined(CONFIG_ARCH_VERSAL) || defined(CONFIG_ARCH_VERSAL2)
>   u32 zynqmp_pm_get_pmc_multi_boot_reg(void)
>   {
>   	int ret;
> @@ -271,6 +272,7 @@ u32 zynqmp_pm_get_pmc_multi_boot_reg(void)
>   
>   	return ret_payload[1];
>   }
> +#endif
>   
>   int zynqmp_pm_feature(const u32 api_id)
>   {

Applied.
M
