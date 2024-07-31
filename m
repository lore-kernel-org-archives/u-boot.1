Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9CCC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 08:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A4E889B7;
	Wed, 31 Jul 2024 10:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="xqAvwvOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1795B889B7; Wed, 31 Jul 2024 10:28:55 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A101884A7
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGUQgXNkkActGj8HIRQpymYWhwvZ6FctPhX239cP5tDl7VM+vs08jC4DkS6fTVwIQ3ayUnDBju8jDgR4Z50QgFnRv5lFuoSwyONBesmB3U2mP7u/hkrB3MwoW72bnSR+U8lYfWaYsVH4pIrAo7xLkE7dYRdLVtCpHslBQG+jUJhrQRz1FZ5hzm+vDtT44djMQsNxBDzjKRa977lfgGgM1LoPCs0LdEY1FRh/U93tv6kMxBSik8fzs+ZeTAq9qvJuKhQSWP/GSaMRw2tspHF4jsUEWaD2a8J3wtnNDM+Z/fnkbV4otbiOg0ke1e1wyizYfk9rfoavrfFqtpn1krQmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xNL8019Ajyoc/IIPSFlTCXVqzixRplRiCDmLHGTfSQ=;
 b=JtlTqmS44Ka0dXrTIpccguP2w6YOf5PabGlb99pabLaWzz4ZOqYJpW9nNoNUhGrDRXN0bBcgRsnETjILizygtFC32lWV9c9vIOW7c1ksZDu55AQxMnu40kA/rjQsx2Lx/hyGwnaYN3hOoX7VRdXpO90p93s9pmjURSBf2ivC+DpfWCPj2Ki0ASuxlIPGInZFlh5xh1mF6VrfC21WVTUUug74n/Ka2ocA7q3CPASgohsZuZaY1USKHXIVbaEAR+HzH6HvOBiUjd/Y2UH5UgC2f8MLBFRM720HMqQFSgV5A/hrr0J0LGLbzUNmJHpj+AIgT8H+HiTVSautZJC6bdxecg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xNL8019Ajyoc/IIPSFlTCXVqzixRplRiCDmLHGTfSQ=;
 b=xqAvwvOMd5Hez5h92Nj/BxUzJIxcKqi6IMQalLlVV+9duxhzxbEdESCBajpCvnZ4RsB7/U2hmk+b3K8AD9AFiDoD9SufpXz1q/7Y3dC4PnBlVMKJ1ggueL2wLqYYaLZ1MLn27iJ+u2guzz8B/tNs1zRNIXqXPyMpxtnK/7518T+RMn8oySTj8CbcsigbSOAPaQL0btwHtY+TEj1ES4tGVjdIYGex+6PzdEunuHVkBuUocjLMB9RreWkL8nX52aS12tiu8ijzCRbiIFX0oSzzZIpGeAf5LMHOhvkA6Xodhj25o3kPhF2V0WCu7Inl+vtesnsqJNPl6A2SVTXSg0rIYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7827.eurprd08.prod.outlook.com (2603:10a6:150:5b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 08:28:51 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 08:28:51 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Bruce Suen <bruce_suen@163.com>, Igor Prusov <ivprusov@salutedevices.com>,
 Dmitry Rokosov <ddrokosov@sberdevices.ru>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 06/10] mtd: spinand: replace enable_ecc variable with
 disable_ecc and update corresponding logic
Date: Wed, 31 Jul 2024 12:28:20 +0400
Message-Id: <20240731082824.3890809-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240731082824.3890809-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:348::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 641d3a06-2ece-45fe-173a-08dcb13ace7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aaxLYia4NcMUCDB9H22g8hmJo8JwTnNNV4Vy3HQP4mGpjG86CI/ac2TXSGhj?=
 =?us-ascii?Q?i73Ql5netLIpEAKu1IAP9K+rhYgOXqB6vwyzgzCuOMEF0Jw9vsNljBuq5+0S?=
 =?us-ascii?Q?LFkor4rnCeyqUHC3jRWu9ZakICCIw9B/s4Wus3jAojfjOAIZ/28UrZlhbqcx?=
 =?us-ascii?Q?ACBJocZ1RzAn0LfNxvMdM/NcD2bcAtOUzzsSmIpQdRcwOUDEOYy/jQ15uEYP?=
 =?us-ascii?Q?KHJjk9Qp0cqSSO6quvECU5Wbm1ZLBaUD//BqpXOPpSx59dU4tURmt0iqRPVQ?=
 =?us-ascii?Q?pFbiQfYqvvBA/IOm0jTXqocFrgfarUsmFEHpAdpvqpYVAylF8uFux+dUDB7m?=
 =?us-ascii?Q?TkpllK5XMO2nMRZS+35OJBIhf2DkLw5eGjdnUW0/6QPl1Zhq9NkSvg4ykalr?=
 =?us-ascii?Q?vXn/2plwO2gblNhO6aqNNfXa7SV70umPDNIh0PIV6trRqjg7ZBNqoD5KZOMX?=
 =?us-ascii?Q?5r1IpbtGQwZzsmJ/bNP4B8uQLSjHizhWUtfIzkRhCNtau0vJXJJZtmTUGnAg?=
 =?us-ascii?Q?p+UO+kHzKuF/o+dh2HOnYRQcCABS0L5qSkCSC5jeqR5iN6ho4WOEN8F00e+L?=
 =?us-ascii?Q?dJyIE7Ko0m8eHSVGq3pUFtqdXRml6Vu20NbNdF00QgjDzKx4xbsPaZm4xhvE?=
 =?us-ascii?Q?nCGTfF6gF7/vW3vtRd6OJYdoM1jpUcNhEDGxfHL9/AiIHIL/afdkA54hXpRU?=
 =?us-ascii?Q?oIsN+k8QmOVIc0rOFchETGPGtfh11DqGmDG9N7oOrP3MfIXYYpN5UsnHuCiE?=
 =?us-ascii?Q?o200YN4E8WWDDGQSG81n0YtKlhUAKpD1/B5dYRHgJnMLdHIzPpq5WpVIn923?=
 =?us-ascii?Q?sKXXn2JeYF34l+S4YYwxSNugIBCvzTMmdottZ6yI8FYapHW52b5E/uD53yxI?=
 =?us-ascii?Q?ZfnK1yh0HsaKcM+c7d1FfZqz17UKHVLvUGAeSL+9NenSXdSKLmyefFUR22aM?=
 =?us-ascii?Q?BQO9fOHs/Oj4L8g/8K2KnOYXBrvrPEYpMyM6yqaOqKu5eehKU1a3EfnhWwFk?=
 =?us-ascii?Q?t9FvEAY5XsoeNERRev4Yd5qbB4SW5UqyjMIO4akbaiwpu9Pg84XCUahm0gYw?=
 =?us-ascii?Q?+8gtsw7OVukNfFA1RZYRA/ljcR1QL7MbSi1qC0oAQrqbBQDzJNdiX/boc0tF?=
 =?us-ascii?Q?DVjIheAajZeef3YZe8askB82oTKe+MhHeDMBgoSP69tqUOJsotvYVrf4NMB8?=
 =?us-ascii?Q?ImjuyeMlXQIy4q1iCYnGmQUXegpxL4VPzzZ1OSlSpumNXxjRRRzhPTAF/d8N?=
 =?us-ascii?Q?VxD6RtLM6K9CV8Elkx2yN8eMfZHmgSW36RybeSnuQCd2rafQMuLHarbWkwMW?=
 =?us-ascii?Q?gOZ9ZPv75sAIHrEkpMQeINAd1PZrFbdBKZpYF/Sya32Ks5pq5sUO2fdOrm8m?=
 =?us-ascii?Q?tVTFO9/8xDNimkTvDnMAVzqCTIB+x3qmh2Iau53fkK5Tw3PNJUhI5L07FZMU?=
 =?us-ascii?Q?4PB2N04F2sQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d0S7t+eVTV3NYY32pdJtCH4CNmLyYhukfASZEOkHcGkQfDC9sC750y3q1Org?=
 =?us-ascii?Q?uFWyyrU/ZwRMrH6LmYbW7GjPatMydqZLV1QGSAyRtixTmLE9QYbKCmG0mB0B?=
 =?us-ascii?Q?VAVwxR+593fzpJkRWnofjpAhPevS0XpoYNgWPR5z5S1+IPPrjChSyLBuSUni?=
 =?us-ascii?Q?/NXaiX4MCVjxQiBdyJYlAyrWPbz3KrQSTZtug4hL6VmNZRBkDXnK0RRxTJif?=
 =?us-ascii?Q?P4GnV0B7zQYfF/wNspcfAYQyd3H3Ey7pJ46luCGoto/5RxXX+XnOjxFPriuS?=
 =?us-ascii?Q?7Y2C/nMqpARiUbbCnovAzlDIPdvhZUKHlrT1NVswkRBXt2JbUpx3rNiN8CGE?=
 =?us-ascii?Q?NwJG/M1E6sFCi3zDdDfgJhegY6eTtL8SN26w09/pa9iF2q3ypqPMsKQNVrL6?=
 =?us-ascii?Q?vG6s4q5pMokpJ/CSfagCJHJrBjakoecEql3STz+b0xR8F05miSodlMZTVYib?=
 =?us-ascii?Q?cg3A1aLzpNBJGqkY/C9X6gtVCglKcw8a+fFacvO2p9CluLCcLBL+n45Uamyx?=
 =?us-ascii?Q?JN1+Bb8uZ+HE38YzDmfVrKZj6As8HOkjgErSjP4q494Cd/dtyMkqldLKiE1s?=
 =?us-ascii?Q?XDgFj5DbT+2Cc3Vj03W/x1l4U0r4Di+BfbmgYOAC/9iX6wHbCjehBBZTyGV5?=
 =?us-ascii?Q?WxGG79HzniubmEluazw3ZJvZzldL+HfCPUWsVdhydbYAMb2zwxd/sfRHoywf?=
 =?us-ascii?Q?Vums/l7jCbyyE6u9d8E6N6oXX2TqkroNvGNTRW1iN8laKYMREQ9W8lg11Rkc?=
 =?us-ascii?Q?SFTVaWSRXwHc/jS2HyjaAu1DXauT6kBag7aOb+CGaHE4Cyd6HZJuRT2sGd1a?=
 =?us-ascii?Q?9vt0ZBJJEoy967DgE8NjkFMA9ljOrynRSG1OPRBoUduxrcWy8NBmje8Q3wkd?=
 =?us-ascii?Q?KGIdQZMB5MdtTgor+6W+7si7JEgz4JvgJrHjfILzXdyu8BQTElegEqa40cAg?=
 =?us-ascii?Q?3tFAdLtT+3ML3BMNqlQrQBnDhAaOmnhU5EMZl08V8MHM6NKurLm8Se1ljIqr?=
 =?us-ascii?Q?WKQ/sg3+otpZt+MSKl4+JTa+F/6dECsUKF0V7WmJh7F0tt0tptlR9Gh+2qIz?=
 =?us-ascii?Q?5ee13zJ9EoX6feOBM8ESeEPOQArGLQJhFTTIxTt7oXKPq4vZ8CJTcPQGFwO+?=
 =?us-ascii?Q?wOjUwS0Qv+cRs6nriwh3JZVQ60ThX4z2LNPDfKDCBtgIzCTYC34Nn4ZJ7k29?=
 =?us-ascii?Q?5nxEHL7TrUNkkMtVy+uw1PeACQ0w66TptlHWiUcIyZfOTeDcwilgmoAnbHnI?=
 =?us-ascii?Q?1/3gDBYKFaHDJ4SilYIYwlb+jDltQaO7LgOct11nS1Ik4pLrYFMrOtcaL1FP?=
 =?us-ascii?Q?ty/V25L+SOH0mBNt8Gz7hPvFBtBHS8bNqQCg1+T2SPeDYkAvFyaJNQgoJx9c?=
 =?us-ascii?Q?KMXZGhbWFKTDwI6K7ZKHVW2pXib3kLKp5qN0S16neQVQa8fNNsv5v3nL9vLB?=
 =?us-ascii?Q?CBInw5ngJrEnrGfa3lnp/1vFBxJ2Pko/KY64+Od6KFdsEmbKjhb2zbHDu4vp?=
 =?us-ascii?Q?WpRBcSg5w2j3v1i63sPm795zMpsk96cetQarttqsT7hjPA3wWvsXuI7ILCMl?=
 =?us-ascii?Q?HQE1tHwPMdl2xPEnRz05JLPqrS3rB73rutUw3SJTZ/+t7B3z9pw4wtFjL6h6?=
 =?us-ascii?Q?0tDnQn9Bp2GLRoRP4pilQv8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 641d3a06-2ece-45fe-173a-08dcb13ace7d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:28:51.2191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ6RcOAydtdQMLIjSgdbcdXEM43VoMtM1jU+n+nfhb8JZokemUUI4tLjng8tht9mD3tn/2WtGuak6uSK6/+J7qlaDHz5MD0yF0SCN8kupEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7827
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

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b8e2849832f..8d5c07e6966 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -525,12 +525,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -538,15 +538,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -578,11 +581,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -590,11 +593,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-- 
2.39.2

