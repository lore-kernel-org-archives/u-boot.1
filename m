Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAA4C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 03:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA5F040695;
	Mon, 17 Aug 2026 03:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BqNvCz8mAeKC; Mon, 17 Aug 2026 03:30:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DC914068C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786937406;
	bh=z/RTecWKbIF6bpKCWeS0ua9CB7A7ix8LA+l7I/d/7VE=;
	h=Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=G4q4I3b5R9r4NxbqLsk/zLKdv/Aoslaoto4MlaktaTUM9CBXBWSEVEqvQFAFSYbEj
	 F7BYhGStOoyftoVR8cf9EDT71YE9WtXQM/ZSaHD1FsOdEEbRvsCv7h/l9ZleJsOHQ3
	 LrqH/Hbgmz/SGf2uyTaHkV9v30+zBuRTpeW9mD10KGLr67UYkN4Wqwdoox7EA4OLgz
	 APlLUPUmkRvl33RKG5P+XtE45CZDcq5hyM+bBsN9qozoykvSH7bF4jUhCCyRVRviNe
	 64dpLI3aA05cV3Gdl4GkkY9p3OUuv3RLGsHbhOjFUOG48Io0c/9w67OrTOquuiZ3zw
	 tSpCKqOtJa/Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DC914068C;
	Mon, 17 Aug 2026 03:30:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 997E9336
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 03:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F4C360632
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 03:30:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8BV3lg0NAIPC for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 03:30:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=tien.fong.chee@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 530E560611
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 530E560611
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 530E560611
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 03:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJ3YUUmGndPNEAC3iiTGgMP4ZoYpc324BjYtvTNv5Z48K0PcTCFxEOx3DYQsgtv6/j4pGP1DooZSXh69tD7KW9YFTFlDHmhqqzPAT08fzraTBLlCahzFAXGZdGzzCfV72o6noE6T/QaeKI7akh6I4uzXSk/j/HzpGAJ8fIHXpOrLd5ZwVa20cYruMEBSBdRgDUVK6drZpybM+R+dayoZB1ERWKkTniie+Yy2kUzBbK2l1aV2mpUE05vWRhhylWbKsWaDFxp+Y3ehCsSrrKU1hzo8x5pAYm2boNLIF9yh5xlWNhxB03zMllzTBDAm9b2wZ4dZM46h+Eodi0w+49rsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/RTecWKbIF6bpKCWeS0ua9CB7A7ix8LA+l7I/d/7VE=;
 b=GZpGfkediXbPPhB2MwvVQDc3N6Vhqbuiv2gLno+WKFE2fs5tYQCjDr9QVTOiMNKGj1lWzDK18yfgxQF/89BaVOwa1CkujzKXb8o9UoYHm1U4yF94ZEIM/xbtb2T5R/FCAcm9sEMaOeqMfurDHAcreF5jBZGaJJKZu0p01h/0ySoYyZ2G3n8uaqydlMwdy8tC5wx902vfJOy5/4dtEJYgkfFgbf717g/+J5tovoAkxwzOnFalanRQfvokDy5sV8N41/7RvqDbkALF9NgAn43YrhFn9OO5XjAA4v4+lYPR1CN06IOAoZpXkZ04SXpEpSsX1AD+3l9KVXQirOqmZCnyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from SA3PR03MB8229.namprd03.prod.outlook.com (2603:10b6:806:465::17)
 by PH0PR03MB6623.namprd03.prod.outlook.com (2603:10b6:510:b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 03:29:59 +0000
Received: from SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97]) by SA3PR03MB8229.namprd03.prod.outlook.com
 ([fe80::2802:a21d:f4ad:97%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 03:29:58 +0000
Message-ID: <cfa5d305-908e-4ab5-8725-47f287fb5e54@altera.com>
Date: Mon, 17 Aug 2026 11:29:50 +0800
User-Agent: Mozilla Thunderbird
Subject: [GIT PULL] SoCFPGA updates for next (2026-08-17)
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>, Brian Sune <briansune@gmail.com>,
 Tze Yee Ng <tzeyee.ng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:990:5::12) To SA3PR03MB8229.namprd03.prod.outlook.com
 (2603:10b6:806:465::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB8229:EE_|PH0PR03MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e3f053-b3d4-4e96-ce33-08defc0fd07a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|55112099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: JCO/2HTAp0qF8mhEKpEFBGz8yqf4/xaWSR9rGUtgg71iOiOGcyzNtmOjxos+4b9qmuTRsOO3/sbs+aXEdZjyqVoIWyMOgTN/q0JF44LFuSWk9PAn83AB7nh5ILdilmLllVOK2Kn4VIrdfUGxHrIYrPrdMSYwI8qNLGeVkuPC7b3/2bIdVJtYafkjXGY8mB1pik8lEcmGgh5hOWsox0Ab1D/dCpkAqrFT7FN3AzpZ+bOLBLLeKXFxG6jq5sYXIEnPfKfnPA13bngexCfLtMOVFY6nplvU+oHw/d59MYWswmO586RbN7Zt+feKgnZhfUvd2j4J5PNBXNyn2W+CXHIaNE1zG63mwUknrles4h0b8c1W8T9pth4UE2TYspdjz6HzuBy9xfKdFje6Ipu+Spb97AHCTaVDiR3ve1/i0zVS9GELtLS0Ed4AeDm+3Z6AwuOFSCfvXY4DeyoylPteUFfUeQ77LKVpgaI/Tj0A+JvEnwlwu8aebAsHp0roZZANibLL9UrjZYf/sEC7sOS5am3buy3eerXwcF7d94/25JrhedP80GoxFcLdGZMKdi5gbOvHvNCSA9I66PjhFCWzZ4VfOsTyYHBkFJLEmSvR6f/hT1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB8229.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(55112099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW5kNlViOXFqbGJqVXBRYVVkaTJFb1hLVUZ1aGdiYis2aHZ5eitMOXBiTkln?=
 =?utf-8?B?V2U5R1NqQTc0WmJvOGZiUjVzTElIVHJZRTd0Y0lHMExwWGZENHNVK3k5akZP?=
 =?utf-8?B?OGdCa090aDdDOExlSUtXRitkcFRweWNXNEZseWJuNE41aEZjQ2Q3MjUraHN2?=
 =?utf-8?B?U3VjcG1VZjZUVml3L1lURFphamxscEEwYUxpZEd3ajU2cERPSi9KdUs0QnFO?=
 =?utf-8?B?a2FnZ1pGSktWaTFRTzRKbzZHbktWRjMyWFliZEFXUTRKUURvYnh4TW9MTVJS?=
 =?utf-8?B?NGl1QjZVL1RHSDFZS0NuVHJRS1JVcDRVZU9BRXB2MnBjSlBTUWQ3a0xaMncr?=
 =?utf-8?B?Yk5uNk5kanlRTlZicEFCZGFPVVorUVZwVjlJNlU2TWQ0c2NRM213dEw0VXNR?=
 =?utf-8?B?Y09sdmEwc01FcVlZUDBBVlNKaUtkSStVVGcxK0dwQmRWUXk4MUJpaEs4Z1Za?=
 =?utf-8?B?K2NJODA2Q041Wk9Cemg5b2tjRzhJenRPMjNEeEo1RzMrUmMvbHFldHdrSnZz?=
 =?utf-8?B?ams2QWlyZlBiTmpqbENkRmoxTE54UzhnenVtR0RSSHFWdGpYREgvV05PUG4v?=
 =?utf-8?B?WXc4REMvdk9MRWsvTzNDQUUwdFBmRStTaFpwMEkwNTEyamExNlFicDNrWXRE?=
 =?utf-8?B?ajh4V1E0K0lYeFlWeWlsdlpmK2NMWCtWVzI2VzZNbHk2QVRNZTBBSytHZXJK?=
 =?utf-8?B?OWo5MXcxWGRLbnUwWTNnTktpSkN4MHZra3Q2Tk5WT2JGRjRKbmRaWURmRXZI?=
 =?utf-8?B?YURZVnE1V1lIdG1kQ1hPMG54Qk5VakVrc1lqYWcvZTNlTXFKWVIzTjlGdjBl?=
 =?utf-8?B?VDkyemxWSDAyRG9qcjNwUEF3V2FTcUZSdEwzeHhySS9IWmduRGhPZTRCUWFa?=
 =?utf-8?B?SUJSaGZmTFlRQjB6THRUVUdEM3UxbWdBOFV2Z0JlcGpuNDRtbUJjR29QMDZF?=
 =?utf-8?B?QmJaSlBpM2lBczFqZ09pYzlCZkpQTWhuUjdBQTB4RG5hYWpXcXUvSUdFejBl?=
 =?utf-8?B?VWtCSDl5MjNOUExUV0g4bmFGazdJMTdzUi8rM1ZKOTQ0cnZsL3pxd3AvMGtz?=
 =?utf-8?B?bnB6eUM3UFdlaWVYdEowbWVXZFlUVXFZWEY3eFE1dmprZzFOSjJSM2RRcFRw?=
 =?utf-8?B?R012ZTRJUVZQL1hENDVzWFNXMWczcWNlWURzc0lWQkF3VndkL1FtRFE5VTdJ?=
 =?utf-8?B?R0lVYVNCTzBMWmtMays3UzgrM2l3aERhQXdVS2JOM2xEdXJrSjF1bml3SVRX?=
 =?utf-8?B?Qndheks5dzBtOEdXNUczQVR2TVpXRmpoOGw0Z05hL1JqTklVKzNqeXM2WHNL?=
 =?utf-8?B?OHhyY0txb3VBVFg1OTBoR1JjeFZFM092dGc4d3J2WGNMbUpMMElFeTdOQ1o1?=
 =?utf-8?B?U0tMbzdEdUJYYkRJK3R5akdyOVQ4NnZJWXJUYVZmZjBoK2d2dTRtSnFVbUtD?=
 =?utf-8?B?U3pGZTVpRDU4VEdDb3ppUzFXTGxTQVk3WE1wbmF5N1ZBYlBPSHVzWUtrbVQv?=
 =?utf-8?B?dlYzQ0VSMklCcWRqZ1R4TjVQSU1OTTZ4WVVabzAvdjE5VVk5Rm8raVFJd2Nl?=
 =?utf-8?B?SWFRcEVMWStYV1gvWm1nQTlKdUlydW1UMnh5c2ZIRHdxWktXNGZUSGp3UU9L?=
 =?utf-8?B?Y0lGUTJONkJFckQzdG9qRWJvVk1jS1ArVURZaERiNm4rdHNvaVdMMGRJRjRH?=
 =?utf-8?B?a1dvVHRzMEVaQ3F2QVgrc2lNWHRIOHpiQWhPVnVUSjlnNVlweUJOelg5VUpv?=
 =?utf-8?B?UUhYWkdzMVp5Q2VndDBFTFh0YkxkNkFkUUh0eElMZW84VzgxWFU2ZmNMNGZZ?=
 =?utf-8?B?b1A1MEJoR3Z5NkNVbEQwUkREUi94M05NenN4by9UditTYlJCK0dEWjNlbkF6?=
 =?utf-8?B?Y3Zvb3FNb0ExcWpYbm5pMWN2REh6TGZXVkh6UkZ2bWNLRGw3WlNLWi9MQkRp?=
 =?utf-8?B?aHpRTkFnZ2dFZm4xZ0p1L1NwN2FrNHVzOU96TWZpZ09RTi9OOUxFN3ZpV05E?=
 =?utf-8?B?SVZrd2pBUzA0RXJrVUV3NGlrWXBXRHczNHJGbEozdURWQWR5U2tNTmo5eVIw?=
 =?utf-8?B?Tk85WnpTckxGWDF1MXZzMEVlclh6S0hObzRVanFIU3M1SnA2cTEwa0NyRDMv?=
 =?utf-8?B?SVVyK3BQVkRMcW9hZ1dUK1FWRUpFQjh6NFRHRVdyaXhQYmQza2pnOWZIeCtC?=
 =?utf-8?B?MFVxSG9LY2RMUFQ4T1kzaXlGd0p4THlqSXU3L3VBVFlxQ01VeDYvYnQvVW5G?=
 =?utf-8?B?dmlKWG1OcGJFdi8rclY3OFVVbVVJSmo5am1RRGJaV0JBenhNanZvNHBGZHBR?=
 =?utf-8?B?VTRLUW9aaGZzMzZmZ1k1cVh1SVI5TjB1RTJ5amVlNmdFbGJ4ZjJxdzNjYUlt?=
 =?utf-8?Q?e/3K01OnyiG2Ovpk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e3f053-b3d4-4e96-ce33-08defc0fd07a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB8229.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 03:29:58.8342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtKLAPgBm1h963aPl4Tsx6lkLg8AJvA9Ad01Rs7+fCznYPQjOIDa0lLORaXUH50kh67u9kpc21TVlcrjX+LieVPlcdA5HsnILE2/NTcNBBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6623
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "Chee, Tien Fong via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

Please pull the following SoCFPGA updates for next.

The following changes since commit 527115ef6783cec49e5610c523c124b399011361:

   pylibfdt: Replace removed SWIG Python 2 compatibility macros 
(2026-08-13 10:12:41 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-socfpga.git 
tags/u-boot-socfpga-next-20260817

for you to fetch changes up to 96ba02bb50016fe70d2fb087d7698c56793f7d46:

   arm: socfpga: Improve handoff prepare on SoCFPGA (2026-07-29 00:36:13 
+0800)

----------------------------------------------------------------
Alif Zakuan Yuslaimi (23):
       arch: arm: dts: stratix10: Switch to using upstream Linux DT config
       configs: stratix10: Combine defconfig for all boot flashes
       arm: socfpga: Move firmware register settings from source code to 
device tree
       arm: socfpga: Update Stratix10 SPL data save and restore 
implementation
       arm: socfpga: s10: Enable system manager driver for Stratix10
       ddr: altera: soc64: Add secure region support for ATF flow
       clk: s10: Refactor S10 clock driver
       mmc: socfpga_dw_mmc: Exclude S10 from legacy clkmgr address retrieval
       spl: s10: Enhance watchdog support in SPL for Stratix 10
       arm: socfpga: Consolidate dram_bank_mmu_setup()
       ddr: altera: gen5: Add DRAM size checking
       ddr: socfpga: Implement ECC DRAM scrubbing support for both 
Gen5/Arria10
       ddr: altera: arria10: Fix incorrect address for mpu1
       arch: arm: dts: agilex5: Enable autostart on watchdog0 only
       ddr: altera: Add delay before writing to MBRDADDR register
       clk: altera: agilex: Update sync to async mode config in clk pll
       arm: dts: agilex5: Set DTB filename and kernel node removal for 
non-secure boot
       configs: arria10: Enable random MAC address
       arm: dts: socfpga: agilex: Add eMMC device tree source file
       arch: arm: dts: agilex: Disable gmac2 node for Agilex7M
       drivers: clk: n5x: Add support for enable/disable API
       arm: dts: soc64: Remove kernel node from binman for non-VAB flow
       arm: socfpga: n5x: Enable system manager driver for N5X

Boon Khai Ng (1):
       configs: Enable CONFIG_WDT configurations for cyclone5

Brian Sune (2):
       Fix old TARGET naming to ARCH for PL330
       arm: socfpga: Improve handoff prepare on SoCFPGA

Chen Huei Lok (8):
       configs: socfpga: n5x: consolidate ATF defconfig and simplify VAB
       arm: dts: socfpga: n5x: update GMAC nodes and DT register settings
       configs: socfpga: n5x: enable CMD_MTD
       configs: socfpga: n5x: enable ISSI QSPI
       arm: socfpga: n5x: switch firewall setup to driver model
       arch: arm: dts: n5x: switch to using upstream Linux DT config
       arm: socfpga: n5x: update SPL data save and restore implementation
       arm: socfpga: soc64: separate reset manager into common and 
platform-family parts

Dinesh Maniyam (10):
       arch: arm: mach-socfpga: Change U-Boot mailbox client ID
       arm: socfpga: Add NAND register address and data register
       arm: arria10: Add correct mask bits for RTRIM and PU_DRV_STRG
       arm: dts: socfpga: n5x: Drop kernel node from binman
       arm: socfpga: Setting the image magic value to romcode 
initswstate register
       drivers: clk: altera: arria10: Fix wrong API used for memory free
       drivers: fpga: arria10: Remove unreachable code.
       arm: dts: socfpga_n5x_socdk: Enable watchdog0
       arm: socfpga: Remove confusing timer related words from  watchdog 
reset
       configs: socfpga: arria10: Disable  CONFIG_SPL_USE_TINY_PRINTF

Marek Vasut (1):
       MAINTAINERS: Replace Altera/SoCFPGA/Agilex with N:

Naresh Kumar Ravulapalli (1):
       arch: arm: socfpga: Fix data cache flush issue

Peng Fan (1):
       ddr: altera: Use dev_read_addr_index_ptr()

Tien Fong Chee (3):
       arm: socfpga: Gen5/A10: Enable Designware watchdog
       configs: socfpga_arria10_defconfig: Enable CONFIG_CMD_FPGA_LOADMK
       arm: socfpga: n5x: use common soc64 env settings

tzeyeeng (1):
       arm: dts: socfpga: Enable 8-bit embedded device support in 
Agilex5 eMMC device tree

  MAINTAINERS                                        |  10 +-
  arch/arm/dts/Makefile                              |   4 +-
  arch/arm/dts/socfpga_agilex-u-boot.dtsi            |   6 -
  arch/arm/dts/socfpga_agilex5.dtsi                  |   4 +
  arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi     |  10 +
  arch/arm/dts/socfpga_agilex5_socdk_emmc.dts        |   2 +-
  arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi      |  56 +-
  arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi |  16 +
  arch/arm/dts/socfpga_n5x-u-boot.dtsi               |  56 +-
  arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi         |  22 +-
  arch/arm/dts/socfpga_n5x_socdk.dts                 | 122 ----
  arch/arm/dts/socfpga_soc64_fit-u-boot.dtsi         |   2 +
  arch/arm/dts/socfpga_stratix10-u-boot.dtsi         | 313 +++++++++++
  arch/arm/dts/socfpga_stratix10.dtsi                | 430 --------------
  arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi   | 119 +++-
  arch/arm/dts/socfpga_stratix10_socdk.dts           | 143 -----
  arch/arm/mach-socfpga/Kconfig                      |  30 +-
  arch/arm/mach-socfpga/Makefile                     |  18 +-
  arch/arm/mach-socfpga/clock_manager_s10.c          | 448 ++-------------
  arch/arm/mach-socfpga/config.mk                    |  39 +-
  arch/arm/mach-socfpga/firewall.c                   | 107 ----
  arch/arm/mach-socfpga/include/mach/base_addr_a10.h |   2 +
  .../mach-socfpga/include/mach/clock_manager_s10.h  | 175 +-----
  arch/arm/mach-socfpga/include/mach/firewall.h      |  69 ---
  arch/arm/mach-socfpga/include/mach/mailbox_s10.h   |   2 +-
  .../include/mach/reset_manager_arria10.h           |   2 +-
  .../include/mach/system_manager_arria10.h          |   2 +
  arch/arm/mach-socfpga/misc.c                       |  37 +-
  arch/arm/mach-socfpga/misc_arria10.c               |  24 -
  arch/arm/mach-socfpga/qts-filter-a10.sh            |   4 +-
  arch/arm/mach-socfpga/reset_manager_arria10.c      |   4 +-
  arch/arm/mach-socfpga/reset_manager_soc64.c        |  80 +++
  ...anager_s10.c => reset_manager_soc64_families.c} |  81 +--
  arch/arm/mach-socfpga/smc_api.c                    |   4 +-
  arch/arm/mach-socfpga/spl_a10.c                    |  11 +-
  arch/arm/mach-socfpga/spl_gen5.c                   |  17 +
  arch/arm/mach-socfpga/spl_n5x.c                    |  32 +-
  arch/arm/mach-socfpga/spl_s10.c                    |  70 ++-
  board/altera/stratix10-socdk/Makefile              |   6 +
  board/altera/stratix10-socdk/socfpga.c             |  12 +
  board/intel/n5x-socdk/Makefile                     |   6 +
  board/intel/n5x-socdk/socfpga.c                    |  12 +
  cmd/Kconfig                                        |   2 +-
  configs/socfpga_agilex_defconfig                   |   2 +-
  configs/socfpga_arria10_defconfig                  |   3 +
  configs/socfpga_cyclone5_defconfig                 |   1 +
  configs/socfpga_n5x_atf_defconfig                  |  89 ---
  configs/socfpga_n5x_defconfig                      |  29 +-
  configs/socfpga_n5x_vab_defconfig                  |  90 +--
  configs/socfpga_stratix10_atf_defconfig            |  90 ---
  configs/socfpga_stratix10_defconfig                |  69 +--
  drivers/clk/altera/Makefile                        |   1 +
  drivers/clk/altera/clk-agilex.c                    |   9 -
  drivers/clk/altera/clk-arria10.c                   |   7 +-
  drivers/clk/altera/clk-n5x.c                       | 129 +++++
  drivers/clk/altera/clk-n5x.h                       |  19 +
  drivers/clk/altera/clk-s10.c                       | 616 
+++++++++++++++++++++
  drivers/clk/altera/clk-s10.h                       | 203 +++++++
  drivers/ddr/altera/Makefile                        |   4 +-
  drivers/ddr/altera/sdram_arria10.c                 |  32 +-
  drivers/ddr/altera/sdram_gen5.c                    |  64 ++-
  drivers/ddr/altera/sdram_s10.c                     |  60 +-
  drivers/ddr/altera/sdram_soc32.c                   |  85 +++
  drivers/ddr/altera/sdram_soc32.h                   |  15 +
  drivers/ddr/altera/uibssm_mailbox.c                |   2 +
  drivers/fpga/socfpga_arria10.c                     |   2 -
  drivers/mmc/socfpga_dw_mmc.c                       |   6 +-
  dts/upstream/src/arm64/intel/socfpga_n5x_socdk.dts |   4 +
  include/configs/socfpga_n5x_socdk.h                |  33 --
  69 files changed, 2161 insertions(+), 2114 deletions(-)
  create mode 100644 arch/arm/dts/socfpga_agilex_socdk_emmc-u-boot.dtsi
  delete mode 100644 arch/arm/dts/socfpga_n5x_socdk.dts
  delete mode 100644 arch/arm/dts/socfpga_stratix10.dtsi
  delete mode 100644 arch/arm/dts/socfpga_stratix10_socdk.dts
  delete mode 100644 arch/arm/mach-socfpga/firewall.c
  create mode 100644 arch/arm/mach-socfpga/reset_manager_soc64.c
  rename arch/arm/mach-socfpga/{reset_manager_s10.c => 
reset_manager_soc64_families.c} (76%)
  create mode 100644 board/altera/stratix10-socdk/Makefile
  create mode 100644 board/altera/stratix10-socdk/socfpga.c
  create mode 100644 board/intel/n5x-socdk/Makefile
  create mode 100644 board/intel/n5x-socdk/socfpga.c
  delete mode 100644 configs/socfpga_n5x_atf_defconfig
  delete mode 100644 configs/socfpga_stratix10_atf_defconfig
  create mode 100644 drivers/clk/altera/clk-s10.c
  create mode 100644 drivers/clk/altera/clk-s10.h
  create mode 100644 drivers/ddr/altera/sdram_soc32.c
  create mode 100644 drivers/ddr/altera/sdram_soc32.h

---

This pull request updates SoCFPGA platforms with Stratix 10 and N5X 
driver-model
conversions, DDR robustness fixes, Agilex5 storage and DT updates, and 
Gen5/Arria10
maintenance.

Stratix 10
Switch to the upstream Linux DT, combine boot-flash defconfigs, and move 
firmware
register settings into the device tree. Enable the system manager 
driver, refactor
the S10 clock driver, exclude S10 from legacy MMC clkmgr address lookup, and
improve SPL data save/restore and watchdog support.

N5X
Enable the system manager driver and switch firewall setup to driver model.
Adopt the upstream Linux DT, update GMAC nodes, consolidate ATF/VAB 
defconfigs,
and use common SoC64 environment settings. Enable CMD_MTD and ISSI QSPI, 
split
the reset manager into common and platform-family parts, and drop the kernel
node from binman for the non-VAB flow.

DDR and memory
Add ECC DRAM scrubbing and DRAM size checking for Gen5/Arria10, 
secure-region
support for the ATF flow, a delay before MBRDADDR writes, and a 
data-cache flush
fix. Use dev_read_addr_index_ptr() in the DDR driver.

Agilex / Agilex5
Add an Agilex eMMC device tree, enable 8-bit eMMC, restrict watchdog0 
autostart,
set DTB filename and kernel-node removal for non-secure boot, disable 
gmac2 on
Agilex7M, and update Agilex PLL sync-to-async configuration.

Gen5 / Arria10 and cleanup
Improve QTS handoff prepare isolation, fix the PL330 TARGET-to-ARCH naming,
enable DesignWare watchdog and random MAC on Arria10, and apply related
Kconfig, FPGA, clock and MAINTAINERS cleanups.

Thanks.

Best regards,
Tien Fong

