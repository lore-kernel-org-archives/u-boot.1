Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37903CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3EF5836AC;
	Fri, 24 Oct 2025 16:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22FDB8362A; Fri, 24 Oct 2025 10:59:50 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A3B83677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdlvzSbZdBWJGr5HKnSy0foomOtvWkviHOLNoJ6xCLtkF3VyxH0iyMnSyQ5LgyMxvWOjgKp/RcQLveyEXxmj3Ef0++iBxkz5g6XexBdYfgc9RQpNQrq9Ld78M3A1EJYxfpKHcWFo+d5L6BtE6xylzX3Hit75yfEdLk53SrlLXLSngGdJBJ+8WvW0KqxJwQX3g5OSzJFeaYVca22BgfqlguOmgdDnRNHhRyo5N9EwF/TuwVR6RcPZTOKcN1fqYD7MDjPXTSs3akea+PL87i8uCbKCHUVc9Sq8LJ3UUfKrxRYUyrX7yXprbbsJu83S1+8N4ZpTChPQI8cTMFMJhzrMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfzlfADge80ylHJRTPlQ6bv3siODunt+BdllSprSBZw=;
 b=RGIgHO5KF8yErlcBSAak5c1kQuAU+zesI7DzZXtdPaXLwmaXbMFTm1VhtcYs/9QYAPFT88d5LnnIt2xSv7lVptNbbdLoMloxXMEjAxk7IblgApUNW+KlG/6+u7y21B9ToW+iDp7I2Oz66X7i7kEPi3c2lpsfCXb/W0rT3Q/KNbW9RjJCz2g0yitEuDZDJ4FyGL6W4+vrr5h8xGZiaZfcqMFvuzI6GbrzP/+P1rFoxSZE7xHWZhr5U+DrPCT3TkDJMSBd2clUGi/0gHiEIRDtAscwH55tkzv9B+gTd8ZcLNn95jTRYYv3LbO5k06Pu4pvFh3cGm67mJ+87KWl4xfXnQ==
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
 08:59:42 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 4/9] eeprom: starfive: Correct
 get_pcb_revision_from_eeprom()
Date: Fri, 24 Oct 2025 16:59:27 +0800
Message-ID: <20251024085932.83596-5-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46522b1a-4e95-4869-4b00-08de12dbac04
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: lYo8Oo5PS6ZWqexND7vnh6FKuBdyVKkdZ1fDvmOYcUlMrXj2WnLL/VY9X5HpsOT0+W5Mog1wzI2DysS55EdNKaPqSD9VqUQ6ijVfxatho+7szGHELUs2QSyMe86W7qV3btBkxAE+bhFqMiya0WL81pGH4gNWwpsWRGjzCyKSwB5FtVq3xMrNlyLQSFVMZdDK5dBO8hmM89u/+CF37mWswrLog3+s/2FMCkK1ciVs6RAfQcphu4x17QGFUiKzTax6DgS8ZJ3Jw2uBDrLr2UidH4ujUkpD27zakhA93sBsJkbqmkFM2L1uIN1ATV7oIAs18xwqYQw58NQkp2TWcqmOJJ+ff1RFY/s4UT9zE90OFhPgca9lxoaRSB3mLfC57HEGVvN6X8LxuX5r9dKfMOcfhk3GkFQp0gpNm59w9eF18mAdtoHDV/ifr3/LFC3FN5ZFVdawNg/ItSLYqArbqTtT5q8huRDusiy9CgknYr4vHnvujrpGdlJYpcAGSpB98eP/+Lh+n4JzrBO+gE3m0+3A3DmbBI29PaOZ/on4tVlTnDvZkuy9weJYAC2N1hAUYAiB5TxznNg3se0DClToF7TZujGXpGxULgSKxaNM7h6nP/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w9a6Co9UoX1IC8bLC3DwsCXi/UXCK/I3EHtAPnz+NpClQCLeyLVr08DVOsGv?=
 =?us-ascii?Q?ipSHgDBwDCZJY/x1O/RshDw5ylAmIDvV/wMoTttl3GcqrWNjm+V1Ijg6+J9y?=
 =?us-ascii?Q?ydpemdmUEBsloIoW5gUlF0ciazw2Rc6A4U33I/yCjN0f1jU0wssipj4KTSDJ?=
 =?us-ascii?Q?X0ENJZud6xzZY4hcQaS9PqbLADZ/vogCIKHJO5zOm69JLwuoFC/97zYC54n6?=
 =?us-ascii?Q?SZ/tLLa3B1KfWqm91bsl/HqvU0hD3Aj75+7UFZgENQP4kfN2TVcpCwtyCyy2?=
 =?us-ascii?Q?VTkhFJUh6tKe4ycnSrmDTU1XdBwJfQKujNxDOguNQfg3/c0xKe0IDJA5h1ua?=
 =?us-ascii?Q?ENYQapXJRLr1AAgjFvBWpA1UHU9XhlAZikM/Zpifd1kNhcjPp9d8ugmeLFFU?=
 =?us-ascii?Q?SAHYYlmSbcprQuTLQxiHYa11JQgXrgJZsFEc9/ErHSzVmKcu65uc4Ap8fnRp?=
 =?us-ascii?Q?mStUw39iAWP6HnB+pNJRp5gBFTC0h9Slwc6AUFPaphTXfVYS5/XoefkRoh9q?=
 =?us-ascii?Q?ZW49D7Hc8CS66gn8Z1wI7rlzUvsgjp6XX+MzTAqBvflQMJXeAleFAHQGEYyv?=
 =?us-ascii?Q?bM0efErNw/CjQe0KDdAwA0SJILmHH0Rup3tyrackGUnkrCA33pGEfUtTFNAk?=
 =?us-ascii?Q?HSLHvP1dygS6g0KdGnEkoxfqqzpJvA0JmTJL6Qb5PTB5VV7J3jIPy/1Z8aKo?=
 =?us-ascii?Q?NI1o+Gzd9A/1uBK3y84D0PjgWAbI7zBFIQi6tQMP2/wNLaRYSu8OGGVyRoAL?=
 =?us-ascii?Q?jyQ3Z/iStTFUQ/t60l+5txj7BlWzqpGqN06gjou11b/de2EHa6NiPP5LNTiQ?=
 =?us-ascii?Q?jficXx/X1Wqh3g2TFZA1SxGMdTwyGxZikgBV3R4J1z5NkYrRlwz2Hrso8HVn?=
 =?us-ascii?Q?zbcoVqtB6UTNPd7UjyIKxzw6BHdnlj9uCYdVRsXXFFUqfjm+aJm29uqVtsSu?=
 =?us-ascii?Q?9wS7m+rl5V5WI/vrWYJqwLzQITrmXmFVkN45YZ0PWN0Hns03mcvHxH6RrxYj?=
 =?us-ascii?Q?UL+mPt03UDFyYLuIo7FKlKDsVvZFLrFR9y3mx7Jk14UG4QDR6H7KRChrs/oy?=
 =?us-ascii?Q?1BMxmPn1RLglAP6e6IVhR8lWR7NtHr1J7ZzW/KpVL5vxTiaamDWji9N9+Oqn?=
 =?us-ascii?Q?6/Dq2hW5HyQVN4DI0tQfgDc97TJA1cOuAEa7/MFPFI+FiF3Xzcs3a8tZByMQ?=
 =?us-ascii?Q?QmueEYyKXZHVZfw3CeJ5j0iZIQsbgt/r0idhbPo3Af6h/Ja4SW+qRGiBr+eX?=
 =?us-ascii?Q?OToUC/d4+f1VnjD7g5I9cJUas26CrZcEp9BZYCMoIRQi2Eiv+5HI+TFBNsH7?=
 =?us-ascii?Q?3a9YhxEpsoCMtWZ6S3YZ020FHGBCP8+uvVhqI2HKfvr3JHFySQv7X0j7pgqK?=
 =?us-ascii?Q?BuLKpq0/iD/iTmJw9ksbUardLIDj3pZRqpjQgylu62oVH6m3GpbTieBTCOTU?=
 =?us-ascii?Q?CQgUGhoyFCqowFmnsoT7RPalB5qSZy+jAtoAeTkBAYdf7QKnrgr4DdmiHoXi?=
 =?us-ascii?Q?LV4+zugnD9WGkTeTVz32vRR7HRy1aYcH62kRiSZfCTXLfgp/+/F2pswM2xXs?=
 =?us-ascii?Q?15ETM/MBvbXZpWnnVagQMyODW+10tK70h4r0hbFXNzWssu7Ym18dmxOJHECK?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46522b1a-4e95-4869-4b00-08de12dbac04
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:42.7239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFu0x43hlvulHvcZQaXGBCEFC7hKZvZpl3wW2Dawf3SA06iH7coeer0XXkZ7NVgd3daG+2I8m76SVfY6xAT/ztaz41fcWifvm8VDK0OWJuA=
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

pcb_revision is stored in the pcb_revision field of ATOM4. Correct it.
Move the function description to the header file.
Return 0 instead of 0xFF if read_eeprom() fails.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/include/asm/arch-jh7110/eeprom.h         |  5 +++++
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 11 ++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
index 1ae9f2b840a..8b689a75013 100644
--- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
+++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
@@ -9,6 +9,11 @@
 
 #include <linux/types.h>
 
+/**
+ * get_pcb_revision_from_eeprom() - get the PCB revision
+ *
+ * @return: the PCB revision or 0 on error.
+ */
 u8 get_pcb_revision_from_eeprom(void);
 
 /**
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index ca5039ee433..986dcc94992 100644
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
+		return 0;
 
-	return pbuf.eeprom.atom1.data.pstr[6];
+	return pbuf.eeprom.atom4.data.pcb_revision;
 }
 
 u8 get_ddr_size_from_eeprom(void)
-- 
2.43.2

