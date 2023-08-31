Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3DCC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ABFF865A4;
	Thu, 31 Aug 2023 14:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PV30uXXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F25F86550; Thu, 31 Aug 2023 05:26:33 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D584D805C1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6g2j/+Uq4r3dc9+xRep0IBp2WoALSmW8pw7MXAweJkBSX6/ji++KhU4m9ipozUvQsj9sAmiIf6R9NcTCYfFeZAYlNvAYw7KsYgQOOT1ioylsjeQdQH3qloancn8dwXjhc0gq18UWObO4eNmy0HJxaRRZw8W0w7/KhLxlUivMBZb/juQZ5mvgWBwJz825g9IXRwIhQNtnqDSehYCwSOuoZm7tw+pGeUHN26OrIhvkUx4hv0xd5f6ryn87dVs0G294pOOzKjlAjYkko1vQgTONZxtul8QD9F3mIm4nz6mD70fXkFHt4RS26H0iWg/4wV3hK8+i5k4b+K1s+xczHzs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjS1omHpDjDpbnoLI6gQiJtCcomFYUhlH2os3NYpoX8=;
 b=TMxPBuyWp+m8jTf3b/yB3KFimuGLOvMyu7lVi1SoVwq/igD1e8+Lte6N7CDGwCcnTusqSVYr3KpB+qDD9/Nz2u7NcKr8fMo2Uuw5vfbrhscU5oCrYkCS6d0CrzLB3S9dx8MHGaITyt4w9tg2DA+joModg5m2TPxO6VZ+c5r26H/ekf+uOJo0mYZ0KSoxNlaIjW3XwDYicbScB5ne8QhXLcQhNPT7+O1Vn5MOfbfew/R+RUuGSma/Om7KRFMn3TkGzA6cT9WbctkJI3vdacw7qN9RyGk5qH6z3ib0w1MKueUe6FzIxahLPCiaE9Pwq3peFWjxImRJuLY1ijTQ4voWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjS1omHpDjDpbnoLI6gQiJtCcomFYUhlH2os3NYpoX8=;
 b=PV30uXXFE25eGH/Nl7IDTSfphUT35Pqok3QIJbIuxCnDuIwR4ym9PEILxHKde7n5czzkyZ/jmZgLkCDpxjFeclSUAuqbGIP0P5HuTw+0f6pX4JgC3/VqlF74UKIkaF6a47AKvpOLmX59uaMjIYeXAsb/IW6JqnxzQWk4xrZlSHs=
Received: from MW4PR03CA0317.namprd03.prod.outlook.com (2603:10b6:303:dd::22)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 03:26:27 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::c3) by MW4PR03CA0317.outlook.office365.com
 (2603:10b6:303:dd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Thu, 31 Aug 2023 03:26:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Thu, 31 Aug 2023 03:26:26 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 22:26:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 30 Aug
 2023 20:26:25 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 30 Aug 2023 22:26:24 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2 0/3] arm64: versal: Enable CMD_KASLR and TPM
Date: Thu, 31 Aug 2023 08:56:09 +0530
Message-ID: <20230831032612.2729-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|BL1PR12MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 8390fa77-df6d-471a-7a67-08dba9d20f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNGuPdqJ/Akty7QBxlalRBxfl1jdTCqd8nARKw0LJB7b0aWfvWLvkt0ptP4wDn4vU9iy5XcEpIn7osVKE6iXMGgw+3y5K6NVVGI9FMZXiYYw2rZUOJOgToAOlMojUD6rZlzOXXitjlAJwtMYrctN75P+hs92gJf5PpwXgCijpaA0CkgbD1MteOCpOc/DAWYfv7CcL59wjzZUxEbfnxGJeicfWkC9lMkuWc7+5+0dkhusnHcix6YRaFb+j/g1HukknnwW6dWx0HVUyuFkK05+bbe2QKhjMQ6GKdHW2yae3tYvIuklo8VEkTFFwgLS9eTXAW0fdieBseeDNJ3m+W/CvvXyCwutSNCSfTBedwDLbnN/y7HiQwG95YjAOvcHRJVXCW6FpnIjuI34mCz6AcamLFp9zFtgwdtzFOOZgwaoy/WePJej2Xk+TKcvYBL3kNVGXF7ZeFAbmvvi2zO9J4RneYZmTmL812FOtpAkWXiXVDIOGw9nNSMmYmHJt1jYBmwUHx2NELtbFR/qwqpk4Bn0rYokvnXAXOe1xbNOgxvQQ7EhapLyINAh42LKPznD6nhNP+OU76/2R9aaADw6rj034Sdv67fncUO8Ms22rAov32cnGOMEl8ktJ+7u8jAcbhtqbc5NOzh3Dnz4rd2413mxtXOvyONm/Wa6vy1B4pzt7ryRUpDyhKwWS+osLGx1+uDFVL65wlQL+Mt8TRxo9Y0DXan05uCtfViwfgsR292+qFq+Ow/nIrB3dbdgTMMytK5Nv2hFCc3mrOdaR8BV/yBDbs+NyLQtom4W3Tgx6ADXZFqY9DlUbn42qKliWBdWV913TFT/ONWh7K7Lh6pgvtro9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(70206006)(41300700001)(83380400001)(8936002)(336012)(40480700001)(47076005)(36860700001)(8676002)(4326008)(478600001)(6666004)(6916009)(70586007)(316002)(26005)(107886003)(2616005)(426003)(1076003)(54906003)(4744005)(2906002)(82740400003)(356005)(81166007)(40460700003)(5660300002)(36756003)(86362001)(36900700001)(414714003)(473944003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 03:26:26.6194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8390fa77-df6d-471a-7a67-08dba9d20f49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

Enable the command kaslrseed and tpm.

Changes in v2:
- Updated the commit text in the cover letter.

Venkatesh Yadav Abbarapu (3):
  arm64: versal: Enable TPM for xilinx platforms
  arm64: versal: Enable sha1sum command
  arm64: versal: Enable the config CMD_KASLRSEED

 configs/xilinx_versal_virt_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1

