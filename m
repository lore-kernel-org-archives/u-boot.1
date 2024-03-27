Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62EECD11DD
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6EE880E4;
	Wed, 27 Mar 2024 13:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="JrXU5Zyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DFED880AE; Wed, 27 Mar 2024 13:12:06 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FA6880A6
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgxG9DD2MWbphpBNYu9pR5jDsjS5e/fWYYFqFkxOyrwSxDA5c//fnbhYBxSEmWw2SLBEzMYd7u7jI1jnE3bBBlfdGTAVJoKX3ceJB3B6f+EaY2oKgS5zyHcYjcHrHzM//GIWLMOw0MKQbHnzPsGwdUVlalI+YWPaTLsCTEUsgyzY5L5EPCVOpaz9FJvAHjHgehiGUSu2iOCST9WR0OH2E9Z36Fd5z0/B3IvbAXdHbj5oUN3Uf/OZcgQH+43ZuXL+hKvfJF1nP7MwDq4MNoTznStKuPBQQ83ztFmhRHn4GO4uHmcWw2rwF85y6pIxuXWANsde5z9yREmq6pxiuw/y4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39DWVu2TwmxaWGyz359fpu7nMFGm9ZLgrqgc1WZ/xkY=;
 b=j5/ZOuUUHSbB4nQkneswjP31fyWAs6fTtjStkhNNljf/iyC8SuETHpqVD/3rOLYTi+v8RsLv2iBm8SsWIlC8vGAcTEzxRZMSf99k18RUYBLEi0BKegGq04TkUCJci8NbSZxkpSM85BL1WdeRZsq2cgSqNr+LvajLcvrM+p/jtwZSq6iXSMDJEbHhZEIp46SSl6zY/sBQmpSsw/xo0jlHDkbAT+5i++0jyPATqgJSnh+qOihmZcVLN0MV8XPHTEkpjdolQXDFZZ7WxmgD0j36nKYM0tIFq9e7py1C7FcFXhl0vfRdQEJ7MEF0E2E7ZxXeMiXJXrvR4Jem1K+E/UW2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39DWVu2TwmxaWGyz359fpu7nMFGm9ZLgrqgc1WZ/xkY=;
 b=JrXU5Zyl2U89gNc31VhhiW6bTqZqO8lZQeSO3c0HKzWKa2aU1v2gf97xrFPN7+5CSq9C94TzJEAUYPaJmWj9wo0KxQg1LFKjRV4lOI0eeqg4otlXj833A6fxddlkomnVTdG1sxW4RmjuGGgpZCcRgq8eIciAemmMYwMtNJFYHjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PA4PR08MB6303.eurprd08.prod.outlook.com (2603:10a6:102:e5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 12:12:01 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::d003:60c0:6918:8a5%6]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 12:12:01 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Devarsh Thakkar <devarsht@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Bin Meng <bmeng@tinylab.org>, Chanho Park <chanho61.park@samsung.com>,
 Jonas Karlman <jonas@kwiboo.se>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/2] spl: Introduce SoC specific init function
Date: Wed, 27 Mar 2024 13:11:52 +0100
Message-Id: <20240327121153.2455126-2-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
References: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PA4PR08MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4ace43-13af-4414-7726-08dc4e571b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2CHMwt+2+nTRHLhW8Gj4XalBXpQDc5WU4n4BYAuE9CjrjLiHlMWiTHHJS8+DV8nTkezA/2d6U11YGH8PABoo9rNbsuziRW7yVqbCfbGoQy3XO9vEQOXUuTiRK+OZot3vVXvN+PJ9mWG3778L0HxQILbb+Pb1ByD9AWUEGH6P3Jy4nSgeh9jUPCSvwKJ+EqzHsLaHHFl9iwtyAoKBRoi5xpMODxCJfGPVdDn2b8GL+zwZ8sZIuJF5/YDojuPuB2w6YVshzvrheN2pCPtPaykrMl+9sSxmkFjvav0yfIqli9sXcDTONAhE9uuL3iiJ48IwrupsTdA9sOhOJ3ZRMQ8uvVHqWTn0z1N6nWuG7viZU0C+1aC7GMjkfyDwbGwFHAM44XQzvOCbyuRh37swkFExra+CXUeHNWmIjl2LfxBeNB1GpdAA0OawlgPkWcnmpKpvToI5xvfbGsPmA/lWELaaqZc/J/Xd/dOV4VCCek8Z80oUtqqKA3drLUAgYS5HWN6i/J6NMlgnTgCgVSgws7qYcaxCWooYG0kBOq+uBHP9ZD9v5X9R3LlEcysW8Gqpb+0hdi4FbpFg+dORp/4eWr1rCorReBaa5d2iHxIG88YoML3TPDW/mp3eGqO77yVb123oj2Ip8MDeBwHeO7+bEnwuxX4PfF2dPz1lBAEpByTwYBEi5Bu7khWwmlOxCIsIx8H9Z50ej+ZCgU5JGT0pJXVUZE5USN8jwJcxFHOSkx/UGWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bm80x2LBT2rvTog77o0vNpZxc1EKMEOQhBSK1lLTmjJLZjQx/aWtY//HF+Ao?=
 =?us-ascii?Q?l2S5qhDF2JwSaNC/33368dF74GC/xfBkAPc/DYJmRlWK9UzHitoVqxkM7WTk?=
 =?us-ascii?Q?ywSNPxz7BTRVYmk8DAceApbYpepIvCUjHJpBece7JMNXzyPHE5/Z+cx22STm?=
 =?us-ascii?Q?1J3jX1LEqGWQjp6Wzyh88tlSe99rAZgZseqr3lFZvq0vzfI/aNq3rXIK83yl?=
 =?us-ascii?Q?CkjfQyhn7nU0UqUQc4sGJ7RQvYtDykwIAcfoS1Ev1vVhuEmmu1zOpbcmr/5E?=
 =?us-ascii?Q?fD96Gy5uI4zh++dp6trLDv63du3xtEU1UFXNW1cDqBSiyJT5puQtRQyZfW5N?=
 =?us-ascii?Q?W6yuLhr8PcZrqaRaGOYiGVhhbO4qFY+LJWJvDKmM8DoPp6ulkLUV2bCpFfSO?=
 =?us-ascii?Q?WubakmxUGb/r/QzQ9XBshLkwSydCYfzbOi8yTmxTK8c3N5/lszP9TBR7HqIB?=
 =?us-ascii?Q?njH76s6qiVzCd8iy9KikQTiQmmuKha/46e8l5+TJHuG2L5v4+VNkHd54iDP7?=
 =?us-ascii?Q?c/dTVkabVFfrvWFBfVCXZeMCzneipDCPH7sB4DcnaqAyXdkPgdkInHGvoQRA?=
 =?us-ascii?Q?s5zvBW8NxDKduKh5tuUPyvcoRG4Rv2F0Ggt3Fno7pteWtc9MQXZBGv3dNx8A?=
 =?us-ascii?Q?VlANPFopr4Q8JFcLyCIAMSOUXIQFi10T3U0psVhTvmxA1IYLPyZfp6uKEr02?=
 =?us-ascii?Q?cp4Y2EmAOU/oMUe1EJe5OUkAX+wjDCujUdfTuRV+gR5DTbx9Y5gkMQcc6Obe?=
 =?us-ascii?Q?knROgWWytE0VKe8A4UI5TgLD8bRzZ2vb5N0KiiIjxhGFkf9jUV2gAtbHc2bg?=
 =?us-ascii?Q?6geELi8iF6ndhFuwUBNv56hEtVf7XDxdKg67a+xD4AoHRAL6W1D63sjJGjPk?=
 =?us-ascii?Q?/jjxPsDp+DXmf9tQr2FS20KfQVHvIUEfPvbiusU7DJ00dHmEmiGeN9BzNHkm?=
 =?us-ascii?Q?l47jWs04gheHz6NaJJvTiLeUc2BNyX1SMMwKyPD313p9/qnwO1gwqMnaJ+l8?=
 =?us-ascii?Q?q5Fnams6fRh+j7lX9dG5Gji+IE+vZ45I6oD146ud63vKaHdFinOt2zq30mx6?=
 =?us-ascii?Q?j7e+lgvE6Xy/fCE72rYxRcUYrEvxg3XZRcq1nSNEkEddsLsELxfwhQ8bMd5z?=
 =?us-ascii?Q?Ftjb8O/+ccdK2S54V+M+4hT7pCMGU6M5eHbCjpo40PZmnSY9BpQpt3RGFFVZ?=
 =?us-ascii?Q?8snp2RxfIvxeuf5O8OQlgL2ObqKleBB+h6mLIqc2UKgi7EYi0R4pT4ifSpLR?=
 =?us-ascii?Q?erqnPHcR2VKGFWIbMc4LVCLuFw4OvYrWdotQKwUhtgmnCF65LNwQOWpfY85m?=
 =?us-ascii?Q?ARyahBBBi14y570ZcQHOpt3smFRyCenyWOguklu1DIN6qJe+oaLJf18587x+?=
 =?us-ascii?Q?o+qQTEXS2bRLxG9uVjFAEvO2mO/kP6RWSApEqaywntRZfxJ9GykPyJ/gvPTh?=
 =?us-ascii?Q?dfyGr6he3oo1cwqHUEYw50i80bbj0WRtyMLVniKee+mLSv4tsrEig2kU/wRp?=
 =?us-ascii?Q?cxMy7GxGtTU2dcZPq13XIYJACj9CUYhNgHMWCVMGAsUsFCEgnw1itqkxcbtk?=
 =?us-ascii?Q?wjCVI6bYiNZ02a0nkHrKzvfS6KGyOpWi/rTyGFKmZbcxRSS3DzMIB5XXIVDX?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4ace43-13af-4414-7726-08dc4e571b75
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 12:12:01.0449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/wRWNnzBBiHn3259VL5AYaRJyFYLkeLr9j/BIdqcYNH4MzWD+4PB+YPVHHPXwfZ5tp2quwAIUCGGAFnISKiBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6303
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

Some architectures use spl_board_init() in their SoC specific
implementation. Board developers should be able to add board specific
implementation via spl_board_init(). Hence, introduce a spl_soc_init()
method which is called right before spl_board_init() for SoC
specific implementation.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
---

(no changes since v1)

 common/spl/Kconfig | 7 +++++++
 common/spl/spl.c   | 3 +++
 include/spl.h      | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 6405374bcc..eece8e58ce 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -272,6 +272,13 @@ config SPL_TEXT_BASE
 	help
 	  The address in memory that SPL will be running from.
 
+config SPL_SOC_INIT
+	bool "Call SoC-specific initialization in SPL"
+	help
+	  If this option is enabled, U-Boot will call the function
+	  spl_soc_init() from board_init_r(). This function should be
+	  provided by the SoC vendor.
+
 config SPL_BOARD_INIT
 	bool "Call board-specific initialization in SPL"
 	help
diff --git a/common/spl/spl.c b/common/spl/spl.c
index b65c439e7a..9b83c85df5 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -711,6 +711,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		}
 	}
 
+	if (CONFIG_IS_ENABLED(SOC_INIT))
+		spl_soc_init();
+
 	if (CONFIG_IS_ENABLED(BOARD_INIT))
 		spl_board_init();
 
diff --git a/include/spl.h b/include/spl.h
index 043875f10f..5dfdf778d2 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -816,6 +816,14 @@ int spl_early_init(void);
  */
 int spl_init(void);
 
+/*
+ * spl_soc_init() - Do architecture-specific init in SPL
+ *
+ * If SPL_SOC_INIT is enabled, this is called from board_init_r() before
+ * jumping to the next phase.
+ */
+void spl_soc_init(void);
+
 /*
  * spl_board_init() - Do board-specific init in SPL
  *
-- 
2.30.2

