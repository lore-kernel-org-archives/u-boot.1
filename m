Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCBACD5BD0
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 09:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C642844CF;
	Tue, 26 May 2026 11:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="jQ1K5ahM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC7A846AC; Tue, 26 May 2026 11:32:34 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A258404D
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 11:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haN+8szprXsjdxE+HzcBEF5DP3GIuCZVbydsBeEjZ48YpftVlIRnQsY6uB+bUT2oC7bw2CChvJbeHOX9qbhdNBo2NDYajU2H6uE1MQjrJUJmfpv4T0sa4XudOVt+GEdz9rH7ILik8efiM1KgGmj4ueBG0z/BREzk7ejwVfrK2ZojWCdKKDiiOI47F5Wy/U1eKkqtA4Q7bmaH5cIbVGjXpJN3N5Ni9f5AX23t03H+E9bJBnJ2xR2IbusRDLkBjLGuGdZm33MJ8y2L3k5ieb1o1mP8DoXPIrX94x86SBI9jPdDPWW9BkK2kFNpWezUvzHPEhdQxMKf0c17ETG2B2tDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTcKeu0wSdN4zWEzcFCPCZN3tajxkCFY0vLazK2NYQE=;
 b=FJO/IE30GQIZRac9Dq1dNUdSJl22ujFeJDu/0I4fBn1bJqSxu1N/76qgtu5ftxYUtsf9YFvrJJ0Yy+wcKdk2dG2haAO4DrHiKHWyLhY5UbJCQEYf8bGQBUnYd7ovWxetV4anPk1trIO1dwEimmQNKOJe4AAw/XxxpEcqFmh2MsnaFtzKuDJi+aAbAS5ymmCOdewh7Iy6uKx4Pt2s7O8SZ+jks4g80X4uUNT0lWkb0ciVLUuoyF++cEB+aWrGb9+vDXbtC/6hEjpP+7CYGDyLyu18/lp3s2WVNqqtDpoC1GRg8Hj31xFWnB3dfZyeFlB57WnzB91/Lh+ENrHNQUpRXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTcKeu0wSdN4zWEzcFCPCZN3tajxkCFY0vLazK2NYQE=;
 b=jQ1K5ahM+hBTLe2q8hR6XH33ATsnK+F34K24012iA1IpO6UJwC6f6BAv0HUwf0KJnyd0QkLq+e2kY0ymAUq7qhhYSWeAjfLRuhxZiziCIqZcBnJvGQ4ZTiF90wfF0qxoPSCD/nxHHRUNF0V4mof04UBzRZazfW8+IWokMGWdz5+LCVgu4qovJ+NFCcLCnHznrxLZCBlyGvLfzisntsmZyXtRCOL0r3pjlUbgx3BCd9TK5nbHbro/lHxNGjXrjfGYcGYV/qcUT5gm3EwvkvMb9NIwNhFVT6f0gwdJD2cGOUBI3cb55wflcqGoT2c6plEUVQb8xk9c+vx5fGRSfzlciA==
Received: from AS4P251CA0011.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::7)
 by DB9PR10MB7364.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:460::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 09:32:28 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::25) by AS4P251CA0011.outlook.office365.com
 (2603:10a6:20b:5d2::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 09:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 09:32:27 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 26 May
 2026 11:36:32 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 26 May
 2026 11:32:26 +0200
Message-ID: <efb24104-5cb8-4073-a171-4977db68fc48@foss.st.com>
Date: Tue, 26 May 2026 11:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] configs: stm32mp15: enable WDT_ARM_SMC driver
To: Yann Gautier <yann.gautier@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260520160715.175032-1-yann.gautier@foss.st.com>
 <20260520160715.175032-2-yann.gautier@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260520160715.175032-2-yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A790:EE_|DB9PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0269dac7-d1b5-47f3-55b4-08debb09b3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 5nYMBiP8WvlrDDRa7tCa77Gtsvxjtg26bG8v6weoDmitWaYCK8bB9Etr4co88wsfgFTMEuuqI7BlijPNWb3oCbgRq82ywkvXh10N0gLGqsaD45046o+7JJpaa81EFLEYLDHzXPnFn+bQ+ehZ6aESKvqrrrkZLoRGW3K7uVpfkWK3MCv2Lh+SxXBImPy7QlT+OG0ZatAAozF6lkxaBlpHmviVe/BkqDlxWgk3ttcpR4Y7RVsDZOtcjKFzWDqgvuXRZGfnvdX0ARr6m2E98AT+l/WgSS26Oea9hxamRWEL4d1/ruIXUKTyy9J6CU9Q6x9cjJZYPY80ceQbafMViR6pSrG+eVAFG0LXiiljl7JV8O+vBzuW9XLe8zS2XQWf0ZtKQhmSgVfKuyAHDLgN1Cqkks5SAL2fZ6QB2fE2ZGiR4SNJ41yiLaBEzFzjc6rRgR6/sxuFqPuqGP2cdXQvwm5Q9AZ1W3NzeZSarPERtcSPJCXsSajvIxta7bgw3uuD4ZKiUBoyBKfmClozvSRg/qKk3IuXvUwTcbRax7PDnOy+kFKf6azXWyA3uYxHridpVdg4mO3x7uyS8zQQnNx6vizt4EKmk4xTcbYBTegMrg93AreeN+6NWIsX1ZPW/Qbfot7pAZq0rA1eyfiw3J/9r4sL3CrqRnFQKi8cTnbN5yoFdYRcaK19BdPk9EmSjEks1KRKXGL2X6/GjkCULG9JnNGHwajkb070GdXKF4oSfNfOG04=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AcWDM8i97CRCXIm49pLkithCKitk6qpkUGMYrLBwDYwo5sUzAt5SuP1hAqLyNwO+UtiwY/imfpXedfKnj/yO+gL+h3/fm8l3tbwrOQYnXw/3JnCa7nseRq8oQ33AuJRtMBQ02JNqvjntNY5AttXvHEL99OMr3H98+3gmwUA2YuwHQRwPweWzdHzRt1j4s0AA8B2qmQ0zgqWEVL4H/dakXNxEpBF1U3Cis//SaPBnlMwC0lgdqPiI8XVwlrRno1Ijg/LCUZaeyN9RveSsqNSK6jINca3NgRm66q8zZrVBz6u5nvSYfEnMcNht82UU2lA2t01LVee61RnmNkSqgfsmZ4wsZClysTEfv7uwKtxBOynLAYhxL1RyClNTNC/Ph/Q+l9nw3/B1/IVNMHzxrF3vQYAkq7pHd50ym3rnzm90BR38bJkRS3uBpQYXHFR5aewz
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 09:32:27.7760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0269dac7-d1b5-47f3-55b4-08debb09b3ca
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7364
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



On 5/20/26 18:07, Yann Gautier wrote:
> From: Lionel Debieve <lionel.debieve@foss.st.com>
> 
> Enable the arm watchdog over SMC driver. This allows using a secure
> watchdog, based on IWDG1 peripheral and managed by OP-TEE.
> The driver will be probed if a watchdog node with "arm,smc-wdt"
> compatible is enabled.
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> 
> ---
> 
> Changes in v3:
> - Update patch 1 commit message
> - Remove CONFIG_WDT_STM32MP for MP13 and update patch 2 commit message
>     - update commit message
> 
> Changes in v2:
> - Improve patch 2 commit message
> - Add Reviewed-by tags from Patrice for patches 1 & 3
> 
>  configs/stm32mp15_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
> index b9e44254087a..2ee08dc15551 100644
> --- a/configs/stm32mp15_defconfig
> +++ b/configs/stm32mp15_defconfig
> @@ -169,5 +169,6 @@ CONFIG_BMP_24BPP=y
>  CONFIG_BMP_32BPP=y
>  CONFIG_WDT=y
>  CONFIG_WDT_STM32MP=y
> +CONFIG_WDT_ARM_SMC=y
>  # CONFIG_BINMAN_FDT is not set
>  CONFIG_ERRNO_STR=y

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
