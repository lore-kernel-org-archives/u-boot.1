Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3669EC5AC9E
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03C1B6085E;
	Thu,  6 Aug 2026 23:45:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id adDAI5coOvUS; Thu,  6 Aug 2026 23:45:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CB1B6086D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059911;
	bh=DPMRKbAp5jBH4efwloiNSZ0kR0KMrDweNWLM5qCNR6E=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=WdnPJfZG4IrjSHx8c6fkguCzQGEa+09fypQ/powBD/7pm5iOvoWrDAG2FpeQNbCXt
	 X3Z4y0t1YWGAEImVzm/FQ29IA+X9K1CuVbVCC0VzXvuVos4AYR24PI3YfNpEyBvUho
	 anCltDcdGmXusKjykOgMRVjAjiC3O/37q6MkeJqkvN5yhPYoxNBAJ0rxtfAiwna/Zy
	 4UVdDXOgZYcjiRnPwiHqB/Q2z1tBpLaeYMmwSMks8QdNv/icfF5zgbV6yhwyS4JuYY
	 UhSO0gGDrualMHu6lhinn7TvJpxuIl9Y/TNWHgdzVQj+d7/InXamlUMbpTm18FMWA2
	 rTeAYfqyT/IrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CB1B6086D;
	Thu,  6 Aug 2026 23:45:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6086392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CACC680F9E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YPALkYiDxEjU for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2319980FC6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2319980FC6
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2319980FC6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSR88/zPqX5TtUGH7UyXy/8YjejiyPCh6M5f/vRZ25dLyFD7A9rVFZc7A2mIc3dh4Zo/3cPT6y06e5i0vVHyvQvJf2hGODHjM6eyCLrk+7GyQZTtjH04x5HGX9S/eIbHfiVZaBT8iP5SSYm5hhjIcnTxM2dY0YyYjvzwa18RA+R88Fe2GIcSsIxr7UOaeaCxchenUJ9vRhQVFOA3xVHpkpQffK0Wn8zumz1hoHoskZLDMsvAsfLByswiTSnBLWf2MOfeGnqae5le+CxO0xCiZVr7BqpIzo9DHXvmmFr4TOxRxKu+GO8VgwfIVUl7IdnBYWQn+fTAMaGAe9UqcrlOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPMRKbAp5jBH4efwloiNSZ0kR0KMrDweNWLM5qCNR6E=;
 b=eaa10tAmu22kn3uk0YPkrsmK7uXOg8ZBEF7DzmbWC73fHIuNCoO0Ze8RLHf8Kz/cTUuPQRWoxXY1hLCeH3nrDa3Ac+BxZXVgiLIigq+gzCwS4DR3963nM1wLmYCdDry1eB3uxd5FRhKQR7/rxqn88G0Ig60rbhBrH/WDd6AKSixBwPZi7IMGBgYNP12BG0p5rS1eI0dE1y0Ce9gU++Hd6oqbIEWL89BJXwA867jL0ZGbM8c9P1igpdF7vrr3vVfVvNY3tP0Eh2oJdIMCYxL97KpmLY3UfFb9Jh8gLcinXXECW18hQ7ldwFy85SrWA5yksowt4IBMGaGZm3JurRwaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:55 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:55 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 13/16] configs: enable PCS for Airoha AN7583
Date: Fri,  7 Aug 2026 02:44:29 +0300
Message-ID: <20260806234432.4098414-14-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e972049-fda5-48b9-cb78-08def414b7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z1JLiLIRl0zwQlkCbo2KCZ6guQi55N0hC8x51t4fzy+GBtJqjdSq2dZP3o6V4AGVzL7itQHddvlsZ0zJ+wl8xivUb9glW8yrKXja8a9WMAj+wo1BPXqXfo8nmj3qs+pvyqDRtRALkUBeP22fOu8X+9VBzhTkVJ6zDp/vUlZut9f37b2aefN2B+NFEuo8uw9bBJosED045R6odIcZlxdJiJzJ43DZ7Ogyqkuw23YvDlZ2nJV/9Ega0TJd7+hdS9gkuyiHnD8id4S2cpiqwuvQCr/hcHZ7oA31Hp+SbXZNd65memvpLYxSOWtDMJnTx9PRRMqSoS5JzThEvpT4PEZMApp0t3D57XpfdLr0lx2nrzuAQ/rOFVVqlqr2Qx3xPlI+DbL6R4kGdUhK/NtEltc7AFOjckSK0uNWuPyX1XsyrcRbMLiDFCn6CtFCREUL/fShqxpt6sUeBLZVlYo64tfo/XbEzJG+IM0jqy21DVIfOxDTSAXU7ppymV0fJIjkE8lSnX+CxLgZbQ2y3Mqjjqiy632Z8ZpZzjTPzrsZqOqoCpq0pHYCIOQSxMpUsFbqlyqetj47mMlzMtPlamYvjdG78oj2P810byubW5RmLuIUNY96eHakNcMMYN4DLkEQ8tFhNKntH474Wa4G2VQn5fDVaqYMI99Jj6gAHBPaitCeLhTLbNdmUYb/D+PwciyAMG6mDP9B0vKjWUvBi2THnzt+3b5Sn4O9FMtG72hAwWOOhGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1Trmu1zMKMDJD4xezcgj1q7mBUfWMPiO1BE3v3bA8WO61Sbypxu2V1NBeqB?=
 =?us-ascii?Q?IYvDndXkhaSgGvW6C4Uk8snRJ/hCLF+35J+QGL+6n4GOqQO1ZuzslfPIAzQA?=
 =?us-ascii?Q?RPiUsidBGcO/Hm3SP6YcTbLlHY1vTcMM2nMBzztlaoxIv5GlQVlDVJuv/MYi?=
 =?us-ascii?Q?6MayovyN7nV1toQl1PLbDprEnyyC9BYfanN3CWacGTmKAFAqEf4MqEAxV1/y?=
 =?us-ascii?Q?1RJL9945SdabSAHvxr7FTf+V226Br1flMF/rKqLbj4w048+fiAsElPn8dCDv?=
 =?us-ascii?Q?6R2OrKOml/OLn8a6OxNpt7ncy0ITBY4hUN56weFEWvywurSBCj6zEuvZ2tKu?=
 =?us-ascii?Q?pdkyALMAtJCvH0imqBNlQtseAYtv8ZVOA53NWRiPYjJq8s9DZxYNyY5ee7Vg?=
 =?us-ascii?Q?aN+h8ZPwlJNJEXAaT6MSNlgaSScZ5ttmbyoD5DF4fVuvjJjMJ0K0y2CiO/sZ?=
 =?us-ascii?Q?/CS8W4qcSaloGhu2S7To5Umf+3B732Xg1gl9sTlWATq37Ug4aYWzbCZitjO7?=
 =?us-ascii?Q?ur7InewJWubJDZQXmd1MdnUwUpKwiVqAdSjtOPCoPc3wPmEMuQxT0HEivTun?=
 =?us-ascii?Q?QSiJ2uhqIC4b0zw3RNTOgKxVX6rTGweeq2IOwb1t+B2EWxP6xrg49kSitgss?=
 =?us-ascii?Q?EbGaWCGDM1Dw5MvhyYMk9UfyrPiuny6lr0EkBxR9bAjD/pCXBh7rSp9BLA9n?=
 =?us-ascii?Q?ECqtCaI6t3QT+B5KAq2Iv9R95UTuxJ7N4uoR8eWhYoa/Ll+0HqTO9Pb1xPBi?=
 =?us-ascii?Q?znhq+WFVVrgcjxPwGyx+6eqH/ITw/bdeC9qT0l7okw75sKwXc8cDkB4QOBif?=
 =?us-ascii?Q?oNOgrYvYjXC8JufAf3B3DUEN8x5kE+4r48r/0b1szcCcpmoZXg+Uv4rpH4+3?=
 =?us-ascii?Q?ALbY3xUN3Yn53qePe2RIbr2Ob/2Yf39m+f4qF/goyvaPvvuUNq9CuOdAOe5p?=
 =?us-ascii?Q?nWtuV5pj29vZ6D6NtscPwifoHyZspJ+AQIMDd+CnAcsW3NvBWPSTFGsigc3/?=
 =?us-ascii?Q?gYfmYBR9UU78xX8+DBJ2ZSBdF8xT38kX/ISIir7om14bKpROvBBwZrDJmyiU?=
 =?us-ascii?Q?e6A4l+hK9lu/n1zpHJ0Tp9DqA6/1pN1kcx5IeTAwfWbm7KI0+RMxiS1yJ62v?=
 =?us-ascii?Q?VUIGJfKNC7NamSmyxjuPLvegKCva/XU/8Lh65AXCCy/wU9jzfv7mqE8XXb6q?=
 =?us-ascii?Q?gie182gfRPB5sXomlwgwk7phXj9Z6iL5suyDJv3S6n7aPRz27v054bv3tr+W?=
 =?us-ascii?Q?i0+cn0uMJMhtecT+VwZGBlDdc89UGP4s2oz+bp4I5J0aWCaiZpgJx5lStXs0?=
 =?us-ascii?Q?Ik9Z8tdFdWKWDJh51/gbuUrJ9dYXP1Hkgt/xVjUHlInIjex4iYhP053PzM4R?=
 =?us-ascii?Q?6P6TvJxVtk6fONlQDQxKDwNBpkwz8QFIhQPHu5m6cyKWn3J1vyB1OMyTbBip?=
 =?us-ascii?Q?n4xFv9S7yc4/2rSMDDniHz4Mk8Oxym+dylqIo4Zcb/99oJG6MqcfwHPphMz6?=
 =?us-ascii?Q?rVDU5YDhtNm559iv9ehG/brwjoN/BR6uYwd/yzI7iwfcAXa8LhDxy23fhsQS?=
 =?us-ascii?Q?ABrh/cN7bDN1wndj/upX2hIUoiEqZwwI4biNj18YZxXee36ZcH0MTvqtl02C?=
 =?us-ascii?Q?hkwxkhpojtyLQw+18V1A4XP2TZFRTOhFKyjlzFpc/i6cXzRQERsMFIxBXT4C?=
 =?us-ascii?Q?WlMfp8zYMjKUjdjY062cg3euq/kKeBXIvUWbOnEiAI4XkoqXxeFdw9E8CGhQ?=
 =?us-ascii?Q?azn2B6FfO5z/TYooj84iJJteWpaa+dw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e972049-fda5-48b9-cb78-08def414b7f4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:55.7495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4u9FaSrpwqQsSkNMZ+YeY3M7ZKfuwCeYnDMuIiTEPWMm3XRsKFnpuda7ruLsnvFuQtjHiURwSUY/WJpuqckw1/nO8Z1HcLK9y1Izb8jF5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPMRKbAp5jBH4efwloiNSZ0kR0KMrDweNWLM5qCNR6E=;
 b=g8RYG21LyWp7dlYcFy/b/LJToxcPeNdhGZJ3FmEBPSkBvjScE9SYVXulmQGY3FBVAjqzWTCL6s/coKkzHtv8I0NQpLRZRbs6P/j2IJrpz583M+TG7oDOvQk/IiY9eAEx00GX+HpYBZ4CuQgaZZNxIeoR+Ud9wFF0lyEq1TWMbVXnnbadvea+bKvoWrX5gBuNnRchNL4I1WCG84czyuOoaZgVJSniNpFpwuUxp4SYL2zPM49YfmqJxXWY6NB6k5XPrKU0tH0FWb7tf9i4lBvlTvqKKuZ8QVz7iUMNNY58t2kNl+hzwbvW0geFU7yflisIB024ZsmP4adY5KV+8WwS1Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=g8RYG21L
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
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
From: Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Christian Marangi <ansuelsmth@gmail.com>

Enable PCS config for Airoha AN7583 SoC by default to enable
support fo External PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7583_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
index 7178f45e3f8..8b076c1cfe5 100644
--- a/configs/an7583_evb_defconfig
+++ b/configs/an7583_evb_defconfig
@@ -65,6 +65,7 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
+CONFIG_PCS_AIROHA_AN7583=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
-- 
2.53.0

