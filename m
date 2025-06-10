Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBEEC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 04:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA16F801BE;
	Tue, 10 Jun 2025 06:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="wcDo4fEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECFA82B70; Tue, 10 Jun 2025 06:51:07 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF92B8004F
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 06:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzYfFNyYbf/ePG0/SNyQKnRp7yKJTrkmKBl2uoXEUBkew8lnXLEaWvYzwsSFMKjmRBLkpNU+zJjTTlmiZ+XDeUlYZ0JEGI3smCt5dVPFR5c8EElCcVCOiYWKKph6GsJMW4hzHo9OpVF1QxzUeYIGnkk3TFk6MXXh+FfdccH6qjb90TGoPF7JvvkKbxtQiNnEjSt1dmbRv227AWH+Gl5kNSIe2dq5B8V1oUyOldv1fO0nN1aQAugeULJgg7HcWaULDEGkcQZMiuzLYMCzsIkN2WEvp26V9oCCIh05ASNj2w0+En8MITDWefO/O/hXaB0p10pTFyR3e7+XgCX4yThY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gI8Gc8jBXXyLsGLPzIG4/6ma549rbjAq7MJybGGIxg=;
 b=zO+xfkZeTLG8ydLi1oDaqKPd/cfT5IUqn50yiGVHP3t4XdJ7MwqxiLzi/aPsdoJnQQQy2Zu+drijwcChprAnhbPZ1I71AFcM07SBvwyxbFs1FAMn+7Uc6SDph4g+yI9saK8KB6HQXMbbKgx0v/UXrNARub2xLsTjvHAJAk+h2OYQRo7/TSP5/QLHGPxfprv6IRV2sxLS74A/D/KBg+wVMlBpta6CkPHf9Xkpv3lBCoSvnkbEZ1fpy+HY8zNV4we1rIOlkxMer3oN/+lJrmqlVhApNEm0L3wBeE8fLgAnnSORDeI2g884W2NMYTAOpSc9eqcxOSgLOphfUPIo2sOnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gI8Gc8jBXXyLsGLPzIG4/6ma549rbjAq7MJybGGIxg=;
 b=wcDo4fEQ5gxYNLjw+Y/uazHizkY0OHCiR+kte4NS4YLTKwzoARoMLt/ikEsWb/9EmqdxPkK35pAmlgHyqU8fYP/K5XAK/Hp1gB8h3RF3RWZ2bgCPt5G25V+fcNIQ7YIQIYZ27XlxMFp/SAFerky0633v19TdvcSf8UimhnMXjJQDzQnHYfiJwDWTR6Kv8lsMYL6RBNEyBPahG17XdYrG5Ok4glqW6eVrfPx4kJMpp4Xc+CKYcPNp00JcDG6eskak3FC7wgCzthqETrScXXJ2P5p9HPM+xRr7187koF8ZPMCRT3U5ga/lEYoSMaktXxXJcH2Zi1JSojjTVn9J4HbWeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU5PR08MB10774.eurprd08.prod.outlook.com (2603:10a6:10:529::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 04:51:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 04:51:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 0/3] common/spl fixes
Date: Tue, 10 Jun 2025 07:50:51 +0300
Message-ID: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <DAIKOVEG1GGS.2LH5IT55T3CGW@ti.com>
References: <DAIKOVEG1GGS.2LH5IT55T3CGW@ti.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0001A03F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::484) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU5PR08MB10774:EE_
X-MS-Office365-Filtering-Correlation-Id: de3899fe-65f8-4b90-8e84-08dda7da662e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ElzbcpZ39JGz8JM+XhGqquQnE35UtlM5u2sX4JKP872XVAJUX+RtJZzZCv0h?=
 =?us-ascii?Q?UvEf649hoszoLFPjPH8d6LxsPyzOwyxDcV4o6IkAODLKoak/7tBvdkOhhObH?=
 =?us-ascii?Q?YHHyeo8oA1ndfe19+2wqh/SCNEXsO58qi2Ft9vWLR8ldHd7tnfq19TE2QD4M?=
 =?us-ascii?Q?DeP/Q68DxBfTcYGsKaSP4ba8M4WZtwau7gHcQ/F4/zXee6HV05K71f/jLyHM?=
 =?us-ascii?Q?KPg2J+f3MMBuYWXc75RbnNiYWaCumyogutCP73hjGq0jrRa31/c23/I7Styn?=
 =?us-ascii?Q?YLRb2OTjlis2ElOebtPRrmNdZKS8U5aSBTkrV6/JBatOpc/B07SoD8eYVJMO?=
 =?us-ascii?Q?U0BE4Gy71Ns67R5ktSQYxvsue/kyKbUxn0BD7NHNuPWOAWI8QbLOdjSlxQyb?=
 =?us-ascii?Q?gM2KQHMowdtRJ6btiY6HYU3UMr7yXVjqrWERCirKpX4IJkZPJ327g5T5rIVF?=
 =?us-ascii?Q?Vju2WhFSjKiiWzYHpOxVatwrGjVQxt2A7FE4fVcRxeGzJijfl36KG+rlD/xV?=
 =?us-ascii?Q?Nchb9peWczaTNk9214gfbEIg5oidqOAsNm1SfsByZmYi/gTDjw9xPIKNAks6?=
 =?us-ascii?Q?BKg+7pO4Q5VU462Lxeug7drzVGPfVrHuTa/YzD74ueeZWPmzJYcUVUHUTztm?=
 =?us-ascii?Q?/LW23GSKOTLXtN0xY03nbKhYfsxbvebhyYN8CS6QTo37X9W+oz9/gHUlzk4T?=
 =?us-ascii?Q?6+j2W+jFMYCxwqbHcZhM5vJazWnOQnFwA9OENn6BwdMRhf4UfsLKpYzsEDpT?=
 =?us-ascii?Q?tkwjw0kBNGKvA2kq8Ld/VN9F2SaueHlNMbaPx3bnQiX7onPtXIRfRQKaQp8H?=
 =?us-ascii?Q?Jl+DuMSkd4cEqAvTCjq9sZGYOreENFzqxdKiFJ+7TR9kTIQtPvJNjimvcF0k?=
 =?us-ascii?Q?g019Si/hYOQ+XPaMts2u90dVeOVUOjgzKNDL63h8w10KpF6i4vkMG1i6d42E?=
 =?us-ascii?Q?RgSTFgiqn1Oz/l6eQxYUKIoiGpa3vYNn145JzPVc1U2mQ5+yIPJYjUnW7PcJ?=
 =?us-ascii?Q?tmYXwfVVg816jSBs1ufXsWGEGyJckYzMArI6jR2k4FRbwCxGFRVIOwksuv4q?=
 =?us-ascii?Q?jwYSLia3ZV9zZwZUVfO09TrPxjnOpkDErp+H30J3t42607S9rgolj8el3Ss2?=
 =?us-ascii?Q?W77ivD0DJdVhJkJAC5eT5u//ONSOPaR248/4mGY/WA1VCo+JUwSAZlzIe2OX?=
 =?us-ascii?Q?3x/jsxlkqrGjBnd/jJTWQdZrKiy0NXDlVncR0Jb4W7a66mUmn9sOJ7LINqyE?=
 =?us-ascii?Q?Dp/iuxfJIp+JFbUXU2KXFFFU2imRjtMSKz4boh6XROtfOgJibznBztolLg67?=
 =?us-ascii?Q?n9SRzHVnt7wQAIWdd19tmb6luAJ4KFAOfD0E4jrD6UPZTujDnTEhuY10emV5?=
 =?us-ascii?Q?qSbFl9yGiMGau4LySt6KonaAuhanPhPsOVjqlNECrtlE5TFjiJLhLJOd2ZLJ?=
 =?us-ascii?Q?5hHDE1x7HKNjWQf7xFcfmTPhDVAb0v4WtUFtTbC0iqxF6O7KJSiHvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/xmAHXf9LMjnvl071uO3+qVWQT+PE45O4qOsWc4+6gylwzr1QRdUF92WlVfG?=
 =?us-ascii?Q?kAOk2PLKUqN4LIiLKSCCdDLlciRKrXZ35gsEGIS+eg3Myuy857DbqiM68DBJ?=
 =?us-ascii?Q?pIAa0m5FIzypiHaemIry49lHwWXpm7Qmt3WnFIhcs9x0fToGmVO28l92Yz93?=
 =?us-ascii?Q?6Dn9yaWlhD84ZF2M5L6JPwoImpm5FvZpsSTwvUyzc5Qx8Ewx0aHQ30/8yEzN?=
 =?us-ascii?Q?zuisQsnq8sPg8viApC409M/bEdnt2SB9HjUJVbVLlHaSz8YN4rGC3FqKFyTB?=
 =?us-ascii?Q?gPPQtJeyQflnZDlY3W0hABJIS2WnPbtMomlsBdaun34G5wJfjUQx68Soh/No?=
 =?us-ascii?Q?TbssPpOFkQnrScSbycvgMNuCTiTGzS7iWhTc+ishS9CmsbUXTvfnC7XGSZ8H?=
 =?us-ascii?Q?+DfdY/Ni9MgAsjb+O1UAQM5clu2BQoFjNvK/4kPkSms4hfQnpiDQXHH1+IrB?=
 =?us-ascii?Q?tZFc/EjbbsYw9wKfb2TRGvi4YrXywAZBJ0S6ohsy1xAQiJIcKVTgAY9xuhd7?=
 =?us-ascii?Q?Xx1Ti5f45E1VwUhyGPfgsxq+Q0hnw3icoDIj3mNqSrcsjKcUwBMCHckyoPUv?=
 =?us-ascii?Q?CjBmFFNvl+JUwHSuMCMs7hjhJIRHI52UT3/4QR108oPqjRItGKahoxTcnTdC?=
 =?us-ascii?Q?C2gVVdt+/jSKocsqrMpfLnZZdrd67LAwql1AmaHR0pp/0PKg4EljSw1jqFDQ?=
 =?us-ascii?Q?0dJ4OPjNqe/QBZJemL4gFNvKqOxTEY9JGqZ7j2HgpqQxX8QdLgMDrlUqYIFn?=
 =?us-ascii?Q?z1JUG5XHTnNt+qam79tJ7bhXpqNk6zxFUlJZOvdBzuRJX69Uop/uoyfa0FEh?=
 =?us-ascii?Q?Rd/0c+i3AVkFmIbIldXVaeV3kRUIfIemCwi1dNYBdm3+phKUIfQ07fN509Ge?=
 =?us-ascii?Q?cQlTWWQNf5om1WrUmwacZRZ6YEwz1JFl1sZGS7zxwtdt0GyTrkO0PwLuhA2f?=
 =?us-ascii?Q?pRT02sqpDUqaDTJDIrNq5CoctFwzQt8RM7uge51reA3uRHpG8VZjmyaxhlFD?=
 =?us-ascii?Q?EzqKnWmRlL1uRQ8QyzgF100CICvQzLZEgllE8xqDBToBXf40qXv+M2AXuD3c?=
 =?us-ascii?Q?HyLpIfs57xkW/ZD337sVXeiSEOKQ08mWRfowI5Ju80mvAgLflJm4coV3seQc?=
 =?us-ascii?Q?kxNMSIMqd/72eLbxeYcrfafmcieryLKGbpmhcid0xaxeiaQ5rEEs0aaD7u3F?=
 =?us-ascii?Q?nSenm9S4ZHcpgD8Ev+OmXAy5N5kBRVCtp95wunFgF+HyveQBpQ6yco5ERYM5?=
 =?us-ascii?Q?KjjZDx98XnJmyai8Vzwl9PZhbZm7VorSqI9T4r37/w3LSObzGvzaSkxJ/qsf?=
 =?us-ascii?Q?aU4iAvwqmzxIx0PLyxeYkPoUymYKCitbwbHkDyG0NQ2C/llly0wRcoEkgH/e?=
 =?us-ascii?Q?4NNclX4Pc+B1nvEbtmX+muthDSq5LPTGs4oDEuQVCbXDgNSFxVNvG8bYQQgg?=
 =?us-ascii?Q?CHJ9aFMqMva1Mf1/FEJ+46VmrJlijJPLDlxg7dRWBf82/6fxUdrCai5KHkW9?=
 =?us-ascii?Q?A0CDGdBk4gh6kYGyur3FwK1prPFhJXj/3OZoVCSTx7rEjb+GnQh6X+7I2mZy?=
 =?us-ascii?Q?oG/K4WFKhKUXRLASUCZ2L2VBIV24fGRDqwUrLBpRtaOidV4S04/ibhG/NUcq?=
 =?us-ascii?Q?RWHSRaoStAlTWPPYZStfB9s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: de3899fe-65f8-4b90-8e84-08dda7da662e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 04:51:01.8658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZOcxQzIh4S1R2v2QlJ19+IqWOmxNs+omO6sMcfYi2hJFy2dtAcfZ77XZ+0eykDb3nd3fiVSiiRF3B95ux6/+dpTBgrL+jI4gUYEpPJV0eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10774
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

Changes v2:
 * added more details to the patch descriptions.

Changes v3:
 * fix commit 873112db9ce68c38984ff25808dde726f8dd5573
   ("spl: Support selecting images based on phase in simple FIT")
   instead of fixing loading of image with bad checksums
 * add more comments about memory usage by board_spl_fit_buffer_addr().

Changes v4:
 * spelling was fixed

Mikhail Kshevetskiy (3):
  common/spl: fix potential out of buffer access in
    spl_fit_get_image_name function
  common/spl: handle properly images with bad checksum
  common/spl: improve error handling in spl_fit

 common/spl/spl_fit.c | 48 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

-- 
2.47.2

