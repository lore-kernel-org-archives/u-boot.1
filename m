Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FDAC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C7F2800B6;
	Mon, 20 Jan 2025 14:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fROvtDP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC38E805C5; Mon, 20 Jan 2025 14:04:20 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F8680077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzSJ/g/9HbEeGlo05/716y73M8bCsJiN7oqRQwbfck2qpKJ6HWO0FlgaaZ8F3uscH8KIXLQpRXTGOaMdRwAH0mAxyECk0XX7ERMOjjllebx/ksio4JXjvmEcIMJstU9MAnS7tmNqb6qh4s6wyEbUFxbI2HFFKwwbTAICWiyNSbVEXrI8FqZO83eI0GV4QBQXhSfdklkgqJW15HDqj4NLJlXHJqaHQ+IdC8Y0acZBgtWvky3BRx4GqSHaCiXJaz9Wwafx0GX3Oi4qz/rrQI6rBKvadz706fYaW1+4kvRPucNXDVMgaViH1uJFKbh/XvYeVVU6YkMIL3+s9QiWwGlasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spEf2GGCJDtT56XrOMVBE96ejHKWvM9ZOFOOUcSrFD4=;
 b=U5W571iZ/Ik9C8L8xn74lNO4rVHl58TWFB7RT4qnD1FmAjdeTFWOaidiKAX+7KsXtwxt7wyM8i5wiNPYkn62iCEZo+aew7zefdmiCM3qFnf0pl0dYbo566WsoButE8au10WpsVTR3cqb4nyP0DLtBxYATkFdz4wFa70slVvB0vbIl3CDwRP5oAf+n8xy7PKEhwEhdr23NLUnaiBjwn+e4H92hkqSJbaxrEUEWYG+7Uv8H2O36Ou0GkIlUnQjbmVpo9cO6zTLUsnbORoDJGXsNCKnvh2yfw6MPDf85SzKFClumsCUxaHTypmHj7C6tgCNHOqlxavQm9LeBTNOdpfqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spEf2GGCJDtT56XrOMVBE96ejHKWvM9ZOFOOUcSrFD4=;
 b=fROvtDP2KSddTLsZwkmPIFrUHUzz7ZvUVLfTLOz/BzqU6fvgPkb+b0lMUJInhrCwqQf/JQrie+NAGxI1oMyh5VbLKwgBCZMI2S7AbiMODK8BMxDSjqB5yUbh6ZX3xLWr+z8dOeB3W3oSgtfK35ymIhanB07UAQS6CsoDWRgnV9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 13:04:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 13:04:13 +0000
Message-ID: <011685c3-8316-40c1-8edd-60cac6cc2fc4@amd.com>
Date: Mon, 20 Jan 2025 14:04:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot][PATCH v4 5/5] fpga: add new symbol for fpga_loadb
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, u-boot@lists.denx.de
Cc: ada@thorsis.com
References: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
 <20250120124402.1501320-6-ibai.erkiaga-elorza@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250120124402.1501320-6-ibai.erkiaga-elorza@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0237.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::9) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: ef891e2e-17ca-424d-d7c2-08dd3952eff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnF3UEdXejlhcW1nQjNENXp3QXpXQnRIcHdIOHUxRFczemFZdGpLa0lOeldS?=
 =?utf-8?B?MmJ6UFdTbHVvbVVmZlczUHQxU29hbEVmRHFtMCtzSDlkSHlya2dPMnR4YVpT?=
 =?utf-8?B?TmJ0THM3WC81c3VjZU52VkM5bWYwR21WTEdPdzQ4bUZQU2pSSnAxUFJ0dlU4?=
 =?utf-8?B?ZzVzMTlZQk1uSE5zK3htUXJYdklLTzFkdStWYVJDQzEySXc1U2s3clVWVnBV?=
 =?utf-8?B?dXJXciswbDhxOTdHaVhYTTZ6VTdtbU9zZ3ZmZ0RGK3VwWXJKcWtFRWRBT1NN?=
 =?utf-8?B?aHZhODN5SXduVGFKbkhBaE5JL3pTZVF0VFdnUnRRYWNwTFEwUkg4UDRHK2V4?=
 =?utf-8?B?S3FpRy8xc2pUN0kzL0wzSEdpNWVLZFRMcEtPbzJWcHo0NUZEUW43YkxMYjg2?=
 =?utf-8?B?NXd6MGxEWmhjQ0Nvc1NDQzlhVnpEUnpGVVI0TXd4aTJMT2R6ejloTjQyZDhL?=
 =?utf-8?B?RFd2UysxRHM0eFkrOUMxSG1DcTdVNkFFSTB3RFJZTmo1V3FQZVdHSytxbzFi?=
 =?utf-8?B?QTlqV1l0L3BGRHluYWtERUM5NENjRThIUk9BV2w4R2dFbW0yckFXdG9lTTlx?=
 =?utf-8?B?MmZXWDcyaTMvMUpEQW9JdGdIUXJkcVJvQ2VtSG16NmwwV0kvYXdwOUd5ZEdo?=
 =?utf-8?B?N2xVTzA2eHpiYitNcVllb0d1djZjc0tKQzhpWmNHTSs2S1VhVWtuUTVWby9E?=
 =?utf-8?B?T1E4cjVTajg3M2tuU1EwMDBwY3NyVVRRQjZQbG8zc1VUVDdEZUh2M255VTR1?=
 =?utf-8?B?WjJQTVh6SWlyVTlqdGhoTWljT2ZEcExvYWxidzM1Y0NRa0xPNE5lQzZDckRV?=
 =?utf-8?B?VGFORzZhUmRQN08vbDlVUlhreGNQU3dmR0RodmdqOHJ6MWh5S0szTms4MjNU?=
 =?utf-8?B?MHhWN2JEdVlLMzJhUzdaSTg0S1VlM1YzZm1XOGFZNmJJSjhZNmJua3lWeERE?=
 =?utf-8?B?UWdscVlDSDdrMmtDKzlNb2dRY2ljUUZSWnQrZm94S0ZJM0hPN1BiSm9SLzk5?=
 =?utf-8?B?TkpJYzEvb05hbzM2MVBMQzBtN1ZxQjg5N3lnMitvVXVOS29QVk0wNVExUEUz?=
 =?utf-8?B?akFzRzFMcGJHL0M4WHBudUZqK0NrT3FNbDNJUWdCQ0grYWVYNVFwNHBOU0k4?=
 =?utf-8?B?Q280b01EakR6WFJUYkFueklsbVk4VW8wRGJXand2Um8yVCtOY1JnTU10enhm?=
 =?utf-8?B?RTJWcTMxTjFGdGlqVHNvVkF4cURHRlNGZllJMHFMVzIxL0gza29HVTlqNXlr?=
 =?utf-8?B?T084Ui9lRnphblRFRVltV3VVQmdEc3pEamxFTUlMUjFkNGttVjhDMmJoNHo3?=
 =?utf-8?B?eHNxeVQyRG5IVm82NkcxUmlwVXNoMlRJSVVGclEySURycnZUN0lCNHZVQ0pP?=
 =?utf-8?B?enZidG80TWZlMEJKNFNPZnp3OXd4b2lRSXhYUTdxcEdYY2pQczljUEgybVhx?=
 =?utf-8?B?a2RPY1JKU3pTbkVkMWF6a0VWSUFjWndqUDBTVVR6UDJOMHFBdVNjUGhFOTJS?=
 =?utf-8?B?RFd5cDgrb0pOSkU0OXRaS2VrQzdFMEJPdnQvcWVqNHlTS1dGTkdScVJTUlNZ?=
 =?utf-8?B?SGxGRXJMSk1BNGI5dU90dVRpSXlZRms1Z2ovaXlKWXFkenhVQkJ3dnNkTFVI?=
 =?utf-8?B?WjVISndLOHJ0WUN6cC93eWRieGVEQTk5NzlQK05HYW1paGRqVllOZ3ZXS1Ra?=
 =?utf-8?B?eERRdk5CVGhtcld5TXpkbHJRblVaVzZCVXRmQlFuSVFNTmVhaVU0NFBtcVZ2?=
 =?utf-8?B?TnoyeklXUENYWFN5M05rV1Jpdm0yUzRyR1hKc3FYd0NvZlVMMno0RlRsVmEx?=
 =?utf-8?B?bHNYdjI4dVRmZkRzeGF5KzNDaXFCNFd1RVB0UlBvTE9TOVUvcDFraENrNWVG?=
 =?utf-8?Q?+fvD937paRsDV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aStwcEllSTF2ZzBjNjB3b0loN0ZhaDlyY0RVQkNLektQZWRPVldVMFpkZk1B?=
 =?utf-8?B?NlZNVlJqVDRLWS9zdnpYVm9ZSUxLTWQ0R3lvN0xpbFJkMERKZ0FrUDRFWCty?=
 =?utf-8?B?OC9mTzJFd2FlVU5QSzhUMnlEMEZCNTBSblNQUkhEbWxjU2ErY0E4TThmM05P?=
 =?utf-8?B?SFkrT2RBYjhtdGRDZWxwbHI4cDZ1Y3p6eTZ3QlE5bytQYmhyaE1DSUFTQ21F?=
 =?utf-8?B?WktaenJSTXpWQy9kSllTaENTNWlpTlpERFgzekg1clM4UUFhVDlmUmljRXNX?=
 =?utf-8?B?NWdFS2ZTTjNKM1BQV3BmbjFxczhhNldTLzdZYlFCUTkzb2Z2L1VnMGUxemp0?=
 =?utf-8?B?N3hOdEhYb2RPVTBhUEZOQjBXQ2l6enVMU0ZBMHZWQ3Nta2t4SFdJQktSQkhJ?=
 =?utf-8?B?RC8yMkc2clp6Zk1paDZwUnFWczh1eWhXL1lFVmNoVkdNTG1JdmJtOFRYOVZq?=
 =?utf-8?B?bG1GUUVpWG91S1YvaTE5V0tQREZJQmFTZ0JiWGNRYmgxci9YVEFYSHh6akxY?=
 =?utf-8?B?YzJzMCtoTDM1SzJQN3oxWStGZXpoUGUwcUxwSWN2NWxzWXRTS0RLNGhsQnNi?=
 =?utf-8?B?REk3SS9PcXVoUWJWdGxGekN0RmU2Ny82Z0FEZVhBTldvaTNGcWI3WVR0WUVw?=
 =?utf-8?B?WHlwTm5YckZKekJBR3B5NW5iL0hTQThjUnpKTWJYc3hIT1BFWU5rRmZpQmVJ?=
 =?utf-8?B?WVdaQUZ0bTZuVnp1L0dDdWU4S1RiemFNSjJGREdaY2U3UEYzYTRtbnRLMGo0?=
 =?utf-8?B?QkJxN0xCY2dXNFdYc2E3eUFMYzBHdkZDbmRBZjRZc0lRQUtOMlFTRzFBTTZM?=
 =?utf-8?B?WEErS2c4aDdXb0I1c2RBSC9uSnRKa0wvSDBHWXVSeU0zb2FnTnR2ZXVkZk1I?=
 =?utf-8?B?R2hXZ2FiLy9Sa0ZxY1lMeVVLdTZCalFndHpnV0tlUzMzZHc1R3NsWXRKUnk1?=
 =?utf-8?B?SEhRSU9PVWxsMDdNbFZvT0RGNXJrN2ZiYmFPaUlmQWkxVWMvRExJVFFtN25q?=
 =?utf-8?B?YVZjQ0xvYk9yZjlDb0VwRk1Ub3RML3k1V2tLc0JzYmgzZ1kxc254dGI2QTQ2?=
 =?utf-8?B?OWM5VVdaMDNOTVBKS09tam45ZWltdW50YlNFbDRBNTc0cENoVzJ6Tk9WTTJK?=
 =?utf-8?B?Q1NwOHY1MXhETXhid2IzYWRPZ0xLZlJCOExmNi9hUTNBMWlhaEVqTzAxMkRh?=
 =?utf-8?B?RmVNSnVPemFvQmZPQkFaRzVIaExPalNBdnVvcTk4WnMzenBtSnJOaEh1VFh4?=
 =?utf-8?B?ZHU5TzBCaVBPQjBUV1NNOWRSV0M1NVdGdTlYcW1UWjFReUoyNEpYUk1jTHRD?=
 =?utf-8?B?MGc3RE9JOGVVZHhNNzhUdTNwcnh0SlJHRkNoVFl0bUxuS2p4cEZYZTI1WVIv?=
 =?utf-8?B?MURHVFhvY2E3TEFaakg4bUZKcUdOblAzOHQ5MHY2YzdueXdLS1JHK0lpM0J3?=
 =?utf-8?B?elNLNExlN3d0V25kNStyR09hRjU3NzhjWTN3czQ0dmJUQnFlZm9ockFWbFRV?=
 =?utf-8?B?eDhZb0Y1NTFuOGJRRjl6SjdRQzA0TjlSTU5Rck9iVnQvL2RvMWtnQVoxeHhX?=
 =?utf-8?B?aThsUTR6UWRpQVNCV2J6UExxSzlKWCtoNE5GcEQ1Q3RZS2cyQ2xhbXJOM0tR?=
 =?utf-8?B?MStQRWxMaFFWaDdMclEzVDg0UStBeGthV1d2RGdSSkIyTlJCV0l0OVZlN01j?=
 =?utf-8?B?MDFhRmJ0cUpSeG5zWTNCZDFvWGZWY3R3ZW4xUFRYNmVVcnBBWmpCcWZaODJa?=
 =?utf-8?B?U2pab2xLQnZNVDJCUlBaSWlMamJoNlhtWXN5NVBnZEFMendGWGZXYXh5UTN3?=
 =?utf-8?B?d1lRd2NpN2oxd1gydExGYTEveGswdXduLytGdjJodEV5QUdQazFEVXpsQUEv?=
 =?utf-8?B?blRrT25aVFNTTU11SEw5bmR4WUhmNWsxRGVXVWZjZ2MzRXVRWUREUEVlS2k4?=
 =?utf-8?B?Umtkb0ZLQmh6L3JvMTVwczFzWTUwcDZlTWNybVhacTNvb2tqaHVodzhrZUph?=
 =?utf-8?B?MURzZ3NwaS9SREF2dlZ5L1g0UzZVTU5uSm5QNks5Z2V5MUN0czZ5eVBJSmJq?=
 =?utf-8?B?bGw0ODBXWGNySllLR1U2anJLTmdPd0dNZlRQeWhSSTJtMmtkY2R4MkFhOW1M?=
 =?utf-8?Q?Q7e6VG76FGdi54QeG0RtcMXUb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef891e2e-17ca-424d-d7c2-08dd3952eff9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:04:13.5028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SpjhTRwciLL9GQtvPspuh4+sIEk+2sYjXlyiVJVmn5mnS2MQ2L895p8r2ylaJT+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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



On 1/20/25 13:43, Ibai Erkiaga wrote:
> Adding new symbol for the fpga loadb command which is exclusive to
> Xilinx. Default value is y for backward compatibility.
> 
> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
> ---
> 
> (no changes since v1)
> 
>   cmd/Kconfig | 7 +++++++
>   cmd/fpga.c  | 8 ++++++--
>   2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c9600498787..55a8d4189a4 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1186,6 +1186,13 @@ config CMD_FPGA_LOADP
>   	  Supports loading an FPGA device from a bitstream buffer containing
>   	  a partial bitstream.
>   
> +config CMD_FPGA_LOADB
> +	bool "fpga loadb - load bitstream"
> +	default y
> +	depends on CMD_FPGA && FPGA_XILINX
> +	help
> +	  Supports loading an FPGA device from a bitstream buffer
> +

Just trying to wrap my head around how you sorted out these Kconfig entries.

you have in help fpga_commands
loadb
loadp
loadbp

But in Kconfig you have
LOADP
LOADB
LOADBP

Also Kconfig description for loadp and loadbp is the same

fpga loadp - load partial bitstream 

fpga loadb - load bitstream
fpga loadbp - load partial bitstream

That should be also clear. It is loading bitstream in BIT or BIN format.

Thanks,
Michal
