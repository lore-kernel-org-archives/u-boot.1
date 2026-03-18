Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D949FCD0A5
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40B9D842C9;
	Wed, 18 Mar 2026 05:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="B+f1FEjM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6F28415D; Wed, 18 Mar 2026 04:17:00 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F1C9840F1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/mEhWlKZKgpLmf20qpSdQ2YWLqgkKiBA6BVQLFW9BmHPN8esTrqr6wKUk0OekHkXcT7RjS2OgFMSoMGleqan6iz8x5ih9jcLBrE+RsjXaL1fNhBMqFiX0naCqVysk0ZxrFCLr+9MhZTzS5BYjTWGR6+k5MTvTxQ9DBmt0/8Iexe8O9kKFuQY6GqRfnAlejxoEsZsVzM43bydfzx44jLXnKBxITFtvihEBv79uVIeT7gqB/JBA3SKTzRLj+rDrQWLZIgOXbWW1MX5C6sLQ2yFT2RcDv7rh19qKjLtjFuoseRbefjbJ93H88UbvKHcT7nzj+zG0gvCC6jhh1ixXdeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2QYkDQCXdMbfpoJDtkcd1TIJF1zKkKiJ+JHzNlBz7c=;
 b=ZxWjQdsyMYTJGgVtum2JS8l6kyF9/n98fMBu99MCci9bvXuLaO5DdEHrwn+/6I+GRnTTgMlF7qreRcz2UaWFJAEOZ9w+dqmgp4bePpzEkewp0oXDJcd9sKcM9g49aSNaWOPgywjBFawcJFf6v8bJP02YenrQpExDmS7d0U61BiwYX1JujQMRMaKCrTHxxJvNQ+1Z264nyzQr82dxc8zfDUyP8ap6D1ahaiqCgxgCJ4iZr/Z4BdQjTZAZLViKwK+t1BUGIZbMp4R3pD+oIGUNNEwiPLWtMBnHzQoi5QyI/xpko88lZ+cwKIDaXJunzqIQ/qLH83Z+Fb4MaCos0P/hiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2QYkDQCXdMbfpoJDtkcd1TIJF1zKkKiJ+JHzNlBz7c=;
 b=B+f1FEjM/QwFa3ahE3+xU0TEpnGHq2G+/ACGDSG+z7ky4eq9VDZCi1XygT9qzXkkMVprn0jpfcrCXJI/W+WP48YDZZrzRQd/6gALznY6sYAY3nfEahk8mT8CFkbZgnlvgd+Wex/zp9w3mkFrKIHtQAD98yhg12AHM1LBTyjPkor8Iz97BafboeiJSJsg0hz4x+mTb3Gn5RssXZiilRBBdW8WNUCDEj4ualvs+zjrSjmRom5cj1iCi0cM9O585XXFvb+9blTHEN5/O86B8HNkw/e1FWh3CIaZUemgVYcDSZNnHVnZHJf4K4Tm/V7FT7gsaRasL9CKClplFo0zu7mYzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA1PR03MB6578.namprd03.prod.outlook.com (2603:10b6:806:1c9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:16:55 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:16:55 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1 6/8] arm: socfpga: n5x: Switch firewall setup to device
 model
Date: Wed, 18 Mar 2026 11:16:35 +0800
Message-ID: <20260318031635.8384-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0104.namprd05.prod.outlook.com
 (2603:10b6:a03:334::19) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA1PR03MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: af3aaa67-62aa-459a-bd91-08de849cce5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|55112099003|56012099003; 
X-Microsoft-Antispam-Message-Info: roKs/exESzNhBmOX0zjTBPR2df2akh4JPLJ4nRhldsxJEOVWgcBgLGjNEXuH/8xGyvG5hPxiQ/eANwhRTZQGoli9X/weX2fB9KHAar/dNPnqQEe1jg6XE4HeJee3PK7WMRZVyWNoB5g7ARbAwPoQjT8DgZIxac2rYoMKPubADTC1Nva0xyotQqEFkcHoiXjxPCIuKea1k2BjWkTMpnn+8z9fRc9X+DWKwJrS7OgBd1us4PLxyBFDdxPIgnLrw65Hkl577hlYiJlUxDMhHOR2K//FGXhC2X+vakRPCvO+r73pXZmJerBj6Vyiwa+yEOqCMyho4ViGBpDTlICkJzfL6EgHvIwbanLO546DcXlfeemz4lrGDOB8oc5NuMuxmUS+DWHtcnz209TcyFukHbEBwkpanOQ+ZYBhaWdfHjCAKHZv6KRuvrCe68Bmi9Bb4waWpp4q/3gNmusxWyP25k836VrNXj+17gPRSZmCtJFrpDIYtvKlXlmHCK0UFL8PaJEe6WDAIqwUxvX1xZePFeidPnIlBBJ2K4h9TI3SfuROpSlQ5rBpTqTal5PjHRrFIg5V68pW7p42ftlMCDStDk0aBK2jzjyZT2qsPXKAsNLl/xmWpz7NEIgZH/qPuXQOXjsZoBwvlE1QpyiT0BUImUEdQ9CF2Mex76UuhW4Tg9ki2lAYuwtYb3zqCgO1TSpsgK/us55lJIdVR7A6WkVFihtKI1qe3ZoRSzGhb4Yeuzm/9vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(55112099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EdtFgOBGHsqIpMVPhQusjHxUKVed1hHA52naObH/Nf+W26M9HIJ3wbxwIoNr?=
 =?us-ascii?Q?rZ+ye1OQi+skENG+jtSLdS1flke/vA4R7odjNzgQ3tiQ7DMB4as5XjvB9Twu?=
 =?us-ascii?Q?zflEmQRjuvImZo8NamQ3sWjbwfXbfEmZ1CF27Vhdgb7JnJVltSgj9/5p5ZCw?=
 =?us-ascii?Q?rTSmqUDL3z7FYqt1tcwSwsk3SldfgFkVRxFkK5oM3TX8ubtWhe9aoyB/dlAQ?=
 =?us-ascii?Q?OAD50EKNpPrfNKQYaP/SQC7SwDvwOvvS95Dp5JzyvPxaTp3nHA7g6Ja0uRzA?=
 =?us-ascii?Q?SGdCn/D2lZXSJena53doz6rRflMyfmkU7y79gN1ESMj1Tw621F41FvfmOi3b?=
 =?us-ascii?Q?kVGlf87qnN6kGD36TvT9x+QXH/p/mXeLmdTSCxVI2Vz/VgvRcL3rKzyoNxaT?=
 =?us-ascii?Q?+XSvOL9ZObi8fH5EdVEBAn9WHiEhnaqtKuCSalNqaqYpiUto8aWCE1s6pLpy?=
 =?us-ascii?Q?7ZCuhMzNNaJX7k4d+Fb905jOLtnPpaZ3ZpvNGIdTPvWg5TBe7amlWedr4j3f?=
 =?us-ascii?Q?eXCD48PvM0RpMb17+zqQAgFW+uabmeGgvZStvqAZuEVYtE4vzF6x3pOesUrw?=
 =?us-ascii?Q?r7PCNOspCget0xea7Vm6TiDIAqsMhNkbCxBYqQDA0pJwDiqyhtQrobk0Z0Wb?=
 =?us-ascii?Q?HLNc0vt9GmzZeZOhoVglNsdZ0f+rq8meFvI+Q4phoSTqamLSgOpVN7GaUIqm?=
 =?us-ascii?Q?VEJs20TuCyoQHfN4Aft6gz2owCQOfwiQ/asABT1clMW39bkayyJc0l9uJHBS?=
 =?us-ascii?Q?jUD8ODmNSS/DdWTCwKcAZt7ePVDQoyplj0v/jdODyTpyUYVWkcUYG4nfGnmT?=
 =?us-ascii?Q?q3d9ECcI+Yhz4FzDwclmP6nuWHC9xcgUVyXtzI7HwGnoDAIDruMjsGSn9RD8?=
 =?us-ascii?Q?5X79W2BD8SuigVvTfSH1Lh7D6UsEuHqNDNs84XfzHjF9jXtWDk3rK7Wm/d4p?=
 =?us-ascii?Q?eDsRIOLkiI2qx97+C5ywuqF8KCBEbU4z4PczVf4pgQ32YJZtOlfB3b0wNBr2?=
 =?us-ascii?Q?y1FV550LBNT8eu/7VlDx5HWRZrIKVihPSrWGsYWpba9NooGKqiaAXfoqLZjS?=
 =?us-ascii?Q?Tjp1RsAw/VzKIb0y08MjMRAWAFksxIHhAxps1u/ALGZ5/VEPVs0/UcKsAB9v?=
 =?us-ascii?Q?33Qo1Wu95PAipyvFr1DY9vafU9JvLDc/GmA1jkgupkmVSFK/vPWr/xAcOjZn?=
 =?us-ascii?Q?pf6WydaOGVoVyDZmv0n/DDQWoxmkOnOAuVnmcA199OaowuTXVx4CisIkv5fh?=
 =?us-ascii?Q?OkWNus8zTTja6sRGZotIPKShUxqcNJSoqT6yFXX8HKKw2xXCVRKl0E2W0vwR?=
 =?us-ascii?Q?F/Fu8uvZPulAj4h9pUIctUW5Ht/F2Uxx///hvcHAv3Z1eAFCa8dEBYizgLPX?=
 =?us-ascii?Q?C2hUBLCO088YMcnJWt0A2FxaS39S0+mMNAou4JOYMzYZ5nBmr0SzE5In+3/R?=
 =?us-ascii?Q?kSrgBhjBfVhnA3eHDwwMrq2mK0g/PHnCmhNWVKHLKSmQFTMK6aQ0EM85C6f4?=
 =?us-ascii?Q?vMgdTOg+MwbSbC60Mlhbx18IM0Ab+LdbS81aopsDlqe9GlKTA7hew6VvWJo6?=
 =?us-ascii?Q?MJbbMMjKsrIR+035GO9tPFUJXgrZimyfd9QVSrW4Bv6YaqBw2a4kNfEdmEo9?=
 =?us-ascii?Q?+Jc7nMv42PCQlkM8m/DDuMnH8Ukp8p0XHts+kDsJKd6XhzI8/bqwZ3WHhZml?=
 =?us-ascii?Q?LNiPKkuTGJar4AGk+pidLvyJaaqQZYc8NglbjLxS6wnqNK+x/C4vOw8s8+Gp?=
 =?us-ascii?Q?+/tZfpzGlA1Swsf9659ZwQJ7Qz2cnMk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3aaa67-62aa-459a-bd91-08de849cce5b
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:16:54.8960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNWNF3Rbf4lSCx8VLWMn2b14432o4IwjOZKRpHyWJ9hQrg6vgdeORvwqw0lzlVOFUI6QIu0+ZZclh7SIy301YaVb9TLlEMoORjFHclQoSFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6578
X-Mailman-Approved-At: Wed, 18 Mar 2026 05:11:17 +0100
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

Move the system manager and L3 interconnect firewall configuration
from a dedicated `firewall_setup()` function to using the device model
(`uclass_get_device_by_name`). This removes the hardcoded firewall
setup in SPL and relies on the device model, making the code more
maintainable and aligned with upstream practices.

Also, remove `CONFIG_SPL_DRIVERS_MISC_SUPPORT` from the defconfig,
as it's no longer required.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/mach-socfpga/spl_n5x.c | 12 +++++++++++-
 configs/socfpga_n5x_defconfig   |  1 -
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index 81283ef7162..97b3f8f1830 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -72,7 +72,17 @@ void board_init_f(ulong dummy)
 	print_reset_info();
 	cm_print_clock_quick_summary();

-	firewall_setup();
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
+	if (ret) {
+		printf("System manager firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
+	if (ret) {
+		printf("L3 interconnect firewall configuration failed: %d\n", ret);
+		hang();
+	}

 	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
 	if (ret) {
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index fc74e2f65b7..6e55987d310 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -94,7 +94,6 @@ CONFIG_PANIC_HANG=y
 CONFIG_SPL_CRC32=y
 CONFIG_SHA512_ALGO=y
 CONFIG_SHA384=y
-CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_ENV_SUPPORT=y
 # CONFIG_TOOLS_MKEFICAPSULE is not set
--
2.19.0

