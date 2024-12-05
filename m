Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D9BE7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC1BF88D56;
	Thu,  5 Dec 2024 14:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3oblo5LG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0717088D56; Thu,  5 Dec 2024 14:29:50 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41210887D1
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 14:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqg548x2hoHbsetvaHFw8FXVLfH6zasr63qSrjpwnYMkQVPGHrBde+GQfByzlt/rCnjZP2hkZxmddlv3izTACDOMn7oCJK5qQmJbeHURBx9WRhPs0sr3Ca/D89PYA56B/23ZMzo91XgVIBiwccfazM0jJkt6Uan8UpNRt38Glg9Drll2YbsYpYz7lEXVZ/0QCp9E1LMZUyUV+ApVSNwynFVFj5azeIy6edH24zshqrOE8Md8arMKxPs/1KB9tD3fxUrLMOfyUMY+UFUkNX+qgtJ2Edmn+jPMyOwBcHDAmbpclNqH+VZpoJ022clVdXqHzJpbCT1Z+cjnxJ4z/8UXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/9uVZmZzmHWRVxDN3lbeZDabx+d0kN+xbyFei6UxiI=;
 b=Mfp7jSvPjiowHth+J1GZIj/6TOEg8BpY6Gz9R/h9nRXgX1du4pmls5smg+tSst4TsPaiKwE0ReNdDHq49dsZJtItOtOTssK/mO+EHbnMokzSRxgL8kXj5hi2C0ooKrkUgDjLSSdg0ETV3Lt5WbZGb8XXLJv5BZM6nqPudZn9h2XmjWG2lUET+GVO7GQXGaPVZoqxQIbuIt9I1VbjgeetUvCFmxUyszH3ZMsPlgBlDaE3pO4hwaFU+pMc5Y81hFIXM/EyIY1tQPVHX2CP54lyeTiPWetXdUUGcn+gpsAVEeyLATXAYkFSnl6LLhUsmeRmbNHNnbM7PtZe+N6nt8PJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/9uVZmZzmHWRVxDN3lbeZDabx+d0kN+xbyFei6UxiI=;
 b=3oblo5LG4+CAXyK7+vBbLPee3Z25s3xRoUNPLZq9P788Q3To13WA7YAhtZYtPHUjpnG0Jj31O+BVlsYMG1fFvtBN0NJ7vAgTU0aSnNXHDf+aPKfNl6KXarOyCa4XEDanCxgyFX3+lCMFJ9spSUSgZjTVd0kDot3shR824eiUR28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 13:29:43 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 13:29:43 +0000
Message-ID: <9aab45f7-d99c-433d-b774-6b4f03d1ae79@amd.com>
Date: Thu, 5 Dec 2024 14:29:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Sync with v6.12 kernel
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Paul Alvin <alvin.paulp@amd.com>, Srinivas Goud <srinivas.goud@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Vishal Patel <vishal.patel@amd.com>
References: <cf37760117765c4cece94736dc2a7b583d5987de.1732805351.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cf37760117765c4cece94736dc2a7b583d5987de.1732805351.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::9) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 6012b790-96af-478b-c4df-08dd1530e0df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1ZFWXVNRXFVcTlSeWh5Qms1TXlmbTFuN2wzbitnUFI4MlhveCtLVGs2cU1l?=
 =?utf-8?B?eHFzOUlPV21tQ29XR1VrNklrR25tU1ppS0thOHpya3NGZ1dKQnNXeVBBR3hQ?=
 =?utf-8?B?ZExUM3RoNXpZVTVPdzl1RlQrVlNxVCsyZ0dVS0VMLzduQXlsRGR4TnZpVmtR?=
 =?utf-8?B?YnNWVmVtRTRFQ0FkSnNrRm5UTTRhNzlUbzFCUXdMVDFnaE9vKzBLdmlFSnRI?=
 =?utf-8?B?N29RcmtPeDd6bHk0eUxPa0d4YUdoUENTU2RuMTlmNFVrbVRMQ3Vtekhjb0kw?=
 =?utf-8?B?L2x4eldzNVZZRTdqNEVNemJGWWNZc2lqZk1PeExCNVV3NE84cExrNCtGc0Zq?=
 =?utf-8?B?aDNqNmRCOC8wajkvZUJaQzhuMFJCZXV4UkRUeFRNaHdLVEM1WjNmcFE4dlEv?=
 =?utf-8?B?aGZiNVluM0VYTDdtR2RRRTRMeDRlbjZyZWVsZkJNUmdaYUZrVGxFRjF6bEt1?=
 =?utf-8?B?bERWOEpKVUxuN0pqMDZsVEtHRDEzeE8wWm1yNmxEUURvZHh4SEd4eUR4cW40?=
 =?utf-8?B?WnB4ZFNOWDhFZkRDbWZMTkIrWWtIajQ5VjRWTVd6SEt5aTV6SG1mL29mTm5k?=
 =?utf-8?B?NWoyQkY3WGdvWWR1R2dRQ1B3QlYyb294NndPcFptdG1aRTdMMyszQkU1Vmo2?=
 =?utf-8?B?cGVzbS9TN2cvYWw3UitDdUhGc01LV2REa3BSL3FVd1FETW1mRGIvbXAzYnQw?=
 =?utf-8?B?UndjME04dlkyM1dVbkdjeDV1cjAvVVFHQ2ZHLzNwWGhsN0RzeEVkYXBhMGt5?=
 =?utf-8?B?VSt4ejlUNngyRy9Ua1Z4dFlBOEgwUURwcTk0NXhNMHlkc3FtbmRiajR3Yi9s?=
 =?utf-8?B?cnd0c0VBUUEyQXNQbnlrQ09zVGRKUW9qLy9tZzZ2dUM3SGZIWW8vaWxNTlJJ?=
 =?utf-8?B?TVF4ZldxSG8rN1RlWmdMMm1BUDRFd2tZdWZXT2Jmbm5kd1ZsQWM1Uy9mV0tC?=
 =?utf-8?B?S0xhUFZNeDVod1F1bFZzRzlwQ2Q4ZHpDM1ppTklrZkRicXB0MmtKazQrZ1lS?=
 =?utf-8?B?RXdwSTJoelJMRVY2aWpBMWYxNUZkYUpRN1RiUUphak4rYnFSOEJJT3NzUVJh?=
 =?utf-8?B?RFNKR29QbFVMREcyNUZRa0ZVUm5TTzVJdHQrQnhISG8yOHdLcUFiNjg2TDRr?=
 =?utf-8?B?Q2cxSTVSOUtxSmZ5NEdYaXMzdFhMdmVoUUVqeHMrVnBjL1NMSHQreGVxZm5q?=
 =?utf-8?B?MlVQTXZhK0dWaWtRUDFDSW85d0NhcTNYUEZMWnBxR0RBRzZlRDVjcEtnZFRT?=
 =?utf-8?B?NUNnNGdLQ1IvNUJZWmxCUzF5TVRTMm12NEJzYlQwb3Fkbnc5SWhNdE9EaERj?=
 =?utf-8?B?NGZDNFBvcm9mdFBVaVN3a3RTeDJjRDlBQTB1VVBCYTRSZEVkT212MW0vWEhV?=
 =?utf-8?B?RHlOL2krS0ovaUUzdGk2NExHYUdIQ2VrTFNmRHhFUjJUKzMxQi9kVmdGYUM4?=
 =?utf-8?B?bHVqNVoxbDJ5YlMvQk93QWh0REp2MmtFK0NZNk5tc21iTjFOZlk1ckJTMHJF?=
 =?utf-8?B?a20xd1J3Y3o4RlhMTlZYNm9zNEZUaFN6NlpGZFFpZkRqcEhDOXFaVXBBOGE3?=
 =?utf-8?B?dWRJNEhHTHJOeVhIVWJvQU10RzZ0V2luQjJmR0tnTDdFc2dkNG1CNXdtYVZ3?=
 =?utf-8?B?S3VpY05LdTBlNUhzT3Uzckw4ekx6ZFRUWmJVRVFPVmRYaTg2U1UzRFZMQ3pz?=
 =?utf-8?B?a0F2MTRTVnZLWVI2KzhTYzhza2hjbE5aZC9PUTF1VjNJSWEzdG9sSThqUGtI?=
 =?utf-8?B?OVJvK3hwcGsxVVgvVEhtQUl5ekZvOXRyWnZidURTdWVQTytsVVZnSVZ5ZVgr?=
 =?utf-8?B?OHpGZS9seXVwblJyb2o5UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3U3aUVqOVZ3cG9FTkQrTFkyUkpFbEZEMWR6K0lzQzBFMUd3UU8rZktOblB5?=
 =?utf-8?B?UkpiREdoemxhRmE1UTY4b29kV29GOUhQN3ZTZ2s1WmZrZGNzUjZNOGN5MTNM?=
 =?utf-8?B?MGVmSCs1OWNudWVydlhydklPaUpkZUQxZDlhUTVNM2lIaXlNRDlhcVdCYVRB?=
 =?utf-8?B?ZTd3MURGdFZ3NTA1VDhtS245RkVCZm5IU3dJYXpWRFJIR2RKZnFaUTVwdmEy?=
 =?utf-8?B?cFJJTDZUZmxDNUM1MFJranQvYVhjTG9kelppdHpjL0Nob0gwMzViN2JxT2pu?=
 =?utf-8?B?UmpqZG1wZWpZaEZnb3AzaFl1TklXd2RtTlQrUDl0aVRWR21xb2hCL3k4dFI4?=
 =?utf-8?B?TlJMUndIOHkxSlFHeWZkUzdTOVBDYWxwY0xXcEhVZVNGb3dXVEJwYTNRcmk5?=
 =?utf-8?B?dGFCMXI4a3NDRVBNZTlwQUFLMTQrdE9EeWRUdno4aXRtRVcvMFBJTzZJWGxp?=
 =?utf-8?B?a3d4L3E3eDQ4VG1VcjA3alpyOWdlRlVtN3JxZkJpam5UcnlnenVZeHJadG1W?=
 =?utf-8?B?ZzhmUjJ4RGsvbnhhaElvMlJaYkNmYWVqelUrdlYwM1hqTWJESnRNelZIeXdv?=
 =?utf-8?B?VTk1R2cyUlhqdmlHNlRzNm9NZnFGNEIrdEpqeHV3VEo2M0FGRE05eEJaUDdW?=
 =?utf-8?B?UG94aWFLQzlXSlBDTXF3bDJXZGkrZ0pwb3I3Zjh4ditvb0ZsNXVQNEV3V3Jo?=
 =?utf-8?B?b01uQXhYS1R0bll6cksvaU1lYlFRT2FTTHNlQ0RsMWRuWlBMQ3RyTUtrQ25D?=
 =?utf-8?B?cHZGWlBlWHVETDFIdkpTNXdyMmFJM2Z5Q3VjREdrMldBM1VMYUlWU0lYczNH?=
 =?utf-8?B?d21EbWx1Qjc0TDZDZEN2OHUrT1huUTUyazNwQUZROVBzUVRTNFFNYldMVmxa?=
 =?utf-8?B?cDdUL1ppa2NHZHBORXBrUTgyWDFZbnlLdlArcS9SazRCRFlURm9RWVQxZ3Yw?=
 =?utf-8?B?Kzd1TTE0QlFnVmticW1xUWkzUEI5REhPVDRhTEk4NnVxdzUvclllZzQ3c25S?=
 =?utf-8?B?MERXc2d3dTBkMXpOeWNtYWFFak1BMy9Vbnk2UEw5SEtmT3R4c0hvRnZhWDI5?=
 =?utf-8?B?dmNzaVliSHVkem5qSmV0WFdyZkNDcnE1RXlrSFFhbnJwcEhTTlRuU1BhS1I2?=
 =?utf-8?B?YitGTmpHMk1RRGU5MlRId2hCMmRoY1hTeE9Bdmd6cFlJWlJpcnJuOEw4ODFM?=
 =?utf-8?B?N0UwWXJBTVVsSkl0LzAzNWxQaCt2NTFFSlRqUG9MZjBSRGpyTTcwQWIxN2o0?=
 =?utf-8?B?K253dTAzNjVVZkpPNEJ0WGNENG96Qmk2Um1aNFowbmpZYXFlVVpYUytvLzY2?=
 =?utf-8?B?eWk4RjRtY2ZaRU90bzRldWVoYkVnVVJCaS96elJMQ1dXNDZzeThhTVc5SUNM?=
 =?utf-8?B?d1RHZG8vdHluM2w4bTlsWjV0YWdlS0xXOWFxOHJ2cDdEWDFqK1ZsajlSZ0pF?=
 =?utf-8?B?ZUQ0TUsxWXpMM1R1Q1hYbGRsTFJkd1ZNV0ZrNUZFUGFMOVZ1dC9kTExlWHN5?=
 =?utf-8?B?Ukk4QmZPaThLQSthY3BhOWJlTE02eFlIblVFdCtaK3k0dkZNcm14SnlxN0F4?=
 =?utf-8?B?alJDRmloZUc3eFp1bWZRRUxXRS9XWlV3NnhRZ1Uxc0lTM09ZcE11OWV4NFkv?=
 =?utf-8?B?WjVxYnhHYlhPazFWUTVZUHI0ZW9kYmsvNVZzTWFNS1g4R3NOQkFrWTdsM1FF?=
 =?utf-8?B?ZGMvdXNpNUxmaGpZaWE3QnFjUVNMZndNWWcrWGE2aE44b0xYeGsrM2tTRXlj?=
 =?utf-8?B?NXIyalRuSUp3MzN3eEUzYkxsQjZ6b05VazU1K3B0ZDdPSUFPb091RjUyQkZQ?=
 =?utf-8?B?ZWgwYWlOVC9CWlMwb2pRTC9HOW1tSmpVWmZraHRKTEJsODRMU0tCWTRyQlhp?=
 =?utf-8?B?Q2xkNGZGdHY4ajBSU0oyUFl2SUdyanloNTJGSVJwM1pCVnRINllRWi9Wa0NF?=
 =?utf-8?B?dTUyRUE3WHFrdktETHJXNVpQWGZ0U053bVpmNmVVZ01WRjlPbEhvNDJ3Ui95?=
 =?utf-8?B?SnB3bTFNZGE2OHZIYnVTV1lYN0V1YzA1ME9kbFpERElJY2VZVlJYLzVOaHBz?=
 =?utf-8?B?ZHcrclZxdGJaQVpnbmRJUDAwU0dwakxJQlE4R01ESEdiWndrYWNsV2lia3kx?=
 =?utf-8?Q?geCyLZzT9yYu+lH+Sy13qtUnN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6012b790-96af-478b-c4df-08dd1530e0df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 13:29:43.5925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QWZJtmKoxTZ3xjppmcOEIkSPDton4rs1cM6akczwg8lFu1V5rHBiljDdv0BVN4X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
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



On 11/28/24 15:49, Michal Simek wrote:
> Sync zynqmp* DTS files with v6.12 Linux kernel.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Hope that we get soon to be able to enable OF_UPSTREAM instead.
> ---
>   arch/arm/dts/zynqmp-clk-ccf.dtsi     | 16 ++++++++++
>   arch/arm/dts/zynqmp-sm-k26-revA.dts  |  2 +-
>   arch/arm/dts/zynqmp-smk-k26-revA.dts |  2 +-
>   arch/arm/dts/zynqmp-zcu102-revA.dts  |  1 +
>   arch/arm/dts/zynqmp-zcu1275-revA.dts |  3 +-
>   arch/arm/dts/zynqmp.dtsi             | 44 +++++++++++++++++++++++-----
>   6 files changed, 57 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
> index dd4569e7bd95..60d1b1acf9a0 100644
> --- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
> @@ -70,6 +70,22 @@
>   	clocks = <&zynqmp_clk ACPU>;
>   };
>   
> +&cpu0_debug {
> +	clocks = <&zynqmp_clk DBF_FPD>;
> +};
> +
> +&cpu1_debug {
> +	clocks = <&zynqmp_clk DBF_FPD>;
> +};
> +
> +&cpu2_debug {
> +	clocks = <&zynqmp_clk DBF_FPD>;
> +};
> +
> +&cpu3_debug {
> +	clocks = <&zynqmp_clk DBF_FPD>;
> +};
> +
>   &fpd_dma_chan1 {
>   	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>   };
> diff --git a/arch/arm/dts/zynqmp-sm-k26-revA.dts b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> index 8c43ade94053..620f5185cc46 100644
> --- a/arch/arm/dts/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm/dts/zynqmp-sm-k26-revA.dts
> @@ -3,7 +3,7 @@
>    * dts file for Xilinx ZynqMP SM-K26 rev2/1/B/A
>    *
>    * (C) Copyright 2020 - 2021, Xilinx, Inc.
> - * (C) Copyright 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> diff --git a/arch/arm/dts/zynqmp-smk-k26-revA.dts b/arch/arm/dts/zynqmp-smk-k26-revA.dts
> index 719a4e49b574..b804abe89d1d 100644
> --- a/arch/arm/dts/zynqmp-smk-k26-revA.dts
> +++ b/arch/arm/dts/zynqmp-smk-k26-revA.dts
> @@ -3,7 +3,7 @@
>    * dts file for Xilinx ZynqMP SMK-K26 rev2/1/B/A
>    *
>    * (C) Copyright 2020 - 2021, Xilinx, Inc.
> - * (C) Copyright 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2023 - 2024, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> diff --git a/arch/arm/dts/zynqmp-zcu102-revA.dts b/arch/arm/dts/zynqmp-zcu102-revA.dts
> index 3132fa533b8e..dd63d22f45e7 100644
> --- a/arch/arm/dts/zynqmp-zcu102-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu102-revA.dts
> @@ -960,6 +960,7 @@
>   
>   &pcie {
>   	status = "okay";
> +	phys = <&psgtr 0 PHY_TYPE_PCIE 0 0>;
>   };
>   
>   &psgtr {
> diff --git a/arch/arm/dts/zynqmp-zcu1275-revA.dts b/arch/arm/dts/zynqmp-zcu1275-revA.dts
> index 095c972f1322..b75b2a796eb3 100644
> --- a/arch/arm/dts/zynqmp-zcu1275-revA.dts
> +++ b/arch/arm/dts/zynqmp-zcu1275-revA.dts
> @@ -15,8 +15,7 @@
>   
>   / {
>   	model = "ZynqMP ZCU1275 RevA";
> -	compatible = "xlnx,zynqmp-zcu1275-revA", "xlnx,zynqmp-zcu1275",
> -		     "xlnx,zynqmp";
> +	compatible = "xlnx,zynqmp-zcu1275-revA", "xlnx,zynqmp-zcu1275", "xlnx,zynqmp";
>   
>   	aliases {
>   		serial0 = &uart0;
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 6a29f6101534..70ca5e6379fc 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -168,8 +168,8 @@
>   		bootph-all;
>   	};
>   
> -	pmu: pmu {
> -		compatible = "arm,armv8-pmuv3";
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
>   		interrupt-parent = <&gic>;
>   		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> @@ -441,6 +441,34 @@
>   			};
>   		};
>   
> +		cpu0_debug: debug@fec10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xfec10000 0x0 0x1000>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu0>;
> +		};
> +
> +		cpu1_debug: debug@fed10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xfed10000 0x0 0x1000>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu1>;
> +		};
> +
> +		cpu2_debug: debug@fee10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xfee10000 0x0 0x1000>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu2>;
> +		};
> +
> +		cpu3_debug: debug@fef10000 {
> +			compatible = "arm,coresight-cpu-debug", "arm,primecell";
> +			reg = <0x0 0xfef10000 0x0 0x1000>;
> +			clock-names = "apb_pclk";
> +			cpu = <&cpu3>;
> +		};
> +
>   		/* GDMA */
>   		fpd_dma_chan1: dma-controller@fd500000 {
>   			status = "disabled";
> @@ -885,7 +913,6 @@
>   			power-domains = <&zynqmp_firmware PD_SATA>;
>   			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
>   			/* iommus = <&smmu 0x4c0>, <&smmu 0x4c1>, <&smmu 0x4c2>, <&smmu 0x4c3>; */
> -			/* dma-coherent; */
>   		};
>   
>   		sdhci0: mmc@ff160000 {
> @@ -1065,9 +1092,9 @@
>   					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "ref";
>   				/* iommus = <&smmu 0x860>; */
>   				snps,quirk-frame-length-adjustment = <0x20>;
> -				clock-names = "ref";
>   				snps,resume-hs-terminations;
>   				/* dma-coherent; */
>   			};
> @@ -1097,9 +1124,9 @@
>   					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +				clock-names = "ref";
>   				/* iommus = <&smmu 0x861>; */
>   				snps,quirk-frame-length-adjustment = <0x20>;
> -				clock-names = "ref";
>   				snps,resume-hs-terminations;
>   				/* dma-coherent; */
>   			};
> @@ -1176,11 +1203,14 @@
>   				      "dp_vtc_pixel_clk_in";
>   			power-domains = <&zynqmp_firmware PD_DP>;
>   			resets = <&zynqmp_reset ZYNQMP_RESET_DP>;
> -			dma-names = "vid0", "vid1", "vid2", "gfx0";
> +			dma-names = "vid0", "vid1", "vid2", "gfx0",
> +				    "aud0", "aud1";
>   			dmas = <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO0>,
>   			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO1>,
>   			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO2>,
> -			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>;
> +			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>,
> +			       <&zynqmp_dpdma ZYNQMP_DPDMA_AUDIO0>,
> +			       <&zynqmp_dpdma ZYNQMP_DPDMA_AUDIO1>;
>   
>   			ports {
>   				#address-cells = <1>;

This patch has been already applied to Tom's next branch.

Thanks,
Michal

