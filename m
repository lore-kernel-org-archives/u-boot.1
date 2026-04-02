Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E778CC6B00
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 07:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D30EA84099;
	Thu,  2 Apr 2026 09:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 989C9839DF; Thu,  2 Apr 2026 09:00:58 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D01784011
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 09:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOSGN6nJ4/Dwh6mbfy24jqp88e21K5Nodqp5sFPTIGJ9fLhIeChcfwN4jf/z5kW/YC1LTICPpyLhNw0aUERGFy8PA2PU8GurydtRZd/1Lw1b1+G7FRBunz7cigoiycWtVg2zEVwDqtb86rG7PtsB/X6A2HfNH8KEIHKpn0ic7uyicg8fDlR8QWKABJd0l8hLTmAuoiF9MCQlYc+XnGGJUF7ht01s211szRkLY06SnDKgxCGZM7pZLNegD3AOPrg2KIcMlLH/L08dUGsQLZR3gdAUXk48t4ImXmMngK1+SWzxYhkrr2w7UBMjlMyiyOl4BK7K0bdjLoRbAjLrodGnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpaxmsDNOQ+zzHBA0otbknGjHJfdnHaPdKNQ7EHIfr4=;
 b=WZ3lKRcUw9q7ghX30EwcB2hemp8BldJxfbz6YCJDHlynm25ExZdfJLdijWZLLZNIAywSL+TwdNCL8IVVxqOLOHZGWi9Nstl8xOQn29jOARvbUq9NS+0M8OcYnIJXLtlLHx7ZX5xe3bdr9hbEuTx68lTGPBE6buoxuFEvxcH615lMYiWwZdo9S6ziTwm0RY0sob8OYUu4JcOgCdULKagL0rvfrn9e8K526rnQyMxCCP4GM5DAarJqTIC+nCJ4X4ZQlb38nJBeLlZL9umA9INp8FuN9cw+qVmRXHHrl5dMN6q++uYgdiO+eY+obz/17tSWkK/KTPVq5jrmgK6W/J7unQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1276.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 07:00:49 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9769.018; Thu, 2 Apr 2026 07:00:49 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 2/2] board: starfive: visionfive2: Support VisionFive 2
 Lite eMMC
Date: Thu,  2 Apr 2026 15:00:41 +0800
Message-ID: <20260402070041.2418-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260402070041.2418-1-hal.feng@starfivetech.com>
References: <20260402070041.2418-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0055.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::22) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1276:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb669ff-7a3c-4132-2dee-08de90859288
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sXAPfTYmn/V7c/DkZqXH1XS/Xd2XJ0LRA4PTSn0OvrMyAdfFn8idX0WGSEuoFbny8t+Sp1wg7ImtWd6PAr8uPm3FCT0k8pX59biw0SePLmRQEMvZ90eDxAbFAJEUCb897MmgURAjZloqVWcVNYhrZ5e3En0GplCl/Yg7gVT9JF0sWp+OmP8zQ+zymiXdlFuXT2GwvZ8jIHwBJM5l8rI/L+UOLfqkJz1NZCxFS0F7fVOVIiqT7CCDTA1oTLl8xfKIuTI6DnNk1mnZdFotn5SFj3xC1JUmitD9f1Pj6YprdFnTJSCYpud1tXEig837iiWTV3sX63Hln3pIEZ2qu41OD5Djh3eD79uPkH3XLA9tqRFThzCI5fCx8vtTWbxleiJGM2i18zyWAbRE2egWoMgHCBsAsCec+Bion82D6P4ylIJT855MJhjER4zM7w/JfsS0YssudG7rL8Nbdd1Tm1IX1v7LJ0/IIyDIDNxya0iiKwV+fHVIZ3UJE0dVn1QLBUufgm4q4Qu7Klns4PaYCCEPwZHfTMWNmsMo0SSKQ+cmU9IWZdfimP7wP1e2i+PSqzOOMtAg5cZOdhV8TynF3xI1Yqru8h1eAuci0ZsR7HE+d/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kyuzZHysn20qjO7fAt4VGFt0Tqfg6RB+WvhKNQ1ramMl5euAc3HVdPgXrCll?=
 =?us-ascii?Q?W3Ssn2IsXLyTPJOa/68bdP6l17Qghza00YaypsuGod19ITN+mzjguukhBVqU?=
 =?us-ascii?Q?hrQYKJ38dr50T7mrW0e6PjkUnfRueZIKJYTQ7ATGWTL7MJUlc7HyE8w91OIW?=
 =?us-ascii?Q?rWaIgCOevLPNnJYBDPLOjBbzRqvk+btptsR56IPdPTQgrKfF7oo/KoZrfyR5?=
 =?us-ascii?Q?ene1lMVQreUd6dMeD+tD+1EdAGwpquPSpAhXz4Ac4zR6AavET59nzx46cjsf?=
 =?us-ascii?Q?bPQ7/fiJTQxU0P7AyH8fJDUIWjXQmT+kB4nREZGcW929ycRTgAWALOXVBPOe?=
 =?us-ascii?Q?1h3y0qiKazMTbsy0agtswcJLrCOjUAo0A+oGcEmczl0r7Bc3SGOyfH3CL328?=
 =?us-ascii?Q?N/KWwaxAitZN0OJnOsdMNEQC1Id+p0uLsVixmoULehTpZ8ErCLPquCcezBjp?=
 =?us-ascii?Q?tL4MQ+FjE9kPuh+Th6zgIjruBODZymj+LI3qabPErcyGoysFEohIXY2acIAt?=
 =?us-ascii?Q?wQmROOTHEqwF3/2eThW9J1qryWYVul00ojwmmK+7crLcZV8w6Hp1dpwmdX4+?=
 =?us-ascii?Q?+NlgYFv+qZpbnONyUbFFLUoP9mxp+Pvc+3o8fXbJnTl/kt3grxzSxWYnHaqV?=
 =?us-ascii?Q?wAW3E9TlH6ogXrsyYSRYDBd8XjgmnOMbRInG48QXsLx3sIATdF3doLaUvbQJ?=
 =?us-ascii?Q?0RNxIRS0pA8DkWJ5APCtb0jsbxZca0qaCMlWLBbXyB6luShEOjIXOr53MxRY?=
 =?us-ascii?Q?TRoagsqzv2vJ7ysnA2qMH+64WwNO/7w5IjfLkS6Y1oWlO0BvkR+yRoT6b7yh?=
 =?us-ascii?Q?KNRkJ5iq9eew0pbkMDvjklcDiKtPyBNzTnLoPQCkon8j24crdRP6o3v9wvL9?=
 =?us-ascii?Q?qE7/a4C6lTswozjm2yPvwjtOvDV7kiqxcyamu9DDJ3vSRTAJehRveouU+5z/?=
 =?us-ascii?Q?u6WiXR/aVU5h/uiHuWAfI03EV4iAa+Dpt5AacaKFtZ3KISJY+fHnrb9j7IFf?=
 =?us-ascii?Q?+QV+gw82f7UUf7MTNe8Yla4u2en+KPjbf/LHEpk1fcGzk/Bx63R/BTlHDBV8?=
 =?us-ascii?Q?ytGe0E+W8jBiQgIGK0WGmcWbhuDa72yNf9O1EokbbQiiCJ/cQMmoCFVPrgtE?=
 =?us-ascii?Q?bM4QQxkR6k8h1PNUa3K+M2kucQ+XWAOVn4rnvp/v/Qpczhq9zAq+ewhBy8fH?=
 =?us-ascii?Q?7rJ41AU6jtL/5Q3TbiNasQBI9uUFi6fZpihQzg9a41wxkm+tq0YyGWNFaNLJ?=
 =?us-ascii?Q?Qlp2dZBIuoTcFg/bB3hhQ9XUNMMdeHmShoAgpyPsUOpIPVm7uqD8BEZBW3Vi?=
 =?us-ascii?Q?qxDvdVUv1sVRKNPFlagNHbwGnZwAQrNSdylpTTzuXrWhbsGZSMD1iD4/Vg9y?=
 =?us-ascii?Q?8RlGpEFeHSx63Rn5LfGdU6Ld0EpXUeJTepnBQ+khlUIjXxZrgDm/71fEa6lt?=
 =?us-ascii?Q?YrF9wLXxhglmCUnmnlzg5AC/8kR6HmGJr9IUGUdaA++hWcxfXloPC4ih4ZgL?=
 =?us-ascii?Q?Q8EymEfkHaIum3M4i/yjukvRermuJhPa9F8IZshXh192aNnJ/CoZFOV0Yfqs?=
 =?us-ascii?Q?GcvUM0Yx5wNZZ6uCtcffAGS0veaumSh/4x1JiI1agrnj0CG7wXbTNxGkr8rj?=
 =?us-ascii?Q?Aw0idwuaXYbWvJyWYREuA6wMNPSC3qpqo21pfrl4eh670jkYQfKvCHIAdbrr?=
 =?us-ascii?Q?+kM7l0qmNZRaGj0VK6DNpINsrCIHZl8klVrnJtd6atbDAkzPR4cRLaboO5rX?=
 =?us-ascii?Q?9nKPJIVfXiQmS2Ap8aBcHk5gh+KH4Jk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb669ff-7a3c-4132-2dee-08de90859288
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:00:49.7933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUocX9bmeE6ArX9R303wNlt01eQVVXI5cbWS2d3EgJApL7bheSKpDXd0GlNl3M4Rx9NOnyiqp+yavygPHflpyPPQlOX9RMB1zeQc4UODxgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1276
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

Add emmc detection to VisionFive 2 Lite DT selection and
fdtfile environment variable setting.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c                  | 7 ++++++-
 board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index e231467f2a1..1b4d623d002 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -144,7 +144,12 @@ int board_fit_config_name_match(const char *name)
 		    !strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
 		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-lite") &&
-		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
+		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8) &&
+		    !get_mmc_size_from_eeprom()) {
+		return 0;
+	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-lite-emmc") &&
+		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8) &&
+		    get_mmc_size_from_eeprom()) {
 		return 0;
 	}
 
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 1a76f745ec8..97f40715f8f 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -72,7 +72,11 @@ static void set_fdtfile(void)
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
 		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
-		fdtfile = "starfive/jh7110-starfive-visionfive-2-lite.dtb";
+		if (get_mmc_size_from_eeprom()) {
+			fdtfile = "starfive/jh7110-starfive-visionfive-2-lite-emmc.dtb";
+		} else {
+			fdtfile = "starfive/jh7110-starfive-visionfive-2-lite.dtb";
+		}
 	} else {
 		log_err("Unknown product\n");
 		return;
-- 
2.43.2

