Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A0DCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 12:22:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A414D808AF;
	Tue,  4 Nov 2025 13:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B8LeaY/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 684EE8144A; Tue,  4 Nov 2025 13:22:07 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AFB68003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 13:22:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Csg9fcLojMZgYjL9vcE0mZxOJrr1IbBsJ75sitFJYLDpI6ndnkIAz1U7bqJtBwCpj8+q8ymNMe8BJwC3y/5vlfh5QUPOYlfrx4RZzP0ehy9IxdMNwVAPAuLQR4//NNF7iw9GyL+oyF6cRRSISEWhrKXoH4zntM0Wi1FvlfDQxY4mrTI5MS92z8JzielpZ/tMzgzhaKuW24IDNJAXLPlxj7jyiqpSeCBRmjOpRukcpThrsZI/gJr8NQtD1HWWfiz9LEd3kpNSNV/JeBtTj6Pe/WmFebU3WMfx8wCeQ/5ih2EGf/+SPkUqSRPeUb0fmAyShQhqQiOkeVuJ19ziqMeSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XndyVqo/PaIvKSygEjlazCBcgW+WAb4bq+LFuqvL5SM=;
 b=zW4tZSl9gTDWgPHnL++W2/3r/4OnkId4PR4nJaTTs8JBUTgXpn6Oz1DukE0cTUP9qSyfb2BDAydnW8vlK4V3ewe39Iw0HCK+SjabMgJHsI6hZXX+fJLjLFptM7F2T4/jgHS0rzbjq4bbKZD+5pgMOc2Ojq8KSVvTWrOLcxBj50v3Ou3w1CQsD+F2KbjoW7u2cBfYsYtNFURas3qb8HrOOnhAkV7AVkhHM3zwnkCkYGHxrvDnfcYAOVAS0ff/8oewYKtfSa7INSm7RtCjLo7OipyV/ebI+8M3qyuj/VCzZhxnpcH2zcKRg6akyPLE5E4EwtHc8zRTJUz9TZIo7NiyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XndyVqo/PaIvKSygEjlazCBcgW+WAb4bq+LFuqvL5SM=;
 b=B8LeaY/70MPTMEYAOPEkbumOnu6lRsr3nPEzqoDhH7XhV3j2fMeKz0ohtLPYSwbqu1rqVYnLc78gL1lKXrTo9XCJLHm09axo66LCx3QCyJDjqkVIwjzXsNP20McARGyFZ1INHqLJYnSXSDZTlF6Cypf/SV7ufnfvfNEl40BmE2I=
Received: from CH2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:610:60::24)
 by DS0PR10MB7511.namprd10.prod.outlook.com (2603:10b6:8:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 12:22:00 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::fa) by CH2PR14CA0014.outlook.office365.com
 (2603:10b6:610:60::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 12:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 12:22:00 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:21:59 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:21:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 06:21:59 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A4CLw0r1934637;
 Tue, 4 Nov 2025 06:21:58 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Tue, 4 Nov 2025 17:51:50 +0530
Subject: [PATCH] mach-k3: Kconfig: fix NR_DRAM_BANKS for AM62x and AM64x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-fix_nr_dram_banks-v1-1-761ddb57f4cc@ti.com>
X-B4-Tracking: v=1; b=H4sIAN3vCWkC/x2MQQqAIBAAvxJ7TlCzkr4SIZZbLZHFChFEf086D
 szMAwmZMEFXPMB4UaIjZlBlAdPq44KCQmbQUtdKSSNmul1kF9jvbvRxS6KV1gZjdWNMBbk7GbP
 0P/vhfT/1L7AuYwAAAA==
X-Change-ID: 20251104-fix_nr_dram_banks-7088d4826443
To: Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Dave Gerlach <d-gerlach@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Judith Mendez
 <jm@ti.com>, Vignesh R <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762258917; l=1286;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=3ba0+MxXLLpeWouauqHCL1NOIg+Y+P2ydkJf748UsZw=;
 b=HqKDht8RIsPjuyE14rYjK/ms0SgFf9xhvs4Ap8IRMrsAEbao2sglscbstmgRDDi2tjdxTsXpg
 45/SkN0VJ2rBR2Fd9KPBSgrz0idDtHtot1MXOc4gpOBae9uP1VLL7qI
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS0PR10MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fb5aa5-e79b-42b0-4149-08de1b9cc13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|34020700016|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTNXV2traFh3dnRJSUFKR3dvNmhzVTRHR1Ftd3ExMDluc0RjSU5KRW5DR3d1?=
 =?utf-8?B?eWtYeWk0cWZaMzJkNW0xK21JMnVwRWk3aEZuWk4zdVJUd3JnQzBDZFdZVmlY?=
 =?utf-8?B?SXN6NW9Ec2lta0tNdHlJVFFvN0h1bHVTVTFxeXhXNERNbnorVThpTG1nWXJY?=
 =?utf-8?B?bEdCYUEySWVyN1QwRG5ULzRwbzFiTkN0dllDVEhNRFdaYm1xMDA4MCtxbTd2?=
 =?utf-8?B?YVhrS0l0VFpjTFJuN0EzK29nNHlwdmlQdXZIQmUxeGRTWWQ2Q0dMOVRlMzBi?=
 =?utf-8?B?Znh3QzkrbTVYUjF4ZVB6QXF1SEk2QjUwblpWcVR1N09Ca3o4QUp1b3lQWGlv?=
 =?utf-8?B?V0VOUVZZbDhpZnhQd3JWSS82alZBdnpzUUZMS1RyTDZJOFIyNHU1TkhRdWVX?=
 =?utf-8?B?aUhoV3RJZndMNDFVWHJoL3lJWnhUYUpHR1FFUDFwNGROS2tBRGtQNDZzcTFs?=
 =?utf-8?B?ejBRODZqYjc5UndFSDJLQXhTWEJuZWs4dy92cGxWQXV0dGhudVdjZmFVVTRz?=
 =?utf-8?B?Nklxc3hBWXdBbG5CeWVxZEdwaVE2d2ROZkt1VExDMVIvaE50N1B4TFZra0RK?=
 =?utf-8?B?ZzBCMkdmZ3FsU1c5Y1FUK2hVaWVKQzJqMlgyVlNvWU5OQjNTbStuNExYQmpT?=
 =?utf-8?B?M0pvZDZodVdHM2NGTFZ0Ym1maDNDclRJdTNsY09CK1l5UHJzU2M1RWtSTTFt?=
 =?utf-8?B?eDh1RmtON3h0R0JhTzRRM3BEcnhxSzNnMHlTMXU2elRUV2ZaZ00ybkRZU1Zh?=
 =?utf-8?B?RitLWHNFQnNYU1NTdjh0bjF4QjlBQVF0clpES0ZCcnNiODZSOEFTSEViVEpH?=
 =?utf-8?B?U2k5OVA4amdtREFMbnI1WGNNOHNvOG1BOEczcVVsV0JFWVFxWE5UZlRWRk5k?=
 =?utf-8?B?eDJDTzZzNlRKSm4yaCs0MUpQUUZQOFRsUTQ3a0lKdjdVOGVITWVQQk1XMnlw?=
 =?utf-8?B?YWVxNzhkdmpnYmNURCtDVmJ1L0ozZXBjS2lwNHo1bFIrZlNBZktYQkxmcVZh?=
 =?utf-8?B?NVYzbVQxSHYzWnBta2tOK0NkNUNOYnNjSTk4dFFxVGxCTGxMbk9ta3NBZVg0?=
 =?utf-8?B?ZVVmU2xrWjJ3TUJ4YWVhaERLT2pjQ1BzaVBXL2k4MGtkd2xBWlZFMisvS09K?=
 =?utf-8?B?MU40ZFNJNC85N2ZHSXFzZVVObFdobWNocFpWbk5GNVVpQXUzR1NMbmkxV3ho?=
 =?utf-8?B?OG5RWGRsUmdhRm9vM0ttYVlvQTlFMTNtblZIRnkveS81MVQrYlBGWjQ0cDFX?=
 =?utf-8?B?NVhjMFhMNklhc1diNG45aTFLWld4cDI5bi8ySU5CTGMwQnFjRmRVVzhMQU9L?=
 =?utf-8?B?QU1QbytwdjREalpTd3VTZ2FncnQzV2twK1ZObUh0TEQ4TVZLdGIrbEdkck5s?=
 =?utf-8?B?dmdyMUFFeUIrNHBocWhqOHVDRW1DODJkRCtka2VyUlpEWlF1THBocjlyamRF?=
 =?utf-8?B?eGtKVTV2K2lzRHdOcTV6dGVYSUt3aDVwWXJnaHJCZ2didUNib0NyRTI5UHlK?=
 =?utf-8?B?VW9GbkpmQWMzWW9xQkRmSnl3cS9hMFNqNlY5Q0t4VktncG04YWlhUnJ1dm15?=
 =?utf-8?B?VEs5aENSRW5sUHBsQWx4ZG4ySGY1UU9USTh4Yi8xSFZvRklIcGhFSU11Sm1C?=
 =?utf-8?B?UkNncS9YNG1jMmVQbGR0Z21OVHpHV21CbnVNbHAzOUpvMFBhK0NYdXgzS2hx?=
 =?utf-8?B?b01yazhMUW11OVhSOEVoaVlRa3M3Y3VlSFFjUlZtNE9ybGdGTCtLS0pBZDUr?=
 =?utf-8?B?Vko4Z1BWVy85WXhPRUthcDFRKzdCN1gwZmwxRFhnSjlaZFFyQWZBdGp4SWF0?=
 =?utf-8?B?VzFWWFZhK0JyUmpDcHhpaFNPSzluQnRUVzZrL1VmZmFqSEdiY1BJS0R1c1VX?=
 =?utf-8?B?Vk91MlQwSC9zbmdld2RwcVF1d283T2FkY1dwcm5HcFNSMDhZdlFRaGdQUk0v?=
 =?utf-8?B?WFRpZU9WQmVrMXhUajdUOHR3QjFjOFBNSXNlNUpta3RLcmFwLytBVHBmT2Za?=
 =?utf-8?B?bkFyOS91SndMY3QwQTg0MWk4dWZlNGV1UkEvYjhqdUYxcEdVN1lzT2xrZEd0?=
 =?utf-8?B?c1ROdm1uWGJKSVpDOHo3NHNxZzBLMnJTbS9GamJyUGNLOEhZU0hzSitidzRp?=
 =?utf-8?Q?NWms=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(34020700016)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 12:22:00.2972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fb5aa5-e79b-42b0-4149-08de1b9cc13b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7511
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

CONFIG_NR_DRAM_BANKS was improperly configured for AM64x and AM62x.

Although the commit b7d70fe68b9c ("configs: am62x: fix
CONFIG_NR_DRAM_BANKS to 1") fixed the issue for AM62x, a better fix
would have been to default to the correct value based on the SoC type
instead of relying on board defconfigs to set the correct value.

Fixes: 01fa91bd5bbc ("arm: mach-k3: Set NR_DRAM_BANKS to 2")
Fixes: 55afd2d8f5af ("configs: am64x_evm_a53: Add Initial support")
Fixes: ca1d803a4740 ("configs: am64x_evm_r5: Add CONFIG_NR_DRAM_BANKS as done in a53 defconfig")
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 1b8c0b1eb968f0414107c0bf3142f744ce8364c8..9c99cf4744410601f770838aae29d3643c4f170b 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -155,6 +155,7 @@ config K3_X509_SWRV
 	  SWRV for X509 certificate used for boot images
 
 config NR_DRAM_BANKS
+	default 1 if (SOC_K3_AM625 || SOC_K3_AM642)
 	default 2
 
 config K3_REMOTEPROC_R5F

---
base-commit: c9fdb9ac4d5234953ffaaef0cfc9d4ccb03f0ce5
change-id: 20251104-fix_nr_dram_banks-7088d4826443

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

