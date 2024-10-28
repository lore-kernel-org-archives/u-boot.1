Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05029D13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:00:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 249A588ECB;
	Mon, 28 Oct 2024 03:00:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E3E3885F4; Mon, 28 Oct 2024 02:59:13 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072f.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D7A88F71
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWEteokbIDiktEvSxJrtJJ9Fj47cHhXMxPXGkdwDmBS2mmrGwCBOFBTS2/0lm+Q3tJM1wR7BZ+5iu+TVHkJHfD774Q+BrntluhZAMTavfhssj2zv3FI+d//0uflvbPCM1aqxkCuyoMcYYBpA0eKOUs4ZbDONyaovrgpboCKErMmK1KIk55fRVKmOfHAaM/VaVNytKFZ6iTInpyLGGGgpci2LeZSjagnS7kwO8CJKC11/K2QQV2nf7YjsrbdW30dNeLu1IPGwKod4+5LY81XXo1/alGhyrMAZNuCdWY5sjrZacnEj+K7c1njVOxQa7MKp6HO8s9kgvDT3ivUsBAsfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyvJEJA6CFBRjv6UmKptULhET5MCfikhi5Rn8MSl7W4=;
 b=E7+JimvLoN0RonNuB/ZnYySYPVXpMSup6+zmiW0WfwtpwcZtBXQi2Z8S4cL7tDRTjiYZEQZr6A/HHdPOq49nMAu9phoJuaBpK9HOucA6oBx/VmXZSDNEuJdlb+gLVlM+wGNEmeQzhpoiB92ak3xTNPMplCjT0dNWgAKwQnJhqBNLKd1iJg7FvhuNc9uEhifkL4TcsX9vsb5fcRbbPg43uuGsLVK3eZlsQDcyBowXOsKdEFw7m9EPOC5nRnGWd1eKZLjrMmXyfpOUjLc+uYp5FUxH4akiBfKAIkDWCt+AH46omiNKW1lzxgMJoFXnhFdb5jtQ/hiXfFRDC0UOzvmoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:06 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:06 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 01/14] Makefile: Add OF_UPSTREAM Makefile for RISC-V
Date: Mon, 28 Oct 2024 09:58:34 +0800
Message-ID: <20241028015847.42344-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f01b648-06e4-489b-1e4a-08dcf6f41b00
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: /CJt6J89MY3KIFkabI73fp1tChjgXZ2UBFTnhp+ci0y1T7IfV/FKR33zeWBLNsMku46A5nKruUuqc8t9g2jV+rDUlrofafLV7/dYfFIjY+FOQvohFvRI5IY7+BLemzEBOx/WBhPfIliqqO5DeCKykHQqSd/Ks9sDaZK/uUW0KNqHzf+1J3mb64izrIN65oe2hlBrcfpl0YodmTgsQWEbscHgdTZ8sXgr5HKVdDp+Pljnl/tEPIG+NWz8ecL1vgkcCz/Bmwyklf6mMhRuKMD8rnIaqCSEALMktQTy6fQGgjobM8YiESN4tb+rTSHO7jhzKXaZtryR4PHOFiC/zCnf6NTJ4+FG8ijdVF3Z3icnWowJu54ifsxPn/Ud8g2Zwwk5WRaqakXCwi9vg10xwMk5HAmZ3Nwdy2B+2Vfw3dwzslDH5k+Zl+QQEqp8U8bT87T+QXb6MpLGwpClihvuvfpRzYI7IFXkGDkVJJinQ0WTWvgeuCwobkfU6pqR6AKKqPvHiPVV1hZVaAnETvpFfwGbzqC5VtcMLkk1VrZIu6omlycv8M0fv/onl3Ml4oHZ2dE+WrjBljXAY0H54issiIJHXCpSo2hSM9u+iBVmi2+9D8/4CkmGVq8STHHcX6jR3w6x
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwjIXJ6FDMwDM5CbbynEDAoQzHy50QRusEgQZ+g65p/z0iGwaFH5dl17w9Ed?=
 =?us-ascii?Q?j1J1D50186VbTsDZHJ2CrU6mvL7KVHCEl/d2005FSopU8EGsrolBFHcowjxJ?=
 =?us-ascii?Q?vnf3MkBX5hebLGxy2BWNsay8wkBIXEDeUyoPBAlyEftNIKdyVhnMgUCX4AcI?=
 =?us-ascii?Q?z1brD9gerh7jx8rQo3GJCaHRcgYb1sJ1GgGzNFGknH4KqQPcjbxytcF/2Mre?=
 =?us-ascii?Q?XYU2llnYDuXXD55exnh/I/Di/5XuCJdvfi2UBGOyfI0aXipiuUvk6GQ4T7o9?=
 =?us-ascii?Q?l+1ibW6sB8vPc2kYqbYu9SIq6V8//jucvZeZ2co5Rzq6pZ9QObOvr5V+FzWk?=
 =?us-ascii?Q?aRZx7r6SrsoOX9U4squCPh8oiYDsN1WqFk8rIdjtDh1uds4ycFd9wMyA0qID?=
 =?us-ascii?Q?agzCMrQL/hCFgTvSFjn0OzndaUtTnQ2aViePFwPbPn5vrNAS49v4is5Q59Hn?=
 =?us-ascii?Q?fDRh0rU5UMI0b9nNYukdh6H3Cjqte/wudQ2qv5f3JD6vIcR/T+mt/zScUD0b?=
 =?us-ascii?Q?wBNn90UTY5lIq7xe4Yg2XuWNfZy/7FbB2tb/N7cQkEr0Q6+V252N3DRVCnVj?=
 =?us-ascii?Q?dFxvg8Lv+NUfdttkWJZS0YDhSsaYvvIDOXvS/NE1kbedy/8dzW87/GsuqHAf?=
 =?us-ascii?Q?BMGnn0Al8z9ZqDIfmQzrw6096cr2ox5raML0J76BKXYciGhtQUMzVAGCq8P9?=
 =?us-ascii?Q?pDVQ5/D62YSGUlMV9fY7ehbJDjwHfQYOgdv9A+o+Z1wahEmKbsu2hMb0Mwo2?=
 =?us-ascii?Q?pYo7FhtL38jgeYNZcRKYeFUNo+V1HXYghk+6XHZM1DRFintMBhNJLlJh24Sj?=
 =?us-ascii?Q?7RVW+AI+cVMKbLkqviPpVB+GEUOVdC32Q1xDpaMSRzzws058/eKY3pHx1sgv?=
 =?us-ascii?Q?oqDr7xPYC4bDVwnq1bwirnhcIJXcEmTlX//KF8iKHqtWGKiWOvcqZhAOc9Dp?=
 =?us-ascii?Q?HVSN2u9NsOPxrQoavx1GIDEdNzL9Ad1iCPIOF9M4kzZG1ktLmF4XWC0lP0Lm?=
 =?us-ascii?Q?VbJOUD4MZOJnUEnz27kqK4ZSmtXHNbdb25SIqh8Cd1w3svZfgbV1mROaZZOQ?=
 =?us-ascii?Q?OPROGA2gXbapJwpL3TzDVAzw+ncO0H+/3gdKiOk+U8ev290w/7K7QmsW/Gbg?=
 =?us-ascii?Q?zpwFSi1nXs8Ibk47xnhFT4MOWhyg/7tRwVwfoMt3YLjM8ArxSkSbCOBPHSU+?=
 =?us-ascii?Q?IreNSQXIOhd2fX60DFC27TZJO5KOkNppTm5l4HQ3qdsyutHF6tWffeal1we6?=
 =?us-ascii?Q?FEe46IkqrGcyIabLogwz1fy96r2Op93H5NrJF4APAyA3u5ObgF1WGiNP9FRR?=
 =?us-ascii?Q?qewX84DAEUhY3wRD3h7e/b5k6hHzcpLevDsQmKT2eBHZZ12g8nTC+pK+rlQe?=
 =?us-ascii?Q?AOmlj8ZlCrWgaHe7cQvXEneepDx1SUAErBkdpHQXPEiYxsam9bxGhJKqmbTc?=
 =?us-ascii?Q?afkH+qgtAzzvHK3PTH4BIxmZLZNWmk2r/Y/zxpWLLFHFBAqlcl/4bf+wT3qH?=
 =?us-ascii?Q?3s8I58XGgeHrY+24tBGxokJgPh7uZBytiwIv6P5YYRuh7rGNpiZCiobVOVII?=
 =?us-ascii?Q?qRoiyWGetVkdKb/tBN6CupwzAhLpkSsSmTNS9thMOwxXaXO9uY/CGMRMesNm?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f01b648-06e4-489b-1e4a-08dcf6f41b00
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:06.6248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWW60OSzFcJJWiUP/hno7iE6dg0zGRuAoIly8z0rvY5JWtkx33DSb7RA4kKY3H29+TCKb434LhU9Dyf4zURlQQDERfl8L6Ov9obJuVLEJIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

This makes RISC-V DT buildable with OF_UPSTREAM.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 dts/upstream/src/riscv/Makefile | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 dts/upstream/src/riscv/Makefile

diff --git a/dts/upstream/src/riscv/Makefile b/dts/upstream/src/riscv/Makefile
new file mode 100644
index 0000000000..e00b3190da
--- /dev/null
+++ b/dts/upstream/src/riscv/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+include $(srctree)/scripts/Makefile.dts
+
+targets += $(dtb-y)
+
+# Add any required device tree compiler flags here
+DTC_FLAGS += -R 4 -p 0x1000
+
+PHONY += dtbs
+dtbs: $(addprefix $(obj)/, $(dtb-y))
+	@:
+
+clean-files := */*.dtb */*.dtbo
-- 
2.43.2

