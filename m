Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90825CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D1F9837F5;
	Thu, 14 Aug 2025 01:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="qii+iSWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB648373B; Wed, 13 Aug 2025 23:31:46 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 574B582A53
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 23:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jma@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwqK9/g3OQSnWLupWQWjZutm5rhfgj5QgwevYaLLNV+hSfCagVogt2obX2Y3aYTOlS04hCA/CTXwTaD0/MiWAeTchr6YaY6KKm9AhAVQlooKj7+iXqJQoIZdVCnJ5BWlGINM7hzDvAbKWqijynnQJQNTgSerFGA0nyf5/zVSYP20s8i/2JHRdQZY7p/SUanQF1vPiohj9ZvrtSmihQfPTJpNRau6LgUp5Nvvefqm7TgmVuA0O82ASgithk04YOgsOYAzyAM3IzK7X59H+C6UJFxOvwlWwsunJNrbEoDmAsZnAUMQ/SHWjPnXcncxX2jpD8/gUtiJISFr/bjo9uYkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gspa6XG3iMNdgO/G8/zE1iTIOieRrnEV+KHnpD/PbKQ=;
 b=M1RpLXzaUxvAi9O9wfLGFFYSX1+RTUo0n2WhBlz7A3Prmn34Py43IZA3cKbQJz0nCOq+nJv6CsDnwCS8z5NP745nf3eQkz0urVtij2JDd6r349fowsiVUiZm3gMRBuvS9QWS5GhpbKxNIIVbvWr1FceNwriDt+Mq0uv2CGNXiAjxBlpZZ6sfwmAw4J+/9NTtA6aTL4xel3O0yJR/RSOPB7Bi3NSrxZ/DflKAUSYS8D/cdkc2ozGhyAxs1Ta6B7ZwTPXNc+/rpcFNdPGCe/j0p/qLPbtSjl9slGqdQQp5c8ZygTYq1rXckqwCNz5YrqC5chGXdar7j/1qD/eTDfFzWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=phytec.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gspa6XG3iMNdgO/G8/zE1iTIOieRrnEV+KHnpD/PbKQ=;
 b=qii+iSWm2X4uQhGWYT3X6R9NCF7/BVyS2er4hUWNZFoIBQlpG2Yk3apHbAoAh3rXmweRNLCazfVlIFSBgLyFMAtWd0Ow1nd/QuxxWEG2ke/et+47yoZxaunz1D+k71GK5jOD1IkRnXkZAFv7KudkkMiqbAsjyYZdAD8h+jMyag8Yam10u9oUJSgRVf/dFtkmIVeHmf8DMFteJvbor5UzM6HRazRGO+drJLwK/hRKPKK1SwgD+sEuW79I3Pv0CFMkskQOJdnxUxJLWdYRIIbUZN+ee2Ef2KyzbTbclg/llL/rhBTJ/EX1apBIyzh2IBzzNqJtXW7kbEBCr1zKCtPt+w==
Received: from DUZPR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::18) by AS1P195MB1517.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 21:31:40 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::ab) by DUZPR01CA0015.outlook.office365.com
 (2603:10a6:10:3c3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 21:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=phytec.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.com discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 21:31:39 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 23:31:39 +0200
Received: from wl-jma.com (172.25.39.17) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 13 Aug
 2025 23:31:36 +0200
From: John Ma <jma@phytec.com>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <d.schultz@phytec.de>,
 <michal.simek@amd.com>, <ilias.apalodimas@linaro.org>, <jma@phytec.com>,
 <j-humphreys@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH] board: phytec: common: k3: Making setup_mac_from_eeprom
 optional
Date: Wed, 13 Aug 2025 14:31:16 -0700
Message-ID: <20250813213116.3076551-1-jma@phytec.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|AS1P195MB1517:EE_
X-MS-Office365-Filtering-Correlation-Id: f0bee8e0-39a0-46dc-ebe2-08dddab0ca37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RGjOHB6gONIEkPyazGLYDiNLhJTvlmzh/PcL10yIIoFmiD//oXss9MfuVktW?=
 =?us-ascii?Q?NoWLb1IRe4Id+c8yL49Aq0TSvHlQC4Tr+55auxgQlaLrCOSGb1eFcAm7xqOD?=
 =?us-ascii?Q?P0TxaAe/eQXm7zxScrGp0GVirTJNe9BhQblcTML8tcTLOBIEhcegLXA4vic7?=
 =?us-ascii?Q?jcj9uV6cCypOmtp0xOxHcixxHn2zIQmbwz+Bzaxfx/SSxW9SjZY1eqCzB6rP?=
 =?us-ascii?Q?BbSgLFOSFewho/GvCXafyiugmt/fnmwFtUeDnAVb+R9V7PJylzL39AEinjpl?=
 =?us-ascii?Q?thM0BXyg0VqCWSpN8smJJsvxo0sCOPZjEvf2wYTpB1pgWYYHL0QQqDqFING2?=
 =?us-ascii?Q?T+8WFTliq6A0WiOFCT9oIfS5bVJ5uj8NqyChOmPY/VLVDoPGDJn+QFI62SGF?=
 =?us-ascii?Q?30tSDEJlDjoLHjdBaSK+fVAR1abEKBa1000HGB1UdtZ4FjwpyrltT/4baVUF?=
 =?us-ascii?Q?9BaVX4Sm/rzT+0fHGRy5eFmysGlHx4xNPAgMNoUPq7AXyVPWWvioybvogHQg?=
 =?us-ascii?Q?tsIZm0OmVcrqotVuhMlOzKZbk//aUamv3bo6BpAK2j6MZz+/LtEfFFXNr3EZ?=
 =?us-ascii?Q?/uIHaGGrDWKgDHtl3wcVD3KDezeunY8xPobxVhoJiNMXTpopF0v8eqO/3sSV?=
 =?us-ascii?Q?iihGtkvWVezm+aSwBQS8J0Wrx/SaoGPUkXPj6lGpvH/2tsxD96A6T28bDxmP?=
 =?us-ascii?Q?ylGUNCm4INUjHBVWT3cZC4Kid+mkBuq5yix1C3j6FVfWh/QZi25nYhd8mNH+?=
 =?us-ascii?Q?xOXBNGUD6o3ndXpKcw0jNdiW/OcsmwwZ5XywmBLBCUgKrgFF5CUV+0d0atLf?=
 =?us-ascii?Q?9owb5Q+ckrnMbw3/Ai+lfr10+4E1xcix3LWZWGlQpKl2327mIzpHvgb2I1t9?=
 =?us-ascii?Q?JoMWkgbIef4n7CHKDgbtvjrW5IovmnQhs+CMGYLgCBrUTQJolW578bdvuU2V?=
 =?us-ascii?Q?fTwEQSvRinJK/L6RngYB2Jmt4iiUNk5+aKaXrwR6vZoq6bXcBNYZVM2siBJX?=
 =?us-ascii?Q?3jLF9+8N+O8t9IiEz29k/A12eU2IiCW0MdH/xyk38hU/kK2mDXmW7nah+S/U?=
 =?us-ascii?Q?mjtmcip4Bl/0GrDmJo/hfbh0DzH1Bd4Rk5NI5kPBYGeea9toDDi2BSdIlP92?=
 =?us-ascii?Q?6aQQhLM4/N4EA/FskzLxxeoZnzZa0W3a3DvfEsj3Fhv59f8NoBV8hHcux63F?=
 =?us-ascii?Q?SUiirky4e/zE4U7PPjDvBiJdNAugPmNlgsAdHjWxdUwD7VF4TIPOfkC7hH8E?=
 =?us-ascii?Q?C5JzmpHH7D2CknEOqenY5iLh418ayhqOufjDszU0F7L6iH2dZqu3B6uAdRRa?=
 =?us-ascii?Q?RMmxEPesd5ly/NKvhLUZ3f6mXxl9BlI80pb177wR2q5bkGarOQLhtqP87M47?=
 =?us-ascii?Q?zFuRv8bgK83egjN5lxGb8ATb+M1ySgsmUj+uJDuz8+pXuB2sKFBUwiRZXfu2?=
 =?us-ascii?Q?rm0Mr4P81EZz/ZTBOk9OVF/U1eXmXHbnHvQJgO/V8DlSfTiEsjsLoA+ZSywY?=
 =?us-ascii?Q?lXdG8jLruHXYzYTAIlqyKWxipAXea8baWm1t?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:31:39.7528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bee8e0-39a0-46dc-ebe2-08dddab0ca37
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P195MB1517
X-Mailman-Approved-At: Thu, 14 Aug 2025 01:22:59 +0200
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

Making the setup_mac_from_eeprom optional for boards without
CONFIG_PHYTEC_SOM_DETECTION_BLOCKS.

Signed-off-by: John Ma <jma@phytec.com>
---
 board/phytec/common/k3/board.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
index 7f34d71d530..647f93a1d7a 100644
--- a/board/phytec/common/k3/board.c
+++ b/board/phytec/common/k3/board.c
@@ -176,6 +176,7 @@ static void boot_targets_setup(void)
 	env_set("boot_targets", boot_targets);
 }
 
+#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)
 static void setup_mac_from_eeprom(void)
 {
 	struct phytec_api3_element *block_element;
@@ -197,13 +198,15 @@ static void setup_mac_from_eeprom(void)
 		}
 	}
 }
+#endif
 
 int board_late_init(void)
 {
 	boot_targets_setup();
 
-	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS))
-		setup_mac_from_eeprom();
+#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)
+	setup_mac_from_eeprom();
+#endif
 
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 	configure_capsule_updates();
-- 
2.25.1

