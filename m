Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D29C3DA61
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 01:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4477388B62;
	Fri, 19 Jul 2024 03:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29DAE88B7A; Fri, 19 Jul 2024 03:38:47 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20709.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::709])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190F588B65
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 03:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liQdV1HoCfnRhRqNRDDt5/YSEQMriIlOTENG2DBUV0bobQF/uaaPi69hnpIXSKx3nL26N5d82FsPoETu9Ni371kkNjs2XtQm/uH/YdbwW9MUmHkQFJhKnGKy8E2toDHOiF1sPZAk9mnZLEmhoKfaAZKzlPFyO9gVdi3J8vSky4iUXSzng+cc+mP9RqMvgUXacKbOJP9jCtxwmQDrsERNtSNUtBsK533UVM5NIspmyf1Kx7IRIK5PtCN1WF0T9q7mpKurWUTRdWlbOMZo5SePlcHi8S9YY68Cdh8XUoufFd61tiPAoiZp3MpKCs/f/R3BG1LtvH7j/d4SsaDMVemppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8MQpOesbuWwC/BS+SGpdalIf4L5iGzSwGDhaQHOsVM=;
 b=kAZCIWvV0Q5VV/G20y0qWYeENkdGx1PilerwwMoBNYU/knKN+qOKD7W1N/VyIDwydoZhQwd2kQEq7BduipAkGXGEcKV8hUScgpACMEsWUoHOb/Xvj0Lturuw4iqAkLzDaxz9n4xKXqRDx4O3znmd8HCHoEK59wx/U+4Ux841H801coI7GTf8CiRBO5JYC6E2hFmBoIbP82KoL9F2yp8ypitrpG4hUGY24Mu6ofHaV1SbHeUtFjvIgUCSvfCY7OObx/Lmn28Akqr7wj2VdSQnAHyMS/aaGe6bDiRopGErAPdPKRRRGt4nBWspagzMUM8H9jUp+d2PUy84c98q0/0XNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0623.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.46; Fri, 19 Jul
 2024 01:38:38 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::bd9e:fb57:ebf7:9d71]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::bd9e:fb57:ebf7:9d71%4])
 with mapi id 15.20.7741.046; Fri, 19 Jul 2024 01:38:38 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v3 8/8] MAINTAINERS: Update Starfive visionfive2 maintain
 files.
Date: Fri, 19 Jul 2024 09:38:22 +0800
Message-Id: <20240719013822.101374-9-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240719013822.101374-1-minda.chen@starfivetech.com>
References: <20240719013822.101374-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0623:EE_
X-MS-Office365-Filtering-Correlation-Id: 95ac9046-6795-4a16-8576-08dca793835d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|52116014|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: qbjVyOlxmUlSwTSiT7I0725MLxcMLEBQSgXRI8Y4yOEWxx5vqvj10BdYHRzuIjz6iCXCu8n7SklmqoUMQxtcgtiQsNn0hIMl7eaaG5e2VOJ9dQ4FkQDaMIDFUoSPLk8g67xXYywCqeBNrxwEOajJ0Jn+RFeoDT1Mhi1Kzs99FTdTu1d0Dx5u9r7H3KfBYVlwhiNveehTB+XsBliAwAuhqkmPErgEKEbOxmyZmugxs267R88W0O+SbedLBRJUjaBpPrFFZYtQ8x/vi0qJfjwDC7ZvMZRDiRwMRzNAOLyEdafIk7xSi763HUbUrB6S42PCL91sOsm1Tn7bThygWuid0TQBznZ+4CfbstYZsNeI0VAb51JM9t82YYimSjW8bsfV1H3vjnFmkd5jEcZAZFBbdKSZhdPxRXC2VQPCJbE4b+1x0qrYXxVUqrLenXYBZLNDoGRJFuwaDddaM3J0eCUJ5c47kH49gGRo64u+aSnP0kiZk8r4EBxcRKxLRmBZ4D+qxcslF6ykcRvwiXgANEkEeV09cZeN00zu+ul86NiS7AXXA9/G6zcjONow3/avvt5h/dcrAfiL0eJdNTKloCPlF/89bEotj1RYEUOTrygAdczIzWat/e0JnTNcuRPzjOO/87EllFHEo9TPhDtrcscatQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(52116014)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PnT7hNeW9KuJqhimEO1gc+/nh7acLeYFrrMwMK+58zCTvUTHEd50KLoSFoww?=
 =?us-ascii?Q?acxN3V7cbRhYAMXNsWtxV+3eOPBCB2Qkad5t2kv4UmL3pQIx4SzJ3iMNETWf?=
 =?us-ascii?Q?mZUNSHFdh3Fe49ExuC3wwq5HGtwKTSh7ErkkNhpiKpzRs2OlrLBUGRiFdCAM?=
 =?us-ascii?Q?NoGm5ubf+wlgvkMliNiACj47klio9H5V6sJbdO4R2VQpxzZegMlBVobrvGL5?=
 =?us-ascii?Q?pOaEjAx4wamPiZd5ItE+It+vCzDxKq6QFJCs+qXMtZg4/2JS2KUSo0d3eB+8?=
 =?us-ascii?Q?ywf/TcVcuGXCgtqnmRmc+dPgfS7kBr2tJsJraSo8i01EySfqwm0Uyjm+8eIg?=
 =?us-ascii?Q?6O5up300ozD+N503G7GwoAxW2vDsFvyO2DLuNbRp65rZH75xWvjLC4ndcULW?=
 =?us-ascii?Q?oig0cfC8/P/JWSTxbYimnaCKAhisIo3Mh5Fg5cgkZ58AKroIhmCumILKR0vf?=
 =?us-ascii?Q?bLB65GLvSoCsjpJgEokYDuPKxlqBOcMt5jMjqme2ko0v7TMqKa49sGDd1A8Z?=
 =?us-ascii?Q?HbxOBgLvd4PFK1CMKSgweGAh4Qaak/lgKxjXu8HDTD48Z70UzuOHLo1VkCpa?=
 =?us-ascii?Q?96X4rcmkncovcSBos7U+v0PXZ+uptROelP+VRwtKM+bIBGUAX3+YKlRSnO8H?=
 =?us-ascii?Q?JKEo74Hc4scOEVYwAlSHajGovZHJiRV/W3hw41gNTxVmxZIyaRTG1ke2elGi?=
 =?us-ascii?Q?+Imr43WKV1ipLAFTmwfVfH9gxeQOO0g0BWJEXJu7dFvqzz/Af7eJmqCEtnCt?=
 =?us-ascii?Q?jp0zgn7VwTonbGqsG8PpJnJCePdZi8g8+8UkRo3nDQ8A2zr7aBezMi46Vbpt?=
 =?us-ascii?Q?K7ZeepFndPqoQGFqPzqFt2ozek10gcd2Oie/S38WIAwbx+ARzG/192vo+nJZ?=
 =?us-ascii?Q?grQHZJ+VfkNrj2Hil5fiJIH94HB5K/Dj+IMgfDQq+itLBzRhVvRy/5UKppl0?=
 =?us-ascii?Q?efxR9j55eIfw1POoXXi2yY8tJ7yK+WG6M0AyWuNCTmVxp3TIS7+6pdDAEu4B?=
 =?us-ascii?Q?i63ymi2wDc1CyO5G+KJGKSX/W7ennBb3dESrNJBKY+wPdJqCU+LWxH3Y9YTM?=
 =?us-ascii?Q?wxQTy5I8S2aTb9uHHrO4burb5/Xq0aBh4h7ZWSWakw1G4LzyZ0dcCE7VhTtD?=
 =?us-ascii?Q?Aq0iafg0PKukWdwKnKrmZDjIvvpQlkjV+Il9xiGmjpXL9B7V3dIMtRid8PIV?=
 =?us-ascii?Q?eCk6CxuSpkK2PXT6j1O/+j+9O6LT1BW6fFxhkTKJ0h/L8UwellyGwNAKkvkX?=
 =?us-ascii?Q?fXqw4vRAATEacSO/AkszscItvDYAES0d4DDt82KoTsmGEGs3/x231v2c4ULw?=
 =?us-ascii?Q?TWl4NqDsN4LpD0PjparOhhLB67MPILZgtvxkJ2AwjhUwmXETudVcCrI+r1Ji?=
 =?us-ascii?Q?9eWyvrzO0SdNTMWCtcw+DX4O30LcTH20mh0Ii7N6iXGmf9vKMl8kdT+tPoCs?=
 =?us-ascii?Q?M64TYiyAGmnkYfATi7FTNezE8tdk6hDtlY+v5xCy4bdlCrkxKUF3Bb2B7vZp?=
 =?us-ascii?Q?+xyFgetZnH9nkHb0gfthzb8huLeKZRVbI1jUdBN3zDO3r3vF4MYtXJqqQzsR?=
 =?us-ascii?Q?lUzwH4VTt2zzR9fnntgw444wECQaUoDQQ4VvNACP6OoHLH5rq4dTokyLDYAJ?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ac9046-6795-4a16-8576-08dca793835d
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 01:38:38.7120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjCfFeWUYcDBrCSYs1uLiXLuEe9qlzXE/kUqgDAzlTBvtg/RNERqsRNStHWoTjzoFbLiCIaujOFnn8ci0o6Y+L8V4KmgIxBTRxmFPj3dZA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0623
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

Add USB related files to Starfive visionfive2 MAINTAINERS.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 board/starfive/visionfive2/MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/starfive/visionfive2/MAINTAINERS b/board/starfive/visionfive2/MAINTAINERS
index d7f638f9b4..1faf83f581 100644
--- a/board/starfive/visionfive2/MAINTAINERS
+++ b/board/starfive/visionfive2/MAINTAINERS
@@ -6,3 +6,5 @@ F:	board/starfive/visionfive2/
 F:	include/configs/starfive-visionfive2.h
 F:	configs/starfive_visionfive2_defconfig
 F:	drivers/pci/pcie_starfive_jh7110.c
+F:	drivers/phy/starfive/
+F:	drivers/usb/cdns3/cdns3-starfive.c
-- 
2.17.1

