Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D4AEB5979
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 08:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 467F583A47;
	Wed, 11 Feb 2026 09:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tdlyjqwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E310F83A47; Wed, 11 Feb 2026 09:30:33 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314A98367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 09:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8tcWrU2aUns4j5fRjvLbYgxk/MCMtT0Hbj9vADBQZ0nsyunQR5gKC7YTG++UJFe8aACPDgYyRp+zdwLkYO3n1IOZZWpjRB0BJrNk1D2RDN0/mEwVS/Mn7hj/DovWhbxMDEl1zvKCiZEkatk0aglJmlxG19tdC2j1JBGYen4H5nDpXVS3fjKe/8qxYnFswR1nhUXKzIu0WGhTXKVBczDAX783OWBlHLFFRrzEGn1SOcNfVDdxJV5e++l3KYl+fhGy2vY64Z1ai+gIIDukYqjSRYsWma47k1/q6pmK16nBt1Pq5+ECYSAEmzi7pgRMygU3sOGaGh19Eujb66E4tFd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+kMbA+27rF4Jw4yOIyvJFhuHyNnwNrgYaseIRC4hFs=;
 b=yq6/8kfkTG+Bwyi9yB6b2hraJIDqkYA9ooI1Yt3NmTwcdf3poCY4ObwHFNrrov8llS/XMkM3uivq0qXqbfMY0HWg7bV9HtDHaVRS5H0QauhVCuMzqVP/GiTlrtvOdospJDqzzS0ZyfVTu7SWXsl5NKLhyPlkKcup8VoJSEjpKs298mdXdrHb7OP+vFlFrWSSkppqqMhoqGte5CoZAS2AWqPrLPbpW8p40M5vjQ7VUvGuhtHcmbBFFr+WXTTgwzkSWSaSvc+BF21VKqb1IIJkOU3rHDCzJKe33NGB8j2Q9RJzcRmjp3FtU8WA80SL9KDvKwCc7VDqWIElaxzjz71Ezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+kMbA+27rF4Jw4yOIyvJFhuHyNnwNrgYaseIRC4hFs=;
 b=TdlyjqwnlFphh9OJwkb6wfUvssg6FyQLQ2L5DBl4cJKkyBAh5esoZwd3MYW/aFTKdqQSexKqzNj2+DqOQQHOGcOY2CaZMLRoJQh5sUFVUc/sjbcfFjn8uY0z0lNZXmAbQ/mJjqnacf5EWzGOqI58Tel4gTEQXGten2Rcc+G65jk=
Received: from SJ0PR13CA0235.namprd13.prod.outlook.com (2603:10b6:a03:2c1::30)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Wed, 11 Feb
 2026 08:30:27 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::76) by SJ0PR13CA0235.outlook.office365.com
 (2603:10b6:a03:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 08:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 08:30:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 11 Feb
 2026 02:30:20 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Feb
 2026 02:30:18 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 11 Feb 2026 02:30:18 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Padmarao Begari
 <padmarao.begari@amd.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xilinx: mbv: Disable EFI loader
Date: Wed, 11 Feb 2026 09:30:06 +0100
Message-ID: <2b14005e41e0688ff9598d0b3f2cfbdf82c8ff91.1770798604.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=829; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=g+qtqwGaW+TTsELGqPiSv3WkPB5A68jqTnvAFTJQNBI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWT22PHnvGrTcLOtrc5WfR0j07PEtnKaCLPpxaPVwVMT1
 y3JPprTUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABMp/MjIsHr98Q9tQj9fvs2/
 tvLmlteSpxnss/uNmM89zz2/fsIkJz5GhnmnI/z5m5/obHG7rsyxxy1Eanr7WUntpUmPO3fsK5D
 cww4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 9051cb9c-71ba-4df8-2401-08de6947cf17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QpDrGhLX9Qr+13OY9VclmOl5uWCZ4mQwTd+80fB8mqOY17XKj0oZvF0smmT0?=
 =?us-ascii?Q?qayBefb4y7ZmZuHp0ivJs1YDtwIQOCzEjqFnLPuIwvi6D7gy6rPYAVVltkPM?=
 =?us-ascii?Q?8KZMEUSeWUvcqXpT0qczFgzfN4t7ALZT+9ZFW1XCExWHRwwNPFei1rVOgq4t?=
 =?us-ascii?Q?PVZ+EODCqkBTx8mF5LuriGf1w5FS+pKcXfaaC5M+jYRPy7D5UVe9TlAjOmtJ?=
 =?us-ascii?Q?rzzywnb7IhPEElLRrOgcS0CbMOC2jLoG+93+f7eZQ+tt0R+KqiZZW9ijNqZo?=
 =?us-ascii?Q?gonvHgbwmzAadWkGnPbQVr9/k9/KniGb1oaMWIzVlDLn/rsIyRFP2eDmkidx?=
 =?us-ascii?Q?Vz3ywKHnZJ8DX2KWDc401MheScDtoCK0fiEcdt09WKzjpqaS4zoOsMViOsju?=
 =?us-ascii?Q?cpzTrJ9Dfnf4kdQrh6n4S1FkKQ/lEXDp5NAVzTctMiodDh4xZ8W5DWOeaIQ8?=
 =?us-ascii?Q?iUkbegO4bb5p5jlSbijm/65P4WMVPbRzZU2/Fg5LYxsPyfgrWIGECNAR8MB2?=
 =?us-ascii?Q?ofCtK6iw6pVHY6GDCjWKVNy/E7gUFTDwltyPw67E2S8LwAFm+WTsOM6z/473?=
 =?us-ascii?Q?hMKXH8/8fmnNwRg+8sJGAGdp1vhuvVZl87cBd5fp5iNT+HwGqTmndP48dROi?=
 =?us-ascii?Q?psdTbX4gmfV00HbmurI6Et74yKNEjnR6EQqf3K+vIAlfv+eLvwSy4+gPin1y?=
 =?us-ascii?Q?atQ9wuzYRHm8bCO7+Nn63DhJieQCGMzrdYcM0bBVDHlCvHexAMxzbXWifC2E?=
 =?us-ascii?Q?XG9YOfwUEL4Nu+YAMt6PhphypyShQ0qMlYJnu4SCjStJZIWMqclWOxVw6VDV?=
 =?us-ascii?Q?dd45iNZOYKNvbODupu7ma8QD7FglRnvEINqLK7JbS6P4mKnJN54cVeNyPj0U?=
 =?us-ascii?Q?yJ0USaVNEY5MlLX3CkkGlNd8RF0L7Spg6tKZJqbJ2c4Ng1A21XhHsyY4zpIB?=
 =?us-ascii?Q?DTRd9QqHeRDj7l+bGhsyDP/nd+pso8vEesEGDhJraKbgJ9BKs62pWJNvNerY?=
 =?us-ascii?Q?+yn8358LDTNzlSeUnDXc/GPRHIeonZeGcsfwj/Y5Cy6ZiviclqS0LRXssb7X?=
 =?us-ascii?Q?3k4sNEhDYAGf9kDC8aPgUPEm+DD76xAddEmTGxpZjyAGjWZJkpwf4e1Zbtck?=
 =?us-ascii?Q?CgSe5KqygOou2UtsLqx6AROpMsTKHVCXV2LOTuKpo0WgTaWhWoX1aE4AD6eE?=
 =?us-ascii?Q?3pCK4KrIvZ7g9+uTtbbmjYTf/ZOx44TdqIijIgPeZxrDZuhzUqjekQmyr8MR?=
 =?us-ascii?Q?Kr2OFV1HBs60kvLYcR1dhdjPXhbqudyCU1vPKxH8KRsdoPszDEs6fWo92pQ+?=
 =?us-ascii?Q?UACqccn6hF7gPVTjBqYYczqHrUt5EqivgxEKZmYXVWYsnzhgwCUlfuLUOg7u?=
 =?us-ascii?Q?VAfy9ngnydJuCC4+jno1+TO9mIlFxELQMx77mpYYp/qid1WenH7I6UsUgYou?=
 =?us-ascii?Q?KU+rJewlsmEUMlGf8+DoazEKPXyHL/xOWYOT+qo+WzKcTyX3ipzAK69COZiP?=
 =?us-ascii?Q?apGM1qSZ7AS4SBWExG9Z+ETWLx6wWfk0p/sgpjmSI9996dS6cG3QuKgeo6Dx?=
 =?us-ascii?Q?xDLPYnWOty8lz5QZMKNHkkTDO1DoRhZtLA4cP9uSS49qUwVoH674TYvzpe5n?=
 =?us-ascii?Q?Iq7xZaYxtEDTQgyaU6lNyf1Uo8ou398SdcJST9J7blWwRuecvCHT5OItGenE?=
 =?us-ascii?Q?9ZgNlw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qfC6THsDcpzDdwBWgRrXV/0iN2MpL/bIsN6inZF306MUbzLP3ufONfHAhXrUoZYyOzNiUPhtDutDXHZd8/WxrNdzdCHv/eZbUesIAQCFtkxoK2+rL/QHLcYbl8z67i5EbjRRo4eHwrtacTdGMsVn3xJ77CzjcOQ++7bsDEoz7FR9lETZevsa6BxQd5MRHMdI4s/w6fne8fk10BnAwc11nYQXUMU/ibEVSYBS8seIbAlUz7pElc/P5fPLT81OO5WNwCnWVQE72fH3gpCWePCPbSV62tHKCXP6XSk1JMRvKwsC5UkCa8PkFCUJ8YzZVSD4eNH2BQuF8MJLC7vPisor7YwXJcZnLJneyd/cxGyL84f/AEsfNantHi4BYTMgBgpMY+4yEMgvn3WJhlX/4q6vegCkbIt9+YRiDzj0hCqNGEWHZjYuq0Z805oQcMxV2cmF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:30:26.9847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9051cb9c-71ba-4df8-2401-08de6947cf17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392
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

There is no intention to use EFI on Microblaze V that's why disable it to
save some space. Also it is indication that this feature is not
tested/supported.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 42dc5fb282ad..4ff3bd6b6875 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -19,6 +19,7 @@ CONFIG_TARGET_XILINX_MBV=y
 # CONFIG_RISCV_ISA_F is not set
 # CONFIG_SPL_SMP is not set
 CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80200000
 CONFIG_DISTRO_DEFAULTS=y
-- 
2.43.0

base-commit: b247750b997e376ea377a685b69b2e7d025db0a1
branch: debian-sent3
