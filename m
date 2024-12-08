Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBEEE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AFF889756;
	Sun,  8 Dec 2024 14:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69B5089586; Sun,  8 Dec 2024 10:21:25 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20704.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52B789529
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQcNt7z6bKn5xuinx4nWgTo3QsWTSayrK6rNq5qKPXyXjPpesZP0HY3hI1Bn5l3KtJnYx8n8BFxSUmOmjOIZ3qEBiaupk4dd1XIMJrGyHZRyl7YWOZIEt5L9mcFPf5LHkpcODzJ/hUJWrOh+MYmBXtXl2sLbiBPs0tEKqUkejMO0mgPCHG4bTT2QFQz4Nac1oNOtv9geLJwB/UXADpodusdL2smWnXe6imAWx5KYtGs/p64YN4t37vnGRETMT106lnONt+XzgQBmCdzjQNclr9geVw6EpQV4RpIIGF+5zYgMjXroFlGGSir9knKy0AdRhy/PiHQekMGruwv1cHKW+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfTlD5yDg0zYGzBkVPFfhKsQq/RX7M38ybUeRG8Sp9E=;
 b=gar3d9p4MQnnWdpbWsZosW/tL6SKntYetpbPKDODAtD6OKzUmZjBhxXz7d3twIfUxahBy6spa7C+F1JnAiS2GHw00zyFbbqDGr/Ji0WuRRS51H87tPwTgsLC7j6XvGyItxN7Xbdl/k2uKmZ2LhMoBaTNfb5XuZ/nlACNutioOvhDRqT1tl6X5T/3KDYH6iqfG9Bpvus0eGR31sLxTET68IrUgxdbw6qt3ZDoL8OIh7seI/bP0rIEqSRD74d0CcwnIgnpjfOWb3pYoROfRn5z7MdlTHMqcCHWt5S46E3QjQBC1ZIwNCTfkI6oKac6E6Ij/cr+rfg8IXmF+Zb2c0kfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:47 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:47 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v8 12/12] riscv: cpu: jh7110: Sort the list of imply statements
Date: Sun,  8 Dec 2024 17:19:42 +0800
Message-ID: <20241208091942.47298-13-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1226:EE_
X-MS-Office365-Filtering-Correlation-Id: d26312fc-3fbe-4185-a4c2-08dd1769bdae
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: DYxdBNg1K1vIsAXA+nnBOWNUkIAsM7pG1a+jpZtf7gpCgi+esRI5UvstiNAFPnSmTDFAjOxuE/uy5IWQEN/QuRLzUXmOZF6gPxE6khj50d+Y+myHmsDfIYgVw8B4YK09T2xayiMYuMpbMnwdqC9r96tNoaY2pqgweSq/agDXxAEhErPGIo32xEZ335MJPaVAK5aaTD0xps6S49C3t7UzW/2p4ioit0eSWV3p7wTgNfxP4VwNY9CLRUn+82tg7XB2kpFT1GmtpovHYIAj5fj/jA40lMP8dh0XY3+3M3IAtGj+2IBKpnpX8IfIea0RLuH0ixjaGgX/utXk+Kh7wJTCKvTzdXzqYNAd6MpOiVkokLQKMtIsryZjte5Kok58jj5QW1CPGvmC66Y2jE9r9H9gEuyWs9JkauIZU/JIsUtk7z1DWZcCO23GV3rQTM4WTd8TlC3wzJG6cEpnZMp6eI5Z84FgNiKzfT9vS7XJU5siar7vyfSL+IK/bLY5sP5kFwRYEacmKXKrH/8gAWp/mPFE3L5BAU69eco13QIwX2dgwM30yptDUgOGcRj3Uatd3obVOps3k5/2EmgdjFw/uNOUjqHc3dyoo3mv7yTIpuAJxrG3DwmbnWCW3OYNuQhkqwNp8/70UAcLp6Vm3gmVU7EE4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xbXOoS/lJdEjd0blhysmtrDvs7gc8OSdnGa/KkKbBFdWMa2M7rtDrG5BLVW5?=
 =?us-ascii?Q?radeZQyLfTP3qxcZW+htXMKTimt1CywYVrNlkXBmCQ59Ff39powo4RUMyhf5?=
 =?us-ascii?Q?t7MgWP1xNhiZLWDgzC9EM51rJpyXMu1MCd+zHQ/X6kJIRdzJyUfIVMC2+3yF?=
 =?us-ascii?Q?T4CTc44Rd/+N/kenTjydNxajpgSKIWfN2C4gpv3nqezS8nOZdpk6eGbsUb17?=
 =?us-ascii?Q?G3EM9YTmMsNW8jUeiC1JkxSW1rfzfAfXSy1wSy3CJYiP6ZpZMrHiJcxOwCtj?=
 =?us-ascii?Q?6aPnWohHFCyQyBZwQfqiXyG62cTPMC+y5odw7eYkpE5PtxJ8hMQg4NPBSCul?=
 =?us-ascii?Q?fsM/7J3d52JqQUhzjiXGcXWVzP8XACTIKpimj2QnuCh0NBR298B7J8+eFo0V?=
 =?us-ascii?Q?mRHzod0LXwqdTHKCPRRbkfA05hwcZ5UTWWdi8sNQyqwJxqSRyXwx4K1L9GV8?=
 =?us-ascii?Q?wFPoeeZeHlYU+LsdJJcOZuCgmTPwau+Cee9De4R3w7c+j090v7fsBROOqE4l?=
 =?us-ascii?Q?NtNzImWdP1Q34BORTPXmf15ejFbVuUXe5gcissDC9ooXBO1t9JFRVMUA1jQO?=
 =?us-ascii?Q?eYybyTxqbVRpZl5q7vN7vrfrM2YuljEbDA3D3hG50/FOT9mmHIORWMg7ZGqv?=
 =?us-ascii?Q?7+hNRo2YHSGO7FArSmDwVaowQOf9qqxSM4ZNrFOWqrpLuUkAO/dLvu78Q1y0?=
 =?us-ascii?Q?p3vZFIPY/vPVF4hQulk93md7gbYYsQa94ZwsTLaUEjsAkxO/q6cpBw+GJEum?=
 =?us-ascii?Q?j7R0OhDD+msL1GZ0sDx4p+Dh1A2E4UJN4utS2s1AcTaCN9kiQF0heNYjEPaa?=
 =?us-ascii?Q?yd/ox2czJEoZAD1Mvp2iFm++9JYgPkAm0VCNVwV8RYUFhHQ+PfQuVS+oscIY?=
 =?us-ascii?Q?6lQwcG3YUd/Le3KXPrx1V3e1S0IqagVzzyQGrs3XnubiPIKJr5CQ1py+yCDk?=
 =?us-ascii?Q?LA9HP2sh3EdfLoxd3gP/ArcvM5h1UrfxnUIXWQMsrTDrE5xIr5AwPrw9BmTr?=
 =?us-ascii?Q?KkFa1eeymJQZbhKF+glVDJJwjz3j6aQuPVUs7pzyzjNftnGRrLST5ViFieEs?=
 =?us-ascii?Q?+jUjlNm+VfQMe7jVASTN6x0+8cAYLknKIXA9RCPS9j04Z26ZgjlL8Apn6Hwd?=
 =?us-ascii?Q?Pw/sPwyJr+gE8r7+I2RJQlNh99w5Dvm0RT588fdVM/r5SPW4MZzXYh1K8EIX?=
 =?us-ascii?Q?HSCuALB3AaDFjULBz6ydew0wAqPsgZsIoyGf0RtPk6EThUjZbc1sjcc2U79I?=
 =?us-ascii?Q?JQhTeEDXRick2ugTCUGKhphXRiV8t4d6QfKB1UZYsN9+MS3npxOSfR2G4Ku0?=
 =?us-ascii?Q?n3nrLQjWPjbcnxWGY6q7C4EKcM0vVfpJpJlq3tzn1XsOawLwdqoLRj7WYf+P?=
 =?us-ascii?Q?Q4odjjoTIZA7dhv6srBscL3tLiPYo4Dp+4D+NdizFiRfg8qyglGAyRr77bAT?=
 =?us-ascii?Q?FvuUIbw5iF+WmuaJUidzp9ckir4WtFnMa5nPyMEKb+mLqR+WlWjX2e5KmTLQ?=
 =?us-ascii?Q?+QnaEPr83qu/+WoXGO6V4BfRoVnqqV+pFVtbKxFken07UQ4vpPB34+1dHoOi?=
 =?us-ascii?Q?no4FZP+Gh5DnuOft5PlXh9VEybJm/j75DIys8mZu0P6Poo/TG2HzP5Osg/4f?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26312fc-3fbe-4185-a4c2-08dd1769bdae
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:47.9239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57z1KIApdRGCLMKjKneFPkkuedNKAjs+sWYXjpw8QCj4o1zaKg1cshIWe+cfDCagighpaslEME1fSI/AUDPcDJItxJuCdwIC2JHfffUHwL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1226
X-Mailman-Approved-At: Sun, 08 Dec 2024 14:25:45 +0100
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

The imply statements should be sorted in the sequence
of appearance in .config.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index 9904a60ddd..fa47e55226 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -16,17 +16,17 @@ config STARFIVE_JH7110
 	select SYS_CACHE_SHIFT_6
 	select SPL_ZERO_MEM_BEFORE_USE
 	select PINCTRL_STARFIVE_JH7110
+	imply SMP
+	imply SPL_RISCV_ACLINT
+	imply SIFIVE_CACHE
+	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
+	imply SPL_LOAD_FIT
+	imply SPL_CPU
+	imply SPL_OPENSBI
+	imply OF_UPSTREAM
+	imply SIFIVE_CCACHE
 	imply MMC
 	imply MMC_BROKEN_CD
 	imply MMC_SPI
-	imply OF_UPSTREAM
-	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-	imply SIFIVE_CACHE
-	imply SIFIVE_CCACHE
-	imply SMP
 	imply SPI
-	imply SPL_CPU
-	imply SPL_LOAD_FIT
-	imply SPL_OPENSBI
-	imply SPL_RISCV_ACLINT
-	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
+	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-- 
2.43.2

