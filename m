Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB90E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 13:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864AB8961E;
	Sun,  8 Dec 2024 14:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD4689525; Sun,  8 Dec 2024 10:21:23 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20704.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::704])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 121208954B
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 10:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3Z7plLdOea/ywFBaUJb0sTtquXxBjK92SLwd+Cf3hSl/ZIqsJr+jjvrGVoFs1nNmGq8vUTcIHAafjT7IfccC+ggD6nlcMwWwhhlrRBfUw1tcpQECRCd0Pvh9zZI9LVatxWisvZkrHDq600zgx2CAaOAkQndZCR+G6FXz5NAuX9sMl4a8eY79JXsX2LLitcNdEJ2fUvB7UcthzFuGOR20Ux4TX41W42torLaBQySywRv7Ik9V/iIyGT9rlCGgmT7ZVOv365bH0hlZXr0ae87jhzIbo9UO2MbjinbKvymuUJuPPDcSNnrSj9MomA6qPthDadW4ZO/gYlx3kDuFBJB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I12eEPpsQktD/5fxoVPqGGDFUlgy7n5sj/9ld1kQZ+g=;
 b=TKZ+JgeEB7JzceNtBvPJpd5SWLakB1xzLTZbSt+61dRpBZRpuv0pk+V5SZwSxFHLpVfWvh5QkbaAvrW0jSuMubwRTz39RoKySVqP5n0NcA3+De50Xve0lyLoGBERV0DlZR+6AXkPJfvly7+FEkgmBZFsEv/ZJgWM8XHiYibfgN0IvTCBLd802a1Bvx+Oe2VOiPF43A45Fwu8BKSjsSA7t3V11Yr7S/lhFhMhift40Lfkv+rPOv5V86xI/S1ypMBcykNLigPHhS5jO4ZlM0A8jSdlJahDSH5BhCjzj8Q4wrTPWCJRIMDxegSqR2Xj/ifPII0YXi1uWtV3KSbcps+0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1226.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Sun, 8 Dec
 2024 09:21:42 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8230.000; Sun, 8 Dec 2024
 09:21:42 +0000
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
Subject: [PATCH v8 08/12] configs: visionfive2: Enable MULTI_DTB_FIT for
 JH7110 based board DT
Date: Sun,  8 Dec 2024 17:19:38 +0800
Message-ID: <20241208091942.47298-9-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 63d188a5-3a7a-4819-362a-08dd1769ba8f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|41320700013|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: fRpanDbE3FPn7poJI2k7y6WLsioiiy+TIIe5qfJ2WS22UpomUIx/POehw84WCWE1MUm8fex5135JSVr8VMSpLsJXgRUkgfYzSuVvUKFTRBZ4/LazRfHyIgLqyEIZk9c2P66FbPOnfm1RL2nd+X7CEdzJRDjKn8k8+hP3/Pr2NBgyNL+AzeDrYRo5y+hQ3hUpjzCksGX50jK3Yzqvy6EdTzsbaSwYRgHvpWb6bliInc0hLPDfLzcICGG6LtyRu/uHIzlCE9sj+YEhUN1gRMS5/xwZjLe2/1ux3EBioXDaRq1uW0+mOFef6aumGPKeYDyR1qsLdvROaCwD9CIaDRVtuZkTRzXS3JJjtdAZg/NTTb6XznmMjyMMgGyghAnz+FEtZogykV97qTmZh8Y9KVmS13RfXQIw65WXUwe1iY/W0LdLzb9Q9rbSUR3IMQL0AEAxMjGD3Lc1zN+OTAARC07AjuU4OaTChZMbCvBhIJo22U4YubNvh42wUejjOEInXtwFBUbSwgAYDRS15BZ4Y4qJlVKkxE4yiVEwjQF9WBM3MsyNs1bTw5dIM4eOicPGbUkf985Ztokc4L3UKrtXzs3DxdB0ucoxXXuaKpcqTNrHHn5OflHtlCcuBU0Hco1TCz7byIjcVD7emI9jFD8Knt4PTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(41320700013)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GdGBrRmz/nN/6UccxnQxYQgjNWeIYL38ikgx1vLlqtmACKOWPUZQWaPjZ+DH?=
 =?us-ascii?Q?6bjzPyXxYxrR3RY5rra/h7vhg89OmogtpXi+Hglrl+c2YJUFQgH7qycZVwEN?=
 =?us-ascii?Q?3ra7M6kamON6JEHaMIEGY9qm0qOqwoWqM/gA5EOsOeqEIzFxsK5qldc51++G?=
 =?us-ascii?Q?7sIjMCrae5UTw7bD69WDteQJWprCXJH+zxJIUCZ/piOr75E3pbHrp9AI4jXq?=
 =?us-ascii?Q?fgLFE1rwsalVuM28uhHaaVhTApJOYTTjPZaIKfufbFYr2l293YKMlH0Z+Teu?=
 =?us-ascii?Q?rMfiEFWNTb1OL7PqDU+4iC/PilQhweFNv3XtouzUSKK1WhYvEPqI2vk4eirU?=
 =?us-ascii?Q?hWI/HSWnkHQWhMaCLhz/FQXfq6MxaIPh1flinudsoTYSMzSb/Gsi5xcZQY0G?=
 =?us-ascii?Q?ZHdh3KgIhcr7OGKY39BvdXd4BY2BeMC8h3sJjrPWmYdduNg3iD3CmFA1MMi1?=
 =?us-ascii?Q?rDjkovmX3yX7Kj2H+5a/tWWSaDjZswQr1oTnvkUfIG8/gWOeitm3X7+wcN3p?=
 =?us-ascii?Q?WoP0m5Vxnj97bxtQyTsu9FjUOhIh2FgG4CHhR5f1lY6k/7MCUDqfLXkYQOo9?=
 =?us-ascii?Q?T5CB+D/1LzVWpm0Ih3FtdLhs922bdGqQZrLzk8Sc3w/s3KtAaQ5Wgh2nsxR8?=
 =?us-ascii?Q?3HrbJkVSQnh0B6PKFbcJel87/vdiXjyByLrWGldYlzVfyuM0VDHLT73BaLih?=
 =?us-ascii?Q?fd6GuSAxG1qlxTCZYL49vYD3/yYg0XAMXVHfVeFHIMAA+iXUQuCw9BltHkTe?=
 =?us-ascii?Q?X67sFZ9UiTdobcew0oqD/kX7fsKmsy6cWSRJWi/a76AtRu/t7MXLopYEV0SX?=
 =?us-ascii?Q?2xvGHLnFWG7mVarKEhftf5x2WzPJC1/Sf6rY3hJHMdMsp0Rcq8ymfR7t7Lw/?=
 =?us-ascii?Q?uVdBkBfYIrtNIeBA6y/JBW2qp05LNVLhZnplaO9aeNatmoZLOQWUywwGf5mp?=
 =?us-ascii?Q?UDSAJsxAYztoekdBQdwJhCzVJk5+bFxA4lZ/JcFHM/0E6bzJ5SVIPoKXYuCf?=
 =?us-ascii?Q?SWuZms1i1NDqhmz/1W0R+fTOgPEAFJSjOz5f2nIAO+6Q2zAGJ4wGTKiuiYnV?=
 =?us-ascii?Q?VK2cnffKd0ZJ0F9cT5v5tKV1ztoyEPv7ne252UT4rVpn8iopm38GYEibU9AJ?=
 =?us-ascii?Q?ki0qxEe2TYXTszvtGF2D1Oyh/FaQ/usmBbN+KQIjYks38euZ90N0nYT7b51D?=
 =?us-ascii?Q?BaRDspWT3sUiWx+zQ/hPtSAP9Xb6mjisoU/gcrwzWYfGFCNliYpm/nSKVbSk?=
 =?us-ascii?Q?Gwn6RfmS8tNc9Epzrt/ht7SyQpQA2zT6aEDiMXJUaAbGWzrwvwY8HP4++KA8?=
 =?us-ascii?Q?ojpeyOX01YEiOcg7wCmyI6XpiQLKzrRM/S4CGorFcXSe5Jk3oYiwEAQ3PRTy?=
 =?us-ascii?Q?GJZaYgs/Ywncl/EIRILF688/85ioVSnsmVDGMkol3R2O7J/UHnJxLE6BTT6a?=
 =?us-ascii?Q?mRBthI9m/UKA+eDjOe9Ug8i4DaYqa7qfrCGL7KlqZEfV7BDs+iBKgFuMEeX6?=
 =?us-ascii?Q?sSIZclYzCCR1nTrYLObyhsYqyOWoEmp42HTatSMi9G2rg2ZgtlrpXN20hqj/?=
 =?us-ascii?Q?8FpHhetU9F9BfLW318JJRq9kYbBu+WWr2aNW8GWV5SSYXZh2uI168Tr4unPy?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d188a5-3a7a-4819-362a-08dd1769ba8f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2024 09:21:42.6898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udLLayV2DwWQZOXEicIRQKyV4kMZhJrbhAoY/F68cO3FZvoIrdPqzyCPyoeAeljf5L+VS+SnV7vDRuRGdxhKolPvEIo356AA44846jf5zt0=
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

So JH7110 based boards can select their own DT at runtime.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: E Shattow <lucent@gmail.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index cb86582fd6..96056c50c8 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -79,6 +79,8 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-- 
2.43.2

