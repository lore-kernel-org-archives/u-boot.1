Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CB1CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 05:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7C7A838BB;
	Wed, 13 May 2026 07:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OqRdNOwE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64CFB83E36; Wed, 13 May 2026 07:46:19 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B048341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cnx8Lc+ZL+xXU8nTzBRcyD8FlB9ZXA6NgtHH1OjpcuvZc1zf/IR4A/p+N7Uzktd0ZxFP2R4AdTD6EZP8Ju2MU4V7AdeNdRUw4TB2bYaLUvxsOmkDspe0KysOerV3tatjajCAE6FfvSec1m5JEuz5uu7U8i7iCZPeK4SzdbPCBmNxugdSD8KxrdeF2AQAX/yD36I9TRf0eES9rqnl35BhYzcBtiiZmtqGs3Rcqp7YFVlTRaLV9v0x0gLMQhTbx+5lBqs/5YBv+xGcTlnDtqxzsOsw0Sw/sbbWZBrLb9ZmG41qoxYzbQcEhaULTEvWsMP5jG/FR+Dbg4GJjCVEvET3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuh0mxFFVgazhaTSOlrdVMKwvZO71+KcbeWHFULJVvs=;
 b=xREH5AiZuPAwjAoeLpZkUEUXNRHQ+wfXWOF/j3fp/pEQk+V8pxNDjrv5FLzBIh7nJ0h5egwR9Ed9JMCYdsdMKrWVbdJXAazMiiI6ww+RH0xWMC3aVAvLC08mNMzfnjcAlvbFIwFRKz2vwTDPi/LCOGefAd1z4KnooXf6OM60bXlScX7+gOMoI9VX/lVSNxzPLuoABh6zsLXh7ZH7CULHwCfOzpXGUpoHv8LN3bUAI8Res1E9xrovCu1BBbuNzLpzYCe+I7oBeFjdg1ftexFi0pfcJYK0oBKJ5q0UHOyoWR9MyYcXG9Ml6sk/hDUYBmw3vmEP75nebjjZeaK1tkkLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuh0mxFFVgazhaTSOlrdVMKwvZO71+KcbeWHFULJVvs=;
 b=OqRdNOwE+HP5E/E5CgcqY5uKuYlMcqtSOWyJe5EeUk6HxISFQa6Se33nWixbzMSs2VJh162/CHO0ymMIo2PJO+fSunSPg7h9nrHmgaEKzPokOtQB6K91ItOYHebC6+W8cNuFSA+nVdq0TVtc15TwT4xxBA2ROWfxqqdk1B0OFhmH52+rLPDerI+dRfIbQxREVZV+veOmXtn0md4RWcFZRQk/lN8dOI/Y7th6u4d5WYdvDTZkTuROsPWwptnHBxSd1ob7FrDaJLV1BGsa4wzm8nCU/GU2wHT5v/PXvaYTQwurptI1jzJIibTFVe3QY996U8rtpmkaCGCqTEYO+QAkIA==
Received: from DU7P194CA0024.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::28)
 by DB4PR10MB6071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 05:46:13 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::17) by DU7P194CA0024.outlook.office365.com
 (2603:10a6:10:553::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 05:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Wed, 13 May 2026 05:46:13 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 07:49:39 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 07:46:12 +0200
Message-ID: <2345df59-0ffb-4817-8801-9114f598bb15@foss.st.com>
Date: Wed, 13 May 2026 07:46:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH] reset: stm32: Fix compilation error
To: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>, "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>
References: <20260428-fix_mp21_reset-v1-1-d1f2dff3f507@foss.st.com>
 <488f6f98-762e-4104-96f2-60a2475585fd@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <488f6f98-762e-4104-96f2-60a2475585fd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|DB4PR10MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: b50cdf8c-bd86-4003-4577-08deb0b2f14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|18002099003|22082099003|11063799003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: rwoXVoKeWcKjH/QsYEqTsSLY/kvdKsgvRs4yrUWeq59jZnxoInG0FzgsXhfadkI/Ze0ROC1KpSsd9dqXp3LSiMP992KAVntCFQG0DonRqysfMrCbVhfuFIaa/LCDv7l/QSmsxXXhS5sKwxJrrwss0BCNZmoWuA3f/xpoxsskHYjzUYMUbumZ0N53bb3q1a2YeTZBMQxRPaaAWOM6Xx3XWkzqZnVPr9Xb9fwyHglEytBheCToMmfJkzj+MMwb9Dkd1ggpCsRW5OS1QguaUdFclh8Z9pjQ7A1yXn0z/Et9ekU0Spcg0ksg9bjuY/44fOOtK69vKtx1MiwSvcoyD0kyJSQSf/UX7tiTTk8ZPV0R43uJfA8wazyIBxbfk4BzTDrAsacYY38TLpNcJ+nTl1AxpbqYwV45po4BCupVpIYwXUPShi/LFAURrcaCxy4rIMB57QyF4yTEDw9gzJlFxf+2mQnzLDs1B/Kd+3PGsn1JMSlmJLzyS8SCHmpzY+kWSaEHHgdjlyW5cESoRa8zMzbG0YIiffl9aY9Objk/Ng6P7ur/bsgSSINcGU3hg/0MYoGkbjkJvRp/VwsQ2kQ6LX1PNbVoYk1kHNK5n1XSghZV51ecOAdIRVGhfe7VkUenwoj3Ir9Nc742uLFAIqYo/tmLiydkUyihKNn1lEiHZ71JyCq1Br7tp9/sxVjSllpStMDpd+oNbnRKSx2R9LJRfT7F3WnOKJAqcLYJQWzQ0Wc0SXs=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IxsHyOkcjbNMtv4AVC/verk8wH1W9df2ttCXY5OIqiU14P0Qe3TQerHQWXtmoS9clxxCnnCzXeyxnglrl87h+/qqwq5Fk8IfC7J09ndLOGZSKvWlF4EoCLzFnJSYtev0eqsN2QiBa9x0YSixg5CugUvjlFkAhVZAejDDl61KyF0yT5pGQ3YwhYYYwoG4mp5Y8R879mjhtdCMbOtz8RWNxX8wDNHWbh+efT9tc+o1GLqGrP3L2mrLRiuYNDJ6T4O5Cd/cYaj+Q/0eYh3cKGTPBwO135fcTzJAHXNEpqOvKZdnUKBaoZPZwxbm80g0FKfmgvYndqEMmOQ9otf/Ecuz1ckt3hf7q0wbKWKKtikS7FvPLiVmeO3JiEXIGA4FXsWIEG3boakChRtkm8804IeLee8Tdsk2vabTV4w9MX6tw3eHb+/uXcuMe2G7laXAbrDr
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:46:13.1094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50cdf8c-bd86-4003-4577-08deb0b2f14c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6071
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



On 4/29/26 09:49, Raphaël Gallais-Pou wrote:
> 
> 
> On 4/28/26 18:10, Patrice Chotard wrote:
>> The following compilation error occurs when environment variable
>> KBUILD_OUTPUT is not set :
>>
>> drivers/reset/stm32/stm32-reset-mp21.c:8:10: fatal error: stm32-reset-core.h: No such file or directory
>>      8 | #include <stm32-reset-core.h>
>>        |          ^~~~~~~~~~~~~~~~~~~~
>>
>> As stm32-reset-core.h is located in same directory than stm32-reset-mp21.c,
>> we should use #include "stm32-reset-core.h".
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
> 
> Hi,
> 
> Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>
> 
> Best regards,
> Raph
> 
Applied to u-boot-stm32/master

Thanks
Patrice
