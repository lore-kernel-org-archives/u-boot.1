Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F885CCF9EE
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C578331F;
	Fri, 31 Oct 2025 08:46:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="boac7VTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7783683642; Fri, 31 Oct 2025 08:46:45 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60FA8800B1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpgI6jeZ44OHCM2PMmz2AHfT7QqHDUD38+4CXfqnTq5Emk3RmdGdIBZoMwP/XZOw5rsv7gldeKOsIfRivouXHU2SaTqoLqelo7NGU5i5bglTw+QbnHGTH9+iizpwWoI1te2twrCWUysbxU1NZe7KenXnSknaYcXAxaXYBCGhiagZ2JPMpmw8jXIbvGXZYdiESaXvzpnNLZjh/OgdOYsaP0o5glxK3tzloqAg15lxX4X3ORV3k4K6Z0blsv09y342hQOMHGtY/TUnDEUwEVsLu9LA6LDQV4OOl7zq4DzG91JnE6T3UySBE82VOTiInxcNIU5Kiisigb2js2LWHfzSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+bXcTUqJ9cRFqRq0tor/bgMxjolJHi9iGWTZqEv/bQ=;
 b=RHs6jHJoPAO46pbaK+lRYxcmU8CRT6Z15WIDNTaO/GNKN+3ie1V234rr43VSmresJ/M54Jns4+Ty8O24r/s0IX/uVx01wxGBBTUm4WWxPwq0aMnqR2V3V4uo5LITxU48V4OzCf0ygySCEAuMsz2j360yG0Ms3Qj8WydgN2fwFDeMCGaQRKKsvajL5w7RLsETdK4rFarU8an0Mxz4tuZHQynW0pbTeBykKVwS3pzcWPv4FeFEMjurSrvOGk8Gg1TnpfhIkC5O0AIW1gilBqeog0n4Szv6ljHGWpqTK2qDY8nK9mIicl4jpTfr2bp9K7pD3fqP+SED+Kyb488uS0NY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=andestech.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+bXcTUqJ9cRFqRq0tor/bgMxjolJHi9iGWTZqEv/bQ=;
 b=boac7VTlqjjtdHpmgBnvPkDQbNGg3xc5s3ToFEswIJr/PH2Kpu/xtamRieMLrecinwTxsFIieqgROaNT/GLwuhQL7jrE0SZbEm+gXGguNryz64RdEsVLRXy6StTVZS6D5lxs3Dl9vyDuDID/6yBPp4luuIdOEc1rXyRWl0YNIWQ=
Received: from BYAPR06CA0035.namprd06.prod.outlook.com (2603:10b6:a03:d4::48)
 by SJ5PPF1DE1C92F7.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::792) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 07:46:40 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::41) by BYAPR06CA0035.outlook.office365.com
 (2603:10b6:a03:d4::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:46:39 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:46:29 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:46:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 02:46:29 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V7kR813549201;
 Fri, 31 Oct 2025 02:46:28 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Fri, 31 Oct 2025 13:16:26 +0530
Subject: [PATCH] spl: remove redundant prints in boot_from_devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251031-spl_loader_fix-v1-1-3fdc65b5af1b@ti.com>
X-B4-Tracking: v=1; b=H4sIAFFpBGkC/x2MQQqAMAzAviI9O7AbMvQrIjK104Js0oEI4t8tH
 hNIHigkTAX66gGhiwvnpIB1Bcse0kaGV2WwjW2xcWjKeUxHDivJFPk2s5s9YReitw40OoVU/8N
 hfN8PipysBmAAAAA=
X-Change-ID: 20251031-spl_loader_fix-b3b7e19af723
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Leo Yu-Chi
 Liang" <ycliang@andestech.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761896787; l=2109;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=Wv6N7G8l2vlG/97gT/P7r3DI8NUGGjRDtXj/RyvLL54=;
 b=HjWk74IAHp/Snvyz+2XpHPVsMAkIpBH10K6VMmPX/+q0RENRMfB6bVJYkylfGMbbLH9ISkymR
 vaPnFDRHQ49D5QshVupCPy7TxTSvBgHAcdcyUls0gOvfRlhXav8fZJv
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|SJ5PPF1DE1C92F7:EE_
X-MS-Office365-Filtering-Correlation-Id: d7931f85-e6e7-4deb-08c8-08de1851a047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|34020700016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDkvay9obXRCaGhvaTZEcTVacENiTVVNQ0xKTmFsR05ySy9YU2R2Vy80Z0VR?=
 =?utf-8?B?clVTKzFMd0NWdDJmalA4TkNMT1Z3cUFYLzc4S25ja0dpUEp6MUtTdFh3NHlT?=
 =?utf-8?B?TGVpMk1pUTFZbTNPMnlEZTNCdko4dE9jdjBIakNjdzRvbSt6Nkljc0ZBNWxQ?=
 =?utf-8?B?U0xvaUFzZS9OMGFTZEo4TWZxVlMzTXpNbk03Z0JUckFyTFdmenJsMWZLZkV3?=
 =?utf-8?B?ZXlwV3ZCbFZxelpqc2l0VlNkV2c1Wm9RMzVwTEdMZzlUT1AvSW4xdlRzQ2hD?=
 =?utf-8?B?T0VnTGw5MWhCVG9YclBWZHVmcXpld0FmQm5ZcDU0WW9hVWI5ZEVTaGp0UGFK?=
 =?utf-8?B?K3BRMy9rQ1VVM1ZZdXJOdk4wVDFjWnAxRXRJK2lLR1ROWmxKREJFMGdzNjhm?=
 =?utf-8?B?YVkwaXRCUFZ0SmhpTjNHR2JON0dnSUhXMlgrK0N2Y1llY04zVUJpeitvV1Ew?=
 =?utf-8?B?ZTluU1ZEaW15Q1oyVThYQktFbW9aWm50ZCtocktCOE5NcTNUeVRIdnhueTFs?=
 =?utf-8?B?ZlhCUXVMMnZYRElyZ1AxckhzMHRaQVVOaG5INHRsQkUwazJSNGVWNjMwUkNm?=
 =?utf-8?B?SzJVV1ZoQ3ozYkhJd3ZMQjlqMy9wTmZYTUY2RmtKUG45Vk05dnlBU0pEODh4?=
 =?utf-8?B?MFcvcTY2aGlhWXVLaUlqK2xSQlJVM2VBN1ZIenBIaW9mOXg5alhUenBJTFFx?=
 =?utf-8?B?RytrQmZ2NGczTkl1ckU1cEE4NDcwQ1dQcmd5emFvUHIrR3Jrdm9od1hKa1o0?=
 =?utf-8?B?UFd4SEtPakEzc3FxelRSbVgyRk02TWpFemVtaWNFMzlhUU9aSzUrQTAzOWJU?=
 =?utf-8?B?dTNRbmQ1NjdaWkd1bzVtYmtVaE1wS2tFQWhMT3dMZTVBSTR2bFpWdCtRbzVZ?=
 =?utf-8?B?NzVuSmE3cTBCRFZoaEE2OEVKZVBpSDVORmVGSFBYVjRLbmw3QnQwTXQvckd3?=
 =?utf-8?B?YkJKS2pxSU9sNHEwQUZzRXNHcERaVE9VbWNlM3JmRnY4LzIwY3VCczBoZml5?=
 =?utf-8?B?bjVZR01kWFUyOHY0QTAzaFNwRGJnOTYwV0pKWjg4bTdhcE1veWxMTUVQWVNN?=
 =?utf-8?B?dG9KbVRsamh2YkJOQUlGTTVpbi9PTTNadFdHMU1oTmRWRlVUK3dDY3N4a2dS?=
 =?utf-8?B?Q0d5Y2x6M0wzclJGU3lyTENUMUIzUDZ6ZHRHbGU2T2VLaDdxY3NOQXpzOFJ5?=
 =?utf-8?B?b1IvSnh3YW1CbEhBbDhYemYrQ0ZjYTZxc2VUaUhlNGtJMTdOMVJ1SGh3MVpL?=
 =?utf-8?B?MDMzK3pWSUJEVENwMVhOMjc4SkUvbUR5QzVpUmxlK2JuWDJCeHF4RUQrZVJt?=
 =?utf-8?B?T0xrcjVOc3pDTThOZmlxdzRaQWJhUStWai9NRUhNcUhWSmpzdnF6QTkrSEMx?=
 =?utf-8?B?MFZxdGp3MDN1bmFEbkFBdDczeFpkbFdXK2FNU3krVHdGY1FNTmRwTDJsRkJ1?=
 =?utf-8?B?VUtsSVQ2WFFGMUpyU1h5UE1YTGttUmRRaC9Ed0NkaU5mZzY5N2tldW1zQVU4?=
 =?utf-8?B?TzM0WWZ4VzVKZjJoK3pmaElzVVIrdjdWYmpuYVE0Mk9NWWY2cElOMUt3NEFB?=
 =?utf-8?B?NHFvVHNwRFc4RmREMnh5Z2xGTTRGRytxTUtKdUNqcDZIYU5FQjdNcDVIRjRS?=
 =?utf-8?B?aHBkS1lpSHo1LzBMckk1UlRDWnNRbEthazlNZy9JNnlrbGY5RlZtWjk3bzV1?=
 =?utf-8?B?NEhTemV4UU5JWWxmeFRTdmVoOHJCcTFBMzI4SW9nNDhyU1YzTFV3SXBCeU1q?=
 =?utf-8?B?NW05RlBhM1FsQTFERi9ObXFSQWdZN25kZkVQa0ZkcndISG1JWEdQd3VDNDAr?=
 =?utf-8?B?em5rbUwxMG5NczR1aGlZd0haa2l0RjFDVmJ0NU1LV0ttSGlwVkxEMkNxTUow?=
 =?utf-8?B?Y28wMTlaMkh0TU1xaGZMM3pYVmQ2aXlrUUkvSUNtTnFhc2c1WFFKMUZlR2do?=
 =?utf-8?B?bjMxOHhzbDNWbUVpRmNPWmpwSERDaFlRSDIrNVNrR3RscDRtOUxDNXJGSnVG?=
 =?utf-8?B?SzRqcjdxbDNQYzRsWllwSmc5b2syYWFncmxEblVxSVduazVCaGlPQXFZdEJI?=
 =?utf-8?B?NDRxK0VkRUJyZEhFVit4Y2xWZEE3dEZLMFR0SXl3blcxaFkwVVJnWWlRQUhR?=
 =?utf-8?Q?lelk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(34020700016);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:46:39.2571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7931f85-e6e7-4deb-08c8-08de1851a047
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1DE1C92F7
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

The null check for loader in boot_from_devices was moved earlier in the
code path by the commit ae409a84e7bff ("spl: NULL check variable before
dereference"), therefore the subsequent null checks for loader are not
necessary.

This patch removes those checks and refactors the prints to be more
useful in case of errors.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 64313cb8dfe1a401078882564b69890480c9894d..39ba5a9d75d3f407d037f19458f5dad77e50eaf0 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -642,26 +642,26 @@ static int boot_from_devices(struct spl_image_info *spl_image,
 			if (loader && bootdev != loader->boot_device)
 				continue;
 			if (!CONFIG_IS_ENABLED(SILENT_CONSOLE)) {
-				if (loader)
-					printf("Trying to boot from %s\n",
-					       spl_loader_name(loader));
-				else if (CONFIG_IS_ENABLED(SHOW_ERRORS)) {
-					printf(PHASE_PROMPT
-					       "Unsupported Boot Device %d\n",
-					       bootdev);
-				} else {
-					puts(PHASE_PROMPT
-					     "Unsupported Boot Device!\n");
-				}
+				printf("Trying to boot from %s\n",
+				       spl_loader_name(loader));
 			}
-			if (loader) {
-				ret = spl_load_image(spl_image, loader);
-				if (!ret) {
-					spl_image->boot_device = bootdev;
-					return 0;
-				}
-				printf("Error: %d\n", ret);
+
+			ret = spl_load_image(spl_image, loader);
+			if (!ret) {
+				spl_image->boot_device = bootdev;
+				return 0;
 			}
+			printf("Error: %d\n", ret);
+		}
+
+		if (!CONFIG_IS_ENABLED(SILENT_CONSOLE)) {
+			if (CONFIG_IS_ENABLED(SHOW_ERRORS))
+				printf(PHASE_PROMPT
+				       "Unsupported Boot Device %d\n",
+				       bootdev);
+			else
+				printf(PHASE_PROMPT
+				       "Unsupported Boot Device!\n");
 		}
 	}
 

---
base-commit: 08bf42e1faa4411cd347c2e370da790a0116e318
change-id: 20251031-spl_loader_fix-b3b7e19af723

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

