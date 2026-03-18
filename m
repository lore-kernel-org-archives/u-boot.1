Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D905FCD0A5
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C64F184307;
	Wed, 18 Mar 2026 05:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="BdUYqSnp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D8C8415D; Wed, 18 Mar 2026 04:23:41 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34215840F1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPJIcV4+twq4I/UC1KuhSbXJOt8MCioKniZVOqjuaOugydXiPf8eXlcpS9ALXCy1zoPJDrzp1gIy2UJ4TDFbVnEdr5jIeEOdUTzzjTatlb2k9y2m6mBFi16t5KynQqCs1NkFWXNIldqPrutBB1SrjJ6tPBM0Em1luZPy8Xa897vUQCTTgNDITFPvbwItpiKKM+Sa6kSjrpGEGrt8MCdrd7N/ryACkcCMs93aZiSlucVdifv3WlGNEp0FKnivEZGO6xRTOuieptN4l4yekWZ1HCYlisW8JAoLsKm1RTSnOolg7HWWcTHpidXit+TDvy6LbNkD/MfamVBSH0AXaJyi9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTJaqW/8iJ71lzgu90eJOWntVvff+26MOBUQkYr60R8=;
 b=NWo01oapYmta6/SEyPq3IAFQB3brTZbHJRZgdZOuQQJ8bNPVJ8sqmtwqvTjZnpyySfGjF8lhE6tG+K2kC69FaHXmFKbD528geElwOrXSdOj+1cS7twS2S5kyQWUeYh9YKBx3AYhEOIyBEyKp7Pq99/ASf1GxN3Q0ZqtO/Uyow3IiC2ZzDcvgOh7IHVRfhVT6lLwqNmYPqP7aGmE+EKPW6G57dyqXncsouGUcCjTHaSXLqX+wVrKbIauy2r9aoOhnrNFQqI9L7NJVT8tCAT4nXcPkVUbJ9Q6F5uC3x0FThVN4+g2MCHJBAQeQdphv7Z4YN8G86lyx+vOb9xr2xrmLYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTJaqW/8iJ71lzgu90eJOWntVvff+26MOBUQkYr60R8=;
 b=BdUYqSnpVliKKlKw59DeAJlLHJM3I4d8Nt1RXahHU51fgsUyKorRnY/M0t54ii7aHHyaHt/gEzEfCWSq2ElE88Or5H3LBo8LGXtQc/oY3hPxuAJjVV+9VSHSvXsLuSEeP7jnhSTYvRUvTC8A/qRcu9gZddyQ5L3aW6/nPgoGeTlgVBsvEP10IGyjmlbvxOEJX4aT4LQE5IETv6qanHdCsoLcjhnyBzYXRhoLMNn8Wya2fAtSfYrskusljk4VoSlPUyKl2UeqiY2iF7pdH9AacNInmKHaYzRAvwx7OUFf8FinjvkYfeX9tTJlyGQV+CfnUs+9KH8NqY9Qd8HtekZsdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA1PR03MB6578.namprd03.prod.outlook.com (2603:10b6:806:1c9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:23:35 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:23:35 +0000
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
Subject: [PATCH v1 8/8] arm: socfpga: n5x: Update SPL data save and restore
 implementation
Date: Wed, 18 Mar 2026 11:23:23 +0800
Message-ID: <20260318032323.2988-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA1PR03MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ec2aed-6193-4c6f-7fd9-08de849dbcfe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|55112099003|56012099003; 
X-Microsoft-Antispam-Message-Info: GzQFpUoB77jcf0BoCKmP9+nDfp6srTE5TdXk7yn84RppJiCOSDrG5sma3MPB3mjyZCNrdVSxp49foyNQIEXh3uniIgArpj3flshwpkWl+DbxrjJ/L4orHQGefY+Vwh6+NzPZp8l4CfoxbsRa48OAQYhpXGFMwx+JGIR7hzpDM5u/0a/ZR1EwmAvDw4ZPTxDMm35MLqvly0H3DAW0Z4Ed9u0aqTSqBbgrQWtfFwMiE7KeOjwpQ9Gddn84E4BzogGP6eCLXnbfk64f7lxzz9iWRAxeweJ5YFr2VxbxaPWEyfs6ZJj+MPRJ0r8FUJ1ziS9rXpmBDKQMp88mcXNBlvMK+Ngd/KjJqBh2KgGeOYnXJcecjQCX4jdi34kIuQ1j2PfZC01oUovyieDVKg73/qhJJu5L+GR59IZc7TGbka8OkrprxDq0+VGxpTl4N7l+LN1Cb5UrEZdFg/qKWi85UGGV7WxlNlDKDvBbzPOTMOin1tGsUxMhwcJCOtIJSukG1YIRRfT4AnpFMYqfT7qypkufBkJ09SIu28LxbzvKOI/K6VpXyysbBUwPFlNG9S8OzfHVsQ2fXpgd4zLR6ltyrnu79Aen2OuZ/67i4jPQP7D5lTCAiWumIAfsOc1D7swHi/LpAu5DXNAm6XTmqFrJdp5GCdPIH7QYX9uG/pGIph/fYQlFMYOvHHQHOtdMoZiIIJsZ9W+076Og3gd0T41zmaM71V7RK6gctj2ClQzdLViUfc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(55112099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D3IEKbYT6y8y4rsGCeyu4UWpkR1CPozggIBaId5RyycLrh2l6EYpo2slTXzP?=
 =?us-ascii?Q?3zAbwiFmQ25bSTz3IVhEdcYtbBYsg5v4L1Pe+T3Zb0mSyeCpYF/KbW8BETBx?=
 =?us-ascii?Q?1kjmZZq/8ZZ8+kIcuRhGVsF1M2H19NwT4CMUJSKUCYFYmehiSDmv14xdmTR1?=
 =?us-ascii?Q?CM00RFz5g0v0I6wqbd/OpjAyvRIP4NKsUUyF7yJfPIW9PevzaxfxVhbEj50E?=
 =?us-ascii?Q?b2zbeX/BWgbtGU6MX9H2pC8e/f/p34EZ6mR+tO43gzH9AKr1C4BMxw1Q/cMd?=
 =?us-ascii?Q?uLonhIuwX8BoXnMCdxFFziuXNtNvgU1K6pNBrPGeOPXGrTYBh9M3hbTgFeTg?=
 =?us-ascii?Q?plBBmMOluBteYIuz8YaUsVBe3VNV2h6KiLmR+Jnlpv/mmq8xIKV/EXnPsYq3?=
 =?us-ascii?Q?ux+/n0UVr/9RREwxMxYlFPXqAuGzrUZnSyObG6H7RfE9cNNyNW/QMWFuIjgr?=
 =?us-ascii?Q?Ib7Vb06jE82nKz4cBJgGBWSL+Ze6Nsh5xayDoSW90Tv9Wk0D/gVCADUhpaii?=
 =?us-ascii?Q?u+XgDAYx8ZkAc2AqsYW3hVuKyClOXhk7ZhCtiq/qrPM26KsCD4SSu/sktDxZ?=
 =?us-ascii?Q?7EIrx4kToXPo55Nj8uZGV4InsGIQnHQzdTyimTGE+6wzIVjolzxiaGavvR+g?=
 =?us-ascii?Q?NLqdtyaq9pIx6z+J9vVPDDw8dC0r7H5sVmnHAxbqjXBXOKJ3emJlDGKvC+Z8?=
 =?us-ascii?Q?ijyAU+i9PG/Og403Nk7BOQAj/yDY8M0suWi/TFldZaN8g3/KiAVKiZ/sgpVc?=
 =?us-ascii?Q?oi9k1IWYngV/NUFTgBdag2ZQFRshpnlVdFXL+fcyjMdws5YN52iRIkblazNE?=
 =?us-ascii?Q?toL+gi+UxtH4jDJX8tHVSMW0JY6MQeWE9b6+BxTVVrC8eZpmCEc3JWpyoun1?=
 =?us-ascii?Q?48Xhhh/F9LcMMXw87oqvmZc/veY0VpjqX+zEqOcDA8jhbHgEbzSUUK68IQMD?=
 =?us-ascii?Q?lJj/N+PwUk8GYnilWWIczwUqvG9YXkgtZJcdjhzjEDhQ8chmXJ+F1KKESm84?=
 =?us-ascii?Q?TJUyUUAWhfM1a6ikfCP4TmlVJY5V3EL9SGX5iFFO6qpBlViIrDQn4UnUxzv7?=
 =?us-ascii?Q?gv7F1YXeSBd9wDH8LLyllSF2DS4eLoxU0wzR7amIC9xccZZSOGQ/c2USUCj4?=
 =?us-ascii?Q?Oefoxkg38eIZfkchisrIue4IAHXaC2npp9XSQ82npLzJs6ar+bk7eKhUq+3h?=
 =?us-ascii?Q?VPshSk4O9fuEBIX7F1UyKQXHwrSaAYu8zmwIpSa5MaTJaBq2phyJht7V4iHa?=
 =?us-ascii?Q?1+sNsw9Fen7VMQNEvbYCPnvduk8BTVEQs0vExyL/GqjtJKTQvNtmspnWroaL?=
 =?us-ascii?Q?ndmK6ed+ZXB7X5escDKDriN1CtMaxrxv2qN4KhGaSDXPJC7iiJoJ6sHUPBZr?=
 =?us-ascii?Q?YzVWf2kn0i6lMYNqgekYL4LVwjxqveZdZAeDusO9gbd2NhhqhlwEuo1DYnpF?=
 =?us-ascii?Q?X+2Wx//iYKJqMc7/LzU5W8CXrRf+gbBcARc2/MFXHyqYfaihzv2Ns/AD6Dnp?=
 =?us-ascii?Q?OkOONl2tIrTxPNf0kvqkjzJt2UVq/DxgPxIC27wKJdfICHkfFuXJLr0XAg7R?=
 =?us-ascii?Q?W5FgiIYCvFeWXULR+WUJBDQ/J5WG8GNjRgXITQKU5iLqpk+bGHeZJrx1+X7l?=
 =?us-ascii?Q?YI/QwEZjLPEvluyJSSsKbHg6br1ZKy4jODMxf14w5Szu/mChWiI0pTrzYVuQ?=
 =?us-ascii?Q?NKYV7PdwNnOkAZ5jAGlyoRV7w+4zzzAzo76N9blSp9Ut+F0F9gkhjneoWlTx?=
 =?us-ascii?Q?wQSi9kzTDHvvU9NaJaTOJpT0v4VVe9M=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ec2aed-6193-4c6f-7fd9-08de849dbcfe
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:23:35.2867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPGDXMTij1JANBvR4/q1f2b7MHA3QUH5BjAKO8zs3zK6sMOBVkzWWZvcfwyMGBxJB21qGO+TRmnJ2ua7odMIQzjyEwk9mC82twGxpCAAG4Q=
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

Enable backup for data section to support warm reset as no SPL image
would be reloaded in warm reset.

Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/mach-socfpga/spl_n5x.c | 18 ++++++++++++++++++
 configs/socfpga_n5x_defconfig   |  2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index 97b3f8f1830..62b991e607f 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -22,11 +22,29 @@

 DECLARE_GLOBAL_DATA_PTR;

+u32 reset_flag(void)
+{
+	/* Check rstmgr.stat for warm reset status */
+	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
+
+	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
+	u32 warm_reset_mask = RSTMGR_L4WD_MPU_WARMRESET_MASK;
+
+	if (status & warm_reset_mask)
+		return 0;
+
+	return 1;
+}
+
 void board_init_f(ulong dummy)
 {
 	int ret;
 	struct udevice *dev;

+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
+	spl_save_restore_data();
+#endif
+
 	ret = spl_early_init();
 	if (ret)
 		hang();
diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index db43046a9f3..27e15a13659 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -4,7 +4,6 @@ CONFIG_ARCH_SOCFPGA=y
 CONFIG_TEXT_BASE=0x200000
 CONFIG_SYS_MALLOC_LEN=0x500000
 CONFIG_NR_DRAM_BANKS=2
-CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
 CONFIG_SF_DEFAULT_MODE=0x2003
@@ -23,6 +22,7 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
 CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_SIGNATURE=y
--
2.19.0

