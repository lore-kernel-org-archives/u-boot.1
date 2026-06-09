Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5969CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48AC58486D;
	Tue,  9 Jun 2026 09:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLkbKlB7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D9B84878; Tue,  9 Jun 2026 09:48:48 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED30D84841
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9v/ajdR17DMyPbOAlRzhQqynAL1wYfVs3no8rgXLGERSjosbDS39q9+xfXHGJ7K/gWzUeSrRtAZc7STnFF4lh0I51Pp5fvgwJNCEROqtS+J2HebALBRuUisoUMI9QYtyQ2nLf0a4ESJ1NCV74XLsRX6UXFODnubwRei/uVp/YV9j9Q0RXlg6SK1KiK5JVE4WAxP4KsP7hBHskysd+Q5B9ilJjX5M+rs+aveaawXwnSf6NO9BbNr66RFqXHgpw5oIqocIUt8SRrJ1t3rou5yUzD7BWuuoFM52LLph0y9bfw/sdlKWOSfEEh9LD8641bVqqgAald3JhdjeIqQp92HEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh76fXlBJ5ZG82m7ebefZol4An7K91melNrZojpXW4g=;
 b=n3iUai9WBWmd3vg7xrC8YSqtD4vVCHobK0OcG4FRzvb7hGnMVW3mXM/tdNQ9rNmb/CWjLIhh4wFI6zhKQ5JcXFrqwUk90PlqzSZpZ7SKRXEXiC+0kRmp/g4vRHFKP0hMzaf0wkqzyG4IQnYD/2wMUMvzxEM5DObn1eCq9z1i+ElejTZx3lp2kOw/0/JvdriBW0N4K1Ob9ixneYTMC19LSofyHB2BrZDnXtN7ldiRRMosrlERNOWRV20gZVseP6WI/keF+ZutlJQWuLAQOLeM4jHRxoc73DcyEv3Uu8oYf/wCZHoeNMMSjP2JxCISjTWPlo+yUkrKg7thNbVYhelI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh76fXlBJ5ZG82m7ebefZol4An7K91melNrZojpXW4g=;
 b=xLkbKlB7U0/3XnTUCmfqF63bAtfqhIvH0zGBsaAD0MlgAkgFbb8fjSPkZgZPmWdNdEabZDNqQB4Lkx+IX21WFAgYegmWKqaG+p8HkfhxFpkMW5STFqLXblbm6qVP0hCeVTZMC9JjcZ0XwoOy27SkcHUKzfwvl/c2PR0p3eJsvEc=
Received: from BN9P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::15)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:48:41 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::a) by BN9P221CA0021.outlook.office365.com
 (2603:10b6:408:10a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Tue, 9
 Jun 2026 07:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:48:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:48:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:48:40 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:48:39 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Trapti Damodar Balgi <traptidamodar.balgi@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 2/9] arm64: zynqmp-dlc21-revA: add mac nvmem cell for gem0
Date: Tue, 9 Jun 2026 09:48:16 +0200
Message-ID: <49490b1d510f27f47e71e86c7d1f29478111ef81.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1248; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Hhm4FkQIQ7zcSceGZOE9jHCXKJ754pZf2/Hodp1h+CI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSpH3XZtXqjt9CmYHbVaxFxkxzyw2b/2hyQ5c1kF2afk
 bRXZrNyRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEykSIbhf4Ja9+9z+wQ+u+9e
 Gm28naNyOXePxOZMTc+PaWzZX1O+MDEyfHL4Wct/9KuTMUdm3NTYbeKWq52P6L116i6+07/5ROd
 CfgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 207afc48-6dc8-4c2b-a4b1-08dec5fb8646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q5OIEUsGA+iDVUB6aZ1P1aGaoblUCRPXhFrIRruR/nfKdYifcVjr6Y5uQ71Yvg8pYYFUWfqrSBam2Ql3klsiUD9FaMii52Ft15uVu8n9bxg0wVJbrfzQgqiOxVanB9PJcODBf/HmCIESxr/YNN3ZZnJuiwT5WR2HssJsRANwlV+dYdNByG5lW1lwQxNyCvL/WVcubwNcVuCc5rafInCOU02ArGDmnnarQcgjxAA+t5AmHgSjimugAHFP67dNRnjBu+jpc/rCFVgefiiV45mZHHwy3KbWBYHNvqnQLAvLJ69oRAEm7MncIdtJpn6apIT/FaK2KIWEtALNnz+bxK9QFQ0sA5RzN5YZYvzlI146lISYcQkFJ82Vz5VEC3QHvllIoONoQbXLp5pfATY0E3cJJQdhOIW7Zoah+DPaJYkdK0WEzTOUtBwu9fMwdQX63J69XsZc4PzDo7rVJ7R8Bxv0QoNMb5bws95huxBly0JdRXVWwsI1+6gDpXKTwLp4OMOPSghl2JL9pqC9lqBXYMz/Sb0MVq9edLfP3u5MOgwQSyWooS1RL4xnHVqkZLg04kSGeGuehAuoPbd9OzI5jfOf/vNW996e1lUB3egD/9SpCVd5s1QgMG6bHZPlUeFX8O14ViITNH/kFwD7J+MIcnX960jLbmC52PqifjBWVWNTd1FSokpSyPM5cpbZELAuKD0zHh74AX23OMZXqwji2h0O1Wb33KpZ/WLvuyJJOWVY0NQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NDmRIabD9iDxtCxdwONGcf4ufQXAFFZgS+ApuSbP3zndqthwc2SX0OLv4N9aIY/PcZtMZXkHjN2rmlhZYMp41kFCwc851ntu+lro3gIxlQeZ4dwlo2H9oAhdyIU4eBipzPlw2M/AgTRfe0P53NHeqQs59xgSfMLCEC6I4LTyHHws3KrEaCSaPOwYpmS4wemBv6MRf3jjBT6+LivOmenKAxwPsAhgfOrIwl5tdcXDgKjMTl+pN/gQZQQQQnU3Qhh0kydxfxSAz8sLKCIMS9gqDe223f1ePi3Y6VQy4EUPdifdRD2t16jRqvhjsohOFGbfckk4LCmmg8dnhEFnKF9dzgcWwSbPc/f7wig/AdX+C5XGpzyf8K3RM9sSCs1yDLYdVQGn6YTjmrf2nHaXGOdOR/thX0dC4IJtyaxhvspIh0rIQxPJaDt65ovb/MrBVLWO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:48:41.2990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207afc48-6dc8-4c2b-a4b1-08dec5fb8646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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

From: Trapti Damodar Balgi <traptidamodar.balgi@amd.com>

Enable nvmem support for MAC address retrieval from EEPROM for
ethernet@ff0b0000.
Add nvmem-cells and nvmem-cell-names to the GEM0 node, and define a
mac-address@20 cell under the EEPROM node on I2C0.

This allows U-Boot to read the MAC address from EEPROM at offset 0x20.

Signed-off-by: Trapti Damodar Balgi <traptidamodar.balgi@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-dlc21-revA.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
index 25cd0a09c944..83c39ce1a265 100644
--- a/arch/arm/dts/zynqmp-dlc21-revA.dts
+++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
@@ -90,6 +90,9 @@
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "sgmii"; /* DTG generates this properly  1512 */
+	nvmem-cells = <&eth_mac>;
+	nvmem-cell-names = "mac-address";
+
 	mdio: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -153,6 +156,12 @@
 	eeprom: eeprom@50 { /* u46 */
 		compatible = "atmel,24c32";
 		reg = <0x50>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		eth_mac: mac-address@20 {
+			reg = <0x20 0x6>;
+		};
 	};
 	/* u138 - TUSB320IRWBR - for USB-C */
 };
-- 
2.43.0

