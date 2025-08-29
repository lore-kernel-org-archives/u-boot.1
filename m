Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F9ACA0FF9
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3E8A8382A;
	Fri, 29 Aug 2025 16:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AAB7834E5; Fri, 29 Aug 2025 08:10:22 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545DF83487
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv+NpVDQq80xguQ/SMJA091XeugrK/kIznieJQzHKDwMGrrXz4DTGlOzQAOdk4ZWKvhgpkjVQeyV4QAF0sG7fdV5/Df6jJ3pzOJhKmjrCVDONdJZt2oqCRHK2LERVeLt4sIf/e1tGnlf/viPe1u6j/pUWL0AMB25X6+4MmUyb5YbaZaY+EYsNInDk+yTXR45TvPgSUh4p42xd0oBFn66Nfju+2lf9Ec6pe0ke5Llxbm6ovi+IBGcUkH3zQWlC+WXxgV8IS+vf83rHFjhbgyhFi0NIWY4+HuU1QnreCESdArgxB0t1nIfStRQgt5+cPV73PPCbEJOW9p/dSr0XemWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRJ4ds8m5XqnKQS8h1oI4GGwbbZaDqwULaZU2FUIkOk=;
 b=fHYw4BjrwCJgbr0hcUTivsQ46xS47w0vYYaK7pfQp0teNHyYtlW0l/Uwv7dBsuBcihdh+hvqbA4wnfehwPZroMVMiUIjzKoSc9OkNlbAhe4I0DHiiEIrGNM0H+Jvh+yVhEheOd23lVUCFx8yjbIm40QLq5R9s2wf7MhKPHyutxkwuQAOSlTK60Hm36ld5/DVgwyA3Cs0rWN22OH9vmV7tJrkoXRUpqab5edSPdaOqJAfr6QAnXokgJHoY8yY2UuZUwk8b6w0eGMwbsYJm2MSEChr5CoYmMqXvyAZ3Divpm0a7RQyc8y3kAPPpeuS+fHrXTKl9VX5CCGsp/Py4yB3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:15 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:15 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 10/10] board: starfive: visionfive2: Add VisionFive 2 Lite fdt
 selection
Date: Fri, 29 Aug 2025 14:09:31 +0800
Message-ID: <20250829060931.79940-11-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250829060931.79940-1-hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1257:EE_
X-MS-Office365-Filtering-Correlation-Id: cba10cac-997a-4bc4-1651-08dde6c2b8a8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: Ws2tLB7cB+KmBWPc4dT1mcI0NZzxqLgG8m++MdP+WR9RlchlRjyyGUA/zZwpYQtcWiFSkZdvy4kK8sD+qq4+oLnBWrBxNQa48B59kDBE/NoXFzrF65Tcd9YTCFkKAPBkua3xgxni2F+WP0gcgYg7LujMO2gNb9/JxqCoPKzgMIm4p58TUL4RExGeIXJwPb1g7rt06GXzKiYBGd3uHxuHUxdi8lQ9JhI0UrcwqAdV7C4pas/V9mBc2CqkIsvRod+r5Y+/3Tm+s+HG+G1pbEpAoifdaXvNM/Eo14FVqipIai86NBEXg6wNK2GVIAJu9CX8ao0x2CrMT8FShBfbjCdTzjrwEXbNAN9tPU863lxhV7AJgJBCFdUiXLSKUGqg6mHO7g82YpvaO8oAasH9uRQ2/gWyYPRDYrIGOl8aBYbwrL98TwlPym0g/ARRJF1X94Mk/ivO7DcapYIBMWG7YN1+M0ONQ5h0YF5DGGTPHp5qd4sncFUZiH/jbQuqdMHpGHl5m2kpdTUTgOcqwXTw2b0nWvRSt1Rmozrt+HNaU+51mMQS2PkHoL5z8PR47kiWiyxM5yQAfZOhohUwfthzAEy1u5SUA1Fvgh7Ay+vkHpO942k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aB2eqkFawDa6kYVwqAXRyK6pkfEgwY5Gsy4+Amgppr6CyTsuzoIOtev4P5He?=
 =?us-ascii?Q?exQD+nCJ3QYArGwxwJClpKVKjgNYj9erlipS9EDL/Bk+OCfrbtO1TEw9bCLa?=
 =?us-ascii?Q?0xuo43jTF9wkPFiL3vyHZ2wFC4Q5ffieCoqNOJzr8yAeuRpfJ4fEemKO7Lhb?=
 =?us-ascii?Q?5r9HyuEW11bquj16B6mTnTVyOOYY6Allgka9qpMQf5wf6U/WFdhdRh0WBPIq?=
 =?us-ascii?Q?T5Hs8Ew/CWB7Cl/wUhoDbq9bOfqzdCQS5nwwAN/Lb34IKnWZXZsvI7CpBkQh?=
 =?us-ascii?Q?ssuuY4kEovthF7O19GjDRErcnGn51EaTM4CWCDn3FTuNeA3rPKLjw0E5T+c7?=
 =?us-ascii?Q?iTSGmt+N1oknEiyCo1n3t0WjCrWlstZdeHcOdSbzLNNp/KLMPTMkBDKlXqnT?=
 =?us-ascii?Q?F8tGAZMDL8hW3F4Pn5zyFSOq3VOcgJyU65PXIwsVvan/59CxbVGBoNMRpL7a?=
 =?us-ascii?Q?GTHyxjiiZ8XKTA++E7lW8wTRpZZdw3HLvK/c7un9qtrwtVaKGB9xyVpQiq4c?=
 =?us-ascii?Q?stsCzsNg6Yz3KAayVvmcoVsNi1V2rkhsKdEGvRFDg2px01pBhKMoydK3zldz?=
 =?us-ascii?Q?84Ppkjzdhwkt+pgXwILw7O79vD6VaDIMwk103HMzTwh6tmEhDABcbWeZtGuA?=
 =?us-ascii?Q?LNloHnfMg00uMq+htf8quHop3igisiGkEQf9mPWXlTFFQZ5Ovq9uESLa0VBn?=
 =?us-ascii?Q?NhvsngLbivHJzN6S9uddLNKYjPkjOjqsLrpnBg6dM7n5uF2HvvOV1ix0PGKJ?=
 =?us-ascii?Q?H3+g/3eDWFLRSCgNbhNW1cJ2C9r+VShCtnDkD6528ku0ODtKfYkoW6R2gTOO?=
 =?us-ascii?Q?LDVuSuYq0BuzmBB8AP/0oflZjtBRDFK6lzK59hmSMY+2xKViXCdNJmmmyLXL?=
 =?us-ascii?Q?EmiJhK7LpRmUC2ftF7XIsBxaAcZ49FvgSeSpL+7/zjVWVjxseQ40oaix59eD?=
 =?us-ascii?Q?eObxncIFRkcmRniUPI/yAMB0pSANpe8NotL+RrZkTBWHAtRMgDseVpuqo2Tc?=
 =?us-ascii?Q?f8OAu+LN+iYA/c8qU0dTsEP5hH2bamHdqmNDVdFj2MC/TmfuUKrGDsRN41Zy?=
 =?us-ascii?Q?48YTRZjtq537kb3NeRU6mlOVSvtWEP08f00t9VxPsN+GzRTU5AbMUVrGh9Ci?=
 =?us-ascii?Q?oZNzEWiL7KzWTxCs8nPKzcSfZQ6o0GTZ6SIdRvZZQFjtOU259LTQ9TwU62jY?=
 =?us-ascii?Q?pdgi6953Bd5eeqbYvO/drl3nt1LUA9jHjUA3FY+YPrxuAIKYsO2XPS6/Tbpt?=
 =?us-ascii?Q?RereM8rxece7A3bKBe5cjGEtQyseiV4YApOxgiTL9EYhquffoqseQF8x+hcK?=
 =?us-ascii?Q?xXyRcav/ky++N5bWKhQAXdILD8jd2CM5cTm4jrf2tIH5BlVIhMY5Am6g+gPx?=
 =?us-ascii?Q?7FPyXZBja2Qmr2CI14UjE8+C15Vhp6TCRITqIBYMK6ycn8v3SDqzKfc+M0Hk?=
 =?us-ascii?Q?vY3MPapcIHtoILvm7iF06W/jXPmZOZzqOkdie3KAER2b9sPQ1StS+A3KN61K?=
 =?us-ascii?Q?fNdbbZ0Ai1cR5ddCj/qOjDe+2Ese8muBEfuLRmPaIzVPcKPWkcqG5w/Qz33L?=
 =?us-ascii?Q?TqBpVEL+gHOWS4+TTnuE5Oobjl8sZpTTxdemKnMkTUBfbdN3DRjPCq7VxEU7?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cba10cac-997a-4bc4-1651-08dde6c2b8a8
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:15.3986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ad9jAdtOBgFWumxVesUxh11n6f/2g+/wq4JqHUZYfPuFns01LT9E0DVjFEb+GQT0D5/KGr74sNtKDW+BCpmTLoKO2ERuWBSSPWdasaYsAyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1257
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

Set $fdtfile to the VisionFive 2 Lite DTB if the board is matched.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/starfive_visionfive2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index f38433e94ac..912e8cb967a 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -65,6 +65,8 @@ static void set_fdtfile(void)
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
 		   !strncmp(get_product_id_from_eeprom(), "VF7110b", 7)) {
 		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
+	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
+		fdtfile = "starfive/jh7110s-starfive-visionfive-2-lite.dtb";
 	} else {
 		log_err("Unknown product\n");
 		return;
-- 
2.43.2

