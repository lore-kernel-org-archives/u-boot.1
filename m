Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C0BEEB56D
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 20:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0892A86A3A;
	Fri,  8 Sep 2023 22:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F66585894; Fri,  8 Sep 2023 18:48:02 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01olkn0811.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::811])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B7A786A1F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 18:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUdz55JxajOiP9oc2p6EZPoGwq3YjIipfFuu6NElnzegoT/B82UA2fWcVvDILyuqK816/yq+YYc+R0jtI2hLx0wqpXAnvYdQ5jKaYUXRB6ZuqATKn7JAA+JjBuykYGpJsYwpQxIg5U2KBghS3bF50EQauU0nnO7q+OdKcT8QFJ3YmiCg1rUM11zodDpRnhDFgEkzT92bdPedECk/QrLFGWO2Dt3dl1tYYfqQqrgAXTg3/oj+n2qDbi8O3bV9YTPS0BS9AxxDaoQSGPl42nJnB9xUlsUaxUNWUdoeZGcw8PQPTOwre1BWGP3mv328Mi+LaKZXi6I8laNt/TZK9nsFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7jOfnLA5cyQdKYFq7mlNQiCGwPpbgageh8HpBFCqs0=;
 b=KxWe2i9qwOqU0beswFtyAr8FGl/JoExUCVKNx1zG6PwLLhrzjonUAs61MiPImZFDI8AWQRCgkvdJpBdsfow4sdGuNgeQOCYgHYcHODCOVZMlmYmn29MBrPRoyDao/oD9pMG01wM1w4Rtc6iqRtoZJ2C58u047sxD5+0QxxtV3GcnxR4w10zwkMhK0wfUFWgtnr/JPpBadE+iJZhQWwXewjWSNLbyI/R9Ceb8a5u068j0MpQeGC7FUIbXhTpNWi1AWDInvX7ily8YWVQ4jBH0k2xfs26w3J36quL4p/sC9lQWslLfsjIwybWhMdzFqqu2ISkVR6CAs0fRuPwXkn3ztw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM7P191MB0695.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:131::14)
 by DB9P191MB2049.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 16:47:59 +0000
Received: from AM7P191MB0695.EURP191.PROD.OUTLOOK.COM
 ([fe80::e833:10af:3c22:e64e]) by AM7P191MB0695.EURP191.PROD.OUTLOOK.COM
 ([fe80::e833:10af:3c22:e64e%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 16:47:58 +0000
From: Francois Berder <fberder@outlook.fr>
To: u-boot@lists.denx.de
Cc: hs@denx.de, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, Francois Berder <fberder@outlook.fr>
Subject: [PATCH] drivers: mediatek: Fix error handling in mtk_i2c_do_transfer
Date: Fri,  8 Sep 2023 18:47:46 +0200
Message-ID: <AM7P191MB06955AC8974FA0226ED937A5DAEDA@AM7P191MB0695.EURP191.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [GqXkopUDSpj91CbRSyBl5bxQM4l8jfimPYHL1bta5+U=]
X-ClientProxiedBy: DB9PR05CA0009.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::14) To AM7P191MB0695.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:131::14)
X-Microsoft-Original-Message-ID: <20230908164746.208662-1-fberder@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P191MB0695:EE_|DB9P191MB2049:EE_
X-MS-Office365-Filtering-Correlation-Id: 635e6f1f-bee0-4442-a916-08dbb08b5b65
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9aTi5aoQVFuxf95V6dbmXXU9eI0dAzucNKWt6jwQlPQxPL9Je3PUIcwZUteafeE5+oIQc4Q4xuFSUEtua8h+XgSR9RYTxXtLET5cGOopvwAmRP9RnYdvzB6k6ZQU2wTGz+2C4SUNgWimCwk9qN+kttw/FhH7HVqDYbomOjfyBQPvG6wWzn9kIgucKupdd/OtEnZE2Cz/gwyyTrWHe85XOhT758k40OeO0jsl4NmpuFeT+nsRXUdXVwQ6WzYm1aNtYVjejS5Hzq5YGjVT5D4drcJmwvehnsiD3UdRUvFByU/reUe+Lfj617jqLFBiVkxeVjRIU50ZpHJndMXrmSyEa9EiclR/1KHOu6kcRePcB6/M7olZ7kR/zYO/ter5EG62x9NlbEN7y+b6szOz8YwvntLQRZES3g+FsWq31brSCKxREJT8uDdfmmBIPXVvzXtWNAm9EvURsQeOrWlVsLIIeJbCKaV3zJYL/tmx+gmiFT90e1t0fnyxl1kXdzUXymQkVS9c3hAZl6Ogt+HJBQ6Uu4e7rWEHw+/aChnjiiQdrSfpGRzhwzEQimctnAJOhF/I8aLrN02EHFs4a12qfjsKwS3sA4AcV8yRFix6xqK4fKG/Zglnq+6GgeB00uUitoJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ppRIvUFqDa2Kyy7ng99yjVhsU2s9kSg52orXWwtFuFG9WG5lxOHDOmrgkwG?=
 =?us-ascii?Q?qutdlwxSi3KpKCC1P1hU8U4ZPZd7IIod/71g0ySssG6QHCJrUwB5oO1MiVhq?=
 =?us-ascii?Q?g5VnspEyznmLYpdGe2f0ugBmNUQvIaHDpvq+nwAkPr5/um9lin52bDGLAo7d?=
 =?us-ascii?Q?/H60ODqfWqrmCJQSckH/I2NcZz2PGGcXEPxGemhSN7LI+sDAcQLvt9/rSK4K?=
 =?us-ascii?Q?F+nPlfS//ZSb4bD3Cb+ZoqOdWGFaTm8kGVfqlsnV2429MzR9McwUc+0kukVV?=
 =?us-ascii?Q?HkfMHoEeGm7+MdPsfs2/8i1ENAPWaNjCOFfPtLC6yam07BQPsih32UWu2+2I?=
 =?us-ascii?Q?oB78T2u1aMLJD1Ogvu/0e98YnmrLayLcRqu/oa2vLKMau6x7jZPr8HXVH59g?=
 =?us-ascii?Q?dhE8Q2Dw4TzkzADK7IBwhs8mnmMrys6qjqQ5+CLzzJs0YBvA3ER5f5g2ns7Q?=
 =?us-ascii?Q?ydOH4WcSLvcYHlrGuwfgPFf1mf1iJoTk+zqleD3oOUHDWAQ22wHZiJ/8yYam?=
 =?us-ascii?Q?cE5yIkNRVl+vBfRvxOMuy/tL9gxQVU4rj/TZ6cgMm14Q1FTJ3GBssz88jmuC?=
 =?us-ascii?Q?SFYivnGseJMBEo6wpHIRhoe9R1tUTv11qwoMIqwzcLiJ8ZbbVlBGwx37kL60?=
 =?us-ascii?Q?I334crsdODqIrA8k20K0qlJXsr858m7sYu4ePLaN4h6X7C58ug14U2yfGUjB?=
 =?us-ascii?Q?dQ2FIOiFBhTjnNTyaPq3pY94ZqF9ezJwLm/a/kDZctXfegoWX4K3/+KB1dft?=
 =?us-ascii?Q?y6cOzg8cxIAdxHQNCQTekGp3H/MnS3Ui+14WmI6ktcMd2Oo2BL8PubE9dmPc?=
 =?us-ascii?Q?ESSWGJ0xhyL+PPcKOcJ2X3hMqvZJGdNWbDhoUr7HKg4sPWZ4WST/bnVRzpAK?=
 =?us-ascii?Q?jIGrH/Rg4anquP5gyhqyD0ZjoZTkAmM/qXGcbqtCVOCHN2NwMsRx2Me8xSpN?=
 =?us-ascii?Q?4bzAM0Hh15nb40mBPrDM1e7JFyTqdLkSoTwwOAGx1F41kuOk6v6zeF3sZZ++?=
 =?us-ascii?Q?PLlRrAJmjp1LxpblTfAkEWFBdBNDKYiZmjVrFRYwnuiun5QPapIl5KYaFqQN?=
 =?us-ascii?Q?HZnwvZRFlLYkfIGu6w9lkpbDBqEkzC/AJ167ie12dd7QrT7rdTASsbR+myi6?=
 =?us-ascii?Q?wPCNT420VUQP2AMJ1w0ORZrgGq7cBRdTfZvnoujNPgY1dUDHvOIDwcA6Av8n?=
 =?us-ascii?Q?j5jO01vk6R7ueV3zYY4LR6mOXGxwr4AmckEPLg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 635e6f1f-bee0-4442-a916-08dbb08b5b65
X-MS-Exchange-CrossTenant-AuthSource: AM7P191MB0695.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:47:58.8774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P191MB2049
X-Mailman-Approved-At: Fri, 08 Sep 2023 22:21:30 +0200
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

Errors were handled only if an I2C transfer timed out
and received a NACK which is very unlikely. This commit
changes the condition such that errors are handled if
an I2C transfer times out or received a NACK.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/i2c/mtk_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/mtk_i2c.c b/drivers/i2c/mtk_i2c.c
index 2f331d32..5592fe91 100644
--- a/drivers/i2c/mtk_i2c.c
+++ b/drivers/i2c/mtk_i2c.c
@@ -621,7 +621,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c_priv *priv,
 	i2c_writel(priv, REG_INTR_MASK, ~(restart_flag | I2C_HS_NACKERR |
 		  I2C_ACKERR | I2C_TRANSAC_COMP));
 
-	if (!tmo && trans_error != 0) {
+	if (tmo || trans_error != 0) {
 		if (tmo) {
 			ret = -ETIMEDOUT;
 			if (!priv->filter_msg)
-- 
2.34.1

