Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37035C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 13:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A702E883BA;
	Wed, 29 May 2024 15:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3HcUern";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8DF3883A0; Wed, 29 May 2024 15:16:01 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3218854B
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 15:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgTj7R2320FmL29yCXZRuriG5X/AS+NZrqtp6nFT1FV+jKAyNn+tTDqWCLQ9sG+qJ7n9+s21roiumMxqFcNFQvJ9yVLVRAA9mRQ0oEUwfvW7UbKf5vRpYR4PK9NUOazjk1w2sTZGN63pr3A1Kf9jkYG1eKYOuKe1Djg0vIP852mtPVK1C+ckipCVdyEIzhGjsLBumYw+CIdowCbPJ7FXZGTegPrzsSEr/fCeljmvn5HMf0P/CYpupyhwAeyhYE84KApdJ7HwiX383jfZTI13kv+CWlKB4Ve9MljIh008GzoqdwoEhbT+fwQ5D5WBbVTf+0Oa/V0jdzDefiw+8Q5Wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riC2UkqdWSRZdKaXpF39KvUCnLtKSQU/2uKeqfzyyI4=;
 b=mMtwdsdZifxmcY1R+Xk4CtPjTlkr6lDotKsNa6vXvxx7DtzGza0qUSO3Dh5yJAfWXVN6cq11dVfhs6gXVmMNOySN8BTPrsrt0zpbyWaKrBgIhKzGKiX+Me13EcKhxlHx9tbbN34/bU5HFJeqSbG3IjYrJYU4qDD/neDpmTBOPzbyAgUj1r9iR34qS4iclJLx048qkdIkWZ+5HTLQ/jnjsVXCn/ZppeLvU66WEKtD/x6IBVHeXRYmSGd1hJ8HBAszsHQew4yi6gxa5ACXoBLBK0K7e6cGjZPvx+qSFD2MnGA/gCUkfegIgbFpcXFHAgXk9p9dAUFoPVhU5Tm5h9G20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riC2UkqdWSRZdKaXpF39KvUCnLtKSQU/2uKeqfzyyI4=;
 b=D3HcUernPVzRB86qfw/ufgCHxxT+oz9oudrEUl4MS6WPkX5vI+NHTYhKdfia2I5hMsv7BDqtZInoZA7o1riEG5m0rcGfaW6C0EgNsL11sIITpdIdTjKzZ7jAFvtWCzGLw0NMKUUNDp2Iz0kK/nseuxZiB5F84X8e66eG/0IhPJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 13:15:56 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 13:15:56 +0000
Message-ID: <ae4f2abc-bc47-47c1-bde9-960df45f278d@amd.com>
Date: Wed, 29 May 2024 15:15:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: versal: Do not prioritize boot device if driver
 is not enabled
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 "Polak, Leszek" <LPolak@arri.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <8b7cca5c7b84cb4854104e0c48f8aa63c4ec5ace.1715322156.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <8b7cca5c7b84cb4854104e0c48f8aa63c4ec5ace.1715322156.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0305.eurprd07.prod.outlook.com
 (2603:10a6:800:130::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: aed7ef66-38c4-4a39-0654-08dc7fe17969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emRQSmEzVlk2RTNsa0d0ZVVkbkhaOG9vcGRGck5EcXlJQml6dkJSUUtmUTVJ?=
 =?utf-8?B?b0p5cGxGQTZMS0kxUHdJNDF4dENIN0N6alZOK3JGbmFrNE5JQUJRNVQva1J2?=
 =?utf-8?B?ZW0ybVBUOWtJTEtvRi9yU2Q2SC9VbEE1VDNNeFdBRGlvZklYWUFiOWNjSnY2?=
 =?utf-8?B?VVh1SFg4Rk9aWHh1dlBJQUxkU3VJVkdJS0hXMmhhVXp2QTlueHZUQ1MzQXBo?=
 =?utf-8?B?a285ODQyR3dTd0Q1TVphdjBUV250dlFqWnhGbC9KS2ducllyU1JBeHJyS3g1?=
 =?utf-8?B?L0hJUFlmYlpEbzFONkRtZ2ttbVZFVG42ZjFXYkRJQmhoRzllbWxyWXZpT3VS?=
 =?utf-8?B?dDVUYzByaU5tcVlHdXBjOWYxT244cFFkTmZ3RGYybW4wajhsclREMnZuUjRU?=
 =?utf-8?B?c2RlWkhQY2ZNbkh4MTdPV2U4M3NwamJSQVl1ZHVhd0ZJejZDcnZ0akhyR292?=
 =?utf-8?B?ZXRBQzdGZ0ZJd2pNLzdMc0lUTUk2SUFFdGcyc1dIWk5jT0ZXdUpSejJkZE5L?=
 =?utf-8?B?UkprT25rdStlWm1YV01waXBRWm5teUx1R040Tm5WSmtEU0hiVlJKa01rR2Mx?=
 =?utf-8?B?OTN2UXJ3Rmgxb0wzeVNoZUlNa0xOKytGYkRqMkNXaE5Sd01weG52MWxzSG1m?=
 =?utf-8?B?dlZrSTBzcjV2TnVpU2V2ZEhjbHBOaENFVjlKVU1mOXZKTTFTSGRnbGRVajNt?=
 =?utf-8?B?SmhKVkVsbTVWeU8yM0Fudm1xTEkvbTlEb3AzbjZKOVBBN1hDQnA2aW11ZW1Y?=
 =?utf-8?B?YmFCOEh3NEozV2ZRKzNvY3c3UzdMVWxxSHBIbnJrY2duMkRCM0dNRG5hcGVj?=
 =?utf-8?B?cEtzRlJkM2puYTBOWWQzV0hvbFVzVk4wcGdaYURqek5mZ2lFa1NXck5UUU9l?=
 =?utf-8?B?Y3dVL3JBUTJMMmVwR0FLMXBmVSt0czZOb0RZWW9FbEJSZHQ4dmdXRDNNNHIv?=
 =?utf-8?B?TlROd1dNc2tDdWF6VjJMZFZCamRDOHJua0FWM3lyMlozNmVRYVFtbldZYjY5?=
 =?utf-8?B?SDVkZ2RKb3NTcXIrcUYxQ1NGZDY4YktIWElFdDZsbnp3ajRXbThQZkdid0JP?=
 =?utf-8?B?czFIZitUc0xXT0ZLUUxOWHVtOC9ZeW5uRnRrQ1NUNGtjUDhwczVTd3NWRjkr?=
 =?utf-8?B?blNPZmg3VUJnRWNrVjdLVWVCQW8wU24zMTN5b21CU2hqMHJGUWtaL2xmVVBP?=
 =?utf-8?B?UGNDMkczWkhCOGkzQk5MVXBDaW5RSWwrZSszc2xhTkVuTHM0S1JKNk5JclM1?=
 =?utf-8?B?MzRhQjU3Mko3L1BsL1d3enovckE5aUJXRnkybmJJd1o4UGY5NktnS2pVWXJ1?=
 =?utf-8?B?SU8vNS8rMDFGQUxDbXhoUS9haVpTV1RzL2NVUGpwcGpqQkVpclV6RDVvNG5T?=
 =?utf-8?B?TVdWS0U5M2twQ0hVMXQyK2tHZzFtUFh6YzhHYVQ4VzBGL2JoNFhrRllQR3hX?=
 =?utf-8?B?WHdXeGxtamNIbHVqb3lraTdEYUlJMHVQUzBFMEwyVFhvNXFzTUo5UGJPM2Zh?=
 =?utf-8?B?QW1vbVcxL1FlNldsNmRLNlJTVEJDQ1ZxWnlSbFJtN2RqWVpCYkhRNkJyVFln?=
 =?utf-8?B?RzZWUnptRXlHbjNzaWF0T0ZTSUhLODFTMmJDeWpMS21IeHlFYzRReVZhVWlk?=
 =?utf-8?B?VUZzQ2V1SGJRaXBBQWpMNXRHOHVoNWMvWE0zdzJXQW1DbVJ6c3dGUmdkSUpC?=
 =?utf-8?B?c1oyREtmWGpJWTVUWTdVTW1qc2J6TkR2QzBUdStnYlE3aDhJbGFZK293PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekhvSXZ5aE91Qlh2YWZoamVnWkY2RkdkSmUwcVAwaXE4ZTZndDgrbGRvU3RT?=
 =?utf-8?B?VnNhL3FJR3ZHZzBzc2g1ZGdtSC9kK2VQTnpkZE9TSFBlbFRrNWd5NzNyQWtr?=
 =?utf-8?B?aE1ad2hCL1FRSUQyclJYMVdVMkFnSHV5T3lvN1g0UWp6TTRZb1g1UXQ0TDdP?=
 =?utf-8?B?cVhDMFJvQXd5WkpNZlJYQ1hOdHVSeFo5bWJ5bGliWitINjVQVEFndjFndkU3?=
 =?utf-8?B?dzhxSHp2WkxVV2RnQXpZaUgzUGJhNUZVakg2R1dxOFk2Q1lKVytENGorRTNh?=
 =?utf-8?B?c2pLWU1IOHk2Ump0M1RWN0lBZUZxOXlYNk52M3pWNnVQYUZLam1BSWhZbVE2?=
 =?utf-8?B?cCtJQVFtNjlIRFdnNUZZaDN2RFJUUFRhVGMweldTeVYybm82Qmk3emFmZTdu?=
 =?utf-8?B?WG5iNXRDSVNCcmxuQ3hFa2ZCU2Y2SzVPaW8wMG5iMEpoNTRuVFRIcmptNmZz?=
 =?utf-8?B?b3RFNUU0RDBjNjZKbmJHbmVrNEFkWWNJTC8ycnR4TldSbmZQdmFnNXB2V1g1?=
 =?utf-8?B?dkJzWTVhd1BLQnBCRnN2OUR1c2xOcVZWMzE4MmVYUyt4dy84Q3Q1Z3VBbFRt?=
 =?utf-8?B?TWR5SFBqNEU1WC9rM3RFc2JnSE5OaGdsbXBweGhSRzdVMEJ4elRCYWs1R0tw?=
 =?utf-8?B?RFZnL09Hd0ZRWVAvWDBpTlc2UEJHc01kbXRub01CRkcvVHVSSjcvdm1jUTU5?=
 =?utf-8?B?UWk3eTVwSENWVzBnaFN2UTQvSTBaeDJnMUt0VHRuQ3REYWZwYW5NRjIwcEo5?=
 =?utf-8?B?TE9mUHp4Q0diLzNOcFlOWk16UmZ0eDNDUVRjY0k1VlhpQU9kcHVycEIrZXk2?=
 =?utf-8?B?ZEw5Ti9zbzlPSVQzSDYvTHBQdEFQVE9UZCs2Q05Gd3hOKy9RQ0hIYWk1bWFi?=
 =?utf-8?B?OTh0WE1GL3NXU3NvNFU0TGdKZEM4eFgrMTRJcFB0cm9CMVBPVDN2RzFoMytS?=
 =?utf-8?B?ZFM0Y1JGWTF1NDdEV0RpTmNEd2o3Qm5oODQ5ZWN5MkhpdHhaT2NyUlZ4aEVL?=
 =?utf-8?B?MkdPd0tGUXA2TnBKbGFhTkV4Y3c1U1NaNldnUUJMZTA4aWtDY2l4ZHVCNXhy?=
 =?utf-8?B?MEhOUktzWjJmdnpYanNyTHJGaDFYQ0N6Uml5eDVxVFVHSTZlYVBNMzhGQWds?=
 =?utf-8?B?K1JxVnQxODhnWWMxYWxuQmpGWUQ2byt2SUxqUmtibnNES1FJVWVUWGVpTE1m?=
 =?utf-8?B?Nkc1VjZLcW1rZmhKMXpLWitiQlN3dEthbWVsMXhjdlU2RzFhL3BqUXp3OTVB?=
 =?utf-8?B?R3ZxSUNxS3dRSTZaaDF6dkFsUGdWREFLazdXZk1DOWNJbGhvMEU4UTNYYmQy?=
 =?utf-8?B?anRkOGUzUWVpYml5OG9lb3hpZlNQVE5NQmgwZVdoa2hxQUJsZmNHSkdoN0w3?=
 =?utf-8?B?QStLMVZSWGNIbFNXelVQNE1uWDl3anlsYWt0MjlSc3BsMGhza2d1amlEOGZR?=
 =?utf-8?B?WHV5STFuYmZFNmpZa2E4d3lrcUk0L2c2NEl3eWNjd1JONWRxYkYwZ3BRODZx?=
 =?utf-8?B?K3U4am9NMkZ1KzZRemhzNkNOT0QvOFNSZFUvbUU5YlNTeTVRSXo4NC9zVzFQ?=
 =?utf-8?B?cEhPM3lJd250QVQ1SWtjNDd0VFVnOTRJVm5zQ3d4ZFk5ckQxM0tlNjM2Z3F0?=
 =?utf-8?B?OXF0NzF3Q2RsQXB6M1J4VThWSUdYN1dKdlRKcVdiUTBEaUZsRkZWblVoRjNG?=
 =?utf-8?B?azRZNW8zOVh4SHF3am0yaWdLNUFFbXp5cEtvMkkvdHNPUXdSWVFneitKTkVW?=
 =?utf-8?B?R2QwWWE4NUViZTk3aWdjN0Y2eWxWckF2N28wdzFENlF0cFpVYlkyMnA4ZStq?=
 =?utf-8?B?QjAzcndURU9FRnp5Wk5iTVpOVE1qVTJ3OTdFOUkzY2t2VlpPeFZuY2J4ck5F?=
 =?utf-8?B?T1ZmaVFmZDU1OEpmTGtHQUlvd0xKRU15M3hnaWF2WFBDbzQ4WVFVMEY3Rko2?=
 =?utf-8?B?b29ISktiUHJWUTFHbG0xVzRYenlLbElnbWpwd2pCbHp3c1JCT2N2Wk1ySmNw?=
 =?utf-8?B?dURtc0VTc0xvN2tmNWN2SzFmdHhuN2F6dXQxYnpDTGVaSDJoSVdWcGQydlZm?=
 =?utf-8?B?cUJHS1ZLYTVsbjNLU3ozZ3l0TWdXMmRSZ3p1Wm5PbHQwWGVrNldFYVlSZGlC?=
 =?utf-8?Q?TozDsJMs2r5Y21IjnY/3wrDqk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed7ef66-38c4-4a39-0654-08dc7fe17969
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 13:15:56.3478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gF3JE0J9foxCcAC6MgF+p8WjBDWUi4WcdKVx9iIM9GyZGQn+r4q2vn5hGzvRgna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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



On 5/10/24 08:22, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> SOC can boot out of the device which is not accessible from APU and running
> this is detected as a warning, as the device is not accessible.For example
> getting below warning when the boot mode is OSPI and OSPI is not enabled in
> device tree.
> Invalid bus 0 (err=-19)
> Failed to initialize SPI flash at 0:0 (error -19)
> 
> Ignoring the prioritization of the boot device which driver is not enabled
> and continue with the default boot_targets. Recommendation is to use custom
> boot_targets via environment file as is done for example for Kria via
> zynqmp_kria.env file.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/versal/board.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 4f6d56119db1..f00605da7825 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -151,14 +151,29 @@ static int boot_targets_setup(void)
>   		break;
>   	case QSPI_MODE_24BIT:
>   		puts("QSPI_MODE_24\n");
> +		if (uclass_get_device_by_name(UCLASS_SPI,
> +					      "spi@f1030000", &dev)) {
> +			debug("QSPI driver for QSPI device is not present\n");
> +			break;
> +		}
>   		mode = "xspi0";
>   		break;
>   	case QSPI_MODE_32BIT:
>   		puts("QSPI_MODE_32\n");
> +		if (uclass_get_device_by_name(UCLASS_SPI,
> +					      "spi@f1030000", &dev)) {
> +			debug("QSPI driver for QSPI device is not present\n");
> +			break;
> +		}
>   		mode = "xspi0";
>   		break;
>   	case OSPI_MODE:
>   		puts("OSPI_MODE\n");
> +		if (uclass_get_device_by_name(UCLASS_SPI,
> +					      "spi@f1010000", &dev)) {
> +			debug("OSPI driver for OSPI device is not present\n");
> +			break;
> +		}
>   		mode = "xspi0";
>   		break;
>   	case EMMC_MODE:

Applied.

M
