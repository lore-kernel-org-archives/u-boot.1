Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062A3C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A46780F84;
	Tue, 18 Feb 2025 13:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IDSEJ+3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AD680F84; Tue, 18 Feb 2025 13:10:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B3080F9A
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkR+rvcycepf9HIwSQUmq1v6m6EvLGxAXM0hDtHqq0pfG1BVt/vtP+sHSbZCB7RyrKvEEqXD+aNpMH2mORenG/SyUyvopyiv6V+NN3Wb7QIBRHmmsqqA9f55L28TclZCLxIraxgA/PDxIDI6dNDm8p1u45SSbh30axW4RdHufPhRTbh9bzLXAwWzgoBE390DSHWy+aDUFGbZuYgehJNrG+RVpju9QeDwMGsKChDzjbLyrw/tMLQrXU5Z6qT87kx+1UiYYIn5WU8kW8f+Sv8Fvh7JLYTZ8vh3jkDOpZGk8mtQMZ/i/lwGbdxfpPRsecIfYvfOmQiL+LUFX2z7AQxBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+oTUbn4YNYWNy1Ts9ycnVEHiWtnKk56XuY+yuL6LyM=;
 b=Oncxkyg+feiqXylKo/mNW7YuZr7PsLPMrb9Acy0I3S5YfgQ23zWdb8plnBKQlFz9d3eVtqrKTKoo+v76bsii6o6EU8jmu0rCjOYpc7WEDkUtruetfzwxVnB1xCDMlUcrCTXylY2vckufZ/oqIRPkfzqYclEbbkRBkHDkds7csdOtVEiNfFRys4rmcy4uizFrkIIaDF7XlLVRO2CNhxalJRXfv467XJ3UpkJxmuwksUuQGVoQ3QpeHrspKr3HiFC2e4cfNf+f6TwqwrGuKc9F6bSSUeHYmSnFHtFkJelS6R29qp0jS0Li2ZySC4Jz2sqgvPjuirK7y+PsBWUU8OFMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+oTUbn4YNYWNy1Ts9ycnVEHiWtnKk56XuY+yuL6LyM=;
 b=IDSEJ+3b8/bLnIO1ZgqJUAWuaAk2UD4SCig7WZawX3a7Wb62h3YRhM6gZrePG5g+LO0egBMiDHPJ91gFjqjAk4V76rc8zNV8c56x+q/GDwvrRO29q3FVTfOh0GGwPqb6iUBpGaN7vhz8yCeMTaOSLOrtf2vxCAMY5L8fuNFeh8gSWCxwqeoihx03IXqr8jAZ7t66EGHe5zJl9XmwEP7IcO9sihaGVJXDnoHQ4x5i2l5PDVewEaPZX2voJ5D0nnM1iO1vWrYsJNSZVhvExeDeB47LmRKy5b9I6AmKWIvcwvMvNQ99yxACva4JMdWqWdKmB0qdYABz21RhVSpDZo/5xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7690.eurprd04.prod.outlook.com (2603:10a6:10:200::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:10:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:10:51 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 13/20] imx9: add i.MX95 Kconfig and Makefile
Date: Tue, 18 Feb 2025 20:05:50 +0800
Message-ID: <20250218120559.451678-14-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b46bc57-cff4-4019-94f1-08dd50154943
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q+Iu0DKyNtg4kAO9HXdGjpp9LydM/uTLLih3WtqD5jU9s19eeAfgtwmWKwrI?=
 =?us-ascii?Q?Rp8mAkXBLiQ0BQCE2XmOuz/OT2HqfpjR1iJ9+EC+kVOj4MK4768grlsKkE9E?=
 =?us-ascii?Q?Es9ChJtm+xM4Nu2YyI8hryxnsTNk9yMDhtn8AJ12rf1H8QYr03XBq3QY46GD?=
 =?us-ascii?Q?EAcITGmqE8Blr1k/1/bO92tRjRxuaQjNHUcxWF/nVQXEWJW96jcK0hzeyAmK?=
 =?us-ascii?Q?RdgPQSL19/N6QkNootZ5ZTWaeKWG6y99fGiJ9oXH3PZVLokybcFdnPD1JEm9?=
 =?us-ascii?Q?mEWzvovRtUfKdeCduoCQFdDbY3rfsvzC6cWORHhV2QWrWUDvYJsUwSAHx3og?=
 =?us-ascii?Q?3WLwF36zY5aNxtrE+cMmsxeLzd2nYicf8UWQto4owdla/Rv/7tp02QNwz8Yd?=
 =?us-ascii?Q?Jiz1lrWL2SU5FiDhWm04PxNldNV1FlHJ57kUB/FE+jOFs6us3jn1X+hjXijR?=
 =?us-ascii?Q?gLAIRXJMqfzYEz3Nro5kmnpE7OmFzpfOLIQp+wwwHYK3c10OQHGw1X8x+wjK?=
 =?us-ascii?Q?93cxWh8IYdvRSVIImxRcbzcHI5lmQI/1ZoDqZej97kVOqwgrk1wDLoxfww5p?=
 =?us-ascii?Q?t9PtDaAgrCQrutOfpoYFXU768z70ouPX/5KDUONy6f12xZ60fIx5q3LXp8KA?=
 =?us-ascii?Q?dfU6sZ34uGrL9jnzKatAlwURQalX+lQXnfkIUobokd7cZMZ+8eYBemwsHTvB?=
 =?us-ascii?Q?ThxvkBviBy4vo7/Hb62xWMpiwLkWfA5LdEmgqpcFABDCXfai6Xjx+NHnY0wh?=
 =?us-ascii?Q?1jDEKXTaTTrCgPLT4fWbmBlWDznvZumOvo3y5BtYtrD/lihc7QkHWUDAoYKM?=
 =?us-ascii?Q?Sex1AwFQqzUbE6AdXiK+DW8B2EAPfy6w39qOVsLfujmfUvWIZTxKTeLz4bJn?=
 =?us-ascii?Q?MWdXxBCZxH7myUyEkAfaQmx8I2G5/WDmA+KrKRvDvgHvMSDFwa58zYoEJCeN?=
 =?us-ascii?Q?kdcxm286neJwNdqOBr0DQ2w61DJCkY+Cp7ftuGfOAwejimU+uxHlfr1y5rRm?=
 =?us-ascii?Q?8QeTAxHJ6pRZoXclnTYSzPJJXtpMvOA2D+Iz1YVEJK1iETfCpaYjiI34SIpQ?=
 =?us-ascii?Q?EiQrOkVsZyHJAs3jEFXxm94NAoD2ThsVyxOgYqlmrqkaK3/MBbveP/B110w6?=
 =?us-ascii?Q?g5xHh6bXibQR1Ayf9t5HL6N9wn4j9KNMGZBClR4ocP2GRXgf/dVjzdh68uPh?=
 =?us-ascii?Q?wOx5E6XX0b4yDcTH89BW49FmyfP4SHabCVG4WtFc3iZFwjtekULXv1kBWVNi?=
 =?us-ascii?Q?oHPbBAjvjGNS7cr+fJaX8apes+mvxrF9VRaAajGwN6T1zz3/6d5seV1+kKy2?=
 =?us-ascii?Q?RgcO1Y5YKVYTZXtA32rFEeXUAXY6ArrhEskXYqidtckiozSMO8t9nkgcFA8Q?=
 =?us-ascii?Q?y1pUIqDPLUa1JYOBOE4vE6BEiM1gGzddPqyiefguKmJqqr+fg+8wMLImR8on?=
 =?us-ascii?Q?OsogiJ0x3Xn29LulAWnUwSb8mdQ89DLj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RvKUXYWQ3DAKieeRdq46zi1t2PwFia138rOt8J2T6JrWfiWUO20rZzhdH6Yn?=
 =?us-ascii?Q?wYpw/zreRRcRigAmtwhQNwZalAQpi+esXnUUee7AZ/1TYPOUDDMTMe2rD9E5?=
 =?us-ascii?Q?ZBVT6/JqXxKtDdQMjTAMiBn9ZBHbPjUT7R3ktFMI/sd4dO1uGDTIo3ovIMfF?=
 =?us-ascii?Q?swNGVUEU5zGS/2DY2SlgFo9KFpHkdcppvJydQyJtjcizAG4sFeVOWSIqN4D+?=
 =?us-ascii?Q?4t1cqjD7ENdpRiTaNVbpIXikiO76Y7F0B9bQo/IWEdFmN7+b4EwIckNI5ofq?=
 =?us-ascii?Q?+uVTkKdfc1aaO3P7oxS2TXypyhKO570UFFNfql2Mnqy/sdOLuAdZ1nLF8WyW?=
 =?us-ascii?Q?YjKo7YQt+ez70TLeeMc4Wu2cMno0XjefmLtncoY9hJC7Uakb5DqYmnVgR8VI?=
 =?us-ascii?Q?snNscgiChrGKJutpTD/60EAZ0mCxjY70h5D80jKzAkh4g5vp5pEvKUNdNnmr?=
 =?us-ascii?Q?Fc0Y0YtHya/6ArZBUpZBSv2Wfp84bz6EGrMs/nI4H+ittvzyh5QjjTrGOHtc?=
 =?us-ascii?Q?046cJOnKU1QD6EAkLwMT6i2yPuF8YVo+xAJ1wDjAw/lSTEVEN9gyP0sLhT9+?=
 =?us-ascii?Q?o49Tbj2O+skq4dRJzjNFuCS3gpz8fyzc1qD0UqKUXuwY/ntF6+yoOBscvnz7?=
 =?us-ascii?Q?xER7gkL0Zu3fjNjnqbQPlr8xG1Tpvd6rthMztddjyJ6wV6FxX9UIaHCd095j?=
 =?us-ascii?Q?cfgiVNdQOqn5rj9LidtD9mejAl9u6farbCQOSGLArihVV7G4I8T9N6qwYWfH?=
 =?us-ascii?Q?gn2afaG6NlZZ75UkbDrvb+OilDQE7izXP0BNImMM0VCBYQq0ZT7SNthCPeDT?=
 =?us-ascii?Q?wcmVbfQDukXkoH2V5VJbySEbFi3B1XG6+kcG3Z8tKNPIt9oxMGNH51m0nXy9?=
 =?us-ascii?Q?ydHWLuEZZrKoUAOp9qXs/6gyzoVYM0RBbzqc3KKoDGKEj989y42V3TGNOi20?=
 =?us-ascii?Q?CyscKdyaziTsgGM5tyTjISyG0Htp55ikNfE986Ezau6RafVW3L3ft/Vvge13?=
 =?us-ascii?Q?/tucnRfVL9dKUgs5JOYUHXDWA2sgMZAbTRuj61W2BTOMFX/StClfdh/cJUaj?=
 =?us-ascii?Q?j/1SGqwVjyGNSuNZODDUxPDELCDGvR9gbpZJ5K6osfmE/xYdC4yUPDEI5OZ0?=
 =?us-ascii?Q?Dvs6jokcynV+j8PSCnbBEmUN4z8i2j7tdj9qnk7lD4MO5VzeRHxcuch4V5oY?=
 =?us-ascii?Q?GRw3/02UKPOzBBI43iJYVzakcYzrS+/mz4+PWYv/OGje9rve6LueAGgdgR4X?=
 =?us-ascii?Q?eIaJqXiYcONcgUInzu9JaPBdzL8AEVU3krcvges0+SlKgCzzEfGclDtgNNws?=
 =?us-ascii?Q?nO3zSjuLBM+xu7+qRcMw0Hl7D/CM3XJctPTtG+FkERhYy/DY7DBzflWkpNdO?=
 =?us-ascii?Q?83gpFU3XaLsTwE2b0rrtF8YlS7vfs/UnP1C912aD7mkZLygmV1X90GAUQKEk?=
 =?us-ascii?Q?AsUI4Mi3Xu+8R3FznLT0YuR2o1875GRXPupF1uGU8mdpDtRpxMSlhOsgl97b?=
 =?us-ascii?Q?5cLlpnlYsUmJw744zhryEcBX1GNa5IYGIAdLmRN0teOx8Jx9nDyNlh1gtFjf?=
 =?us-ascii?Q?1v6okaUcd+sN9pcEMbDIqb7Kr35eW1D1rOLMpHfm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b46bc57-cff4-4019-94f1-08dd50154943
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:10:51.2139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTQ60nCm5vqq6IMwUQ1urGKwdyKctIr2Mn3JsFR+KlcJbg/YLAQKgPmhulpWU0HzUPFhbv9hCp52zVVgj7yA5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7690
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  | 8 ++++++++
 arch/arm/mach-imx/imx9/Makefile | 9 +++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 49220c0955e..ef364ca1a2f 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -21,6 +21,14 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select IMX9
+	select DM_MAILBOX
+	select SCMI_FIRMWARE
+	select SCMI_TRANSPORT_SMT_INTR
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75a..53cc97c6b47 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -3,8 +3,13 @@
 # Copyright 2022 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file
-- 
2.43.0

