Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8244AFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD1ED846B9;
	Tue, 28 Apr 2026 09:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="O1krwH63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1546E84178; Tue, 28 Apr 2026 09:01:11 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E876A83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elhDtxUX1uUuMtoKej/Ob8XfCGaaYgsIyDWJyX3J+AVZr3HGBglAebLGUiC/gyLDETRBaSPadPNp1pQel8Me6RcnhqAZf0W5geVE6HKnMrY16yy4VUn38Yy5quzx0SolZcAB9XYuBc2JhEpG4BQBfT/i6dotDB/R64cZxqZ/lmbJYsfOSYypihvKlSO6kHbRR21ApJrbE91YbSVjDvsWZe6OV0Q/Zbx4LpFd9ePJ93e5Mztw7DYF7xYqHe3lBJcY9M81fr9GnPX9y3vqpU9AtVspvzSollfbgu8WitcR8ZlVgMMZY/snSOOhdkk2B6ItvSwvcdhvhtKFrjntrKBszw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spcJVjm3JUIIh6fpVOL+UgCbshLXKEEgdqC4/i1cPHU=;
 b=jhMgVvq7/lKTOihKu7glgzvsubktEXPeOiq6jDGvOdg/zruVoAbCK9LkoaOrRUMAVqjqi6VK0ggNOm4Ull7biNCwFqeAWWB7lmZnpOvw+arBaypalsJqzjST0sJkaERzF0BAuxGf5PvjamN1PMdC6aMC8PA9QSiL7wa5a1FjX1vsO+KABoabNdezPUVI5kiod/FC/A3gOmwUNwS1Cg+VATMekwWkX/f2QdI5K+3bBOacitYAxcypzVniyc+n3vlEx3rM/CBvyJyh+0HplhwbQedX3eTsUlPuAZAFDE5dfzmz54sqK5KiozYWKzvNoi7vnsLope9c435gnXppik2EyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spcJVjm3JUIIh6fpVOL+UgCbshLXKEEgdqC4/i1cPHU=;
 b=O1krwH63ziC/hB+LZv+MuXN6Go3FNcAajRJDzfZ92uyVOtS91EvjSsG6ixgqL27t/lrdmeJtmVDcmD8GxVxWsyyUZdR3AOOAcRfSj3cUkHQ7HMwFWLmG4HdtT7gUfuY6xMThQ5fLWk8Bvy4fuSAE+kVwAM/nPclWP4Do5S3k+bIpMabiqzma04HSlH0r/ocjzeJl/SZZgna/9szh0fK85/0IQiQOdWaIOKJSJqVbNtfqP73MaShLpUR4T5N0n6MqMgygOKXrVfkqy6YNDRNILlH25EYUPY1apcIGFmxbcsbiO7y+hJZDIEJ+Ow9kvp9q7L+2qMCKTRdE2K3KXyciyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:01:03 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:01:03 +0000
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
Subject: [PATCH v2 8/8] arm: socfpga: n5x: update SPL data save and restore
 implementation
Date: Tue, 28 Apr 2026 15:00:17 +0800
Message-ID: <20260428070017.16807-9-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428070017.16807-1-chen.huei.lok@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 06b9068e-4713-4e0a-d206-08dea4f3e944
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: y90gG98FgSfPrCSOB0yPneenn2Qqr7Xs1vkX+idAsOpDBizKkFwI4/ml2EP3BxeGKYo8HMevczWHLTbeLfnBUDH/iwHKTN/w+dGqok+eY2dcgC5fKU6apYQfbnmKPbQPyAvNI6cR5iPsIuWw8IhP6cv8LlwOGJiMzgzz+7aqydJE4xucxMm2DSV6kgEgfTmQrBlobNN0GIM83DYa+oXw++NirShFDCOluJ+PxPgRyYebH9o/e1FMf32HBYCMOqAktE2Y7HYNkt3lMvARKW02ZpddRllLRo1D1WUlxOQy/ItU8Pv/BtPu8lP6Pps2dd+enPLxsT3bVxLk6Rvt9LG6J6h0exZBa7QUJGjbIrNix6SrYs+dXCFXhdXr9eS+f2fPAakW7YV2NxJuQs+JNAaw0NFGHOCA/nvSJERwKP3XiTniKvlTXo9KruVtV9peGG1G3SAhAyr1LaEuGatjvmIDbldKxDEFIfZuV1d6+bR9kItd9bAWnGsX4gl0UBsJKCFsZFJdrQRJ+8vNjCiCerK3lkC5MaNwaR29rCO5PpIDpyHpmNejg9+7X22qd7WXXLYpnpWfhcPY2gq5HOKYOe5TAckuv+PRbXy3iLCCjWcAo6lIw4lX6QyAoFPm0gbqr0bCD8kdGirANGu7cxDUc6b9CVfWgW7N0fsZ8W1tjASuLd9rjChYTB6BDMpF6x8czISvhXJCZ6huJO8shcjTHXBGOwf4VdGyZcSNU1j385USpao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5SEQu6W3Wt6LewF0xf7Kk2DmqlhjzHpRxoFbB4FX4cx0lCz7LUsomYhKpbmu?=
 =?us-ascii?Q?92vvIckQQAXnAdGRO2Anq2i+pemwcbCoeQr91OXcYW39nap0fbtqHHqU+8Rt?=
 =?us-ascii?Q?YkXpXvqRfOo7la3xCTqKSzFJGAH+dDW+R1CWdGOc12wWrBSj4V3v2IFo3NzW?=
 =?us-ascii?Q?y800ucM++gTFiPpAS3VTxKDWoayThCLt1tKjUZX4f0+9T3IkmS5G/yjzyB9R?=
 =?us-ascii?Q?5cynFqqyRudoQ3wpW49Ng+dqJ6BMxscRsJp/EcvZdpBtnPl8auvnuNetpGtv?=
 =?us-ascii?Q?ZKskycutoM7qx55jSdA+dGaOXsgg4qe4cqpXioXg9x72u+N7txTMqnqsYZxC?=
 =?us-ascii?Q?It4WKGamPT8lLnijyCQiNraIHb5KDgASShXbiYmTjl7Yy6ofUWdcnJZCVpGT?=
 =?us-ascii?Q?RpQK+DtNHdBQr3okAaXyGepq3dlBYsH7oXAERF8evepEfB9tBMdGzmpg2gY4?=
 =?us-ascii?Q?YRTFeFwRFMRNcrPrnPjj/xzf7lhto765dLydczmGYHtZWjuKjxysxFx4aB8B?=
 =?us-ascii?Q?4IzBpu7WCa+LnV1HyDIBqC2NYlYCsck0F5ZsGA7n+XQnG27keMuFT70Jlb+X?=
 =?us-ascii?Q?mYUmyE0qrSVUKQBoQXv1Q2kJ5ukxcAn47ha5AO4p5Oswwf/NzhHl7uAQ9aZl?=
 =?us-ascii?Q?pL5KS4ixfPlc8F2TZzdk5d40wvJcJtmkSuubvZBHGf7YMczy0qXpVERxcpLo?=
 =?us-ascii?Q?7Id07A3QXR2MSXlXaGJv6iEO+dKtU69YyDcd14SDHkcIvI+NUJIwzp/xKXJy?=
 =?us-ascii?Q?qPfcYqaM2eF/FZ+wkbvUVTUQFjZA6huo7uRF/stGSF8GYmbPF/kxrxRK8YES?=
 =?us-ascii?Q?K7NgTvJmpbny9CwZ3T3EsjZqq9DphmdaFySHN88y2kCKLBBiHz+lOJ2lNyrG?=
 =?us-ascii?Q?0y6ajm0csiG0fOipxYCTQX2BOaEWl28ctZQh4/7ZKnfeJ495rGyaNq339wFw?=
 =?us-ascii?Q?aOzEQx3KDpv2r9NdG8SXvFCCVuskUg9f55Rb0HywZpGsrror/2HV9SU9MiNI?=
 =?us-ascii?Q?E0XNphm240hrzrPlkLrX0OjwMRt/tf2V+eMjvNxjXyKbB/xmNk+zYvwunzDo?=
 =?us-ascii?Q?rD2U/Ya9qu1alomWoXbDAx6OHVTbzO1Fh/9v2ThQQ/PPPso/y4Nj4uCWYr8v?=
 =?us-ascii?Q?AJBeVXdoPTwpG4jjR67O2whbX4jFhXtAvR9koj6pkEvtkkwZqIzTdAQT1Pnm?=
 =?us-ascii?Q?GrZJ7gDm6XyufTGiIhlnDBuVYrW/p651sXLhgoInYg0beH2U4ByuQi744R5z?=
 =?us-ascii?Q?1ntr4OL4vF/lUXRqrLVAyG6ugJkFIcVnLBNO4noRPltubbS7V4+9nqmMP0P0?=
 =?us-ascii?Q?jlXaXq9/L0Gl4UWnG69PFn9fNtnTmzYbMvbPEQfjpQnP/wi+1NLfxlqpL4v9?=
 =?us-ascii?Q?VejUVVzj6MS7mt1i4wUNsQd/nwWTk5CcuGGj8aX91MI8oxSWixMNajmMQnXb?=
 =?us-ascii?Q?jsm+HhMXibs3NABBH8MBcJ3be8h1/3GuvuKYSD4lL+VjBjSmBKbt4gGMSYyX?=
 =?us-ascii?Q?rs1BXdlmX6p01QmTCZFgtvjGredZxCdxcGpijLxoZjKj2jXCpOBVZodtnY8k?=
 =?us-ascii?Q?fuD8GDeLk6BaI2aPV8VOhjXjd76VCiTlFXffWo7/WodIkTI62d7T1cPlDVY0?=
 =?us-ascii?Q?0PSgmLAGM3JW3iWfgSCEB675hDTVyg/qJ8dmiQjD7ykGuHOpZFfjbhq89AUN?=
 =?us-ascii?Q?3SbgDCUpThmPDIMJdg4J0FaLJlE4cGTqxOnskVa3zt+vY8K10HcpghveB89Q?=
 =?us-ascii?Q?zz3a/Ywwlez1pJSrXBZVk+puD41arQg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b9068e-4713-4e0a-d206-08dea4f3e944
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:01:03.4736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r71GnYxDvBdloPZ9sQqs+jrZnZcBUAIXvyGYlg5vVRO+DlbZwvk5saWfQtOnud9MqrQITudHmPKdzjcQROZr5qwJQZJ+pyhHx/1ERU7bRZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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
 configs/socfpga_n5x_defconfig   |  1 +
 2 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index f776d0c0327..8933811a7ec 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -19,11 +19,29 @@
 #include <spl.h>
 #include <watchdog.h>
 
+u32 reset_flag(u32 flag)
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
index 8ad6316bce4..27e15a13659 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -22,6 +22,7 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_n5x"
 CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
 CONFIG_REMAKE_ELF=y
 CONFIG_FIT=y
 CONFIG_SPL_FIT_SIGNATURE=y
-- 
2.43.7

