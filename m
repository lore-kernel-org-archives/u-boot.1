Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFD6CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89928838D7;
	Thu, 14 Aug 2025 01:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="S3uOsm/3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 393EF837E2; Thu, 14 Aug 2025 01:43:43 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0DC88383A
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 01:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLrGuOX0mgz+enC2xs7B8hwgR9RuTn/JuYYRf/w5owCZjPaTIiW5yd3YheKcjka5jZR3aQciyV9tECCmVTBv3SoeRPtllr673WdVXAQjefXd1EfWSMcio4Rrz5mKiZnFjyGVSmAepdIV8CF2fXHWPaqiSiNQ+5GCNLBTOur+su0pEUGxN2YWeHwuah2VGEKlGllGrWsexrrG5LfV+P+CyHDiDo0gZINFhpN7UTYaRErWha/B7HnHvprZOgkz+J9XIlkIJHRZOaxJQi8Im3KJhhyFzyz/4kclKku7Bl//Cy+f4el450NlZ3QGPd41a1V8hQx825I7VVjc1HtlknOdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZbaW4lnk4Jg6XtpG7FdZymUfDyEXEbC0uLLD6K7lko=;
 b=xOHu7QFhEt27NftBS8sPUUaw+FFtB/CI3p1VIMvdmId1Qn5N1XmxSkfVeRV5DDH5sTie6K0Db/QugvucFU620XOaP3iXphqAOPb7XMzdYGhAaurZGmQGI6xXJr/dNLgj25wZI0kFzdtkmCDow/KAiVW2itGUcRkcDrCncVJ6gOf6pRqp440BXY29BHUdPHaf0bwaJTeFIhfBQOmaRBUzOghNDWfmYVdDIyqfTUhrMRAWRtFM3ve6b3L7WpUAd5PWNVsToFNsSXbeaQDVLOj7jU1ggsWMgdYe03E96DcG/jrrmaMKjD24pwBW+UsV0wvXdrvZe0P1ZuOPoUjDXVgtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZbaW4lnk4Jg6XtpG7FdZymUfDyEXEbC0uLLD6K7lko=;
 b=S3uOsm/3XBrh3oBdgrIJ/6PQj2mL3DT98vBUWD1jlVRe2InD6qpsAGhtTDIhJV9RaLCmoNf5MhxgeyXgn0HojsygFBBqu8PV2PloYk7npvQDnSRpSIV2C6olHiZr7qWxErWXu0DNWNzGWpIu1lNciPXXJw3XIsIwZopKXB+BPLsQXFrQQ6w7vFW93bLvaA7wmM9NJZBE5nT/mn9RKC+z5rdCw0SDmrSLYiUYEBbghK9fhQs7wJjxf2kx80ZsbBJX1ZJzS9cGW2Apt6Zcni6hrenaMy+ScvgV7MHUUWBR8BEthULLmrRgSpbzBI1KEmqDZ8KUyhBc28//6g6a2aE50g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by FRZPR08MB11021.eurprd08.prod.outlook.com (2603:10a6:d10:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:43:39 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Wed, 13 Aug 2025
 23:43:39 +0000
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
Subject: [PATCH v5 12/21] mtd: spinand: Add support for setting plane select
 bits
Date: Thu, 14 Aug 2025 02:43:05 +0300
Message-ID: <20250813234314.3945708-13-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 8ea8cc09-b4ea-46fa-cb9d-08dddac33a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yaLR15BA5sQvBdV+c8c0PgDtoJFc33TEEbcckmPgwoJq8ZGAfD2PCwPJn0Gz?=
 =?us-ascii?Q?hiTGC+DyUvPrs9BOLrW9KQUChgKuTfuG6c0Z1nyNLxUgPEGP4wL1voBFdsQR?=
 =?us-ascii?Q?jxpGl0OJVWmNX8ZJKzylrLHlgj+jJn2mLQ9r3DR5npkWX3ISbhrXR2h6GCZ+?=
 =?us-ascii?Q?ewVEbo/Eu+kDvtbty50C00W8b2yMVkeyKIi34nrGGjos0Jfy8pkTyIK2Npga?=
 =?us-ascii?Q?D/bHtL31h9wUWNahR1Dp3aSbFrGW/S3HaPM6t8TYTha00gq5Npg3wdbs3Fwq?=
 =?us-ascii?Q?hNQK7BYcvN72hPcSDYmc9neVix0IYNvywB0IEglHDipznIc4Gv8Mzt6TIR35?=
 =?us-ascii?Q?v3zpo+co7JPfvFFqd+XM+OR55APQXhiEvKz/Ev6UhvmBFD0bNa6HqgOHUeLG?=
 =?us-ascii?Q?7P6E6v3jaZ5voz1iLu86RtzocwbTEOlJMcxsq44ZMxMxVgs8wAeNgIbG3g8D?=
 =?us-ascii?Q?SIjSZdf0bUizD2MSjaehOjN234wSEGfAY0aWlYXisD3axe1aHYeDn4/Adznu?=
 =?us-ascii?Q?4gYBk0n5CINGQxxgxNmwJpF06ikgG2TTc6yEtmD5C0ouFtb8KSJSH4gls87+?=
 =?us-ascii?Q?fCPhuspLkwxucnYVJbtrLSxMftttvOUn7bmitKwlbsxOQFz4ER8vjF+2jXgU?=
 =?us-ascii?Q?irWqQmvWOrxvE1XitZVVXG/Up/MQBXieZcD5vOjI6blubR9ZPNeg1ZHHaWXq?=
 =?us-ascii?Q?RFK/SiVg2VahjGEk06AI8Ty6u4qz6pqpNbXbkMp7dTON5yrox0L5VQZTgQZl?=
 =?us-ascii?Q?ctphti5E94BjMnkwdPHHYg4sq+WY65uHg8ZXvp/2ZUwQDzAo+25VqTSpqB5E?=
 =?us-ascii?Q?qnlCpuu11f02xLLUaMchDZeH0ZLgQ6hKjdMQilaDjyA8OhcnsprjFCtUTKfL?=
 =?us-ascii?Q?uSeqbGp73Rd5PDqaO8cccozpsoszcQVTYW6StM6jXlhbvYFe3iQ2AMmYpqXi?=
 =?us-ascii?Q?hh8CJsm1Iq9C2kLLjOF7RCH7JeUTCzaR2MsyB0dK8YaVBzvI9gk3KQXzjea+?=
 =?us-ascii?Q?M/+mHTg1lYTzOxvu9Oi7EMHuHaJGGABXJ0sAfQ65V1FgWQ6EdbEHPY9ObI0L?=
 =?us-ascii?Q?OIKaZbAbPeTdhcT8iyWxFPtkLdEXLn2OeIHdvG6SEIMIrxCX3MAGTLfn1i3m?=
 =?us-ascii?Q?LpAn13OZjs1Ly1S8xOTT17n7x06o0kAvzkXAXGI34PiiovuwtFlnHwpCtvQJ?=
 =?us-ascii?Q?UZ2DlWxTpn6O4AYMM5d6wvkdGqzZvNI9PtAFXNuIIyP1bi56vyzvs1EA5AY1?=
 =?us-ascii?Q?DHcNzz1CrTg/T00WxfpkHSHpw6+aea67cIscv/Fyqt8oUHPB5azNoPc7Jgmq?=
 =?us-ascii?Q?+Jc5Of0gmva6ywSmrtuANuIF6oPoA5zcOugbNMbW+InzKQXi8SHju6vOlHKy?=
 =?us-ascii?Q?9sr/l4CC3o7mdH6ijv7c/PP9IPWsZZb/42vrMULCVD8NBSV0cfz1KhLzPhoQ?=
 =?us-ascii?Q?/KMSXC5H4QEuSRshj+Bt6jV18CNjISKwl9/u9ejrBECcUwM655dFhMmgkzKN?=
 =?us-ascii?Q?NozVA1vtm1pGXnE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JLvaJ5B6mXY1HigMLSEi7e9K2moG+Kc47wK5IpMUrKwyV8/jW4ZMQbYpAnrS?=
 =?us-ascii?Q?qiNrdhz8z96gpP9odt1RjKlzQUfEAQHmmJuNJj4NNBpgdn9pprQ50TwZgRc3?=
 =?us-ascii?Q?5ceLcDwqJvftyOUdd86hhhNtOPQG0irEFVCyq9K41zqdtz7iS2Z0NK0LVaXV?=
 =?us-ascii?Q?0E++FwII/Nt1J7rfrqWb1mfuJtYjqobh+KIlDngAiEwEM/khR2o+e2v9e/0d?=
 =?us-ascii?Q?x84SGm2P/RIbA9HaPDT+uVrAigcCCJvuhK4cLAPjPfpf3TOeqpcycEuysKnk?=
 =?us-ascii?Q?ldfGGkj3KxsWpmniTDwCj7ywwiDkREL/Hx42NVJYz8i2yc+6x4ZpiyX0qsMK?=
 =?us-ascii?Q?kQS8pc+dVacAKRIOsF296mgIhjFpzIK3lV+6sN+PWf4ZzF3UfMSMPpRESeXI?=
 =?us-ascii?Q?4FT5nY0LQeZLObGdea0ew0k1+Wt34yw2QEVlMhjUgPOXxMxcLmk6sYSVfEjL?=
 =?us-ascii?Q?W5hP+u7NJWOWkD1WBdSvqFofKEgOFwkN3/ymOYVUiMAFqlgvLTj/NaIWKyMY?=
 =?us-ascii?Q?OUMHU3JKAr6HEel2neZ7gFZtW7XZp3K5RSlRmHprtRp3haEj82cPRG+1oJk4?=
 =?us-ascii?Q?FFR9apIxyV+c/ObHM8vN8DM2eRPNkotK7TlVOib9IAsVcOVsq3IA8wQN3xhd?=
 =?us-ascii?Q?Ep+tc8vxjXkEcF7LqILH5+71SXDPpWWSrenSnEDJNqya1i2hIg2vK+oY8N7Y?=
 =?us-ascii?Q?4BHEMJSFq+tuqAE8opTCEYOD8RXn+uiS/8aWrG6xUCaoI7PGQkOzEJuR6VMx?=
 =?us-ascii?Q?zOtfqFZCST5yCV8YYsp51DtIgOa7W6TspBch3VItwWhGrsGQwoDQN1ogwmo9?=
 =?us-ascii?Q?6nSKt3ZFSDL1IjfymhlE+2uuZI95MLvFOf4aF3qcI5zamew+Dbd34dmZAQSG?=
 =?us-ascii?Q?nxIYKe5LtCtz/bokrSXW3s0Gb+195L5IqQufqtMijTxBUT7I/jk46OQDWDTM?=
 =?us-ascii?Q?CdYs1VaHD+HLZRbnc8s6SQLWLTXvNXa8U97UYp/YUqRjPhclIPnCHwhgPeAD?=
 =?us-ascii?Q?Frp4lXSvBq6uga5/F4KHA8ULU6jnYGgmp7Kh+ssC2FTaFGK2h7cvhLPAX/Hj?=
 =?us-ascii?Q?lGVmft3M8cfN0s2IEsRAI3qtAClgBCPSZAl60qj7IXsQoVfD3EpdVQOfac+K?=
 =?us-ascii?Q?4do3ligP4ElaKNJeBo1D3rgahBkKEtzft9OBDfOJ7irpaO08CGOyISVImMnM?=
 =?us-ascii?Q?XGKF4hfY+qJYJUOn9fV+CAbsfHX2Ri1ZaEHkr78CpahEGh4knTUb7jvLhMaN?=
 =?us-ascii?Q?CRtqSXW3i9+86ydqJZ+z9yY7quXYgMwE67aCMpM6SiwMBQ2heM0aAlu1b2x9?=
 =?us-ascii?Q?+MWOBJwX/vSQKiI0ncQQII4gXB5vs3aniU2Kx9MDFj8na7IDGvI4R8r4IwMR?=
 =?us-ascii?Q?6kffIGpdIDWUdA10RufJ3/xbbpUcFI3dUTRP3rTyVJcENQazvvCtDczODSBD?=
 =?us-ascii?Q?GwkBxNdFJCwmA2SzKKnm+dJDk4F9xyoOwOGO/nkGVWNQav3Jta/C9uSX01ml?=
 =?us-ascii?Q?eNuX/AfeM7e1bX4/rM5Dbo6WpGAKnkoIj0EW8UqAQT36787e3JE4F9Hr6I9k?=
 =?us-ascii?Q?muGRWbphf+bPbdx7GIsyqdtfCt20CJDJ7fLGm27V1gnXCzbrVTJrUQ8BvHUZ?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea8cc09-b4ea-46fa-cb9d-08dddac33a8d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:43:39.4565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po7epZzS1uZsJG148QYfOwyosw2TY+XtLADEDTiJAZsv0yxptIND1mwFMY194JNdGzM6A8POb1zK+S9O9uuH0Bzzm06zrYCUSqlgsTfg6EM=
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

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add two flags for inserting the Plane Select bit into the column
address during the write_to_cache and the read_from_cache operation.

Add the SPINAND_HAS_PROG_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the write_to_cache operation.

Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
that require inserting the Plane Select bit into the column address
during the read_from_cache operation.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240909092643.2434479-2-linchengming884@gmail.com

This is a port of linux commit
ca229bdbef29 (mtd: spinand: Add support for setting plane select bits)

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 6 ++++++
 include/linux/mtd/spinand.h | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2a2ab664c2c..2083e3673cc 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -382,6 +382,9 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
 	else
 		rdesc = spinand->dirmaps[req->pos.plane].rdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
 		if (ret < 0)
@@ -456,6 +459,9 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
 	else
 		wdesc = spinand->dirmaps[req->pos.plane].wdesc_ecc;
 
+	if (spinand->flags & SPINAND_HAS_PROG_PLANE_SELECT_BIT)
+		column |= req->pos.plane << fls(nanddev_page_size(nand));
+
 	while (nbytes) {
 		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
 		if (ret < 0)
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 011861dd059..fb3a2e5d909 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -316,8 +316,10 @@ struct spinand_ecc_info {
 	const struct mtd_ooblayout_ops *ooblayout;
 };
 
-#define SPINAND_HAS_QE_BIT		BIT(0)
-#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_QE_BIT			BIT(0)
+#define SPINAND_HAS_CR_FEAT_BIT			BIT(1)
+#define SPINAND_HAS_PROG_PLANE_SELECT_BIT	BIT(2)
+#define SPINAND_HAS_READ_PLANE_SELECT_BIT	BIT(3)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.50.1

