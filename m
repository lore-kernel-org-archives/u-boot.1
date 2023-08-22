Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07525EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 14:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3543386494;
	Tue, 22 Aug 2023 16:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="s5ne/2P8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A72C86494; Tue, 22 Aug 2023 16:34:36 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01acsn2080b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::80b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93E218648E
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 16:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jle7j+1BqWzoPDWRFhBv+Phm4RdSVPUjVkrgOWZ/XNu3+rhqwSbc3MOxbLcnZBvLyklNfzhbzsTPwwxlYdz1d9iB7qH6zMBxWAYkIQkT2Mt2dpydWcc3BCVNuPRGv+bbvIgXpUxKR/rGHHXEggqPviNA4ExxOGbUtGIBYov57NjsF4SrVPU/5ophzzn4O8U1Dx3NtqT6+pn7fb8oJUKjyrw6ixsPmBWKvuvZJImJFnpJYjoIYHrleutkbqB+5EgfsMKLEQt0SzpwUYDoBV2kCOmna5g6CfGGN/kXUilZ+CNBKsu9Vz/YrNRsc/FGRfYrY/lTfwovDxuT+Q5a3ElImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V11G2q0Rn6vB47TScc5YrWNLS6K99M5xgYFsG/lBz8=;
 b=MOklbBcenmsUKG80Eg7KdlBoQYyWr4BeCm+ah2DEoCP4KXhlU1Axlgez8yUhb6kDZUR4QNDikc4q5RLpo1P+3iRwCFVYLQuVflmzptqZXPw2fDRrh0NKXrdKIigQ7vAug25SMb8nK7zA9pcl1kMkMzpnnwpHdgL4mh7mSG/ARNIn3HguMSgOxZwZVdmMjhh1lHq3A4XJXfsgglGEKeJRPl7xYhb8XoCnOcs1m/1Cq1yotXVzOTeAqeESufic93w6seCKE8+fYeSzv8+qufdhYnddJt58bgm6r+WdIKAwu7YSk/cVYjSCH/qs9UJ07oMXCKw0yS7Bw2uBc5I+txY3JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/V11G2q0Rn6vB47TScc5YrWNLS6K99M5xgYFsG/lBz8=;
 b=s5ne/2P8kDScYm/r4LZLs+bTTgwdY8B7Dd5evjQSROlGrXajqh76y0Y2iOgeT2GX/U37uW/IT5s+vSRy0D18uYu4X+i8WJLHil051HPdD0rK8fKLStiXBlej6Z8uiDh6wCMuJTISQS8f20/CSOtEPzvq6x6ql+XVeT6wizz3aeSuCfEOABbK4PgRkGBqQnM6wE5wBh47CtSs1eF4VgksQnzB7TEXABGVb7tLOnuxuAzpFlzs+QjSfEPw94bVaC7wGV1SkzQuFmV0iG7oCpzJLlWOTOwtU24tzFL76ImjysN6SgwV+oiC8L/kSgfJFZvF5KSZYcrCu+GY73H54LStDw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OSZP286MB1847.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:166::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Tue, 22 Aug
 2023 14:34:28 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.013; Tue, 22 Aug 2023
 14:34:28 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: xypron.glpk@gmx.de, chanho61.park@samsung.com, ycliang@andestech.com,
 yanhong.wang@starfivetech.com, u-boot@lists.denx.de
Cc: mps@arvanta.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 1/2] configs: starfive: Enable PCIE auto enum and NVME/USB
 stuff for Starfive Visionfive 2
Date: Tue, 22 Aug 2023 22:33:56 +0800
Message-ID: <TY3P286MB2611C9AD6E5BB3756A959E89981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230822143357.2818-1-wiagn233@outlook.com>
References: <20230822143357.2818-1-wiagn233@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [3UhvCN1RUtdJHOAZqXP3FxgG4rI4W0P4]
X-ClientProxiedBy: PSBPR02CA0008.apcprd02.prod.outlook.com (2603:1096:301::18)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230822143357.2818-2-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB1847:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a79de4d-dae3-4700-a1c6-08dba31ce3a2
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3lez5r043BQwD4sP780sNyQIaiQwQV+dbJbiplr2tKN87tKWPXuB59+SL2b5glyaKhB/RRopOxz950vQsoTt5Sc1qwjul/MJI54jv3jkJ9se7+qAyv1wd8pPHXvfukdvlxYl20JvXYkJF0RIaM60q5qPvsmoZbSSxuIbU4mLQfxTycix9a0F1S4gOSzpIuMpoCLYQrn2DFClIlOVCs37p1vEGBRfAHCpu4gtp5iXvl+gtgVY0jpYNopm+AOB4vhhdt2SQRTou16fj08oAM2g/BnMqIMLGf52bGP7QahD3Z71RiENxO3wcfeexcsnYBrWZCLOtkdvzlEqih2wD5huwMgR4kmWfuCOs1i3XoTNgYvQD67/8lJC/2NQ9vzYt6CsOKkI3v2gnDJBJE5EqDtusbkpYvSckXujbPmyHBzZ3MxY9LsdUcWKD4oiJd6XVOjMKcvth4tRsQvyY11B27/YFc4FUfI6sP7HrH+72f4vo0/CXLCN0hvarwnCRK1Jf/QwbMXmNqPQmq/IBZycO2gmzY8lIYtsO4nhD5rdF7Y7wrw4q4ZDl/ljxzs3cmoWpGx+fOo15cMwUZAZgVH02nW2u5Fa77sA4VqfSaBjuX9lAuBse0LvHqvp5hTQ1TWKU+SY4vIIiejPAnFGngWtep/k3SB3yPifzM/HxjM1jy6lzvNvclSOuttpPkuu+VVPnrDSzclikgQdIqSTjK+p3XWt+rAzstB4hCPQbOicNumX5N4WdHqX61bgAUfvSAqsAQGQ0IQVDcq9/hXVVOB1kdEAHQ8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDhO38d45QKiUkFYBokl3WTFyyimo72bu3axmqbH4FtTa2GTpHwNEX9XBpcuYDita90rKIR2XsSsL8SZJNYeW0dMjQVEDRuRGJl0gAzFmS7nQam680Ulxqh4bA9QTVRNwmKoXAxc8Kv33JYqBPHWPXLW989duiYkIHG8hy8RO5nTuJRhmW5AeyJtj60F+JJsoBrOhDFDTJZGSG9ohaxLjzGGUKrlP+Q9U/QunEUvgWgEPcDZYltTGAm55HNVD9Gdl0h+TS2ZYh7yEfICQINKQXcIpERYbkBotbKvyNSwKo0ACX+OSyI7a1a6IpHnaUZgxeAL8+f9eYg1mxplNZzlyUYHDkysrbx1txmezhuxGHCSkfd4My42WotLJltpfok+U1NPynVaSOzFlLuSv2ypnOAFZ8wdtJoSzI0Zc7uoblQiWa7cHkwhkM3TtPBPEyYOAaM7EnkgbKvW8Ck4vGl7X+tTJhehzyPLYIOOdMSYtcX6PP1spE7BF2L5ycNkdu/El6qyL7kDer+NSev30JzFSL+XmSMM7UX1wtf7hvLzrzYyy4nh+MNSyNTbURCPNe2sVh13SI1gb3W/fIzGjnTUGcK1eh4yVriuSzmAAcXR1CZszDDOXacxlx0wjPv/2AQM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dy2Jp6QRfwSTD7vj5CyrZaCzmnlno4s4b7FrcQ++LlL1DTgKLAQ1tEorFWOA?=
 =?us-ascii?Q?pfX5MwXFx47K3PhErWZ9t8f/Ev3n6jqKpIPpagAdJb4shwGrbM7AhT0styLI?=
 =?us-ascii?Q?gVDtMuVEpSCQVMf05czp1T0FAPYx3dMLtWi8vqVdfp3EPN5AfKi3aYofLhqD?=
 =?us-ascii?Q?JSP/8HmzBX/lD11Uzq6IFFTOwTB25fmMNa8NgiarVDeFlFikJShUnOML4cLw?=
 =?us-ascii?Q?Od5e+14KvI1M/yEtGyf5Zv5MOOqzNA8qUfHUGEO4EJyiEb4zvmd7omEKwd1m?=
 =?us-ascii?Q?0Y/t04QY/y+4TtjIvl7MMJizqM7XVut8N1QVc/GBIqNkHOohygrUJoX1EcU3?=
 =?us-ascii?Q?qFv8ErGexLcz+gTC0QJjBaNMa7NUpSzwH0QtxBTqGH6sKVa2Pymvd/FiC7t/?=
 =?us-ascii?Q?PDJAQ5j0crNzE98moqBmyYM+IGx68YYLm62vFzu6sNy8le6yEO2B+H+sjSdy?=
 =?us-ascii?Q?VMIPqU2iLKbo6tMZPp9UEtlgric0uK/gKrI5wOxovvEdJvasXdiJO1UJZkP/?=
 =?us-ascii?Q?4mw122YmWAGcgnnH7bYwHx/tjNLMkL3wqjU/jndmVXCmRzQkaaGJTE69ejgS?=
 =?us-ascii?Q?s2BIkFkVG5XrrjqQ1d8dsnxfszghrTov9ajVCegPXHMw4cpixG5kZXxT6CO8?=
 =?us-ascii?Q?4d17ROGvrM+bDNovEOvRJ+rYOGS2jCHEbpcimAkk31aFFA6MN72qNa/rKGdc?=
 =?us-ascii?Q?ui6Acr8bx/AuClvXR67OB86nYnzx7arKuaTt6uIFtPh8I0gc3a2m/y2qKB/h?=
 =?us-ascii?Q?ObH3Ee/IHarj2ggIl52r3/dvmBrNs+0Tf5MVA54xetIeThv6Jp6q1udEJOpd?=
 =?us-ascii?Q?CK6o8ztN5+wgbHQa27CyFZihwuAPeNk5UNqiIaR/CMwZq5ZsyZ4ckvt2M4Qs?=
 =?us-ascii?Q?4YflrRCeAKsPoNWIGgcb+Y2xGj6fMhCq7+TY6i1veTQjupskcPbkxnax3/jo?=
 =?us-ascii?Q?eRD/YyLbHioLcqM93YiaTqFJPRI6t8AqQf02V5WOZa9xnvAg+sDihrSUIIu6?=
 =?us-ascii?Q?9yIa1SzPzIARoS31EaiEJKUTU0nFYWrpJ+GiiNQtErMmAfNnWOjInyfPmku/?=
 =?us-ascii?Q?dMQqiLnP0V640Ms53CVUmKLiCfcwJyhIN8PEegwE+7UF1HELCX0ovkL7OCgb?=
 =?us-ascii?Q?iCz6XfgByYZS3pCc80YNdxmNssDifv8+BL9E+kk6rD0n1ohxpZxLfvUNoNTV?=
 =?us-ascii?Q?XEvOUD689XbnsJdtOOlkzD/hvuZGk29mclTyOw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a79de4d-dae3-4700-a1c6-08dba31ce3a2
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:34:28.1017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1847
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

Although PCIE driver already exists, board defconfig isn't configured to
enable PCIE enum on boot, thus USB storage device and NVME drive are not
supported by default. So modify defconfig to enable PCIE auto enum, then
start USB subsystem and scan nvme drive on boot.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 configs/starfive_visionfive2_defconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e9b63e5b84..3002c96f0e 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -30,6 +30,7 @@ CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x82000000
 CONFIG_SYS_PCI_64BIT=y
 CONFIG_PCI=y
+CONFIG_PCI_INIT_R=y
 CONFIG_TARGET_STARFIVE_VISIONFIVE2=y
 CONFIG_SPL_OPENSBI_LOAD_ADDR=0x40000000
 CONFIG_ARCH_RV64I=y
@@ -43,7 +44,7 @@ CONFIG_SD_BOOT=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 debug rootwait earlycon=sbi"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="setenv fdt_addr ${fdtcontroladdr};fdt addr ${fdtcontroladdr};"
+CONFIG_PREBOOT="nvme scan; usb start; setenv fdt_addr ${fdtcontroladdr}; fdt addr ${fdtcontroladdr};"
 CONFIG_DEFAULT_FDT_FILE="starfive/jh7110-starfive-visionfive-2.dtb"
 CONFIG_DISPLAY_CPUINFO=y
 CONFIG_DISPLAY_BOARDINFO=y
@@ -124,4 +125,9 @@ CONFIG_TIMER_EARLY=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_PCI=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_PCI=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_PCI=y
+CONFIG_USB_STORAGE=y
 CONFIG_USB_KEYBOARD=y
-- 
2.42.0

