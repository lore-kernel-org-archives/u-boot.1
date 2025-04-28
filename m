Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B10C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6056B82A33;
	Mon, 28 Apr 2025 15:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="YcDfXNmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6E8B82A9E; Mon, 28 Apr 2025 15:45:55 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D0CA82AEF
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyNgUpEwHTd+BgC0gat2dNHHfWf+TXF0xv2wRi3RObhoPcU7qmTfuaK9pAz/E/gZ8sur7MAMxp3VRrtmhlh22/Jvavg4VEowCPk5za1pZlI34gUOnVOrXt/uq1//KdJEOheZmQnwO7SNEAEJmARoEtriVw2/P9Er3LhHpXOrt9Iq0g8YbVR2mQvyh8zgKsqwsWBAppzQoG/PdBQz+fz+TnKUZwbhoaI/3vw81pe8mFDSsHnqrKr7QNhpmb2mInlaGiy+F7caa4RzV87+/+RfzEJUQvKdqXO4j1l4CzgzyoiQ5PudWR4Ow1NiaeI5d7SV7VFOh03e+EqhWVEQa1b5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBZmVYaYpht65da+1Aqb5ld8L3TXthMwXq+r3SFq8b0=;
 b=Q/zSG5dsZrw/Dggheaz6iiAJeu57nrnQf4MbgzBk/oF1b1pxaUt6T0dbePrjn4LjwZxyf6dLJsmzdU3uQOt5medPdr1KtQ31eA9CrqGj7nUSmhqJZ0L89jRwghgM1ggOdM+0S6OjIrzwoLiBm77o8Byl7jrfNqsNUKFAsiHkVrOKIWg/4LqRmG8xoZAxVE2gcGglxY6/ookjA6LhuMCrTFJEZV5oHar8tuXtnF5VvYtTtWnMKyLAESMO7FgzCHYGl7BWOxpm5ngKO/RkstIHULR3CN5eKJXVGXbpFb/owKDy4i1+hbktIy6qRGhSczRhDYP20Ag6RUrXqRoDFRE6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBZmVYaYpht65da+1Aqb5ld8L3TXthMwXq+r3SFq8b0=;
 b=YcDfXNmPPqPNLMPslTb7KUWVjIF6S8OVfSGhXqVWCC0pDy1s1ZJ5NGRqm/HLoMxe0/dbe8sdwwtFaE9kdPzyQ4NIHAYzOqjGZ3/zSyH1dXDQOou8Ur9V3AtTquUmhqZGqFuGby7LGoa7EIJG0FzXurumgkeIRKXuQzFLtsUb3eSV5tP/qr0/WCwn1QXXK+0dFS/ZHEyTcM/J8lWGg90HwJaTj704YObRRRa3zlpES/Cqh5eVoGWWNOY/eDEoqB8szd46jMcZDkHr2KNNnBTABSZpIpE8etgAz5VSRfLMz8Ss6spNZmqKATtLPBhF71MwBUHCs3vLp8E38NmzXUZqeA==
Received: from DU2PR04CA0057.eurprd04.prod.outlook.com (2603:10a6:10:234::32)
 by AM8P195MB0867.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ca::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 13:45:42 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::e0) by DU2PR04CA0057.outlook.office365.com
 (2603:10a6:10:234::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Mon,
 28 Apr 2025 13:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:45:42 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 15:45:41 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <n-francis@ti.com>, <nmorrisson@phytec.com>
Subject: [PATCH 6/7] board: phytec: common: k3: Factor out mac address setup
Date: Mon, 28 Apr 2025 15:45:30 +0200
Message-ID: <20250428134531.2884940-6-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428134531.2884940-1-w.egorov@phytec.de>
References: <20250428134531.2884940-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509ED:EE_|AM8P195MB0867:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cc4a95-377c-44f3-0e15-08dd865af857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/GjrB7jo3NbgkXsPl6Br7KsqgTHHdc87xL1ZRNHhvE5/ZXvptkAyPEEEE6+a?=
 =?us-ascii?Q?iHzrpCrzcE3WfCeli0mVX4AqYPU1h7FLR4RWIDcrkLk6+CuCHYeCHdPNudVo?=
 =?us-ascii?Q?ElRpQmIcd1IF/RQ0nhX0dSI236H+7SRtB6FZXW43m14w/hJnwtSLvV0G3AwI?=
 =?us-ascii?Q?dnVz9HBIRN6wv5vXur7FSp823jMTzLCaJl5SKSnFCRg+xD3pFO6F+OLDWdmU?=
 =?us-ascii?Q?tZlYEFX6sNNBjB90HJ3iafQutkF3lk6yxrLBJjnL0Mo3J/JhCixDc4n3eh6h?=
 =?us-ascii?Q?O08O0Fti0emkjfcFG5E/dSyKsfz3hVB7TL/4XfbQWjjzZpyDtrrYeR6D/jcF?=
 =?us-ascii?Q?QNPy65OxzVK8AtTSWHWIoAJ5215BHys54fxwhs9nhovdHdkj8I57zLXYDfGH?=
 =?us-ascii?Q?kYx9R7iDPUMz9srl5SDi+sM3xMDf4Xeu/0saoH4aMYJJZhYQuLpaRYc4t18O?=
 =?us-ascii?Q?aZKcNZAPe3M8dRLncrDqsARy7Pi/uLAC5+4x/5JbMuS7AXbmPFsvp3eNSfjh?=
 =?us-ascii?Q?NcGK8SdxlTL13pMStngliRLBBZStkP9vXhA6dcz8s2r/0KrFRXJqstNeTAWx?=
 =?us-ascii?Q?R3QkgonGaVBZZjBI58s3gjD9dtEY5CrpkdRw6QNIoYKd59axI0bh7TA/y97O?=
 =?us-ascii?Q?lc3JKy2usrTZwVj22j8ymlW7vKkkMVpn2nbZQG16leW1paNxhyNmDQuoitEc?=
 =?us-ascii?Q?rYkm+WnlfrLIlrch+feucK/yiHbo0rf0x2u0QNYCaNHTa1035/z1JBBIgPuq?=
 =?us-ascii?Q?r22OX9MIiylF2SBsJTg1w6UEDedBSdbuRWxE3llTgAObxduUGrx/AcWmdafI?=
 =?us-ascii?Q?b1Fp+7FLqlAP84FDzDDv94jIaaTuxsjJ4nJUO2Pn0vZNQFbSrnEDP4oP0R1N?=
 =?us-ascii?Q?y4ECCXuBFj60AOQtgkVXXpEmX/DAIw8qZE6xUMvBYayKxInKP+oaHnC9G4sj?=
 =?us-ascii?Q?4SeuSs84nCWMCy3kbhT8mDgszzYmIZ2/zbCEF0JGOhZOEacE4GZcPcwJZpi+?=
 =?us-ascii?Q?kgyOKrrVWVVLhZ87flw7LpEw2rw/koOcJDFN8uS1t1VVe1mcFgv0T5Aqx4T2?=
 =?us-ascii?Q?4ofx4+5gxNDN83mIsTS3fSn/VuIYMkrY/d6vjBi3revC3WA030Ac1zusLUxT?=
 =?us-ascii?Q?4oG/SO2m8ybP1tTP1i4KvdEw2ZJCS7PBqX3PUXaFRjoZ2tD0Ozh2e1An2iQ6?=
 =?us-ascii?Q?DMSd62kjZ7L2Kq1y9Ypm8gAx//AiykfPyHSfBiVsarkLT4jCY5CRZhcA9kqs?=
 =?us-ascii?Q?A1CxNdA/Hd6xEKIaA73nwQGJgmTEPkjIVIX9juSMUoM69aWy4IJN4mnU3wzE?=
 =?us-ascii?Q?Y/Bf7gbpzgkbdVFnB4cazHnHSPhC0Gw3hpdOUbHlbUkMEPWJ7UWJ5y6JaAWP?=
 =?us-ascii?Q?z4F5dglCqUaWIIWvCumgQLvqrJpMBNTUjZZNlJ5+03UrpFYOVnQhpyD4F9Ey?=
 =?us-ascii?Q?r4Dlba4jMwYeVepXaO0GPuQ9wvAsW/I26b83iypXQUfaXLk8OlsNF0plLTu3?=
 =?us-ascii?Q?ykflsenBVtTVb2ZBCD4l9065OnBnxP4ZxJEv?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:45:42.7395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cc4a95-377c-44f3-0e15-08dd865af857
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0867
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
 board/phytec/common/k3/board.c | 44 ++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index bddc818743a..26d87f58096 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -175,31 +175,35 @@ static void boot_targets_setup(void)
 	env_set("boot_targets", boot_targets);
 }
 
+void setup_mac_from_eeprom(void)
+{
+	struct phytec_api3_element *block_element;
+	struct phytec_eeprom_data data;
+	int ret;
+
+	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
+	if (ret || !data.valid)
+		return;
+
+	PHYTEC_API3_FOREACH_BLOCK(block_element, &data) {
+		switch (block_element->block_type) {
+		case PHYTEC_API3_BLOCK_MAC:
+			phytec_blocks_add_mac_to_env(block_element);
+			break;
+		default:
+			debug("%s: Unknown block type %i\n", __func__,
+			      block_element->block_type);
+		}
+	}
+}
+
 #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
 int board_late_init(void)
 {
 	boot_targets_setup();
 
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
-		}
-	}
+	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS))
+		setup_mac_from_eeprom();
 
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 	configure_capsule_updates();
-- 
2.34.1

