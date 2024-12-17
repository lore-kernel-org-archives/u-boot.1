Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D95E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6979480250;
	Tue, 17 Dec 2024 09:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="dYl5KLVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF72F80243; Tue, 17 Dec 2024 09:32:21 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7AF801A0
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtbBDvkCFXZ3yTdL/m7OiFmj9vPlhUHDezfuwJKYYjVugx9WK16YciF8BF7NTZ1tFfaueNHo5d5+NRn++/ZLI2IGsJ4FVpmHaWpHEd7Ne2mOWSP977TbDKZxHWKexEC/TTptFKEnkFAmb/DOxuHPAC7KGMLmugIiED+QgKSziGrfjOB8U0FtC3x4vs8OHYue8TjzXvgWE8OTH5/rOR/eVrt9pV09vctKz8lX8k+cFzOz/urylQFNz9r72VDqiLSQtZJG14Xo9h8JAdquQY5Fewhpg88AdHSCqlhY560gdZK25U6BbIIzMg0uc/3wkK5vH70u65ucMSayQ6dFmtJTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqyID4A20p8sFFsGsD25NjdSIu7R5k4RxnPuLZTMFN4=;
 b=e4/r7oiXNCpzD/188xVs9bK8e52sO0HnnFKWdHkp7taJ4BgLAMkCeIqjB2gYMcNQPsBZqUlYH9snWn3ZexXSOYGx2Wd5oaSpoV91vLKFZxDNC7vAobl6kIG4ER+EhlsOeK1qUSm7eNY1G2Md84Uqb2S5u7l229uTw9so3wWorVZE649WUUC3CGwUtvcTyMkKEXpj9Um2NOAKWofZClxmvwsBh/KacOPUYqxEv01VUAYhseFQ3KYMokX9GYBbngaeNpJMYU1MPAIvKFBLEybnRW/WVx6l4ReRgU5FN6BNiGgNSILrqWm9eudTPjQMvZ9ROpxXY3NbsdgYaX7jq9Gjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqyID4A20p8sFFsGsD25NjdSIu7R5k4RxnPuLZTMFN4=;
 b=dYl5KLVa81sI8GEJ01luZdldEJiXrBInHL4ED/YfQ93AJ8HiTOtKC4a6qfczLEHUoBREfdAZBsTqYIV28xaCswbAV3lxBQg0W5QQwE+KXufhDFJUDOc9j3QNFLABD6fEX/YAuAb4qS2VlXZz7j1p1n/+EkumT/dOmF9TQjGvBgM/ZOfmbAmFzMAortXVc+mGsShXR5WfJ8Hw6N+bDhTWwEhU6r5MuQwGHwPEawLld2b+5TpRPTmMuIo3fgEps/UzQ76DhXs61JzFj0QSU6+HkY+JHqDP0+nUKR1r3jl13QpQyMrrGNuHCXnQ0CsxkcFJm1tZhbsztFPbxDX+YEM6oA==
Received: from GV0P278CA0055.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2a::6) by
 PASP264MB5696.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:49a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Tue, 17 Dec 2024 08:32:17 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:710:2a:cafe::76) by GV0P278CA0055.outlook.office365.com
 (2603:10a6:710:2a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 08:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 08:32:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7C05020213;
 Tue, 17 Dec 2024 09:32:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 0/9] add the support of sha256_hmac and sha256_hkdf
Date: Tue, 17 Dec 2024 09:32:03 +0100
Message-Id: <20241217083212.70330-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PASP264MB5696:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e2277fa-8aa7-4376-78bd-08dd1e755088
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DnP27RCJaW8KYDB1CzgYjQZK1wOpFI2sBR9pkPKA0R1HL2ibboVM4pdQTy1Z?=
 =?us-ascii?Q?HimGa1BT41tFKZ73neyCJO/xkkoebgCo43en8OrQlrpHhiVDSQSL6bJml8uv?=
 =?us-ascii?Q?7Uk9IE7Kv3Ih0pK/bwxuzGSpmbY10LvMmYubLTR7oUZjj9BTR/+K6acKL13/?=
 =?us-ascii?Q?BtC3WWHHWe7k8siXuv4XsOAaCB3t2u1z8gMI4Vk8TI35EOG+1drCCH/uST3d?=
 =?us-ascii?Q?g06WLdDoAXAoVjnM0grLMTU6PLQ3Ky6J9g7fxJw0Y+94ditUB0dOrkkJTwyz?=
 =?us-ascii?Q?/bmQ0NBbsLo8f/D4rC0+V/IVjqoBN4qDIvGIDnNkNq2yvoeHNAOn8VCWNvVA?=
 =?us-ascii?Q?l7zlgA8V7fgsuvlCVujLuEVIz14EW7NuSWRDLCisyLIshUBWGyBsx+7ApqHM?=
 =?us-ascii?Q?yhy32I2XQvvCs4POrAN35WIJi7JorHLfIewp8IkXeIusxZ1wZTjkHEr19aps?=
 =?us-ascii?Q?AinPZiIe+o+VasSzBGVI1xygBWCvIDbZSXksWMhgIuuzC8ZLcOjuqGI03foG?=
 =?us-ascii?Q?UKhBj2U6zGmDoW0Buqyc8eW7/NM2HQieWLcVzqpcr1v7BbyBbCNzpkOCLyZJ?=
 =?us-ascii?Q?FFRpr/UyI+NN9drt8B6cCjQdC0SmjP3Wprg3p5pdmaCL48W3m1C9E+Zne7uu?=
 =?us-ascii?Q?neftdexBNv4EL2kJUgAZ+C0zEJ9ytcOOYMg7dhJZdGGH4aygMeonDK+zKh0D?=
 =?us-ascii?Q?cWj5WF7xirvL7duFrmE23LY30OORVYZD/Qj5wYnK7ZHMii0wT1995YkQyfuL?=
 =?us-ascii?Q?5dizcIewnLe5kOOWbjRPbcPLiQdDS//feIPoNFWDeea3T9/Sopo+iGMGvv2d?=
 =?us-ascii?Q?gpexipda9VJbvmqy8VYiQKn0kgz05VniVASxfU3CBm4E7ioUyPcvaOAQwJit?=
 =?us-ascii?Q?NHvawlhP9tNZGL/77Ax05r4ki/U6iv27GAOSrJgBxzPyMcuNBM+EcIp10UZH?=
 =?us-ascii?Q?ArUu7aXWxhYtxscealtaioVNdEdGSWFwqWY6LGGvogvcV7oOiP86xmNms7S7?=
 =?us-ascii?Q?8YhlsjVXqF3BlaukZBj/Yn/Q8B/0RrVExP5RZmMQaCGHK0A38frPfSNBzceg?=
 =?us-ascii?Q?nsxdcTTo1NoMW/TFMUEQDIvTAgnvikTzyejPb0YbF2304mo61fEG1onJjShH?=
 =?us-ascii?Q?nU1HtjV0lKlM57wm8fhQu9jw453kj1pYkoHTC2YLYrwSEKtc9gjlMq+nnA3F?=
 =?us-ascii?Q?SJvmnajm537RlDhnULymt/BOAc7IFPSzeTzh/bkO4xMaPiBPybp2MhE98Azn?=
 =?us-ascii?Q?3QniA2eu0MgTCW9n3IPFMUtWmMAi5XzlD7yeHa8eJNDN30Qa2Eo/A+N0zFmB?=
 =?us-ascii?Q?igm3KsMRrvNe/Jk7kw8g2vfD3+IN5QweAi74fCOuVJnVs91MZlrXtwPgrGio?=
 =?us-ascii?Q?FPrTnjDf8qXc/XZ7+i2iB5z4KYMZsi9nvcSKPguSptQUHfaUGRtZceP0/Lzt?=
 =?us-ascii?Q?+LGqxLoTbfX2EEArOTENHR1sJhL5RzMlW8TP/wOq+3qTElOrp3emxA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:16.7137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2277fa-8aa7-4376-78bd-08dd1e755088
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5696
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

This serie adds the support of sha256_hmac and sha256_hkdf.
A first version was sent several months ago just before the 
integration of mbedtls. This new version is based on mbedtls.

The first patch of this serie add the support of hkdf
using mbedtls.

v5:
- use mbedtls to compute hmac
- add tests for hkdf
- enabled mbedtls in sandbox_defconfig
- some cleanup

v4:
- fix computation of the hmac
- add more test for hmac
- move sha256 common functions to sha256_common.c
- some cleanup

v3:
- also define sha256_hmac for legacy sha256
- add some #if to define function only when needed

Philippe Reynes (9):
  tools: kwbimage.h: use linux/compiler_attributes.h
  tools: renesas_spkgimage.h: use linux/compiler_attributes.h
  mbedtls: enable support of hkdf
  lib: sha256: move common function to sha256_common.c
  lib: sha256: add feature sha256_hmac
  test: lib: add test for sha256_hmac
  lib: mbedtls: sha256: add support of key derivation
  test: lib: add test for key derivation
  configs: sandbox: enable mbedtls

 configs/sandbox_defconfig        |   2 +
 include/u-boot/sha256.h          |  24 +++
 lib/Makefile                     |   1 +
 lib/mbedtls/Kconfig              |  14 ++
 lib/mbedtls/Makefile             |   2 +
 lib/mbedtls/mbedtls_def_config.h |   4 +
 lib/mbedtls/sha256.c             |  59 ++++---
 lib/sha256.c                     |  66 ++++---
 lib/sha256_common.c              |  50 ++++++
 test/lib/Makefile                |   2 +
 test/lib/test_sha256_hkdf.c      | 197 +++++++++++++++++++++
 test/lib/test_sha256_hmac.c      | 294 +++++++++++++++++++++++++++++++
 tools/Makefile                   |   1 +
 tools/kwbimage.h                 |   6 +-
 tools/renesas_spkgimage.h        |   6 +-
 15 files changed, 668 insertions(+), 60 deletions(-)
 create mode 100644 lib/sha256_common.c
 create mode 100644 test/lib/test_sha256_hkdf.c
 create mode 100644 test/lib/test_sha256_hmac.c

-- 
2.25.1

