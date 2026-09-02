Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36102C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECBB280FAF;
	Wed,  2 Sep 2026 08:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vN18RSHnuKxW; Wed,  2 Sep 2026 08:53:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339230;
	bh=N8c5qWK+fX2ckBKr9oSa3X/Ns8nu7eixdIg6CBDykpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i5hLV8ul2JKcTjjS76KFwp7w7eEGO0oGF0e857mqUTW/MjAhgSH+GZJjVpIoZoWd5
	 VRLJyo7Zvjms5fW8Z7ys2cc4uZOmSTmAysnKY5rK7D4FBfDyWU89RQUIT0nXeCFiX3
	 /o1WaJ78y0M5DM0Yiv6zzrNzbrWvkfHiGVt685OLT9qIEUinzKQT6p4/HDZvV3Nja5
	 zp3s5gr7pCv3kiqB4X6nVheUYGm7pOQL69cGjLLBFoj1dKFX22BNpHrnr8Mx0keC67
	 s2HCwhS1+vOokYrjn31JhGTL3TZOzf+j2zgRMv1/xEPcBF0U7nqoC2lwSfq6GxEXXl
	 BTiW8c9VYw1dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7835F80F84;
	Wed,  2 Sep 2026 08:53:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AE89A127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8B8D60849
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aXoDcu0Oic0W for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=KsLG00BJ
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C08EE60863
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWgaPqb8CMlGcnH8ymNFc3vhl2SSp2CqX5eV/lGY6LPjbVe52L9S/TAWfK3xxOf7J2TtajHSnc0YNR/Jgmx0brWzE0RKz6gEaJL51HpgdY+VbrMmfVxMlHpEsBgJcpSVS+sxDsCYgkNkk9/I4kpMIWWrMhZeyD5MbAqb4ePzdhMtZJr34P6fOvsMR3Ifw5cFKNozdM/CgGNQoGJYX1qbfP+/2ilJevyEuleZcQDVuDVQhDge2t8JhG9of9kijinVWuELbhvrJGoKaoQgnBdeNoAc0Xa5vcEng0PtA/Qt4xPo9MTqK9793L8iPnr0R0ycJn3WzI557MoGfkoI159qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8c5qWK+fX2ckBKr9oSa3X/Ns8nu7eixdIg6CBDykpo=;
 b=G+BLt40a9lFFse2+0nkZiGePMKDApZiXlWANsdfothdnkpHuNy3+FnPXxh0+vQlTHDlY90JzZolESkvEp+ZYHQzbUb2Euk3bUvSjVXWjWKcSic0EvIeGo1BOqomnBbn4yyjzr33k1Hz5wLTVB8N0xKmOols/+NpBGgYyQuckun8YVPvT1X8+ciw+kCRh5ZL3XxDAEA9F44dxUTB8/jsndv0VX9PKvAbX5P/xYg/TbZK1yIrs5stGKePNq0fx2m6NULrTWW0rUFAcRUhna3FI1UK6MIPCHWB7Xx0DV9PBja9ZwlI7KMnrHidaJQLnWaRFPWF72P87MatlSoakNKuDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8c5qWK+fX2ckBKr9oSa3X/Ns8nu7eixdIg6CBDykpo=;
 b=KsLG00BJ28+4IyPh8KJwCEXVf1k7JgMoxLoTbGpKmH4Jf/S8cEDNJ1lyFmsh2Et9pYOD2w8aH4CZEDIi6msdfB2qovOHP6G2KC0oC+SfMPAZhn4SsPGi7q4Jd/Tw15frkSsSvCxXm9PiZQObW3/XhW7f0UoX8+AkmBcQ0iZnIix59wr/2yhn+jY24RmBE9lwhxybXE9Fk8iQgv5WwnDndQPAHE2x70k442ZnUEvObC+dXr1ZnVI9CoqzuqsHO0aLIGpACpryDdaH5MV7PIYxR1tFaYVU5BjUcPp0nO5B/fft17mDoUlwVLOxJW4xmqDld81dSzJC0fEriByo0ZTnOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:37 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:37 +0000
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
Subject: [PATCH v2 06/16] net: airoha: add support for Airoha AN7583
Date: Wed,  2 Sep 2026 11:53:01 +0300
Message-ID: <20260902085311.1550804-7-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: a6cd3b76-f5ad-45db-1c90-08df08cfad97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: E5w3BZaCRGZNdGUDmNVRAs99ni5n/ihCGBmqP28F0alCzqINfqer1IoPzb3NngtskRoTSZAkuJFOePKbHb9YDGgk/RE6V42jEIuS4d4jvBG/3W5V2ye3He1d4jtj+U+FLAO7rFY5OpwkXypONYteW9ho7nqhssGWIzepoppI0BOVZn3djBJBRXXB3Cq7DgdD7PqWO2wtxvQV5Z05x2SYnaexIdYA1rQV1+3ePf7d9nfwz1DEABwQZKDm/O3UOowhKsKYL7w+5vKNbzRPrFpsq2vWuzI8HBtZGn74L7AjBuRf7qckB/3lYu4As+S9r2X8EXzTfK+nffPYN/A7LDGy3D9B2XNVvjNuFfY1XlaL0eMePVle1kK4iZnkvYLnVgjQ7dkjWmjQsfgS5yBOKWMfBdsgkbQUpcPbEEs/roa3WaVT+Lr2t3ICvT61VSzQxXt/45M5iWCHbHEir1h5IbobsY4LxkN6b8494HYrvbjCJQQEemYGV10VJyjtgB43QXJY6aYoz5/NIKsJOX3OeZLk5LcpNL+gZ/3RMlbjPW3NMmNWJiAdHWe8CIQWvNQ/50bLOANsXisCBnoeAHt0NngtZPBX4Zduj6jycN+5nHBife5d2kAu/ksKDzsjDweTGuqKzO/pvMPdM9y/srUZyiIQPNFlONT5zX2++SMKTDqoPFSBqu0gQMEe7h381iQTlNR6JnQUdcifUCnoV0wiJSoTxXOYC6DhhkEZrld38vwTbbqrtp+If+pEJlauF/TasyxW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zyjenlfl/uBeshezSSQlSlJ7TuWlILsjn/cKV7nzzDzwgH08h8xk4c8eUkIg?=
 =?us-ascii?Q?bXaLHLTG2FRfOVujfvPh/NfCcFI6ojRfXTdOp5ozkpT2GfFL2jNfjmwf8na/?=
 =?us-ascii?Q?Im8x2+lt5/2HeeacCv0e0czjZYvk/EY9xtBuDzTOmPH4vITjJTLZo4tLQmuB?=
 =?us-ascii?Q?IXdmPJFEI3mHWMRhN+GF3n/wrHCmDJ9AMXyGOEartGNjA0y+xn9J0h2m+wLd?=
 =?us-ascii?Q?smLd3KexSvOOokI/AYSugge+Wmpgfv4FTHfD61G1agozpD5g41Hfh/pS3dOK?=
 =?us-ascii?Q?yCjIHUdkj8qID6nerxTq7VX2orvWzxGom+7zbQVv/YVbUESKKDQysJg0PT50?=
 =?us-ascii?Q?nZPhUpmmTEN34YMCWTISefu+JuLeh2ALUlzFNlLQXW4N0+cM7N17AsVWKkhU?=
 =?us-ascii?Q?zKePqpG2CL595aFj8gndz7j3+Bf8k+7DGyh/wP0dFdEI9W9A4fYX4a/xyCkV?=
 =?us-ascii?Q?VXIWvows7PB/UIALyJy40DVXqqWTtf338HL2agVQUKC1LIEU1GBs6SYqH1Sf?=
 =?us-ascii?Q?4/mSezioaLQtFT4ZofVFQCDJ2tylibpKtMaJ2W+DOeBHaz6YTJxZpkKBWbnx?=
 =?us-ascii?Q?VT2RzZV/50LEzQonpTYrChl3fu5lchRn6TnO+CAWDw0mOri+rKk0eF3JCeoS?=
 =?us-ascii?Q?gNLZgXPHtzH3E44zDooOZlmGYe99GzZcy9BcPLWl4zJJCHWHU1BqOQkTjjgI?=
 =?us-ascii?Q?8yL4KRHojBgD8M2k+1D9mFMjuyosSiajQjF5/cZ8lDNku/GS89JljSeTwmby?=
 =?us-ascii?Q?tY9KSuHV9sFzzI12EW/z5TQmLvyqKtnRIt9DQJDrBrgTcjfy+IHncjEs1Sw8?=
 =?us-ascii?Q?vsM/6hDDRD4x/G+RILLISmSeklWGBUltLYPXH6RZalrwBAe3RRUi6i0bm1I0?=
 =?us-ascii?Q?l9RpdaMMYo6dIMfAq90WudEugTLOGTPAYRuI0vekqJLzvO67uOGGgFb3JQfQ?=
 =?us-ascii?Q?E+Be/V1UYFU9unzZ3BwnaPz4hUulXSfeEkzE7PYAksvF0LbSUamGhJ/d5O/J?=
 =?us-ascii?Q?PC+mdekZUoW79RzIjTfHoV3aiO2FrvZWZ68x85tAlQaDvuI/UKRB9kWNizOm?=
 =?us-ascii?Q?aoEqwrx7pBlqADC1x1fnLmVXPomFEYwpo/VjPa8bzijHLBm8v5V5LNWg7/56?=
 =?us-ascii?Q?O86Pgv7n+ZIoFpUKUJkwaU0fXzN3VKdma3G58BE5UkomfcPCNm98hYxC+aV3?=
 =?us-ascii?Q?/Jnts6iBACa8EtDw9QMn8uUlf+dOgIx/K5m3lIPxBkfZpLbWrqsZ1PqgsCiL?=
 =?us-ascii?Q?YclJ8gMaoBZUybHsP9lDkRq/Fl0QJhQAQVA3BdDpQqGEaekvs8VCIzAwk5jk?=
 =?us-ascii?Q?xkbeDjO/yRSVFzoeXvoneGll8mpY8RAtV4QGT2T5FAo2CWnQWYewPyzzLCV2?=
 =?us-ascii?Q?8/rVLpQqfMZFPHAGizfySnwVHU7x9fBzrRgTaVVB4fM1rlMQcfGneHd0Ez9c?=
 =?us-ascii?Q?8yIEgDWVtheh0kugSuaJi1m7NqNse6QbA66mdfTy/EdJdOaEsO5nFXTDiSjL?=
 =?us-ascii?Q?QF5XN/MeG8OM/xBK/LlfNG99a13N1OSge6XT4ntHtc9K5odybFQR8KxT7gVn?=
 =?us-ascii?Q?GOvx5xyzwBVcE1qRHMdBx4MLTAj7jjvm0YXhUJ7WjwaGjfFljxSKFg7g28Nz?=
 =?us-ascii?Q?5mvpwbJ5iw7+K35aGDMf5gMXIwE9/YZyM958LIcGTrdHvHs/kzoVpHQ2z+Dt?=
 =?us-ascii?Q?HIuj1i4hS9ASCUPX4EGd8krPI/2kQialBIIlSZxKydFUSOKLH1sHLxh3oyxe?=
 =?us-ascii?Q?DgT47ffDHA2LNbISVWoXdF17x4yrjRk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cd3b76-f5ad-45db-1c90-08df08cfad97
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:37.6313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IHkd2qC8FybqXyC7frWceMKL/F3vbWm5qQHiicVYmw1Sf2TuMiyzJjdWuKHGYszFQUB05ZfkKAl4Ihor+mwDqR+p6/B+TLxgKBWpPyDBtY=
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

Add support for Ethernet controller present in Airoha AN7583. This
follow the same implementation of Airoha AN7581 with the only difference
of having a different reset number and a different logic to reach the
SCU node.

Generalize the driver for these 2 part to account for these minor
difference.

The switch init part also required some care as the Switch Internal PHY
enable BMCR_PDOWN by default and tweak to GEPHY_CONN_CFG is also needed.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/airoha_eth.c | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index e5d39b95cc5..d552b9e9de9 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -24,6 +24,7 @@
 #include <linux/ethtool.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mii.h>
 #include <linux/time.h>
 #include <asm/arch/scu-regmap.h>
 
@@ -34,6 +35,11 @@
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		4
 
+#define AIROHA_MAX_NUM_SWITCH_PORT	4
+#define AIROHA_MAX_PBUS_TRY		10
+#define AIROHA_PBUS_SLEEP		100
+#define AIROHA_PBUS_C22_MASK		0x800000
+
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_TX_RING		1
 #define AIROHA_NUM_RX_RING		1
@@ -86,6 +92,19 @@
 #define   SWITCH_PHY_PRE_EN		BIT(15)
 #define   SWITCH_PHY_END_ADDR		GENMASK(12, 8)
 #define   SWITCH_PHY_ST_ADDR		GENMASK(4, 0)
+#define SWITCH_GEPHY_CONN_CFG		0x7c14
+#define   SWITCH_DPHY_CKIN_SEL		BIT(31)
+#define   SWITCH_PHY_CORE_REG_CLK_SEL	BIT(30)
+#define   SWITCH_ETHER_AFE_PWD		GENMASK(28, 24)
+#define SWITCH_PBUS_PHY_IAC		0x7c20
+#define   SWITCH_PBUS_PHY_START		BIT(31)
+#define   SWITCH_PBUS_PHY_CMD		BIT(30)
+#define   SWITCH_PBUS_PHY_CMD_READ	FIELD_PREP(SWITCH_PBUS_PHY_CMD, 0x0)
+#define   SWITCH_PBUS_PHY_CMD_WRITE	FIELD_PREP(SWITCH_PBUS_PHY_CMD, 0x1)
+#define   SWITCH_PBUS_PHY_PORTADDR	GENMASK(28, 24)
+#define   SWITCH_PBUS_PHY_REGADDR	GENMASK(23, 0)
+#define SWITCH_PBUS_PHY_IAWD		0x7c24
+#define SWITCH_PBUS_PHY_IARD		0x7c28
 
 /* FE */
 #define PSE_BASE			0x0100
@@ -365,6 +384,12 @@ static const char * const en7581_xsi_rsts_names[] = {
 	"xfp-mac",
 };
 
+static const char * const an7583_xsi_rsts_names[] = {
+	"hsi0-mac",
+	"hsi1-mac",
+	"xfp-mac",
+};
+
 static u32 airoha_rr(void __iomem *base, u32 offset)
 {
 	return readl(base + offset);
@@ -405,8 +430,12 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
+#define airoha_switch_rr(eth, offset)				\
+	airoha_rr((eth)->switch_regs, (offset))
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
+#define airoha_switch_rmw(eth, offset, mask, val)		\
+	airoha_rmw((eth)->switch_regs, (offset), (mask), (val))
 
 static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
 					   enum dma_data_direction dir)
@@ -438,6 +467,8 @@ static int airoha_get_fe_port(struct airoha_gdm_port *port)
 	case 0x7523:
 		/* FIXME: GDM1 is the only supported port */
 		return FE_PSE_PORT_GDM1;
+	case 0x7583:
+		return port->id == 3 ? FE_PSE_PORT_GDM3 : port->id;
 	case 0x7581:
 	default:
 		return port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
@@ -809,6 +840,59 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 			 FIELD_PREP(SWITCH_PHY_END_ADDR, 0xc) |
 			 FIELD_PREP(SWITCH_PHY_ST_ADDR, 0x8));
 
+	/* AN7583 require tweak to GEPHY_CONN_CFG and clear PHY BMCR_PDOWN */
+	if (!strcmp(data->switch_compatible, "airoha,an7583-switch")) {
+		int i;
+
+		airoha_switch_rmw(eth, SWITCH_GEPHY_CONN_CFG,
+				  SWITCH_DPHY_CKIN_SEL |
+				  SWITCH_PHY_CORE_REG_CLK_SEL |
+				  SWITCH_ETHER_AFE_PWD,
+				  SWITCH_DPHY_CKIN_SEL |
+				  SWITCH_PHY_CORE_REG_CLK_SEL |
+				  FIELD_PREP(SWITCH_ETHER_AFE_PWD, 0));
+
+		/* Disable BMCR_PDOWN for every PHY */
+		for (i = 0; i < AIROHA_MAX_NUM_SWITCH_PORT; i++) {
+			int try;
+			u32 val;
+
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAC,
+					 SWITCH_PBUS_PHY_START |
+					 SWITCH_PBUS_PHY_CMD_READ |
+					 FIELD_PREP(SWITCH_PBUS_PHY_PORTADDR, i) |
+					 FIELD_PREP(SWITCH_PBUS_PHY_REGADDR,
+						    AIROHA_PBUS_C22_MASK | MII_BMCR));
+
+			for (try = 0; try < AIROHA_MAX_PBUS_TRY; try++) {
+				val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IAC);
+				if (!(val & SWITCH_PBUS_PHY_START))
+					break;
+
+				udelay(AIROHA_PBUS_SLEEP);
+			}
+
+			val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IARD);
+			val &= ~BMCR_PDOWN;
+
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAWD, val);
+			airoha_switch_wr(eth, SWITCH_PBUS_PHY_IAC,
+					 SWITCH_PBUS_PHY_START |
+					 SWITCH_PBUS_PHY_CMD_WRITE |
+					 FIELD_PREP(SWITCH_PBUS_PHY_PORTADDR, i) |
+					 FIELD_PREP(SWITCH_PBUS_PHY_REGADDR,
+						    AIROHA_PBUS_C22_MASK | MII_BMCR));
+
+			for (try = 0; try < AIROHA_MAX_PBUS_TRY; try++) {
+				val = airoha_switch_rr(eth, SWITCH_PBUS_PHY_IAC);
+				if (!(val & SWITCH_PBUS_PHY_START))
+					break;
+
+				udelay(AIROHA_PBUS_SLEEP);
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -1269,6 +1353,13 @@ static const struct airoha_eth_soc_data en7581_data = {
 	.switch_compatible = "airoha,en7581-switch",
 };
 
+static const struct airoha_eth_soc_data an7583_data = {
+	.version = 0x7583,
+	.xsi_rsts_names = an7583_xsi_rsts_names,
+	.num_xsi_rsts = ARRAY_SIZE(an7583_xsi_rsts_names),
+	.switch_compatible = "airoha,an7583-switch",
+};
+
 static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7523-eth",
 	  .data = (ulong)&en7523_data,
@@ -1276,6 +1367,9 @@ static const struct udevice_id airoha_eth_ids[] = {
 	{ .compatible = "airoha,en7581-eth",
 	  .data = (ulong)&en7581_data,
 	},
+	{ .compatible = "airoha,an7583-eth",
+	  .data = (ulong)&an7583_data,
+	},
 	{ }
 };
 
-- 
2.53.0

