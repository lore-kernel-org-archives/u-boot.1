Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1C9CA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98FD083767;
	Fri, 29 Aug 2025 16:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EF8E834E5; Fri, 29 Aug 2025 08:10:17 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3F883542
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn8J8a1bdzEvbzxTMAZjeSNSvP7L9jNqCyZGHRNvwmcR8enlE9vrjYuCerC1IM2Q8fB/2OuKPn/FoHHJ4ILv5+hQxVsBk0p19KtXDlCPxTL6G9uuHqI8IAP3fjGLI2ouyGz8eY30ZWppJEFsOtLEY/suWsudWgD/nvyjkffimO1OwwXj3MGJNIsyGV+xyltT4dcf1Iw9XIkr14L8tm4jan5YSN95rH9RHV4ruHMxXq0dI12vMNl65CcDBBujAekjIHreeoCDWPFOc5EUTdsYVeDjdnZ8FDXaHZozSvhogIPy9eYRMWzU3SPlLhHO+vlDRvkL50wqCTyCnyjIhZTm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFvZhoJXy5rQq75iDt8Mo5pkT0HaVY6d8cUQpA7wwOQ=;
 b=PVzsw+MaA99YtzUjN+OdgjOEMeSBL5vzpUw2d20WbRfzCc0azrJJCTP43hQH8Va1yU+FK2FFKTlMglEgWCBASdYv3mDkGDKnojXk6WwlAZKTx1BRDSjRwcw2ifR3r4+vLqpeRov1uTgR0GYKYkeQy2FCFB7cbFuVkEivJAPoiIZFRcoPtcrPIe/sFAfZdi9jSW/oqVnPRAdiPoXXcwGuR5hoku/lZHyh1FJZ/ZvDJgnoRJUTIkNOxFL8zeYdiE9sUEjqm5JGvmhoBrplKc17qbMRv513VR9p/NJ25oUvFD3fJwxCNoGxxohAQQJkfatSiCTSEo6HkrcJV4SgmSwm5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1258.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:10 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:10 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 04/10] eeprom: starfive: Correct get_pcb_revision_from_eeprom()
Date: Fri, 29 Aug 2025 14:09:25 +0800
Message-ID: <20250829060931.79940-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250829060931.79940-1-hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7d559b-72f3-4d07-f9ea-08dde6c2b594
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: cKH1VNq5jnNI0RKPqtCUmBG5hSjwHDPUcsuMvmijZNrj66Gnb2PAZTOpMp8PcokgcFsfsq10YbWSdBWaWRh4hLW17ll3m6CQBNw8R6pEX4A1Q8miJSbqEKa5o3F45I2z4peccJbfDxKS7H2PVNKYWHBcIlURMsZZVMTCYmGNndB54DVW9DVwPlbyKK1iYFBdLl2hMDYsFs5UKBT8sXT0uXBxPe0zYB+fTih/VRKgMIl3pO9kiWPKyIVaWsAuy3oi9cu2pVLvGbZ4PXIl02tbw7btdGiprBIvGjtO9Msb6DxpDlXs/nrLFJtLJqwSPi0JD01OPsyG+THhJhWBJBVQMD4BAHoEKY5xsa2KkWkxo96jk31U9bXE/xn8zAVw5s051LS6Scinq8glZaxOOhhvbHgOszhI0Wt3A7SzHeh5GPWhJwajWIEwdAlmfhjS4Z+oylKkpNP/K1ffvdsWWOvqz+zIe/xHgTWWbuFEfSFWrJ1aT6N1vGY2r/RJb8Y92cnuwYozGIhZ0uXfQIwL4N97CK074+RKBi5twAqAchJaCD/bxGrkVCi+G6uzosQAAYB8vdNBA2Dpwrm02ZomNVf1vOslCWi6CP+gyJnTZISaBEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JG6q59JVt4saQHgBXvaE5TVi1abz2bcNrmTMHkhuUXaw8ZCFWPT98poWvgvx?=
 =?us-ascii?Q?J0X1CeBSN0eCIYLuWO8zJotl9rV/uXwX4d6Hvw3SGB60CWu6wZU7QpWtoAIF?=
 =?us-ascii?Q?hDv3QDbSb4O4hPfSTArlR37AJrhDVyheQuqjdugiOT6ilPt8g5Z8l7fjNDO6?=
 =?us-ascii?Q?Uuy3dqMx8275c+zIk4PIvLpYluArTHvMGlz+diWbXHj9oXoef3qv/B1UvuW/?=
 =?us-ascii?Q?JrKWXbUIBU1vvvO8wCn/kLTKvYci+2mrSIsvbRE3ZSqdpXlpLvOvw7FnPnBc?=
 =?us-ascii?Q?cgvbhNbg+JrU0sE2iDEPcKg+2b/N9s8vq9zH1UCqnAwNK7eyTQQ6QmNkpRYg?=
 =?us-ascii?Q?2Qn6JM8buWdmNFF9u6BXBhhyqLgxxuf78Zwvejb+VqbYBqcU8YG4wNg8tbrr?=
 =?us-ascii?Q?2FWMJEvLtt9oiCmjoQNCrTExHhe9fIAX1ZzuscuZnoeO3yRZYW7QMCJY2RYq?=
 =?us-ascii?Q?24fjpckWkH1EzFCkGFQDLMWK1dtmXG/cmVEFs9fYwv5HlGhIWEcBd/alotjw?=
 =?us-ascii?Q?CuyK3lEyJDXmgFT+dnDKoWyu0GfrNy5L2L7FXlVS9FS+rXSSxbjvFqrCXH8s?=
 =?us-ascii?Q?JeNw5jVx9w9BqlkMerDHipU3ZT517ZcVrGaLPi5E/CkmQHSY9NZ1awsJM8b7?=
 =?us-ascii?Q?ikg70pAoT3T8yHm9iklHQwxhiW1tuo+tOayYVVI4of3De8/SdhA2/nxrmlf7?=
 =?us-ascii?Q?dSYzIOHNSoc7jqsueHzuBadSj6sXEENtiWsYJbSFQOf/O+URkrTaC6X4xyPa?=
 =?us-ascii?Q?rrXhfsc8GA4jRGlEC37KE0zBmoH2uw3c4fJvT6Wd4hjqBJ57kNPNjtSns9mM?=
 =?us-ascii?Q?JicMch7+n8pf1lVjYWovPzD8d6owO1ZN7rvoCE8+OCXaSFDdsVQr2xvQoUYT?=
 =?us-ascii?Q?pVxzT8ZwbjktUTGqKvPTHxtPtUqdn5n+QGmDoJxmg3s78Kmeu4yWGdxlA/QQ?=
 =?us-ascii?Q?QjcRVUFi34xsYdubm96xfXJA/4sS1JA2QcBwTKrL+NTeL7OrrSHdfirpyrAJ?=
 =?us-ascii?Q?UpdBsXTzDIjvuPBHIDqmy3JmwDe9wMtFwrEq6TECty92pmMxRdvQ455IxlMB?=
 =?us-ascii?Q?Y0HQma4vYYl+0rQoJnCLBK14kUMDt5CNnZyd2fshyQUGPpRCLtnotiYpUYOX?=
 =?us-ascii?Q?jtXPxsj0czGj9W55CTu1/o6Ej6AzpLkUkUt6YMdIC70EDIrQPch+Czf0V6Qc?=
 =?us-ascii?Q?a0QMYyCYu9JhQXGXE0CCxIQXE/z6jEGMFKRgRJ5Uuk5J69zvWQITKHeNna+7?=
 =?us-ascii?Q?SKiM7v84lrHLfKZbJOi2+JgsacD2onwFDQraiRTFgMXPorXlUsAaXkIKLrop?=
 =?us-ascii?Q?bkTnu3+Msgd1f/hfRZ7EU2C27TuvFVEG9zvo+urkjrqjqijvO28uo8te2uVs?=
 =?us-ascii?Q?hy4SifbTOdtEdYNiZpmabtAOKv2gU8A5RAIIPNE2nnWJhzsoBDX2QJFQDqYX?=
 =?us-ascii?Q?r/KYWqLQOQdE/Mb5ao/S8qvRL1N6jth3e4cCKPs0WVy0LUNNoS+ydSP/DPto?=
 =?us-ascii?Q?e52lH/43lDLMbDXPUxoRfbKxmhnhdUWmn0dEjFBmEPMixj1VFDgJoeScK6cm?=
 =?us-ascii?Q?eRGdUd5fJ3yjN2FdWfFwERw6tKPKZQjETlJiQgil5+SGdCRSMQQtEBsZGCaA?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7d559b-72f3-4d07-f9ea-08dde6c2b594
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:10.1930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNVu8RwBpo+6eyKgh/abF75UdsoMGyxIlNhRadcg7IJkNTZdRCtSJmT/mAaAsWlmQdr22cNpipyQqAwEqYrVXU74/rKiQS23u0B4meUGvtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1258
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

pcb_revision is stored in the pcb_revision field of ATOM4. Correct it.
Move the function description to the header file.
Remove the function calls in board/starfive/visionfive2/.

Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/include/asm/arch-jh7110/eeprom.h   |  5 +++++
 board/starfive/visionfive2/spl.c              | 18 ++++++-----------
 .../visionfive2/starfive_visionfive2.c        | 20 ++++++-------------
 .../visionfive2/visionfive2-i2c-eeprom.c      | 11 ++--------
 4 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
index 6d0a0ba0c4a..025f1d32c49 100644
--- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
+++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
@@ -9,6 +9,11 @@
 
 #include <linux/types.h>
 
+/**
+ * get_pcb_revision_from_eeprom() - get the PCB revision
+ *
+ * @return: the PCB revision or 0xFF on error.
+ */
 u8 get_pcb_revision_from_eeprom(void);
 
 /**
diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 3dfa931b655..901e7b58f36 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -126,19 +126,13 @@ int board_fit_config_name_match(const char *name)
 		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a") &&
-		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
-		switch (get_pcb_revision_from_eeprom()) {
-		case 'a':
-		case 'A':
-			return 0;
-		}
+		   (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7) ||
+		    !strncmp(get_product_id_from_eeprom(), "VF7110a", 7))) {
+		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.3b") &&
-		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
-		switch (get_pcb_revision_from_eeprom()) {
-		case 'b':
-		case 'B':
-			return 0;
-		}
+		   (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
+		    !strncmp(get_product_id_from_eeprom(), "VF7110b", 7))) {
+		return 0;
 	}
 
 	return -EINVAL;
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index bfbb11a2ee7..f38433e94ac 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -59,20 +59,12 @@ static void set_fdtfile(void)
 		fdtfile = "starfive/jh7110-milkv-mars.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
 		fdtfile = "starfive/jh7110-pine64-star64.dtb";
-	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
-		switch (get_pcb_revision_from_eeprom()) {
-		case 'a':
-		case 'A':
-			fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
-			break;
-		case 'b':
-		case 'B':
-			fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
-			break;
-		default:
-			log_err("Unknown revision\n");
-			return;
-		}
+	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7) ||
+		   !strncmp(get_product_id_from_eeprom(), "VF7110a", 7)) {
+		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
+	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
+		   !strncmp(get_product_id_from_eeprom(), "VF7110b", 7)) {
+		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
 	} else {
 		log_err("Unknown product\n");
 		return;
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 3866d07f9d4..43b8af4fc59 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -535,19 +535,12 @@ int mac_read_from_eeprom(void)
 	return 0;
 }
 
-/**
- * get_pcb_revision_from_eeprom - get the PCB revision
- *
- * 1.2A return 'A'/'a', 1.3B return 'B'/'b',other values are illegal
- */
 u8 get_pcb_revision_from_eeprom(void)
 {
-	u8 pv = 0xFF;
-
 	if (read_eeprom())
-		return pv;
+		return 0xFF;
 
-	return pbuf.eeprom.atom1.data.pstr[6];
+	return pbuf.eeprom.atom4.data.pcb_revision;
 }
 
 u8 get_ddr_size_from_eeprom(void)
-- 
2.43.2

