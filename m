Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E775CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 07:02:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9951845D8;
	Thu, 30 Apr 2026 09:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="GZjiwNrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E49284605; Thu, 30 Apr 2026 09:02:14 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFD8880433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 09:02:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNuOMuayTr4xbZyt36VhtznfIJjlQ1mzmbToZi7RsG0niO+ABKruDhBGk2bGC1G7UbZFhTEv/IbkhUx/VBbIyMdT/R77e6blkXqA/CNN2R7T9FnpyWa7jiAJslOIZ0kayGSr+r9GQ6hh68n98Zz8+kaZyAjWgIJMLySr/oXBjW81MSR4LRylKYLbpzTxy8ns99ETIzlj1bA/wUVeZ6egnDqCnviAnplVTfEzZMhb6bDqNXaF2jqbMyT1Qqa2vyUjOFd0AhQkqnhCmxZBewoSUxsM5ASbPBy9GdhtTZeh8QvcK8oserB3oWmPX5swhh2QuqrfKWDXpiLLkzD8IKnzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ce4PuUp8lCOYIFPbJDPovWB0lzqRo4fUFK/+OambwBo=;
 b=rR56o45MG3RiKtM0ErQr2hix14d/Ji8W1MPhmHYQzh6S68fjSxsEU2ZpnwVJn0rdiUwQ8+lDyueIvfq4EjQkKzdTMSq3KMvSIetn2TqaJjzgSoxN+5d+wTDXy/1/wPhWXYr04KMUZT7q2IpAOdS8SSLWXfJ2siE1PShwuAMwbL9Dce6M+/9iwwhuU9a1zFUkgI2iBwqjcu786KGuvKATEF8RdVWsSjn0RzAMf7rmavda2jbeTfaOCfqN1edz8oMi9d/4ZddXhiNRHGqxggNyZVet6O0zPP+sYntp8hm7GN05DP3zV6ZrvfgmDzNGM29N7Mc3H/1MFhBXkwl75/Ry4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=amarulasolutions.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ce4PuUp8lCOYIFPbJDPovWB0lzqRo4fUFK/+OambwBo=;
 b=GZjiwNrmYdAB4jlvTbkdR94+97DOp4CqswyYvw9jTBLiNh5u+xCGaygab2RpaRQJXRU+4e6jTOGF/zUbH309yciTTXBAzCcGeUNr7mTQ15j5EkN4z0t+kWR1fu1PxDfVAgA3f7smIMps5VqDsm/FPSSHbuHrlg9yHEfuCdiWzhRgEXrT82yE0HpoMXwaxnXx802lMoqKiF4IVibNLjs13DvmMdg9/0jb3jB10YU0edfUqSxoK3wyK6p5EwiXp5DnAZvBsFaaDeFaE5K2pYqTf9dTaIXCOQt0uyFxiYYjfuD4xN+o3zOSUr5EhWfmASD805EVS6XLEDWoc8faKX6xHw==
Received: from DUZPR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::24) by DB8PR10MB3529.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 07:02:06 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:4bd:cafe::52) by DUZPR01CA0154.outlook.office365.com
 (2603:10a6:10:4bd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 07:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 07:02:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:05:38 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 30 Apr
 2026 09:02:04 +0200
Message-ID: <abfe9af0-a694-44ab-a850-d3fe614235f5@foss.st.com>
Date: Thu, 30 Apr 2026 09:02:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] video: support Rocktech RK050HR345-CT106A panel
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 <u-boot@lists.denx.de>
CC: <linux-amarula@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Alexander Graf <agraf@csgraf.de>, "Alper Nebi
 Yasak" <alpernebiyasak@gmail.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Simon Glass <simon.glass@canonical.com>, "Simon
 Glass" <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini
 <trini@konsulko.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260225161851.2475274-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B90:EE_|DB8PR10MB3529:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdc56d4-bea8-4cf9-df38-08dea6866383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: UkNuO7n3SoES7EuYTZHV2Jgx8o2JMvhYBh6mY1EhQaF39+iV0Gw5lFuyWBQo9ejgkCMh/sm+iKiu0L8AXzLP0zAtvAlIX5+r13NBREXadkuPwa7fvDa3LYqOkS8eBgmOEAjVuV47fG+cPr6h3eM0jAXr4MCcyEmCEKqhQ4Jj6Yy5xHeFBLldTzPuWOCwpdnFUfhP7gI7aXWfKPVKPGwPLN2DGswgfBVM17BAjdPEMI1szRQU3k8j6PSCb/D45DBvMlKp0FgndQy0HT9HxCegHl5H5z7oOfMT8IbGTNyW6J4Hq1/A20dZqBrk1Y2oUcN5igED4Qy99+6K+tPcq5Ro8wnuPzEtm04ARE2KGKYL/2fW50biiGB4gnDhtfwhMoqPBDN0zk+jYZHI+EJa/kUAsY9cMY/Kx1deE1cjFUTx9hSOB32t/NuKp2iGb6kjDbQsPnxV9kdKQjtiT/oIu1TtPeM7EYnCL9fnFOckk9pkdCmU1IeiyqKEVxiz/+eqdLrkghbaR+pxxgHPopabsOvr/qQiYd7u/MykGgd2I4+NNFlok0BYjzjLK2PatnNiOrlVIEIFC9AECdZBNoTHKUwBscudt9ivdR4KfPXCvuWnx/N50EuW1HQ+pzvxc+izYngIFz+DVbs5C03wapdE6zELv5oWdGmKfKsvz2MGJdl7nqKXz6U7ByH8lTWfve/P57CVCbyQJehLgqiRz5AlfX3lE1ynmgwVC4BOVyzE0pctZSBv9fOGnKDRGCD8CB3Mtqn/hncyandnV9btwnJXzdbeTA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7PN2ZVBIt4UaB+fHwyzdI0Rcc/+CI/Dz6+KOVj47pKWPskpPHGX+Q9hTvdfxS7RQWct0rLt5Wch4bbhm7by1VdcbK/hviBGRlfoU5Mev8PjhO0jxCGL+ctQ0GR+GWVxSL5ef1WJdUbqJFYoYTJ8toVkN9Zdf3oCjJCN0ZVAncVI8XcJXDRLcIfRgJ8/BcFnkeQNjVQBJclSkSvTKyyN/FLxpnkQjvmUMLSC5yYsQqPxrGgHtuERcPqD4EGo9JZv8iUEEZx0kOSwCo1SNZsZQGryfWm12YCdFL94hEYzSixeYSKRZyf3ISqS5UxLE1UQMTtKnYawICDcL3zMfhpIh++EH4d6tcP0yLmCBe0sOKIhKkOhA5WQ/e9SIQ1wBKDbZgHCCDfmFkXuQ3u5PDMSdnGbyQY57i6okAmNf0gW98Sx1hOWfAaJNezHkWWnFPDVi
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 07:02:05.7450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdc56d4-bea8-4cf9-df38-08dea6866383
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3529
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



On 2/25/26 17:16, Dario Binacchi wrote:
> This series adds support for the Rocktech RK050HR345-CT106A panel.
> The initialization of this panel requires a 9-bit word length
> configuration. To support this, I have extended the STM32 SPI driver
> (including support for the STM32MP25 SoC) to implement the set_wordlen
> operation.
> 
> To properly validate these changes and ensure the SPI uclass correctly
> handles the word length propagation, I have also implemented the
> corresponding logic in the sandbox driver and added a dedicated unit
> test.
> 
> I have grouped these patches together to provide a complete overview of
> the implementation and its verification.
> 
> Changes in v3:
> - Use struct spi_slave data to access wordlen parameter instead
>   of driver private data.
> - Move the stm32_spi_is_enabled() helper to the new patch
>   "spi: stm32: add stm32_spi_is_enabled() helper"
> - Insert blank lines to separate code in ilitek-ili9806e.c
> 
> Changes in v2:
> - Rplace tristate with bool in drivers/video/Kconfig
> 
> Dario Binacchi (9):
>   spi: add support for bits-per-word setting
>   spi: sandbox_spi: support wordlen setup
>   test: spi: add sandbox_spi_get_wordlen interface
>   test: dm: spi: add testcase for spi_set_wordlen()
>   spi: stm32: clean up buffer length assignment
>   spi: stm32: add stm32_spi_is_enabled() helper
>   spi: stm32: add support for bits-per-word setting
>   spi: stm32: extend support to STM32MP25
>   video: support Rocktech RK050HR345-CT106A panel
> 
>  arch/sandbox/include/asm/test.h |   8 +
>  drivers/spi/sandbox_spi.c       |  17 ++
>  drivers/spi/spi-uclass.c        |  22 +-
>  drivers/spi/stm32_spi.c         |  71 ++++++-
>  drivers/video/Kconfig           |   8 +
>  drivers/video/Makefile          |   1 +
>  drivers/video/ilitek-ili9806e.c | 356 ++++++++++++++++++++++++++++++++
>  include/spi.h                   |  14 ++
>  test/dm/spi.c                   |  16 ++
>  9 files changed, 502 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/video/ilitek-ili9806e.c
> 
For the whole series

Applied to u-boot-stm32/master

Thanks
Patrice
