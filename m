Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F209C5AC82
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 23:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9DE680FC6;
	Thu,  6 Aug 2026 23:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3S_ne6c06_sc; Thu,  6 Aug 2026 23:45:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C31AE80FAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786059900;
	bh=Sr5YYfCmuV6nFQ9rsjoDauFurXJs9bYRS+D93E6czEU=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=nDXyd61r9Y76sbxYirUWr0znpvUzrNE1ZDqtZm+EJ2s7+73Cp/y4dKnozPbRs/0qN
	 0dKS3R4ZqpiWQk8wXuprAUL5QASKoInB1CjVjY7S6ppQbGzKJlINcsxYy31z6Jfsts
	 2uxXNyf8Q40I6fYYs1IgSP0g+M0IHOGbusVcaoVOY7a7zIR6fj+1qvTN8MxiQqzO00
	 fM7GDdyANvOA6cTAeA4D6uta3AyZd8L+sEUHX75gSbKu7tZCvh+DkNbDRu1jUNYk+e
	 re+AU8AGPgfEqPtUCyeRCwCot03KuMKB1Jn3kkNdn7Pm3p6BJEFZwf54gxMWKz6quN
	 Uy4GSI/J2Uxew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C31AE80FAD;
	Thu,  6 Aug 2026 23:45:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4087A218
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3247880F9E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z-le-baDfzqA for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4832B80F87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4832B80F87
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4832B80F87
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 23:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3txzw/yEIecZhsaCy+SzsBwMLp7lk5UofTizXctX4ESpYAeRxgf9Y8087ch+1/7oy8qUYtul8UB/yxw7AEzwmepk1zWO2vwW1Av65FRcg7FOgPhHiQorJFA3h4jgsYLn1LFCNlacWeHrfaeV/Ax8HNai7QoU8DXd5juJfGrPq0CPAe8YnJwFuya8bNDgigc5ub2xaXzd7Oqode6v6s5qf8k9beCWXPNJlwU7+cwvBmSY9WkjoYxTFC2mxPw3MZSp2+BKZY3Y3bYuKo3fWQmsj1txg094Cb4gIc3K9GAONmBUC9lJCb/XGnODuSlFenSTzE65lzmDWlSaGllEHybSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr5YYfCmuV6nFQ9rsjoDauFurXJs9bYRS+D93E6czEU=;
 b=NW/u2+LzS0e09Pe0/NjRJBuBHOqyx1zuhymqYDSEYr+SHgLE+FH8uu553UAIgt09Blx33rfUNb+8rTrqH7A/QRihjQDqQsesfin+/rSf0Qqpikc4gsZxFbgZTgzMXDX7MQoys9dMvfl8tlZnbO+n7ECUAG+9eQM4g/ucgMYZ1UWxbHaCimMfz4iKVisgRj5a/6vM5YKRPhTEruyKiFCxKiwmueZsMZ8U1rGXXf3JbeEUsURTQLCgJfNIwXYJkeDJo3iZBsCHbaO/dAC9YM9563uANTrNA07REZ0JDYV9gJTPEKEE7c0H2MZgwhQBCWHd/fnXB17l4KrywpjFTqe+yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PAVPR08MB9530.eurprd08.prod.outlook.com (2603:10a6:102:314::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 23:44:39 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 23:44:39 +0000
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Sumit Garg <sumit.garg@kernel.org>, Anshul Dalal <anshuld@ti.com>,
 Wayen Yan <win847@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 00/16] arm: airoha: add AN7583 SoC support
Date: Fri,  7 Aug 2026 02:44:16 +0300
Message-ID: <20260806234432.4098414-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF0001DC42.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2fa) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PAVPR08MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2b98fc-0816-4edc-e8f9-08def414ae57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|52116014|376014|1800799024|921020|38350700014|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 99JhNAIsCb3XOG0sruyJwFRwDIUfZogVuzbGxotEeV6HLhsSikp7R5meiL1y7SQGOZjHqTC8Adecq9aqxsHkzt1tDqvpUZXHyQ92v/uCYQ/hJPIOjvd2YFk/T1Bo5CzQrG858+jolNGHIW9I3NAxDFZ6ptt0vB8swsnWFt9wgpg0xTBQ4Q0Jx0kuM5zG73FpH21xWEh0VcjobV05WbT+tCuPx6t7G3r86fq3+ykVTJ1ioOkPSSOwOjpWVcs7SCKNGDvBnPnCJ6/RxQSHsiPU5uqwKNJqkNDQp7wYErcpzNu1FzuUifZlGrIQN12CZ+2bjdBHl+RflSXfU489WRHPjU5eBisXYE/T3yldPt6nVQR9HPq8X/XmjsvaIPD/t4mcVQLOSMY8jqSvxOYSgjP7eMSn/8nbRrQYAA1W00YeKK7cOvdR8UytW7V+HkZkGwY0v0JwW9vDkIusrLL4Qkk+sivbkTC7/v31fktg9IlL54cWPKfLuhlqz1K/aB4OHjz2ozzV+NFNfp1/muXwzSNH2zWEmZ7/sbnY85KmqAqdt9Gln9xeo2eSyCUCEleRSwiwY8SoYKsWPBLg+NUV5FyL+MXTvK+xb4nTmW8ahkrQpXE0UgbPIjOf64nUuhMm0KQtSkryii+wFuShDzSRVtqr+kJCqnkf6MRTy3gR7ILTozojZJoUc0lSp9whuo4HoMIZMnbxHGj2dKb97L5n5wYsh0olaR7MQiIMPA7wKSQPnnE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pl81fVHva67cZV4gNgRZjlyxZKHk6rsvQISiDtgIKjcZlBbxepW9GAxXmqpl?=
 =?us-ascii?Q?av9e3GGuGqWrWlXySXla2UQYdnneNSPaG2DQGYQ28pZ7+8xBF3cwKI1UplbC?=
 =?us-ascii?Q?FPC358ZOIpV5Eu0AQA0cepd7LTLiKI6HQ6PyuhD1ZUxWZTQ/d8jUv8NzmZIx?=
 =?us-ascii?Q?D6uAUL78FzyFspXxqN6NMV9MS4Ir3mlU7+QssOaOtOtrcVmr94HRog3ZdgJ7?=
 =?us-ascii?Q?PXgI08IyjR3i0giEXo5F8dchP1vL8Qu3Vcqm2ksUybT1b0HNabXSX1Ls18J9?=
 =?us-ascii?Q?WqA7ZOcfir7gqhFbPuv3F9W6g1P0+TKBZIKoDA5/pp3v+n79h8wHar07ozfs?=
 =?us-ascii?Q?8Nz3qbY1Dj/QtAW5ryI2nKLSe+PIclDRW2jePkJvef9HxuuEBFH1Js4hoZKZ?=
 =?us-ascii?Q?bbTqSoZZvY4nOg4Uc7y3xK1PnMGbsaB7qIJq4lOIwuncp9ETqcemx1SACkB7?=
 =?us-ascii?Q?yDfy6MsFmE/oDDbHNJ+8of4ajdAyrhaKRgt9GZbSINgopCW3q23G/Fy1KSx6?=
 =?us-ascii?Q?GjpB7CVBliBDYbWtjRcMD9fziPAsguO6w3vO284luww4PLD5HK/kqGlpJ5V1?=
 =?us-ascii?Q?L1QYh/ERnj5GJmGwavBWa1pngon+gcb3HEbI+wP71F1hUNCqjcZIy8yFXXP/?=
 =?us-ascii?Q?EkMG/KQ+XRruYJFcHDvIP1FGaEaMxOSthRQkmML7j+0Gg3KjqPhtMvBLzKFS?=
 =?us-ascii?Q?kLVVSzQ291skM/lIjkmV+UeZKG3EYiv7aPvylab0A9XsQ22y2eMTUpWwMkUA?=
 =?us-ascii?Q?EXDJTFbxUQ+fgZq0BXT+I7DMsV4gitvhDJ48M1cxTI3CA2L4M8Jd8zx5wZqF?=
 =?us-ascii?Q?wbmmt59UAL1RML5r88S5LboPoWVP0IcquS9SnznmNS+ARS3OCdbBLcxSUdDe?=
 =?us-ascii?Q?wZho176/59qbcFUNIgJtBpuDvAH2OMSWHpUvXmZkdzsBXYwhglHU65D+yVQ+?=
 =?us-ascii?Q?Z9vsVGm0gw0BlCba+vCkv20cIhXcHHzYDrrGGJEGjTwsdBOMnJEyOT3whbX9?=
 =?us-ascii?Q?PA6rmHlwcsfUTxJrbWXQq9V2psx6w2isYNCuhKLQdZffeBIwf1XEw9LMHEfg?=
 =?us-ascii?Q?+S9SueFNOHCBC3Go7rKO0BsapK9KhdR/D1gVfEvSgbzZi1He7BAAjOGjM34C?=
 =?us-ascii?Q?uWiUalOIjYoT1AhqfekP5ipTyd8x3Nztw6i/hgiqUdQ0UdKB/TosKdnZ4xYb?=
 =?us-ascii?Q?xcXIyKt9GkwC056tSr0/hRwConmWzqM4apK6qzqLzIVuMOi3Z8nCZGmQCOKH?=
 =?us-ascii?Q?C4hnFQXnMVGydiz/+yXAFfYlxL69iPYOffs1KBgoqi4PvkbsGoRO84pMzSke?=
 =?us-ascii?Q?L1NoU3aCJnKwpCKMtePrT8ScdTJlV8JKnma6KHlHWxkkONvZ5xTiCfPG7En9?=
 =?us-ascii?Q?yATflyJ4iGMFR8NFcrdhkJyqhjJyWnUa2ANkoVem+OqO7O2RD+c94JsLDVqm?=
 =?us-ascii?Q?8JIIYRK1mmQGovzW612cv54znQ/RodLsvQLQEwc88KdPHyxCJMNyPZejuTav?=
 =?us-ascii?Q?p5+HDZx2CuoNYBzqvceIrw7JUbU4AymQDn5nimRPguyRXWWk4iRBoKUyPwbh?=
 =?us-ascii?Q?PcrNPuAcQj+bb+qqWvQqukB8sRpgL21paWzdC1Nkj5LleNNMwlp7X2WQ/CT3?=
 =?us-ascii?Q?QCPYHu4BjeQ2MT5m9YSGJP++pL5HAli7TUpJlK/XbqGLs0CBg73hTGrnNJvt?=
 =?us-ascii?Q?gPyia3JNETOcO6UfM+rr5f9hpCaQc3VPb5MNLEDRrcqDYfQPMKoSQRr7F+dK?=
 =?us-ascii?Q?9yTHIr5lnUh0P/Kj3UdZtuG1XnjQjec=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2b98fc-0816-4edc-e8f9-08def414ae57
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 23:44:39.6245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erlXxjLoq32A4V9fXLT205EcwFgYfvNEJPtfWJBgt1cHC1xquRs2qofd+7rngbXAwfu42q4d/9yQb/rccSviQSB7UoHu1uKZviX3VYKBEf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9530
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr5YYfCmuV6nFQ9rsjoDauFurXJs9bYRS+D93E6czEU=;
 b=2YAdbQH+abrbQeaD2r+OxOKdwErFmVe99ykPoZClbo3f4IzI+qg8bvt21YdKA4D2sRmFjwjEP+9pj3x3zF1D9tIYuV76+Et/KtrGoYZKFa/2vNNK+H/U/IbUY0+lUGRynrkzWX5i4G2aDqseSoSTCRxJJvwS6Mh8VRqq0iupFUu+5G8pZiXSYhIW9/GoCAgGHGWbfsnwv7G6yP0NsfplDaYzccHaiLNfdr8F1Tiz96RDd07FeLW5aVjjgr9N/o1EcsjQwyH2JsESAK3BSXYUBEUj0VX6lRxLPYoZze3qg1adKwte1uedzX8+TNljIMWSfjR18/45UsRGmvKOZE1M2Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=iopsys.eu
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=2YAdbQH+
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

This patch series adds AN7583 SoC support. It is based on u-boot patches
of Christian Marangi airoha openwrt branch

  https://github.com/Ansuel/openwrt/commits/main-airoha-6.12/

AN7583 is not included to upstream linux, but actively supported by
upstream openwrt. The patches were adapted for latest U-Boot.

Christian, is there any objections to not include this series
to upstream U-Boot? 

Christian Marangi (12):
  airoha: add support for Airoha AN7583 SoC
  dt-bindings: clock: airoha: Document support for AN7583 clock
  clk: airoha: add support for Airoha AN7583 SoC clock
  reset: airoha: Add support for Airoha AN7583 reset
  net: airoha: add support for Airoha AN7583
  airoha: add Ethernet node in AN7583 dtsi
  airoha: add MMC node for Airoha AN7583
  net: airoha: add support for Airoha AN7583 PCS driver
  airoha: add PCS node for AN7583
  configs: enable PCS for Airoha AN7583
  net: Add support for Airoha AN7583 MDIO Controller
  an7583: enable MDIO_AIROHA by default

Mikhail Kshevetskiy (4):
  arm: airoha: introduce AN7583 helpers to get SCU and CHIP_SCU regmaps
  configs: an7583: add mii/mdio support
  arm: dts: an7583: add mdio child node to switch node
  an7583: fix system controller mdio nodes

 arch/arm/dts/an7583-evb.dts                   |   85 +
 arch/arm/dts/an7583.dtsi                      |  522 ++++
 arch/arm/include/asm/arch-an7583              |    1 +
 arch/arm/mach-airoha/Kconfig                  |   14 +
 arch/arm/mach-airoha/Makefile                 |    1 +
 arch/arm/mach-airoha/an7583/Makefile          |    4 +
 arch/arm/mach-airoha/an7583/init.c            |   66 +
 arch/arm/mach-airoha/an7583/scu-regmap.c      |   34 +
 board/airoha/an7583/MAINTAINERS               |    5 +
 board/airoha/an7583/Makefile                  |    3 +
 board/airoha/an7583/an7583_rfb.c              |   16 +
 configs/an7583_evb_defconfig                  |   83 +
 drivers/clk/airoha/clk-airoha.c               |  158 ++
 drivers/net/Kconfig                           |    7 +
 drivers/net/Makefile                          |    1 +
 drivers/net/airoha/Kconfig                    |    8 +
 drivers/net/airoha/Makefile                   |    1 +
 drivers/net/airoha/pcs-airoha-common.c        |   27 +
 drivers/net/airoha/pcs-airoha.h               |   17 +
 drivers/net/airoha/pcs-an7583.c               | 2202 +++++++++++++++++
 drivers/net/airoha_eth.c                      |   94 +
 drivers/net/mdio-airoha.c                     |  221 ++
 drivers/reset/reset-airoha.c                  |   60 +
 .../include/dt-bindings/clock/en7523-clk.h    |    3 +
 include/configs/an7583.h                      |   19 +
 .../dt-bindings/reset/airoha,an7583-reset.h   |   62 +
 26 files changed, 3714 insertions(+)
 create mode 100644 arch/arm/dts/an7583-evb.dts
 create mode 100644 arch/arm/dts/an7583.dtsi
 create mode 120000 arch/arm/include/asm/arch-an7583
 create mode 100644 arch/arm/mach-airoha/an7583/Makefile
 create mode 100644 arch/arm/mach-airoha/an7583/init.c
 create mode 100644 arch/arm/mach-airoha/an7583/scu-regmap.c
 create mode 100644 board/airoha/an7583/MAINTAINERS
 create mode 100644 board/airoha/an7583/Makefile
 create mode 100644 board/airoha/an7583/an7583_rfb.c
 create mode 100644 configs/an7583_evb_defconfig
 create mode 100644 drivers/net/airoha/pcs-an7583.c
 create mode 100644 drivers/net/mdio-airoha.c
 create mode 100644 include/configs/an7583.h
 create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h

-- 
2.53.0

