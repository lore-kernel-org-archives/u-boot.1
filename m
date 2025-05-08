Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCA0C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 15:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D3B82AF4;
	Thu,  8 May 2025 17:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Aa0YwcMj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89FEC82AAF; Thu,  8 May 2025 17:16:04 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC8B82A56
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 17:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uV8bZ04B6NHHPbQS06KbXe9AOpCqDdvN/yj/DsDISRq5U3VdXLFEQKaUN2JTuIjLWmXTadYMq594a0DgvAx4jPaIVUtLZBXHaa4a83s4JlMg0RcNZfLE87Ts/sx7V8l8mc5FeAchssbYR50dfwEuJm/YEK9mVKlOupwh244N2XzwwElaZoxJbxTTDKsIvUVRYtzKu2BOuOBkTX22bFI9uK0f9kL2RXac9xA2nSl/MxQhOobQUn4YmTVU31+wqJYjSCufSVV6ui5iBxa+Eygt+t19SDDlrRxxDL8iC7PONDRRc2pQLIyXxsQRE2v8US1vYfKr15Wc7xehjEI8U6POgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPnSwpe7wCAEd7y813GeATGnU5/gSt6xLHuF9Me6SQM=;
 b=QSPMwYBg3/Ncq+Hbe4tKKVfhoL41orbEjpAwbPNtmKpU5jBoW9x+0KfrIjp6y3M/HCflJKVHQxeGjWdnF1TWUHZDaON9rjq/9weXT9HkMDWBi7dG6AXMCgVL/r/odxtHpyTZGGXOf4qdZYLwwWeMOmyLAXw4e5ouKcP/g0CP5lvmkwrhzFhcn+K7VBs6hD9SL/QUOC9J6c2bItf4VmfTHVuUJYv48oLunEhF6/0tD8mJR0Yp1OaDuwyqHI5f3333yn4eTAXto1Q7sy4sYNyBKRYEwJh1cskjFkeZOzCXqGCKljgjQ974M6BEgjNkfAC3TBtYJqvJORnXO1VqSr9AtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPnSwpe7wCAEd7y813GeATGnU5/gSt6xLHuF9Me6SQM=;
 b=Aa0YwcMjoFAqkcRTnINiK4HbYmeZNfxsYkivS/UfTsOzY1a/tq/MLN6ESkGJ/0dTxxJLVJ4cBaSJolceVFKPJj0k+LWdQSFoizrzLV1GMRGItfYll6A9FAJYsZJLAKzd7TuhzGbeygSUslI7eftdhht6bESdUW0thqtQfsBPc+xKhSy0VMg8vpgEMmGaaE2VRF7qOFjz3nQvdIq016XoQSix6EXuVmIeYVRHXMKG0JztPETiRO3FSEPMtQGQ3fiRUdZgz7F2qbl3oFGkSyp+P5E19D7aKViB5/x5a/2scpGS52zkkS42TTuADyy/NBnXVAuYqW4ayzOZKeSHUTV1NQ==
Received: from DB9PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:10:1db::14)
 by AM9P195MB1188.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 15:15:59 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::3e) by DB9PR06CA0009.outlook.office365.com
 (2603:10a6:10:1db::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 15:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 15:15:59 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 17:15:57 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH v2 6/7] board: phytec: common: k3: Factor out mac address setup
Date: Thu, 8 May 2025 17:15:47 +0200
Message-ID: <20250508151548.162122-6-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508151548.162122-1-w.egorov@phytec.de>
References: <20250508151548.162122-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9C:EE_|AM9P195MB1188:EE_
X-MS-Office365-Filtering-Correlation-Id: a41a4d61-e7ae-4a48-434d-08dd8e433d18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zwxXpKU3TsKJv+U4xqZwVpDjMxyK8ut/TjucKrz655fCX8yKI7CYU6IDsTnd?=
 =?us-ascii?Q?jd3UcNf++kbGn+T7UmUL83K+y2c4J7iLzz1D3hPKt2pAdNXiQJUAYnw0XTus?=
 =?us-ascii?Q?Q/IFPgBLZnyUMFN4Ll3G9YKfBVwDxSXP6iwTx1DF6kbyvMIPepSgpag+Fu3P?=
 =?us-ascii?Q?G1ppEEfb4zeH6cQslGibflBaDzM8tamxnhv9PW66Ydc1qSyNJ39vmZ7Mzl26?=
 =?us-ascii?Q?DOcXStPVg/EQAGyee13rpATkad1aaoU4LNHT/UEfLojGUHTL08D2CwhqyfcL?=
 =?us-ascii?Q?RIBdPdP/++YOW0QtjpCNf15LI27Q4rBqV/39fQAZdrgjoH9iGbu769AZU9TH?=
 =?us-ascii?Q?E5qedYcGB1fw8nIw0/ZhmiboiA+1mrwCnYZj2c0skmRtd1SaHEK4Aqzf+QqT?=
 =?us-ascii?Q?WxOtjshd7wSlG8SmQo6WonK0mUW9aOSGv5d41z41oCOgomX68TSb92mUkBwE?=
 =?us-ascii?Q?QDORWnmpo2P0uQnTUadTAMozT6eiYKdV2bP0kX3xyMIswjIt6APewP4xTrvv?=
 =?us-ascii?Q?Mimc8JqmcNd5Et00de6XnvvvrW1vBOPDO1pEOSCdh0Wbd7dPh4kN5MfMxGOH?=
 =?us-ascii?Q?eIXa3hPq6/t3gKmG3CMiF4FoM+vnMpsF8Pi71gjJ4m4gLeo9vGR5o2jxDt0r?=
 =?us-ascii?Q?9wEZFtVhQy2dhar9hfPniFtqPhf4WLCL607USjy+jEjEpyrdihg73IoiE7we?=
 =?us-ascii?Q?i7LwHG7O2X1anJSc3qXr3C1S0GVPrAKg0HAPIRi0/fAeEWNaAWsWb4imINpv?=
 =?us-ascii?Q?LNH8X/bdD9vZKaseahlOuz9Zfg1eyxd56TgbpaU16l/O7CqN72YcVNZtTKaZ?=
 =?us-ascii?Q?to2KfyGFlYBFvJkhhSO0lwcaLijEic6unKcwpCjJzCzl0tEvBJ3EZN6Tqtvh?=
 =?us-ascii?Q?GhYikt+owZG0JdeJd3or/aySZAsTkYMlIsmI6xg8xxhpTWCRzaV19xbKjF5d?=
 =?us-ascii?Q?oijSxWOpoI5H/uEIRyO9cAo8Ci3P2YPg8Vtw8YmyO9pD3fYnrM+VrLuCinWY?=
 =?us-ascii?Q?rAXyX0kjhUBMuY5ZDcB6dKophelfjTg2s6m1o26yFrTr5iZWRWOGXqEPiVic?=
 =?us-ascii?Q?9qzrFeatb7OTf0HMfYLeM+aayDKYLVMpGKIpc5axykRMZpyh04kL5aGbwKyO?=
 =?us-ascii?Q?0gZ+j8iOenghU5L1krRw8oFvy36LlRKdhPnoLsdLPnutdBmmTINA8Ml2oBc8?=
 =?us-ascii?Q?Tsn17RZFizI0RAqBXK9DgRv6KN4EUKQk2BXV2glc4KX1uEIzTQtfPZs6uuoF?=
 =?us-ascii?Q?qBSZceNiX7wN3oUzfr1B5WuePGpmMW3MZZjAsd/eViiQkpn91hOp+E4uL225?=
 =?us-ascii?Q?yIZNwLd5bPF3LJqZv6fC27YwG31cdIbrai+aJcrNBONU/TMQQkEuVabjwc3i?=
 =?us-ascii?Q?krr1tp6BUqNHKzGZZBld8EI64W8bjjGA+zmrVRb8+VLigKWVVso5AJPFQOFZ?=
 =?us-ascii?Q?+xlHsg2fZEP0dlYHqp00E1CluYnfFJEENVIyFEdWs78KDvWi2xQ0EQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:15:59.4710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a41a4d61-e7ae-4a48-434d-08dd8e433d18
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1188
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

Factor out the mac address setup into setup_mac_from_eeprom().

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v1: https://lists.denx.de/pipermail/u-boot/2025-April/588142.html
v2:
  - Move setup_mac_from_eeprom() inside IS_ENABLED(CONFIG_BOARD_LATE_INIT)
---
 board/phytec/common/k3/board.c | 44 ++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 755b9ecd407..d9aec16b090 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -176,30 +176,34 @@ static void boot_targets_setup(void)
 	env_set("boot_targets", boot_targets);
 }
 
-int board_late_init(void)
+static void setup_mac_from_eeprom(void)
 {
-	boot_targets_setup();
+	struct phytec_api3_element *block_element;
+	struct phytec_eeprom_data data;
+	int ret;
+
+	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	if (ret || !data.valid)
+		return;
 
-	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)) {
-		struct phytec_api3_element *block_element;
-		struct phytec_eeprom_data data;
-		int ret;
-
-		ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
-		if (ret || !data.valid)
-			return 0;
-
-		PHYTEC_API3_FOREACH_BLOCK(block_element, &data) {
-			switch (block_element->block_type) {
-			case PHYTEC_API3_BLOCK_MAC:
-				phytec_blocks_add_mac_to_env(block_element);
-				break;
-			default:
-				debug("%s: Unknown block type %i\n", __func__,
-				      block_element->block_type);
-			}
+	PHYTEC_API3_FOREACH_BLOCK(block_element, &data) {
+		switch (block_element->block_type) {
+		case PHYTEC_API3_BLOCK_MAC:
+			phytec_blocks_add_mac_to_env(block_element);
+			break;
+		default:
+			debug("%s: Unknown block type %i\n", __func__,
+			      block_element->block_type);
 		}
 	}
+}
+
+int board_late_init(void)
+{
+	boot_targets_setup();
+
+	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS))
+		setup_mac_from_eeprom();
 
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 	configure_capsule_updates();
-- 
2.34.1

