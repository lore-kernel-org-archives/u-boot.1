Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E0AE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 11:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D786801CF;
	Fri, 13 Dec 2024 12:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Kfcg3mZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C58380141; Fri, 13 Dec 2024 12:00:55 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119E4801BF
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 12:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+j7QGbw8EfrKBCDxTIlIls0ljuiacQohYQI/IDghdqZMZcc9BnWkuJlQby7bBBemTYD5SNIeXq4ugBJ6v8sFCazQKLAAMFAmxFAzuXlcz1yG4g6yzvB2eALpNEQG9qkLpxlqNf0KvYaRDY0iWdyEKDrjg+dPs8Ks/4ASnAWwGiXU2TZJccxFLuVrK9r/ezP3jdSQJGByMywhf6rPM0jkruxueEdoo2IoVQ4xcMTbiKujoOYS+vbNwNXEKHx41TYpN08XCFHa5Er/pKiqOgZ3M4oQdxoCNwa9gAa/3WxjNwLgvyQKnY0AK639Shi5tuaE/sXtLQ+PV94grbDdlqLkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpsn20bhCdmAUjRqUfVypGGC8egspgwL8QZOLNe29Y0=;
 b=d53xqCyZtOQgZCJzeW6woJRArJxZ+tsG9hQESCruYikV3zwKm4yAnGQgdAEV1RSKLH0BWRXPe3//HLAGkeuRmpsZsPrJ3NU9jOtJKCdfftdZtkXDeIkQQH4zZjokjiFMPBupI3tkaFJOLeMzhuCG3trgxfQ8WedB35j8n9eILHdefeWRsylroAXPGDihNSUnemzitg8YJcjtPch8qwcEGPt1HkgBCFzioeUUENv++ZSJBcA2fEdQoNnZlIbo+jxUL2EltgCrcVVcZNzrNOpVaah0IoFJ1d5aoPDp4ZYYV6Wajxecw48nkbBssWiJZo+Op/L/M4xd0lrkocn3ebdQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpsn20bhCdmAUjRqUfVypGGC8egspgwL8QZOLNe29Y0=;
 b=5Kfcg3mZh0suCJG5o32gSwg9HhmSuYSLwCci9NkJeSHajjnvWbGgobsrjFUnaigNNTXmIWrs7OkPURV3G7RZjjsv5MWSKXeDtGWyKqKE6wZL+ywvCoIo+AvwAhckQa7+zT9x2/FLUuu9LpVBzriHzvdGb7/xLbJ3CoG5LfFNles=
Received: from BN8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:408:ac::46)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 11:00:46 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::3) by BN8PR07CA0033.outlook.office365.com
 (2603:10b6:408:ac::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Fri,
 13 Dec 2024 11:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 11:00:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:00:45 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:00:44 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 05:00:41 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v2 0/2] cmd: Add support for optee hello world ta command
Date: Fri, 13 Dec 2024 16:30:32 +0530
Message-ID: <20241213110034.1113036-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: af8e884b-4db5-4380-7b64-08dd1b65656b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pT9H7onlAtsCU/8p54rneZtJH+mzo8ZcJOJp5GNhuqZXKGalSArA9EZ09rqh?=
 =?us-ascii?Q?rYcfixgm+7TJ3TNj7kpd4ZZ/JjBqUmwXeS+ONhs/vwwyDVb5D5JBhhs0R/oi?=
 =?us-ascii?Q?GfQQlnfLwsYCC7LgyFD6HCc0ac85CFmQzWsXJGXkkcLsM2ajbWdbPHIfZ2UC?=
 =?us-ascii?Q?PXtlc+Cm50fduJPLrgjFPP6JOZK293ddveGgDMl/3vYPOEdsjRGQsMbS2VK2?=
 =?us-ascii?Q?IxadDyx/0B2pTOgiVkZ5DXQx9dTkvxJnw/ZOsWZZ+eiTS8qREnFnzp7O9Yc1?=
 =?us-ascii?Q?rnbBFQO6/IDvRRFd5+1UyY1BH83pbyb7E4h1mZFli5cFzfFHBlOFke6aW8g9?=
 =?us-ascii?Q?JRPU63jbN3aZZEupKn/xlDEc/QuyxSPCCJOHNP/y1Y4rzK6aO8Xd4QB5Getx?=
 =?us-ascii?Q?DvKQwFfyJnOQ7JXuAo8XiR8Luq2865xSZ8akg8CkdLnkMoxjWF/MBRbXHCw1?=
 =?us-ascii?Q?8XtT7jqEICxpHijV0IfK2fk4i0DnQMS9PW9kgjH1q7kdD9Y7vUXoOguCcu4q?=
 =?us-ascii?Q?eewzsFU2fc44hAHNqxLNQbMVENj/+2GTFbSC1Umwl8D3uxA5uuFoOJCfkXu9?=
 =?us-ascii?Q?3WxOshcSL+HBjP4CC+6XhlAMii1kCdZJwAvtuzcduw4AmFKCU1v1FWvIBPqV?=
 =?us-ascii?Q?vCKE4PiSUgrgmsJ7ffw72m0jrpA/cWorhysEg13aUj8oQNRsg37eskapeLAs?=
 =?us-ascii?Q?JUn+X7OwUlIhSWAprbFE82UOJkvPje7urmxtFLHPKjVqLJf1MevA8wAy/8IY?=
 =?us-ascii?Q?bPMXPtATCkrVZoX5x7eZ2nU53P68RQvMVF8q4GMW3e6Em7TnRVWEVapMvY8e?=
 =?us-ascii?Q?qtmBrQpDCuybg/QnOzBtquuHktqxkkQsX6zNtfA4Tfn7A7DHRZ2sJEOsscW8?=
 =?us-ascii?Q?vCo+r91z2mfouDPAL3nQJFlb5lq0RYc8M9DnlRyoTTAsMtRCbm2kbz50vc3z?=
 =?us-ascii?Q?uiTFQK+1srBwmLvUeIqfBbJVnAionYD5FM1KL84gTPF70KbyiiC2Y1V1np4K?=
 =?us-ascii?Q?Mi7RheSXR4QhmBI11TcN4NhhzP7gEAMrxVX7jdTLDEWoUUuQ4LFdci6+QY1s?=
 =?us-ascii?Q?qY3drPLH0Bo4zIP4jKQe/VkLxPNHNg2gMGG6WqkR9uwNDzgZJeuoKOKYCPot?=
 =?us-ascii?Q?C3V82JsnKBSqoDYiAO+G71oSCGrN/qwlUEY1mTPj8B0kGkYjGNZCXdEGPlER?=
 =?us-ascii?Q?BZjjTP7iNa3mOXbwz5Lrr+NZI00oleKKJP5dvkh04AC1/Rh3LJ8b0Cmggx4P?=
 =?us-ascii?Q?Qr5E6AqLWXvOvxCuHB5IFFgw2NCXFtisJSYg46rClqv/JpAnqocyMXAcaUks?=
 =?us-ascii?Q?F2oWswNHibxkU2Q2EW1xviGev/OMdTI2q0BD19+8QmSllZpEZqDaHIDWIvvr?=
 =?us-ascii?Q?v097NwWMk702JNcTwjfKAPtUE60c6MpW7e8tvMykH3XWGlx+QdLYEWLvXPCg?=
 =?us-ascii?Q?HWW8qjLMdLTfAMr8/qw8xJ0xvf5yIh9V?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:00:46.3043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af8e884b-4db5-4380-7b64-08dd1b65656b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

Enable "optee hello" command which increments the value passed.
This provides easy test for establishing a session with OP-TEE
TA and verify.

It includes following subcommands:
optee hello
optee hello <value>; value to increment via OP-TEE HELLO
WORLD TA.

Changes in v2:
- Added command "optee" and subdommand "hello".
- Update the man-page in doc/usage/cmd/optee.rst

Venkatesh Yadav Abbarapu (2):
  cmd: Add support for optee hello world ta command
  doc: man-page for optee commands

 cmd/Kconfig                |   8 +++
 cmd/Makefile               |   1 +
 cmd/optee_hello_world_ta.c | 104 +++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/optee.rst    |  75 ++++++++++++++++++++++++++
 doc/usage/index.rst        |   1 +
 5 files changed, 189 insertions(+)
 create mode 100644 cmd/optee_hello_world_ta.c
 create mode 100644 doc/usage/cmd/optee.rst

-- 
2.34.1

