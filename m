Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEC2CFA451
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 10:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A74B8934F;
	Thu, 24 Oct 2024 12:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="e7ZGXlo1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3677F88F23; Thu, 24 Oct 2024 12:02:04 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 355E28934C
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 12:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6+bd4Ztoa5AtqzMhfbtJKrWD4G910QxvYDMQojMRVMCvwimE0/JHY96BOkCjW5ja7pgEleHAIlJQPRnZ3jpwC8NQLjCJiO1qY/eke7hr4BYTQYTbBvuKA2rD7VHCJAw8zKdbTx/d38WC1KlNixuzp4zqxXu00PVb0a6ZVGbckeDJTuRtWIXQOz0b0GW/g5PUvqZ7kupKKPP14FDYMRo2qtKxULU0td1DjZ1X2ybuJDVDkLZI8OXMVgFjsMyatO7TrL+TaYDEV/PmDIlzSPNbZNsGiNjOD1p+8RDFsPy1Z5rxFf8GMdu2lHUz2MYjXIUV3gSEG6/VOLsXirT30cZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdgF+urDPJKQq7S7aoCB2UHCz/RMZkIYFZlTjzHn0nA=;
 b=ts3BWqxm1+5pcc9HrBartumgFR4Pfnoqrmlll6E12dDmAcOaSx8x+b4+HJGzOICOSsLTike75J269P830FUuxoR2tFbirwaydi5UO9NGZw2wKlSg51QwxD3nBDhkC0yT+b6p5KgGols9RhHzjPl7XN6x8p+qE7vzOlMIq4Z8SywY5flnG8DRhgCR3er0UALwJPpH7FSruOvoHv0GNbnQoxNWBGfCQ6gpPSdUrklM4qux27PG2m8iNdwJv+v4dEwPDHI5+J8tNYGNkBw8NJOZ33x2e6cDoQ9EbZ3+oYJHKwk7xUhd5wq6+uaMjqwPrkd32GZwhNFKixhveC1wHs6Emw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdgF+urDPJKQq7S7aoCB2UHCz/RMZkIYFZlTjzHn0nA=;
 b=e7ZGXlo1e42d4Ot1SAcDSaiOKD0Ignu8a36ARizONUGXm8TOpqFYku/apPNHb0XS9bH/XkqqG6e4a0EFZhoFi1Q6zjd8TvPdfYg+OaDAzCRA/gs4lDUiFqLLOcU2jwb6VJZku6oHbFi2GDf9EeGnCQogpa/wOR2FmN8jfUX7d5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ea::10)
 by GV1PR10MB6146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:99::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 10:01:47 +0000
Received: from AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83c5:5c8d:5d3d:8b09]) by AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83c5:5c8d:5d3d:8b09%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 10:01:47 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
Date: Thu, 24 Oct 2024 12:01:45 +0200
Message-ID: <20241024100145.841964-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5ea::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB7082:EE_|GV1PR10MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: cf59f452-d4a8-48fc-0aab-08dcf412df83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cFnUwk4K5b2mW9B+zNbHlxSEpToEtBP2JY3czh1DQ5NqcK3s2vMPW3goM22u?=
 =?us-ascii?Q?1/lIhl9lv3RcdHWjPIrCz2ozqvWZVRPizlOMtwUqD/ZmEmH9X97aZ34q3ZRm?=
 =?us-ascii?Q?IcTQCAFcS0VzPgBdC2+cBPtBJ6mqwxmIwpKfN6IpEoWH9SOZAGdUMVu1gKO+?=
 =?us-ascii?Q?TnO2Y5IeVRoIU6cSxPOWMY8ahLKLZsPZgLtiTegHf8P5zjBqArawMKeHFhOi?=
 =?us-ascii?Q?uN06RtcNtfplrrT7awqYhRh3AVy7HQQ6cFKhfx+aHhlDEtrP/EKG0I2pNpxh?=
 =?us-ascii?Q?O8zAASj2khBiMAKMioAnzrxoVxcTxskB6sUNr9AlzPbapbr7187B/w+fKw85?=
 =?us-ascii?Q?htgPed7NtVwhZ5vLa7kuUPntvBuWPtdJCARTQVUgNFAM4zedtfX9+vfyT2p7?=
 =?us-ascii?Q?oF1dGOhbaEMioYXd8K7yr619en+LoHo+dW7LkLSXYY+kY/EbNv1U0PGFehxs?=
 =?us-ascii?Q?aCoKSSBJ6mcNlZwLx0aVOH40FpsCtK+Sh6LXqPEXyEMsgvD8/lcrjE+PeGeQ?=
 =?us-ascii?Q?MT86en8PELT2Zmsw6ZSbXM2XlkRTj2jULNrlR4b7qq/YjAs1cHv9i0uZrJt1?=
 =?us-ascii?Q?7xckvUHAz+0CYnD1cwqyVPIMyaD/CRnZ2q7swFvzSsPtPU9IxM7cY35H01aR?=
 =?us-ascii?Q?/JuSk9icC+YLDl6ZNWhxQTKl8CzlecY7i/AUrAw7hLxm7cJDIyJ/SX2K4Jpr?=
 =?us-ascii?Q?tUcgIga1oy1kZmr6PujaRuvu1SHUz+pby+3dLz95/zkIUcZ+gOhJWcwHpGxY?=
 =?us-ascii?Q?UXeF324i3/FyTItGDnMEOFI6Rc7dGlDzYQdvcyoSpv8jmfhDVoOlbdWOwbm8?=
 =?us-ascii?Q?Pxm8V45eZN/L4BSk2qqy7qQ4TuklMgxgS1bQEz5+B1XEoG/xpk2Su8xB4L7I?=
 =?us-ascii?Q?McD2iMxlqptBc3bk2YsDKhHvHEiUU9bMVlXy8NSHhkvj0/FBOzoXc71p+Mkx?=
 =?us-ascii?Q?n1B+TFnMizt4V2r8VQBRLXWxhXDzH5GCRa3+9X1+WpscYIKo32s6+WdApodq?=
 =?us-ascii?Q?6vIKTWQ4X5MwIanrTCj/lk3p3xq87labYXBdzrR8pKgO/T4nZvWxvr0NMVJO?=
 =?us-ascii?Q?r2iOU8C/bLSezS/92Pcbyj2MqbX05vGTPov2bTnTPL6QPiTWTpE3ddaMAGX2?=
 =?us-ascii?Q?SeQjFhY5ObEoLy3rZICWDRmFi95nyhDGdft//jVGh/j3GAgMD9Mk4XahOJfS?=
 =?us-ascii?Q?58Rb+QreT+Wp+MAI1FJxSWELDTZS+MJZqwTbgP2NBainbSgh2P+abtBNK74e?=
 =?us-ascii?Q?asfSnfLWeJIWpy8YnOve/tZ3GDSfz2kJ4R/yyFj/VfzCBmoYWZSElXgmdtgP?=
 =?us-ascii?Q?cLmRtDvFHFNACcdlijz63u1IR0PzqYSTGD3g6kasJ8m8I/LllY+Wnv1vWAb3?=
 =?us-ascii?Q?genLE+4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FD+r/bWNxWYXm345uVbw0oHiDP1tmj+kkHFuNQb2HM3BsEIKmTBrSS3Ew2FJ?=
 =?us-ascii?Q?32gGCSmP0nMUX/P85/CPEnc80LxPMqV2hQZ5Ux4GoENBudTFoY7L0K9F6+SW?=
 =?us-ascii?Q?BJHjoNQfB8Y3ZaCE3JXcehpLTtKf6rwirDLnh1KDfHTlmGusXIhWgtVzyJc4?=
 =?us-ascii?Q?51KGLpTig8tX5MfEHRY+LwX7JgnEonHPzWADP9HxPDhpJV9u2u6XOneNKh61?=
 =?us-ascii?Q?GaTXwtlsyON8DeI0fyPvDd3RH8a3FtbYdpQQFDM3gC5AXoGlNI9ivmQT40oL?=
 =?us-ascii?Q?FFMwCkwiFl/fWHz8BW+4uyTBuN6FUT3asOByeom5WgvFG3PFXYLG3zMjLzL5?=
 =?us-ascii?Q?iSfozf9QZ3d+x3vT+Y5MReWoSDFgF7yv/LA32dpp+Y1JwmNwEBRSWDCmPTwp?=
 =?us-ascii?Q?V8pKzlltewzATUkKcf25bI7uwwpSvHkH8YBEy7gtHo7ddiwS85BtK7XLnU6v?=
 =?us-ascii?Q?MJc4iM6Is2CrsNDPbCKe5xPU7IliSXzXbecDwgUX9xEzq75WKLGaXW0r4dvg?=
 =?us-ascii?Q?dzHPKV7BD+X21VbjLeyJeS+olidHkkdN0c5XrwuUVQW4gqjDTocIoTqCLMYg?=
 =?us-ascii?Q?SVPTQZALQZVYORmKiKemIr9u590nhTl/JBBhf4sb10Gz7ilotSuZ7eOErHdE?=
 =?us-ascii?Q?3b88cArirSJGvwSjMHYsxaLwKLVY1hWONSxCaZX7jV8X3cv7NEfb9lyd9ba9?=
 =?us-ascii?Q?Cys7fJI5eGMzco27Qhlq7GS9lrbx9IE1hnThjHtvlI91JnjxCe0TTBbT1fBF?=
 =?us-ascii?Q?zioGuFSLLoCQEZOO5IGvJtMecNUvGAEgknY1x1XTUWF5Z4Qf2IHtPRpVeXFF?=
 =?us-ascii?Q?D7cfQU7kmANq4c46TO4ovNh3xNq9Cf1DsWI1IMvX0JMHJDpW/M8i55x/Hjau?=
 =?us-ascii?Q?AHpwZnVOGdoN6Oy8vwM+sDqu6MzXsa8ZVASF5I4OCyBspv0hLUwcDiI2i3hN?=
 =?us-ascii?Q?+VXiwcWohoqsai5pKkJfBmp1e6GZR2pT4MdnEToCOu3A4Y8xjoqPCAZiJOrv?=
 =?us-ascii?Q?EKNrOaEJAkFtUB/5KDiV1vY+kBEldki/7rhJSojDx7lneMG266AsRn+pduf1?=
 =?us-ascii?Q?Ox8ohqjhPDOebNbmoY+A2i/w0KEjG2z+IHSJ+kmQo99q6o37VEsKNQTNCbaH?=
 =?us-ascii?Q?h8eggWKSTZ+7qOtrxjlzyTmMzoKX6XGt/e53AYFBLHhDPc07HsDHGY77peNM?=
 =?us-ascii?Q?t1MgQ3xdLLqfh2/D6HxaRE+fW1iLOr1FdwEHc+9Q7arY3IVeNk+Z568dg+1p?=
 =?us-ascii?Q?oHODSHc1Eb1f+/0xQA795/dVjXY/8aiVD/LW2d7uMARZAnGSJACT3K6PwXZp?=
 =?us-ascii?Q?omIZWv/06n3RoFx2+DA/tnJoYQNkhfgQpBWi/LtaeAjkVt1DG7NR6juRVLQS?=
 =?us-ascii?Q?qGtZhfLg14/orrn1K2GdaAMx5He/FTTooS9WR2oLfClU0l19UVu4Jhvcdgye?=
 =?us-ascii?Q?mCm4eSRVhSYxzUJ95KRv4bZ7MuOdtbop7IXK3MWVK2s6Y2v8gGFIpPNoTRyo?=
 =?us-ascii?Q?/9XpT7MUqLvfa98B00UmvPyOFWXP1zcPUyszJSzDg802H/U33rfJ3usZWog3?=
 =?us-ascii?Q?i7yOl/Atoo9cHGxC0yRuW8NK5HQY5+MS78kZJ+POG8Xbo5Sb0la5wutnTYGk?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cf59f452-d4a8-48fc-0aab-08dcf412df83
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 10:01:47.7383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5yTUHkABlcSKU0LmYCSSsPCFP8Tkm1mUqmTLYT4RnmUSoEppHnhHYFbbL8VZZ2mO59MRJwkrRYghou3kJiGXv6Q7tDArZV5Wwyc78QUrgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6146
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

I enabled IMX_HAB on an imx8mp board, but even though I knew about the
implementation, I forgot that I had to provide a sane value for
SPL_LOAD_FIT_ADDRESS. The help text for IMX_HAB doesn't mention this
implicit requirement, and there's no build-time warning; the default
0x0 value just ends up being returned from
board_spl_fit_buffer_addr(), obviously resulting in a non-booting
board.

The existing imx8m* board configs that set a non-zero value currently
all use 0x44000000. The actual value doesn't matter too much, but 0 is
always wrong for imx8m platforms. So just use 0x44000000 as default
for those platforms.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 boot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 940389d4882..72d1f69afcd 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -231,6 +231,7 @@ config SPL_LOAD_FIT
 config SPL_LOAD_FIT_ADDRESS
 	hex "load address of fit image"
 	depends on SPL_LOAD_FIT
+	default 0x44000000 if ARCH_IMX8M
 	default 0x0
 	help
 	  Specify the load address of the fit image that will be loaded
-- 
2.47.0

