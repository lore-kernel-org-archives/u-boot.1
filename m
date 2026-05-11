Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135A3CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 07:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45468482E;
	Mon, 11 May 2026 09:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="A3Hme71U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F4EF84836; Mon, 11 May 2026 09:45:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB3A84807
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfXgjR8syWX5K0+VhwYT0LOyYrAwWpuLVi1g75zPW7aboQexAtnbKwa+sBI/C9qYXlMuoh+WGoJCYwf8BpItbQKvYXY+HvCLcZXe6TqDCj6YB4VnJw56nfYx4Dcr7FIcgTG67hpezBN3jSGr97WgbEpUSf9Xmh5tL/r43hDQWA7HdG+LFEuDMnQSPqHiEdP3xi3YjL4z6UgeIAtqMcqpPZzHIxZNRI1RluYmSHpVWSFbiiXbERYzgkM9zTWFh5xzd+K6CjaB6pOZoAxiFqFCj5XNhihO7ZT4Qfrz4sIfjQzEFeJ6Sc71BCppVpx9xZ+w3EUwo7NxIQpOONmsyzmn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5I5cZEJ3yAzcxfztY5Yo/FGBUTqvYiMbpOjKMGB2ng=;
 b=MlWOsJUzohMyMCKSkp3YpEwt71s5M53Qw9nScMArsLRkYs5JxcJD4SNoPrAp+FwqS2Kg0tC8vcwUQBBNY4TGAhogcPvAWSXvdsJErBq8YB65IxicFpPFsVZfncBB+LCUFJJNGcS2aT/s3iHZ2U9YYHlfcpxWXfeZa81Lm+btbkMGTElVkigiCjJkH9uYPgaTJ3euKrvRcE6cURkCbOZfsKhecEvxzaueE9hRNLnUZY2zdZge+9zgZYjzB0b2yat2Uh4yA/3jM4ECl1LB8Usjsh6KUTUC1BJAxP2NO9zqAB7TEpT7j8KcuPtHBsU5VW4YoPNgfmxoduJhbLQNWRPYNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5I5cZEJ3yAzcxfztY5Yo/FGBUTqvYiMbpOjKMGB2ng=;
 b=A3Hme71UHPSm4fcfSxMSZME1S23AvSsfFsIjyH9y+DNeh+sksvt+KUzZf4SaX/Vzf6r15In3oZhPkHaTKYPD0Wnq1S1GlgYk9lkhKLmlTt7uME1xi9/5O/FPCbK1iu6Kxuum7TW4GcMzp2uRD1rBcvaBdNEsSgw6huUnKNx1c4GPCn7YQF4Sbw1D+e823cITTLSsmrRinLim6tyggyseESCMbHiV6fm7E5z0MJn/DNibxZlElDlgFcduO2av1ge6qia6jHMTs0LhQ1yDH9zq3HvBG8uT5CajfgoGajO9mRMfPGokldU/O5VyeIh4h29NIViEjkKgtzbrpSJ6yKrLwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by PAXPR04MB8606.eurprd04.prod.outlook.com
 (2603:10a6:102:219::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:45:35 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.20.9891.020; Mon, 11 May 2026
 07:45:35 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] arm: imx9: Update i.MX91 part number detection
Date: Mon, 11 May 2026 15:47:39 +0800
Message-Id: <20260511074739.3772848-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 037da81e-eecf-4ed1-2425-08deaf314966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|42112799006|376014|52116014|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: FiZ1g+2dQatWG7PJSzVnxIDYaQc8YXqlH1MM+Fwpi2e/QqREYXH6BELyzhgn4nr1aKsyyruS9Dc0HpPSyirvD3wj4EDOD107Od1hQmG8AgeBzlXa7VknRPpTbeHxoW5ZMDFqMHUT0Ip7O1p1S8n0ckCK+S+j2QfOYhdItGvBzTWlcrT8KMcyNfiF9whXUi6BXzPjOsgbBQMcbeJ/IbEMedUeT4qp/4aXhID3BOCBMqgb24q5h0pGnkYl4Es999Xie0dstPh/yzIXFIIpgIGZBGrAfbppJgVpDS462U46GAg+icbYyGoSMQO/myhRBRBzFkLeu+IzQ4oDfTbjw2+wL2GbS3jl50pBB+jiUDV4MW2MLSA0ufXqPYI24PBaNyQhhzHPbdP8cvNZ6qJ0BpkVu55abH7pF4Hjo8myD3HaDzJnHb/Han2kBIKin6AqwTXl5XfY2yQTz8wuDCXhJjzrW3zQ7VosNfLezwkAHcc8aqA2P1YlRUb+TgyGHenUuTpM8PGACAdsDkAJ7ZULxdpE7ykP0RkHbB1KIKGKCwiMVcYOpDvnuUSt/QIjZPTOPaS22kADT1MawBZ8rpF5a5sxffiyOZ/YXVqpAn858L8UjlilEA+WKQao1LvlObLw9np1GJdS90q1vQAdGicxgst9wWsmIU59iK30ngs9CdZg1bDUO5y3BKF+3CL5XS4uNnEl8DEPUF0Gduytr+OsT482dXiUFfiAEl/EWhVR+MLqX8oi3nQBqJ4pJ8rhDW813kK7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(42112799006)(376014)(52116014)(1800799024)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4wqS5HMVN9d+6zPYPtbQ/3loTBrFK8dbgok9MywfE8trWsXhrdIuMldmZZJr?=
 =?us-ascii?Q?wWWtgwNM50PZrLDEp6nOmH+NJF9mC1U3DxP0qKwMeSl54ZWU+HaowiOSJHSz?=
 =?us-ascii?Q?+HzZC239WZF1eVFuVibQXKQ+kTVS+K62DYylgXQkznhXImiXSwlbycI26bhV?=
 =?us-ascii?Q?hiYnuOXIlM1WgcTlF7/8KtasSiKumMnTOeQH8++H+iyalL71TXSym1fd8vCz?=
 =?us-ascii?Q?vG957II78/SZAnMQLrNApntYULZodiACXjIlIE3bzo4zTUpPqYn5uDlSjp0D?=
 =?us-ascii?Q?uac8zgdLhXufjKdtpUdynRm7VG9OAm2gvSbui5iu5LjKdQ5wCFp7jXZ5YWO8?=
 =?us-ascii?Q?Ke9xvzzyk/vAVVGAGkZ7/x2Rtgrwv2bLEoQOgpPgpHb7HudlWkQ8WfFsRIda?=
 =?us-ascii?Q?BvieR7T7SkHZaIlT5kMFWRAto/z2y3PXRObQ6X/KgsEfieuX5kIMJo/6Po0d?=
 =?us-ascii?Q?nMvvpgWNVfc+zrkxVdWsgXgyRQuTTEGxyBkyHxK8XjT0SDkfVmFuUEUR2kPm?=
 =?us-ascii?Q?aSOE8JM9s/RNxIK5Yiu9gRS0XMxTfNKQlVr/FKT700RTopzXtUJWqiIOE1f1?=
 =?us-ascii?Q?ejhEqoM8JE5K03grhPbfGuUVLThjC/ucDMjjX5ZQb6UZHkbQ56RbC7BZqFtK?=
 =?us-ascii?Q?7jEurmc4v8KbRNKNft/Z4r69lE/AsypoSSxyX0sarG/XOyhtZpihlmZVFZzj?=
 =?us-ascii?Q?9M51nXN+n6jf6t3wOOmBdMaTJjtsLqZ285109L1uACTN2t18eN1Vx+s7cM3e?=
 =?us-ascii?Q?XRSKpE9VX2l+QfuY6GHj3vUMHlOUHCbAA+VkhqIyhUq2X2a5VITfPAKE8/yE?=
 =?us-ascii?Q?KzKk+uXH5KPH/Xl9wDjdXiVgI+mKFUwy/VaesE110ylaTwWtDizC9Hvlsy9Y?=
 =?us-ascii?Q?tGhwXw9/vl0/eZFny7Z846n2awtn+CYRuJJwVXxZqDjId4GK1jCsD7dzmd7k?=
 =?us-ascii?Q?k4D9Vg0C0InlbJB7Hman97DvePXhVAPoyvn4DW+Iorf+uIRWU7q+MsUlizIi?=
 =?us-ascii?Q?rMVYbKNaMXttOvDbvJ5A3BkezpyaRcOaKnC7ZhIBgyjfp6bAN8iOFgYMT6Yb?=
 =?us-ascii?Q?VVyxBKi3QhrDBDEkcCc5U4+s5CUM0NY3k2f97bAV/d0koe37ritVFrc7xGsr?=
 =?us-ascii?Q?0ZHTcPnYrnYF8JtIJBB2/4XPBXm+1wfCzRtcPafyFPGgczaC4c5tpJs2A64P?=
 =?us-ascii?Q?q1NKDxXj1d9MYMlKywuaNnW4UKOr2lyuzieXo8JAWGH9W7DGvtftf9T833bH?=
 =?us-ascii?Q?xMzIfKJLZlux6MHvRLLbw5jRtZlJqJdJpRak5ACGKfv+6OrazLhkl31eDOJ+?=
 =?us-ascii?Q?6DliXxSi87Ktf/tuVEkbpbN51znbSIz26cuDvddI9YOF0v/Ral9xTF0S7bAb?=
 =?us-ascii?Q?zDaLBfgaFmUFJOd6nyFPWDdWeBpbjwfrivBvZVg7Jg0l0zJVYJ0s7lRcEM0m?=
 =?us-ascii?Q?NyVsmr482ZNa7Xxtsw5P0Rq2AllDbFs6IseoM4n9r8a/ehG0Wg/NHvdzvx4k?=
 =?us-ascii?Q?JBPdK2upxzZX4ZQQtIxnaNpyjeIA0652zD6M0fLAxLTNFgD7qf56izO/0Rq4?=
 =?us-ascii?Q?PGeULjL5bbs6gdh4NskZkHcl43iR4z/NsOiMLH08ES5D2o9PmGMX5w2eBQBM?=
 =?us-ascii?Q?hza2/SYbdVg5WhdQHlc4qsoqaH/hbJuE7iGcm5if5ysNVijzdxwGHOMnurX9?=
 =?us-ascii?Q?KOnafuENHdssRgH/MQRZMlz5BC5ws2WscUzPVtZaaizop5BG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037da81e-eecf-4ed1-2425-08deaf314966
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:45:35.3778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaCynK6Jjqjw4LMr5PD4GyICDRpzrN8ogqIoq2YzokV2sJxxEK8iuLW/qWxlMher
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606
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

Change to not use NXP_RECOG fuse, but detect part number according
to feature disable fuses and SPEED fuse.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 44b3e0f5310..ec0cb18e954 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -198,26 +198,15 @@ static u32 get_cpu_variant_type(u32 type)
 	bool npu_disable = !!(val & BIT(13));
 	bool core1_disable = !!(val & BIT(15));
 	u32 pack_9x9_fused = BIT(4) | BIT(5) | BIT(17) | BIT(19) | BIT(24);
-	u32 nxp_recog = (val & GENMASK(23, 16)) >> 16;
+	u32 speed = (val & GENMASK(11, 6)) >> 6;
 
 	/* For iMX91 */
 	if (type == MXC_CPU_IMX91) {
-		switch (nxp_recog) {
-		case 0x9:
-		case 0xA:
+		if ((val2 & pack_9x9_fused) == pack_9x9_fused)
 			type = MXC_CPU_IMX9111;
-			break;
-		case 0xD:
-		case 0xE:
-			type = MXC_CPU_IMX9121;
-			break;
-		case 0xF:
-		case 0x10:
-			type = MXC_CPU_IMX9101;
-			break;
-		default:
-			break;	/* 9131 as default */
-		}
+
+		if (speed == 0xf) /* 800Mhz arm */
+			type += 1;
 
 		return type;
 	}
-- 
2.37.1

