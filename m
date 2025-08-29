Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E89DCA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DFE8381D;
	Fri, 29 Aug 2025 16:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DAE834E5; Fri, 29 Aug 2025 08:10:22 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20706.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::706])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF6348354B
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjL5vW3cb+UhkjMvKd7oqeAZdtKJ6cTTaeuqI51FBeoHM9kbzAveQtXrrGrE6j6cjbn0xA6MUtQ8xgRI7Mua/jnP6a/8x7A6hCS471L15Tdbevz/BfH7p1kEvqRbwKzFi9TIiqJISOVRITuYtvPFq4M3IcL24QOGE07/u+evOHWCTm/3PL+l/g4Z0/TigsoTflLiw2+BwpIn7M7kD+xlo435EmDiJR/ykX6xUUJy2+vcwNCR0IwA/lrz6+XNp5h8/rUCnWEi5JXVPta6DhAgZ8eZ2A4XS3fI/06/riobBkSv8FJvG9A8gTsucfB6oR5FG9yOuaaEh58soxOPcZgeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvGMjlsqpWFjAD1tbWOZX2p/6TXI3kFhijLY9/lXouY=;
 b=OaXdu/Aj6tPiuVTC6U26Ty48ndP1BBcGbRRcolV3qNVAEIFsdRW+QWjczPZ8gSxh6D8UlEHTPhuCKM4oztxhKgMSPUXIg75StMRPnelyoz7Dsv48snROfLs7JqracJWpTk8uHfhGGShWt9IJksVig3IASJY37WB4fN60v6Z1qaG+W2gfi8GIDJnl5JxUAz8Hz6XMB24xIvefJCudroMbiuwKl2G/VAukkPaUmutcnhGSl/chnK7TtkRbH1ueiDfQ56boE0pwbnmiV8vQ55C/6s8ZYmlODYmDfZJrgFJ/u8u5yXurN05avYX3O1AFIULpDUVMGmkym0T1IgRXX4TCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1257.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:14 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:14 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 09/10] board: starfive: spl: Support VisionFive 2 Lite
Date: Fri, 29 Aug 2025 14:09:30 +0800
Message-ID: <20250829060931.79940-10-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6504eecf-de0a-4a05-b64f-08dde6c2b821
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|41320700013|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: wg+MwXkAjQbaIa6ASR+5G7jCt3Ljpjc4aw6jjONP/lU4+KNg0u9sjCIuX/aJeUAvXvPNTEgvIv2MJTofzCKvXjSG/w63k83uzcEF+3NH/GJQ31vtLZwkLxW431YPx+mQJsVU1v3iUGfjSu+OwPqhIYAzjxJc/ok9v9wvmyUww1BrlSL7woCY66FaY9wuk3npcySNijXJtN0DKrNIhyQsXdL1r6MXOjKRO56GWU0WyOC5+mKZT+F4RnkA0wnQcmkPiRZ5M2jGR1Xt3+GJsZbIK2mOun6pVgBh+kzEatvBVJNctmerbUIseWcDbcCRoAMjAFmqjvUfcgjn90cGzwhybtgYkvwsMdEEwHvJjTP+2Kbpz17UJ43zSMd7+ODmudbMH1MKGv7kRSjZNICWhrmu2Ey2peM6xfzLtIP5farYz/NEf8BZGjhT7lkk7rwcEcuPIjG+D3gkFyfD0TM8icXitviaDtsnrk1BU9FL1QHZU8/mI4VgwBIZoj8Yc8BGP43uU96GZ+tM29WygrOHWMjzjwAOv4TzQYNEfWdsYM+sLMAQYIxZcZqf+H+KaVo1v//8BJAG3Hs6aTeHFP09NzQJpTSyBO7xxAdtEW/3KnFmaYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(366016)(41320700013)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AO1T4M40ywuhQDsmT/GmgRLCf8FtQlzDse1RUPjoryiTKTw0skUbTKWXtG/u?=
 =?us-ascii?Q?PRYV2L1Pkrp/abBJEAIadNzawH3/EFw/8euscpTeb28ZbIgsmALKLgPEzuyi?=
 =?us-ascii?Q?gAiYZmkq1VxMTcY3hk8uAlmpQAdAa+7L+dHdaCz6bQoTTsyQimgzSdVPM9Fz?=
 =?us-ascii?Q?5+17upFTsK3ZbD6YtJTxLup1BT+/i2Y1eduVSHR671gFC6Hyyml7JBXmrTMk?=
 =?us-ascii?Q?/HUF8O+OA8agcYaAG+9w8+IwzYAkurjI8htH0QXPdct6uqEBfpnmSYluvLMf?=
 =?us-ascii?Q?fJH27gHs2adSb8EB0QMa2rVeOUFrcntP1TqEZHJUe+AS9VuZN9hNM6aQXdqB?=
 =?us-ascii?Q?MuoZJrFwt+cvoYhJjyKXSxwnZJhXuEqdK0KEWIHk+44CrAobfhi6mrOMYNNe?=
 =?us-ascii?Q?gI9NHcon51XeGY6FO+JoFjULk6KqI2naAW6DQxNJlwBlkVaCmm5zPNG7Fejm?=
 =?us-ascii?Q?7xM/x1LFxQ+4evzIYmDWPngjhyXRFm8H/jY1u3ZD81JLWA1Daj0ImKcyfoRq?=
 =?us-ascii?Q?BuAdaIQZRR0TAMWHP2VvMoRHoz9aokrjDQ8D06VPyTu2APgB9HAl7zVdyZ6H?=
 =?us-ascii?Q?bC/LdcEudcKw0rj/0X84NSPdkvApuqhkfPYyKnFeV6eVCKoQ0MQ7IwOKgmQC?=
 =?us-ascii?Q?XT/vjKL3oL7JihXZYm4Ccen3b4+ZsO0cv2HX/M2BPRayQ3FH3vP9nfAuAfo2?=
 =?us-ascii?Q?StNmjoCvnK/wxIzfw1GtPudxYx6stol4VIiEFjhHRbzxUIlV4Wxq2Ow414da?=
 =?us-ascii?Q?l4dkINsNv5A9T4fhqgw/AKCMatgidLjHwwough3n/i8TfJ5/kkaqx3u2px55?=
 =?us-ascii?Q?NaBC3b+l6jPu+NXq2Zk+PLqwe6ixaSo4ctxj2NwyrN74HunlzbFBgqFsrhHT?=
 =?us-ascii?Q?Gt68wBBIjYG/EHWNdzSqtZHokH1GlcZtNazyekfHn8olnTZhJOdTLkuCdEjP?=
 =?us-ascii?Q?1h2xaqd64DdTbDdH1FCzu66NdmNm1w0k9lpu109tAxIQ+QfQuqRZt3GA/seQ?=
 =?us-ascii?Q?8sb+hFyTyBZwFBRq2DaVi9sJhhpr4PbCprttDFe17SJ/R3r1yUT+gw7BlQG3?=
 =?us-ascii?Q?JiP/XyN51hU61V7nj7nGElefHRykkiOnKZj/IiIk0K9TxeIYTeVrXxkpb3sO?=
 =?us-ascii?Q?Zg6f/b8ddVITJmiyEBdXDgdjrnZB6U1OqnsocNC7jgcFdvGr/G4PjSIln2h9?=
 =?us-ascii?Q?U9gAeNuXTDFFObvA8i74r7XxjIlwAJ4sS/iJud1LJNYgXOI+LRVH9VKtiZwe?=
 =?us-ascii?Q?fFPJh8Y8gWCgy/pe41PUhTfHupQ3vhdvVEwWe5WQ9lT2+duw7sL9BpWYQ471?=
 =?us-ascii?Q?b5ormcQLdyVfYSfAtaQsAiNVCatD0ch9fU1y7vDe9XSEXHdKB6aaNva+M4H7?=
 =?us-ascii?Q?vDgoHtlOPSUF8ilyIP/MWBdo2MK6yIextRabRWVNkFBya076UkpIIG9eKJeI?=
 =?us-ascii?Q?6CaAv/7SlS18r957HPPWi36+yU/TtCqc061OxY93tSUw2L23MeuSSMAOXwJP?=
 =?us-ascii?Q?eKihvZ1jMWyP3ox5OCS7ONH1oRGraFBtr2D6B6MrelgbDH1lOFrVHcIUMevB?=
 =?us-ascii?Q?d6b/3oTozMgnC1o9PsBd9ZwpWFi4VOhd581Uqp9YZCHURYbAFC8RTaxd+zwW?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6504eecf-de0a-4a05-b64f-08dde6c2b821
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:14.5213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWuCO/szuPY8m/jJec/yPdVxM7UlA5qA0T6vigPwN8rLnP+zcly1yhemI3m1ONko+B8eAH1RZPnN1nR2QlS4nPaLo/yZpUq2YFYtrhl4L60=
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

Choose the matching FIT config on the VisionFive 2 Lite board.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 901e7b58f36..18571b482f9 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -133,6 +133,9 @@ int board_fit_config_name_match(const char *name)
 		   (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
 		    !strncmp(get_product_id_from_eeprom(), "VF7110b", 7))) {
 		return 0;
+	} else if (!strcmp(name, "starfive/jh7110s-starfive-visionfive-2-lite") &&
+		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
+		return 0;
 	}
 
 	return -EINVAL;
-- 
2.43.2

