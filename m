Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9B0C5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 11:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E37982AA7;
	Sun,  8 Jun 2025 13:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lEliMcCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8106B80FA8; Sun,  8 Jun 2025 13:32:56 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FB148144A
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 13:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6/J2VMOHb+nuTYin0UXorfsu3pIMk8hSafX2j3sn3Ek7X3jsqYlbCoVyuib3vn0OJP7+u/74GJVoDjaasUsQlUAhL0ANETS0Am0UE16rLjDzj6GP6tmDJcSu4xn8MkN6FrUiwVkx3CZrFbOCX1PNXVL8LYGBToZQN1Aw72ecdaUPUDNmgDQE5jpPfM9s0N43glpkCSupF+WmtD0LdTRq89kWYAmbSQ7OEAwO9CmOjoycuG53BsQoePL/XdV7mLVms2EeydZVd8onZA/3eVqHxcTuBimvJdYYba4yHT5FnuxBidArXLKHrC329UdK4Jf5ogYLAo/BR1pHLosfOB/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18Y1ivzPx/n8uWvPI1YR8XubO09/sN9YRVwKK1xrEgE=;
 b=XlG7VIPX6O5QF5Q7lg1yBWn7E9JN70M+vQaRlNl/4UTVhA540F/VurCAS2kOvdECpRWcxmCrhDql3+ymAayE+TKnMh+AbtNkSrQKW2OWa/iTk+1djszhAgsKff1DorsCXCGIPF6KN/VGUWS2xC6PxraGC4iR/8H7U7mvwY0UnQJeMXKxzxZfcIBZKE9rVQf6B+DvHtxq36AeK9B9hvG90qBJW8hWCeM3TDscYcoPhNr4Duu5wjtjSVmzJosuOzrZALkHz5FwGY2wFCZWyBlP0BMAV7upfPSeIyNK/5XQ+FRhsySM9VBT7ducFkdCFKk24enWa2bdCTJk88IM9yAFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18Y1ivzPx/n8uWvPI1YR8XubO09/sN9YRVwKK1xrEgE=;
 b=lEliMcCV19PrtjA2RXpJW+FIEbNeicqwa04nCk8L0rq2pAhqLPIBq+6lYMDKcYgyXi0oROKuGkyCcP1ikXCBRSGCpGHVrA8jItgiYHSTMwzT9qFNxk7ckzLGVrajCZEnDTGV9QrweU4PyB3jggzhTJVrl8xkjjGgtAJFs2NctW47Zr0hUN3LeIbpAyLgkGQi+V67k2iszrp4zIU32xRNXBBqyRNtw7bcZIma87CwOS2aSXnvq4M+Pgx+MxyZs+iC7d84/4AaE/eL7ggH6RNqapH+xeXXfgreeYj8nbAh1bNXx1+5Ex1YhWOnX4/jaVhcTMHE97OMuMMJyllX57WUIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6405.eurprd08.prod.outlook.com (2603:10a6:20b:332::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Sun, 8 Jun
 2025 11:32:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Sun, 8 Jun 2025
 11:32:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/2] drivers/spi/airoha_snfi_spi: remove unnecessary operation
 adjust_op_size
Date: Sun,  8 Jun 2025 14:32:41 +0300
Message-ID: <20250608113243.810552-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250608113243.810552-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E4A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::1d) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1377db-d68d-43de-c0ff-08dda680342d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T409XSqe4tGGKA4nFPhLy5hspoS80oprHhMdKvglJq2mo6R/1FvAZdUdpl6B?=
 =?us-ascii?Q?OkMmchkcrye8RU7d5lgUqvV5rsqqLXmux3GAdhKHutncGkHYvp+dV8AB0Qfr?=
 =?us-ascii?Q?yB1pks3BraZL8wLjA+trikPnWlM2V4v7opYlb6FitVBFKt/BZeyL07i4CThB?=
 =?us-ascii?Q?ig7waOl+7wG4rDpAxziYezvJaRXdQKzLeEnm51c/Fa7cOPA2keXJLb11dHCL?=
 =?us-ascii?Q?jPM/hHM7MFEYYf22HxJ5BZAwk0K4jnnFyx801AxReeSYE2+uEjBdmBupL6DU?=
 =?us-ascii?Q?5CvHK+19B5Sv0vfZOZwZ7/4lptXjMf86IiVklMJKunrZFPO2cuPGVnIoU+wU?=
 =?us-ascii?Q?cn6QgsqLnuBD6ZY+ulX6d1AGtSZyo65VlMq9JibldaGZLsYboZsvsTpWPhuh?=
 =?us-ascii?Q?8VM7Qcg7QDsMJBuLk4Fm+l0WtpLr0oNehuYvJhRWysnX3naeWlrKyJEFDOug?=
 =?us-ascii?Q?AUBWq+I4T0gBu7Fqskj/4hqmEb3revGGnYxEuMKyCuVAiCOGcdurErbOobn/?=
 =?us-ascii?Q?xqImBvsrmSA5ISI3sUztQaMs9UAL+CpkuZiAUODDVVSgWPFgHNIAhYkHQCN8?=
 =?us-ascii?Q?/HqXHx+h+P5aMpyun4/+LxzzF40zIzTD2H6E31zoeVUKuJdaRjzd7P8HhYRt?=
 =?us-ascii?Q?vkc51CjF4/arjhiJMVyC+0HCcfw9yBB9AVo44CTERxjRP18zGY71OzdFnl6S?=
 =?us-ascii?Q?OCHrHXbfPe8x4oBvXVW1ezGvGJOMoyq+SYRL2f3GnPxyV42yoUKSDCwuZUqa?=
 =?us-ascii?Q?3IMk+AQIOHk7s+qY/1eQcbHNVbqo4WVpPIT1Sl9E6+8aiucF4kDgz4T4v7Of?=
 =?us-ascii?Q?2zOrUWBIi9tWNHWQzFvTUdFYVVLZI7SHLRfrfD5Z2+DxXw50ir2a83ptazJm?=
 =?us-ascii?Q?EgN+nHQQr7aWO2o7JEgzayN8fpVVIvzMHR1boNn3WpjEwwzdzJlgngdVX9q+?=
 =?us-ascii?Q?s6MKUosde+JPATv2cETkifAq94TuiLkHk04i6NzPGryvv0hCaUU69Qd32UUw?=
 =?us-ascii?Q?C8W0ehcZg1v/hfarXBDWL2tSppZP9+i8zaPkOmTQbJ024C2bfIXqXQbZnZdQ?=
 =?us-ascii?Q?UZzhFfzqNBv/uZjkHwNGx3Hz3ALep+cxPP1ptppnDxkqBmaX6NQLDw8nHb3z?=
 =?us-ascii?Q?MOK1QDS1OjPGroP+fELTpomqbPDn6Pi4xT4xVgVAHKCEjbyhA2giBQxm/JaJ?=
 =?us-ascii?Q?QGZY43JP9Lhjak/hRIKjVy1Igm6wKElqUTkO707BBlGvtArfJjndnfotFg0L?=
 =?us-ascii?Q?EwSIBoKiw8ZgIHPIeodQlxkiAfICLlEjDQ9lbV5DweGwqnmKBa5dkboEPHcr?=
 =?us-ascii?Q?D4judEFAKAaxyqyW3Xny7eDorje2nVr16pJVSQ9ITqhe97Q6bR81vCTL0nzb?=
 =?us-ascii?Q?OS8xWYrNNghOdmrcK2hYixOLO7HH7vwsE9LbyX3gsSvA/RSbmNwrVncTHo2f?=
 =?us-ascii?Q?nTFyvwWUQSQtFDmk17rQEVqYt6ujXzeK46/gbXvOmiJ+2+FEZQxh6A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gvI/YdH7m2XVghwlLYN+Lh74icqRPeLamVN5fBLAQLGrEZXBWM71jpC+0oT0?=
 =?us-ascii?Q?UeK9wAKcOUQWmJBUEewCPZ9zxxRphCWaOgN02ROl+Ig+37VsSbBm/dqupoU0?=
 =?us-ascii?Q?DqRDvyJATjBiYeEwsWz288vBaCbb4ZT7ImI29nDLFI9TF33lwmy1MInPTrqP?=
 =?us-ascii?Q?KV0vkYTjOCi6aXmzZDnn8Bzdmz9Y4ltLaF4Dky61nq4I1tfZkRH2b8lWwONd?=
 =?us-ascii?Q?Ec+LHVDyRRdOqTSoRrayG8vl7zomuqk78AD9v+EKRTU0Prd6+iYwo3YOk4Gk?=
 =?us-ascii?Q?hUvn7eKAXAzwMv9sEThz60DKmI9ioCuaWEcoEJNK9aFhdLder59QH8zF+ofi?=
 =?us-ascii?Q?6eCpRGV0RxzKAmGfqS7rLtN8TC+hzzS1fIZ7vn2gHWyFnVXbMk4Z1+o8AfN3?=
 =?us-ascii?Q?HJcJkfvKhMpRVnK4F1UqUHVaeqWRy6tQ6dfP9BiklSe/UHVhfwqr3QzM9yP/?=
 =?us-ascii?Q?5Cf/8AYiH1ALhCjlkECUUtmoN3PUeTgMJ2qQMxe36LvoJ0PQY99FB5Fxi305?=
 =?us-ascii?Q?YTKQr7N2mgT6nr/D4YM5U+N+68crD+ZtEvRBMlzT38KUSwelK5JT9E+vKttK?=
 =?us-ascii?Q?U49AMSPr7Aq8XmQHjQ0jtNgUw0l/owXE1JuUImVyJt42sB/6qKTjNyyT93Lb?=
 =?us-ascii?Q?dtNMwTdRpMsbntM8pOVNkS3N9Fyg0oh/1gLEbOvbeaw/DqRjlRylogr+4n2z?=
 =?us-ascii?Q?miR0DcAbB375RJBGHCRXOwZMB2SgAbRdyv52M/5W4s2xiBJba0Z9yXuHFXua?=
 =?us-ascii?Q?g6VHK76u2c0CFUE3oRxzQnQI/f5AKyYHKbVZbTwhSEitgLLBHtvvl4FkaEcH?=
 =?us-ascii?Q?9hd0rVHES+AJfDZtJD6TUGHqhea1b3TAVTwZJgrcY7lEWSIKANZ1LDMmt68s?=
 =?us-ascii?Q?7rwWE5/f1EcHTngjc6culJXMCmmxvXdBd+DjuGzTTE29DsNNGlZCmnek8HQ0?=
 =?us-ascii?Q?JrDY6C62murD602EZUML3ro0RMbURIFl30NmiQK11h2sl3CtHLTF3j3GzO8b?=
 =?us-ascii?Q?sSGqbWruqavLEz9B6DqYCqFNFmVZtP7ybULpPWB2FsT2Bd5qlEj8gmpsYlCa?=
 =?us-ascii?Q?Npq0hi6sxkJwDa2JcD114/g2+V0tX2jpuO7jX5lcFgeL4rTOwr0pzGsBRedG?=
 =?us-ascii?Q?hdLwe8Xla1pnaTlTC6zqbI17GqSFtntdVSK/UJNFBZ9YUsmhWUj5P4qo3Xlb?=
 =?us-ascii?Q?C+e+ADsRnXBLjkR4Ke+jbTTPZiXoHHF+6SIsc9o0iCdZsFB3J/0FRV0qjl+P?=
 =?us-ascii?Q?RtnOoOzLaiScApy0FfNHNBjQ0IzeiB+WniLPY+44p90X8S7e7ObZHW2OUADL?=
 =?us-ascii?Q?+QJelEwU4nlBhMs8S3VnZDk8CGSKY3cHAZwwQlJVpQJ6nXUIZIzF20B8qgmr?=
 =?us-ascii?Q?2CLYVI6gB73HKLAY7L9Prq4yJWJf7u73JNy5I4RBS5e1AeJLSknGZ3RchEtd?=
 =?us-ascii?Q?xl1Ir9F5sJjWw+CcPM5AGNIl8MEyOnkHTxIrLFkaDCK9Ha3R0Ct5MNCkfLkT?=
 =?us-ascii?Q?MMQ6iTz6bjmpdigeHdQ8i0GwM2GhoAobJT5h0ZvWWEzM0+VRvaLgAgAyyuAa?=
 =?us-ascii?Q?qTrbj2qQGBb1DqDekjjliPD0OyOH+NUhH1RU68D9Abr/+Byr25XAuLxUcJO7?=
 =?us-ascii?Q?+frA9K6LoYbYr7V3vhdSVqA=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1377db-d68d-43de-c0ff-08dda680342d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 11:32:51.9911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaZjKpgVNIW2cRpZYCCQmd9k3/9UAaHT0a7ft7TGvfZfCdkdU6Xxjk64jxuSVjRIM/RH0bapRq4VqZ9LKB3Jyc9+QQkwES1D09K/p6vaAzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6405
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

This operation is not needed because airoha_snand_write_data() and
airoha_snand_read_data() will properly handle data transfers above
SPI_MAX_TRANSFER_SIZE.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index 3ea25b293d1..4eb01038404 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -525,21 +525,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_priv *priv)
 				  SPI_NFI_CUS_SEC_SIZE, val);
 }
 
-static int airoha_snand_adjust_op_size(struct spi_slave *slave,
-				       struct spi_mem_op *op)
-{
-	size_t max_len;
-
-	max_len = 1 + op->addr.nbytes + op->dummy.nbytes;
-	if (max_len >= 160)
-		return -EOPNOTSUPP;
-
-	if (op->data.nbytes > 160 - max_len)
-		op->data.nbytes = 160 - max_len;
-
-	return 0;
-}
-
 static bool airoha_snand_supports_op(struct spi_slave *slave,
 				     const struct spi_mem_op *op)
 {
@@ -691,7 +676,6 @@ static int airoha_snand_nfi_setup(struct spi_slave *slave,
 }
 
 static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
-	.adjust_op_size = airoha_snand_adjust_op_size,
 	.supports_op = airoha_snand_supports_op,
 	.exec_op = airoha_snand_exec_op,
 };
-- 
2.47.2

