Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867DFC61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45BA8608B9;
	Wed,  2 Sep 2026 08:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xAwbLv2MpYUo; Wed,  2 Sep 2026 08:54:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339248;
	bh=AVw+LW7FPO/GWO7oyV/6Z9FmAc9WxURNzNEpEs9CP84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eUb4HbfOLxEX8JK6uqdbZUaPl5dEwskOFLBP1oEp5EsdAEatMXGKvkl4sT/B1hHCA
	 xcLb0uFJdS5iyzCHOiL2rs2/oodja7Jd8b7HgrqzUEESH0y9au7JP/E2tU5mZVp6Jp
	 qlrY6ekfUWPo8tveNNIDbwe9Caix3PTeIIkGyH0mTFb4nx57ji9FvrvWFbdXeJFbee
	 iRsjsSe0DST5gBcRXU7IIiBsBOoGhyMrs7GXcA5nLN/EkrvhhaYUbo0sFa7QLzLJgb
	 hxsX0k4A2Rq/HGTMkvZ7M/Eph69lYmL64/F6b/7M/UeqQu/nTJx/wQ28/uSJbtHhw1
	 6rMrCVjhmkVUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DF3460873;
	Wed,  2 Sep 2026 08:54:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F19092FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3EA140310
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oul8J3BkJcWJ for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:54:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=xil1obe3
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D90784031A
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0Qm0l5yG8anIgAOXGOdfufnjHam1H7MCUSfj1n6PbIAPQveL+vgo0maVDA4hX8xnRXsD2OBpIxsZ6Zt7kqqnHpoi3wnGTgqjLkcd0Q8KgNwcq7EKUuKnRcnkTv9IsPUkjgAObyt2ZyNmg/zvk7EYdRSC2yoa/rPwOifT/mLzYud6wV8nOSviiYtrh71xxP9P2+hpK8B63+QsqlhRHAGzvtJEYXkFyWQiRKXuMvXq0461re/oDVQG0ymsM96fMtSigGEs8BfRbEhmUT3df1YZw14xJ+aNxgEysSC8vQAXdicimAxac+FYVzXTIQwUlGvplAxyZ227dU3evxHH3jVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVw+LW7FPO/GWO7oyV/6Z9FmAc9WxURNzNEpEs9CP84=;
 b=D0EbURvRXZxPm8/93YqLMtbC7ctDoznYBNXeWsldAK9o/Ak6r1aniycHGJAtD5j117K0nSwBZchXb0r6mUA8Mm8nvItD4NhzlMdCkkQnHrIzh3t4y6jHDsg6KdK7klLLPe8DAhlfIRaVxcdyMlyTqGgwSYGTtnws86W+DqnUFYpWMkdea0uAd5rxno0HrEfhQF4Dym1QRfEpBF9WkAVkuqeemIgHvuULGtGOJ5cEQcFE3+YbvaXJSDDTJ1EYIEqAno8v5dymRf/59MxlvrY8M98lns+Egx9OzIxGQ3gk2M0bSoKbK+ywAeEYlmYgrxv8C5V53mHPPyuPvpaYeuZAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVw+LW7FPO/GWO7oyV/6Z9FmAc9WxURNzNEpEs9CP84=;
 b=xil1obe3SB1elLKasL8yBAP9IYXpzwJ4BtRh5qg4B63WmsoBiYZkj+y1zyoXbWQamJ86WMqjOtKud7s5crdkibBKEvqVJpADwB6pt8eTPckZX0TNLUXf1tc7XE61AoZsikYfgjtiOfKqBBiWCxP0I+KH9x+basNyIBnwL8IwwFIXSiszXrUL0v0bpz/afO2fsEq4l+M19hInN6AP2en9snRny6B3lB3FnvSd7M8noHkQeJYxiMuDzXE62YWHrSph8AltSljLkQkbtGnv7wzLzzUDtez3xvZjwFXzMN0UCXpx+JLdmQ0ko/IDWDLVoiy8TPlHt6VF0a53xgyStd+i/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:54:00 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:54:00 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 14/16] net: Add support for Airoha AN7583 MDIO Controller
Date: Wed,  2 Sep 2026 11:53:09 +0300
Message-ID: <20260902085311.1550804-15-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV2PR08MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: c340998b-6a7e-4991-212d-08df08cfbaf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 4gEx8u9qsIKxEy292XjRHZH/9pghuYGJCOhCU236GHxMyeNP7AxDLJqK+B3UamXlxTY+1mU0MLVdp/R+J4RcyJ+lJleR6cpqplSK+yvF6JIkQFVsxBws2C6Ikp2YINVVLkIdAYUgGsa6wb8xTU/X6Nkg4zpLXSZFVcHORuGdLtLnVwjhiB92gUg5T3HfGtLtBfSGGMWy2fxYBKjsR8+NvaMm7ZIbd/Sa2HaBBTAFNHV3D3FTf+qfKmTWTSwy6TyX2F9z69G4822s4OWSAJxffi74Ep/Vin1+ZV9PJ+PqsR/F0YhfGfOg7F43OeuWLQ9RG+oNjTALIkwlu2QeOLST1+WT2gw1whdGX3ErPzfBfO+S+1pBgLwfeXsrfDoQobsqsSWKepDhmgC7oaF07gBIX8i1k1kAjsNuaQ638BZnC4peAJmrna/LROnivFkAeAl6BWhULJZZ9tdc7zlyCk+MGIM+vA9nQKjgMhK448cjUhDvYdQ8aBN/tQn+fQx9uI/4dKAa4/jAX02DeF+8aH04+Y4SdtrGI2K2I9ClELtnIvZAA39L1aKyy3O3vJzSDZURERixu6GSIyUSPXgn2keCM29NTETaRXYbuAorq/KcONFEI+gN3NZmirl1qE9nm04i5/su9wHlzs24/CijQngeUVn05+OejDwaFXmzte/WszvGz9TSwW93g8uCBQMIsq1zzPieslw8PZgCPEXNk96RK8w8r+8t6/s9dIz5DtcDJLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zsh40W4ER+jCZy+khC0E2UPx1ApoR1SJYkSZcoO9xkOS5rHz28Kxr2oxjweF?=
 =?us-ascii?Q?kaLS9Tw1DCW5ZHsP3ZE7gc/8SG/0NjxG9qNoOl8rIjz/6AzFRWCuQVVijOGs?=
 =?us-ascii?Q?e0HkMVUAlx2p36nU3HnaJsw1kJjvRgsQDRZhPjhtzYMqbsOjtndVXLjXLpjE?=
 =?us-ascii?Q?mJuuJjQWrhY9XJTJnKQHf/FOxt/6bIf8usBPtcn50m7sbhSKNw0Qo0h77BDF?=
 =?us-ascii?Q?k98fM3Ghbh/Af9Koiuh3IZGZ1wdmIEunkxY5qKtwRtwJZNimJJH7QscvoE1V?=
 =?us-ascii?Q?p75X2Hf/mBD//eug7bymwMMniRErwzUrprad4LwWCRaqm7LwmIDgX6WhX1UE?=
 =?us-ascii?Q?fMD7nvQfVApH2O0W4WDRabHDZodMrKotS2Eya3Wo7zxK3h5ZbY21BgscG/6s?=
 =?us-ascii?Q?Lh07yHWboI/onZ0ifBDLz13Le7vg1kwfv6P+YdFPw5F584S7tkxrh4OEDb7T?=
 =?us-ascii?Q?HM8grwo2O21cyOGlQMsLrbtus2nQky5Q1MLC7HYU2At3GF1qDnUdp3uMUPFy?=
 =?us-ascii?Q?+aLXDRyY1/7WQoUxIz29qphnfunw3quTDytiHb3ChG4ochDIOvWJA8djkLS3?=
 =?us-ascii?Q?2X/8pwqk5gqwsmxVY7gjgzefNt0K+s3XxXO5SP7kNTSgMC0utKjrznxH4D+v?=
 =?us-ascii?Q?l2y/RT9v+HbNu8NevA5iJLJfsn1+u5pusYGtUXUJBICF0XI7bPMe0w5XDYQK?=
 =?us-ascii?Q?3EU78vu3E/1fUpOQrbEFWFuByBC3CINHN9iJplLeQ2XLGHzPuu9SleZErABL?=
 =?us-ascii?Q?ouvG2/UDDHU48H/oxi0TvamPHzCZ8DO6kYxYWJm7aD8pH9uka0ob3UN+E4S2?=
 =?us-ascii?Q?0T3a/ghmrRXNH2cGApxd52u3FlWuvFY2uFgUeEXJzx5QpBauli3viw26UH+/?=
 =?us-ascii?Q?Cq45qXi1ybIbqQPXiuiEUStBPzfH53Ir0APG2+RLNQ7lQJ5QeqHpAxo+u/uB?=
 =?us-ascii?Q?IuqVVsJadJSf3jGKJRo2zoUb89oeNnzJxblb8j5OayBSe9DDdNsPJhOGsPCv?=
 =?us-ascii?Q?4HCYdZ/6hNdTzSqiblVHtLMQ6ZrxuHLFJvATSVd+ydBFDJJTd1+t+pTMPmpa?=
 =?us-ascii?Q?U67eig+K51Xt40CMst943SlrIdM2QfRNkwr/EvPWBhSIQA8l7QuqLEyLSUbr?=
 =?us-ascii?Q?h7Q33fh5uBAlLHlAUMsyiCjcvp0vg+XlBqc2cgeFT2ve5t7EWY66Suvbb26c?=
 =?us-ascii?Q?n6NGaGcDQ1kTLOTdoTerK/JDqKZus+H5AbC1BgDZpwFZzWLSEmPl0heTti2m?=
 =?us-ascii?Q?MU2UdONFB/WYHWOB+lkequijmjHUquVANRQAUDjJZxnwOaifEXVHj+QK3MX3?=
 =?us-ascii?Q?o2IzdcbdObY89AZgW+FdpU/hOhBjCSB9lAmSGgAM9Gz52UQ61vRMSAwnfb5T?=
 =?us-ascii?Q?y2Fau99kgfKpAdjrdI/8OFePHlwrDtlXUDziYIEVZKn/Rfn4PVK08pR1jnOv?=
 =?us-ascii?Q?+bLMkznR1W5noc2hU0ifmUWAivd4UkDYRbrGmki+JiGrXD0HAzJAUpzAFBp8?=
 =?us-ascii?Q?ExhAhFpB8cwSPGP2jklfgGdPNdvcM2vmzFAPIz7es8F54DcJ23Li71ZcdcxW?=
 =?us-ascii?Q?yE/9AFyP9Fzo2mlADLfdmSM6dENgSwA+Mk93a62vyj6aIeudLT3W1GfqdRoc?=
 =?us-ascii?Q?bGDOvPiRtLD0REhAz53MHp9hRGo+kpn0f/F5eMi+RMfVs5JgeYOswLG+bLBP?=
 =?us-ascii?Q?sseGspLpEtF0/Wy1trUJkrK7OumfHRV1KX6LmknmNXB67sJiRXxXrVPrA7mF?=
 =?us-ascii?Q?1ubePIQ5A1e+ukhprH5yj4TaA2gCwzU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c340998b-6a7e-4991-212d-08df08cfbaf0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:59.9638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UY2/F5pQVCz0oweBpJxaH5zrdNaBy2MTz8BgK/chSL4VmvcDXQ+CTPJaIYTADmDV9ENAPphEerK/tZMQmHjQzw8P40UsJX1g7Iw4nBnIJz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11739
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Christian Marangi <ansuelsmth@gmail.com>

The Airoha AN7583 SoC have 2 dedicated MDIO controller in the SCU
register map. Add a dedicated driver for it ported from linux kernel.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig       |   7 ++
 drivers/net/Makefile      |   1 +
 drivers/net/mdio-airoha.c | 221 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/net/mdio-airoha.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index faa08e9ebba..d2515a98ebf 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -118,6 +118,13 @@ config AG7XXX
 	  This driver supports the Atheros AG7xxx Ethernet MAC. This MAC is
 	  present in the Atheros AR7xxx, AR9xxx and QCA9xxx MIPS chips.
 
+config MDIO_AIROHA
+	bool "Airoha AN7583 MDIO interface support"
+	depends on DM_MDIO
+	help
+	  This driver supports the MDIO interface found in Airoha
+	  AN7583 SoC.
+
 source "drivers/net/airoha/Kconfig"
 
 config AIROHA_ETH
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4c1f4094ab2..ad5f6dbd434 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_KSZ9477) += ksz9477.o
 obj-$(CONFIG_LITEETH) += liteeth.o
 obj-$(CONFIG_MACB) += macb.o
 obj-$(CONFIG_MCFFEC) += mcffec.o mcfmii.o
+obj-$(CONFIG_MDIO_AIROHA) += mdio-airoha.o
 obj-$(CONFIG_MDIO_GPIO_BITBANG) += mdio_gpio.o
 obj-$(CONFIG_MDIO_IPQ4019) += mdio-ipq4019.o
 obj-$(CONFIG_MDIO_MSCC_MIIM) += mdio-mscc-miim.o
diff --git a/drivers/net/mdio-airoha.c b/drivers/net/mdio-airoha.c
new file mode 100644
index 00000000000..ac1fb13622e
--- /dev/null
+++ b/drivers/net/mdio-airoha.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Airoha AN7583 MDIO interface driver
+ *
+ * Copyright (C) 2025 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <linux/delay.h>
+#include <linux/bitfield.h>
+#include <linux/time.h>
+#include <miiphy.h>
+#include <syscon.h>
+#include <regmap.h>
+#include <reset.h>
+
+/* MII address register definitions */
+#define   AN7583_MII_BUSY			BIT(31)
+#define   AN7583_MII_RDY			BIT(30) /* RO signal BUS is ready */
+#define   AN7583_MII_CL22_REG_ADDR		GENMASK(29, 25)
+#define   AN7583_MII_CL45_DEV_ADDR		AN7583_MII_CL22_REG_ADDR
+#define   AN7583_MII_PHY_ADDR			GENMASK(24, 20)
+#define   AN7583_MII_CMD			GENMASK(19, 18)
+#define   AN7583_MII_CMD_CL22_WRITE		FIELD_PREP_CONST(AN7583_MII_CMD, 0x1)
+#define   AN7583_MII_CMD_CL22_READ		FIELD_PREP_CONST(AN7583_MII_CMD, 0x2)
+#define   AN7583_MII_CMD_CL45_ADDR		FIELD_PREP_CONST(AN7583_MII_CMD, 0x0)
+#define   AN7583_MII_CMD_CL45_WRITE		FIELD_PREP_CONST(AN7583_MII_CMD, 0x1)
+#define   AN7583_MII_CMD_CL45_POSTREAD_INCADDR	FIELD_PREP_CONST(AN7583_MII_CMD, 0x2)
+#define   AN7583_MII_CMD_CL45_READ		FIELD_PREP_CONST(AN7583_MII_CMD, 0x3)
+#define   AN7583_MII_ST				GENMASK(17, 16)
+#define   AN7583_MII_ST_CL45			FIELD_PREP_CONST(AN7583_MII_ST, 0x0)
+#define   AN7583_MII_ST_CL22			FIELD_PREP_CONST(AN7583_MII_ST, 0x1)
+#define   AN7583_MII_RWDATA			GENMASK(15, 0)
+#define   AN7583_MII_CL45_REG_ADDR		AN7583_MII_RWDATA
+
+#define AN7583_MII_MDIO_DELAY_USEC		100
+#define AN7583_MII_MDIO_RETRY_MSEC		100
+
+struct airoha_mdio_data {
+	u32 base_addr;
+	struct regmap *regmap;
+	struct clk *clk;
+	struct reset_ctl *reset;
+};
+
+static int airoha_mdio_wait_busy(struct airoha_mdio_data *priv)
+{
+	u32 busy;
+
+	return regmap_read_poll_timeout(priv->regmap, priv->base_addr, busy,
+					!(busy & AN7583_MII_BUSY),
+					AN7583_MII_MDIO_DELAY_USEC,
+					AN7583_MII_MDIO_RETRY_MSEC * USEC_PER_MSEC);
+}
+
+static void airoha_mdio_reset(struct airoha_mdio_data *priv)
+{
+	/* There seems to be Hardware bug where AN7583_MII_RWDATA
+	 * is not wiped in the context of unconnected PHY and the
+	 * previous read value is returned.
+	 *
+	 * Example: (only one PHY on the BUS at 0x1f)
+	 *  - read at 0x1f report at 0x2 0x7500
+	 *  - read at 0x0 report 0x7500 on every address
+	 *
+	 * To workaround this, we reset the Mdio BUS at every read
+	 * to have consistent values on read operation.
+	 */
+	reset_assert(priv->reset);
+	reset_deassert(priv->reset);
+}
+
+static int airoha_mdio_read(struct udevice *dev, int addr, int devnum,
+			    int regnum)
+{
+	struct airoha_mdio_data *priv = dev_get_priv(dev);
+	u32 val;
+	int ret;
+
+	airoha_mdio_reset(priv);
+
+	if (devnum != MDIO_DEVAD_NONE) {
+		val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+		      AN7583_MII_CMD_CL45_ADDR;
+		val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+		val |= FIELD_PREP(AN7583_MII_CL45_REG_ADDR, regnum);
+
+		ret = regmap_write(priv->regmap, priv->base_addr, val);
+		if (ret)
+			return ret;
+
+		ret = airoha_mdio_wait_busy(priv);
+		if (ret)
+			return ret;
+	}
+
+	val = AN7583_MII_BUSY | FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+	if (devnum != MDIO_DEVAD_NONE) {
+		val |= AN7583_MII_ST_CL45 | AN7583_MII_CMD_CL45_READ;
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+	} else {
+		val |= AN7583_MII_ST_CL22 | AN7583_MII_CMD_CL22_READ;
+		val |= FIELD_PREP(AN7583_MII_CL22_REG_ADDR, regnum);
+	}
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(priv->regmap, priv->base_addr, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AN7583_MII_RWDATA, val);
+}
+
+static int airoha_mdio_write(struct udevice *dev, int addr, int devnum,
+			     int regnum, u16 value)
+{
+	struct airoha_mdio_data *priv = dev_get_priv(dev);
+	u32 val;
+	int ret;
+
+	if (devnum != MDIO_DEVAD_NONE) {
+		val = AN7583_MII_BUSY | AN7583_MII_ST_CL45 |
+		      AN7583_MII_CMD_CL45_ADDR;
+		val |= FIELD_PREP(AN7583_MII_PHY_ADDR, addr);
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+		val |= FIELD_PREP(AN7583_MII_CL45_REG_ADDR, regnum);
+
+		ret = regmap_write(priv->regmap, priv->base_addr, val);
+		if (ret)
+			return ret;
+
+		ret = airoha_mdio_wait_busy(priv);
+		if (ret)
+			return ret;
+	}
+
+	val = AN7583_MII_BUSY | FIELD_PREP(AN7583_MII_PHY_ADDR, addr) |
+	      FIELD_PREP(AN7583_MII_RWDATA, value);
+	if (devnum != MDIO_DEVAD_NONE) {
+		val |= AN7583_MII_ST_CL45 | AN7583_MII_CMD_CL45_WRITE;
+		val |= FIELD_PREP(AN7583_MII_CL45_DEV_ADDR, devnum);
+	} else {
+		val |= AN7583_MII_ST_CL22 | AN7583_MII_CMD_CL22_WRITE;
+		val |= FIELD_PREP(AN7583_MII_CL22_REG_ADDR, regnum);
+	}
+
+	ret = regmap_write(priv->regmap, priv->base_addr, val);
+	if (ret)
+		return ret;
+
+	ret = airoha_mdio_wait_busy(priv);
+
+	return ret;
+}
+
+static const struct mdio_ops airoha_mdio_ops = {
+	.read = airoha_mdio_read,
+	.write = airoha_mdio_write,
+};
+
+static int airoha_mdio_probe(struct udevice *dev)
+{
+	struct airoha_mdio_data *priv = dev_get_priv(dev);
+	ofnode ofnode = dev_ofnode(dev);
+	u32 addr, freq;
+	int ret;
+
+	ret = dev_read_u32(dev, "reg", &addr);
+	if (ret)
+		return ret;
+
+	priv->base_addr = addr;
+	priv->regmap = syscon_node_to_regmap(ofnode_get_parent(ofnode));
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	reset_deassert(priv->reset);
+
+	/* Check if a custom frequency is defined in DT or default to 2.5 MHz */
+	if (dev_read_u32(dev, "clock-frequency", &freq))
+		freq = 2500000;
+
+	ret = clk_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_set_rate(priv->clk, freq);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct udevice_id airoha_mdio_dt_ids[] = {
+	{ .compatible = "airoha,an7583-mdio" },
+	{ }
+};
+
+U_BOOT_DRIVER(airoha_mdio) = {
+	.name           = "airoha-mdio",
+	.id             = UCLASS_MDIO,
+	.of_match	= airoha_mdio_dt_ids,
+	.probe          = airoha_mdio_probe,
+	.ops            = &airoha_mdio_ops,
+	.priv_auto	= sizeof(struct airoha_mdio_data),
+};
-- 
2.53.0

