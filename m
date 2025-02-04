Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD2DC0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 08:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9BE805A1;
	Tue,  4 Feb 2025 09:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SFW2uZmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA4280562; Tue,  4 Feb 2025 09:53:54 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55DC380285
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 09:53:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paGGqs+iA19tR/ryq1K4Zo7kou4/QQ3c8QhitAknhsfHVt14/0BmpFZNhRZmpwSVdj3O93NTDnituUx/h05x+b3Kogdk3qElY0MdDuTcArUJSicE7paK541mqZU+lEOI7AL2fRJfoUjyI5LkaxnQBaj/2PaGDm5wFhsw0BbVfSzftnPkg0AU+0yfTAmrwYO8wPSw1Xgj6mH19/+3aBppwlybkD89jtJ+njQGQkUKqU3iYdbn6D2EHZSXoYMTTLFLvQBtudsKf+OIf/lgWaWuG/ravIm22xSKnZarjxrx3452Oa5vxEOTRdgUC3DGNMDoXgSOjzJE6reNOh6aTkX+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNebX8LP5fYnd2y9mZJk++tpSwDaK5rkuIskGLBREQc=;
 b=k5/7g9gnvLyJkeMKtVNCuK514IsCehaoDdQWVdfm40O/QRXnmwpNBlCUS0CB4l8ZsnP8+Bj4TTKblGSpelaUVieJL1AdkytyKe9SE/ycQzvM+lByIe7thlVEdsKMnZq/xwc75o9F/krcvfAJEkHCnAPDu3Swx86N0eAO+oXPhzXyU3W6H/vyXjNjp9+MaEGsw4wSae2xm8GfHqoyls+BWbQTlt+MReg9AbWlOgpWZTfYo1QRbpKDJX3lF6f7GRGlzudmfF/RHVENlm542x4KXeLZlGBCUcGggdZpxY4htwnUqAy5YEtqmLUcIxc2xNmsvhKeXX4GrjuZmgEDE7Qizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNebX8LP5fYnd2y9mZJk++tpSwDaK5rkuIskGLBREQc=;
 b=SFW2uZmyWptXzP6mtpimyYXh3u+vyOgj83Pc1GLPKVpa7oj7UH/Gagtz4KufPtt7Q1D8wicEjRA7hpgcl7wYXg5j9PQNl9FZgLcUm/WES2SOq15eKlW1qPhGviatpSoZLJru1eHSop+9FyXsVHQDetXmKZHe00Diyy6vQPfxs6s=
Received: from DM6PR14CA0043.namprd14.prod.outlook.com (2603:10b6:5:18f::20)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Tue, 4 Feb
 2025 08:53:47 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:18f:cafe::15) by DM6PR14CA0043.outlook.office365.com
 (2603:10b6:5:18f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 08:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 08:53:46 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 02:53:43 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/3] arm64: zynqmp: Update binman configurations
Date: Tue, 4 Feb 2025 09:53:38 +0100
Message-ID: <cover.1738659214.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=783; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=1GyIBAfHtqlrDjeTiTP7bTCrtmMoB7pZaXPW2LVGCS4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSFVyfPNTohvuoL+5nPQgVeu0tLfL8+Sr0V5rO03/9q1
 +ectXd+dMSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJ8H9hmKcW/37uzJDCC3KX
 r5Ut45v8OmXDwzSG+a55fxNPViwRrtWc5mrOeHeJWfWPRwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 57891259-ddf8-43d3-b999-08dd44f96fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+8uX1jDyXsLLsq8f+/jN5QZo29s/d0GDWNJkvkgf9cKijWCkKwuLAxMXZqov?=
 =?us-ascii?Q?xcS2m1XoGklitm1ovNKKNLghjbbT/jUaTXCMkVeXqzYAF/rCLJWZ+aoq5Q+y?=
 =?us-ascii?Q?LDv85NXnQnxCxOPRcU6VKpoFyAaodMGuGpOkqLOKSdEjyiEcxNkODTXkUj3c?=
 =?us-ascii?Q?aFYMW5E/EoneFompRvpkX3Nyl77GvmeUkBjb4Ct+4iuqLp5IX0n6tyD/hYbS?=
 =?us-ascii?Q?IA8oHzPj8M1nAks2sv5qFCUevEnelBmJXac7KTj4ViY74eWpq3U6zyMDXKar?=
 =?us-ascii?Q?Xk2olZJ7D5BKbAoEAHnUzZVjxh7QiGD6qADtluSC/q0SZJeu7Z8FczauONoL?=
 =?us-ascii?Q?Rwfl/tZaEoeZ01AoUz2joMCFkSnbP38+aQUodxLfo1VZNt0Zctvgg8ayWjQV?=
 =?us-ascii?Q?Cu3GX+uLhQgnxYZEc/P+/QvPT+GIVAv4SBV0DsAB26kTzyt7ffVpdCVRsm80?=
 =?us-ascii?Q?eA1WZzvIs2AlTp7ah9JrmWECr4/GiDAr0bwgoFkskJZzzXXx4MlVQ6SOQ+tO?=
 =?us-ascii?Q?nw0yDzQKTbIuqJ6OnXD6FcrdxdAnibsKsivsSYHb3ghzIYi1JSeQd2OIZfPq?=
 =?us-ascii?Q?dHgl7Cehe7749CByjAyeUHfFz5YgI2eijm7HCtlHXGBd8252R84Ci8aMfxHw?=
 =?us-ascii?Q?yEB5HwKm38XYE6Nh29GLKFnCtlK1qG/Iv2Y5eteuKHLtdaS8YqLe3H1gN17u?=
 =?us-ascii?Q?htwb0eth7L+GIihwQdj72c48BLCVv2y1/HoKCCdm5F4QuZLBvKIAX+K/GpOc?=
 =?us-ascii?Q?HXKQe0mUXE6f+MrQ1a1/w53X8wlAoTwUhRdxrmG3PZVTkBc6IBZHSIUY7nt6?=
 =?us-ascii?Q?2LVVABxxuk/ediJqjTB7Q6krYzWU3JAaVEHC9ppjlXZqp+kDHI3zzA6afYH2?=
 =?us-ascii?Q?ygigjH6UNPnyuCPDJ7+CI2806FH+iIwUbVbCT8vbHiCXcX2jJSYNs+Pvij8I?=
 =?us-ascii?Q?2QbhjaEp4QZ3jzlif1WvBt8XZCkHE/MQZwxz1QjeKn7l6xsh5VQJmjBmXo6t?=
 =?us-ascii?Q?ctb7Nggly1wMamgqsBai7o11aEsSD/gRKDmis2s0muCqarKBrnsrM6umQ9Gx?=
 =?us-ascii?Q?UycjrjXdba6fEKKObw9zMeKlY5ahcY7I7dforYqEN8AYOKwz1E/vSPWw8Bct?=
 =?us-ascii?Q?joDPl7YoMVfybYkyM1pmRsNd6oILQiTlmMmMJUdlokLvna/E0OK1g04XNZK5?=
 =?us-ascii?Q?qgSBTGzZ4itC8KqD4DnMQBqETVZOWTyTy4XZ7xel9zsQUCsLmThu6I1uTWm9?=
 =?us-ascii?Q?v5JhjAfi2zIMppdShE8TAVWbJeNX48v7vrteSq4xfTCLwbh1WI1qaq/hxE6H?=
 =?us-ascii?Q?XYMM3SeSIWsJy2IIgHZpC3AHSYRN4vRwEPI2puGy1dY7pI0bHs2wZzrLVvRM?=
 =?us-ascii?Q?Q4Fu0t6P/NYOtGJljRmdp/6iL4oxmfAAaGCaizWftm9zVGmvRNckZrJ8og3/?=
 =?us-ascii?Q?guXjjvYXVNlsgMaDTr87mm643QshjZvbxI9i0OoVIOLKAJbid9rypHMTIDC7?=
 =?us-ascii?Q?iW39m3ZQIy2Ra/Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 08:53:46.9601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57891259-ddf8-43d3-b999-08dd44f96fdb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
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

I wanted to test u-boot running out of EL3 which worked before and there
are some small chagnes needed. At the same time I found that TEE
configuration is not using proper load address because it wasn't tested.
And also DTB location can be taken directly from .config value as is done
for other values.

Thanks,
Michal

Changes in v2:
- Guard CONFIG_XILINX_OF_BOARD_DTB_ADDR usage in binman

Michal Simek (3):
  arm64: zynqmp: Fix TEE loading address and add hash
  arm64: zynqmp: Use DTB address base from .config
  arm64: zynqmp: Describe images without TF-A

 arch/arm/dts/zynqmp-binman-som.dts | 16 ++++++++++---
 arch/arm/dts/zynqmp-binman.dts     | 37 +++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.43.0

