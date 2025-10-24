Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9AFCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67D33838CC;
	Fri, 24 Oct 2025 16:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71A148331F; Fri, 24 Oct 2025 10:59:52 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20717.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD7783710
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDmHquiTH0BrLGSQJ1qqWrimZTOi7jL5ZyM1XOoDVwGRplQ+7N9PL07CCr31PDfYrt2P6JRygy6hutsxLvDIzOWRDcZvur3g7uwUKmoChmd/pOUtmaRQBlYeF7Vm8cYN0p7J1dQx4Ctb4vtaasqdt2K3F9XzBSnoudlD0vSj6uLLP3yVOeUxXwllaZQAWa7SnPrIRwQHpghpNmGsq8Wsn1LjvVaIiOVCuK0RiYUuUCBrpSgeIy01Lf3uCAeapA1L9fJ5t7BAORXft3zeels3GHaH8E9U0hGGxflCB69Air0A3Nmtck88Y/irJxbgP/deu5udRgVgumpiPOIj7u6+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzLrMUvrbcDHrnd4F2iGuoLMQiaGxJ4/VbGtH5IH7n4=;
 b=NskI5n45KQn+wm2813K2+kP70ORCVBwSbYgVCWDgXb/quL4IsnbyexBXgbuArIsoACvT3DDkS2d/HIS/xgkqf9xh42ORJ065DmRp7jIaSJzEpfMh/jIH49tN7BgreadZ499/QdCIYmZHDRqk9lo+mIYPfjzOwPc9hKGjv1DcuVndZ7SMDQSuMNiR1fcG2jIjN8wAv///LKjHVGX9n6EH7qECN/8UEGoyVqUbfW4XZeWhimXNwniUFQlz4fykZwAZnZNESqN0jrNBucEm9YYNzHoMeS8KUXRoEuNOQ9GqptxPJrN8B3rz0AOeg4tjYk/Y9ab44IAEjt5YEPPs0hbaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Fri, 24 Oct
 2025 08:59:42 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Fri, 24 Oct 2025
 08:59:41 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 3/9] eeprom: starfive: Simplify get_ddr_size_from_eeprom()
Date: Fri, 24 Oct 2025 16:59:26 +0800
Message-ID: <20251024085932.83596-4-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251024085932.83596-1-hal.feng@starfivetech.com>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
X-MS-Office365-Filtering-Correlation-Id: c1247c10-e128-41f0-802b-08de12dbab8a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: Izyr85Kfd5YFXGjQ6Hw5oL3GNkUX2+eY+ku3BlR49RgDketK3k5DEsl0uzkgmD1z+rlK43tWjU6unDGyx1IoAUZGXNJRpreYh7BHBs+smNjTGq/chSpbaDkSqZm0bcrqrWK/hCU+oeFT4ki+nmhnVb3Zc7PbDLGSEjCSMy38jfc+Yh0M+++d8Yqgmy45VxH6PqKIqHqTbdqKQpD8J3LcSmEK/V43BUEPGYOg+41tlHkczdXqwdQjuv2bJ0UJfnMexUzkvvIGjmTTtwGZDQTgRO4+uzPQCAWE6iEk1IM0MkRfyIVTSvv/eNndHLEFoPXSbFTalWy/dX1x6wAZ6KvhZ2ZCErqSANONGYi+PBnCHDKZ6NH2cJ5p0e2XXVREEokWmfD2BBlPLLfl/pqgsiEuOdrexcwF5ebrz3HLItEVFH9NBOlgdhaEcqDlBawDkVAjUw0bcXoAXHf9kjBM+NL3b8ObRfwLhtjBXVY5W+ME5pPCAXnBdtyCfoxVYbfNG40N0gql5Lpzvj+WM/qeqa6DgHyEsHbHknsFaZ/H7Be4iVU8X8V0Cg3I+8wASm4ayunXWS5vsdWVnJDpdDS5rvuhsuOfMP5HxE6mq6GB9gaY6ak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vMueF5a6hC6g2VMRK0HLLe/lbrZKfHq1kgDkZ3DqdIgxpOCunySyswsDjnDX?=
 =?us-ascii?Q?+9Hw8v3gSpfyzOUA3z57XZMQIrj8F8mlGZSrNZIKuXXuf0IluDocZpAlg6GE?=
 =?us-ascii?Q?YJsHg5cNfBul2RV0gw/ABADw4NVOIjuOkkl12eIr/HP4z9P36NJ5FBwTVb2A?=
 =?us-ascii?Q?BsoObYomJnFkrN6QEaiaUm+lId1nM2/CMZF54TOXIKr98KX7im/r/VwKs+eh?=
 =?us-ascii?Q?b+yrtyTj6FGiZW4vQOTCtpZCm4zF08RXZhFCOsZNpz88C4kUGys54/kROvSE?=
 =?us-ascii?Q?MiezuDWatfygKQ0wPG2/b+driBemVG8kEBayOQcremMPpBrdXbZGbuqqeCNX?=
 =?us-ascii?Q?D+AhVzM4FJv9SFM/lfJVS4PRc3JVvYcif1D5ssFGjXXIEN3CIn3GiAEj1v4B?=
 =?us-ascii?Q?64ToKeIFKGU+bkUb9invFmvaxFeZBv3Buwl1gOsT+QGxr0098VBc9Y/Ld+cN?=
 =?us-ascii?Q?hlUKdIQiIQ6YxUrqSDKBIuMRFx8WkVA3QZjeXPVivNvR361nd1MaTWTrZCkb?=
 =?us-ascii?Q?ebavxTd0RY8jHMXOVroP4Zr71TYP0YSzJdpTeX3KXYHS+YNKBQueTiEp1OHT?=
 =?us-ascii?Q?jjrRajf9nTZ6VA4q9ZR9UCq8SJURSg2tTQ/6N72sSNlmlPveXq4HNFvT0BKz?=
 =?us-ascii?Q?Jkz3K5u+paOOblYVFEms4wFP0nFJpiQSBURK9Dv7jAlgxpuNFdobyUixkZFK?=
 =?us-ascii?Q?3hKRS7ECqIkvpFqc+crQ9zSG43g4l6IVCiN8POK/sDtrUUg0HRe02P93zL1+?=
 =?us-ascii?Q?VrjW5VBgbKD/YWdqB2iGIzJf4J+CstV1c/BdlyCth/Wwu26CgGltswZM86i9?=
 =?us-ascii?Q?jRvb7GZ1jofUXive0VS4WVvN/prE5wBy6fm06K6Oi/BMQirv5ivp+lUHM6id?=
 =?us-ascii?Q?uOYL65pIKaWkyXKkJtS9oSkaHOWNcUuTKZYrINSH2TaVBK9Ke/acFNPCvcuG?=
 =?us-ascii?Q?9mPU0Pxj+9j+EMJMPX7ZSjl/UErq6iW/GxuotrczdAEGdIxgQ3qB9F1wBogt?=
 =?us-ascii?Q?vNWlIkhR6tuSe5SghSBEqrhHKCAPHs5Wi9SVjWhla4gqgJvidpt0cMwv1ZFA?=
 =?us-ascii?Q?NFkpERT+u9as0IpxasxmuC0kz5PB+mDQy/OAiKy8bcNVyxrUtm2K1bEuU4H4?=
 =?us-ascii?Q?kD5tHU+1vBEBFEOIJFPLXYgKkhoAiIfTVGhRxTttlyzSFVaLWbztFk0duwN0?=
 =?us-ascii?Q?BnLrWlcaZjo9vwfTSlm9khI6iPrBIBIc8r+eWb2zy17ilZJQUHrIGo4EYgny?=
 =?us-ascii?Q?8TUmVb6jgtOrgoFVBt1w9GNb7b5XJpFmimWBWXv2vZ6PNyysSa9lY/zpVdJ5?=
 =?us-ascii?Q?+VV4AcTWuZGXU5VDY3WRETwBrfAEvtj4kdBaesHv/xs7BDdDKTzrLnqt3v3O?=
 =?us-ascii?Q?BNJojWCNTN4bkyLnfAeCB+gvdL318OihCQDM8Mo6e8kVIfhueWx2YscoB7HJ?=
 =?us-ascii?Q?6dtVNvf31qybFLUAiZq6to2BSKmcceeEJMi/hDBvAqPJkf+6IGD459+qWcrQ?=
 =?us-ascii?Q?+GkIHJfFkvkia0KYM9uHW9KEEXArYcQXiL6cZEDCDkGd14+LRR0CVsMN67Dn?=
 =?us-ascii?Q?2OW3ApA3ePjoSBM9Yv2H9DbVBF1ukWeXUw6yD6TK46esker8TcgWFDp1B58f?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1247c10-e128-41f0-802b-08de12dbab8a
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:41.9381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJHkDxnB7o1PJ91uhVcuL0fPDisLdEC2/vmqx6XS8R6F9O1noUm4EY0Cul64tCBhPcSidrSAMxAwZQZUxy+06zFqwVicpO40AsVGJV8wsPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

Directly return the DDR size instead of the field of 'DxxxExxx'.
Move the function description to the header file.
Return 0 instead of 0xFF if read_eeprom() fails.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/spl.c                     |  2 +-
 arch/riscv/include/asm/arch-jh7110/eeprom.h     |  8 +++++++-
 .../visionfive2/visionfive2-i2c-eeprom.c        | 17 +++--------------
 3 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
index 87aaf865246..3aece7d995b 100644
--- a/arch/riscv/cpu/jh7110/spl.c
+++ b/arch/riscv/cpu/jh7110/spl.c
@@ -41,7 +41,7 @@ int spl_dram_init(void)
 	/* Read the definition of the DDR size from eeprom, and if not,
 	 * use the definition in DT
 	 */
-	size = (get_ddr_size_from_eeprom() >> 16) & 0xFF;
+	size = get_ddr_size_from_eeprom();
 	if (check_ddr_size(size))
 		gd->ram_size = size << 30;
 
diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
index 45ad2a5f7bc..1ae9f2b840a 100644
--- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
+++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
@@ -10,7 +10,13 @@
 #include <linux/types.h>
 
 u8 get_pcb_revision_from_eeprom(void);
-u32 get_ddr_size_from_eeprom(void);
+
+/**
+ * get_ddr_size_from_eeprom() - read DDR size from EEPROM
+ *
+ * @return: size in GiB or 0 on error.
+ */
+u8 get_ddr_size_from_eeprom(void);
 
 /**
  * get_mmc_size_from_eeprom() - read eMMC size from EEPROM
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 17a44020bcf..ca5039ee433 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -550,23 +550,12 @@ u8 get_pcb_revision_from_eeprom(void)
 	return pbuf.eeprom.atom1.data.pstr[6];
 }
 
-/**
- * get_ddr_size_from_eeprom - get the DDR size
- * pstr:  VF7110A1-2228-D008E000-00000001
- * VF7110A1/VF7110B1 : VisionFive JH7110A /VisionFive JH7110B
- * D008: 8GB LPDDR4
- * E000: No emmc device, ECxx: include emmc device, xx: Capacity size[GB]
- * return: the field of 'D008E000'
- */
-
-u32 get_ddr_size_from_eeprom(void)
+u8 get_ddr_size_from_eeprom(void)
 {
-	u32 pv = 0xFFFFFFFF;
-
 	if (read_eeprom())
-		return pv;
+		return 0;
 
-	return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
+	return (hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL) >> 16) & 0xFF;
 }
 
 u32 get_mmc_size_from_eeprom(void)
-- 
2.43.2

