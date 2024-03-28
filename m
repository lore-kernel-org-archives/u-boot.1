Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06929C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B2F288118;
	Thu, 28 Mar 2024 10:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="wN/4RDQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C27387D55; Thu, 28 Mar 2024 10:01:28 +0100 (CET)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0716.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::716])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB0887E75
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsQN44LbMCHweChVTOmdxvyvhtskeEfOsKJKj7Abi/Ip/GEWVmVjR//0RJfhidx6xxqb/ap2XCm0zBmSMERMnJCvtp7uI0M7nsA2Ixd5FsuIsumaQzRaxBqyxqxf5grT9jFwt85HGBjgduClL7sjnNi4BK56ItFamapKe+VPnXEgz4WUk99MebQRQdeyCzvKsN3OqzzxbwdFHvfslZMq3CG/I2LQX4c9mPx6iKLQEkI/cUzhwjqMEXfcxwhiVP6T6Bul+W5jcSyV6TBXdY1FviwMUjj6sGTtYmoEJv6ofbHsx/W2PL0SWJmzuLoojWsp/flWXUVfgdi8anq2FjQcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RPo1CVA+4QAifDFyxVg3eBTwzwJhoCKJbVSepbEETU=;
 b=Hpha56mFV1+GpARoT1VZkDAUhHcn1fwDFjuztUI/hFHMnmAnX5DQNaD8EHhXcvHV6naVPW2r39YGTAu435+iGapfIup8LzMe8vAdgJQWn+PjMfpb6WvX2n5/kqgR5yCm7NabEN3P7X/bAZsveJVPU1h8k24d7mVAxOJVxklfmbk2Q/TGGhmyv42XC+K71PENOEx7W6J4bPcqIr+U4yzCx18PnH5ftUFbuVJnsvWFgZ2RvEZlSShMNmz1a+45TzvuTKhSpPylwh7tdNhI/nTA/da0GovvEbCiF7aY9seHGWfggioqrZbFydHtEU56Bd2lRg61x8GG4WGndY/J4nllWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RPo1CVA+4QAifDFyxVg3eBTwzwJhoCKJbVSepbEETU=;
 b=wN/4RDQ2Yg6KGEvMFn0XDb6+SzNg4hrZEWCtGtLFDyF8vFbcKG78Ac7Hz6KLRWNKv+g7S0kzruE8DgRT/qopMahd2ahWyLOfskoxA+Vj0W6HgAUCTRdVmc8q+q8Cs9cvseTcJnSCAxlR0HhS0Y8QVkCyzB8N4Yel0P7Jwh/F8G4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by DB3PR08MB9035.eurprd08.prod.outlook.com (2603:10a6:10:429::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:01:19 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:01:18 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <monstr@monstr.eu>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] zynq: Add function to lock JTAG enable bits
Date: Thu, 28 Mar 2024 10:01:10 +0100
Message-Id: <20240328090110.14683-4-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240328090110.14683-1-lukas.funke-oss@weidmueller.com>
References: <20240328090110.14683-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|DB3PR08MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: b89d951b-a817-4920-4a85-08dc4f05a1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yk314EwRJcb1pKsvwSH1EkqeZsIv7tMWGncaTn29X0t83JAqSdqVeYrVt1zpt6iaQVPsY44OkrNM+37Tqj6t/duY82F+Us/epspGMmXXjaZmYyX7Tj3bNKYePo5W48XWtD3KqHSk2AynOxYYCPxdyZGkVyfxDJDFOCHz1/VnXzMvX4+QWyWJEl5rLLIYAZS/n1TUgLtAXCsVt4jSqbN+VCVK1SABE6sQG2o0u5pu8xKbkwwemiK+ntvUJGNsrJ8D+wtaQ19F7Gt7gyFJf2VRdEgyaC2Q5AviEX3Mo5s8UvwmqOyn3zAJGtpvx8HQrsLti70HkOTVltZAzego+YtYDuikBl33GY16j3G9XjuMOsgzIBRQepPPpuUTiY6omWCc96DLxfW3SabfUk9RTM21imgS1ncaigmx3sl8wTMvt73D4Xd394dinCU9lEseDfDlj8YdB4Z09zG8O8nGU2fY7YajkZVREz6yaldnPFXW3wwqJNT6Bic0B9NOvoQDqliq08Tiut6W0gh5DV2OJ+dXx8OnfsRx1U8sdtRWA94uLlA4RGpdolkqW4MBCLgSi9BzMlyYeDxfD7k3JW9X2pdRquaioDGfS5u9FhSx5qUN3u88LcgZPAmaqZy4vA9QGPtumvIwNxGVvTAZhYkSMb3H1Bokvrhzwb5ImmsyqK0EtvMlEidfLv3nbQZ3kPpNWxoN1IUHDUOpjXiC+mgyZE4nNdiYLlRX7XjfyUNX9mC0z8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c30JQ+SDaBFrNPf2fSyWg8ZVPoZCGNw8bMiM3edK0fpINKieipKQPj2gllSs?=
 =?us-ascii?Q?AeW1RgUeZ7QEETUi0xoXGSZS9v9wHOTL3YsodAUtCe9MmjvY8Iu0ScQCfGrN?=
 =?us-ascii?Q?t+ayDJ/fdfzcM+rpqK+N4CL/CsLZ63akCN1oeYKOQCVjyQL+vtqES3H3eOUk?=
 =?us-ascii?Q?g2zNRZvb0kKMYzLv4c5+y4V9SVhY9A6kXiT8DxOXcguRIzlFaTXzGtoTecLb?=
 =?us-ascii?Q?8CRLPBZE4JC5c5yUcxXfV1acoBx8QP8xszsQERkYSl19MtoyrIyDTVRzOIBR?=
 =?us-ascii?Q?bYoH/NAkdbe0aSaVBjp0qn4ZyAMY5r8c0v2zQw+hZIIj2pYWHQH6+hjByfWM?=
 =?us-ascii?Q?BgOqdG3BM+gn1ubrNRbLaKbN8fqGS8hSX9FTx23k4BDGsfNZSFx2r9yjG/LB?=
 =?us-ascii?Q?JYGMe2L7xSVBryz4A4HMB0DBeMpOKlWcGwHoauO5UpxyIX1TmHEdoIRWYuu8?=
 =?us-ascii?Q?wrPEYUPwYw9iXmStTZ5bfAfuEUXCsNVnnurakkSwWK7BYdhhzPMB+Ul+xBxC?=
 =?us-ascii?Q?ve4Ffg1hl/BOcs2G4IiNP6NCHMy+nm7xW6A9/18sOO/j/Whjp7TIUBtR0ZC3?=
 =?us-ascii?Q?cu2tNJNzbSndvlmri/DypBFzRQDDpdYPj2FHqy3WrIszjEvIN22KO6A2L5gv?=
 =?us-ascii?Q?dKM4kHE6N7lgBCPSYNVYIQYnoq1japV8hacEfu6is8XfHtsaHUQXODaRHmYM?=
 =?us-ascii?Q?RSYbuLPG3f7ZqtnxxMsy5tcnvaEa/LmS85p/dnkc6rXkLkO4JLfN9nhm2Xij?=
 =?us-ascii?Q?L8XZXTVuS4p0OLoNJSBxUbnnar0AZbGXhOHIYvk8PYUB03CamdlwquLQeXwF?=
 =?us-ascii?Q?iW4xmeRcAg35v14FJ2QZA9lvN8gRxW9jpl6xWLetSG/I66M0BZ+lp8E9A7zr?=
 =?us-ascii?Q?g+xBaOoPL0C+3pbfCI+SR9qaWclASSQPFVTzXja4XXfc6id+0o9Ca+1PBStU?=
 =?us-ascii?Q?9/z7L/6Ogp7kEohEuc0zAjfx2ohvHl0cuQZjGN6DwM6kdiJAJhgnLSlosfuP?=
 =?us-ascii?Q?t4upIjZwaE2k+IqvCoj7jmo/cJWOgiS4h5wVwpnDmXSjXX48DdmSsdyPCFPq?=
 =?us-ascii?Q?taLvQbRhu22eR5XAlYbyn0cLqDCj+jrChvwc3mwm94wRXF1RWSCsMzD8v1Hl?=
 =?us-ascii?Q?x5atF6Hf8YOY5wGqiEBzkN4gMCyj1AEP5niEhSSreG2bEnv/iqKbGwpp+0n2?=
 =?us-ascii?Q?qghjowGMXeelnQBiSJyfCfxcSjnBg31MAAqXerQr+p7wsS3P1bhwHnIofFJ+?=
 =?us-ascii?Q?w0AltNsfhY2LT/AXntZJ9j6bnczPddHJ/AGp+1/Zr0dAj90Pr9Fhwp8KeU9t?=
 =?us-ascii?Q?9ouk0TaPfGbYgGwKUTStlPDPiq14++EbPswuOV9vAEvW1zsCrygrb5nTfTTP?=
 =?us-ascii?Q?1T7letWBLRqRCGNWpOquqw7t3QmL+PNx+WToBnjHVz67PvtYpUfNitYmYrvd?=
 =?us-ascii?Q?gMKUY4yQz2dlRnQa7oDD4kWQmM6+e2QvYKWZhU0hrSa/oMNiUy98GpGaIIHP?=
 =?us-ascii?Q?od1wHOII03U3jMdL+TZM33mSGhbnkMZKEPXOO+ouKRCux7rG8kobr0MFCRhE?=
 =?us-ascii?Q?pPtlp9annjyAS4m4ceIPz0LcJYsVB7vP51MlzvhaAMCuPsMImjvUuF6GlshL?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89d951b-a817-4920-4a85-08dc4f05a1d5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:01:18.9096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyHaHyStO2oUWhGBYr+EWKlt4Z97mdAJUkCkBvD8JK/pB/R0C3QNa9D8XRAG4TIWRs1Yq+fKWRDGvnTNIjlLdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9035
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

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Add function to prevent debug access from being enabled. If the debug
lock is set the debug access cannot be enabled after a soft-reset.
The debug access can only be enabled after a power-on-reset is
performed.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 arch/arm/mach-zynq/cpu.c                    | 10 ++++++++++
 arch/arm/mach-zynq/include/mach/sys_proto.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/mach-zynq/cpu.c b/arch/arm/mach-zynq/cpu.c
index b8d413b69a..e6151bc21d 100644
--- a/arch/arm/mach-zynq/cpu.c
+++ b/arch/arm/mach-zynq/cpu.c
@@ -20,6 +20,7 @@
 #define ZYNQ_DEV_CFG_CTRL_SPIDEM		BIT(5)
 #define ZYNQ_DEV_CFG_CTRL_SPNIDEN		BIT(6)
 #define ZYNQ_DEV_CFG_CTRL_JTAG_CHAIN_DIS	BIT(23)
+#define ZYNQ_DEV_CFG_LOCK_DBG_LOCK		BIT(0)
 
 #define ZYNQ_SILICON_VER_MASK		0xF0000000
 #define ZYNQ_SILICON_VER_SHIFT		28
@@ -93,6 +94,15 @@ void zynq_enable_jtag(void)
 	writel(v, &devcfg_base->ctrl);
 }
 
+void zynq_lock_jtag(void)
+{
+	unsigned int v;
+
+	v = readl(&devcfg_base->lock);
+	v |= ZYNQ_DEV_CFG_LOCK_DBG_LOCK;
+	writel(v, &devcfg_base->lock);
+}
+
 unsigned int zynq_get_silicon_version(void)
 {
 	return (readl(&devcfg_base->mctrl) & ZYNQ_SILICON_VER_MASK)
diff --git a/arch/arm/mach-zynq/include/mach/sys_proto.h b/arch/arm/mach-zynq/include/mach/sys_proto.h
index f583ef090d..3377fe2c23 100644
--- a/arch/arm/mach-zynq/include/mach/sys_proto.h
+++ b/arch/arm/mach-zynq/include/mach/sys_proto.h
@@ -16,6 +16,7 @@ extern u32 zynq_slcr_get_idcode(void);
 extern int zynq_slcr_get_mio_pin_status(const char *periph);
 extern void zynq_ddrc_init(void);
 extern void zynq_enable_jtag(void);
+extern void zynq_lock_jtag(void);
 extern unsigned int zynq_get_silicon_version(void);
 extern unsigned int zynq_get_mulitboot_addr(void);
 extern void zynq_set_mulitboot_addr(unsigned int);
-- 
2.30.2

