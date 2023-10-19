Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9215CCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 09:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D08D871DF;
	Thu, 19 Oct 2023 11:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="IMNEVtaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A9C871C6; Thu, 19 Oct 2023 11:58:53 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::703])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69430871C2
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 11:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTUJS0kzIy6DSrBolimK/Wdle0Mfl4HwVHCBvJO8w0/byRax0nwwVDIkByWLa5QLpp73sJM0QvKyKP99duD4A35ZcgE53sKSq9U1fKrecg3jIOWhJEA4+64ORcPLuY0TToLx/dFzHwyGgUvpEEPy/fb1vNRaXqfV4a/M+YGrW4g1pe6bhSI1U8F12kIKjc/drdzcjs3+zXaMP2WMe3QB/Ckx74emNl2CDqY4UVY6XzixwmPk3fV7590J9viLQItrYTvewbNCbup3x2+i+/8qHjmjW5LWIpvXE9ryOfgncKa72mhAJSPf61qeTSq7UQk/JKD0j+zGv1NW/gEAaCK1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlRotd9yd13jf8l0jcj5IVKLMXLJdstAWXOP4SFeTmM=;
 b=nOskUtxKoOqud7iXafaOqTZLCm2JldaEhK+MyBfQ9SgwybrHofRPqV6U+jms1U1KeBlxwIE952fK+k4AtDmvfjOqoAc3rnuW/gPHsAnzw7IU5hDznaE73UrSrkom16gw4YzymPVeBap6GO1o/J77Sz0XN7M+av28T/L04uWdh2jXvmXMQeg9cZn07RvaiY2rxUj2DfUg5rLcoTbsFsxqN/hb6qOnesOz7Gvj4iTPwaEwpSE5Tpj30aweeVdGCKoKCPOzkxa4pqBx+qluYtyqR+Qdlc0RU5LhEoSxAWlMiGJclopLSUhrk09+Rp0jEMoeuh6PMOpQv7AYAlEu9ieHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlRotd9yd13jf8l0jcj5IVKLMXLJdstAWXOP4SFeTmM=;
 b=IMNEVtaaoi66uFS12pJqXBpnyZGh6ngb+RAj2wW9YdEuTIAXfGYnTbs0KwDx+Upwi2IMVn/9+62WEZFWcJON7AtbxRsfgq4UqHDcyaWLZJYGcwTis3HYoyWpsN6T+YbpI19v4DmbHM3Uk77Qnth2S0cw4QKyPztg/CdERUUxAT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DU0PR10MB7481.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 09:58:49 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 09:58:49 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH 5/6] led: led_pwm: use led_bind_generic() helper
Date: Thu, 19 Oct 2023 11:58:36 +0200
Message-Id: <20231019095837.2084458-6-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DU0PR10MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 39171ced-9675-43f1-2cb1-08dbd089fe25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +PubQhzD7nE2+Nb5dcYyqRedKIMVMrktCRrdaNsnhRO2vcgl9JO1tKDv2fw0O1/ttGwQohLq5ZBt5Ck9/SBmuB+YpxuoP5fr1DbPr1ouKQ4fJAUb74IxbYB/Ci+AmZ0qdsvI78i+TpEsTokKiC6k6t5d8Np2jNjzjM7/vSHUjTCK2aKubrRH+UHNfP0kLZMJPjxiV6zuQ7K17g065dntSXbOKNVOYb/uvvl6z74htIfQtasC8vbT8saYCU2ZYrsVrqchQ6tPkW5uolqClqo6Z0b2PHNDsrl0myHSVApARFybYJc5ifsNYwE+JpwEe1nZgILhhccfoX61EupovEISs16DF+Yb2UlzNv8olJkOud3B4uL5jN2ob6IwTR9AndZVTcmgLeAnEVNDt2FrCHfkJG/gy1m6FCfExFZKrORCKSQ9QH2ok4933ULl+1bFrLxDyaU+l+TuUpBHz6RNdELIEE2Qawty8+ES+r4B55YPpCouWiW5MtDwjY7r1Q00Mn9nZUF5DnRlo+28BgvaBJX3qr/nIlEmSX7FeIzfi3/IoFhGKiaYi2ALu72O2Cm2B0JgNAtqV1YslKM4N4Bg15pBGAHc5RfyUgb4c91KSolY7qdC/HKoYa/wBUBhxqLXS+S1oP/NEYH5fevreUdO/6xQVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39850400004)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38350700005)(2906002)(38100700002)(44832011)(41300700001)(36756003)(4744005)(86362001)(83380400001)(26005)(6512007)(1076003)(52116002)(6506007)(2616005)(107886003)(5660300002)(4326008)(6666004)(478600001)(8676002)(6486002)(66476007)(54906003)(66946007)(6916009)(8976002)(316002)(8936002)(66556008)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B3dWqjhH3c8N4OYXPlbgUhOYKp/LXMBd9UJ9008e9PNDxh8ckoruUHAEpuCa?=
 =?us-ascii?Q?q/pUIavdh2rd3Y2MT6VQGsumU7qv2IjKwwiDqzCz9sKMaCILRKiOqKH8XTDJ?=
 =?us-ascii?Q?TqIrKvyD4347FCevdLxAjFfO/b26HB4wltjjm1C0g+ggz/TzuL7Cwusinrr1?=
 =?us-ascii?Q?aF/c/4XZ41xuvQlZ63cjCo8+Hu8uqYdPzJ+vJmWqJYaaGVgJOfFUPNaKqRSr?=
 =?us-ascii?Q?Dzx4x+v9v+bwY3LPQqrEFNSsq9l6Yujwx6Hpa2fd/o9SmXtW8FOL1ZvWsIQE?=
 =?us-ascii?Q?GHhpmJcVpl2hMOontIT/PP5gtiodoROMOrbjOaCyh8DzJcHYrRqHMmtgaZKt?=
 =?us-ascii?Q?yuToUY5hIB5q0ZOJf0O0wR0VlDMghE57Jhcf98ZO3aBKtwFpcqLcSNwXcOVB?=
 =?us-ascii?Q?QGJFOxkBjJ1oxPabnDwrOXGTtzQgdhzPbegeJPfxyR9XYIqAmXYeaDHaEbEr?=
 =?us-ascii?Q?APj2e4z6I7NtfnOPb4JqX35tHOX1nR+3a5TdlWXbX1YgOZwNtMQn1NAa5BDh?=
 =?us-ascii?Q?SE2MvnDk5hCW0zFsoZKrO3gMSPyKoi0Uv38xACpy1McpwHKqeRzyEWPi0rJU?=
 =?us-ascii?Q?hivGeegO8HS2zA8pqKEp9aOtWfiKmstCr5W5hk4bjpqhTgpqKEDSsELrBjQf?=
 =?us-ascii?Q?DoGMSYUgL+goSKYy91bmw+G2t2tJZIEURphgG27Rir6P/Q4Ti/JFo/AaznZ9?=
 =?us-ascii?Q?+Uqp5/zldEe6BFJgN//JhkIDw1mHgo9Z9T+Ddq8auO3bDRDkIBUfZsW7s1hH?=
 =?us-ascii?Q?/CMn3cYEKsL7Pfisf5zLoE+zUm5b8A3lxgxT2YfnO3ndiGOLB8yemSUYHUZa?=
 =?us-ascii?Q?JiRNmhbZvsbQptvP3BppIeYPCdEyFYQKN3S4JZQ4lmlnssspYdfNNWEBRJvk?=
 =?us-ascii?Q?DMt0xFhfNyffKkQ7hrLgUGaGMIscNINj7I7X7l00Oi77l++Ps99RmfntSvEH?=
 =?us-ascii?Q?egLFbjifRyrYmvhoj9qVa+LBPi7lITUoR2bmmtPCAzya8S/TcAVildjki71J?=
 =?us-ascii?Q?0DhbENDSQAghH0YzuqraECuUTQBTYTB7399RwCsfUddA2bHLxTsB8TrgPIMS?=
 =?us-ascii?Q?8/rTHFIshMmvUwczS52u1R/aa0XefIxBlnA3ILSwRdweEXVQ12DdzU2dGTPP?=
 =?us-ascii?Q?IRr4gAuLCVOSfwcHlYFiwG3wNVcU/GdO58nuNIN1dPfNJc/L8TGqdKO/UYk5?=
 =?us-ascii?Q?EGGe72bzfUTI5We2qe/JCNkvB3pi3+H5bKMMg2vPZOHK+51xgylUhQ2Zp3X/?=
 =?us-ascii?Q?tYVzN7VRa6UWoDV3dgoauoAy1rvMIJaTde0VXD4dKxcgVl8+fCuYa2eBvHV7?=
 =?us-ascii?Q?XLnz9alsv24sWHw4Dy7lvJkAaNpxTHDndOYyQ/caAoghmgONFPntKV9rP8U0?=
 =?us-ascii?Q?YVuFE8/+S1tbVL+GgIZOt3X6qTeFn6fgf3OT9YsOnWTEAzuKw4FiUYZPoEsT?=
 =?us-ascii?Q?HjOLQIRk1xY2+K7nmxG9j/UELozy3ybkGpg/JgKvh8xxvE95RMA5Rk6szA+7?=
 =?us-ascii?Q?S5lZjF3gnZh5xlgNCf3w8X3DRDB6UKwD/ld5Apev4HZMgivDPhMFEtpwq0Wy?=
 =?us-ascii?Q?WDUNoHSKyy8kq0fVhtcHKiogBFm4M3z9mMuMfLxnPpU6b4mv91rdX2BPTfJ3?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 39171ced-9675-43f1-2cb1-08dbd089fe25
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:58:49.7777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x634rFFso7pu3Gb9uw2nEoi9ZLgHcXCb82DVBQo0FUJpj7hv4dsrQb5tFYCjkgOjzeozpzh9RMioR84sYFhR/mUbKCpox+MgSXS1RF88bXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7481
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

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led_pwm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/led/led_pwm.c b/drivers/led/led_pwm.c
index 7c8eae9337..ae6de3087a 100644
--- a/drivers/led/led_pwm.c
+++ b/drivers/led/led_pwm.c
@@ -9,7 +9,6 @@
 #include <errno.h>
 #include <led.h>
 #include <malloc.h>
-#include <dm/lists.h>
 #include <pwm.h>
 
 #define LEDS_PWM_DRIVER_NAME	"led_pwm"
@@ -136,18 +135,7 @@ static int led_pwm_of_to_plat(struct udevice *dev)
 
 static int led_pwm_bind(struct udevice *parent)
 {
-	struct udevice *dev;
-	ofnode node;
-	int ret;
-
-	dev_for_each_subnode(node, parent) {
-		ret = device_bind_driver_to_node(parent, LEDS_PWM_DRIVER_NAME,
-						 ofnode_get_name(node),
-						 node, &dev);
-		if (ret)
-			return ret;
-	}
-	return 0;
+	return led_bind_generic(parent, LEDS_PWM_DRIVER_NAME);
 }
 
 static const struct led_ops led_pwm_ops = {
-- 
2.40.1.1.g1c60b9335d

