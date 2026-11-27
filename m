Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE4606A321
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tGEyKViK;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MqgxfvuE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C75860AD7;
	Fri, 27 Nov 2026 13:04:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4DmIik-FTj6Z; Fri, 27 Nov 2026 13:04:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 76D0360AE8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795784682;
	b=FLyJszwD8Qn/3tzV4xVkHtISpw1EFkavMXvl3jhCXRgtsU/Ff9Bv8fjJoMq9Fq7p00x+
	 O4ncjPw4tq8sWPTcZxrkA66UGemYaZPHfVSAOiCuTytP4w9/FJMany5uHAD1OAnvGhZDv
	 9B6v6AvEk9jX1vj1hg7Zo179itU99cBOWzc4M+9ib7E9DdT0n3iwrOAG9XzHmUSTe6hqp
	 5z06tlU18F3BOhF26Zx1RgNjCJy3WK46hVnaiRTo2E0vkttgVkcopWzRUJWA4/kON3xO9
	 EBQ9S7dPYvvHnlUkNWv1Xugwk0IbYQTpvHcflps0WD23xBAP3hT9R/0m+tSPex2nCLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795784682;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LRD1dft+N9NP5x/BByRD/a61tDA2JmlBWISKI9Tvnss=;
	b=iyesFME87NJG5XhyaVWQ9LGSvFycUyJGXZb4GnQjb/kBTPNvof6dhluYfZ6LJAlmilHs
	 q+boHn5zeaLOqZUvSO6iHGY0pcfoBK7lGUsxiAGrvbkV6HbFJtaVQ+wMLiuLFWLg2VdF4
	 nwzdZ5cWjrQhVq5DvO/jZ2n/+aZPirmPlLXGK42PzTJi+SQbDourqeiOhypy4wKmEZRjM
	 tRcVkp58uI1GOqy/9ZXyj+dAvjUc7ap1KxPu2agxjteLWs1S79h1bZJuCBVJhBD/nq4cS
	 g2Cx6WPfrUsfAO1C7voRa5CH7PHcYlSD7yNSida68q99nZeTK706mN4SpAUCs2OdXGg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MqgxfvuE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795784682;
	bh=LRD1dft+N9NP5x/BByRD/a61tDA2JmlBWISKI9Tvnss=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tGEyKViKfv/zevvkxbPMdbu3zjjVVlGkcy9Ajv6X6Up1PXm4gCEYH5O3Pgia1Vc0M
	 IzSVZ+ct1zUciJi1UTXd2dv7LRjoFmpjG7F8EP/9Aeb6JPQkYOznUALSHbr5nJd/Su
	 xna+q2v78dTDtIN3xvW9iEY9Q5XYrW7YJLT0JoBlUj2s3VGn47lTRr3HLseh1YI5uc
	 ZY9JWunH0dDYyO0jLOxH75e9meLnY9hyth/0yVOs/41pajESRfTqiI5foQPw1IhtV6
	 YaPgxFXfhv5aatZe6FQbXTpVGTEZf1nuTXBr1TRCvZUujCNeSrIKPdIgw94pxUvi88
	 fKI1Pw5JvrEbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76D0360AE8;
	Fri, 27 Nov 2026 13:04:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CB70D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0151A60AC2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zRwxaVFc3zgy for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:04:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FFAE60B58
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=MqgxfvuE
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FFAE60B58
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRD1dft+N9NP5x/BByRD/a61tDA2JmlBWISKI9Tvnss=;
 b=MqgxfvuEb/WOR0nTyFc5DGWeZR1Kc5JIe2IPvwqIYNpOIYu+195KINlTPmviGChbpV8rVjQ8CWWFQYzoit8NSXI7KUQnTt8FRxxsh1zDPToxbai6qbfAvDLwraUSQNLy7eFzCVS/Ga4lVVFwEkXPi+YZeXA4twMoZLrA87mEcmf/W3rFU1LUcJrNY4XVVpiOKJLDFLlE63IhJIiXPZeXZq1s3HazTjacfHnc+1ggJV7FBXO/g1o56BOqlptDEukJ6vHR+yDz/oLokK7NqNVPygw/vkkx0kgsWq4e6zg85jVI1e4aHBNFsqWpVoVSs3RcFYtBIqlUg0dOtZpT2lbHig==
Received: from BE1P281CA0080.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:78::7) by
 DU0PR10MB6510.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:406::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.6; Fri, 27 Nov 2026 13:04:30 +0000
Received: from WA1PEPF00009B3E.eurprd05.prod.outlook.com
 (2603:10a6:b10:78:cafe::69) by BE1P281CA0080.outlook.office365.com
 (2603:10a6:b10:78::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 13:04:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3E.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:04:28 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:05:13 +0100
Received: from localhost (10.252.12.59) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:04:22 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 27 Nov 2026 14:04:20 +0100
Subject: [PATCH 7/8] configs: stm32mp21: activate CONFIG_RNG_STM32
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-upstream_stm32_rng-v1-7-b8b4a9fdc8a8@foss.st.com>
References: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
In-Reply-To: <20261127-upstream_stm32_rng-v1-0-b8b4a9fdc8a8@foss.st.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 =?utf-8?q?Maxime_M=C3=A9r=C3=A9?= <maxime.mere@foss.st.com>, "Gatien
 Chevallier" <gatien.chevallier@foss.st.com>, Nicolas Le Bayon
 <nicolas.le.bayon@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3E:EE_|DU0PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c96333-5465-4a27-d50f-08df4c86f862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|56012099006|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 7gPWQ86wmxQLyGaA1gqyoM7wMcJjORkjdRzGf6NQ7u2+SwS6auX90rCY8rZ32OfwK5iFDA2p0tw2pjp3Fw6/yXsjduYKaJgztbqfmIlR8YXdpvAnQb4FvLKVd3zM3u91saJIsqyZqDO+XeyxHwS9ESY0+oLbQ0gsF9PZV3NGzRBArfh7s+71P++Exv0yysW1nmRmJQZsvfjEHVn+9tg3X+FyuN0pG7fQwyASDB7X1P0XtXyUk+/wKQsomHHToM45w67Da5WLVxl7npNbYYlFhGRlv3YJKdYFRquJi2+fiV1EiVqOEVpR4U+xm08356fkQn2pyDt+UvA6b2sQVsI7bTFmp47nPNc3W0aciHCtf1JxInff9gGP48GZjQ7tOIokDkxG7HaCtz9FqQNqg7omQ33cK3+5EeKIPlC7G8dGgNhEhGQ4kTQCvUL6oY6cpvlNjzs0t6emRQZroDUei/jQXAkoLCpWSPrGxdEKgAFfRq780ad2sXgcidhvKMrWnQSdEhJ6R8E0pLy5a2QileVSDRv/7/+KwGt3nUTEXzUClzlBdBv5oSFsaxDgB6l3kJA2DdaplvDtOauAUxONc78GZqqWfXGflybSZr+IJW/bE9kxwgESOE/vGTJaQfJW4Uin78s1aD5pvhrpmmEn333+avveiVkdc9y+Wu4bP7lEnaRMwTLuGtDDBIgeKJplYw7X3qa6GpMAH28r+oOv4zpD5w==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QwJbpWeGMUoeHZJIKgra1epyOWhahfitH15DO+vLLBt6vFylGxl3W8Ukh7LQw8kRwq9NWduM9c9oVp/iVWg7WYbMfJPixindEZ/jA7nFwBSgKFvP+evj2DWiJKM8AjIAPjc2Bte+WYoMdDUPJMZ3yOGPVHWDgvJbZ2ra5Zq6Ko4ZAUN6WI8GX2WijuqsdKz1C/rdLWUHayxvm3aApWuab20JVqGbWErLo2PV2I65yq+jZ4Hr74EMrYE00+evePZSH5PojQcSc3vibNszb+649NDp3Whb+uLOjpCq5B8hD7iwWxS0y5XMpXdYoHyyUhJ949KQjQhoNneZWoIqtc4brV7qkfiVV6NLmsMIgp8h4PkgYHqltTdU8IGZ6QxdQJIxx6LuToDmHtdDR3Ml5KOtg3zzU6n75n/3sJDkmJ//LLmptKvjJXIMFBTEwm5j7gR9
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:04:28.5227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c96333-5465-4a27-d50f-08df4c86f862
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF00009B3E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6510
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Activate the support of RNG on STM32MP21 platforms.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 configs/stm32mp21_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/stm32mp21_defconfig b/configs/stm32mp21_defconfig
index 22077e1291b..35b6031d3f8 100644
--- a/configs/stm32mp21_defconfig
+++ b/configs/stm32mp21_defconfig
@@ -68,6 +68,7 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 # CONFIG_STM32MP1_DDR is not set
 CONFIG_DM_RNG=y
+CONFIG_RNG_STM32=y
 CONFIG_SERIAL_RX_BUFFER=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y

-- 
2.43.0

