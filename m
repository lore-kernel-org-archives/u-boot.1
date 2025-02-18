Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECB2C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2266880F60;
	Tue, 18 Feb 2025 13:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v2kPo3y7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0E380F5F; Tue, 18 Feb 2025 13:07:28 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FF8807C0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCz9I95VSx0nGPnYYs6LjmKeNgLdqgIE3aAREi2g0PHeGI66vzYgiNKsVJxdXvOAq9jBNEzAnxKI+PDsSva53rVpHRdqPkiFUDVk6OfvF/XU6gu2Y4QUJzpEqWZrpLd1yj5Ai6j1fCREdL5Q981kF30hFNX+O+RfrHODO+5VbhA1UQjjR7Qhv34koof5RSXeIs8vs8Ddyvv560GPUjuHgI7ll1XntdP8N+eTA664q92Tkn5PvtD1M/3yRv8xGY112Q0mH54SbfRO+UBSw/jIwakJ139fHEEDBhf78aey4qprM7S9/06TbdXFf9CupSjFvVDsqydFzZlJT/tvc8Si2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEaxoQtVxpVm8wmajoibLpAAHrwnwBuLB09tQoE6xbI=;
 b=HQQ+brNnrjrejDDqF/bgTHYYFQu0lpDkKcHrvum/SctFuAqlda0UF7jMXA9IYh2dF+7bjwFpgOabSog06a6RN+K+ktWTsP7sHUL1HkjU/0ASoRd0cIbLKVSDv9umKXfdeI0U9yQ1vjPPZl7oMmBJGV2xqFet9c35+dgUMAdRhlxhuthHItIT4EQmdpcsbmFCRdiND3LP1FlbtJGQhM1MBZPSCcAcKBDSEVVZkmb8SnyOKILCbTu5phyXFsjambjujqBVUlPv8GIcrCbi1e9fd0b0zwOl+GUC4jYzKxiirOaaZRebzs4QB/4Kbq/5ndUnBiYGAojQVtrJYcEn5aPfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEaxoQtVxpVm8wmajoibLpAAHrwnwBuLB09tQoE6xbI=;
 b=v2kPo3y7zOpK+A/vKBwsRrlsC0nbsJ3cK7CsK43k4HQFpFOpEMXCPE64ZWmfNmnV7jS9zh5XlGEtm9ZMTewL05TsdLiOAUaQHtsnLK8FtzUA8nuQDzCzcwgMcVeu8z+tXAwsEXcXmn6uKk43OWnf6rYzRlNNeGfEugA+OlgzYFw3mfUoilMvgJ0g1dxNnV1viP1bj2LeHJYaIB7oB59ciKfDK8wxUEETbOpTcv3ZkJImyh0X/JH3uyTTUPMreu6KzrhtYYOkSKJsjvgmDkxn+IiEgULJoFdIgtol1dcCNi/PwwCSajgrnV7zc4N9XEDDX2NNq6x0btvOh2ua2qu4ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6912.eurprd04.prod.outlook.com (2603:10a6:803:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:07:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:07:24 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 04/20] firmware: scmi: add pin control protocol support to
 SCMI agent
Date: Tue, 18 Feb 2025 20:05:41 +0800
Message-ID: <20250218120559.451678-5-alice.guo@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: fd94890a-8326-4e10-a077-08dd5014ce13
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d4O7vyqkKpoLypw8RLfS1UC8nWp6CSQ5XJ6feU9iztbdjCM11uRIr0qvgYz6?=
 =?us-ascii?Q?sBVJtt6HmRQNsnWhA8mzEDxS12GwgPrvApN5u1gyLu6rgfApPoGzwhtYPbSB?=
 =?us-ascii?Q?skkTzMD7soEIb8jUFh7MxNrnX++qw7lHU2oWtuomZsc9WI8ZIxWXilmBDDiC?=
 =?us-ascii?Q?LJ8+G8oWPNq2E0KU7hmaNE0hcp6FGdJjXZ/qXqiGeCEhoT642h8q66gm1E2Y?=
 =?us-ascii?Q?BmCuTjazI5Y0EPuMrAXQ//ROSR226SFwcWvR+WMDuPbFSZ2DrFhYtf162vTo?=
 =?us-ascii?Q?cpeI81mG80Ccu8N/G8AVSTYvn3Gu+uoQVePzfDuIwaSewucqmNs/+zP094x4?=
 =?us-ascii?Q?4vzJSGZs9N5UTruQZIxwZVBlH4d11UP7pqeczT9pCGysKDnTi/DhtQIuOIbt?=
 =?us-ascii?Q?eVybghZZ2RerbifyPfhQNVTcp9hJRos5hnvUOY4BRSWVG7jf+gzLa2gCVVKY?=
 =?us-ascii?Q?Kg7BHxvCDI7gAQ8pAA4rfHz8RW8WizBn2A7Nm2erzRmpV+kyqcQ/4DchUF3M?=
 =?us-ascii?Q?09s8/V/6cDpULRqXsz9e2btCkRfJR28+elyRVJjQsI3UJ9vJ2IrmaMuhMMfR?=
 =?us-ascii?Q?xsSTryja9KPWrWyJ2ppHFU/I82UWXMul5PpHuitFLnuNBdfevpJSyvlBxVNl?=
 =?us-ascii?Q?anUGMM8w3LKjZSUVse2+lb1y0V1QTOHuMQsM4XT5xAe3/c2S/BbRktlavq0K?=
 =?us-ascii?Q?MzgmOr8BZGRcs7yMhZpPA33IPV7AnL5FSZfsdRX2/qN2l7QnoUQ13LyGjXt7?=
 =?us-ascii?Q?q7loOm7HZQmS7IzAs4WDszqQ4SmQObY+dLGk9Kopxy3M0WXYQXeGQfeeraEk?=
 =?us-ascii?Q?CDlya0sUjr70Q944/wRc+ekbpKzq324CKsHti8AT0t/i+v+cpUL48vkN9X7E?=
 =?us-ascii?Q?vp8N5T5hfoYkyupuEuWfEQV5h1b3bqnijWhjPCrGq2qm9bsxr0KcIQ//8RQa?=
 =?us-ascii?Q?Sn7/5R0y6f3wZYei45FzQnV9ug4FglawhoGC6bR+ONKBwd9p05JjGS2ksnNm?=
 =?us-ascii?Q?9amJXbEbR2hzqxk43jU2zRn0jZ11vJ65Obx/CQFk+Zil5VA5dW5A0UdWJxa9?=
 =?us-ascii?Q?GuXNM/Pmr0j8MGOqIBeRCWdmQUtdSvs7PKWAJh343gakNqXbr5Z/Vc8++Bh/?=
 =?us-ascii?Q?dMFecQmCLLcNnOhTmlWxsDEbwlm23u2C8njRNg2pGDQA6S0pM3ulY99L27E1?=
 =?us-ascii?Q?VNRvRxI1fJ5fevOr5cf4pJjEEc86OXq+CQeDV/EKsnX6XMhq46tfWSHYGTVj?=
 =?us-ascii?Q?Gq34Bvxly+QmaChEJJe8UC3+vkM1MB6zRn4w5I/ehkPI3rL2UF0LjjUO5fY1?=
 =?us-ascii?Q?gbc0IO9QXSokZ89Kf0lLsXnMJdRUr25o4vz+llViu4g48D3303sNgRuxgxpT?=
 =?us-ascii?Q?0pIOBExKcvMB9Y+28JQANmeWjhQEKfmCMcnoBcczAlrQ444BDlfZ4ilF1JhL?=
 =?us-ascii?Q?/HPAm6cnyeU2c2X4/5/y6pBMj0oStPN7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2HIlxUTQMbFJ8xPh/FUFajKweptcL81LV9cTq9VwkX6IkDY82cV2rwDlpQqs?=
 =?us-ascii?Q?Vvcw8c7b12yJH3640SwWxr1xpmijpYHlseA1vsRMy0ye8w9b8x9/YDaY0afg?=
 =?us-ascii?Q?vozjcV2l7A4/ivPh6AQZEbu/lXeZsbFXie6AqGJphqQ2HytnxpqSnem3Jj/X?=
 =?us-ascii?Q?sGs+nFS1Kwl1V3O/JoFkjVJrjOfzQ4TCk67Pdb8bijyXC3bPLEELSK4TPDZ8?=
 =?us-ascii?Q?yA4L4nzEZb9758LOU6y25MTnEEMkAMKBQyBRNU9r4Wc1yokEWL/vigNw5JNe?=
 =?us-ascii?Q?nO8RsFkg9YrIVEigsS6eVvy9cT3avdkKxVKGKMajTBULP8PAltmBQcB9UgBf?=
 =?us-ascii?Q?8b4EKS55MukyOxqjKrk/Og2Pc8Cab3whuOeZYBnhqUIDsYB2senDeE856kuf?=
 =?us-ascii?Q?PxbI3/vTGRcI0iu7LVOb/tw/wwwftH5I7A3J062exGMDw7UHtQm2COWYC+p3?=
 =?us-ascii?Q?0GQsc2D/WWhy5A9JGm2cIU0qzY/EyNSIrGhG4RGm1aaZHTMwkTeEeawO/uQP?=
 =?us-ascii?Q?3UOMq03Luw4qlrbnJWNLEgs7UAH4pc09ybJBhEPxoI7FrxO+PLl1ymQRLsOg?=
 =?us-ascii?Q?ZSjVEm9k7HbaOmKti/PMXIXJJdlz/vAIJVxVYmINkAndRpUBU7UWwflpwmaP?=
 =?us-ascii?Q?UutY6D41uz6LAH1dd2Jewvmul/lRdZWlBNCUEBg4dm5ChxW/K+ejJBmz7eNW?=
 =?us-ascii?Q?QCmExmelDEid2oT5TE4clxI+OlkEZtJbB31rtDg4NzFMXoIPktCYDFwlgcXt?=
 =?us-ascii?Q?7Z2X8eYsGuWnmSAUOpAcNhnzjQw7JfKf+pP1Tci6EeNQw/6+HXs4hdiZbkNf?=
 =?us-ascii?Q?I5cSCpEqES8Jnf9XDlJUTg8vwDXWmXNn1/kYrxjaPLirnRL5mXYn+A++pRgI?=
 =?us-ascii?Q?bzzvqlpGZZhY6PU0nF2+4nMCnAcIwbYN1DOZuiPlXsh36lIJuIPNIxwYEGRM?=
 =?us-ascii?Q?C401JylyTPQV28gXG6KNSVsdeyhMfYoKFt/p4OLUB/DCVgzYXmoE5wmxLd2M?=
 =?us-ascii?Q?VXnqEMIHGzYLuphFJdThWBRhiI6RqnoHKTDKcPcjVeTVgR2KNYffjSUwCtN+?=
 =?us-ascii?Q?kW9huv/K8zkNB2RULyab7omAMtLkhjhy2hnsqsldJuHSEPazxeI0il5mEKkD?=
 =?us-ascii?Q?AEZvqwZDXxBFzstqmVo1yrKDZmz/MAMeTRD0e0xupjefqITIktoY5fXTHkAS?=
 =?us-ascii?Q?SKf605n8m5+W9ClBRIJyuah0CtJcfDqBX5N/IO4RX39ZVeZp3P065V8T8AlM?=
 =?us-ascii?Q?eoj08mSjLF7w/B7BFA8khOxsvBy9pgxR4opc3lnhlZwsifAsCPLGwDwECdQw?=
 =?us-ascii?Q?0hNG/HXqC/C2DKv8aUAVGpxZ6pBxP8XghdU0mSsHmOlPJJUcazbJnB8zu5tm?=
 =?us-ascii?Q?UkN+C7hbQyAqWzT22lUgO5W32sOisbAd9Qr2QVEekvyKzXB8uYREO6ATwBAq?=
 =?us-ascii?Q?tNrjWRM2WBJp8bOjCADv/uQa+TsHcg7AAnwah3SEmLhruCXOHZ0O88nqzXU5?=
 =?us-ascii?Q?JvGEfuSt5fzrxDwoFaA7h9A+ktmBhs0aG5hfSbN+ya1q84keqqhLF8Lfligr?=
 =?us-ascii?Q?8/K8yruPQPlyp3IFtKQbJvSim/JSIA/ZdxhdSUc8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd94890a-8326-4e10-a077-08dd5014ce13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:07:24.5586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhO8NPN01IuDj3EPZi67nxdgHLOlrj7/XPY1BA+pDdX8pxZ96Q5SIZzQx2YmSvCbBcJUwxzMPSNc3qySgzcdiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912
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

From: Alice Guo <alice.guo@nxp.com>

This patch adds SCMI pin control protocol support so that the pin
controller driver based on SCMI, such as
drivers/pinctrl/nxp/pinctrl-scmi.c, can be bound to the SCMI agent
device whose protocol id is 0x19.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 11 +++++++++++
 include/scmi_agent-uclass.h               |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b032..5f101f4ede8 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
@@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
 			}
 			break;
+		case SCMI_PROTOCOL_ID_PINCTRL:
+			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&
+			    scmi_protocol_is_supported(dev, protocol_id))
+				drv = DM_DRIVER_GET(scmi_pinctrl_imx);
+			break;
 		default:
 			break;
 		}
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d..4beec43cb08 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)
-- 
2.43.0

