Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0C606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uSzqMLR5;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=chOrbWIL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FB39605F0;
	Mon, 16 Nov 2026 14:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQ8Zi2_27Y9D; Mon, 16 Nov 2026 14:35:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5033160794
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794839708;
	b=n30pkImoCLQlDVFtC2TwUe5VOj4FQmmlMmXZ7aQ7/8xOfFsGSRDEcpRmRC6qdQKr9HaY
	 +V50GimiuJBoOmDueUz0ErSsQTR+RE6Oim9M1U0vtbasqWUl+QuLUanGbMJaSG8A9kADg
	 ZQNSGHvz1jjU2YT4Yx+JRxaO6HJ3G+I3oOOA+vG3DKT8FYGlwc3E86iLIC6RCXsZgUt0L
	 fyHGLkzCHgaptxdOITl1l9Lu8PaXMWbpCku3Wtvi1GTqH7WM1S/mC7p8Lt6L7HcY2XB8X
	 5nv3D+Xga8eLS7/05EM2+8SH2s2e5mH811acT0j90yqp/JxyGLr53kPNnoTzDNR9E/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794839708;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=iIUqeSsbh05ZuwsZa/BeBYtHci8Ca8QNzP+sTT9cvcs=;
	b=U3QNq9LGwGnA6Pzesk3+MAeXnRe1GctmkH/YKy2w5s4R1fcPb48JJFWZ+rxyxrmQ+UjC
	 +KbUcuKox5fymRhaKLdY9y6ga3+yTSi5qO1GDWE0w47TgjlT/hLvnJ5EYgfNgefl6Xdf8
	 z2Cp15pMYq0J8UEWNjTFLe6eNDr0SLD4n7EqV3EYOMHv69IYExj5/kfhfFKxCInlkv/+M
	 m98Q5HhJI70MN2N7J1nhuP2u00IgKbqt+H6uar3kaDF9RNH3aZMyFJpetTjmoMZxknG88
	 kc+McSJ2I/dj0K1wSyrGKc0QzmMR93Nyvk2BuWk5I2IrjIT5YuCQs7SR7dBnD0WVMKQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794839708;
	bh=iIUqeSsbh05ZuwsZa/BeBYtHci8Ca8QNzP+sTT9cvcs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uSzqMLR5w1LNgB0pai9ORqN5hSRNGRVMU9mGpSUXisuqhBXnr+gYhIXcubLj1O2j/
	 X1pTaTeWLZzsIwLOiZLvsNEiJI4Q7v5fNe6JIoZxaDBIGDMJPI9HZ8i9qRMD3qyuaw
	 kPL1kqlqO2IMOCSR3sPQTNJ1Cd5TmiCWW8DkKaKB9N48509C0DT68+biKGiEYUgVbP
	 63cBjY20iN9xeK4150XWFF+BM1VSjg6qvSJ8nN8Esi/JTncA8l3kdjV5VQ+BCg/6c0
	 u+BS+zUTzxLFQYexiYuKt62g5z5CRc0YvPoSY2N5r6V9WeT1EGshjfuet8FjLIIexA
	 PCPyHP3P/mlDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5033160794;
	Mon, 16 Nov 2026 14:35:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E4082FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FA3880D0B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4of6wp7Kn0e for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 14:35:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 98A4180C68
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=chOrbWIL
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98A4180C68
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIUqeSsbh05ZuwsZa/BeBYtHci8Ca8QNzP+sTT9cvcs=;
 b=chOrbWILfRK1cQRid46PVXVspxZuoKpK9QI7U9Ql6+tIxJDm0NOHOTUBozO4XoUB7hJYttdU2hriSTCZMqQZ2b+3rTxUI/uQ1YVXNmT+/mL3IjGfbrpwAmapoc0mzdDBYI9WVxy5pZ/cM3HORgVa1ZMbNZa0BtYqikfRBU6cX5fohlOv/oDpQeNejUtV02eCTBG68qbZuOptUiC5jXQiA9+mnEmXKP8KlgCsVkg6Ri2KT9Cr++ztgqU8VwIjjTH8AI3iFVQOH/dRHYW8Xr9Q8Q5QlgSFcN2pZA2/X2ByBXbhHaz/wKWzz1R2f+hT++7dm5movAqaBgR6S+cvHuV42g==
Received: from GV3PEPF0001DC21.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::115) by DU4PR10MB8484.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:568::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.4; Mon, 16 Nov
 2026 14:34:59 +0000
Received: from CPH1EPF0000052E.eurprd05.prod.outlook.com (2603:10a6:388::189)
 by GV3PEPF0001DC21.outlook.office365.com (2603:10a6:158:400::115)
 with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Mon, 16 Nov 2026 14:34:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052E.mail.protection.outlook.com (10.167.241.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 14:34:58 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:35:42 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 15:34:57 +0100
Message-ID: <61c70afa-781e-4782-9385-a59ac5513be3@foss.st.com>
Date: Mon, 16 Nov 2026 15:34:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/35] arm: stm32mp: stm32mp2: move boot device
 environment helpers to SoC code
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-25-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20261107143241.2236511-25-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052E:EE_|DU4PR10MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: c98824a3-47da-4ad4-0a23-08df43eeca6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003|261026121527099003|261021135927099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: IwLlYXj2Qb8pQHibbbnDyCk7li2fZSDo/PTzIxvxSb3Rrm9LEVOhUZfbp7iUdbpc2PtR/cXi0rxSE+CRP2GyxQpLXU0rzXa/R40T5us5ZdMVVVl57EUcTPZ31esiRPFw+hIgPUgFDrFjONLpDfd2HoSVt9BBh8tBF5qD6HnuIr5MWrP75hnOzwQGQsBaVhjG/3uYIxUR2ce156MS7VazMJrazo+8uVaT63WtZn/NImEzurVztZxE6KAb60y1Z4Aq6xlZtJNEWXYL3MmW6espFHR7LpeBlw1VH0bLD+oY3ynwB2EfSI0twgLOJcfEwUvFtBDsztiYznz0bbLrRYHLf1Iq2j3TkCrorubn2e/Z+nOYYOBYAFMkhY76yZI5eTrFaXYg5cNDWw7x6syKx+O/CJrMBcN+JV3EUGAu89+EuOy7blFhfzDeT4NArD7FOUt7JoxNV6sMxKUW2DAjsFUbjP9nTuQs2l3d4XieBAl9X4Tu6Y+CC5OeBJJ7seBeGgPQmHM/rfaMcXJntCv+9HyyzqQNoWeSHxv4aMXxRP9y/4jZa3Jf7wYtSapUCZVuK1rp1pHiTPEkkBer+CYC6CZmpgjG90U5IQJsut/mfwfxfw/EyDwOxCj9fRr97HaGPIOFGAn8Jk4NjfeGTkXvq/aEcOqENwl54NbvyWPWe871wiuDoe5Tsd31m5kYDgwv+dqOJwoOFpukcOVGuRZGKVtJKw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003)(261026121527099003)(261021135927099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OABwyealM+RebEWTz8QHHfg/v7sF6WtS2qmOJJcB/xAOfB8lVoBy1Vj+AO1gREGkwNhxlDuqSTkVXXAWEZ/v5jRD/T9zCfjO+an0NE4dVE+sFHHUKYEPSo1sOHSih2IKOThNOuW3RmiznKLDgXiulFuz0bSqAwfHp67ewMS5G/IZn0i0q6TDlPvaWrhqb3G32v3rqtMvR6JhRZ7VjGsYrCWiS/NBgkyEttt70QAvVycklVSCtObGF0AffFr3TBui7imISaD5l0hczsw6UX03zMpRknbUYrRT8uWBh/PVP22eAXYKMtQWQHBpWtAD+Y9yJrBqxGmSAEwUmdXa4bRiN0dHFftNFxbUybSeEbCeUGnGhnVktpud7t0BPLey9uyd7ISrblHunhixmkDLQ5sI/axu8HS3km83xvjbN4h22siF5kHnNeXO547y9swji5rU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:34:58.6304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c98824a3-47da-4ad4-0a23-08df43eeca6d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF0000052E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8484
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/7/26 15:32, Dario Binacchi wrote:
> The environment location and the MMC environment device only depend on
> the boot device reported by the ROM code, so they are not specific to
> the STMicroelectronics boards.
> 
> Move env_get_location(), mmc_get_env_dev() and the mmc_get_boot() helper
> to the SoC code, so that other vendor boards can use them too.
> 
> No functional change intended.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm/mach-stm32mp/stm32mp2/Makefile |  1 +
>  arch/arm/mach-stm32mp/stm32mp2/env.c    | 82 +++++++++++++++++++++++++
>  board/st/stm32mp2/stm32mp2.c            | 71 +--------------------
>  3 files changed, 84 insertions(+), 70 deletions(-)
>  create mode 100644 arch/arm/mach-stm32mp/stm32mp2/env.c
> 
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/Makefile b/arch/arm/mach-stm32mp/stm32mp2/Makefile
> index 8f2e641dcab6..f2def2d1283e 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/Makefile
> +++ b/arch/arm/mach-stm32mp/stm32mp2/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-y += cpu.o
>  obj-y += arm64-mmu.o
> +obj-y += env.o
>  obj-y += rifsc.o
>  obj-y += stm32mp2x.o
>  obj-$(CONFIG_OF_SYSTEM_SETUP) += fdt.o
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/env.c b/arch/arm/mach-stm32mp/stm32mp2/env.c
> new file mode 100644
> index 000000000000..9e7b5b882908
> --- /dev/null
> +++ b/arch/arm/mach-stm32mp/stm32mp2/env.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> +/*
> + * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
> + */
> +
> +#define LOG_CATEGORY LOGC_ARCH
> +
> +#include <config.h>
> +#include <env_internal.h>
> +#include <log.h>
> +#include <mmc.h>
> +#include <asm/arch/sys_proto.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
> +
> +enum env_location env_get_location(enum env_operation op, int prio)
> +{
> +	u32 bootmode = get_bootmode();
> +
> +	if (prio)
> +		return ENVL_UNKNOWN;
> +
> +	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
> +	case BOOT_FLASH_SD:
> +	case BOOT_FLASH_EMMC:
> +		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
> +			return ENVL_MMC;
> +		else
> +			return ENVL_NOWHERE;
> +
> +	case BOOT_FLASH_NAND:
> +	case BOOT_FLASH_SPINAND:
> +		if (CONFIG_IS_ENABLED(ENV_IS_IN_UBI))
> +			return ENVL_UBI;
> +		else
> +			return ENVL_NOWHERE;
> +
> +	case BOOT_FLASH_NOR:
> +		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
> +			return ENVL_SPI_FLASH;
> +		else
> +			return ENVL_NOWHERE;
> +	default:
> +		return ENVL_NOWHERE;
> +	}
> +}
> +
> +static int mmc_get_boot(void)
> +{
> +	struct udevice *dev;
> +	u32 boot_mode = get_bootmode();
> +	unsigned int instance = (boot_mode & TAMP_BOOT_INSTANCE_MASK) - 1;
> +	char cmd[20];
> +	const u32 sdmmc_addr[] = {
> +		STM32_SDMMC1_BASE,
> +		STM32_SDMMC2_BASE,
> +		STM32_SDMMC3_BASE
> +	};
> +
> +	if (instance >= ARRAY_SIZE(sdmmc_addr))
> +		return 0;
> +
> +	/* search associated sdmmc node in devicetree */
> +	snprintf(cmd, sizeof(cmd), "mmc@%x", sdmmc_addr[instance]);
> +	if (uclass_get_device_by_name(UCLASS_MMC, cmd, &dev)) {
> +		log_err("mmc%d = %s not found in device tree!\n", instance, cmd);
> +		return 0;
> +	}
> +
> +	return dev_seq(dev);
> +}
> +
> +int mmc_get_env_dev(void)
> +{
> +	const int mmc_env_dev = CONFIG_IS_ENABLED(ENV_IS_IN_MMC, (CONFIG_ENV_MMC_DEVICE_INDEX), (-1));
> +
> +	if (mmc_env_dev >= 0)
> +		return mmc_env_dev;
> +
> +	/* use boot instance to select the correct mmc device identifier */
> +	return mmc_get_boot();
> +}
> diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
> index f2575339b990..96735fa9f8a1 100644
> --- a/board/st/stm32mp2/stm32mp2.c
> +++ b/board/st/stm32mp2/stm32mp2.c
> @@ -7,12 +7,11 @@
>  
>  #include <button.h>
>  #include <config.h>
> -#include <env_internal.h>
> +#include <env.h>
>  #include <fdt_support.h>
>  #include <led.h>
>  #include <log.h>
>  #include <misc.h>
> -#include <mmc.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <asm/arch/sys_proto.h>
> @@ -88,74 +87,6 @@ int board_init(void)
>  	return 0;
>  }
>  
> -enum env_location env_get_location(enum env_operation op, int prio)
> -{
> -	u32 bootmode = get_bootmode();
> -
> -	if (prio)
> -		return ENVL_UNKNOWN;
> -
> -	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
> -	case BOOT_FLASH_SD:
> -	case BOOT_FLASH_EMMC:
> -		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
> -			return ENVL_MMC;
> -		else
> -			return ENVL_NOWHERE;
> -
> -	case BOOT_FLASH_NAND:
> -	case BOOT_FLASH_SPINAND:
> -		if (CONFIG_IS_ENABLED(ENV_IS_IN_UBI))
> -			return ENVL_UBI;
> -		else
> -			return ENVL_NOWHERE;
> -
> -	case BOOT_FLASH_NOR:
> -		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
> -			return ENVL_SPI_FLASH;
> -		else
> -			return ENVL_NOWHERE;
> -	default:
> -		return ENVL_NOWHERE;
> -	}
> -}
> -
> -int mmc_get_boot(void)
> -{
> -	struct udevice *dev;
> -	u32 boot_mode = get_bootmode();
> -	unsigned int instance = (boot_mode & TAMP_BOOT_INSTANCE_MASK) - 1;
> -	char cmd[20];
> -	const u32 sdmmc_addr[] = {
> -		STM32_SDMMC1_BASE,
> -		STM32_SDMMC2_BASE,
> -		STM32_SDMMC3_BASE
> -	};
> -
> -	if (instance >= ARRAY_SIZE(sdmmc_addr))
> -		return 0;
> -
> -	/* search associated sdmmc node in devicetree */
> -	snprintf(cmd, sizeof(cmd), "mmc@%x", sdmmc_addr[instance]);
> -	if (uclass_get_device_by_name(UCLASS_MMC, cmd, &dev)) {
> -		log_err("mmc%d = %s not found in device tree!\n", instance, cmd);
> -		return 0;
> -	}
> -
> -	return dev_seq(dev);
> -};
> -
> -int mmc_get_env_dev(void)
> -{
> -	const int mmc_env_dev = CONFIG_IS_ENABLED(ENV_IS_IN_MMC, (CONFIG_ENV_MMC_DEVICE_INDEX), (-1));
> -
> -	if (mmc_env_dev >= 0)
> -		return mmc_env_dev;
> -
> -	/* use boot instance to select the correct mmc device identifier */
> -	return mmc_get_boot();
> -}
> -
>  int board_late_init(void)
>  {
>  	const void *fdt_compat;

Hi Dario

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
