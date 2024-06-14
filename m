Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF233C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5FA88A07;
	Fri, 14 Jun 2024 14:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="opOcD6uV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D6F889D5; Fri, 14 Jun 2024 14:48:34 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C9D8857B
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sybor0VQ4vgw7TBVmbAHptT5LqE22yfpsLNp6mfcMkjbNrD2iCtoRs4745uv9S4hkYCFXMonkUqXVogREicZCVnliz6igOvJ/ifR9Zyo/f542O+c9/qMjEpeJkPRcuMDlmgvob5GXcn5M8nyyRh8MdtKpG1V0FmnWK8dYlsFNB18VgZyHL/jCDOXQB49231NiLauwEHP9HHOq5YIhZ2IuqTMPy0SXYsj+LA214AHcq7CtPPQVeHODZUZ+JdrXtb0JsAWHJiaAZWt7f6pIliwfAGhcj5IX2uyy/Pm0G7//2LpPim/uqhULMkh931nBIVAQdxoC6K7TIzgds4joVfqGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imK9kvLWPKiuSP2A5A2ydUhTVpspA7BYlIynY7Uu5HY=;
 b=eQYkwxMNhHNSNE6wrmIX6bM9tPSHFxgwUnuerrP2A/korEzbhXIYuKsEpOJFJYNY/5Sl8UVfhBZ1M3pTSbjeO7sTfm/jVZVGiKHewj6MIHdSgNwKVZe5/Fr48mu904OwDt1aZTusKZxBGxu9Ux63xupxAC9LF+4M9zynk2JWEBPZ3oNFvhKSllip63BSq37wKasJkLcFm/GjDiWEpOch97lLzLCy9i0e/pZC4iFRmQc8SovBMu5IM53KXP+QxR76R2q/whDJrdVlUBw8tlqEZ3HM/1P0LYA31k20Wj1FnteyDyMSL4fgoTVHxD+SuHmf3X9Fqda6tLOVDiQcai20Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imK9kvLWPKiuSP2A5A2ydUhTVpspA7BYlIynY7Uu5HY=;
 b=opOcD6uVEBMov7SPB4Z/4RMorJlEQfUftEulwBYcX/mCFXoDT9hVG9KThgJE3i1O0eefil16e8dYYuIfiWrQN7/qagxT2gsCKyJdWbPAK++6HKiy6pelPf8R4DzENsiaYMSw5JtzzebkJJdVXFMUhbZF2kW1p0Kw85OQ2EpubNs=
Received: from MW4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:303:b7::10)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Fri, 14 Jun
 2024 12:48:26 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:b7:cafe::2a) by MW4PR03CA0095.outlook.office365.com
 (2603:10b6:303:b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Fri, 14 Jun 2024 12:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 12:48:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 07:48:24 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 14 Jun 2024 07:48:22 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <vigneshr@ti.com>, <git@amd.com>
Subject: [PATCH 2/2] xilinx: versal-net: Handle spi seq number based on boot
 device
Date: Fri, 14 Jun 2024 18:18:11 +0530
Message-ID: <20240614124811.22945-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614124811.22945-1-venkatesh.abbarapu@amd.com>
References: <20240614124811.22945-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 7901ce36-9459-43d9-a6e1-08dc8c70488d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NGzuZ/VNI+SK6EKtWM5hTfexXDXRK5CoA/ZckVJx4siLWFMJ5Y5xTs6EGqVS?=
 =?us-ascii?Q?beuYdb9Zb97b5o3eYimwBq6M0OCHOrK6fyMfYUkXtDQprULiTCl/TdJ4xjzU?=
 =?us-ascii?Q?j7J5Irrd2RncjwnH6JasY/e2HwCLADPlJ4pnO5ey4T68fWjx2eGpK+Zb5vbh?=
 =?us-ascii?Q?mSYdMUa9KZ5RlFjkGkpKLbzSw6xtxkmtAG7hkiG11q9FnJdfqIM/MhBzQujT?=
 =?us-ascii?Q?uLzq1Lh0dMRYZjzsBeK6YBgszDrn1KffCAh3wqiYN780ze0uMrHJtx+g4SfX?=
 =?us-ascii?Q?pXcbvAjk2O98xPn5uYWbSydyz2ESiKrgxgkZLt5RHebqNEemBqUvDzcx/PuY?=
 =?us-ascii?Q?E6VnAYZSAaAQEswqvR4s2xuXKemGzYyucScEBCDp43brF6oMnAHRfdK5a+2s?=
 =?us-ascii?Q?mAkqDa1KO4w6i5V7n+Wr29H+vakvF2xMaWDanUaIfBlRQD38pdqbhzIclqyD?=
 =?us-ascii?Q?glkeeydUmep8soq64t2Y6dHGtiTv7v+OxjS7A/Qu1zC9tNVug1tiSVw5yPfc?=
 =?us-ascii?Q?SN3E1WmfbNXgD45yvubKq4RFRjGz4pDWyGo1fM6Tj3u6Nj/5vhuiYDBfp9zQ?=
 =?us-ascii?Q?6z4QB0l8Wa/8ZcMkgKSUjt24U3mGG0EcAbuDAL0NuYO8fOnwp5tiTPMcM8bM?=
 =?us-ascii?Q?IOuDOqG1X93LwZ9cuBH9SKQvU2WCdEeTQgS8lh04cAgcVqjrwCBKUZugnkkg?=
 =?us-ascii?Q?R8mH8On74u7nisfiPAmQk7kP4rML91E609g3oit/J/Og195RiqmRcE6y88ml?=
 =?us-ascii?Q?3UJq8wrBy83JQfVTckyB1zF8oCmnZQR3Dj1HzxwA3YaXdjvzZdtf++hi1YxK?=
 =?us-ascii?Q?drYKKM1/1TlpJJ7HCEhXZ/mOEUyRHVEJTG3fEWkdft5mgxymTeW6EpxzO6br?=
 =?us-ascii?Q?evsX9aeJCGW+UCYg7ZHwkuP/HhxuI5dpfLBwoveK2Y6HoPY+VXE3I+ixeY70?=
 =?us-ascii?Q?QjVhbU0hW4jqM7BPgGyLe/+0fodcREC69yvaWwQ3tHjGm/2cFLvyO9n7swO3?=
 =?us-ascii?Q?mCy2lx2QhCr/g84aGSTuTQuAScRUMucJHzGzZEAZsZG3RYz6OICHnakPnZs9?=
 =?us-ascii?Q?BYQ9kg1m8vqbpasL9YA25sra6CV36tuNkpOM8Qe8Jfvf3DGB4yzXI9a0YQvB?=
 =?us-ascii?Q?YFDJfe4E/z6fnEb3nh0SYuRZ5swSvdGhj+MggwzfZ5TJ8B8C/BYWQ3iyM9Ys?=
 =?us-ascii?Q?28sGLYcmAjZyO1K8TJm/xP0Iv2FbbQdbfu1G/axZaHJkXGItfwawTFAgTc0z?=
 =?us-ascii?Q?xUFUhGRlCJDmXtugo4OU89Fb0Wmlfnqq2GG3xn2U/pfE5KKpsbqnDG7OqzSL?=
 =?us-ascii?Q?9DCcRoc8gMouxTQodBwNXigDe9mrEoJmiw69dP080MRD9dn1MCrvCrSVUC49?=
 =?us-ascii?Q?s3yAWKCNZ0oKfV3xMnIM6EW6hThLhUKWr7dkb6cSQrbTG9DBEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 12:48:25.7955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7901ce36-9459-43d9-a6e1-08dc8c70488d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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

Versal NET boards has QSPI and OSPI and default bus set to 0
is not working when system is booting out of OSPI which is
controller 1, as fixed aliases are set for all the boards
i.e., QSPI to 0 and OSPI to 1. Add controller autodetection
via spi_get_env_dev().

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/versal-net/board.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index da03024e16..5a93cb29c0 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -194,6 +194,51 @@ static u8 versal_net_get_bootmode(void)
 	return bootmode;
 }
 
+int spi_get_env_dev(void)
+{
+	struct udevice *dev;
+	const char *mode = NULL;
+	int bootseq = -1;
+
+	switch (versal_net_get_bootmode()) {
+	case QSPI_MODE_24BIT:
+		puts("QSPI_MODE_24\n");
+		if (uclass_get_device_by_name(UCLASS_SPI,
+					      "spi@f1030000", &dev)) {
+			debug("QSPI driver for QSPI device is not present\n");
+			break;
+		}
+		mode = "xspi";
+		bootseq = dev_seq(dev);
+		break;
+	case QSPI_MODE_32BIT:
+		puts("QSPI_MODE_32\n");
+		if (uclass_get_device_by_name(UCLASS_SPI,
+					      "spi@f1030000", &dev)) {
+			debug("QSPI driver for QSPI device is not present\n");
+			break;
+		}
+		mode = "xspi";
+		bootseq = dev_seq(dev);
+		break;
+	case OSPI_MODE:
+		puts("OSPI_MODE\n");
+		if (uclass_get_device_by_name(UCLASS_SPI,
+					      "spi@f1010000", &dev)) {
+			debug("OSPI driver for OSPI device is not present\n");
+			break;
+		}
+		mode = "xspi";
+		bootseq = dev_seq(dev);
+		break;
+	default:
+		break;
+	}
+
+	debug("bootseq %d\n", bootseq);
+	return bootseq;
+}
+
 static int boot_targets_setup(void)
 {
 	u8 bootmode;
-- 
2.17.1

