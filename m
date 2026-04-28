Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2832FFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83FD98469E;
	Tue, 28 Apr 2026 09:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AysIQEWe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC938416F; Tue, 28 Apr 2026 09:00:50 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 802CF83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RajcTKHBawxBxpRuF5Z48kta2LWdbDtzW0QVDVnaBMl2d2qmUr9KFlv02PkcoxXieNT2fJbl8/wnSrDvN0a5/MAina7FnwdoBMgnokj2B8akdMAjhhDOh3Q/1EjfvKB8bu4PiffBZFHO0jDOpph/98Tms2EKfl6fgVnweOfTh3zR4ow1afOQbBJzNBxHGRz+KXEMBbsEua/RXKel82wZy5n2YCSHMhmEWalKE1x+oYHZE+/prRWZrd627MrCm38dv0yBCqblFtBQmFcJuQ7CWO7WhV+s3mV6Owo0opnvXgB2Rv+RwjOAQorHpYpkQpLZY//AUYFIzYSTMGDCpJ2zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEEBZggfMbtVxv7UA5sXQLCtscKkEF1ZFkGZcJP/+Hg=;
 b=yaPikCID5R3rtC8a+mx/j5yNFZjXsqqplo6vQaY2Xzp43Tah1f3LR1F/By5ft9xctP78RZ2u88yBNEug59ALKwYzl0PeZeMWhMahII3eMN5sVVfnkv3Y6JbyrZxXfQ9iC3JHA9K7Z+dgHz3J5p4DIPTCu2loZQ2eUCcEZMm+5UpASMNSJ+oFDJCAsamWfOwwerr/j4t83AhTIaMHcKRy5SJU+ElRuEagOM3EeOxyhUn0tOLVF8SFsKounShRv60DPNZlZWyOM72PPUxHHCNOp9WTSDmgqntjRlBYzh/zpDW9gc83b0gcHzObgz7B2IKm5eQ/+GSxz15F1AZPMfkZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEEBZggfMbtVxv7UA5sXQLCtscKkEF1ZFkGZcJP/+Hg=;
 b=AysIQEWeoPcH54UoOvB3QmsTQbFkmBh2hcU1QWIa2kjF5F/mkiA+VS9/m2YcXFUVu7uvqXwp2IhoHuRs9R6nQHKNX7V7xZN7mpwgrqxKBe0jd/nD+xiVg0iw60ae7YSIIFAfiLkmAPKQfHLDsUZ5ZoR3zEwkp+LX6QeU5YcGvSYvWAr6v8aQUnSNLszwEQOGRjfIMt1Cj0TxtfUhE855gZ+mocklhNPtKRuAZ3EdbfhRlWpL1ituIoLzaeNRGHCjX41v+3wgHXL/hV8n9NJxaudh0wu42Gzg3tSeTpC7n8Go0+IZFgYZFJJrhbN/PB7KPohiO+0nktaYlSSuETngnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:00:43 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:00:43 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 3/8] configs: socfpga: n5x: enable CMD_MTD and SPL SDRAM
 support
Date: Tue, 28 Apr 2026 15:00:12 +0800
Message-ID: <20260428070017.16807-4-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428070017.16807-1-chen.huei.lok@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: daf1881b-6c51-4c37-4bc0-08dea4f3dc83
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: Wa/+DFnlxQKDOl6ztLpgjtL2dwEY8ps0Po9KnhMktDEHIxhwJ8WLY8ZnzC0WJpL54KXHt5uj7dcL1gRFN6jbemq4rsdifINkO3OremtsID8Uki8ZIWPhHyiNpseeIZCYbrDcSktA0UhZ/ZBB+eYjaTAbh/3uyIPieLpNYtX1aW7YDVegsjW1+tjaipJxIDWisFFZZme3jldBh7jVs1RD5o3/K5YRsWBrwjt2nNueNwD8Glr2CHrXHEZ46ZRllAI098rnqp5LAmCg/71a/Wq6BBbMaOFMdqkDvaBwe6zWnZActIeI3S0PtSzupU2qSLyMhhXLOfclEI6nNHsDjE1W/paDvl1HmGW3cvYOP3MIasHfl98hnQfYWhqRYiNGdEIR+EKKLPs12H/Y1ZpZFDsbBiWvLUYZzLsHPY87p2H+9RZUA/nAbBPFN4uM0pUxEAxLp+EwYpOThS6WoRAor16KlJxwZe1RopotKMZWP3+IWqDWaOvEqWwu0a8TQVPEovDQbuEN6/bCeend9z4w4/+/nsNFwzKclYMUHglrOIq4t4SYF1Ko8uQjsL/15iOVgujvgrMTSh/uKokn2PFhEkkcuH1jXpipstSy99JW0PL4MAcwZpSCpp7yHLXbP38qnCN7eOFtJMQnJsjrzVh0TYIS5QwYB8CN7B8IDjonrT5bIv6pSZa39coZFXvs0+3e0nzp6rC/+74Ef56sL1hNzmwaXRFZR0Xij0DlTmOmI/1eD6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hOuxLP4HoG498ua9/m0o4MO+0QgU2t85LSEVQu/dpnUB9yC+oNlihtruubI5?=
 =?us-ascii?Q?mGofTRmcjMlaayt1ke3n7LwDGys+pubHCRv/tjYlgmYo+OM43QkFhO/zGx+s?=
 =?us-ascii?Q?FQ3IOPHClJZO4FRa8Kz3pDp0YWsHk9qZuLK06htfTo8gSyYF7XIgm+u7cFIk?=
 =?us-ascii?Q?B2R8ePtFuUVAVBR98u0ivgwnWiAWUk0XHG/+rTWCv2WJOB+tNqCffKmgMB7m?=
 =?us-ascii?Q?lyz/eroGgSiMP9NcQRln3pUEF+mhMyKGcdEjZDbBRK30RYYh7wXTczDNRR8w?=
 =?us-ascii?Q?xA7aYIIp93xaBTkr+2J7xnZ1wXAr6OAhuArw3FwewQv9QsHM2ft2P9XzDunk?=
 =?us-ascii?Q?pkczz0gSSpjYs9JyBTC/PevKjaDd0xGf7BTGzhd5s61n8bbDwERU3ZOAuAfD?=
 =?us-ascii?Q?QMaa3rVC1OdyOkJIPfBlcIgln9VZogqCPcHoicIt55BJ5yPxySyAQw+pp0Uv?=
 =?us-ascii?Q?1YxmH7E9MoyHpOb2P9QJQpcdBNXTVZyBI6+0M5ur5WL/5eHzg6bob7C7YHc4?=
 =?us-ascii?Q?RbSULI1E+yfkSeHSC37UccGawPmOge8KXoNZTEijSJqhzjU5ukcIqnRd7X7k?=
 =?us-ascii?Q?LztO7j+rF2b/k6rPUcA9sXZc7JdgL5TrorfBM631mgilvyLWF9F/LqvL12eD?=
 =?us-ascii?Q?MC5JX4473HOX13OJomiZI5McpWpyj7KJJFDWV6Z0st7BFyzJg6Xnt92DLols?=
 =?us-ascii?Q?K2wwxj4/iAaIWISP43o7Aq0SGs69v50gSIZBqGGCl/dX+Wm2Fko+5X6TI9jU?=
 =?us-ascii?Q?d1pU8lH6GF4iQugdW0YKCI1eBjq+Lc+Px/5HCk95eMl/GyBNg5+GuPiQYRz4?=
 =?us-ascii?Q?WgBNZ8v30CvZXLNdrUB7OzutlIhmtXLDKkyO+MAUbxLmvpHuDq2GdESCKwMm?=
 =?us-ascii?Q?ynVW41rszajSnkgwzW9G7y/6m7Jtykdb9J7/H4gnXqaiPOraBBv9iY17SC+1?=
 =?us-ascii?Q?YwCGnhjlKm5FJ/9+KTE17hmI1o/wjF6O3W9RhILANlcStMcVnRnmflyFvrnS?=
 =?us-ascii?Q?XvcOzagHvUogZaZ9cF7qu2I/VWwQnZlPN2nAytYPoAiBH/0p3nz8yjYo8Gxv?=
 =?us-ascii?Q?u/c5P9CTjnw1c7mu8TPmMuIL+IJMx8pt2BQBFHPIhSK89VG2tdM1j5brIsbx?=
 =?us-ascii?Q?pSvC/zZcKALlmrE21vZt4wEup7tD6sMLIpjV8WknnV8nFMZDc1QJyueTv6/Y?=
 =?us-ascii?Q?fNSmOOSgmb13X/8KiWWjs//gtggAZmPK198QwBXVeNSEyoJoK2asmMytI+JC?=
 =?us-ascii?Q?t1HXGKSuAaFLAm2oyJUGKbcpSMESRWDC8T3IoPrL60i/998sEmsZCP81AX/u?=
 =?us-ascii?Q?12q3zImz5uFnkuca0Olr/spzuORRYZpTlo4OHb+24MdZy4qSFCDF7Jq0oNyy?=
 =?us-ascii?Q?HQYs9teKRAjuJwAVSEsTFw+GjQiHMY2Kdj4noYAzaicT0LOoXHQ5F6xf29MU?=
 =?us-ascii?Q?JU2ld/fNFg9vfIoSqZ10Jir81Hb3uU8tIhr3FJDBx+O3ebQLnE5xO7ODKR6V?=
 =?us-ascii?Q?9CriChaC7g+11fvvdDPrvakaFQ4RilEfF+q5vCMBB6V15kKLyyqQPUX3tkGv?=
 =?us-ascii?Q?KcFruVSawwpAvUok3YXfDtGuzNDgn+nF/qoysMRSYeT6tgIAvwHgCv/6I0gd?=
 =?us-ascii?Q?XwTpngJTXE2LyzGoNgtU+gbJFZCzOTTxvmvFiIvLduRw3rIFO58kqiPDcERA?=
 =?us-ascii?Q?Kbq7AlQowcfBvkz4OzyjTEAf2BosN2Hf6UX69z4Sp8LkKGVUFldJ9kciYiaP?=
 =?us-ascii?Q?V5u8PHn6efbLW4odtlglejhA72zVfXI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf1881b-6c51-4c37-4bc0-08dea4f3dc83
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:00:42.0219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5B++AteE5nVz7CmqaSjxE+Eq3wEaifUGc6a6/r38+T8o4xdxWxx+WVEt/vXXD/wQ8TVj0MVjcfmToNYYi36uVqYhxYRehfiefgpMPn1dlvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Enable MTD command support and SPL SDRAM driver for the N5X platform.
- Enable CONFIG_CMD_MTD to allow MTD operations from the U-Boot shell
- Enable CONFIG_SPL_ALTERA_SDRAM to initialize SDRAM in SPL

These options align N5X configuration with other SoCFPGA platforms
that use the same SDRAM controller and MTD framework.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index aeeaa1636ae..b6df9946ef3 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -55,6 +55,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
@@ -68,6 +69,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.43.7

