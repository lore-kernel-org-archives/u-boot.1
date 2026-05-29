Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96139CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 07:57:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D06E6846A3;
	Fri, 29 May 2026 09:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hH9XxEVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DBC9846B4; Fri, 29 May 2026 09:57:00 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99BF844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyq+ql/4V6jvvSxAgBDBFG+YPWKgUUolvSwzjcMlTXAPjZc0bNeASbUTvEZlEaZoD0w9y9mnjTTuZqpAwxM4YbzovSPbMdTUGjOpwfqyT3Y/iZ8948wMfS+IqlxcBJq/tafBH90BWE2fRoENNTahctGQVjt9Kcn/AKqHsHDN6D5jMNQ2/uyHXsLUQJU4Aml16XGZJL2GxqPqaCeUfD4NrjF36clYaQD1c7IHkz9kcCE7G3AvN0mlFNommCg4V4XNfdHkrLRGqfhvhXSBMJ3gY+hNj+AXl0RHYPcAg1nlqVimJF7giJjCNvTCrykpgEilmBrGlL/KuPE25odastjPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKsWTbLC3KNRVBBL/YODu1wJnL+Sil56acyh8dXKemQ=;
 b=y69ooghYQroRT4bB4WjRMzzxJN4VsqDDL8U0lZEiTxAPkQ54g1p8aFHjvOw8LgOD7VjFeiUiTUW0AaSG6BdYmYfxz2mBUzxjmGw/eFHuAFcunICLnkHR2S1RsC8vQLNB4aZQSvq443RNz8ZcdFuICJBcuK4TEX8vdnU6xezaUxKpYjjnDs1aTu44BBM+/YqWz4hc20qJMh89m/GQX98svgc+nc9s25m8kg1DB+sl3tz8O6kyr87MQiP46QiSthU/10YFwybjfzIvbffxmEFNVGyXsbhYY17wCBPRbHQ6JcGyrhd4e3K+2RJs6BNXQ6oK9PQCe6tbSH9lTxxoRD/5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKsWTbLC3KNRVBBL/YODu1wJnL+Sil56acyh8dXKemQ=;
 b=hH9XxEVDGH+PWgbsQOE+uJjidugf45sOpRQhACEYln5pQWXV/3MYuwQn8Vzh1NC/L2YCn2yzThclbFRcf511kseJFW3jmguk1KDPRVSvCjsGbvWWIageA/shDfRC+xgyF454P9hKiMT0YJ+iVThz3bXX/Xx4s/8U2NPysw4Ccuw=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by CH2PR10MB4119.namprd10.prod.outlook.com (2603:10b6:610:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 07:56:56 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::39) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 07:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 07:56:54 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 02:56:48 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 02:56:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 29 May 2026 02:56:47 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64T7uk093209178;
 Fri, 29 May 2026 02:56:47 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 May 2026 13:26:46 +0530
Message-ID: <DIV00L1KHD4P.3H68PL3H6MVQE@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2] board: ti: am62ax: tifs-rm-cfg/rm-cfg: Update DMA
 resource sharing for CPSW
From: Anshul Dalal <anshuld@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <sparsh-kumar@ti.com>, <p-bhagat@ti.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260507123127.1518673-1-s-vadapalli@ti.com>
In-Reply-To: <20260507123127.1518673-1-s-vadapalli@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH2PR10MB4119:EE_
X-MS-Office365-Filtering-Correlation-Id: e230bf2e-920c-47db-5cea-08debd57d9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: dhn2HmG9wqA7Lc2an44EY1Eztt6Qk+w11O/FJ2XU//0cip0O/TuemtDdmBertTT7R43XOhROLdxz57HJkcG2Aj8Gq9YCo8HuI1/qEtZSfcNJsUD1EnUxeu9zN31yWsWdIrhEnaXI6BnWEd3pujgLGgIQvSyeokmNGvT7C2zjEu6MU/1zA2SKGluY5wa9uZdBZlTErVTV1zwlWRJM9UbOV9LZBHtZvheELvoBSeIRt6nFWFCwQihWjSjGl961Ylj4RGU5mo7NHqba1ZLgN9A2nDyoF7ln757DBiTty/+hMqDbhr2xn/te8JKacXfeyVrcqYbx/8MG0VVzFxMduwyrO0PY2UJ+ykj4q1grxcUorh2/2Vg0kRg2ETxtNKQHKpSOh0Ueo1kJSaBFU1wFJv7tX+75qOOHQN/sJV8Y5lt16IExS/9eE0NkqmLXUTz2Y8i6j1RHbI+smkYd+daDcLGftbSqle5d552NtAvswI+R6vJ2kV7trV1xRnaaWYto8oLFUm2V4K069JACEtAhnVrPrPaccuflgNWo/uLIbIrYrxzGkySOQKEOD5ncPrk/wtQrjjJY6DVoYrco64lHcSQVscwxnSSwHOUERNJPDGhvV7BpPWd/osIlz4rFAwjTcIzbtOcM7FUtaEchk2/wtFX9sRZ6Rr01d/CiWNvC+itnJOAtdVfQKyko9SebbmwWYe/zrsqoE4XUD5WZXYZWxlL63uC99w4zkmZyavP+36lwZyQ=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IBuPFxmjzNLkcYAMWkHzBEMi61373rACe4HozvS3YHDZqFxTOh15IHUyaxCx5h8DEWB6D8G5Hr8667O3cJuWE7IeejTf5VasCChbzZDdiJuqjRma1djf+Z1h4UPcbFXCZ+2Ac6PnYjLGaQujdfGBmnNhOLCXD2+DmGQFLhOM1z02cz3v+c7lpgaeOhLYgOqgFBluj8yIitWZzFf3brYs7jU97SYlimvjuRVxucGrVlkqLPQIV8TLLGgnYvqsBcehqtghswlmn0mZ3C2+UxR9k7jmHTfTAGgLD+SaLdosAVx2V/qXH3aZuhjeTOzNnO4FrU0Ksbg+7JP+NFqigm7z2UettMSg2RHkdKcK/5UJElyXg0WyX94YouTjS/cMF8ZFetdbiXdXgROemaghJzv/1ho8Gh32EY5SAxB2agmxjWmVjCp2cpfYffijr8vkZj3h
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:56:54.5569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e230bf2e-920c-47db-5cea-08debd57d9cb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4119
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

On Thu May 7, 2026 at 6:01 PM IST, Siddharth Vadapalli wrote:
> The CPSW3G instance of CPSW on AM62AX SoC provides Ethernet functionality=
.
> Currently, Ethernet is supported on Linux which runs on the A53 core on t=
he
> SoC, by allocating all of the DMA resources associated with CPSW to A53_2=
.
>
> In order to enable use-cases where the Ethernet traffic is sent from or
> consumed by various CPU cores on the SoC simultaneously, while at the
> same time, maintaining backward compatibility with the existing use-case
> of A53 being the sole entity that exchanges traffic with CPSW via DMA,
> update the DMA resource sharing scheme on AM62AX SoC to the following:
>
> ---------------      --------------   -------------  ----------------
>    Resource              WKUP_R5         MCU_R5            A53_2
> ---------------      --------------   -------------  ----------------
> TX Channels [8]  =3D>    4 (Primary)     4 (Primary)     8 (Secondary)
> TX Rings   [64]  =3D>   32 (Primary)    32 (Primary)    64 (Secondary)
> RX Channels [1]  =3D>    1 (Primary)     0               1 (Secondary)
> RX Flows   [16]  =3D>    6 (Primary)    10 (Primary)    16 (Secondary)
>
> In the absence of primary owners of resources (existing use-case
> where A53 owns all of the CPSW DMA resources), the secondary owner
> can claim all of the resources as its own. For shared use-cases,
> the resources that are not claimed by the primary are communicated
> to the secondary owner allowing it to claim them. This ensures that
> Linux on A53_2 can continue claiming all DMA resources associated
> with CPSW in the absence of primary owners, while at the same time
> providing users the flexibility to share CPSW DMA resources across
> various CPU cores listed above if needed.
>
> While Linux has been mentioned as the Operating System running
> on A53, there is no dependency between the Operating System
> running on A53 and its ability to claim the CPSW DMA resources
> listed above.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Acked-by: Anshul Dalal <anshuld@ti.com>
