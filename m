Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3492E77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 11:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 722598012C;
	Fri, 13 Dec 2024 12:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AJBgztXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBAE38010E; Fri, 13 Dec 2024 12:01:03 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C547380241
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 12:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3U23CylSvUr73dkO4bpY8PYXUt/nFKTyvuaFaA9Vi8VX+ZCzfyLVt/NApvO/RECXLMCQkZj2NON0UCBIL/jR43RCcKtuUQ2tZyEtt4gYeepkBzcaFwlZ7Dp9CYJEaT24IoTmcjnab6dOjFqQxRHfPMGGtgHFW2zJOtjNhsOE+fDEf/ZRtpZxRwFJqtiXGhKp+TNhaPds3V6GV+K1L7OrevQgLw1dNtTKibHmVLSHiE+N9K9hYUrD7RqPwt85mrQskeGWWCOsAgmFqV49tcYS04njpchN7C1nv0D4iJ8CPc/y5wbiMPqYYKBA3qJq8lPblGbqvYyzxCQAb8Y9zQlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGSRUHG1IAFZd+dHpDQXfeCPGyWbE/weecNrOH+sMD8=;
 b=bbGnubm+hNSTkUAlcAs/UnlAA+pnzgdyqJMhkeMFwbSFM6zCIccgZVMw97cQF1Ie4h9HApsX3DnKIeQfTgnHAhIsu2eT4p9b9s0EvaEaCWWBiNhBOXrWVM0R9OVUVIuyeDRo+051grZEF9nTxmzu1FsNjDh+IJibLH8uHVhHQc7D/zJAaaflJWwxHvjOcIsFDrncSUO7+yn6qC7jU/8PW/AR9bd6G8WzfYc52UOJj/RVWrtO7/IkKCZF8lGCLh0HzlQBMHpD6schZlrWK5/CQbuAsUk+qo51FO5pteipLIfpJRXzEuUvrLrt/qkA/Gooo9MLLwS+TQZT3eYG84r3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGSRUHG1IAFZd+dHpDQXfeCPGyWbE/weecNrOH+sMD8=;
 b=AJBgztXMjUi58TuFa3m9qb23tA4hxDY4JBE47iejEil+s3oHFWI0vW5gAnLygVvIndoqhwPx7aOSQv77DdmuFei61EqRhtbps/7Az/nQfO+hRCNkQNO+XrEIh1PasJdwGak6DcA5jOYrbbkTkR+xWPAuuivCtu15XDYofEDcGkY=
Received: from BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::29)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Fri, 13 Dec
 2024 11:00:54 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::cb) by BL1P222CA0024.outlook.office365.com
 (2603:10b6:208:2c7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Fri,
 13 Dec 2024 11:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 11:00:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:00:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 05:00:52 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Dec 2024 05:00:48 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v2 2/2] doc: man-page for optee commands
Date: Fri, 13 Dec 2024 16:30:34 +0530
Message-ID: <20241213110034.1113036-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213110034.1113036-1-venkatesh.abbarapu@amd.com>
References: <20241213110034.1113036-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a3f8f9-77e9-4833-0bdc-08dd1b656a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?trgdVfNJjvLMD9OlHBd8pEpiiYu3cS8Ssu8zJ7QikuUyTJUdH8G+fM4Mvewl?=
 =?us-ascii?Q?CRSJmJhdxs2LhsR8ztaOYVvgF0zT6u1vsfGXvT5VLhLJjZYUooyRiQ3HU5yv?=
 =?us-ascii?Q?tmxTUd2Va09oJ5bmekpmgVsS7UM642emdX9jBR9Aufnu/a60KfSCTau+zhSF?=
 =?us-ascii?Q?jmfGqISH+t2h0DpIZLsEr1CCljxwrufIEqKq+c9CN5r4Y3o9qsCev2/sU0NI?=
 =?us-ascii?Q?h2sNILkwX3SoZNptUVPFlKZyAvGqsu24C2qdE4CSH31wEF2oIpzj2V7oqyNS?=
 =?us-ascii?Q?WushyUtyl+B4/VDMFyknU73rLOY3wskWmQ/eBVZTFKqgbp3gBXAzvedO9XeI?=
 =?us-ascii?Q?Fpro3oA7A2ZNQc8wsq6VCBuVLmq1dMO8kcojHreLlR6ckIHsoq6UXYhOzURx?=
 =?us-ascii?Q?LXfNTN4gyNyTB8tjy/znqHkYxFvV04mCmSwNFwGU6+4iKwxTyNaooWOD+02a?=
 =?us-ascii?Q?PYCviHHZZ3H5sw1+0L7fLiOUBmZed0Av89671UF2Mbj2gX8CQ1ahVETaJKrp?=
 =?us-ascii?Q?Xni2hkAiOUHlPXwN/KPn0Vq9hCvsDBTXqT6kQ879GYwZV+rgWXi+hm3JNgIV?=
 =?us-ascii?Q?WuOAWWI09j4WCFTyDRzubNEEYnyJV6zCRHTdL24XhQ2Du8YwpAynqaYIdT5a?=
 =?us-ascii?Q?qccyS8MODlqt7uU6pD9NqNTCUJ5YWqKNpYbSyB9SIcU5nxRnbEEf4gwtGCDT?=
 =?us-ascii?Q?qOfnas+2iCz9GbMBGBVPFhLuEi/Skx7CSvIxnrPIqcSY/sVSLxjsGX9kGL2j?=
 =?us-ascii?Q?DiFtj9i6Ffb+xmVITLOV/O+V1Pyt64kmOxBku1mShs04nX8v3jUm5iqUJUnJ?=
 =?us-ascii?Q?mC8AvMr6mkrYegHDIlTahX4chtXZlVLNBQXibmo9mGwu44mS0g1ApxDf7/Rx?=
 =?us-ascii?Q?VbxhSUIYNnNsGeyLwOgQ3rEPoPons9r4CjtRuFH9rKkQ+mKVy0dkxtVjW4Db?=
 =?us-ascii?Q?Xlqr/0kAxRxmgUnwbZXkkX6rTvUMzqnReJitmYPyihvMU3nxZTwuxv8l3ADh?=
 =?us-ascii?Q?s2TZ8Z1t2k8sLtfXXLta9Pz943pRbl2O54pYZcbhMsdq/yXMhv2phZPk4wpz?=
 =?us-ascii?Q?KGujIC9aFnK837iRRFBJG8U3mUgJmQLImO7zVN7oeUlqbB0qq9Fcm0QvfFSt?=
 =?us-ascii?Q?xJgajMfuYoJ8NAifqGW5Ad8qUwYhuzxDfb27irh+1EnJzLhNPIf7TimemJ1n?=
 =?us-ascii?Q?5yYHLKRQCcKr1YPJZhFhwArJ2IVcXHWrNp2XacbgnrLeAzMMIY8G9v2hfkGC?=
 =?us-ascii?Q?ukIuRxVkWL/QR6sDzKqj0ITmxj5BlwHucXCAE5k0DEM8bhsJgg4OfeC9xnnN?=
 =?us-ascii?Q?jd5Bjq1OIT8aYcUwwl3yzx1hS/UscRL0oLtzd4YAIAhaYYCc30tROjBxIF3P?=
 =?us-ascii?Q?9/LvUFYIp7SWNQ+sRl8QO3+ktGpmDoJsukD06wwuK2plObRAuw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:00:54.1985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a3f8f9-77e9-4833-0bdc-08dd1b656a20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
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

Provide a man-page for the optee command.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 doc/usage/cmd/optee.rst | 75 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 2 files changed, 76 insertions(+)
 create mode 100644 doc/usage/cmd/optee.rst

diff --git a/doc/usage/cmd/optee.rst b/doc/usage/cmd/optee.rst
new file mode 100644
index 00000000000..a8a19e3e983
--- /dev/null
+++ b/doc/usage/cmd/optee.rst
@@ -0,0 +1,75 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+.. index::
+   single: optee (command)
+
+optee command
+===========
+
+Synopsis
+--------
+
+::
+
+    optee hello
+    optee hello <value>
+
+Description
+-----------
+
+This is a very simple optee hello command which is going to
+increment an integer value.
+
+value
+	value to be passed which is going to increment
+
+To enable the OP-TEE OS side HELLO WORLD example please refer
+https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
+
+Examples
+--------
+
+::
+
+	==> optee hello
+	The Hello World TA is going to be called
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	TA value: 0
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 0 from NW
+	I/TA: Increase value to: 1
+	TA value: 1
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 1 from NW
+	I/TA: Increase value to: 2
+	TA value: 2
+	I/TA: Goodbye!
+	D/TA:  TA_DestroyEntryPoint:50 has been called
+
+	===> optee hello 74
+	The Hello World TA is going to be called
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	TA value: 74
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 74 from NW
+	I/TA: Increase value to: 75
+	TA value: 75
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 75 from NW
+	I/TA: Increase value to: 76
+	TA value: 76
+	I/TA: Goodbye!
+	D/TA:  TA_DestroyEntryPoint:50 has been called
+
+Configuration
+-------------
+
+The optee command is enabled by CONFIG_OPTEE=y.
+
+Return value
+------------
+
+The return value $? is 0 (true) if the command succeeds, 1 (false) otherwise.
+
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index cb7a23f1170..4dd00f002cd 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -92,6 +92,7 @@ Shell commands
    cmd/msr
    cmd/mtest
    cmd/mtrr
+   cmd/optee
    cmd/panic
    cmd/part
    cmd/pause
-- 
2.34.1

