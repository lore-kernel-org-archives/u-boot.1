Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E786C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:20:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BE088089;
	Wed, 20 Mar 2024 14:19:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="D+/G6ZMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BDE680EED; Wed, 20 Mar 2024 14:19:43 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E896488063
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5NroxCiQAVjwTXTCXHZcrA9mBZmIXGLUiMr3YYNbrwiO4rjZvC7f8avgbWSFyhGpUl0KBTmO5k9tNJtmUuaVHJ4g1+qMuTzwlVvM5pAgA/xBjBtZIKcRCbDf9nlkeVUThQcTWJ0C1jRrdLpx/Vo6hvoLbXNePUpHzXe9yQSbKEVAqtemLJUsBHDxuET3cDgYJ1Uks6eIk3H5FDq3sQ6HWKgrc7ZXMHoKwk7icXWzY+afhFZqE2Ui+haJDD9nq9NJeroWvv0D1sPgIfHkLOHRJkUClEwpcQWijTvQ+mwmOBqvQDm9fnumWH02YTsK1qz/pTIJdLQh/LGB83n6fYjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWQAydB9nL4UDzRkg/24P86r9EhyuE58fW/EgzyJD8U=;
 b=QBEOUEWIxxaBvgaP4blIVXjbpofYY5UJRxkverZgScieOpx5LCRCoSEFPaS3XqrVyABZjl5KQzFTT0ftnqa02ovcUdBOkR8w4mIBEGPBhzAA8BjBOUINUcIn+ikUFNdaePPlDyAq+3N1gHrItu0+smk2tl9M35yx33dgsHWNknhAdbkEczP2m4aVQbBj6SXKS/BUU6VDpMPQ7SJPeg0UQSueXez/ks10n4eJaihI6ZKYWZc6Up2EpzUmAoIaWDHVJxx3kMVRbOQ1OmjeGeNkTlJft5onJfRwPRrdhvizAsnbSY+j7mtvZRgomcttLfITgOQDAPgMbwosFtdzkfhdtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWQAydB9nL4UDzRkg/24P86r9EhyuE58fW/EgzyJD8U=;
 b=D+/G6ZMAHGXukREPdaguDoV7ATiD/6tlEdIeLDLq9AtQ6Fj9DNNCMR4dAjWDPm0vSvYCS4T8gM+oCS85OwoEi0C4efUmEhDgMgB2P3/03f0mSb+xXbe5ZPYsaO3do2k0OILRPOCJI+a2UQ4GsoKNu6pyrcSU1Sz4QcDaaMzf5K0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GVXPR08MB7797.eurprd08.prod.outlook.com (2603:10a6:150:5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 13:19:37 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 13:19:37 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>,
 Chanho Park <chanho61.park@samsung.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] spl: Introduce architecture specific init function
Date: Wed, 20 Mar 2024 14:19:26 +0100
Message-Id: <20240320131928.1836386-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
References: <20240320131928.1836386-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GVXPR08MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa9cb7a-b2d5-42bd-506e-08dc48e0646b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IOsa0t1OJd9FlPbsMfxUWe4YEz4BitXrnti2OkUAwBOS9URb3xArS1iya/XEmlaTQuEbtyRWzPUhwYvD+lW5mUfAH+DYJ07bzcKErRfI3tRRPr5w83c2JfEvuIaNejQSuDPVB7J8XkPBZn7sQ3uBlq3QPlnA1mm1CN/VcfWHFm97+Ve4LP+ncZRC4PDOGd7hRPo46g+2RSXaWEDBPoWBE1UVG4nO0m0WtPjynrvCvendmoe5qLlEAQpyEofnrYYaLdB8UCU2O/U1D9FH6k1tqdC8SbBfiKchQDJPB+0mqdvNyboZM7UOBXEQ6mT0V+WRz9az8L0/4OzWzT8DWCYHk6kbKK+lYuQyoRu35ppzIIBtuCe0IQko++xW/x7eDtxG3BiZ4+46qsavLdrqDI6cPnGCr0ey4AKxke1LU7lwpcvny87kSTiztsiGrldyA9bAPNkeDipzTmeba5NVVEhqUyCr+FbY/xDEa3NWzbPjy/EhcVwm3rUxq2h+BAGE3cfN+ASMwRCGT/zXViJChTgoDtGjobh+ybVcb5JJ9uHzuwORTG76yBi774Yt1QN7G3mI7Bm5v2UqYT/BD9V4+DDVMp5X/d7FsTWiQQKBNA8knXCvyksDsIbzKX4NWjx64G5Y0JJZ9eNS0xp5MaH2MTyFwvejdwXBSlupjvXQjJ1Wf9vc6R34F3W1BdSfjG9UNWxTNspCoFtzxFkFL7KThiylW9HBs+s1Q2Xm+uYNaFAfauA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yPm4vZT+O+Z8ARw7fdDtyK0RkWLxcV8eF6MgVGYl8Umk9KSN8ps9eAmhTIXt?=
 =?us-ascii?Q?3zK3VI5zmYQAtCd+FgS1vgyc+4i8hCCdX9s1e/EKhYl9TNPZNQyM2JTP0R/7?=
 =?us-ascii?Q?YmIceo1v8iIs4yc8+87750UGZeF7VAs8ugj1g9/Q8Aeh05cy7xc38WfllBFB?=
 =?us-ascii?Q?MkBioiZA3t3sz60SjDj1irdvEYgQD7Mt12vMSfyiYR2tAUnsW/8NwWwE+08K?=
 =?us-ascii?Q?73VShPLRB4e+LVok0uPDNJGPiNre/Wee2d6hOTyKpzO1NJWFC7aT0EnBc9P/?=
 =?us-ascii?Q?kFWjMePt5v1Lfj/Y4jokry80Earhs9GdbFcZbLFHIw5+v6Lc742qoUxJMb5M?=
 =?us-ascii?Q?KgGQJoex/roq9ApLbVATXVLyUvroZGO9DlYjkCNAGgezt7joot7kAsVWaIZq?=
 =?us-ascii?Q?sddJXHRc/L8ybLS8e0SdMOjGoe8Ihw/ikDvKkMmL9o7bWA/3Da4WWv/Q4Dgu?=
 =?us-ascii?Q?9FEks5W0FAokPO/MTcyFT4+o+SwQ7m3sUa+dzLbJAQajjpBblpWjRw9qL6IS?=
 =?us-ascii?Q?FDSYUWywmvjjSsRf/zZrK7WVpY5z6nF4w9Xt6nr1Cb1oOi3vguqSRRn9IbfX?=
 =?us-ascii?Q?u0roOuTMgsYlK2pTWnOa3X/KoW0y5+IdxT4OaTDnUB/r3QqWox0wWVZtJ8HU?=
 =?us-ascii?Q?9U3OC4njtPI9TKoOMTAKWE17DihzBhKYSm31SRShYK6AmDHphYfeKLwcaTo6?=
 =?us-ascii?Q?o1datK1saD6Re5ydIw7aGbJgpYCPmLkgCB4fyDrRE2xLCBVnaq2A5bo4YCVD?=
 =?us-ascii?Q?fsPRjOpt6qFgRDV3fV2xU1CKkASIAkVtdmWHg2Qai19jt4JIWZjPdZURKeoJ?=
 =?us-ascii?Q?WaPOzpnlXvMyrym6v5f3HjeJLgNv2HlXs9mTzHyLxsbNfsjazwMSRTm70oAf?=
 =?us-ascii?Q?N2RnaqqfJ5mDP2O2jwbdCaWI+2ldL8N96Txu0PKwmd/XpZlJgKI91xPNWzuV?=
 =?us-ascii?Q?UuM/MLvK9SMjmhJhqG76OD/4xuRCdgY+RlLrHqwdY6N/POPsM0eGXBIo0HpU?=
 =?us-ascii?Q?Sld5OGQ+/l68Jk6A7s6NeK3q61vMHXsEhyjbCqUKLclPMtaee7LXgWgWLxpN?=
 =?us-ascii?Q?Hls0zdLOA4o6nN9yix9EBQeY/9VaiM7MQrDAFTDRZjgVazcbUIX23KJEqpnr?=
 =?us-ascii?Q?7HxdztQvWYlZfKHNld28diUkDXh06OuqHUIC0SzZ7xDbZYAw45vgyt5BJMnn?=
 =?us-ascii?Q?rPyvkew99hj32eZ7P6aKbzbCA9PA5/okgP1DxCXGH9r7biWQel0FFbT//xzk?=
 =?us-ascii?Q?VEbqN8Oithvl07zEkez41+jwadH9HYK28A86MvN/UCeTpCwpXZadSVrNY311?=
 =?us-ascii?Q?z5Gs94Y68ULKkKsJAz6Kapv6GGjrhjnO8WUQSXXaxn5U8sSoVpzt1x670h90?=
 =?us-ascii?Q?AdkgZ7cqHQWn7qMHREJofZIbq53xrV1eBX6Wh6uyQw3KFUDyfw5RqPJRXgK1?=
 =?us-ascii?Q?fpzv7giGz/x91hCVNOaRbzksvsmU7Tb1seEJ2HqJ2F81qHzQie6xhmodG2TU?=
 =?us-ascii?Q?udpwaOW952gfcut+FrVCkeWwseTfdQPq/OVYStsCuzyzizYfQKIUduXTydwq?=
 =?us-ascii?Q?35WtUjQZigm872a2OSvV3+QNvOhfsYcOooogmNwcEdKdzVyJTnxBBgwM9dZb?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa9cb7a-b2d5-42bd-506e-08dc48e0646b
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 13:19:37.5695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAkKsCuMRnw3BWpcKlH+Hu8w01K1T7hDkizaUCalJ8qRwJGSNlOhM2fiZZz+w8KuwKkfJNFPc91p01VLqHnN5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7797
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

Some architectures use spl_board_init() in their architecture specific
implementation. Board developers should be able to add board specific
implementation via spl_board_init(). Hence, introduce a spl_arch_init()
method which is called right before spl_board_init() for architecture
specific implementation.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 common/spl/Kconfig | 7 +++++++
 common/spl/spl.c   | 3 +++
 include/spl.h      | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6405374bcc..1a987037bb 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -272,6 +272,13 @@ config SPL_TEXT_BASE
 	help
 	  The address in memory that SPL will be running from.
 
+config SPL_ARCH_INIT
+	bool "Call arch-specific initialization in SPL"
+	help
+	  If this option is enabled, U-Boot will call the function
+	  spl_arch_init() from board_init_r(). This function should be
+	  provided by the architecture.
+
 config SPL_BOARD_INIT
 	bool "Call board-specific initialization in SPL"
 	help
diff --git a/common/spl/spl.c b/common/spl/spl.c
index b65c439e7a..2f2deae14f 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -711,6 +711,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		}
 	}
 
+	if (CONFIG_IS_ENABLED(ARCH_INIT))
+		spl_arch_init();
+
 	if (CONFIG_IS_ENABLED(BOARD_INIT))
 		spl_board_init();
 
diff --git a/include/spl.h b/include/spl.h
index 043875f10f..2d23c8c0de 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -816,6 +816,14 @@ int spl_early_init(void);
  */
 int spl_init(void);
 
+/*
+ * spl_arch_init() - Do architecture-specific init in SPL
+ *
+ * If SPL_ARCH_INIT is enabled, this is called from board_init_r() before
+ * jumping to the next phase.
+ */
+void spl_arch_init(void);
+
 /*
  * spl_board_init() - Do board-specific init in SPL
  *
-- 
2.30.2

