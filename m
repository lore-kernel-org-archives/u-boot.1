Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CE5E99062
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 09:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6AC684181;
	Fri, 10 Apr 2026 11:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E8YOd5Wa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA468414B; Fri, 10 Apr 2026 11:30:54 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B5584106
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3eLV66fJnzyLLnDtoKJU6PASTnC74Pjem7cehn1PxNa1yJp0+saS2bW5/Y0HgurnkC9/Y1xtaINZQc6hXJ/0Pv7xc98DACfzekC77N2Ph6aOh3w86K8eYTJMJQpOJ4Zt3orFlhXdQcKAM7f/MaGrWImJ6pK/Qi5DE2AwWUJn7VYK2huu9+jC4vHZeV9eXnT6W3BM2/HXPNCewPmwQtC8hqcKzeeqHAoyC43VChttCafzYajkJ00lLuaITO7LDyn/c+ad8GIJsd3S4lerDp4Kq0FwlfbCHdm8k7LYhy84V6VsSWXM/WpbtRLn0C8NAU8sXdtyjxwo2pMC+yhMJK29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVfN+Im09lO8eYMaoRyRDlz77Xlsmxu1mbE7yfOpEE0=;
 b=q9b3xyQg2SWDI2ExTv4QMXmm97NYqU9gS1OBBepld2kuKTCcm5aYMWXHDFwdp+mywWfNZe/S3nb0gP1J9gy1x8gcGEmPtDH8+TJTM/epsLJCPyx8W66Za2kbsBj7cXIFuo0HZRxDoxTfakCTh/rEnVjnnaPBPPYp4Rg7fhdW2VkTCoT/h6QmRXnv3Ft+sQDSmr/4xwrppaqgL/JeBbO5/DKgebgposTm81nEoXrQif3YkInPc3KjXuNa8DTcxx2Vpy3QykzHCorFKibtiyK15O1hAhvmipR4D0supdTMZ0Sqo+mJkHZIamCeRcDPXbH78+4D/2LuVFMscSbJHldY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVfN+Im09lO8eYMaoRyRDlz77Xlsmxu1mbE7yfOpEE0=;
 b=E8YOd5WapiR5TWxvNZmN0lUeeYoX3Jha/xTgngHXGxDMkcJPu8lyhxAjOkUL5r0StXN1gw/5nMLXZzFHwUEZ89HokVNRDgt3zHlKjskPts+R2DFMrOmRutGbPak48hcgBx5GzAFnRM/+g1cR4q5OZjLUqFVRCOxow8H5HrofVPw=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 10 Apr
 2026 09:30:45 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::59) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 09:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 09:30:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 10 Apr
 2026 04:30:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 10 Apr
 2026 04:30:27 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 10 Apr 2026 04:30:26 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>
Subject: [PATCH 0/3] fix 10GBE support for AMD Versal Gen 2
Date: Fri, 10 Apr 2026 15:00:15 +0530
Message-ID: <20260410093018.1461732-1-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: pranav.vinaytilak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e752b2-5ec3-420b-96af-08de96e3d786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: KZMbcnU2XGZJtTgzA7aWOjdSUnItCcyZiFnoEhQft1Mb5dF0aPPE5rJ64u8BC+m/VzKhyCM/uL8YqaPTrRFl4tBsKI4Q4YHsCp7IjRXU/OMTR49pg/F5NJzIrOQU5eiBcIhdoQai6TYFxaZMu+BPCp36LVFqkswhMkTv2dsq9kCNlU4ScuRYt6EUPsrEGRu1vWpsZqCZ7UnCPPBDN33dVEGHf7ySOTFhB22spP4TPAWKP/NakqpL35jRZdfsiOkC6bHaBZkChvpCKos/eS3v3WmSRXZ1opblW1KWsU0WBsC0RjXk+p/zRhTUeiuZo7FtDpXetUpoM3xk7rHg/3TcJWlsQdqfKvFOFOpxrPXnrsuNJk5wM1gKM51F4IQtPWfZN7hhE0VZL8Piy2eg6OaWhTjuh+vfH8XtY38vL1Ox0Wef3IfvZ6RwDA77WHtOfFsLnXrOMslQGl7Ft6ZBOfXIUhuqVtcC+fn2lQ1kLlCZk6RaHIrMzztEyJM6LHSHYGRzks5/rJpA9Y5VNN6rHdMAK1qgQvrfO8YXsAwI67hMW6kZ7TQ3ojeR9/5RsUlyIm1Ukf2KRLblkFC5VxwnMTe/4xXc58hZKr3XUAAoxqha9zwyd4fuGd+phTZKa8xIE0nBFvrfu45aXyw8n2m1n8zWurOjMTVYzpv41PWaeuLnqtYxbOB2gMpi0YhAiEdOipy0jL/eF5+LvBfdfYE8NiwS5R8jL2j7rlXP9/JKD1xF+a0qvyg7OsgF3a1BBL8L31J0KGecAVG4hU34bPm1TAKd7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gkhc1YPbGpTM9R28l2v7qsFCgpn0teBvd5gIftiTuzGNZGM+LEb25pdt4EdzRxYrJcPrJRr/nHB9iDDYWBUBzxSW5nc5ylJawFAm89E190sigH7FjcXMI0o9YxSzWVpUhw2m5btOOtrp/1q1UCVI6HZlsG3fvOwikWaS/E5GHaosYZnHIZDuwHQC9qi3O+//Leyybeh1sqyS6oo1t8nfrKGckbma+CBcYG+qtEavOAUi07GZJgqn6eMPiEvlry3V3e44hKjWjuIfwkYHlGrlU79yHHrxSEj3bbt0oCgY2YVUNQ3CbxFS4swxO+MgTUjN8PBrWvlwyq2Xd8D9N0ZPef+hA+DeIzR9Ch87+jPcE/tF04tWCd+wSvJ7Jiq56UIph/G1bA/3VL7yghjqBArXv046DdRhqwYgSagDV5R5Pnr8j4lxSqboSBV+WBdSuFfY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:30:45.0325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e752b2-5ec3-420b-96af-08de96e3d786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
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

This series fixes three issues in the zynq_gem driver required for
10GBE to function correctly on AMD Versal Gen 2.

Pranav Tilak (3):
  net: zynq_gem: add SPEED_10000 case in clock rate selection
  net: zynq_gem: set 128-bit AXI bus width for 10GBE
  net: zynq_gem: reinitialize RX BDs on every init

 drivers/net/zynq_gem.c | 60 ++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 22 deletions(-)

-- 
2.43.0

