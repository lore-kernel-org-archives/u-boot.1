Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43150CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 11:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BBFF828A2;
	Thu,  2 Oct 2025 13:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hC4B1JtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49987831D3; Thu,  2 Oct 2025 13:21:05 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A8181D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 13:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaE3x/OBxrn2C8NEFlNDqMtcJYCMDpQboteOhfJ23OCG0ZHcZiMpMNLmJ6I6nhAIhNZoaa+1mfzNYjMcgTjvwbILg/OO1fk43HfpaE6+GwfrpV0vWkEvVIOvM0ww7LJHHj2RXLOGsEBaKEj27daj2w0pbiycnqAP90+m1F+ueNNjTniwhzoKdwgGKfNlltGLNDCqIK9xBERJNX8sOvMQRAvTDxZZpuKY4jTxM8P/cu0Mk7KpQXKVEbUFhO+myKlNgEDhoWjiX5rtHqM8J5ezHKGqW++LCutNrpFoAkYFwgst64cIsvBm7sl4PCVA/cRkqv/r0qAsYg4BfugJ/T0lzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXf7P2uDg+bwLnJaOJeDz7rciB+ah6ooekWLQRhdWlQ=;
 b=iXpdrP4o39ZpKjSe91JhexlouuxcXYnMq8SeX3Voy4BC1bho3/297fB/4xYLAjWL19jMWjyLPbtp4s4qx5HLG3/zlVL4S846tIjJTc+r8FtvN8FkryZgtt2ybeNHhDkEMJrj9ZVr5fzxoMAsGDZnWzpzOSF2Lc6qvnamQc9sd81vC7j4YqYfAx2zPl46SUvEKWi5nrbBHTutZawz8LwxQkalywXO2YaeuJEPgyrQD12ZAt4++ho4o1WYqUoPyquVJSKfoove5BZ5BFNiq2taoM+5tR45gu2zVPp/Oi730s+bygGOXX7JJDqZ+kb64S7O9SPLfueH7c+30O3vesWkFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXf7P2uDg+bwLnJaOJeDz7rciB+ah6ooekWLQRhdWlQ=;
 b=hC4B1JtEAtHfjxbm6pmFGOTsWn/oDmdw3D+asoraCaZWqhtHlVWHbAiMK5JEwRi9Vn8CtVKowZRvQ0KJaKMbukRGbK9f+3he8Z8MYodnF6st/AfY1Q+hmC82bpGMtCV89Qa+2Q6nvvZgYkS74MHdijWHK0wFv4H6Sk4ZQDAEtQKaK2W13b/iKpMa543cT1qtQQbQ3TuXSWUKu96qDlnjH6FftFDMdPPznu+4c+QUEpWz0t+03WTfdwso6EdR+yOXYQ4tsj5V3yj5nZ1CEKFBSH0+ILMogQfIt5H1+WGHGAN40nnwig616cW9CDiLUhCbkK2eIXH2VsqWhl1rE0Nn7A==
Received: from DUZPR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::27) by DB8P195MB0598.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:15b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 11:20:56 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::6f) by DUZPR01CA0092.outlook.office365.com
 (2603:10a6:10:4bb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Thu,
 2 Oct 2025 11:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 11:20:56 +0000
Received: from lws-schwan.phytec.de (172.25.32.51) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Oct
 2025 13:20:55 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Thu, 2 Oct 2025 13:20:37 +0200
Subject: [PATCH] board: phytec: phycore_imx8mp: Add rauc to bootmeths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251002-wip-config-imx8m-bootmeth-rauc-v1-1-e54d43a6fd70@phytec.de>
X-B4-Tracking: v=1; b=H4sIAARg3mgC/x3NOQ6AIBBA0auYqZ0EiPtVjIXioFMABtwS490ll
 q/5/4FIgSlClz0Q6OTI3iXIPAO9jm4h5DkZlFClFELhxRtq7wwvyPZuLE7e75b2FcN4aKxVZea
 6NY0sSkiRLZDh+x/0w/t+hSLGV3AAAAA=
X-Change-ID: 20251002-wip-config-imx8m-bootmeth-rauc-726fd79f8145
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, "Yannic
 Moog" <y.moog@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|DB8P195MB0598:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d5f3a7-39ee-4c1d-e14b-08de01a5c1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEp2VDJFWXBWWFdib2hHNVpTSmRJMmJnOGR2U2lQYURUNklKODNmSElOZ1FT?=
 =?utf-8?B?OGNNcDVzSmJpNmpLVW9lZmVPc1NOUWVnTXdsWnJMSWRkMW1xUWpLc1l0alRT?=
 =?utf-8?B?WXBRa0ROUC9SRFRtSEkreGFHM1NoQmxiM0xOeVFHRmNiYlcwRng3VDcrU2lh?=
 =?utf-8?B?N29wWmlieGRsN21KWkI3dkkzSmFIbXBkdzE4b3AxK3RKNzdmb3ZoK0V5QmVV?=
 =?utf-8?B?bkQ5YVFFcFJnMHV3OHNWR0V6ZDlFTVA0d2FNZHBUT25HMzJpcS9NNmViZkty?=
 =?utf-8?B?azZMNDU4elFWZEwxalUwUmxoK0cwZWpqdEJjTC9NOWkvLzczR3FTWGYwaUFX?=
 =?utf-8?B?ZWQzU2hSZm9aY3R1QisvdnFCcjFMMFJhNVZWNEpBZDZaQlNCOVM2cktRZmt2?=
 =?utf-8?B?OFloT0JXT1VoYVRjK1dSV3JycWhkRm8rYnMxT0t5S2VWNGc1ZGtxUW5LVUxI?=
 =?utf-8?B?a2JlZzcxRjFyUThLLzQyTWlPVXdWcWhESXVyYUtib0hQbUREcEp3bmhhbTh0?=
 =?utf-8?B?aDB2TUw0QW8zYTc5V25aam9hcmNTaTlHeWdsZnEvMjVSUUQwQnlBeVlLYUk1?=
 =?utf-8?B?VzlPNUNVckZLcUpkbUNhdkY1YXBodUlYU0JWYS9OTzhvbWcwd28xcmI3M0JJ?=
 =?utf-8?B?SWdPcXlFZnBlLzdSUE4xTEhDYW1hcjdJVnpJdU03cE9lUS9xR2JPQUlFcVls?=
 =?utf-8?B?WDdhdVhsaFRPamsva0NRYVFjS3pQVDNYZmJJVG00N2MzbjN3NmViSzZIcm5C?=
 =?utf-8?B?NHA4SDJhRFlZWjZKZExXMVdPRDVwMGxmcnNIREw3VDBKQjRmVzBqWGtrVkds?=
 =?utf-8?B?WnFtcXlkUnRqNDl4b0RuKzhTekF0dEpTUjRGQlRQb2hYeS9PT3E1WVV5WWVP?=
 =?utf-8?B?SlRQZkZCVHhPVUtXNTh4Y3F6OE11YnNIZHpWMTBOeFlSZWVrSllaQVlTcVJY?=
 =?utf-8?B?UGlJOW9iU3hPaS9ScFhWdm85K01KQUlVYTRya0ZnT0xweE0rRFRWZWlrbjJu?=
 =?utf-8?B?NDdrZ0NOZFdsTkFISDNtekE5cEJjWTNpemNoVzlkS3huejYyWURuYWlkUXBo?=
 =?utf-8?B?emV2aTNVMlNsdWtIT1dkTTlJYVUyR1Z2QVVObXN1dWFFbHBpaUxKb3F2cmhj?=
 =?utf-8?B?bWNMaDR1UWNEdFdscmJEU0JNK244UzA1Q010M0o5WnJGUERXME5hdy9tdE1y?=
 =?utf-8?B?bkNUbTl2ZTcyVGhNQWxtV013VFBzYjJidm9ZR3JmeXlUT3haaDA5bmdwQXR6?=
 =?utf-8?B?ZUx6N1lIOGJwbGRsWXMvK0JoRDVLa0M4aGh3aTBsSnU3azZndmplNCtxUTlF?=
 =?utf-8?B?MnUrNkJ0a2JCbVI4eHJnVGJBanVwT1Rjc01XZ2NBVFlPUFdnTUFGbko5ZE5V?=
 =?utf-8?B?eTdjWWc2WnlzdFo1ZkRaMUUrYlNydWJHY2FwTTFOYmRkRFVIcFZVd3lBckg4?=
 =?utf-8?B?SXIwbndjNzJtNHYzVHduNTFaNzl2WDk0TzJhL3FQMkVJLzJNK2hpcTQ2a2Zq?=
 =?utf-8?B?KzMvR295RS9JWGNvUDFBdHJlU1JqTGVRWEhEMFlxQlRZYWFlaW1UanNHMTZQ?=
 =?utf-8?B?eGpWbDNuM3VGY3hpYURac2gwUXhxKzF4MmpJeG91dHcrNEtxcTdkT1AxVjVF?=
 =?utf-8?B?N0JwSzVmTVpnZmd1TnpQd3pvbG9hQSt5aVFybUdlK2drUWtzYk0yU0FNSjAw?=
 =?utf-8?B?TjAxNktjMGx3eDZkWVVsNU01bGdWZnA3MW8xQ2FpWk1rNFUvMUg1K0c1bW95?=
 =?utf-8?B?eXpQL0dhR1RZdUM4Z2tCc0h1Q1BSZHA2cWFYK010NGRZQXlVT1FtODNVNmVM?=
 =?utf-8?B?UWtXNlVFbnRoMDZZVFZ6ZCtCNzZyRVRGVTkxKzRlK24zTDNTNklldm5rVXJh?=
 =?utf-8?B?MHVGdnRMMlJuSHBVd3NscXRTVzFSYTl0Y3FCMElubjBCWWVQeVlrZ1dMY1pw?=
 =?utf-8?B?SE5tbXpDbW9udC9xYXRrdzdCaXo5V2Vpb0FNbFgzd3hMNTRxNTVGNFpITzNy?=
 =?utf-8?B?Mmh3aHlNb0tuUVppM3diNS8yQ3BsTk1RT253VFAremRhZ01LZXJDK3ZvdmRT?=
 =?utf-8?B?N1J3N1hBSVkwTE1Xejk2SFZialJud2piaGtLbENJTzNjaFYwNC9QZUZSbG1j?=
 =?utf-8?Q?WNZs=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 11:20:56.3660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d5f3a7-39ee-4c1d-e14b-08de01a5c1b5
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0598
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

Add rauc to bootmeths variable if BOOTMETH_RAUC is enabled. This is
setting a proper default for RAUC enabled systems.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 9a129a0a4bfc48f1fa70ea6e2f895acac3ca05d2..70044997adb8ad1e4a7c24faa52f9d78becb229e 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -3,7 +3,11 @@ bootcmd=
 		fastboot 0;
 	fi;
 	bootflow scan -lb;
+#ifdef CONFIG_BOOTMETH_RAUC
+bootmeths=rauc script efi
+#else
 bootmeths=script efi
+#endif
 boot_targets=mmc2 mmc1 usb ethernet
 bootenv_addr_r=0x49100000
 boot_script_dhcp=boot.scr.uimg

---
base-commit: 5b93c3ec7f9d66dc40d062a47a4a880f7d346b7a
change-id: 20251002-wip-config-imx8m-bootmeth-rauc-726fd79f8145

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

