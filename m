Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86247CCFA0D
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C03583AB4;
	Wed,  5 Nov 2025 17:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h8MGw8Lv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 917FB83AB7; Wed,  5 Nov 2025 17:22:18 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E4183AA4
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUj6KdE0etmdXBcBMYlp8VhHjHLRSAMKXnAn2UbKTFIpH+5Z4Qxu9AdinJe6hgHgi05Q/JBfmgKYcSbMmLPvtGaeev+I9ozWP2izEYjYlY3fsPPNSER1sDZNMNF04yti7brUpFzjt5RXil/I0PDjef/b2dw9wB4Co7Q7GiV/TtLDG9Gs5u6Qu5iyBKKlsqVWTwMlPP7yPyqPHxZVw2lDVOfAQ9vbRZRcJccc6uCPJEaxjR+n1SJFEujOHoGQ1VPzdoTk+KbmXM4JPeWfJ76ahSQUPiXM+RyaX1GojXtlPqPcCwWOEi3ZBn9tOV+ZV9BGhrKZlUKyHUuWxDZtGWHUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMuodGt1zsUHcmmSEBp/TyK5Ttx+2AOhzTtev1/+EeE=;
 b=FdNZAWpzRJ+56v/TjnoGl3iiKCCgbfU4BAtXA1pOU5c/XAH7Zdx53Tz07uTe7SU/cjKqnLIyX8O2vw2bCQr7cshKI9QYjqnAyE0bBZJVLEwRgguvrkxt1gKRcmAMakXYjdF3+t48YnJ9J5xZKgoq2OMLeWJRfDhTVdW9ZjaGeF33/A/b1esHou1Axd5IFWvgvb0+gBd6E0ki9f9osjtwNXKdjth5C6A1oeSrUHnSqpMBbKaYB/5t6LM6yYrBpzxIiDy69xevNTiEOauCSrzDd9a9JkzXV2BO6RGB5kQ7toKyDTgJvVAPzpv1vU4kCxS4GIsxZgK15VoeAGF17jVFNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=dh-electronics.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMuodGt1zsUHcmmSEBp/TyK5Ttx+2AOhzTtev1/+EeE=;
 b=h8MGw8Lv8azeClFqYlcaglcxRv7hT7z9ExZRf8QdVPORQsuSAkC5yqVFn/dkjrqwYazdQyIb0zztMy7uiswM7wGtj+AoF3iRRHkXjD3GOJmtq/MlAIWr8ODjcbBqvVDBI7F5F38oKBBYSB7dwtbC0LEhNhXKFYi0Rl88VPh0iHw=
Received: from BYAPR11CA0069.namprd11.prod.outlook.com (2603:10b6:a03:80::46)
 by BY5PR10MB4322.namprd10.prod.outlook.com (2603:10b6:a03:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 16:22:12 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::af) by BYAPR11CA0069.outlook.office365.com
 (2603:10b6:a03:80::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 16:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:22:09 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:22:02 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 10:22:02 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 10:22:02 -0600
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5GM12C3949927;
 Wed, 5 Nov 2025 10:22:01 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 5 Nov 2025 21:51:46 +0530
Subject: [PATCH v2] configs: am65x_usbdfu: add
 SPL_USE_TINY_PRINTF_POINTER_SUPPORT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251105-am65_dfu_fix-v2-1-ccada89d966d@ti.com>
X-B4-Tracking: v=1; b=H4sIAJl5C2kC/3WMQQrCMBAAv1L2bCQbmkI9+Q8pJW43dg9tJKlBK
 fm7sXePMzCzQ+IonODS7BA5S5KwVjCnBmh264OVTJXBaGMRtVVu6ew4+dfo5a0Q25aZdHfHHmr
 yjFz1sbsNlWdJW4if457xZ/+MMipUjsj0iDgR+esmZwoLDKWULw+CSvalAAAA
X-Change-ID: 20251105-am65_dfu_fix-1144eec06b19
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Andrew Davis <afd@ti.com>, Judith Mendez
 <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Vignesh R
 <vigneshr@ti.com>, Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762359720; l=1838;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=BedG8GNyhe8LH2mSgzpupNGpFTs/DBoSMYtlqxnN59c=;
 b=W3AhU58Jp8bRd8udYF+lLjelKqNYnH8GJy9I1XwmVTI7CC/iTqPlT8+vArg+PSF0D6Z52CCBz
 G55T/pP5rcNCwCOvmg6gHprTPNboGUVCRpRX/toceWjjT8d9d8ruNga
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|BY5PR10MB4322:EE_
X-MS-Office365-Filtering-Correlation-Id: b859a074-ded7-4087-8027-08de1c8777fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|34020700016|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUtpSFdseVd1WEM1b1hsRm5hOTY4b0pDN0hTbDNRSFFzYlY4Vkt4V05waGNW?=
 =?utf-8?B?SEpxY00vdWkwNWZEN2NBYWJuL0VzZzJ2QTVKbkl2bDR5K1RnYVc1cGFPNGh2?=
 =?utf-8?B?TXpPeVdkaWg0c2JRNUJEUWZSR1NDV0Q5b0dDV2RuSDdxaHBwL0xGVXdreFNY?=
 =?utf-8?B?eTVzcnFCNzNUSDVFdU5nb0dRN2Y1Z3BUNEhHL3UzUmlYMEhJVVdWU3NWaHkx?=
 =?utf-8?B?cTlISWpSay9ETjlWUUdjUXEzRmlRUDhyNkhwNGNGcXp1cml3RjFzYlF5dXI2?=
 =?utf-8?B?TWxuc3JBRHNrQitHaFB4UytuTTREN0lnZ1R4c1dWQkl0elJZck5ITi9NdHhq?=
 =?utf-8?B?eGt1MzlyQnNsUElHL3YxdDVSR3JZS0JQbjdNdUZ0NXNLblhKaGROQkY0T3lt?=
 =?utf-8?B?Qndjeno3SWlXYjJhVGlZREFQR1NCMXJOc1FwM0lILzhmbHpLaFdjZ0l5eks3?=
 =?utf-8?B?N1QwRTR0Rkh5QmVSMGplaDR5UDJuSEJaQ2h6RUZzSGRQWUcrTER6V0ZMRXBO?=
 =?utf-8?B?RHBJT0syczBrWXNsQTZzVlhURVNQd2EwRDg0Y2JkaXkyOXYvQ0xGdmdCOWtP?=
 =?utf-8?B?US9pQmRwbzM2MzJybUo1aDVLU3dtSXFBRUFiM01rTmxuNUVLS0xHa3JRTVI4?=
 =?utf-8?B?TWtKcC9BbHoxK0l5aktIeEZXWnRIU09qa01aaHRrc093OFlBQldna2xJdjI1?=
 =?utf-8?B?UDlIVUJmTlFSNE9UUEtxWkhLV0dBM0tLaDBTb0EvTkh3VDRzalRRVEpPMzE5?=
 =?utf-8?B?MmdvRVVHU1VxZXA5bU9DeHQxUEtLZzVXVGZqSVpCZVZCNVdnTWd5VnUvQVN1?=
 =?utf-8?B?cU12aUdqbzFDQVo4ZnZVWi9nejZxMHl2TmpzZlpYTTl3cmtXcTJNMjZzMlp0?=
 =?utf-8?B?VURDM2dseVV4MVZrTXhCTW1OcDJUYVg3RU5HZzZyOEtTTjMwSE1hU1RkNWgy?=
 =?utf-8?B?Vi9ibWpIUThEbzh2aVlhU1AydzRvUGhWcDk2Wk9iV1JxRXYxMDlheCtvMGNY?=
 =?utf-8?B?NmtiSUcxbkpVenhraEc0Wk8vQVlmcE5senNTUlRnOVBkYjdKVEdwNXAvQ2lw?=
 =?utf-8?B?cGdMTFBjMzZZaThMNHBGbVBzT0ZhaHA4MjJRTHdrZTluc1M5S3VMS2ZOOXg3?=
 =?utf-8?B?aFBXTmNvQlBPcThNZFBBSWZXcUpKL1RhZ2N6WXNFWk14RlBXbkR3SW95UnhB?=
 =?utf-8?B?Q2xsc2gvWmE1ZFVPMW1wU1VXQ0lNZ0E1R044OG5RVTBES2Y4Y3Y1S3NidDky?=
 =?utf-8?B?Unc3NWh6Q0dVZ0s2N1pWaW9tTi9nMU1YcnFCREVISktyN2o0M1lPMFBPSEc2?=
 =?utf-8?B?dE9sZm40V1ZSQThJYjVvZHU0ajBqNnA0dUFRTTZUdGlXL2MzSEFnY2h1TTh3?=
 =?utf-8?B?Qzh6dXV2MGJMVzNqbXptUkZTVkwxY0VqNW9VNzN1NDNkV2E0SUY3SGZJRTZq?=
 =?utf-8?B?V2RlL25qYmtMWnRLdUZwK21YdXh3TWNrSVBkd1pVRHUwaTAzSkRXWm1zdExY?=
 =?utf-8?B?NzNRd0MrSlhyYU1wc2hKRmh1L3FjdytsRzBySmducTM3SDY4WnFJOHY5OFFS?=
 =?utf-8?B?QkR1c0Y5ZEdLbGptTlE0dHFVdVlBNGI5WkxoUXppbnRVSkhkVGFiZExPdHpu?=
 =?utf-8?B?TlNsUzB6aXdUUy9pQjNFdVVVSTh5VzlkMU5JbTV3Wng1YUtaQVR5ZlEyNnA3?=
 =?utf-8?B?dFBSVXgwM0tHVHp2Zkt0SHBHMGNPS1pxVWVrdGhIaXlpeE43YldjYXk0ZXQ2?=
 =?utf-8?B?Yk5mcmxQMlhTVUhBTCtjTEdFaFFMRDgzaVYxN2JsSFU2SmovdlUxMUxEYlFr?=
 =?utf-8?B?VWFtcG1kOXdGMVhFRG1pTGVYMnNiYWdCVTh5U3ZZbWhNV3JPY3lHUHd0bHdz?=
 =?utf-8?B?eFFXdkdxOHpyaTR0cVJyc0kwaHZMV3d5bnNYNVMxaHI3RC8rYklsQTVVYkxi?=
 =?utf-8?B?M2JmbUlVYUFVRGtmckRHVG9HZXFQQTJoZmtlNHoyaFRLM0g2eVVZZmM3Vzl2?=
 =?utf-8?B?WlE5azNIVTlZdHNheUxMWitMQkkwMkwyNW1Zc3A1VzgxbUZCOXNYT2t5cTdu?=
 =?utf-8?B?WHpEWFl4RGJaOTNaOWtyMk1GSXdvOGdrTzZJajAvNjRZanI1K1p5MEczQkJ2?=
 =?utf-8?Q?bxww=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(34020700016)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:22:09.0881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b859a074-ded7-4087-8027-08de1c8777fa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4322
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

Since the commit 1e24e84db41a ("tiny-printf: Handle formatting of %p
with an extra Kconfig"), SPL_USE_TINY_PRINTF_POINTER_SUPPORT has been
made mandatory in order to use %p which would earlier have defaulted to
a 'long' print.

Without this config symbol, k3_sysfw_dfu_download fails to set the
correct value for the DFU string with:

 sprintf(dfu_str, "sysfw.itb ram 0x%p 0x%x", addr,
   CONFIG_K3_SYSFW_IMAGE_SIZE_MAX);

The value we get "sysfw.itb ram 0x? 0x41c29d40" causes a boot failure.

Therefore this patch sets SPL_USE_TINY_PRINTF_POINTER_SUPPORT for the
usbdfu defconfig.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Not sure if a 'Fixes' tag is appropriate here since the commit
1e24e84db41a ("tiny-printf: Handle formatting of %p with an extra
Kconfig") did cause a regression though I think the problem existed with
the usage of "%p" with TINY_PRINTF set to begin with.
---
Changes in v2:
- Remove unrelated changes
- Link to v1: https://lore.kernel.org/r/20251105-am65_dfu_fix-v1-1-acc29111dccf@ti.com
---
 configs/am65x_evm_r5_usbdfu_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index f9161f1fe111ff97f7aa79f10b21c3b0ab1dad32..add03dce002b2abd913770cd836d2cd8c852ed5e 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x57000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=y
 CONFIG_SOC_K3_AM654=y
 CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_AM654_R5_EVM=y

---
base-commit: 1c250e444ad3b15315ee8b0fcb3fc3acc26449e2
change-id: 20251105-am65_dfu_fix-1144eec06b19

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

