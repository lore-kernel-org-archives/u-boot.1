Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A214CD343F
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 07:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FFC58341A;
	Thu, 21 May 2026 09:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="od6doXgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 681B480433; Thu, 21 May 2026 09:20:57 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04CA380433
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 09:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRRcrXNrTKpl0ltUtRr7Qbs6Sn+ExZPijDm6SEtcENrSuEZGay3Zn2nX8eFTUQHGGVBDLo9byRqlqwW4hkWSY7kxLFUzZmit8sTBqbu1yaL2q5V0M1fRVaZNnyyIjncyxFRbn3MZWsPcAXGcTR6S/TbDQ3+o5NgFZCwNbulxQIDjc5FQXawFelPhIYRn14Tx6qxtuzgchphLAkoWwaHWo+1cup1mW4p7n59Vtrl0pg3uttIl7mNcDdqFwCzr27HDFgV4Ym+3wdYq6rftHubYlRyYXC/1po+IUBVCMvUj02698qhuI4lizYdtNr/c/ZlCA1VrbZ9xz7npn7azWBykhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVinjL10qSZl26vsqWB0FfRrTDCx/J/lhiqQR9QtiXc=;
 b=V9hpYdLV1fG48AylxUbnHgKuVhPWTHU0OWYCVo13Fyi1OSLncE2SCsRVJMVGGF3nnsAG/fmlJUqJ+n+CAKU7lwejpPy+V0HOmU8jJhEuMF6keZOvRmMUNtFw5TSED0qx1MDQGw+YbARSNhOoPh7wZYfZZaaK9tHGMfYx5rqpuHpNutTYcxyouZ/ygwhNTChRBcLRHc+IyEMDFO8ZiUaMjIzManhue+a9sBiseHWJjdgmuybdmlmNLD0bsbViu5Ly4+4Whdvg0UE5Ryj/vK7aPnWp83Y00zfz6bWwLudfEqkWVEv0HPf8gt2iA5eUbW0OJV/M0im1HbwC+r2j+op0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVinjL10qSZl26vsqWB0FfRrTDCx/J/lhiqQR9QtiXc=;
 b=od6doXgXtF1IzjjmmU6KnN/GrIasFVeYBtRxGBkWcGg98INFHGhsXCZI3ysY7ujRfFgi+w5NIMQvYkeuCVQ/RyiRHVeFlpq5OSp/efL2q1XyxI6IbHTxFhZFVPzNTaBiOrXMHaBlhDI59M5Ld7jpmzsu8Ok2jvBMc0VwDiElUyZ/4f/ug9doGrx4GrsbmPxkOk0pqTKVIXi/Pdz269rZ0O8403PPkMQsOEBL6tp6QETWsuj/cq8wYlkujxT9yJ6YzLkUYCuQPNN8/pElBg2kaTpdbMhhLIPxP1gZTcTf1E9KhRUwNqlI/xK+knlS+sRvtCRiHHVasEBFG1C0x5eUUA==
Received: from DUZPR01CA0276.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::25) by VI1PR10MB3598.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:139::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 07:20:50 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::2e) by DUZPR01CA0276.outlook.office365.com
 (2603:10a6:10:4b9::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 07:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 07:20:50 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 21 May
 2026 09:24:44 +0200
Received: from [10.48.87.77] (10.48.87.77) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Thu, 21 May
 2026 09:20:49 +0200
Message-ID: <b74d784c-9728-4242-a9d0-e0c805048c7d@foss.st.com>
Date: Thu, 21 May 2026 09:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Enable Arm SMC watchdog for STM32MP1
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Anshul Dalal
 <anshuld@ti.com>, Christophe KERELLO <christophe.kerello@foss.st.com>,
 "Lionel Debieve" <lionel.debieve@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260520160715.175032-1-yann.gautier@foss.st.com>
 <f48f9d8d-4b14-4745-8c96-2c315889f770@mailbox.org>
Content-Language: en-US, fr
From: Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <f48f9d8d-4b14-4745-8c96-2c315889f770@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.77]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|VI1PR10MB3598:EE_
X-MS-Office365-Filtering-Correlation-Id: d64bfe2f-40d3-46bc-d7ac-08deb7097c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|56012099003|18002099003|6133799003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: s3pfiy/2N/rKOQ4fgg/TxqwL99leBiNnBtqIU5xn/xnRsfFEP0XKlqYcVSN//CuWOCd/xbs+iwpl9UBjdR+ZQkXb7ZHVf+2Vr6l6QANE3yLj7OTT93ejyF8osDGWe4KSrEUic1AmTsxL5+dIU+t2O1zLcMMf98SLvM+cn+GYKTFXLEli7icVQr50Wov6EBWDooBfkFp5sPzeCBiYNWX3YjLfFDcxA9RlRiraUkE8CSeNeV5Wid3bz1SlTD1f2Wdm3CtcvO3CwcCfwJh4W14jDFGo643ZnM47YrijnaRsxtGqTO+Fx+siVWvGoQ9bHkZo192FktSHUuaAWj3mOn4bYqWOuihrFAq1Sb10inQGlcUuwe804azW9G9fWXIA4eBsCoIEbTXeKGz6+Kaic1X0e78G8RcZ7Dp1nhLesA5NVGLzZSMEXleKyL4FGajtspyS3Pnt0msGmyKwbSpZZZ1E1Gv2ALbPNWqtcwXWhbBKd77/kziRIaLsOi7oSRMhjMss0vOS2DOLsOCjzE26LSFLrmy7jjaQdzgaiXupRP0QkFYTdkTdkoYrF+4tDjqWQW1rXKb37XhnTsz0ri+nZcLf6BtkU3YnSmqT/OpHJwlLKLocNGB12MuVexsyKjwFza5ahAcCiRfngpulL3YcqZHTrwYNTgaGDln43ha2Vn0N3uFUaaj5yH4tRUdaEcyUyL/308IpTOUI18BcMqi+n1SBFViw+z360IxA3voXC/4pWVQ=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(56012099003)(18002099003)(6133799003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EV5kAbEVVos4a5+/zbetS5LTD+d2/SzqMzyu9Jc4Jgav99iT1Celm+B/wbw8HZ++tffXphlyVLVESoLzJ8IONulZOpbZ8DZYVSQQxmqB7QRY4hBXDr/tMnGtlCQYuWJc80xYEVEeYroC6ZVMs/eQGSCkCINXMcvkFkiB0PfNu+G524IqZbhiUXB+wgNSUdzCpi27jxF5Qk0+nSn2B1Vkwed0OzcGuImI9/3hauwnX+8jVQ3EuLC01BeF3ZshjhJeM8BYhOG32Raq7J6A7uD5CtpuM2UqdeUwkwi0LmoTXsosn9RXXvV2Ag/9nRBuWpt15oRzs+a/oUK+ceDqsLe2gbEE9kLkptLQxpu/bQ8abQkSufegFwA+FTz2ZsVrlf1qc2NMBrZ1TdVpH+KrC9ppdVNU+4+mjptv/BTxJSCqanzES4bvIctMbTngh4Kkf7cX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 07:20:50.3931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64bfe2f-40d3-46bc-d7ac-08deb7097c86
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3598
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

On 5/20/26 18:38, Marek Vasut wrote:
> On 5/20/26 6:07 PM, Yann Gautier wrote:
>> This series adds the supports for Arm SMC watchdog for STM32MP1x
>> platforms. This enables the required config flags for both STM32MP13
>> and STM32MP15, and updates the U-Boot overlay DT file for STM32MP15
>> in SCMI configuration.
>>
>> This series also requires a patch from Patrice[1] increasing the
>> CONFIG_SYS_MALLOC_F_LEN for STM32MP15.
>>
>> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20260518-master- 
>> v1-1-37fd4df56609@foss.st.com/
> 
> I hate to nitpick at this point, but, it seems the two patches in this 
> series do effectively the same thing.

Not really, the watchdog config was already there for STM32MP15, and we 
now enable and use the Arm SMC watchdog.
For STM32MP13, no watchdog was configured at all in U-Boot.
So for me the patches titles make sense as they are.

> I'd say, align the commit subjects 
> to something like:
> 
> configs: stm32mp15: Enable Arm SMC watchdog
> 
> And:
> 
> configs: stm32mp13: Enable Arm SMC watchdog
> 
> Even the commit messages can likely be aligned ?

I'll check if I can improve that.

