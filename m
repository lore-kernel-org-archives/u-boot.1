Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EF4C83F17
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 02:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2369683608;
	Thu, 24 Jul 2025 04:56:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OYnBvWt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0835183608; Thu, 24 Jul 2025 04:56:44 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00050835C1
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 04:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHbFysJkwtQyTzSbcTtOAqO7TLYF0R4UgYx87/aTgT6cSWDu/AkoAdjn2IG3HL2jT4KNtC+7xHYpqwLQUpxkWAQ1O7Pe56I/w+bD1ng7yqUWdYNerREBTH+M4ymjKRVgbkN8PZqwuRsl20OfOahGC6l/14Jc0R2EQqKh8gBI742vl6bBBZGX0mpA+ppd44ht7sFIcD4xYBz4mvyAkd/I6CiMvOYY6vE5JrXXt0ajrT0BSlFj8Ke6i6fpMpZhJQz9rgHJ+5jzuBTrqETw5s3iq4IiEmD4iS3yUTu1SJcEE+hjOQ9hx4jOJrJyoLCRrbTMrr/LO7GJGYM0liOdHmVzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP1TIV7s21b2pvo7V0kccFpcgdt4+9fVzqSoG0CT8fc=;
 b=AfTmFJAK0MNb+bKTkbADG0jEhtSHzN45QbHkUIFdHMbuN5DetxwR5h8pziQVfKRS3PpZfeTSZ8GqwRqADIBbgdUu7qGJkToAP78HGUSPVcogsMBxy13LpxH7dmlwgUpPCZ4JpQYpN1G04JHTsG+dpFVVyYlxSweGaLKAPO1lh1ri47LQaB18pUDk27Hi9DDiUnntmPqKl5T+T03I+zNgY/n/a5YUDGuDJ43tzM0jjT/47XWxBYkI6TJ+lrgC756IqFscLnk0JRkjH+A35/uVuvaWf42wEDmhwtFSeM71z+aVOYBIl4rOykO0r/cfO9CEaI1u8Dbo+zwGTilDH+RxfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP1TIV7s21b2pvo7V0kccFpcgdt4+9fVzqSoG0CT8fc=;
 b=OYnBvWt0peVuRsLeF+w4MjIzY7gUOiMII3qHnIC7NfKRQHY0gMu5G1cR4LzrX/8IZl4Bb/XEPQO1RalkUQ9oCDRpt+Gjxu+1vuZYb8fi07t0aQ5fHRgARFBt1JI6xzP/t+0GwaAypD2A4bG/1aXfR98ktaN0ZfCFkusKnxAMflUAl8OBmPglyOip4dICsFK8p0O1uHILCV1DnFTpeU+NtNsbFXEidQs/usRe9qe04MJ9WdDQmhgDuH6wxNAtL7/Sz0K8UaQa+0NLv25N3qzg6vRwP8bTYyMf0YHWWRxoY8nnphe22dKz6dTBUuT45f/HHXXSvFV+popb+D3NcpvZKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8735.eurprd04.prod.outlook.com (2603:10a6:102:21f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 02:56:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 02:56:37 +0000
Date: Thu, 24 Jul 2025 12:07:01 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>
Cc: u-boot@lists.denx.de, Iulian Banaga <iulianeugen.banaga@mobileye.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] Fix emmc error state after mmc write timeout
Message-ID: <20250724040701.GI18395@nxa18884-linux.ap.freescale.net>
References: <20250721123513.1105662-1-jimmy.wesolowski@mobileye.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721123513.1105662-1-jimmy.wesolowski@mobileye.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 80009e68-052b-4d88-9c18-08ddca5daf1b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a/bczygblGrUM2iAcU/cMcszuG+G6Qzwf+uzYqIwQlZE0N3WbRecYoQhSU8M?=
 =?us-ascii?Q?c9zYX2TK6RcqSfdNJDPGD09q7G8dtuomu9bU0wgkVPvRE/MprNGmW1he2KYx?=
 =?us-ascii?Q?NDGw6xoXj8azIp9uaO63symXw2QRnUxeboEfg2dxkGYCogbfVFevl8fMNgmX?=
 =?us-ascii?Q?x7v16BkIpC3Umf1wx23DI6uOeTZBdJXH0i8tTvx416+FFXbauJWfxzCeSejz?=
 =?us-ascii?Q?zpZeqecRbTc+Q8KOPQGVSu5OqHmbV4IzivVc87rvR6OSMTOlISrvVl2Kgy2/?=
 =?us-ascii?Q?YwarGAaHQtH2V8Vg0veQyiSib7MDkfnoEVJnTIYPeTEyMoSOxL8sceZk2dMK?=
 =?us-ascii?Q?AgprhF6vdEWg8pVWjeROR3PIyoiHvYip5khvNdolCo/8B2KuYDemCsxQ/JP/?=
 =?us-ascii?Q?WHRv6y8ku7IRlkME6QTqBHJz1rcpwTlDtKczmZrUrQa3g9UdvVVvIcRfLbWe?=
 =?us-ascii?Q?2jqcjCdwKhGTg7Ge+oSwDKBfrZHTx187cHr54f8lEnmh9CW3fOXl7C5KQtQV?=
 =?us-ascii?Q?/vxtNeS8HcSDnPdry2Z+/gyCNoMuPy0h7QvU/RbUGMORTS59VS9Pom/UPKCS?=
 =?us-ascii?Q?+I0QPujkngOHVmFnn7iAfflIK1jV+GhHl9fZl2Bi5zq7EW4GTFqB2+3oKlGf?=
 =?us-ascii?Q?bI5H2sp6aqa/8G+SuhfXN5Eh2B/Wodj/QiKRcqSjTqAyehRTNO8+rvKoFGks?=
 =?us-ascii?Q?hFrnzyEK9nICqWeCVcetTPnwZ1goniiyw8FvWBDc/M9nlpQzRvXfyctQz+Cb?=
 =?us-ascii?Q?n85BYI1lxRvSdPA6GprjruyXmL+rFc5g5zHzEmwwkfFr7n0NNVxrqF4CRMqS?=
 =?us-ascii?Q?PpekkXiT7BnOqB6GR6q8k5n3RimjOkd3I3x2k8AzJTGBjfX9fN4aAPobc32X?=
 =?us-ascii?Q?xgerE+waTjBi6TEJENP61sH8IBWI5GoQg+MvBUdH7GAWfXFOLEt1tSbrklK9?=
 =?us-ascii?Q?LRquAxAO9w7IeI3NDuHeYiK6TcaNEosKjGkzkA2oD9NaDSEua9Q7yLKxmvtu?=
 =?us-ascii?Q?h2rR53/jzmmI0P3uX3uE9hZ5vP5BHFAM3gktMiZUv4LNM3LPDAxO+x0Wlgah?=
 =?us-ascii?Q?igwywZJ2n7xayKp/xxoKiyhExgQLChvsvICiz+EktDv4xjr4di7BGC6CXaZN?=
 =?us-ascii?Q?o6haJWSDim58jB97LqsmIiqva1Wwe/soNH+NGTCP5vF4m5S5WCJ73gbkX51u?=
 =?us-ascii?Q?n7ss/3d+hxPzkXL3uLdgZZ83uDQZi9J7hAPsNbv7tiGTxMCdXQlQpgBlI/lZ?=
 =?us-ascii?Q?mr4JTJvlMuqKKhp1G/SFbr6ezqFKSg0nE8ebYvoRvlBVGXU8rJ92roN5ts/8?=
 =?us-ascii?Q?Ry9H/rwJk62aaxPiIvDTmc05tgOYJxeMi+SuK9NTfErGamVLxCVvBNZ91LE8?=
 =?us-ascii?Q?R6FRYSRa4ooinrN7X4j56CGbAbre+qbFiK3TYmh6lkBVmU10CEa0XQMPA8kB?=
 =?us-ascii?Q?t0MWjRNJpEG5hwAyQ1nndCaD8gb8XQvgYtJnSeeIHjJ1WnjQnLV8Bg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nckxxeUHxmnMPsLFNvUF7Yi+4tQerFB+6Thx0L/5QycTz9IRiJZdCec64FGG?=
 =?us-ascii?Q?AYBkcpVT2fhO5NXy+3Yt3g6qLsDuXXA/y2Ck7p6vISSvhNkqGvrPhWXfIPqY?=
 =?us-ascii?Q?vFG4qVBUETlUWaQqtY4Gj71NalyklILlHR2yjBa4Lf1Fum6sP4dzudK/AxxJ?=
 =?us-ascii?Q?7/h5HJEaCi8GQgxNibivX8J2jxj8XjMTrTUhqgQ8onJeJzacPW23qMZzAeUK?=
 =?us-ascii?Q?L+BDkGHAH7pmkFRAYa78sMRp5w3xFmjOAXHd+IE1XX6aZlhqbwRrkUnhYpyH?=
 =?us-ascii?Q?JcaUh/aPKb7vz9MjlgH4CtLAG2UOnE1zvxjo0Jjt3dcxpCnrAcXpLz+Ffhzx?=
 =?us-ascii?Q?PwMk4qc8WrHQou77dHb+gxVJT/vt1ClNDTPQPsKuLV3/a/pGp6gp5Iiviv9l?=
 =?us-ascii?Q?n28WVnG4NGIqe9Zk2PgDPcJ1/TeplSsccJB3cypYxvrRcLCATtEhPPHfzOwb?=
 =?us-ascii?Q?8utJL3+GVqcQRe4lVk9n4HkIOr5Iyg7GqUtl+O1a3ueixz2bg7u7HOEnxZPC?=
 =?us-ascii?Q?qx1+phyeDKLn6VLQnSrhrL+PtQ9Dk159GLJXd5RDypOX6HaP4WYXrL1GIsjV?=
 =?us-ascii?Q?Ajs94QjCITB6bGaPR+prO5LrHrkbHHLJmrmUZbMF459FHL5uJyU/XfEpNRQr?=
 =?us-ascii?Q?66apCQIz2yFxGZvNHv+ZF4GK5g6JaxzyRt7MnHuBKBM9hzcTNzHi0mKs5oIO?=
 =?us-ascii?Q?Pw7y6fm+YFGL0B6XpL9qhlGFTlv/IRRXDeQHMZcAFoTUzHqvNvBGu46EHvH8?=
 =?us-ascii?Q?HJrAIeAz4b2I+M32PxkDodwItPIBoyh1T0366y0zLlJMizLvy0KWP2r8l822?=
 =?us-ascii?Q?iVjvs+8hX/JNusJXT1NsNMjE0Pka7JjPnh1zcC1Nvo38mEQ3fFeZjwcURjyf?=
 =?us-ascii?Q?cjugq1e4hEeNDtUQvqkArR5d9RLZTqZqzTkMmaPDLaCqzgf+actj/Le0TrKt?=
 =?us-ascii?Q?qiZYqaBZMzoU6D7qH0gRwVQoV2+oPNnmTJkawhRDPdTnEF1UQpX5Ju23E94R?=
 =?us-ascii?Q?JagkUIeO2rBJUxa2LbF5LDsGvRzmfVFb8geq4vfX+sqbMsf8nXOFj/x2QWVb?=
 =?us-ascii?Q?ctg/nehwV2gx7Mdn4UQYzIHC8nCtPsRp6rJGewetlfQw0c9nEisOZNZfwfSu?=
 =?us-ascii?Q?88p3CSTo8MzJOwiRe3baEIKoxmcCFt7gWuRo+j9c/0seJ32xhGaFGt7HJLQZ?=
 =?us-ascii?Q?4NmJsuZXqKIbHpD178GjLV+RJcZn29z0GGn2cjj7EjI6igU3oMhIBHN6sh1+?=
 =?us-ascii?Q?5UH3+UAxt09EXazkeRyStsiAQ2F76DuPdIeZcKQRPJ9OPnpzpGgwnf0yB9A2?=
 =?us-ascii?Q?s6PfiMBBx85/41VwwaDQUc73ZcQZaz8SxCtCo4xDPeaMISHPou+9aOAIsmRC?=
 =?us-ascii?Q?u4rtwJdp+Q7lExNcdfImcnAT80/nFnZrJZ8kEjwM6HNOleR+RTbIbYom11I+?=
 =?us-ascii?Q?k4Yv7OShgPrZaYbM97lcB5VLEvFWbrfH5rfPOQFHiL0UWUZ9JjYEoVUg1NpW?=
 =?us-ascii?Q?1r0JDyP1PG1KgSG22thqg72hoBiUtwgBwYLANc7H7NfChoCBRCJngs3QMlSY?=
 =?us-ascii?Q?6InTpkn8ftD2vgBwEzxEJWJiH7hSkzsozximAqUN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80009e68-052b-4d88-9c18-08ddca5daf1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 02:56:37.8217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx/8Q4x/+6UDzPKfnwwmyXED1JHqyUdtiX+CRGldiy8+ZZnKc7PcMHfujJh5hTYja5bJNcSyx1WPAgpENjJsXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8735
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

On Mon, Jul 21, 2025 at 03:35:00PM +0300, Jimmy Durand Wesolowski wrote:
>From: Iulian Banaga <iulianeugen.banaga@mobileye.com>
>
>This is a fix for the sporadic mmc write failure:
>  mmc write failed
>  0 blocks written: ERROR
>
>After this happens the emmc will remain in an error state
>where subsequent read/writes fail with a timeout.
>
>The mmc driver sends CMD25 - WRITE_MULTIPLE_BLOCK which
>can sporadically timeout. When this happens, the mmc driver
>aborts the transfer and returns the above error messages.
>
>But the emmc still remains in data transfer mode, since
>the timeout was decided by uboot, not by the emmc.
>
>Fix this by sending the STOP_TRANSMISSION command (CMD12)
>and waiting for the emmc to be in ready state again (CMD13).
>
>Transferring data blocks after a CMD25 can take anywhere
>between 5 and +15s on Samsung EMMCs and the current timeout
>is not enough. Increase the timeout by 2x to accommodate the
>long transfer times observed.
>
>Signed-off-by: Iulian Banaga <iulianeugen.banaga@mobileye.com>
>Acked-by: Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>
>---
>
> drivers/mmc/mmc_write.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/mmc/mmc_write.c b/drivers/mmc/mmc_write.c
>index 90fcf2679bb..37a42887cab 100644
>--- a/drivers/mmc/mmc_write.c
>+++ b/drivers/mmc/mmc_write.c
>@@ -155,6 +155,7 @@ static ulong mmc_write_blocks(struct mmc *mmc, lbaint_t start,
> 	struct mmc_cmd cmd;
> 	struct mmc_data data;
> 	int timeout_ms = 1000;
>+	int err;
> 
> 	if ((start + blkcnt) > mmc_get_blk_desc(mmc)->lba) {
> 		printf("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
>@@ -181,9 +182,11 @@ static ulong mmc_write_blocks(struct mmc *mmc, lbaint_t start,
> 	data.blocksize = mmc->write_bl_len;
> 	data.flags = MMC_DATA_WRITE;
> 
>-	if (mmc_send_cmd(mmc, &cmd, &data)) {
>+	err = mmc_send_cmd(mmc, &cmd, &data);
>+	if (err) {
> 		printf("mmc write failed\n");
>-		return 0;
>+		// do not return 0 here since the emmc will still be in data
>+		// transfer mode continue to send the STOP_TRANSMISSION command
> 	}
> 
> 	/* SPI multiblock writes terminate using a special
>@@ -203,6 +206,9 @@ static ulong mmc_write_blocks(struct mmc *mmc, lbaint_t start,
> 	if (mmc_poll_for_busy(mmc, timeout_ms))
> 		return 0;
> 
>+	if (err)
>+		return 0;
>+
> 	return blkcnt;
> }

I would keep the comments aligned with others. I will update when apply
the patch.

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng
