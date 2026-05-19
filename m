Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DABCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35490847C5;
	Tue, 19 May 2026 15:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="TpFEMcZG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D3884839; Tue, 19 May 2026 15:51:30 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF11846F2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUN07oggOQGNMEUEPWxQhaxY4jI/m4khVy5gDtZxl2drXs9zvV6nmNvYvR88X+khp6q1F/KqGQ1XXoq3PxuTcrrvI4M1yzoFmD6tIELNwwpDBxDyOqFYQEh5W0A5vAd51msbNC3BeLCDwHUd6Ts5BywX8IxIUzBGcTKed6YzS984KYbXU0YdsrFEqjz9gYItoHph1vC/JuDrzPCaiNs4BzeUD3KNCR3ZIPDzjNYwsiBHfgM2mE7YKxEXKdFzNxr+f7ye/MYM8JGnD6U5m0V1MNQWiIXq9BvN70pQHLd7eaZ20T+g99sg68R1S4qRIisDMFJqhBABMmToeHF53MXctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUEgyOwKLzfUuWaCWNMNELBgYko6/Gj4Rd9e88wfSI4=;
 b=tLij7+eJd0ZDTDbDEnocW3MzRVQhM7RZeL21AGQTeh/Iy62TnPtkbYMjYDhoD1iF0AZDSJoYcDRlqW7vlA0n9QyxbuB5Z3xbrmOJMcKL5Kio4X57o8+WnNP23PFGiphbNtZpAGXxY09VerX9+/DEKvOITic2W7Lkp2z1zrEQGgTdt+9FKQPeZ0fz0zUyS3mrUTUI41aTp8cCxTxa8vTeuDHexC+qsj9X2Sx3FODvdr5r+I6+bZn5f50lZCDTMFWle1Ri7GHDMG6cEBRVmicO/N3UU7eqqWQHJT7EwgLj/rmtX8Gi9/gcc0jaOEBq7RwcEn35OAY1A9oaaAhnQbhSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUEgyOwKLzfUuWaCWNMNELBgYko6/Gj4Rd9e88wfSI4=;
 b=TpFEMcZGF5F0QNfeO1uVsOj+YvkLpJKiLxpyGCuF+UY8mq1zX842lts8dY1llAy1cEWc9+7dP+HIsJeA11ZRdqyKdBTArsaX0e4Fyed66edzBc9yqAIp7WLP/eK9Iyoh4y0dyB1zwgi5QBaoo99GQveRXnIzYx+zs0EWCuLCAZwWVGLtQDO2g/If30nNAY4VroGU/M5hWpfQ03943uyoassR8cJpFYQb0exAJHZuKA7rYIdCBPYUQBlGPMyY7AwRREP+BVBQeBEQ3VMfCOEln1N4OXxuWeR263vP06GdvyJ7czn32fWifhqEFGQkDGY5u8JUMNP2QwP69+drLDd+tA==
Received: from DB7PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:10:36::36)
 by GVXPR10MB5837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Tue, 19 May
 2026 13:51:20 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::a1) by DB7PR05CA0023.outlook.office365.com
 (2603:10a6:10:36::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 13:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 13:51:20 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 15:54:48 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 15:51:19 +0200
Message-ID: <30aaa3ef-fd77-4300-af99-dcd777ee700c@foss.st.com>
Date: Tue, 19 May 2026 15:51:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] configs: stm32: enable WDT_ARM_SMC driver
To: Yann Gautier <yann.gautier@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Christophe KERELLO
 <christophe.kerello@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260519080737.47928-1-yann.gautier@foss.st.com>
 <20260519080737.47928-2-yann.gautier@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260519080737.47928-2-yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B90:EE_|GVXPR10MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b94d44-b9ee-42eb-0d31-08deb5adb51d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: mUaaI7aKjct0N6UKj/swSUrd6+PVXyUhqSBCY3UySMwImI+Rv1pZ252UdYRKchwQQzodSRGj0v9VNWaWkYa/BvuxB0jgU3vzkl3PY893wnQ70JBriNNxgqOzwW0t5fxa2WcPX6J9GnVcqEbX6qyT0TTLCY9D6bCKD+lo3423Rv31zgiIesMkn20lMPJBdujQ31vC6dD0iuiqUAprcbBzQ2GoywknJRlJsc4hrlZCwDKNKSO42fKQ1vp8YU6IxZaaAQx8rIejRQx0btGxD9FeD+u9hkjQY/b7LUEB0OjfyTv/c4WyLRvextKTyMMHCvrVQINjk1HWeQ3PrFdIIy8F+HcZBOmXIxhy2+s3rwusl3fqqC3CtTNGyWzUUe97uyWyWxu+B2O+zf9KflEuDk+WW4r4BNgQZOMeSbBuvNctq0mL1LfQIfV7o/p77QF6IIjyV40M42UnT1LqMpntTKNj4KkyXY7BkVcaanPFa4B7UyRUFY/ldfIaPr22uONqPw4NjoTJjZuQ7lr81n9Si+M9ciBKnr3aFVPthvvGFIkfnFtkjzuG1RKzwtU8pYTDoj+pdwSpgXzxXczLGmy+nIfA+AAeH/ncJHhGJI+RMvNF8se+utjXPUp8oXU822qoPxg6hNqJJVwYrOByPpM0gk3LHf0c0eRC1ilx0TvCozr5mJK4sHEwYAF12G+QXbQv7GDw5jVa/nHlWGuuyHNdTbN5j8peTNjqE1Wzx1auDzPe00c=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eiH4FCU+gd0n8UZzGpy7rXieKyO2MXrDaP32GCMcsW0GxxY+DUeUW2i8t5+itzHn6ox9VKjicfvvDSXgsNfrFIqoIlpPtbjOEfODQpniCXziEgj2MD7ID3DAG0R2dhXpC7C8zrslC4G9It6DPLjF0vT9I7UXOuppejN+8XIY6An9y6/dCP9+1C+yC/lliBadCY6uAVwJv51jnwjUzBJ6jUW6th8qqrHBw8AFWvqV6ftpyoXy91jGOU35tgt3cbb/Sz19o5vkuhAB8gT9PcwyC/oIQ+vUEQ4F1E6FxxpjDwGBi5Z0ehWVjaU/EHwCmS347dNKp80OsK8FVJrjc7pPLmb/4mTcx8Zjqj2sjiRoFARR1vFz/vAO6OM1J47jj80aK0+H0uKZED8+lJeJ3fMsqVESnfTy2pdPq+EtRZF9d3mtG06p8meum2F+mQ4RDYZr
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:51:20.4548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b94d44-b9ee-42eb-0d31-08deb5adb51d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5837
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



On 5/19/26 10:07, Yann Gautier wrote:
> From: Lionel Debieve <lionel.debieve@foss.st.com>
> 
> Enable the arm watchdog over SMC driver.
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> 
> ---
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
