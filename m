Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937A1C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A662E881D3;
	Thu,  6 Jun 2024 16:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BpebZF6n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E4C881DB; Thu,  6 Jun 2024 16:45:05 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A333A88103
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE7aK6LOga+Y1YHH8XayQh6sFN3kODldJZ9qRrnY+l//GcEkCUHWTVVy9LIDPqoDBAmBrIawxm4qNOGiaceRr1MFso8GjJUFU/P+Q6pHzxUgnuuNJV2WPFuJCIpviPxifVS4pJvLS1YUnGYb+w2X6anCtk6WBy8d0XtBWp+GWqOvtN2rQKn8OhwDGOz34h+p7tsTWslfPi6rtrJDe0n2jjTgb3P5ScgXOU7uaVfY7vlWmQVAVJ+kVxyoIwIvFG20qkDQXG3RJCL1Sz+V7+VgwowEyjCm13g1wLV5KWrMXsfnrlad9J2T/YOY4AmshtJtfwKB8VMc5jeSu6hZ3W0MIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO09tD18GiddvtGmgjxHMXTAMIbLiEiSXDD1GUnazhw=;
 b=niObawdQ3mzxdV69spsuj1BzLwhrbtqLGsuvPxvgcDyqr54G19b+rVYWNClR4dwv3/fxrrBeUAk4YIjxi1a68PKFKRqR+roDzoSMuRM8wFkqWm1KKKKz7s2G6twpPgeIKxzxufijyptkcDP9lkyFdec9nnPhBrPMUiXBUa7ECX7Q2FCwFB4SAgT4wD1r50and46uZx1DlSLgx51Y88J8Xa4Wx/1wnbCai3DPyVGogW+xE5ka1v5vqUrxxEbsAhbGwdd8o6xd+H50eVCVVBMDQ7aATIosHSdimAlke49w8yOwY/9HAhy3R6PU1KWgryb6krfBO/+BKHIh+3h4aP002w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO09tD18GiddvtGmgjxHMXTAMIbLiEiSXDD1GUnazhw=;
 b=BpebZF6nt3gKP0xISmKrLGepfFJgErTYUNZYOiLQ1KlkLPNUdHyqDGaBvwWY+WUvRJ+x5UY0cztXJWWAKxFq0o35yzXXQw8+d5F5P4t9E72l6CY+0Gqj4g0EMjo+6CHIAV+06pBDlgUQBFJThRvV51JY6fmEurAkr3JrEgNLZh8=
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by SJ2PR12MB9139.namprd12.prod.outlook.com (2603:10b6:a03:564::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 14:44:59 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::cb) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Thu, 6 Jun 2024 14:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 14:44:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 09:44:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Andre Przywara <andre.przywara@arm.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Piotr Wojtaszczyk
 <piotr.wojtaszczyk@timesys.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH] gpio: Add proper dependency on ZYNQMP_FIRMWARE
Date: Thu, 6 Jun 2024 16:44:54 +0200
Message-ID: <c3ca38fbb2f4e6948a5ef95b369015de96259709.1717685091.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=733; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=AoKmTUty4bhFhoRLxc8au4O/yezKcq2iMgT+OkurX70=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTE08mvDXMnXz+ne9s3Nnqm0j9GieXP/y+xOP1Iz/Vn4
 ozDvLesOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE/rgwzFP4zymh6c1+wruq
 ySst5p6l4fn7Kxjmiu3n1fnZqNvlk31ytfPzrG5RbwlRAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SJ2PR12MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2b9f0f-cd5c-46e7-d480-08dc86373d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|7416005|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CsM3D0TnoOltCXEHwsNPDKn6pJLDXt5bafViF68bOKKvarNvwb7HHDsTYW6T?=
 =?us-ascii?Q?hp187r7JYmDsOb3o3nGAvBwmOitBZrqPUyvpHpkA0og8Ejw38eriWC1PBKDA?=
 =?us-ascii?Q?p6+YB/mBH9VfS5sJRK4C+lKFvQY8M33JwLASSVTC6BjPpnFUmcVJgd+m78Ff?=
 =?us-ascii?Q?WU+B7gcnFoiLlKbo09DcQdzQgFnd0bXsFF+DtUDN2vWPqHPrtz6o0oDsyFx0?=
 =?us-ascii?Q?GaCxNwH2uImHmK1fzNUzsfEx35cRd9I0Ri6T/1riCr39aYECCdu+rePOSDLV?=
 =?us-ascii?Q?Nc9vvMLFJWydaTzPQqNNlbVY0JMK8X0/npHn0NC4rP0NiVNP7qfzTgw5vRER?=
 =?us-ascii?Q?TU++j0QeyLfKDV36PYhNBaBp+WfKRPTZ+2RreIvOl/eCkvzjjnQfr1Dnsaih?=
 =?us-ascii?Q?2d0RmT/59QmGvqh0Y+uzDcVm5g6kclSzHVVuYT1jLjoDc9dLESIDL+vL6TuU?=
 =?us-ascii?Q?it6yG1oDl6k+coYuyD6bqvnwjCFR457tEY3IcjIr1uC0SShOPkAuaumyhmKS?=
 =?us-ascii?Q?jA96in87fMTPs4PstzoRyB1SHGsXLLh0OnQ+l0rSqkMgVT+BwpOM1FGa4zOa?=
 =?us-ascii?Q?Tz4x3+6aJtv6kzXyuggAYymTYirg8hjkux4ZExmxZN5BwYkcTeUmMUSjwiKB?=
 =?us-ascii?Q?RbOHtC530WsaXFdbCDbOZj20IWjubiNUOAUNtDDYiHQvIbAC/f0gn/S7Qqrq?=
 =?us-ascii?Q?f21hTNjNxKiHoQ6H0kZJTqXtx3ZqJJs5Mz7k4QxXjC8bWOJ4ks/vKfPlkrQx?=
 =?us-ascii?Q?h8GvLzcRfw3Q+ACxroXrZbfjhjhASkgPPF6zJkuDmNypHFtVF9hslisKReTP?=
 =?us-ascii?Q?MYCdkm14ZyErakOGjBT7QQ1eYJollk6cHlUAEdNEVHPYZSZyV4tFcbk8SkG0?=
 =?us-ascii?Q?WD5C/K44H/UCUpobiTS8KSSSJ2rNRnrQLUIYQ2fmfIPVnh2zfE7ipTOP5sep?=
 =?us-ascii?Q?yeejG7R5AtfApP0stylw2GcANKWzSWFFO25g4gmVNnwf232qtwJRsomgr+Hh?=
 =?us-ascii?Q?zaL2PnlisuI8f0GM22j0MH4s+CNzufpZmEFFxirGm6ACXcQRzgRDalvOg5kv?=
 =?us-ascii?Q?w7oTdIFN/uHrQsr1AfpQ1vMYTh6mY5xvTyoimVjOWd4j42xift7y2y/BA0RP?=
 =?us-ascii?Q?Hh6o4ff+zgcs7utsouvmS+Ub2f/31RInyt1Kbm6i2MY6+jn8FVKodrwP2QMN?=
 =?us-ascii?Q?i/5CLnKANE2pfpgzU6FfswMtQZKMM5PiZGoiLdJ4/AZVH6RV3qE7mfVeWBcL?=
 =?us-ascii?Q?l3Vsc8df/iUNaOQbbm/W1svZHGrbFY2Y/QGDbDheOwcyjhTZcVUbomV9nxib?=
 =?us-ascii?Q?P0RpiuTLGX04XsYE7xpcOGtUkKYx5Q4Y6uBAxfBg/88rnJ5vR8XoGqYOgrpI?=
 =?us-ascii?Q?piH6UNDEXtCJVP4VwMjXwV7oGTFAaIplmxemmgYZ30soaPhm+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:44:59.0832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2b9f0f-cd5c-46e7-d480-08dc86373d7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9139
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

ZYNQMP_FIRMWARE can be disabled and driver depends on it that's why record
this dependency via Kconfig.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/gpio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b050585389bb..93c5125fed9b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -639,7 +639,7 @@ config NOMADIK_GPIO
 
 config ZYNQMP_GPIO_MODEPIN
 	bool "ZynqMP gpio modepin"
-	depends on DM_GPIO
+	depends on DM_GPIO && ZYNQMP_FIRMWARE
 	help
 	  This config enables the ZynqMP gpio modepin driver. ZynqMP modepin
 	  driver will set and get the status of PS_MODE pins. These modepins
-- 
2.40.1

