Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CD3C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0487805E7;
	Wed,  5 Feb 2025 14:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B8980207; Wed,  5 Feb 2025 03:58:25 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072d.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6422E80087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 03:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGncoqOBQmUBE5pKu1EV5cImNgxOZOea0VsvvtUNl1PKAzI8Pp4xa17G2evnC7kcDvUs3mtjnaQfpwk9QkhmmTaoQdsZBJ2nrj2nmeF/o99Aa5RPkTZ31Rd5mw5440xe16VxrQ3gh0LDFSMvY43L61Zr6vhJmZuSnOgIo9ZOl2AymQfpC4DZOsC+U33ZG6OPK51t06+Obcx2GGUCoN0jA+jaUZ/ABDCWSTP2o2B1BUGm3g9/Lyn+EO83QgWFTwoY7x8MlE6b3ltRjYB9KrjfxYCQss4umrapO7nPFu/IYMTsGGRdOOsaIXyFUsRm+mhCB6f8MV9M7qBn3g0/uL3MMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFnqGTjVaxYzZq70zaf4s7uDaVs8JNmbAUstqKWXuyE=;
 b=ZffotQNHhgRndYppeVsKio3XUMpOzxWLsd2rHzaYw5jsKz1lXyVuqfu/erqUxmZcxX/IIOk9O872+E4DnENXVOTtLMXf2izdTl/O2Wh7xOtTa01pXagswG3P1OfXVUs7h0f80kSMSTan6rrv+GNBNO63EDFCI+ChEWpeU6u8myIFHmDAzU0d6CPqI1wairV8Krz+9THuThVPDT3OHN4QwFf2KiKdlQ0fh+lHAEiTHjvwVK93lMYEMETqRj4lU6+eJpo6JtkVoNxBiY1EtTRGNQZ5YWab7aucohpuJm50ruFoFQScDxqon84edU8LQucesSjV6fBRS1pb6QQDVm/N8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1324.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Wed, 5 Feb
 2025 02:58:15 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8398.013; Wed, 5 Feb 2025
 02:58:15 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2] board: starfive: Update the maintainer file for VisionFive
 2 board
Date: Wed,  5 Feb 2025 10:56:52 +0800
Message-ID: <20250205025652.5171-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::17) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1324:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b315fc4-8a42-44ec-c1f2-08dd4590ef41
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: jggcvs9vWaBT+ta7Dj61D7EZxcutVF4qSWEfSGyPfXJm7j5jM7ONtV3wmEJ2xBRTmnDzRWg/BB3lkHqSVEVMr126CxffuA77VCl2N/ihZwKfZTlQWXv3jMXbdDZCDwVMTkZOxxHjcN6OY9T3VQWMU1/Sj938U53LqGoQFY3I+MLxZBU+3LVzysACf/emzChnYetY09MqkNoXzpUHHDdt1BY6oMrG51irmv4j3sifHPFR9WrvILZUfIN4oxq9fLwVAQX2pS3682o4eYMPgvU1D0jFriCnheccy571xXT8m1JgbhM8iq9PFbt7XJ8Onq2QlDVrn11mx+8kiu9L2ZqYysa0Mgihi/UF9MWiLxepoG4L43XgIkPey6ybPiMOaH0yWK7fp0k/5Le3XQ7zy59v2sH0gktIYTCVa9Vk5yO7vdQIOfLvupp3r24axvgYEMFBHnOTj/fxA5WaXTvU+aA77qifJkF93ATBIuIn6WzlWlnMK8pdPsZqjfoTvzlW2JZ4///YmAjAU/eqL4d3DUJc1VrhUlFz9DaY+lTIikQIMWlK19QKGD+xEd8DxtJzjHWj5/SfIV7D9ArOlVvGzONsSR149f1BUIQrfmDwBUEqii4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67NQyKUNp0Do15847Zb1BOsvNrehBXCOe42YYpKJPeRXZMOL+hTjFYOeuPoU?=
 =?us-ascii?Q?AUbuWaJk/y1uKi4OeyF2JxFk6yyaninooqGCzFSuNxAo5oOOO9YRBGM5tidH?=
 =?us-ascii?Q?QHmNIm9JNi87AnWW4RDVQQk3Lv4R36jGU6/eznR4MVIpd/fx5qpUtSQA1DJr?=
 =?us-ascii?Q?LNp3jJceWq0z2L++RhDCvaO9b66UrFg4SeTTrmQr9f2GXUQ3tWgCd6AxqE7o?=
 =?us-ascii?Q?Y+t6kDGmqWsydJD8NRwCVf+C5b4gejaFDWs2IWCk0RnZfsCAmWnfZTObeODM?=
 =?us-ascii?Q?pP9pmfGHn5BGACv5EZNM5OXvpdx+VBDdgiEvcW0sP2yijg3DDtjrMKvVnGGO?=
 =?us-ascii?Q?UZdJpX0/2yuXAQIIPO4PRpCZHOOsQ3L0QCotffW49h4cfvD+5U7IFvY6YOJK?=
 =?us-ascii?Q?0ntEDpr21Skqcph6Y1bm9LQkQm070eJclXOECv5ygg8WzEJAiDODKzx7mxnL?=
 =?us-ascii?Q?aH+Yhm49/dYeyWAixbzniWT3yHjyJp+9FES/fCPOclP9WAO+KM4RrF5BCgsh?=
 =?us-ascii?Q?FhhJ9bD5UP1hvmkN4j4K1V+gPBv7iIv9B6pnAC/W2BAFg9xPDjtw6IKCKW1f?=
 =?us-ascii?Q?saJwrREg5aZ1V3xQah4L7P3JD7NECo7PdOlKWeq49agm02M+5+iFwcYL+KIJ?=
 =?us-ascii?Q?F0fHSr1HMwucrxgsYDF7GezeTwV+HaEdX69ML5QG+lkHDJES77jV1Uwwy2wt?=
 =?us-ascii?Q?QOyp+40TWuZj/F3QEtqpwNIOYXqtp7VfFAm54WbNaUzvJ0zmRgD3d0FIhFSb?=
 =?us-ascii?Q?5E2o6a4OIfOI/uz03RrRxSt/JezXX0I1jNSjaQzj0w3PgS9HxJFzqPN0j8lk?=
 =?us-ascii?Q?WTeBTeyXTWG7iYi9Xo+I9GXvNtgDM1yt+MZDi/bZToJOtMxbozhqJoJ/Qhpf?=
 =?us-ascii?Q?pKg4f/zDzwggv+W2SyGAUnL+6VqscVNGwSr09lvCy0WQsLuOLvv4tCAmrAsh?=
 =?us-ascii?Q?psZewKJQB7V6YgLD8FNt0QvDJv79XraZ2iZyTur6hN1c1L2nf0vvyxY+TkBL?=
 =?us-ascii?Q?LvtmsQurwC2z1Q75WAl1uSlrf09UuhHEzDSYfUcRPnCC1f4RLSov6vf8VkNQ?=
 =?us-ascii?Q?gY5UZEx/lYyWksPi94ObXXoKFaoC5gQpy6tKViHv8Ju+LLgjSLxiHeA71lQH?=
 =?us-ascii?Q?BqSQMDscujvRUKoE/BX9zS/gnX54mJQ6PIfCz4SHQ5eVIy89keCEwQU1LC2H?=
 =?us-ascii?Q?mVcWcBG7KoPktWsvgrG48NTmr02wl1QkH5kaekFPSaLx/hoE4dKrnH2BQXxu?=
 =?us-ascii?Q?YBI4cebB461e0npFOskTUbXP9mPNIjt1LC99/BVa2GQMU+OkiuV+KMtigXdC?=
 =?us-ascii?Q?Gm1uqMS4T369DMKM3+cl3RvGoX649nJjLAK2oIX99PfPHtjBK7qW6pgLXwFq?=
 =?us-ascii?Q?T7GznnhGjzT/CNblrchQBkogP89UIQYaXGPlvADriEsos5zspesH6LaSXfEH?=
 =?us-ascii?Q?U0ipvVFlRApD/9aN9RGLgPJH+lSZzNQO2h6WQcSPzH4cz7iirfyTOrttvDOD?=
 =?us-ascii?Q?mOLLVL/0/K2JohVA0S7KPUHOv4sFKSlj8gZTM6RJcZeK7Fm8JrxHlcAt4BQ7?=
 =?us-ascii?Q?0tyDlKhJ4mOQNwSMHbSrruk1f+wCSb9ymHUzdSOzALr2UgN/Huqbw11fQDGv?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b315fc4-8a42-44ec-c1f2-08dd4590ef41
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 02:58:14.9618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+zvctCeqNye6l/tj2vd3FpoR/9h2jBLif6QLhJTj/iIwV/ok5Vvq3P0/VA9QOYME/FAPt63gxhVMgJLaHc384d0TM8ZppRolj3Yt16nMnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1324
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Update the maintainer file and mark jh7110 related files with N: pattern.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---

Changes since v1:
- Mark jh7110 related files with N: pattern.

History:
v1: https://lore.kernel.org/all/20250127083814.67839-1-hal.feng@starfivetech.com/

---
 board/starfive/visionfive2/MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b41..87589553150 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -1,8 +1,10 @@
 STARFIVE JH7110 VISIONFIVE2 BOARD
 M:	Minda Chen <minda.chen@starfivetech.com>
+M:	Hal Feng <hal.feng@starfivetech.com>
 S:	Maintained
-F:	arch/riscv/include/asm/arch-jh7110/
 F:	board/starfive/visionfive2/
+F:	doc/board/starfive/visionfive2.rst
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
-F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/ram/starfive/
+N:	jh7110

base-commit: 97c125e6bb441a8062bdd28e82f17b1da1224416
-- 
2.43.2

