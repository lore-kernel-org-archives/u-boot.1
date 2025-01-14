Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA04FE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 07:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49EEA806B7;
	Tue, 14 Jan 2025 08:28:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rutNBhMK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7534806C9; Tue, 14 Jan 2025 08:28:26 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCAF80619
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fgh1ZvxlhQVfGPZ7q9xFntQFZKPcpJuHJ80sbF8Rm/NW09f1KckfJbxZooZPZMwZXVICJPM02qmqKVZnw2Gal/3ebOL6hvUdn3zwvCekAuS4QRy+q9tyPmMm3S0FIqmrVpPZaLrd7dqv3lbmwygXbexa0w7b09/uOG360a5SkQ5CkGJcg0A2dYxMKMf44WK15/H+JkCsVIL2aVQbQ/vWfnuniv+7YVqSFh1JmvCW3iIkGixq1bj3LQyu4ZFmW9+B/+QR3uTtXFUXhn6fzxdC2emjZpRG0cEeRxGbwr3yaj327/bLHae9vE/V4F8LbPcPHfXpSQ5+FrPN50q2vbTowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sORiancA1zWv1HOfNsIuhOXuju99Z+Zqq29M/CfFvM=;
 b=PSoSEeDXkgJXTfHk9iIHg18cCOFzbF66WVBb5RSTyEa1gnrLl8MP0giQu7auThKYK+M1fMXBsTzNDsYu9wHeNhEkXjgBK/q2UAC48o37jUzsgnyDyXuoh30Bek5rfT1OCqg4/5aF/YAN4vnaiu+D7YJR+rpzmRoJ0MJXCTA2Y5g6YHLrqb/hdEis05uJfZAcNTCMkOBYP19ArfcJIr0GVgFdRkB1fRyGt4zsCwXu4CqccvaZYEOBmBSHxDiP6XV+lsqtl09qx3Hmjxxqgpr1q1rHtXwrLBpVHp9C30xr1j0jDmrRcOHM4U/IglKrRJm7tlI7kL0W2Wb74L3XP6peqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sORiancA1zWv1HOfNsIuhOXuju99Z+Zqq29M/CfFvM=;
 b=rutNBhMKyNaagUr1usvSoyHW3YeMhI145OhLrBOmyHjFGxPpDM1c5Rjg0g/8GQta586yv+LDDVRiHXT6TEx23ARJcC7dyBJ20jA7c0tBx/hd0sZasuJCJXB/VaztDDfq42C2CNFhjhpUCfyC3ft94vQkaeip3YYeQ13iF6gFvGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 07:28:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:28:21 +0000
Message-ID: <a622268d-993f-4013-aa64-c89632bea901@amd.com>
Date: Tue, 14 Jan 2025 08:28:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add eeprom labels for System Controller dts
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Jonathan Stroud <jonathan.stroud@amd.com>,
 Paul Alvin <alvin.paulp@amd.com>, Saeed Nowshadi <saeed.nowshadi@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <878558c3c859599d29bc4ae2278baebf84b368e0.1736152966.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <878558c3c859599d29bc4ae2278baebf84b368e0.1736152966.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0307.eurprd07.prod.outlook.com
 (2603:10a6:800:130::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9a2652-3f9a-499d-61d5-08dd346d063b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2VKb2dvSkl2eFpOT2RCMVErK2FoeWVCbm5jVVg3QlBxdWNkUHI3MGtzTHgx?=
 =?utf-8?B?cDdxYmF6b1BIMWdTcE45MW8vbFBEWkJROHRZSk40VnFXcVJjYURTU0dCQ09U?=
 =?utf-8?B?Ty8wVGFIK241R2lUMXFMSGlwOGZiR3RSWEVwK3dSeDhEeHZnSFR3c0FMUXNP?=
 =?utf-8?B?cDB1K0l3ZFZ2c3YreU44K21tVG14QklURTB1amRzVDE1eWNsc2JDcDZ0bytO?=
 =?utf-8?B?M2Y1SWgvR2F1eE5RZHM3QjNKYXE4VHM5Q3lseEhaU1VRZU85YjVxeHp0MUFB?=
 =?utf-8?B?NzltdUF6dGZEMDB6R1dUd2lwRnF6b3llNnNZQ0FHSnpxWEtQMWdsMWFiYUNH?=
 =?utf-8?B?OXAxSnR3cDlXZzdrZU9qRDczck1sdWM2TzU0Y3ZuNUpnSXhYNnR4VkFwck9q?=
 =?utf-8?B?R2ExOXprOUgyRWxDNS9ZOHpHUUFBRHNHY1Bmc0pZb0J6OHViSWUxOTBwb2FR?=
 =?utf-8?B?TUxuMmZpeFQ2anJxMnJ4MW1qbU9TSm50c3hNNTFDNEYyS1RIS1JKUXFHTDRS?=
 =?utf-8?B?TnJkTUpOaFVqeUpXdlhjMEhHQy9rN281Tzhwb09WbGNUYlZzWVIwYlEvMjJq?=
 =?utf-8?B?dGZ1UGtZU1c2WGlJYkY3NU1BMWt3ayt5NTErS1NWWW1URWFPeVdUN250ZWdD?=
 =?utf-8?B?dThGUG9aZWlXcVZGYkhySEtrbVdEQ3RXeUlqY1lRSmJIU21qUEJyamNhcmZJ?=
 =?utf-8?B?MUUyQ0FRbm1xNXZSeVl1cEgzYm1SdVo0QmVHQ0xMZndSRFdrMTJuSURUM1ZN?=
 =?utf-8?B?NURmd1o5WFlUU1NUbkdvRElQM3F3RkswazU0N3ZtdEhzSVhxV3owSU1BVVRX?=
 =?utf-8?B?TTJZUGhNdFVvVGJva0crc2FqckxKeEFKQ2U3alYzTlFNM3d0K0tyTVprejlB?=
 =?utf-8?B?UGJ3QW9tZEo1eVJQcnAwc2phRC80QlFJVnJHQ002bXpPVFptSU96aTU4OHds?=
 =?utf-8?B?TVQyd20zZktuYkl2dWltOS9uZjU4SUNGVzFRbGFQVjAwOHdMWlFMeWRXRkRj?=
 =?utf-8?B?RkgrYmh5MXdzaGlSNmhXWHVQWFJtUmhrcy9SSWlPYlg0T0gzMThoQjZXWlBS?=
 =?utf-8?B?dHhXU0pTOFhMTmlBZnBUSWdPOXhjTThQL2U2S0hsTGh4bUw1RXZSb1NFaXZw?=
 =?utf-8?B?RW1VcEluT0l1MFROMjZPNlV3bTN6cVVBZTlWV2pRZTJwR2Y0OTlmOVdKRGE1?=
 =?utf-8?B?eDV2WUtlYkFhOHBHTFBmMEVibWk4ZTVnOHZoSUx3N1hwRm8wZW1uRG9PV1l6?=
 =?utf-8?B?dEg3dFRiR3lqeDNKOXlSWWJuTFB4YVhHZCtvZzBVUndnOGYvV0pWQnNMMHRC?=
 =?utf-8?B?Vk5CTFJ0c0l1WGV1K29QcGR4Tnk1R1g5b3ZYSXFxQWlzblJPZlU5bk5MNFdi?=
 =?utf-8?B?Z1NKOEpHNHhnMjhQSFFIbHFwb1ArSDY3M3ZIN2NvRTNPTHJBSFE2bTdkUjho?=
 =?utf-8?B?eXB6Mk9NYzN1bkNQZTBtM1ZvWnRLemlaa2JObEpvTkl6b1VRdklDdTQwWUZp?=
 =?utf-8?B?Tkh1bE0rYytkeStoTVdmYkNzc1BKL0NpTkFZNFFPcHF0WitSVTBZT3RpWWRC?=
 =?utf-8?B?Zk5QbnVMSGV5SGhyZDBVV1B1b1JHVlpoZ2xoY25QODFZdjBWZ1VrQjBKdTNV?=
 =?utf-8?B?Q01IN3NXOXdJcW50UnQ4Z05kdnMyMkFESTE3T2piUzhGTXpLOWxDWHdsd1RK?=
 =?utf-8?B?aXBqMHBqMHRjLzBsa3FSaVF1SEZWenQzay9SYlYvSGpRdUd1b2VlM05UVVdP?=
 =?utf-8?B?alFZeE9EcmdLS2wzdnpBMTlVbS85WmJDNE42RjFGUVdoNzBIcVhxNmhidzlP?=
 =?utf-8?B?a3NTUi9yaEFycTJ4SUZwWW50ME5sdjQrRWNQRXFDcGErTkcyaXFndXFUc2dR?=
 =?utf-8?Q?4dXM38TVfDC2o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJQREtrdkhGWS9KVjBnTjNiajhORi93Ui9WT3lsTEVRK0gycno5WUhzdmtw?=
 =?utf-8?B?S0lFaGJ4dVZrM1ZhTHZlU08wZUhUaHBsY1IzUm5UOFl6VTlPN1E3MEJqRDlT?=
 =?utf-8?B?UTZNa0xPOTE2RWM3TFJ4dWw0d3hldE43RzV5a3RLSnpvNzRTNU85Q3ZSVlRY?=
 =?utf-8?B?NmlwL0U4cVBWd3VsaFJvQ3JKL09rRVhwODZnNFR4MjFNWWttcnRodGRHMVVM?=
 =?utf-8?B?aktDR2Fzdzhqazd6RmR2MC9ReGo4V2ZvKy9pQjNlRlFmOEx1Y1BHWm13VW1m?=
 =?utf-8?B?NDNuZzNkZ011UnYxTmN6ZUh1S1dpSU15Z2paa2tOYTJyaG5mSkg4dWtCYnd6?=
 =?utf-8?B?U0xwcW1NTFNQKzY3VzZ0SVVWMEV1Q094ODl2Mm5QSE5EYXE2UUJFZkJsSlFU?=
 =?utf-8?B?ZUxmY2dBVkxVN3ltMXM4NXh5YnRlbmxPd2hWYnpPZW1YMUtZME9heXpUUGNs?=
 =?utf-8?B?UnVXZ0d2aHNuRjU0M1g1V1VXQU44RjhYclZqaXVjSEVIZXVDdTlvNFZpcWl4?=
 =?utf-8?B?VVlEbTRzNHZUZ3JDMnBYOGpXeTR2NUd3a2dHdkZKUTJXd0JzWHgxQkVzZ096?=
 =?utf-8?B?YjFSckNoL0d2cTJMc05KZys2dnlrUm8wS2cweVhSSGdrUkd1VnRhNG1jMzdz?=
 =?utf-8?B?Vi82eG9QNmJCRCtqdEhSN1R3ZVpqczJDR3cvZnp5TmV6Q2tYVjFKSWhzTW00?=
 =?utf-8?B?SFRza0tQbUptZGMwUTAveTEzeHg0YTNTT1d0SkRxYVVPM09vODYxcjRtTFJ5?=
 =?utf-8?B?VDdWeXVJajJXSFpQNmxBdE14WXRYczliL1BkWHFZRW5NUjRJNU1FU2h2NS9j?=
 =?utf-8?B?QjI3TDJnRFZKenlMc29PS1BOVDlQQjRQUDhjQ3hod3VBT1BpbUU3UzltbGVO?=
 =?utf-8?B?Z3Z6RnBVSlJlMDE5SElyTWlHT0dKMlRIa1lhKzJBTmo4elk2Z2JTRjFSa2dO?=
 =?utf-8?B?UmcrSlVCWUx2L2YrRnZjRWNkMGdYZDFySm9LVVBWL0s2Qmc0QU0xejhXd08w?=
 =?utf-8?B?NW11eTI5Qi9UWGRzOWp4Qm5kYXV5c095ODBYL3VSdVBOSHprajBrR2ZtSXRO?=
 =?utf-8?B?Z0FDZTYzOEVLeVlidVA3SzZWY0VNcUNSZmdDekVTY3VPeW9DZ21ES1ZKRW9r?=
 =?utf-8?B?Mk5aZjRKWGM4cW80eTZ2ZnhXRG1XK0tsVVZwWG94eTNIbmRiTW9MNC9aUnNP?=
 =?utf-8?B?ZW5zek1vWGpTQndZYjhKdDBSaEhnY25CYnByNU5wYVJzbGxTUDRzbmJ0Wmxn?=
 =?utf-8?B?RG9aMjBVNWhPWm9RK2M3eEdQVHNiTlBWVzRCWWJyWWkrb3VEUkpPbmFIZDR0?=
 =?utf-8?B?RjUvR0xhTVI4eHczNFQvUTFQUE1ud1pIZWFtandpZ0tPbFpmd1VFWEZSOUcv?=
 =?utf-8?B?ZERONWVXSVl3UWNVeC9WMm5LTFdSaUJWbGJycGVwb25OTGxJdkVUbExMZFFM?=
 =?utf-8?B?dE5wbzVRWlZaaEpobnpLTHIxc0NjTEdZaFdRdldhZVZRblFYZUx6TWNxUFh2?=
 =?utf-8?B?QUpqSDNaUXFRTVY1SG0xUFZZUmU3NnJYb3VuL0FsOTN3WjM5VndRcDZmQ2ZM?=
 =?utf-8?B?VFRJYkR3RmxabmRtekxFZE1wMlVJN1VHaFNkbmJTTFNsekdEVFZ3N0grbXhv?=
 =?utf-8?B?dEpzZzhDaHB4REdrRnpaNDMvQSsrUlRrbFVERUc5S2Y4aWpWQWlTUG1GNEtk?=
 =?utf-8?B?Uk9DSE1DSS9GNkJPbUtlWUJqZ2xPK1pRcEgvakp1TjVTRC9qQlRwSjdHblFj?=
 =?utf-8?B?clNFZ2JUTmZVME14Z2pYYkZHNkVQOVlwNEhWekxUN3NpREdpdE9OYkJlMHBC?=
 =?utf-8?B?aDVkNEdwanFrNU8rd0pNdTVPOGErRkFpQ2tOQlVUbkVvTWd0NmZHLzJlaE8v?=
 =?utf-8?B?Myt2Z3d5amIwYThwQ2NyaXlVcTNsUzZTYWswa2Zqd2Q3b0d2ZFY0VzJ1OXF5?=
 =?utf-8?B?WktqL2EybmpQRGs0TXRNNVBRNm1lNTNSWlQvZ3IrVWRsVUYzdWk4dzNROWQx?=
 =?utf-8?B?MU9HUGF6TEdtWVJpc2YyT1YwVGkrQlBkRDNCZTBTOVdMUjYyMFhlV20yUUZY?=
 =?utf-8?B?M3NnM2t3N2szeFg1ZGxiUWVlSkpwYjRLQWh1VWozR21UKzQzN0tZNE1YdHM1?=
 =?utf-8?Q?Kz6PcuuMGzxmepy1P677EtTcU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9a2652-3f9a-499d-61d5-08dd346d063b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 07:28:21.7785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bapnAQcpnuqq9MkpGYKsrOGIdLCS1MBxwb8cQo78JVPiIx5xXuVbKG0np8VUqaQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
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



On 1/6/25 09:42, Michal Simek wrote:
> From: Jonathan Stroud <jonathan.stroud@amd.com>
> 
> Label all eeproms so we can open by label rather than a fixed i2c address.
> 
> Signed-off-by: Jonathan Stroud <jonathan.stroud@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-e-a2197-00-revA.dts | 4 ++++
>   arch/arm/dts/zynqmp-sc-revB.dts         | 1 +
>   2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> index 4e0587fd441a..6e2d9542012a 100644
> --- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> @@ -494,6 +494,7 @@
>   			/* Use for storing information about SC board */
>   			eeprom: eeprom@54 { /* u34 - m24128 16kB */
>   				compatible = "st,24c128", "atmel,24c128";
> +				label = "eeprom_cc";
>   				reg = <0x54>; /* 0x5c too */
>   			};
>   			si570_ref_clk: clock-generator@5d { /* u32 */
> @@ -509,6 +510,7 @@
>   			/* and connector J212D */
>   			eeprom_ebm: eeprom@52 { /* x-ebm module */
>   				compatible = "st,24c128", "atmel,24c128";
> +				label = "eeprom_ebm";
>   				reg = <0x52>;
>   			};
>   		};
> @@ -520,6 +522,7 @@
>   			/* expected eeprom 0x50 FMC cards */
>   			eeprom_fmc1: eeprom@50 {
>   				compatible = "st,24c128", "atmel,24c128";
> +				label = "eeprom_fmc1";
>   				reg = <0x50>;
>   			};
>   		};
> @@ -531,6 +534,7 @@
>   			/* expected eeprom 0x50 FMC cards */
>   			eeprom_fmc2: eeprom@50 {
>   				compatible = "st,24c128", "atmel,24c128";
> +				label = "eeprom_fmc2";
>   				reg = <0x50>;
>   			};
>   		};
> diff --git a/arch/arm/dts/zynqmp-sc-revB.dts b/arch/arm/dts/zynqmp-sc-revB.dts
> index c4f70581695d..6f5856017bf3 100644
> --- a/arch/arm/dts/zynqmp-sc-revB.dts
> +++ b/arch/arm/dts/zynqmp-sc-revB.dts
> @@ -175,6 +175,7 @@
>   	/* Use for storing information about SC board */
>   	eeprom: eeprom@54 { /* u34 - m24128 16kB */
>   		compatible = "st,24c128", "atmel,24c128";
> +		label = "eeprom_cc";
>   		reg = <0x54>; /* & 0x5c */
>   		bootph-all;
>   	};

Applied.
M
