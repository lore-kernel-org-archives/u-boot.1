Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36A910ED66F
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBC584010;
	Fri, 27 Mar 2026 13:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wE5DVuyg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B78B881E18; Fri, 27 Mar 2026 13:54:00 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9453683FE9
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGFfx8xuQ1gMgh7Kqy1rQxKQBmWXEG2+7uBUX+uv0ZSz6jmps7jw/tLOal/1H0g/YH+1fXGSfwT6UT1jTPEdr7dx6wuDJ6Oh1/+RD2eo1Bb/LbV5nXqpuAdoQF5RcqeOJ2xvr7xLacsmndoz3q1xIi4hqS4Br4mS5FngzfMb9ffjJGcdYlcmOx7QLZd114uGWawfg5EWElS4rgw2WIwok31WgWB4/CqZF2ZkGAFSgITp5x6w+NQVa8gqqVjuGfnGuEuL8VtsyJZBy0F04pNfdcqvrcXotH9K+ruhL0wMSdxMbUZBf9KktOiyfKDVLWzg6I+3+OiU68763R2pIvZ1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz5BGPA0xbBLplc6cz6N1Tm+E6z4LiWdP6pBS4ADXGg=;
 b=woUnpKC+5o4Yo7vj41BE04+MiCiwGujugZREGyoX0yFeFFEjDAH+gFJZhGK3Mnuiob2A+1+7kZUZtwxEvvVC/7IRnZF6bFdkAoDuHptDY6NgTys3+Eu3nVPV7g+y+guiUuIpb7McBl5iXqqQloY+YbvvgGchNM6/QGDrID0soLi6JdKc3PnSIPDkXrxfqzEP5dZnXaApfug3bBdCmEp0QuGyXjWLVcktWMLfs9eKszQNaTfODMzFHJHhal/P/RmyzO5OPIyKNW+TON3JXW86nFr6CodxcsFoK7q5ygVZxdDDWXeDjU/R+h/GIJub1uYGuiQm3y6veZOT2R3+ccL5Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz5BGPA0xbBLplc6cz6N1Tm+E6z4LiWdP6pBS4ADXGg=;
 b=wE5DVuygaI7V2vWk5DG+9iDygUV4SGe8mVYkLgEhx7znkdbxQY0wp9IpeOs4GG2EyuAOdO+tJpfP8acB0gh4/+Keb/VZhbSy9c2h3CvkHvF7oofer2HuWlvtMDJLMVnA6kJarAganpnmN+UZ986TnNX+9/L0wWowl3pQJ+IOMBc=
Received: from SJ0PR03CA0134.namprd03.prod.outlook.com (2603:10b6:a03:33c::19)
 by PH7PR12MB8015.namprd12.prod.outlook.com (2603:10b6:510:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 12:53:50 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:33c:cafe::64) by SJ0PR03CA0134.outlook.office365.com
 (2603:10b6:a03:33c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:53:49 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 07:53:48 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 07:53:46 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Naman Trivedi
 <naman.trivedimanojbhai@amd.com>
Subject: [PATCH 3/4] firmware: zynqmp: Bind TPM2 driver for Versal Gen 2
Date: Fri, 27 Mar 2026 18:22:57 +0530
Message-ID: <20260327125318.1037146-4-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327125318.1037146-1-padmarao.begari@amd.com>
References: <20260327125318.1037146-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|PH7PR12MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc04fed-7814-4188-68f5-08de8bffe493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: J8OCppdoH4lQ51zPCcLj7v6LCGa2cxG3J02u2EVRyK9YGRt3Jgp6zURFwvQ/q1gO+4nrY3M5XHYWTeWqgxm2k4zL1ETSQL9l1LNfKct0nL1c2bbSo/iAhp97GV2qyTuf4WBIa0ruqEgLmXWEadYwNVk7amLTKFpyGTWbYRLSmuMgEQRZzxxwOgmAWocqHOQMkyvOHg7nide9VaXz09DjBDBZjioDTbKEekhapcQkgh8NGhKRmk2O/laYDjFSn/XFKjx66wLx1CSzrcz6yaq8+f6q681ZRGGDmRViyuhbTxRcan0OZgm9dfgQ8dEdVTrM61SYn/1ZISrboGNx6jEOUq7UVmut7iIXh3aVzK5mUQ+q8OSAQ8G+xVJrXvBicQIN276TXjzt4p6smHUWeqA7SjSS3uni4Y755OoOMTNffX470RoT0EglwZFq+mCTSTIHuyjg7R+H7F2IeIYmqbAlVpfill45obe5aj8qCWt4Sv93gMwsYp6XMP/XKuLamKW82UjcMJHn9c7/sOlY1Z/Pr3069mWjHvTMbr/jTLejAo4iPgoytZ3gqtN0nWZmOmcGzPiSKcZT0sU5D6IAVkKKgUskFkBbC2eN9fwhDBlfyiQjzwLvP4cIUAiKgVTdw0OQsctu2tq43iL1FePNwXccjH6iNmtrIHDwtz6+BGBbowvdKcaeJJqG+yU+JruMnQ8eP19p0UGZ63Fs4MULJR8/IvJTTH6y8H9QxTwXFTAgZOUi+FPO7dQ3s2ZcTZMJnR1uis6lIYO5Hr0jM7l4h6e/gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YNoO2Oo5HLpLXksVh6nQ3Dr6J2QQaMZMWZxvu+jO7Y9xewG6ekYa95uS93mMtzyw2DZQEtoLFu0ETK0x1n+lwLe8o8My2iuqC6y/amwFpoMWmvGMeHdeEtBV/PSG4YcrZyF96scSR0jrRktDA9tGcOg90FfEq+5zbtOXgU+OF1k6MeGsOG3Tf94xt1dmpYznElDKY3ixS88FOqahd+nVihEO3rck7b3BU5Ju/7IICu4suVOUgjaDde71EPvSc6hMmnuM6KBfpMqjgtK0OvFLL0y52UJN/uYA5d6T+TWW9Z0UbgZboSFFSnHo0W2nitp+ur3sY92T+8ulCgSMpDiPsBKX4lAa4ajHZyeJEHpSknUsEnCM4mMQyeEhtAkmBMEOVGrPoq/F5rUR4t/9Z/gICuSubnx3DHJ9WGk1pLUeOaA3QCe7xwk3H61ko2qHb4PZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:53:49.9635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc04fed-7814-4188-68f5-08de8bffe493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8015
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

Wire up tpm2_versal2_smc in zynqmp_firmware_bind() so the driver is
probed automatically when PLM confirms both EXTEND_HWPCR and
GET_HWPCR APIs are available.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/firmware/firmware-zynqmp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 2315d5932d1..4a0e4eaeb51 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -623,6 +623,19 @@ static int zynqmp_firmware_bind(struct udevice *dev)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_TPM2_VERSAL2_SMC)) {
+		ret = zynqmp_pm_xilocp_is_feature_supported(XOCP_API_EXTEND_HWPCR);
+		if (!ret)
+			ret = zynqmp_pm_xilocp_is_feature_supported(XOCP_API_GET_HWPCR);
+
+		if (!ret) {
+			ret = device_bind_driver(dev, "tpm2_versal2_smc",
+						 "tpm2_versal2_smc", &child);
+			if (ret)
+				printf("TPM2 Versal Gen 2 driver bind failed: %d\n", ret);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.34.1

