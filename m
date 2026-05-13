Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA7CCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 05:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ADDA838BB;
	Wed, 13 May 2026 07:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="gHKmvfsb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFF38341A; Wed, 13 May 2026 07:48:12 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E107884198
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPN7qGcJGtQKdc6DWfRhfpbic1sdJg1RPZWmn6YfrnXnW+riQYLqK5TLitGMLaJXdny2M5mk5fx1kjX25PcKGxODeS7i/kxOTz2Bt/lsUI0XPVL47SHXm2W0yeG0jiS8LC6G4yk3KQpfrBmsHvzIjPUMAndT6Xhoah4esqcCVnK5ePkelkd+Yl9Fy5LOvFKxkNW4qhxdSYY/4Di3c4YV7r+qevMPdE5oSuFGtWKONeeoORucKSPEQpuQthGz/IgKFEW7U92jAFaYH0B02S6mNfsw/nFptWjspUh8jCWm6yM/o5iVOjyF9fmAz0jlph8bbViD52lc1+GDM34jYdEc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPERnMUo1A9hGfM4ntr++ovh8ABVRbVDSVxsURhNNBE=;
 b=g0MvZC94yhLlV9wcEFIc5V/YApKBR7baO2rQ2akFmioHLQKAx3yNF2htJTJ0PgyUgFgSFjtz8fdXvGlh5YRtL1KqK2wWy5BpN+36H6UlAOIcVxovQQh6d/UMpQIsb2se+hExytHhsN3NwFUU1sYgIl1RJJYk84a74A3YJZ9k0yAw54j9pWmeWcNXubslJ+LdV+KFqLL1h8JiDfEpbVeWVFMYchdDkmFDfFzvh4SkRodZpTtASrBISqHt5j7u+Q+JAiG2bTe33ld2lQDy0X+44o0gUZi0HOROJlhIC1piCmXdgGobVV+9/ZzzK0j+zPsEoaH78WrYxqlaNYMBFIhE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPERnMUo1A9hGfM4ntr++ovh8ABVRbVDSVxsURhNNBE=;
 b=gHKmvfsbamUcNke2bbTj7aKKrZMPPqbOsWj2RqS9pNT8eIVrUusgtouOym+qQTRLSs6aYtw5+Rb3NYROJ9VZ497oqGt3fot7GiETlXDEQEJVtDz0vdSY7FAylkVJIj9xhJ+ifCbMytHQUhs8O43DcbVRd7j7dtx0AJlMevf7I//fwLzQ7i9p2o7rH5uHL9M0k3VbMxqfY9md0WJ+A+TRZwIWaP9Cdc4cCRUoM9WKlyXW76pyt9BghTPacc0PubxCr6idKU/uy5R9afuaTvNJml4ROR8C1F5j+if8Zc5ICwEh+8Rkl5R8P6wwZa9RYafqo7MaW4UIn4Tmd2ABhhJjaw==
Received: from DU7P194CA0003.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::24)
 by AS4PR10MB5174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 05:48:02 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::63) by DU7P194CA0003.outlook.office365.com
 (2603:10a6:10:553::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 05:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Wed, 13 May 2026 05:48:02 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 07:51:27 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 07:48:00 +0200
Message-ID: <0f23738b-b6cb-44f5-8b89-2f74760f1bf2@foss.st.com>
Date: Wed, 13 May 2026 07:48:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] Support metadata-driven A/B boot for STM32MP25
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Javier Martinez Canillas
 <javierm@redhat.com>, Jerome Forissier <jerome.forissier@arm.com>, "John
 Toomey" <john.toomey@amd.com>, Jonathan GUILLOT <jonathan@joggee.fr>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Michal Simek <michal.simek@amd.com>, "Padmarao
 Begari" <padmarao.begari@amd.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>, "Sughosh
 Ganu" <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|AS4PR10MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: 772b188b-83b7-441a-a457-08deb0b3323e
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|13003099007|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0dLkFqGSg1m1SJ7ICBrUOOVD9Keqjqbi+56ERIoWzJnxcj2/y0N2GQl1kTccWfL4cI6LZaoP8iHjFAp8+j7rxA2zOO6m8ZCGmyL9egKvzB1CFdWOF6l+rWMiG6+dE48hmng8RvEnItXBAvgkS/wVp/7K+c6dvoqa6eDI8YNOe2DtyvzcsNbyFsddriWNiMDLvgBrM45qPkKZHSG0pPOtFHenCc2UKUIbA3C1GUptN4WdphvIOBiZ7JAB+rfomzTT6pgjuICWCvXfcJ3YshMNjagUSjkxOq3JGPhfT1Dhf/xjLGohgOgeu8T9BWzRLV6g1nlXC73Whe1v+eeNo7x/pZD93fkyikoO/rsYh1vEGTdmtC0ILnsc5WAyJQ/hpI8zVZWM3AuIQuxdvnX0yin5FJ/UoFBBDrqvOhxq3fF72M5Z2tIjC+ZDM4/JqL1Pp6iUbwjzlpFCJ8geyOivVWzaqn6+h+b1m9yNWTHSh7ofkfJ82hMHVOxw/e6YoBNvBMew63rBLsQ+bR/BvEJtfzDYS96ItPPSh07KY7S6zEXXhKbaNGzbt6ETcheR06COCGNoCeFTuCtBctZJYHadWEemLvHKRQe31EylP8N0dOaWtrzeWtkaK/oGXQprLWd8WUzaujCVnuOmHLAaupDlDO9ynK+qICKulc3PjCN80iI16fHVkKTMgPpg3j1iCyGeiVGa9AFq5z16AjyYprVYnYnTz4it8Nuok5RKjT4BH0Nq4Co=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(13003099007)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WKztpRwQBWivK5nsUENEfAbYqLi7/ZN++qGayqxCwH6ZTZsEdhBHNVwIWKdyVKD01KWXN1SlgtXw05l/2jLHJvuRqhl3XcfQEyY+S1ai3APfyXiZdwrdNzsdRZYiERQb294zUR1CXpXME1cXGKrikrvC7Iy6suajDaVuoJnnbeGLFu3QxSPL0boRiqmQPyveNeDvarRr6iGF4Mm4adRlrScyBUHl8OnxfKlGWwfJ+7HMYn/p4XQggYP8jZEKxcaOSzOzk6TEqOqDSH5quASsjwFjcdBSLUHmye1HfxU7Wni9SYuPxuU3XTlGO0mkYo5QvCzXQmBf3tMMg3h0v+hNJ343qUa3xBvLv3Lx364buyMKU3TJ9jxOqhdGkUMVHa5LMAKbZMFKFfsTthpAkkOIjWsZh3N1Icb4SC6GxJTgPg21VLA42CAJOQ/cKnpY1nX5
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:48:02.0650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772b188b-83b7-441a-a457-08deb0b3323e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5174
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



On 4/30/26 10:06, Dario Binacchi wrote:
> This series, the mainline version of [1], provides the necessary changes
> in U-Boot to support the metadata-driven A/B update flow for STM32MP25
> boards. It implements the logic required to dynamically select the boot
> bank based on FWU metadata.
> 
> These changes are designed to be backward compatible while providing
> the necessary infrastructure for the A/B scheme.
> 
> The series has been tested on the STM32MP257F-EV1 board.
> 
> Additionally, some patches in the series propose changes with
> general-purpose utility:
> 
>  1/7 lib: uuid: add partition type GUID for extended bootloader
>  4/7 cmd: part: support lookup by UUID in 'part number'
>  6/7 fwu: add helper to get image GUID by type and bank index
> 
> [1] https://github.com/STMicroelectronics/u-boot/pull/6
> 
> Changes in v8:
> - Skip the test in case the CONFIG_MCC is not enabled or the mmc
>   device is not found.
> - Add Reviewed-by of Patrice Chotard
> - Skip cmd_test_part tests for configurations where MMC is not enabled
>   or the device is missing
> 
> Changes in v7:
> - Add Reviewed-by of Simon Glass for patc 7/8 of "test: dm:
> fwu_mdata: add test for fwu_mdata_get_image_guid"
> 
> Changes in v6:
> - Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
>   tests for part command"
> 
> Changes in v5:
> - Update doc/usage/cmd/part.rst to reflect the changes related to the
>   part command.
> - Add Acked-by of Ilias Apalodimas to patch 6/8 "fwu: add helper to get
>   image GUID by type and bank index"
> 
> Changes in v4:
> - Place the part command tests in the cmd suite rather than the dm
>   suite.
> - Order the include files according the U-Boot coding style.
> - Add patch 7/8 test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
> 
> Changes in v3:
> - Wrap lines exceeding 80 columns in test/cmd/part.c file.
> - Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
> - Add kerneldoc comment for fwu_mdata_get_image_guid() above its declaration
>   in fwu.h.
> - Add log_warning() messages to fwu_platform_hook() to catch inconsistent
>   FWU metadata (boot GUID found but root GUID missing or viceversa), as
>   suggested by Simon Glass.
> 
> Changes in v2:
> - Add links to the XBOOTLDR specification in the commit message of patch
>    1/7 lib: uuid: add partition type GUID for extended bootloader.
> - Update help for 'part start', 'part size' to mention UUID.
> - Add kerneldoc comment for fwu_mdata_get_image_guid().
> - Pass efi_guid_t by pointer in fwu_mdata_get_image_guid().
> - Add patches:
>    5/7 test: cmd: part: add UUID lookup tests
>    3/7 test: cmd: add unit tests for part command
>    2/7 test: dm: part: add test for part_get_info_by_uuid
> 
> Dario Binacchi (8):
>   lib: uuid: add partition type GUID for extended bootloader
>   test: dm: part: add test for part_get_info_by_uuid
>   test: cmd: add unit tests for part command
>   cmd: part: support lookup by UUID
>   test: cmd: part: add UUID lookup tests
>   fwu: add helper to get image GUID by type and bank index
>   test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
>   board: st: stm32mp25: support dynamic A/B bank bootup
> 
>  board/st/stm32mp2/stm32mp2.c          |  32 ++++
>  cmd/part.c                            |  12 +-
>  doc/README.gpt                        |   2 +
>  doc/usage/cmd/part.rst                |   6 +-
>  include/configs/stm32mp25_st_common.h |  15 ++
>  include/fwu.h                         |  11 ++
>  include/part_efi.h                    |   3 +
>  lib/fwu_updates/fwu.c                 |  33 ++++
>  lib/uuid.c                            |   1 +
>  test/cmd/Makefile                     |   1 +
>  test/cmd/part.c                       | 227 ++++++++++++++++++++++++++
>  test/dm/fwu_mdata.c                   |  48 ++++++
>  test/dm/part.c                        |  53 ++++++
>  13 files changed, 437 insertions(+), 7 deletions(-)
>  create mode 100644 test/cmd/part.c
> 
For the whole series

Applied to u-boot-stm32/master

Thanks
Patrice
