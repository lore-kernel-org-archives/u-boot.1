Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16B5C4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3299786EF1;
	Wed, 10 Jan 2024 13:34:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PwFpONR/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523FF86D2E; Wed, 10 Jan 2024 13:34:31 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D350F878E9
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 13:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXlGqPaxj3qt/Sz+QL8Ll151fTNCvxEFrdj90aBXgW+7q2Gm736FYt7di7ywMR4KIlS05l71+jVgzgmEj6VcrAmQGsPZ0CLuzn49S5ZZev6BAJoFFrIRuDxWVoHzSrtcqpHnhA5ULTrMhQFj6IB2WoOzB5vt7kwm5riu1rcMUTGKZLhQ2Emf9PNzIvfGeHJbQR+xR2CVe1NPkPLq/+HRMr7Ozn0oaeQtQsfMJsGlIoVk/o0ioRqiBDIzq0KU0dOwbFfe/IqvqK3eVpvUeRRzYeIl9i6u13LBsY2oBEsPDsEsvwSoxmThEY1Usn+wnB1CrpA3mynQ6gPcssGNodPqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWchV1sBBMUBYJNoNC4MT9Bn8NHAe01TnmqwmzN8190=;
 b=VzXSeZDEQ8wm/z9BP8XXKP+lDFNp2u+sbH19DwDhlXDuA51z/HMPFqWYp99wrjlfgukS9LlxelR9zSsriEljM6g0Tcc52mHcseaKg9QQRsBP9/TdYfT/5hmi/SQjaMBm5y6W1cqyLRaJgRPUHpsPePeNGPkvQ2SFl2TuFtbwWKv/vMqvIQ8LjA/aBvyUE3q3g6ewMxSkqJwXXwl1rWvMGUPQFZvVJX8FNTElgRcT7Ou3jzyeYYkzA+/X0Q4gen+8ftVyAMIEkC94byK+pyBTxmIctc3ml3B33R0J1Cpgau45GKkXRjgAr8g1zyTAJvRWBHUFoy5Y8H9GJOHM7NnJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWchV1sBBMUBYJNoNC4MT9Bn8NHAe01TnmqwmzN8190=;
 b=PwFpONR/dFOxz+4l7EttOCt1ZfF/uLB1JYcnsavfBsGv3iuRKQp6ZesHUWvf68K2gjwRLMXmKPOuO4/NyB6/oXWd/LelxTrT2lPEn6MwqAsCG0GlMRLo/qNrmtzcr5Ot8PCsZDSbGSLrM9+5NK2/CD/90/xz+G80bmNYWF+0usA=
Received: from CH2PR02CA0029.namprd02.prod.outlook.com (2603:10b6:610:4e::39)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 12:34:24 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::73) by CH2PR02CA0029.outlook.office365.com
 (2603:10b6:610:4e::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17 via Frontend
 Transport; Wed, 10 Jan 2024 12:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 12:34:24 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 06:34:22 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Manikanta Guntupalli
 <manikanta.guntupalli@amd.com>
Subject: [PATCH] arm64: zynqmp: Remove ltc2954 node
Date: Wed, 10 Jan 2024 13:34:20 +0100
Message-ID: <f26b1a780ec44444d62e2dd696a05e2a37fa0993.1704890056.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=hxMyXz57gldPVs872qq1bUqSkqtTuV1PvC7LKe3G1Lk=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtR5fScDtBPtElbNkwiX3xHQtefPVRFj+dJVbxeHJDS0z
 357sVWwI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEwkx45hnhX7pEVTbZP8N3fv
 iNfrLvzC6uLZzzBXyOyQx6MmU9ej4ndYN66ufsix9LMrAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 7270e0e2-8c51-4eb9-bbed-08dc11d87a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y7RKWnG5a8i/uMr7EjkZxb2O0ZTVFHTtGqzL12fqDnM3zQzJ6hFhrZ7DTTKIycpEuK5xS//zvqe2wr3X3o2TDnzpLycoSBeS1vE1ZUQY1aU8n4Utie55ukut83r1ygy/wfxlkM20YXMQUuVKbMZYB4iTYoYtgOO2TPuNuIeW7iA17X+c5T1CndIp6gqsVLRp/qvnbzWQn8MUp+tLaUrBGT3h9XeipCyGVAR0eDshan76rMNBuo+aej2aCYYydpEbrafjaHbutjI2z5pMD/0sY8Z7xEgEDjmEBmPYo0AnO8u6Z8wxt+PpZZJ9ZTuqJspv1KKwWeJi4PBlimA87FBrXj52+fJNZu5RVC+8hYSav7H/gGCcvQhQyL4UGyKwsEVBmRaJ9cChRN1UyBT7UNrx+cdJnHSWy+8+gcbrDIEE0g/PJuxhpWnY9mjklwcAn9Cr/plNHayHWpqinVqGVlFI7IUtsofiT49hl/jdQJ+S/Lzav2YZEdxwBxhswioBIJw+ivA9uP8SvlAQb3n4zzuY8Sd5TBdgboY/1XfopLZZQmO+Tsfra3OEyd78VXNF23dZL3Mn1k1q/u0dnSMpvZeMGxHQdaPdf5pVcmQ/fNZzRSLkEFZXlj/sDuXCiTW9yXWPwemrxUApvls5DS5KAKh+cKjU7u9iN8AeEnm+30Ep8CEXzX/ECL6xXKn5OHvEuC1LOcWePeJUOnuZ3nmA3QONhbUKf2UBzrStL4OrNBDAPgrrE4XOlT0xis5dtk/XOJW/AEOU3NXLTJrIsYDL+12Hdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799012)(186009)(40470700004)(36840700001)(46966006)(36860700001)(316002)(110136005)(336012)(426003)(54906003)(16526019)(8936002)(47076005)(8676002)(36756003)(83380400001)(4326008)(44832011)(70206006)(40480700001)(70586007)(2616005)(478600001)(40460700003)(26005)(2906002)(82740400003)(5660300002)(81166007)(41300700001)(86362001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 12:34:24.4942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7270e0e2-8c51-4eb9-bbed-08dc11d87a7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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

Remove already disabled node. GPIO connections are handled by pmufw that's
why there is no reason to have it described for non secure firmware.
If someone wants to handle it from OS revert this patch and also update
PMUFW configuration and pinctrl setting for these GPIO pins.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-zcu100-revC.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
index 49d5cdbba585..c5945067cd57 100644
--- a/arch/arm/dts/zynqmp-zcu100-revC.dts
+++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
@@ -103,15 +103,6 @@
 		};
 	};
 
-	ltc2954: ltc2954 { /* U7 */
-		compatible = "lltc,ltc2954", "lltc,ltc2952";
-		status = "disabled";
-		trigger-gpios = <&gpio 26 GPIO_ACTIVE_LOW>; /* INT line - input */
-		/* If there is HW watchdog on mezzanine this signal should be connected there */
-		watchdog-gpios = <&gpio 35 GPIO_ACTIVE_HIGH>; /* MIO on PAD */
-		kill-gpios = <&gpio 34 GPIO_ACTIVE_LOW>; /* KILL signal - output */
-	};
-
 	wmmcsdio_fixed: fixedregulator-mmcsdio {
 		compatible = "regulator-fixed";
 		regulator-name = "wmmcsdio_fixed";
-- 
2.36.1

