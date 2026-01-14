Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BF8D38FEC
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 16:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9866F803F5;
	Wed, 14 Jan 2026 17:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="SMoMUeX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6175C8063E; Wed, 14 Jan 2026 17:55:35 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F5E80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 17:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4FqUOq57mCXiaHea/jWVPg/jjQwEtNq/KYvhEyD201IGW9yoN4IB5wbAnjx542vGc1IVJYKs09gwcDEu1+hZGTxm85Givyp6cBR6kBcPt/NZ1W9regxEUvTc8E8tpDE8wIxeNIxpO3k3nrd2aXSSU1BqxxCZpVR2X5n5mJsuMPVjKCE0eggsJTvrNEfoPCyEK1a5gpZNWKguFD6jI8019680uS3zrM+g3IJobi4kA2z7VuHUjOixUiSrdviASCiWVoLvR3XPpxNHHi1og+zxbOafsIO1gRqW9zdBmmb4B4UT8stZiS4FcFUW/fZaH9kSJ2AOZOZoXEYI+DJ0xro5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vN2Z6Lxjv5C4GgVW9nf+t4+SckBRW/zX2qWWMPoyz0U=;
 b=pF5B+I/WdL6vKeMnIWNfMh11JdpWz/u4/IWxBp0yCM26lgkkzHmvLpBNDwXae4UIPbPkbjByL84jBgnh8B/zcL8RNimErHk3M/1zJmZ314cCy6RsTJVBy4AcpmI6pr0Tpn7n1ZBU8c0u0E8sfRm0vPtKcI5D+hF1+Yt1QYFEDhzDHUOrCuYHA41iuxMfUw1ffQlq4UT2JV/3Kbndtmyef2k4SCe+8fil80Kx+YIypO48Ti0J1uNL0IcGgI+dOL+r+bJwQxhpRM8A6RVSnStT0MaFwR37yIrAzYIERUvtESi9ddtoVLuZTgVGW88nkfn9dnWjTJwe1gO0d3gmpjOu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN2Z6Lxjv5C4GgVW9nf+t4+SckBRW/zX2qWWMPoyz0U=;
 b=SMoMUeX5/wzY3fT2+bWYGusGnp+E0yU0Y1T65ylMGbvKBfo9SFlxdacK814x5XnK17mclwdVTz+rLI06UhiGFZPj7ayT9NQHibCglyt+Y3SmU3KTYvIGTe5dawLyJOeaFixB3+0XOLg/viF1Ce9ZCXXCvk40EJqml1rYUM431K68weaYLgVUvH3MXfleB13MGKt5GTNh8piUrfufkVgs9cJjYRHYfysepsxY7EQgP/wAbUSrL5534xdjTCLJkC/ynfGzRWZ0q7GM7uZjnXDcWtc35G5P0OBgwg+Ze/Zh++5jociRALRdoC/nszL0U7d6ZhfMu+UcyGsIkh/mLvnWPg==
Received: from DU7P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::29)
 by AS2PR10MB6685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:55:28 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::fc) by DU7P195CA0006.outlook.office365.com
 (2603:10a6:10:54d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 16:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 16:55:27 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 14 Jan
 2026 17:56:52 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 14 Jan
 2026 17:55:26 +0100
Message-ID: <cecb567b-289d-49b8-a9dd-390a6d894500@foss.st.com>
Date: Wed, 14 Jan 2026 17:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] clk: stm32: Update clock management for
 STM32MP13/25
To: Marek Vasut <marek.vasut@mailbox.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>
CC: Lukasz Majewski <lukma@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>
References: <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-0-d055da246e55@foss.st.com>
 <20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-3-d055da246e55@foss.st.com>
 <869f8843-8d43-4c1f-b6ae-0116fcf64ac4@foss.st.com>
 <f6140b6b-2dba-4bfe-bdf8-11a9793916ee@mailbox.org>
 <020df345-65df-4d5b-945c-36db65428587@foss.st.com>
 <5f0174c7-6791-4fc3-80df-62812baed40c@foss.st.com>
 <5a4ea825-3a89-4856-b9d8-d1df827f9b9c@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <5a4ea825-3a89-4856-b9d8-d1df827f9b9c@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|AS2PR10MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: 0891dc7d-44d1-4fa2-388a-08de538db842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkRELzVpMnVsMTNqRzcwZFo0dDIwcDA4UTNvc2EyQmpoOFBuT0htdTdkSXo1?=
 =?utf-8?B?VHFYRGxtckovR21IQ1JkSnBYMVc2dnBvRms5ODI1cFNEamcvYU5rWE9icDJT?=
 =?utf-8?B?WEw3TWkyODRkbnVnMzRzbWdRUXJBWjNNbjhmQnhabEhWTjhqQ3pSenEwMkd4?=
 =?utf-8?B?QWpobFdPRjdxYzlEbnh0WG9ycU1PK0ViSElHczRnZG82TEQzaWxmaXRXYWdX?=
 =?utf-8?B?N0ljNS9yYkhaNjV4WVJiVTc5a1lNTmg3YUZ6SkNjZmx5b1pOcWpPNnpRM2d2?=
 =?utf-8?B?UTlOYTRxNjYxckIxWG5sckwxdFhUaFNBMGdmSzVWVGJYMHNtK3Uycmx5Mk54?=
 =?utf-8?B?cTFlM1NxdmkvNUR5dEwxNmNIMEp4QmNDTDNqVGpXR244NkxZVzhuajh3NWx1?=
 =?utf-8?B?TDhlUzI3YllMMXVkVDBQNU9ib2NyeHIybE5QYWtRYlNJVFdScDFuRXdpWDNh?=
 =?utf-8?B?QmROS0thS05mUm0zM3VKUEtvZUYvODZvc0JjWHhjZTh3c1V5WWNVTU1RYXZy?=
 =?utf-8?B?RnBFM3dtUS85WEx4ek9XNkc3RzFmSSt5OHJvNEdaUXRuQzJxa2ZWSjZycUJO?=
 =?utf-8?B?RHdRUjl4bmtVWERtc3lkamZmRFQyRGhKT09YaWlJbTZCS29oK0NrdkU0OTZj?=
 =?utf-8?B?YTBrUXdYUFZFQWVEM0dsYUNCbGIzVERhNGFJQStUcXpKcWhYSDRnSWsrcUk1?=
 =?utf-8?B?b0xFb08rbndlY2oyeEJYWVpsVWxXRWdtcmtDZUd2VDBCcjlBekI2c0xoZGto?=
 =?utf-8?B?azVPWjJkMFh6U3JUUWlBZUVnMnNUK0ZRc0dmclhQd0QxMW43MzYrQUNvdEkw?=
 =?utf-8?B?WUVnV1VIaS93TkRTWWREajNwcFVNZEZVZTBYV1JmWUhGZlBnWUFvbUxXZU9q?=
 =?utf-8?B?dVdrMU5UbytNa2xPa2cvMzh5MHZiNSt1Sy83NkYrK0o5SGU0dThSVnpqR3h3?=
 =?utf-8?B?SEtaSlIwWUpmSWlGY1RKMXI0RFh5UTJzdWk4TkovZklBUjRGUHRMUXJNbWZ1?=
 =?utf-8?B?UEVFSFZSRzdGbGsxK3c0VVhDOTl0WUo2c1E5dmNiRnRKNnI5SHZLVk5yRG1V?=
 =?utf-8?B?YnpSeHJoaENHSW5qVjVxYWkrUnIrMmoyeGJQRTQwb2hRS3pxclZQN1h5WmVJ?=
 =?utf-8?B?elBVQVhwTGhDVTYrOGVQM1N2VU9CUCtYZEhtNjFKbWFrM1crWHVGTEROUm1p?=
 =?utf-8?B?VDJqL3huRDArT1FFZFhEWjZQWVRwdkFrNHpkdmxtQndXSVZiYlNZUmZYUVdX?=
 =?utf-8?B?WWMzOGRmSDZVSzFHUmtHK0pNY2Y1RmF3WG8vN2syckRSSi9IeDNBOWE4TXVE?=
 =?utf-8?B?UllQR0ZLYkdCRklFVCtBSWhoVVhzWWgxWE1veXhBTDk0dHEzZjVuT1RJSC9k?=
 =?utf-8?B?OW9kbGRGS25JVmU2SnRscm1UMTVDWExvK0RrZU94NW1YMTRKOERjRllBdklq?=
 =?utf-8?B?ZXJoZVBZWEdSUldBdVFuU2JpdnZEK2loNDBpQ0Q4WFJMWitVL2ZTYXNHSzVS?=
 =?utf-8?B?MjNkbGtTS2VlV3plVVdTcFZnNDNmR29yL1RGd0NNU29WK1h3UVpGZHhnYW5Q?=
 =?utf-8?B?NDh4WTBqVk1MenJCYWl0clIrUHA0N0NXTjU3M3h1UnRibC9OQ01vaWpOL2k1?=
 =?utf-8?B?dmpkN2VjS0p5eURnWUhhNEluWXgrMkpDbEZiM1ZzU09GZ0lKaUpWNEtJa1l3?=
 =?utf-8?B?cjFPVFUvWTlQSjcrakRBaUppU0xpTEx6TUhrWkZ2aWF6RVJRN0JJQ3MrNFFJ?=
 =?utf-8?B?aEw2SzhxR1REanRuL2JYRnQ2WXlCN2RXUkhwTjZpWWRKaEVOaXhpVmhvWGI4?=
 =?utf-8?B?VHpHKzhYY3hhbkFlMU5GVXAvazNvMURaeThuWUdnd2s2b2c2Q1FXL25EOEFz?=
 =?utf-8?B?MVcyTFBFdXlJVXlsdHNWaFFyNU8zQXVkWFZBZ3ZGUTkrUFNqeDNaU0tDREpo?=
 =?utf-8?B?WmNmLzgyOVRyZ0NyWVJoTmQxZ3d0VjJLYzFmVkZtRCthVzJ5NjNXU1I3TDhY?=
 =?utf-8?B?RGpPUGVNdm9zbUVMdVAwcVNvNWhEem92bUlmdmFSVUtGZnVOa3ZHckFFV3Vx?=
 =?utf-8?B?THUrWE96MUkwbFlHN3hPOXRuTTk0MDJtZTI2dTYrVExSdEJUQ2M2Ulc5STJZ?=
 =?utf-8?B?T0VDUzRTOU1WTTJWTmkrS1FNOFhtNlBtUmRlMGUrWWx1VzZMYTlRMHl6ekVh?=
 =?utf-8?B?ZHhLME5iWmhob3RmN0RVY1hiYURHQVRyaWJBd3hFb3EwdzJncE9Fa1dKcjg5?=
 =?utf-8?B?Z3c5MmRsNDV4cHJraGt5NXRsVFFnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EZTz1ejMzoMLDHotdMG9oskKHOX2S+9qSLDAlsbK2/iYvVJH3AcnLkKVqslft9IOPfQh7yza7EFXbvOsXa2H2/kLBBm+rn8JVrN0ykg4A/VgipZcqjvqrRrPp71cLMTHg7XnzHoLbpN5utCA+LEbtsaQYrATBVCuy+pNrgRk9zfCEycyjya66Vfwc67juXuupPrlIZzIgCtz4MomCoONQKTlLa7UTb/cMGdRC18JHPLB3r9S9m1oXKBHs5Oo/cdSFbhmDVGbN7OpgNgU8GTC+IM2u3fgoUMU4CStDdVMYXs9F5LIO2nmZ5gQlI2lAEIkysjqpeGZpkJHCOuX0giglFIJiarvH1Y2Nalcuc9KeErYSbVaA2XwZhfI/S2LeyNpzoQWL/fu5i2FJuo9zCuvXf+UK9rXrGGSgvr22M6C+z38BkWLSeLW2VyZq31ISt/9HqPpTmo1joyd6XmAxMGKkax9TVOlWyQUbfdibGzJKVJNtzLiIyEA2BTELjqBoJhi36S+fpThKKLXMzR3QS35vrVOsf8juGFupXeBzUO+KsJWItzbUjPY3dcbfGyMEoW9q/E9vB6rWtCFCvipxvbYUDU/B0od2UCpAnGX66VUsr9NjwQlUgVzpoSD5QEBBvHUlx3LtDxGvQI+qsyDGyQmIWGuEIiHvc3unQYNEv+jo3qacvtAbAxeNgYxqpl6DE4i
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:55:27.8833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0891dc7d-44d1-4fa2-388a-08de538db842
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6685
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



On 1/5/26 22:22, Marek Vasut wrote:
> On 1/5/26 3:30 PM, Patrice CHOTARD wrote:
> 
> Hello Patrice,
> 
>>>>>>        /* WWDG */
>>>>>> -    STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", "ck_icn_apb3", 0, GATE_WWDG1,
>>>>>> +    STM32_GATE(CK_BUS_WWDG1, "ck_icn_p_wwdg1", IDX_ICN_APB3, 0, GATE_WWDG1,
>>>>>>               SEC_RIFSC(103)),
>>>>>> -    STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", "ck_icn_ls_mcu", 0, GATE_WWDG2,
>>>>>> +    STM32_GATE(CK_BUS_WWDG2, "ck_icn_p_wwdg2", IDX_ICN_LS_MCU, 0, GATE_WWDG2,
>>>>>>               SEC_RIFSC(104)),
>>>>>>    };
>>>>>>   
>>>>> Hi Marek
>>>>>
>>>>> Can you give this patchset a try on DHCOR board in SPL ?
>>>> I have bad news, the SPL does not even start with this, no output on UART even. The problem seems to be in 3/3 , if I apply only 1/3 and 2/3 the board does boot just fine.
>>
>> Hi Marek
>>
>> Happy new year ;-)
> 
> Thank you, Happy New Year to you too.
> 
>> Have you tried with DEBUG_UART ?
> 
> No, that is not enabled in the DHSBC config.
> 
> You should be able to try the SPL on MP13 EV if you pick the changes from these three commits (a few DT changes and a few config options), it should be straightforward to port over and help you debug the problem:
> 
> bf53344bff8d ("ARM: dts: stm32: Add STM32MP13x SPL specific DT additions")
> 1143fd4c3507 ("ARM: dts: stm32: Add SPL specifics for DH STM32MP13xx DHCOR DHSBC")
> 998da69da678 ("ARM: dts: stm32: Switch defconfig to SPL for DH STM32MP13xx DHCOR DHSBC")
> 
> If this doesn't work quickly for you, I can try to set up the MP13 DHSBC with DEBUG_UART later this week.
Hi Marek

Thanks for pointing these patches.
I succeed to make stm32mp135f-dk board in SPL boot.

I will now investigate why SPL boot is no more functional with this patch.

Thanks
Patrice


