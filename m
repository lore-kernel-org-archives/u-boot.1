Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D841E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 895E6801E7;
	Fri, 13 Dec 2024 15:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="33Ts2uyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D6680137; Fri, 13 Dec 2024 15:03:02 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBD348012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gm4bLSbV5G8WJF0Lxp8n5o07biL0nyp+GnJtQGyPhPHMos8qhrNj82vrqps3HuVsqcifOQZUemLxQJyCCwlLAXLrSr3Nk6bZi8t+xAOhMB1NqvaI2akX7BryumMYNCDCfVO8rIFpJ2kEM/GFqTwqtBqStoc2bXGjikKnwv0TstF766DzG7DEKLDND311BTnFy8a6/cGr08VmMw6+LgZYmMHSh7QhfOmt/UgHEKSjCLNi1djh2lOFt9bjwXFb6UAHN/Rjw8GtdvSlndnr65/YQJEiMgsT9E2nlaKhZj8CB1R1xy6WQYQQmdxqxHk9HEN8iB6mN7My9Py+q2Kx/0AIbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61ELtzrrqOBXvX40gT6YzqOQDTUbynQgUF7FxqAs8Rc=;
 b=vbKOjB89WREjpEHSUiMjkW+yXItm4Z9pez8eyzMytRQUP2jibrMkmJYYYh4SLNQwENe7+f3zb22jjDHO3tMcJBiJ96dMOW8z8jtfmGdPOsXnSQVQ8TS7Ns7uQ2YP6+mVjPHip7e1ahjbPaL6UiHQgyWVoGMw4T6FJzgJzsZqmdTHMuuAb086gZWiD43dtmZY4qHOiMd9wyAihU0yIWDSooBIz/kzJhCjfbk0sEtYUOV5OMaKn83Tty5eqrvja8H4A+htrccvoUfd4Ve8+hKm2MgXZHx+KREPOQWjohPcNsS6ev4hQybNi8KwWNZk8LBNLhuain60FEs67pLHjN2oSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61ELtzrrqOBXvX40gT6YzqOQDTUbynQgUF7FxqAs8Rc=;
 b=33Ts2uyqMHDe6gH/4q82qRaEfy2pbM9hW4X9d3GQtcsrk9M81OnSKrXOqd/ilB1xInmyN2gDlh+ofQG3HJsvY+Tp+Umz4qYLpwd6kp1lN+n8LolQN4ZEOLMkUviSNOnvk5WWv2kNEkY75M6MhEwnDR0VX21Ejd7AQ4QiiYDZdGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 14:02:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 14:02:53 +0000
Message-ID: <7e4738a7-40d4-47fd-b45b-fd04e6f21161@amd.com>
Date: Fri, 13 Dec 2024 15:02:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cmd: Add support for optee hello world ta command
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 jerome.forissier@linaro.org, akashi.tkhro@gmail.com,
 francis.laniel@amarulasolutions.com, ddrokosov@salutedevices.com, git@amd.com
References: <20241213110034.1113036-1-venkatesh.abbarapu@amd.com>
 <20241213110034.1113036-2-venkatesh.abbarapu@amd.com>
 <87a5czg34j.fsf@baylibre.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <87a5czg34j.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0012.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6718:EE_
X-MS-Office365-Filtering-Correlation-Id: 4529e469-6549-415c-7fd7-08dd1b7ed63b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1JVcTVLMWc3QjNYK3huUkpFWWlUTzVadjF5SnpGYSt1T3hnSC81OW9zUHBs?=
 =?utf-8?B?VWFHMkYrWE90T2xudlVIdDRCeHRvY3ROdlZkNk53RXVzSHpnZTBHWnprT21Q?=
 =?utf-8?B?ckFKcVBOZ0pWTmxoTGEzSHE3R2s2L3R0Y1NOVWhDRGNRbEQrYVdwNDhoUE5k?=
 =?utf-8?B?a1FETTV1R1lOQmswbWlmemtETHNuMjA0Umh4V25zUEJoU0YxVm42RDBMUjVm?=
 =?utf-8?B?eVlFYU95MWxtUUhOU3dUU0RBcTRkdys5UGQ3RGNybW5MckNaeEZNZmdnQ21u?=
 =?utf-8?B?NkwrYkk2SXdCMGQ4RkYyVUFhbklTdEV1MlQ3NUJyWmtRN241TS9iYzF1RHdo?=
 =?utf-8?B?Z3Vkck9saEl6Zi9icnNFREVna083QnpXMW1peDIrbVE5S3o4OVFkZzgrUW00?=
 =?utf-8?B?cWdaVnUreUpNaVFmeTdWU0lHSGRIOFFkeHB5UVROWXoyM1VDV1BLK1hpNXkw?=
 =?utf-8?B?Zmd2SVZtUHFsUkxqRS9MVWM3U2JyekhtT3VPbEwyRzFoR3ZLU2xSK2RGVFlq?=
 =?utf-8?B?ZzZ6blJLMUxEbzZjd0gvcG5lcGdmT092Q29tN0FGdlNSQWNVWExmeU84eldN?=
 =?utf-8?B?NklVY3Ywa0ZRUFh6WWtPSDJFRXJUYWlHRnEyRGdJeHhmdUloOHZrdjZaYVJq?=
 =?utf-8?B?QS9hU0kzSElaWGFXekZMTkZrSURraGF0clBOWi9LSzBZWHdpdzB3MmVMR0ZN?=
 =?utf-8?B?S01IWTBXOHlXZy8zQ29ETGE0SzlOTkFqWDhWbmxXdURyVFloL0lWOHRxV2dv?=
 =?utf-8?B?TXZxaDg1QXN1cHhoc0FicTNJNTlGRm13endqQVZQc0pqWTVyVmRteGpicE9i?=
 =?utf-8?B?cGNUcHdFWFY3cityenZEcEpTdU1XUEY2NDFtVysreGJrUDhWdElrZWQ1aTBm?=
 =?utf-8?B?Wmk5bCtzM3U1RGR4VitnbHRzam9CWGU3U0VkcUlRNW9OUWxiV21PU0E2OGMz?=
 =?utf-8?B?LzgwYjRMeXI4NUxWZnFrRGlwenp4OEVOMHJhdHdYRFkzaWdYVnZ5YmpvMFlD?=
 =?utf-8?B?Z2hvL0tqT3ZXc1orN3Y3d0xDZndUeFhwYm5FU3pQdG0xbzhHS0UybGxyUTh5?=
 =?utf-8?B?bVBjL25LMHJoQmFrN3JPVld6MEl4eU04c0Z5S0d3MjZlQkVmTHlEck5sa2px?=
 =?utf-8?B?VG5rTTFPMnRsZjMyeGpldGh2Q2gxa3FCNXlWcll2bmtIRGhtYUhRbldPZ3hP?=
 =?utf-8?B?SnNEN3BuazhjUjA0YmhlY1kwY0wyS3pXUXVyYWNLbkFPWDZ5VVI3a1l6SlFw?=
 =?utf-8?B?bndVY3lGRk1Bc1A0cjJoamtoWENvayt5ZjdyeWRZOTBneHpuZFptM0l0T2x5?=
 =?utf-8?B?VDZZbFVxTlluRDhjMWc1anIzbTR2OE5zd3hlMG1yemU2VjErOE15bEF0Q3lM?=
 =?utf-8?B?L1BvV2hCWWxtRCtEajZQUExLNE5qR1lYVUFBYXkzbEh0eEo1ZXBwcDIxRmNw?=
 =?utf-8?B?MCtvaGs4QmtTZThOc0dnaDdmVlh2MkRmcEQ5U2cvUURhS0k3bHdLYVdmU2Rx?=
 =?utf-8?B?OWhVMEtxeEZuRWk5SGNEeFVKcmlIK00reWlUU3BielB2aFFXMEZxVE1YTGVW?=
 =?utf-8?B?aTA2ekF6NVlFcW1lU0s1OUNScjRIR1oxSU5PVXhnSFFTMk4xRW5LZlp1dStJ?=
 =?utf-8?B?bHEycXl4SFZVajVwVjZBem1sSTBhcWt1THltcnNGMm03SXZ3UGY1ZVlRdmln?=
 =?utf-8?B?MWpISTdrc25MWlhaaDVKVS9VV2M3SGNKbVkrbVl0cnVqY2ZKa2hNMFp4eWs5?=
 =?utf-8?B?KzVQYkRXY1paWmhYRnZ1b0ZHaWNiYnNXK1ovejQvaVJZWFJFUy82aTgwNmRD?=
 =?utf-8?B?Z1UyNzRKTE1ITXNNL01FUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2hYNkMzYmlNVW91TFdHY0JnSFNRQ2kvTjM3Tk94NW03MWdSbHNqY1N5cnVH?=
 =?utf-8?B?Y0xVRlJDTTNzZUJ0S2dzdlJETFhIeTJLK2dWNG5YdFBBNVRQK1F5NngwMUpY?=
 =?utf-8?B?VEtjVUNDb1dIT0MrdVZUd2FmaWNoWE1Bd0M3cEd2cEQxaXV2NWJKWXZBT0xN?=
 =?utf-8?B?U0kyVFQrSkdKRFdpV0phSGhjVWs0VFhQeW5udit1L0QwTVN1d29zQUdCOFEv?=
 =?utf-8?B?OGRleWJOT0NpY3ltaE5hU2pDejZybC94Um5ObENBdlY5MTljWHFZRG9ycUpx?=
 =?utf-8?B?UmhUcXljV044MlJSMFBPOUZMVkZNMkowSVlGVUFYWWpPSE41eFlqWm5wa1E0?=
 =?utf-8?B?Z0lTeHB0akcwRXk2VzVDc1BWUVdXOTIvbkJ6VHQ0Z3dpZ2dLVDkzUW9tUnhQ?=
 =?utf-8?B?MHRNRUZZazFaUC9xS2pYWVgvL3R0M2J6dkM1Tk1ZSkZ6TVNwZlk2WU9MUy8y?=
 =?utf-8?B?cVJKTmxnQnVzKzJhNFNjMzRIQmxXVGJRLyt1aXhUWkpSUURUYUxuQW40TzNB?=
 =?utf-8?B?OWd1UjF0dVFUcFU3b0Y2RG1hNGVCRXFoWjVFSmszQURzTlFZdVBlR0RCYjZp?=
 =?utf-8?B?bDcvbURJK1dWS1ZZeHVSZTdLZjdudG00Wk9GNHV0cVhaWEV0a1c1c0RTdHd2?=
 =?utf-8?B?UUVBaWt0Mk5VQU9RMUZtMVdFTVFudFMrSnNuZEkvSG85VUpuWkJwVXF6R2VL?=
 =?utf-8?B?YzFmRkd5MmkrR3ZZVVd4cUJmMnhZdk0xY3RZZ0l0b0l6WmFhaWJ1ZVo1cGxp?=
 =?utf-8?B?M2lQVlhsbmVjWXRzbEpEZEY5M3BXQS9MbGhVL0I0c29DY3hFdUJzaTBndDFk?=
 =?utf-8?B?WEtwdGJSUWdXRWhDTUFWSEdQbDFYdkJiOVRoNnhxcjk3dkxVVjJEN01yQ2pJ?=
 =?utf-8?B?d1RBcGRlT2RHbHlBMEt1cGV2SDQ0QUdoZ01UQVhvb0VGalJtbmZXU0Q0K2dC?=
 =?utf-8?B?cFpQWFRqL0FnZ00wSVozeG9nKzJEdUJ1bGo5YVpKUHhERmtXNFdQRTF5QWF3?=
 =?utf-8?B?MC8zcUlhS2pVaVNKKzlNU3JoM2FXWkt0Tm5zTHhjck5Ta05qVHlDS1E0UmRW?=
 =?utf-8?B?OTJ5U1FrWStyMHlUdENJUUZDOUkvUHlJaTIwZDVzRDdNYVJJcjBnMGhPTitl?=
 =?utf-8?B?bDFsOUFsOEZ2enU5WmUwbURKbUFub2EwcW5yZHphTWNub01kVDBTeDhtMk1j?=
 =?utf-8?B?bldZdlArYm9DeWhBWmlETkc5ekhDUTRyV3I1WnY1dzZNdGpBQkxrbTlqWk8v?=
 =?utf-8?B?UGc0VE1CL2ZhODJhRm9WQVp0blZpUEttQytuNzJSU3YzSFFNa3lJaHJmd0FF?=
 =?utf-8?B?THZHaGhzRk03bi9nL1VQc0lQdTRUUm0vQkxna21KS2tpSHFNVjdtbGE4N0Uz?=
 =?utf-8?B?Um1yVFhPSXF5MmFtZDdHL2MvRVdFK2FOa01wc2EvVDkyM1NueHBLYzZiUFo4?=
 =?utf-8?B?ZTBEY2xVd2l2Nmxpa2F6clpJZVpOSnRPUFFFNUpsVFBaa0JGQlF2NEU1MjRR?=
 =?utf-8?B?S1pvZ0k5YzRaTWExYXczU1M5cU9oZkVGNFZsQnFVbzNZMGYvZ2R6T3M0cFRh?=
 =?utf-8?B?WGh0bnpLZnQ5WXl5QjQzdVpHVWEvQUQrMGJXUnp2dzVSMUVER1pKQ0x5NzFz?=
 =?utf-8?B?dEVtazBlTUthLzZOK1N5RkJabmoySmFFMmxMK2hOWFdYWDZVTTVPYkJ0dTYz?=
 =?utf-8?B?eHo2VFVWTTR1c3NzTFdLSkllK3hnMCtZSHZJM1BCdUwzRUFWeUVvVzY4emtD?=
 =?utf-8?B?NE1TS3liZldUR2syNVZIUUE0Qm1oMFNKaThWVDdxZmV3MkFwcjkwckhLK014?=
 =?utf-8?B?T2EzeW9CZ3lqY0NZaDUyeURsWUV0NFJYZCtWM1ZUekJYMkNKOVJqRHdCRXFo?=
 =?utf-8?B?Tmd1MXlaNnRQbWZ0b0VRUEwzODVGYWVIdXlVMTRwSU1YTU44TVlSMk5qN25E?=
 =?utf-8?B?YllVMVU0bjVSOFdRNi9TVXFMS2lBL3R2Qjd0WXRtVW15U2JGSWU5VzFpZGJp?=
 =?utf-8?B?RlBPZ3F3TStPZGt1d1dOb0hSd1lBVWNTajFUaHU0Vk1IZkdSM3cwaEQ1LzlE?=
 =?utf-8?B?NU54WTdIVmxyV1hwcFpCM2tMaFZUNi91ZWZyUHdoWjk3QkpiN211ampMOGtk?=
 =?utf-8?Q?rIoJQn26faz59T08ewvd6aA6K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4529e469-6549-415c-7fd7-08dd1b7ed63b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 14:02:53.1537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6K7xy2iMeZV+p1rmg/nFJepN0tdj7/YQeZjkXnHTb8gHocz+0nIG+kxxw2FhRQZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
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



On 12/13/24 13:48, Mattijs Korpershoek wrote:
> Hi Venkatesh,
> 
> Thank you for the patch.
> 
> On ven., déc. 13, 2024 at 16:30, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com> wrote:
> 
>> Enable "optee hello" command which increments the value passed.
>> This provides easy test for establishing a session with OP-TEE
>> TA and verify.
>>
>> It includes following subcommands:
>> optee hello
>> optee hello <value>; value to increment via OP-TEE HELLO
>> WORLD TA.
>>
>> To enable the OP-TEE side HELLO WORLD example please refer
>> https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
>>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> ---
>>   cmd/Kconfig                |   8 +++
>>   cmd/Makefile               |   1 +
>>   cmd/optee_hello_world_ta.c | 104 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 113 insertions(+)
>>   create mode 100644 cmd/optee_hello_world_ta.c
>>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 1d7ddb4ed36..f1f8d1b9571 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -1446,6 +1446,14 @@ config CMD_OPTEE_RPMB
>>   	  in the Replay Protection Memory Block partition in eMMC by
>>   	  using Persistent Objects in OPTEE
>>   
>> +config CMD_OPTEE_HELLO_WORLD
> 
> If CMD_OPTEE_HELLO_WORLD has hello as a subcommand and we plan to add
> other commands, shouldn't we give this Kconfig symbol a more generic
> name?
> 
> How about CMD_OPTEE or CMD_OPTEE_TEST?
> 
> Maybe others have better recommendations for the naming.
> 
>> +	bool "Enable Hello world TA"
>> +	depends on OPTEE
>> +	default y
> 
> Are we sure we want this enabled by default for everyone?
> It seems indeed like a nice debugging tool, but maybe keep it opt-in?
> 
>> +	help
>> +	 Enable the hello world ta command to test the OPTEE by passing
> 
> OPTEE -> OP-TEE
> 
>> +	 a "value" which should increment by OPTEE TA example.
> 
> Ditto
> 
>> +
>>   config CMD_MTD
>>   	bool "mtd"
>>   	depends on MTD
>> diff --git a/cmd/Makefile b/cmd/Makefile
>> index d1f369deec0..049147a1442 100644
>> --- a/cmd/Makefile
>> +++ b/cmd/Makefile
>> @@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_PAUSE) += pause.o
>>   obj-$(CONFIG_CMD_SLEEP) += sleep.o
>>   obj-$(CONFIG_CMD_MMC) += mmc.o
>>   obj-$(CONFIG_CMD_OPTEE_RPMB) += optee_rpmb.o
>> +obj-$(CONFIG_CMD_OPTEE_HELLO_WORLD) += optee_hello_world_ta.o
> 
> Similar remark for the file name.
> 
>>   obj-$(CONFIG_CMD_MP) += mp.o
>>   obj-$(CONFIG_CMD_MTD) += mtd.o
>>   obj-$(CONFIG_CMD_MTDPARTS) += mtdparts.o
>> diff --git a/cmd/optee_hello_world_ta.c b/cmd/optee_hello_world_ta.c
>> new file mode 100644
>> index 00000000000..7c398bcad2c
>> --- /dev/null
>> +++ b/cmd/optee_hello_world_ta.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * (C) Copyright 2024, Advanced Micro Devices, Inc.
>> + */
>> +#include <command.h>
>> +#include <errno.h>
>> +#include <tee.h>
>> +#include <vsprintf.h>
>> +
>> +static struct udevice *tee;
>> +static u32 session;
>> +
>> +#define TA_HELLO_WORLD_CMD_INC_VALUE 0
>> +/* This needs to match the UUID of the Hello World TA. */
>> +#define TA_HELLO_WORLD_UUID \
>> +	{ 0x8aaaf200, 0x2450, 0x11e4, \
>> +	{ 0xab, 0xe2, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b} }
>> +
>> +static int hello_world_ta_open_session(void)
>> +{
>> +	const struct tee_optee_ta_uuid uuid = TA_HELLO_WORLD_UUID;
>> +	struct tee_open_session_arg arg;
>> +	int rc;
>> +
>> +	tee = tee_find_device(tee, NULL, NULL, NULL);
>> +	if (!tee)
>> +		return -ENODEV;
>> +
>> +	memset(&arg, 0, sizeof(arg));
>> +	tee_optee_ta_uuid_to_octets(arg.uuid, &uuid);
>> +	rc = tee_open_session(tee, &arg, 0, NULL);
>> +	if (rc != 0)
>> +		session = arg.session;
>> +
>> +	return 0;

return rc?

>> +}
>> +
>> +static int hello_world_ta(unsigned int value)
>> +{
>> +	struct tee_param param[2];
>> +	struct tee_invoke_arg arg;
>> +	int status = -EACCES;
>> +
>> +	printf("The Hello World TA is going to be called\n");
>> +
>> +	status = hello_world_ta_open_session();
>> +	if (status) {
>> +		printf("hello_world_ta_open_session failed(%d)", status);
>> +		return status;
>> +	}
>> +
>> +	arg.func = TA_HELLO_WORLD_CMD_INC_VALUE;
>> +	arg.session = session;
>> +
>> +	param[0].attr = TEE_PARAM_ATTR_TYPE_VALUE_INOUT;
>> +	param[0].u.value.a = value;
>> +
>> +	printf("TA value: %d\n", (int)param[0].u.value.a);
>> +
>> +	tee_invoke_func(tee, &arg, 1, param);
>> +
>> +	printf("TA value: %d\n", (int)param[0].u.value.a);
>> +
>> +	tee_invoke_func(tee, &arg, 1, param);
>> +
>> +	printf("TA value: %d\n", (int)param[0].u.value.a);

Any reason to call it twice? And 3 the same messages will be hard to parse via 
test. I would also convert dec to hex.


>> +
>> +	status = tee_close_session(tee, session);
>> +
>> +	return status;

return tee_close_session.

>> +}
>> +
>> +static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int argc,
>> +				   char * const argv[])
>> +{
>> +	int ret;
>> +	int value = 0;
>> +
>> +	if (argc != cmdtp->maxargs && argv[1] != NULL) {

this should be the part of already

367 #define U_BOOT_SUBCMDS_DO_CMD(_cmdname)                                 \
368         static int do_##_cmdname(struct cmd_tbl *cmdtp, int flag,       \
369                                  int argc, char *const argv[],          \
370                                  int *repeatable)                       \
371         {                                                               \
372                 struct cmd_tbl *subcmd;                                 \
373                                                                         \
374                 /* We need at least the cmd and subcmd names. */        \
375                 if (argc < 2 || argc > CONFIG_SYS_MAXARGS)              \
376                         return CMD_RET_USAGE;                           \
377                                                                         \
378                 subcmd = find_cmd_tbl(argv[1], _cmdname##_subcmds,      \
379                                       ARRAY_SIZE(_cmdname##_subcmds));  \
380                 if (!subcmd || argc - 1 > subcmd->maxargs)              \
381                         return CMD_RET_USAGE;                           \
382                                                                         \
383                 if (flag == CMD_FLAG_REPEAT &&                          \
384                     !cmd_is_repeatable(subcmd))                         \
385                         return CMD_RET_SUCCESS;                         \
386                                                                         \
387                 return subcmd->cmd_rep(subcmd, flag, argc - 1,          \
388                                        argv + 1, repeatable);           \
389         }

And this will allow you to have number of args between 2 and maxargs you setup.


>> +		debug("do_optee_hello_world_ta: incorrect parameters passed\n");
>> +		return CMD_RET_USAGE;
>> +	}
>> +
>> +	if (argv[1] != NULL)
>> +		value = dectoul(argv[1], NULL);

values on u-boot prompt are mostly hex that's why I think you should decode hex 
here.

>> +
>> +	ret = hello_world_ta(value);
>> +	if (ret)
>> +		return CMD_RET_FAILURE;
>> +
>> +	return CMD_RET_SUCCESS;
>> +}
>> +
>> +U_BOOT_LONGHELP(optee,
>> +		"- commands can be verified on OP-TEE\n\n"
>> +		"optee hello\n"
>> +		"optee hello <value>\n"
>> +		"\n"
>> +		"With:\n"
>> +		"\t<value>: integer value\n"
>> +		);
>> +
>> +U_BOOT_CMD_WITH_SUBCMDS(optee, "OP-TEE commands", optee_help_text,
>> +			U_BOOT_SUBCMD_MKENT(hello, 2, 1, do_optee_hello_world_ta));
>> -- 
>> 2.34.1

M

