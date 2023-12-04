Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AF1C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 21:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2FDC87825;
	Mon,  4 Dec 2023 22:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bO7l/s57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 094F0876A4; Mon,  4 Dec 2023 22:56:57 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B8C987712
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 22:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tanmay.shah@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyW62182ccTHCf6rMt0sZfbP+qYwaF9nWrdo1cKYNveEaYrG0e/JUfAQHyddffWkg4E6uQzsFr5uP8yXLqtjYWTOI69+2vQmxboPDxAUMo+e3XgQwACPWK1siTyAbKrfWFcCtFN9xt9sG0caLe5KGy9L7Fq5kKZRqm509Vnm1+TPIJIZs3u34HmxfBnDp5hF0NPqZ17oap8Zmjuinw5VOZ+F/rMzOn3s9KDG75HjP37jqmlYpyRcGpvDxboI19gCudFmDrUlTnAyXm28s7EvCmIUiIaP6zknR7Nyz9vAmQrXFObQwxLewajSmJWou3eZsCbxkpRqzA8IRYUomgjBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5X9oKVgVTc7jO1I3vbJStI/LHDxAG2E384hRRrEkvk=;
 b=bWHAQ0vYuaRLLiW4Xt897lr5Np/YhfR0crnrHU1F47+zTH0VdFMW390y03y/meqc7Q/Nr0R2CY9Bi4dEwtTdAnrMANMRxuZl92f+IzLRFQpPukjT4oNhPByR47N7CtGowci5i4xNr1X4mfBcDNdQCMiL1tPC+u2VBS4EcY1SxZeYKzhcw9pfyZs1tz6kGEkwJdd62nwgbHWANPmB+GkppO3lxn4vVTMOwJs0vUvLZXC4vMSP6eOmCFuNTMLqXy2gm1FttGxV7BgtFohnjJxlqHzri/ea+0qogAL8gXys/+vHM+kGmdXzpfdGrO1E5CTchw430MQB24OoliYlnvftLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5X9oKVgVTc7jO1I3vbJStI/LHDxAG2E384hRRrEkvk=;
 b=bO7l/s577jdCTSHQjZ+RPJNQbT9UF95U7TBu1SOtQrTHNUozvqT/aWBaEmOulqKNOf+V0waINM0gDhHF5MtZJ+2FHdSuHZMD+7zczGQpvVVDIqFKKO5nDspVqbJD9Z7gAnblkhfY2hguEZYEAcPgkIXQisV5XSH2gjJ8C5UiivU=
Received: from SA1P222CA0134.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::7)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:56:51 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::b3) by SA1P222CA0134.outlook.office365.com
 (2603:10b6:806:3c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29 via Frontend
 Transport; Mon, 4 Dec 2023 21:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:56:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:56:50 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via
 Frontend Transport; Mon, 4 Dec 2023 15:56:50 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH 4/4] dts: zynqmp: add missing destination mailbox compatible
Date: Mon, 4 Dec 2023 13:56:20 -0800
Message-ID: <20231204215620.63334-5-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204215620.63334-1-tanmay.shah@amd.com>
References: <20231204215620.63334-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|IA1PR12MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ab01a5-c8e0-456a-3726-08dbf513ebd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUQQSxZKqg7t4xEKVmFz0ZH1FIiV2SSipcbmynrjUbjflM0fvL3FNwmv/uOHR4MpIkYa5g84yv7nf005/KdOjh0t9D0VF1TPJyNkAiSzCKXgFEWBVzQHYCfb3auUrWAnxVRuInoatJnHXbVt4u10Xaw+vlLwKf7mLROyffxW1eYFFioXs9gFylmsQkKGlwE4G3Ygt29j83f2YAaQR6DMBvhzhHAD2TXEVkCFNT4Iue6FwWQ9o9ku7lu/aBbKLMDE74LGZP7nDoGpqfjXRF728481tLUti5aPm+vfGPN4yQktuoNjlrb5GO7K3Mch0/QMPR4V6emF3Uf8c3SStqwwnml4rdC265chCX/veH3iST1U5bWWp7596gII/MftXUUtDrpa9vDkITLJ/v3HlNi0b2VHplYn4LKv6cPdhlbaRkvutPS07crZ6uP1SXkRVY7JH3uH6nQe7pPO0Jc8rFjIe039cjnyoh1UfQoNxWJE2WO0mdPIdyYrLtLIpPHLcSPi/pEDN130pES4JO04Y5zvIJ5afYJre1Q+FiVUTkFjjW5MJTnOUf5kowECpLR+jHI1h6onZ1jrLmXpVVzF5Fq53w9Ck6biFdTf3Jh+S0nrqgUz7MC1TgL0byerHVbL7h0muQFkiM+lxUJj58Ew6SVWOIpMSiExfz50LdzA8i9eTUFZcwjFydCyZuNwHmDOlsh3u0MO2o8OnyxeIl8w2A7j7ZsRRLy/HcKNCbnlOD9y7JPBs83ummLd1b1snOEo5n6L2sPjePJ4luf2mr8nwSrcew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(44832011)(4744005)(86362001)(4326008)(8676002)(8936002)(2906002)(15650500001)(41300700001)(36756003)(2616005)(40480700001)(1076003)(426003)(81166007)(356005)(82740400003)(83380400001)(478600001)(336012)(26005)(6666004)(47076005)(36860700001)(316002)(54906003)(6916009)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:56:51.2103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ab01a5-c8e0-456a-3726-08dbf513ebd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
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

The commit in linux kernel 81186dc16101 ("dt-bindings: zynqmp: add
destination mailbox compatible") make compatible string for child nodes
mandatory that's why add it.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 arch/arm/dts/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 58a56bc1bd..21be909b1a 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -148,6 +148,7 @@
 
 		ipi_mailbox_pmu1: mailbox@ff9905c0 {
 			bootph-all;
+			compatible = "xlnx,zynqmp-ipi-dest-mailbox";
 			reg = <0x0 0xff9905c0 0x0 0x20>,
 			      <0x0 0xff9905e0 0x0 0x20>,
 			      <0x0 0xff990e80 0x0 0x20>,
-- 
2.25.1

