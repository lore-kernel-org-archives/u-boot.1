Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418CDC36018
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F9CD82064;
	Tue,  1 Apr 2025 10:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="NPs+vOjY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F6A82012; Tue,  1 Apr 2025 10:47:00 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4FA82051
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvgg/ojq77JGI1aBFisO63rWI9ADEvqw/PnjIMIcRXoFEOStLPSmiBv4bL/95axhr3jrtKNgUuKgX88aLPq8XK7tsKSsvyb9APrHDzHRzoI/efa+wb458MG/Fu+uu5I4yMgoUlyWODTrxUKBKGL/tFgs2EKFHj4lT9y2xMMXb/BFT/0dqHYUCzyM7mfshu+vK7U3CBATjgdq7LkdaFEirYJj0mnLtCXQIWl+hnw35xsyuKH1RS8UVzhKx8slSL5HiLSTL4luB3hHBhB3LyDfsLwtNqWYI/PbouDPl4hnYogf5MnssjfpJcy6nz25NyS3ULmT7Pbi7L/rRRP3lbWMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCf6U7wgwDFHVE9WPuRTMtP8g6uVfKGxk26ffMJDG2c=;
 b=sjLWauBfm2aDdMm96IXKrNlQf6mUDLhmSD0POtGa7PUheMY8obLvUhSkeDwV3R49rrPLeypKrrwdSruH8tcEblKZrV+YFEys30rXtkyzgQo6dqR5SmmqQv6SN+cAN5KhIP5nftVvGeax0qCsntFnJenUgDgyLUI+usHl22xFtL1NbYrkKkaeBc0Zbu/VZgmTAZCer5cnhlTyIZLhrPtSsPgYx2R5nip/iQtlzbi6Yt7SzQjS/ZoYmCydl6nvfyNAd8vhzvKnVsd+Mvtdkcjtc2Un8ceegsMzxMkUv/gW3bPSGTEdrhI9Ugv6Xzl5B3A55On8o6IDXzBFzTnm7lWVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCf6U7wgwDFHVE9WPuRTMtP8g6uVfKGxk26ffMJDG2c=;
 b=NPs+vOjYkDbErtxu6g+ejDYDSFU+f7uXwh8KPEHui3y3382q1zqeYMy/meRbmut/lV5qdMV056zyU/Z4sUs6gpnCzaiLtCBfpMFwSEpt24dnb+Nt4o+c5EDbx8INujVJ0zSnjFibr+d+xrR0CuVbVetPB/7Ul5ar327CilAYSygMJS+Bdp01oUI81P/x46KDEshLCAr55qV2NdNrtQFvLIa73rvg8FnmIfX/dgIVYaLaKM27WsY9NIUGAJgjg7PtYN+OY+Jt99OQxUu49IHL23pjfY+/iND3aQqguvd9UKHqBvEZX4+QYxylX/ImMn1U1VBdsfb4vlJ2Mw7MC+w1JA==
Received: from DB8PR09CA0001.eurprd09.prod.outlook.com (2603:10a6:10:a0::14)
 by AM9P195MB0854.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 08:46:54 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:a0:cafe::27) by DB8PR09CA0001.outlook.office365.com
 (2603:10a6:10:a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Tue,
 1 Apr 2025 08:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Tue, 1 Apr 2025 08:46:54 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 10:46:53 +0200
Received: from llp-anderweit.phytec.de (172.25.32.242) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Apr
 2025 10:46:53 +0200
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <festevam@gmail.com>,
 <marex@denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 2/2] CI: Build missing binman tools before binman tests
Date: Tue, 1 Apr 2025 10:46:42 +0200
Message-ID: <20250401084642.216933-2-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401084642.216933-1-l.anderweit@phytec.de>
References: <20250401084642.216933-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.242]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFC:EE_|AM9P195MB0854:EE_
X-MS-Office365-Filtering-Correlation-Id: 40067810-17bc-44f6-6e70-08dd70f9c0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cH8PP/RaHXZzN5oTArAOHsfXh9872z+IylXoTKjF+o0SgZW4o0+hxX4lyMxT?=
 =?us-ascii?Q?0J/lkZ4uw49qHGR8N84sSgHv2anjsgExrgXCY3BIovDcaxMjXGKcStyyBzbR?=
 =?us-ascii?Q?m7tCP8/EcJuI6L9TjuprgMZ+ktxScgRoTH/x9CdYjRTL5QLy3Er2usVoM8XM?=
 =?us-ascii?Q?HAxxfkxiLita0/9I667wVBginQAtAa8AOqoOe5xGUutmHzhfOu7g5CJvh30c?=
 =?us-ascii?Q?MBEEfOZEjLqF68nGvHbuHfwB0mK1ofQqaW3e2Qskpa31j8y+IO7CxiUyZwv/?=
 =?us-ascii?Q?wOyRRLlwCulk4+BIjfW5xcQVggHUzifUwC2NWQ7PqFBZB9U0gwknoH+pkEav?=
 =?us-ascii?Q?zzXU1IahgMyhemuz6Hht1DiyiF4gzDSn1LWp4QwNE9XtkeHv7upYoYrS0vKx?=
 =?us-ascii?Q?3hnX3YdMNQihL2GXIyO02OqPqVLZeIqRoWBU6+aQoB9Gsd5AWCCXLEhWNYZt?=
 =?us-ascii?Q?MDMUJFTvz/YUFp3CDoROp2cMtV3/WSROi57pNLYYTWsNTdZrlhL1mL51DO4P?=
 =?us-ascii?Q?OM/X0twl+oEjVgvKOmiURBUqHQWsdFtcsSgaW87hY98Zj1p4406qXrKj81dh?=
 =?us-ascii?Q?YTsOIAL4C7etqrOgB7VVsuefB8hUyXRdM4tCuY+BkQAvVDCGmM4tRR/gCceF?=
 =?us-ascii?Q?XZmFfaE4pGM7qBOEi0EZAQv0Y/B3Ll51boY9olnU5U62Pd153HxFGTNHyb7U?=
 =?us-ascii?Q?5TUOdAvpAGt4Hfxju6QZ6kl+W+FGiuN9K1uKA4YcpQ6z7fD8Y6L54p/IjEqS?=
 =?us-ascii?Q?6M5Rt+lTOyu5h41UvYejkx4SoBeTZ2A6blD1faapnHayTR/LW8KDSrPFPzUK?=
 =?us-ascii?Q?yXOEGCbtTTf1aqW5+WmOiPb4jya6LhRrcyr1GM+bZY8LGOY1N+KWE5ye1fZC?=
 =?us-ascii?Q?5c3aDOUjU7EhqgekG7Vm/5p12xU3+bwj6fpTLsjJFOnCH+ffa4H7Ul4Wh2Qt?=
 =?us-ascii?Q?SDz20hzxR98IsNr5EHg4Xk8nxpG2QxcOraQkrUOSyRuJuQyHL1NO4r/H0AnO?=
 =?us-ascii?Q?q4W4i6grKCxjpxASt1lAkGbiafXO4qJuzkAiRIXLAQ578hzy1N9KsaJdRKxA?=
 =?us-ascii?Q?I1wrnhzZ/ZHIxPFYoLB1PrFauz9u8uFBtpzpfgKw5bbKFhPLiQJRtpccXYnV?=
 =?us-ascii?Q?6rH0kLT7MyS5gEOOH3D9YRVrotnwnXTkt7BIuZQto1A+d46A5dIDlU+9y7xo?=
 =?us-ascii?Q?51c0N7vLtXYmXeNkLsvLfS399vtek74dlGrLmCJ4pb3jkrhMfUmsZtSGGCVZ?=
 =?us-ascii?Q?PsbElYdERDAFjKq/vzgAtj3ysBCUFQB9dQx906RZYoVvJ9Fkeii0GiPr/oue?=
 =?us-ascii?Q?PnkF9WYIgPGhlOIexmTdcKHeft7dGFc7nMJEm7SqNeSxRqUgh9W5oeYLEfFI?=
 =?us-ascii?Q?wTZgFTgpXW9KoslRFg+cttcjZUGeyGKP45AMdoUcJp+4lMJ2nHj/91w8geSo?=
 =?us-ascii?Q?ZPdju2zJbScB4HS6K/wbtainb3UcnyXPVF3c1C30sLHnopqB1ZouPbV0eN98?=
 =?us-ascii?Q?n71qZEgC7eZ9q3Q=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 08:46:54.2436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40067810-17bc-44f6-6e70-08dd70f9c0f9
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB0854
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

The CI image does not ship with all tools required for the binman tests.
Have binman build the missing tools.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 .azure-pipelines.yml | 1 +
 .gitlab-ci.yml       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index d5cfa59a8a61..9ef6b6564597 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -144,6 +144,7 @@ stages:
           export PATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}
           ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w --board tools-only
           set -ex
+          ./tools/binman/binman --toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools tool -f missing
           ./tools/binman/binman --toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools test
           ./tools/buildman/buildman -t
           ./tools/dtoc/dtoc -t
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 2dbe6325f334..c407e3946814 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -196,6 +196,7 @@ Run binman, buildman, dtoc, Kconfig and patman testsuites:
       ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR} -w
         --board tools-only;
       set -e;
+      ./tools/binman/binman --toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools tool -f missing;
       ./tools/binman/binman --toolpath ${UBOOT_TRAVIS_BUILD_DIR}/tools test;
       ./tools/buildman/buildman -t;
       ./tools/dtoc/dtoc -t;
-- 
2.34.1

