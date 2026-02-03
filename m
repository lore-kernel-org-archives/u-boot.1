Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B76E87849
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 16:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D22083BF4;
	Tue,  3 Feb 2026 17:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="RCbhkMZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921A483CF2; Tue,  3 Feb 2026 17:49:47 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47768839DF
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 17:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ahzf/d4uH7JHq8YMyb8WOBES3Bj9EcX//oUsVuC1lk8x/CoBx6LB5JPawbkn0g1Ks2kHTFFki2uRs0iXxIrUnYaOP5JGXk29jxX7wOnqjbKEH2WVTXtNKvH7d2UIAyL1EhBWh/UENH+++Xr5xgS0kifMBoEO83JNNxRDUzahWTAXQFE494tSS5uQ5M9zLM4DUKhk1ul4PO9iYyO6GzajLE+9qAh6mS1sgZc5ZfLNCklfQ1QdO8rbIDoFWUMusH/BRib6uPeU6QSkLOWuAvyCgKDe4Y5EzGJHYbg046rCFrWdBFVNeH27lp/N3YYtXRtHDujqUt00hX0j+Vj4ktIuuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qQWV3gqv/pIsHGXejmwSrH6BEVLz2Xm2qZdtiv0iOc=;
 b=MULxEVTBs/MsGYnlBDBMo7DHnVlvKTro8zZ6L7cJfopp18N1Lj0cJ5rdRPvwRBV5q+ScnuukETjttqQctRR5bL0p3P1+4hxIWLgf+3upO2Ydd8/Mwuy4oBQsX528F37HJpJ9c6a9rHrMDc1XgP10FLpzUk75o+R/fX07NqaJOR32ADxgyjIMRA7+fw716Nn8VD8gtqb6VlIJGKRRCoXMpKxT3WIWjWEm1DhwxF0OUPpPY3s2NBHDNpNGvKn4p5QiksX5QUhLs3+KvEFhamYEfC1CglwAQpaDMfEcgKSG4j9ZY4Zq5Tb0yqdIO/mZmlklemc+/l22HX7TCmkFsE12NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qQWV3gqv/pIsHGXejmwSrH6BEVLz2Xm2qZdtiv0iOc=;
 b=RCbhkMZs2UzrAKhxin/8Kb0A6pE0Fjv247fProURDe4xGaQbohqIxhEVZ3I5t42zw8+S4BN6n8H4lXJ3rCzc0FAMcXWzO0vFARhMS0i49q1E4FqDIE8Spp/yMKqKF8G4hQPGofSp25N2ymZTwKRz9McbpeT2BU4Kzf5qyGDnW+HI+CZ+a1AAdTNDm9abCpmUjZolUKpP9tyP2yRKPgJRa73+chY32wCb+A/iCS5lcyrGcNliq9+F+pE8aTSXhgezjVjk6oWNao+ykNaKIZ3pjPtiaP9YiH0KTOI8cZS/UN23B1Iym0IdTLOudo+vH+QeZTbElejui4JdCUEiV+8BLw==
Received: from DB9PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:10:1db::23)
 by DU2PR10MB7693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:492::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Tue, 3 Feb
 2026 16:49:38 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::49) by DB9PR06CA0018.outlook.office365.com
 (2603:10a6:10:1db::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 16:49:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 16:49:37 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 17:51:15 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 17:49:36 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Tue, 3 Feb 2026 17:49:25 +0100
Subject: [PATCH 5/7] ARM: stm32mp: Add STM32MP21 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260203-upstream_add_stm32mp21_support-v1-5-48ca3409cce1@foss.st.com>
References: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
In-Reply-To: <20260203-upstream_add_stm32mp21_support-v1-0-48ca3409cce1@foss.st.com>
To: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Nicolas Le Bayon <nicolas.le.bayon@st.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Thomas Bourgoin <thomas.bourgoin@foss.st.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Yann Gautier <yann.gautier@foss.st.com>, Simeon
 Marijon <simeon.marijon@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|DU2PR10MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 325b1c39-2030-4099-1fff-08de634437b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0NOZ1ZsZEtkNjBMWWJOVDJjUmxTYVVHRVh5Q2R2OGszRi9TNjZzajI3SmdG?=
 =?utf-8?B?MzV1ejBqaDluc2RlK1lTRUdLYUVyTGJycDhNeXQ4Y3hLL3o2NDQwQjlxbTVW?=
 =?utf-8?B?ZHJVNUxEL2M5aWRIeVpsSkJpQ1d5bU1uZVB1L3RXSW5KMGhPU3dXbkV6WExq?=
 =?utf-8?B?NkZHV1dLeU8yRURFeFVRVDhYd1ZxS3BIblZSREtSMXNwajZXWW4vUkFMUndh?=
 =?utf-8?B?eDl5dkNNeGRpN3RKeC9JRUN3L0ZwSmVhNjVyTXB3a1V4LzVEcGM2U1BwaWV0?=
 =?utf-8?B?bzRuK2xBRStvcWFIY04yNFdTSkgyTDg4TmxJbGp3aU4wWGxlYVFQanJXVEI0?=
 =?utf-8?B?bGtHUmxCWVR2bFJXcWx0UkZzSTRyQ25kY0FuQ3ltdTNWcjF0Y3kvOWU0R0t2?=
 =?utf-8?B?MnR3OE1LaVdqM2JGUzVTTTdSMVJEdnlGYThUYVdDamdueVFIWDllb3kwc2Jl?=
 =?utf-8?B?Kzk5OWNqSjhrblArcDJJTVRrTittejluY3ZOSVhvN0h3OHBoNktLVFAvbC9U?=
 =?utf-8?B?L3ZIaWIrZklVSEhyM2xQb0x0SWpQdm9pSWtCQVdPL0Q3SlpqNUVSdmI3dzBX?=
 =?utf-8?B?WHNFSit5MllZYjdIbWVwQ1NjS0xJeUE3VHd2Um96aUQvR1JBaFFlVnlzS1Qr?=
 =?utf-8?B?aENmeWVvbnlJK050SzdZU3JPOENaMDIvVlNsa0Z5bW5TQklvSktoOFRtYjhk?=
 =?utf-8?B?T3hPa0tablhMd1JkN3NaTDBDbisvTnk1SC9xNzdGMS81NFg0YWhlQWQ0UDZT?=
 =?utf-8?B?OXJ0aU0yNzRXYVdSV2lWeFBtbitjZlQ5ZkcyVDE0VjlpbWd4RldDM2VEK1pt?=
 =?utf-8?B?RmhhUGlqUlJxMUlVQVJjeEl3MFpHcXkvQnkvajFvNWpCbG5Oc1V3and0UFB1?=
 =?utf-8?B?WFlQU21pVVE5VkFtRzVYcktTVWlWRE1oVGliRDJkMFZUSFRBWmpndWZxRlJL?=
 =?utf-8?B?VEkrajVHSkgxU3l1VUR1Z2lBbGxuYTdZSzloeXZLMGJHS0hQWjJ4Wk9kdUdj?=
 =?utf-8?B?NjgrTEdGNzhHaXArd3cvemRLMW1YWm4vdmpRNkkvUUdUY0NDU1RDSzc4em42?=
 =?utf-8?B?TGFPOTdzOHlGQ3RQT3JsakNHUklHYVF0cmFxZVJOeXI2cFEzZWxPWmRnaGx4?=
 =?utf-8?B?ZUNTTXVkRjBBNzhVeUdkQU11OHdRS2dyV2h5cnMvb3AzUlcvbzJCMWtkWHVS?=
 =?utf-8?B?d1NPTG93RG0xUVpiQXA2NHg4Yi9HUm5JUnpTbWxMZkE2YkMrd0EwRXpZOGR5?=
 =?utf-8?B?a3loSEplQ2liVlpPUisrZWRaSHlnaG94ay9nSlc5NHJyS2FsbUVnLzhRaC84?=
 =?utf-8?B?dXZCTTJHSmdLZ3RRZExRSjRwT3QrVHkxQkJtcERPL0xqcVNOTExOK3V3M05U?=
 =?utf-8?B?YW9FYTFXd1Rmam56dkg1KzVRclA5RDRLRzBkaEVwa3owL1FWZDJGSWQzRWx1?=
 =?utf-8?B?M2lYVVRvMitkcVBXOUFWYWYzdk50S25xNmpOSVl5cDU1TDV4NmNjOGM2S2Zq?=
 =?utf-8?B?dmtOcy9TY1FiRWNDd1ErSEUvTXVQNm9YRThmbjFka2h1MFpSVkZlOVBycmE4?=
 =?utf-8?B?bCtlWUkvcnZSaTkrcjA1ZGQrYnpiNlpLd2tFeEZUMDg3Z3drZzJ5eTBSZUdv?=
 =?utf-8?B?R0VTTTl5VVZFeFBqVmxMVzJKK0tmb0h2N2JMcmorNDdyN1JvU3RlNlVYNVFv?=
 =?utf-8?B?d01RQUtDNXRTMytZT2haUEJvZ3dnTFVYR3RGWkR0TEFnOHl4VjBsemJuVWty?=
 =?utf-8?B?eThUaGJjVHlqUE1BZndpTnpVcXlMclVobWQ0Rm4xNU4rbDEvMkZueWg5c2dX?=
 =?utf-8?B?ZlFWQVZBeCs1UlpFa213Vm1JbTBTRW5HR0k5YlBFTjhPL1hkT1VzY0s5ckFo?=
 =?utf-8?B?dTBNUG85eTBhemgxUldkTlZrUVgwK1FZMktDNTZJUjVmaFh6ZDFzVDRNL0ZF?=
 =?utf-8?B?alFrOGdtWXRaTzZZOWxhakFoblRJbUl5MTYxNi9pUHVVSkMrK1FOcjN1SFE3?=
 =?utf-8?B?ZjI5VE1jRW5OaVR5NVBibDFSTmZrU0x2bUw4RS9xYnBETnVoOG5VZXhNNC9L?=
 =?utf-8?B?Y1NFNUJtZFRKZ2FxYzRmSXkyTFV2cFVkbVc2RlM1VzU3a3dsWW4vakpnanhj?=
 =?utf-8?B?bUZkMFE3NWdhV0VyY0Mzd3o5M2V0K1g5VjFGM3U5UW5QVkNFdmUxa1N5NkVo?=
 =?utf-8?B?N1NkeW5Gcm1BNmpYN1hzbGFUZ3phcXRwelFsS1FSMTlrQ25jUVhSRU5KSmFB?=
 =?utf-8?B?TkZkREZUNUdrOUxyOTNZVFRBYmRBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: usKIyg136whIXAdh5rFLMYQaK0frivJOIidHP8yq1kzb/KtcQlE5Q6Mhb8hTbpsyw+viRapxT3hP6OeJSWyxTsaD3H27fTfMMH2jmq2paJkfxI4jS98rE5rxSiQKm5RButrZ43P2GFgmcpzw/iDfDoIZd+55VWQwQdRxEDEgUNoPCrVtezSQxvdgnp7Zw4yOqHYEGZN5uHWd/raZpFoXhbRhwQV/wVxdeIZuEMRa3LF7i8AzcT9SmUlU+npTg825bCC0Fc3I2v15WyO0lUtiMfNd/1QVkIc7ltXhAzVP3cXuRO434gwGjTnvJSUpc+7AcojIpJEOTCGNetFD+IRwzNUL8vrPH3SZt2w1K8QDRCfN2Efb9dR0iUDmu7evXO/CD7cVey6p4UYTTjxfjE/4PnrdBUFdFI9VONotb9lzpvd0SgO2gumeYvFI5dASrAHD
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:49:37.5654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325b1c39-2030-4099-1fff-08de634437b5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7693
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

STM32MP21 application processors (STM32 MPUs) based on a single
Arm Cortex®-A35 core running up to 1.5 GHz and Cortex®-M33 core
running at 300 MHz.

It is pin-compatible with the STM32MP2 series in the VFBGA361
10×10 mm package: the STM32MP21 uses a subset of the STM32MP23
pinout, which itself is a subset of the STM32MP25.

More details available here :
https://www.st.com/en/microcontrollers-microprocessors/stm32mp2-series.html

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32mp/Kconfig                  |  27 ++++
 arch/arm/mach-stm32mp/Kconfig.21x              |  37 +++++
 arch/arm/mach-stm32mp/Makefile                 |   3 +-
 arch/arm/mach-stm32mp/include/mach/stm32.h     |  12 +-
 arch/arm/mach-stm32mp/include/mach/sys_proto.h |  22 +++
 arch/arm/mach-stm32mp/stm32mp2/Makefile        |   1 +
 arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c     |   2 +
 arch/arm/mach-stm32mp/stm32mp2/cpu.c           |   2 +
 arch/arm/mach-stm32mp/stm32mp2/rifsc.c         |   1 +
 arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c    | 192 +++++++++++++++++++++++++
 board/st/common/Kconfig                        |   2 +-
 board/st/stm32mp2/Kconfig                      |  14 ++
 configs/stm32mp21_defconfig                    |  78 ++++++++++
 include/configs/stm32mp21_common.h             | 126 ++++++++++++++++
 include/configs/stm32mp21_st_common.h          |  51 +++++++
 15 files changed, 564 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
index 2716844b259..31b2746379d 100644
--- a/arch/arm/mach-stm32mp/Kconfig
+++ b/arch/arm/mach-stm32mp/Kconfig
@@ -84,6 +84,32 @@ config STM32MP15X
 		STMicroelectronics MPU with core ARMv7
 		dual core A7 for STM32MP157/3, monocore for STM32MP151
 
+config STM32MP21X
+	bool "Support STMicroelectronics STM32MP21x Soc"
+	select ARM64
+	select CLK_STM32MP21
+	select OF_BOARD
+	select PINCTRL_STM32
+	select STM32_RCC
+	select STM32_RESET
+	select STM32_SERIAL
+	select STM32MP_TAMP_NVMEM
+	select SYS_ARCH_TIMER
+	select TFABOOT
+	imply CLK_SCMI
+	imply CMD_NVEDIT_INFO
+	imply DM_REGULATOR
+	imply DM_REGULATOR_SCMI
+	imply OF_UPSTREAM
+	imply OPTEE
+	imply RESET_SCMI
+	imply SYSRESET_PSCI
+	imply TEE
+	imply VERSION_VARIABLE
+	help
+		Support of STMicroelectronics SOC STM32MP21X family
+		STMicroelectronics MPU with 1 A35 core and 1 M33 core
+
 config STM32MP23X
 	bool "Support STMicroelectronics STM32MP23x Soc"
 	select ARM64
@@ -195,6 +221,7 @@ config MFD_STM32_TIMERS
 
 source "arch/arm/mach-stm32mp/Kconfig.13x"
 source "arch/arm/mach-stm32mp/Kconfig.15x"
+source "arch/arm/mach-stm32mp/Kconfig.21x"
 source "arch/arm/mach-stm32mp/Kconfig.23x"
 source "arch/arm/mach-stm32mp/Kconfig.25x"
 source "arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig"
diff --git a/arch/arm/mach-stm32mp/Kconfig.21x b/arch/arm/mach-stm32mp/Kconfig.21x
new file mode 100644
index 00000000000..dbde3d75ad4
--- /dev/null
+++ b/arch/arm/mach-stm32mp/Kconfig.21x
@@ -0,0 +1,37 @@
+if STM32MP21X
+
+choice
+	prompt "STM32MP21X board select"
+	optional
+
+config TARGET_ST_STM32MP21X
+	bool "STMicroelectronics STM32MP21X boards"
+	imply BOOTSTAGE
+	imply CMD_BOOTSTAGE
+	help
+		target the STMicroelectronics board with SOC STM32MP21X
+		managed by board/st/stm32mp2
+		The difference between board are managed with devicetree
+
+endchoice
+
+config TEXT_BASE
+	default 0x84000000
+
+config PRE_CON_BUF_ADDR
+	default 0x84800000
+
+config PRE_CON_BUF_SZ
+	default 4096
+
+if DEBUG_UART
+
+# debug on USART2 by default
+config DEBUG_UART_BASE
+	default 0x400e0000
+
+endif
+
+source "board/st/stm32mp2/Kconfig"
+
+endif
diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
index eeb5fdd7b45..853469f3c50 100644
--- a/arch/arm/mach-stm32mp/Makefile
+++ b/arch/arm/mach-stm32mp/Makefile
@@ -8,8 +8,9 @@ obj-y += syscon.o
 obj-y += bsec.o
 obj-y += soc.o
 
-obj-$(CONFIG_STM32MP15X) += stm32mp1/
 obj-$(CONFIG_STM32MP13X) += stm32mp1/
+obj-$(CONFIG_STM32MP15X) += stm32mp1/
+obj-$(CONFIG_STM32MP21X) += stm32mp2/
 obj-$(CONFIG_STM32MP23X) += stm32mp2/
 obj-$(CONFIG_STM32MP25X) += stm32mp2/
 
diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 90f06a052d3..7f349f3b68d 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -165,16 +165,20 @@ enum forced_boot_mode {
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_STM32MP15X || CONFIG_STM32MP13X */
 
-#if defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
+#if defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
 #define STM32_USART2_BASE		0x400E0000
 #define STM32_USART3_BASE		0x400F0000
 #define STM32_UART4_BASE		0x40100000
 #define STM32_UART5_BASE		0x40110000
 #define STM32_USART6_BASE		0x40220000
+#ifdef CONFIG_STM32MP25X
 #define STM32_UART9_BASE		0x402C0000
+#endif
 #define STM32_USART1_BASE		0x40330000
 #define STM32_UART7_BASE		0x40370000
+#ifdef CONFIG_STM32MP25X
 #define STM32_UART8_BASE		0x40380000
+#endif
 #define STM32_RCC_BASE			0x44200000
 #define STM32_TAMP_BASE			0x46010000
 #define STM32_SDMMC1_BASE		0x48220000
@@ -194,7 +198,7 @@ enum forced_boot_mode {
 
 #define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
 #define TAMP_FWU_BOOT_IDX_OFFSET	0
-#endif /* defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
+#endif /* defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
 
 /* offset used for BSEC driver: misc_read and misc_write */
 #define STM32_BSEC_SHADOW_OFFSET	0x0
@@ -218,14 +222,14 @@ enum forced_boot_mode {
 #define BSEC_OTP_MAC	57
 #define BSEC_OTP_BOARD	60
 #endif
-#if defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
+#if defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X)
 #define BSEC_OTP_SERIAL	5
 #define BSEC_OTP_RPN	9
 #define BSEC_OTP_REVID	102
 #define BSEC_OTP_PKG	122
 #define BSEC_OTP_BOARD	246
 #define BSEC_OTP_MAC	247
-#endif /* defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
+#endif /* defined(CONFIG_STM32MP21X) || defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
index 2a4837184fc..47a6db79bca 100644
--- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
+++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
@@ -30,6 +30,20 @@
 #define CPU_STM32MP131Fxx	0x05010EC8
 #define CPU_STM32MP131Dxx	0x05010EC9
 
+/* ID for STM32MP21x = Device Part Number (RPN) (bit31:0) */
+#define CPU_STM32MP211Axx	0x40073E7D
+#define CPU_STM32MP211Cxx	0x0007307D
+#define CPU_STM32MP211Dxx	0xC0073E7D
+#define CPU_STM32MP211Fxx	0x8007307D
+#define CPU_STM32MP213Axx	0x40073E1D
+#define CPU_STM32MP213Cxx	0x0007301D
+#define CPU_STM32MP213Dxx	0xC0073E1D
+#define CPU_STM32MP213Fxx	0x8007301D
+#define CPU_STM32MP215Axx	0x40033E0D
+#define CPU_STM32MP215Cxx	0x0003300D
+#define CPU_STM32MP215Dxx	0xC0033E0D
+#define CPU_STM32MP215Fxx	0x80
+
 /* ID for STM32MP23x = Device Part Number (RPN) (bit31:0) */
 #define CPU_STM32MP235Cxx	0x00082182
 #define CPU_STM32MP233Cxx	0x000B318E
@@ -67,6 +81,7 @@ u32 get_cpu_type(void);
 
 #define CPU_DEV_STM32MP15	0x500
 #define CPU_DEV_STM32MP13	0x501
+#define CPU_DEV_STM32MP21	0x503
 #define CPU_DEV_STM32MP23	0x505
 #define CPU_DEV_STM32MP25	0x505
 
@@ -102,6 +117,13 @@ u32 get_cpu_package(void);
 #define STM32MP15_PKG_AD_TFBGA257	1
 #define STM32MP15_PKG_UNKNOWN		0
 
+/* package used for STM32MP21x */
+#define STM32MP21_PKG_CUSTOM		0
+#define STM32MP21_PKG_AL_VFBGA361	1
+#define STM32MP21_PKG_AN_VFBGA273	3
+#define STM32MP21_PKG_AO_VFBGA225	4
+#define STM32MP21_PKG_AM_TFBGA289	5
+
 /* package used for STM32MP23x */
 #define STM32MP23_PKG_CUSTOM		0
 #define STM32MP23_PKG_AL_VFBGA361	1
diff --git a/arch/arm/mach-stm32mp/stm32mp2/Makefile b/arch/arm/mach-stm32mp/stm32mp2/Makefile
index 27fbf3ae728..b25af2e8934 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/Makefile
+++ b/arch/arm/mach-stm32mp/stm32mp2/Makefile
@@ -7,5 +7,6 @@ obj-y += cpu.o
 obj-y += arm64-mmu.o
 obj-y += rifsc.o
 obj-$(CONFIG_OF_SYSTEM_SETUP) += fdt.o
+obj-$(CONFIG_STM32MP21X) += stm32mp21x.o
 obj-$(CONFIG_STM32MP23X) += stm32mp23x.o
 obj-$(CONFIG_STM32MP25X) += stm32mp25x.o
diff --git a/arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c b/arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c
index 36c631ef0c2..4f418b65d38 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/arm64-mmu.c
@@ -16,6 +16,7 @@
 
 struct mm_region stm32mp2_mem_map[MP2_MEM_MAP_MAX] = {
 	{
+#if defined(CONFIG_STM32MP25X)
 		/* PCIe */
 		.virt = 0x10000000UL,
 		.phys = 0x10000000UL,
@@ -24,6 +25,7 @@ struct mm_region stm32mp2_mem_map[MP2_MEM_MAP_MAX] = {
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
 	}, {
+#endif
 		/* LPSRAMs, VDERAM, RETRAM, SRAMs, SYSRAM: alias1 */
 		.virt = 0x20000000UL,
 		.phys = 0x20000000UL,
diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
index e081dc605b8..75befecbc2b 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
@@ -128,8 +128,10 @@ static void setup_boot_mode(void)
 		STM32_UART5_BASE,
 		STM32_USART6_BASE,
 		STM32_UART7_BASE,
+#ifdef CONFIG_STM32MP25X
 		STM32_UART8_BASE,
 		STM32_UART9_BASE
+#endif
 	};
 	const u32 sdmmc_addr[] = {
 		STM32_SDMMC1_BASE,
diff --git a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
index f8f67af4449..cf8026088f3 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
+++ b/arch/arm/mach-stm32mp/stm32mp2/rifsc.c
@@ -367,6 +367,7 @@ static int stm32_rifsc_remove(struct udevice *bus)
 }
 
 static const struct udevice_id stm32_rifsc_ids[] = {
+	{ .compatible = "st,stm32mp21-rifsc" },
 	{ .compatible = "st,stm32mp25-rifsc" },
 	{},
 };
diff --git a/arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c b/arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c
new file mode 100644
index 00000000000..40d0f329496
--- /dev/null
+++ b/arch/arm/mach-stm32mp/stm32mp2/stm32mp21x.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright (C) 2026, STMicroelectronics - All Rights Reserved
+ */
+
+#define LOG_CATEGORY LOGC_ARCH
+
+#include <log.h>
+#include <syscon.h>
+#include <asm/io.h>
+#include <asm/arch/stm32.h>
+#include <asm/arch/sys_proto.h>
+
+/* SYSCFG register */
+#define SYSCFG_DEVICEID_OFFSET		0x6400
+#define SYSCFG_DEVICEID_DEV_ID_MASK	GENMASK(11, 0)
+#define SYSCFG_DEVICEID_DEV_ID_SHIFT	0
+
+/* Revision ID = OTP102[5:0] 6 bits : 3 for Major / 3 for Minor*/
+#define REVID_SHIFT	0
+#define REVID_MASK	GENMASK(5, 0)
+
+/* Device Part Number (RPN) = OTP9 */
+#define RPN_SHIFT	0
+#define RPN_MASK	GENMASK(31, 0)
+
+/* Package = bit 0:2 of OTP122 => STM32MP21_PKG defines
+ * - 000: Custom package
+ * - 001: VFBGA361 => AL = 10x10, 361 balls pith 0.5mm
+ * - 011: VFBGA273 => AN = 11x11, 273 balls pith 0.5mm
+ * - 100: VFBGA225 => AO =   8x8, 225 balls pith 0.5mm
+ * - 101: TFBGA289 => AM = 14x14, 289 balls pith 0.8mm
+ * - others: Reserved
+ */
+#define PKG_SHIFT	0
+#define PKG_MASK	GENMASK(2, 0)
+
+static u32 read_deviceid(void)
+{
+	void *syscfg = syscon_get_first_range(STM32MP_SYSCON_SYSCFG);
+
+	return readl(syscfg + SYSCFG_DEVICEID_OFFSET);
+}
+
+u32 get_cpu_dev(void)
+{
+	return (read_deviceid() & SYSCFG_DEVICEID_DEV_ID_MASK) >> SYSCFG_DEVICEID_DEV_ID_SHIFT;
+}
+
+u32 get_cpu_rev(void)
+{
+	return get_otp(BSEC_OTP_REVID, REVID_SHIFT, REVID_MASK);
+}
+
+/* Get Device Part Number (RPN) from OTP */
+u32 get_cpu_type(void)
+{
+	return get_otp(BSEC_OTP_RPN, RPN_SHIFT, RPN_MASK);
+}
+
+/* Get Package options from OTP */
+u32 get_cpu_package(void)
+{
+	return get_otp(BSEC_OTP_PKG, PKG_SHIFT, PKG_MASK);
+}
+
+int get_eth_nb(void)
+{
+	int nb_eth;
+
+	switch (get_cpu_type()) {
+	case CPU_STM32MP215Axx:
+		fallthrough;
+	case CPU_STM32MP215Cxx:
+		fallthrough;
+	case CPU_STM32MP215Dxx:
+		fallthrough;
+	case CPU_STM32MP215Fxx:
+		fallthrough;
+	case CPU_STM32MP213Axx:
+		fallthrough;
+	case CPU_STM32MP213Cxx:
+		fallthrough;
+	case CPU_STM32MP213Dxx:
+		fallthrough;
+	case CPU_STM32MP213Fxx:
+		nb_eth = 2; /* dual ETH */
+		break;
+	case CPU_STM32MP211Axx:
+		fallthrough;
+	case CPU_STM32MP211Cxx:
+		fallthrough;
+	case CPU_STM32MP211Dxx:
+		fallthrough;
+	case CPU_STM32MP211Fxx:
+		nb_eth = 1; /* single ETH */
+		break;
+	default:
+		nb_eth = 0;
+		break;
+	}
+
+	return nb_eth;
+}
+
+void get_soc_name(char name[SOC_NAME_SIZE])
+{
+	char *cpu_s, *cpu_r, *package;
+
+	cpu_s = "????";
+	cpu_r = "?";
+	package = "??";
+	if (get_cpu_dev() == CPU_DEV_STM32MP21) {
+		switch (get_cpu_type()) {
+		case CPU_STM32MP215Fxx:
+			cpu_s = "215F";
+			break;
+		case CPU_STM32MP215Dxx:
+			cpu_s = "215D";
+			break;
+		case CPU_STM32MP215Cxx:
+			cpu_s = "215C";
+			break;
+		case CPU_STM32MP215Axx:
+			cpu_s = "215A";
+			break;
+		case CPU_STM32MP213Fxx:
+			cpu_s = "213F";
+			break;
+		case CPU_STM32MP213Dxx:
+			cpu_s = "213D";
+			break;
+		case CPU_STM32MP213Cxx:
+			cpu_s = "213C";
+			break;
+		case CPU_STM32MP213Axx:
+			cpu_s = "213A";
+			break;
+		case CPU_STM32MP211Fxx:
+			cpu_s = "211F";
+			break;
+		case CPU_STM32MP211Dxx:
+			cpu_s = "211D";
+			break;
+		case CPU_STM32MP211Cxx:
+			cpu_s = "211C";
+			break;
+		case CPU_STM32MP211Axx:
+			cpu_s = "211A";
+			break;
+		default:
+			cpu_s = "21??";
+			break;
+		}
+		/* REVISION */
+		switch (get_cpu_rev()) {
+		case OTP_REVID_1:
+			cpu_r = "A";
+			break;
+		case OTP_REVID_1_1:
+			cpu_r = "Z";
+			break;
+		case OTP_REVID_2:
+			cpu_r = "B";
+			break;
+		default:
+			break;
+		}
+		/* PACKAGE */
+		switch (get_cpu_package()) {
+		case STM32MP25_PKG_CUSTOM:
+			package = "XX";
+			break;
+		case STM32MP21_PKG_AL_VFBGA361:
+			package = "AL";
+			break;
+		case STM32MP21_PKG_AN_VFBGA273:
+			package = "AN";
+			break;
+		case STM32MP21_PKG_AO_VFBGA225:
+			package = "AO";
+			break;
+		case STM32MP21_PKG_AM_TFBGA289:
+			package = "AM";
+			break;
+		default:
+			break;
+		}
+	}
+
+	snprintf(name, SOC_NAME_SIZE, "STM32MP%s%s Rev.%s", cpu_s, package, cpu_r);
+}
diff --git a/board/st/common/Kconfig b/board/st/common/Kconfig
index 94ec806949b..3d00f3f3331 100644
--- a/board/st/common/Kconfig
+++ b/board/st/common/Kconfig
@@ -1,7 +1,7 @@
 config CMD_STBOARD
 	bool "stboard - command for OTP board information"
 	depends on ARCH_STM32MP
-	default y if TARGET_ST_STM32MP13X || TARGET_ST_STM32MP15X || TARGET_ST_STM32MP23X || TARGET_ST_STM32MP25X
+	default y if TARGET_ST_STM32MP13X || TARGET_ST_STM32MP15X || TARGET_ST_STM32MP21X || TARGET_ST_STM32MP23X || TARGET_ST_STM32MP25X
 	help
 	  This compile the stboard command to
 	  read and write the board in the OTP.
diff --git a/board/st/stm32mp2/Kconfig b/board/st/stm32mp2/Kconfig
index e88c71a278e..d8882f113b6 100644
--- a/board/st/stm32mp2/Kconfig
+++ b/board/st/stm32mp2/Kconfig
@@ -1,3 +1,17 @@
+if TARGET_ST_STM32MP21X
+
+config SYS_BOARD
+	default "stm32mp2"
+
+config SYS_VENDOR
+	default "st"
+
+config SYS_CONFIG_NAME
+	default "stm32mp21_st_common"
+
+source "board/st/common/Kconfig"
+endif
+
 if TARGET_ST_STM32MP23X
 
 config SYS_BOARD
diff --git a/configs/stm32mp21_defconfig b/configs/stm32mp21_defconfig
new file mode 100644
index 00000000000..8ad31292579
--- /dev/null
+++ b/configs/stm32mp21_defconfig
@@ -0,0 +1,78 @@
+CONFIG_ARM=y
+CONFIG_ARCH_STM32MP=y
+CONFIG_SYS_MALLOC_F_LEN=0x600000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x90000000
+CONFIG_ENV_OFFSET=0x900000
+CONFIG_ENV_SECT_SIZE=0x40000
+CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp215f-dk"
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_SYS_LOAD_ADDR=0x84000000
+CONFIG_STM32MP21X=y
+CONFIG_DDR_CACHEABLE_SIZE=0x10000000
+CONFIG_CMD_STM32KEY=y
+CONFIG_TARGET_ST_STM32MP21X=y
+CONFIG_SYS_MEMTEST_START=0x84000000
+CONFIG_SYS_MEMTEST_END=0x88000000
+CONFIG_API=y
+CONFIG_SYS_MMC_MAX_DEVICE=3
+CONFIG_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=1
+CONFIG_BOOTCOMMAND="run bootcmd_stm32mp"
+CONFIG_SYS_PROMPT="STM32MP> "
+# CONFIG_CMD_BDI is not set
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_ADTIMG=y
+# CONFIG_CMD_ELF is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_LOADB is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_RNG=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_LOG=y
+CONFIG_CMD_UBI=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
+CONFIG_OF_UPSTREAM_VENDOR="st"
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_IS_IN_UBI=y
+CONFIG_ENV_UBI_PART="UBI"
+CONFIG_ENV_UBI_VOLUME="uboot_config"
+CONFIG_NO_NET=y
+CONFIG_SYS_64BIT_LBA=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_STM32F7=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_STM32_SDMMC2=y
+CONFIG_MTD=y
+CONFIG_USE_SYS_MAX_FLASH_BANKS=y
+CONFIG_SPI_FLASH=y
+CONFIG_PINCONF=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_RAM=y
+# CONFIG_STM32MP1_DDR is not set
+CONFIG_DM_RNG=y
+CONFIG_SERIAL_RX_BUFFER=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+# CONFIG_OPTEE_TA_AVB is not set
+CONFIG_WDT=y
+CONFIG_WDT_STM32MP=y
+CONFIG_WDT_ARM_SMC=y
+# CONFIG_UBIFS_SILENCE_DEBUG_DUMP is not set
+CONFIG_ERRNO_STR=y
diff --git a/include/configs/stm32mp21_common.h b/include/configs/stm32mp21_common.h
new file mode 100644
index 00000000000..e5129b13b3e
--- /dev/null
+++ b/include/configs/stm32mp21_common.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*
+ * Copyright (C) 2026, STMicroelectronics - All Rights Reserved
+ *
+ * Configuration settings for the STM32MP21x CPU
+ */
+
+#ifndef __CONFIG_STM32MP21_COMMMON_H
+#define __CONFIG_STM32MP21_COMMMON_H
+#include <linux/sizes.h>
+#include <asm/arch/stm32.h>
+
+/*
+ * Configuration of the external SRAM memory used by U-Boot
+ */
+#define CFG_SYS_SDRAM_BASE	STM32_DDR_BASE
+
+/*
+ * For booting Linux, use the first 256 MB of memory, since this is
+ * the maximum mapped by the Linux kernel during initialization.
+ */
+#define CFG_SYS_BOOTMAPSZ	SZ_256M
+
+/*****************************************************************************/
+#ifdef CONFIG_DISTRO_DEFAULTS
+/*****************************************************************************/
+
+#ifdef CONFIG_NET
+#define BOOT_TARGET_PXE(func)	func(PXE, pxe, na)
+#else
+#define BOOT_TARGET_PXE(func)
+#endif
+
+#ifdef CONFIG_CMD_MMC
+#define BOOT_TARGET_MMC0(func)	func(MMC, mmc, 0)
+#define BOOT_TARGET_MMC1(func)	func(MMC, mmc, 1)
+#define BOOT_TARGET_MMC2(func)	func(MMC, mmc, 2)
+#else
+#define BOOT_TARGET_MMC0(func)
+#define BOOT_TARGET_MMC1(func)
+#define BOOT_TARGET_MMC2(func)
+#endif
+
+#ifdef CONFIG_CMD_UBIFS
+#define BOOT_TARGET_UBIFS(func)	func(UBIFS, ubifs, 0, UBI, boot)
+#else
+#define BOOT_TARGET_UBIFS(func)
+#endif
+
+#ifdef CONFIG_CMD_USB
+#define BOOT_TARGET_USB(func)	func(USB, usb, 0)
+#else
+#define BOOT_TARGET_USB(func)
+#endif
+
+#define BOOT_TARGET_DEVICES(func)	\
+	BOOT_TARGET_MMC1(func)		\
+	BOOT_TARGET_UBIFS(func)		\
+	BOOT_TARGET_MMC0(func)		\
+	BOOT_TARGET_MMC2(func)		\
+	BOOT_TARGET_USB(func)		\
+	BOOT_TARGET_PXE(func)
+
+/*
+ * default bootcmd for stm32mp21:
+ * for serial/usb: execute the stm32prog command
+ * for mmc boot (eMMC, SD card), distro boot on the same mmc device
+ * for NAND or SPI-NAND boot, distro boot with UBIFS on UBI partition
+ * for other boot, use the default distro order in ${boot_targets}
+ */
+#define STM32MP_BOOTCMD "bootcmd_stm32mp=" \
+	"echo \"Boot over ${boot_device}${boot_instance}!\";" \
+	"if test ${boot_device} = serial || test ${boot_device} = usb;" \
+	"then stm32prog ${boot_device} ${boot_instance}; " \
+	"else " \
+		"run env_check;" \
+		"if test ${boot_device} = mmc;" \
+		"then env set boot_targets \"mmc${boot_instance}\"; fi;" \
+		"if test ${boot_device} = nand ||" \
+		  " test ${boot_device} = spi-nand ;" \
+		"then env set boot_targets ubifs0; fi;" \
+		"run distro_bootcmd;" \
+	"fi;\0"
+
+#ifndef STM32MP_BOARD_EXTRA_ENV
+#define STM32MP_BOARD_EXTRA_ENV
+#endif
+
+#define STM32MP_EXTRA \
+	"env_check=if env info -p -d -q; then env save; fi\0" \
+	"boot_net_usb_start=true\0"
+/*
+ * memory layout for 96MB uncompressed/compressed kernel,
+ * 1M fdt, 1M script, 1M pxe and 1M for overlay
+ * and the ramdisk at the end.
+ */
+#define __KERNEL_COMP_ADDR_R	__stringify(0x84000000)
+#define __KERNEL_COMP_SIZE_R	__stringify(0x04000000)
+#define __KERNEL_ADDR_R		__stringify(0x8a000000)
+#define __FDT_ADDR_R		__stringify(0x90000000)
+#define __SCRIPT_ADDR_R		__stringify(0x90100000)
+#define __PXEFILE_ADDR_R	__stringify(0x90200000)
+#define __FDTOVERLAY_ADDR_R	__stringify(0x90300000)
+#define __RAMDISK_ADDR_R	__stringify(0x90400000)
+
+#define STM32MP_MEM_LAYOUT \
+	"kernel_addr_r=" __KERNEL_ADDR_R "\0" \
+	"fdt_addr_r=" __FDT_ADDR_R "\0" \
+	"scriptaddr=" __SCRIPT_ADDR_R "\0" \
+	"pxefile_addr_r=" __PXEFILE_ADDR_R "\0" \
+	"fdtoverlay_addr_r=" __FDTOVERLAY_ADDR_R "\0" \
+	"ramdisk_addr_r=" __RAMDISK_ADDR_R "\0" \
+	"kernel_comp_addr_r=" __KERNEL_COMP_ADDR_R "\0"	\
+	"kernel_comp_size=" __KERNEL_COMP_SIZE_R "\0"
+
+#include <config_distro_bootcmd.h>
+#define CFG_EXTRA_ENV_SETTINGS \
+	STM32MP_MEM_LAYOUT \
+	STM32MP_BOOTCMD \
+	BOOTENV \
+	STM32MP_EXTRA \
+	STM32MP_BOARD_EXTRA_ENV
+
+#endif
+
+#endif /* __CONFIG_STM32MP21_COMMMON_H */
diff --git a/include/configs/stm32mp21_st_common.h b/include/configs/stm32mp21_st_common.h
new file mode 100644
index 00000000000..c601f2d7fb6
--- /dev/null
+++ b/include/configs/stm32mp21_st_common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*
+ * Copyright (C) 2026, STMicroelectronics - All Rights Reserved
+ *
+ * Configuration settings for the STMicroelectonics STM32MP21x boards
+ */
+
+#ifndef __CONFIG_STM32MP21_ST_COMMON_H__
+#define __CONFIG_STM32MP21_ST_COMMON_H__
+
+#define STM32MP_BOARD_EXTRA_ENV \
+	"usb_pgood_delay=2000\0" \
+	"console=ttySTM0\0"
+
+#include <configs/stm32mp21_common.h>
+
+#ifdef CFG_EXTRA_ENV_SETTINGS
+/*
+ * default bootcmd for stm32mp21 STMicroelectronics boards:
+ * for serial/usb: execute the stm32prog command
+ * for mmc boot (eMMC, SD card), distro boot on the same mmc device
+ * for nand or spi-nand boot, distro boot with ubifs on UBI partition or
+ * sdcard
+ * for nor boot, distro boot on SD card = mmc0 ONLY !
+ */
+#define ST_STM32MP21_BOOTCMD "bootcmd_stm32mp=" \
+	"echo \"Boot over ${boot_device}${boot_instance}!\";" \
+	"if test ${boot_device} = serial || test ${boot_device} = usb;" \
+	"then stm32prog ${boot_device} ${boot_instance}; " \
+	"else " \
+		"run env_check;" \
+		"if test ${boot_device} = mmc;" \
+		"then env set boot_targets \"mmc${boot_instance}\"; fi;" \
+		"if test ${boot_device} = nand ||" \
+		  " test ${boot_device} = spi-nand ;" \
+		"then env set boot_targets ubifs0 mmc0; fi;" \
+		"if test ${boot_device} = nor;" \
+		"then env set boot_targets mmc0; fi;" \
+		"run distro_bootcmd;" \
+	"fi;\0"
+
+#undef CFG_EXTRA_ENV_SETTINGS
+#define CFG_EXTRA_ENV_SETTINGS \
+	STM32MP_MEM_LAYOUT \
+	ST_STM32MP21_BOOTCMD \
+	BOOTENV \
+	STM32MP_EXTRA \
+	STM32MP_BOARD_EXTRA_ENV
+
+#endif
+#endif

-- 
2.43.0

