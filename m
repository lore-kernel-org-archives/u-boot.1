Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243DBC624D6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A0FB80F50;
	Wed,  2 Sep 2026 08:54:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id burk4FxRx89l; Wed,  2 Sep 2026 08:53:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339234;
	bh=aFfK6P05629xl4lUEPa8ceNZxuch275zaElmXTJ4wAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0C5/7s1E3TqsVs4ub9Lm76q5s97nAHSMm4KDSM48Mkv4moGIz9AZVOv8zd3P0VtCP
	 eCymU0v6B7zfDcWXyrH9GqmwIohInMyi1w8JGrqBBOK7mlR1URHP/0az2mVWsWlAsL
	 cUjEGLsq4CQTzu/F4r4xagDeK9TrJjbpSsP1BRrX0YviBgRICCjO9OaUFiER6Ur17k
	 +o2S0RCPNjKxs8O7A8XMjWdhKFw9Z1NPS2pNAWSKKsj/x2ehkmiWkO17i0ZdESURG9
	 88aI9dP1nE3+ujENl1D+F3YbCvVHv/0A8EY7TQV8XtkKTbeA9Yn6BITUp82X4Ebl7Q
	 50ykjzQiT8SbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9FF5F80F92;
	Wed,  2 Sep 2026 08:53:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CE842FD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 033D04031F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wWK0NdVKS8bD for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=jXnfsOix
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EC7640310
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB8pe8p+OI2hhiRWNrk8Tm/thpC+Qyl00yOiyxYD/SVBjCKzdSQ/sSyorC1juOkHuggfc5pvYkigEdqn/WqV9ITkkPuK2/zdcrIn7v1wdh17wCrH5k+9pyjjLf0Xtg8cRfEKLD38dBH+n7JYELLlkh+LNjRWlYEpXn/hLtlHHupYxv9+Hh0+R4TYZ6bK49KdSvk98HyVdLOHpgRe4tN8O/9Z//KdLPnZ56ceyUM+JEZwKZxs9VbzebgDm366+z6V/M+qeZyw/TEMr/IA2MEzUfb3uO4TNsZ0s+0z/Bibgk+XS3xU7DO5DwB2JpVvfWsKjvTx8+ykPn98n953lrRfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFfK6P05629xl4lUEPa8ceNZxuch275zaElmXTJ4wAo=;
 b=ripLdSmhubXuIaIYUSsyl2OG1wOHRays7lbDCZHqAJuqgLwy4IwydKMPaugts0MdOt2syDhM6oQlzQBBU5/1c+bVR1oYsyLuI0PXcefMIa7eKTT2AhDwcIGkMIW4wzkYs12w+/aTCHyz46lxmhLRgF1bugwPJRd6TuXrdoATnRBntXH6FePqE1Z5o9dN4l5+H0KaKlOboUfhfCtG6IP33ZQn6ng/yq7hGjbO1pgVh9VreO6lODVmjVpEzW/83wgagyrjiQW8rejzz47xKQy86jvapaon65PCJvy2FhgxUut/kkLeMC4AQ6+oXec5P3/b4JcrihvGDugVZy1sH/ydqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFfK6P05629xl4lUEPa8ceNZxuch275zaElmXTJ4wAo=;
 b=jXnfsOixJXEZBrFMCoUmZgcAJdphHW5derkoKvxcBg9e/2RGJM+9DqomS+YQPFRnEnP258hrmKGmrQ2IvYbrKBXnnb1MlX9Dg+CMwH6HdBlex30R8UepcKUDFQadgvuBMo58yO12XXEFbBkMEVLgu67+CZds+cCuCryomh3LJJj3D+oZoq+Z1Sg89sYGIA2fIi6GsJv1e/GTbHFEbCeS+oB2OY5niosKAXHTT5giHqywBB9NqsM9bhukuWwDQkUqqtcnCCEKbw5ikvDiMMxhNVF6C2fsJJnkzT7WUp36r6ytTkMQStLJvAM7l8CJVXgCH7+uC356XJGnsBIX+JfxGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:46 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:45 +0000
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
Subject: [PATCH v2 09/16] configs: an7583: add mii/mdio support
Date: Wed,  2 Sep 2026 11:53:04 +0300
Message-ID: <20260902085311.1550804-10-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: c68928d2-0411-43cb-06cf-08df08cfb29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 83YqVmuTN9Um/VBZXVLEhZZjKUjTCfBWxZX52HUuUBRcdbooJVE3iEeDq9GfStbEYrW3zFTAYmPjELUowQjVf2admFwnxmciKrR3WFcx2sT0Gx0NDDgqEuWfpCG6m0yOLynOeQ2Z2ANp1faPnijRRXS6iTf05YftDX1CmXaAGSq+TOzGp6jDLKrTYC3B8rEcbCbMSplV173pBXqkl2p3tY8sPMwMKDczXF90CVWfvmW+/BNUyVP1EMv37dsVskeoODcS+C9tYjwvvrqQa0fa5BqlpTsPGXYcezwAfm0C2+pRKpOzitlpHdGWagcUMhgJGBckyw3mRFc/IUN2w0/P0EBJSoEZNnsE9FPPFA+qAbj71ekvBU3dRzvviD7IzB5bisRXd95Fvu+jhrg8g8HzG/UKK3WrRrC4zO7jCPDngqPG2BMklhR9qQHI5lbxKLKMS3BaCVYWLnY2CZ42IzhQ2363iP80O0aEAkoJQEZg32dQn6ZRh+LO1MojHmf5HydIgGqfZHguyBzWxZMwCrsL1tlXpBbdmFI6x172lSLhxOaFEzrR/mLX2BlHcVp7XSWVR8CpbnfzejeEJysTXwE1UHcxdQrqyWWMWMNomgd9IMyNkRllqhHkM8XpAhMufw9YV9mCziKj0eW+HPcTOC5wzldHpYWZ9T8t0vrUkWW649Gc9tMykT/DDoC3wuKTlpNsmDAl50LlBUmm5sZkP2Tu20qsmGYC35UfXznKPI1wJQEt0RqZpektHJ4NZZs2UPEZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+oEFVaJ3bdE3ncSHm4nc/OttTUGuhDDktyixnDovoR7CuDxIrT1BGxwR+Ql?=
 =?us-ascii?Q?AZWPCRSjdbfJNR80waAK+7CMapC3HNKF9YHTV3BpC542KMVsAggYYh6YcvvN?=
 =?us-ascii?Q?CmDOgLf6tRdRzI3X39V7tmx08ACh25BbQ2OCkU5zs/piC8ebCXLyFnEUZdED?=
 =?us-ascii?Q?qPvAFC/scOVqQWG3c0m2LLnKf/7+cmeI50RQuPBxStsA8U7DMz70P2WLfNeH?=
 =?us-ascii?Q?0ynbbTaw2RvFXvr9BEkyGRLKibs3tOM/7Hnhq0yh+Ng/1M4YlUm5OJZbJsMA?=
 =?us-ascii?Q?Mjj9QyKkviSHyfP2rywMf6JNPtbie5+n5oUX/rKXEhT0oz1plFdsAE8VOCSH?=
 =?us-ascii?Q?Nu2VFzcNSPxJvQOfsokl1Dxv/PYkvm07lyxFsg/80MIKnSRmzJ6fwKzZ4CAR?=
 =?us-ascii?Q?YFedTuOMx38S2pI9Hr+Ei96uJ14Wgv5CpTS6owoIvVCAzrdaE+kVlh9L5VUa?=
 =?us-ascii?Q?ldQxHHr1VN1GdT+mWOVtxltGcMJsALjQqWx6S4XM7z11LtPd6i1wULz/cOLd?=
 =?us-ascii?Q?8k81QgZfJWKauBrU6TZuL1fzNsiv75ojBx0OFhGybfp0+uqXb3cU8RVZ90Qt?=
 =?us-ascii?Q?SJVb0UljwhMQQzJjZVc3wSJRSWjhPYD316pwXK5f/hLyfbEiEWoOMselkLn6?=
 =?us-ascii?Q?XC5tLMGJQoaWZ0N6K5UDjl5ecNjJGTIKoow0eZsAIo5/T6/KkBDTczR4g3Iw?=
 =?us-ascii?Q?tnBAUMfFXSbV+KLJ4YU8yjVl6Nmi47C9I3ud5AvWHRvXGQEP0w1v1RKpxL/i?=
 =?us-ascii?Q?jM2qZJ0DkuAxAZ0hh3m6y9jOBfPCAn1sjpuimUYLXiHmZ1uR5OujGd9Hffh4?=
 =?us-ascii?Q?MZ7JdgDbq+e+ronzWOIGjY5bv2z5zMngZRlC6CoEfnWk3tWmTRuQQE68blSc?=
 =?us-ascii?Q?cXsTKVI1oF9krUsLE4nbKXM6p7fb7IQZ4PmJOrPosv5XVxrXpN9hPgzLVhh1?=
 =?us-ascii?Q?oz6lcht0SVG3p1igGLBipUTmu7j6y+HDN/e3hfwGR7/dnad4hXZLiMbWlGOV?=
 =?us-ascii?Q?uTgryuxnmTWpHkXtIXIb4GZu/QbgBn2dXurAWBegDvEDK1WD1eNzKtyJCjAX?=
 =?us-ascii?Q?hUcz7aN5F3+pyEF5jVZc/56YrNVsHgM4Lf7X/BpmBrSbS7UNH/3gb9X04lnq?=
 =?us-ascii?Q?qgyKxw7mZb8f7Jha2o+/OeFpqTdGEwS6nhCE3PssFLcJjPy0uewnNmIAI8yn?=
 =?us-ascii?Q?qJrxU7X8VarCnXI6U//lfqzbhz3Zd6fiVGhvAjpPJdh4KpmkkJt2nv3sQjxq?=
 =?us-ascii?Q?DfHrVrW5hLnSdPO7QBZ75OuW5M35N92MICDsqXWSpnhVRFG/8bNTPrd8GlQZ?=
 =?us-ascii?Q?5cMadODzK2F9s3q5NZh43H331q5sPhbHdTnZmZEPoCV+yWhwMWZpZ1GXZ20J?=
 =?us-ascii?Q?WLZr8xxu5lF2GFtoROuiY9bm0q4KZ2jhw1FgvukJj8xzFlZlDNNCNEfKU/IH?=
 =?us-ascii?Q?7rfnG0nw1EGiDKaM1RE25o9BfWxYB2C0uggCg4AHXVYwWnMi46lZxmdQuB+H?=
 =?us-ascii?Q?X2j34XLHKrlMR1WFCL8/OVWsmPFC6IWzvtyIE5pSvRcod/xaUR/guNbaBlX0?=
 =?us-ascii?Q?dEI9keA3O+2mOAWNAH0dEcHQfpcvEM6IsMf1eXvN0rVRVscROG4134/V105H?=
 =?us-ascii?Q?u7PzUppW9QnPUfqg5GULfGmY4skZa9v8RQ/dD4Y75tnzJGQzezaZExQqUYeQ?=
 =?us-ascii?Q?9+u8mXRfq2xqH9nn3hd3o7m7JIeStvuAX3/VLPcdk6SVw0G4vv4uBgXyBRlG?=
 =?us-ascii?Q?Ltp+dw4KGSRH9at4bqVZK7L4CP9dC3E=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c68928d2-0411-43cb-06cf-08df08cfb29a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:45.9013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9tUBxDT79Gb44uQ42N/0XdvHTE5bdvdroxOjt8LKrYbcn/TNLfBquBrHHuExamBAdFMTNm6YrhJdmBZstmZtnjtFjRXxXc2wxHxUB+50aU=
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

This enables mdio/mii command support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu
---
 configs/an7583_evb_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
index 16466be51b2..7178f45e3f8 100644
--- a/configs/an7583_evb_defconfig
+++ b/configs/an7583_evb_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 # CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
@@ -63,6 +64,7 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_MDIO=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-- 
2.53.0

