Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9942CD4F57
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 10:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1478F86B81;
	Fri, 22 Sep 2023 12:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jAKH3Iz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5CDD86B73; Fri, 22 Sep 2023 12:37:02 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC3A86B08
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 12:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gezkTjK9WVhrx58ZXZFdcMmVDheFo1LLvW37qwmum9VnCrik7ahwzRWCq3HZgscCO35aJaR1NwngIVeXMMjhuz11f9iOlZ7yfSoNNzLb4zDDyfM9SelxUPmyIKsj47DQAN6lnS+oAHtapKBODnr8zC8ptSVkV2kKPhg2lUPx9NqbaqopyOMGIY8jnCbVM5zPt9DEXFl0hqNKPtu54/zG1Rz4ChVEzRbYpGALyJwNTrHFi3m1r6SwrGXZBCGeEwbQz9GjX+przmC3/TsWRXdlu7dljrX7kbNJ0w4Q7mYpqQQi9jpfeWXdxyAFwcAByXNeUsf0K9r2dJPfg9bIQSBWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o0BIGIzarPbwh8JVcx9fXdIPGz7utBn8BzqtIrEac8=;
 b=ddjHl5SD2p4wlCwj3U1Xe0z/sw5FPwsHlJ4fGlylQOjkpvMBG46B5/ZgWkQRjqfDg/84qHG1w71Jo30bMA2fSuPXYmwehLLEOfKJcKxNS8Fi4eJI/Zo9+rPFrbakxLnswjOcu1PwHo4M1GRNn3qxMaKjzKO9Vm+MA/ScG/vlmucU2czmBKm5fjtGajLsm5v+F6OHAhMWCPbnJWQgm91bvLimIeESt22g+elQ2STcaw4Mhjsw3asqpXVIFQIWwClCGjI+FUlLGJo/bzQD1RFOt3PJbjVKIhz993JKgcVsPsY6qQJOnikBG2mv4LsI3gW41Q5BiWM+tTE/GX7V7Fo4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o0BIGIzarPbwh8JVcx9fXdIPGz7utBn8BzqtIrEac8=;
 b=jAKH3Iz5RhmKWmOeoH9y1QTNBCbLeKzr1OAu6xKHNtqJORFX6LEBoweZU7lILQXAyDaBvL+8hNq+dhMsYH6Z9MkorloqzOi5rr+w16yq/5Xd6jI1+NxTR4DraPdniLy9ndauGYwvVIHyQndXtDm8Xl+TXqFXZuFGxM85QQOssuM=
Received: from DS7PR03CA0009.namprd03.prod.outlook.com (2603:10b6:5:3b8::14)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 10:36:57 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::6d) by DS7PR03CA0009.outlook.office365.com
 (2603:10b6:5:3b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.32 via Frontend
 Transport; Fri, 22 Sep 2023 10:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 10:36:57 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 05:36:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/14] ARM: zynq: Describe nand device in DT
Date: Fri, 22 Sep 2023 12:35:42 +0200
Message-ID: <3fcd68ccdfed5e6c079681e3b29e06583ec8a375.1695378830.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695378830.git.michal.simek@amd.com>
References: <cover.1695378830.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=4jiQU4DyYfcKPLvRwk+Gdzft2DFBNNWN00LT4Ewj+DQ=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlTe3BkKwdPOTso6yiq9Ofu9XqRV4C7BLWpbA0s27zj6f
 d8X04yEjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCR8BCGeXoS0r+clCstD6yy
 fG1+qj9Pkr/2LcM8m8NJX14+jRBqnFZuaBavtfQMc6wzAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d5b22f-2448-401b-c87a-08dbbb57d8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z7fbvinAqx47sNWjhgBqWZQZ4M5C2OB6tES/dG1UnPFLQ/Pr4r+8qlMgpxuHJUNNiHeTMQTjxdysBIsI6qtl5xvwHTGCPO5zbC2+aXWDHNoL6stz5Q4p8VRPwe/OxBIse5pOloRRBeI6ymm/KELiwRmGK7cC9FAix3AcyxELn0mVRTwpdI4t2lcku2DRao4B51zoiytG6L59agJ69JPEKoiK3fo+k1dCkqQkECsGCEGIkUEggQ/QBUezUXdqJj9vKvOIIbnFc5leFQPUN6gHJhy+ACJNZb2kVangPIfzJ8bk73jSjMCioh6Z4VgqG2KXPn3vlk+yjwRgRiAosrWKUfGoElkhNDEx3XH9RWmmjPXldLRPRU6aorKnru0uwl4LtZkW7u2u4BEEK5g1k1YT70EgIY0wiypo2Ad92wNkHzXM7YuTKMEHW3Oc3vfaezA46DtugCaOH8U2fhzviMFRn8qWZ55QUUeShPWoKJA8ITT9SIslPsnl/00HtGJjMBLZFmmqk6Q557HrP+f4/Z7inzuIyJ1WMcGJlO2N8uyt+dz9YAXXoxrQfp/poz+sh5EDaTAOCS0fZqFGZDjLt0UHkHXXUysaE22HpkOeFOB0cpyy1FxIMtfkqqxCDd3RbURu5gvgb5U6iPVSQQ+MWO781y3dUKMabzoRvSk8M0ZTnI2LSCCvS9Rszo2dG7omMr3V7nKxIqm/32sI4XsxO0wImQJ5aUR/YsvVKdJCR4sG8Jsl7Dc6ugdyhmLZm9wLM0LE45VDfPdb+2G3hIdJbAE8x0l7/RbU1xC6pEqi1niU0wh3E2F9HZuNjivURMMvdODB1vhb91nSzE+/5YxrlpbgMnOsZnXrJwYxSExdG5P4ZmQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199024)(230921699003)(1800799009)(186009)(82310400011)(36840700001)(40470700004)(46966006)(478600001)(110136005)(70586007)(70206006)(5660300002)(316002)(44832011)(8676002)(8936002)(83380400001)(4326008)(40480700001)(2906002)(41300700001)(6666004)(40460700003)(16526019)(2616005)(36756003)(426003)(336012)(47076005)(36860700001)(356005)(82740400003)(26005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:36:57.6411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d5b22f-2448-401b-c87a-08dbbb57d8ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
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

Linux requires to describe nand structure under nand controller.
If it is not described nand device is not detected by Linux.

Error shown by Linux kernel:
pl35x-nand-controller e1000000.nand-controller: Incorrect number of NAND chips (0)
pl35x-nand-controller: probe of e1000000.nand-controller failed with error -22

When wired:
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xda
nand: Micron MT29F2G08ABAEAWP
nand: 256 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/bitmain-antminer-s9.dts | 3 +++
 arch/arm/dts/zynq-zc770-xm011.dts    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/dts/bitmain-antminer-s9.dts b/arch/arm/dts/bitmain-antminer-s9.dts
index 6c47396ce759..0228b4b30e5b 100644
--- a/arch/arm/dts/bitmain-antminer-s9.dts
+++ b/arch/arm/dts/bitmain-antminer-s9.dts
@@ -52,6 +52,9 @@
 
 &nfc0 {
 	status = "okay";
+	nand@0 {
+		reg = <0>;
+	};
 };
 
 &smcc {
diff --git a/arch/arm/dts/zynq-zc770-xm011.dts b/arch/arm/dts/zynq-zc770-xm011.dts
index 02214349feb7..d1e971254e51 100644
--- a/arch/arm/dts/zynq-zc770-xm011.dts
+++ b/arch/arm/dts/zynq-zc770-xm011.dts
@@ -49,6 +49,9 @@
 
 &nfc0 {
 	status = "okay";
+	nand@0 {
+		reg = <0>;
+	};
 };
 
 &smcc {
-- 
2.36.1

