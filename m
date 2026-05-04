Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D778ECD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B1058468A;
	Mon,  4 May 2026 15:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E79C846A7; Mon,  4 May 2026 15:41:57 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20720.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 917408468E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEKFQlDBnsB4wPwrbSMvsgSYCDfr8KW8LezfR14bZ5lgMjGtG4IAZJF2YkYKwcoLiD4bhISb8dq4ardA2JAklqdj/PqS8X45qzNteiastJX0fPBdcnTtdC4TO1Vmzs0QKV92V48sotvOWOcctwXicd65olHr4prRgql0y6noaIsX3wKYCco0qtY/psNSl5CgZJrJ7hlS15Q+qc/SxeAAfDAjzOcetp3Lsg1Z0NVmNX6mjF02J80OtVZnmt92nniBOzJNudruPlOKp/sJy5jjaxDT6OqOfVn3NS2NiLEVMnCxTLR31H1QPRzj6nSWfEwHq6ZIexif6E64ZAAHUGKdIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lc3cE0wIAdMZL8xF7qMMVRQ5Vlws6LV4MYkEwPxLgWs=;
 b=GlnguG4Q7x93gsLK+BVop7ok/oWMIIkU7hNiixPtcNe1DPsMQ8DDG/xLTudn1zxxQszP07NTlAPOmrY5uQ3y9c3qpzANJLa00dqomIN+Y03w229A9uWtJElfpLH+9f6WdS+AVoGHtkEl/73iX8Y/WyOmnC7T54oKa8CDgagfAcK6P/s11zPcQ2MtWQy2rO70vyXJV0BAfwBG5nficeS7+49O8F/PgzzaCc38ng0iFNKE7C4Ln93yEFDmgULV5ac7UPXqPVrZ0gvxO2LVDEqTotTXli6E+BS21HgbFfbkPCyS9UGwDmyPRukkeeSnG3couKbFY8nTKwwq4l6x3g2dzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1227.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:41:44 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9870.023; Mon, 4 May 2026 13:41:44 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/2] configs: visionfive2: Add VisionFive 2 Lite eMMC DT to
 OF_LIST
Date: Mon,  4 May 2026 21:41:34 +0800
Message-ID: <20260504134135.4542-2-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260504134135.4542-1-hal.feng@starfivetech.com>
References: <20260504134135.4542-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::29) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1227:EE_
X-MS-Office365-Filtering-Correlation-Id: f684a613-cfeb-43a6-9b76-08dea9e2e11f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: WtoQMb+OIcBagbnCRJljxu0SBGpcDw4YptD3xosRnwFIzswUo0WL2LggmkwagMffAyAiYdPSOPi7tR5nXdhNbtKDLGyMYx/pLoYw5vvxPXzD1iyEHhZhvdUYKJ4BdupChyvPfc2zaJ9Qb+Y5wUYkhwCG5pnWSCcdlF7kraBCc/tX6f0aRTweyCICcnXttiDANTy2CRrIw43tmkHICXtaVhIi5LMOjEnzFK0eCkoCZ1DoOh4hNq9COaOB0PL0qkXN2FJwO2NopAHmMOwrhsAA5awhFVMSHlmbgPRjqstJDrcrIiW22/glf8Q/DsVTh4CMu4HOGEXrrN4GX11OfmUGrKVT/agJt+4YMo9jzas8vM+teYxr3M9JMWVDyUDg7s6NwGzsYkDJCVVPpAchj76QBzeIpZ0MRD+D/ySZMgJNoeD9O25eVq1QLlsnymCwEccEEzbI6rcR9nDN1NnwSJd6G1XdpF1YN1ATFGlALDz2gZMlJ1A01gJsZUlmLPYijiomTxr8M+zjI+HgTiuwyNvveIKPUHp5ilSt6fLynXsFRFZxKpPsbLbt717YfBB3gtsO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tmPwg9DdkTFBclmrD8C7t3LV02BOCaYegbbRFbonkezqMxj4vme7T2ADblOQ?=
 =?us-ascii?Q?xi9USUrU1elSQQ1vGf3SZ69AQ7H76GVTusNZFAyOAzeTZvdgH6Wx1MH/EfbM?=
 =?us-ascii?Q?BRZ6f4mShmw5qtUJy14VubedBGPELJIdXc/y1Pfa1tUQJ0ar4AoPj5An370a?=
 =?us-ascii?Q?2amHB5T0IztDOurfS8u//3RwiITm9CfgsaKR4a9fBiKwJBjpLVY6OjKEJNSK?=
 =?us-ascii?Q?maD44Dr9wrYvLHxYbamJnXLuMn0Wf/GJlReaqFgMIPNJ6/f6hfwKy8+Qjaus?=
 =?us-ascii?Q?s4Vq9UIYyKmTwk+WI9Fn8/BaaNBI4uSRlvaPPEJW5oDvvM18zxxRsSmaJsCx?=
 =?us-ascii?Q?mUl9QRYECZZnL+EGrqLySITXWGaLWFSVxshk/WBVgKbtwyw/lXY0vVK7MdNM?=
 =?us-ascii?Q?pYwYMIuYLhMsgPamqQ+aA45n26lYT04IkhB3GqSCorJtB3bqtfGPenF9O6vo?=
 =?us-ascii?Q?2+wdoWfojSgcxOAarv4IjCEq15ZvKidfQ3YhwFKUcRrSomDOCgJSjQzzuqUm?=
 =?us-ascii?Q?8wYQoSTaXTJcQpKi7q0N5RgqUfZE3uxiBXbyltDfG2ohmSv4/HoITaOj9yb7?=
 =?us-ascii?Q?sh5sV0mzxAs8chx4ncmzAi391xWl6dXh8M3L5bz3Y1hZoQ7+tkIIL0nJTzZd?=
 =?us-ascii?Q?nYK2nj4X/Ityt1RK/2ZuCtzZafzya2C3EC6tHuAWTT9o44CO6wGlxrCyKUQH?=
 =?us-ascii?Q?kDKS1EES+SkpVn7Oj98cTRhjbGZDtG77024EieOXz2ry9NIbzMXAsOeOMfDh?=
 =?us-ascii?Q?NiHE2mVakkWwOVeWc9qFNLbO/VSbgoJzTyAb5J3TeE69UjIq2hZwcPn4Qj6O?=
 =?us-ascii?Q?plTVxwqqFb2cHLRqDmU0FK7sn6ivv51xywRrpUPAKLsZ5ATFncj7imkluYWK?=
 =?us-ascii?Q?nOqKqeU/2diPAqxXRgyTQJ+cGaMQV2CTuoRNiLtCduYyjCA6JhwMKcz5eTxy?=
 =?us-ascii?Q?Dvss+fbmaa3ivqzrfKjjeRpJDeZiCITEU7uyyKM5nSIWD7kjOsqOdDejVebc?=
 =?us-ascii?Q?Q0ZCl5G8l2JqKMDdCYYpehZxZP1yFh8nQTd7j3XwqJkB4SBAoOhtJWDFBMOq?=
 =?us-ascii?Q?0NHMYqO4plxN3EUHLZxMShBLmfqgHpFy/Pfp2FtNPTDExiJPey1ZR87YUYjt?=
 =?us-ascii?Q?XWFnf1jEKdYpzTW6CdFjUdxELF1mTlEFVs+iDtg59oIUolCB4mPkXFfMGFLX?=
 =?us-ascii?Q?yJ2C70zWlFaXIRwXZp8M0IXBDv+A2KWK5esstT6kYGFJQ72qG5bPWrpQEn+R?=
 =?us-ascii?Q?ShkycX349mZWTJevDISWqrFz1DzIir2SQkevC/5/Lo0PsjPFjtWrzNpMDBzu?=
 =?us-ascii?Q?ItDiiQI7B+l1vAfdC57Lq06llH2KJCYG8jtFTN6JahTWnsR6DFup06HdPj1C?=
 =?us-ascii?Q?RGhfvwr2+xqU/dnkHODXAqQVIIlaKvVXJioN/rpSgWaCV8pt7YMgKa8zN//o?=
 =?us-ascii?Q?4C6jcLeKIdQtTNv+Tz5ZBOf13SXEsC83vgg6Y5rFvoqpNTyDOcotdRRnIlS3?=
 =?us-ascii?Q?6oVERtMe1dg7WA3dgCudfzli82N2nJr27BjN6uJVhuNYh1gTTUnNM2NlZq+O?=
 =?us-ascii?Q?dNWEo3QLaemW7Ww6RqPwX75X0YKHaorjAzV+zx0Oi44qP1BBWeuXtzCfqONY?=
 =?us-ascii?Q?c9sLjtb82y5vDJ2vM0nmpnjuknbMrb5QqC9SzNaEWOCn9wbybWawWOAFA6M6?=
 =?us-ascii?Q?ZrR1Mxa38jMTvvB3iXPkUIBlUaYS3nZ8JTmsGrPO3o0UY4XnHF3nF7DCM26f?=
 =?us-ascii?Q?SKSd0UNTwQ0d7uqnbMfaGxvoy+AqAt0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f684a613-cfeb-43a6-9b76-08dea9e2e11f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:41:43.9170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYHcFIyZeBuVrB6/u2AwMy0R1RyWxHZb5GmE5gNuCow1hHQ2dh2wBXf10NdBmPKd59/u9/iYI/bQ1U7hV+7WXC6Ze0jZcJuKBOV1utBl8bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1227
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

So the VisionFive 2 Lite eMMC DT will be built and merged into FIT.

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 74a24dfd074..b6b3108ac5c 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
-CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-lite"
+CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-lite starfive/jh7110-starfive-visionfive-2-lite-emmc"
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-- 
2.43.2

