Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244F4CCD184
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 14:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 411CD8382A;
	Sun, 12 Oct 2025 16:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="RtSphLjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C766B8383E; Sun, 12 Oct 2025 16:28:01 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A020A83816
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 16:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvjLfFNMo9lpxUHuA6LjoH5E8VQWeEgJzY43zzIT21YQ6CnptwdXIX2EMgDsCCpe/A+Vw5AprX/+gCJ6u+EZ0zM2B/xW3uIlE/X9zqw/1kSqXNP/BTfFcGBG3+RO2BjE7irtjYXdV/B8RS0Lk71b4FDLbofpAq32rq5186owCkdtUzpV1ad/lP6eZGR73BkG+44TP/ysB7tKcdlmgo0AjtI+xcmQz8LrMvEIp7o3hqi8cgwEih99UQyCwsEicnmqN1EunraXuYKHb/M/EItflf4L70HJPbyXdLxRNaKRjBktG9lfFdVmaRKC3lVosFhsBMOY7iVb1sniqNrlIAXOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC1ofRgORqBVb9EQFXJcUtvOivkAP/bjw+1N+Ih2mBw=;
 b=kAr9Kt1v0BTQBidDFrJ6rTT7hJ/wvOSxLTcAGsjuwyEHFCPrY143wCT0FZ13+qKuPiUkl36abTqFX7ymP2OgU9H4qKTaun2CHvtIBujye7O5Y3tN+a0xRL8+yQKrEkXew1i4O8wmpSDaFgsInxORp8oO7BBhOwV+DgXZYH1XuvdqeYAqBqQanQqvJpwYhOkcZKArmpy39/raIkzxG2HrrJiZKnaeYCBhvgnddfnmx5N0EDqx1cM7jIrzV3Ij199QVPRHqb0Qd2eOB3cr9AggfdRYe31ntOnjuQdM1lmilV5IHNGOwQ03JgqrdSJJl405iFTVUVlu/iBkiIJypGipdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC1ofRgORqBVb9EQFXJcUtvOivkAP/bjw+1N+Ih2mBw=;
 b=RtSphLjj0ykdUDuYA1aHXX8UFD58BQDlXlMRTYTY25ErAf9fYMiXpRwdmdTl2y8T8g5+KUmQm3lJO0HLDoI6ST0PCjnT/5+gBwe0jmsNxuJwqadpxRaZ5DUDaAsCkB6VyuDpR7KCSsbeSa1cpF9Miiy39c5WIAIM1ZUnxSc0CIpxa652CS5zl+asPucTbyw5Pxzb6lkLVvty2ugUKq0XvoFlG/jJqiMiy6+yl/tapR9Fl7/w92C1ActLjcoFGHuSpHxYnmDsQfAwNIyyZAiH2D6MM/OyAjNePe8vIugA5TUkE24rVyAwxKxU5i+V1xY92avg0nXarQ39KyVMhdun1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11394.eurprd08.prod.outlook.com (2603:10a6:150:2b1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sun, 12 Oct
 2025 14:27:54 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 14:27:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v2] cmd: mtd: benchmark: use lldiv() instead of 64-bit division
Date: Sun, 12 Oct 2025 17:27:47 +0300
Message-ID: <20251012142747.2315881-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB11394:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d1b02d-2214-474c-f786-08de099b885c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ISbcORWlDWoGqvsgta/ntAleuCY8AthoHRCo4Nn51Z4ckIiwfXvKvMf/DVk3?=
 =?us-ascii?Q?0rRyaZ9xrIKUrATXdfIdaobaE4hlkhjyI6GwAWTtiDNvgP8JkgphdogkXHhD?=
 =?us-ascii?Q?8YGlSRfFNtz0w5+uxC30BeGhN6mgptlPprdTWr4wdnm/nYKe2SLbO6mL4hbX?=
 =?us-ascii?Q?u5X+gMv0dOs4i3pIVZHI1RNgE738bgbYX6LY4WZQqRrIYNHjosepzUy8UqOL?=
 =?us-ascii?Q?lZ7i/++/AsD6qlB7pNxn1pnaehzo/J6CT2E3Aln8cTGuWsukoUs2CNFzrjCN?=
 =?us-ascii?Q?MD/eqJsGC6cvNZZxX6/caod1P2OubJ5a8utNmtdCZg6Cw5FtYjgcpspA5T+A?=
 =?us-ascii?Q?EtZp9cOcvMEDWEDD5JHuUZivvmH0gFtKG0210FyZp8qJN495CiCyuZM+Zlmm?=
 =?us-ascii?Q?BE/HlgIEMM8b1N+HECZ3OEHJCSXLSWQ8YAn3WD1KQyQBqX1mNzFSeuSG1ylG?=
 =?us-ascii?Q?626I3ce1mvXWfg+nYOFYJGPWhRlgYU3GuNQyDD5n3tFZm6jyhOEiGOOohV4e?=
 =?us-ascii?Q?OxpG2Jc+dMfVvg8dJwFFUIxXi8oW1whzrU8D5dKeV6Vnvy+SLggjWvZvoips?=
 =?us-ascii?Q?ymwpjqGRGyhYTkmhXnE9rbyC1KgGtzOu8w5BnM+xlHsJj5cFrzFvWPpaMmmb?=
 =?us-ascii?Q?45Wrg8UbWbl9QVmK5VR3jspnbt/Acu6QqRn9v3AF8j9yYCMwOZmLcaTh0BAv?=
 =?us-ascii?Q?5erG7/V+nHiAIYcmhJ7Pfcwaf3v7XWBI0Hep25q9MMIhWa+d0mGsEA3otC32?=
 =?us-ascii?Q?YWa/4RxOZyfle5nUDh0Re6ZjMF99IfTN8lcGHRrHjOSdFKtcDqLvoRphFyBN?=
 =?us-ascii?Q?lBNUyJC0SnD71hqBIZc7016myC9iKz45gJoGZPYgR65jHgFER/G+fVfwlRYV?=
 =?us-ascii?Q?Dg48tSWY3Rw6UpLJp3iQJMNWg24RY2LVGUfaFcY80qQfZsJAfo5BGgHdvHZn?=
 =?us-ascii?Q?u4pr7ztegqierQUNVLuYhC/OOgyaOGRYRA/k6uHcZ1a3NVIVEtI9oHrTRxG5?=
 =?us-ascii?Q?jFsxZYTJBZnrp1WWTh3oBfw5ugiykxUVbUZ7T6zBuykbLX84iWvd/0jPO9ZQ?=
 =?us-ascii?Q?t+habE9JIGjHzlEtDVn1Itm+XuInyrIPSSMsWFtqQEz1cllucy+k9/22xvbP?=
 =?us-ascii?Q?aPncm1J811guP95YZLNlL0UMrkn9qj4kaNWg/6q56hHzdQYRaOnb/jrjH2Cm?=
 =?us-ascii?Q?FRikX2uPRU+S0I+JbZXR05jn3eBTyOdlYrfWe0bV4I7ri/ylKFuJEu14v3zv?=
 =?us-ascii?Q?gW/l7hu/RAwsyqx28/Gp3RmpQ0/SOIO1BiVJBt2E33Oxp0dKPnf34f8VWpXx?=
 =?us-ascii?Q?1mDl4kfAT6BjsBKH1dhFQ3Q74sAbK5qZ2VBuJtfCrgwm/44/zCYfGxeSXKdo?=
 =?us-ascii?Q?kVrqANpFW2tOBGiL0AW7XcHDeJ+jzfFdZBaid8pO7gqTzg/uPIvJqCo1s6PX?=
 =?us-ascii?Q?napbWCw+cMvmiyNG+7ye89f9chbwLX4Xi5sFMUrACzOC6jKL5w83frgnQ92W?=
 =?us-ascii?Q?cIxgtI2A4BAuGwUxwMBtWW+mO+4GbuuqxyKC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tF29vZb/xTs+hAistPprxhv5sAGK1eP44oEXwyHoKx96MDoqBJeQMz2Pmgyh?=
 =?us-ascii?Q?fdVWitXfZmvVYyIv24h8eWcCC0YqHZIi6oPboB0IisOcsNHP5nE/0Alhyi2n?=
 =?us-ascii?Q?6fZ/GXkdjsi6wAyX5PzfczDk3lyNiS+MpXh2neV7+HwoyLCD+0mnvOiVBtVK?=
 =?us-ascii?Q?Xz7CUFMeC4dKoXlXLZQLSFFGTwk+RISy4i0NNJqH+fFANFZe9OMWJBR9FoOC?=
 =?us-ascii?Q?fxNkL1A+ICIvosaCn0Ovd9Ls5tYiQ2DQTFBcHXcoKgQKce8GJ+GrfuGINpgt?=
 =?us-ascii?Q?yltZWXH5KWWO5Ivo2fR04QsGTQn9Nghc9wOZKqVEwb05Tbvx8LNlwCefqzTc?=
 =?us-ascii?Q?tqPagxGYqYXVjdcxuh9AQR8NChraxLREWxZEb3k9O1jLrq2Rx1bwk+rsjOIo?=
 =?us-ascii?Q?gizCjHHQPQR866x7GYMLS1cV+HDOApMvkw/ECuokH8VgZqibO6QtfJJ5p0EX?=
 =?us-ascii?Q?pXr4fdZgbBWaPJVxHTx0bPvAgTNXbZY6NCZ7mILfDNP3MokmuijhPWAwWC5I?=
 =?us-ascii?Q?uU/1I7iq/TkCCQrSUfqskYg/yvOBiYVVi8FZpeJr86obB2Jy314OhtEV2dk9?=
 =?us-ascii?Q?wHlrcJTc+zKB0XRY4Flnw/0JJuPe5rErdPTmjFInGIjAQvjJBnlme2IBsPSN?=
 =?us-ascii?Q?aLAamRQKvFoT8JxTOgHaxVUHK9dNCa8vda0C/Q8UIHV1RKSdyybZWkRFL5xc?=
 =?us-ascii?Q?thsZrRKnouILjI8gmN6BlGxnQt2ziq8zk2NtfiU++uMEAMZlKEvrnCasgLAR?=
 =?us-ascii?Q?YDPQTlepkVwQ1c4fj7srjjDA0qsXEPuan+RI1Sr9BSzDwXzju+o+9I16g7YA?=
 =?us-ascii?Q?P6p5CvrKXkZb0donrzDF2B5NR6YeXJoa6l+8zVpTqb0ui2SBcsn+4Q0mbKYv?=
 =?us-ascii?Q?3HXqLajXIGx0eoYGZf5PpsN6x25fbIY4muYrqzeFeP1iXEyNVHb+qOiulyc0?=
 =?us-ascii?Q?hNreeTzkVRlyTDHHOOaTwO9WIp6Kg7bFuvm8toJdtEgzZwlwc9MH9Taoc8kS?=
 =?us-ascii?Q?r16qT5dJphgEJqwLava4j79Nw4wTlFkjFixK4OuTPKwmV+VpN6bqNfMQny9B?=
 =?us-ascii?Q?RH7ycAbTht+dw4uzXXmg7FBATIeH2PP81nGUFj4h7DsPr9usNoeTVDx0LiUR?=
 =?us-ascii?Q?ir27xlKFmgD1LtXNcKK402AQaCoV1PN4na0yirj7hqCH9zqODoxYe1IMNgcy?=
 =?us-ascii?Q?nmWiQg4gMfDKZ3lHiMz2M3bHDwGgpQi5Tooi6gwuE7ELpWucB2HP+LNKtuJ2?=
 =?us-ascii?Q?cJb5yzt5MdqdFhuM58KfXLhz7cbom/la9YZfUWAQSjS5piJCvztCsUxmifgI?=
 =?us-ascii?Q?Cicu3Gk37ohjNNAznHw/8M7JXaOPipXyAtWp7QhhfinvznoQ4ujLW6VBWL9J?=
 =?us-ascii?Q?RHGSLNun82tQKSdOTDM2+WA5uWGWWjJKpMHW5pTf7AwsKhr7RYDfCD5AKQ4c?=
 =?us-ascii?Q?IqTQgHCRkW5EXuKHnKTULuym8k2eVJUtqXaU+MBbvrraXGhvYmUUd34gR0K0?=
 =?us-ascii?Q?PgcFCjTF4TkxnXewnscuMeFGMk8bNYlYb9Y8t00EM4mWSS+qfyMjImRHlHMw?=
 =?us-ascii?Q?W0DXuXFVkFrvPPhCcyL7WNJD7apaQ9iJncc/XFNsICbHBmxVJywDlxOhnvFc?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d1b02d-2214-474c-f786-08de099b885c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 14:27:54.7655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+2Ameaa90oENc5CsMWaP+ivl1geH2yDDA/ewX+01Ngw+BvwDaZ8BV7HkRYsVrLOB9o0cMzwWqkrjOz2bZStWdwVtRBMsWRD69qRzw4Tsl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11394
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

As was noted by Heinrich Schuchardt, some SoCs may not support 64-bit
divisions. Fix an issue by using lldiv() instead.

Also replace (speed / 1024) by (speed >> 10) to avoid potential 64-bit
division.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 cmd/mtd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cmd/mtd.c b/cmd/mtd.c
index acd886da6da..6d7388a30ff 100644
--- a/cmd/mtd.c
+++ b/cmd/mtd.c
@@ -10,6 +10,7 @@
 
 #include <command.h>
 #include <console.h>
+#include <div64.h>
 #include <led.h>
 #if CONFIG_IS_ENABLED(CMD_MTD_OTP)
 #include <hexdump.h>
@@ -595,10 +596,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	if (benchmark && bench_start) {
 		bench_end = timer_get_us();
-		speed = (len * 1000000) / (bench_end - bench_start);
+		speed = lldiv(len * 1000000, bench_end - bench_start);
 		printf("%s speed: %lukiB/s\n",
 		       read ? "Read" : "Write",
-		       (unsigned long)(speed / 1024));
+		       (unsigned long)(speed >> 10));
 	}
 
 	led_activity_off();
-- 
2.51.0

