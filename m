Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FA8CEACF1
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:23:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9538929E;
	Tue,  1 Oct 2024 20:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Lh3qtadJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C82C789287; Tue,  1 Oct 2024 20:21:34 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F07D89294
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIfUw+sqpaSKv/7Tv23aWuxZ62FZ+SE16xeNZLor494qLQBMBNnhTUVm0wBchFYdvAz7x31ibDi/cQeP7mr7cOiNXLdBBb7RroTCcO2nYbu5brIU/RSr1m2gBGru45Qfs4bAtzQJGldBq/dyFPJVSXIKb/X/YcSiIkYFd08ImsY2/VNmEf4jQEmEpN2uXCx0M2suvZGm4yNUOVi4z+GJ+rV8OoQWKEpuomvYkhCMN27WkODE3bp/4HDmT4cY5SzFvs1uDaQXrIJYb2TJC4ShgS4/FWWDnaezX/VzEaSZND2wJHr+riGdsEV7zCz33hf21hvtqQAA08IPRKSMviyAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leTRrFIEtPGdq4BWfTBHvVrDAOiTwpQ+fPY7UvRoY6w=;
 b=DrdlxbWy7eEQOMINGrwPQ1X15L+fVtyKQngeuYi9BOy1g5UPicHBrozxSHY7UaJ4uuXb+TYBuzRnT0cMVhh7LKPQJTmMVNQ3/5sLwHAtP8rSanVW4o2AstEjN4D5LjecN1ba3GhVrZGxIMSgmk58yxwECXXmxEdGpTtBDCLWbounlydM/EhdrO0B07S7SyqvFTNTR9+G7KFLmmptP5RBC5Pgjfq1lj1RpMCPa4i1BpwMUBxypTmHS0InMLieGMSY/Hhw8QpRXQvVO0d8wYkK5rPl5bqoghhFLao8KhPYBqoCQRqrGolfFqmG30BBoqLHfVB3M7JWuWm6HbIgPrkfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leTRrFIEtPGdq4BWfTBHvVrDAOiTwpQ+fPY7UvRoY6w=;
 b=Lh3qtadJJAN06VbsKjR0yukgYTc9rwGip82zyxYzx1Gh25pirH80GiPzZ6REcDaPdI9WIPn3mmUbPgBkEyTrnJTHkE9idCr8VOHHLViFsAdXHVTusurFBkfDqBN+kBEvy22OgBurpdg7tvNd4p9Kclt5X9HQ1vH1Ly5Lxn4nDN36GCra6hTqnjWJya/d807tGT94wbRcjVQQIG2uWVpGGhyC0hHEZnlZ4lr3gs6yPFY2Hyz/gNmOS5iwicTf9RogCHdVA6yOPcHJ56r2RIVs1mah9ybOltodtxPVBaBXglhxRqwEbOoxAtpHic2viOZ0XNHoZyNIHlOsIIQMAt9EKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9153.eurprd08.prod.outlook.com (2603:10a6:10:414::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Tue, 1 Oct
 2024 18:21:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:31 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v9 11/13] net/netcat: add netcat over tcp support
Date: Tue,  1 Oct 2024 21:21:05 +0300
Message-ID: <20241001182107.907828-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::311) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: dda4cfa5-a2d3-448c-f7a6-08dce245df74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ptz/HvBfwtFoW/6+IZedFBB3AvyQPUd8ru/WtyGJfqSG4B7pGK8FI5NMeXn8?=
 =?us-ascii?Q?BOe98OrUGRc/gnxArFkbqCJcuqmfAAUaqz4drlXNmk8tPt4eAjFPnrLEYMZ/?=
 =?us-ascii?Q?6dGVgB+NmYaT4LgUcFQ4cakuyTWpuRiyQ2fR4eUFAaLgav56uw/Rx5713Ufz?=
 =?us-ascii?Q?koy92ripUyjnlfa39peBtUg1/m5xR0ODN+AC5lPaHvd2DNxajvzQi7g8ZLdx?=
 =?us-ascii?Q?aRw3eSCt0im2CrV2zx0bmBrCCfrAGZUZdRXiZH7o6gaZ8iplmc99pVSkMA2e?=
 =?us-ascii?Q?jlmiE+KDhwGJJmYsErAXIfTX/5QCelsClPW3jhgXxTEGxXvVcp5ybyiXPinr?=
 =?us-ascii?Q?TXcqzVOyjUVvla/ZgJ7jLlOcWvJEO2ZRHIliGvRazcXzp0klR5IzgulofXPP?=
 =?us-ascii?Q?4x0EkWryzbuRewvz6MRjoBkAvs2RuUdS+eJAHP3p43v5gX14xcJwbzwKcNHq?=
 =?us-ascii?Q?iRKjzZmNsiFEb5wQDiY7Td+5ef9eYUv1u962JN/XdZhtJe/dFJQHt5WKZcmb?=
 =?us-ascii?Q?kxN+FEEPaCk8Ng6xt9nNeK/YUUXrpXJlk36UV3gGQdTG+OnMIwoPvz3uiGRd?=
 =?us-ascii?Q?H8TNDxONWbzCe9OWkkeHYAbPT2btprWHrRXVK7CFUJgD8jVNtSgROWWRTEN5?=
 =?us-ascii?Q?FCBPfgFMgc0jrG3M0KPEbER7Jyz69CVK4ioGPGBKaBp+OKMi0r9aYAFBylqP?=
 =?us-ascii?Q?EguCTf4xP6x2Co1ozyp22DjTZaaXueTTt7Jbj819xDkm2R01SsW8H+Ccn5EE?=
 =?us-ascii?Q?avK3bzZzY8y6clMWH1FnImRTUaRNifyxP6GiYZI3lrRVknTSOHwPH34hVvAC?=
 =?us-ascii?Q?RfCgmyQustCk88GJ5G+qz8FehWLvkSY+0YNk7ybz79kOmaAZkowd1nJJC60M?=
 =?us-ascii?Q?SyOdeMhh4uoUWKMdHE/o6dubjW5UC7PN7JYlvTrYOEV006p9smlGEMjylKTX?=
 =?us-ascii?Q?wX7qvHwcobR8XvOaGICqA5wLbkrbgI1VvG6JYKnHC5Ut1Ke1oU/+scAbnKuC?=
 =?us-ascii?Q?mIIGX/WU0LYHblk6EqVHbbUSYnMS7RI3Q/WzNa6vE+kmbp5sv4c0FkkTEUhw?=
 =?us-ascii?Q?jfJ+QsiY7pqsqlT/4lu6IFXJzPPF0+qYSYjWn19rCulrdgJCYyIRJRm5+hzo?=
 =?us-ascii?Q?dpW/gauGqWmFSaXH8tdZnDljyuN+0sP1CPwuHRWvY0uUF5PdrsaWlT/uWqs5?=
 =?us-ascii?Q?4vgh4+VrjfywXs0Z9P8izKs+bmP+WKz2Ms2zNng6emDT5Zct4P9eKW3S7xQN?=
 =?us-ascii?Q?EQHM60lIhudrHA11zdQaWe/UUJNejR8NBgFCtcr5IlfDd/dNmxIW5POeXiXt?=
 =?us-ascii?Q?ddFqOgIPyYzzImXuZdeWErUPXvckO0oHto5o7asRGWQ+n7YkRhU8TuCvMrI8?=
 =?us-ascii?Q?U+inB8hDZ1Jy8UXl8/wHPj4cVp1f5M9lSczpu16g1Gs9xN1hn6b4jU1OA1ct?=
 =?us-ascii?Q?ONVZPiTCNFs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MktbRj5d6fQwIKs/HZw4g8CANPVRZEzPGTTOsXMK6AiSMleika0cdMBfaMjU?=
 =?us-ascii?Q?erJuoREHnaGZg6v2KqfeKPVcGxLkCkGp1qDFI6pUL5A1AKIwcBqNQvUtpZF5?=
 =?us-ascii?Q?5uBo/Ik+PpUU8s8UsCJW9g7KXKUG8jJbWpwErvoQUMCrFk5F4KZ+8QCKnxvQ?=
 =?us-ascii?Q?W9CK8fFn1pjT7+xfAgn8mj4lmKomTZQAeEZYjZQufUPAqNzQnExsWLOiMvRF?=
 =?us-ascii?Q?vn7+KqtwAUD7bhTWtCP9xoBD0XY5cjJEA3Ib898JpZyd9DUZeFfNd/LFzGdr?=
 =?us-ascii?Q?ZOB1IQ96t/JNmy7qBe4S2LkqzFtrM3vCrbcaTJ+lNj8Cx48W7+gdGLw8px24?=
 =?us-ascii?Q?qhXMg63zJBv8eNDJWImly+1FfFDuYPI7MX5BoVNuARpdgH2XK9jQBLrOaKIP?=
 =?us-ascii?Q?pgJsKrlMd8/KLMdis1S9b61zVUYpfsgckB/Ss/MYkdNVa30nhfYS8eiEyzmK?=
 =?us-ascii?Q?WMadbI23IM9LZfvAgpZnyzn+5/kEx+mxuMraGpQOv6RhoN6enST5JppI3FEd?=
 =?us-ascii?Q?g9HTuk0ilDrJka82GYVruRlikOZ+mxSQ4dzYSkxTGk9sE1qCy4qjpXLMPw3O?=
 =?us-ascii?Q?lt+if+L2OZkmjFV+FUTHZeGsEsYe9P4PnwpNVuRDGwiqq800fmJXYlsGC9CZ?=
 =?us-ascii?Q?fTBJqhQPQiY9bo5dODZHnLdXzPhm9jyY/QzzgdXaU2yN/5TAwefcOT4N4C55?=
 =?us-ascii?Q?ueAbrhPY1vCrjHN5ESHx2MQAwk9n08Q76/ha53ii7gwlpnUPDO1qANRMDk2q?=
 =?us-ascii?Q?7Ch4PdlLeEqoCZk/cOUEfg0jpj4IPlvEI7fAPuUzp601asD7inU5y7Razt1l?=
 =?us-ascii?Q?dMKFZ9UPDrNToWwjFw3wImdfOLu7qecC5tIBzc5zwZLDI8Zy121RZX5D9vUx?=
 =?us-ascii?Q?vvzNjJWoeJdqSVeHBYP8AlU5/eCwYXW+MrCFfhSBxs4b7Do/dPJtkGZqpl6L?=
 =?us-ascii?Q?0hcyHnaDBXmfLsSw2q10vkp8qsTrMDjlH2Pll5GQ31BcsH7ydU5Uhb2G3dTi?=
 =?us-ascii?Q?vjspEoOeOFScEj8EqEJ5uD7DbC/81rh3+9Ehw1fStiCHInsN/FSq+sAj7pQI?=
 =?us-ascii?Q?yFYkyX6LLyWoyQNkNURo3ZVMxE37ibtzdG/rMqafBTUYgV2sovKFM4U/iyd9?=
 =?us-ascii?Q?z+MjlXzi+J7n31n76eOWczgD/iN7Y4eKU3h3ycaYpSmnD8hm3Vmxk0P09K9F?=
 =?us-ascii?Q?lC1MVunqyd41X/zhpnJ7DRyZA15Wsu5FVvsmOYi9YXja0ucNqgGgD0II8SId?=
 =?us-ascii?Q?MG+SLpsUg1wwe1TW3wcmT3wnkD/eaUSioNCJHlCeudwlYIDNnAK3PLqeC/4L?=
 =?us-ascii?Q?ePHEpcYIuvOH/6zN3qmFuKPbThXcR/Fv2t2aln4woXsibOf6P/kBfs1/JsDM?=
 =?us-ascii?Q?WhLR89vnd4ganyqUgQ/ZLbGYCLuOLh8xEEd32m/vPdfozjx597aIqOe3dF4b?=
 =?us-ascii?Q?SuAPQNlqUbIoM2Ko0odgZUUPGvmifeEnTdhLKAW45kfr/gpaMJ6Wa0+TmmF6?=
 =?us-ascii?Q?1HxvN3UkBIHK0eQZa1V19eCP9BleaT3pOyi2SZWCwTfZaq84ppnwjK36o7Yd?=
 =?us-ascii?Q?jKGA9TB+PUGefsYupu0Up4j+0CPQhn4yfDTHW6uMC48rYgapu86gMIAuJL97?=
 =?us-ascii?Q?Mryd4362dtd97MoiX8oclow=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dda4cfa5-a2d3-448c-f7a6-08dce245df74
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:31.0882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZLa2f+PxWTDRgUXvlFUb4eCTwRn17fIbz4alssj3SI0zNFj4Wnns9oocur+ymmkn9iaUXQUIZg/cJnvJErWC+3XGjYZ4UhiX4k6eO2g+9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9153
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

This patch adds downloading/uploading of data with netcat.
Client/server mode both supported.

How to test:
============
  netcat-openbsd=1.219-1 from debian were used for a tests

  a) Load data from remote host.
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat load ${loadaddr} 3456
     PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb

  b) Load data from remote host.
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -q1 -l -p 3456 < image.itb
     u-boot: netcat load ${loadaddr} ${PC_IP}:3456

  c) Save data to remote host
       * U-Boot listen on tcp port 3456
       * PC connects

     u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
     PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb

  d) Save data to remote host
       * PC listen on tcp port 3456
       * U-Boot connects

     PC:     netcat -w1 -l -p 3456 >image.itb
     u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 cmd/Kconfig          |  10 +++
 cmd/net.c            |  35 ++++++--
 include/net.h        |   2 +-
 include/net/netcat.h |  20 +++++
 net/Makefile         |   1 +
 net/net.c            |   9 ++
 net/netcat.c         | 191 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 262 insertions(+), 6 deletions(-)
 create mode 100644 include/net/netcat.h
 create mode 100644 net/netcat.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5ef3c8a8748..78d9b00058a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2025,6 +2025,16 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
+config CMD_NETCAT
+	bool "netcat"
+	select PROT_TCP
+	help
+	  netcat is a simple command to load/store kernel, or other files,
+	  using well-known netcat (nc) utility. Unlike classic netcat utility
+	  this command supports TCP-based data transfer only, thus no data
+	  will be lost or reordered. Any netcat implementation should work,
+	  but openbsd one was tested only.
+
 config CMD_MII
 	bool "mii"
 	imply CMD_MDIO
diff --git a/cmd/net.c b/cmd/net.c
index 53ce2bc5d0c..79bb126dbd4 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -206,6 +206,29 @@ U_BOOT_CMD(
 );
 #endif
 
+#if defined(CONFIG_CMD_NETCAT)
+static int do_netcat_load(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_LOAD, cmdtp, argc, argv);
+}
+
+static int do_netcat_save(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	return netboot_common(NETCAT_SAVE, cmdtp, argc, argv);
+}
+
+U_BOOT_LONGHELP(netcat,
+	"load [loadAddress] [[hostIPaddr:]port]\n"
+	"save Address Size [[hostIPaddr:]port]");
+
+U_BOOT_CMD_WITH_SUBCMDS(netcat,
+	"load/store data over plain TCP via netcat utility", netcat_help_text,
+	U_BOOT_SUBCMD_MKENT(load, 1, 0, do_netcat_load),
+	U_BOOT_SUBCMD_MKENT(save, 3, 0, do_netcat_save));
+#endif
+
 static void netboot_update_env(void)
 {
 	char tmp[46];
@@ -323,16 +346,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 
 	switch (argc) {
 	case 1:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
-
 		/* refresh bootfile name from env */
 		copy_filename(net_boot_file_name, env_get("bootfile"),
 			      sizeof(net_boot_file_name));
 		break;
 
 	case 2:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
 			return 1;
 		/*
 		 * Only one arg - accept two forms:
@@ -354,7 +378,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		break;
 
 	case 3:
-		if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
+		    (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
 			if (parse_addr_size(argv))
 				return 1;
 		} else {
@@ -365,7 +390,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
+#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
 	case 4:
 		if (parse_addr_size(argv))
 			return 1;
diff --git a/include/net.h b/include/net.h
index b0ce13e0a9d..0af6493788a 100644
--- a/include/net.h
+++ b/include/net.h
@@ -515,7 +515,7 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 enum proto_t {
 	BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
 	NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
-	WOL, UDP, NCSI, WGET, RS
+	WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
 };
 
 extern char	net_boot_file_name[1024];/* Boot File name */
diff --git a/include/net/netcat.h b/include/net/netcat.h
new file mode 100644
index 00000000000..d8e09aaaa55
--- /dev/null
+++ b/include/net/netcat.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: BSD-2-Clause
+ *
+ * netcat include file
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+#ifndef __NET_NETCAT_TCP_H__
+#define __NET_NETCAT_TCP_H__
+
+/**
+ * netcat_load_start() - begin netcat in loading mode
+ */
+void netcat_load_start(void);
+
+/**
+ * netcat_save_start() - begin netcat in data saving mode
+ */
+void netcat_save_start(void);
+
+#endif /* __NET_NETCAT_TCP_H__ */
diff --git a/net/Makefile b/net/Makefile
index 64ab7ec740a..dac7b4859fb 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
 obj-$(CONFIG_PROT_UDP) += udp.o
 obj-$(CONFIG_PROT_TCP) += tcp.o
 obj-$(CONFIG_CMD_WGET) += wget.o
+obj-$(CONFIG_CMD_NETCAT) += netcat.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net/net.c b/net/net.c
index dde6009abd2..978fc1978b3 100644
--- a/net/net.c
+++ b/net/net.c
@@ -102,6 +102,7 @@
 #include <net/fastboot_udp.h>
 #include <net/fastboot_tcp.h>
 #include <net/ncsi.h>
+#include <net/netcat.h>
 #if defined(CONFIG_CMD_PCAP)
 #include <net/pcap.h>
 #endif
@@ -571,6 +572,14 @@ restart:
 			wget_start();
 			break;
 #endif
+#if defined(CONFIG_CMD_NETCAT)
+		case NETCAT_LOAD:
+			netcat_load_start();
+			break;
+		case NETCAT_SAVE:
+			netcat_save_start();
+			break;
+#endif
 #if defined(CONFIG_CMD_CDP)
 		case CDP:
 			cdp_start();
diff --git a/net/netcat.c b/net/netcat.c
new file mode 100644
index 00000000000..15054befb79
--- /dev/null
+++ b/net/netcat.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * netcat support driver
+ * Copyright (C) 2024 IOPSYS Software Solutions AB
+ * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
+ */
+
+#include <command.h>
+#include <display_options.h>
+#include <env.h>
+#include <image.h>
+#include <mapmem.h>
+#include <net.h>
+#include <net/tcp.h>
+#include <net/netcat.h>
+
+#define HASHES_PER_LINE		65
+#define MARKER_STEP		10
+
+static struct in_addr		server_ip;
+static u16			server_port;
+static u16			local_port;
+static int			listen;
+static int			reading;
+static int			marker, marks_in_line;
+static enum net_loop_state	netcat_loop_state;
+
+static void show_block_marker(void)
+{
+	for (; marker + MARKER_STEP <= packets; marker += MARKER_STEP) {
+		marks_in_line++;
+		putc('#');
+		if (marks_in_line == HASHES_PER_LINE) {
+			marks_in_line = 0;
+			puts("\n");
+		}
+	}
+}
+
+static void tcp_stream_on_closed(struct tcp_stream *tcp)
+{
+	if (tcp->status != TCP_ERR_OK)
+		netcat_loop_state = NETLOOP_FAIL;
+
+	/*
+	 * The status line will be shown after the download/upload
+	 * progress (see show_block_marker() function). This progress
+	 * generally have no final "\n", so jump to new line before
+	 * output the status
+	 */
+	if (netcat_loop_state != NETLOOP_SUCCESS)
+		printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
+	else
+		printf("\nPackets %s %d, Transfer Successful\n",
+		       reading ? "received" : "transmitted",
+		       reading ? tcp->rx_packets : tcp->tx_packets);
+	net_set_state(netcat_loop_state);
+}
+
+static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
+{
+	net_boot_file_size = rx_bytes;
+	show_block_marker();
+}
+
+static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
+{
+	show_block_marker();
+	if (tx_bytes == image_save_size)
+		tcp_stream_close(tcp);
+}
+
+static void tcp_stream_on_established(struct tcp_stream *tcp)
+{
+	netcat_loop_state = NETLOOP_SUCCESS;
+}
+
+static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
+{
+	void *ptr;
+
+	ptr = map_sysmem(image_load_addr + rx_offs, len);
+	memcpy(ptr, buf, len);
+	unmap_sysmem(ptr);
+
+	return len;
+}
+
+static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
+{
+	void *ptr;
+
+	if (tx_offs + maxlen > image_save_size)
+		maxlen = image_save_size - tx_offs;
+	if (!maxlen)
+		return 0;
+
+	ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
+	memcpy(buf, ptr, maxlen);
+	unmap_sysmem(ptr);
+
+	return maxlen;
+}
+
+/*
+ * This function will be called on new connections (incoming or outgoing)
+ * It MUST:
+ *   -- setup required tcp_stream callbacks (if connection will be accepted)
+ *   -- return a connection verdict:
+ *        0: discard connection
+ *        1: accept connection
+ */
+static int tcp_stream_on_create(struct tcp_stream *tcp)
+{
+	if (listen) {
+		/*
+		 * We are listening for incoming connections.
+		 * Accept connections to netcat listen port only.
+		 */
+		if (tcp->lport != local_port)
+			return 0;
+	} else {
+		/*
+		 * We are connecting to remote host.
+		 * Check remote IP:port to make sure that this is our connection
+		 */
+		if (tcp->rhost.s_addr != server_ip.s_addr ||
+		    tcp->rport != server_port)
+			return 0;
+	}
+
+	netcat_loop_state = NETLOOP_FAIL;
+	net_boot_file_size = 0;
+	marker = 0;
+	marks_in_line = 0;
+
+	tcp->on_closed = tcp_stream_on_closed;
+	tcp->on_established = tcp_stream_on_established;
+	if (reading) {
+		tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
+		tcp->rx = tcp_stream_rx;
+	} else {
+		tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
+		tcp->tx = tcp_stream_tx;
+	}
+
+	return 1;
+}
+
+static void netcat_start(void)
+{
+	struct tcp_stream *tcp;
+
+	memset(net_server_ethaddr, 0, 6);
+	tcp_stream_set_on_create_handler(tcp_stream_on_create);
+
+	if (!strchr(net_boot_file_name, ':')) {
+		listen = 1;
+		printf("Listening on port %s...\n", net_boot_file_name);
+
+		local_port = dectoul(net_boot_file_name, NULL);
+	} else {
+		listen = 0;
+		printf("Connecting to %s...\n", net_boot_file_name);
+
+		server_ip = string_to_ip(net_boot_file_name);
+		server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
+
+		tcp = tcp_stream_connect(server_ip, server_port);
+		if (!tcp) {
+			printf("No free tcp streams\n");
+			net_set_state(NETLOOP_FAIL);
+			return;
+		}
+		tcp_stream_put(tcp);
+	}
+}
+
+void netcat_load_start(void)
+{
+	reading = 1;
+
+	return netcat_start();
+}
+
+void netcat_save_start(void)
+{
+	reading = 0;
+
+	return netcat_start();
+}
-- 
2.45.2

