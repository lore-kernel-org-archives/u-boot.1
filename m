Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E08CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 13:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB6C86EA2;
	Thu, 12 Oct 2023 15:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oybIA3ZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 941BF86E4F; Thu, 12 Oct 2023 15:03:23 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1860F86E5E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 15:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkYCAUxXussQGZzJVpUaOYbFs62MRNMzNftPXSiBS2CWsv6K52Zh79nIHQLaBPF5EVhvtVWxYDalZiZO1U7gZLKVh7teOhPH8TOa8hUSlEIMoOp8j6cGNmi2sdUjRPLwfhsLoihzwbYe/OBGJ9OzVYZr7iN+jVADoJCF5O26M/P9mk7v9N4vdKfVvPr8pXU01Wf8HrMIGbKQlsXQQUHTK2/JGlXOq7zd+gONUIHm5wou9u+evO+m8vfURRgdj75BkjpnzM9+PSqMVZDyT/6BHRe9BJfo8GTlgalJ5JqVdGdPoCaWXpOqqdFSdr8JYsolz7F8EJNuBQ3rO/9z0ZwdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25nVY95m52wZyCdB7IUpYP5N4LSmiVhhhH47BpYUlLg=;
 b=CnYyDBS0FGhkwoNcxV4ZQFpMXYQ0J78sU+5DwYtenaoPsrHXAKBV6fzoUumvwLk88LtcLAabVcscMLCMcbw3aeBN1cBF/ptZHY3CSBwMok6eD8eNWFbyKZzxhuW4xb49pLuI1i1QSvzYYP2T7Wpje6JqXzjWu6XNh0l6KCIcodnx6amM5/bVs4lR7QihiBpPDEivSAQO8/Y43l1jvb1fu0VLL2fqMU4PdP91XFP4m6Jh2K4L8lbLZQaatox/qX5bv98lAKRXNkLA7A2wvFTe5PJLun6/ttvFFkKrZyPqxqxjGKblC7q/CjRK/htfEHYCi5rWBLiY3FpwY4BlsdIwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25nVY95m52wZyCdB7IUpYP5N4LSmiVhhhH47BpYUlLg=;
 b=oybIA3ZR2s039iioAGCqzu55OWZD+gSkmNcNHnxcHfWkKlWlFaZB/65DQmu96zYwqxGpYD/OX4C4YgiMHVWTZvANTQI6abSmAcnt+e06xzQO6OlESCjT7iP6Q+6uEmK1OagmD4rIREX2aeHvs+d2JTHlt3fyu7u4qMH79gvYK6Y=
Received: from MN2PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:23a::26)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:00:47 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::79) by MN2PR03CA0021.outlook.office365.com
 (2603:10b6:208:23a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Thu, 12 Oct 2023 13:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:00:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:00:42 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Piyush Mehta
 <piyush.mehta@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 4/5] arm64: zynqmp: Remove address/size-cells from ams node
Date: Thu, 12 Oct 2023 14:58:50 +0200
Message-ID: <0ca8d8fe245ad7cb665f5333202d83f70acfc11f.1697115523.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1697115523.git.michal.simek@amd.com>
References: <cover.1697115523.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=623; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=nVdVj4iojBIVWSBewn9aZOgHJYx/md9oSjizCrGKaVk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlT1t52+F17tF4/YeGpfkKbfT6kvhcJN9yQPXilvC7iZs
 iVbqvhdRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZgIXzrD/PwL6xctTCvhvRVf
 ebHx6v7qpUtjbjLML75e+eigKFPZ7a3f/r+OkzlcbDj/AgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: f90d9a08-65e2-4e43-0f5d-08dbcb233fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmt8BDrvjfMp/CQYRXVQGYJHucgasaFWRCfi1JR0Bejw5ybzwK6DniIzrJb6Wg6Fad/M3eLZvxCfC3af3zxH77biOiUcUHUv/ANNtbksAinkoPrNbBNF6nsJesPtl4dSDFwknZiyYW1m1m2nz3OBQgm9Hytj6xbe86Dm99E3gRrPc9xdN01LWHSk3fMwDGeuipYvkaejakIpYIe/v/+K4SXQtJmgtLzE4Dw+ictggjpAmkIkYQSADE/+bSfaIMYFSl6jcYclcIYy7LMJNehuIMhp7OWUfav97YcYVKSzbxyMyj0LbSKNkViXyhDj4tgqjJjR6WJwAwFvjBgfJCyasTWhBCFGEuy8qAkBKw91Uou8obY5oo267TPno2ETGZbHg0CfUcSB8oQ3ddl9gByVxcJ1SdlYysamE7nggBwsbUSZl9VCNfs9nhCP+/PVIDIu9I7QZXic2WDJWEq+0QM5keyYFRnAlSsyhrzjflzYmS65Ydn7nmx3mbpaqYPEJRAdPZdeL4Mgm2snPJGcBZucx0PRdFWeaOpSZedJQP/7JNYyIoN2Co2TsEiA+nVvZ3b6PEjQ/CmoI/RKovoWQhPn7W9PP4u+4ZTy4b0iiJJZ6KWrUTJ0A4gbYLa9XEYWKqFIU/9tUjSLOHj3sNUVhiLMomC2ahLZY3DoiN9/OsmKF9mYPXzsNmFVhy1Th+K6/FWSdyKQ1fVZaWElyaiaFvvj83TUmDsyb0kG/ut+HinZVLi6U17bWqlVWQxLZmjuFRfQj8qFSOMqfHvA5+AUrHZ46A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(316002)(41300700001)(110136005)(70586007)(70206006)(54906003)(478600001)(8676002)(8936002)(4326008)(40460700003)(36860700001)(81166007)(82740400003)(356005)(47076005)(40480700001)(2616005)(86362001)(4744005)(16526019)(26005)(36756003)(336012)(83380400001)(426003)(5660300002)(6666004)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:00:45.8727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90d9a08-65e2-4e43-0f5d-08dbcb233fe3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
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

Remove unused address/size-cells which is also done upstream that's why
this is pretty much sync patch with upstream.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 366b50a104be..de60233fd061 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -1034,8 +1034,6 @@
 				compatible = "xlnx,zynqmp-ams-pl";
 				status = "disabled";
 				reg = <0x400 0x400>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 		};
 
-- 
2.36.1

