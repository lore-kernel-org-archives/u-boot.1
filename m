Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20B7C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 09:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F19D388575;
	Tue, 23 Apr 2024 11:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="aY1BHe87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A90B2884E9; Tue, 23 Apr 2024 11:14:43 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0709.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5E8884F0
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 11:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8JUq/3WzIH1fGBg1RC4X9tlT1E/omf41Wpi8b1Ym58JtorZwpxIGCJ/aBPgTkdNA1A/XnaONKTipLD2vy33yajnhQUiXKyD5UNyAr+yNLtuD2nfrVrhIUxHVIIDbycgP9oDb8VAWN9VW0dfIEquQvmDFABANn1SFomKdkRhPxcz7gVJMCMWqdFMC2XvyEFLxgssoXaSr7WxNv3RU8ckoTI/IWvfY0Zp37c4rW0jRA3928tVfae4H/T38VrV/JQq2tkjg70SJTmZDgfyalL1fHiNbtbCmQ8fawj9kNqQYN6oftalaaGriUgzDqhwFLDl1jKfalozB7Q2LXgHNo1vzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXZ79H63MODkkeQzzD65jrfvvVE7XJSn5j3JnqtkljA=;
 b=SUew0iUZ0tEcqphp6wzQnFe5RUdPpvIINQ0N7rIlBG/Mr75anzl2bjq6C5J7hvZhY8yd9Y2lW8BMNW1jucdICKtLJxhqXaWFHUoqHnT5k5+dDRpYPqnhm3OaQyW6XVuOdrWUOEfdz1XxkYbORbZhFSJLL5PJczvdCVHCUEHhWLITds3+HKgHpbefQcWjL2EBK8V3gG/XDLJECyQVlZPHMzvCyxrHmQxKWjt0e1U7+9ZB2dl/CReHJe8zwTIhXkeBBxcLZ0XbjORTcpCmys+4FkO1a5szZZ0hOYUnPcVTMTgOEXMXJiI/5biD0J8zAYwg8aDS3NUPQcnnWJvU5YV8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXZ79H63MODkkeQzzD65jrfvvVE7XJSn5j3JnqtkljA=;
 b=aY1BHe87i5zVnFQocrNGDayZ3+/QHbXh+BShehTz3bQZn1BvkW/P6i7XP49MJ7aWJF6c6uRM9Zcj1GRYuE0WuUW+wRE0fZgL9RgYqHgBJStfWLZ98AAuSOQff3yxLZftSvVrILzFe2oNbmgxw+2fp9FVyY2RO8qnhZaWU6XdN90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DB4PR08MB8174.eurprd08.prod.outlook.com (2603:10a6:10:382::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 09:14:37 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::7f1e:4f98:9784:5e11%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 09:14:37 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: E Shattow <lucent@gmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Leo <ycliang@andestech.com>, Mario Six <mario.six@gdsys.cc>,
 Minda Chen <minda.chen@starfivetech.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Rick Chen <rick@andestech.com>,
 Scott McNutt <smcnutt@psyent.com>, Shiji Yang <yangshiji66@outlook.com>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: [PATCH v2 1/3] arch: riscv: Rename spl_soc_init() to spl_dram_init()
Date: Tue, 23 Apr 2024 11:14:27 +0200
Message-Id: <20240423091429.178653-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240423091429.178653-1-lukas.funke-oss@weidmueller.com>
References: <20240423091429.178653-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DB4PR08MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e716d0-eaa2-47fe-385d-08dc6375cc4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tUgN4Y/QA/12JuKW4IXR/RXCY5T1NIrvZpxZ+Npp5Mn90ZXev2vhEfM54z1U?=
 =?us-ascii?Q?Z1aaFU8Mg3Hj7lMKQ5A7RYsZr54WmRYmRM15O9mCaFrbhqgtF9C2Rrw32yOS?=
 =?us-ascii?Q?8UVvHN2DtwiHOeA/YMMYEnuAhgy1XmgTahBWHBVGx0amFEBUnTjpe40ppxTm?=
 =?us-ascii?Q?miAYFRUKiB0vALlA4Q4csfvTJud3wyCXeiTtYmxyhNI3PpECi1H7v2PSc92u?=
 =?us-ascii?Q?NOzw2kGFKCATkTnyP/pmnDDoM9b0BBNHFHlLGGgY8bxGLBwlBNFFd7SEjwIX?=
 =?us-ascii?Q?eCNviw2+Pfqxx7lxDYMt4ZIeN6lFW82Kej9Qv11LIYbyml4iSDVzulS/uHX7?=
 =?us-ascii?Q?YONZsVergAxYdH7NOHLdQiLZWGg+eO00SiKF3FTIL/CkWNwrXw6LrqFDcMOm?=
 =?us-ascii?Q?lNc9fXUUp9u79uNQCzduec02bMkhxWYTs0lVArK6nNW+fmY1F4MDotez8cnc?=
 =?us-ascii?Q?1Zba5IerB+AV7bMQVYmejlEvY0Q7Duj1uVBiZAYPv2XUM3lrlaRnx/lrkn4m?=
 =?us-ascii?Q?9uKIgxeWa8JlnmQaloJkQ4LMj2+Pyd5wvT/5W2W+tqODkm1B/pKBcYJ+vsX0?=
 =?us-ascii?Q?FS4OLSu6rmnhGcKQVwdNYZhhXMNEIcBZJk6JdhhGsfBujF7VMmblnAGHo9gZ?=
 =?us-ascii?Q?r8cdQBGqn1gSJOS7DWZgBm0K0WBdgIPQjp5eP7GATqbJmlicgHOgqZyYAqtw?=
 =?us-ascii?Q?TgnX7fRrrrivQ5MAHpGW2N7wMpzUT9eO/jwbDc+mX6vlZRRVYiblm2CtfQrU?=
 =?us-ascii?Q?woq2McQvwhpvK0J6C9LmOoUeKA3iopbHfPtqwAq+AkLCilCrD71Z/NdBwMvR?=
 =?us-ascii?Q?Q6uWJ/IVJ3qCOkCPEB+3dW0uEinGyP9ZfJHEeDjsRRRJIHvpJGwNRSR/RHNJ?=
 =?us-ascii?Q?nvDYtL0C8/TijFZ8cD1kh4i+YVWPvBtXKd0qEmyMYXmRbWfhoFbeYiF7RfQp?=
 =?us-ascii?Q?uVfsNXX491b4D83VIdL43c5xcz0eDJb62c2Zkr4+UM56xajopLOe+fX6hsGC?=
 =?us-ascii?Q?RMe7P85ukrGQIyBaswqOoceSQEThbBn4XgXVxwh2qOAsL1SflBipOCB1GXAc?=
 =?us-ascii?Q?rOl3MapF8H8N20GeRLsxjJuhdAfa/lHKs1MMKV0E26xoItVMgOIkLBjlTqK7?=
 =?us-ascii?Q?ogbq4fpWvQOhzROw2iaF4h7L72lJLJeiynibzSf/Eb0/KaPsApmEsuJcIvde?=
 =?us-ascii?Q?nCZF5Iftr+TBoprDfru8X8zijenld9qG9qb7nzunygPYQw2p51TuOfbMs8+l?=
 =?us-ascii?Q?eNrmhNYJFycM0+uqu56P2IvOJP1rgTm3wjHykeFNVbAX6LZPyges4wMI0UO2?=
 =?us-ascii?Q?La4g/MYsoNLkPKznJw0XLW6O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lxlU1fYyeZz4sn6fHWPv7WjwnckUvOFRpB3gNIC0eXL0QCfNhTNfAVr/6uch?=
 =?us-ascii?Q?vCInGiZDjQr8UwavGw7GRf5PMlk3ijWlTekE/YvjE4DsE46EG3BUkZ27Kecx?=
 =?us-ascii?Q?MZ6ijPcpnt6OAvFBd9IrHo8K/7ghKK4ywKznmql+28errHiJOogUe6wW8nIY?=
 =?us-ascii?Q?eyM/ol1c5tf/EDE877efuLYH3nrpSupiNF16ES1EXyI9WrgSGDkXOEaUxU0u?=
 =?us-ascii?Q?WCn/l0tx+AXdEm+wLuLaeTk+AcLpsBplAiuVL7kkMKc1tb4xO18Fpae2WzTN?=
 =?us-ascii?Q?3aXqOZ3m2fNSMs7qnMX6JC8FR3NsqG3hOqPCuGosj9m2rEazUNhkoL3MMFmL?=
 =?us-ascii?Q?2e8tHLy3fxLZB4QAO/bhd3rykt2DB5rIHqq6+lrIIBOdHyuh/CyQbaz54dnU?=
 =?us-ascii?Q?mG81skPlRugKr6wp8bF7SIOoaOiUS0oqE4UWiRhP3TS4h8rvk5yDLAo2GKtI?=
 =?us-ascii?Q?b7iprnoMlrGiW4jK3QoxFBPQY8O+tEpLuOIL5FSQM2JRQecSF7au4T6i8O2Z?=
 =?us-ascii?Q?eMV74FiYqHcUmm6/p2VwGzCuM7QA21g3Q2FDzLNd6Z+G/2j3M3xz7dlUBFwF?=
 =?us-ascii?Q?Bkanseu0e1dfn5QkM37VZozaWmL+vQG4an/TKr0t1FXAX3dyMBgPdjKZ8cPM?=
 =?us-ascii?Q?/1d792NWNTLHQ2nULF/vkPCppsCuuufUKb01mKwAd+AzOOuZHH5l3hAb6tkN?=
 =?us-ascii?Q?k3mc8whYebufVnYIkbaFuoLzATmKtSTGgKzQIt/2JXagxTqch1ubfgt/2F1x?=
 =?us-ascii?Q?P6QJJGHBYWOVUiVB0SyoPKCbmJDAzajEOakmD0hRWdue1/LWVHcq/Hb5n/yq?=
 =?us-ascii?Q?Tr5CXdFbjNbCZdQL7ntUbWzgmINSM8h+BzMWNS1ViFLgro4a6JZwoEwyjSyb?=
 =?us-ascii?Q?KZSemhEb4Vb+xqTwN57JvFE3XXFCPdOGMM/2EQAss/wE8Dqdq95f0ZxlrC5l?=
 =?us-ascii?Q?ZK/nFKRURieJ0AJSi855uhoMos0Ktvu0VQwKDkRRcQWvkR6G9Z0j+0dUtLOm?=
 =?us-ascii?Q?svelrtprwmlUe23ZI7cAh3BbgMYQ/04mW9lbJ0McrvLZrKbsiGvz/JEsf9p1?=
 =?us-ascii?Q?mQhrT+Vo88IJCqmRqofACeXGd/ck40e5sgCUDUQtNuI2kkwc9DA53ZLt9Vl9?=
 =?us-ascii?Q?1EuJVmuy1tfrzGjLMZ5xKiv5dDjzWMYa1u4TS2o8fdAbYFR0D6ytTrJatxJ4?=
 =?us-ascii?Q?KlhxKmvhCQoM4EvPuES6/EVElGoNR7TqzQQ2Jz2ua/gysM03XRS7gMWtOnHR?=
 =?us-ascii?Q?Wb3LY+MGT7t7ha0avdSuEdZ4FETf9glZBrbMuV46Q0ISoA7w1nPsEVcRfn3M?=
 =?us-ascii?Q?7B3YEtThXE/sSGSX90W7SuH/gakoDrmxJ1E0p8qcuiK9bJSZuG4acTmtuGgN?=
 =?us-ascii?Q?vSLxTnzz8QbKgjlMg9JJBNq5AFxlNu0ranw/64Cae8/5nEfRWCijJQUXOLoN?=
 =?us-ascii?Q?cSFOFp4i3QJVrcxHBRtsdz9Yjb5r2onkVSgBWgodqlSN65z85sku+A8mzCEX?=
 =?us-ascii?Q?++nUkOhWrtIeYS1U+GBdMS6hGkZY3Sx6oHK74NbR6oYq7yTx4Itwli8Nmmrg?=
 =?us-ascii?Q?2be9REs85BMwJ2OS2k2uB6lL8KWWmfHSRv6ATPCNnSCgZsYwF99k4BQErPIE?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e716d0-eaa2-47fe-385d-08dc6375cc4e
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 09:14:37.0624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2dG1Dtdrg4lz7rSWB58byPDRJ8S45k1naOkw6VGO1FE5oT4ZHDlRIiVK9yIBDSWL+MzmV/nsSZ14yXZYIeL0dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8174
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Rename spl_soc_init() to spl_dram_init() because the generic function
name does not reflect what the function is actually doing. In addition
spl_dram_init() is commonly used for dram initialization and should
be called from board_init_f().

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 arch/riscv/cpu/fu540/spl.c               | 2 +-
 arch/riscv/cpu/fu740/spl.c               | 2 +-
 arch/riscv/cpu/jh7110/spl.c              | 2 +-
 arch/riscv/include/asm/arch-fu540/spl.h  | 2 +-
 arch/riscv/include/asm/arch-fu740/spl.h  | 2 +-
 arch/riscv/include/asm/arch-jh7110/spl.h | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/cpu/fu540/spl.c b/arch/riscv/cpu/fu540/spl.c
index 45657b7909..cedb70b66a 100644
--- a/arch/riscv/cpu/fu540/spl.c
+++ b/arch/riscv/cpu/fu540/spl.c
@@ -7,7 +7,7 @@
 #include <dm.h>
 #include <log.h>
 
-int spl_soc_init(void)
+int spl_dram_init(void)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/arch/riscv/cpu/fu740/spl.c b/arch/riscv/cpu/fu740/spl.c
index c6816e9ed4..16b307f036 100644
--- a/arch/riscv/cpu/fu740/spl.c
+++ b/arch/riscv/cpu/fu740/spl.c
@@ -10,7 +10,7 @@
 
 #define CSR_U74_FEATURE_DISABLE	0x7c1
 
-int spl_soc_init(void)
+int spl_dram_init(void)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/arch/riscv/cpu/jh7110/spl.c b/arch/riscv/cpu/jh7110/spl.c
index 6bdf8b9c72..87aaf86524 100644
--- a/arch/riscv/cpu/jh7110/spl.c
+++ b/arch/riscv/cpu/jh7110/spl.c
@@ -28,7 +28,7 @@ static bool check_ddr_size(phys_size_t size)
 	}
 }
 
-int spl_soc_init(void)
+int spl_dram_init(void)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/arch/riscv/include/asm/arch-fu540/spl.h b/arch/riscv/include/asm/arch-fu540/spl.h
index 4697279f43..519e7eb210 100644
--- a/arch/riscv/include/asm/arch-fu540/spl.h
+++ b/arch/riscv/include/asm/arch-fu540/spl.h
@@ -9,6 +9,6 @@
 #ifndef _SPL_SIFIVE_H
 #define _SPL_SIFIVE_H
 
-int spl_soc_init(void);
+int spl_dram_init(void);
 
 #endif /* _SPL_SIFIVE_H */
diff --git a/arch/riscv/include/asm/arch-fu740/spl.h b/arch/riscv/include/asm/arch-fu740/spl.h
index 15ad9e7c8b..b327ac5036 100644
--- a/arch/riscv/include/asm/arch-fu740/spl.h
+++ b/arch/riscv/include/asm/arch-fu740/spl.h
@@ -9,6 +9,6 @@
 #ifndef _SPL_SIFIVE_H
 #define _SPL_SIFIVE_H
 
-int spl_soc_init(void);
+int spl_dram_init(void);
 
 #endif /* _SPL_SIFIVE_H */
diff --git a/arch/riscv/include/asm/arch-jh7110/spl.h b/arch/riscv/include/asm/arch-jh7110/spl.h
index 23ce8871b3..d73355bf35 100644
--- a/arch/riscv/include/asm/arch-jh7110/spl.h
+++ b/arch/riscv/include/asm/arch-jh7110/spl.h
@@ -7,6 +7,6 @@
 #ifndef _SPL_STARFIVE_H
 #define _SPL_STARFIVE_H
 
-int spl_soc_init(void);
+int spl_dram_init(void);
 
 #endif /* _SPL_STARFIVE_H */
-- 
2.30.2

