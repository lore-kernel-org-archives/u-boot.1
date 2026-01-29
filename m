Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0E4D358F5
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57BBF83DEC;
	Thu, 29 Jan 2026 11:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="P7tBP9Nh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 216E583E96; Thu, 29 Jan 2026 11:33:18 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C3CD83AEE
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5xOe0Pv7wirzkaCOnGzE8yyxgUCsCuENgPNGn3NCO/0yqhPg/6qw+EPC68QOaMGwzAiM1/UDZESHQKiD8pSOAMae5iapmwdCgJa5mPqQHpbaiu6zMIX+WvOI7duS16FMioAv94iXNkyz+9PT2XinDH8mjwL4RwXvUg5TpHIaFaZB70mLObbwqRM56WQ9KvfZD1c2LAvSgsbKfXcgxIWWRlZkCV4jiULCnqP0XmNF80bRc/9EaWPyQIzNTaVZXAFjS8cRFYUN3cbYOX9Ejk2QjD5lr+F93+YUshH5QcyKOG1BagVF/7rWiOJTJGRKguow7M3i+cIy2ixDqCkT22Ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WKEMb9RFsoDO9SEfXjbrTuFiodCn2+kT8JoeqegIAo=;
 b=KsVUmjj/kwxHegT275Jkn6+37nMaw9eAdd0+4iegNgbOaqVl/PbNN8emr9r83Zy5U2Wtw4hqkpIC3KuGL/DV2N+4tpMEVd8i/ZvGPfdVWcFf5biBMfjaLyELlt4XTi2OeEA1xe0a4fWlandSBK/HVYmUw1t5LLtgCccr94UhsLiEdGIwnME6NQbJOt/6jbdI+aOTGJSufBsdglFU5EiDt9uqUVKkRKERDBOwBUwB99XJwkHTmXa3gMmtKSf/MRsJJdlCLoyf//2hQKnC/niULnl08MJ3sopqw6eDD8ip/Ge+pXuCQbBRfR0KycEPHp0QCH6TD50lR4rzKqGJ010s8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WKEMb9RFsoDO9SEfXjbrTuFiodCn2+kT8JoeqegIAo=;
 b=P7tBP9NhtFR/Iyb5nO+jO7Be9QwZ/9upgrJD018n1TpmoQPLa7Q9mSC1KPk/44d6KiAQf5P+y/eSdA+48fKzBwqiP3w7X5jfxAsixOUaNy8jtbS2KbpZoEdJrtaMdnm4PJT1OtplXr4DtAhA8bjT4GwV7CdpIrulsev1LWqb3vzqF+gBBE6NXexqXWkPQD51ZhQP2irScXuxPQnZd6bVpZhs7HjUdk3bRuVyGgho9pCIcZXamGWWmJ8OxbHoy8BFKsvpTl5GSiLRw+cuW75xXfJLiPBhY8N7WcK9GZ9KDpTtWYL76ZkBt5KVdPrLU4I1ZKVxGAPH9twYk4j/SPbaFg==
Received: from DU7P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::13)
 by VI0PR10MB9500.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 10:33:11 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::c5) by DU7P191CA0009.outlook.office365.com
 (2603:10a6:10:54e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Thu,
 29 Jan 2026 10:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:33:10 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 29 Jan
 2026 11:34:53 +0100
Received: from [10.48.86.129] (10.48.86.129) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 29 Jan
 2026 11:33:09 +0100
Message-ID: <b8c4dee2-2086-41bd-b3f5-0f6ed91abdd0@foss.st.com>
Date: Thu, 29 Jan 2026 11:33:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] board: stm32mp2: read boot index from backup
 register
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260118104912.1672642-1-dario.binacchi@amarulasolutions.com>
 <a7a69ca4-c8aa-46cc-8745-249360a4e1ed@foss.st.com>
Content-Language: en-US
In-Reply-To: <a7a69ca4-c8aa-46cc-8745-249360a4e1ed@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.129]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|VI0PR10MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 743bd27a-950d-494c-d7fc-08de5f21ccc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXdhU2NUM0ZBVTBMZFFYdExOcnFLbVFEZXp5VmdQZUJ5dk1PTTdLMGNCTUhX?=
 =?utf-8?B?ZllIRnAwaWZGcEd6QXp6L3JCL0NCR1F0UG1hRzlsL1hicGNLUkEzeDBVRXBx?=
 =?utf-8?B?ZnlKK0NPY1M0YTNLaTVkNHpUVTUxbmVzS1FHem1sMTQ0RjJZZ2wrSDlDRWRI?=
 =?utf-8?B?SmJqSmdHYjVYNGF2dHRDaFFBcEVhSTdaZWlHU1NOV3A1QjVVZ1VGZjRSRjBM?=
 =?utf-8?B?L21GTXhtVTdRc2dqWTAzcjY3WnRzTjl5dDA2RVJwdlUybXVKV2dtVWxJalhP?=
 =?utf-8?B?RDJzNVRoRGVxdnpOOWJ0K0dyVi91SGpTakRtS1RVaTJvd0FPMHdMZkhLUGNQ?=
 =?utf-8?B?RFhXdC9iVk9QcFhFVGx4dWNBM2ZWNEVwNVBNRmlQbERSZ2VJZVkybkl3aEFH?=
 =?utf-8?B?MWkzMEZ1OEFsU0lWbVUzMDhJZkV2L1V3TG9XZHoyV3JYTm5tVlY4TjhaZUYz?=
 =?utf-8?B?WUlHZ29pZy9Lcng4RFhWMlB2MFNuc1dMMndvWUlsUDZmUlpURXFxalp3Vmxs?=
 =?utf-8?B?Y0pRWmdpb3JSRmRVR0tLcHk4bVpoYjlPOTlQN1ZMbVltZ0FSeEFIOFh2T1Q2?=
 =?utf-8?B?WDJrbVVTSFdCd1IvNCt4QzJkTFp4aUt3MGxJZ2hqZm1LU040UEpWSEdMOG8v?=
 =?utf-8?B?R1dVbmpLYjZIWlhoVXdGRW9KU3NKSkoyZ2FtN240NUxzNlVlTThMTzBOdlRE?=
 =?utf-8?B?ditiVlNNd3FVVkNLSmpoOFJ2T2x4NmVKVUlvQlJQdVJXWEh0VmVXbEtQdDJp?=
 =?utf-8?B?dGkybGFHSWx6R1RBWW1vTmlleUxuellXL2NHL3RjR1JJczJ0QmVCL3ovWUZS?=
 =?utf-8?B?M1p4ZXJzTTQ4aUtCb3NueEVkMldYK1NiejNKQTJLcEdzbVN5UGV4ZkcrR1ll?=
 =?utf-8?B?VHMreGJIZTQvbVd1V1d0MjRuUmNscFl6L3h4UXd5ZGtpYWt3Y2tjbFBRd0FZ?=
 =?utf-8?B?N29HZ3FQSXV3K0doaXhlLzhmWWwvOE4xamdoT0M1TWs0VWlvVGkvR3hnRWVM?=
 =?utf-8?B?a0dXaGt3Ymw4bUdQMENhbkt3M0NRWnZ3dXVSWVZmQzBLOHdualFsbUFjZTVm?=
 =?utf-8?B?WG5JVStwY0tFdkVFbk1HcngvenlFU213Nm4zVDB5TDdjcWwwUW5OSm1XVmcw?=
 =?utf-8?B?YWN1ZEFYWUR3bXJkWWJYeFB1UVpQalYvMjJXa0lDYWJUNG9aQXF3MjVETTdF?=
 =?utf-8?B?NGFnYVY5Zm50UnJPS3l2UndVL1JRRGRCM255NlZiQzRMMjl3SWtTQmNpMWZz?=
 =?utf-8?B?L3djQUZEQjRRMVRldTZwK3huTmpURlU1QU5MK280Z1JyMnlkRXQ3MWJtaFlW?=
 =?utf-8?B?dXpsMEg2T0JUR1BxQ25aNG5UbHc2RU1QOFJEZVR3bTVValNvUEVYb25Ud0po?=
 =?utf-8?B?WCt2a2FLOUI2UGJpM2hWZGMxcGFhaWZIVWpINWJoMXJwZlZpUURVclRIdjNR?=
 =?utf-8?B?eW5zMmZGZ1hoQWNPcWJuUStWQnhVSnJHMFBBZktGN1pVUGxBRThyeTdncUEx?=
 =?utf-8?B?KzRxc0hYT1c1aDBnZmlBbEZsMXdBWXlSMUlyUXFVUVNCS0lYMVpzWGhzSnJk?=
 =?utf-8?B?VEREeWJVL1hwYktzbS9pakpONXZLK1hQd0JndzRwUjl0WEphNFFydTBHVzJ3?=
 =?utf-8?B?NmFDNm42UkdLcFhXaWtyUG1RNTl0eXh0M3IyYWFHVm9hbUdLamQxV2trUFY5?=
 =?utf-8?B?dVNTQmxBekdnRWViTmpMOHhXNHRPOUh3UlIxQVhNanJyN1dOdjJLd3hHUElJ?=
 =?utf-8?B?dDJQUFVHaFZjTEV1QUxPQ3ZlTlZ6OHdsZTR3OE5qSEk1L2psZTBGK0VRUFZj?=
 =?utf-8?B?RzhnRWpmclZPQU1la0lkSFJPaVlDMnF6QUQzOHZlYVFNc0NsRnhTa2I2d0or?=
 =?utf-8?B?NEx5dDFWem4vQVU3b1F0UlFMVml4N2VKcVBMcWlCVHpkbEUyajZYbmlLR0tp?=
 =?utf-8?B?OGRXeTJBQ2RTWFRDdGR2cVRsMmRMY2s1MW8veXhuTFJpYzM1bHJQOWNxQjRa?=
 =?utf-8?B?MG9oSWxKRzU2ZXU4RDFqY3BzeXJmR0ZJY1NSaUhaK1BnTUhjcWZ2QStQUUhD?=
 =?utf-8?B?akxUbDIyRWhrS2VvRHRSaXFvSThPZll6cFVva3NKUmRSeFE5N0NHOElJZmdq?=
 =?utf-8?B?ZmZielpaUVBmR1FwQWhCWlpldWN2Tmp5enNsUG9oRDROZTFlbGVUdEQ3Nk5a?=
 =?utf-8?B?MDgrd0ZSQ2hpN0tyUlJYaE1hR25lZTRyWkYvMVlGWnBzaS9uUSt5VzdnYlNN?=
 =?utf-8?B?Z0txWlA4cTkzTDRtQ2E2MnZxZFhnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vYG8YKK8/3WQgfq/p9ri5WGRwDVnwlaeLJ5+9q+2J81q8bUqjCEJ0hH1gT31nltJMAU7uVevNqzJFPs3OmAGYolTg9EJ24E9dcAxiIzqBLvMjXf9fcF3Uf+SMBsK1ixtG4SUJJnOJv8mlF/+5+18VoBx1ELTeLczx3zyy1zHwsjjb2QkeHoJRekKLbuQwzJhr32KI+xp1PB6M3h7bnQGgktRdnM3Ms9tHDLelXxdZNWUjb5F18N0Kq8eCwYiXMrARzzL6x6zWZAC+0AggKIFbwyd2DTKVSvT78mVcn9ePLMFzNl4M6wMfR0CeLQWGBxNc1nTcxBrNwnGYn1WpQV2VVXHHjJo+RFzy7QAg21jrS5ggYL7vWZqUIbbx/oD35DXQRDgNw7MZ3vmaEhLtXfoCuFHAOv4kq5pPDTXnDWnyAQU4QIPhjjfe2o8INq7i933Da4Drw0qtutDX+2X/aOP+LyKnGQPXFxW6hVIQ0V7RPvb+GwGJio4P6UmB89ONPPCCmQmAIn8R7GcXeT6N8AUKkxx0a62KgL4VVg1GdEl+sOxp/q5mbnQJdkTyOxeZv01/Dvpiuviq2Hk3f5QSpseaXLXfgResFVogjj95UMDI+gPJlFzCmvm+YFrHbwttv9tjyHuF8sKOMA3AdSTfiOV/RMGvvrkeC7BMlWtHIOQzRGfrZm6X65zXcnR0ZmQHNZF5I2JbPMQdMlSVB1SVzlVhg==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:33:10.5793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743bd27a-950d-494c-d7fc-08de5f21ccc0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9500
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



On 1/19/26 09:38, Patrice CHOTARD wrote:
> 
> 
> On 1/18/26 11:48, Dario Binacchi wrote:
>> Following the commit 95b5a7de30f6 (“FWU: STM32MP1: Add support to read
>> boot index from backup register”), this patch enables reading the boot
>> index from backup registers on STM32MP2 platforms.
>>
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>
>> ---
>>
>>  arch/arm/mach-stm32mp/include/mach/stm32.h |  4 ++++
>>  board/st/stm32mp2/stm32mp2.c               | 21 +++++++++++++++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> index 2bf50c755cbd..90f06a052d3f 100644
>> --- a/arch/arm/mach-stm32mp/include/mach/stm32.h
>> +++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
>> @@ -188,8 +188,12 @@ enum forced_boot_mode {
>>  /* TAMP registers x = 0 to 127 : hardcoded description, waiting NVMEM node in DT */
>>  #define TAMP_BACKUP_REGISTER(x)		(STM32_TAMP_BASE + 0x100 + 4 * (x))
>>  
>> +#define TAMP_FWU_BOOT_INFO_REG		TAMP_BACKUP_REGISTER(48)
>>  /* TAMP registers zone 3 RIF 1 (RW) at 96*/
>>  #define TAMP_BOOT_CONTEXT		TAMP_BACKUP_REGISTER(96)
>> +
>> +#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
>> +#define TAMP_FWU_BOOT_IDX_OFFSET	0
>>  #endif /* defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
>>  
>>  /* offset used for BSEC driver: misc_read and misc_write */
>> diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
>> index 7bc7d2a608fd..43bc583378e6 100644
>> --- a/board/st/stm32mp2/stm32mp2.c
>> +++ b/board/st/stm32mp2/stm32mp2.c
>> @@ -188,3 +188,24 @@ void board_quiesce_devices(void)
>>  {
>>  	led_boot_off();
>>  }
>> +
>> +#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
>> +
>> +#include <fwu.h>
>> +
>> +/**
>> + * fwu_plat_get_bootidx() - Get the value of the boot index
>> + * @boot_idx: Boot index value
>> + *
>> + * Get the value of the bank(partition) from which the platform
>> + * has booted. This value is passed to U-Boot from the earlier
>> + * stage bootloader which loads and boots all the relevant
>> + * firmware images
>> + *
>> + */
>> +void fwu_plat_get_bootidx(uint *boot_idx)
>> +{
>> +	*boot_idx = (readl(TAMP_FWU_BOOT_INFO_REG) >>
>> +		    TAMP_FWU_BOOT_IDX_OFFSET) & TAMP_FWU_BOOT_IDX_MASK;
>> +}
>> +#endif /* CONFIG_FWU_MULTI_BANK_UPDATE */
> 
> Hi Dario
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
> 
Applied to u-boot-stm32/master

Thanks
Patrice
