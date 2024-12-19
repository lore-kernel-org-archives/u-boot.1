Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298EBE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 04:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C6680241;
	Thu, 19 Dec 2024 05:39:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U9ouqOUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8493A8021A; Thu, 19 Dec 2024 05:39:51 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA0380326
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 05:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YScFjzOP2mDHQORxS7ZXQJZWGS/Hh+1EeLyX0271Ii/ioDflt7o6qIW8ZLICiJ4nIJb4P76FltOUSOVCPUo1a1508EN7eYwfnUl3FB4OM+cfO4E9LaV+Bx1A41GkU12Q1m8dNxaeCQJxLGAPNX4AkHR94Jq6F0NUJdqNg1R/17PcQmudiKWJR2ZdpTk5UjqSeTFWRU6XzDp/9StnaROT9yfXk5WAAghQ7YbW/cD7QZTVkZxARIVuuEsL1AkBKFxFd0gIqb18vc2xdtKzLXP/Luh31Sar5J77/YeH+1tRwWNoAgoxsVKG1GpxAbkn1J/cEH5C1ZrE1fYaRVBQXkKqzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MIrSUj2eQ+AHWyYNYNRzuQMd6tmaFbz9AInGt7FHF8=;
 b=x/FNZLstwSSCYNUUPV/4FmTDhXGnMggYboz0Pi/aHkEFlhE/goRjMKgeeibeCzoog5S66TrSzXYY3dix1quLdrk8wBwT8AhyEvHz9WW8R/YH0TxDvGffzgp1vz+U6RmavM3Kzm9AfFU94mn8uWhkAd36TlQ2+/BHWroW7cMYSJiDGotL/hoZTBfl2znUkUorOLIvX2OWdzrtM5EN9l3WrF/4mreV6DweK+qK5mlB3nuXeyH0zj3S3tSO0s5vD3lFJjab9T5C7LiXfvj/wNDMmPW2+9OeeDrOnJcCP98LCp/YsF+bODUjQzCKpdjNvS5BGaeIYO02QDLIKpXqX49DxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MIrSUj2eQ+AHWyYNYNRzuQMd6tmaFbz9AInGt7FHF8=;
 b=U9ouqOUQHPp+V5zrtQRGUa331stfFe9zuHkMm3fE5uoXMAg32vQol0gF+WzOYXYomQHj4mwGB/BEbmIdo2yCilRyV4qMxWQMQpTQ8UirYPBOLsqsscqo61WNbCiY29IQ6CB26Nk+N+8/x93LGdtxl5xCw7gxSkysWvSt7x6KdgE=
Received: from SJ0PR13CA0101.namprd13.prod.outlook.com (2603:10b6:a03:2c5::16)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 04:39:43 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::23) by SJ0PR13CA0101.outlook.office365.com
 (2603:10b6:a03:2c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Thu,
 19 Dec 2024 04:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 04:39:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 22:39:41 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 22:39:40 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Dec 2024 22:39:37 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v6 2/2] doc: man-page for optee commands
Date: Thu, 19 Dec 2024 10:09:18 +0530
Message-ID: <20241219043918.1646095-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
References: <20241219043918.1646095-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 64cfeb5e-ce47-4941-eda8-08dd1fe7283d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/Fma0iW6+PoFg0UFz9+ldqX1W0o/THSK7h/wcZzVkcfDfIt++fPNMdA5E4m/?=
 =?us-ascii?Q?SIUFWPPzMZu4l6GrAvpSpetIrvkMUmarsDJ886I7kU40GlhdxQ7LJrRYgiea?=
 =?us-ascii?Q?7+ncfzssT5oavZmkW/6SlrNP8XtwyDu2NwtwmAK9pT2tlLTpeDSpgONWlmri?=
 =?us-ascii?Q?BEq4MyjR6r2xKnBZnWNYPXzR8sqFTYFdfRqb6W/axgqrLvJPQDhxk8LCdbBU?=
 =?us-ascii?Q?GCoDIEiDe/luwTMnsShRawrrqdgPh+Jqr3aZKqwX+KqSTJi6y75jD9pPipXY?=
 =?us-ascii?Q?6tyKdG0HGMoy8DlTy6mmiZyFq2OodyutgLWfMpwjBHkXkXpZGTNAoVQOjcqi?=
 =?us-ascii?Q?WJd1xd2ZqxvUnRJDBWKUgCWRq9u5UAsOOcL45bqybGmJLn13umViK6AYr8BK?=
 =?us-ascii?Q?LJ2RLx1Cvu6jr7UfjlIs+0YHU3UrtG5EppL7BAD+l7gozwORfbXRDa0Z+A9G?=
 =?us-ascii?Q?z2l0lniitK7i2RZTkLPMJ5J+nQ24PpO4eu3HPxmmqqhd+ho2VkTyPK1lia4A?=
 =?us-ascii?Q?WcT0aIKVuF4QKU7OAMlkiqocv3k/DxlBAmIEjMmMODm92u38PXXb5//V3QTX?=
 =?us-ascii?Q?XRsPVNQdukHDRs3nindAS1DF1NTLZgw+Y9QFa+R9ctMClMw3qA1/Puv1jf1P?=
 =?us-ascii?Q?WdFHq4pj8d1YeQQ20KxfDavhyGmYUETbRKAhnSXbOUATf46+gFWv8985QPXD?=
 =?us-ascii?Q?qFHa2IvDF1XO+mRSrK+R4M9LDKSPjBPZJASeTzMgOP9Enw1qrPtvwtRG2UBO?=
 =?us-ascii?Q?C15pzpngo2130PsJTPYz9lUF7W+mtIY3g59pqA5sD2CsbQDGbg0dhrwcZd8w?=
 =?us-ascii?Q?5yVi0B1U92TMst1dr8zAZiyB4P9KHIoUGmCwqCtK8N7+kKa0pP1RHHAks8M8?=
 =?us-ascii?Q?7jUsR7uWZJ5p64z7DS192HBMvCKlnV5HjkEsBZMhmLQlDWz5eDMVU6XvJAWx?=
 =?us-ascii?Q?STSARZps/8m2eJ00mCJaTcidk3E/2P2GKQbi7+WdgGvIWcOVG/HW9pexq6L6?=
 =?us-ascii?Q?yXLwrRGA38g3eHSF4/BMylODkKBUK1dqGyPDatn2USWAJDRPeqDlDtpC3sAL?=
 =?us-ascii?Q?iRg/BH/fcyoetw3HpvqyLvPwHqxurPU7GRfPOJyM1OSM5xyxKQyMGaS4GYKz?=
 =?us-ascii?Q?uc514mvv1FIe8iWdnrTh5nFCUtcJwdcKFcBlzuQ1L8oadouyr5CqygcElb6X?=
 =?us-ascii?Q?XX4fnX/VSLYMqbYAfuKi7ba5XKcB6mj9fUxGuJj3seIO4dZsyjNqGWMf3UDJ?=
 =?us-ascii?Q?14vLuF6viq47BdqS0hsqpE42flwY7vsLliPJ94y36QDwqFSgLlo2qK6LDiOm?=
 =?us-ascii?Q?kBeh0HNBzNZwA4SJxaTBDPHDkTMMTPDyxeMvmOpRMcO1OWXP/EG4HlO5Bp6R?=
 =?us-ascii?Q?wjRURa6LPYlBixPAXUPgFSHraTNN8LwYRe1QTMOdHaHyxU+jjuTgk1bW9kDz?=
 =?us-ascii?Q?mQF3eIxlyGA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 04:39:42.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cfeb5e-ce47-4941-eda8-08dd1fe7283d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475
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
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 doc/usage/cmd/optee.rst | 70 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 2 files changed, 71 insertions(+)
 create mode 100644 doc/usage/cmd/optee.rst

diff --git a/doc/usage/cmd/optee.rst b/doc/usage/cmd/optee.rst
new file mode 100644
index 00000000000..46c569a105f
--- /dev/null
+++ b/doc/usage/cmd/optee.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. index::
+   single: optee (command)
+
+optee command
+=============
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
+This is an OP-TEE sanity test which invokes the "Hello World"
+Trusted Application (TA). The TA does two things:
+- It prints debug and information messages to the secure console (if logging is enabled)
+- It increments the integer value passed as a parameter and returns it
+
+
+value
+	Integer value that the TA is expected to increment and return.
+	The default value is 0.
+
+To enable the OP-TEE Hello World example please refer
+https://optee.readthedocs.io/en/latest/building/gits/optee_examples/optee_examples.html
+
+Examples
+--------
+
+::
+
+	==> optee hello
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	Value before: 0x0
+	Calling TA
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 0 from NW
+	I/TA: Increase value to: 1
+	Value after: 0x1
+	I/TA: Goodbye!
+	D/TA:  TA_DestroyEntryPoint:50 has been called
+
+	==> optee hello 74
+	D/TA:  TA_CreateEntryPoint:39 has been called
+	I/TA: Hello World!
+	Value before: 0x74
+	Calling TA
+	D/TA:  inc_value:105 has been called
+	I/TA: Got value: 116 from NW
+	I/TA: Increase value to: 117
+	Value after: 0x75
+	I/TA: Goodbye!
+	D/TA:  TA_DestroyEntryPoint:50 has been called
+
+Configuration
+-------------
+
+The optee command is enabled by CONFIG_OPTEE=y and CONFIG_CMD_OPTEE=y.
+
+Return value
+------------
+
+The return value $? is 0 (true) if the command succeeds, 1 (false) otherwise.
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

