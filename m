Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265F7E7DF0A
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 17:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E64C83EC8;
	Mon,  2 Feb 2026 18:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="XHc4cRXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22DF783D8A; Mon,  2 Feb 2026 18:05:36 +0100 (CET)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3546383D8A
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 18:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZo1U9x2DT790z/EThZnrZb/nrtAvYT+nuY+AOOqEDksGUxxygD887ObOLWkotk0RsiDdfOkBKomWFSvUjQpk78x0DyTRfbpWr9ozyqk8Ym5Ia8yzAKJ1cUBuhW1kh4qB8wE/7V4QqBER+16QLQFUqEs1lcYePmsNHyGEeU+n6XcmqkDTaJyo7pA+AU4uIDE+6htJMLHv5/CbVifhsaEOhxKvD1fys3h+AYwY0wzTj7aktmNLoZXxtMClwOy0jiAgvO6cJAvUmLXANcCXpcp4rDI/WfVwyoHisEI93aGBwG0hS4DsN5R2ItcqNc6cwINp4y02ldrESz9Tdnzi4ptkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MPeBHSDHdp+z8Uxp1A9nT9zLEEXYdvziXEBVvYGXg8=;
 b=vQHk3InIS9/8aXd5XmfYsacogy+zxsui2hPqlGWTcKSG0uAwsFYOInAOiqWMSpP71SgaeJPfcgkT5DM4moviguFYN64qVGsC8jDWfMdwv4NRYIfvb877+pexU1U3OyTlsYkiUIvBSO1RdXH9hKC9NhdqrXmGJtFRg4R+4Uupb9RquC5q1cNQAfSi4hN4eoYFHaeTWDY1cZ0XJVZ2l54Bd60LqZQQGH8wsHSFcSC+dRJwfzlmrj9tjTQJ9h4VgXcO5exh/yP44MT7mUmK+NIm+YMzUzlckb8/uUXmAxP8dt3SkGVftlXO30yEqshEtu54VhNqgb/CILxfo3oTRiH3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MPeBHSDHdp+z8Uxp1A9nT9zLEEXYdvziXEBVvYGXg8=;
 b=XHc4cRXeV5ofGUoLG93h4hIt9pZ4j25X5B/i4YZ2HbtG5sH44ZuM/4jQFEzDJe2ULubmL7vavbJrpgkik4EeK+vcj/mvm+8DgT2sMPCItBBtKwNWX0s/WXlD2wTwi96o6Y1q8ZFWaHErSVrLghBgCJKF6MzIuWbn0QENv/JNvewIQo+KMaJtm16XK/HD74Hq/9wsBj4P+vAdQewvf3n2dkGXIQBPPY5fm8CNRLE9L3ILFczjs4QxeGbbfq/A9mMwnTJGXUAOTrKXFvjZfIim9J02rCMksL2v3pdqYlKtBmYSDRPOn8Yt9SALrcLXgKqy0xANcQe76+zzAiV3OGe8eA==
Received: from PAZP264CA0253.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::13)
 by PATP264MB5111.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:05:30 +0000
Received: from PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:239:cafe::e3) by PAZP264CA0253.outlook.office365.com
 (2603:10a6:102:239::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Mon,
 2 Feb 2026 17:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019233.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 2 Feb 2026 17:05:30 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.66.192])
 by proxy.softathome.com (Postfix) with ESMTPSA id 9FA1220078;
 Mon,  2 Feb 2026 18:05:30 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi,
	jonny.green@keytechinc.com,
	raymondmaoca@gmail.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH 0/4] add software ecdsa support
Date: Mon,  2 Feb 2026 18:03:03 +0100
Message-ID: <20260202170307.217200-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019233:EE_|PATP264MB5111:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a0b78459-2224-4f05-4b79-08de627d455f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bO6NmTq+CJpuMrMAhShDnsna7l2ivwUO7r2irPiCe0aUp4TaGB1Q0rmEKME5?=
 =?us-ascii?Q?vJoHHPyZYxVwCaZjWSp63Zwa7WUNkPZr5XTCYK1EnpMJNjDOpXavePoHR6lz?=
 =?us-ascii?Q?fllm2zlWjaNJKZhXdAyZgIRJzaXiU92Ujj409vtJccTi+p2gaUp29CVe5FzC?=
 =?us-ascii?Q?i4xvWJhG9UFZZdN3UgAv7H5eRd1C5WOLkN9RMWn/GAf3DeiHtArXz3H0D9m3?=
 =?us-ascii?Q?sJ2EwMQ5h2MeVGIco0TrXlvLTQQcgvdFX3/Cm1MskRimyBaloq//muPyqu/W?=
 =?us-ascii?Q?783dbyg+YDG7IOTWhNezu6ele1iDCodSz+GRr/JItoy+StvmOwQPhdZG+LvA?=
 =?us-ascii?Q?E14caCZdxQ4GcRH4s7vDK2TtZYGbgU2wvLt5X8baEjXfbl1Wiy3MKAcxk8B+?=
 =?us-ascii?Q?Rwus6LUApbQpTvrLoSZltpU8EnXlhKeM6DfS1WbTgure68PD+dtfAOlUIKWm?=
 =?us-ascii?Q?OwBPWyQ/yzs0N7k6k3Ds0Uo+BqIvSTtQ8Z6k82JoaxH8uPH4vyCxXG5z9i6q?=
 =?us-ascii?Q?kw8qlIC0uuEgF5EVK3ZxdO8jrby7dvNaeEwr+mC5PWxKiq5Xsz6o5IWJhjSH?=
 =?us-ascii?Q?io8jYorqOJ92wvNS/eLdyC5UkpAsSo47fDjfvPh1h7iBtI8dnQILPdtFtgJy?=
 =?us-ascii?Q?gg/5w+E7ll0+MHmPKrUYgivBujmpQYK8M5OGmJbHDKxrw9hsGo+mcVwc3lkG?=
 =?us-ascii?Q?CxcTr23bEP19CI/DssDIjBBHu2sqLQVbYMRYe/mNsJkm1J3kQI0RLorWt0sr?=
 =?us-ascii?Q?i92B/q+t2tFD3e1FjGU3zAOZnOHmKdNLLPLksd5fZu/qQxJz/IzY21FKY7lO?=
 =?us-ascii?Q?IDF1TaY6atdhsUUzDt+FbMcZXB2zu2XEFXNERMEt2WRdtdlj6JXI2wkvf99S?=
 =?us-ascii?Q?ALS5kNc4L3zyAsIHbfw2PjIWUI+o+QsZURYAx65LLDQssSHV5+8dphuImYrJ?=
 =?us-ascii?Q?kOeTQZjNNSMXCI8KeFJ24z1BK8CqG4WTp17oQGhk8jvj+C6fSGBssUkdx23L?=
 =?us-ascii?Q?KSgh5jmsKDuG3wy+ObsoYy0597X2E0w4Ua6DEUrk7yvSGCmZ4WC3B9bAPZx3?=
 =?us-ascii?Q?/z4fJmjPAxdZm5tzeP2uCZ5c5lbZ4Z3LPutwF/A1mWiSxi7XUfT4/5SyguPX?=
 =?us-ascii?Q?VKDu38wM8jhKUqmWGS3lln5pM0HAf88A3Vsex6UaDCwZzgKJgJK38p6RmPye?=
 =?us-ascii?Q?fNpHayDUCX5ghoIihQJLxKjITZnyTyGJzsBjr48GNx/nz1OlQrUIOyyXJU5N?=
 =?us-ascii?Q?qr87rRYkQkyrWMQrgpcj1GYXGvxr4W3D4ea/GhiNLcHOPBwiAugKWG10DWBt?=
 =?us-ascii?Q?gWx8dpdGE5wOtkc82cl+tEN0MmQYW/c1yRv28GC43GjlBCnYef357CZRfRfA?=
 =?us-ascii?Q?LccpEsjFM+A/I5sDy80X5PyjcbBodNd4+KPNa1XUxd3dwKFQvlP5IzHqKmog?=
 =?us-ascii?Q?jtt/K8o3E5Wdt0Nz1KcSDqT1wzBQOp53jJMKdmjZXecciXrVUHAPXpQ2ctwz?=
 =?us-ascii?Q?eGoeh79FOq2he4xKODyEqBmPyLxBv4TV0iAcmnHFAcXDKkiRX0HwatYXCm9c?=
 =?us-ascii?Q?KOW7fB2QGP3a0hyJyFu4Qx5IWR0U6/3oY7cKm4/sIqkM7UR7oYLrshYrCnrS?=
 =?us-ascii?Q?Fi3EfJF5bqIF6dEc702ssGzd36tPibmYhbibH0dDOSseg7GCDbxn2X4MmJ3r?=
 =?us-ascii?Q?cIJScQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s+6to/Z7/oolLCuO4CEk3es2GfpT8M6w5E2cEgtWqBvFNKndYHsC2uG2A/zCgbsXoqPsGAKPx2ssE0+8Y2pogcHTts8Mm44m9po71gsWZWBon3qrBaxeQpU6X/nN11QVtYCOt873/ey9g//GYisSyMLAAdYM6KLQ5ENeN++7WJGahxeLUUSt/C4QJ0AKsYiz/nLdFw6By1yTZHO67I8aYQZUNvsikSshrmI+vpqfWqEEuBYeqkmqRgszRGG0EBrr2arx3gXZhzOhgQMa/jxjcfurc0lAxV4EDUcpopjTQIi0rTZ7+u9mI234tjGa/NeG5/lcAvr473d/98cII3ikipL0pezmtqTDDRjlA/tb/wuxkUy5QQq6x6moUpalP81MSJZw0E9Kxk8tbkmSt+P7rd3GLZAhbYlZ7oofQrEbSjHOdubZXYdL5gZZA0DJKJ2C
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 17:05:30.7432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b78459-2224-4f05-4b79-08de627d455f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019233.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5111
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

This serie adds the support of ecdsa with software
using mbedtls. So boards without ecdsa hardware may
also use signature with ecdsa.

To add the support of ecdsa with mbedtls, I have:
- enabled ecdsa in mbedtls
- add a function sw_ecdsa_verify that uses mbedtls
- add a driver sw_ecdsa that call sw_ecdsa_verify

I have tested this code with sandbox, and I have
followed those steps:

0) build u-boot using sandbox_defconfig and adding those options:
CONFIG_ECDSA_SW=y
CONFIG_ECDSA_MBEDTLS=y
CONFIG_ECDSA=y
CONFIG_ECDSA_VERIFY=y

1) add a signature node to an its file
	signature-256 {
		algo = "sha256,ecdsa256";
		key-name-hint = "private-key-256";
	};

2) generate an ecdsa key
openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem

3) create the itb file
./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>

4) launch sandbox u-boot

./u-boot -d arch/sandbox/dts/test.dtb

5) on sandbox u-boot prompt, load the itb and launch bootm on it

=> host load hostfs - 1000000 uboot-ecdsa.itb
4628674 bytes read in 1 ms (4.3 GiB/s)
=> bootm 1000000
...
...
   Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK


I have tested with success ecdsa256 and ecdsa384,
but there is an issue with secp521r1. 


Philippe Reynes (4):
  mbedtls: enable support of ecc
  ecdsa: initial support of ecdsa using mbedtls
  test: lib: sw_ecdsa: add initial test
  drivers: crypto: add software ecdsa support

 drivers/crypto/Kconfig             |   2 +
 drivers/crypto/Makefile            |   1 +
 drivers/crypto/ecdsa/Kconfig       |   6 +
 drivers/crypto/ecdsa/Makefile      |   6 +
 drivers/crypto/ecdsa/ecdsa-sw.c    |  33 +++
 include/crypto/internal/sw_ecdsa.h |  14 +
 lib/mbedtls/Kconfig                |   8 +
 lib/mbedtls/Makefile               |  10 +
 lib/mbedtls/mbedtls_def_config.h   |  18 ++
 lib/mbedtls/sw_ecdsa.c             |  94 ++++++
 test/lib/Makefile                  |   1 +
 test/lib/sw_ecdsa.c                | 445 +++++++++++++++++++++++++++++
 12 files changed, 638 insertions(+)
 create mode 100644 drivers/crypto/ecdsa/Kconfig
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
 create mode 100644 include/crypto/internal/sw_ecdsa.h
 create mode 100644 lib/mbedtls/sw_ecdsa.c
 create mode 100644 test/lib/sw_ecdsa.c

-- 
2.43.0

