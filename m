Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14629C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 12:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 931E58210D;
	Tue, 29 Apr 2025 14:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="os7bmKwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6178214A; Tue, 29 Apr 2025 14:08:38 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20709.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::709])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F57180BAD
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 14:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8fEjSeOh6uI6UHUGCpqrF2hc3tuzwIxC44nyEd5KHbzEoboHTB+Ckc2EnQ5cUs2Zs6EI40TbUA+M74VJCT2/xSChH+z4/4SS/QEm9Pb4BCPNAJ7uHDvfH0yKUWmbqdMNLWe5P5SZJYftq4m8SVLdH/T8jojkOSFulBHYhLLwua/GBXpuUqn/HQqqTEZ7evtWKHBNBOsxNSFPVUV0sNAZxaspU6EHnDMzvhNsHshAW8pscvzH+xm4fUyM3XRRMY4APvekDwDcDZiBx7DJ41lHh12ImrUcwsL9OPthbB2zB+LqM8xLFsE1PGQDaqs4KpEBjHWN5jFBqaJ9M0pJXHr+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pt91NFrLcjmBT8bIz97YK2vqP01GMHDu0/NMI8BhzMQ=;
 b=K3Qx1ssGoVQPzLkmj5pF1cZkU40WXPfiDF97MhRl0/27ciR//rrZ4rJVKnPMpi3NDgtz5VF5uCEME0pIJ+xM73Y5iTzuHFS4IRsUAmb8XqmQKRpCweC73t9ch7eHoqiv9xgCG0EP0skZqagb2ex1Noqhk80hNCEDkrj5Tjm0S86aYk+CxofB3JIWccFpxIvtVoVbwJSQ1YSMEQi4P8wbfkVvqADn4+pCRSPXJcjW1DIwRGAx9FUYbWZ7/sMgEi9u0oUMZmwCfhzDl7ZFIgp0fqoN9M4CAkNcfwiBYGPt5BeFx9oAJ459NApsfcr+IG2nN6wkVR6SKeZHUqRo6IKwNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt91NFrLcjmBT8bIz97YK2vqP01GMHDu0/NMI8BhzMQ=;
 b=os7bmKwg8ZEnu2ALOcj5GUwQebuzUqaUl6ohsZ77jz1uQqVVnjQuX7hK9zI/1CIkNpWSNpfWfzmY68KSV6Uy2Vw+NHaESFHR27lzLPOYZuBAr3B4mK9zonuzBDnM99wC64RED5vd7oIWnaOtXktyEsPGWTDOerO14SMdqZxa2EFC5zIOnlEuyxaP40tTa5SBoirPPqeJXiohMl7dq5qMg9/TqCmzksbJvrvvyCtm2r48TG5auDcZjLWifyzNHDXKD2z4X6aX8XdovepEVKBLlfRmaPul0+hw1KY7RDJa6Vi+Jyy2myFVEm29JxEBco4lkZdKeV6ip6OyasmFucqzdA==
Received: from AM9P193CA0005.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::10)
 by DB8P195MB0663.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:145::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 12:08:34 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:21e:cafe::c7) by AM9P193CA0005.outlook.office365.com
 (2603:10a6:20b:21e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 29 Apr 2025 12:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 12:08:33 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 29 Apr
 2025 14:08:33 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 29 Apr
 2025 14:08:31 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <mkorpershoek@kernel.org>, <anshuld@ti.com>, <upstream@lists.phytec.de>,
 Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH] configs: phycore_am62x_a53_defconfig: Remove
 CONFIG_SYS_BOOTM_LEN
Date: Tue, 29 Apr 2025 05:08:18 -0700
Message-ID: <20250429120818.3365069-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DB8P195MB0663:EE_
X-MS-Office365-Filtering-Correlation-Id: 120c6cf6-42ff-4dfa-37a9-08dd87169077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NHwzMANBsKiuNmJ6SkXm4BzwIqoD3sIhkeeqFbZGB18X+HknocTIvq17VSZb?=
 =?us-ascii?Q?E3nHdIzEJzxO2yCsJIkjIZp3bgw3aupXQrhI9LnXHySNxrmX09yutp9enxC4?=
 =?us-ascii?Q?tWIHWuvwTlxuCy4OJAPv+GXquvRYFtfaRsdZev7SwVd+0XXMLNYwbTJ5wpBK?=
 =?us-ascii?Q?Keao51obaivSy+v5VAaqcRQQmIVoaTpIN36sEUt/sSpzyvq9ctQPKoBtruSH?=
 =?us-ascii?Q?wfEr62GRJt+xNdTecQZShLgb7aZRIoUFSp3o0HwCPxLNdOOnbBwkhqEKWZUV?=
 =?us-ascii?Q?xyZbSBy5vfOJedgAEAlhkF7SJzTwSh3624o8jSrRGyTt2s7das7yg6EMOqzS?=
 =?us-ascii?Q?/RK+hHbHdPFACjLQfO0uZt/UlP5GxxWls0PxzLHM12mogr6DJtSfhxCwn9TH?=
 =?us-ascii?Q?CV7JIh6nN0TiJ5PQfTNdZxMZcvaAJuh1fn/b+GpCGroWd5pi3slGoS2uF8zH?=
 =?us-ascii?Q?/xyF+eSGVIDw8I60F5IlzbviwPKdY5WFUIHMTbgQzZpM+Nl8aa9q/Kvq53nM?=
 =?us-ascii?Q?UBpM6kJXS7HMdnbmjLJu4GHA4Xg8fmtdcLRq0a0i5jB586WMpY8Ph9qPsOmI?=
 =?us-ascii?Q?vRn69k83/g4Td/Zjcq/M/udb19VVr05u4lPrqLFV9cZBqvRHu3VInMIKr9TM?=
 =?us-ascii?Q?IiORTZSgAkXoYz8njaffUW7F4buE3Sd0nrm+GYVcWW2cwWC7dp9GDVe6cDQ6?=
 =?us-ascii?Q?ZcbBva4/MbmOpG4OUmgVz6JduT5QMPfRDEafbYC56DBFPn7y6ewdHvy0HHo/?=
 =?us-ascii?Q?hnWSb7pjyfw5EeE859e32g6oKvcyd/2U5Qd4zmaJ3iGcvfrtnym4J1K8pcof?=
 =?us-ascii?Q?qsFUYN6JUolcb3hk2Jhif9jlvQ+VU/eu915z5J5ZGdw+8fvLsh2Wc0etG1di?=
 =?us-ascii?Q?8r/OA7XdnxqBFq8dqyt+veeq6J98uJ4j85QOOIgC+MrVeEGtDCmgJirctsYm?=
 =?us-ascii?Q?NtyjsyAQ5+NwPmHPM4YAWf2RP6kczZ9WtWsJLqvukrdkf98v0hoLL92Oo664?=
 =?us-ascii?Q?HLJwDr2NUogTEp/G+EyfJdXhKFjU/1EHxSfs3hD0f8eDR7A4ikEpyRxotwAv?=
 =?us-ascii?Q?dXxVufy+Z9nRPvOLapCQJw6Ur7x2aLMVcCs+9Hi2urNbXxVqMyhCW4/zCEw/?=
 =?us-ascii?Q?mONZyZezpJZuj9dd9QVxg9m04H+n49R/LHSeYJFGj4rmsPcq5xfU1J40j7w2?=
 =?us-ascii?Q?joAA3J8tZvHzTDjc/KAivo+8IKKryDWComf7neoQDzQ8TH6S7XfpDK3j8pXg?=
 =?us-ascii?Q?wHETImB2f9KzkI6D6BmhR7CJchs25xhVARNPhIxaBPyof90lBDtWg4Wi2CEM?=
 =?us-ascii?Q?8pRziVcl0P/IXgDyW3k/dAVjJd5XFwUCHG3XrzNJYuS7Oiok7DRFlNE8VZmy?=
 =?us-ascii?Q?+ZM8bcP5Q8ecT1iqe8YDx1OVmBxnO9fBKp0rjJjC4/bFk8LNDBQbwFcQCIi4?=
 =?us-ascii?Q?zlOhHsnxOLuW17Ceyoa56q8OZn0qlSHC5ugw7tyf0cSnnThYscVy3v8dsV6Y?=
 =?us-ascii?Q?Mzx2I9XhyvDZgaIMw/zXGdbdRIcR0i77zVU7?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 12:08:33.8822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 120c6cf6-42ff-4dfa-37a9-08dd87169077
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0663
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

This config was defined with the default value of 8 MiB. However,
the default value is different when CONFIG_ARM64 is enabled and
should be 64 MiB.

Remove this config from the A53 defconfig and use the correct
default config.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 4ad399893ff..c52a2f76200 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -28,7 +28,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
 CONFIG_SPL_STACK_R=y
-CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SPL_SIZE_LIMIT=0x80000
 CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
 CONFIG_ENV_OFFSET_REDUND=0x6c0000
-- 
2.25.1

