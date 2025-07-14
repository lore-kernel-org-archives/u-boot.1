Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF2FC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9688183061;
	Mon, 14 Jul 2025 15:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="n1VV21Zd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FCD6830EE; Mon, 14 Jul 2025 15:31:17 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F61783095
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpRW96/UjmZ3CMAIMKO8wIAmaTLw0HolzpkBtWtFbrI2Lm/9ihiAkAC4VWh4ILUY8e48oy5+6cvrNPaSzrJPRHq0ynN8DUeVgL9aX9J7B1IbKJr2FWWheF9WgriRmZz+K1vLe4XEmK66S0j0OPtk2Gljsb4rqnjGY0P5FI4gD6hWBbIq1Re4BTZbR6Qkwxv4VCNTeNrNtJq8kumPeo4JSbFgR/bxupWieNKLePNBsDIlig+yWJuZ6b/UJZ+Fy2GTAV8VRLDixZAHNWH54JX1XmjLWbuRDX/He3OBtaPc2Yslv0iBKcD5s+be5G2PVohK3Flt6W5FhcGCBnIq6ASn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5oY5LiI9UVCkJjK9edcoADhbiUPWh3J8KJQ3O8WwYg=;
 b=eICFKacy0jLXOxs+dkpgihjLb3RyipAHKRDqbW5TvLejTlJVU7MVuLtTKxWI48oPljq0wvgUrSJqngPZCPlJBJlpqKpeadNA9jgFUI6Zx8k8BA7NgYwghEl5nA3glQVNpTjXE35mjV5fz6LRlzzi/ufoWHMgXE0SLSWXgXLaCEjUYiPHsjREMK/qiQcWKrrLEULECRXECWG+ebS80BML+NnH/sZHaDCFaXgrzjr4CPLuD29jaFh5xSGf0ODqPd8wp757HaWP/BS0nDG80ZjDIGCMCTclYQEIlfAHNyQSnE1L2C3AKS+MI7OiBtvQVWoYEgn08Jmr1A0Q6DPalxPojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5oY5LiI9UVCkJjK9edcoADhbiUPWh3J8KJQ3O8WwYg=;
 b=n1VV21ZdblNQZY+wk5dnJ+bnWFBq9oNlifoVFMmpB8wMChsIY0i2DkOIcTA0ZsGzEtUtiXHJ72xk+XZqntGZJeJh+fXEi4/OKCnl0L3Cwm7zXl2GDGv7WV6nricY7zxoIs6S2KKNNXZlJijMbPZ0dMSz3RAo2+hj/z7hveZh+tGeKsouvWaxOmMLRjJ0fJ7HyXNJE0/FXGeey2px2dF07O6XcvUKLCvBOjRA9IbOl2fuWKqUl0yhpgCdcxv+vel2fh5VGbK15EAmbVE5tn5k1l7UAn4IAW7kfDh1AuiqYawEwKpAdOPAEYrZ2IjDi4lP47HdeIFgFRczCx9QWZIP6Q==
Received: from PR1P264CA0106.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::13)
 by VI1P195MB0704.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:15c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.27; Mon, 14 Jul
 2025 13:31:10 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:102:2cf:cafe::1d) by PR1P264CA0106.outlook.office365.com
 (2603:10a6:102:2cf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Mon,
 14 Jul 2025 13:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 13:31:10 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 15:31:09 +0200
Received: from [127.0.1.1] (172.25.39.83) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 15:31:08 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Mon, 14 Jul 2025 15:30:10 +0200
Subject: [PATCH 3/3] bootstd: rauc: Only scan all partitions instead of
 boot files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250714-wip-bootmeth-rauc-fixes-v1-3-69d2b80e7606@phytec.de>
References: <20250714-wip-bootmeth-rauc-fixes-v1-0-69d2b80e7606@phytec.de>
In-Reply-To: <20250714-wip-bootmeth-rauc-fixes-v1-0-69d2b80e7606@phytec.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Wadim
 Egorov" <w.egorov@phytec.de>
CC: Leonard Anderweit <l.anderweit@phytec.de>, <u-boot@lists.denx.de>, "Martin
 Schwan" <m.schwan@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.39.83]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|VI1P195MB0704:EE_
X-MS-Office365-Filtering-Correlation-Id: 95170a08-2c41-4d6e-43bc-08ddc2dab1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkgwcTlqU2hMcXh5azlYM0N6dHdGOTNtYlNPMjRmblRwUDJhZDFXU0lLaVNU?=
 =?utf-8?B?YmNyWVBwSWFuUkZFS0tHU2tiWXZUMTM1L29zeFNoNS8vNEQrTGQwVjRmWC93?=
 =?utf-8?B?S0ZwRnkwZkVWMTNuWitqVmNRd3dORmdzZFA0b1FPU050Z0ZiK2R3cS9LRVo3?=
 =?utf-8?B?a1B3N1N4ei9vVDl4Y3IvRm1QaGVTSDREUWhrVjJOWVovM2xOSXBHd01pdHhD?=
 =?utf-8?B?UEN2OS9RWm53b0Irc1dSc0hjZXhPYnN0WDUrS3hYbkR0a0sxSGhKbDd1UzEr?=
 =?utf-8?B?enpTV1BrcGkwOTU0aEY5b3prcFlSdDFhcWdKKzJ4dW5QYklPWjdIV1BrdGEr?=
 =?utf-8?B?dUJKZEpsWHN6YytCQnBSSTdvMnRDd25nSHhmT3d0cFJ3QlRZZDVTYXZpSlhM?=
 =?utf-8?B?SUMzaG92SmJ2aHBIT1hYbHNTcWw1R3B6clRTVlk2dEJHQUVGdXBWd3Exb1FH?=
 =?utf-8?B?L0JjcnZQMnErNjdEZDhQeG05UXNoaEFtRWtxazdDNWtMSXFvRVJpekxPZUhk?=
 =?utf-8?B?QmxTVGlEVC93RG9sWENlcVNHZk4vZEpDU3o0ejVwN2N0bTloSVQ1L1E0VUtT?=
 =?utf-8?B?NnlRZlQrSHQzSm0zNlA0RHpaK0JNQXh0dGl3WUJzdjZxa0FJci9lS2creld5?=
 =?utf-8?B?YXdvSlY4Vk54QldxTVc5Zk0zZ0lJa2czOWI4UUlXdGZRSDBYTzVUL2JRZUpG?=
 =?utf-8?B?NWhmMmlZVnF0MDQxeTFrdDBpYXhNL3UzRk5qSGx4MFo5RDVRSWZTWkpPR2lH?=
 =?utf-8?B?aDdyaFQ1T09iUmZhZUkzVjFrNWthU0RnZGZESERzVDhZYnY1NmhmVWlEYndR?=
 =?utf-8?B?aTVFUk85azRCZ3o5S2YrODRDSW5lYlZxcVVqbTdHME8wUWRsMmhiRmN3amcw?=
 =?utf-8?B?anJpWmwxbE84Wm5BcHgwSDJRQ2tpM2RIZnYwNUFqRmYxekNMZUh2Mk9yNHpr?=
 =?utf-8?B?cDA3bGJKN0ZFSE9yTFM3SVhKYTQ4c2w4cmVWVUFzMWlmcG9jZStBRGE3ZlBT?=
 =?utf-8?B?SmFRNmxoVmFRcUFlRitNcXBuRVM4blFBcHlrSWdlYXdCWG1DTFI3WnpBbWpS?=
 =?utf-8?B?ZHhVc1pObGxmMEtRZ0N4QkU5K1hNMzlMMHVmcldnY2xkcjErUlRjSUlnTjYx?=
 =?utf-8?B?RldnY2FpZlFpMnhuc3BuSVZUZXhnK1AwYndzeDltU0YxVHpJZGVZZ2ZxZVlG?=
 =?utf-8?B?U1B3MmdxNFJBeFJmdWpxaVhuQzl5T2pvUmZpdTJpSGx3WVZKL3huZThQU0xC?=
 =?utf-8?B?enpEOFZxaHIxM1huT2d0MnFNNWh4MGJCS2hoNHB5NkczRE1aTEZ4MjZKa3l5?=
 =?utf-8?B?K3RmWGNXV0ZoMTYrYXNjWEFoVlNMSExtV3JKQWpUZTh6K0N5azcvV2IvbHFp?=
 =?utf-8?B?YVZMUU1pcUlPaEhQcVljYytoTzFhOEhwZmp5U3o1UnZhNHFvd3M0Rmp4QXZv?=
 =?utf-8?B?cWtQZXJTaFFGYnlma2xFTGRVazZsc21DekVBalEyQXhTSjZJQkJ1UGVydmJi?=
 =?utf-8?B?cGdQcElXaVg2bjQ5Mnp1WXFVd25uOVR5UjNrKy9vTml3TG5hNHF5WkV5TEF4?=
 =?utf-8?B?bmRQM0RKeWNSbjFNMjF3UXNSZ0t6NVVZdVoyam1JTHpRN1NNdWsyWE9seUQz?=
 =?utf-8?B?RnJ6d0ZjanpXRS8xaHl3TGdXZVBTSFo1Z3ZNbzBEaWNHZUtMRVdKeVYrTE16?=
 =?utf-8?B?b2pPT21hWFJsdm5wdXpVd2lJSEVHVTZ1RytJM04xNnFOQ0RYcTBtLytqVzQx?=
 =?utf-8?B?cERaMEk5RDFGa2Y3dU5mUlBLc2hPN3A0eUxGK1dEMXplSFBIK0c4M1NtR2hD?=
 =?utf-8?B?a2tMNFBDSnE0Q0lBYjVhcnkvdGQwVW5kZmtVcWhGbFc3R0RwVkNGMWJQQkZy?=
 =?utf-8?B?ZTZ6UkRuWVkwZHlqTVZsOUNMMHVjV3J5YkljR0czRERWdDZYUytYdHd5WTdz?=
 =?utf-8?B?TE1UU05HTElpdVdaNGdLdDZ2Q3ZEdkJ2WVRicWZNdTBiY3A3SndjbzJpNTdN?=
 =?utf-8?B?ZjVDODdpSTNtcnloaEt0MkJCUmZ3NWpVWjdaV1NVcHFyZWJLWkQ1T0czZHh2?=
 =?utf-8?Q?ROyb7N?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:31:10.0141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95170a08-2c41-4d6e-43bc-08ddc2dab1f2
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0704
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

Only scan for the existence of all required partitions of a RAUC system,
instead of searching for boot script files in all of them.

Previously, it might have occurred, that a slot did not contain required
files and RAUC already marked the corresponding slot as bad (not
suitable for booting). In that case, scanning for a non-existence boot
script would result in an error (and thus not booting anything), which
was different behavior compared to the legacy RAUC boot.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 72075c04de1c609da21b0277acae413d97875fd0..cc6180221ed90934801ebd801a7bd1b3fc889aec 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -79,18 +79,17 @@ static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
 	return 0;
 }
 
-static int distro_rauc_scan_boot_part(struct bootflow *bflow)
+static int distro_rauc_scan_parts(struct bootflow *bflow)
 {
 	struct blk_desc *desc;
 	struct distro_rauc_priv *priv;
 	char *boot_order;
 	const char **boot_order_list;
-	bool exists;
 	int ret;
 	int i;
-	int j;
 
-	desc = dev_get_uclass_plat(bflow->blk);
+	if (bflow->blk)
+		desc = dev_get_uclass_plat(bflow->blk);
 
 	priv = bflow->bootmeth_priv;
 	if (!priv || !priv->slots)
@@ -99,20 +98,21 @@ static int distro_rauc_scan_boot_part(struct bootflow *bflow)
 	boot_order = env_get("BOOT_ORDER");
 	boot_order_list = str_to_list(boot_order);
 	for (i = 0; boot_order_list[i]; i++) {
-		exists = false;
-		for (j = 0; script_names[j]; j++) {
-			const struct distro_rauc_slot *slot;
+		const struct distro_rauc_slot *slot;
 
-			slot = get_slot(priv, boot_order_list[i]);
-			if (!slot)
-				return log_msg_ret("env", -ENOENT);
+		slot = get_slot(priv, boot_order_list[i]);
+		if (!slot)
+			return log_msg_ret("slot", -EINVAL);
+		if (desc) {
 			ret = fs_set_blk_dev_with_part(desc, slot->boot_part);
 			if (ret)
-				return log_msg_ret("blk", ret);
-			exists |= fs_exists(script_names[j]);
+				return log_msg_ret("part", ret);
+			fs_close();
+			ret = fs_set_blk_dev_with_part(desc, slot->root_part);
+			if (ret)
+				return log_msg_ret("part", ret);
+			fs_close();
 		}
-		if (!exists)
-			return log_msg_ret("fs", -ENOENT);
 	}
 	str_free_list(boot_order_list);
 
@@ -185,7 +185,7 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 
 	bflow->bootmeth_priv = priv;
 
-	ret = distro_rauc_scan_boot_part(bflow);
+	ret = distro_rauc_scan_parts(bflow);
 	if (ret < 0) {
 		for (i = 0; priv->slots[i]->name; i++) {
 			free(priv->slots[i]->name);

-- 
2.50.0

