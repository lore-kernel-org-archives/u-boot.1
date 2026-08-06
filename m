Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FF9C5AC82
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29C316087A;
	Thu,  6 Aug 2026 23:45:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KkjOr7vZQY32; Thu,  6 Aug 2026 23:45:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 124DD6087C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059915;
	bh=5sTD18ozE9Q0q3fXwYN+xj+PKp8QVl8CVhcWWwOhkjI=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rJkxF4jOeDfAOSEBi58C6HepqhWYcRCiXOn8/oXxhRumlC5jSLNknFToCWjzH3O2H
	 Gw7ZFb/wtJQ68sCcYqDEO1i+cHOK/gyUPGKtvbThUW2T0j9yuxhSFyRh5du1xDvlu8
	 ZV9r+dU08mkDUfrZeXPAh1aatzbieLQunMJoMPomZkNjolvRFHpV3WblE42QXCpFlZ
	 //DWQmLHPZ/1YKLzCFNPy5B8XMJvdqDZUktXXD8LCDz0PYJmnCC9dHictBdU2f7slM
	 Td5psbpggcdLPdtHgZlzQypXfqABI+AMFrIoIz1FkYuvkZAq7AZee4ifFnTvRND1Ch
	 gTglb0okepchQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 124DD6087C;
	Thu,  6 Aug 2026 23:45:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 334AB397
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:45:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1922560868
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:45:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y7pogA7O9pD3 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:45:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2606C60877
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2606C60877
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2606C60877
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFG96Elu4PAvKMy6fq8FowQ3CV/Vkzg+9GfzZbyDIgfEqqCLPGe5PrX0jQMih2c+fNjiU5UScNvG4Ko6A4Vo4YniUDR+UJpx3S/2xpqcQbMH5U2WwzBcx1lQMu0Rpy0Z8H95r62MHQIDH6dcfjn8z5Qlg651lshzd9RmEskYUazvt6Ujv1tUr7qm4/LHyzTPR+12F9wzXwCYnu/so+qhDepsyHBDa3o8NuLMYRkZqnAqM+VFcAyqHbSuidP3VdswGWGIWrPSoviKpgAePH2ujVH7LDgfgUFERW1d1S0OWPThR2sDd2V7Vk+rEzRv9c5IOdisoEBxvnzquCNSt+JsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sTD18ozE9Q0q3fXwYN+xj+PKp8QVl8CVhcWWwOhkjI=;
 b=F8jujZ6rc+rvrSP8t1aYTtsPV8WD2Gu7rxy3RFK6QW0cX6RHY6hzpNhN02/nIVJwwQiKmVKD/uJDb+kxvw8FGZTnzlt0/j0GUzlwOsmJaAFBbY77d+Cufa5vOvODldxt2rJq0G4ziBvMERR8LP0yPBsMNLKEwwYQEQsIqySfcTCXvRhxn/z8q9tJK/tCTyx+SGcqLSarNynn4pLn/pM8A8YpqXvjB5UsnghfhUESEOeB/bL6cpoPhOgk73pBpr27dpLvUg6KbdHhH81FJjLkUnTDW6V3XH79UepLT5Scfv1BCvabjS9Iur+SbG/uu9wdvPCdMQVOjv7AZZCr8hr7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by DU0PR08MB9228.eurprd08.prod.outlook.com (2603:10a6:10:41b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:59 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:59 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 16/16] an7583: enable MDIO_AIROHA by default
Date: Fri,  7 Aug 2026 02:44:32 +0300
Message-ID: <20260806234432.4098414-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|DU0PR08MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 647d8b91-ed98-4386-20c5-08def414ba2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|52116014|366016|23010399003|921020|22082099003|18002099003|38350700014|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: fPXUIOGzFvcG4Y3H6Nbi9dumXVHTqfUPA8wSBVboStgB+/CAahX8jsxoXZhOhdemA/fDv3dSx/MOgePDStZ+LzTtn5MhRr+IrSK5RwmbTTTO+m1xQ3lXoOvpOW4f0twlIrxNiHSIrZSKO2n/1m2fQWIRKPyo1erT61RGnGe00q2KA1oXkV/L2xh9TDMpJLUljqPsAVHzWVMVaXx4kdoZ1tRGanQaMZIpSO7o9hZniaiqNsDW9+BWYPk85rRS+S9VkIMWz3zOci5ynar8RWpUYzxKMO1psn+S04fVYbSdW43wCz+VfRoKwZIBEB0+AaK8RtHB5Ozb743WBReTSWq/Sze5DwaXsT7quDqcT+nbTiklVKCtX1HxhMVsLBexaYVRQrlVL4MZ+e8qeV99P6WHMd+yFi1R0JGAxE1ktXallsBYM5Ght/b2b53dqzonVSnlVWKKjiAaOEszfk8LB2CoP7XiLf6mPjF8G6YfFwMIDdzxjosliuw5ZkStr6kEpkc7aTAojGrKiGTNhI5ZxdoOqoy7MD1beHlQqXG4bzgOhJF27NjzEsZP+kqafpnc/pa/0zN8cyhPWUY8YypIY0z6DIRy8n3534L3QwVZfjgVBC37cw6j4PVu8o1/sZftLahPhlnmtyX8wdmqoaYOMmT+ZESI+enOuRX86H7+11GhOH2Lb2JE9bri1xMnIu2qpjEGf8kxb4CCWMZVkbjZ+3TUegjSKa3fMPRmAz/HjTK3vss=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(23010399003)(921020)(22082099003)(18002099003)(38350700014)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lQWj5UG0nFLtFL0r5DjKW9rsVbvroIR2M8TSvq49ZBqbam/14wbvc8abNVaY?=
 =?us-ascii?Q?o8DMU0jT7bxi7tpJLwpQiXas1hSBD5imPK7KaQ5O6j+lC0rHn1WG0oS5sCTI?=
 =?us-ascii?Q?rtD4ki8wCSMkiA2W3UiGwB+zLaDf6STLGufGz9JnX6/uFvsplGbGCqFMSF4q?=
 =?us-ascii?Q?4e1oqcWKVulHW4i1fjw8jjK/hRjSuzkaGe3X4heK/XhtIW68JmqX44AguEyt?=
 =?us-ascii?Q?Zt4UjHl6yj3byGsmQ0ZTblaHfcqwmmd1TZi0b2mA0Erm4iuRbUz8gg+XY4Je?=
 =?us-ascii?Q?DEC71wIGMJh263VfGRdF9InV694/QPA4+99oioqkja3c5IswIVqzhvJPHe3W?=
 =?us-ascii?Q?x9/7cECxuCIW/81cAoIHqgUZU4IQlKelrOaOwf8+jW4ykYHPZ9HlWJ2TjWGU?=
 =?us-ascii?Q?CxnkgK7WmfYVag0qMEGj+/2Zyuoo6EmLjYxmHTHd3LmbptIqV0brjbuim59F?=
 =?us-ascii?Q?fEvTp+HBdVX4IA7nffAMO1+4+D52Byc9Q99eexrr24Dz7b0uu1sJDg5iHCxU?=
 =?us-ascii?Q?brk9SMOb7kSygEwJYrHegbPZQSD3jPrsetllxqdudlQnVjFmOuO4nbm2bgq4?=
 =?us-ascii?Q?9up4tgShJ980zAJ1KzcW86efjTV7Y7kKe/OEO5Pid/OGABO43Wwc9Oa0VBk1?=
 =?us-ascii?Q?tnHJF8Dwn8CCRTHh3hb3U5ZE3Pr8PYfjrVSGhlcZhIvfHuDkNtz5JPO6Y/ZJ?=
 =?us-ascii?Q?DAvBvTnt1Wk6ZMezdA41iJ5VsyMIjN7evHGucWvz4fDFAkUVLl3WcuulyjFf?=
 =?us-ascii?Q?UTcThi80OMeBWCf7d1Kop+vAsDReobt1EoyHMGwv7sjR2aaRfG8UckjqxbPg?=
 =?us-ascii?Q?RPZsATO0EI8xNYzs1mJSLRpkdMlYeECJ4jOPxUv6qN8iGtuEnAwEZRuNgMyn?=
 =?us-ascii?Q?SySagj2CU+NWIG68dam1CJs/9WyMNG6G5ifLAqW9Zay3vYT0S581g2PuggrO?=
 =?us-ascii?Q?yC94zjbiGhEVnb7f1putF6aSG15mF0VVjtAtTT2QMpbiTTglHwE3Fr/wIBVO?=
 =?us-ascii?Q?7zCZnJEEGEmKOnodKImewTyVrnz8L2vhrtFO89c9qkQr0aQ/+M44JMzjRIOL?=
 =?us-ascii?Q?WRbn0IN/O8YZrjTBC6/FADT2D9GqyBuIR9h3zhfB+HjP2YDpbafC88Lkdzrm?=
 =?us-ascii?Q?AOwxTZyzQUs3VpTLhP5WPUqT1cEWGiolQR59VImgOHicBlWH2tP8hxxudoaY?=
 =?us-ascii?Q?zkYxFxFdKG4ZA9G24BSCVhXMm6nEER7v5irUStQgOj7lW5O0j3IC25wOlSzH?=
 =?us-ascii?Q?34mcQrKhWb772eOdQo2hd4SbZQRCD56sxxSdVLG8i/h7AEZZDkFAyTDIUh6G?=
 =?us-ascii?Q?lmdlxHXHrF2iacFeuDp3xDZgS3HbGnUx5wJSHRY3Tqu15V84npFvlYLOl8hw?=
 =?us-ascii?Q?vKKlneLZEZsH7F5cxSuPSAR2pQHYj6EkRed6ieWnwIQZTUMJQxlAIumJKM7a?=
 =?us-ascii?Q?6Rf7wZ1A2WAh8F2whVgHbzf84vYBPM9jefxUPzqEg0wX9VWwmRMyspeUtuum?=
 =?us-ascii?Q?pN/SFnkFZPvv7nQEjhUDlRCF0eW7XLemV18lyZWd2/cDTBpjm4ev82JF0K39?=
 =?us-ascii?Q?55tDNoxdb+6LWnSty+4VcKLyp6LSRcMP+lkxaTOIvp2MfRIjrtDcwCfP2Mah?=
 =?us-ascii?Q?vrm2G+aS9dtpxhoiVFLRO0PhzuBGY63KtV40/4AhylBaeZGaOvhYaayKoCss?=
 =?us-ascii?Q?IqVJKqPNhCzhN9VE5fonOWAUjkdmKZACjGdBjwViL1sTNeTGfQq532W+0Id7?=
 =?us-ascii?Q?kBCyzBLMwDUd5jQ+ZrbHBEiK0zW/DKg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 647d8b91-ed98-4386-20c5-08def414ba2f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:59.4855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZO+K7HbOD3841RvBPhyNX6sPbZ7KzfYi+bmxfW7wTqqw3OkA+O8IaGMyZbyuhTq0iNa77gf02r2kV0ID7KLU0TOZ6kDxv0ZgYraRmx+dfJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9228
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sTD18ozE9Q0q3fXwYN+xj+PKp8QVl8CVhcWWwOhkjI=;
 b=4ceQedKhu1dAcUR2ctOHvGemPKAdwDnU7y5T8LidZmxqTPT/3UGTcVaiOqKzGeFgYNHOlXt+G+2CUPIuSW4kY+4J/eTepLmOPKfzLphw4p/RftPAhVMmQd4mEmonA0WPZjPYBpc5KIpaRpErCdz+/NUJPcgq3/ZuNNvxEF8qa8e/HbJuznKL3dcuokdni4gkcLwaRjbAyhKUzpPhi+m+rCNUbP9GWrjinNg9Ix8Yo95Ik+oL1If7XZeqetbeRJE3JZYCTmj16ZIhDrlo12zT1BKFBcraWyOVtItRi29Iv5uy2Kj8bNY142f7POedyR+/20joE4WoIXjghd7RAZw/jg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=4ceQedKh
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

Enable MDIO_AIROHA in the default config.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7583_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7583_evb_defconfig b/configs/an7583_evb_defconfig
index 8b076c1cfe5..08bcbd52c99 100644
--- a/configs/an7583_evb_defconfig
+++ b/configs/an7583_evb_defconfig
@@ -65,6 +65,7 @@ CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_DM_MDIO=y
+CONFIG_MDIO_AIROHA=y
 CONFIG_PCS_AIROHA_AN7583=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PHY=y
-- 
2.53.0

