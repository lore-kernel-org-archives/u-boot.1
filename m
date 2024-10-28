Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73881D13590
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D523890BC;
	Mon, 28 Oct 2024 03:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DD2688969; Mon, 28 Oct 2024 02:59:24 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20719.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF2E88C66
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 02:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZyIlvBrHnqq5XtA//i1Rr4/fx81wz8pMWgYwKTXUsUAL+m42kLKU26Mi+k2KW5Jwv4ymaXlZabRVvenhZfKW3THWpGN+3M80nP/deYLn9bbwUeWaQZ7jNdhAy/+ot0ZbQJFSdiqzM6Mlkvu2N6VIKZw4441Ef7XpyAqXGk4m2lTj2UdNH9G4H2Y9bvrxOjMutOKCjnXQ0K3Qz422NBaEV4PwvW4lXc1RzSCHUT5WaSxX07gjjl5Xr2RUQ87R/p7qlKuWcGjTPaeC7iS4RWTMq+vSm6En9GbXowrP6pDzhrmxk7YBgeATTyzvmc0WFA1DmAu72SAjx8Fhhis4zZ9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEv+I/u1Ck+YkVUBIoPxOyh5Ymhu1rgbS06Kh2F2pns=;
 b=iGl1/HkKfCGfb/fnQDF5GQ3mroc432+SDtE+yq2MronW6qwFNLe0CfMNwZbDAwIA5SuyfvGfHKVg5rG23SnpAndyDKvAzE8cRLpFAKE5J4PUSGVrUs43JspVLkWQ4Cc7yrJcGuRMdIKW0VKFzSay7fx9ZOuLYyZpEEuSVh8mv4WA1cfdj5maDxT4JptBL3PAnE4NJSBp9EqprujbchOVX8EQU+xkTweHPIf/52m/9k1dtm1DXhjbH91kpTZ0RaerpfHOYTuHr+LvQ7VDYUJBt5Cnukx1QHAGk2VhXG5hY5RnJATVTcL+IU2mPhfzJs4Xs9t9EGDWdvHKssv04oHzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.34; Mon, 28 Oct
 2024 01:59:16 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8069.031; Mon, 28 Oct 2024
 01:59:16 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v2 11/14] configs: visionfive2: Enable MULTI_DTB_FIT for
 JH7110 based board DT
Date: Mon, 28 Oct 2024 09:58:44 +0800
Message-ID: <20241028015847.42344-12-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241028015847.42344-1-hal.feng@starfivetech.com>
References: <20241028015847.42344-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_
X-MS-Office365-Filtering-Correlation-Id: 856ea33f-38a2-4529-c719-08dcf6f420ea
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|52116014|366016|41320700013|38350700014; 
X-Microsoft-Antispam-Message-Info: fPJulF3dsgJ2qGEU9WS/8p0KxwsauFJtYK4e7SF6sR/jDkeYGp/m5rC93cxMcbf1tNJTFSY0yQJ2suveZVpHx5+nFqIPMKxJZ70IUVeffrXege1EPl5THCSZZMOI9SF0UQf3M4xe7vN5efzuKUla+qOO/3ha7lb4mbVovatIaFdV+8DYS2L5OpKoWZdBLxdyJkkhWcfgMsDRhkSLumRQbf+4gwOcJSCHfSC8ximxy2b59yzgtzoNmdp+igFGiR+1iUdM1ZHfxUfUGMVOYruKvHsyUECcp1zyrzRp6qVFbe9Il63YFRl0iIdT5+5jLFkNKM/Facomd8DAzllSLAo+sZJHwRU6sQuWKwh7XnLKHtJDkC1/QBgFRlRxh/telsKxz24x77H54N2QhydscZhTlB3sOi8/xwMhFysoIwrcsjOzvyirmBj6qNWKR0TLcA3jw8/uTD02G7FNfQ82xuWkubb8po1zSdVBS0IgsbQT03DAgYVovV8+NlOvoDlNSYePpR7zN5Pd1wm7RPWba4Cl0PrzUkKbsWI2uQGhphJsxLuwMeQvBu6OBAq046wDRLVH3qPtaHXa3lGCfcfoOs+DAf7J+t9Lw3CpOxASgG5Q+izRdrfeKAjSIaDU0Pok+3jE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(41320700013)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jhhDg0gqWiOdM1caxRTfzoTZVNycTKDTGDjlVsS7KbDpZtXANuY3TMhlJ/0H?=
 =?us-ascii?Q?Xh9it1HDIQap1FKrOx3PDkIbDh+1e8f64/Rrh0R7VCeiw89BdbeiVr2wDQ0B?=
 =?us-ascii?Q?UhWFzCKd5J9KoDA8Bbdqs8qqpRgfR9Eo1JPlFnqymYByABn6hrBA/SXYsVbr?=
 =?us-ascii?Q?uCGPUSvFB0Y6pGkbUe2JvLsPPeRvoCJIOAVOW1mzE0GPgO9GTdRKZOMZOeZf?=
 =?us-ascii?Q?yX2T4shmjDkazB877QQjNxN8vCt/ke5DQhmIuXll145qDnBYPblbBDAofN35?=
 =?us-ascii?Q?KQLxaJe7YpNweJn6DxJLhTopif4XLEqZNF9CDhWUiPtPcC+B7MG5m4pk69L4?=
 =?us-ascii?Q?jMslvo/MuVvGmJCvg8yiPW1lNM6EPrU/yMDHdG2tVdhyCEKGh645qW82PYgd?=
 =?us-ascii?Q?1M+iC/T3l4l3aYdhISwvQmt9EpR26tNFr4sNt32nkmKHu9Qd6qvaJnTYjgVC?=
 =?us-ascii?Q?qmiTovUniSaK1FLQncNS9ZshHHpZoU1nQZMoK7Arqh3Gu4o5dKJK94rfJ5JX?=
 =?us-ascii?Q?Y/WFK/bD8hAxGqWaOUvvz7sMuooBAuKaCQPK3+JwmOtiF3RMBEO7O9fUNBVZ?=
 =?us-ascii?Q?L60d7xyBsh+/GI227RxHh8/MIP8sPbd64wouoFvre7PHz/2LeKuBv9L8ZZMt?=
 =?us-ascii?Q?1pJnFwf2Z1+hgtYXnl4gpoEOn8piZVy/0VOxiTfuQ97zatmZhKDcQ/TJakLJ?=
 =?us-ascii?Q?Jg3mKcEE5QNW3yf0Vk+ymv0e1RHVzErP4jBOLTwHFnsJtonobG0vZTyothAg?=
 =?us-ascii?Q?uHQZtVpePbQ+ghPjzIdFD7qsDrWkp+dk+H3u7+yg1lwGcbkaEwbUsV+yt0Br?=
 =?us-ascii?Q?aR3lFiGRjfELdiuGzCGeFk6CfeV33wDLlUFDjfAEtqfaDMkUMBrFMuu7rqn1?=
 =?us-ascii?Q?uAIYQVvoo7OBgkQWhVreUuU7oVe9ZSLWC3bJ+/YpAZl41BuyWVVhIRfdWHaq?=
 =?us-ascii?Q?lEQzUoqvuSEIuH4lzFH0WsiCjH+r2WfcsSTqDiUTSxR0rKgwNsTpbdJolNFr?=
 =?us-ascii?Q?F0K7eHx6Fz/pnXpPHhrJ84oRXPcQvFHW1qd4UZv/Tzqmy94S6a5cqlStnN+m?=
 =?us-ascii?Q?ltjcPhdesli9407KSO1gsE9WmUGsqMdhZaqYHvNgib7KhlaeYjunq3bIBGCy?=
 =?us-ascii?Q?mGF0u0uPZz5hi70N3ndW9Rtuhs8iXWelwiyLcsrLTnnKvETthyO3uVA6rTc9?=
 =?us-ascii?Q?qdByziiXaYCBYdLszABD/9rB+rW6Qk1Hd7CpIMy3QsNJPg4YLQbqtO1lJYg6?=
 =?us-ascii?Q?6bvNO+f2flL7OqWYP8YyYd3zmKr1Gw6A3vclsUHY/IAuRBL9iRsJ3Oi7nKi7?=
 =?us-ascii?Q?No+p6stMnOBdXe+ApcMkOLCzDfrSj2/gKC4/0QozReBAjDP8Hl6obULrcA0x?=
 =?us-ascii?Q?d5oTM9s5LlV/3rsvM65odK3cV9+FmgbSyMhB+G6RPGF8gRRqDsrjUvntlbZI?=
 =?us-ascii?Q?ZsIzqK8bG3syMyWWVhbE80xvy06ZDf0AnyaL+qBTviry5onW4ZPOX0J9WnRY?=
 =?us-ascii?Q?OwTJR6nPaMxQnIbkF8TZVEzNM7MSX0DM4x8kGgEuz5gd6C2vBIRVi2LH2dtx?=
 =?us-ascii?Q?DgimMbT+9SDVXVWGgyKramT+8Lqha7u4R/3nnKXRQkvzpO1ghhI6Jh/HRqty?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856ea33f-38a2-4529-c719-08dcf6f420ea
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 01:59:16.6093 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ber3NviHJxmDLLHYjdEhvUUMinlmWVEmon9+7dK1CE3xrmaft81a1XOuerXwFHbU4EMbGvJkzX41bGLywZp8p6IPByU5sgau8cAWUG/tY3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-Mailman-Approved-At: Mon, 28 Oct 2024 03:00:01 +0100
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

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e4ecf205e7..be9605d053 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -74,6 +74,8 @@ CONFIG_CMD_WDT=y
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
+CONFIG_OF_LIST="starfive/jh7110-starfive-visionfive-2-v1.3b starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64"
+CONFIG_MULTI_DTB_FIT=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SECT_SIZE_AUTO=y
-- 
2.43.2

