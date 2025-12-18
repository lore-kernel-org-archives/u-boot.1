Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A08D6D232
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 15:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A1383DEE;
	Thu, 18 Dec 2025 16:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TBuvPeVB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66AD83E0E; Thu, 18 Dec 2025 16:25:16 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE2783DE4
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 16:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTv+Mq6rMd1cFGj4/UX4cHTZ82l+28hJu43oYvtLulV7KTYa0/r5kWm5ivGqiNIclPEoiE+sT9yzhGUmU/X5CmCGhRqdNN26KUqtytAvjmZoF7L7hKSXGGx86VB5n2ACqYmKHSZZyheKIK9QOeW+bRizU+mF/1osVw7ZzX9Qr3GnwLSJERErzfAGP/mv1gZwbNexi95ca6uVyLxJ/WmpSZUTujCd2pH+yX1K+hA9dvIy5y0Uh64Qp8MetT3r66q3cglGLdg+vccj3jUMlRxT/Dc++dKt2+dnNPplwXHDJxLqIfl+iW5SiMucMwYqbckSfAqOLemURJRbLNXXM0AjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RA3WDdcRuK4b9pKcfm/LQvt2uzopM9jo+5E9FZLWB4=;
 b=LX4Qo8Wql3hYVejCUebb+vCr2mn0DbTj3qAUh3JvSwWVe2x642P+c0UmKku+1JMXVJpsxwpYxfw4MtkcN4kkB3xmeXdVp2QDqO64NjiGGMd3KKVYaYqS1OInaGyseddGr7Lu+e84kR/8H1lw3IaI7SKD+C6sacVbRNY5YDu9ldE73aPLJ41slcL/TgWibHFEzWZWqObw7KD0He3yUX6sFjBnJ6AOziexd8s4wEbRD/sjRopJr9HfbLSp9unhYoeyg+t6S+ddlzAEhxo1gv8qwPAHHL1oChTAC9n7gnxmARhDJ2mDkNBtB0IQDC2OWiwowTcMeFh85za4qYqrWo4PWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=dh-electronics.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RA3WDdcRuK4b9pKcfm/LQvt2uzopM9jo+5E9FZLWB4=;
 b=TBuvPeVB9vI7ao1kOmKw6enNvFxsHVwTVy2czhZv+8uVxSCr5FzBeAN7crSydMhCCt/IxZM4NYjKRp6YUTnY7poH3gFUbD3PmsjK35N+zfM+LENrPkqPis31oOlF2TCMce2alxTwbTKkUJkPT2xFKS1s6tGJ+Jv/7EH+QgIPG1o=
Received: from MN0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::12)
 by DM4PR10MB6205.namprd10.prod.outlook.com (2603:10b6:8:88::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 15:25:08 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:52e:cafe::1b) by MN0P220CA0022.outlook.office365.com
 (2603:10b6:208:52e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.8 via Frontend Transport; Thu,
 18 Dec 2025 15:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Thu, 18 Dec 2025 15:25:07 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 09:25:04 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 09:25:03 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Dec 2025 09:25:03 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BIFP3Ga3572581;
 Thu, 18 Dec 2025 09:25:03 -0600
Message-ID: <c8296852-16ce-4775-bdbd-6a41d4600619@ti.com>
Date: Thu, 18 Dec 2025 09:25:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v3] Kconfig: select
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3
To: Tom Rini <trini@konsulko.com>
CC: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>, Judith Mendez
 <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh R
 <vigneshr@ti.com>, Christoph Niedermaier <cniedermaier@dh-electronics.com>
References: <20251204-am65_dfu_fix-v3-1-de18ed3f346d@ti.com>
 <DEZHV1ELFZ43.E3FN619R0UNY@ti.com> <20251216140104.GU303283@bill-the-cat>
 <DF08W9D84X84.1DQ1VM5S8TT9D@ti.com> <20251218141653.GI303283@bill-the-cat>
 <210ecc7f-4de4-40e8-8c15-5a6231df48a4@ti.com>
 <20251218145801.GJ303283@bill-the-cat>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251218145801.GJ303283@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|DM4PR10MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f67b3b3-8854-4544-9802-08de3e49a013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFhvM2pIVndVWUJkOEVCb3lRYy9SMUFGNHJyWVNPMHViSWhGekttdU02aFFE?=
 =?utf-8?B?ZkJxYTl0a1gzWWdVcUNIYWtYeDFQM0xDbHRvcWRQN2V0R3phbW9sL1RrZ21J?=
 =?utf-8?B?QUluSDVVV0s5eFpnSkRMcVZQQnpzSFRhdmMwMVl0US90cVphSUpJWWh5bm5z?=
 =?utf-8?B?TzBKbmVtTnUwWFdhcVZhQlRsMWNuOFdENTB4NmE1cS95L1krOEZFTytIMlVT?=
 =?utf-8?B?RmV2ejc0S3hveHNNMElTVzBNVGxHYnZmcVlORjlaSU1TSysxTmFsQm5Va2J5?=
 =?utf-8?B?WFUwUUZxbXM4N0d6Ny8veHlTZG5QK2JaUFJVcGYyNnR2SFZoVmxtSURnZVlB?=
 =?utf-8?B?QkZFOXFZNVJsUlpiaFRvWExBY2dQRU9DNXhyUXlHMWRWcCt2WGYvaldQQkYr?=
 =?utf-8?B?V25Nek9oaVd4TnNVUFpZY3pFTWVlR0x2RmhDZlZGL2ZoRStoWTBXNVpnNXJT?=
 =?utf-8?B?RU5TUk8rUVhkRnBmRDVFSkxUdDZoNkZ0UytISWhZdDVoRmpVQWltUjdTMEc2?=
 =?utf-8?B?Nms5eVdQSVJwWEVwZXVtT05ydE5YR1djQVVFSnI3MFhrVDZMclpEQ1FqQ2tw?=
 =?utf-8?B?cUxHT0pNZ1Vrdm1vMUZnZWwyMXF0N3BhSHJzQ29ETTNTV2QzcFU1RkQzRTF4?=
 =?utf-8?B?MXBBbTdja2RpRTJ4dUc2ckFEaFpWN2xZRHNiN2FESDNra3B6OEFnc1Rub244?=
 =?utf-8?B?TXlkVkViMHYrb09VeVVQMFo4QndsbU82TGJOSmtKcW9sQm5EMm9lUXBCMXdz?=
 =?utf-8?B?aGF3MmF2TEtuU2dxVkdwN2RabXNkejVWQWNYMzloTHQxVU1xMHVjM0ZWSHpF?=
 =?utf-8?B?dUdTbmdIeUhRSkkvM012K0xtcmt4S0hhdzRTR2NWRlIva2EreTN5M3pzUTZw?=
 =?utf-8?B?ZG0ya3IvR3hDS1VtQWF6d1ZrTUdXMysvbVFrY3RKbWNoaWkxVGVOb3MyZUNW?=
 =?utf-8?B?ZFVhdUJOOFMvRkVHUDYrS1JRNWVjWXh3eHA5eEhKQnZsR0tQL2IrSW9FRFhW?=
 =?utf-8?B?NXl6Rk1yTnVVVkpQREp6OGlXNXM2bEk1NEVFMTZkR2tzV1IvSDhlajdwVDdY?=
 =?utf-8?B?blJFRWxtRXNpdnMvVytscWU5am4zaEFHRmdsTnpFc2tCeS9Zakhad09TWCtN?=
 =?utf-8?B?eXo4ckIzWWNCcWU4NWV2d0I5em5Td1JZOUx4S3VWbUJqdE5sOVhwWXppazVX?=
 =?utf-8?B?UjNoVmdBaDJQVWloL2hDU3NuWnh3Z0NWR1NRNnBubDJycjZJbTJQbjgwOFZP?=
 =?utf-8?B?YTExSnVpMmhJd0MyU1JNMU1OOURzMTlEQTM3aElnaGJqS1E0S3NxUmFtQmk3?=
 =?utf-8?B?SlJEbUw4NGU1RjRrYmY3dENuTDNZSk1ITUhyV2pOYmgyMXk0SU9PV1VoLzV4?=
 =?utf-8?B?MXYvbkFiTFQ3aWlESXlRbnQrR3pORkQrQVFCZHBzeXQ4dGdlV3RnZmRrQ01q?=
 =?utf-8?B?aGtEUzJTTko1eS9rZ29VYWo4WTdqWXpUNy9GUDhqNFd0NW43R1pwVmdpSE0v?=
 =?utf-8?B?UHhFMnhSTGMrWXhTSDdON08vcTA3VWZabFNGUmtBUWZEbFlMTG9kMGdtT1p3?=
 =?utf-8?B?bkh2YkNNTER2d3pxbDZhMVc4WWdiODJFVXJ5K2kzYkkrVlN6NTNJOFA1NXhy?=
 =?utf-8?B?TWpaOVlaOEJYZE91SlU1Zk05VEVvMWx2WkJoaHRGejhRSDBoY3JpeHRnbnJC?=
 =?utf-8?B?WkxwRncxK1llaGRSd1dGbWVzVzlqaTVEeFNMMlc2Z1VnZnBXMndoNU5hT21y?=
 =?utf-8?B?YktXY0Y1TDF1aTV5cUp3ZmlZOUZkUGR0R0xBZ2h4K3RWRGZqYmRDMkIyajhp?=
 =?utf-8?B?T2FlR2VDN1M0ekpoOUkwT0tiR1NBbVNmVG5TdjFkbS84bkVQNnhxMDRkT2gv?=
 =?utf-8?B?dUEyU2drZGRFV1BrQk5pcSthUzdrNzRkN0c4MnBsQ0V6MXkzQ2x3eDMyRyt4?=
 =?utf-8?B?R1hQUFg0RzF0RUdkRHN6b3hzU2VKbElnTmMrUWsreHpvV0VOdHNIS2tJbGl3?=
 =?utf-8?B?anZUUVhiRHRtQ3Q4d0VIa1d1bXdud2lvOTNaS2JPMTRWd0RFWkJBUzQ3aU5T?=
 =?utf-8?B?cGxDTGdDVlJiRENXUjNOaGtabGdJbHRjUlBjMjNlUndDQWwzT3U4YW9Nakt6?=
 =?utf-8?Q?oogs=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:25:07.1156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f67b3b3-8854-4544-9802-08de3e49a013
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6205
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

On 12/18/25 8:58 AM, Tom Rini wrote:
> On Thu, Dec 18, 2025 at 08:41:57AM -0600, Andrew Davis wrote:
>> On 12/18/25 8:16 AM, Tom Rini wrote:
>>> On Wed, Dec 17, 2025 at 11:03:43AM +0530, Anshul Dalal wrote:
>>>> On Tue Dec 16, 2025 at 7:31 PM IST, Tom Rini wrote:
>>>>> On Tue, Dec 16, 2025 at 01:52:37PM +0530, Anshul Dalal wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> Any updates on this patch? If possible could we pull this fix into
>>>>>> master as well for the 2026.01 release?
>>>>>
>>>>> I thought the feedback was that this was a generic problem and so the
>>>>> Kconfig logic should be universal, or there was an incorrectly /
>>>>> sub-optimally handled case in the tiny printf code, that needs fixing.
>>>>
>>>> We have a few ways to go about fixing this:
>>>>
>>>> 1. Fix the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
>>>>      with an extra Kconfig"):
>>>>
>>>>      Pointer formatting used to fall back to %x handling before the
>>>>      commit. Though going by the commit description, it looks like the
>>>>      change was intended. So, I'm unsure if we should re-introduce the
>>>>      confusing handling back where %p is handled but not %pa or %pap.
>>>>
>>>> 2. Add SPL_USE_TINY_PRINTF_POINTER_SUPPORT per defconfig:
>>>>
>>>>      This was what v2 of the series were attempting to do but as Andrew
>>>>      pointed out, there might be other platforms with similar issues and
>>>>      it would be better to fix it for K3 overall.
>>>>
>>>> 3. Change usage of %p in k3_sysfw_dfu_download to %x:
>>>>
>>>>      This is a suitable fix imo but we might still have to fix similar
>>>>      usages of %p in other places. We'd also have to be more careful when
>>>>      bringing proper U-Boot code to SPL since %p would not work the same
>>>>      way.
>>>>
>>
>> For what it's worth my preference would be this one. We should just work
>> to avoid using %p in general outside of debug statements.
> 
> I'm also fine with that.
> 
>>>> 4. Unconditionally select SPL_USE_TINY_PRINTF_POINTER_SUPPORT for K3:
>>>>
>>>>      This allows us to remedy the problems with above 3 solutions with
>>>>      very little overhead to the SPL size (<100 bytes).
>>>>
>>
>> How about unconditionally select this for all platforms? If it is only
>> saving 100 bytes it shouldn't be an issue for most, then platforms that
>> have verified they do not need it (or need to save every last byte) can
>> then disable it. Seems odd to make a change like "1e24e84db41a" and not
>> have the default be the existing behavior.
> 
> There's just lots of platforms that can't afford much growth.
> 
>>>> If this problem is faced by non K3 platforms as well, perhaps it might
>>>> be better to take the hit and make SPL_USE_TINY_PRINTF_POINTER_SUPPORT
>>>> default y.
>>>
>>> Ah, so now I understand the problem, with point 3. So yes, I think the
>>> right fix is to add "select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if
>>> SPL_USE_TINY_PRINTF && DFU && CPU_V7R" under the ARCH_K3 symbol.
>>>
>>
>> Just the length and specificity of that conditional string is making
>> me think that is not the right solution. What happens when we find
>> the same issue for SPL DFU on ARM64, or in some other code not
>> related to DFU, etc..
> 
> Part of the answer is that since we should be printing "?" now instead
> of the wrong value, it should be easier to spot the wrong code. Perhaps
> we also need something in doc/develop/spl.rst to talk about it (we
> default to a tiny subset printf, some things don't work without
> additional options, avoid %p unless you must and then enable
> SPL_USE...)?
> 

That's fair, hopefully folks understand that to make "tiny" printf
so "tiny" some things needed to be removed, best we can do is thoroughly
document exactly what those removed features are. The issue here was this
was a feature that *did* work before in tiny printf, and was since
removed, more documentation wouldn't have helped.

The only way we would hit this issue again now that the feature is removed
by default is if we are taking code from U-Boot proper where the feature
does work, and running it in an SPL environment. Maybe we should work
towards using tiny printf in regular U-Boot also. Would keep function
behaviors more consistent.

Andrew

