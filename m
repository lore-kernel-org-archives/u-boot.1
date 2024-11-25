Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF5BD3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2387899FD;
	Mon, 25 Nov 2024 01:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CC4289550; Mon, 25 Nov 2024 01:33:43 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1765E8955B
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2sTicvRhWOmMSfSC3XUIm3uqiXqoqsadR2nVLx7pzDQLuodOm9OKNxi7M9qlzU1++HYU6i8mZl+wyN0gbI9wRJkw6lLGkGZB8pwKqIEWPsAa2vi/5bA7on5euf9lYsy96WVK04zG5tvUpLdXSiZtfpnczmRtAIFq3NtFdbgqDVz7ZKC2+KsZw6b3xJvKJmJjkv6iwSFKN5IxpGJTbPepjmOHfU6JUuZfachbB2Luqge486py+cTmsptd9XPVyBsqHapb//PSUl+9kw6+yzOevzbwn/bl9lJCUd4F7ImKfOVNIlJNgD+Se7NhgjLnoOn8Vyh0mEnIp0FcOHDz0STsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFZnPq08Xrx2j0TE3F+ULfk1MnYR9/jkRloYBtLzsTU=;
 b=lcTQhiaxpxeEFKn8DVURR09fKzwQlenKQHau3cyUVohxLqYkmJA9PDv2W1DAGpTye9MzM52/Ah1zMEEY0eR2DS6BK2mIQ6tMOUpnGqSc3gbQzL6isz+eHcB5g/PNZzCkj5iluOJW64eDbTNbRJECXeH7pfoGaOsCiDBORUsrT9IHiYOAVDjU5gDALvDJiMLNFq2YLJv36p4DBJm6B2WjXMjOBmNJm+wJxkeKrJ1pBocwbB+cQCABURLQlK39kDLFCcXTD2Vre+X/M4/ssFsg3Doxu9aZUlB5jJqzJcWelPYQNf0lr9BXvcfbni3tVezJl7/GCaWNwocb3oicXlfUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:34:01 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:34:01 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 09/11] board: starfive: spl: Fix the wrong use of
 CONFIG_IS_ENABLED()
Date: Mon, 25 Nov 2024 08:32:03 +0800
Message-ID: <20241125003205.75327-10-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241125003205.75327-1-hal.feng@starfivetech.com>
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: 202e7f69-e62e-4803-e862-08dd0ce8db5f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: XOawJM7b4ISPDBGwXPEx4sEb7LkR0bKOtNbqRFEMk7p81swwS6fLAn4xyp50ikXvlUoB3gG0jqWfZz1uxlL0pNpmXZ8rLrW74v8JlUhBTnY/9dXgVo6jMOY6G6eM/nsDrSVDSwNwEmKMdi+q6eESnYgg0AMgQcaXUmk6rh0yRzhUqwl2XGKYK03CQKd8ORgmDf7dbh7cNYlAc6iBLMsiQd/ZWVb1KUVtx8Wsk+UtWJ15vNFzUpixOHbz+alVdvLWHyCiXAMkCugxtYJl7/aG/5zavHz4x4KvfuyWbNdwqCbOv59Ffp+25Jshrn6huftBRABNguo5VwKoOZezE9IG+mI1LNQF1TB9k2PWQOFo8RvAcUnJ9k84cB/eX64tm2z7p3UQp88ClqOOGu+KI1XfCxIIVKbp5BFhDFvFlE33+nHwS9edlx8FjsX65O2IP32Or0Hnq2jMTODTlTFGRhmUC/KqQPan7LPGkP/RvW4VAqIoI3B2DOV9yTDWTVtXVqPol2VWlVy2K/NslfvuOkNssvcxjXeq3tgQwqZCADhqI3aE4QDi5/WKl0t+LLLNbUA748PbrcslYBliOy1N9/CgdbppeHDf867GCz3gqHuS5he+Co3Hr+iXDWpTimXQNkGo9TMU8qKI0lwOluEqYUrFQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yNbGvLqDdGMT730pEYv+U3PmDPYpbLhuKwF5pea8UBrLf8JLEPuOByXxfihh?=
 =?us-ascii?Q?XnZCcZYM8FolnUgflPN16eq5A8AagSdK7YgRKHgssL3lCNG32EAyXGngxpgK?=
 =?us-ascii?Q?LXHPEAD0gUuxxCwgwax6BKs4ysYwMQoIl5ve260EZm2l6IpdjlM1Xw2pLax7?=
 =?us-ascii?Q?V3TQG20T3irFD9/oTHz6KXZSaLheSqV6kGvhE3Wi6yK9dN//8RWxr+PeqOlM?=
 =?us-ascii?Q?D0YSygtetUwlfKYT/2FMzhxlVaNJ1fI+pCkBF9xa8AR3ux6vEnDzWSDf/tyr?=
 =?us-ascii?Q?oscxhotccxnL/qoYuEIX+8YdClt6bmvup66nWKaLA9/1kXRP+7gNcKOrZEQx?=
 =?us-ascii?Q?L/cn9do6GTiFEqJP4m7hlp7a4wNnXr7zFdMtQu8fan9/BKGK31pK9BW3GFBS?=
 =?us-ascii?Q?hoEdyjVef0ZfNtFmB2diqg81GptoiG1UeGZuT6NMpJUo8Lm6nNaCRYyoTAzk?=
 =?us-ascii?Q?MVVUPpPtBsHAU5jt8yStle/GCTN48smoIyJKHtRNFk0joF7WiMEjmkbCGvHg?=
 =?us-ascii?Q?fgoqk7bO4MDaqlk3pn2eXfm9/pgTl68PHlvvfV189+inLrv9ndmpgq8o/1hO?=
 =?us-ascii?Q?BdaHUxDeHwv+OVlTpcq7W8gcPMpU0EiOZKmMJKO1GNb+CJL/r87yiw/r/D0j?=
 =?us-ascii?Q?EuxM9rB1HUIfrB+XDyROS5GNZBZVzm8d9Kqw0jh7kqOESrdhKMJ/NBKRCo45?=
 =?us-ascii?Q?ux1odjXwMalaWI25MANaVmrBU65ZPjdb1NeYaDL77+fqUT6ZAmEeWr3rW2IS?=
 =?us-ascii?Q?syO7au4wPCqY7cq/v84rxpzv1zLaWMg7NLzElNSYDP8CQ9hGzH9eGW9Q4exT?=
 =?us-ascii?Q?7eIrJpkHsxJemsb0hssYZ5jdAYu70sVchUoTWfr84oAJ3jvgyKUw+qvbH4Wu?=
 =?us-ascii?Q?rZLW2sEljbCatTIbVyvIhDW08PNLGkYKFYSKM+G+AJ/Ztg/8BR7yf3oc88r/?=
 =?us-ascii?Q?O3uT8sp/TextFQfhoGbHtf8NfZgi+VUHC22UBFEEHMUIIVy1ibcBFPgbXcjE?=
 =?us-ascii?Q?fRxknQ5SnXZPBXh/Dl+eCpOtToU1a+SwiPkOBg7LRNfpgRovj3//2pzd5dIb?=
 =?us-ascii?Q?xahxVymeBn4JNRv9ujk75c64xIhsoPGsEvKk6JUly6a8cGV0ECpx1Xs51TiF?=
 =?us-ascii?Q?q/nWxfOBaGPxHt6JJHRAMsKitQDr2QceH0OKqIwxJkdB9OmMRcHWFEl5twRI?=
 =?us-ascii?Q?3XPzOrSYiVC1pgJChc4NxgCuodSw/hHyVzbFY5U4aewzNkkc5H7OtuO6eFpA?=
 =?us-ascii?Q?o0HfHqZYSk4g7WjpUOeMext94p17jbq1LpCmnkP63metspwnksyEDMRWnrI1?=
 =?us-ascii?Q?FTODT+2OIAzYZ1VUNdrK65os7ql4lleBH+pW1uY0xtg6U0+AgS57g9byzHOt?=
 =?us-ascii?Q?3U9SUBPbKB99rOeoDZsroamjrEnHcCl7XqrtO2/bvyiIASaai0/E05q4qZrZ?=
 =?us-ascii?Q?Iw9jW6xLLkh2QoECTnx/RMwoviBq+yZKuZTtNyJZDAX7aQageOjmTVxky9y9?=
 =?us-ascii?Q?hjxnGIpjUfExsdoGnFRXIWVdRZZOUfPIzq9H2t5RSA6MO7tT5MTaGprC8jmw?=
 =?us-ascii?Q?7UpkN2f9WIswUpEQTjMMG9ioywzSRpD3dK74Agmw29p/OdLiDpSywXzIG3zD?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202e7f69-e62e-4803-e862-08dd0ce8db5f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:34:01.0391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoOfqWEvJXWKrURvLOTTZiOYbw7uUOqBhWKTXd5TrFzGccxzRAT1ot9FSjvUxcJBb0+vqZw7FIcSpmHGN/PLb4tiCGDcOII1r9QTy6XnYJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

Tested-by: E Shattow <lucent@gmail.com>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

