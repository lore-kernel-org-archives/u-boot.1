Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4BCC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 05:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC7384C8D;
	Thu,  2 Jul 2026 07:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="iG/N+tFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E6084CA7; Thu,  2 Jul 2026 07:58:21 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C752084C6D
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ln6DBkMMY0+938oOlf7ka5awoIY1DNzUS2vQJPNs5SZ2HVpcKL7zPyYau+4g6zrbdNAn0aTNFnxizw7rUrOnpaetLpSsJ2s0xMo0ToXqjx758A4ZBDmvg0Fq0QhCiDatodN5Fbk/Z4fERRyExDivvCtJvS0Jd1N5ahLJhdvIAi1JJWvBTa34yqN1bGlM9ma0QpQ/RdXqldSYCry1/oFCudQnz/DgO440bRH8ykOkamlv5oSvZJh+ByOTYTTaIr9v/v9oqRdew2FQWSfmcW1XOiz/Xi/xVp/0VhmadKpyVahRTeRV3VhMcSQHwqVvZHiVYWCXivXMd9YGfv7QXiP9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjsHngMagFFdW5XW7H+k9GNIaUoh1NIcF/Y1GzS6iMs=;
 b=RgE9Z4ikhLdOZigxQI/Nb2oAt0cW4TvnKI50FBbhkmzT1D6iNPFqkusifHVBODln4NhdfFP6Q2nNrKKHPP4OWf4qXmO/avNXdRrVnW3dcIyE7ChXBHWrA9TQLm65VOhxTxqKApxT4mwhKdBYBIOn7f8JILDPSLOrkcFpejFelh4uresPh3zmrFUqdctQHl8wA2nHcVeVawrW8czsdtj3ZI8MTnUUoAqutGEFSo7LF6NrhTtJVEUhzKWlhFruy0Ev2G1S5MQb+eztQCpIt5c4vpqHJ5t9LjBqup49X9aaz4MeetCer2S834CI/bU8RKS2y8yxJVaCGJ8sD+o8NlPcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjsHngMagFFdW5XW7H+k9GNIaUoh1NIcF/Y1GzS6iMs=;
 b=iG/N+tFV/t6P0TNAECGD7zbil8yqigWEmr+oPP9zD/p4fwEFbrjDcgwitq5+5ITfBAsOmzB/7NJxzo1pCZKGWuHozzsdqWjThMpRiVZs+/U6girpLe15ViuSSRMFW2eXAt8Cj9tooz5gcXpBcD551P6Ddmsu0Xad8DPO1SsCSmhOnpNiK5sMfib6LX6K2TGxD2Xr8UleRl3+EQK0AZSHNMdCCnhN8adbkTHCPYZYino4XlzE3dA8sSp6YTjqsf7N1RdMGehCAcWK/xC6jOkPM+A7Ygg3Tjya0AU96oS5QLhY3HBFc54gIyfuFXIKeT+GDtT9mAF3MisTH6bVo4N6Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DBBPR08MB10433.eurprd08.prod.outlook.com (2603:10a6:10:52f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 2 Jul 2026
 05:58:17 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0159.018; Thu, 2 Jul 2026
 05:58:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v14 08/18] clk: renesas: rcar-cpg-lib: Convert to common
 field_{get, prep}() helpers
Date: Thu,  2 Jul 2026 08:57:34 +0300
Message-ID: <20260702055744.2164975-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260702055744.2164975-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::16) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DBBPR08MB10433:EE_
X-MS-Office365-Filtering-Correlation-Id: 938c5518-7a98-464a-39d5-08ded7fee843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|23010399003|366016|921020|38350700014|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: /XnNTloA4sstF+IZj8s2/bRUF+RdEsE0qGqGxPqg9Xamt8QJ1PmWCZj/Q8toFHV9yYhM+92O2M97im6gR6SYMYYN+jIwfuy4iyLATOOwL3+SgciX2AsbiSJV86gl5PNaSryJee6TMNdd/bYnhb5uJpNRE0bF5ACUFbGIQPLVYdCqz3GHW5ahXTRA64iDH60vsZMpyM7K0kpvsQj5GveFp8LhSp1EyyiGZ7X9/8bPUYAOK3JdXpe0ziDvCEufO5UHZ40dgI6LUhaL/kSaQk3KWQqM4dg5uX68c3TXPwsnQ3Gsvu8i/r8v87oP++GRFLWoMumclTbZ8VojkaSg/oJzEOs5LHOQEvX50TITkaQelNfL2hFC2TrgOWB0GbQEI5TzVMCb3Vk58OsPqv0/UTWzGxJLe1UlxoFmsGPkeQIB0dQ0CN7cPSv+BwRul25QZJ2W1BS378/PShFvhkkLz7P9GWpYvkeBY0dCJeSh5OqJfSz5nODDGt8+noHzgfRyEHELownhs3LDhJJW0WeC4EAaFE99AqXQ88qe/c3irTo3uQpMn1n68ZimooSshh8fvOfIje1Y9GMyQ7Tx+DKj8uP+xTpKNwfPMItZkQdh40HDNY4fMNS8Y/3yplvd/+NiMndjEUVDjutexsQr1OtmWYFKB1w6ee9WssYuvd5hL5P4WAGu+W9qUMG7r6SArrVIGltUXy1sVA88EDNE/BFkYRFPsvKqpBIl5ykjx2Vt55+W2VV2KoYDxsuCKTSW2iF1HqMj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(23010399003)(366016)(921020)(38350700014)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hMQH0Z6JyFr6HO8nSE0b748I+VGhBAXwpKL8PioOFF9nfQEAORFP/IFyLWJg?=
 =?us-ascii?Q?0v4trBp06E+agwj1pfgGYGb9POd60uYM8vVaJ/bvIXhyfEOrXW5LW7tAMQ5j?=
 =?us-ascii?Q?WVpw37ql4isi8Bl0gZgD/sfZ2yjf3/qeBDjTMGnmJHdRxiLPLDVSKcwbY1FC?=
 =?us-ascii?Q?41tj2sdk9RGJNPa8KrvfbTYkCEfasBDALuE0d6WkDvK6NZeTvrrpUgM9gLXt?=
 =?us-ascii?Q?SMdba5nDVrwq4ZGuS6d+Ouuip/j/nhLsqh72I7ylztUTR8mgRpkLkEV5Kxyi?=
 =?us-ascii?Q?NqI9Oq8UjpoltB0PJFSI/wRQMyz0IaFGEYhJKnZhx8yefo8a3bb67DMOQol9?=
 =?us-ascii?Q?KR4XUeEXfhcZDE1ypxhVCqE9s75sOKsb3wf1XM6KNus6mvHNOcv2BazJ7Etd?=
 =?us-ascii?Q?YpDqUaoJMJ0YnU+gpN8tlcgLoVw+AUa38CP33lw1hKLtrrHtORNW5kzY6mZa?=
 =?us-ascii?Q?aLfMYjAPM1fDKGVqx9OPAdaso3E0MJAvqvy8Iu+stgNDh3++bWnQX5dSb+vx?=
 =?us-ascii?Q?zxhhZ6mjjiYK+TZS+BqdRDjQdPUaw3wXsnihgTjFgS7QoCxOozty69ktRvZK?=
 =?us-ascii?Q?dj3SEv+Xf/utmzKvy9UChmDO6uJ2JNXNgltYuhv0vl2C4aQkYwTGywaj++k1?=
 =?us-ascii?Q?TLb4vbZHtt0feQPyW+QacB1lXvXLWqsMQkDwC2GdwiIlyXZSjtl43lErkvDb?=
 =?us-ascii?Q?2Y+/HsmJ3Z8PNJX5CmdU/++QmV3bOKG49TR5QdILuKYvYvIUcupZC+n+ekfP?=
 =?us-ascii?Q?WcRtjEtO1112TkifTfwFojrv0bIpOZokr35FOM8hKLUb683y0ZMuYYwmkTSa?=
 =?us-ascii?Q?tt5Jy5tnR4vSo1KHK/lJ16LSEN/8EPbLfPICQCWETJ/QIh5wvrC8T/PZLD4+?=
 =?us-ascii?Q?3IVwFRI6+7rW990YgCQlWU/fbGfKTO1JxXMy77UkDtDUkK2IdcAeSGxp/M8I?=
 =?us-ascii?Q?ae/BxaJe9eDoXxtEmkt7N4bD2ZDSZ9jF80rxFl1LYItuLbxTfMhvgeNdi6cR?=
 =?us-ascii?Q?LMbxU1F+0NDt0kpoNkt51p1JOhpK42sN82mY6fvmAIweGjQaMP+ZLv3Y3qHn?=
 =?us-ascii?Q?WttHRA8jJW1tEvoWAhXZFPyotROtS6zLUEJD87tcoG6qU4lUPZXIn0yhktTG?=
 =?us-ascii?Q?6pMDhhxG7wVRQAfsYTqAhAL/fY+ggx4z3heCdZU/Jbi2NK/35u/oqU7vMaRR?=
 =?us-ascii?Q?x5pNqAmqwS5IV+5XZ8Zk1YUALOpWwlOg+xVelFXUsMv9rSBbDg91xvsH9nXg?=
 =?us-ascii?Q?y3Q0NuyPecsRelI2klt4ySKdYxR52mj0uxHP+TuxS1K/eu7zx2nZ23+zqLQN?=
 =?us-ascii?Q?XnAHVW+y0o7t2FZsJfEaEXCXvpSJKI+B+OgaY+JfuRv/+fst4Ipz+H6BY/bH?=
 =?us-ascii?Q?nnVUxOOSYWcrgvWRNbycBmDwMX1thzqMDiasywkb2FQXvyrBopuYp/2OBEa2?=
 =?us-ascii?Q?BSQMvHDMbD0fzv+WplNyy3zsiCQiCK+wbBDfu1iviFEPfk6C4+mk1sANV00l?=
 =?us-ascii?Q?4s5ySnHQUJPI8QGKYFmO8bbMGLPditWYTzC8ioAM4XotAA1ooUAX/F6+nP3o?=
 =?us-ascii?Q?8EKr6lODCjuOLPHwl2D8LJ33L6YOm8/7LW7Fm8YG3XBKSwDkqXJnsbtHTJYK?=
 =?us-ascii?Q?5Pbhga2yeb0GmURmH8BNJ1gKpdKrjS7KEaMtud4ajBpA1Are+ZafsbK74X4y?=
 =?us-ascii?Q?JX0CptatplUYAzbnSX/VnZraIW6GvLOD7YhbhTc2GMah/qmCFDxOAacYEg9m?=
 =?us-ascii?Q?CzWV2q2VZ3+8Nb0E+iwK4XPmbkqSzrk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 938c5518-7a98-464a-39d5-08ded7fee843
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 05:58:15.3199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71gP+8/mgEodx/LcAXxaGVBEtY4TzI2lO1Lu0GbRkYn9D1595z6uJRKLjqUEG5nk8dGKqJpRBhICbtV8xXkkJKDbaPaMHTkwKUdKn75o/9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10433
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

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/clk/renesas/rcar-cpg-lib.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/renesas/rcar-cpg-lib.c b/drivers/clk/renesas/rcar-cpg-lib.c
index 60ab2cb379e..8e992d2c2da 100644
--- a/drivers/clk/renesas/rcar-cpg-lib.c
+++ b/drivers/clk/renesas/rcar-cpg-lib.c
@@ -30,10 +30,6 @@
 #define SDnSRCFC_SHIFT		2
 #define STPnHCK_TABLE		(CPG_SDCKCR_STPnHCK >> SDnSRCFC_SHIFT)
 
-/* Non-constant mask variant of FIELD_GET/FIELD_PREP */
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 static const struct clk_div_table cpg_sdh_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { STPnHCK_TABLE | 2, 4 }, { STPnHCK_TABLE | 3, 8 },
 	{ STPnHCK_TABLE | 4, 16 }, { 0, 0 },
-- 
2.53.0

