Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17E5CD3438
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 18:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105E383CB5;
	Wed, 12 Nov 2025 19:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EOiaH8Z7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E3083CB8; Wed, 12 Nov 2025 19:39:32 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B5483A6A
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 19:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqxhuJNyWwA9t7U+OYB6Ja+iKENoIQd9B7LG11+kmQw7ymvnm2/dXk4R5aT81bn9RXnx+42bAGXOIdue898zlbcbrTq8oy/UO8bqflL9orAkHUG6TIoV0/ghVxdcHhNwW6EoLE24PMfOcTAJ7JKnoMBVizeYPpNyIrr4jeJtZQadJ29w2NBA2ZilBrJtJfv93heBSm3w5L/gx3bFS3uiFCeQ4RCE1mwG5SdkNwAxVAW3BhTachNOUn/FxxtFoFUJhjg6+ywVnI1oEgRDuwSaL92tM8vd7MMlOtIvbRA6+a5axXUj1uRpILciL47bmVtnoSOJAzOfl8cmmwRZR4dWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UGR0lm4XfDY2/qwXd1xK44bPkjN/01jRCqnvhHiiTU=;
 b=lH2KxDV4ixpXhXa3WTEZ8BIKkJU8t78fR6ngZtV9+F+ObYwOq40jqiBs2ZCMO/1vgzXiQO7lP83X3lwiN8vZrPZa+qlclZR5FIhyI+NabEKEDHFabquVVI8hnSwvze+sFPJqRT8gYyUXuIGdaJgEh4+Ja0J007GM9q63oRJvRbqJewl7sDxcrWY90umm8h636jp+qBck13Dvz9siDbnxTr0rnWBp9eJWQ7Cj6bjRaU5cM++G0Po70AuE8fzf4FWcXZmiTcGweiJ/4UoaSAz432E2hLQbFf32V8rhE9jZy/bBrAPjMlnOZROrF0F8zr/mi3j+VNuoP6RZKJHjzRqDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UGR0lm4XfDY2/qwXd1xK44bPkjN/01jRCqnvhHiiTU=;
 b=EOiaH8Z7DSEfksLHXEFhigI7IQRlpRdm2kgQgkhvvgTMa+7ZMdaMgx/IkRj7C/N4gBCBq5WdM8lhRHLkO7gGJXAFAbtE1HdTxz/0SHKTzAKl7Hab3FPZd3IpFAHqo7gwspu8FAydA64TL75/gkC0krcZHl1Vfh3dbVw9nmL1p1Q=
Received: from SA0PR11CA0090.namprd11.prod.outlook.com (2603:10b6:806:d2::35)
 by MW4PR10MB5838.namprd10.prod.outlook.com (2603:10b6:303:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:39:27 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::7b) by SA0PR11CA0090.outlook.office365.com
 (2603:10b6:806:d2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 18:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:39:25 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 12:39:25 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 12:39:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 12:39:25 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACIdOfL3173167;
 Wed, 12 Nov 2025 12:39:24 -0600
Message-ID: <9185332f-7e8e-4f14-9e3b-6532116e4eb8@ti.com>
Date: Wed, 12 Nov 2025 12:39:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] remoteproc: k3-r5: Implement is_running operation
To: Philippe Schenker <dev@pschenker.ch>, <u-boot@lists.denx.de>
CC: <stefan@embear.ch>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 "Beleswar Padhi" <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <20251111071756.1257488-1-dev@pschenker.ch>
 <20251111071756.1257488-7-dev@pschenker.ch>
 <03940bba-e496-4078-9804-1b9daf6f43ab@ti.com>
 <372f7735a0d526055de4028d0d69636fbe65bba0.camel@pschenker.ch>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <372f7735a0d526055de4028d0d69636fbe65bba0.camel@pschenker.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|MW4PR10MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: a77aeb92-4e8c-49d0-8522-08de221ace50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?blNwYTRuaGgxREtveEpxMVhObENFb08xdmJRdUlvWmJtQ2Yxdk1ObitNVFJU?=
 =?utf-8?B?N2wvQnVyMFFDWkNFNldUTnRyd0orYjA4dlBBejIrcWJiR3pvZkhoY1Vwdk9V?=
 =?utf-8?B?QTBlRXJvaDYxYmVXSmxLbTY1ZklLSm5RMEZ6TUNJOXQ4WjZDYXoyaEw4YVJQ?=
 =?utf-8?B?ay9kTmpSdVRvMnkrZWcrakE5cnd0N2R4RmVvNWpCenRUc0hHOUEyaStWTS9P?=
 =?utf-8?B?eTNZeTAwWWliMzJDOWZ1ZDdSUnl2ekRoeDJZY3MyTEFzNXZzbmF4M3B1bHU2?=
 =?utf-8?B?K1FzZ1I3bE90M3Z0c2kyQUV3cjZ2WkJyOWo5dlFsK3RLbVNDeTdyNkUxQ2Vm?=
 =?utf-8?B?TDZHWmJITzM2b25jRW1pMUtkS25VODRicW84dFc3N3YydTRkMnNDNkZQbjFW?=
 =?utf-8?B?TjlWQ0hHblhYVDNxa1JhQ0ZZc2pUR0JMY3RVTEdXY1JSeHJ4Z1hGeGJwMnB3?=
 =?utf-8?B?aEdPV0Y5c2JZSGxLWVR0OGxzMFNRYmpYUWpNd0VVaVBtRkxjSDYrdGFoU0Fh?=
 =?utf-8?B?YWNwNE9lUll4b1NPRVRHTVdDUzA4eFpPSngxMG5xT1JMb2VSd0JlL0RYak1n?=
 =?utf-8?B?c1RLRFhjRllVbC95OXFtY2VqTkZNL1FMbUlvRDd6WnRoM3BBS0ZhNDlONGlu?=
 =?utf-8?B?azZ4UWNVRXFwSUVxRUZCeXBUeld4Z1hyeVFzZmtYM0xnNTBuNEY3dkN5NjAr?=
 =?utf-8?B?aHBJTFMyaGYwMWlzdTdoRGdnQVVlWktnU3FXa0pIQTVvakV1VUc4R2NNdkhk?=
 =?utf-8?B?dngwcnBFdUNoUHdiQ1RmU0hIZ3NzNjNjRUJwOXJDQ0xKZkVVTnVoam9YQWpy?=
 =?utf-8?B?a0ZlclB0M3JCczg0Ylk2d01xdThJdUJ4clZ0V1M0bkUzb1FRaWZheEZPaHNS?=
 =?utf-8?B?QmpWeXlmQnRPTHRKR1JySkxWV2lydjV6VnB3OFJYb2hEQXJQdVc0N1U3Qy9h?=
 =?utf-8?B?WWd0U1V4M2N5Z0hjS3JFTTBUTWdBOWhhN3FDeFZNSVF4R1JxbDRyUEQreVRw?=
 =?utf-8?B?Vkd6Y29aNUNUMyt0QTZ2QWlrLzFyWFNEZEEyVmVPU3VUOGNiOWs5V1NCK2p0?=
 =?utf-8?B?akt4ZElsYjNhd2NjcHh5VWFOdjB6OFdZZjhyWm9rcnlsbkMyaktGTlYrVXlE?=
 =?utf-8?B?MGZYK2ZOUDJ3M0p0c01yUTFGemZXampBMi8zQkpKbW0rWFRqQnJGNVQySWJq?=
 =?utf-8?B?THFzVitHd2t1TldOV3JiTkZHdWMwMUFKMVlJS2c3WHVKOUE3dmt2TlQyaDFC?=
 =?utf-8?B?b2xPMGlqQndySWYrN2d1YXlKSkF0SFA0aUkzMlI5UXRUSDVoV3JOUUpLSjdH?=
 =?utf-8?B?ekZ0bFh3Rk5RZFRiMjNkeEVXaWd3Z1ZrVXJnaStVdmducHQ3STVtV1RodUR0?=
 =?utf-8?B?bEc5blB0M0trV01kODRPenlsWnMwQWQyT1VMWnJOejl5M2FYYzdWQXBhdDli?=
 =?utf-8?B?Vm5sZERnd0RRekJ2WEw5VU9YZTRWRWpTYmx1K3BGbTkza3FpajdBcWxvdkVl?=
 =?utf-8?B?VjFxTVhoeXhDUG1WS29qbG5zVTZjTk5zS0hXdVdDUjV2NVV1NkRxaGczM0JJ?=
 =?utf-8?B?L1A3TGt1M2JhUzRHU2VLaG1RaTRBMHlMeDU2Vk45cE5pYUtyWFBaSVlmeEdN?=
 =?utf-8?B?ay9Ya1l1dTJQRDJ5TitvZjdrc25KN2ViSWpSamNwdE5wZnNMMUxPcVRUYWls?=
 =?utf-8?B?TE9IVitzRmxLRGJYdnYyU3hIOU9IWWR2aWFhaDI0TWkwUzJYcjI3M0FEK3Y1?=
 =?utf-8?B?MnJBVDJrOGpSZFpYZ25YdUY2UmlwemJXaXdzTzdiSkhqTk5KWnZXMUNsa0RI?=
 =?utf-8?B?YlhRSmlGblZQbXNtTXpGN21sYUNXQXNsajg1dHNkQkxhNTVFUmRlUnd2MjJ6?=
 =?utf-8?B?N0gzWkx2aUxZdmp1TEw3bmZWQWNvREVHdDllY3Rsckdkci9yUUdGSmxTSnFy?=
 =?utf-8?B?ZlVvUk9OMmFIRTVnMmlJNUgvekpWdU5yMjFrbC9sNExQZE4yQ3pIS2VkV1Fu?=
 =?utf-8?B?di9MdVpWNVl3RjBXOEVGQ1N5VEdXS0dTRTlka29RU1MrdXFDcDZtZitNdVRR?=
 =?utf-8?B?MFZjZnRybkJvNzFmREtuQU9xRGl3V2ZjM3hXRWw2dEhyYzliWkxKbWhHODJ4?=
 =?utf-8?Q?znMA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:39:25.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77aeb92-4e8c-49d0-8522-08de221ace50
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5838
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

On 11/12/25 7:49 AM, Philippe Schenker wrote:
> 
> 
> On Tue, 2025-11-11 at 10:11 -0600, Andrew Davis wrote:
>> On 11/11/25 1:16 AM, Philippe Schenker wrote:
>>> From: Philippe Schenker <philippe.schenker@impulsing.ch>
>>>
>>> Add is_running callback to query the R5F core halt status via the
>>> TI-SCI processor control API. This allows the remoteproc framework
>>> to determine whether the R5F core is currently runnin.
>>>
>>> The core is considered running when the
>>> PROC_BOOT_CTRL_FLAG_R5_CORE_HALT
>>> bit is not set in the control flags.
>>>
>>> Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
>>>
>>> ---
>>>
>>> Changes in v3:
>>> - Implemented Andrew's suggestion to assign size before casting for
>>>     memory safety.
>>> - Added Anshul's Reviewed-by, thanks!
>>>
>>> Changes in v2:
>>> - Made sure there are no build-warnings caused by this series.
>>>
>>>    drivers/remoteproc/ti_k3_r5f_rproc.c | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c
>>> b/drivers/remoteproc/ti_k3_r5f_rproc.c
>>> index c6356729e9db..7326f5a4b30b 100644
>>> --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
>>> +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
>>> @@ -573,6 +573,22 @@ static void *k3_r5f_da_to_va(struct udevice
>>> *dev, ulong da, ulong size, bool *is
>>>     return map_physmem(da, size, MAP_NOCACHE);
>>>    }
>>>    
>>> +static int k3_r5f_is_running(struct udevice *dev)
>>> +{
>>> + struct k3_r5f_core *core = dev_get_priv(dev);
>>> + u32 cfg, ctrl, sts;
>>> + u64 boot_vec;
>>> + int ret;
>>> +
>>> + dev_dbg(dev, "%s\n", __func__);
>>
>> This debug statement doesn't do much other than note when the
>> function is called, which can be done with other tracing methods.
>> Either drop it or have it also print something useful like the
>> status of the core (running / not running).
> 
> Hi Andrew, and thanks for also looking at this patch! I actually put
> that dev_dbg() there to be in line with all the other functions in this
> file. They all have this.
> 
> I'll keep it for consistency with the existing functions, but I agree
> these could all be cleaned up in a future refactoring patch.
> 

Fair enough

>>
>> Other than that LGTM,
>>
>> Reviewed-by: Andrew Davis <afd@ti.com>
>>
>> BTW this function would be the same for all the ti_k3_* rproc
>> drivers, in Linux all these were factored out to common K3 helpers,
>> might be a good refactor for here in U-Boot also..
> 
> Thanks! Good to know, if I touch it again I can refactor those common
> functions out like on kernel.
> 

No worries, my comment was more a hint to either Beleswar or Hari,
I'm not expecting you to cleanup our driver for us :)

Andrew

> Philippe
> 
>>> +
>>> + ret = ti_sci_proc_get_status(&core->tsp, &boot_vec, &cfg, &ctrl,
>>> &sts);
>>> + if (ret)
>>> + return -1;
>>> +
>>> + return !!(ctrl & PROC_BOOT_CTRL_FLAG_R5_CORE_HALT);
>>> +}
>>> +
>>>    static int k3_r5f_init(struct udevice *dev)
>>>    {
>>>     return 0;
>>> @@ -590,6 +606,7 @@ static const struct dm_rproc_ops
>>> k3_r5f_rproc_ops = {
>>>     .stop = k3_r5f_stop,
>>>     .load = k3_r5f_load,
>>>     .device_to_virt = k3_r5f_da_to_va,
>>> + .is_running = k3_r5f_is_running,
>>>    };
>>>    
>>>    static int k3_r5f_rproc_configure(struct k3_r5f_core *core)

