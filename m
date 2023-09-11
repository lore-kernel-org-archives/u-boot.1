Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259E0EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CB1D86E32;
	Mon, 11 Sep 2023 16:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2x0adcXv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860DF86E32; Mon, 11 Sep 2023 16:11:11 +0200 (CEST)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 603E586E29
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mvo1thgyVRvXXxxc+H6MT0Ao8Es/v/EFMuVKUAdTzfjwE5r/WjpH/SGd+Fzp3gtkKI6yApFdf59kf8jpQZ5LuVnzwzHu8UWdlFbueLBCD1sb1UQ42pNn6Oe3CaBInDCIU7CbcWFQdzoIOS5KP06XzCM1n+rrrzbznrnSAIHMsT0GZEvKiIFEBefeAfcOLgltSC1ZUXURU84K8z+OaZ8Ucp3+Jcvrxw+GE1I3IgyROuMizNCHYqEerTAJE3GSlpp1STUmy6oQS3DQxq+dHr5r5Wz273p1E34XHTxf47XWaQZrH+5NKZA5MHaDzb740V3du/TAC/kPj1fstDT8JCG1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLIVOOj7WuVMWfjgqiXGCmjvH5ied6XsWLfC/8lE5yI=;
 b=XWnpYOTXnUx1R49yLDJBjgRP3Rmd5Aua6A+bJrECd3QclTLkSjGVrgYv2JSa2eneRMoB/W56j3X+jYOIMjOrPKDHAzxrsKbTSYP88iOxL5A4Rq9il7YEeTKHP8eAOBQ5DJJOdUgfRbJoeW7BYYGSn7ehkjNvB/dZg9+ymwoCnLzdpyqcncLufgnP/QLVvEPA3G9t8pICCkHo+lGK/JGTYOJnH+IWYCP4VqFfzgR2boa6GbgI2mgyWd+mNqPgE8XUMHw/Ccs54UHM2veOjIoqujCp+YOKaN4h5P8MlqNfePAyesPQVmGL57UFuXQFb5qL4JnVeH6WMv7oA58S9Q6pHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLIVOOj7WuVMWfjgqiXGCmjvH5ied6XsWLfC/8lE5yI=;
 b=2x0adcXvhKuaoFCA8JG/3Vg1T8XZkCU19MdtG/NBF+IJqMQJTSzyQWLlac59J9o43EDGxQZMFYD1M0sUeRitkBxAX63+DxGWoW6rmIs543sDwaFe/ajw6WQTXnBvRabXrRBFEkR6Dl/b8XnoO0jIlAmIUXl3mE+uZCU41jtsUpI=
Received: from PH0PR07CA0118.namprd07.prod.outlook.com (2603:10b6:510:4::33)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 14:11:02 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::19) by PH0PR07CA0118.outlook.office365.com
 (2603:10b6:510:4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 14:11:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Mon, 11 Sep 2023 14:11:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 09:10:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH 2/5] arm64: versal: Add no-wp DT property in OSPI flash node
Date: Mon, 11 Sep 2023 16:10:47 +0200
Message-ID: <7e88dd7b9306bdf0738b2248bf9017e1997d25dc.1694441445.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1694441445.git.michal.simek@amd.com>
References: <cover.1694441445.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=NQTDzKD3Sf8D4IKvb8LyEVFRqoshK8JrI4ZrlDDI930=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/8s+1H+XI8tWp/pbfYHc8ZaWjcc2OlSWaoRPuN3w5v
 6stjOlgRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiIxxmG2WwM0+1XlZjYh9X8
 nSRkP9PixHYvE4b5PmJfK974ZdUWOO8vjfKf/c4s9ngVAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b43e078-6c6b-470c-855d-08dbb2d0edab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ZU3F6G7oj6s9r9p0RptDgDhe5Otf7hgCxH4xrSXaWMIFWUhg0FanIzW+EAOlYkBUoIBT8XXhgKbyWZ4XHYBBY371XqawmP5RslH/a8H6vZ/rVcwd1m6F9/7xmgKP98KOnbnvUOQqiOoxv2jYvM23bu5AbL5cpSK755eLbBu+13ueORD4Fb7IXUIAtuagH1qsnHkTNbccuh3ZXMmt4eaDc4groStQexcUnXVNzsuLPD6f+uCJ9QH1764B7SSDNZCqO7wE3wdlKiZtB9YpnsP6tVU0/50EJZnVsGmvYUS11878/3WOzE+6mJaYmp8duHi/0ZpWyzMxErakKqadwl8OKAbF/PcDb/VTo00/x+5zqwpjWfjIca/lhrNn8cGDRj7GOhjObJsWjarGPZ6WJL2jKw7ajPdY9dbFm1OXvQwokQhqOoFZ6iSlD/4KT9pFS7hvvtB6iiZCAkFT7u+inw492FJYLV4Tpmqjoetec5xI8GShmpLSivc/ekd2lIvjS8j1BZRyW1LflWmCOdN18aWkrO71z7HE9a+dY2ZHOgO2171DTABpDF27OjIqebRDAbiugegwnYqpnkisBxOrS1rv4UbxTOCUsRQncQoZPf6JAgRH6arQz9C23jpPE+ufVE7ofGG7oHXxELijh146W7GUPBaF8W8h2dCuMhGrP1guG7DQqsl61OgKhVVMk5ELyU2T8FT39cK+3vj+adHw4t3RfYOzfpYlISAlPD4dxF59Qi7YJgXGBNHVe4DfXJfshA09EnEYtFl6jx6kMoaotcaFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(82310400011)(1800799009)(451199024)(186009)(36840700001)(40470700004)(46966006)(5660300002)(16526019)(26005)(40460700003)(8676002)(2616005)(4326008)(8936002)(47076005)(2906002)(86362001)(356005)(81166007)(82740400003)(36860700001)(36756003)(426003)(336012)(44832011)(40480700001)(6666004)(110136005)(70206006)(70586007)(478600001)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 14:11:01.2814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b43e078-6c6b-470c-855d-08dbb2d0edab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
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

From: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>

Added no-wp DT property in OSPI flash node for all board dts & dtsi files
on which the WP# signal of the OSPI flash device is not connected. If this
property is set, then the software will avoid setting the status register
write disable (SRWD) bit in status register during status register
write operation.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-mini-ospi.dtsi     | 1 +
 arch/arm/dts/versal-net-mini-ospi.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
index 19caea7368a0..5683a2306bde 100644
--- a/arch/arm/dts/versal-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-mini-ospi.dtsi
@@ -57,6 +57,7 @@
 				spi-tx-bus-width = <8>;
 				spi-rx-bus-width = <8>;
 				spi-max-frequency = <20000000>;
+				no-wp;
 			};
 		};
 	};
diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
index ce8e2158f6ed..5d188db62d92 100644
--- a/arch/arm/dts/versal-net-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
@@ -72,6 +72,7 @@
 				spi-tx-bus-width = <8>;
 				spi-rx-bus-width = <8>;
 				spi-max-frequency = <20000000>;
+				no-wp;
 			};
 		};
 	};
-- 
2.36.1

