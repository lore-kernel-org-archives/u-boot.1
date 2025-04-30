Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94FFC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 05:09:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C7F8283E;
	Wed, 30 Apr 2025 07:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eElzGkF4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B2CF82AAE; Wed, 30 Apr 2025 07:09:46 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 434438272A
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=neFZhIaEgvYg67YhZ84p3NyKMdwG9VFK18h2zYbMIjViYE2s8yJAk7yMGqarJdN1xcZ75BOaqCCV8J7sZEp4LN9GPpjAXM+UWohxPb+SUehkeNkl4ssy3kt0lmHkzpMkrvr3eYxRx1Ri/ZENQ05DNX7qYdk/SB6lUT67146saJLiiNFluJtcFocNHlBPdpWfzl921ak4usyHpwm2zfxJ1lT4uHq8wydR+J2xKWwffCsMrU6x9nWNSzoNgJSq9uQGJPS/dmqHAeo5y3tzdlrK7B4zJT3M0FMIAjHGwtSva6OyTwHsgmcRyghJAI43ERTgIyG08tYTy+Jeb82tPTR/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eiQxaRBEqFguu1pd2NqfDMWdAnBOk15Rqku+Lsoywx8=;
 b=rf2pt6yd3CdT4Od+YrMTXaXSsNArThcvbprEgIyl6LuvW+svfXTj5g4eIy3rufM3nuwTQXQ9VuEgdNyPjCfhwJK0sznmQ68U/kFt08f+gHHTeWKYCR7vKfxcrM/Fj+GxXqa2Td59TrGY0TLcjlRcvzPajUEUXwevZwsUoJ/zPRa7a0cNEx577U9J5w546xxmJ70jfqYoRXNzuhj/RI+gPtHF+COnvjzZ+OULaE79KpYpzEuFW2V2Hh3XeneiyPP8L3yj1uguXiyzZoyHkx6ie0T4zJC8bGBfHXZAKAQLw0cpzW2AKD7Q11ZBp0ZenFkv0/9RrWUwtl4SdOfDkEOrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiQxaRBEqFguu1pd2NqfDMWdAnBOk15Rqku+Lsoywx8=;
 b=eElzGkF49zKUNMdC/UWvP0rfgYvzkdqNRG1eJdt1UXV6YJVB/gqRZWs2XxpUOEZPFxFIlh/xHHC0CyYYeLKo/kb5uDOKv2NbJ0BhJNP5cIKrhG6kq83E3zJlp6EUZ3n3LfOaQ+sacy5aM4ydcDLN6SE4g8mINHcFoYzbQTUH9iE=
Received: from BL0PR0102CA0034.prod.exchangelabs.com (2603:10b6:207:18::47) by
 SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Wed, 30 Apr
 2025 05:09:37 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::39) by BL0PR0102CA0034.outlook.office365.com
 (2603:10b6:207:18::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.34 via Frontend Transport; Wed,
 30 Apr 2025 05:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 05:09:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 00:09:35 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Apr 2025 00:09:30 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH] spi: cadence_qspi: Disable the DAC mode in indirect read
Date: Wed, 30 Apr 2025 10:39:23 +0530
Message-ID: <20250430050923.135256-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.44.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: b85fc730-f387-4466-f663-08dd87a533f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c1ZWI6JchjhAHQccstq/LCjqtNUAT9m0gsTDB0qgDSPu+EJyaE3fpSOoNaNr?=
 =?us-ascii?Q?LHHaX/D4k2vejVf36rcgfkOPduW/FlmRhTmXhLfv5ogi/KO/OpoI9mgy97x/?=
 =?us-ascii?Q?Qk5XhcLTW8DMjod+F4f1Kp0RHTc2VfQDAU7celMgCZk/xOStUY37BcuIDuuf?=
 =?us-ascii?Q?MVgzvY0vWenmm2/9bSBjc4guvqhY62QwJaMvdcU+pb29XGSevbLQhCqsqZrR?=
 =?us-ascii?Q?707bkoinvRiyU+2xVBTGrshKFC5QuqxTzO0z8KSsqFo94D7/Nc61+X8tWCI5?=
 =?us-ascii?Q?D9Yvxd4a7CaBjMT9lnVuVeDDm8RQldk2he09XDigg6IWoA3YsZEcRv1YB9Hn?=
 =?us-ascii?Q?ahI681hCxWQuhpTFpAE9V84zXzkJCI+U7dma1pNvQLixLawS9zXCsdW3rNDd?=
 =?us-ascii?Q?BkeE1KeF40NgmsM2XrJq4FwQrb3MYH5yELyQZH1XzqP0Gwa5yLQyH/bwYHHH?=
 =?us-ascii?Q?j07dy6RbglzIzn4FmREloVjvd09BS5s2C94QwIytgTcCsZGWhRF5Tr8gKkVt?=
 =?us-ascii?Q?oyZi611HuAHT3wM//J1i88L2vnNo38n9LV9wYUTzSn8cGOfj1xiAuVLEkr2e?=
 =?us-ascii?Q?1qqmOmEBPh7WPZC+s7hzv94t3vfAgxnWkxSoil1Xsh1wWf6JIKOHwMI4Ibd3?=
 =?us-ascii?Q?cc9TqpdpoxGDYcTiOBNYAZmTwiKhkxdlq2mz4JOBqWyxF/s6Aqidm7FNYuey?=
 =?us-ascii?Q?5vbue7c572TmjkIV2yIS5ApGs7YGZ3HM2MMofwHT2K66+4HM9Bt1F6L3OXAU?=
 =?us-ascii?Q?Yx28IGYaBYD2EGdUTQj5hRPVhvc15BSdZz9SFm2JKk7hLJZcR9ArI5IhMyeE?=
 =?us-ascii?Q?Hk0wwdigXa3M2CfuVrcIVZbFtnHSuusFcQKKJODLxHxshxLdQoSWp44rJU+9?=
 =?us-ascii?Q?3lxTwuFUb0iRSzhSr653zdxesyxwS/EIRlS8JZt13wdDWo0QrQr/OjcpBDDO?=
 =?us-ascii?Q?fTnrZCVAaHg2krW6eWoKKac7ENjDNwpdwXdUaD2bV+yCd8luCEo4vLoavOKa?=
 =?us-ascii?Q?7gd9CoWu2Kb00y+MKLL5gia2AM6ozrQwJT17J7g11Z48uiPgMTuNA0j+tmoO?=
 =?us-ascii?Q?oBEzprLaFLVNYiqc7p5Dbh5cOQ7OvUhcn6TYnG02/fw12YVOg1VHSxlxIoEV?=
 =?us-ascii?Q?O8EHw0/5pTbOqVyLX9Jlw3m4NSVHH9ow3MY2gakhmSUxzYYkU3vyfUxdJGu6?=
 =?us-ascii?Q?2APR6AyoO/htYGbLEy7kbSqKDJ8WD/rySKgBncObC9hMtCPc8I0DigbKGFA3?=
 =?us-ascii?Q?NAz2Fhnj8/MNQ+bo9EI664lNXTYs+IAQf+LhAcoHXkn6xM7ZJxYH4UA6IJV8?=
 =?us-ascii?Q?xlNO9rpEZa5pJhsumnBaLqLB0KHp7c6M1KwTDhjAlU2T4RDDW/UEwH53A/zQ?=
 =?us-ascii?Q?eH9Zhhfh4nAEZqsP8NULB5io1HxVbWtjRGZp9Wr28WEquuHJS8DjiXbf8dPK?=
 =?us-ascii?Q?1JhOTx4lwuXc0j/JGR6izN33yCXOV8zF4R6SF1kX/2OhFg5Hkk+s2nkxkANP?=
 =?us-ascii?Q?+Ja5Q+t78TqLXcLyqxFfZFp1ct0I3J0L17Jc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 05:09:36.6822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b85fc730-f387-4466-f663-08dd87a533f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
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

Hang has been observed on QEMU, as it starts with indac
read and fills sram, but after dma is triggered, it tries
dac read instead (based on priority) which gets blocked.
Disable the DAC mode in indirect DMA read and enable back
for writes as DAC mode is used.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index fbeb0c6a85c..a78a282c543 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -36,6 +36,10 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 	bytes_to_dma = n_rx - rx_rem;
 
 	if (bytes_to_dma) {
+		if (priv->use_dac_mode)
+			clrbits_le32(priv->regbase + CQSPI_REG_CONFIG,
+				     CQSPI_REG_CONFIG_DIRECT);
+
 		cadence_qspi_apb_enable_linear_mode(false);
 		reg = readl(priv->regbase + CQSPI_REG_CONFIG);
 		reg |= CQSPI_REG_CONFIG_ENBL_DMA;
@@ -116,6 +120,9 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 		memcpy(rxbuf, rxbuf + 1, n_rx - 1);
 	}
 
+	if (priv->use_dac_mode)
+		cadence_qspi_apb_dac_mode_enable(priv->regbase);
+
 	return 0;
 }
 
-- 
2.34.1

