Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C401C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 04:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 819798490A;
	Tue, 30 Jun 2026 06:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PrCXOYI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBBC484987; Tue, 30 Jun 2026 06:37:13 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE07848DC
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 06:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oh4WveZQdXCo5ymjUZ2uE62L+C+WsaB8VZFiGW89DtUpE9AcjSmaVv/VOA3/XyNyWMuXNKi9MJOHsO/eL0n+plvNPWe62j0XEkIqOcLP+TRtIOGPQi2pYsSVfACSamCmNOBgeB5YK4GcBbPp6nsAEUnGmAOTgUKzeDV1PmJo9CZmtIXo8cXzXBJA+8F3oOkuQSd3DBLWPhJjnoDytmIGTHHBLoKBYbomc78RF3VsH45QXaA9+glf+ke0NTt+iWt0Js5HnukZ7SE4rZZr7MBpCR11y3upF9gLTvsE8YYJjntZv8/8BcCd7OXT9cSfpQNyf2nDiHKKwyEI4Q0krtEAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFXLoAKKqSGV+OfIqVDoGiE28hJTT7v/AjIQYMy2ZSc=;
 b=b9SjtjpcA49pod969OrCMNnsRpkyoEPgKTYBuDgEl2XOvbicmuzjihg4d3BqtB+ATTxoJm/dV+eK0PwevptCoX6YLZj107fgki1jhphMIgbmsXHCgo4yub4xHyrGNouhJllWEZ+CthohQPyRuFOEj+LqNYSaFPrkm2O3yS4jA6ZPUlGgTKTnyjGBzXmcKEV9/RhEtd+sSW9nFhPdl9AqALsMX+ICUQ/3gRNbVu+7/1OmIu1fwQo4xJfUa+V87eZdx2jhU04NAPQoBMTo8t7HG0JLIs7nAnUeiphKDfGDm87lzXV9zdnitG0DLU9QpvMcIHhYhhIdP1mQi4u1b10RXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFXLoAKKqSGV+OfIqVDoGiE28hJTT7v/AjIQYMy2ZSc=;
 b=PrCXOYI9oyKAviuBJHGYX8LctGhjY4oKmo81cQgAN1QPzHh0FPJgmT6KKJnmDt6hI9ks8G8w+ZD4RMddyWQ+Gofc8omc3idrc4wbCB8nIq/NlzizhxwZZq+fXNpdwvlsP/IZQmmucfwJrybxwKWgmfUWJMqSnIMTxa5xRi7kDm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA3PR12MB7922.namprd12.prod.outlook.com (2603:10b6:806:314::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:37:05 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 04:37:05 +0000
Message-ID: <bed15a62-5645-4ae2-a207-b65d74ecc11f@amd.com>
Date: Tue, 30 Jun 2026 06:36:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/64] drivers: usb: dwc3: sync code with Linux v6.16
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <88b37a74-6d98-4a6f-8f77-4ff5c47459c2@amd.com>
 <CAC_iWj+isM=utVFXdKY0RuQJZ9qJQe355PAd=TrCZ3YvLzVymw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <CAC_iWj+isM=utVFXdKY0RuQJZ9qJQe355PAd=TrCZ3YvLzVymw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:a03:255::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA3PR12MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb0eaf4-bd35-4161-8141-08ded6613c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|22082099003|4143699003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: f2VBI9rGj9lsaoxduo+p7jNMKw8mYjvLq7OE6a18GKj3zJZy0yOFdqBzVkzCkx8zWFWYP/0s8WN9k1iW4DO9ES4/IlnNJgfOG2ENvaZz5wRkDzw9tCXP28R0S8mo1zCA6vXQbST1tiK16XG7CYTQViduSmoA18inwltKWqmU6XthCWynUbpxdONTBwd9eG7TBK0OVdJ8ZPdDyAMtFGwQqxdt0Mri1MX2OE2nxF7A6RrQNTSlWeWH72HNsQ9EQAa59vtjHX7BT2OlJWf27R8c+pQOdlZ1C+goORKxuksK9qDi0J43Pp5264tjnJ3YYo5ikmni0YPCQf7n4CP1g3bbWKLL3edAdAe5BNCkUn8sw05Y8BRub8lWsLgOS+AKbMsiQfg0MYu578yP8ZfM2glUKFiwd3yhcfc9H4Lh0ij0m4kWxB+Q4qHrJFnTGPgYoMZsyCfHQuNSNFqBXqJGHORbL2KETQ8gEeEgaS56tB3UFD89HVvo9tm1S3IgZnMtcpUqLEfx2NGMUsvzJ8gg7b6hr2tLQrVxvYIPSfCMX08cpBH07GDoySCinMDDjpHaRSoyKSKVAUiH8IWeCh6ULhYlsOEg0myAjLHPxzcNUtkAqf5BnqXWTimDUSIhIZe/MKg9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(22082099003)(4143699003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRhZHEwNFVmd2ZGWnhyeE9IcWIrS0s1d3lKMC9uc1hGZkdudDVGcXpvQThK?=
 =?utf-8?B?RTAwb1dDaWppKytNN1UyV005MFNzWjNnaG5pSmEvNGJVVUdlam96VENiZG9n?=
 =?utf-8?B?WGo4MDFPTTBtR2dMRDREUzBKeTdWVUVWa0Vmb09ZV2U5Q1lXMFk2Y1I3djJp?=
 =?utf-8?B?cStWeGFidW92M2dha1h0YlpNQWFyNUgwVHI5WDUxVS82ZXpNaE1PN1FqODEv?=
 =?utf-8?B?N0FDTUxFTzdBeFpRdEhncVppWDdSMnRZbkVNRkR4b2wyVEdpMUJHQjhBMzB0?=
 =?utf-8?B?eTRoMlR2RklqRmdpT3BUcEUrYU95TEVjUDUzT21ia0R5M2lhSlQ5TzJxMDl2?=
 =?utf-8?B?K3RHc2VxU2FnNytYbDVjL0E1WnJGNHY1TTVVbU9OR2JIYnh0UG80Vjg2VmFB?=
 =?utf-8?B?bU1YNGlrdS9GMzlEV0RxdjY0bFVjeC85ZVhWSW5yMFc1Mmw4MlROY21KR0ho?=
 =?utf-8?B?NmNRZ0g1UmdMMVhPWkJUNUNYc3Y2THlWZEZ5QmJMdlYxOXVpZ2lwelhpWW9V?=
 =?utf-8?B?L1NhaDZoaForT09WZ0kxS2tLR2J5T1N4bENDMHRpRWFNNHlKMHJsbkNXZjVI?=
 =?utf-8?B?WEoyYWw4QkV2czUyS1c0UTZMdk1LSG5HbmRDb0p3ZjlrQ3Q4Z0JuMHU4TGxa?=
 =?utf-8?B?YWtFZWVRVFZFSTlsZE03bk82M2VCU2IwaTNYNGxsWjEzQjVzWFFWL0JhNnA5?=
 =?utf-8?B?bTJadXhKZ3dDR21WTlM1cHoxcncwbkNwVVN3SkpkMnZHeFNZMDdTQlpVT2Fv?=
 =?utf-8?B?MlFOU0JVcWdBN08yK20xamlUSm1SakdIelp6L0p1T1VsSFEyaHpjU05uNld6?=
 =?utf-8?B?Q3dvUkwyZHdWRkpIQjVDcnNENFVPT0F6WUhkVndnV0xuTXhMb0lYek96UjNs?=
 =?utf-8?B?STNpR0gvampPVlhYM2kyT0dyb2w5K3Q4VXJJVzZtbjRTV0FLeFdVTXVRTnNM?=
 =?utf-8?B?Z3drT0Z4NVl5STVTa2cwQTYzZFZNdnZOOXhxR0UybkM1RVJiSDhWQTdIUkt6?=
 =?utf-8?B?clkra2Z4MnBxMDBiVWpKT2t1L3FKWVdpSEl4aVV1RkZNbXJhZ1ZkNy9aeWJH?=
 =?utf-8?B?VmJYdnRIT2FxY3NRSHhoVGNmQVgrdmtJMUNFOW50RTJhRHpYa2ppMVNPWWw0?=
 =?utf-8?B?Yjh6MThocnFuZTNjQjlzQk44N2dDTGgyUG1SUDRmUkdrSll4SElDSmxQTHJH?=
 =?utf-8?B?Wml4aXJXMHlObWdEQWlrcTFFbUl1M1JHZndvZEhuc3Naa1BnKzlTdmdYOGRw?=
 =?utf-8?B?bm9ibkhwdFhiUnh0cHJpbnpSZWpvVlNqU3JHRnViVEdyM3ZIaERLYk5SWXBq?=
 =?utf-8?B?SStJQ3FtNEpGdXBndFVKbkc3c1dLcnRlQUxRTGVtazRlVnRPTTJ4TFd4RWtS?=
 =?utf-8?B?c0djUkNVKzAzbVFnb3paMVZVN2p3S3lmR0ROMHlKQzk3bFZabXVPY1BjaWsy?=
 =?utf-8?B?YmVjOUF2a0V1c0RVL2QrOEdOQ1E2cFZyQ2FXRWhRc3JYcVlaUkxlU005Y1Zh?=
 =?utf-8?B?c3hvbFM1c2lweHBCbjQyTVI3T0VuZFRoU0RoTUs2M2g5YkNzTTR0b3BIbEJh?=
 =?utf-8?B?Um00VmJkbm9pd1lRRmFsUnN3VEN2S3pJRUdBTEsxVTR6TFZoUHhBamxwRkd3?=
 =?utf-8?B?N2VYRjdaQlF6MFJxaUxOMXo0TFlaclg3M0swUmhTcXpQWElmT29HNUlUeTc2?=
 =?utf-8?B?ZjlsVkdwcUk3MHhJNmRoM0dNZlBjbFIzRVFpODQ4Yk5qZFE2R3NrUnNBcXRq?=
 =?utf-8?B?K2dyQWMyZ0lVYjU0UkJCR2kwQmJFck41UXR6ZzU1T0JKZzg3V0VGVitvZmhQ?=
 =?utf-8?B?aVRCUVpQY24wNHVHYVRrSlRxY2RvUzZRSm9rbnFxNWdUSnZNVFVtSjlnbXVD?=
 =?utf-8?B?RlFxczZFVlRROFl6QjFrWTNnMWdrd0tqZHBSUTZRcWR1aGJ0NTliSVhxMEZN?=
 =?utf-8?B?eElMOE1GSlpCaXZYWGFSYWFFSVVDS3lucFBDZzhhak1CNUJ3ZkI2RFJRRWlj?=
 =?utf-8?B?T1lwVHhMMEY5Z09kY2hoeHBDY25ibGR1a3MwZUFheFQvZStGN3RYRjJCdnZQ?=
 =?utf-8?B?bWFkWGdsWVY3U1lsaEJFMkZzV3dvK3B0Rm1iQStDM2p3MWtRZTNBeGZ3blNJ?=
 =?utf-8?B?SWRGUEhwaEtrdjQvd01XbWFVNzlkVmg3U2kvdHdmaWdWb0VPcnhiNm85UHox?=
 =?utf-8?B?czgzNkJ2a1pGTzJwYW9CeGlYdDNyMWNKYUd5RGRUeUx4MEhTd0U1UytuNHM5?=
 =?utf-8?B?RnBWTUV5RTV2cEFaeEIvbVNTeHJDOEVjRUtnMmpMaXorRmg5N0RteE9nNVQw?=
 =?utf-8?B?YXlmK3ZNWENiUEdvcjRuLzkza2xLK0p0ZW82SStJVVQ5czlrems1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb0eaf4-bd35-4161-8141-08ded6613c99
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:37:05.2560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGb5uX70uV7AM+E9txZ0XABOO8tZR1TRh3uh/4KBwyNP7z9C88sBb/YPYRpskNMN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7922
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



On 6/29/26 21:07, Ilias Apalodimas wrote:
> Michal
> 
> On Mon, 29 Jun 2026 at 13:53, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Hi Jens,
>>
>> On 6/29/26 10:43, Jens Wiklander wrote:
>>> Hi,
>>>
>>> This is a follow up on my last two patchsets [1] [2], where the latter only
>>> with a small change in addition to posting all the patches.
>>>
>>> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
>>> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
>>> to u-boot"). Since then, not many kernel changes have been ported back into
>>> U-Boot.
>>>
>>> This series synchronizes the DWC3 core with Linux v6.16. To provide
>>> a clear audit trail and maintain bisectability, I have structured the
>>> series as follows:
>>>
>>> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
>>>      to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
>>> 2. Milestone Imports: A sequence of 50+ commits follows, each performing
>>>      a "snapshot" import of the drivers/usb/dwc3 directory for every major
>>>      kernel version (v3.19 through v6.16).
>>> 3. U-Boot Adaptation: The final commits (based on Jerome's original work [3])
>>>      re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
>>>      required for U-Boot integration.
>>>
>>> Note that this is compile-tested only. The CI pipeline on source.denx.de
>>> was used as an OK/NOK indicator [4].
>>>
>>> These patches are also available at [5].
>>>
>>> Thanks,
>>> Jens
>>>
>>> [1] https://lore.kernel.org/u-boot/20260507092843.358908-1-jens.wiklander@linaro.org/
>>> [2] https://lore.kernel.org/u-boot/20260624123025.GA3245275@rayden/
>>> [3] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
>>> [4] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30524
>>> [5] https://github.com/jenswikl/u-boot-1/tree/poc/usb_dwc3_sync_v4
>>>
>>> v3 -> v4:
>>> - Restored obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62) for dwc3-am62.o
>>>
>>> RFC v2 -> v3:
>>> - Rebased on v2026.07-rc3
>>> - Configured out a few prints in drivers/usb/gadget/udc/udc-core.c
>>>     to make it build for am335x_evm_defconfig
>>> - Applied provided tags in [1]
>>> - Published as a branch
>>>
>>> RFC v1 -> RFC v2:
>>> - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
>>>     dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
>>>     from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
>>>
>>> Jens Wiklander (60):
>>>     usb: dwc3: restore to original v3.19-rc1 kernel import
>>>     usb: dwc3: import from kernel v3.19
>>>     usb: dwc3: import from kernel v4.0
>>>     usb: dwc3: import from kernel v4.1
>>>     usb: dwc3: import from kernel v4.2
>>>     usb: dwc3: import from kernel v4.3
>>>     usb: dwc3: import from kernel v4.4
>>>     usb: dwc3: import from kernel v4.5
>>>     usb: dwc3: import from kernel v4.6
>>>     usb: dwc3: import from kernel v4.7
>>>     usb: dwc3: import from kernel v4.8
>>>     usb: dwc3: import from kernel v4.9
>>>     usb: dwc3: import from kernel v4.10
>>>     usb: dwc3: import from kernel v4.11
>>>     usb: dwc3: import from kernel v4.12
>>>     usb: dwc3: import from kernel v4.13
>>>     usb: dwc3: import from kernel v4.14
>>>     usb: dwc3: import from kernel v4.15
>>>     usb: dwc3: import from kernel v4.16
>>>     usb: dwc3: import from kernel v4.17
>>>     usb: dwc3: import from kernel v4.18
>>>     usb: dwc3: import from kernel v4.19
>>>     usb: dwc3: import from kernel v4.20
>>>     usb: dwc3: import from kernel v5.0
>>>     usb: dwc3: import from kernel v5.1
>>>     usb: dwc3: import from kernel v5.2
>>>     usb: dwc3: import from kernel v5.3
>>>     usb: dwc3: import from kernel v5.4
>>>     usb: dwc3: import from kernel v5.5
>>>     usb: dwc3: import from kernel v5.6
>>>     usb: dwc3: import from kernel v5.7
>>>     usb: dwc3: import from kernel v5.8
>>>     usb: dwc3: import from kernel v5.9
>>>     usb: dwc3: import from kernel v5.10
>>>     usb: dwc3: import from kernel v5.11
>>>     usb: dwc3: import from kernel v5.12
>>>     usb: dwc3: import from kernel v5.13
>>>     usb: dwc3: import from kernel v5.14
>>>     usb: dwc3: import from kernel v5.15
>>>     usb: dwc3: import from kernel v5.16
>>>     usb: dwc3: import from kernel v5.17
>>>     usb: dwc3: import from kernel v5.18
>>>     usb: dwc3: import from kernel v5.19
>>>     usb: dwc3: import from kernel v6.0
>>>     usb: dwc3: import from kernel v6.1
>>>     usb: dwc3: import from kernel v6.2
>>>     usb: dwc3: import from kernel v6.3
>>>     usb: dwc3: import from kernel v6.4
>>>     usb: dwc3: import from kernel v6.5
>>>     usb: dwc3: import from kernel v6.6
>>>     usb: dwc3: import from kernel v6.7
>>>     usb: dwc3: import from kernel v6.8
>>>     usb: dwc3: import from kernel v6.9
>>>     usb: dwc3: import from kernel v6.10
>>>     usb: dwc3: import from kernel v6.11
>>>     usb: dwc3: import from kernel v6.12
>>>     usb: dwc3: import from kernel v6.13
>>>     usb: dwc3: import from kernel v6.14
>>>     usb: dwc3: import from kernel v6.15
>>>     usb: dwc3: import from kernel v6.16
>>>
>>> Jerome Forissier (4):
>>>     usb: host: re-import xhci-ext-caps.h from kernel v6.16
>>>     usb: gadget: re-import epautoconf.c from kernel v6.16
>>>     usb: udc: re-import udc-core.c from kernel v6.16
>>>     usb: fix build after resync of DWC3 with kernel v6.16
>>
>>
>> 4 patches are missing.
>>
>> b4 am -l 20260629084507.3254232-2-jens.wiklander@linaro.org
>> ...
>>     ERROR: missing [61/64]!
>>     ERROR: missing [62/64]!
>>     ERROR: missing [63/64]!
>>     ERROR: missing [64/64]!
> 
> I do see all of them in my mailbox and u-boot list is cc'ed. Haven;t
> tried b4 though

They are available now.

Thanks,
Michal
