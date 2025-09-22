Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA315CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 11:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88E3A833EB;
	Mon, 22 Sep 2025 13:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="EKhEgbOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5081A83211; Mon, 22 Sep 2025 13:12:22 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B94832F9
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 13:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fO8aNmaHy3cavGGetjixsLJzRC+gy4zDPw45Y/bPPY1cjbKE2sftYIb1S7YikHSZDDUUqKBvQhlnkmCYRjCjknIb+kFy4W28LGfv5U39GxTyj985H2doi7T5KSKEOEuswej/aPBXVfLZpqWTDd/XeCGmWl0dsO9feZO0X3JEQ759rUH4F8QIdTC9cL79IYvImo7IfRaCIf6oTnp0ZXgFAKZeILWMg8uqJZiYwcSwqPOa4uNdLqy37Iq97VeIibl2lhl47vCfundBW4VfMR3U9pCA0NwbSz63YHP80+XS4BO7DDgAUFzdryfuHquwlwBzkTJcE5QMpkEdD6ftOrtMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=815Yggqr4fWfZb9JqW4R3M05nDz5OfhaDbLlmgqChEY=;
 b=n7s46g0hnfsbR2faXdKM85U2wVddLLLx3WRnlXLdgashH4jwPyEu/Wlg0Y9GhjzFJRQCFCgztHVvnWD05KgFUyuRCs+Y2uNIqUNI0tKws/z2EoBYIsZeR7I0qraiw5H/Rme4KWkHHa+1MM82g5vJK4PAVV2hGW9SljNBSq5RKG73Mgq16Rojr+ZxTv5PqevMeUwMBwCdq+6TwhzQ18NsIqe3qfssFeCmjfvLntdcmKjarkgzUi99KEfNCTM1apXA/rsftUHQfQg3ZJwuPjVXROjaz0q9PRmdGf87ZZlk9mSwkthfnCZD/68Ym1t38aBy3XFdHmCBy2HJjbEji3PeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=815Yggqr4fWfZb9JqW4R3M05nDz5OfhaDbLlmgqChEY=;
 b=EKhEgbOBNp8qKSifcxXzLdWO0bSD4Nsd0A1QpcSh2uj4ZUIYGPHNrwCx5FzIZCZQED8b8BY2BE1r5HVDw1aet0lqK/jkXTvl5doDJcRodH7SWLPlm9Wb9FexJagxY80A70Id+TW8xzCUrWlsdUZxdSVupECxUu8dBa5AP5fHvPp439RZ+11COGpqKc6zDSx11mHSyQ+vJ/4DadoNFetxyMGsyVt6S5oS/0F0FOH3AYFyomYtX/Tli8EGjwgx9BmFrTZgBtSubRwH70R4KDNk+zavXlQ623EXu9l3/wt732lmVQXEvaQNpB/pShAgK0Cu58T4+jun3I+U+83rBX6P9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by VI0PR04MB10735.eurprd04.prod.outlook.com (2603:10a6:800:269::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 11:12:19 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 11:12:19 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	jagan@amarulasolutions.com,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH 2/4] spi: nxp_fspi: Support i.MX8QXP flexspi
Date: Mon, 22 Sep 2025 19:11:41 +0800
Message-Id: <20250922111143.1204915-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250922111143.1204915-1-ye.li@nxp.com>
References: <20250922111143.1204915-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|VI0PR04MB10735:EE_
X-MS-Office365-Filtering-Correlation-Id: 434c2823-ecbe-4d6a-025a-08ddf9c8e50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j1dLcSWuNl7Qj/0TqJ0u6uSs4gl/7q26b5JlaMXOjSurk8sFEbLUBBJ3taRv?=
 =?us-ascii?Q?Sujh3vfHGcJV1EoO5CU4ru7e6lfvLHr0fCZ3UwyF04yDiOxR7hYHjVYB3TG0?=
 =?us-ascii?Q?d3PY9u/CJJH9p8rnyxOCIvR3jyF0y52MamZiqvzCrsczoSWwc7ZCJAWF33/C?=
 =?us-ascii?Q?nBP1gFf+K8sbC01NRFfFbiuo+yLnvnpED5JI37QeMwzewBKL5RRcq9kOfFNr?=
 =?us-ascii?Q?z7r2ADCD+ZisJJG8QBzpttqeTWhu+OciOJcSD2LnX80Zbv8icUWVZrYzE2zy?=
 =?us-ascii?Q?yUUNkxZdZqdQOOsi2Qe2yadLrzGGQygG+CeIJ6mtDyEGyTeKU3O7yEcYUIeP?=
 =?us-ascii?Q?SZdd7Zh1qmjRlTlMeld6g5xUaO9Y5CaalpPtptNIn/XAUwnjnN8osQSSD6lJ?=
 =?us-ascii?Q?LVSyhgLRNm28EfIdEb/XIUwmWUxPfigDZ/jXvwR7eaz1CwUr2BHhKEhhCA5k?=
 =?us-ascii?Q?YUkqDcLD1w4+08UVM5EycYn2Gyq/5gVw8HsGd5KxM4RrpkOQY4/ilU8aYckM?=
 =?us-ascii?Q?MoVhvm2nT6HtPiPr7M9yUNzNA4cLNgm8aaKIiHz7HuLDx0hdUkCCYJUfXAiN?=
 =?us-ascii?Q?GFa6oLLT5EjsIrzQiFs3+DHvukGEWiLB9ZoCwtoTEaZRpjH+gp3QhX0YltK9?=
 =?us-ascii?Q?+if9EM3F7s8gUc7S341k0PDzBQdYgZ6hctJspP2/XBkwTOt1/xhIt+3/pHSe?=
 =?us-ascii?Q?J1hF7Z41tCDSp6t8R++THs1LqFoeuN3U9opxtoclk6JJntBUz9kb+X7GVeAp?=
 =?us-ascii?Q?ryjr/JcIR1IaIgEUTbCYmfrk4IGRNCNYqgRAxpsRMthyughgCn9F5zXQxR6N?=
 =?us-ascii?Q?td+b0Xq04Bs4z26fJhSRZuEepzHgZus6a5gRaTZoyCFL+NbCFaoI4e1vw4fB?=
 =?us-ascii?Q?41CFDPHlSApo6m3zHOljR1z0yyb2CSjpp8MxGkn6dXp/0O6FT2R6Iss0h6/x?=
 =?us-ascii?Q?eCas7bnuOEBWhgme3DFWwVqzYP9xc2DoSVm11EDXtSw7Q+30ODzNePAG5eVd?=
 =?us-ascii?Q?Img3AnwAIiL4rd21LoxhdK0iOMQimiuTHEZq6GmQzbyPbft+Auk/g5bYN3vW?=
 =?us-ascii?Q?+PKwFczRSf+y75E1euvggc1ZOqjzJ8vUQxAy4ucDBmEhrvm1R9DS6yFmp/5Z?=
 =?us-ascii?Q?RrqTWv7B3F0NMpBGYU2CWn1KdyBCjFhgwsRunCxIqOHiR9GDT63gaOgupePF?=
 =?us-ascii?Q?hnf6DICaVSDd/aeizc5+INFmgxLrNU7Gs0xKjM0lJbJUGWIxrMAStVum1coS?=
 =?us-ascii?Q?C48L6urZ8mS57p7mKgZMUmlna7nsyWrmNqRvnWGIiJXVXuRu/caqD2anFJT7?=
 =?us-ascii?Q?Jjxc8/kMAEa03m/gh/EvQEwH08hO0BENjZsXOcX7kf9k0KmeANAug+k1SCjV?=
 =?us-ascii?Q?d20q7lki5AXsupe0xkN7+rJx6zAbeAw7Xhv5YiN4VfAyZzED8lFUDqDwu0+N?=
 =?us-ascii?Q?ixATlVJ6HEWQ/MKhxlBP7CgI22VUS+kVTAsSep84LmaZz0hwYKMHIA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k8dLQIqCvUcfLU3/C7OiR2rYInMDOOLb1ePjHVUTHwDonp7Z4LaO7rMBljsb?=
 =?us-ascii?Q?Q3IFah/7bUUwFclo9VWTcxKViS50nDbiV1g1EScnvyLGn7G+zd327XLES57E?=
 =?us-ascii?Q?E8ZzH4cNwUkdp2J+WMN0Qyq4JdtNGVq/XS6eag+acuegfy0PYBSVIoW14W29?=
 =?us-ascii?Q?oECp+jgP9/CAWpz7YXHfOSzNxfGI4+mPhe5QVM0de0qlat+J6yhJK02rH/sc?=
 =?us-ascii?Q?SVua/1PzlAbs/GAaT/1/d9E+JMUEBsx4nkCpnAj1w9zjWxUFf3SK5xdTdjdP?=
 =?us-ascii?Q?HW4aP5dH6CgT8mp/fuqP0dhbA3goRx9d0i/gyDAjZWsR1V77LCTpvUAAm/Ft?=
 =?us-ascii?Q?vGHESnpd8qiyj4+gTxrq2LBgvQfQuhPqaiLsC+l4n2AGnWsFq5ovcCf8z7dL?=
 =?us-ascii?Q?i9deXmb+ep9JRMVhflj4JA1mNxd29sHdSs/lASg8ozT6jjHD73xz+8D5eN+z?=
 =?us-ascii?Q?TmB7ZY9ciC6QSEmHewYGn6GrSeEer1Dv2LP5QZH8KaD4ZX4ekpBVPdHEhJzf?=
 =?us-ascii?Q?LZ7C6HSnj0typCjjKKDUyUFXEvISan0d/LRLDbp2+ClCkZZnVez6lo4lToMp?=
 =?us-ascii?Q?rB2kvwB2cSaV+1JHFCKtbDTrFPp/uVMxjkVGM/esfXnhWh6HC/FhRLIoXWT2?=
 =?us-ascii?Q?bSy3R9tk4GKlWSj7S3T4zlyWWZltMG+8gBdkblrlljz0qscwhgJizt9+o1xT?=
 =?us-ascii?Q?KqlgfQPXVKigo/Z67Jd4yz7DyxKZKZT+w843bh+u6UaoN0An/v68rQCcyy+J?=
 =?us-ascii?Q?xYEiDV1xJC4aMdVpxW/IvIqUkjyHQQAkkeKMNcc7OahY4ksmPBqGeNQOHf//?=
 =?us-ascii?Q?W/QJDg9dEALBvTVp2WUKB6s3zfLH+BaBJI7Am2PHjy35SRqU8K43gyRJZyip?=
 =?us-ascii?Q?R33LgqKRwZTd5DcuuUnajHmV7yJt4SxxtckxSId7CeEvXm5qJRt9wvFOKXA7?=
 =?us-ascii?Q?lx0uEvg7VZEc4uRAAnh0PyfUPNoWXZNZRb37N4nzsqZ0YAPNlwSSiXtNJJod?=
 =?us-ascii?Q?la3uytMhnPmn35RU6RV6+6Ikd6K/02m1aTK/sC7HFb/mh40NKruKJ2hJBV+p?=
 =?us-ascii?Q?4Y0Wb5b+SAlCJRozuIBXPFKoTq+M7m8oqWZXRlQ3GWT3tp3A2BRuyTk5snvi?=
 =?us-ascii?Q?PHPIcH3u9pYW+hgPniLx4WJ16S4Jzoh2dNYWGrbz/N7o8zKwTXA+tPWHEMIJ?=
 =?us-ascii?Q?N3E0QvKebIEMvWTi8BhOUOaXtFg+kffpvsXxTi0ik8ZzjV84l56/btpBr05t?=
 =?us-ascii?Q?NFQJUisr9klDjPQnhgAv6hB52CZCECX+rTfFdHnkgclG+ueKwA/ZoZkM5EuH?=
 =?us-ascii?Q?v62+PkBq5lF8aLafPFW2lvYLvziQx70b7v0Gc05UKDJpe/VkEZ9jmv1f0zAW?=
 =?us-ascii?Q?P1tBkymTN2B6+oRf2tdj322yMpvuUzM1R4KZScJgZvQanwtXpc+wPh6No9rA?=
 =?us-ascii?Q?vPlbcqOKsYDrc3MsvczEk9VTgm/ZY1ongBmHx/CsvABDHb+Gzz48dhicvwh7?=
 =?us-ascii?Q?8i375fLwRppA3glWkzjVhkR0QIK0zZ07Jy6chNrJoGeB4orsPJhoQo8vJk5Z?=
 =?us-ascii?Q?1VnqvQONcJU/jRcGvu8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434c2823-ecbe-4d6a-025a-08ddf9c8e50d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:12:18.9974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzE54rEU7vikj5jR3bhARiRMJn30Kdy86rUERvdfhjsz1wdyGaomCWI1FNTahPZz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10735
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

Add the compatible string and driver data for i.MX8QXP.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/spi/nxp_fspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 2dac4da44185..2a0c1959f387 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -337,6 +337,15 @@ static struct nxp_fspi_devtype_data imxrt1170_data = {
 	.little_endian = true,
 };
 
+static const struct nxp_fspi_devtype_data imx8qxp_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.lut_num = 32,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	struct udevice *dev;
 	void __iomem *iobase;
@@ -1081,6 +1090,7 @@ static const struct udevice_id nxp_fspi_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (ulong)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (ulong)&imx8mm_data, },
 	{ .compatible = "nxp,imx8mp-fspi", .data = (ulong)&imx8mm_data, },
+	{ .compatible = "nxp,imx8qxp-fspi", .data = (ulong)&imx8qxp_data, },
 	{ .compatible = "nxp,imxrt1170-fspi", .data = (ulong)&imxrt1170_data, },
 	{ }
 };
-- 
2.7.4

