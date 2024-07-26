Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E46C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85C8788361;
	Fri, 26 Jul 2024 10:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpWzpl6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3270088365; Fri, 26 Jul 2024 10:09:56 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 602CE87CF8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEmJWKPIEDpoOulsKvksC5eza/MQ6DQZswKpEX5y2kD5SMVQB5d0riinVu1DAubPhVmeDienyR9rN+5r5wNVv7q26sFDaKpe507X50GF/QYrKSJ59vBpku5ogWjvOh3E466oyrBOz1X8cNQfVXdJU0Fj3zUeXHZC49W5sCcc+47XSzQE63252Y8ZxjDPTvTjEkbUj+VKI4QF93qJcixatweUIjv/zeTSpnr8byNA3JdzTDqAfqY9Lv/TZZm8rfsmorLelYAxvMEUZr4F4E1b0YtnBSh7NGMdtAGr+428VMNEMlFZaU1c9lx0J3AaXdcKT7I/UZE1cxTknoT7qhwy+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DyXdHLbPL0CWbCHdQR4Bm4z9NaX7S8AF+f5CrLrDuA=;
 b=Yza+0taXPrHjDp1Xl14kdsQq/zv8tVqtzAw7dtlbwNVdBOg8CQJV0ulqvlPE822g05I07QMT70TzK9QVH8QzwCmv216vKi013lse4xZO8WqXmRi7J4x6Rfb2L6L3/rk5jPtcWdV55SqAhW9GiSpBKnLhKQD8gSUqIS1B8tdYZW7lepz45KRMsSoWW9paVhIsZL7yuGhpISwxED9k3dehtEuig0ca7WlvbgSzNrbAzqxMGO1Q8UnWP2OnV4sn/75sJ05DPBjWUhin/OX5XjLQ7QvHKNfH+4nU1NZ7AQMi2wRVzpyHSOdxIPJDXqsZRhfaIhTYgcoPBzV6Twbpgu9RKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DyXdHLbPL0CWbCHdQR4Bm4z9NaX7S8AF+f5CrLrDuA=;
 b=YpWzpl6KtD9LEKzFEnN/oHYN2wKKavD3JGjcHJIMOY9LXrvKaiskl4R6ZghBtOpxlf8U8jon3/zF7d0U9eoQIihgFRvmL4l7B2uaH4/sl8qZRN3GO4eIkIOQag0TfWshj8nz3+1pC8JKCVGk3P9SBeyfsE5oQhArAMZUPxrC5ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7680.namprd12.prod.outlook.com (2603:10b6:8:11c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 26 Jul
 2024 08:09:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 08:09:49 +0000
Message-ID: <d0efe9fc-961f-4e6e-a299-638645ea2367@amd.com>
Date: Fri, 26 Jul 2024 10:09:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add resets property for UART nodes
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>
References: <81c602417a5d28dfbce122b2e5a63ff7ddb74594.1721053421.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <81c602417a5d28dfbce122b2e5a63ff7ddb74594.1721053421.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0025.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b36971-430c-4c68-698f-08dcad4a51f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk8rd3pKRWt5SkJXbXhwcGVMUjloNkhhTjVyTTZGdHpmdFJFQjZCWDAyam5j?=
 =?utf-8?B?Qit5UmVRQmxXNytESGxtYmJucmlMK0NFWXlyeXVKdElTZlRzT1BoQzRrSkFC?=
 =?utf-8?B?YmFnN1N5VkpuMS8yZzJYLzRBQkJpbGpyNE5vRjBoRkxid0lHbUxvL3MxcTFZ?=
 =?utf-8?B?enhEOW9weUFocmk2K1JyZnRIcUkycksyNkM0TmR6c2gySGF0eWFiaGNtUFY1?=
 =?utf-8?B?bi9HdVBJWXU4RGIyNXIydUNLYkF2ZW5IcXkxU1pIYnBjQUlNTzFGMWJRQ2RT?=
 =?utf-8?B?TUZDWkdLR2FJM3R6em4zMFNORXNZdjk0YmFhaEpqZ0dibFY3d1lhbStOem5H?=
 =?utf-8?B?WkJpWGQveW1zc1lES3l4SUJwRVdtN0FPaWRDR2QwZWFWMWpBWGNWUDJ4TnRn?=
 =?utf-8?B?Y0ZwbEdnSE00V01jSzE4VlVTeXN3dk42d3Y2aUZHZzcxTXNGaTU4d2xETFoy?=
 =?utf-8?B?ek1hZzErczJ0RFZaRjJUdFNGb2NiZjVUT2RaMFVYWFFTdXM0UmZLZGN4TzVq?=
 =?utf-8?B?bHNycThxa25NRGhqWGtHd1d2cGV4OEg4UVhsZXJRMzEvdnVZbkZvYlZZVnVQ?=
 =?utf-8?B?cHVVdjEzSXRocXFYU1U2QmpMZ1lwK1B2b1hzWmZPZG9raUJBOWtHZVMvYWFk?=
 =?utf-8?B?Ly9SYVpFMGxZOHE4UC9KR3lDVldra0IzUUYwZzI5QmIzWlBreUtuSmp1eXhh?=
 =?utf-8?B?YlBCNXI0WXNSUjJ6MXJmKy8wWk1LNU92SWlaVERyQXdvbDhOSlpPNFg5b0ZP?=
 =?utf-8?B?b1pxdllPUVk3dnRlRUJmYmlsMmJweks0R0t2ZGRPY3k5Uyt6RG1QYzNnOFp4?=
 =?utf-8?B?MU5wSE1RUEdUTkxmRXhDUFFzang2cXBuR3FkTGVxSFV2TGRaL0t0VTJVZWRG?=
 =?utf-8?B?OVF6RTFZaXIvZUFzamdJV042T1pzcXpYV0tROStKRGMvRHJOTVpLOG1VdlFR?=
 =?utf-8?B?akJNV0p0MXYvK0t6TjIvcXF1eHdDUHYxejBDTnVpb21qeXJnbDBaT0lnU2dh?=
 =?utf-8?B?RXR2OStMaHlGcnloZVYwdjJ1cEJKeTV6OTBwWC9FZVNrcUVQWThkMzFZOXZy?=
 =?utf-8?B?cWZGa0ZOZ2Z1VnE5TDhxNVhacGJrTUxRTUFWTXRjRDZ5NHZKVUlGblorOWtP?=
 =?utf-8?B?c0EzOUdHSlpiRkR5b1JZUjdNYU1TNEhUcktYZUpTbDRXSUNBaGsxL0RrNUdk?=
 =?utf-8?B?UXU3K0RJY2hjTFdsZkhWcExDUklpZmw5TlphbGtoN3JnWWRKQ2pjcVRZTCtW?=
 =?utf-8?B?dUxmSGRuMGt6Q1M0cU1tTDdodnYrcTQ5cVdIeERoWFBRNWVTVUtDNWptYUtH?=
 =?utf-8?B?dGhQRHdQWjFhT0ZFUHpKdDMzRFlVRHdJNktIMzQ5clR4cWxiUjBPcTZteS9E?=
 =?utf-8?B?NGJNNC9rd0FtZ29iUy9FQ3Z4ODl1S28wbkVKRUZvTm9HYU5FWFVudVZvVHQ0?=
 =?utf-8?B?YlFESkZPYlJIT1BFYldtcmNPV3FTWTQ1Zi9yaWNWR2NqOHgyUVpwNjZMc0ZQ?=
 =?utf-8?B?cjQ4bzFBTk4xN0pMaXVEd3VJRXBEM3YxeWl6UHNoakVvMUFVK0RqeUNYTTJC?=
 =?utf-8?B?TjBZeFR3SjJhdjBZclhwNjRBUUpzRG5CUlBEN0pha2h6azBXWUdaSCt2VTJG?=
 =?utf-8?B?YUh3NjYxckVJcExyOUo5OWowWHY5UlR4WERISjFwMC9jV1hMWFhTZVhUQlNH?=
 =?utf-8?B?V0srVzZtRnp3aW5FSlRCVXdnYXNCczdtTVREWjJ5V2lTQzVTeEp2ZnZOMXFR?=
 =?utf-8?B?ZVhlZGVhSGhSSHVhZDFzd2FRdUZ6MmpOakFFVEVYUU1kamwzSE5sTnh5ajI1?=
 =?utf-8?B?Y09lZW1oV0NNK1NsZzF0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmtUaUxKTzVBUklQdlcyRStFZ25pSk9mRFVFNHpYb3Y0VEorb083M0xvK2R0?=
 =?utf-8?B?OXNFdG5CQURldEVrS0ZNS2lEREUzQWZycXViOGYrK1QrbExFcE1VWHBDV0RI?=
 =?utf-8?B?b1RzbmtzSnpLRWt2MTZ5QjVyLzBqOWNFejIzaDc0ZVQyYitkMFYwQU1WUlhk?=
 =?utf-8?B?cGVHYXMveVRGY1B2eDhwYk1vQ3piWDNrK0tHa213bDFUeVJqRlNxdUl0Q2s0?=
 =?utf-8?B?dHR1dUNlaFpuNjlmQzlQRGN3eFMrc0JPWkpWek5nL2RGVk80bG54RHpybWVj?=
 =?utf-8?B?VmF5MGdNVDlWOUdzM3c1ejBKMWt3YUt3TW1CYWtLWDVFUmMwZzYvdmVUcmRJ?=
 =?utf-8?B?ckdLMHIrMDlZM1J1SjlCb0QzclpGWmZ4RGdpTjNMbTFVUjFTYVJmNG42Kys2?=
 =?utf-8?B?K2FkRW94QW5nWVNOOHJvSmZJcUpWY00vVWlkcHhSSzhSRlQ0WkxyKzVBZzJv?=
 =?utf-8?B?WjFMZ3FhY01qSjAyV085T2hCandZZU9yR2lCT2JaMzdwQk5jaG1KOTZVRFNH?=
 =?utf-8?B?TGhkM09wWVFiVHNKMVhrZ0dKbmlKcUpxTm41Q0hVNDIveE9HdTVuQUdENGFo?=
 =?utf-8?B?cnZpcWtTMzJ3QW11RFdreDBpcVF5VzV6UTEwOURGWkkvck5BYjFveW9BdlJG?=
 =?utf-8?B?eUZkREY0T3lqUGNzVkU1amlCT0J2QnE3Wmd2eFhxSEVKeExIMnRQT2l5QnZF?=
 =?utf-8?B?cTBqaTMyZEovcGNTNVFSbHBIQkM3Q29JbjF3YkJ5TzVNS0QvYktOZjRvWFJv?=
 =?utf-8?B?bFRZR0VKcGoxZnZRVHRrZ2IvVTJkL3Zld1NDRWNjVEV5NFY0bUNHVmhuRFFw?=
 =?utf-8?B?TEtCaHhQaXQrNmNPM0VmQXZBbDlSTkxkemk2cXBJR2hIdWptV3dld3Fqd205?=
 =?utf-8?B?WHVMZVlOQlZNVEJ4QXFPa0ZlRmJHTHRzcXdkbjNlRkNxSklBM1poaGhVd3pt?=
 =?utf-8?B?SG5SR3AvdlRUeHo5V2xnQ3JKSDBMNVpUamp5eWhlODM5Y001SmdvWmMxQTJq?=
 =?utf-8?B?VzRrS0MxeW4zTDBtVUNvYnZrQ0hqVWc1cWdyb1VTSi9Nc3J4RFJ0Y21TdUhL?=
 =?utf-8?B?NFJaaGg5dWdRZys3ODd5UGxiZEJBTkgwTlJibit4OFRUZ0xJcU55TTh1dnZ2?=
 =?utf-8?B?R2I3Smt0TmhjTUIyZnFEWjl6cDZzS2VEZVZuN2xzYm4rL2dJSm5vYm1xbUJ0?=
 =?utf-8?B?OWVrU3lXaWpEMFhLWElzMS9SMXY2WFBZM2NPR0hicE1jUnVpQ0JtTmh0eUli?=
 =?utf-8?B?Vjdrdld6RVhvTFZDRUhCUzJ1dkJMVHpVTTNqeU4yZTZXWm9lV3JUYlJadTYz?=
 =?utf-8?B?NEc3REdrR0ZsYTJETEVMSkpEZUdTUmIrZXFtZHE3WVQzVHNBZ1E4SUw5NVph?=
 =?utf-8?B?TVpkcnA1V3hwclNJZ1o4czJCcDdTaDdPMkk3T2NHQ3FLNzJSZ2xEWE96UFA1?=
 =?utf-8?B?c3FqVU1MbHF4VW5TOFdnU24xTFNmbklyQ24xRGlrZ1hzaHBqZmpHQ3NTMTR0?=
 =?utf-8?B?SXdmM01iUUVHMDJ3WjJTRWkwOGRLYVFadEJLaHluWDA0U2I4MW5TRzFmbjNC?=
 =?utf-8?B?NEF1d1oyd3M1ZGJwOXd0bzA3MDZ1K1BqMVJqSEZnT0o2R0FGcTRDQWRCdExM?=
 =?utf-8?B?QVlmUU15YStLdnc1L1JEME4wWU5Kb3Y1SkZBdEJiYkg2ZjdIYzE0cmE1MHB4?=
 =?utf-8?B?bkFhTGdYUDdrK3RSRVZkWmd6QXZnRURoT3I2ZDlPaUdvSk1GVmI5YVNXSDd5?=
 =?utf-8?B?OTJ3azBqZ25rQmtIaEpMd2JuSEZpa0RlN0o3MkNrSlI3QVdZV3gyVzVMWDBU?=
 =?utf-8?B?UW9jYUI5cGh1dDNtVGkxNUcybGhTSU54K2ZtTWhZM3FQMFNXeGp0M3NIQ0Rw?=
 =?utf-8?B?U2htQUdaZmFxbnRmNndxZmcxekhLTHF2Q09Ua3pLOTZqTEpDbGlmLzY0Wks2?=
 =?utf-8?B?S0ozTklQQUR3a1ZiMGN0QUN1b3NkOXRDTFQ0YmFTcFgyZjVFSDFxOWl6TVMz?=
 =?utf-8?B?bWJ3eFFGaXhyanpZMnRyaC9Bcm1wQnBXV3BVTkdoZndlODJ6c20yUExtZHlh?=
 =?utf-8?B?TEN6SXlLTklzdG9DaXhHMkhhTmpBUDFDU1FiNEp6by9rdlNPakVKNDlCRWV6?=
 =?utf-8?Q?Vq/V9IcBixWgU3CFTYMtS6v6R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b36971-430c-4c68-698f-08dcad4a51f1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 08:09:49.6221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBWeOxrIcteagAmGm8LXxH5sEcZn41oi/dvswqCRvRVp0ZE6s+vhhnkEBqP/lZPG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7680
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



On 7/15/24 16:23, Michal Simek wrote:
> From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> 
> Add resets property for UART0 and UART1 nodes
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 34f592c1a85f..6a29f6101534 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -1025,6 +1025,7 @@
>   			reg = <0x0 0xff000000 0x0 0x1000>;
>   			clock-names = "uart_clk", "pclk";
>   			power-domains = <&zynqmp_firmware PD_UART_0>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_UART0>;
>   		};
>   
>   		uart1: serial@ff010000 {
> @@ -1036,6 +1037,7 @@
>   			reg = <0x0 0xff010000 0x0 0x1000>;
>   			clock-names = "uart_clk", "pclk";
>   			power-domains = <&zynqmp_firmware PD_UART_1>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_UART1>;
>   		};
>   
>   		usb0: usb@ff9d0000 {

Applied.
M
