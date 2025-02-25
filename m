Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ED3C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 12:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4AE80F56;
	Tue, 25 Feb 2025 13:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oLScy1Dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8712380FAA; Tue, 25 Feb 2025 13:11:59 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E5DE80F53
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZj57lRotQuUlXWdsVLBZ+8vy6LeHhOYMMWTqVwVTfjkcN8NyHrGqMl+XTY/xt191mYAbrO3AMSCp/LG/8vsWNoUuku7YXnR4V00PWOmoTNequQSdmbyMtWL9lKBOZ6TZ3YAuENhh6eFHsJaKEUAGQl3hCPSwo2Uy2rcERBFWcAZfX+Yob4uM5hE1bZ/8gqUCA5I6j/1uM++fJAdT+zdOl0RbXyLNXnLAW66T77mbxeo1ToVkEg3hGSOQ62p8gWRqVadXoNVWdRVHIiKohc4M4vkNprk38ghhfcimK7ubLa1xDasfN06jWGJJzdsY3EXkc9Nl1qlPnO92JsDajNV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGMSpsRhDffVHKMPxDtzHthnIl6RAcFnrnMvhhNpo4U=;
 b=cLZEB+f5JQNPptd/9YO9zVQNzyzJyINqkREPmkAUaOihOEw+VhOJRokHfYQN+69/nCj9CuFnrWOK0iNpl9oAg90ugaIGL1q0lHFJlw8WgRBal5BlWLzTs5PVSUmqjPwpBgi9ZrN9Aw5Dmt7F1jdjFH57FCBQCVxgFFSqcuCm4XiNQfQ317WBnBTtQAVArGRpLgJBUib33BNSJ7IzHsr4saRJC2ceSZckB/IxYQEyFVcuzj5Ik50dvYcyTvqq9SrkChYVUGA8x1cGashUGW2OkhM2JKBa9GjmSdXOTbCx4N93SdqarpWquN+cXBZKA2+8qsm4JNiBjZFRraRPAWH0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGMSpsRhDffVHKMPxDtzHthnIl6RAcFnrnMvhhNpo4U=;
 b=oLScy1DyY7RFLlsXdfBMSCxsZvknxthxsVjfPNccThXx10XTRDrwZBLrsPGddhuEZiEVGwnTOfEDKt5hUAjMvtbwIJ2D7LmhGtFEF5CdhDXcHfOXDhqMIiT+jbEmVJKBcIFeo9bJzcqIET3DNG27luIDSYSzWPsrAqhMZQcdmwZ1KTt9Z51Y/BJGHwNigIQkuQhAufcddEaGpCG1HhU9Qu5rL1EGNpSvStOIiaxv/Qcmw5HyftEGGiyrATBPWBL7R1njS869MoS1XCFDt0dcuU4VQprIiDnQ8XGTddnNuaaP0TITx7DF7VLwmKe6JCDcxlsJ4GkuWXOtEOh91jo7+g==
Received: from PR1PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::28) by DB9P195MB1443.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 12:11:55 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:102:0:cafe::9a) by PR1PR01CA0015.outlook.office365.com
 (2603:10a6:102::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Tue,
 25 Feb 2025 12:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 25 Feb 2025 12:11:54 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Feb
 2025 13:11:53 +0100
Received: from llp-anderweit.phytec.de (172.25.32.242) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 25 Feb
 2025 13:11:53 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Leonard Anderweit
 <l.anderweit@phytec.de>, Marek Vasut <marex@denx.de>, Tim Harvey
 <tharvey@gateworks.com>, <upstream@lists.phytec.de>
Subject: [PATCH 3/3] binman: cst: Build from source
Date: Tue, 25 Feb 2025 13:11:43 +0100
Message-ID: <20250225121143.14862-3-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225121143.14862-1-l.anderweit@phytec.de>
References: <20250225121143.14862-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.242]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000003F:EE_|DB9P195MB1443:EE_
X-MS-Office365-Filtering-Correlation-Id: b1417060-388b-429a-b05e-08dd5595983b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DIW4kHbqX+OZb77CVfFZ7tS8K28Ds2xx0qaxaPDQnmcKd104e+eRxqmEfGs+?=
 =?us-ascii?Q?XkHVCvF6pPlXdbmBI7hvtBdaNdInvyiL4LyRGy1hnUyuDYkF592/dBYI8pTk?=
 =?us-ascii?Q?5mtKaCa4pUP7Q4wrGh7XaNHTMT4ZMAMRYhuEFR8ve6nX2p1ApHiSn0Ko+FzV?=
 =?us-ascii?Q?uHX9U/9jcoISdmwyEs1I1GT5zWEqSCf2yzGNoBOz+yrrvQwJlfx5oIO2yGML?=
 =?us-ascii?Q?2zT0t2mH9CEcvWkSrz59FcXGS8bNWHjR/zXL8WSMrz1gbqm7NEcaSa1t5fqc?=
 =?us-ascii?Q?IjzcoHU/aWCw3irpp/I/UyVY4amkIvWVNGnW8q1L9jNdTE3km6yqI2ckG7+W?=
 =?us-ascii?Q?dTLerwKcdgm9vdhczag+9j4pJ+PpiIGJLgWPnL4+dwE+Xraf0icz4ht7QKAf?=
 =?us-ascii?Q?+vR53FzLw9C4jdAq4vB+4O5XKw4TxhdegrFMx0P5gxGqH26ovOuHawcpYfs2?=
 =?us-ascii?Q?sJL5eQ3ngKCWoW+4GQwfCjrEaEuZAEBfnWomdBGEcqver/0E4dm9YJHRjdQ/?=
 =?us-ascii?Q?Pu11NePm9r/daWb5+Da2TYLdBnR9y+AEam7d1WyCABhRKeqFyjZSH3d3j8Wz?=
 =?us-ascii?Q?5G0byFFGd0kAde9C3K+VKhr6UufjfWeItQ/1YvXHSpKSZVlpXIxNVKagVqEs?=
 =?us-ascii?Q?btOMxTK+KH9rwl3YMR8BNfiSbjKMPXrqfLLAIbWVPtuY1gFupCgYxQrVjxUH?=
 =?us-ascii?Q?aq+WgMjScq4rULdkTB9qu4r+A7M7v//B5KIzIj64tXwD0ZcgYBDmgUF1mXh2?=
 =?us-ascii?Q?KEiztQrTNiKbpLpykEJceBA+w6C471YyD2YD//1RHJO5VQ0xDpi0KFMVMnr4?=
 =?us-ascii?Q?hP0KOaff5jzbLbjQnGGOnTt/48Mke5llL+CybMnVqPaBtZVIMzB/l3glGSo4?=
 =?us-ascii?Q?sXynz32WjAbrs1JRgx/J9V5IIEmoaisEqY/NcC1MQbfR/si1O2T2g0pp34QH?=
 =?us-ascii?Q?oqvnStJvWGO7wuA6dU/tkcPLtCu/zSvV9C1mcFsxvGIhDIZFyHwqC0/4H5ae?=
 =?us-ascii?Q?6U1WUDOIyN0qQdFphggxzi2wetvwY2VIwJp+vukdMb/tHGteq/JBmGFa50dZ?=
 =?us-ascii?Q?54PcW9QzoNxpoZTq5pLzlgrV46MoebeyAcsBAcZOZlJro7k0iN0c4oE6tbL7?=
 =?us-ascii?Q?UOFrBcxoFmkco286JiIsFguKVjI6fwRJiRiP0xMPbFjXdeFJ7ymSN9mKhIqT?=
 =?us-ascii?Q?4I22IK0fzOxvxi3Bmr1Yt+uC3TYZvm0Rs8raFkGsnAfj4Dk6tvffNGTiljgw?=
 =?us-ascii?Q?DpjczTBcqqZPUZvNCnJHMSYiOo63sXuL9bTQQZ+ThOL7wqvEUHH5fc4xhG+q?=
 =?us-ascii?Q?+5bKSBLoR8RmnJyoXedMw2yRfVz7y7YKvpePOkQIK65LZe0FuuYoPKSe7E5N?=
 =?us-ascii?Q?qT4LudBRMORIiz/nXteMgyWUjoxdOroB+qx7+xfkLakp5s5O6LwMoimEIOPy?=
 =?us-ascii?Q?DLilCa+wxmY=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 12:11:54.8702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1417060-388b-429a-b05e-08dd5595983b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1443
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

Build the imx code singing tool from source instead of relying on the
distro to provide the tool.
Use the debian/unstable branch because the default branch is outdated.
The binary is supposed to be build with docker, work around that by selecting
the correct Makefile directly.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 tools/binman/btool/cst.py | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/tools/binman/btool/cst.py b/tools/binman/btool/cst.py
index 30e78bdbbd9d..0a23d12d3e2f 100644
--- a/tools/binman/btool/cst.py
+++ b/tools/binman/btool/cst.py
@@ -29,20 +29,17 @@ class Bintoolcst(bintool.Bintool):
         return self.run_cmd(*args)
 
     def fetch(self, method):
-        """Fetch handler for cst
-
-        This installs cst using the apt utility.
-
-        Args:
-            method (FETCH_...): Method to use
-
-        Returns:
-            True if the file was fetched and now installed, None if a method
-            other than FETCH_BIN was requested
-
-        Raises:
-            Valuerror: Fetching could not be completed
-        """
-        if method != bintool.FETCH_BIN:
+        """Build cst from git"""
+        if method != bintool.FETCH_BUILD:
             return None
-        return self.apt_install('imx-code-signing-tool')
+
+        from platform import architecture
+        arch = 'linux64' if architecture()[0] == '64bit' else 'linux32'
+        result = self.build_from_git(
+            'https://gitlab.apertis.org/pkg/imx-code-signing-tool',
+            ['all'],
+            f'code/obj.{arch}/cst',
+            flags=[f'OSTYPE={arch}', 'ENCRYPTION=yes'],
+            git_branch='debian/unstable',
+            make_path=f'code/obj.{arch}/')
+        return result
-- 
2.34.1

