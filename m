Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42999CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 11:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7F583C08;
	Wed, 12 Nov 2025 12:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jyPmkTnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CDDE83C46; Wed, 12 Nov 2025 12:16:22 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B8C83A03
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 12:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnB9Wvy0jY5D2LQMVHEwt4C03ILXk6NgkJmIQKQlJ2R6SON8vIHQg0sqOK+y/ZvLwlFiaPIaQPB96DiinOlPk0mrU01yyWjJWyHiooDo4Fwk/7JKO6ZzvCdSJcm2WMWKZ1aKkSh/hr0I9eCe7xih688EVlfaNQP7tbU7DK+qkBSRjeeQNWOFYN/0yeh/GzkFL85RDkmvEMBC5R/EeMSF6vx6G+R+0AYwPtyDbwR2ADAUTom6NOrBg73DYtm80xnij3kqKQFIDFxoigyzNrwcdVCR/6odGa8ODGhfzueShWtJmnKFDsCiUpuRaQN2cI6onZnaAq2NQX/i9mAVicb1mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czek/3350rMjnBPQ/e1k7g8Z1+uvTQfsexa6mvnuPZE=;
 b=U2W033VzI3HqfwC1XYB7SqFcLe56q5DrsoJGlrC1odKHavStWivOnNYZL0Wq8R6vCccASVRCviXPUlEpn+eNDei7J0wgAO8YinR73TQFkHzqe32Qsa93ym2qW5zsNal/su6ArdgxzO3njOyQzUIbmC1UhWG52pL8p/zHUrlOabqm8lXkPuTz4VJjMUYp5OaSdjgmQ29DIs0l/iU1h/qbl+R2u3TgsHnfHATyQHiO+bmha2FsXK3C7vwfdkwT92WREqExvgoZ6vfp7nDZBQnM/RnAoJ2zdvxYev9reEtgw9CLhIXtxgwvQx3+DhnXCa9QgxiyAMvzdC9u3aix+bfv/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czek/3350rMjnBPQ/e1k7g8Z1+uvTQfsexa6mvnuPZE=;
 b=jyPmkTnC4MzYmdKC9fCqG49eEyFVZ5Y2+nHPMMmg+VnuqO819gDvUnq3z827oNc7gOfwHQt47xvka+2uLm17m9TZ4QQhJ0gG/2cMbfLl7nFyh+pJObegar/qEXjYmM6PHMnB1+sbLdhv2F6IICb/hqVz/IHHZDQFYNRqmxaVgkE=
Received: from MN2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:208:23b::24)
 by SJ0PR10MB4734.namprd10.prod.outlook.com (2603:10b6:a03:2d2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 11:16:17 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::5e) by MN2PR11CA0019.outlook.office365.com
 (2603:10b6:208:23b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 11:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 11:16:17 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:16:14 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:16:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 05:16:13 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACBGCLV2598283;
 Wed, 12 Nov 2025 05:16:13 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 12 Nov 2025 16:46:06 +0530
Subject: [PATCH -master] doc: board: ti: am6254atl_sk: fix PRELOADED_BL33_BASE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-sip_doc_fix-v1-1-1cdc147cb83c@ti.com>
X-B4-Tracking: v=1; b=H4sIAHVsFGkC/x2MQQqAMAwEvyI5W7DFIvgVEZE21Ry0JRERpH83O
 LcZ2H1BkAkFxuYFxpuE8qli2wbCvp4bGorq4DrnrWKEyhJzWBI9xg99iNYjJpdAF4VR8/82gTl
 WuZBhrvUD6eDEJGYAAAA=
X-Change-ID: 20251111-sip_doc_fix-574cd15eef2f
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762946172; l=1434;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=44UvPqd6O4DdMG8QikJpA8VkE05P/omfiDaBGrizvcs=;
 b=ixdDlyDfrqmuJoNXTPxKAm8y3afWjmApDt5sXhTZlXMKEbYGvXw2NeNJsmKow1ytESWxDYYXL
 7iZkMR7Da40A/kXB1wveCMqSZ+mzZPeCIt20d8StVlrPFzVqJU6cHkF
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|SJ0PR10MB4734:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e8cb4a-9ad1-41e8-c3c8-08de21dce640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnZrbUZEbUtUT05naFkrMWZhYTBRT0lLYlljcERuTVB4QnczQVNER1FIRHB5?=
 =?utf-8?B?QXZET2hrWFNCYitadXBJWjdMZ3RRempGQUhDeEFpb2V5YURnSnB4dCtvTUJ3?=
 =?utf-8?B?clpCV0pEekx2NXgwVFhLTVRxV2ZmaFhVNVBYTGlMTXBXd0pUbllTUGJZSnZD?=
 =?utf-8?B?MzNpaWZ4YnJScHRZaFZ3MEYwYW5Pd2V0ZCszV2k3cWx3aXpGclQrcnVQclJ1?=
 =?utf-8?B?ckJWQ1F0TU5WWGZuNXBjMUhNSU9leDBkUnhaUXBIWWJEbEJ3SGhyMFkzeXRP?=
 =?utf-8?B?ZmptaVQ5SENqK2hhZmZ2N3VDY1dCSVJ1WGRORlVnYStvbXJZNUk0eHIyQS9l?=
 =?utf-8?B?SW1YT05GRndXdHpvaGxYRzlZSUZFRGZLOHVHTXdSbmxxVTZLMHRHVmgxVTRJ?=
 =?utf-8?B?cDdpeXA0bmdReFlDbTVqTHovczVVYndWcHp5ZGZhQi9IVTJlVlVJUkpuSUxy?=
 =?utf-8?B?dVVZeWV1VUZuT3ZEakRwU1VhNFFKcmdyQVNoYVFtZzBlT1RkVjFEcEFmUkIy?=
 =?utf-8?B?RGZyRXIrL3dkdm9uTlJZTlBUS200UlRDaCtOMWFsNE5QVDNmNVJNb3ZsWXNi?=
 =?utf-8?B?eENyUE5tdis0bXZTQkZRRHFiUkhVOUFlV1BGWVBMRVZqdWFta1J0cFJ6SzBN?=
 =?utf-8?B?c2Jhc08yeGxBUHdJNVdheTAvUEV5TGlsbUMzMUZjREhiTFp1bnRFaWpsVnBT?=
 =?utf-8?B?bGR1czkzeTVFTGN1VUxVQXdEME1zUzVJOWkxR0wzOEpxWjRmQm9yWUdxTGNs?=
 =?utf-8?B?WDU3MTFxMzZCQm92d1FHV0tRUU1STERsa1NWSWprNlVjVzJycjhRQzFHRnFB?=
 =?utf-8?B?elFhZ2E3Qk1GNUJRM1FmWmQwUEVRUGRMMUUyOFBveDd4Tk8zblY3aHB3L1lo?=
 =?utf-8?B?aDJQak44cjRwMkdySGsrU0hucXFZL2xWbWsvZkx1b1dRaGM5dzhmNDJXM2Fj?=
 =?utf-8?B?L0xJWUZrMG85alI3WUtEOEt3SGVSODdrZ2FzQTdmemlxT3JrSFMzUExaMlNU?=
 =?utf-8?B?K0k4blhicFA2RVZNVHZqdFJLUkV3bHYwZTZ0VFdwTEp5VXBzaGFOdlowVk4v?=
 =?utf-8?B?RU9CMWcvQU4zTVFLd3dBdW1sY0NSTFJGQmxWUTBoTDAvUGRqSlB6cHJwTUk4?=
 =?utf-8?B?ZExOOVloRDlTUXUwYXcwT1AwWDdlY1V1MTg0eGNIVjVKM2FENVNwNGNhcFVC?=
 =?utf-8?B?aDYzSHhERlYrN2Nmd1pITlRMZkxhRTZ1QzFCMVFZYmZaemZsRThyUnBiT3BG?=
 =?utf-8?B?NDdwNjZPSjA4TktjMEltbFM4M2Z3d3JaN0FPcnYvQ05ub0F1Z1dTMCt2NEE4?=
 =?utf-8?B?VFA5ZjEwMzZvTmt2aXZVTU9CNzZuV05mdG84U2NQUm5mZWlURWtiUWVRTkt1?=
 =?utf-8?B?R2xSOXFOeVFtMmIwOTJlVVB3ZGFtRFNYZzgzYWF0NkNGaE1hR3l1YlI3Wi9J?=
 =?utf-8?B?bHVXcXJZZUppazhQY1FTMXFIaGx6K3l2aW9HUmQrYVBNSVpseUxuU0xrU3FQ?=
 =?utf-8?B?bHpacnFJekJhUTBlV1kxUW1Zc2loL3BTR2xidnFzR0R5bG1PcG5RcFhuMkVQ?=
 =?utf-8?B?RTN2aXFhcHR3ZGx1elhWVXZraUNZZ2VySVk5cGtiWElOTndIRlFoMmg3WUtv?=
 =?utf-8?B?ZzlXZmh2Mm8vUmNxQlUzbUxhR2hyVTJDc0lPNGFlRlFyWXJkY3JNL3FEWFFl?=
 =?utf-8?B?aVkxV3Vmb2ZYUDlLaXZUVlZwc2FSUVF5VGVRYVBBbm13UjNlTXdLVDROYnpv?=
 =?utf-8?B?RFlLQmRwRjJZN2ZLa01oZmgrNFRzUWNSemVqbUk2NTR2ZnlZSmlnSTkrOUZD?=
 =?utf-8?B?VVIrSWcyamdPUWFGYkdTNk1Wdk1WMFU3Rk1DTXp5N2hiT2JKeUdRcHd2QVZX?=
 =?utf-8?B?RkxRRkZUMGNHTkdiUXNQY2o1UUc4RlJOckRUS3JNN3kwdmxjaHJkVEhGYkpT?=
 =?utf-8?B?alczeTNQVDQwYUtYSFVWVExOTGthdVA1RFlpMVoyU2lvaTVMWUZXM1FDVnBZ?=
 =?utf-8?B?ckJUMzlRcjd6RHBmaWpPZ2FSTTl5Q1N3RzlUMURlNnk4dnlHS2pob1V3RlFG?=
 =?utf-8?B?SWZzNk5zSmcwZDdBTjM3YjNNWk43cjg2eUNnUTJHWWlwYzhCN2k5YWxkOHRK?=
 =?utf-8?Q?quBg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 11:16:17.1556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e8cb4a-9ad1-41e8-c3c8-08de21dce640
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4734
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

The SPL_TEXT_BASE for AM62x SiP is set as 0x82000000 whereas the
documentation states 0x81880000 as the PRELOADED_BL33_BASE value.

Both should match to allow TFA to jump to the address where A53 SPL has
been loaded.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
The A53 SPL memory map for AM62x SiP should be updated too but it looks
like the A53 SPL memory map for a lot of K3 devices might be outdated.
I'm planning to fix them all in a later patch.
---
 doc/board/ti/am6254atl_sk.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
index 905b43a182ba16ec1d71e8428f482fef79e947da..11a9d865f0d060e05b310dd47cd2ae2d7481462a 100644
--- a/doc/board/ti/am6254atl_sk.rst
+++ b/doc/board/ti/am6254atl_sk.rst
@@ -60,7 +60,7 @@ Set the variables corresponding to this platform:
   export UBOOT_CFG_CORTEXR=am6254atl_evm_r5_defconfig
   export UBOOT_CFG_CORTEXA=am6254atl_evm_a53_defconfig
   export TFA_BOARD=lite
-  export TFA_EXTRA_ARGS="PRELOADED_BL33_BASE=0x81880000 BL32_BASE=0x80080000"
+  export TFA_EXTRA_ARGS="PRELOADED_BL33_BASE=0x82000000 BL32_BASE=0x80080000"
   export OPTEE_PLATFORM=k3-am62x
   export OPTEE_EXTRA_ARGS="CFG_TZDRAM_START=0x80080000"
 

---
base-commit: 27bb38c8e7ee7929c9c3f50047b4acb44f357c55
change-id: 20251111-sip_doc_fix-574cd15eef2f

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

