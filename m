Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D02C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 11:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4699083281;
	Tue, 22 Jul 2025 13:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="5gBH+Oyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D7983873; Tue, 22 Jul 2025 13:42:04 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2EF482E26
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 13:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUwtgGZdvReHTlYZ291Tx//GZc8IfzunV7O5oTX0fKIKUjT6bIvRXY2r8d6kjVkEAxKsKYEgvPORuHMXRXoFYns58QJZKKPAPBgj3zKtJMXXct/FMhdLtwQyS16TmI1qGOkFcG/kEUi1aiiShzGLr7uPGEzNLy8Gut486rLlD/Smhz9IJDbMmk7EDYLT8NzV6D075ZNIu2jLaU6RRa6DHWbRkpp8r2EqE1ojRW6BK9nbQS9ofYhxyHFnUwNhqKYQlm1Lt+DRyR1ikeUcaHPvQUxXZ9LZHxau5ziSupP+wLXKjhRDySyeIz2WwY2YmXSYdlGYT17CgdH9aUN3OImuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWftgK8agPsp65LB1cYVcOkYUucOKtYZMyQU51s9K/Y=;
 b=LxrdHmUnGbIQungNNvKeetxWrCHc2cawlcieTq6Y5A6kN5CufuLqIy2Ro8FXlWO6F7eRjtvTadGOoiTCrMnF+YuLt6vj6tCGcXraEh0C4xsm+FryhM4NMUeNGY6IkdsS+Dkd+CUYFeMY5YQBRt4Xb7cf1PyGACgdDiQOED2HtAo945v9PuMUD7bv08fLpQxhC0/H3XT5QDFAZLENZ+A6POqrAVUyKmxclXaUpi8QJJoZ4iCzZWTi7+ry7AtdEiebBiePgj+47608h1qChqk4RkmRQvhqg87B/7lzR1wwj3HWP5CZXwtwWcXUX2TA4PRRI0gpZlgp+XA4HCl0I+bFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWftgK8agPsp65LB1cYVcOkYUucOKtYZMyQU51s9K/Y=;
 b=5gBH+OyfDlImTrpPwIi7U0V5gGDxC4iLtemHQ7ZpUcYYy+dW5sF5Xgh0QeaYkCilfDksmtrx2TUH8LGnjA3MEJm/Iii1UM9vC8PnDruDJbfCwmvZVzTFtIfs7QMyheQ6uuYram1F5VYEOa/jWoaJ7VrurJZevdP/6Qgu57kRKcn8bTDfoBy3magG8KJy+sPPQuLXwHcJFlb7gQ1Vm5+2w1fVOCaBhdiTSr5F4iV5DJ9JlcHcpzREllC5LIpGmPPV8C8dSHqXrstrQljwRn0E3Ql9s90Es4iYNCGkq+kU5Pa7yZUgJn/8a8fNt+tDXBgvxrT5SJfzCRWENIoQyOug8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8674.eurprd08.prod.outlook.com (2603:10a6:10:3d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Tue, 22 Jul
 2025 11:41:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:41:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 04/19] mtd: spinand: add missed add missed
 MODULE_DEVICE_TABLE()
Date: Tue, 22 Jul 2025 14:41:20 +0300
Message-ID: <20250722114135.768998-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250722114135.768998-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c538028-6a23-4842-00f0-08ddc914c364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8gtfjeonphA5ME2JMS7H+VnCGrBl/jge7TroLee1OK6WNgjt7+7NahnNjzjp?=
 =?us-ascii?Q?CokQqlDzfgqkzZmhZu+kuK4Avm1naSOjASyEgqkyywkP11vtxePF6dOyPvq5?=
 =?us-ascii?Q?/Kal3QynmVP1N0YvqhPyd/mgZLd4mL4H1cf419cC0o8JVaG66tqUkgMSn1ZA?=
 =?us-ascii?Q?8Nlgg/sTpJgNecn6zB5Nt9IVBL9wAZjn6+HcLSoM80WxsVvBYWh1BarmFcxV?=
 =?us-ascii?Q?UyR/cFrJ5EFLgOPFcvd2N/GsLQTAIMwqhxLmW6eM5KG52quTALBCwVWrkko6?=
 =?us-ascii?Q?8HY8mZhtY8TJpIDJ5c19NsVMcBbuqIy/4UVdjtXSwzZCnIFIEuskSbsRa1GE?=
 =?us-ascii?Q?d32aY98aJZ6ZkR+lcjVcX896KdP3nYWRnN7s3N2ik/P4og1KmwGRDv2DVzBL?=
 =?us-ascii?Q?DPmroxfXIudPDVmqkQLqDd6jkGV2R6I1cxHiboCA066R0Y/+yRVQa4q4ubsk?=
 =?us-ascii?Q?Hq70/hu7MG2hkxxOCJ9tl5G3KQIMDiKstmieXttD5YsnnvTd+Bd1d/s9p4wy?=
 =?us-ascii?Q?1toGq27lhi5TlN/rwQUZkePUKc/0h6hlWHCCJCqZt66q/hMmqew9t2SD72Er?=
 =?us-ascii?Q?vlYfdkN8RLVlkFi2BVzMHJwCKcJkqBPaJVXM0RmfL1s8yI/Y1079DUZZ7ES9?=
 =?us-ascii?Q?utku3Xew3GFrk39Ms58pr3pAm4ge8pqc0O54QNHGLWqIwU6W6J4pLgTpMIEm?=
 =?us-ascii?Q?AZQwBNHwQ3ilUJORkzpL56OMJbDdy39d6roY2/u1XRoKMHEsQ3ybKfqgllKT?=
 =?us-ascii?Q?u3jdswC3dVfpgUryA/7h+Mn5eii/lV+p6GmS740AT1xSNU/vUtRqJ9w+PMl9?=
 =?us-ascii?Q?dEFSFaVNHOluKcVeE4gx603rz8ulcqLc4iKrmt1RwDXdgJZXNPnC5v20wNu0?=
 =?us-ascii?Q?+2x7aeWiT+5fWUpyGmWj3CD3KMcT1+joc+DN86WbWkIjE8F2a6oywUo2Plh4?=
 =?us-ascii?Q?ajTDBy40O6wOYQMumdDXAnLQqRU99CtTjgMlOOEeigiS7s+1qnp/dHN+l+Rb?=
 =?us-ascii?Q?tqP703QyCA2QSkJuhBoOnVpZV90cbdnWL6IQzr/OOpXGKFnndtSJ/ofVfm64?=
 =?us-ascii?Q?dyNf2++3Yl//xyvRuQImlZw9qCqnSlkUkU540ggyGGvBGxZK81AigfvVzSmU?=
 =?us-ascii?Q?PULp2ccNF+v5G32RILc8qS44fu46eTwYsiFOTlcbZI/HJGGdMuHyvI4IAqkQ?=
 =?us-ascii?Q?rA/nKM1UqJcZrpHcuZP03OZ11YGkJqSgAIrDRKDV5Fu0T/WuBuuYJw/TaOqR?=
 =?us-ascii?Q?i37sIX3NkmhjOj/8Trsu9B3aOYKLDpIUZ04yjgDKoeWR01U1UFa/ubrxhqVz?=
 =?us-ascii?Q?xj4kS4tY6675g3jOgXDRFXpE+Fk2OXjaua0+yM6F4VHi9I/cYe5fWqgAQeSq?=
 =?us-ascii?Q?zQPkkyec612MvumvN5/z4/9IKdl6KHxHJ3y733mHnFzL6EaydkolFFVILEPY?=
 =?us-ascii?Q?ZBm5ytyRowpYxY7QAqGeou9qHG6oIxcBvqubqGlCUNJQwQw/l5P02TPGX29Z?=
 =?us-ascii?Q?8MUnFgQ6hwNmfYU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5U2smMRdH3R2Ibb6XvXVCHArpFQZMVEmpqMcXkVg+x7ROQd8Nz84CeviI8X?=
 =?us-ascii?Q?61DbUFDyoMvfRsqvRGIa68/aGTxFiHIVyBBnMUUfJuQ99veovYmBmAjAniqE?=
 =?us-ascii?Q?+bBkOzp0a91eNkhIPm7PTRID2LQmaZ0zXJqcSpVb7K2dBhwJ1zXOA8jme11u?=
 =?us-ascii?Q?pSqIRjEL+bymsTs7k05N8ppT4ZlBr57G48okf8JEtmWfUCACgFdaebV/LAkZ?=
 =?us-ascii?Q?w+TqkOHpbRkbmq03Jx/nTgar/OJBk0Z6gZ/1oVowOHjxpoVFbNB/nKvOXGf7?=
 =?us-ascii?Q?f0MJPd8bh6x0iXkQRfdFL+jqR4IE9paVCQRlxn4nGw8cHTKUDukl7IcAC6q0?=
 =?us-ascii?Q?2Brl9JQk09yb1T4xjJR9xZTctNVqCu1xXXxbVHqAMf8dW8oz7HlbUPn4PJTe?=
 =?us-ascii?Q?2u3VVLduqPigYrma80p+cI/wCcGOyiyojP8HEti3MsHCONGhK6xPmWhe0Thz?=
 =?us-ascii?Q?HSpVXP4g/P/ThnIs8gk0i0CYdsw/9J/BHJcUU6g3bH9XOyLE+afYqf5Drj5e?=
 =?us-ascii?Q?1+JMONdConi0dDn6WXCLegXsDyi94SJt0ZbQx07whj2NXYERmd4tlI7aw3PG?=
 =?us-ascii?Q?PzQTLuhOQaC887UE/pgycRumk/llbSI/Qc3KkF1WMmYHWboYvTXhkZjiblZU?=
 =?us-ascii?Q?KUhNkFFfCcz7H9q7evOVDbvmun6qLRkMmd5VQGZT1XXhB3LwskL4VzQw/6PM?=
 =?us-ascii?Q?E7WAkn+el7/tGaS8zpdz3QIm6PsG47pAyv62DWB+hyDNhuilsksGYkd6D9Ah?=
 =?us-ascii?Q?WwFxM+rxq6EsqRlA6hXy5xGrF/COg1qd1llUK+bsRKSfmRR7dXW8m7ZKeTt8?=
 =?us-ascii?Q?R/cdfm/R5y/vS0UmPV13N5V6GKOdCv47rS2xmNRkjS3hjZRzQhstbp6sggM1?=
 =?us-ascii?Q?zVWZka3QFHWwjAZbTjLgS0mgRS5yIlQY4lvWBAMkEO1GPtAuC8wXFYxOk6Rx?=
 =?us-ascii?Q?ScgsECSjR7ko8qJWLe7i6Tj9dISEnAMCc0kluzkMsGBA8kJ85MqcqPyrq0EJ?=
 =?us-ascii?Q?gmG8H8xHbjOm4JFWgkbj8cvd3EvB12DXxhLuqCioj6HdUwfh7W7atRbZFKF0?=
 =?us-ascii?Q?RkboRDKKhnfO0TnCb4uuVJ3gPshNTFv+03ulPon4p+o93bSLXmBnm/L6DwSB?=
 =?us-ascii?Q?EZUxXkeHBln4iuTeJoI/U0jK9Eo7F7dWmiIT6pv+9tSUj1pVvQmdI8Caejw3?=
 =?us-ascii?Q?hztat0ubwVf+A6RSQON3qOlkPpmO7uVIPCJjdGvztjXc7E1Q5so3Nn2Xyors?=
 =?us-ascii?Q?mogJUufIBjmFfDg8yWZ5edl7rqsLqjJLdH2i0iMiKRY8o/jYfhFWE1ai+X6k?=
 =?us-ascii?Q?aD94XuluIBomTWaipQOWqW9x9umYDPXvcn1T73RLxCeUZ2P4QvXG7sn4sXTW?=
 =?us-ascii?Q?wBlDpqNVusajHJbibseB2G7ocHaEaqdzyzshJlcstcRTaYUXtSph2vdEftBP?=
 =?us-ascii?Q?8FTTEjZdi5rO39YwBOUUwhi3l5s16JVEbCElaZoJMLKcJhvHxIJiGC3Kdork?=
 =?us-ascii?Q?dgh2F02cG2Thx5TfpJ46o7ILQY0vMpxdRUXJ5sPj9sxv6y9eZZEx67wR+zon?=
 =?us-ascii?Q?vmWwsf9P3N7W4lDQ32dBdD7nG0AAmuCWzZ/0QQpEbJXQgJVLjTsyCTKI6wgL?=
 =?us-ascii?Q?LpOPuZoOmESH2BYuvPd0lig=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c538028-6a23-4842-00f0-08ddc914c364
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:41:57.4636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 581BfZETeM0J0NMEEgZHj+r8jZEztu/tSE867lK/9CQ8mwrIqH1dwbz26eQ0v3p8pI+u0P4G8ALd4eYBFzazjjFrImPsQvUgQm409EWbAzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8674
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
 drivers/mtd/nand/spi/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d8abd03e919..34e5ac33c63 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1285,12 +1285,14 @@ static const struct spi_device_id spinand_ids[] = {
 	{ .name = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(spi, spinand_ids);
 
 #ifdef CONFIG_OF
 static const struct of_device_id spinand_of_ids[] = {
 	{ .compatible = "spi-nand" },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, spinand_of_ids);
 #endif
 
 static struct spi_mem_driver spinand_drv = {
-- 
2.47.2

