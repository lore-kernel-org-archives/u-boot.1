Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B73CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B1B83849;
	Tue, 28 Oct 2025 17:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="eWEjAKxq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A921A8382E; Tue, 28 Oct 2025 17:28:40 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E64A800B6
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiOug0lY2/zfKe2noMsbHVJv/LdQBlDpXDQxp7zRL3OwJzU5x5Ry5RH2h8WJFAHjyTRpgLNCIPUYB7US3EyvXMSrEc1Oja07ne7u+CCn1siQ+e4RMbUn7+mYgZ4CHs+PAT8A588ffYYI2vY3+1TMmAIGWys5cuI9hQQldVLhs5vvPA0WKnPbGYzzZf/sQkSu25iaGANQ8t2FISGu/pnWb0ygf1sfJZa64LmjHG6AnJd2/ud2dDftXcaCoJvCdwacFKa75N0hDcNljjt8i833F4BMOEDpqX6YD+K93YahtpARy1Zc4PCYufsEbgpYE2czuOz1PBdGDXNpO6JVJUL9Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orOzZolwsPSdyAAamqgjtv7CXxnCf0n3eCAcQ1KmiEE=;
 b=zN9qO3RrVQrNyilaWDYMJqZ0LmTrcu/qbOobRc6L+P/F8tG0YK6vsYXsgfsjETCeB6HAQkTR2bOOWKqnel7FURLB9usqP+WVNILmtHLh3vfegC0vdquSOZNQotsgPL9+2xTHAYqxX3ke/oXZLij9T+wnWucpyzIjTTAOu+o4wC6RaLOMgEO0bzRiny99m4OTdY60sSFyyr5WFuVYD7gcWbMK0fNIbHb2Y0SZoc3Wx2o5suI6BpGn5vUc820dzghTwfYDw4cxa5V2BgV730kO8bRRoA0A2OgqXNr7R18KAFfnTfQn81o4muhOxzWnQfk/6wpMnd0QZOJbA5OtmwJSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orOzZolwsPSdyAAamqgjtv7CXxnCf0n3eCAcQ1KmiEE=;
 b=eWEjAKxqrTyl+Up4uRZUZbbF4cemIx7VRar43Wqgwwk0dMe4xaDr+u950T0GKClVzs85B4FFqJ8vXzg2nWt9KWrAH3uD5P18o1vOquqrO/Pk5OcloJspX0Kl36L2gF4EtCCN5C/mdl+CsxfsTukWV0tMstUdpQ4aujzSHBV+3RSe3kminDBm0j/m8YAJINngaWOtvcikEys5Y6e8nqWjV8rQKtEHWiE4+3aGdZa9vS+9XihTn9zdjpxnK73T86QwGmW+SW5FhWNn2cFn44OMJ+yN2ENdOMsPBMdIvodJyjvC8LdCVsF3524E2SsHX9px7lwaOXTi4qQwAQIfW4vWkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by MRWPR08MB11233.eurprd08.prod.outlook.com (2603:10a6:501:77::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 28 Oct
 2025 16:28:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:28:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 01/11] spi: airoha: remove unnecessary operation
 adjust_op_size
Date: Tue, 28 Oct 2025 19:28:15 +0300
Message-ID: <20251028162825.3353166-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251028162825.3353166-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|MRWPR08MB11233:EE_
X-MS-Office365-Filtering-Correlation-Id: cb172080-a1b2-4a88-38a9-08de163f0b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nIBL+JiwL0zPpmmxhvf7nQjbPuBuAPDIdSc4nOSxMG98Eam03Zkidrxa+Uks?=
 =?us-ascii?Q?h/R0/LH1aNVOuv4qcLm3T0MjP2q8Ug/jiF0+xzEx9kTbsx2WvruCheWxtmEX?=
 =?us-ascii?Q?3YKjGuuzEsOBuCc4wvmyQSt3V0EJu1L6GBxijZwS7i/VxiQwS6e1VKmYBvcB?=
 =?us-ascii?Q?wTDH6n2fKwmiABiof0AcejT17GfaICkoG4RMBHUgfLLWp8awQLnyA81Sinqq?=
 =?us-ascii?Q?OrewNYJCEPzgtvSJAAQ8e735H4KIPvpLMqYraYG5a+mW0jZVFO51xFrLkKoo?=
 =?us-ascii?Q?Ewhig80AxOdvi+LQk16D5whnkIasiudli5xzJku4lnBTQZ7ivSe/NBDm1aar?=
 =?us-ascii?Q?3tIQ1sE7Yx920OaIHtb/FcMGeGvI0k0jJZcW/dZs6/wnauhbtdBSZVE4kulN?=
 =?us-ascii?Q?nArI77lvNRX5qIkiD2nrZjqK01kUeGoK7hn/rQtFgLLHB6SgOvgEVbcVymfW?=
 =?us-ascii?Q?6E8fgxYOa7vbYzD1AZvi0s9yhm1jq5KKJcZQZ88YpcPKQt/IeoiFDzMxKGGe?=
 =?us-ascii?Q?0nNO4vFBZq0xbHvQOJplspt6kLxY86g6NImZcwMdsv4SK8HSGsmnrBKRw1/b?=
 =?us-ascii?Q?aYYTmJxyYfgi7Hv56NyuEPnIXCNx6zudoc49eBmUhZSCzejiorBWcOYb46P2?=
 =?us-ascii?Q?ZaxepLEM6JDV1KZ/7hYhjHiHl54NtuOs0EYr3COnz63IhhXt64JCblF0p+Qu?=
 =?us-ascii?Q?fkKWVaDcAwDwJAAYjKq/2YlZGnn1yfFLotlTe6cjwJ40IuuqHi2E1pX4Irz4?=
 =?us-ascii?Q?adFy+sQzEbnnHSx3tagSHjn+lmCYrMEq5nLECoiiSdOZ729YTB7j8blBcaDV?=
 =?us-ascii?Q?0CpOhFCNT2f+t42G83a7nvb/ljqLN4PzqKN4IOLnoaTHdEzbHhL8wOeOWanG?=
 =?us-ascii?Q?HOzXBEy7xVtMYJedLDOSY7uIygRn/FTkFZeY66OFYvwiwoxyvI9nmwCPbN9E?=
 =?us-ascii?Q?vXTHu5JACFwPMvoa7uq1scXo3TzLNqasyOPcmCwdYBNFbNcMIs21wX6Jd0gI?=
 =?us-ascii?Q?hhYtqCRAPuhFppWvEk7W64IPUz+YZNm1/F/BuTO6fTWdW0LTTNVHwLIS4Ab5?=
 =?us-ascii?Q?EUOG5l6kjTA/mfieYfo6SWFN0VLqWl6ASnv9OewUa95nVh6tbL1ysXpOKOYi?=
 =?us-ascii?Q?HNQLLDNWesBv+RcL3aYdLKGaxNX2cgolxQxgpjzOuWE4JvkIsNq3sHdUpXD5?=
 =?us-ascii?Q?PIh5EQsjp40WEeeOvXs6J2oA5QPTfUCQ/RMohtdJQ2cnGdjmBXJTFbW9k1fC?=
 =?us-ascii?Q?4N+dE47BggHnq15tKjABAcGGmxFo1dbaj9sLig20sb88l/DCogXS0luNsYcd?=
 =?us-ascii?Q?uxiRYSioLrxjvNQW8ut5/OzfrN2UyMhPAG3iBBIg8QSZlf+q5nonlU1MAF4H?=
 =?us-ascii?Q?VLC4J+TVfHwMPOdSes800AOFy7Dg1g0okNUuw51OZ78WF/8iUCg46562tcfg?=
 =?us-ascii?Q?FPA7EtQ9ovtLdhpRc5tU+E5nUpchWUCYboTgTdr8ilE3N0I89boyHybHqh1M?=
 =?us-ascii?Q?wv0htC342vQsKR6Ne+evRYYKStKYG+uTh2Iq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DejfI8nvVLQu9Ubujgpui4AvjZnhCXR9Fbrz3EbUz1i+FEa9O0uzpwc5YKl?=
 =?us-ascii?Q?iCZGPhN+hTZOnkKWL4mOFQh02glP7+MxcCtkFgOxca4PU3VVHyLv+M+buYlG?=
 =?us-ascii?Q?x2jl7S/vCUGoH/p3toIvrPDITr/Dd7enc9dEV2DzGcGLiooGs3ZvvCsoFtSX?=
 =?us-ascii?Q?gfND6sj/3mD/dthwUml+BDXQIn0LhxuYKZaQ7Qp3zg1sytLryvLyHxVOKmpB?=
 =?us-ascii?Q?pOE13v2oq93KhSsSW2amgTbwIRji89Nw2ZqaU6R7RzxO+pmWc+csvep0jFo7?=
 =?us-ascii?Q?+SKIluq3rnMouOJap/RwKNItD5+7hCBobgNVmeirbWrXslHHYBZaO3YNIYpc?=
 =?us-ascii?Q?2k4UpITnBOF+xpDcUBrAb/mIgDLxL/wS265Tj/WE5+EQzaNWjE04GtmtMppP?=
 =?us-ascii?Q?OPSSfiCj1autAQHhhpLEgR8jUGZq8WUNfVZtJI/JGemc53W3Oc7CQmH7JUJf?=
 =?us-ascii?Q?BPkOBZN083UAcTmTnf8YASODXfcpi/ANG3DrTzhee5KUy6JiEeWS0mVmljWb?=
 =?us-ascii?Q?2nagKvHTOT6sPrFBhW0xIOadCPf3+9ouFoJeye86NeT66UTEn3Atn/7j/Q8B?=
 =?us-ascii?Q?ixKjrOpiM3XbCaQWIlgKBjoIH62Zh7ABs/svLuMB8kJQ0Jg7uNjvFyJKQM4D?=
 =?us-ascii?Q?ZZF5S+XVQOV7zgLsOdn/hbjvGL7ul+f0tjsKb4NloxpH9LIPlog7c34JowdK?=
 =?us-ascii?Q?MgmcUhkqF1HbUX4Fb0pKEJhEeNi/FFtEDphTovAa/dYyiG3e/qCUUQq99tDu?=
 =?us-ascii?Q?SC4fKEy+KMCuMm3Bc9KviDBC9YLU6Zq5PtdokGFbOFQSBs5H2NaW7aYKGZzd?=
 =?us-ascii?Q?wf5Kak2HbKP8Xst+iNU6js3MZ6KD8dktiA+SdYeGflZvvOZTXqNSuDgwcmi7?=
 =?us-ascii?Q?HwzyDAIlrN0IZQ4tOZoMadfL7SAfEED4n/vYg6Do5xwH/RU18Q7iCrX9Uzy/?=
 =?us-ascii?Q?R9gKsvyKIDgyycTwSXCp5f2f8BBQ+qFGnZ/s/oPYHgTogAPfeV8LJe/tTbim?=
 =?us-ascii?Q?253ME3oHg25JDecVsnV2x/RTkGqzP9fti5iO316REK8K44ibNBHync1ILsla?=
 =?us-ascii?Q?CLTjkQU8b7ro1vPZEf/gNJWj169TDW67MNVjONu1V2wiXQV2Gc+eUVpuKQl3?=
 =?us-ascii?Q?lw582W1Y/sfQvD2RuxUkb8iSFtVa2vDYSuP0QR//Wh9mui8qpGbVlczXuzOc?=
 =?us-ascii?Q?lO943zwlZSQn2GYQcy3sE+IyNbzLTScRuZ+ujuKoWMbW4PR+lbCgfGotAlnW?=
 =?us-ascii?Q?cRb6OG5Zltcv9z1sZGo0k3y6iQa0Iue6khkKGa1U5W/y92fjm766jKrZuvfH?=
 =?us-ascii?Q?a1yx+1+ehyyryHsZxTnuKZgWie76uBy6f6asmupz601JNTWkdERuQkfd9hnG?=
 =?us-ascii?Q?QRgbkZvDZLUXlpGr04d6Rdkmcm05I5Avtqs6aolevkSCI/AuK//AfBv6arDh?=
 =?us-ascii?Q?XcvcebHLggHIETonec3aIeb7zRAtoVXEEsoE+K1yle42GQCPaeJ5rnGdMgok?=
 =?us-ascii?Q?LWyRoCD8F2ce2HqGbwWmsEKg3lq3fVi84gYUYB7o6rSTuqZhYRL7WMQHpA1H?=
 =?us-ascii?Q?TOWduPJWz258mvBQe870aSRLdnMkMFmPS3wALZuWjTlOdtTyOHF8UpNj1dtQ?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cb172080-a1b2-4a88-38a9-08de163f0b10
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:28:35.9861 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayUAnjFm3DIVCSvVre3O/dCQXXVwIbFxjyuCdXupNopI34P9pvBwkWbNJWkqCde5Bu3YCMnRnj4/E7/vCUYxsy1yOmrDtSfu3bjuVxDmT0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11233
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
2.51.0

