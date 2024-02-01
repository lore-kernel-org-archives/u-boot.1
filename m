Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36495C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:39:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD7587CA6;
	Thu,  1 Feb 2024 13:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sz3cYf9V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED33B87C80; Thu,  1 Feb 2024 13:39:20 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B4D87D01
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 13:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H30cejTQlL70nAyUN3NvOpX0Bk/6N6T/qicVlc48Lw8lXlgMpu9D+PX6tsoWo2dWZW0jw+rtWwzaYgwBEt6AxgqsXaloJ63t2O9NmjuwayYglgSzjEQz0wrA7DorF/jQteA1S2WaOYMKdkpbPUQb90jJ9DgZWwnXflMJFej8L4mSUc0jg2Dgk7BTKLGKWLsCVkjGDbK1LkVuvCJrBAU6MChkVXHRxgPZn0haTNXnqNjVugnZgVA0MRwE0EbLCHCMVP2iENDjzw0Jpcv+GCvytO4pKTHwzgqRU/31a7VGFugk3Ru435ZumDalcjKjYCI6n5DaYQ3LG9RuPa3Zt8vy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEYBLP10ty3pm237jUl+b/BfBT5UsK4D6d9dAU80cL0=;
 b=NnEoEVUyzNWZ/CUtQnjBHXpTL5u6UQ3Nbqm7TlppBkSX5fMOI6760ygkc5odV1UMzjJAf/47F1C6jCQ6+ybwxle3o9tCWkNB26U23o0sGZKHnIkpK3lelwnGydiHwqUCzJN6+30kWcNxs4pbOrihYz5He5oG4+Yt9YAFIEFBT3dbiPYX1pTE/BGEQFI5EfnXKRTF6ANyQ0fLfHUCRbFuHegTsmMCDLJWudQ2q3GcK5/SgOcZk2jCibxA1qTzzv1J4KWXSwWI9j1OZTsp7BBA6yJCYzPImdCDz4en8PlQnXCjIVn5OYWjqu3BQTywGpWQQH70UmVseOiv2w/Vms85uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEYBLP10ty3pm237jUl+b/BfBT5UsK4D6d9dAU80cL0=;
 b=Sz3cYf9VUAr93Xd54wOsM7KKchv7cfoWukK5LbXpK1nbx/nNB95uqBqv44ebW2YfNpRKjE7TuSK2Fi8qWTfYpII141zSAh4kK+e5qfKAlmEwu23Fs1fA9KKzlgkWKFVPI56n1sBEF0jWzv94E/cR+vYFl2CH6YadbnEqqgs5lDU=
Received: from SA9PR11CA0003.namprd11.prod.outlook.com (2603:10b6:806:6e::8)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Thu, 1 Feb
 2024 12:39:01 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::a0) by SA9PR11CA0003.outlook.office365.com
 (2603:10b6:806:6e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.27 via Frontend
 Transport; Thu, 1 Feb 2024 12:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 12:39:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 1 Feb
 2024 06:38:59 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Harini Katakam <harini.katakam@amd.com>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>, Neal Frager <neal.frager@amd.com>, "Radhey
 Shyam Pandey" <radhey.shyam.pandey@amd.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] arm64: zynqmp: Do not expose usbhub nodes on kr260 usb1
Date: Thu, 1 Feb 2024 13:38:43 +0100
Message-ID: <862ca748670f18f25d88aa5b43c37e3dd6aa35eb.1706791116.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
References: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=YOr0HbgeqkI9Vhf2z1umG/r/fNVaIuDsIfPB3plPOrg=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTdEy5N32lrvfSVMN+HObqPw9wzxL02FFz4feRYCOOB/
 U4RH1lmd8SyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJSKkzzM+7+MNjEns125ZV
 KxSb/uWuXBfcwcIwh3dm3+H/txRFtgRlsu9Zov7/29mnUQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 76805364-a822-48aa-1de4-08dc2322c44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0l0aakuzVVzsi8ciPPsZsIa6KMnlUD7YmsAykp8UXkwe3hKYQYnQoCMk6THv0nuwHvjZ279sL4Z3CgXIUgHfrdgErHhWMuMlBKDg7FydaPv9vhxlCy3QyLk4b+wa1u+XYBkanrwTRXxB7j8RVVk+n+CqBxBuw9+2rnc7slja50H3RMyyU68aLvDLSFm4cxoNB3uZosXER18lOJspeNCwyho11syfaFz/ZBBreVhmlo/kiBJx4C08WYgBLS+nyw4sgRP+YQTq6YV7RZXCuOY5B7oU5Z+ip2YdeRUvflLG1cSpuzIxQx+IE3GfSCziDrSaT2ZAbPAmFBmbBFDrmjYOFmp9Q5gcyJvpbquKbwVwtAD4MoG/Dorb0O6QNI15ZAj57XekdEQj2t1gkiM48LBp2mO8QUmyFJ+zMZs8lfkwHYJ8qIk3PRg3G3s+ifp81YVYKgwhdkAs6V26O4Ot3U3eFzGKzfS0RvsLlO+gsNBVxKPPckcF/ISaN2hisLEzGSBkd9lR7H8daQwAXoV1PN6D641Kl/OeUhvFvv0S3ZmMb0oCJYbxhD0qb1RatjEnnFbvjRWqPLoSrgvfPQekT5xaqu7MFBi8OVmKicvBNo5vtshbCPCieP09S1HaZvu7K1k0/nVXo5aNeH9tp+C0YWCubTVgpUMlDpzMTEj3H2GkKnFS+nnrBRNX9n76+9G8Z+FF4918tGACyZfOutoQMXbHNmBC2tbYZ9oZn5pGfue+UqCU8867yWXb/Xyp5/kGOJCl0c2EWNQR0qAdMFr1jxzJuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(46966006)(36840700001)(40470700004)(2616005)(336012)(426003)(16526019)(26005)(40460700003)(40480700001)(41300700001)(36860700001)(54906003)(316002)(36756003)(478600001)(6666004)(83380400001)(356005)(47076005)(82740400003)(81166007)(5660300002)(70586007)(2906002)(86362001)(110136005)(44832011)(70206006)(8676002)(4326008)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:39:00.8522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76805364-a822-48aa-1de4-08dc2322c44f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076
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

usb0 is already updated but forget to also update usb1.

Fixes: 4ff083f09bc2 ("arm64: zynqmp: Do not expose usbhub nodes")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 3 ++-
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index afcf8a8ee6ba..ce7c5eb6d346 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -174,12 +174,13 @@
 	phys = <&psgtr 3 PHY_TYPE_USB3 1 2>;
 	reset-gpios = <&slg7xl45106 1 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
-
+#if 0
 	usbhub1: usb-hub { /* u84 */
 		i2c-bus = <&usbhub_i2c1>;
 		compatible = "microchip,usb5744";
 		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
 	};
+#endif
 };
 
 &dwc3_1 {
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 24be5dd84e19..6c29f6574134 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -175,11 +175,13 @@
 	reset-gpios = <&slg7xl45106 1 GPIO_ACTIVE_LOW>;
 	assigned-clock-rates = <250000000>, <20000000>;
 
+#if 0
 	usbhub1: usb-hub { /* u84 */
 		i2c-bus = <&usbhub_i2c1>;
 		compatible = "microchip,usb5744";
 		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
 	};
+#endif
 };
 
 &dwc3_1 {
-- 
2.36.1

