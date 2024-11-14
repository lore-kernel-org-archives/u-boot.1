Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2A2D65C57
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 08:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A308641A;
	Thu, 14 Nov 2024 09:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rIrxGEBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384E980AE6; Thu, 14 Nov 2024 09:38:48 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1068881E7
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 09:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2CkJ6MjaM2E40THE6zwlclHmC+kof2keR93AC1x4rHv1Nb+LeoBXAWJcbbCUwNbcXvrzERlaC/cQAqUeZyxUYROxlNBrsgS3U2Kh6wJR/EGXD26zQQLMmSRvQCVqcAzlduuqXz5PHGLhfPqZGXhKIp+CfWqe5YsC7+TBqGuTWvixFvB2X3YmEpnWU3YQ0t8s39i7kYCusv3w9VjrFqATf0BNFHmQf2tLhsKSDOzDD+ZunXfbYsLbA5Z7z+c0W1LiuYRMzF3t488mQzk+gkEyqlMLzQtwGpREdBx7Wp5X00I2Gx05VDCsBkRMKSalZEfcXIDIaQMAz5klIqqUEvHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtrsNDS54WYkLNT9cVMDycs0/bz+5A84px6ml4tll8g=;
 b=JuIAEKvDkEAEuCJzx8sCy2yCM0hm54I+8fSSDQqKC2jeetdlAy7KTKSHmD4qPNU/hw6vxW60JcEnjkp0syeCDF5/pRkO27j3lkYovfF3/hBUK/zL169FueYt5Qm/rSC3WG4LmAN6D+7FSZycKVSBXT6mx3aXaizr23REasYx4WFNHS1xsODY+TPUBhXKRlq/zpqX28YYzq33KOfFOrlJUlf/JE54mdARoXfgdirg02lyyJUmFyLRbDvWzdcy4xqqinqXTJDo8dLMjTGIi9NO7b2WUAjC4NGA1ubW8/y9WxyXTsgTxL04dJ0CRzWktsCYSldIK8dObCa/anxwWCXyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtrsNDS54WYkLNT9cVMDycs0/bz+5A84px6ml4tll8g=;
 b=rIrxGEBw1aK3jA9vYjPkW9oWisefKZcVdQutS/iOo1QdguG5upD2MV23YQX04dh4eNfLWInYkTnynNRhsSiPII/aOo8/wUnfM8nBBTyD5qYLYggK2NCR+BCjbQmkkuO1VUXgkhoWsV6+vl+/MAeQ7CNZMXIJ6ovIIkom0G7i5f4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 08:38:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 08:38:41 +0000
Message-ID: <f0765203-4e47-4131-aabb-b689c6702865@amd.com>
Date: Thu, 14 Nov 2024 09:38:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1]: bootcount: zynqmp: Add bootcount API
To: Vasileios Amoiridis <vassilisamir@gmail.com>, trini@konsulko.com,
 hs@denx.de, pro@denx.de, sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
References: <20241105132744.1572759-1-vassilisamir@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241105132744.1572759-1-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0212.eurprd07.prod.outlook.com
 (2603:10a6:802:58::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: e4389ee8-6a7a-4674-9aee-08dd0487be41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHJqMmxPb3RJWk9nMjlSOVpEZDNPMlBZYlU3bkhiaFNyMFVGaCtDaXkybmJD?=
 =?utf-8?B?aW8xOFl3N1hubGxKaEZFV013SWQyYWxtbml4VGpORDNqUjNWVzBGVFFBZkZX?=
 =?utf-8?B?QTlmYnZRcmVEemRlSCsrS3lXNUFhQTF3UGlsakxrUGI5KytMbFdDMGhFSWtC?=
 =?utf-8?B?RTFOanY5MVQybmpMOHRHNlZEcmFUa212U1dnYjF6QmR1RmJtZ0RGbHNVZHdB?=
 =?utf-8?B?cE85bnR5NXp0RzZKbHB0aUdxdG9QSXZZQ2JMUHhsV1Byd05rSlNWU1FQN2p0?=
 =?utf-8?B?V1FNMzNLbkRDUEFLQlUwUmVuSHFaS1lraXE0bXE2NlE3d2NlMEg1RU12eVdy?=
 =?utf-8?B?eGFFMkE3THp1WE5YcFV6VE5DNkRQWFdMcVhla2JsZzFvdm5Udmw0Rk9xNVdW?=
 =?utf-8?B?TmxNaS9hbUsvUEtXcWN0L3RQME82Y29nbVlTUkxyOG5WVllJQWx6OVVmNmtP?=
 =?utf-8?B?eWNub2h1aitVY0xsUjg3R0cwNncwTUFHZFN4WVg1MERZV0FjQmFCUzJhb1Fk?=
 =?utf-8?B?N2RORUptM0FuVE11WHh2MzNtRGlpcU4vWGEvTjV1ZXN1Q2V1ZGFpeDdMOEFH?=
 =?utf-8?B?TUFhbWMvd0NPK2JYcDBucGVhaTJtN1hBMkVBaTE5b2lMdVk3NHNvS2NVN0Rh?=
 =?utf-8?B?Q00yT3ZNVExpZjlBYjl5TC9xV25aUmEwdVVHanQyODRmZEJlajVEb05MelIv?=
 =?utf-8?B?QUswY21mbkptcUtzYnREQjB1am13aEVpdTZ5SjRYRVdzSXdiMXRQa2ozbHlS?=
 =?utf-8?B?SmhObTIvdlpKWHZSd1Q4OVpBMjFJUnlHb2hkd0xad2U2cDZpcHBYUG90WEd0?=
 =?utf-8?B?QjhIMUtTV3RjbmkxQy9kaFJ4a2dyYnBKQWh3MDZyNXcySVZBais0M1JmU2FH?=
 =?utf-8?B?OHltMFljejVqY0hKYzBFbDZONEVKdXNwQlNlam12dkc2bEIvelMvQ0d3Skdj?=
 =?utf-8?B?KzNvQzhWZytzdjBPUjJUVlUrSHMzMkZTOVJxK09aRXVlSUcwSkROeHpaZ0lR?=
 =?utf-8?B?RVM5dWdMOXppdmhBa0RoZnI2NjBHNG5HT0g2cXhlbTlqUFJHNVZNbWVsYTFW?=
 =?utf-8?B?MERzUFk4elk2US9DTjFxZTFPSENsNWJsUnlObkxwOWR1ZEU4dGx1T0VKTUc2?=
 =?utf-8?B?VFZZUFgrekdmYmxpZmJxNkRPQ1hBWENrM2dPNkZHU212WVJvRUduVTA3cWxh?=
 =?utf-8?B?MDdCWnlib1N3TDV6dlJWcXBUdFhrUm9qNzkrTGJpeUszR1lnbzYxMzRwUFFi?=
 =?utf-8?B?azZvRHlyWmNrekkzeDJmN3BUODRHZ05QWUdIWGdmUURoMDJ5SHo4Sk91ck4w?=
 =?utf-8?B?eFNSL2xLczg1OXdNRHJCQkJnLzY5ZXF4REQvb3dwVjFFWWQ1TzdiNUs0aUkv?=
 =?utf-8?B?bEhROG92RmMyY3Q3ZFdwT3g2SlNhOUVsNlhvdUxqSGFWbWlpYjcweTZwOFJi?=
 =?utf-8?B?RWs5UVBKTEpqZHhNUkYxV2JXMFNnWWg1Q2R2a3dGMi9ybS9qSW5yUE9LTHJI?=
 =?utf-8?B?WWoraXJ5MGtkUmtlaEtnOU5Rbmk4TmMwS08vbzlUQnJURW1KRXBvWFUwR2hJ?=
 =?utf-8?B?Si9zVjcyL2gwVi9hbjNPdFN2UXhsNS9tZjEyM0ZOanBxY3JLbDVBR0xsTDk4?=
 =?utf-8?B?RFIrMlhJcmswV1ZsQ3NDUVlwL3hROTJ5ZjlRL2VqWXpUS1ZsUDhNdlJwZFhW?=
 =?utf-8?B?dExLTkF5bVFmM01TT2Q3d2JxNkl6ZWhIUHRibk9KazdtNk5DbTJPbXBxMXJR?=
 =?utf-8?Q?Evaedov/q0G/kLgSy1C7mznWVyP/DX64k23VFJ9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRacW9Ca3FlZG8xRFhsOStCTXAwbS9tWTFSaDBXSWYyL3lRK2JEZmJRVjVF?=
 =?utf-8?B?dTBQZHRjWTVRbXJRdEVxYW83RUZBL3N2UnQrK2NERm1saFVaalhyTG1QZjRE?=
 =?utf-8?B?MWVaNytvYWpiZWpVTE1OU25QRzFsN3JXemZ1bEhVTk8wRVlTM0R3SGNLa1dh?=
 =?utf-8?B?d2FRQTlWZE5JblUzVTVtcDFyTDNwS2IzVzQzYWlvTkU2YjFuQWNnWDRjWEtn?=
 =?utf-8?B?bEI0cVA0eE1VajZ4QUlEK24vTElRTmtaV2J3NHNaZ0xoNUFVMjB4TzhnUURO?=
 =?utf-8?B?V0dVcE9Mc3UvZ3NVY3ovMFNXQ3JhaUtWclhiN2I0RHFYQTlKR1YyUlhYUkhJ?=
 =?utf-8?B?WUw1RTRmWWJHQmkrSkRxenFrUldFZjhEUDB5UDZWRGcyek5XYzA0NXRBWnpu?=
 =?utf-8?B?UFZkb2RPeHU2dVdkVmpCWm1SakRtM21JNnpraEdhODB2VEN5VysweGdBaEln?=
 =?utf-8?B?REZkd28vMTBUaWJOTjRKY0YwcFIyOGtiQS9LekZHZVBGdzJYQUhZY3dDd29w?=
 =?utf-8?B?N3RyM3ZGUlFsSGtKWnpoSXNWUFV2NExlNjNKOUR5Tkw1anZuM0xJTzBTeXJS?=
 =?utf-8?B?ZnVDZDc4aXgvMS9BRkFNek9ReEFvcTlMZFJxMnNYRVp3YlFmVEpKdFZiSkRC?=
 =?utf-8?B?ZDNSbUx1aWJkdHBHM1FtaDlOYUpSVm9XZXNxcFpvd2ZxZk15ckM5RHhHVk14?=
 =?utf-8?B?bytrZTVadlFCMWxQRnUxTmtoYXFYWFFObUZIQS9KbE44VVVVT0xYSVpQMHRC?=
 =?utf-8?B?SGF2cFNYd3U1YnRieTUvcTZZVWg0dTdUSjBsQjI2dU5mRXhHWjRzNFh3Z0tt?=
 =?utf-8?B?ZnBRaStIRUd5SkJYQmpISHI2V1VLMERSc1Nod1AwNFZLWEhUclZiUkVyU3JH?=
 =?utf-8?B?TVhYRGNvSkQvMC9oMDFQNVN2Wm8vOFRFczFGZjR0R09JK2MzQUVLUWVhc1hT?=
 =?utf-8?B?MFRrWFVZZHFZK2xPZllZL04wT09HYzRIYUhxSUszd0dUNkdZSjdiZytvU2RK?=
 =?utf-8?B?WDRDdlFYY3ZYWk5JcllQM0FubnBzNzNNMVpCczVPRFJ6NW56YWJQa1paQndP?=
 =?utf-8?B?bE40ZTNBTTZLbkNhUjBsUGpldGVoNStGMFFDeURRNkhFNDJ4TWlUR2c3bnVa?=
 =?utf-8?B?Mjg0ZXVVKy8ybjRrbGhsbnJVZDNia1pqMVBNcDhDOENnNG5NWG5qcHFLOWlQ?=
 =?utf-8?B?TEZYbzBBVGVDMnFjNGJEVjlFTmpoU3VzNWFYVHpsTmZYRXAyd2N3bGhDcEJC?=
 =?utf-8?B?QnRCb2M5UGcvUFpYS0NKQnV3M3lTUUREVEY1ZUppRHhOcmUzNklPT2EzWnJt?=
 =?utf-8?B?elJqMnoxS0VVRWY1UkJobllObG9xQkhxSnQyandnTlFFcVNFeEptZkhpSTVS?=
 =?utf-8?B?Tytmd3FtOWhhd1NzLzZoVzEwNXFVSXJSSGZ2VTd5NXhMYit1WGt3WVlnOGVN?=
 =?utf-8?B?Q3Vkem9uaVBXem1QRVBpZkVtMUlMY3lWWGtic0JwaitRNmRDSDlobFFFOHdB?=
 =?utf-8?B?bEJPRHRnWHdrTmRvUlBieDRGM2J1T3NyMGRxSGs2TmZrdkhOeXFjdDltTCtl?=
 =?utf-8?B?dWxmYm9oRTdOay9GcXVjcU5BZEpGUkxSWVFjWEJZTU51Mm4vWU1idG5WOW85?=
 =?utf-8?B?N0NPbEdpUEVRMEE0RkZEQnB1dUxQWGQ1Z0o1c3l3akVGNHJXSUZaT1daWEZa?=
 =?utf-8?B?YmZLRGZVeGJxM0ZFcUUrVnF5VktyRHVxVEhUL0F0dkZ1OEM0YTJLelJxLzdP?=
 =?utf-8?B?SnkzK1JXT25NVlBIS3R5bC8rMnAwdTdvZXo2VWx1S0lLRnVHQjJoRm9yazB2?=
 =?utf-8?B?a3RpcW9PUGtOczBXZ2tnR0x5QzArYmJVRVZRMzdhVWFDQmZ5U0JTTXFNMUJa?=
 =?utf-8?B?S2tkWGFxbEFaSU9HTlV4d1hhdGNNUjRGQ2VrQ2tnc0ZBcXNqaU52MFJOTnh4?=
 =?utf-8?B?b1gzVDVuOWpCeERWWEhDU0VnWFZHUlJ4MTlkY1V3eit2Q0ZZUU5UbUNNUUhj?=
 =?utf-8?B?djljRjI5azBYV2xFOVFzWTFzWTZYSkNDWUFOeiszRk9xalhTLzc2eVJYamJK?=
 =?utf-8?B?SzN3WGpPcW4xMFQ1TGExSzg3Q3JuNGpjWWRxMWtiOUpoQXNMUktzOXVaMVdy?=
 =?utf-8?Q?Ao0oTHz1UuYHGuWBZ40a2MycE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4389ee8-6a7a-4674-9aee-08dd0487be41
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 08:38:41.8001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sEHSrd5lVNc6OAiJlFcSiFWqPPLZBPUZG9l1/V5LCawAfSLqF6hdINxvjfGQzDg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022
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



On 11/5/24 14:27, Vasileios Amoiridis wrote:
> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
> 
> Changes in v3:
> 
> 	1) Organize correctly headers
> 	2) Remove redundant "mio" and change "write" to "read"
> 	3) Add "depends on ARCH_ZYNQMP"
> 
> v2: https://lore.kernel.org/u-boot/20241105074917.546887-1-vassilisamir@gmail.com/
> v1: https://lore.kernel.org/u-boot/20241029185814.7937-1-vassilisamir@gmail.com/
> 
> Vasileios Amoiridis (1):
>    drivers: bootcount: Add ZynqMP specific bootcount support
> 
>   MAINTAINERS                                  |  1 +
>   arch/arm/mach-zynqmp/include/mach/hardware.h |  2 +
>   drivers/bootcount/Kconfig                    |  7 +++
>   drivers/bootcount/Makefile                   |  1 +
>   drivers/bootcount/bootcount_zynqmp.c         | 47 ++++++++++++++++++++
>   5 files changed, 58 insertions(+)
>   create mode 100644 drivers/bootcount/bootcount_zynqmp.c
> 
> 
> base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271

Applied.
M
