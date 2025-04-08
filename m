Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2EBC369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 08:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F31F382FAA;
	Tue,  8 Apr 2025 10:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CuKbK0ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFFE83388; Tue,  8 Apr 2025 10:19:19 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E885182F5A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 10:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLLx7p12lYe4r3fwyIaGhD+oNlKLSv+1Do+YzFqoorq6frfxdjHCzorl12KZYFfPOKw7DCeeBPJantimyOAwCZHII3C22CKRArSjuIybQQPxFcHarpG3ERHL4Nrc5NJddiLm43w4AWQf3OSwaIEU7f+8QB2PZDZMCuA9FDkzECvxww22e7hyQ9u4CWCbeatJjo8AnrkhCwIS9Dyok5eU4hPYKLQFtcdwsYbe8kxhMsoDlhtgQI+SdOTsLrbUSE7h7+CbZqmcRMhEjEbK4B0AOCb047Jn2sgEkxx0UkLXwVOg8WNDXFJ1cPOXmDBXtSH2lA9RzRRLfE+2kGUwVMvdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rD66ZwGkdzV1xzjUxXaCgVVaBdoKYmCrnnn3Id+9PM=;
 b=C034v6EpPPr8W8CUU6HfgAmaMmCTg/sVEcf1GLpBEH//r2rJp54HQoMh0GCgv8boqIHUlH6I87+4te7pemh9Lhbv3UAnEQfTVxe5r37I/D0BUMQml/kt21SuNN5HSD9ZzhU4s2YvXKl2gHGgrr2+/L6icJ0ppq9op1vh5SNckHa4rTelCQK/kwFSe8vIDSFmSeuBvmWC38BZEClK3ulLNtW/DS+/guMUiIfTrIPwFki2T6WMhZFHskoXuob1QulRytZWJQjsppAs5Yq3Rm3wFUzL7CXXLrt3qXmD3wlu0K4fWHOcmxjDRj+5bZQZQH4q2Fe82ZZoJSpECnfW+B+++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rD66ZwGkdzV1xzjUxXaCgVVaBdoKYmCrnnn3Id+9PM=;
 b=CuKbK0caQzB5ft5egTc8JlhUviibKHQ0/9iY7u9Hoj9OaTZAJM4NcquFJafaFUQBL7NV4tzusWr0qnLz/9znq40B/mwFMpLWnUEL1V1yRZIht9CsYTzzaQSgYAry8TRy8K1525rjAn6Z2ddep1hZdB8mUcCDdQd8jvtHmmtaoLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 08:19:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 08:19:12 +0000
Message-ID: <6f75461d-ff7a-423a-b7cf-b34ccd9759fc@amd.com>
Date: Tue, 8 Apr 2025 10:19:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: versal: Fix initial stack pointer
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com
References: <20250407134544.3951763-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250407134544.3951763-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: da8b1c00-5249-4ea2-bc5d-08dd76760b57
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3phdGRqK3k4OUkzZmV3c2cvZVJ1ajlKQm8vYkMyRWh1WXdkK3Y3Rjl6RGs1?=
 =?utf-8?B?Z3JtZHdKSE9mMWJ1NldjbjQyUkJPbEtreG5TUEdjMUphZ05sZ1N3VytFVHFu?=
 =?utf-8?B?djNnUnJIZEdXUjcwMGRIM2drd21GcEJBMkZyVUlEVFZMQVd4VGJMZXhFRllY?=
 =?utf-8?B?SURJdldLNHJ4dlArOVppTElJV1BLV1JNcURBMHVWclNuQVplTVlGUWZ0QXVs?=
 =?utf-8?B?dllkelo3bWxkZFVabCtPSlhQN1BBMjRIWkhmWlpyVGhHQzFZaFc2M3hDRDFu?=
 =?utf-8?B?L2F0YnVOUGg1Z1VLL3dUQjE2REsvZnZjUG5FM1Fzck5oZTdRdzk5cktQQXk2?=
 =?utf-8?B?akFaTExTVWpsZFhVRnpoc3dBcjBwSHFkWlYyaXViNXExQmxNbk5DVllKODR2?=
 =?utf-8?B?aVlBciswdTFmVURmNG9sR1V3VVRLemF4ckJ2Q29SRWxxQjJrb2ovYS8wOFB0?=
 =?utf-8?B?a3RSNExJY0tDL1BTeEpZQmFTeXk0OW9LdzVzQmRxeWpSTlFsZWVISmFFQzlw?=
 =?utf-8?B?bmxzVmlrQjE5QVRET1d5Uzd0N2FUV3JiRGYrUVN4dmdUUHJTT3Q5K2NUM2Zo?=
 =?utf-8?B?SldlY3Z6VTBBb3dmaG5RNmVGNFo4T0Jmait5cXJLQmtYRldKejF2U3NzYkFR?=
 =?utf-8?B?RWdEMDlvZzR4YXYyVWMrMk12UU8wWW8xMGFTbG5yYXgvSTBUcjVsMlRSR3lJ?=
 =?utf-8?B?YzNVTUVBcVlHZ1lJaml0TkVSdzR5b3pJQ0F6dGRMeWlTSUlodVF6TmsvYk80?=
 =?utf-8?B?dnJHTzQ3dzA4cGtPQnVuRUo2RHpyam5DZlB5dVNYZkt3ZzJNaU9od09keXha?=
 =?utf-8?B?cTE3TUxPelBDRFQvUjV0aU1LczhTd1ZVWUtGKzgrMU1vN1cvQzloTm52Njhz?=
 =?utf-8?B?eUI4aWt3NCswbE5NaHVvcVpPclZEdHNqZ1dIc3JzbG94dndqb0xnVjNwWmtC?=
 =?utf-8?B?Ymw4QmhhRHYzeUY1WHdGVlVLWGJSMG8zSUdPbUxQQ2cwcDdpTDZ1OHlyYThw?=
 =?utf-8?B?Rk5FaTVHUGpEVHRlMkwwcit3ZmNLMjVTblZrcmRESiszVFk5SjQyZkV4V3lL?=
 =?utf-8?B?bVJUZmYrQkJqQWJVRCt5OENwQ2JPWldXcWNLQ1dMSWZGWVVXanBDM2gwWFhq?=
 =?utf-8?B?Tm41V3Fta09waXBDcVdKVUFMeFZxa0Ftd0FBYzJzZ2E2aUtid1RRMDJ0eHgr?=
 =?utf-8?B?OHUrVC9FNGZkQVlYMnJheXV0aVFpOHBUTGlDUkt2WGorak1XbkhsVUp5QXUz?=
 =?utf-8?B?bHpHa3h1SHdqWHN3K284RndMTE9sSE5CV3RQYzkxSEhwRklQWXQ4WDFrWjk1?=
 =?utf-8?B?T3RJVXQ0Mm1LelhhdElhQzZUbnRwSEJ3cWFyMkZHcTRkak1rbWpaYlZFdFd5?=
 =?utf-8?B?M2p4TklpYW1jVDJ1aUM5VTZEVC9waFN5Ym1JckRESGo3UmplY2tORTRHbllT?=
 =?utf-8?B?Q2VlVlZtb295eWJSUTkydGRSMXRHd1RIZXBkbDZUS0RPQzhvYWpUWjExRzZK?=
 =?utf-8?B?aVZVb2wrTlNYM1IxRkZJUlRBU2V1K0Q1UGM5a3hkM3djRXVnR3JkdWwvcE9W?=
 =?utf-8?B?L1RQeXNLSzlPbGluWk9rcmk1TTY2dDhEdml4S3ZmeElMOGFkQkVycEpacDRC?=
 =?utf-8?B?WkN3dXZZMmprVExCbzhLaGszNE8yTHltYlJyMlR3L3lGM1dIait1d0NabDY4?=
 =?utf-8?B?WG53T3dWaytlcVhXMTJTVThvUVFqeFQrRXZzQjlqNDV1VVQ4UWFnU2JjNGM2?=
 =?utf-8?B?cUMvVHFyazZlWEtXODNFVEE1dGJ4U3RZblZrZUdUWTV5V09ybUxybXdTa2pF?=
 =?utf-8?B?emJqRE9wVy9tRjlYWkFWUHFOZHZFSWRrdzY1M3VkbktzK1ZPSVQ4NGFkTUJv?=
 =?utf-8?Q?6Oa8y2IMtlLJ4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkNxTzJFU2w0R3VHS0t2WElpUUN6NEgwZlk3bjVxV28yTHpKR3EzNEJtbFhk?=
 =?utf-8?B?TnJZQXVENlNuazVkQ0ZEUTlvcStLRk5JdTlNMDV2RWh5VS9uODEyd2VRaGhP?=
 =?utf-8?B?d0dqd1pwcE1WZll6UWtaT0FaSXhqUGlTaktLeUZPUlpLYW9ZOHRoVU5HNXBI?=
 =?utf-8?B?WjhEMmowRHJZNXF0OHFLUFJwUHl2YU9IMUQyRGJEa2I3QUlQTXlOVDZRY2t4?=
 =?utf-8?B?RWhCMTZLYmNsQ1o4SktFZTgyeWRLQkFQUFV5UVFxcWZXR3U1dnM0RWExajVa?=
 =?utf-8?B?elpTd2ZGM01sandQWUx3S3pYdXNkVjBXRlVRRldLQUtjeW50czV4OGN0dWxi?=
 =?utf-8?B?V21ER3R0a3hCWHQwYkZ5WEhCUzZpaEh3OFNmRUNqMWZEVVJTRDdGTklQR1Ur?=
 =?utf-8?B?ejdRbTlUL1QzQXBUU3dHRzI0RUpKdTlUTE1pZkxBVWZLSW1yUHE3MWhydjQ1?=
 =?utf-8?B?TjVHczJvbzZ0NnFHU24yQVNoSGJTdlpJc1BpOFY5Y01UclYrckRBWXhwbzRr?=
 =?utf-8?B?STFLRzVNNzJ6V216MlAxRDA2MWtBOC84U0l6UFdSS2hacEJqTmx4TG1RVm51?=
 =?utf-8?B?VHlhRlRjNjBGZ1RSME8zREYzUGd0b1RKdm5SVkI1d1JDZHpSRTNxZS9oMHI0?=
 =?utf-8?B?b3ZCWUMxNWphQjRmdGJDOGs4ckRKa2FVb052WkJQczlGdUt4b1hhZlZFeWhm?=
 =?utf-8?B?VG1HZ1VSTWRFWVpWTWU0UnJXdm1acjRub1ZzZG1VZXR5SWo2R3dkb2FReDdW?=
 =?utf-8?B?TzhrN0k4N2JSamhoNHA2ZnhkSENKaitQUnhKSkszNjZYMGM4akZ6VXBjQkZ4?=
 =?utf-8?B?dWk5TlVONHl0V1lOYVkxVWszU3VQMWJlSWN4VTJ2L0dSZ0RvN0VNMHZQL2V0?=
 =?utf-8?B?Q2RPL1B3RmxDWXpqN2FVR0ZFd1dqV3I1a095RkJHSmM0R0FBeWpRNnVzOWdI?=
 =?utf-8?B?REsvZ3pUc1FqblU2ZmlHTkRaaEZ6N3c1S1Nqam1ZbDN1ZUcwbzBSbENQRVBC?=
 =?utf-8?B?aE5qSWVGc3JzMkhnTTB2MU9tSStTeUZTTlJ0VDVsb21HV3N1ajh5eSs1Wlgx?=
 =?utf-8?B?eWtrdXJaeVFyaUtOS3lOVW9idHU2U0tYVklSL25mR3B6dS9QYTBzMzcyNkM5?=
 =?utf-8?B?MGRCeXF5aTE2T2U3N0JlQWVFZGRmTUxFRFo4ZjJPdC9OMXRKeTdtL0lpTlpv?=
 =?utf-8?B?OXlsdlZxNlVLbWFSRC9qRVRPRE1QMGtHZ254SDVrS3BNeENhUnR6eGxkUHNG?=
 =?utf-8?B?b2J6emtGcC9jTG52Y0RCMEJ3NjVQN0pONlB5Q3d3OTFmVHhJTnl2NE9QdWVO?=
 =?utf-8?B?VUk5VXJWS3JIYUxCNjR0ekQ1N1M1ZkNDd2xYRUx2SWpQWXIzd1V6eWxzclNF?=
 =?utf-8?B?dVA3UG9RK045N1AyV1J5a09ibHJiNVdteWlYZVpzRDZ3VE9vRTFiWkFjU3Vj?=
 =?utf-8?B?YlpsNHBxTmxMYm9kWXdpMTgzQk9rK2VXL2lqUXo2bVhtNTkzaDRiaDRTOWE2?=
 =?utf-8?B?MGNLWmdnM2lsN3hvYVF6eGJWV0FZTVk5bUlRYjRGTUloQmdwMGR5TEVBOXR1?=
 =?utf-8?B?OXpTVVNpd21zbGppdjQ2MU1GOENqVmZYeGg2REt4NUtUVzhQVk9MR1dSa3ht?=
 =?utf-8?B?Rm1tQVZQOFpwSnphRHByekpRVlZ5ckQwWGZwTnR5MUhMY1RyYnRGSGNReThN?=
 =?utf-8?B?ZDVqMW5IQUdzSlhUSzY0cEk2RWZRaXdkQWt1b1ovcE1uTVVwRm9SaUI3OFB3?=
 =?utf-8?B?V3FJcktVRVY0OXlIRW80MVVlbGxYczFkTU9aQjM4ems1TmMycUFLWDY2YWRM?=
 =?utf-8?B?ai9JNXYrL3NWWExwbnQ4N25nVkNieC82K3RhZ3RQOFJ5L25DdWQ2TzAvS3l2?=
 =?utf-8?B?b3ZxVHp0Rk5BdUtpb3lHOWJ1Qk52OVZyMjZudS9wcENFTW13TVMwMkFHZjdY?=
 =?utf-8?B?L1JQRGI3bDhZcnVvUGJETVB2Tm5kRW1VYTZKa3NuZE1iNFRBQ081aWc2dlVw?=
 =?utf-8?B?YStZT0krUzBxOU1WOUdFZFlZK0phb1ZqMW90a3lrWVZTWFpmTTdQVHlGRkVO?=
 =?utf-8?B?QUVGbEVEM2kxdFd5Y2wzRGpyQ3lJRDZUTGt0cnorZUtmVXVVb3A5QXBVUEE2?=
 =?utf-8?Q?B/1+f0VUUcZW5hivu43/VRQSn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8b1c00-5249-4ea2-bc5d-08dd76760b57
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 08:19:12.7335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DsGu1jp7b2GwwWb46bVcFtVs1AzgbwvaJkM2esSjfsBUtSQXV7SmIHz8FwfYD2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
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



On 4/7/25 15:45, Padmarao Begari wrote:
> The mini u-boot is getting exception because of an initial
> stack pointer address is used at near the top of memory,
> and while executing u-boot is assigned pre-malloc and
> global_data memory after initial stack pointer and updated
> the stack pointer. Serial driver is used pre-malloc area
> for serial operations before relocation. But pre-malloc area
> is cleared while doing BSS at relocation time. The u-boot is
> called board_init() function and doing printf, relocation serial
> driver is not initialized yet, so it is using before relocation
> serial operations but it is cleared by BSS and got the exception.
> To fix, change an initial stack pointer address from near the
> top of memory to near the relocation memory.
> 
> Fixes: 685874939a5e ("configs: versal: update initial stack pointer")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   configs/xilinx_versal_mini_ospi_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/xilinx_versal_mini_ospi_defconfig b/configs/xilinx_versal_mini_ospi_defconfig
> index e1cdc186fb4..af9ce499169 100644
> --- a/configs/xilinx_versal_mini_ospi_defconfig
> +++ b/configs/xilinx_versal_mini_ospi_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000
>   CONFIG_SYS_MALLOC_F_LEN=0x500
>   CONFIG_NR_DRAM_BANKS=1
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFFFE00
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xFFFE1000
>   CONFIG_SF_DEFAULT_SPEED=30000000
>   CONFIG_ENV_SIZE=0x80
>   # CONFIG_DM_GPIO is not set

Applied.
M
