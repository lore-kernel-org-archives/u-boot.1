Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CBFCD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BFC28468B;
	Tue,  5 May 2026 09:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="iOcs0FHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986E9846A1; Tue,  5 May 2026 09:26:57 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0358466D
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ue9FnHM8giDIhHMUQWL5ADPJ5eZiHJMSuks7bTU8NDL5P6TRJkWma5IWaXfIrL1UNEoScwAgELz5HeM7FAbdTS1I5NY9zjlBrATy7Wwm3eTp6ien98UuPRyOttEJWZMK03cO2zyLfb8FjvuLDG5rTwJfToT39M5CEcrzsjVKtoOzLNPfLI9PZOaEjvm7ehXBIxo4yYTCTEZg1wUlDzRmllp578cR4yh1QEHR1mJKJ1pU+T/RxU3YAUMQxt8fhjSd3CLXL0d6r/l8qBq5JLGaVXBQo9g/6LF29Dkwa2ptZw7NsS5/ljFIllS5La/GKQRjRf1J+EWqThtTRq9DWaHykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY0PEd8gyo5/NCsCeSeZijGa/2ZyRCMXHTA++gXdVfM=;
 b=dfML68wSHyP7KQApj8j1isgKD97IDLPvqIWh83T41DQGLyBzzsGG1AyjPk4q8/PLCftUX6u0ybdwwesVRDbwDqzuPxM/hAlEDjMmmhNNMduyF8wseWhfDQDGoVJkucVYq2pqGEtzAjOsHKYC/7Ka2azNTLmtzB22EBaT0X+t82n1ARdEKP4YVz9U9azkSER0UK37ZCALYBaW18jIFcE/EL/40++QOeDRhKR9QGsg6Oe2Y4DIY5i9p8HPi2AYChDoqngSn3mkh2AprcLhwSofMK8eUx6DSFFrLrZCbHnN6K2jCb52h+mXSxuujXzNwiLTKZ6zTlL19rIaXyjKuDnDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY0PEd8gyo5/NCsCeSeZijGa/2ZyRCMXHTA++gXdVfM=;
 b=iOcs0FHkv2mi/c7/N8fIoc4aGavOlO5b4xei2QjQGr9HZyb8JJqeReITPC/9U1gb6EP738DeekVt2fOmV7gTckqHXWaKkF7nKCGdXSk7+61AEf+Zwj2hz73db1b/kgNsVG9NfqkwC9OACPakztqy1yT5C5pxSMBUdsuQKDvBRivwHtWsq3dhzwii+DNH8HOT/TSRjzXEtUdS7RDaO81GmJAk0UG6D4fLxW/GGJMjua38FqW0O7ASV04i1KTDBV8GYjRx/4r+9/B30uzPa95+JgEipnSmU+RER+ZTG2mk/52EXvqXRG/Xn+E8aSKBilKeEQcwNJbp69D8AK3QjJWg/w==
Received: from AS4P195CA0052.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::12)
 by VI0PR10MB8833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:232::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:26:49 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:20b:65a:cafe::17) by AS4P195CA0052.outlook.office365.com
 (2603:10a6:20b:65a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 07:26:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 07:26:48 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 5 May
 2026 09:30:05 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 5 May
 2026 09:26:47 +0200
Message-ID: <5b02ed04-764c-4eee-ba58-0f84ef43446c@foss.st.com>
Date: Tue, 5 May 2026 09:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] test: cmd: add unit tests for part command
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
 <20260430080627.849636-4-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260430080627.849636-4-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6C:EE_|VI0PR10MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 395831ce-425f-4d36-2205-08deaa77aba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 02mPrJnf2AMdeM0c0e28caVn88chppd0Jm/SYVK34MOwFashyfu0EC2pqTi4jiSymHUqImmUo9eKl0ET2I5Uu++NWuOc0i93R6ePCLpUjR0yWkhdyiMPodrLRXVfnCtmahZUzRqRiA4yfRPeimeHYHavn0vXHKjrdyTY+v/A2FA9eNWq9HqYEUViaGspN2Z4/fzkDMjt8nvD1LNXf4lsIBSFaUvhXQdH2mg++9T6CB0yBqcGeq+7Ir7t5hf8+H5kExXwTVtwoUsHK/DRgauq4vqqSzg4H+TxzzQWApOihCPnnCEpaJ/B7Xm9BdaW7zf66IYO2dZNL5/BfUA6J26fcRowlZhpFrGAkfj5MeEPiiZdC9g6gGpa5SGRZI84l37cWyQ0puyxnrEfIrRTqbnXzOiHxC5SIRAYksqBxVTM+trU2VlIPrpgEyBsEgMDrYiFcQp1eRQL22uFWXstYe+6InUxPOOQEJi1oimQWrcR6cR2g90w5cS60v9bDKRMBj0aVf/ZR7+8jGncKtw9/b/DVWXGeiNg0L6INbk/yZLSKBzZZmxPJc9yyUnyLheD5o7DcAUuyUmOTVfoqFi9F0vpXSbvqYC+rh0tz1hNFkSbd4Zu9DvTd2UkZnH5RGA2Ld9oLctlKT7vVUPula9jTUY5BcjEN7QeQwye3iK8Ntiz4Qt0VFxheGc9OlhKlrOIF5hiUTmUfWzwDWbJuU/SSxPUFTXx4rTRljpp5hvJn2PL3Po=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: guFQeokd8p10RdyTLH3/lUqALeqWhcXgTEPba/4VuCwhBJVnchqj4ZX/R/6ddFUo4k38f4nr6J5ZGnbaW7O8HlRiUV5xgxPgwUqj9RTv7t52JvhHlCoE/4cbClqsGRLE/RrvvhdW6W5qFw9KDmGCpNYqhYOUqqpR0t4juz5shb+iRIAsPCzBkTzPG8g5LLkHldaZhpoQ2lLRSI8/l8MuTNYIMPZJzcgYUFOFPWaZjzVm00IuTRLClgaLWUe++vQfXWEn/y+mwB6hmhAd/S5jEUurmnlYvZ5birfnPXlDRzAmKKanMrtrqUI2/5THTQdjzr8IJZjoUdH/CsZ19sCasXwnTWa2ulI3tYop0Gtg8xmaGjEzpyPNmvLfh3zST26wM8sPZC3oFFFbVDL9ELlZfvTMudXEV2CsR/wn2hw1MOB5MFFadwf0z9l6A55FdscL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:26:48.9559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 395831ce-425f-4d36-2205-08deaa77aba0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8833
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
> Add unit tests for the 'part' command, specifically for the 'number',
> 'start', and 'size' subcommands.
> 
> These tests establish a baseline for the current partition lookup
> functionality by name. This foundation will be used by subsequent
> patches to extend the command, ensuring consistent behavior as new
> features are introduced.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> ---
> 
> Changes in v8:
> - Skip the test in case the CONFIG_MCC is not enabled or the mmc
>   device is not found.
> 
> Changes in v6:
> - Add Reviewed-by of Simon Glass to patch 3/8 "test: cmd: add unit
>   tests for part command"
> 
> Changes in v4:
> - Place the part command tests in the cmd suite rather than the dm
>   suite.
> - Order the include files according the U-Boot coding style.
> 
> Changes in v3:
> - Wrap the lines exceeding 80 columns
> - Combine run_command() and ut_asserteq() -> ut_asserteq(1, run_command(
> 
>  test/cmd/Makefile |   1 +
>  test/cmd/part.c   | 183 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100644 test/cmd/part.c
> 
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index 5f2815b1bb65..8d6932f1176c 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_CMD_LOADM) += loadm.o
>  obj-$(CONFIG_CMD_MEMINFO) += meminfo.o
>  obj-$(CONFIG_CMD_MEMORY) += mem_copy.o
>  obj-$(CONFIG_CMD_MEM_SEARCH) += mem_search.o
> +obj-$(CONFIG_CMD_PART) += part.o
>  ifdef CONFIG_CMD_PCI
>  obj-$(CONFIG_CMD_PCI_MPS) += pci_mps.o
>  endif
> diff --git a/test/cmd/part.c b/test/cmd/part.c
> new file mode 100644
> index 000000000000..cac57a1a0e35
> --- /dev/null
> +++ b/test/cmd/part.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Test for part command
> + *
> + * Copyright (C) 2026 Amarula Solutions
> + * Written by Dario Binacchi <dario.binacchi@amarulasolutions.com>
> + */
> +
> +#include <command.h>
> +#include <dm.h>
> +#include <env.h>
> +#include <part.h>
> +#include <vsprintf.h>
> +#include <dm/test.h>
> +#include <test/cmd.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +
> +static struct disk_partition gpt_parts[] = {
> +	{
> +		.start = 48,
> +		.size = 1,
> +		.name = "test1",
> +		.uuid = "c5bce7a2-03f0-4d03-9048-01ff23b9d527",
> +	},
> +	{
> +		.start = 49,
> +		.size = 2,
> +		.name = "test2",
> +		.uuid = "9df346e8-2c53-4cd8-b9ac-3af83f9a9b74",
> +	},
> +};
> +
> +static char disk_guid[UUID_STR_LEN + 1] =
> +	"8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
> +
> +static int setup_gpt_partitions(struct unit_test_state *uts,
> +				unsigned int mmc_dev_num)
> +{
> +	struct blk_desc *mmc_dev_desc;
> +	char dev_str[10];
> +	int i, ret;
> +
> +	if (!CONFIG_IS_ENABLED(MMC))
> +		return -EAGAIN;

Hi Dario

Is there any reason to return -EAGAIN ? -ENODEV seems more appropriate ?

Thanks
Patrice

> +
> +	snprintf(dev_str, sizeof(dev_str), "%u", mmc_dev_num);
> +
> +	ret = blk_get_device_by_str("mmc", dev_str, &mmc_dev_desc);
> +	if (ret == -ENODEV)
> +		return -EAGAIN;
> +
> +	ut_asserteq(mmc_dev_num, ret);
> +
> +	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
> +		for (i = 0; i < ARRAY_SIZE(gpt_parts); i++)
> +			gen_rand_uuid_str(gpt_parts[i].uuid,
> +					  UUID_STR_FORMAT_STD);
> +
> +		gen_rand_uuid_str(disk_guid, UUID_STR_FORMAT_STD);
> +	}
> +
> +	ut_assertok(gpt_restore(mmc_dev_desc, disk_guid, gpt_parts,
> +				ARRAY_SIZE(gpt_parts)));
> +	return 0;
> +}
> +
> +static int cmd_test_part_number(struct unit_test_state *uts)
> +{
> +	unsigned int mmc_dev_num = 2;
> +	char expected[10];
> +	int i, ret;
> +
> +	ret = setup_gpt_partitions(uts, mmc_dev_num);
> +	if (ret == -EAGAIN)
> +		return ret;
> +
> +	ut_assertok(ret);
> +
> +	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
> +		env_set("partnum", NULL);
> +		ut_assertok(run_commandf("part number mmc %u %s partnum",
> +					 mmc_dev_num, gpt_parts[i].name));
> +		snprintf(expected, sizeof(expected), "0x%x", i + 1);
> +		ut_asserteq_str(expected, env_get("partnum"));
> +	}
> +
> +	env_set("partnum", NULL);
> +	ut_asserteq(1, run_commandf("part number mmc %u bogus partnum",
> +				    mmc_dev_num));
> +	ut_assertnull(env_get("partnum"));
> +
> +	return 0;
> +}
> +CMD_TEST(cmd_test_part_number, UTF_CONSOLE);
> +
> +static int cmd_test_part_start(struct unit_test_state *uts)
> +{
> +	unsigned int mmc_dev_num = 2;
> +	char expected[32];
> +	int i, ret;
> +
> +	ret = setup_gpt_partitions(uts, mmc_dev_num);
> +	if (ret == -EAGAIN)
> +		return ret;
> +
> +	ut_assertok(ret);
> +
> +	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
> +		env_set("partstart", NULL);
> +		ut_assertok(run_commandf("part start mmc %u %d partstart",
> +					 mmc_dev_num, i + 1));
> +		snprintf(expected, sizeof(expected), "%lx",
> +			 (unsigned long)gpt_parts[i].start);
> +		ut_asserteq_str(expected, env_get("partstart"));
> +	}
> +
> +	env_set("partstart", NULL);
> +	ut_asserteq(1, run_commandf("part start mmc %u 3 partstart",
> +				    mmc_dev_num));
> +	ut_assertnull(env_get("partstart"));
> +
> +	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
> +		env_set("partstart", NULL);
> +		ut_assertok(run_commandf("part start mmc %u %s partstart",
> +					 mmc_dev_num, gpt_parts[i].name));
> +		snprintf(expected, sizeof(expected), "%lx",
> +			 (unsigned long)gpt_parts[i].start);
> +		ut_asserteq_str(expected, env_get("partstart"));
> +	}
> +
> +	env_set("partstart", NULL);
> +	ut_asserteq(1, run_commandf("part start mmc %u bogus partstart",
> +				    mmc_dev_num));
> +	ut_assertnull(env_get("partstart"));
> +
> +	return 0;
> +}
> +CMD_TEST(cmd_test_part_start, UTF_CONSOLE);
> +
> +static int cmd_test_part_size(struct unit_test_state *uts)
> +{
> +	unsigned int mmc_dev_num = 2;
> +	char expected[32];
> +	int i, ret;
> +
> +	ret = setup_gpt_partitions(uts, mmc_dev_num);
> +	if (ret == -EAGAIN)
> +		return ret;
> +
> +	ut_assertok(ret);
> +
> +	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
> +		env_set("partsize", NULL);
> +		ut_assertok(run_commandf("part size mmc %u %d partsize",
> +					 mmc_dev_num, i + 1));
> +		snprintf(expected, sizeof(expected), "%lx",
> +			 (unsigned long)gpt_parts[i].size);
> +		ut_asserteq_str(expected, env_get("partsize"));
> +	}
> +
> +	env_set("partsize", NULL);
> +	ut_asserteq(1, run_commandf("part size mmc %u 3 partsize",
> +				    mmc_dev_num));
> +	ut_assertnull(env_get("partsize"));
> +
> +	for (i = 0; i < ARRAY_SIZE(gpt_parts); i++) {
> +		env_set("partsize", NULL);
> +		ut_assertok(run_commandf("part size mmc %u %s partsize",
> +					 mmc_dev_num, gpt_parts[i].name));
> +		snprintf(expected, sizeof(expected), "%lx",
> +			 (unsigned long)gpt_parts[i].size);
> +		ut_asserteq_str(expected, env_get("partsize"));
> +	}
> +
> +	env_set("partsize", NULL);
> +	ut_asserteq(1, run_commandf("part size mmc %u bogus partsize",
> +				    mmc_dev_num));
> +	ut_assertnull(env_get("partsize"));
> +
> +	return 0;
> +}
> +CMD_TEST(cmd_test_part_size, UTF_CONSOLE);

