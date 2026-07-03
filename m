Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FAAC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 12:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38347849F6;
	Fri,  3 Jul 2026 14:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="hjKyl9Ca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4DEF84A27; Fri,  3 Jul 2026 14:36:05 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C257849F3
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 14:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYkoCou5QzA5CBVLno+GrlaWK7jEJV8NTdWR6WGmpwCpKucc9vhyhDwiMUZmlz4K/STtoE7E9PRDF86r8gJpfYbLdOOEojTZCp2lSMN7oqj3PImu2UnTSSnkQaT59YfKMAw4OKOxhu7beC1aKB5dbYifmk7zATx3TGXM3oSpLFmAUeBDc3giWuJ76h5Z904Ccy2QYSt2vjWHlnxNa5z9dgCj2LMQ1C8b4TVzUuLDNARDgi/QxzkttWqlsr64PyDKikopHZRR21inHHvrmlnvYs9nQK63CgUA9P6e+t1v0KEyT7I2Hd6RMJXw4GMzsXiyVS1aBBAQ1e2Y9YJD+B5aNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmPu3MO2ERcF4mM3gsGUVStM/fFKf0UqHjrHURq+NjY=;
 b=H+EF43R6BG1yz6IREdkeif4TXFuZ3Q7gyAHgjTl5UNH7w7YPSeQyuQ28AigmEJfZUukOYCEsj9WUBhSOYwGGmMXKeB+yeCJt3tgPKrG70ePlMGMM7Bp4h0mnyRjnHViYsEy3aDbbDpxhPa7y4ZdBjrg5M32K7tOL6hRJGk/KUOdUoPWyYi4bWEqy9Q5Nd/0taqqdlgf5oMn4hOWioCu0RAptrrolwmMFhHVamH5lIzY4/wY093WLFoYms3jzQvVjcS3txWE68YqAiLnkU9TGKtNYVL6AeGEaSsTYuU6/kTdWQP7Yih63MeQuNk9YR+qNyETMsBBCkjli/bkiStFlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmPu3MO2ERcF4mM3gsGUVStM/fFKf0UqHjrHURq+NjY=;
 b=hjKyl9CafDYVelAT7TPLIykNK88OeAEvcE5Xp482wo94/Yhb+3WVoy4UfMFwVYmfhad41Y3cCK2LVKLgyAbJ132pbxGuqpSepuOEffWF9JZoq+Q3KSCLUqHr1+LY2TOHrHjzvjPlohK8JKrYWSPHGH6rMEGjQzZb1a7nu1Txsdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS4PR04MB9290.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Fri, 3 Jul 2026
 12:36:00 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 12:36:00 +0000
Message-ID: <83dbaf71-7bf0-4c64-a634-8a3bab9a72fb@cherry.de>
Date: Fri, 3 Jul 2026 14:35:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] drivers: sysreset: revert support for args
To: Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <foss+uboot@0leil.net>, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Michal Simek <michal.simek@amd.com>
References: <20260702-revert-sysreset-v1-0-7920c16a1f3a@cherry.de>
 <2ccadd61-59e3-4f97-950a-47928c83c7c9@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <2ccadd61-59e3-4f97-950a-47928c83c7c9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0092.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::15) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS4PR04MB9290:EE_
X-MS-Office365-Filtering-Correlation-Id: 038aeda9-7b23-47e4-c45f-08ded8ffa2d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: S3rh+EDUDTgSDOZpR++6pikovrGCldYynIxNNzBPqg7sppxNAKKivIL+mYW130ZX2E+W5EI7KUpCIHnpbIyg2mdRWwEqdRNdvauFsx5w+MY6LbUhRdkSLucKxE9wwkA3+j3FjmepDG9rrk32A3tJdkxjjvzLxWhxiMZ+QEMWcuDXwfq+8/TEQd7tHkNGlKLI17rGT4F1felAJEykKy0l/YPMO5W5DihISVkbcCL7sh8tAljet5IxWEJwJ0tCWnJudqBWEudJe0oaVFva6WXBpgkxKkNVDE2PWMPya8hll5PkbJo+Wmbqq483NjHv8JsxlaZTNAufnYuwa5/8LMtlabtJRiqXtkp1q1O2oTo0rDP0xfrXfEAlkDTr3yPzqzBKSWwNnKpGJQia3WZKovqnct4RlqrQShH/iywPRHlM6sf3HuwnOcylZj4nv0khs58ek0dOLxuFFLCJqPlF87YdKS5L7hoJ9L0R0DLKs3GYJwnYqGZHn7Ure6lrBV9pWWBo0CoPnqMe/Ts1AT8RSfY9iNvFIVpVXE2qtGmXGgDhliMlRN+S1NFDh8w8QH9YKwtc1GjafEM0jec6YPLukMiVsEoL+KQ6ubohjjdu87GQHlnepM+oEGCChmfH9EyksRvE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDBENE1NWEtHcE9hNmtyMDJnMWdacmxtOUxOQU9nRlF4RlhEQkthemVMQ1g4?=
 =?utf-8?B?S1B2L2NpenhuZ25Dc0ZLUDVFaUdOUGRPbm5iL1lJRG1GUExGdzVHWk53Y0Zi?=
 =?utf-8?B?YXlWdXhRdlVsNW1DNFVxY01IWXFlc25QaHQzSWVSRGpHM1dVeGRxdHMzdXZB?=
 =?utf-8?B?M3dhWnZuK0l0T1p4UTA1RDBFUmVyYUpFWmhEcDcvbVh5WXVoSytIOHQ5OFNK?=
 =?utf-8?B?OVQ2S1FNZjF3MWY1OGczTDZCWFlsdXFKRzdYWWxWaDlNbm4wbVRTSkpIYzJj?=
 =?utf-8?B?dzJzYllqcm5xT1JBSDhGL0pZMmpHRHNUVmNVYTlObEZLcnVHZkxQdElWcjZw?=
 =?utf-8?B?dkhObmdkaWNhUEVBck5NSCtwZkRJMzlaWEExNUVSOUdTaG1GRTZMMXk5eTlI?=
 =?utf-8?B?SENXLy9uWHZuQWdteVVqd0laMzlMRjFaRlNmcVJDUjlsTkxkT3NvQ1RyTXFo?=
 =?utf-8?B?YUMzekRheFdjUWhQaENVU2dRSHBnbXhWbERiK0haeklXQ1JybklZVG83Nmw1?=
 =?utf-8?B?c0ZydUhkYSt0WlhtUi92S0xqcW8xakpxUjh2UmdiWWI5WGUvblBGNGdUR0tT?=
 =?utf-8?B?eFZmVWJ4NVdhaTd2L09oN1BZdXdHcXBNNUdaRnJMTVZmbUl3RXBFQ3JTOWxv?=
 =?utf-8?B?c0tKNDFtNUtrUUR1QlFGUHFkZ3p3YUxqQ1RDai9uekkvM1FpT0FWOFJ2ektP?=
 =?utf-8?B?aG5QVFFNM1NlOFR6N01qcExNYnYyaytwM2xPZDkwNnluRG1nczA3QUJjaVp0?=
 =?utf-8?B?SmQ1K2xnK1BpM3orTHhocmxMMDlNTGkybEVjVnNNRVdQeXBiUUpCdVlmOE9w?=
 =?utf-8?B?ZmZjcWNNY2hKRS8vWVNGN2VhN0duZC9hcVRsTUtsQTgrYTVJUEhyc09ySzZR?=
 =?utf-8?B?NjRMRUxIbVVjWlJIRFNTSndvcVFLOFdQcmo0aWZnVHlKRTNseFZpZXMrOWlD?=
 =?utf-8?B?aHNNZnJNMlFzdzFNVHFPZ3o4OWpGZE5CYjU4bWNGK1ZMUk5ES3VxQ3U4bXZj?=
 =?utf-8?B?Y0d1dE54WDN0LzNxM2pkZ21NdmtiL3RrWThYMXJPQ3d6MldZVHRUMWQrQS82?=
 =?utf-8?B?Q0dqK3haQXlwZEVEVGlKNDY2bkNKSGYyV2RzeCtIVFpQZ0FuZ3NVY3dBZVVR?=
 =?utf-8?B?cUlvNnM3ZngxNUpaMDVkdTh2MC9rUXVuaHNaUUZPZUx3VSs5MWIrVjZJRzVn?=
 =?utf-8?B?bHQxeVk2NVM3WWdmMjBPcCtHenQ4Zm14NU5Ecmg3eDdhMlc2TUtOa082UTRn?=
 =?utf-8?B?eDFHZGRmWS9QZGxRRkp2V1JycWJPUTVYZ09ISExJTXhuVXlzSlhxcWV3M1Qv?=
 =?utf-8?B?TVZIclFEa01mU3JPZTRWS2NvK3RwWmdwS3N2MWdkQnJTQ3ZNV0xUM1VrdzZr?=
 =?utf-8?B?aGdPcGpxYjE1QmdpVEF6RjBQSnIxa0VDeFJmemtKckVVRXFGWEppWUtGZkor?=
 =?utf-8?B?MFBLeUpKQlllNktPK1pCQW5tdjIyZ2NabXVxcUJFUzI4amZiWFlkRjZRTTli?=
 =?utf-8?B?UFpFc01qb05xRTMzd05uOXVLbGtvVTdodnRyZUVBN0xJRXNieWVXUnpSOFlP?=
 =?utf-8?B?dnpJVkNqWGdEbVpMSGlDdVFSd245R29TOWpycDlIYkdyWDBCY0tNODB2Y2dH?=
 =?utf-8?B?RlVXVDRZUDNwd3htbWxpMnJ4SWUvSjdkUGdtdDJZUlB6VnZ1d2tQdWVobWpZ?=
 =?utf-8?B?ZlpQc0M2K1g3QTJ4SHdJRFQzK0xlTWhJdlZSNXpzWU42YUVON0xkbUp4ODkz?=
 =?utf-8?B?djgwMmJFbzczcWszbDVMc0tKZnhJdWpIQlZxdThMbHE2Y1piRlZZcDRyOUpl?=
 =?utf-8?B?TTREUGFPWU52aHZyd3R5WE9IeXc5Y3pxaEVHL0hmck1QY3FXRU90QktJUVJp?=
 =?utf-8?B?L3hjeEJQRVlncGJwcUJOaGVKR2V5cmhBWHc3Rm5QcGgxODFlNFZPa01UVHFF?=
 =?utf-8?B?K2JCbEludGJXdkVSbU95Wkt1UlFFSVVlcTFValBOSVQvaTRuSE5ramc3WDNy?=
 =?utf-8?B?UkNZNG9jaDRXdVJ5ZFFMdEhpZ2k4bThaK1FITUZpdmxnKzJETVlVbXRiNmtp?=
 =?utf-8?B?aEpVSXJ6dkwwcEN2RGxYNkVHSFBWL29TYlRyWHllUTVKbG9CdEppVVdkMzZt?=
 =?utf-8?B?STJUS3IwVHEvTzEwd0hZK2dKN2VielNCS1FVckZvOERxY2xRNjN1VDFISStM?=
 =?utf-8?B?d2hHRjNIQ21heGJiOVcvdXcweHl5ekk4RlNXbWFmNFVIY3NKLzhjNmwrT0Vv?=
 =?utf-8?B?aHc4bVJGY0t0NDZGaVIxOEw5VEwxYkRJTnFUWC9GMmtKNDJJRmFxMjdBQ1Vu?=
 =?utf-8?B?OUVXVHZJaDc2djBCNnhqSk12WmY3TTRQeS93Z3BKZnZTQm5ESndhdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 038aeda9-7b23-47e4-c45f-08ded8ffa2d3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:36:00.4449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myN29ce2AkXNCnK+Fg4BD+V6FNVS6AGajndabvUrEkr1Ojh7LR/tOP5fc7Ze58InkCZ/0LWe+VgkLHIthK+btCqvkrroqBnQvieHpM+20MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9290
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

Hi Casey,

Thanks for the prompt answer!

On 7/3/26 2:27 PM, Casey Connolly wrote:
> Hi Quentin,
> 
> On 7/2/26 20:27, Quentin Schulz wrote:
>> The args support for the sysreset uclass contains a logic bug. The first
>> sysreset device implementing the request_arg callback will consume the
>> args, not support the specified arg and thus return -EPROTONOSUPPORT
>> which will stop the iteration over all sysreset devices.
>>
>> This is an issue if one has multiple sysreset devices and each with
>> support for different (valid) args. If a sysreset device implements a
>> -dummy argument and another -foo and one calls reset -dummy on the
>> U-Boot CLI, it'll depend on which sysreset device will be attempted
>> first. If it is the one implementing -foo, it'll return it doesn't
>> support the argument with -EPROTONOSUPPORT in which case the device
>> implementing -dummy will never be attempted and instead we'll do a cold
>> reset which is very likely not what's expected.
>>
>> I suggest to either add an additional return code for the case where the
>> sysreset device knows it isn't supposed to handle this argument because
>> it isn't among the ones it supports, and thus we try other sysreset
>> devices until we find one that says it tried and either is in progress
>> or couldn't realize the request, or no sysreset device supports this
>> argument and we end up doing a cold reset (but should we even try to do
>> a cold reset if the type of reset requested by the user isn't
>> supported?). Or just don't try piggy-backing on the reset command and
>> have a new command instead?
>>
>> Maybe I misunderstood something or misread the code, so please correct
>> me if I'm wrong.
>>
>> We've tried bringing up this issue multiple times over the last
>> month[1][2][3] but it seems like we're left on read. This is the last
>> resort to get attention on this patches, hopefully we don't have to get
>> through a revert a few days before the release though there is only two
>> working days left before the release. Sending a revert as requested by
>> Tom[4].
> 
> I'm so sorry I missed this feedback. That really isn't great.
> 

It happens, I'm glad you see it now :)

> I'm with you that this is a pretty fundamental issue with the 
> implementation here and I think the best course of action is to revert 
> it and come up with a more suitable approach that isn't so open to 
> trivial logic bugs like this, likely with some deeper refactoring of 
> sysreset/reboot-mode code in U-Boot.
> 
> In hindsight I think I should have pushed back harder on this 
> implementation, this is something I'll be more cautious of in the future.
> 

Just to be clear I wasn't trying to shame anyone here, contributor, 
reviewer or maintainer. Mistakes happen.

> Acked-by: Casey Connolly <casey.connolly@linaro.org>
> 
> I don't have a chance today to test this today as I'm OOO but if it 
> doesn't break other platforms then it ought to be fine on Qualcomm too, 
> maybe Neil can give it a spin on 8650.
> 
> Tom: feel free to pick this up if you're happy with it.
> 

Varada sent a series trying to fix the logic, c.f. 
https://lore.kernel.org/u-boot/d7e003b3-e693-4579-8e3a-b09ce9f78d10@cherry.de/T/#mf098752c30cd6a6c8e7700f61cd54cbc8f307d6d. 
But if you feel like we should start from a clean slate again instead 
then we can revert this now and take the time to implement this 
differently for next release. I think your feedback on what to do next 
is important here. But I appreciate you're OOO so we'll do without if 
you don't have time :)

Thanks,
Quentin
