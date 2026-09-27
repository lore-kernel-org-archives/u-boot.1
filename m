Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8155C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 23:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5CCA605FA;
	Sun, 27 Sep 2026 23:57:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1nuhcAQo2k1r; Sun, 27 Sep 2026 23:57:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9FD2360601
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790553463;
	b=EYN7GCtbarwcicNb8HsKNJZCvVlhfuJD82MU//2yAQv3rfg/I9uIEk8jMTo1DoJfALcm
	 XXfzsbJSPjUeFVJcSuhLheFbl/F9GSmf2391YpMAL4oAi2rCMVjtOeDjMLVlZf1qXCZxQ
	 +dwjJA8sIH7ptucwTyVOL6inJ87prwr8Kr8DSwuyxVj7iFk2boQWOzI8O6lAE9ZkxZoh2
	 SN9FzJP+zseK9ZUM5oqlhixCnKWeqhAy+8BIOW32AmhXKkbQLdS8XsHmKyxDtHbkKNyr+
	 xA+2/8RMyIfb/sjTd1tSQC/fcSrmpAWwDC/GBzTDHb/GeykHYLf389aGDR7eN+SasqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790553463;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2bmk4qO4gHqD46KUpeACytN7xf0qOfg334PrUw0U8+s=;
	b=ZPoNodtq3BPrKoKDY483D1kYYnPoJrI2VvX6TTlv0ZHQHz6/U5OUcIjGoNMrod/wr0wh
	 RB8uTSotZReAb64uN1SjVLftuMUvUnhl2vzQuC8wxlvgZr8N6gDbKM5zDM77bXbz+0o37
	 VV7JUj9YXEkUyw/xVrzY6eHny7PLLV/FxKPTH4a4l+2p9SX7nDhYmAnCxZTgK3oSWilln
	 ESlJiX62VfpgWzlfRcl4Z4TBpVzr7s2/r8RNIXinEbmYrxU08hW1k94Oxte4nkSBQZqll
	 A70zATd4ViwK/oRPK+p7UBch0bjO9sjlGJV1+/TQfvw+yBSr2iYO/jTDHjNVG2l/tVQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790553463;
	bh=2bmk4qO4gHqD46KUpeACytN7xf0qOfg334PrUw0U8+s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p7zt8v43iioRvbKKe5vyDtx6xn3sjm3q/VcFXf+IXLpyCu7TTgjZflNJWdOL8xz9W
	 zU8RDZTeeYs5zA8x73l8BNMGPJB0kCyeuT0FGe+iA1DrLb46bU7AZ22t3TurImKZTx
	 DkovZmPCQRVdbUdWbn7V+vycpti5bStRl3L+rUnnHecvtrgR5QB653DjqKVFfk3C+s
	 rk/w3Z4tukn5OMRMu45sDPprA5oueUul46R+TYm6DE8G8EDiPkakjhEdQ7dtwBtBGj
	 YNqHkvEtMsw5myq/Mq2/hbJ1YpbMe+jmHoiLiRPmBnwjcIRei9UuLt7EvDSm3d4VKW
	 S30VI7gLTO3Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FD2360601;
	Sun, 27 Sep 2026 23:57:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 82BAD24E
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6746B80CCC
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RvM8eD4aQulz for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 23:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EFCBC80C87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790553461;
 b=FXvq8jXPpUazA8uAJkLwtm25Xks0O9d9ZVLN8wu+X2V/UzzgM0fxAigajCDuYDMwrQab
 Gh83OTwYJzM72DrF1rp/SuUoViiYN46g1qVtWxfR2SZvaWz2MJ9J0WyB6TK3Ky3VCuRkt
 1kHMiLoVvhdMNr90XUllr7yng0gadQL39dLym8f9spoNOglUfjSyrjdkkW23UMBoJY62A
 ewiVtTHRXUaBgXI6TaqTdXyuT+ijcbdp39ftQw3tIwYpY18nYBtRZ1OBlWRDIyVt1pLGe
 JK38t1QxhMcRoUXe5cZc2y0h0OwHySg7OnJqJtlEe9/MpoqqWyANY1yIJGbIZo+Sxqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790553461;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=2bmk4qO4gHqD46KUpeACytN7xf0qOfg334PrUw0U8+s=;
 b=XihElIKk6daqjpuVJC3BteMTUYykHO9CNb8LjTEZXmc/20kLlLSesF1Z5h+is1G/MOVJ
 +JNob+9ShJmVph6VMxBvTgEI7KpoDYz680i6irSbpXgg1i/aHwWjA2koIBX0vV/nkBnkG
 BrMEVgklwOHUp+1vbrIIKqdjIFha/EIjJifBnmmEzCu8FCw6/znA34tQ1TkLhp0n4qsVU
 z8s3DcsOftgXLmUD5ZUI8s2WvB46x56q5Yh4XtfMkrchq3G953OdqKsV3qrc1YqO8YXLs
 O9NV6FM0zHHzwsmhFxrPj0Rc/tcbcJnYtZzQL1+0odegog7JcK9xj/Mnr06d4GSCXNw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=iopsys.eu; 
 dkim=pass header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=mAIh+1Od; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=mAIh+1Od
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFCBC80C87
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 23:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg7xDPzt7PYJuyKWZ8KLQTYJWlukMFsT2EVpPdjHKI4d8F3yaMVv6HJAWxlhJVtfZA1vu35poQu6qMLE4eiwFjLBuB5D4L+h2MtvweVe8FUAr9R3cScib1mhXPhlxy3DIPa8etshPdHy/VX+Q5ogfyHhFVouILSR0lgiiqh4eD2c2r12vg0L4p7scB2hBVllc7zBQroqS9GLMOIU06hKcY5mUjhjDxyZLx+DnT48rGoQ6dm8RKNhTbqv5jFESGSAAOA/7Un+qKRCs+aG6UPYuDTFe/RtRu0NJioLqsUZ9+hvEhIfuRioSrUs0bAyj0jg03EQlRrGyDWb+okzs8DLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bmk4qO4gHqD46KUpeACytN7xf0qOfg334PrUw0U8+s=;
 b=CgyA3dBnzFGppST7EEFYS39qJRaTLDzwhcI0dCgoLGxfN01VcHQ51nVenBO1k1WDdDLTWNvP5BXg1K9aaU2jEu6dZ8fDEjjEp0q/ns+eN/nNv0vcI9PITxc7zvfdP9ree/GuFSH6AtPW/AdejLD/Nqcen237Dc0gNqqwq2TneOQKrmtQfeTXA2dW4LJWNBCPXag8ZsltDTum88pFvGVvLt4enC3qnEf5aXDdEvta2V2N6fWg9/a397/CD/mjlOhODngVR68d3TXXomoU/maDhXex2hobDnpkWdSEi5DTHcn0mZVrTxg/jPV8sbdL7tbsdrdrzHimzoHi9rlq3lUVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bmk4qO4gHqD46KUpeACytN7xf0qOfg334PrUw0U8+s=;
 b=mAIh+1OdqWmSF14rOCeLUIiG4xRoEfA9oCuFNWlZR8v68tqTd6TWYCDtcS9nJRGy97jkiuHwZMyTIdTP8Le23U5foTjCIILr/+DLzpRG8nj62wpXT7sv03fg4UX0MwDcu4grVOO9xD1GZWaG8lfc0nEzeftpC8ly354Az81au8Mek4x5McvwX1Vo8PR7WqE45BIx4rsG3vloifGSYUrplOZyc6yMtUOlaSlv/HDjLbxZoh0hTE2jwoicuHu0WqnnvEdWWfMvwBucmmO+4Bl5qFT9YnpqziaIzyPyiqjAiL2hD02pn2BMB/bmnukJxat0KalO7be0Q6jmHMkDomic1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB8347.eurprd08.prod.outlook.com (2603:10a6:10:409::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 23:57:32 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0472.005; Sun, 27 Sep 2026
 23:57:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Eugen Hristev <ehristev@kernel.org>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Mark Brown <broonie@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 0/5] mtd: spinand: sync with linux-7.3
Date: Mon, 28 Sep 2026 02:57:11 +0300
Message-ID: <20260927235716.1872707-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bac173-6479-4ae1-51cd-08df1cf3181d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|366016|1800799024|23010399003|10067099003|11063799006|6133799003|18002099003|56012099006|38350700014|921020;
X-Microsoft-Antispam-Message-Info: TvBGAl/0N81uIU8xKdArFf8So7JsQhmMPUwFXjLu7Hnk0Bp3OpZYS+v5O4lNMVxicP4BiqmGsqglEP6CE6xs0zZcQmlonBXk7oE0MG8BtDnjJ1AKJM23Vhd6IW7tskgD5eBh+/DhOlgVJx2HpFk+3euwEVrdPWuID9m1SF6YL2fpODpNdKRsHBw4pUYDicHFgRC+YJT0kJxT0BFzyN8W3vH5QBymqosFXWGOczQdDqb+Uk1xF9waRUivoDbYZkjOCN1jzKShLSXG0YV0QMm/9QB/NewMHF3eY1X+DkfDpaIViV1CI7PSyNMAbHhka8eRe1Cb8FeEsAx/7SPg81s/N2LERsyfGwCDlHH6EmiqoECGFEzAh75h7ms5j3dUFxx6UiwlUeQH7JTLuNGz5Lst55Kx+uGiSTKC1PfJYmLTPLnf41U6paqG2mKblow3TMdI8POD2gDY3X/78kyCZtM0e5IhJrepfZdlfsG2DOF4WMdbBcpdtnTlN41lRwpSjK5KtJE57A0R8Q2xD1sSt/HfZ3ghjh+8YePoRLbgHe/eGealHVnRxX+Seu3sMzBrc7axrlXVE2gmY++Gz76PibmrizmuqR7i3IC9kfq8W39mnYV+/jAkWUuCdKb4E73OECC1xSg5xU1IQ07OxQ9ECQZIOb4z3ykyeNGLzuLnE1SFajmg885KFbofXVlJ9onDe/rTVkxLH9NNgDaeoC5TD/z16K6kPPYFQRQ1aktn+VIC3KjeJIvIObeuot4iy6pNL8o2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(6133799003)(18002099003)(56012099006)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0+ixoG0qfnCQdegh/9hk3NoTtcS/Fp2Ewjg6O2VOmUDKGvY4qCI5DWeDuG2?=
 =?us-ascii?Q?8n87GLWSfJRdgvEeFuiBseSPmqE9PkSiLTjdVpAmeJJd95TW3+IUaQQuyX69?=
 =?us-ascii?Q?5YBLgabozJVbtKL9Gt0ZABI6ta+dF/nF0ylQGK5bnidNGdlwj49mF9aNELL/?=
 =?us-ascii?Q?nIDwp8xpHLxFYKnMW4LYFyAiFNfLJ7aLpQD6Et3lH0jdo4LR7zldCkKTjtzm?=
 =?us-ascii?Q?jHtvQOC4kbtXvSB/c+RQAbU/NmphjJJCRnKLvSixEqS+9azUxXC1lGSLM1Xq?=
 =?us-ascii?Q?2jpjEtR4uLINZS8LdiTLySqFYOAbOPPjWUZrY1rafUUnRWbFJMQ4Dc/FLnrg?=
 =?us-ascii?Q?HQdqAYNuDDB1UgTOw9z6nqkadLi5MsHl87PFCgn9FIH+2Vv/9BH80jDdvlIs?=
 =?us-ascii?Q?IOj+dSXDJFIfP4OppdSKxJRcz/1fwNe96DYv2UtgQ9j+3aD+SxYztSCbjZSD?=
 =?us-ascii?Q?dIBbTNktP6acTByUdxMcOXQxo1B6CJ89sfQM7g25gp/Rt7yCTWFBP82VpuK+?=
 =?us-ascii?Q?xWFdFOAwvflKToH0PsVNp5O/ug9R8fTanbr+RpE0bdJ+6iGRRZgWqVM/+f7c?=
 =?us-ascii?Q?SGMVzMnlRRmbFjNjXn2+4zU1wX/fj5N7xNKYN/iQrOXYfXDJBzH8Ynek5lZu?=
 =?us-ascii?Q?HsUuLQbjXTLfJe9+4BJ8Q+YbomIjiAJ6VG99ItvxOr7zM94mFIq3JupxYNtS?=
 =?us-ascii?Q?IwsKN3MXpV1bk7XOBvH+qyt3LpqDCuTxKg4turTwU1kS1uLdPgYiPryFTxfq?=
 =?us-ascii?Q?IM26u4XBr/9u429xVTQ541m8ypHs5XQbLfdtn16KFgBiXudADfruwWVWxmfc?=
 =?us-ascii?Q?xmGg8TBRizpSh9owS6XUtm2ibkK7jDyjsgExNHcTk7rKc4IPLNOmGDrDNCWH?=
 =?us-ascii?Q?uK5NzYjoGKpD8Dk/i+TjP11mLbAc51ctlXmPDjwr9WHcf2drVLHPaoPH3I+L?=
 =?us-ascii?Q?bvOhfk3vfss+c+7LSGMBR4KVCCceGfHhInmsQ23eQ36scKH4yXxI8rTJQJDU?=
 =?us-ascii?Q?GLuxzxckrhYswAdGpFvRkGg4QdVfxUCartZ36KuI+7QTcghF7l2LLFKfWP87?=
 =?us-ascii?Q?tkulp25dr2vISP4lN198g2RlNvJCaOy71eO5QU6ISO1olJYfsGFm6aORrvHy?=
 =?us-ascii?Q?guZprTgIdqi7k/exLtZ+3bL4Sfno8ja1IjIzaJYYBBJwVWUR/yUD6oLT1cVK?=
 =?us-ascii?Q?a1Rz+mCaN6hawfDaI5DW+VQv27Dcc+UEPA8v4l7Gllco0uXebzamI9SF+Qt3?=
 =?us-ascii?Q?SQLYtGXGBk5knVj1l0ROPTsLeFAVEMFbwWhBO11SUusPnd8D5aURPqPzNELY?=
 =?us-ascii?Q?ZN/yGFcMba3PrZluzZP6P39BYP367+uthD4lLNZq2eCuEk3SGCWh8vHiv0Si?=
 =?us-ascii?Q?Gz2ETdlVLWLyuF8PS865jszQUUFw+fO2aHfgEBPGOWtCt/7IVzkKlRWhzWyx?=
 =?us-ascii?Q?qJD2tZvWtsbMetFr4W23bDk66gkk4qF8DMta6FRvjO493MfeZR2G38UWIxJG?=
 =?us-ascii?Q?AZbHz+dTH6JzjS2E9eo7rk4zobLYmuYfpBMZJ7T+ZpnOblrADXak1GQ6I9IE?=
 =?us-ascii?Q?wG9+4PIf/DWgQxmCYzdUHX50jioFg/Z118eKQEMkkkGr8OnhLt7sFG7enged?=
 =?us-ascii?Q?uvUaLI04k6jcf0WF1mrNrF+zoKlNFsccdfkXUtW3pqN17ZISce2wiMKSs58g?=
 =?us-ascii?Q?U0P0+jcfh0o2hoN+eoXDjqTLusbmlb2ciu4Ujdr8TOuJX3ISBmtrcFwJT3MA?=
 =?us-ascii?Q?FVi/0kgkIbuWa8KjE9/zKxGx9NyeKH0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bac173-6479-4ae1-51cd-08df1cf3181d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 23:57:32.1500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6wNEcWzVf5UHmT+O6iHPYCwqMx+x2zH54x1YM3d7kFzlvIUgiSC9U8kQS6VxM7oIna09RP2wNPRnmabJVXRaewNfcYF4LKApbGWBQUcKZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8347
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

This patch sync spinand & spi-mem code with linux-7.3. Here is a list of
major changes:
 * spi-mem: capabilities were added, so spi-mem or spinand drivers could check
            spi-controller for support of specific features
 * spinand: continuous mode improvements
 * spinand: octal DTR support
 * spinand: many flashes were supported

Mikhail Kshevetskiy (3):
  spi: spi-mem: add spi-mem caps support
  spi: spi-mem: sync code and behavior with linux
  mtd: nand: spi: sync spinand code with linux-7.3

Miquel Raynal (2):
  spi: spi-mem: Transform the read operation template
  spi: spi-mem: Create a secondary read operation

 drivers/mtd/nand/spi/Makefile     |   5 +-
 drivers/mtd/nand/spi/core.c       | 504 +++++++++++++++++++++++++-----
 drivers/mtd/nand/spi/dosilicon.c  |  93 ++++++
 drivers/mtd/nand/spi/esmt.c       |  30 +-
 drivers/mtd/nand/spi/fmsh.c       | 175 +++++++++++
 drivers/mtd/nand/spi/foresee.c    |  34 ++
 drivers/mtd/nand/spi/gigadevice.c | 117 ++++++-
 drivers/mtd/nand/spi/heyangtek.c  | 132 ++++++++
 drivers/mtd/nand/spi/macronix.c   |  87 +++++-
 drivers/mtd/nand/spi/micron.c     |   8 +-
 drivers/mtd/nand/spi/toshiba.c    |   3 +-
 drivers/mtd/nand/spi/winbond.c    | 466 +++++++++++++++++++++------
 drivers/mtd/spi/sf_probe.c        |  22 +-
 drivers/mtd/spi/spi-nor-core.c    |  20 +-
 drivers/spi/airoha_snfi_spi.c     |  10 +-
 drivers/spi/atmel-quadspi.c       |   5 +
 drivers/spi/cadence_qspi.c        |  10 +-
 drivers/spi/nxp_xspi.c            |  12 +-
 drivers/spi/spi-aspeed-smc.c      |   8 +-
 drivers/spi/spi-mem.c             | 150 ++++++---
 include/linux/mtd/spinand.h       | 198 ++++++++++--
 include/spi-mem.h                 |  53 +++-
 include/spi.h                     |   1 +
 23 files changed, 1845 insertions(+), 298 deletions(-)
 create mode 100644 drivers/mtd/nand/spi/dosilicon.c
 create mode 100644 drivers/mtd/nand/spi/heyangtek.c

-- 
2.53.0

