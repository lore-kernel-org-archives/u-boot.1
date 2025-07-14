Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8557CC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F6983071;
	Mon, 14 Jul 2025 15:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oJp6lOHC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B35E83022; Mon, 14 Jul 2025 15:31:14 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E7083046
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqdeUl0Rch20YD9MztUJlYGKvoIQILvN0CzlM/IxDcMFvDICuvO89bgl9JIIxx+bjMGAelN8g9AsDMNMobixDmvmu89osSSbgyRDLS96WW01UtJmwdAoeOwHVOxQ1rm+51TH0418UVCBfhdlwN9HR9xuTQmFljCED6FUqTSEFOIqkkfL3bxr3kgFmWAsehwp0O7FdbwRM1fvMwnXLeYvvXSTS+640R8OovzaDTiXscPSWNq1TEARUiqp70UckZV8puJy+jPSx9LDBczPRaC3/Nm1EAJFCNHhKLnE70XiSM5P5M1MGycBk86kqeX8t5ZKBrQnN2/RM5T9+LuoCkxpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cuKzvoRKNVF4a6ErPd79CVvtg82iFloy4jsLLnYSUg=;
 b=iSiZ0d9/IE/xolLiJdY5crXjqTaFv/VO1TPgMKfyhFpUnJvfntWY0BSDgKnsEnbZFhDnIZAFidmjCXAQZCtQ6MPnoI5sGL9+Yih3DJ8ac8r2c7hSlO6t1j2qbyUgwLHDc+H/Ju4057LQSEBCCd8zUfo9zZMtU7LRauQYY7PUjog6LE3Z2Yxu7EGXcyUDIdHV1NuHS2bRklNI3cSAcGenz7CkQiJ0KTtbxyEUWfHPKKsbSG6DEcUp2iaCkdKFcbj2XM7zsFSbKVsaWYrAxCDnOGbZ0D4dlsZZb3yDfsq84uGcVxlBT4l0F80B3IgEmZzXGDEANQDoXIJagZB9IyTS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cuKzvoRKNVF4a6ErPd79CVvtg82iFloy4jsLLnYSUg=;
 b=oJp6lOHCpalhgaCQX364dhiWyoXqfiwLPMXtmzGDdRyUzUq2+tALAkIHsQWxLOXZuTSPxpNZRG6AqEyckQ+V8JkMRZ4DkXxJZ/G/ofLhBm8f+ePwgHeaopQab9NNvGk5GqZHRCaYKqYYWx+wZlvdQNJg96kKj06NQZNYJMwvLfTTbuw/3C/N3FxaQIhLYXGgVP53P5zd1nS4W35AAs9GHpNvrCJDcG/xgEQJnHodvN1yPrBgioHNPgpB1nXhVLJ1BGHGjlELa9+DeVHJpE5hLE9WudNy6DBOO9OXdTXeDerWqdfK7SwFhcdiz6F3+qz/Jq7nv0ns09D9+PJlxc29Dg==
Received: from PR1P264CA0101.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::9)
 by AM9P195MB1078.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:31:09 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:102:2cf:cafe::2d) by PR1P264CA0101.outlook.office365.com
 (2603:10a6:102:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 13:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 13:31:09 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 15:31:08 +0200
Received: from [127.0.1.1] (172.25.39.83) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 15:31:07 +0200
From: Martin Schwan <m.schwan@phytec.de>
Date: Mon, 14 Jul 2025 15:30:08 +0200
Subject: [PATCH 1/3] bootstd: rauc: Fix potential memory leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250714-wip-bootmeth-rauc-fixes-v1-1-69d2b80e7606@phytec.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|AM9P195MB1078:EE_
X-MS-Office365-Filtering-Correlation-Id: 6313f9c1-555a-4348-e7c7-08ddc2dab160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVZaNTY5cWw4U3Ixak9YbGl2SUREdEhBVW1wQ2VlU0pBTDNTNk4xYzBudzVU?=
 =?utf-8?B?QUs1TWtPVjkwbTRXaFB0cDRWVFR3bWoremswZXNXUDc1a09VeEs2OFlZUkJo?=
 =?utf-8?B?dmo2d2NOaEhEdjg3WkxYQ2J2MHRGUGd2NUtBRFFaSVRYNnF1K0I1c2xkWW5z?=
 =?utf-8?B?RzB4a2JycDdxdjdsUzJrVUtVR2w5RGtqbUk2YzhMTS9jVnhxbTV1L0l6TEFB?=
 =?utf-8?B?Y0pydUorQi9SanJGNWRPeEVOVnhRbUhvSDBCNWpNWkdUd0h5bDRxZ2ZrQ1Nq?=
 =?utf-8?B?dTZOc2FGRlg1Mk5YZ2djcU1jV1hlTHJla3hGTG95dVM2K3kwQVZERDJscFdi?=
 =?utf-8?B?SUJtK0VLNVhsN1NzZ0tDVTdQZXRaWFVVdjU4VGgzbFJjODcyNkVqS3h6dFMr?=
 =?utf-8?B?L0hiVDZ5YVl6M3ZKb3dlekk5Z3psZmFEUG12MU5xcCtPZ0VLNjZ0WmdiUHdZ?=
 =?utf-8?B?VlNEYTJkbjlOMVJrd2RDUmJ1R05YT3lPblB4SGpZa2ZHektRNHRDTWt1QU52?=
 =?utf-8?B?em5yM0hhU1c1ZXpha0ZlQUhoY2E0ZEx1aWRTN2tVWjZhcCtCUFdtZS9uL1B1?=
 =?utf-8?B?eGVKcy9uR2x5SmVtWnBmbzA2RmlPZ3Jqcm0vMU1zNHNVOEFhZ0FQYW5BRklO?=
 =?utf-8?B?OUdkdlNZOHJFbzdVWFdWd1liWlNvRGxvQ084aTZ1RkZwMVNvVEpEUE9wckl1?=
 =?utf-8?B?THZyeWhBNWtUcDhuME4rcjFhalQyU2JTc1gxc01MV0wvSGREY3huY1cxVzU3?=
 =?utf-8?B?N1hzZExJdmxGYitXSmtnMWFqZitySytjZTRoZVQxemoxRThPTnkxVWhpVWdC?=
 =?utf-8?B?c2IrVDBqTkJwQ3p2Rk93Z1lFb216a1BIalE1SUdCVkZiejhuT3B6dm1jbmVt?=
 =?utf-8?B?b0lIWnZLZmtBUmxuRmF1T0tNMzFSQjdXNkFoa2tWZnk4dUdZclh2WlF0QVgv?=
 =?utf-8?B?UmlOVEtERjF1L01ZekthVDBBUnllYUE5RTRzTmRPWmVoU0V6SkRGN0paaXFE?=
 =?utf-8?B?NkpnNDl2ZFhHVTNqaDY3VmRwYmhkTUNwaE5OdHU4dDVOMDVzOE1UbVRGRWVS?=
 =?utf-8?B?b2tQZUNRQlptS2JjQzVuTkdqaTE4YWdvQmtrVE1TK0xydlh6Nnp1M2EyUk1I?=
 =?utf-8?B?enY3OWhuREcrcWhFYkc5dllWNXVsM2ZMZ2V2N282NnRWSW1DTk5OTDRnbVR6?=
 =?utf-8?B?VE9Kd2w1a0Vma1FVYSszdlhZaThaUDlFTkZxWmpzNW03MUJNd242Wld0aWZ1?=
 =?utf-8?B?dDUySU9mbHAzL3BNWForNnBXdmh0bGVydzVKNmVnWWMwNUlZZVhZaVRJSkM4?=
 =?utf-8?B?V0JoRDRON2J2cGpENDAyekxDdnlLeFhBeDh6RTN4bmgyTUt4UlBNUGxCdTJr?=
 =?utf-8?B?Um4vaXpiRXJkaFg4NlppRzJ1V285akdtZDY2aTI5aUV3OHFJRy9hUWJwUWda?=
 =?utf-8?B?bXRSYlE4VGt0Z3JwZEQ1RnI0OFJlQVJqQzBUWUk3MEZkQ2tYZVhTUjBmNDR5?=
 =?utf-8?B?akR3VDd1cmgvVkt4dXhEUFNtLzJkWlNwV1RoQzB0L3VCT2hvWHllZmZpMjYr?=
 =?utf-8?B?dEtJeUo1amwwbHBPVGJvVU9OTzczT21PSzJpdGtpMUdLVzVrbnpCTDBQMVRv?=
 =?utf-8?B?RnZYNm9iU3grUThESWVnUVkwWlh3OVRndDlIK2ZGdG9qeUlHVElzSW1OTlF1?=
 =?utf-8?B?VzBoN09WYWorOE4ra0RMTkRIbUxhckEvYU1DbVJlV3o0UStwOHc3YWQwL0Mw?=
 =?utf-8?B?MTZqNTNQK2M4c1haTzA5V3c1RVJnM2haV0FPK0hxQko5Y3pmUGg5dzhtVkRt?=
 =?utf-8?B?SExMQVRmbmJUSU5zUVlJM3QrSkxBRzFBdHRyaThxalphWUpMSTJoUlNNNHhU?=
 =?utf-8?B?cS9Vd1JBaGVlZHdYYm5vV0ZUTVBXL2Z4b3BZNkhiSjE1Uk9VS3BzRCs3M2k5?=
 =?utf-8?B?cStPVW5NMmRoSGdxQzNvZjdnZFJ5dWtMK2JzRGg0WUpBaEdwZm1CNGZPaU0y?=
 =?utf-8?B?cEpyUzg2d2owYXlJSHpVZ25TWTFDNFNwK3JLZ3BoRForeTkrakY1cmNNb2J6?=
 =?utf-8?Q?d3ynAu?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:31:09.0608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6313f9c1-555a-4348-e7c7-08ddc2dab160
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1078
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

Fix a potential memory leak, by checking the return value of realloc
first, before assigning it to the private list of slots.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index fc60e6e355dabef4d58bf1203997b41d99c536f9..6abbd25704bdf218bb0b3a02306993584088d2c7 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -168,13 +168,17 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	     (slot = strsep(&boot_order_copy, " "));
 	     i++) {
 		struct distro_rauc_slot *s;
+		struct distro_rauc_slot **new_slots;
 
 		s = calloc(1, sizeof(struct distro_rauc_slot));
 		s->name = strdup(slot);
 		s->boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
 		s->root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
-		priv->slots = realloc(priv->slots, (i + 1) *
-				      sizeof(struct distro_rauc_slot));
+		new_slots = realloc(priv->slots, (i + 1) *
+				    sizeof(struct distro_rauc_slot));
+		if (!new_slots)
+			return log_msg_ret("buf", -ENOMEM);
+		priv->slots = new_slots;
 		priv->slots[i - 1] = s;
 		priv->slots[i]->name = NULL;
 	}

-- 
2.50.0

