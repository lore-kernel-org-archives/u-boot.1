Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF93CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5232B83741;
	Fri, 29 Aug 2025 16:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60536834AD; Fri, 29 Aug 2025 08:10:17 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB81483531
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mdp85ZTRpe+Ofo7O4iJA5XEbeksUeLFFWIELMLPRjaIXO7LTJgRYMInYyp8XxkjRuw9Q7apT9D+SIRrFhfhaMtjpcf4VddXVZZi87CYfZTzDJYhSy149M1aaqCIE1+oHjI57/fK1nT0Ich1CnoZUWs8K7J7M7sA7tS4OsWf364b74/YPROgFqC9Uq1UNifzSWm2nPC2mp15renuAJpimwRoBNyn0oWH4siNcjjQ9lKkhWIJ29T/S+wxG8z0bI9F1HiBVzEK5W1pICJXe6l/JUTy2yi9FOnLpK4DUdgl0MkjBxP1Tp979bioF/Orzlh1lT2RQvcxEZYPNNr+HG01wFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t48CCRVAmEFH6MGmpmG8ZpfnlqwdMRer13ybZKbuoac=;
 b=gOT1SNS3LjqdS+zT1mNZiPcgp2MgxQgdkxpCu+bdtQkRIO1Oy6niQHNQwJS2dBEBNoZxMiJx2vI4/a3XpNv6VRuY2ZSXB4bwpi1soqYAlfXYr3D6Su0dF1Vn5tI3dY3766XtKz2pMT4byJUFfF5YK/2pvqgQHMZ9uRKXKJ6btL1NIY76WfHOzXlumEXCFI5X1M8vWSoUX6viWiirCqIJhBSmzY8prgMRYZ1INP4KT0YGqmpMoP6C05MbsmDtKy3EHcUbv2BP79crswXtGGKND+A9c1HXD5uYuH4cfn2FVsMZjN+IS+SB6dZCOF90NVs3a26kRFUZsy+gjCSqnztGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1258.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:09 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:09 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 03/10] eeprom: starfive: Simplify get_ddr_size_from_eeprom()
Date: Fri, 29 Aug 2025 14:09:24 +0800
Message-ID: <20250829060931.79940-4-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2d11a34-e4a6-49f1-98fc-08dde6c2b514
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: xwMHoBqKya5SO8ZvHqEyV6w2g5jGtJr2kAd8j0Tney+OooaJ6eVqR4LKeYd2mj+LDFh2rsovec/dORM6O+ApC67uzQFRChRXkH9HgBVDi7IWMYR78BZjoEoKn//vJW++2M36zoxxEVh16rV4WBs8iLkTGjMnNODO/uwph9tUYJuBpDySwzbGXUDmAEwGf42aaJZCmfprUbOz39YfCLveWSCuwqdyCqXvWQR1NAtluuFmQc0y4EhRqwe61s1M0M+34bIiXalEydvV8DoLCzkvwzl7cVKkjdgzBOxn+ytLIkbBlmpSpqHrmG/MZvFiPzSH8CJ5BMuSfKpCz4fw2eG33NPp9z0CB8dQWimQUtuvrLwzKLsiNBbtNVieM8u9Q0AdB+gcZej1MXNbY66s4bdthaDOCagOXeE+Nz7YMqESTovlbc0S8FxJ7U6actToajmR8vJULgXvSIFqmdrkesBkhj+c7O/MQuBDyC2MeJXpL74XLMtsa25tlQ1grdA52qvylVZm0ZoOh5lzpOz2yRuGqKepfQNlXAtrtXjZvpw9LijOeywWYwY4+h8/lkm1YS5RbVTtOkisQoP32KRAIRnpQe8eBENbNkLd2M4OyY882/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ajhmX/0V07J2C5a3y9wXeNA2zXlOtQWhopyhlF4HnAO2Dq6p07SI3qZNS35d?=
 =?us-ascii?Q?wTXxUhRsRu8n8LhzOBxkXEgJSH3GRUKbB1iq76P4CjbRa81K825eLtWWTm8v?=
 =?us-ascii?Q?kqFU5qnv2xOtYtkg0eMMm9yBkO2V0h+4fweJBBuUi/JNwhNn2V8jvMLLz7R0?=
 =?us-ascii?Q?I5FNc/Jp+VVnWyGWk6pKzsAgUCHZJdi0uQ/bf1snRLm4CY0H2BK14/6meuvp?=
 =?us-ascii?Q?zsLD52RYvszqNfHD4bQcwQ7TIm3IsnIg2Hg4TTtGWNDKEblsAJXK8j7B2j4v?=
 =?us-ascii?Q?xYTmd5F6iF5FYfFtQkGew7fJh1XtVSFj0B0ETBNFbBKXbtxWxnEw9i8JHG7s?=
 =?us-ascii?Q?mT9mL+3ALpNmHeQCmakpsPKg1K97ILTEtlwkSD4s9jbi4OlqPk01hsuSO6Mf?=
 =?us-ascii?Q?yzlg66KjQErWfUrmPyITgpmBEfFX9syEECkc+44K0/rYC5RUnM70p8TBmBiC?=
 =?us-ascii?Q?ZErCiPLHcNFAdC8wZp4U3u5bdrz41IEVwDn6mEOXLCj6diCuOQqhnWo+aPV9?=
 =?us-ascii?Q?9khOCHYCxEpvtUPYNx5axS7QnVcd/VhiTbwgTDGgwVL7ONsCiezNiwwjwhYM?=
 =?us-ascii?Q?x+Qxu38lK4mKmK7l7LPlXe03DlRHKb4u5LJKb+/XrCKEKWk4L40uIMlY6T+t?=
 =?us-ascii?Q?WVQ+VS5jAGgL6jc3sRCvkjFRaLFLf6UEZhsMDDOr5Q2T8KtSB3l8exbT8fBJ?=
 =?us-ascii?Q?Z9dpYmkr4I5msFvbcqU7MwDRarC7Do8di1ozkVpQc76zO+FjzejZ1m+Hf0AL?=
 =?us-ascii?Q?Je+bDI6wP2EhBeblkZHt3sQb5xIvvsPeJZ3QYw/dTal9oOOwdKtEfKYn2bnv?=
 =?us-ascii?Q?1WkMuOtArEPLlpolk+BjS/rRIBKnnRM1LISIkA3ss0r6jnWMEZ6YkDsKQ0xM?=
 =?us-ascii?Q?XJEQCgsGXEeaOlanC+16ZPeh+eIkHo6WaR7/2faxlg8Bd8iOiXgZGFenFFam?=
 =?us-ascii?Q?OizPCIAf9cin5BwxA63SIVYOjBtka6XSSEl7GsJwT3pv20nO2Ew63yICAU9M?=
 =?us-ascii?Q?IjbhcGeQoIY81FBZfdGYMSwl1KAAb7r9xxgXZc8c4VsdGVBzgiSufMRtxZrX?=
 =?us-ascii?Q?d4RU087vqOhW6GiNFquJwIg3/NSMVkHz/UM2St4bvdJco4BzRYtm0TCY56oZ?=
 =?us-ascii?Q?mcWwMHS/TVFgNDRTchL9K3pdQIMbn1i09crpgWCTk5sOUcDTe2wmuMoVPA9k?=
 =?us-ascii?Q?KVXvqV+yzZ13qRvolJsBrerZiVA5wiNrOw5BXLDqvhp1KQU9RARAWBZYIEJU?=
 =?us-ascii?Q?onGdU4qHQ9n70xumKmjuGhR9+/zfeJ//LHIQkCAiF6y6GHL0Uk5FPf+GwhBc?=
 =?us-ascii?Q?0vnZdV3Z5/qjKWt9GZZ4AQguO0o41YT+vTHy4rJQGxaOs00zg1g5iGev44wZ?=
 =?us-ascii?Q?JzZK5pgSqg3LKaLj/p9rvFsj/CX0BkVjJUbekb+yvD9MMnOHxxs90zlVA9fO?=
 =?us-ascii?Q?p3XMcWtMuvcoTVwM7p4l/Ik4djiBY1xlO+EanVpYZyc3qAMP8ckr97JaEMs5?=
 =?us-ascii?Q?yPpd41i2CDFliryVWOz9+zyK73fIu9coelAwKmJCSqB9xpQseZXfv54Nn33b?=
 =?us-ascii?Q?YrLNVLLYRq+te5AYEAmZMDF4WdtNUc/qRKnaeKA7jAIHe+1xSycJ/bZIPwj+?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d11a34-e4a6-49f1-98fc-08dde6c2b514
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:09.3505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNSkwBeqyeQjUmB1azlz57ZyuOWsUK70azw5rzBq5DuDIm0LQu60kVubYMs2PxCaLV0wTTTn7+bKYwLHIrw/AsoKbNAFVcyYJbJ6LD526T8=
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

Directly return the DDR size instead of the field of 'DxxxExxx'.
Move the function description to the header file.

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
index 45ad2a5f7bc..6d0a0ba0c4a 100644
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
+ * @return: size in GiB or 0xFF on error.
+ */
+u8 get_ddr_size_from_eeprom(void);
 
 /**
  * get_mmc_size_from_eeprom() - read eMMC size from EEPROM
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 17a44020bcf..3866d07f9d4 100644
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
+		return 0xFF;
 
-	return hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL);
+	return (hextoul(&pbuf.eeprom.atom1.data.pstr[14], NULL) >> 16) & 0xFF;
 }
 
 u32 get_mmc_size_from_eeprom(void)
-- 
2.43.2

