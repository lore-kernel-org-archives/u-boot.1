Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2052FCD0A7
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 04:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5235842A7;
	Wed, 18 Mar 2026 05:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="OD9HbIIN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C626A8415D; Wed, 18 Mar 2026 04:16:43 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C03BD840F1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 04:16:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GfqzLd63KFfWcBxaWeiSEotTZuNSc5ffttyU8Kls/p84C0+dbtRAl+rJWZFzMYCGHsIyKJy/aRUuYeYQa27TOzHjc22mGU3Wo+1nN2s2Jp5X3BDJlF3/73xQ7bELuiRDdXzkqVe8e0BK6QcjxwDjPvIX6bPkZ1yGIVvY292pvmmYq9pLLZXFrxFVB/m9mg7+LUS+9hbgAOq+9/Q5I6DCtZOmYvRfCPenfm+Yy3bq6z3HIgsii+okOCU1NckNMs78klLoiyu2wlXIXBUxjAZV/+KGEqJSd1bazdO4kfhCvsLgRc7kEfACAvtp9nisCsRjFJcmKpj4dvopQF+opDsndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aXH1C6IsYmZ2VCusT7KSxUKK1oa8wuIk5jPgpNDF94=;
 b=W/Za6Ex0zekwi5eWv+Q01oW68DDaDU4X0QUh7EfwniolGp0FKDYYvBkUh3lgC37Lgz1MHac7zLfG4jxq1Z3aJImWVcE2NKM+tSM1Zyg/lKqabG8fayUI4052G9g+BVveJhOrPER58m6MOUihkmWnVW7Lo7pMXMjoun3uwMwh7Vv1rR2cwIe/gH3zwQlaA4ZYbYhMD6Vmwh1USnFdv1JUKZ8o7nybEoUbXZvCKoYP9nO4uRoS8x1yIfirWKt66kWRIfMJNYhc0jnbDMh+SRWcyvbOzfFwrgfITZOgxRw/Xn0V15M4lRjy8SX+5ddElUMSnZBxRWNxUJhv5lO0hCsSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aXH1C6IsYmZ2VCusT7KSxUKK1oa8wuIk5jPgpNDF94=;
 b=OD9HbIINaRUZhoylv7ZnjFlts73i+gBbAfZGEGrwrz90CJMAYUBAVCvImFdtgntZggyCbJpS+S5lcE0NH73gV2u2a0HsPCwULK+hTQsFYNmRbyriP/GrYRVkYu/sDVVSENoMyN9F9IGnU6pLM7oKR+REPOJw2HhdDp20YzMNlHKxGdviEK00+hu7lQAVN9Y8gjIro7wvWGqnRzxjs/NSTJZRT2ZiOk7zKhPNz26wUvoroELIG1Cap2QgQwLujYxk2QbkAddcw8j8PP2+rBPVYfgMq85km8i1zgnAfPU1kgIflKZyVVEqx5YoV63/B+vw4Qhp5p1xLUkVqjn8yARgWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA1PR03MB6578.namprd03.prod.outlook.com (2603:10b6:806:1c9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 03:16:26 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 03:16:25 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
Subject: [PATCH v1 5/8] configs: socfpga: n5x: enable ISSI QSPI
Date: Wed, 18 Mar 2026 11:16:12 +0800
Message-ID: <20260318031612.4003-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::37) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA1PR03MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a19251c-d570-40c0-1844-08de849cbcbf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|55112099003|56012099003; 
X-Microsoft-Antispam-Message-Info: egKqOFHdQzVit0QhwHI/4phiGaLC6/VBMdODbZwMDqW4xJPJ0cP18lxLGoCHtWhD3hWTasiw02byLXrJFZoGgAzyGHkUF9Ia071fyi6VMnSptNqiTNTff2Mss7ej4aiofzPxDz4suvHI7an8kTajwkpaTc5yB1+dVrdzP3YAfAWnQUjCvxtX2hILi+D0m6+sK04nE2sKcnFwphwmQNBsngaqsIIVg80e7fxHkc3czhY06nJDyMdPJeFdj14/CMSI1HvkcCQ6IvNilw12DQeoZJuYZg1Y+ncF6KAgvRKHyhwOgcXoKJAUa9V/xh94hb/r0rXrDisQS7BFCRAc98zPz85ka4rwUrCS4+nSejJSRrBZjrpjzAaZ4fJ5b0oV2shoRTH4HXEzpFmrYgg3U4GlHWY0E0aL1ekrX1e7HxXFXktpv5fNseX+lY1/8d/fnKw0IW1dyZB6o8fHD9uOhuOQClo5o41u0878dW+bOEaqxkF7qfHVWNLVvhutdhsqYVrfmNWXu0lrIXqDRHqhGCLjQGscOCkywIdVp4zBtEv291SYZ9LNEG4NpU4RNzHD/5DlUu7ysfuqHPHg3FTb8vboItbwIC45tvI8PgXIRNr+SmtlDAifMBhDrBpf+D3FDO6yGMiGanoqeq9PHwcrjrCfWUW/DBGdxeNgc2sTSPcdVzaGu6lViD0kkSr/+pWBxikUdRLXZaF7lK8h6YaBQKOoOtLllDlaUPOHDGu1eJN1GrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(55112099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4102k8zxLC8mSmvaM46wu+z9ouP2vOTnLmYFTr2BY991Ca3wpBJ1yO8tfbCj?=
 =?us-ascii?Q?8A8sJwHxljuP23g3QXJZZ5mNIksMY+g0JPYErES2C4SVjjfs8YCU68mgIode?=
 =?us-ascii?Q?1IMlB3KyCgJiR7+GuGw1WYon7PCMzoTlY9+wJkOLx7THfSC2pLbmR1qdHzga?=
 =?us-ascii?Q?FZ33CBuRfxGSfMu9Ye5B3bH4C2z89yc4Jk0LKV9GNAa6Vw3xIOUa4Der3R+G?=
 =?us-ascii?Q?vIMjzXkXwCoSPDva7K37Fd1AcaTTumHN5jjzTfGxfRBAEuFZKbRQF9/aJN29?=
 =?us-ascii?Q?HTWKVEMdAQtcQ15ClZwZ417BoNNRW0CYbsKCsCxe1YFxvJlxXFRh6zErGq6b?=
 =?us-ascii?Q?GO8+5JjmjRiilBuy9GoZPc9py8dZTTu6w7PC+6O+GLvnG+sbbbzSffk+5vnA?=
 =?us-ascii?Q?OCf29QGEhWLQD2RPlvuo6JfYHtZfoCz6vWa8vhSUkXerCn6Ouk9sGYIxzlgb?=
 =?us-ascii?Q?iiEuk3vYUkRupcz4G9Uo244Kuda6ytFcSo1vxBmyGxW4tx23OSQV+92taqnV?=
 =?us-ascii?Q?4ieKVIX6Bv+uXdPom4u2H3S0CpY2vA+ruzbv5gXIR338BeVGsTCjwcrlYp2f?=
 =?us-ascii?Q?HIgflF0EABGcW+Sx1Nl1QnNeqttv1FzNYCFNacb2H8FIFfF76n1vDZIP3vED?=
 =?us-ascii?Q?RzCzg1ScpHMiMpS70rMa+mgmCuU3u7rkfKulZ5Gu30h3uXrqtn5KfO7d6Xlp?=
 =?us-ascii?Q?gYanitNF/0wo41VFkph3ZiXmJI1x6bMRbPjR8Zd+k057h83d5RTln/76jxEO?=
 =?us-ascii?Q?QrUi2+9rWOKxvM7JtHfVCDz3LU9ELgoZqtrhChmpMHCC9gNz6Mj3naOkWFyo?=
 =?us-ascii?Q?eYMv6TAmbb1veK9D4ukfupJx0IrW8ToZVk6oUslIA35Xn4p5IgjPdZsmwOxu?=
 =?us-ascii?Q?iGxsFSPbu8+u8Kqzre1hqXWDyEpUrMMUOMxpBbxEAYPT9N2AHDjitD/FPXr6?=
 =?us-ascii?Q?R2MSQm6BH+opWif9RKsb59YufdqfeuhpaivbC/bMkYzDzk5A27DZJ7LTPuS/?=
 =?us-ascii?Q?4Q9MjDtkPOIE5Fwp/OFAv0cDYe4nAT2HklwiI46q7rDgbu8ktoJNjuYwzVXw?=
 =?us-ascii?Q?hGCr73itjCAd2Dvf91h/vnw2jxDS7VeFtqoSBbZ5b0tcHb3XoqMroESiOxDw?=
 =?us-ascii?Q?iRqohtbl4W4aeS0RJYKb1m132lLl7Qfgahel+xI20HYROh7xUPdMylpkej54?=
 =?us-ascii?Q?PV/u2PS9o+dC6lP03KCyH6lYLxop+nY7fJjadDVVr2Djtz/S+SUihXoPSuk7?=
 =?us-ascii?Q?1FXJo93AgolggPF0DcLgabY9ZA3Ptz0ZWJgCvg5k/hFK1Ed3E+o1qn55LKFc?=
 =?us-ascii?Q?YHcXmYadj2z8RUxw5ahVXyD8KRktKNJjSlbp05yaMUNJfrwkw7HS58F+Ok7O?=
 =?us-ascii?Q?ppUGyym5a/hgk333naVPU4iJnz4vZ5Jxng5oNm5q/ZDnfOOM3lgqR8ui76u+?=
 =?us-ascii?Q?FQASKLDH6s1+7/L5JqfggUcfrUk58RENxqCCLgQPzXqItonOOfOID9RooZvh?=
 =?us-ascii?Q?U8anZFsQKbtBOwHiC0AwqlYiMZCEtkWgSW/ysKdWAP5g7rH+IIXBNFGHRhGR?=
 =?us-ascii?Q?UrihQrDqxRA5D7dps+M8qWSAbBWlniTqrfkawKMZZP/xxGTLm6+AS5G4Om75?=
 =?us-ascii?Q?55v/utY4OwR4UGQeA/8WGijh4zCq0tDVv7dPwZHVTo/F9HRouptR3ahBz4u7?=
 =?us-ascii?Q?Lmz1Xy12MoI6JmX7LoCwtDD6bIq4kC+/KglBp9KSJfUUNk4t5ESLbXaVB0iA?=
 =?us-ascii?Q?MeCNnmLwNbOoCJ2KjuBkIKHY+kRs2i8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a19251c-d570-40c0-1844-08de849cbcbf
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 03:16:25.2986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UefZa0a8Yl5kQe5iTo9ADjgQNNnlN/C3K0O0mHhJXgR/WLaAWz06dNH/GZU6cY5/6HOgXaIPUg54TEQDFsVp2RcIctva0fAz+Usr3+bHREA=
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

Enable ISSI SPI flash support in the N5X device.

Signed-off-by: Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index fe63756fd95..fc74e2f65b7 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -75,6 +75,7 @@ CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_ISSI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_ETH_DESIGNWARE=y
--
2.19.0

