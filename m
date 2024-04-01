Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01868CD1284
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 01:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 110A9874B1;
	Mon,  1 Apr 2024 03:33:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="U+DQeFDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2550786E40; Mon,  1 Apr 2024 03:33:12 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FA5874B1
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 03:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHK9UYBNK+K1w0xgUVykrz08pXkZTHiUUC7MVOzM6dXQ2oW/j1b45o37h79t0m9fS91ZMW9i8n4kU4fxgbDA54N/2HWHOfS/ExX1FTwl9Qvxh8bIQXaI2Lv8fWwOZCeMv5lgFnc7AsIOa6sgc4NBw0+ITO3rMbaWUXtfHIkltWgfNahgVBsMCAhhj4UVfAUjac1vyjFg7umqTW3Yaf8dGUY4n/nJvM6MFvM6KGndXjQT0l8M8JXaMX0RCThKi8ijsgIcdlqfGSse1e3rPhSILdqwrevltz9jeSOngDWua3i41js1ny0xb2P/pLMY47G5sldYP7CxlH7aRDTvLX8uDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFQZ2CZv102MsB01Cty8GcycUZJO5fDEDWlbwIuyQio=;
 b=HgbCYjno2jcB9RzlSWh6nNcxuR+IZJmQE2orGapmqpa5IlccuiU5/9S/Afc40bkmr9OZNBWhccGQ30bgRmBPHKK1Jqzx4KCjYN3u894YZp5bVdz+l9tZANROJ8IdBRS3YyBdY0CCFS8brayP0V+0yn4FradKd4MuXyy9/O68bC0KkeFC7CpOe3iJ7B0vL6a0ehEFo2ATJTQMH7UovgTWfzNH8lv9gYBVjBdWHpcfHpabsTYpDQ3gOk8Fmi1/huKioAHNunySxfmcFRtDdPL7gaNi4RzwjUcRyOQ9VZFiLkz7EWHNd4+N4tJ5rmtuCemMTW/rlQPO67dbnDozWT1YLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFQZ2CZv102MsB01Cty8GcycUZJO5fDEDWlbwIuyQio=;
 b=U+DQeFDKMzwsYifwKVlGfIPAWw9k94bD8o/BhVGg3cO7AUi5OUCSDC2SziYU5PzDrhhmAIeJbXKfUwrUxN75DgY7tbycxuxvpCeUzPtq88zl7v8xiKttRtjAJWD7TZ+13fl9NYo9fMM+PKtp8d9aM7c+Aqwa5ajK2s1Gv9xbwYc=
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM8PR04MB7204.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 01:33:08 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a%7]) with mapi id 15.20.7409.039; Mon, 1 Apr 2024
 01:33:08 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de, u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH v2] arm: imx9: Correct imx9_probe_mu prototype
Date: Mon,  1 Apr 2024 09:32:49 +0800
Message-Id: <1711935169-26267-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM8PR04MB7204:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVnnOl8VDT/pLtIy6xkq25BHRPQbI8Hs15G1C4UOu+y8UviChXXYTHZ2aB63zXVyma9WNgrb7qBqWTfBajcSXjEVvDHhMbbBXhg6VvLd2HmiMQ+2d8ZRwIvwsyekJq3WZ+rlxJHrWR3CO8wxAGEoB9/1T07EI4T277kmumGpQHexLecd6GZxq/jVOEBZ0K1gsaEGMLJqzz+JKiWJIxd/SCNx0Tr+NuAgLGnOgBc9B+DK/c+f6M/iooK+ftZhbl9nTzXK2cshNsmOYjCl1K/ZGlJFce4YFd2vUWiBP2hbMMJIO7mDNnLIDLgTK4RoH3xccBTSHQVeza6ihdARlEp4GqKPM+pOwPLLInz+sDJf//OITZRKz7nfZH+M+tv8UGJj1U6L6waGu9pBtx29cqkKkscNE8NxZWx4TghyabTFdiF8EmmAx4y3eEUzOuGcIxOvv4und6jEoOe8G4jZAUHiaIzPl45Aleup+mWrFJgkJeNqtlgnfiYN7wQ5OV3+t4jQzCoTvhjCBfhiZut+oLUCYDAsGfd7EJ4zZaVj5q+G+spcj5YNXGdpYQwKJZhjF6FpdcRAkdMvqsANbsD5F9TPryIV12++0U7GL5wK1M7DkRgLnEPKY4plxXpwjPaOuSlXmaTtDT46lbQ1HKvMFA2wokT2fABEDwf39FB9kAkP0JYaRwLdn1WNuBoS/oIZXSghNU8txJZz/qZ73nc3GHFD0X3QXryb/3VAIWdWPn3BHEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?47Zxs4d69pp8dQFe3PjfqxmG6hNYw2/XVNV1oLrTmYua70m2+jhcQo1MyRSy?=
 =?us-ascii?Q?x5jWWm8bfiydPiUaSdjYB5f0hJNT9OU8NsY6SseMEfQPwrwieECK9htBthRY?=
 =?us-ascii?Q?SJ7qcUB01qArjV29Yk/Lvlipr6IgLriEIQGWDeeoWAzoSUUAidQAurmlobNl?=
 =?us-ascii?Q?NqrCXIgE9XkmUAaEAHUfLSA5HYh6fynV7jvf3ABPietxcXlH5yxkvku1z0x4?=
 =?us-ascii?Q?UXlOkx1ZTnfUv/jxl3tWXsGwnA2RMFrrUBC5rbMbodCgDUiMFj6GDOxknyUN?=
 =?us-ascii?Q?g/RI5Zv/FvjZZrS92cuo1Vk+InfVi31SeiGuWri9Ism0GkGQFZt+SGC/GGUh?=
 =?us-ascii?Q?6udAMcmCXg7sapCtIp4DuUHg2chWu167OowtCVJNfk1L3XAVI6JapghTKA9c?=
 =?us-ascii?Q?jaL7xD6vCy/NU9pZ0w8A1EfhpKGHQo95sNOklEcOZ1zf766abZYxUjRXjac8?=
 =?us-ascii?Q?RBFTgPLMrXyzGhjb/b7aLheF0Cy9LYmrQ+948gnnFt+nWCNOBJxosNiscb7y?=
 =?us-ascii?Q?MHEKOgFIg6UoeVWqOSfvVNuOj3nAipV6MURZUyJu7xzYHOzIM+U3XZpe9p52?=
 =?us-ascii?Q?amTHGQYPvceUgIw6OaWPTTRRZMiEbqjQYXew/NsZ3fI5A0tVF44EcHia+ec4?=
 =?us-ascii?Q?p0M1LJlukE+ziB0KAvSWR/XsfdLm8/tcDZeR9afmuSp1v+pn7oo4QYAMn0es?=
 =?us-ascii?Q?yYHBioySbZiQpPR0Vs+z2rTUHIPcJvFHDWIMJJ2/+5o74/XobeHqPPaYBnM/?=
 =?us-ascii?Q?4N1p/XWR8JL8kFcF3uiq1zN27J3+Bje9wdKtdpgI1R8TsZHPr7I89vWOHPjZ?=
 =?us-ascii?Q?gT/TruNHV2y7YZ1TETfpZqwa50ksnI1HRl0JPg8R2PTvidxtzObCzWpKjVKC?=
 =?us-ascii?Q?UvmNRm4l2I679lVy/obJfDweq+szC3tgmrh7omF9Dy5DNJErXi3UFxAlv2nl?=
 =?us-ascii?Q?Iz1Xc9uE14uwkY73PZiH8909nNpIYQMNci/2kuMweSxa28IgwhhiCgohzkhl?=
 =?us-ascii?Q?jl10NHKIC0grF9ufKEyqtFXSRp7UyManzaKIyn99B2YlVV+nCrekrVH30xh7?=
 =?us-ascii?Q?zP0g/NL1H6eO40oStaGHJW9tCZSN9dk6UbYRZrFpsSloHntXjQUyqc4Hr763?=
 =?us-ascii?Q?Fhn5svUFQlPRcpwZM9ROx80Yb7RxEnkEHI/ebuDiGG/N4SJt4uBmbazz2AF3?=
 =?us-ascii?Q?0U0nuiGHOPDVdI1Nlk3EZurKywcZeRFqnC64AD05+48/cFA+eLOOKlR+ddrP?=
 =?us-ascii?Q?Rp+c054dG/B0kwph/Ob3NebKC/7hpb8ln97RGVneGhxAYRIlpx7M6LdKsM7t?=
 =?us-ascii?Q?7JNsSjmAbtKlhI5LszMxIzsNZJI8yXSsK56ilSaz0ACXHJdqNqg9XvWt3kUP?=
 =?us-ascii?Q?D7x3ARhcku+QZh4439TjQW5BEPpqBjt84RlIxBJYOeNfkHQjlq8hW44rt38b?=
 =?us-ascii?Q?gtCkxDHPOFWgN3Eg1RyZcwJhLK4K0yaG0IuPHMsBl7b2u6kE0xWcjdm5M0at?=
 =?us-ascii?Q?1XoiFGNbSkGSJqEfQLG6vAhWdfZOXQvUp1+SMzmzL9S/Ic0rEFL+Y75JR+j1?=
 =?us-ascii?Q?lpBLygupSyy506RXNVg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c23be8-734f-4d3c-1420-08dc51ebaf85
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 01:33:08.6162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 111mlg1av6KomDHexW1wVKIzEUMF7bzh0sGwmh2JwkvQgNZSDI5okUSPqoCIFHG6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7204
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

Since the event callback imx9_probe_mu is re-defined, update
its prototype.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
Changes in v2:
 Fix imx93_var_som and phycore_imx93 as well

 arch/arm/include/asm/arch-imx9/mu.h | 2 +-
 board/freescale/imx93_evk/spl.c     | 2 +-
 board/phytec/phycore_imx93/spl.c    | 2 +-
 board/variscite/imx93_var_som/spl.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/mu.h b/arch/arm/include/asm/arch-imx9/mu.h
index b860499..649b8a6 100644
--- a/arch/arm/include/asm/arch-imx9/mu.h
+++ b/arch/arm/include/asm/arch-imx9/mu.h
@@ -8,6 +8,6 @@
 
 #include <event.h>
 
-int imx9_probe_mu(void *ctx, struct event *event);
+int imx9_probe_mu(void);
 
 #endif
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index 2fd5559..7331a20 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -116,7 +116,7 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
-	ret = imx9_probe_mu(NULL, NULL);
+	ret = imx9_probe_mu();
 	if (ret) {
 		printf("Fail to init Sentinel API\n");
 	} else {
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index 16303fc..f03bfee 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -122,7 +122,7 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
-	ret = imx9_probe_mu(NULL, NULL);
+	ret = imx9_probe_mu();
 	if (ret) {
 		printf("Fail to init ELE API\n");
 	} else {
diff --git a/board/variscite/imx93_var_som/spl.c b/board/variscite/imx93_var_som/spl.c
index 36e1721..71f346c 100644
--- a/board/variscite/imx93_var_som/spl.c
+++ b/board/variscite/imx93_var_som/spl.c
@@ -121,7 +121,7 @@ void board_init_f(ulong dummy)
 
 	preloader_console_init();
 
-	ret = imx9_probe_mu(NULL, NULL);
+	ret = imx9_probe_mu();
 	if (ret) {
 		printf("Fail to init ELE API\n");
 	} else {
-- 
2.7.4

