Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE98D12D60
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7891C89377;
	Mon, 11 Nov 2024 03:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9D3892E5; Mon, 11 Nov 2024 03:09:49 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09BE78911D
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiIln8CoGHi7tGk9kpGNljPvmFzQkVMxwj1FsALU08+o0hQIVW60ageUQbzJUyr5tY1xBtE4jWRuYQipcISqOYQlgE0iasxf/6sWIR9eRFi3DA3uovVUrn4MZGUuCrsgIA0fMKzrylXhJRyuFOExOYwvMc3vBd05+bW/t5W1EYwFjqtKrzM13qfS/gvw69Q6WMaihoWntAE5r6Bz0Se80BvpFU7sy1j7lYOj0iizkwkd3T60xhyR6MFSkErL0G3BYqhIFqjENZ3u+oS+H7hmBi1H5JwKRL7kWbT4JInBIgN7Kulj5WgDwRvFCBB2tf+78bZoo6Bus/1UI2Tej4Ryew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBHJJp30lHUkjPj0ri4VWOhD+dIkoMv688WXiK0fbKw=;
 b=m0Gh2pP4MdD0VvPlV5S/i2vfOjfoUY3gHvnXQ+Z+9hq1yeUyykg1UzFSvyX3g9B+KIbT2DAvGbxPVVWAOAiKyQFFLhNsqjx5QxVgGxJDsQsTn0Mx+sqFNQ2Cs0bS7XPxfv/MpRVCJo/OM6kSLflEmqkA8GImBqyRXtv7Xldmt5hsDA9qtKHLW4W6UqgQiGEbI0xWEz5zWwbtvboBfqSnrhFO7WxyW1p3yOefANhZSK3uBULXWRtL+Alx0HG7Nf4B8FsDOfkI4tZ9W1RUgUedcj5hALJ+hYbbZWz7IEVWeeJcfVrI5eqj8v8FDzbP/sx5JxF8ct8orPyynawDVGOCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:54 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:53 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 12/13] board: starfive: spl: Fix the wrong use of
 CONFIG_IS_ENABLED()
Date: Mon, 11 Nov 2024 10:08:07 +0800
Message-ID: <20241111020808.38974-13-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b941235-6dd3-4924-f56c-08dd01f5ee93
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: JvDTLWtAzESuuiG+i40wJ6dgDm2X9w7I3jjCieHnKqbEhTtTe6L6ueRVmMMJIo6M1dsNOVI7MGONklD98K1bGXLlTzA1XAigr7RlZ8DYlUw+o+Ev3dhgYR9dZYuHJ3zDjnBSBiZE5aZLX54vHjeXH/XjJrzBR+naz27lLi/9mGcpfixxVPqDwKRspJ12RkTRWA4FxEI/Ew6dyhY4x+pY646BAhLMeOHXRR+51VIbOu7PuxENZqD5pyrWgWf1vzAud6SoN9eyRjZDYdTMBQxkprM5C4Vur68H2wrAC5Ub0+mD3yGNAvIRWpvKyUaHun3vdlLmUMcpqFMtLX48FnOxZd2IpDOYdspqUAuQD9Ust4fPyWnzOqgClKDlaaAb3YNOmiMvVAOatjxyXPRAO3Brq9q9msmEbJAVrnMBj5DYbw741i1/9qWcSV5j/Y0fRv6o2ZLSjN6G7ZmHpzO4G1Jbf6BFZvu0lcfHgcCWsecqvK8JhPvOqIncFyeuOajdJvJqHOvA+Wl4g9dlGpkxX9xfAIGrEl2L5/TfYx0Pg4V3VH8/HcXgjC6meapedJSPecUtXUjVHc2JCYFRMuNt9uZ0/Ufs5Yl/P7SUmTNl/jlsM+FrE66I4GcvhlfrdsPuHSBaq3qmIRuYLJHDwk+bm6ns1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I2qLDcyD5V8HZSVitxWbu8qqOGRV/uGomtFnwGpqGqKATfQS3lK2Fddle4/I?=
 =?us-ascii?Q?4EXEX2A3zgZF6T3Lz497xzAnG7hSKSdsz2lXwEePV3lIy+ogczFbMUNPecXu?=
 =?us-ascii?Q?NlhUWVk6EgAkNUlSfNkuPWJTIQ7VxJd16gT6XXwuPHUWG7oEyix1xgYnkewW?=
 =?us-ascii?Q?dLndvUlhF6hTujjVPMj3trkAcylCsKHYliK1VWNJQvaBmSonVxEADfALxNKz?=
 =?us-ascii?Q?FXydqQqCk1zgVW6wHHbMkr/FQxnX0Rv6xkOZ/HtoCR82b+O6ZfHY7Rsgi8wn?=
 =?us-ascii?Q?VAIIjFPL1aKebxP5MROBJFtXmclYdQEm6bxtyoQDaQIeRKqVPcD8Bh8Qw2M1?=
 =?us-ascii?Q?dWovqheehbxp/3xHJVxPl+/Pwjb4y7kAXAXPtu0iqYJHi2HOZiTJxq97Z9+n?=
 =?us-ascii?Q?R2wYQthoTyXCFzR4tGG7Ce0pK+vLeiLhSq4a2Vm52iLkj31h2I+VJdgM3G/b?=
 =?us-ascii?Q?epeJmFPCsR0bSw5oOR0/eFDxwibVumZah+csXltoIPt4uwLS0K6QNaWq3Mph?=
 =?us-ascii?Q?LGB6VRmf2nhM3ncNKvW35W6f0mjgDLlkL5ykPRLXWgz1J/CaJr1em7XXUNQd?=
 =?us-ascii?Q?mat+/9urVx4iiQuORxnJRwpteCYxPo9fQP8u9Pbc6s81ug720zR+13hIxO9+?=
 =?us-ascii?Q?895YX8uLAPHS0jbgzTYL+HU6rdDXG1Pd3JtTao1roboVseKBeaUi9+jP0rVx?=
 =?us-ascii?Q?P59Qf7TOH3zXGNHHW0NzM7ECEJawL2daaBo0uDE+TUmWoYECn6HGbI2a5GVI?=
 =?us-ascii?Q?QEg0J9UL7NXwXyJTmAhTAzLuA9ASRORIc3OVU2sN96nAdzzpc3C8URCHxpB+?=
 =?us-ascii?Q?QkpeCpLiEHuJi9RBn5FJXhHBdXr/IS6c2Yn08lrkGCfX+XdfQl9oM8p8K0mp?=
 =?us-ascii?Q?cJE4xWIwc9aUsl/6R3nMFSHalHnIL5EmLNSZMOU/tAM7EdTZ9ZHSTEa9ZX8L?=
 =?us-ascii?Q?SzYOeDODusAONIlVY9pSN95bSkz5sLy143bNKpiPD51HgMqx33fgys5P0ABJ?=
 =?us-ascii?Q?oieVsZqBYDrsVahg9FDiusdRqKVIAP4pRLOTreWPYbGLHqJQwABrlc4K6Mq+?=
 =?us-ascii?Q?1n7V1c44koCeXfhon8oKvh5K8N9BXyBW69grJ7fmF1d3Z8plwMOEcYmD1wHJ?=
 =?us-ascii?Q?K7ATAbjfQx3x9t3YBqY6iWSS4rlz4SP3RpEpX8vO5s9QmZXIUXATYpEiV8KN?=
 =?us-ascii?Q?Cq/Nxk1whcKbNG/F4Ridf2zUuA7rSoiCOCY2HN/iRTBtah1NsIwbEXuf0JH+?=
 =?us-ascii?Q?YFEceX8OGn34jCkbb9okjBBOwK44KngfWiVeto3EqpwEjoWbVv0dkr8cslZR?=
 =?us-ascii?Q?xU2Og2AlpoOfoT3rX/gXZWwSO2c2bVoaPwtEUki7XajtEeTciZ8UPXw+u7e3?=
 =?us-ascii?Q?+/5T2+35wBF2Kt2ze4bXrynh+KqRvXhf0h5+/NH3tpkjLmDKioxZfM4qpyB2?=
 =?us-ascii?Q?JHOQerV5151SDMueN28H1uNr2oU/uUFpvu9mCpgN/UEbxOHD5+jV4Qc/QnT1?=
 =?us-ascii?Q?QHhfFAiHiplaZnUJfhqRi8Sge8ymAzgarZTfLZDIPVswIoJVLyTVWFKJEe5j?=
 =?us-ascii?Q?Jx920AYDLGdbNNL73D/MnZIEa7A6JICXMPih/wJi96Mi+/t3xwhpIchzb0XZ?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b941235-6dd3-4924-f56c-08dd01f5ee93
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:53.9025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UO/Eo6KoXFyrtaZpCT6S6qJjzSaVzY+9NaAWxPu/iRt2/AXIh0KvklZBTUiK4MkxpDs9o+Q2KLtj27YkMhDWR1daoL//A7s9JZVi5FiZxT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

The prefix "SPL_" is not needed when using CONFIG_IS_ENABLED().

Fixes: 5ecf9b0b8a75 ("board: starfive: add StarFive VisionFive v2 board support")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 38132ecccd..cf7f39d5c5 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -110,7 +110,7 @@ void board_init_f(ulong dummy)
 	}
 }
 
-#if CONFIG_IS_ENABLED(SPL_LOAD_FIT)
+#if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
 	/* boot using first FIT config */
-- 
2.43.2

