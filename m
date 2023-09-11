Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063C0EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA48B86E2A;
	Mon, 11 Sep 2023 16:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="17AB2PKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505D286D05; Mon, 11 Sep 2023 16:11:03 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F57A86DD0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuLUcIissEf+7IG6j0Oq6nUw1QRD16ZXlC04dbYcB6Vj2H0x+J1bnC6of75KM+LdDMz6208x/3N9CnsZ285XcSU7mK6I0Tr1EF1ArNi9ugjfLzWqf9XqOSgypAo1pjvKydET4PbDFbbVqRYS9k0+0fOQpYITg89Hj3QZlB02MxPdXcGONMYh7sY2GEIwcOQ6EWyAFIxWH7Ftj85oaR5V/WFG8lP7wSY1NXeNKHGGRWJ0USvSkrYfQiTAU7Z8iUoKI9ztlMhwSg52mMNigwUE0yJuVcgb7z/3hlYPX0KuFVUFwgac8Z3koD+9CoW5xaQLyU/xnyRzta1zsbeMdQHo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRpIxKSaDN45EpQW8HmKroX8uBgJGih9UEN8qjC57A0=;
 b=K4fWa0Dn8/MZgzUfbWwWM2jfjEUfv0p/zmPqeeRH8lC0iPQObwiDI4HSpCh/otoCROvAQgL/JWA/ztKzlKdVCeRK/DqZSUhrXJ/9h435rRp14TFvMecAcn63qR0htIKU/lV440plht8XEzvZ3ZT+Ldp8+Nya8jQ1NyaWD0pSOO6/LbpjabSIQEVX/6zeNFvCgpUZsxTL/Dxca5BbRWjXD/GGKsdt2S2vLwJACuf2ipWsq28QzV5XzprKDA6luwTC3tgRT5ZehUFMw6mbQOClT+FLvZxRI2YMPc/+jPLUirOlJiOOuHXuq7eYxQ0Qf3glghGpPz66iDgpkiI5WFfgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRpIxKSaDN45EpQW8HmKroX8uBgJGih9UEN8qjC57A0=;
 b=17AB2PKq5XhXUUQxfTT3go1PHMonD39BIJ6eilM4GSAt9uRLU0x4hvTCWspS8ta7BSH7cgw7V1o6tSp5+l3sBst2s8JZYTCMOaouuFd1yXQCeshKc0plGzqlk23/NXcWbRPeBnaCcyL5lDXQ2w0n7l9DRRYFPJ42K8RPP6XYaUs=
Received: from PH7PR17CA0047.namprd17.prod.outlook.com (2603:10b6:510:323::29)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 14:10:57 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::a1) by PH7PR17CA0047.outlook.office365.com
 (2603:10b6:510:323::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 14:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 14:10:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 09:10:55 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH 1/5] arm64: zynqmp: Rename xlnx, mio_bank to xlnx,
 mio-bank for DLC21
Date: Mon, 11 Sep 2023 16:10:46 +0200
Message-ID: <ace68d4b7701d1606a85cb18242409fce941b363.1694441445.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694441445.git.michal.simek@amd.com>
References: <cover.1694441445.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=960; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=vmgN6TKbLDKM2z2ADVKTALyUaVMimfO4H9lYZ7v/BCU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/8s8vas7axpmz10OkZeWBusbZBr8CEtgbug9G19UtK
 7/Tu0qnI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkYAvDPPX0XcVXlC0vy6f4
 rv9Z0Fy/tdblOcN8P1fNACehDHGJxXpK+hdDF1vv+r0KAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 834241b4-782e-4916-d15b-08dbb2d0eaba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZN3/pJmHugucuuj1sfQgrgTNboH1hFMmjmgAKNxnkHicKvwxE2AYlSIKpHlI7Bq/MIcsEdRNYMrcAJhowf57MhLppp+arGpyhYtRMBQBf+aC2ueOj2BQ49CGih3C8ZYx0VmWw7eYJq9+3dUuujk/AbRMJc1nqLSStDO06AvGBBfxJZ7nv+XtbwYjBW9aYQ1g7SEfOcxuT4uQTWa//KAC0ADGXRCl56/Qktwy2Rs0vOPquPDuTgMbCvECbW4QKnXNDtaNkaruicRUuNLMZ7pejTfgXuTMtfgmYpSqaFyATgJLkOX9+r1nboHfsLPDf3Au76FGrHsYkLcZrh8dLEA7efKN7aVGHl9OmfekaNZNvw2N5kguengdM0+sd9w848BHPuKQqYIRas73gV9rEw3V7DUf2ZpotCC51qK/8BkzcQpcSljWgy+w6PqVmU3IURe9b2WX2Gizc+JvpWv3NVd4ogJNyLq5f451/DVKvHyAuKgtg4LOBHaaodrK8muc2K85LbeVRBuXdiSE2SgqCKH2oWBQcZccUjyjbAj5JrMsNuFXwoMkhPhy+Tiqw0OlUq7vWOMr2qFiC8tytCebKcvV8DUxhOJudKX+vf0CmA0HB4oKUVgZxo6LkWdnFXgFZyiuBmLiU/vgh7mpn7nvlJ9bydTo3VXh2xaH5nLRGtxmQofXSWRy+4ecEFjfwlW+h911es4JQjn7qSvm9+qWHmcJTdUdJHfxsea8J18597XyBVnnaBqGo70jUrsvATAy2VbdFp/BTfdlYoHeb/fe3WwPdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(47076005)(83380400001)(41300700001)(5660300002)(44832011)(8676002)(8936002)(6666004)(478600001)(16526019)(26005)(316002)(336012)(426003)(110136005)(70206006)(2616005)(70586007)(15650500001)(2906002)(86362001)(356005)(4744005)(81166007)(82740400003)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 14:10:56.3485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 834241b4-782e-4916-d15b-08dbb2d0eaba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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

xlnx,mio_bank was used in past but it was renamed to xlnx,mio-bank because
'_' in property shoudln't be used. There is no impact on the platform
because if the properly is not defined bank 0 is default. Bank 0 and 1 have
the same configuration that's why there shouldn't be any issue.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-dlc21-revA.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index 1b247bfa8944..016081ef7b99 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -61,14 +61,14 @@
 	non-removable;
 	disable-wp;
 	bus-width = <8>;
-	xlnx,mio_bank = <0>;
+	xlnx,mio-bank = <0>;
 };
 
 &sdhci1 { /* sd1 MIO45-51 cd in place */
 	status = "okay";
 	no-1-8-v;
 	disable-wp;
-	xlnx,mio_bank = <1>;
+	xlnx,mio-bank = <1>;
 };
 
 &psgtr {
-- 
2.36.1

