Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F568E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 15:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705AF8070B;
	Wed,  8 Jan 2025 16:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eHhM46HU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102A3803DC; Wed,  8 Jan 2025 15:04:13 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8458006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a25rjoHtb9cq4//7m7VvPTa2QXLdxsSZyYe9HGDjKY0/ElhdLV/gJG4dMAUUC7CT12Q95fsqCzQkMLkdF93J9hCJ9B7u+SVetBCvxtX6YOJ1EyJgh+uy0fgsMOcmHrxrswsABX7+KFm5RJd041cgCZkhAzt7yBe+UMKQqrzMs0XhsPgsFlGT0waH8PwDXXNujvndewEioqR+GZCEl+u728INiezhpGCUDFFf04XqqNUPVx1w1zfkW7d6Q9v8fgTkwwdq0Ey6re+uieWnrwgDFiN8+H2gOK56ovqZaqbu1Q/7P3GN58qe6zct4AD9tpax7HL4WBVwGg0W5WBQxgQzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S06m7NZtFkYTUGagPP66MmBNo9+uVkHmOB6cFeWxxg=;
 b=tz3UqqiqA26qSK1blDJ1dFXBibpWXfZUirbV9wEuaG5Zw83VuXZNO5/UBoh5OhIVcrBUdx4zQZY2JYts2EvnbLbhrfii1q1907njgCP0NkAMrOMjRmdNrPLs2xHQAuynW7FbWb16Gr/XbzLwYnp6xPMQDuORabNhlIMm6eJWMc6rZeOf+qJIP2DIf4eVRjQ61v2fgx/mzYw+NhYuj+7qb93I1oUibJPG3EyUzFdvyCWc+a19yKOHthjAPIZeFIvBPLpbFKNOGOzLmuHb8ipTU2sDwT6cWgH/rLXLTU9hYhAfiu7ojbYO+zsjWcs9LGgzfqGUHWokUJmnJmJbDrqPsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S06m7NZtFkYTUGagPP66MmBNo9+uVkHmOB6cFeWxxg=;
 b=eHhM46HUUQdpTk8P34fDDIpqxoHZE2z6dmt5OV3qJQsfQWHKhu4zENNWHRSgusC/tqKBiZ4n4AElzhilYYMe+vNESA3Hofv4wv034goWDPyjkwk9J2CghqC8m8QHKZMIoyuddhUVHwpPkDxEgGQyrPAb93ZNgLvvBkYqIeCzW6g=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 14:04:06 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::64) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Wed,
 8 Jan 2025 14:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 14:04:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Jan
 2025 08:04:04 -0600
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 8 Jan 2025 08:04:03 -0600
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>
CC: Michal Simek <michal.simek@amd.com>, Ibai Erkiaga
 <ibai.erkiaga-elorza@amd.com>
Subject: [U-Boot][PATCH 0/2] Improve fpga cmd usage information
Date: Wed, 8 Jan 2025 14:03:49 +0000
Message-ID: <20250108140357.969380-1-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ibai.erkiaga-elorza@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc817da-05d9-4651-800a-08dd2fed504e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GiTGE6DBZ71jcykP3WJnBAeHccvd+zDAmkoFb2KU0r0zM2qzlknGmp6l4JSj?=
 =?us-ascii?Q?BIbum4nD7puXG8NXspJz9GXRZqOJwREq5idpVExuFq9eMsyBQmnIWwXTyrSH?=
 =?us-ascii?Q?tWThMvbSMVfwr1rtm+0gdArREZqU63AuoyFX1iMx2GcDcvh3tOY8T0aP2Uo+?=
 =?us-ascii?Q?bHX74xlCyHsF5iCUhKhIv/cYgmc7gudCDY+ch+Cgpup1ZYKV1GTWRtyI73Gh?=
 =?us-ascii?Q?OoSgn159X5WxVOf33pdsaocoJsFIINwtOOz8Y6lmYOmUVERPU0IJWNC8bML5?=
 =?us-ascii?Q?CQaDPU9VujgvL2RZlrs9rZ5lARebDbftmteDwBTcp74EZI2jw9B0NZpFHj0P?=
 =?us-ascii?Q?IJAIs3wsxf4Y1mqf24KPcOkvPLPEHB3NyIuzf4rtbSYiQ3+U6Wg4jmfttGq0?=
 =?us-ascii?Q?bekkQ4+iiR6yE/vTMZwqncL3iJqN3qzN+lc4mcut1ViCeBqUcz9SRL6Jfxjz?=
 =?us-ascii?Q?2/Oyp30UWwCiiz2zD5eMvNue1Ycocw5ArMEPSEYMhtI4M3gHdZrgEQV6DE7V?=
 =?us-ascii?Q?zXsWEBMCiMfwkiNVEIIHUHOOD5h2wZGw1jNGVO2UBHDx7+b0N2qKv3qfrFej?=
 =?us-ascii?Q?YoUqFU+oNlgdo28ua3Wu3SM1XSZiqK3kvjjnW+4XlmxAvX6aQmch4rrAiuGp?=
 =?us-ascii?Q?BAUobg3/xPs6QxIo3euhQacZ2vay/mgB0Oy3El979rtacz0f3JySipiW0mYw?=
 =?us-ascii?Q?vrTQjw6j+zNgWFA0vxcWKF1aUhl9bBxjn0eUBXToIoAWEhqRHkJC8Ynvt8UY?=
 =?us-ascii?Q?otnHUuFXTWYSmebxEFgkzoXhD+Wf5wNKxgdaVBEjzTodJMAkmZn+aeAmGZpA?=
 =?us-ascii?Q?p/pbDFKdQkQnmJRTMQ3P8fBhFnUhHFcZ9b4PVhwqsiLudEv5bwsskUDvTXIz?=
 =?us-ascii?Q?/p7yc9RslJMeYgRsLL3VxIThnGjpaKwTFEqt49NGKSLpzxYpJMAeKqZmVBRt?=
 =?us-ascii?Q?DA0gTRpoHWdRqtDJwr5ISfRLD19N1oAqM7Z4ugBlGL4SFW6f9vcxAEmF0hWT?=
 =?us-ascii?Q?FNpYGLXielScPvv9TAl3vDVhVhWOQcyASTCnwiWC4omQGA/zNoSVXLORKGqy?=
 =?us-ascii?Q?r0hzaJ0Xq3qFciV4pNjNz/+j9j7vVrUXKcRMNZ3iua2MpBEzyB7ApjofI3RQ?=
 =?us-ascii?Q?5Gvpln3qqickJy6LCaRTq2tp8RfauKGSdXTkMD35Zb2pDFVThZjd5W+s6fgK?=
 =?us-ascii?Q?l0Mo3zJWau6j0dJdXWOp14zpBXUqEjg6NryVbRM9Su+T6Y1tU38r0wl54mVX?=
 =?us-ascii?Q?f5EWY7/2EYX7saRyrSpORuIlnZjrLUzK0HbidML7PJxyG6VdAi6M3U1ckgaT?=
 =?us-ascii?Q?/i49CAmdC9CZDHa/WvKs66k5cF+FDZy99XU6/0bqkKfU5/xkk38k9PH5Kc91?=
 =?us-ascii?Q?7xIO8p5t1cGum78oGshQPTLEb8cDnsas2N7uYOVl5BYOGJFQst/QV0miD9nG?=
 =?us-ascii?Q?h1w2zkg9O9ouvIklYFgYLzKqfZpWppBMe8u9wXUGgYOIF9Bi5pl0SSQI8fMj?=
 =?us-ascii?Q?6t92XdFd99QEjyk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 14:04:05.6461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc817da-05d9-4651-800a-08dd2fed504e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
X-Mailman-Approved-At: Wed, 08 Jan 2025 16:49:18 +0100
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


Current usage information is not read friendly specially when all the
options are selected. This series fix some of the issues in the info,
from one side aligment and overlapping issues and from the other the
excess of verbosity on the loads command.


Ibai Erkiaga (2):
  fpga: fix alignment on fpga cmd usage info
  fpga: improve loads usage information

 cmd/fpga.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

-- 
2.42.0.325.g3a06386e31

