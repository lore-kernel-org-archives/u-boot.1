Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD63CCA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5626A838EE;
	Thu, 14 Aug 2025 01:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="L7UcSo1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283DF83855; Thu, 14 Aug 2025 01:43:46 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B30D837E2
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqg5pXTK7k6bGId1sTh6ifCwNWWtFEPWhc81h+Ed+SLjrZu34q53O0vbjHDk41ZAL3eNZTUOvnvNPGFdG+i6rtx0kicmBTxy/z+1IZ+VueM096v4iptBGlBjL5Nh0cMRCf+fHTg8wDxWmAzlzzfmjQBPVuq/Byn15Q8hbfbDst8XCfdgNG8R3nzk+cPdbSuv+NvFBJ4UrD7QdlB53n1J1nQHxJYqHoJOUQN1yDGr9xYNPW5pIb3a28l4rYs1x7U2b7oKzFQBNeJ9uVawR5eHMAx9USNLdBpZNiM1G+QWgJZBzj+anDysrVq6n7nH+QbR73u64iRFC6bXFPIR+Xyh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3D7yZFKHRSyFPKn4/hO/ruFJas5fpFZ6nhdbtIhKxI=;
 b=u6UHFzr7NE1/LBdjcJfzMiwQHdgrZAqHj6VLCkx0+fuzE8C0wy4gC+ii8Px5IY3102CwASzap3yyIyOR0ArXZP4pkdL8AskCsrN496B08S7XfejH6mTq90X+HJ9DFxGjHKgkf9GmYqrhCHLVAeeuLBDUpU3tlS5HKRGFLaNxGMYL3AKl6E+H01KmqjLP/WT6xNuSV7PI8GQ0KMNME9YzEuQW3Z8/BNVA8+GXIoxAIg7Cqmqfnv4wENUZpFdNyArpy0ECZVj0PSA/a/D/Q05wjVQ4ez9rSV+kqDQ9VU1Z6H30qOGLx+VH6YjCh3NKGVasljIej3Nr0ZWTKxFUjlW25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3D7yZFKHRSyFPKn4/hO/ruFJas5fpFZ6nhdbtIhKxI=;
 b=L7UcSo1NDppZYTPzcQxuNCWci4jP4FbP2MX8frn114WlA3OWyeioGEFrakgEYH7Q5/zKYbHZdQwrV6Uz1sGByU6V5mwnxHFhQwVXwVowVYlTMnTL1HPG8XsL3UUErPD6RfMNmj0OGCrfrGmu7j581dFI+wcp0LsAvo2ZfDHOk7iOfldw+RpbfUYB/a4Eu1cDcb2Z/UgFEB5S01pLzByCHWMi0EqEA314aTvGdASs9RRf+oJi3H4RcDPizAvibTZN8mUaov0mXli0z1HlJ71IFqEHJ+cgjI1P3vlwkhOpaNhSFyiBJELH1FlrpqBmeI2FBxp8/daD19IySbFlK6hFhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 14/21] mtd: spinand: Introduce a way to avoid raw access
Date: Thu, 14 Aug 2025 02:43:07 +0300
Message-ID: <20250813234314.3945708-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0174.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::7) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|FRZPR08MB11021:EE_
X-MS-Office365-Filtering-Correlation-Id: 2966e73d-ce9e-4c11-10f3-08dddac33c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OCrEQ2yBCHd0wzd/MkkV+SvpWcxTdC9lH8xf3DqKwmIMf3HU0tG1qG6jTtdK?=
 =?us-ascii?Q?gPPHLDVs28hMaIpy9qkwuzeL4bhrbwy1U2olHatkdJJ5QkaLBO5DrZs5IlVt?=
 =?us-ascii?Q?E/E7JBRFX/MIDk9YXH3sciY1jTVM+uGbP0cM59qCsiNkp1OfK9VUjPWu++nq?=
 =?us-ascii?Q?w6r4dHChG1DmeS334dMlzXHuyC+WyNea4gLhOXRuX8qSbTlGyH0i9Lly9Weg?=
 =?us-ascii?Q?CroYdDsanXdsaErnUUEstG+yPnNL647IrogBOvQGQXizpD21iMfIHULanrmB?=
 =?us-ascii?Q?hERSVW0hHs+fqXtr4fXt5NliltK38GJvxQhjLHpwojw87p0IgW9jqgwot4HF?=
 =?us-ascii?Q?hBbQ0H9/M3f5Fw5BZDghIj0k6iJ6O89lObuhWWqglXzo3RDc5s+GA4SnaH0E?=
 =?us-ascii?Q?CM4k/I1Sknw9CVKwm+92XttPcN4kKrgkcnyFMB1YtVgt63oGRD0ehMpMN7AK?=
 =?us-ascii?Q?ZkcSMlpu35eD+idIKMNaGe2Md+/89W/+E4J/xtWQUPLmZgwHTtc4hB4dXqDX?=
 =?us-ascii?Q?HmZmA1AwDCnsS73AGS7x9hQMIvvbBlH+3+snq2hezgvvjoAFQQ0TPAVF7oAh?=
 =?us-ascii?Q?9AkHAoCKbUTXt+meBAN6/eKs/Iqf28HkL6OtD7XcRgnaqBSUgU8HcKQ6Qq2I?=
 =?us-ascii?Q?Bo6h9nElVPYAC8KAKUWXZnUeB59O0gnhNEwkQDcxbOoU2lD1O0l5C/e6NXV0?=
 =?us-ascii?Q?jESA5TMmP5dhBZESv65o7VtrYAz7tjyCK33CY/LIxRJC6YkMoIL63dcng/nd?=
 =?us-ascii?Q?ayZR5MWwxOzfIDqaOb6keFQcgeiHgTzBJixIfo6ApoZfNVbn7L9kOWYlN869?=
 =?us-ascii?Q?542Y0/oX2G5jueY7kRkxbxiPCtE8GTifU9b1npTOLZ+yHC7bvQD/cUuDtg8U?=
 =?us-ascii?Q?onzJTOq5jf8lhNOAlk+8AlIEwC3R+a1+ciZdq9VH+MHSaPEJD80I6NjnIU8Q?=
 =?us-ascii?Q?a5ic3KgSyWsz5+rdLY6Q6wFQJt+ornUsdsOOMp5SaDh3Dm0N9U4dvytfPitT?=
 =?us-ascii?Q?e0ppDgkPOpgPz+n2DIZ0pzF35rctNIqxU4zGyWIx4c1wFH0DooHQJj9ELPHb?=
 =?us-ascii?Q?H/YgK9SSRvonw5AarNARCYgTsbVZiVNR+rskwyYvNcSDaOJFmMDn7bH/eAbm?=
 =?us-ascii?Q?+hco4HpS9bNUTa89eZssIV744J6nLpejynzY3ylMCVm0fqr2eqVtrVC7aA0d?=
 =?us-ascii?Q?5jH8qQkarinQ4xlpZpD7imp8LkxDX5hZ61ZVgjEnV8xlkw36oSMrsUAT72Dg?=
 =?us-ascii?Q?zdqy7ski7La/mtchkRLtXiPvDA4inYTnnowgXV5muYH84f2PiRVYV5IGub99?=
 =?us-ascii?Q?QYaW6SdqcM//OngjfwcSmJ0iNubLnsgX4/cCKj/4d8zMANGz0MrfLgldkwcH?=
 =?us-ascii?Q?wnfRNiXv6cpjrYujAOEhvQkoH7luDeWVLzJAs9PTkle8mT39tvCabsmwuAMH?=
 =?us-ascii?Q?g7g1//YFSNYkg/3VIjkzjjVyDCVPZ1nYT+gnkNZOScARN7GZxqx2v1CrOQn4?=
 =?us-ascii?Q?6MyrbfZqBdiWAho=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCf5kw5UP29k+JS8DWJ+eJ0LM/PUg4723Wilg0HV1X1SmvI1co9hawqZmZy1?=
 =?us-ascii?Q?dRqrCeq6t+blxVWpnNssZkSQEvMVPOUIXld6bV1TdhpoxdhZBX0qfRsddQUD?=
 =?us-ascii?Q?F/UghelKNRlf6Je1VQmOedEAgdttZf4Vpp50zJ8/mZmIDZWWtjy4dXNPO8j3?=
 =?us-ascii?Q?HWTRdX1lT9zUKPZv8RNPYOpbxRCCM5KYT7VVkoTu/Q6SMXWtSP8mGg+PkHIE?=
 =?us-ascii?Q?aeTPKcw6Mdk4FlT6Hysn0ChzxWHcyL7DCWc7vchH1lBjPArNIrbtd5tAVuub?=
 =?us-ascii?Q?oyjnDdYvZmOnl05SKiIjuOh2yaRj/lNAjZMztcnaQUNYU71j7A4ncz9LAQVX?=
 =?us-ascii?Q?8xQxpwigBXj2h5374IgM1Ilqx8j+cbLaXu65/ZDAPv8Iw29DV9WDLgf9DrXa?=
 =?us-ascii?Q?YEZ9QMxY+H99pBHQg84oqjeefkuLaYB/fsPFSnWe/QtRWDeAfBPUjdiRyIxf?=
 =?us-ascii?Q?lOm0JnactosdUfKhaGMtuw9A2GjjNjG4pOXmRMoEPt1/k24i7EuOCaQtKWn4?=
 =?us-ascii?Q?LfFWXxHkFLUGTHN8IykuVkCfvB2XGpVdPbK4+NfA4h3L8Kn17SsygQ52kdTB?=
 =?us-ascii?Q?cMecbWhtpHNf3cvlk8xE+k3AuoZ6C3IHI3t8UgpsqxqZ7sObLNMVp+QAZE4+?=
 =?us-ascii?Q?o2PPGrooNumqbDi5xI+z+Hqpm4/nXZvqWOiq+xlh65b95DTrbyKXN3cFweaQ?=
 =?us-ascii?Q?GqI7cD/Ev97iIBktkt+sDyYqpMEPojkCetSPfenveu20rsg17RzzkZVIHUq2?=
 =?us-ascii?Q?uwDakD+Wpv95d7iA+TPdX3bDE5BCHt7GyGduT51lo+3qEsMNgmGLsjww09QH?=
 =?us-ascii?Q?XUXXqneWd6JxDM//t4FOMLkLAff/fYEPA2cDhm47LTEXeI3KK1wnYfPB7wyI?=
 =?us-ascii?Q?sruWzQ8ohEEh/sxhLl9bIklhljy53f0ls3Pg4ZPmt4sPsZRS7rflJDN7NHaj?=
 =?us-ascii?Q?4TFq94edimj6Auh6vz8Xz4z6pKtvKhR0r/k/d2busgui2fIVwdJ8I3/EjK5T?=
 =?us-ascii?Q?7JJ73ulSpLPNIsPSUbtJW7pj/uel68/FawE3Gb9fuu69Hn914EGbGy5aNrOQ?=
 =?us-ascii?Q?3h8+t0sY5kxtINfr6EYQqku4nWJ84zXGqrDhSyCXa1awzPxbWm6We8gKPYl/?=
 =?us-ascii?Q?QsGTvT0MP1PjWcqtMiBvYdHrMxFPzRMSm/zLMSRLr1UiCOMlbLNZvVwFzP8K?=
 =?us-ascii?Q?o4dxf9u/jpjpP5AOFZChOLRA1nUoMgB7iEYM1da5sOIYvJVf5rsu7ys+Ycv6?=
 =?us-ascii?Q?R61tG3+7xfPV76o6OuM5lIE4uDpF24MaUJMPk96MrEz0s3PYft6Q80+WrVu4?=
 =?us-ascii?Q?upume2IzZQNMNu6JEk186q39c3L6MIcGac05qEYuW54K2zVzRIRuAsv/GAaM?=
 =?us-ascii?Q?4oFTDyOlfFlQAnBQo9Qy+gYUF1WeBNA5XkIquHejCp9VTQFRwLRvUQvNTOVA?=
 =?us-ascii?Q?NVHvqtjq7crT5nU9y78XE77O8wSURwQRsfnqM9pj2fGAg1MQDsLtloww8EL3?=
 =?us-ascii?Q?rPlRKxdXKcOkverIYP+3sE4yjuU1MCX8lC8pKVR8Tlx+YJlou40iAuYM9XM4?=
 =?us-ascii?Q?v/I1hKO0ca20njkQIs6i4BTuTRG3kZY5XAR0xLlYJDYhgGJ+jYlVe8doDK0o?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2966e73d-ce9e-4c11-10f3-08dddac33c3c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:42.2510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9judF0pqOQemf5rqfYMoZLUd2MbG8Xj52FO8wPr+iR6OELxZMo0rKqLuD/AuFOuEn+8UFj56TXlDhLW3bgGf1/SGmXrUizIg28rqcBzJLa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11021
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

SkyHigh spinand device has ECC enable bit in configuration register but
it must be always enabled. If ECC is disabled, read and write ops
results in undetermined state. For such devices, a way to avoid raw
access is needed.

Introduce SPINAND_NO_RAW_ACCESS flag to advertise the device does not
support raw access. In such devices, the on-die ECC engine ops returns
error to I/O request in raw mode.

Checking and marking BBM need to be cared as special case, by adding
fallback mechanism that tries read/write OOB with ECC enabled.

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

This is a port of linux commit
6d9d6ab3a82a (mtd: spinand: Introduce a way to avoid raw access)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 22 ++++++++++++++++++++--
 include/linux/mtd/spinand.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d0c9083a5b3..c04e82651fa 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -298,6 +298,9 @@ static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
 	struct spinand_device *spinand = nand_to_spinand(nand);
 	bool enable = (req->mode != MTD_OPS_RAW);
 
+	if (!enable && spinand->flags & SPINAND_NO_RAW_ACCESS)
+		return -EOPNOTSUPP;
+
 	memset(spinand->oobbuf, 0xff, nanddev_per_page_oobsize(nand));
 
 	/* Only enable or disable the engine */
@@ -749,9 +752,17 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 		.oobbuf.in = marker,
 		.mode = MTD_OPS_RAW,
 	};
+	int ret;
 
 	spinand_select_target(spinand, pos->target);
-	spinand_read_page(spinand, &req);
+
+	ret = spinand_read_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		spinand_read_page(spinand, &req);
+	}
+
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
@@ -795,7 +806,14 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
-	return spinand_write_page(spinand, &req);
+	ret = spinand_write_page(spinand, &req);
+	if (ret == -EOPNOTSUPP) {
+		/* Retry with ECC in case raw access is not supported */
+		req.mode = MTD_OPS_PLACE_OOB;
+		ret = spinand_write_page(spinand, &req);
+	}
+
+	return ret;
 }
 
 static int spinand_mtd_block_markbad(struct mtd_info *mtd, loff_t offs)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index fb3a2e5d909..63626c9c27c 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -320,6 +320,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
 #define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
+#define SPINAND_NO_RAW_ACCESS			BIT(4)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.50.1

