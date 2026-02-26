Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DFCFCE083
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 13:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36BA83EF5;
	Thu, 26 Feb 2026 14:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NC3ZXUYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8864983C54; Thu, 26 Feb 2026 09:29:58 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6731283AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 09:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mp5nntwdVkpZRwSEQ6eu3Cir3IJiYEJ2Hc9hbq2PTwN5TkqQXFMqcFJmEMa7iNB7fsrv3IOQkmok/X7BHYiyZjcQPNOiIvwt09kdlAMrl32Lp6T9YqA+F0yQg0eLVnRjQF86ib7Kcaip10Jn2LAmk90o1UHZ0xO6epffXXvx0mtu5iAr2uO+lQoki5N4WZ5H0Io+jpVil7BJ07UtW9Dm/F9X7ZSyyFK4jMRbp68P0X6RnDGD6QaEojcKuwf2ze3fvpZu361CBlDkDl8VXIyBC4byBo6Ic34TNZF+zE+12WdFkVVfp5FsO1RUQdah1kJtOE4w2eW9kBSd+wLlkW6Jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRw65+Lim+rOe76y2UK3f2uAfig7RhbhYTYyYHpTn/Y=;
 b=Ur64TvZprcJsG/P3u2iWfAEpIdF7JAnQoiPa4Pebq1WbMu7fFpLQ1K8Z1nWXvJ+v3cQvdSSZMMZ4AHB+mTg2dwcxEgqPUm5lwYMLcUC87qRk8FG7rKSqb9q/f1oOhNjvVTx6wZm7CjrXDQ/bEW1wdpPo/uMSwfVi78ynpUJZSvsXuuAN/sSEoK+cPuvp5CxjgMCppNB8TmDcSgbkPbQSVjW6gUzxTbn/dhYWr37kRfk9ntkGYHD6BeTXBNx5iI/eRJzM4MDtrY+an3R/MayPkwiYLDnCJCavaD5y+UJooW4H0f1Sn4V982C9HV3zOPYOopJ0UAkO+cwLL0ZCOe3Tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRw65+Lim+rOe76y2UK3f2uAfig7RhbhYTYyYHpTn/Y=;
 b=NC3ZXUYaSZEFaE5j9CgODwzmKhgf5h4q8Q5j73nMJQTY0l4T36dU0voVb4rnN9Hzc2X5opUhnxcvegQ1glUjHXIgVdwFG4wt+scL8RUWMTdPpNzne+DSn2ihzZbhAD+8G2kHiWSa6Yf2enOsnK9dHyP52V80OkzfkoMUsIjm1EBablewiBPtxYnTNjzir/k24Kim2iX/E2CIDAWMmucNluL4tmXWlo3EpSZ9xAWLdTOhNLflvuj5bRqK9UFFVI4EH+UbytpyuU2s/BQQSMwtsQmAXf6NIi4fkssKHqQWJgs34cdFlDg33Yo/fXyFnw/5vsZXsNJnK98XsvUZ2CCxqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SA2PR03MB5803.namprd03.prod.outlook.com (2603:10b6:806:116::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 08:29:53 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Thu, 26 Feb 2026
 08:29:53 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Shiji Yang <yangshiji66@outlook.com>, Tom Rini <trini@konsulko.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vignesh R <vigneshr@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] mtd: spi: Add ISSI QSPI to lightweight SPI flash stack for
 spl
Date: Thu, 26 Feb 2026 16:29:06 +0800
Message-ID: <20260226082906.21217-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:217::7) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SA2PR03MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: af769e85-933f-49ad-5318-08de751136ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 0O8QScFfUGsjqgR9BS73AgXGEr1zkHkG60F2wVFCOJsI/cqnIpi4RnK4Tn8a9b7lLBfe/LzsQVZWSsKO/7itkVCAD4Bj8r118Giv9C2kzHAzt+253xtNwp7qyVkoo3NETYP3QETdUoCbo35o6HvQMWV7C5FQkltz6zjzdJ/DrN+rP4UxWgKv6wUFCUztQJXlg6SXyU2oUrqE3M68csPDiQIwzsIdP4FaCPJWr29ldZEjQfBkSbv+KJK9hIXfye0RVph5V+Si5v9ZlP1+yEyugYC98osVHoy9sFgsdx2h0sXJH1F4lecXmFK0NmNZYadoMgdSI2JgFWQgxGOyyzakhqXzN/gTwSWErqglHDKPyn98EDPfmmzE45EckYPO/Lh4eiwjzTxOrBCszMWem/hlbdM8pTDsP5YJKnVckKuxseZTERxYwZZPwAJCcxd/SiW/I8h0SrwII2sdZktUN7TeGwobbz2fENOKjZuV276BYyiuvqZqWY7bwc6GV4vkc8hyV8wPreVtly9GDGBAO65ML5pElBXea1h840lZ4lH99dnj6F5lgmZA7ulBbchVR+fiMME94fcO21mCa2+E3mx2C3dTWjOwOAeE6cXReXT449AewqjfrTLCcrZX1/1Y4vsEnt1eEJA8CJte2NSg6JpH2B4+VEHfVGF0eYncY51OlXgypPC0l8ZsR1/LPZGPH4Ji4CiepHWGwcl5oI3NQdkOBMTG5Etf+Ug0vC1ywpO9ty8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LfiKc4SHd8UsYQd2eIuXwWo3Bhg0T59aFlJE2EbM9K3JuLc4td7wFIYMPnN1?=
 =?us-ascii?Q?P0LnwsQqi6ixh7Rk/fioE9bOG4SdA6uqCZfvrQm5jYPO5nTiIbSyYxykro0J?=
 =?us-ascii?Q?6znzTVJwxCNNqikAAWHGi/iihpgXGKH47symkk679uCzDDyVDdsvcHZixarv?=
 =?us-ascii?Q?ZdRYiviqGfQ2mOyzYW21xM3UXsJUVY84S9G/HyoaYqm1YDX7He76Z+qFIusf?=
 =?us-ascii?Q?SQ8fUZE1mdhNfIkvE9Pdm4vcOzZePF6x2+3ej33J8M4Q6WQZKDWS12B/XTXL?=
 =?us-ascii?Q?g9red7OerPe5nuMxSgCFh7jRBb9C56MYd+te6qgbyoUEusFESr5g9zIB+JDC?=
 =?us-ascii?Q?Dnv3dGv89I6C0rxI4E6bYRTDtaFIswdsPwj8QfLsOxiRvLve3GE5FRO80QKB?=
 =?us-ascii?Q?i6CVqoM3o9TQ8coGsls9zuj3t+qyu3BlZ4F0pxTa8SfYHwi4QxAV+d33R07S?=
 =?us-ascii?Q?E1AshsQkkeIycahsWfjHsa7Zcp3PCYdmzuY1PnfestcewTG+b/ltbR8Nk3B1?=
 =?us-ascii?Q?KPY7et4TpsGk2ag31W0bYEUeQTHz6NgxAq6rT3i7MFi53k9xrRNqiIABVBhW?=
 =?us-ascii?Q?fNOWbIhCjVYcra3pWdgiYiPq+LNBtkVFh44Gzw9bgN2diACgWLGzI3Lrf/zJ?=
 =?us-ascii?Q?SDVcPuHFKwqYtHcuTv1roDkuhitNu4MclyIRQjYsCeCVy32pgx+YkVOMmStR?=
 =?us-ascii?Q?Hb8GqN2Ljqkr/ms0g5wz5gA7KSl8fBlR/AG+dEehLBCQqtGhBS11kEcQneK7?=
 =?us-ascii?Q?KcKtK8dZxIunwYgipU7YUdpJVL/pIBRGR2gyv5Bhf5waLbfDRPvyO0uNtWRy?=
 =?us-ascii?Q?rM0qg6eFJtAseOEyKxNWO3AzSoC313PWrfZstAhUGqQLqnt6GGmuBSzNkql9?=
 =?us-ascii?Q?X8Gb+eHhxMv6jQpr+OWR7F3dbQI1l7kpT7Q0A6L7DXXZzrPlkGM5Wv9OMb/q?=
 =?us-ascii?Q?Xz2wUF3VLhEJck5iIgTKaYrlzW+HLZFZuLNus7UyIRfbfvd0Dfg9WHGBFoDL?=
 =?us-ascii?Q?JvJy6gFqlImPLr20YFcB7jji0ebAqbHS4GeiawgQJJNIT896Camg8NO+ZxCk?=
 =?us-ascii?Q?ktNZ+67CWSdizACPdQr7Ragw25GIJdlmOUkgbly+ziU3xyyk4xasSc/ITV2Z?=
 =?us-ascii?Q?iJ9kJ8lonzeN2As1plbXCWeDhv08w/kkhtPoR0WF/o6SxyszmF9xlB2SdM8Y?=
 =?us-ascii?Q?r0D5L8WYw+A4X4a+GTKgTwbuUMFiOKMPD6r0eP/57Zxy3U72tkwux9O9mNs3?=
 =?us-ascii?Q?JL07+1r4mCMYCS/5EzxTxYu5OWpY0vaD2A+mwlMesk8alPanxqRDt7rh+ejS?=
 =?us-ascii?Q?sudT9wyfgTXlzTtAzb2oV81tUX49PRthCwRMKbtICEvvo1xwq8u33S+kQD26?=
 =?us-ascii?Q?mFp1a0wJIV1IYXCBe5eU3IcKcfrxyCp+SQ9aCPYgdZaneTNcbOpj2/TXr39C?=
 =?us-ascii?Q?VbUJSs4j+HmQ8bCTeJ0RlY019nwyL5Cse0A368kAj4tb+zPh5NEfUwZ4DyEb?=
 =?us-ascii?Q?/XlKMzoCdHZDBosLhm2NGH2sAXPpRsX0HgTskeBuT0Ew8xczit9uzMlLoqS8?=
 =?us-ascii?Q?s25hpqY3SgI4DAh0L9H/LKj91owPFxmXafD3zUylqs60Oqv95s9+1c4SfEfK?=
 =?us-ascii?Q?BY687/VoGbn/kED/l4JvdVOoGxudwlkZZr+ftcQo4I+Sxijhf/Mj4V1BtKMY?=
 =?us-ascii?Q?p6U7wb1dvoeWb46KYWaiEkKVu9Xloz9ZtpKoGuN2K2dEe0nVV7ky4+y2koqr?=
 =?us-ascii?Q?gqxWBp8d2w=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af769e85-933f-49ad-5318-08de751136ed
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 08:29:53.2520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /B/MfcsPv1I1v4T1ij2SmyLBDSBLgesCjIzwRmskcnXujx2CW+tgs1hwPViEfISPocB2YZSibdQxVH2XChdYLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5803
X-Mailman-Approved-At: Thu, 26 Feb 2026 14:43:22 +0100
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

Add support for reading data/images from this ISSI QSPI flash.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/mtd/spi/spi-nor-tiny.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-tiny.c b/drivers/mtd/spi/spi-nor-tiny.c
index cf00473ee83..13e51294165 100644
--- a/drivers/mtd/spi/spi-nor-tiny.c
+++ b/drivers/mtd/spi/spi-nor-tiny.c
@@ -437,7 +437,7 @@ static int spi_nor_write_tiny(struct mtd_info *mtd, loff_t to, size_t len,
 	return -ENOTSUPP;
 }
 
-#ifdef CONFIG_SPI_FLASH_MACRONIX
+#if defined(CONFIG_SPI_FLASH_MACRONIX) || defined(CONFIG_SPI_FLASH_ISSI)
 /**
  * macronix_quad_enable() - set QE bit in Status Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -666,8 +666,9 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 	/* Enable Quad I/O if needed. */
 	if (spi_nor_get_protocol_width(nor->read_proto) == 4) {
 		switch (JEDEC_MFR(info)) {
-#ifdef CONFIG_SPI_FLASH_MACRONIX
+#if defined(CONFIG_SPI_FLASH_MACRONIX) || defined(CONFIG_SPI_FLASH_ISSI)
 		case SNOR_MFR_MACRONIX:
+		case SNOR_MFR_ISSI:
 			err = macronix_quad_enable(nor);
 			break;
 #endif
-- 
2.43.7

