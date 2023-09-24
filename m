Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46AACE7A89
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 03:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 289D3863DD;
	Sun, 24 Sep 2023 05:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="ERCgpbMD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF7186844; Sun, 24 Sep 2023 04:59:59 +0200 (CEST)
Received: from IND01-MAX-obe.outbound.protection.outlook.com
 (mail-maxind01olkn20812.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700f::812])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F718620C
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 04:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tjjh89017@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHZ3Nfk4JxcffgbHyETwlZWSmaoG3bhOxo+PAJp4pAtUAprzR/X7xQQI4IJINzYa+BCm45kNpzllZbC9EXxTyFcbSYtIvKW3rC9cmwIDGX4Vr9FF1M7Vlct/7mOv9YzmZe4P8mYiMC25nXtlPzhuZZUzuH4lwaJ+9hxkfNalGEZIVsa3pEvCZDWn0iPDPeDyuZZuiZy65UCEzjVoaVolNIayVK9RAAs/xRaXpXxgJQmgrq+Byog3ILEx2nIcqkL7A5m9j2MIP5+0AGBUBBWHdE+dUKsjGCwHeuAREGFBpPeidTZt4ku/aF1ocyw863YaMayNIuymuQdhta06ib/xPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLllfYhstVEKRHt8yVn1OcbaO6lRPc34+YkFmmtBWDg=;
 b=GSdmt6rbBHSY6Nc2AAJEbrMe6IPLUAryp7ztLe7T88PrHv77xCMTtUxl7EXebX/q/H0WNgI7rgvonwEuQIHCgqivZpCq8w8FK1CP6QGRphV782sdYFqn34ukh3sQkdvR7cyAjzSz2Vo4wGJxHIj2WOImxeHHPAsffTitr0WzqYoPQjY6XtSKneKdkjDO7+J70N7/YuC+pXuKuys+TN0GuxmVtxPkXaE8SaMG9ww97mYm1RufzbQEPIJIL7Fii6HT9P89/cl4bDZmE/6TuxwyIBsfJUjJbRH7OxPJAaN5RoQbiKt9blOzKm2OyTdOPacTNfWtBIvrsThxI4mhWeW9Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLllfYhstVEKRHt8yVn1OcbaO6lRPc34+YkFmmtBWDg=;
 b=ERCgpbMDhG0YmYc3sgu2xYMgMlnVR9iehZyoI4Ism4C4pJGzMI4ALk6R0/+kg09DowR3qBasAl/uitGNCBWZNCGQj5Yb6vNfWR0lRbFyDWE9dwJNh9bJiVxpus/Rek9+jSvc96ukMiKSKBwnzfN3ipx5H6DMoAInJy5RjOldR78OKaEOLnKkDraqY/lh/NRS2Mcq31SFCI4ftYShxUmCUR678lM5T9WOCjOoKv67MXHMtAoeK/GnmEZlTxPkS3ff8pKMEjqTMdJ4TUIzDOvkoiGYMZo5a6LcK/bJb0F5DVr1slyUEn7yZl1HtYF4uNb6wNv8m5DFkGi26Lsp2IsmCw==
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:d3::8) by
 MA0P287MB0783.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:dd::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.27; Sun, 24 Sep 2023 02:59:52 +0000
Received: from MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::43b3:9c7e:61b9:5278]) by MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 ([fe80::43b3:9c7e:61b9:5278%7]) with mapi id 15.20.6813.027; Sun, 24 Sep 2023
 02:59:52 +0000
From: Date Huang <tjjh89017@hotmail.com>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, tjjh89017@hotmail.com
Subject: [PATCH v2] arm: rpi: remove boot_targets for default standard boot
Date: Sun, 24 Sep 2023 10:59:35 +0800
Message-ID: <MAZP287MB05034A33FFAAD17F2A43522EE4FDA@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Rc2C6XGu8csPR867lKJ7eVRUZrnX/FKtkeqjJhYGvRQmw8L5bRkdpDErbKTZ7wBZ]
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d3::8)
X-Microsoft-Original-Message-ID: <20230924025935.29999-1-tjjh89017@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZP287MB0503:EE_|MA0P287MB0783:EE_
X-MS-Office365-Filtering-Correlation-Id: c36a1017-e6b2-40a1-99d7-08dbbcaa51fc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmtvNRzPWqXvGAAiH3B6W0ZFj/EokW12nuhOSWExTSjhKOuFXGoKrmkLFh/cv3Zvjh0iaRPaj/Wz77+BWZGaWdT/xV5XwDcCyLBMQelmZA9iENosUZXwdMRF+c4ttve2z2IHsGfqFkIrCDRj8yXLAkCd//DXixikcMKXcMUC9dzz6lpKNKr83TDuVzRISB6xLTzS+2gAMsnK1NkfAI0SPEiAqgqT0g8AlK4acTF9EQZildCIcpef0ssZDVRyIqscrUs07epxgIIqEPun3Ib4xzqLHgeOAZW/C3ICiF0+xsFILPOLJauu0/hcBIqrtYSszjGDEYbBKMh6sv5izGuHD3Y1amLINsrewzG4lvHXMCBlLK4CYvBLYSTRWOTWKeTOGWZ8/Z3AeD/shEDN3izTKYtpbg/9/Uj7dSeuumXFcPtJao2m+lq0flHX8UyVsbxTSO6XE8cufafjasqV3f5aGoBZdHYg/oROPhAO7X8+NIvUIpSyGf0+QSq/bmEwwE2RSMJSgUouweTwRHvjUdyZ+w6+edoCymm2AfKpxzDTTObiRmlhw9LUgnGMwQoVkDWaHBdqBzNwERuV1p71JsuKl5pXoBFf9OLDHyRlvc2TZhgZOxAqV6IWAloKBtuN6zQc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVrriBGI7YdnxK/dCW3zeEtAputH4cmY4o8blE2MqYY+Xio4bfeomqNClvYg?=
 =?us-ascii?Q?9jrUrrXQWqGcUHnfemOVPetXzr/vuYw28k3D8H1wsfFz1EDz1+Hxtb2vxcLU?=
 =?us-ascii?Q?zOKkaWhxQcRWc6ChM7MubSTXuYlRgmZB2U5AdhVwR6HXH4/jcV5Ho6uOPdMO?=
 =?us-ascii?Q?L8tCNg3nqXnbS6P0JYm/fFgzuibO2H3GTiqWzoQuNhShy1RAoYYaitELIOQg?=
 =?us-ascii?Q?24TOc8nUPuo8CW5+fD66vCYzosMt02Nk9G2zQnB77ygTwCdhYqrVYgd07gU+?=
 =?us-ascii?Q?wLTX98cXcywkKOBcJkDs3+ATBbaRgYzK9iHP4wEtuPpC9+YOUiiF9AtoKEbm?=
 =?us-ascii?Q?aaMIgG+hLaOzJqvdVL7H78sGXpV2ipILm7VIkZlkZZOty46uSBAJPmWCX4wZ?=
 =?us-ascii?Q?DH42+IxxWr1Oeuo9tsVEwMwFOsk2p/EdW5sev6t/AujrV6/Nhzch+z/p8oLN?=
 =?us-ascii?Q?q53s7FQJjW9JiZlE2fRkmnUhd7wo5IeOJ5swutmcATMonApl6MdhoNLIGVuJ?=
 =?us-ascii?Q?FsMxUQcqC8/UOW+y6SRhFCRlxZrup+6s6kNqm0Bl80y3A7Kfy37nQtP85v35?=
 =?us-ascii?Q?QlTDYrEeBwOMr5ME9Cxtkfqhg3SaeLhte9xHekSYrqsrWKCEgjw9AmRHEv4e?=
 =?us-ascii?Q?R4iVt5onFpwxNJXXceTmkif0YDwM5ApEuPlOKIMsP/3/BykFFXr2mFt6h2gO?=
 =?us-ascii?Q?5pRPCVqd6KUG5NqT/nQL1pjT7NWkm0JsAgH9ivKby5H3130aWaE6mP/peTB1?=
 =?us-ascii?Q?L3zXUCB+QlPxmEH15r0cB0MUNqsYiZ6TcOUPDRQtJega6Nagki49xq7601p6?=
 =?us-ascii?Q?cdANUG8z3K1UZpo+PBRjCPC3FRkTdpQIh9HXUdzyR/CfdSbAcKKMTAN2H3g+?=
 =?us-ascii?Q?UnBdFSl+0gyi5nDVBFUlSYsiR86o+XOQGJd329mFtdmoZYoqK6KesCCioOmL?=
 =?us-ascii?Q?dWJuuQwZ8Z9Jlv6PXhFg68+nHqpTYl3W/PZ/b1F+3WLGraujawXm1sew/rGq?=
 =?us-ascii?Q?EZPIDmjNHYfsfOTjDXCRnCeq/MbezPMA7XpodkhpOptXDBI8ER5aL+SbeKiV?=
 =?us-ascii?Q?AQC9fQP63XkfvwV+fI6FFtgS5aP1mi4iudTp8DpqVoY8ndxoH0Gob1+tyQgI?=
 =?us-ascii?Q?f1Qe/aJNWeEZbrQ8T4ncxyPxXIlWkrg+N25kRvcHeE7MC+z8hWHwKM7rmxcB?=
 =?us-ascii?Q?FEDY419HRHOMgEfwmuovt++/txCmGkil2NO5GpH15VhrD95bCujXrb8/or2Z?=
 =?us-ascii?Q?CJ38dW1VXsy+3FQPUDEF9lsw2ZSGs/zqMu8JC8Pxgw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bafef.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c36a1017-e6b2-40a1-99d7-08dbbcaa51fc
X-MS-Exchange-CrossTenant-AuthSource: MAZP287MB0503.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2023 02:59:52.4704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0783
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

Raspberry pi supports standard boot without boot_targets

Signed-off-by: Date Huang <tjjh89017@hotmail.com>
---
 board/raspberrypi/rpi/rpi.env | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
index 30228285ed..8fb8d5d5f7 100644
--- a/board/raspberrypi/rpi/rpi.env
+++ b/board/raspberrypi/rpi/rpi.env
@@ -73,5 +73,3 @@ scriptaddr=0x02400000
 pxefile_addr_r=0x02500000
 fdt_addr_r=0x02600000
 ramdisk_addr_r=0x02700000
-
-boot_targets=mmc usb pxe dhcp
-- 
2.34.1

