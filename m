Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DD1EE020D
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 21:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD1186A63;
	Wed, 13 Sep 2023 23:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="cR0QRSl4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C1986907; Wed, 13 Sep 2023 23:16:07 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86C3C86B65
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 23:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=han.xu@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuwmV5yO+C3Se+Mhe9/nSjHxBCRqkfb8ZZ3jxX72sx4r8/e/M/7uF+WK4ezGrOl61cnJkXGUt6FH0qnxF6XTEeLi8BK0H/ywMwzRU10+wCbwpqL9/ko0bNSDafFUZAvaWzGs64zSAPwYR47QsIlWO+Qmfi4Slda1tzTme6zicDUpYRqZWmsA8bWl3gIScXE2sKHbXBiazhDBxlNyRJ/zs1X9R7OBS0sKjeys/H+mE22mIY0fGdEKcR0JmnbiZvQq+c/vBy8gJNXavFGDnGYOutkqtC/mOtMf7LAAtqX1qQvFl4426POGcePig0PHV2r/P35u+gJJKXI5E1SFs/QmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGZiPdFBqDCpfPrOKp+n7Kbk3+YvZ7C+YMvhxxV/3kI=;
 b=WzG1UAo0taAEvNImPYs1eLtrQZggLwCC9bZjRYnWXQSFwXzKSqHfUGaFwJXxRhawfmI5KZYJKCC/7qgkiI3/m1S23rrmPI97HiFalPBqU4fewre6lnYIzo8SkoqEjezsvamve/8d9GWr2ue3zgJiig3KNTHnmFMmwEZZ4g90A3FKNkvx9wg7JoY9qAg/rye0k+g2OpLtA3BeHuim/bKisRWohNbrtDMXD6/Sq1fvVRoHzweX3RhWv9emF5Om9gqMCoDsi/0BIEgEnm/C/2ETgzMAByUljzhbSLKb66m5MTQfH2ADgdmc8Qj/DZEIzvCbATPBYhtvdEjoZMCGVPxdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGZiPdFBqDCpfPrOKp+n7Kbk3+YvZ7C+YMvhxxV/3kI=;
 b=cR0QRSl4TsGfQIiGeSFbjSxl4OKmgx9pDDsxBeOYoeHlu7+XCOPHv0Ojz31Og5lpJuj9mZw9pjPgPbqqTwOWceXYJusWz8ZQGxhpC1jRvQ5huB/ra6wLCXuhxnRXyWAbZmtzivP0aPNt069Ij3TtIsgz2ccYDTOyP/ltvPQADhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 21:16:01 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::374:6c14:7fd3:e932]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::374:6c14:7fd3:e932%6]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 21:16:00 +0000
From: Han Xu <han.xu@nxp.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Han Xu <han.xu@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH] spi: nxp_fspi: reset the FLSHxCR1 registers
Date: Wed, 13 Sep 2023 16:15:35 -0500
Message-Id: <20230913211536.605599-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: a3dd3b9e-265f-476d-0442-08dbb49ea104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NERHa4pOPEuP5rc6RnazdU2bkQBL+/omu/l6XhGeKqs6Nq8KSpEp6PP5OMbhPboFYf4v7tbWFKpPdFYz7gWJpGnHMWOOkMgzCrqXC0/dKfp0uApKxTHRuiSbHjfMt3DMsgthz804AXllxBX0umCbJPKE8Wk4ooIq4huotr1eODM1U2F2esgloHD2xImHmhRi3vCmsFAoog3jfGK2so5VLaW2UeCpUKB88fF0IppEpFuKXr6iK5tM+3+ZyWSti3RP3E8jJRb85nWTP69W6dMeJpklr9+4ZANWhLi8QnLKhwI3KK3+MvHgZUDOPrAJeu2mNXx8n9f0+1NDWC4O2io823dCXgWkYyTUv7fBvCFTmNrcg9qXXyis5I4KeSI/M/TVOq5q5INi7ZCfuyAGNXcvnI8QtjZKaOEm6qw33Dp1lZAPt1a8HdDUJPapK6JBMlK+iQ68hSEOmRirTPh+pagkYQ334v8BPwGYoi9x6TFofBwpAp4v5uuJEU0TjHWONhCnjs7wb9NhTjVJ/P7HAgf9HA1PLcp5ogTGAagTcjxEHUpd7PEfHqQwQ7fNlLDAj7L4K/Bbc/KV8OfELO2WyGtiM5wThdmGC3NdIpkXBHtqFh726dKzvUwOS4fJuQ7C9NSE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR04MB9071.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199024)(1800799009)(186009)(6512007)(6486002)(52116002)(1076003)(38350700002)(38100700002)(6506007)(2616005)(6666004)(86362001)(478600001)(66946007)(26005)(66556008)(2906002)(316002)(44832011)(5660300002)(4326008)(36756003)(6916009)(41300700001)(8936002)(8676002)(66476007)(4744005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nmihN9TD45ny8hRpiT3qLlS70iFZ6EoagiVhFb1ql/SRMN+Bhw997B3YNJEH?=
 =?us-ascii?Q?1+yHHMHYh6ZID0f59CY5HdTyuwIYdVGanDmwv/b1+HfBKBbxXYSS+uSw5Tlx?=
 =?us-ascii?Q?0g3o6tAm6w4g4LHHVRcpDg5MWHndpbKYL1djJQeTg7Ztbf+bw9t8oqnlGyFo?=
 =?us-ascii?Q?FnF0gaf/I7eaNpFdrsPmpSutcamolipiAngIQfzKG2eXFra5S2WZAxjM/Got?=
 =?us-ascii?Q?TM2z1CvW+Mn7rU3cBeXXeQgj6Hy6+aPFsOwR1HLs7gHqaO7qL4X3pu0TKs2S?=
 =?us-ascii?Q?CVPnLqzAWZUvJtkcNb8/AvCNHVIdxbwGlLn1X5uZOCaEPhg4Nyicyc3INkIR?=
 =?us-ascii?Q?Fsud44yl3Uc1vU4hluTNwget3uviYtHadT9rDQ4KaeR6QN+33bfNRJeh9Et8?=
 =?us-ascii?Q?Wev5o4LJC6Xd63nZa/okP24/pxNTZZ43L3ev3xJI89IaguUrzX3W+U7113jW?=
 =?us-ascii?Q?F04O3+7qQzGpMLhD0P8H/+mYrJ5yKe/2dBw0JVDMHpgPOAUNKHjYv7hbCogY?=
 =?us-ascii?Q?ve347l/j4QTGUWrSY8WLX2Jezc+EsxwlS7QXgD8zWV9XnIZL2evVWrS3RbRx?=
 =?us-ascii?Q?9874WftCBjxW20iciBUSLZr1o/XgoyqB9HXIQ/b0MVy6iYyK3lylYAEDb5dt?=
 =?us-ascii?Q?R10SknQkf+n81GdWh1mOghH2gXJ4a+W1hGwekax9+SbSJuQeqcFMg5nD0UFe?=
 =?us-ascii?Q?lO60vmtvP8ZUC45DtCrOA4F63ng0XgQRpUB9iCtgcr2oo8VXi4bGjWYMWgXF?=
 =?us-ascii?Q?fVngi3xeNNYmdFxRkWI5fM2Zm+YqJyLnpjr00SEb3FsQZFSHML2jWfXP38rn?=
 =?us-ascii?Q?Wu/YZBq677P4B8KKYj2go9RdETs+EwMRpZHZya/DD0FO3aN5N9C7/wCZlDgE?=
 =?us-ascii?Q?IeJ631SkvvxjV3ON0nbDBd3lbXRfMmn5soFdc7WyZroQi/qJhQaSkEXoqGUz?=
 =?us-ascii?Q?IoqpEodx3YAxR+IdESzMvtiabMDrsIDA4hDOEJ64WUUtyGJiH7EQ5tVkNf/t?=
 =?us-ascii?Q?pv+EUUtpQCaTHj3dZ7eA1QkY0nuF+NZvD8r1RB0FiM781MWQnSeJTKBBOMKN?=
 =?us-ascii?Q?X7gQvLza3SNlqyhQLXQnkW5Nhulkam8Lp90S6vSI6OwQiv+fsBrFiQy1pq4N?=
 =?us-ascii?Q?eKQaC4McXNOsUAjdNtA5aJQmJlZ/VerqGcEiF4oY+fo9+wFua6VnEartmxTF?=
 =?us-ascii?Q?Z8zJ6qiDHdoNsPFfB8i+Z2kkTzYspJQ2sviwfIbLhaSqFlw9HA78AzXqbexS?=
 =?us-ascii?Q?iR/WLfhDvKT8osoIUBAvaOVhebb9SQ3iz1BXPauXTs4PyTdJyhgpnlCmbsDI?=
 =?us-ascii?Q?K+7AbRp91hYSVVWidx82iV8RhVU+cy7Z7JG9L9Xh5AeLWBItewr5lLqrXCmV?=
 =?us-ascii?Q?/Kdz/jeosDvjHIqEqG1Z+a4+SpKTOhsLW2z0aHp2PAh+JXtH53hmHwKPeYhW?=
 =?us-ascii?Q?aV3CXPex6s6c4HZ+5AWCX4s2vosF648RGA25tLV093/TnYlrIIGkVZXPAW3O?=
 =?us-ascii?Q?Jw5nZcoMlM91jnfsOBQssLhSOyf9gHG5YvPuDpLQNSWWRStdj4PrmZy/Lnmz?=
 =?us-ascii?Q?cKZ14MbstU/1QRdmMUo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dd3b9e-265f-476d-0442-08dbb49ea104
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 21:16:00.6013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPMk7lk1yIVFM20n5NZlNQDu53TCu0pCGWbUT+Z0kXa6ZjPtIEbDbyAltIhLy72M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337
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

Reset the FLSHxCR1 registers to default value. ROM may set the register
value and it affects the SPI NAND normal functions.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 drivers/spi/nxp_fspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 579d6bac9b..5db27f9ae2 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -927,6 +927,13 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_AHBCR_PREF_EN | FSPI_AHBCR_RDADDROPT,
 		    base + FSPI_AHBCR);
 
+	/* Reset the flashx control1 registers */
+	reg = FSPI_FLSHXCR1_TCSH(0x3) | FSPI_FLSHXCR1_TCSS(0x3);
+	fspi_writel(f, reg, base + FSPI_FLSHA1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHA2CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
+
 	/* AHB Read - Set lut sequence ID for all CS. */
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
-- 
2.34.1

