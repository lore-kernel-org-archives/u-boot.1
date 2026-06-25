Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9992CDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1C184704;
	Thu, 25 Jun 2026 19:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ml/uurBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E0F184942; Thu, 25 Jun 2026 19:02:15 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7E08460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFFphJtBk7b5GCAdAssf8/gnPErqpe/AbPKFXdrUbbsofA8LUUupK1ELUoXYwNryFmQTdk6MTXwEYnvv29OgCdzr8ndG+IsRf5cuhaYbhMYZrx5jfCEWM+pXbgkGNp1z/hf7FEKNcr3IsjoBIoL6IvZRE0z9/OCTR7ST/WdQE7bwz3LpsOXC+MGzL1+XpgyQ6RXjVPw8+wAyZibaCVLr3866zTlhYORlRJ3m7bR9Ov7joma1H+qLYI4In2tDHizuf3l52hyRttlseE/3/sSrca/1E9AL9Xt3IprC4V+ISQa9E4HWzuK9ReZpq1C8QEioiZes20f9TmZMpGy0V0gPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPDQMwrsS4nyWYqvKDJPH6V7v9GPIwNrkhJ+yRg9sts=;
 b=US5ID2hml4/j2PeKLDPYRu3vJ6ENwgov0RfExOmSYU6z2JsQ1HBf9KNEwQJ1QvVIqRjZ4kIew9ICmj1QQF4gg8o7KOYESSVh177kh+X+OfatT6C2Zy/LWiVJvLOABXa3ALxQU7jf6i420Ws/bDII38R7Td1eNi+pdh+e9T7C8j7oNPxRtrZ3maZ/4nCjpPU7w/WJAFtYDXdhy4imaGb3OXRPbPBBBq/Kj+mZv/7Kt1BIeCbN96kXXM9sltGkih6DuPBoQdMIB62NzxLk3wxBuCMcnX3Xl/CHaclWwSTmKGJIMuWmT+QSyxKt4aJ1V0YvzaX1C6ThFZSYwEXrc1L/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPDQMwrsS4nyWYqvKDJPH6V7v9GPIwNrkhJ+yRg9sts=;
 b=ml/uurBU+KUPq8ls5AKYect7IiQH5XvaMBH52CuX4TYJooORX8LRVJRnIJJAoXDT5/B5oq7dBd04XwN5iVSyC88swLPmZarWGSnv5tTLXS6Y7VvR9tIDs5yMEtuROBfcJl+Hv0TivrCS9g+n9ACuqxniohHVIzB3/bOJHQeW9x2ABJL9bobE96DoJAMH1l7tbqxZdNdujre/jK3CJZQgoZObOYGdus1n0W81WL4usBU8uWHdB8nfKTuRuvWCjVr6NE+yNouAYOojM9iyboA/u0wUbdGxKJ85SQkBABTufalGe8t+LQgJ/Q1bXKfFi7SldbDytzpxgJ8AbABNSOShAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM6PR03MB4922.namprd03.prod.outlook.com (2603:10b6:5:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 17:02:08 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 17:02:07 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Andrew Davis <afd@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
Subject: [PATCH] mtd: rawnand: denali: add NAND_DENALI_SKIP_BBTSCAN_SPL Kconfig
Date: Fri, 26 Jun 2026 01:01:53 +0800
Message-Id: <20260625170153.2593-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM6PR03MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: c091918c-4bb6-4b6f-7405-08ded2db7d24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|5023799004|6133799003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: WW5aleEnWiBKHUU/PIUzax7KVowib/u/YeVVv/kyq9USfOEugUu0G1gNW/rxaWgtQxfDk1OSJ8MUaZeYDooiTBQzKzIRzVLUNg3amZIRGr1+WEvjaMUy6NJIkjipzERj5ruQZbj+Gb6pEyWtOZ1P9h73kMdQzvwgD5hCEpYX6cwUgrQu6029PYTuguxG5UnAoxKoVPw6JrAhIXHbIwM+aReFZZejTFkVdOZ3qydB1zuRpFOmvj5NfCZoYtt95WfUzoEr/jUhyLmdiMWd80AR66srNj8F+dsdrFA9M+QWjtJP8v7cbN/aWpe8t7w0iP607eBPGPCWylI+t7NKBzxBLkTAQUqD3K9hrDEvMFpuNt0weED4KKsD1Ln86mKdSRIjd8FsMcv0mlXCqMlBYZRO33vu+H+WmS5nb6e4acz8VC9SrkCNHlDzbb/dwC3xm1wKBYTgiz+9dSpIKimSyLrOW9kvCwkkDc2AmMcRIlkJQSS/hdEEJ0vy+RMJM5LolStM0YubOc7gEFqXzn0x+NTDZ9QOaPwJuppDYQxuBApKGDBhM1F6bzLiPsJ4ewLX2u50m4OdZo1H9ucW4DxoY/DfdN9ARC1Dxbtf6FiYbpxH8GEEhwF50sycCOi1H+jS45y/wGx7NtNjQzPfTZtM5kP1mCrECukJeSTSPvV0lrM3g+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(5023799004)(6133799003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?12uhwSFeloD0TKDnODS9Xu+hEm7uII8qxqA9lYTmXYHzRAjEWlqtPomuhl59?=
 =?us-ascii?Q?2yduKEVPXs9Q5d44A6ti3JlX8zKTaDiEoYYe0A2HsP7LBvfIwe+DV8FNorXy?=
 =?us-ascii?Q?iJKDSmkHepCVBhC4A1MfzvvDO6EAe1XfQ21Te3YHVbxp+6Jk1tz04RS/xnUI?=
 =?us-ascii?Q?Nz4U4MUA5eDHUTmOsz+nmNEmzFpbnw120v3SBHUCxkNqZNoJuIZ/oiL20YNW?=
 =?us-ascii?Q?MncGvgWSEdu0ZU/K7LMp9xRxho280QX0soaQ7rPO51V+fpym+VRDfJw+lWc9?=
 =?us-ascii?Q?SphI5iffxUbDd7qukAJ83OH7zHWeVex4IZphP7mwRmSW2Lu55vB5T+fopml7?=
 =?us-ascii?Q?CmauP35LQrTJ3YGpyvbnH0jkL+celew7DcwNbJcxLoByQCeDoXxZM65d2XTp?=
 =?us-ascii?Q?6Ze4+pTWec6uD6MAtLYTklLagaMmI6yVYoEu2idph+ikWguZ8qyfGM9Rg4u9?=
 =?us-ascii?Q?jVz0/zmMDN6u2Zid0FJ66Xjy3AK1Cs0NXKzLt7RT5AnEbCuzHKps3SwuW0ZT?=
 =?us-ascii?Q?wphd2thkN3+Lh2t6rn5UeUfe8E89da/CKJ9Oakw7yHjxWp1Q//9iXsJn/LR0?=
 =?us-ascii?Q?EvkjANZaIP8/Co/BUKh5eBoLIaiGWqHfPyJxM7+5gzSHyHyD3Fs5v/gsfp1I?=
 =?us-ascii?Q?QD9c0BDRhpASHODW1osOFPkYIGrOy2xdyv+AOMglRAbMze0HLdznzJef8TPu?=
 =?us-ascii?Q?18pWrzc+oNGSGI5qO/CtwYWazNfY277nkao24ue9M4gqgKW0u0jc4Exs0/Dr?=
 =?us-ascii?Q?bwSpqZVmllsqICrYy/TLMmaJs5KBCnMnEEl5P4eWEOmd4IQVpD24qeDnKRrD?=
 =?us-ascii?Q?0dmgfTSVOdKfPhMXJ+PaNyVOqcCvPTnX09wEGkzBWyUhb8aN6MkIbt7x6pUh?=
 =?us-ascii?Q?zIGzMWEEQtEOq0GZ8KKdM1wl/DanfRDOCMq93iASXXYrUSZxTVga72UyOdmk?=
 =?us-ascii?Q?AXmSdYDk2ryGUoPFqX9Fvd4C7wTNx5CntfilRafJ93CqXorQCiQjXF3Fsn93?=
 =?us-ascii?Q?SWJHUYcJqjXwgo7aHfkcVd0KmBH9KAMqFpQyUrDdUkuNbypN7oC+dYVDDeSq?=
 =?us-ascii?Q?WifNfTvzEyBw+z7MCzR4DIe/6sToCIy1azvPLjkElwbcbt7VWgDKqpD0ewfE?=
 =?us-ascii?Q?BBEUDgc8FJiMmN+wyLJb6mJ/S9H2JlpnHv9DH9JiuOkPSI4gad+QFqKHXnqT?=
 =?us-ascii?Q?fPpDe/egCU6r2wKwIfFJnS8JTy3zFfYUvS8RdDZi3V1edzc0VsigJZyjGFu0?=
 =?us-ascii?Q?uo8UVc0JMHQf2GV8GrV0F97nNfh6ix1eKtWrAJCqBzG8ebOt7VSfWgiTEl02?=
 =?us-ascii?Q?zHPRtCYhf4GF/4mCXbil2nq7QtK6l5KY7TffTODw1XfAi+lSFGO9Yqxfz5td?=
 =?us-ascii?Q?A6GrpftPhB0mi91glE1d9OJ+cLtuQsUi132uZTrrqI29i3POOBeUapA6lDMI?=
 =?us-ascii?Q?REMO3dBXO5DXV1cuzAuUlSd0PZC6wVEi9AkIW4wVQK7uIl0KWTk5GQkyasSF?=
 =?us-ascii?Q?ukpieXRLXxCkzWRngkLMlai8bfU12bPUxODy4j09sf/xPMK3O2zwIJdpKdqc?=
 =?us-ascii?Q?qSGMV3o5K1wP3ttn7QVZ6d9eLgCCPbKZtyxRNP13HVdU5NUh8waZiFmTJ1Vl?=
 =?us-ascii?Q?JVDAvctWyQIe9a1+W+FxGlRDIF9I8kOI/9WolyJBO2d5SDNv4zUwWUOe5vGi?=
 =?us-ascii?Q?qTIUg4C5ezBKuk1vQhQSKvKYw+jpi+b0xrE8PHa3uFX5Fwm1hnHJ4d4TWN/H?=
 =?us-ascii?Q?nwx4z30HsWHK9IACi8INWfcmhjjiNy4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c091918c-4bb6-4b6f-7405-08ded2db7d24
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:02:07.5821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBxjRBXmIyYjthkJK69Ygf6kgeQaKnBYgrXqpf5sRznnXBzGnd81OrAD7WQ77qKsr517bhkXqA9ptfksTqDsnRxqYkrFkbsBphN98ucjBIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4922
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

The full Linux/MTD bad-block-table (BBT) scanner lives in
drivers/mtd/nand/raw/nand_bbt.c, which is *not* linked into the
U-Boot SPL build. In SPL, nand_base.c still calls the chip->scan_bbt
hook from nand_block_checkbad(), so each driver must either provide
its own scan_bbt stub or set NAND_SKIP_BBTSCAN so the hook is never
invoked. The Denali driver currently does neither.

For SPL the cheapest and most appropriate option is to simply skip
the BBT scan: SPL only loads a single FIT image from a known offset,
nand_block_checkbad() falls through to chip->block_bad() (an on-demand
single-page OOB read), and we save both code size and boot time.

Add NAND_DENALI_SKIP_BBTSCAN_SPL (depends on NAND_DENALI && SPL) and
honour it in denali_init() under CONFIG_XPL_BUILD by ORing
NAND_SKIP_BBTSCAN into chip->options. Have ARCH_SOCFPGA imply the new
symbol so all Altera/Intel SoCFPGA boards using the Denali controller
get the safe SPL default automatically without per-defconfig churn;
other Denali users (e.g. UniPhier) keep their existing behaviour.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/Kconfig              |  1 +
 drivers/mtd/nand/raw/Kconfig  | 11 +++++++++++
 drivers/mtd/nand/raw/denali.c |  4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f624675eadf..db8d4a121b0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1195,6 +1195,7 @@ config ARCH_SOCFPGA
 	imply DM_SPI_FLASH
 	imply FAT_WRITE
 	imply MTD
+	imply NAND_DENALI_SKIP_BBTSCAN_SPL
 	imply SPL
 	imply SPL_DM
 	imply SPL_DM_SPI
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 69a254f6650..261b9a51dd7 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -223,6 +223,17 @@ config NAND_DENALI_DT
 	  Enable the driver for NAND flash on platforms using a Denali NAND
 	  controller as a DT device.
 
+config NAND_DENALI_SKIP_BBTSCAN_SPL
+	bool "Skip the bad-block-table scan in SPL with the Denali NAND driver"
+	depends on NAND_DENALI && SPL
+	help
+	  Skip the full bad-block-table scan during SPL boot. With this
+	  option, SPL keeps chip->bbt NULL and nand_block_checkbad()
+	  falls through to chip->block_bad() - an on-demand single-block
+	  OOB read - which is sufficient when SPL only loads a single
+	  FIT image at a known offset and the full BBT scan is too slow
+	  or otherwise problematic in the limited SPL environment.
+
 config NAND_FSL_ELBC
 	bool "Support Freescale Enhanced Local Bus Controller FCM NAND driver"
 	select TPL_SYS_NAND_SELF_INIT if TPL_NAND_SUPPORT
diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 39cb641e0b3..74e19922645 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1291,6 +1291,10 @@ int denali_init(struct denali_nand_info *denali)
 	/* no subpage writes on denali */
 	chip->options |= NAND_NO_SUBPAGE_WRITE;
 
+	if (IS_ENABLED(CONFIG_XPL_BUILD) &&
+	    IS_ENABLED(CONFIG_NAND_DENALI_SKIP_BBTSCAN_SPL))
+		chip->options |= NAND_SKIP_BBTSCAN;
+
 	ret = denali_ecc_setup(mtd, chip, denali);
 	if (ret) {
 		dev_err(denali->dev, "Failed to setup ECC settings.\n");
-- 
2.43.7

