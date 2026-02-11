Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D73EB597C
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 08:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2A078367F;
	Wed, 11 Feb 2026 09:37:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="iPuRPTEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 729BC83A47; Wed, 11 Feb 2026 09:37:02 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5586C802C1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 09:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er+tn9CbnRkkhxtnvZmV5yjz0l0vyf1gPDVUZqmnOF+911IJpdtyEc2fe/RWLgUhVsv0eqVC8H6/Aui6YkE+S8tdb/cy6PAEADS/lQHfvH1Y7n/gzLQjU+H1n2Sw8S2vYW42HkaxmKpEb6+/FOwLUbgSYQTEIc1WwwgxCzJEIbahS7p5TsLrB/CyI2wZcNTN5rnaJjlWrfOs+/2EiKYseM4ZkmazXLIt5aq5u/s9laZjRdugocRow/5kncPvwm6OaK2JC0kVYkWuZIIalLnpvkhGZjJDZehMoK51KdNkvJdS8d99PO/1WkOOmomyFoadhXlccmadr1hlChQyuvE8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxhJcdsIpTIB4yq3WCnnZtpOBW3g1aC7iLlgFlJWz+c=;
 b=YIPBy3BAmvIZQRbCkoSoFtb37NPEtGxspcBAGVNh60x4CadPypg7p8fbFKbjl6WpeYN7pqPAlma5QMl124Jo2psPQxEMplpggGHamOXNqZy0BrQzJegGImk2/lsVcdZYs7dzoaz2Roh25YmC4uV2UcOOf5K1zLGGJZJuURcjL14Vyb1DkSH81SRfqDFofRUgxodCqPsR6IIRalV/oWVpbh+dNXpvpHAfluQMg5WMy7vIvJWXq1jvqQYEfNKbcgaBvkDOiIk6IOzgKZijHiMeXipbwXKCqOjWaMeBgZoSt2sGVX4SBk7faS/LWr0aNR5q9WF/acB8dkIOR+iJ8L1B8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=outlook.fr smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxhJcdsIpTIB4yq3WCnnZtpOBW3g1aC7iLlgFlJWz+c=;
 b=iPuRPTEe6rBU4nOncCrkwByzHL8JdRMM0ysYBLC3WXdnrf2kOUiJ9YtXM4u+6zC02BT01iND496EXrGyhEhBrbddr74IYi+w4DNwmjS2FxS5KJZIBqlQL2J1ynMYWkEumCILujz/7ZPqhweBlo7gddKMVOGtxGkH9XWcrOVdXz8EFsXnhqtttzTkAvdNfxh4eQtqsvRtJ3z9SRt/+d7LsP7CS0PSopA5mHz9oc1mixoVeisKQ/IGo041fbukxX7AgW3tAkGJVNEQhvq9UYJ/mXDXivMQPGMNtSUli5WFXa4aZuDiAVShNa/b3eTcqjbdhYVD+Lo4NXUf2xD4n4C+Eg==
Received: from AS8P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::33)
 by DU0P195MB1883.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 08:36:57 +0000
Received: from AMS0EPF000001AB.eurprd05.prod.outlook.com
 (2603:10a6:20b:31f:cafe::83) by AS8P189CA0006.outlook.office365.com
 (2603:10a6:20b:31f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 08:36:55 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF000001AB.mail.protection.outlook.com (10.167.16.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 08:36:57 +0000
Received: from lws-schwan.phytec.de (172.25.32.118) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 11 Feb
 2026 09:36:56 +0100
From: Martin Schwan <m.schwan@phytec.de>
Date: Wed, 11 Feb 2026 09:36:22 +0100
Subject: [PATCH] bootstd: rauc: Fix null pointer access while checking root
 part
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260211-wip-bootmeth-rauc-part-info-nullaccess-v1-1-d0606be8a33f@phytec.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NTQ6CMBBA4auQWTsJrYA/VyEuxjrIJNg2M0VNC
 He3cflt3tvAWIUNrs0Gym8xSbHCHRoIM8Unozyqwbd+aL1z+JGM95TKi8uMSmvATFpQ4pQwrst
 CIbAZXroz991Ax1PvoMay8iTf/2i87fsPAQtu0ngAAAA=
X-Change-ID: 20260211-wip-bootmeth-rauc-part-info-nullaccess-948e546a3751
To: Leonard Anderweit <l.anderweit@phytec.de>, <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Andreas
 Pretzsch" <apr@cn-eng.de>, Francois Berder <fberder@outlook.fr>
X-Mailer: b4 0.14.3
X-Originating-IP: [172.25.32.118]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AB:EE_|DU0P195MB1883:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e6bdc8-81ac-40fa-4130-08de6948b7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|32650700017|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUFuNzY1MUNhS2NFUVU2dmJtTmFCemEvM0xTbHh0eWgvMHh0RFdtTmt4WDBw?=
 =?utf-8?B?R1ljUDBQMElXOVZKcGdqa0FUUk14YTVXQnZXdkNkWFZDcUhWc0hkcEtOM3VP?=
 =?utf-8?B?OExUSjZjR1ZJcHA4eFA2a3hRWDJkc3UreWV3NlBMaURkRkpYVzk5eTB3M0hR?=
 =?utf-8?B?dmhKRlJrMUxheE9LQVR4RmdnNXkrQTB5N3pwNjU1N0VJakdVTGQ2UlFYeWxO?=
 =?utf-8?B?MkIvSllOYjBhanVrV0d0RHhrWWNiUVhiRDZ6c3lYYVhvY0VPbTJNN251aER3?=
 =?utf-8?B?TGt5bWVMaHFNZVYyandkbU5DUFhKb1F6RzhINCtmU054S2hRbzFzZXhUeHBM?=
 =?utf-8?B?K0NRQkYwL0lmL2g5YTR5dzhGRFdFNDdCYms3UmZUdjk1aXI2MlJFeC8xMWtS?=
 =?utf-8?B?c3lYRmJmZ0M4L0tDUGpKVUZuWXk3cnFqaHZvbFZYakthejcrc1o4UTF2Q20z?=
 =?utf-8?B?WVVBTWpCWGJ0SHY5cVBpVXFRVnRqMmFmV3c0aWFWT2RZcXFPOEdGRkZQS090?=
 =?utf-8?B?UzczTTBzUnFDMzdaYXJ4VWZpUlpUZjNOUjRxSEhJbmxldE1iajJZWXhDRFRT?=
 =?utf-8?B?RUduNWkrQmswbG5hN3dWaHE5RDRHcStUVElSNUNzcDBMTHh0bXdlNnZnZzM4?=
 =?utf-8?B?cXZZMGU0VkNyRE5JV3BQMkxpSW1QRmVLUjZPTWN1MExwRUNMcTJPbDQ3c0FY?=
 =?utf-8?B?VWJiL3NnVG5lM0c2NkVaOTM1ZURkQ2E3dklCNGNsZHlrUitoaFV6VXYrVndB?=
 =?utf-8?B?SGFQeXYzWTJyNVA1REZpUnAyMVRVNmwwMnlKN2RrZnQ4VGlObzZJRDdBQ01T?=
 =?utf-8?B?Rm02MnRZdHJoVzQ0UThsMVcwL013OURtL3hSczc1c2IzcGZOWXZLZzJZYmlM?=
 =?utf-8?B?UEJHcG4weHo5T0gzTkkxcC9Bc1Y5VzVPUVYwYjEyWTE2WTZFYUVpaE8rVm40?=
 =?utf-8?B?a3E4V3lQUmpNSktqQ3Q2NVFkYm9adGpKM0U4MTdyWmwvaWF4YTdUUHJ5MkJi?=
 =?utf-8?B?NWFGNytxOXRlUFBsZThVckRUWkkwY0xGbUF4Ry8zU2hLZC9WRUtSekVrVEc5?=
 =?utf-8?B?WkF5U1ZzM3hINDNTN2dYWU56UDZxZkc5S2hQaWxtM1dpL1czeHNudEthSzhX?=
 =?utf-8?B?RkVLWXZ0ai9yWEtzLzdyZURnTWxvNHlVZEIyMThxZk10WVYzOVhmT1loZHRY?=
 =?utf-8?B?QldwY2didk1mUUl4K1YxZXFVdXpIdFg1anhURU5DU0dsWjlWMDhZM0prY1Fp?=
 =?utf-8?B?WFdGTTlOU0J6N1Y0Sk11MUF4R3hxRXpyL2ZXOS9kK2tZM0tGWHJQSWYxNGRX?=
 =?utf-8?B?SW10cUo1aGhHUndFZWNZRVZrQjBqYktnQy9aaUpnSkxkbDRFNzA4c0Jwc2Rv?=
 =?utf-8?B?a0pndnFaL1JXZFNrSmZhL0JuREU3MmhycWZHU3JiRTZJRlkrekVKZFdKcU5I?=
 =?utf-8?B?YlBUV0dxNTUzYmZJSlpiT3o4amUyY1VFWlQxNmFHUEV4ekFkMldsYXNCWjNl?=
 =?utf-8?B?d21HNUZzaC9seEFMellIdHc4N0lleFpKcEZLSXlKQzVNSmMyWnB3K0g2Z29w?=
 =?utf-8?B?ZExMeUk1cmpwVE5KQVpTNWlOaDdFRncvNWtDUWFiRnlSNTdBRE5FQU9FTjNl?=
 =?utf-8?B?bXljMVdDclh2VmcwcitPajF2MTk3M0VFZ2NLWXlCU0RTQVVWQlQ3K0dSWGVT?=
 =?utf-8?B?VEYxZGVPbG1LenVpTGFpN3JWdnp0REJsU1ViN3ZDOXpZVFNPd0hrS2RYUVFz?=
 =?utf-8?B?SDh5d09JZ2VUdW9KQ2tmanhYV2c5ZjhsQmhoV2xReUJuVGdwZXl4LzNCM1BZ?=
 =?utf-8?B?MFdTMHNXS3l5b1JsK0Jpb21ITDZlWXYyUGRITHAxSXNsaTBQQUdvVUZFZ1pQ?=
 =?utf-8?B?V0U1N09vclJWN0JOTnBSYlpWTlFDVmdkMk5DOGJPUDBrQ0xrL0pwRUYyUUxr?=
 =?utf-8?B?WjVHM0pUQU5CZENFWHdKWVF0aWdDMVIrOTVlbTlpeFAwYlJNeWQrL1dvSXFZ?=
 =?utf-8?B?czFyUWFjMjZ6LzNncmpiTXlseGlCUWlDWTQ1a1pHTnJRNExoR20yT254cmZJ?=
 =?utf-8?B?MzFoUlZ0cVhzQ28xM2FuLzd3SlBVUDBVaHZqWHg5UC9PZDhXOE9DWmhxcG1F?=
 =?utf-8?B?K280VmNsUjZNaS8yMmF3MTE3T1NGckpJeWNISW03bWsrelBSUEJEY2ZMRzBj?=
 =?utf-8?B?VGxoRytXM0Yzc1RnV2dGM1lkTXl6MjVBWWIxRDlET2lXMXFhVzNGS2ZKRkVZ?=
 =?utf-8?B?QklCQzdKaUZ2Ry96RGdwZzlkUmJ3PT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(32650700017)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7xwEdONSGK9H7SokuhxXsQIK2MtYss5ZU74ZaPsT+Mc1UH+DcFSGUPAC/PODlYorEVzifxhwD2I8VzYI4G7b1qWNxLJppY6XdG0/JVA4SZaH9pgwNSe8lBihaHtr6XcT42pQ0BD7m9mEt5BdJjvtwTHgZX2Z9ecqBg8ZsS5NALqD8E3qOtUlme7r+dQZtXAdP8A7SCgp8+8hcW1wr+SQjNu2EQ5xydgsf6gqQT2qzXCXTjW92MzYJ6aPyVtsmUFeLR0cbCsU5v0cYf/S2HGXZW0CsdpKmW902065++waEtGyI45jpj+PfDHDYTjBmo8oMm7wiD77hf/9o0vhdHup0/+PHwHmRaLQrewd+vQLlPsxhAuhYPSqINXF0yXAtkPxrmu3MvLBDnFC3ZkOUw9rk0/lNoNiPjI0PVrvPMbODhcFoY99avA33yNPMQycwokA
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:36:57.3610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e6bdc8-81ac-40fa-4130-08de6948b7b8
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AB.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P195MB1883
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

Fix a segmentation fault caused by a null pointer access during root
partition checking. The function part_get_info() was falsely given null
for the disk_partition struct, which later resulted in accessing a null
pointer and thus undefined behavior.

Fixes: 5d7c080ae5dc ("bootstd: rauc: Don't check root part filesystem")
Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 432d170e006..d7b0c686ffe 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -97,6 +97,7 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 {
 	struct blk_desc *desc;
 	struct distro_rauc_priv *priv;
+	struct disk_partition fs_info;
 	char *boot_order;
 	const char **boot_order_list;
 	bool slot_found = false;
@@ -123,7 +124,7 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 			if (ret)
 				continue;
 			fs_close();
-			ret = part_get_info(desc, slot->root_part, NULL);
+			ret = part_get_info(desc, slot->root_part, &fs_info);
 			if (ret)
 				continue;
 			slot_found = true;

---
base-commit: 712765339a5c6576fdd5683748f97a1215868d5d
change-id: 20260211-wip-bootmeth-rauc-part-info-nullaccess-948e546a3751

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

