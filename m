Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C203EB1067
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E1BB83FDE;
	Tue, 10 Mar 2026 15:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kwrnD4RI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77E5B8400F; Tue, 10 Mar 2026 15:59:51 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BADEE83F53
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHLoY6d51r9QAOpnPPPNynnWzJ7lYqwzvpBuoknb7I3+csGsSG9aC5TrL6hXhTbWJZi+MbBxRt7Ge9o6WZDuD247fIR0yUp3yP+8nCRoHKCVcCNGOAvTwWIbxwM0qGSMt5fhE1Y3ealiPG/ZTiSTX4Otoia6jqrd1rAPeJafDkiQEfXuCZmx7UBnLCoIjCBq8UFsOReUKb2+qFPppaZA/UITcb3yUbCDNDzJ8XnzUfrRshM0uf00R62dyxWpJaIh4DgrYbRHQE574WMaaUfAxv29hk0YWvQxtBO2VMj/Ew5/1k9xLKwm1oIknv29B6qrEsZeChPAXOENxXGYeh8TSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry+dYIol4p4JxHGyYNQU/BipoPR3wvyHlC2vPAEhITo=;
 b=untFw/QgMXmrh4YWjRVL8XlxFcDdOJbI+ZV7AUcjWR1B/EVXF11Sdr0/qtdXKSQw4TMxXiX6l0XCLVeZ7vcDMRXksS0xgT9UPwvQwS6h7lEZgqmiFwkZd8QDt/oNFBuFjnebJhv4gNr23/8XbH9fojygPmRhC7uJrGzJUSQOBJhiLCXLCA3hksIfkOthzS/CeRj33e+hBsiFMwaby5fthUONJqDSNZGv7Lk48zxPQxIwGABIq9JhzZKoUIrqal9sQfd3fKVdOsqp6miBlnD5lstJv9TCLJk2EEq8tsVNFVORBFMraYsqEtpWHNndTuo+sXn6G6Q7uu7GBPU8jZmk1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry+dYIol4p4JxHGyYNQU/BipoPR3wvyHlC2vPAEhITo=;
 b=kwrnD4RIKp62uZFheoizFoAiYciGJuwhJ4HvwYflECROl3Luxv2KFmWoEFq6O2Ax1lb72A12z3WW8mcIhJSeZyen/imYByr7/I8GjG7h76E488eNveQXJzqOSjB8sd9+lExK3v06gbI8lWjRSgv7kc5pV/5H6vicodnYfX+65kw=
Received: from BL1PR13CA0321.namprd13.prod.outlook.com (2603:10b6:208:2c1::26)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 14:59:42 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::46) by BL1PR13CA0321.outlook.office365.com
 (2603:10b6:208:2c1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 14:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 14:59:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 09:59:37 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 09:59:36 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: Casey Connolly <casey.connolly@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Padmarao Begari <padmarao.begari@amd.com>,
 "Simon Glass" <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH 0/2] fwu: Call EFI stack initialization after preboot
Date: Tue, 10 Mar 2026 15:59:26 +0100
Message-ID: <cover.1773154765.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Jlxf3miiGAOy85mOWpnh6wOEdicXC3J6yLqjNcsNCiw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRuMDwvzl8V1G45cdOZw7uuxZt43Jxt7fOGRbntrvXbP
 3lSseLLOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiFRUM/8N9VjstWnXApsa6
 rPS4tu3PRaKry9gN96/36lNtfns07xXDH67dUrazbMQ8OwUlLv6+6Xdy7urrt+vUtNNXsaaoz2N
 2YgAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1fc3ff-1b93-4f13-fb00-08de7eb5a89f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: G8SmdOQY3Jc5V4QaE0HqdXxqOhtKpg25D8wVpbuSA3a3B6xf5hu6+yq/FIPk69RhTmou1p8pBV4nWTM91nz0Dj0d/8/6zil8GZIwjdO6YFQg9KvL3OaQmdLOWntq0tun9N86wAIOCt0oor0XXm0OjRDAVakR6P5wnblAJvH01LbOrfVOyUaFOgcMIb4nTLeNubWv2uIzrzPmsMXV1CMI2lm22eYlNM4EgRREfjp+Ac3Wk4Ahw1JnOM8niADPq2SK+aBqv5oQYu3cnYvxrV0F+nETvpBvdfIaCInuTmnKWvaHNmMngwS/RRZf8vd5CgShxcQLwUS575wuZoGmbcHDEpJojAB/Vm7Gk0vRJ8ChFVQmGmfRcN0Ay02PGRhNTxzoNZr9E1oQPnV/9TvaMzcsbAJiU7lgltEtYd3HnZY3HZuGMVEmhXTHfV6SLRtdSk4VYqaIH1XdOsiHHghp1h8meXnTAZgNGVrzPBzPnga8KrZc/eCvfg5LDkEr+569YuarqRkgZbbJqAH+1hpzqCsUHvVBwjV4XmXmBv/OaJBDEa5UfArrDNxtSw3Tk57R+I4qN+aH2kI1gxttFWkc0WIiF2jUa2imF0WEna4E1VQXSIHFOLs9BVHWLCBPj7WhOqFgg1Ng66uVKi1aXkGCpk1r7R1YhReBTTvDTObUnns2Pdqzim3Zy6+uNR83BU7vLB94sBdM84hckWDqp+Sj2HyNBl2vOJKAhI+LMqpzv8elQ8ESCamSNTx/oHeTXMLDZVoKM4jl/2DDPzAr1HtyRkmCpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QQVrsI4ta+mOE9l2axvs0PxyDJqe3YInkJ6R4cCxytE+cf0GXdK44ZNVpGbxVGJp/W6y4mUvFXcVSwXD1XIYbamaoOuUlTMyOvlW5AZsb7bHzaFTYvbOxOLYkZ0ap6qa21Fo/mFaqyuN1QdomLpcgX226YH/RKWdHoMyU3I5cKzHZlR2hfxHt1dsj/Eg29ZQJVIgbEMO+skP43NGNUXKsNsqvkl+hsv3wTTKCrz11FODpYNoWh9qbetg+y+eJ2cckLgcuPBSuSLj6OU+K81b9p+mfDcXrzZJeaft1bOqgwF4YDOv7aUwq7mG2w/bQmzEcslyH0QXtfgBufkH7YnUaVIEIBM5v7/aE3fZ4bhUSH3VuwQ32hKfpd8T3bxN1sPIjvVVFOLvfulmgKcbnDeINxjVVbTwNei/QogE5TKjsZ/Cr4oK8Wr636ZYD5WG8iaI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 14:59:41.6076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1fc3ff-1b93-4f13-fb00-08de7eb5a89f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928
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

Hi,

the whole series is trying to address issues we have on platforms where usb
and ufs init are not done before efi initialization. This is happenin on
platforms where A/B update is enabled. FWU code is called early and do EFI
initialization before usb and ufs started that's why they are not visible.

We are workarounding it by starting usb/ufs from board file but this should
be more generic approach.

Thanks,
Michal


Michal Simek (2):
  event: Introduce EVT_POST_PREBOOT event
  fwu: Move boottime checks to EVT_POST_PREBOOT

 common/main.c         | 3 +++
 include/event.h       | 9 +++++++++
 lib/fwu_updates/fwu.c | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.43.0

base-commit: e5387628c1d64caf7bcabb5d99d2987bd5bff617
branch: debian-sent3
