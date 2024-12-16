Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18931E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 09:30:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 687098005B;
	Mon, 16 Dec 2024 10:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DH15dkzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B43980104; Mon, 16 Dec 2024 10:30:17 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF0B8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNSrTZSOwdCoPyVhyoipw7gaK/Yvsk7itNOzrWxHEjYXpesM12N9aW5QHFvYXNM74jYQ5eIJbiU5rzqMlg4nmJu6yi8oGjc17PacFi2vgVoLBfKWaEUrbW+2EfYLKkN/cZ1lbPy3hjU5TZCdy+jOg0fhSQsu0pCQ556qF1FjwhRlCX3ElqFQLuXi56bPmSc0mgOHgqZS0onzYSLNMbG/0Djbp/fe5kzTd+kbN4W5wnxZdg7ND2lmMSNie+qQOgmzB8tSpc0xc+Gyws160yRtqdSdTjA6gNFowE5OFuJFtCep6+r/cOZkifvKgPrtKcDRDYi5GyDwJo4U3Hq3F8yN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMe1nI6+xBFiDHc+W8wTRcxTdviVLuqn1blz2mfk+9A=;
 b=EFMVwyGeGWkzHkpTUmJCsx1JVZXTfuK3OrIY4zIxNPskJXZLMM+3xb4dPJQ2LuVKp4L3dDwcAom3azR7xmeW1Sn0a1Esw4SDexyq9NwaNVUageGrxLgxHbLJ9fAnvhnsbBDB429CHE/Q16npL+7fK1WVlHIEDgb8NJ9TOsDM44hkdDe4bqoNz6aQmnTW34Vsaf9DDHWSJOV4MG969OarEcqZkXtZn1pFs9kna98zX1kxy0xOfDpx0K9gfIBdqDYz4kUcWf6z9ftx0KTZAuEy+3PQcImR/FUkeTenWOWlzywRHNZbWlwNyByLY7+/6OaAHtGAEY+JUXinlrKTcb8Hcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMe1nI6+xBFiDHc+W8wTRcxTdviVLuqn1blz2mfk+9A=;
 b=DH15dkzoPxiz2+3GA0+A5MmryP15EkDWrHnaTZZMQ+SYceAGFmVXJKgL1OpAM2AcHFJiX6xyqKdExhJBgEXDPezh6GgyMx89u3FLxR0b92d7jpcTfOQ5X4jeCGCcD9xq/gJ9gLHHdCtPX1g68IXSdf9k7KAt70O82Pc3LieBXRc=
Received: from BN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:408:e6::17)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 09:30:11 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::b1) by BN0PR03CA0012.outlook.office365.com
 (2603:10b6:408:e6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.18 via Frontend Transport; Mon,
 16 Dec 2024 09:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 09:30:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:30:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 03:30:08 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Dec 2024 03:30:05 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v3 0/2] cmd: Add support for optee commands.
Date: Mon, 16 Dec 2024 14:59:56 +0530
Message-ID: <20241216092958.1230455-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 44940682-6414-4166-1bd1-08dd1db43cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1EDivgmR6RhrqnCrRqsAsdVEjs8kR/au5T3PUAJnES5N8xxYd+Onk6T4lwG6?=
 =?us-ascii?Q?Ui3CVwpwp0TN8q/Hmxv/wUiqlTmE8MOv/fTIxq+D7KJYzzm1YsDs7JLr3ZIj?=
 =?us-ascii?Q?H+LvtPJ761+XE/FrL6jD0LrG+SHv3/uQmq8lLBayelH8lNDGUZ32NF7sw3KF?=
 =?us-ascii?Q?rcfZsl0Gi/1ZFNIPldXptl3oIEb/YounWxRBG4sUCRSpUFg7fTgjmKncvDXL?=
 =?us-ascii?Q?5owqb/BUyzRkmNEUWJJ5S5cYix5b7j2F9Mt8gg6cy60b6JU5wM3L+z/WSQwn?=
 =?us-ascii?Q?K4HyBl6xXuV6eAMwF8leQtT1AI0FPoCNBhEKJCwj6HVdJwQNVQCYBpviA6iu?=
 =?us-ascii?Q?Wwut7gL+2MVx3U0j4TgqHMA4/JZTu3B7k1K+a7MXIM4bL2qhbyMjvEr4SaPy?=
 =?us-ascii?Q?ghIyyzjpXE/Z0yqGtZljYHjNfHaY01MJ1K5QwYstqv2jCmkjcUG3syqUK7y/?=
 =?us-ascii?Q?k+j+zD8W2VfCusK+3YRXD4NzNHwQ/EXawfILowlvaZnLEnN99ejsf/8etziY?=
 =?us-ascii?Q?1ODPCWVKAXOm2mGD8J5QlA3Gt1z5z8E2rTN8BxjDFjOkanGKLLgDClYBQqqj?=
 =?us-ascii?Q?JhyMOBPVIae7H1B9xnavHyYpbbwLmymIoukBl5ONNY2JjaJ8SoIXTOglOfcL?=
 =?us-ascii?Q?GwVljx3b9qrNrGWFBcBD1JUGeIC7Zew3XCmNIBagUTqUpxx/z+STxc812J0u?=
 =?us-ascii?Q?BH069nksP6247l6cffiOJp/z6SoYdWOMHT0CSPI5BPRwiV6q7xtoZ92ZBy2x?=
 =?us-ascii?Q?U/J4SJTmJGbKCDoKy77PgzKBl89k37kXbaYUKTB6IeiIiGyoNUqJP3XKsZlw?=
 =?us-ascii?Q?VoBgCmC6Fe9UBtRfbUXEbJ3hu6fMctlmuQJfwjai8jqsZffmFxZPfToVAshC?=
 =?us-ascii?Q?vYCLVZk2eF2HCtFkebMbu6TVFXUkuzv35NJb1cHNN4uRPXWfbrk+JKxtrmWu?=
 =?us-ascii?Q?YTRRWbyEUNyRWIuWFRsNGuAnexGNJuUJVTYzMGnte0A6imzImzjprRXG6MwF?=
 =?us-ascii?Q?eOthAYEVLTPYNgv/aQJsq/WlH/73d91jHYWIpx2wBJugOQFJ3dbKZOM0DW9n?=
 =?us-ascii?Q?yMARxT/VLi92RANxmEw+6jx+cM4lKf3o3pWm+u8CmkQG2JRArN3Xu239t7cE?=
 =?us-ascii?Q?IUfHJrYb/hmQU6xBxYMuXPdklZbzCpKTVXlcit3CVZrGJ1gcaV8N+KKiglEX?=
 =?us-ascii?Q?txnMx6M8DZbQxVIGhlQ65Xa8kanfTjWyEdGYSFn9iQBG01fT14vvmKzSMsvU?=
 =?us-ascii?Q?UZtGYItQfa/MTrB7ob8pyodxBez5si388ve07Qw8APGDJL2tDZfttLmXEKS9?=
 =?us-ascii?Q?BdcBYIF02ReLi3sH//UmFFWxRK59nnJOQmTPVZ+yKCVNFNUCtol+mWr+8Fp5?=
 =?us-ascii?Q?eflvvkawSCNQLZSKlKuUvY4gaiT/KH2cBag0Bm27p8GpxQ/0Pk4JgGzcC+rV?=
 =?us-ascii?Q?+EpMwWtJwRHXN9IBF/UhNHAohn2EM9g8SxO6IevOfKDS6EuX/h8ssA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 09:30:10.5911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44940682-6414-4166-1bd1-08dd1db43cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
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

Add the basic 'hello world ta' command which increments the value passed.
This provides easy test for establishing a session with OP-TEE TA and verify.

It includes following subcommands:
optee hello
optee hello <value>; value to increment via OP-TEE HELLO WORLD TA.

Changes in v2:
- Added command "optee" and subdommand "hello".
- Update the man-page in doc/usage/cmd/optee.rst
Changes in v3:
- Rename the config from OPTEE_HELLO_WORLD_TA to CMD_OPTEE.
- Rename the file from optee_hello_world_ta.c to optee.c
- Add the hextoul from dectoul.

Venkatesh Yadav Abbarapu (2):
  cmd: Add support for optee commands
  doc: man-page for optee commands

 cmd/Kconfig             |  6 +++
 cmd/Makefile            |  1 +
 cmd/optee.c             | 93 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/optee.rst | 66 +++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 5 files changed, 167 insertions(+)
 create mode 100644 cmd/optee.c
 create mode 100644 doc/usage/cmd/optee.rst

-- 
2.34.1

