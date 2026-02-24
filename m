Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A605E9B250
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 10:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04F4083642;
	Tue, 24 Feb 2026 11:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kKEf8d1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF9883BC9; Tue, 24 Feb 2026 11:26:19 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE0AF82BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.delaunay@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv3TkYlL4L4nDhxd3Dv5nj+nvuyjgJbNC8Py7WmF4HgjJ+/FmF9ANMmaN2sGh4gdpkB/l/Ug7CW+zFdtDakfq++FxLjLwEjQ8Cjm1XT7bzR8KH9loeuS7+UherehpcNrkGttjvtMAVyaBt3eeOhC1V9TDjvSn21e9sKsZs6nWjBLVDs7R1JhwxSWdwgWEUEWkQu0+WHc/8Xsw/8qjtJbXU+o3IcP8rlN7jr9wZS6xr/l1YxIaTIvsFaQLkKyVRmX7bf789c/Czqp3gLMfYxml9tL5wW4ACReAkNF4xpn/Qz/7Rr2dtnZP9KBhxalbdgLB2xO28kU5+baoDxa2Drb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCRL47rdEOCJRdzsT0+/T/9SshWxalZgtqYVkHpLVz8=;
 b=dlnz7DgJioEJ93gAzCdl/fZDxi9ZTmYG3H6ahWvXKoKHZ2ipDChg+Dn5eI2kQ8+FLyQsKtND2+PO4bqm9P5llAf1hOI4NvkJvHOFPKK3YVDUpQpQ7PM9M6cg1TOSALG+XD2/AgfIKpDeNlYtJzGZ1GLtoYRP9kdY7tWDrajFYQ1suNa09F66taap5bR/TA+uh9tC2RGjh/DkZyvAzZyQAVL4RAUcKWAPReubntGtQfWmaHSiRhkehGs0mW0L4LrWq2yYxmBQ2/N3RFv2lOJR3K/b1C5QcEHOwYNYMo9jut/ZtGI5ygZXVJqVeKJXG0FAoe8wuoC+Ncjn4CQl6DjC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCRL47rdEOCJRdzsT0+/T/9SshWxalZgtqYVkHpLVz8=;
 b=kKEf8d1TBFURfHSw6RlXOdUbRFuP+qZT/UCFfkLInyKO7lnBal/TukRCmf8GYkpBZk3qKNBp6i4JN6Tn7XGkMZC2F0SKy1g3/c4q9ybOYYh/dDuuNYdY0MBZiR7owdaWAF3/CQo3xl46UA9BZP6Jy/0yoDK/PfyS1HWP0Y93ervnDsZf1syI37ceg5LpolXdOlopnnzc5eHfs/q6XubrrkVrZzcws/VF7PP/l/1uWM36MxBcp3pHy6u29isSoRXun518YYlGAdYvq3NQKMSM1z247s0Cgu27u/pSMNzHqUXIsWaaVkRjg6K/TSLRO8iN1ZxHWElMKPQ08PZ465KxYg==
Received: from DUZPR01CA0275.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::6) by AS2PR10MB7370.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:606::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 10:26:12 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::f4) by DUZPR01CA0275.outlook.office365.com
 (2603:10a6:10:4b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 10:26:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 10:26:10 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 11:28:17 +0100
Received: from [10.48.87.244] (10.48.87.244) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 11:26:09 +0100
Message-ID: <f1fc7d31-ed9a-4af0-b73f-ebe10f8c7447@foss.st.com>
Date: Tue, 24 Feb 2026 11:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp2: Update size of DDR entry in MMU table
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>
References: <20260205-upstream_ddr_entry_update_in_mmu-v1-1-5495326f7446@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260205-upstream_ddr_entry_update_in_mmu-v1-1-5495326f7446@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.244]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|AS2PR10MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 964322e3-a1d8-40e3-50d5-08de738f2146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vnh3dC8xYytiSG40WDJkR3paRHNOZkNwMkdIMEtlQXZuSkJrLzdOZXVMSFJn?=
 =?utf-8?B?YW5YUWJIZ2o5aENQYTF3SU5OTndETGsrd3ZEQzZWc2xSU1ZOZzJ2enZ4WElT?=
 =?utf-8?B?WHVpcHZIZHJWL0Q4YTlVcURMQUJlTHVQM2gzV2tIYkdUVEFycUVTQ0FBRE1I?=
 =?utf-8?B?aTE3Vm5IbDJzN1p0NjFPUks4TE5KM1h2d3VNRnd1bHlkZ0IzODBzeXBSbVZR?=
 =?utf-8?B?M0dXOE1LN3luQ3NDWVFJQkRteVJuVHRzTy9mOTFlZXU0L1R2M0duUUF6cnE2?=
 =?utf-8?B?UHlNVEtHRFpxTjRNa1BJOTRjY2pwVnJjdkVNV3l6RmhZNW9zMlg2TmphclI5?=
 =?utf-8?B?d0pxQ2R0dVhoUTN0d0tSVU1vQ1h2RW9DYkNsbTBubUJEdDV6Q0hLd3NLMnNY?=
 =?utf-8?B?WHR4K2tnOXg2OFF3dmpwR2RVRGQrZWFVYld5MlkzaEpUSjBURGt5NTVyQnVa?=
 =?utf-8?B?MFZLVDR5ZDlHd0EzZllad3ZsZlhsc0FYaXplRkpYaFNCM2JRVkZCbVh5Ylli?=
 =?utf-8?B?QnVuVnNPbnMvVEVLTmZiNFAyZjhtMHByVXBpaGdVTVFtMW9DNXJvUnRmaHI3?=
 =?utf-8?B?eGpFd0NIVEJzS3IzZ2VtSjhmK1ZoL0FHRkJmRk9iVitpdGprUm9vK3lhN0x0?=
 =?utf-8?B?WWpyL2Vlc2Q4SDN1a3lpRm5waTRDeHZiMURXUXZrNDV2a0laNWx0SzIyeE9t?=
 =?utf-8?B?YThFaEd6NmlTeUZub1BVTDU4VVIvVjFwWThYVWtVVUVaS3dPMDRoaktJS01V?=
 =?utf-8?B?Nk9WYkpTMys5cGxFOVV3eitWYksyMkFHcEtQV2EzQitsQ29ZMmFxb0NaQjBj?=
 =?utf-8?B?TzZHZzZkRXhnMFhzc1czS0FqVEgvUm01MzZWdmQxclBpbGlDQXowa1YyYlpB?=
 =?utf-8?B?akVvVEFTYTIrRmVsQTBydFpkalNlRm15Z2ljNmljaXlGNTkzWExvdFNqSzBV?=
 =?utf-8?B?K0h6Rll3dkRNNlFYYmF2YjVKWS9mN00wV1JMekp6UnozS1lpeklHZ2tNTGNO?=
 =?utf-8?B?Z2RKbUc4Ry9odFgzYnRQMFpFa0prMkJabGYrL2NPZDdaVFBETmExZk80RDVx?=
 =?utf-8?B?OFJlazh5UE9RaDgrVUVEYnUwYWdkY0dBK3BrSlZnbnF0ZVVqV2kvOVp1S05H?=
 =?utf-8?B?ZTd5akRZZjFTdFF1dHdqNWpJN2JMbnVWaXROVjlkSkpwS0dYS20yWFYveXE4?=
 =?utf-8?B?Q1h1YXdUL1ZadzQ5ZVc4eEw3eGFrTU1USkRIczBZZjJob1dlVXRRWld2d0tK?=
 =?utf-8?B?NTgyd1U1NG5EVmNaRUg2SndIejA1M0I4c2NOOWV3VjI0Ym9TUHBqcHdXWi9W?=
 =?utf-8?B?bjRvNGRlZEtYem13a0wzVHh0U3RLaCtRN3VyT2MxeGNPZk9VcHVKYTArY1hw?=
 =?utf-8?B?ZnVsU3ZOQk1WN1ZDUXptVGprNnJNeFExRE9CdkIvVjRoR0Mwdnl6d2xBT0hG?=
 =?utf-8?B?Q1VqZFloVXZQVmVQVkZzNjNnOVZIa254RFdsZjNpK0VIajZJcGJWWW1IUGFo?=
 =?utf-8?B?aDFWcDc5RjJ0NTNST05zdWQrN3pEaERBZ215V0Ztdlc0d2FTOVViOEQyb3Va?=
 =?utf-8?B?TTdTeExUQVhlREhtNDJ5TWI3a1FDQTVtc3BKQmpma3AxT0hnbUlrS0NMRDht?=
 =?utf-8?B?MUwyOTViNjJzaVZKd3BOeXl6M1ordkNBLytDS1JLVkttOTJTWlJmOGRHQ0Jz?=
 =?utf-8?B?WTJRZFdqZk1vUDVjRVVjZUNXM3hMcFBTK0RwTE9BSmRsR1p6a0NzeGlab2hO?=
 =?utf-8?B?OWNPWDlxelRISm9TVnhjRmhhNnZLeUpwcEJOZkREYTkvQkNObXM3SmdpV2JJ?=
 =?utf-8?B?dmM4K1d6ZTYyNzQzVXZ5V0JsbmxtK1hESDVYVlR0V3hqc201QmFESlJ4MkMv?=
 =?utf-8?B?S09vVHZWdzB1WlZlZ3Q0VlV1OCt6dXh0Z3F1dGZlb2F5SGlEL2VGWVZKNFlZ?=
 =?utf-8?B?cUZKTk96bGNlNnJHU1owQ0VaWGwvQTFWQktLczB1SGRTcHE2bzd3OXl3QXBW?=
 =?utf-8?B?cGdPOE9GZUk4WFhIWWVqbGpyTTBJa2paaCtiWDlUbWN2dy90cERsNThHY1hh?=
 =?utf-8?B?T0Rub2ZYQStGNlJwL3B1WG0zYTlldXBHQ3JkL3kveHJPQXV2bjJQU3NOTi9y?=
 =?utf-8?B?NjVuRWgxMW1PZVlqMVRuK0UwNzlDUHhjQU93TXRjTmNEUmdpRk9jNlJDWjNh?=
 =?utf-8?B?MnBLRHR4YXNSWnhVRGJlWmpLaDVsdzlpcTYvbkJydGJUL2ZWY0paOUxHQU5o?=
 =?utf-8?B?WC9NYXBORFZjQm0xM0FqUzV4aitBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /JNvTNw7RUrkwFyGSKqiMUmT6xOpfow8UoXLUbefNBOOzEbNIYmFCyH4sWhpJ9Tj9YfdPLIR9PbksL3GS0xxDpxbRyMNi3mDQf/Dqku/WBG9HefJTcKyqNk60apSvlXXZI8GM8Be1BkaCJmrwfU8FXvp16JEu9TOPURuz+v+rs+9VFQVPiMbpyarJKUOtxVwnLknzXybMJML8OPoXk2xk1tJynfMRxgkWsOPqizMqn8u7QCNaNlDl8F1An22eLtsRRpXOatDPm/SW79sq7/6kBtjPZqmJ8zopcLqVCLe+s/Qjc/fqAjNb+We5RdMet8sCDgmXN3NfMKmKkQE4ijZ+11UD1dFCVaDxmoMCGgm/SK5dIysiShWogw6ThsoVirB15XwAApPLQyH22RPJG81Ndm2Y0LTSpte41Rw8SE0HZ/u0gH3Kfk+ncF5SFioRZI+
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 10:26:10.7805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 964322e3-a1d8-40e3-50d5-08de738f2146
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7370
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

Hi,

On 2/5/26 17:20, Patrice Chotard wrote:
> On 1GB board, in particular cases, a prefetch operation is done just above
> the 1GB boundary. The DDR size is 1GB (0x80000000 to 0xc0000000), there is
> an access on 0xc00017c0 (ie 0x800017c0).
>
> As beginning of DDR is protected by MMU until CONFIG_TEXT_BASE
> (0x80000000 to 0x84000000), it triggers the following IAC:
>
> E/TC:0   stm32_iac_itr:192 IAC exceptions [159:128]: 0x200
> E/TC:0   stm32_iac_itr:197 IAC exception ID: 137
> I/TC:
>
> DUMPING DATA FOR risaf@420d0000
> I/TC: =====================================================
> I/TC: Status register (IAESR0): 0x11
> I/TC: -----------------------------------------------------
> I/TC: Faulty address (IADDR0): 0xc00017c0
> I/TC: =====================================================
> E/TC:0   Panic at /usr/src/debug/optee-os-stm32mp/4.0.0-gitvalid.8>
> E/TC:0   TEE load address @ 0x82000000
> E/TC:0   Call stack:
> E/TC:0    0x82007f30
> E/TC:0    0x820444b4
> E/TC:0    0x8202dc54
> E/TC:0    0x82041fe0
> E/TC:0    0x820143b8
>
> By default, in MMU table, the DDR size is set to 4GB, but not all
> STM32MP2 based board embeds 4GB, some has only 1 or 2GB of DDR.
>
> The MMU table entry dedicated to DDR need to be updated with the real
> DDR size previously read from DT.
> After relocation, in enable_caches(), update the MMU table between the
> dcache_disable() / dcache_enable() with the real DDR size.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/mach-stm32mp/stm32mp2/cpu.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

