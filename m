Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25E8105A595
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0F68419A;
	Thu, 12 Mar 2026 13:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="lnpkKj0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDBE83F9A; Thu, 12 Mar 2026 05:46:52 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 077E683F75
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 05:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhsCU6DdAZtd32+Eyg3nwyXZarIpOvN+DfFZweyuz320u8hOnsMUKfs8W3oAQiADG9WaYYerHkcvRKgS51caeXbLvvMwwj48eFLJ3J4fD2eU+ndX+zciyWPvP5O0CEUvtL4Zf8xtvX7EXqrijMKCudC/pQaDjwtuGmLn3Q+ZhzZkg7HM7US+KpLsnUt9hm259rDJ9xY20HApyZvmzfU56wUCA53uDCJe6hXVIlQG7xBG5qKITIu0L1Vzj4l9tlB0Imh1ISg8yI0EuIapFV/49yq4mtU/wtvuQuqixzO7gDTyhwU1kd4KYPa0dLxOra9hjEIL2ryJY67mSYWJVnXkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgqk9JSnUOzMwqk+x+puMWJXDLSO2IbKCMS+MZHoXkw=;
 b=ODZO6tCgfGYXUEeC9wNueFYWmmu8FAAnEMe0FX3OAuHWiothAbXaNziZ9gB3T/M+9z10uGFElbVDXbdR76Q6iJG9g1RJnx4jTPJe4QazfIc6hgSuD9yB7pjEQO9hgPCqt+F6iZq6k8IXbLOsVYa2w0AQYE3gTvCXswlj8NhmWI0qakKFPLhSYhcTX8FwuASX9VcC09AqPZ3cWfYhcNyWXbVErznsgAxMvNwm1mDgrS6Gy0fJkVV27l24vaFYSVKeHLNpDDZmiHlBWOF3oHfvI0qyYHl2/LIrIaBR9r+oNZr8WMF3XwnwgM3tDAoSYs5Soi72Av9RRx/E9J37wFXCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgqk9JSnUOzMwqk+x+puMWJXDLSO2IbKCMS+MZHoXkw=;
 b=lnpkKj0PtHkPGHVqVaq2vGN1pgNtM4SFGh/dvHaTegWQWLKLjHvWYiSha8eJGnXtB4SorfKvV9sElZxmj4+FYp43TyozSZ0w6OW7M0nah8hysOEwnE5s8gBpdseLrF57muP4TDtnPfTD801XuC608LgAhY72lADs8qxuXB8mZpbz1Y9oxmEuuDQF0kfnbUrgZgJNhLxDIEk7JLhqz4xA3qD0HgxkpxgSr7DA1JVU9q+3yuLdA5FvUEJWcseAEH5Mb+FY+GPCDdNaY9neK/OjYWCFtEfGjNwr4gRYov6zlnF8Nap7v671FoDEK6ZYkq74OYhnpgR7aEgHL1VKBBRFMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by PH0PR03MB5685.namprd03.prod.outlook.com (2603:10b6:510:42::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 04:46:44 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9678.023; Thu, 12 Mar 2026
 04:46:46 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] spi: dw: Allow bits_per_word to be configured by device
 drivers
Date: Thu, 12 Mar 2026 12:46:33 +0800
Message-ID: <20260312044633.29242-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::48) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|PH0PR03MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: f95a1703-423b-4cc5-f158-08de7ff25d36
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|55112099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: U/2ZvbljEUSxtdnsmycsLUuJcBQqRMJduaGB0vlacaMb41N/8EfvDCYEDbyX7jZ1M+4JlACrd/WMjijwUBFymDQiTYUq3Tf0kR79nZaV9Ebi0PWEHsrpxbFJZsvvTiVr18hacrqvMc4osJZ2IGvL0y/XIuwBijzSXvZMl7C5LQL1XuiiYJRRf7a1qfuP3+H81X+3CsZLJRtilPNODEiDBsVBaICn5wJ5UxDuWg1CgPqDWwhY2WWzYo8eZ7B1Zv16N/gvXVvsa6n7eEsTPTiLo4WdIIxX4IJS3sR13EK8WkCn1+7ibgDb7hM0aKlMRiIDuDhjCUZxLewg+LKxkAnOuTdE4m/M/gypI/KWVpBELlXbt3F+hfjNNwk7D7CzhhOJkRiaYgahkiTZSHZ6qkCJfLGAdT5AhSCP4K2OXGBdF5cUXoLGaA0wGqUP6oW5MlhgfESM3909usFLc81R0KeoEl4u4j96GIXojOBAN/zP++sqQaeBeNyQ7q4h+7y+9WzFoe4LBF7FXS68yZmLIA3zu9pqCzyRFr10/p9NwmoXplK8mw4h/PAwiE5GJud7la0d9Qk33oEQLItvlhoViAA4kT55BNxPo0n5nhSyRSFnJEEh8RY5OuFEemGNE41D7H7CfxC7eYV5V15M1CgtEF8s9HzT8s94RF2FUasrxKCrTZUfY+9/8gZPEJd/L1oCffkX4b5gOrl57OzI4FKRAq4O1y4Up6ayA4n/mGD8E5wcwis=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u6CqlKfqcoMhMh399dAKZDR4hevI057EGZyhszSv7F1Ob5auVTZnmVSriS83?=
 =?us-ascii?Q?OpSSOX8rtq8ZFanzALzFtJF/M8IZvgzL2bdd3GaTeg0+mPcSD/MgDfH4uLh6?=
 =?us-ascii?Q?HmNm7GuNtGUskFryMMthmCs5VprTr4sgfaqPOiTGUK3ltulxzQIeVtCWrTIS?=
 =?us-ascii?Q?GLMnEqwOMRn7K3f61PkXmsSnhWwbmst4X/NHEqqnlj18YF9/4VjQlOY9U4Jh?=
 =?us-ascii?Q?n/73fqg+DbAD592VEb8k0Sa9H4+XWwJgkyDhE9IKFvwSzlmTmNpzGh/o0haV?=
 =?us-ascii?Q?K7BsV5ERRaDY1sLN7Hd/+8wfO+LaBB4tvUi+jytvlNctWWFo5rsg8MN0eeCT?=
 =?us-ascii?Q?qYw1W9OrUDN1no+iTWWVrDs1U3P8PNvhdtSPzAPPJhaoHG+O9AL9Q2kHHx83?=
 =?us-ascii?Q?rl7kcKBKLKdHuUn/0u051u516nnPlTjPbGV5C33rkSS/UbI267H2LPge6WRh?=
 =?us-ascii?Q?rA1EiFS5LQNd57Id1KuGUfUhQ+4fOWUr0GwNocWeDnc8wwSyGw7J9oTD7TmB?=
 =?us-ascii?Q?MYbqq+QFimRq2lLaK4fMSAwvbXnjZQqWFDNVZ6OKJodYVTU5+dAMHyJZv/hE?=
 =?us-ascii?Q?LttwWBMjUN0F4HlO0arlzwZS71mubXecY0OvDCIyStRJzz1T/DH7DlqFY6V6?=
 =?us-ascii?Q?1ar3ueDXHMBC0yXkiqVtxVoXZ4YBuDYmwsokr6DHhBmtbHoCOER5xwV4GMqn?=
 =?us-ascii?Q?yu92xP5e3Mn/U79TmljJDcrPyoMgyrpbkwnZfJmPkeflS51MiB41JAwXYW9H?=
 =?us-ascii?Q?akjLTzY/BGAuAgz0sx6eHFM1kTUw3OzMl0hzl2iGJL3ImK7cRer6s8URV5xW?=
 =?us-ascii?Q?wf7hkZVh1+jmKEHytiHAOkqpOCuCuWxuJpFOI1xzGC3Cob9pnEf4KU2zMUSi?=
 =?us-ascii?Q?3kgWqIrdly7AGcnrfdOaGawrSPWZ40Z/D7nTv/sGmh7uxJ5UzlJ2ygk6ezUZ?=
 =?us-ascii?Q?GxJ8z9sBbRPx5DSp13a4bQFYZEGMPwSdeqfXROHCO4GYHoNLwjaML7E497x9?=
 =?us-ascii?Q?t4VeMM6haDSeMd78Rl8LiIXuFTj5QepWcpGjuYSC8ndQXRvPIAW9LpIiklYU?=
 =?us-ascii?Q?gcCGYC2LnZnE22zC551d9ocJ/U26EAziROEhVEcIwH8MLAl1O23KENqHIH/m?=
 =?us-ascii?Q?LbC+vymNciNFzu/K3JH9m9Z+0N2/qDECRHbJUxIbhNRxFKtUP0sV/Wd94LmR?=
 =?us-ascii?Q?HdrBZ8UZztmVXA2znTytrRrjbUU5X0SfU1XNuNCTDGG9NRJO3wb1Kn0Db7xQ?=
 =?us-ascii?Q?DPElTUNDu89RJhUHrh8lnJRPx8lSY9va4VECcqxWb6F0g9AfMP1vOpS/An64?=
 =?us-ascii?Q?Hq0NG3bEjzqoVOsZ9qK/XG17FsZYD35yLVMizGFuTDNWaWIhJD+FXhXJ75A0?=
 =?us-ascii?Q?ayXMThIwjynFgUIL52NwG69abYBktd/7l+4mt3MDXWOgOUJ6Hy1cP80FjVcN?=
 =?us-ascii?Q?wLcCceWfoYRFH8FfmI/S7ozvkdS86acbRZXQaMp+jLG8ZZgbmY971KfJvb5B?=
 =?us-ascii?Q?C8lljmBAX1k4Qh4JCKF42ht5Aj1u37bAbzrkWbAzIYuHyxQVxyloQ0DWzNbw?=
 =?us-ascii?Q?NodhjIhn7mPRwmDSPA/eGdoOkQAiewS3gqOB2kKOEAa/A/bOf61+FySWQs1A?=
 =?us-ascii?Q?7ye72ShQlQFPTCzXjy//RSDhJN62ODPshgmtfT4odxeVwgMhg8eApV3a+Od8?=
 =?us-ascii?Q?QzrIdK2fPH3dDBO9hTEE2SkSFVmhCbdtyZO90/+dyE2q7ej1n7apgANJ3O6/?=
 =?us-ascii?Q?+WRjgyDTOQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95a1703-423b-4cc5-f158-08de7ff25d36
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 04:46:46.1062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjd6aZHdzAyIXQFWdgpu7TwNPbhefSAgoebMxP1P2PMj+1cXdIj1/O0l3NQ8ER1s9W+lVCK/T0BJXedAh3KP1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5685
X-Mailman-Approved-At: Thu, 12 Mar 2026 13:47:21 +0100
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

The DesignWare SPI controller supports configurable bits_per_word
(typically 4-32 bits), but this was previously hardcoded to 8 bits
in the driver initialization.

This patch enables bits_per_word to be set dynamically by upper-level
device drivers, matching the approach used in Linux. The controller
reads the bits_per_word value from the spi_slave structure during
each transfer, allowing different SPI devices on the same bus to use
different word sizes.

Implementation details:
 - Read slave->bits_per_word in dw_spi_xfer() before each transfer
 - Validate requested value against controller capabilities (4 to max_xfer)
 - Default to 8 bits if not set (maintains backward compatibility)

This follows the Linux model where spi_device drivers set bits_per_word,
and the controller driver reads it in the transfer function. Device
drivers can now set slave->bits_per_word before calling spi_xfer().

Example usage in device driver:
 slave->bits_per_word = 16;
 spi_xfer(slave, ...);

Backward compatible: Existing drivers that don't set bits_per_word
will continue to work with the default 8-bit transfers.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/spi/designware_spi.c | 12 ++++++++++++
 include/spi.h                |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/spi/designware_spi.c b/drivers/spi/designware_spi.c
index b520c727900..0df9a4f5abd 100644
--- a/drivers/spi/designware_spi.c
+++ b/drivers/spi/designware_spi.c
@@ -497,6 +497,7 @@ static int dw_spi_xfer(struct udevice *dev, unsigned int bitlen,
 {
 	struct udevice *bus = dev->parent;
 	struct dw_spi_priv *priv = dev_get_priv(bus);
+	struct spi_slave *slave = dev_get_parent_priv(dev);
 	const u8 *tx = dout;
 	u8 *rx = din;
 	int ret = 0;
@@ -504,6 +505,17 @@ static int dw_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	u32 val;
 	u32 cs;
 
+	/* Get bits_per_word from slave (set by device driver) */
+	if (slave->bits_per_word >= 4 && slave->bits_per_word <= priv->max_xfer) {
+		priv->bits_per_word = slave->bits_per_word;
+	} else if (slave->bits_per_word == 0) {
+		priv->bits_per_word = 8;  /* Default if not set */
+	} else {
+		dev_warn(dev, "Invalid bits_per_word %u, using 8\n",
+			 slave->bits_per_word);
+		priv->bits_per_word = 8;
+	}
+
 	/* spi core configured to do 8 bit transfers */
 	if (bitlen % 8) {
 		dev_err(dev, "Non byte aligned SPI transfer.\n");
diff --git a/include/spi.h b/include/spi.h
index 95e7d5b1556..035d50f6b3a 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -159,6 +159,7 @@ struct spi_slave {
 	unsigned int max_write_size;
 	void *memory_map;
 
+	u8 bits_per_word;
 	u8 flags;
 #define SPI_XFER_BEGIN		BIT(0)	/* Assert CS before transfer */
 #define SPI_XFER_END		BIT(1)	/* Deassert CS after transfer */
-- 
2.43.7

