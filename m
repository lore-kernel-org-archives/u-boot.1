Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58509F3C9BC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 16:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B508283642;
	Tue, 24 Feb 2026 17:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wmtii7f6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE76B83981; Tue, 24 Feb 2026 17:42:37 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D82A882BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 17:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTmidmZmajczZTp1fux5za11dTprz8GDXaHfwlqnlEsrhjjFAgF2NJsLtVHxHZPxY2dGSWhrHc/SSiT+kaYkqNG7GBE9cEq81JizjO0rBnrOUxd7E5t9RDVUUkWt5TBezUZzo8xy6WxnrF2g+7u/EoVgwtNmwiXPsbORMyB9yDomaW8V/vPLRlhEWUSN1io0j/rMXQSiHq3N7C7pHV74mgDyFJ0HuTC6+SZ2TPDENlg9bCiYjxQua7XwzAEUEynAjfgbsw7BHtGA5X2YEnESdHRQCgf/txthieByxe8wUl1EIeag4cBgdEFcfbYBAqQx0tSvPAl2PDULLAtzYnVq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf2DpFVqhC9s9LIxCf57GFo3KKhwqXbQD4BSTx2Uw6c=;
 b=o595VEzW0PFC6VUGMm/lV6BuVqbBQvG2iUgmfCE/45yTLrF7ezZnNebjrLNpJYyxhnqj/EVjtQpD72WiqDfMpXHREdUDepi1XWdRllk8WDETOs5tWnV5Xmr4nxgijhJt9KXnSFa+sLeTM/A+tMHbg4lZxoU8l5gM0TiXgw+TWgzWX9HquU5Ly4NCtQ9H7oM19BGQUEqEOitmWkRSCIrQW8MA3MuRRY+6s7y13cf65LKiWzwer6dAWivq6pF6guMdzGLIat4H3/nj6ZadGUqr3hQApPbnk8uUV6Aqxi6KzvZTiU/Kd3Zn+Ws5ePJ7HZBUTJONAXQYQRS9M9gmG//+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf2DpFVqhC9s9LIxCf57GFo3KKhwqXbQD4BSTx2Uw6c=;
 b=wmtii7f6lZtJ00ijdYC/2jX+yAIiOm+X8RN+llRmkDNvQrXY5+X3eE5K2IVEfNBe8RP++GjUsaQIHmGGVvLxldU79qRam31De9YyUfkHE9T2qneiSni8fBU8Qn7pM+d3DjPMkYUSJgMxXubEfiTwkJqhTl9CJwZgikKFdD9FTBs=
Received: from SN7PR04CA0071.namprd04.prod.outlook.com (2603:10b6:806:121::16)
 by CYYPR10MB7627.namprd10.prod.outlook.com (2603:10b6:930:be::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:42:31 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::68) by SN7PR04CA0071.outlook.office365.com
 (2603:10b6:806:121::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 16:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 16:42:26 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 10:42:26 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 10:42:25 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 10:42:25 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OGgMvZ3068008;
 Tue, 24 Feb 2026 10:42:23 -0600
Message-ID: <5a979fa0-59bc-4e00-96ef-18992b50512f@ti.com>
Date: Tue, 24 Feb 2026 22:12:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: j722s: unlock mmr after spl_early_init
To: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <heiko.thiery@gmail.com>, <m-shah@ti.com>, <j-keerthy@ti.com>,
 <n-francis@ti.com>, Diwakar Dhyani <d-dhyani@ti.com>, <u-kumar1@ti.com>
References: <20260223144558.395289-1-u-kumar1@ti.com>
 <23f03e64-71e3-4fcd-a216-fef7de5a37aa@ti.com>
 <20260224143040.b2gvfhcschzznyvt@bryanbrattlof.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260224143040.b2gvfhcschzznyvt@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CYYPR10MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 443974db-e31f-4c00-d071-08de73c3b1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWl5SzVGSjBBWHlWQXo0MnBiWUNlZkJNM2NYMExyWm1NakxUdUFsZ0ZNeUJD?=
 =?utf-8?B?SnQ4VzJhU1Q2TzhrS09TNVBVNEtlQlJERTQrTW1GNDFvbW1FZ1llYmlJdEc5?=
 =?utf-8?B?ZlhHSWVQUXY2MENnb2tJL0FiUzV1bFVyUFVicVFMOGxLODFmQVhucXVhbTdK?=
 =?utf-8?B?K2RDTEJ5OXlXQ3BUZGJmQ1hMYy9PVGtnM0tVSmJPSXJGeEhlVnJXTWRTSEdM?=
 =?utf-8?B?K0piay9PYklKRTFsUEc1S3lOcEk2djhIVGRyelVxaUY2bUFEZjRsV2QrQXVX?=
 =?utf-8?B?bnkzRDVzc05IRS93ZXl4Q0I3SnBFRko0OHh5em1ZWDNQMWdzMnhVekJ5RVF5?=
 =?utf-8?B?Y3ZjWFd4aFo1WkJFTkxWMENvZEFxc1FsY3pRdUFvbjFMZ1lnaXFLK2pHaDVk?=
 =?utf-8?B?M0dkcVJMeXZ0aWFXQ29FSU1BZlk3T1UramUwcGJOR3Z6dFNRcGlSRUQxMlcy?=
 =?utf-8?B?UnpwUnJDais4dDR1RzlwL2NPOXlQRlFUS2EzZHhReUR4dFJ0THpYQkhYNGtY?=
 =?utf-8?B?WXNUTTdSenRUVEw2QkNDbENhSTdlaDNwUmVob25zSUlHQWljK3l1TjlRMGdP?=
 =?utf-8?B?M3ltdDMxZ2xTY3daSUtXdnQ3Q3ZvbDJzNkZCNGNkWEZoOU1MQWQ1QUQzUmd3?=
 =?utf-8?B?dXVtRHc2SzVSNC9kYi9qVWtGRU1ZY25abnhjQWppMmxLRDUraWRkbFhmVTB3?=
 =?utf-8?B?SkVFODFUaVBmTGlCdlFUQnAveWRpc3lmempFRVJDbDl1VjN4WjY2emllQjlD?=
 =?utf-8?B?cStNN3kwOEtNWElERDdDdGlzOERvY0o3Z3lwU0RvVmh0MWhnVlYrTFN6UzZR?=
 =?utf-8?B?RnVtTUtKcStZWGI4MVplL1BnbXhWYlpzdGFZcUE0bm1rQzU2TU9tQjgxM0cy?=
 =?utf-8?B?RlFoSStRVVpscERZT3ZXcW45ZlRtaVJKUkZtbUpSSmp3YmVKeFlTaGdaUUFX?=
 =?utf-8?B?d1ZRY1RVbVRJSktzUGR4dno2dzJBc25IZnNWOTdDa0FHU2ZmdGZ2aWVRLys2?=
 =?utf-8?B?ZVpCNW9aK05GVElFRlBtbW5nZlFVZWxya2hydm9lREV1cDFrdURKcVVYZllU?=
 =?utf-8?B?bDEvelFIdXdRbVBMYUdaTmYzRkJKOXZUaFR3QitMZWlMNzFQT0xhRWE3YWc4?=
 =?utf-8?B?SlZ2RVdKQmlUU2tKbXNXeDZXakcrRm9Cek9iSWw2QXBZOGdST3NLN3d5YWVE?=
 =?utf-8?B?aGw3RGJESVBJVEpIVTlYbmVMUlF1NFhWLy9KYnZkbldkM1pWTGhPVlIvcEFz?=
 =?utf-8?B?NUdNMUVaZGxZYTZhNWxvd2FWa2xNYmVjdlgva1RwRUlMa3ZCbnFLakY0azNB?=
 =?utf-8?B?M2g1aVBDalRWbGZTd1FhOW1MaDBiOXdISHNMSHFTcm9xZ2tXbVVzZ2lFNVA4?=
 =?utf-8?B?Y0UxWUdIZ2lZcUlYMjVIb1JqWWVub0tzSUtoU3FKWW0xS3o2UlczSDd3aGNH?=
 =?utf-8?B?cXV3MG5uTWJzNmswbHFPTXhiYW0xcXo3eTVRWGZ2a0pLZXNvTWswcUdCU2dq?=
 =?utf-8?B?ZFNpVXFwbzRNbkcxTTFiVkk0QjFWQlo4NVBtYWpyUWNKYkNldVhmV2wwNXFM?=
 =?utf-8?B?cnhhRU4zMU9yKzFScnM3dEc4V0xPM0l3RnNFb3Q0Nk5NYjhBRWZDVExiamRl?=
 =?utf-8?B?MGxlRUlvM2FNMmxkdnlTU1hGM08zOGZMNHNMMWFUeUxwS1k3Nm4vaitBSlFo?=
 =?utf-8?B?ZVN0eVE0MzdobVlQWjlmMjhGZFlVYlpuQmhXeSt1ejQ5TDJKSGEzeDJObE1N?=
 =?utf-8?B?clFTRHBBd3YvTEs3Y2xzL3ZHR0loVXZ0aEhiMDNscDM3RzZ6anZtajFGQkw5?=
 =?utf-8?B?UCtoWXVBWHdlSTBrcW1hNFBPK3Q1QzhBZ2p4endpc0k0MkV0SFVOYlZvdmc2?=
 =?utf-8?B?RndVcFdHRjhZbnJKM09tTUE1dWhmNXc0U01TNkZCTzdJOVc5RVVKTmE2emov?=
 =?utf-8?B?czZURXIvNzRWb2oxY205Y2k2cEowNlROcitmR2plQm1KYmdsOVBRZDZXSC83?=
 =?utf-8?B?Z3B4L2l5emdJM2JnekMvOUt1cm1YK1VobkxSWWVnOUlRSTFIL1B1UTlseXlZ?=
 =?utf-8?B?NVQ3WllBSCs1SmNodG5RUDhRanJDblEvZEdsZFg0RnlSSU9nRXVvN3JkWlBt?=
 =?utf-8?B?ZnNxczdFWnQybWxhOGhjZzJJWTJDNjk0QmxpbHRaWW1KTkR1OVhqRVhxQjQ5?=
 =?utf-8?Q?g9E9MtKk7ehiBa4SjZTXvu0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ptRDYpDMR54Sni6/GrrA8S9TiyQeDwSqD3+P81XxvjSErfjuHVuDT1CxYkUNcZlDodi9K/Q0ut7SxmMLco1Wn1o4kyNnkjQTYJ20tkmBExdRGkWdEhVBM1O45Vy+ufWLh6wv+wcqF3sX9IhvFRaDDl7lG8NFEseuhrqwMrTJgMNqwar1mMWS3HYIy9QE1GJ6Uw4l2xfS9DDPhEHyXoJRDw/VjmWOxcmC/vvRIYTMs4COdRZxS5T0mDBKWrj8R5BEqDbmiQabXCYHfIQ0ZHsgsxFcZdCKISeTJ7DdirmnAtkp/6fYtrD88fynE7NmHLsa2oBvHtn/ZDzFQUp/Og0VOo4dL4jpmPnhRX7PdZFD2clDqDwlkSj50F9A6JlRzyNxfpnEQLsZI51W1ts5NwVl3cRXogym0SjHG7FgoJHBd8QuIGz2uMSlnHJvXmFS7rfd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:42:26.9876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443974db-e31f-4c00-d071-08de73c3b1b7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7627
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



On 2/24/2026 8:00 PM, Bryan Brattlof wrote:
> On February 24, 2026 thus sayeth Vignesh Raghavendra:
>>
>>
>> On 23/02/26 20:15, Udit Kumar wrote:
>>> unlocking control mmr before spl_early_init leads to
>>
>> Nit: capitalize the first letter
>>
>>> unpredicable behaviour.
>>
>> and run through codespell.
>>
>> Commit msg is vague. What unpredictable behavior? How do we know moving
>> the ctrl_mmr_unlock() to after spl_early_init() really resolves this
>> unpredictable behavior?
> 
> This is an issue has been reported by many people using any of our SE 
> configured reference SoCs which we haven't been able to give an answer 
> for.[0]
> 
> The current theory is the CTRL_MMR ranges are firewalled by ROM and TIFS 
> is unlocking them for us. If that's true then we need to move this until 
> after the version message is returned to guarantee the range is unlocked 
> by the time we get to this point.
> 
> Moving it to after the spl_early_init() adds more time but isn't 
> guaranteed with many boots.
> 
> [0]  https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/


Thanks Bryan, 
Make sense to move unlock of mmr after fw versions are printed. So that we are sure
tifs and boot-rom are finishing with firewalling.

FYI, i just did one experiment, put random delay before calls to ctrl_mmr_unlock()
and wdt seems to be working ok.

Another option I see, let original code be as is, and add support similar to above patch
for wdt. 

> 
> ~Bryan
> 
>>
>>> So unlock it after spl_early_init.
>>>
>>
>> Wrap commit msg at 80 char uniformly please.
>>
>>> Fixes: 5e291ee34fd4 ("arch: mach-k3: Introduce basic files to support J722S SoC family")
>>> Reported-by: Diwakar Dhyani <d-dhyani@ti.com>
>>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>>> ---
>>
>>> On HS-SE of J722S in particular, enable_mcu_esm_reset function is not able to reset bit-17 of ctrl mmr CTRLMMR_MCU_RST_CTRL.
>>> Which leads to wdt is not functional. With this change
>>> bit-17 was getting reset properly on HS-SE and HS-FS devices.
>>>
>>
>> This too needs to go into commit msg if not in $subject as this is what
>> user actually sees as the issue.
>>
>>> HS-FS
>>> https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-fs
>>>
>>> HS-SE
>>> https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-se
>>>
>>>  arch/arm/mach-k3/j722s/j722s_init.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
>>> index 1180c75f551..a0dab5d7032 100644
>>> --- a/arch/arm/mach-k3/j722s/j722s_init.c
>>> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
>>> @@ -84,13 +84,13 @@ static void k3_spl_init(void)
>>>  	 */
>>>  	store_boot_info_from_rom();
>>>  
>>> -	ctrl_mmr_unlock();
>>> -
>>>  	/* Init DM early */
>>>  	ret = spl_early_init();
>>>  	if (ret)
>>>  		panic("spl_early_init() failed: %d\n", ret);
>>>  
>>> +	ctrl_mmr_unlock();
>>> +
>>>  	/*
>>>  	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
>>>  	 * regardless of the result of pinctrl. Do this without probing the
>>
>> -- 
>> Regards
>> Vignesh
>> https://ti.com/opensource
>>

