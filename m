Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86FBCD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 08:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 429C484255;
	Wed, 13 May 2026 10:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="bf1PX6Kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BAA983E36; Wed, 13 May 2026 10:15:04 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A3B383EEF
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 10:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qksDLdFhN3HlbqRPGKst5VjSjQ5Sg6dxNaumgN4zWuEQsCV2w6rFu6Fb24ogOi/YEkP3/scRg6ZFOStSI1Cw1oXr3Fq33rJYxbPPG5PXv90JId7TkXP1QfDOIBe6rm2Z/9stjGum/l7ASsi9ryb0t3vPB4prtElQhgMUB+Ie1Gv+/Fg12uRBV88jJj1aLICbYqrvSeT3lOOXAHCWst28u2PbQHsVhQt7JnN2dB4k//bhjgE2OlajObFU/jNpwzVdVq/P2p0TWs32TEE2csgtr4epQoL714hEBJEYzlQgz1i1lNp4UgWEwoK1Dgrne5GTnBZKAUibEu040a08PNsGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xyaw3i/ymWNujkSKtiAMqKZlPJ6NxhRreNrdxou2Pw=;
 b=Qu9Pb9BPKmLhthBw3XKD1/2gTfFT8UhqwLD2HoOGG7y8lB0ZSYxLqc/0KGaS4TqNR+8727rWIAg3v+u1qQebPMpszSmWSo0PK97cD42ERQRsju2pL/ZpXltiRJGE8H5pWclqJOny6GjmB9Reo0Wv7JLNplKwuUqL2NlQjrcRgHQe1b+Ezay54W0PxHz6SqwIh4T6OXaUHqOhJSdeTixLjvuiyuXNUSca48VqRiSPmq/CJNHDouRw55r8hL9OVOk31hUErHwfP2JmF2gG20tJtBd7Fv7vKr/AhHuCXTPAX28JhstEazNS1Y5A/Cz4uXAjYE3STV/4sZskL1C0U8ktoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=linaro.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xyaw3i/ymWNujkSKtiAMqKZlPJ6NxhRreNrdxou2Pw=;
 b=bf1PX6KjjqECiGFCKWjgW9V+Ic0yFxgHvl4539tPMMrKWjtqf9CdO9lVIjEuoregiYzmE2kUmKr/Dio3WfmzHizRdqHjTb/rlKzUGjDD/edlpncPiJzzfGzYaT05mSWy1VkDm4Nn7+r1cHbYhGqYvFXtnipmHQWSqzbwJfHVKQr4zLqeVjlAEbv8tYuCVE+wGBv5gL4rDLZxb9yZuM7uQcKA2VNgEGws7iXAkTYtuh+2t5WRexKL+fO7zgDweynnJ3lrrxTFIL5AizkSYmNSHXbNepA+U4TCHi86DXE0l7NE9njBmPZnxj4kl5D95G0/JJCkxk1nHbrRiAav81a7bg==
Received: from DB9PR06CA0019.eurprd06.prod.outlook.com (2603:10a6:10:1db::24)
 by AS2PR10MB7177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 08:14:55 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::f5) by DB9PR06CA0019.outlook.office365.com
 (2603:10a6:10:1db::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 08:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.8 via Frontend Transport; Wed, 13 May 2026 08:14:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 10:18:21 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 13 May
 2026 10:14:54 +0200
Message-ID: <731224c0-a38a-41d4-959b-1b05d608cf28@foss.st.com>
Date: Wed, 13 May 2026 10:14:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] Support metadata-driven A/B boot for STM32MP25
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@arm.com>
CC: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>, <linux-amarula@amarulasolutions.com>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Javier Martinez Canillas" <javierm@redhat.com>, Jerome Forissier
 <jerome.forissier@arm.com>, John Toomey <john.toomey@amd.com>, "Jonathan
 GUILLOT" <jonathan@joggee.fr>, Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Michal Simek <michal.simek@amd.com>, "Padmarao
 Begari" <padmarao.begari@amd.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
 <0f23738b-b6cb-44f5-8b89-2f74760f1bf2@foss.st.com>
 <CAC_iWjLe9cv9C=uMjuMJVhLJ7P=RA020PO4GqZ8UjX8z0yfdyw@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAC_iWjLe9cv9C=uMjuMJVhLJ7P=RA020PO4GqZ8UjX8z0yfdyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|AS2PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac100ad-889e-404f-ae56-08deb0c7b786
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|18002099003|22082099003|56012099003|13003099007|11063799003;
X-Microsoft-Antispam-Message-Info: Goj17ycCKzHYwom/c462UK/xpWZLsfTjGp8M4hQgcAXBQCej7jH3ql3vKMIXF5qQ0F4t7JR1go5la/Mfj9gAaXYC1r9wByaUa8zj8kOb4UCOo7Lzgi62etG3yFtmFgor2MrndKm3J4aChWAh9G7pf0TY55rfjsUVNVFJtwKyP7MHHUyvLaM1TDreEBny3lsthOrGgTDAZm1IxNlOofkXMWNeUQOTqL0aN53EgNGsrbOuEcFYiJAoOAIqppRJF8CUa6do2+0pc3goFIT7EPgb0U9vXPt5HcDyVaINbffESsC2HsnlaAY3aD/yHJS7rb2Edl8sq6hwWyRXWnUty2ugTIMARKN5YAbsBQs00xpWG/R0bzY243n+hbAfkaUmY4Y2oteZMYHhamNj47B9VCwZmHOds2TBBBkZ3y02amxjEosNBMTIa1tEI9/mr/rcSeS5NDKq9/G/5ZRH/VeV/HUQQwjmZbKycXPpEvJ/ymDYgknUrfvZLWfE12TK6axQepRP8l8+YvW3zPCpviN7GAbnfEAnMBwvR217QRf9d6qW2XB2fmN9gpT7rwSh5qobMqU0mcIPuMDmuQj6ogK0gp0jk4QUQzFdLoiiBf8qC5vxK+pekcnyt81PFrly7R87ZQ+u25m+IA2H/igB1N8L6YfzHDy0OGoZwE3bmqfS/aCAqggFJ6Dxa5tBSOwXYeIZjXDs3kvlDcyLX2eEGpf/z80yQVH2dAq7cDya8bifUQDYaPA=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003)(13003099007)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ur8SOlij+Jz8BcJrKFnOa6yhwiBgaFvlS77SPHzybzLVbl1v7WfjN8EOMUSrzLsLEZBiLe0yEWlsrF4xmdfsO4KXKSVw0twe+SV+tgTFw7oVkm7ItfwvSNL2PCdR5poSBpm+2YeMfl2daAE4JWSD3A2Nnjg4kgWLzzHRNlDZMaSDMkBC/4V0n/YiiocioRxUlCvN4Xbg66UYLZ/kTDzjmaqDH+Gz8io7LQrE45BipD/GFiAtruFGNIz7SrQst9a1wrw3qJam2jhop3dJjD6lEO8i8sMeC3Chu5jBZdiG1OlWWy2fva85If73Z+RtQ03fpl//9t8+HpDS0eqJeBQIwJqx5qgeRK3wE4X5OdlDc28FxY49vAzMbc6tqYxPbgq6Z396BZOEiIc62ODLm558Q8sVTFGD28d4XpkjXF6CRRvzxIswl5UuPLTM60E7XlZt
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:14:55.6160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac100ad-889e-404f-ae56-08deb0c7b786
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7177
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



On 5/13/26 10:00, Ilias Apalodimas wrote:
> Hi Patrice,
> 
> Can you please get an Ack from Sughosh before queuing these up? I'll
> also ping him and see if has time to havea  look
> 
> Thanks
> /Ilias

Hi Ilias

Oups, i already submitted the pull request including this series.

Patrice

> 
> 
> On Wed, 13 May 2026 at 08:48, Patrice CHOTARD
> <patrice.chotard@foss.st.com> wrote:
>>
>>
>>
>> On 4/30/26 10:06, Dario Binacchi wrote:
>>> This series, the mainline version of [1], provides the necessary changes
>>> in U-Boot to support the metadata-driven A/B update flow for STM32MP25
>>> boards. It implements the logic required to dynamically select the boot
>>> bank based on FWU metadata.
>>>
>>> These changes are designed to be backward compatible while providing
>>> the necessary infrastructure for the A/B scheme.
>>>
>>> The series has been tested on the STM32MP257F-EV1 board.
>>>
>>> Additionally, some patches in the series propose changes with
>>> general-purpose utility:
>>>
>>>  1/7 lib: uuid: add partition type GUID for extended bootloader
>>>  4/7 cmd: part: support lookup by UUID in 'part number'
>>>  6/7 fwu: add helper to get image GUID by type and bank index
>>>
>>> [1] https://github.com/STMicroelectronics/u-boot/pull/6
>>>
>>> Changes in v8:
>>> - Skip the test in case the CONFIG_MCC is not enabled or the mmc
>>>   device is not found.
>>> - Add Reviewed-by of Patrice Chotard
>>> - Skip cmd_test_part tests for configurations where MMC is not enabled
>>>   or the device is missing
>>>
>>> Changes in v7:
>>> - Add Reviewed-by of Simon Glass for patc 7/8 of "test: dm:
>>> fwu_mdata: add test for fwu_mdata_get_image_guid"
>>>
>>> Changes in v6:
>>> - Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
>>>   tests for part command"
>>>
>>> Changes in v5:
>>> - Update doc/usage/cmd/part.rst to reflect the changes related to the
>>>   part command.
>>> - Add Acked-by of Ilias Apalodimas to patch 6/8 "fwu: add helper to get
>>>   image GUID by type and bank index"
>>>
>>> Changes in v4:
>>> - Place the part command tests in the cmd suite rather than the dm
>>>   suite.
>>> - Order the include files according the U-Boot coding style.
>>> - Add patch 7/8 test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
>>>
>>> Changes in v3:
>>> - Wrap lines exceeding 80 columns in test/cmd/part.c file.
>>> - Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
>>> - Add kerneldoc comment for fwu_mdata_get_image_guid() above its declaration
>>>   in fwu.h.
>>> - Add log_warning() messages to fwu_platform_hook() to catch inconsistent
>>>   FWU metadata (boot GUID found but root GUID missing or viceversa), as
>>>   suggested by Simon Glass.
>>>
>>> Changes in v2:
>>> - Add links to the XBOOTLDR specification in the commit message of patch
>>>    1/7 lib: uuid: add partition type GUID for extended bootloader.
>>> - Update help for 'part start', 'part size' to mention UUID.
>>> - Add kerneldoc comment for fwu_mdata_get_image_guid().
>>> - Pass efi_guid_t by pointer in fwu_mdata_get_image_guid().
>>> - Add patches:
>>>    5/7 test: cmd: part: add UUID lookup tests
>>>    3/7 test: cmd: add unit tests for part command
>>>    2/7 test: dm: part: add test for part_get_info_by_uuid
>>>
>>> Dario Binacchi (8):
>>>   lib: uuid: add partition type GUID for extended bootloader
>>>   test: dm: part: add test for part_get_info_by_uuid
>>>   test: cmd: add unit tests for part command
>>>   cmd: part: support lookup by UUID
>>>   test: cmd: part: add UUID lookup tests
>>>   fwu: add helper to get image GUID by type and bank index
>>>   test: dm: fwu_mdata: add test for fwu_mdata_get_image_guid
>>>   board: st: stm32mp25: support dynamic A/B bank bootup
>>>
>>>  board/st/stm32mp2/stm32mp2.c          |  32 ++++
>>>  cmd/part.c                            |  12 +-
>>>  doc/README.gpt                        |   2 +
>>>  doc/usage/cmd/part.rst                |   6 +-
>>>  include/configs/stm32mp25_st_common.h |  15 ++
>>>  include/fwu.h                         |  11 ++
>>>  include/part_efi.h                    |   3 +
>>>  lib/fwu_updates/fwu.c                 |  33 ++++
>>>  lib/uuid.c                            |   1 +
>>>  test/cmd/Makefile                     |   1 +
>>>  test/cmd/part.c                       | 227 ++++++++++++++++++++++++++
>>>  test/dm/fwu_mdata.c                   |  48 ++++++
>>>  test/dm/part.c                        |  53 ++++++
>>>  13 files changed, 437 insertions(+), 7 deletions(-)
>>>  create mode 100644 test/cmd/part.c
>>>
>> For the whole series
>>
>> Applied to u-boot-stm32/master
>>
>> Thanks
>> Patrice

