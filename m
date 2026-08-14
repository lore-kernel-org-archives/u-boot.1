Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0274AC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 14:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B47F48156B;
	Fri, 14 Aug 2026 14:48:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kt2NkXRQzbRu; Fri, 14 Aug 2026 14:48:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EABF581551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786718901;
	bh=EjmG2rP1N7kGJ6Eyd9SbpFggJwklwGuDOexNHOSpb0o=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cRWQPHrOskSAvxWhAC/xX6NwURi67NZESOVs7xxivUiODgQBH+E1cNXbj/aRag9WF
	 FTMxBxhRPha5rcubL8fUAmNQONKxTtHQynUITm8Y9ESdJlOJ9BFAh32jjdXBxqKa4q
	 TaHptY4EPxcZfVT2CNpjkentyxb4kCdUKskwsm1p30uxueK7XNtkdrKrjl4U+mspYO
	 zt4JhOGp/OJYVOyTvRJtbMiVoolh8O84A7wAtJxtJ8scenXlGJ1ZKy2BYUHvaWhUOG
	 gJ/RFVBL4+CbhNxYdKNXtHp13yrBQ8FQtSq/KnXHLds8P7oQXrOzk1piPKloPfcz9l
	 fKJOPa75WQ5Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EABF581551;
	Fri, 14 Aug 2026 14:48:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E58833B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1092240AA2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3XoctNvfF1y1 for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 14:48:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=boon.khai.ng@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 50DA3400A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50DA3400A4
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50DA3400A4
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:48:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4FMFGMEnenRdCGuTVOhF3gmBsjreDimklP3FxU0pFcTDNcAvldDWutHhvAHWr2gi3s+wWw2NET75w9lPqHQLL6gnsKhV9br+O0KL8isSnZRpCSdrg80xHGYkkgxJdtMjbhpKncpGm9nUqdKcdc/bBf+21Dk4KFLwmQCtLDSazYB6RKVihfQXg3RGvmPC+SZ/TiUG302xKeYZ7pyyVwBZTiXbHSBiirU9eorpO8CcujYnXJJkvIsc7Vvq5QtFJPER7r8DR2/Vxf8I8S/h2rnvfDHmYBPWx14R83K5jUJjKbslNWSORonyJ2UyCK3F0XTdAOosv7IUUH4q4+G0U/CIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjmG2rP1N7kGJ6Eyd9SbpFggJwklwGuDOexNHOSpb0o=;
 b=hBJceP8pFdrqTGfeZ4DxwqM22Rz/ONkFAsyS6tCIwY80ccaftIdy1x/CJwcfb6mrcwjvX5Vd4Z4JSpDR5MGycPsxRzSwNCHlsSMBJwaBxgsJ/m1NV9N5JKAcNst2FBh5v3U3GHWTKr3LZGB1GU4CCOycEUqAAphO+8koWfIiFOlbGNQO44WqcWZss2oqVTdpiIZgUA4iN6fiTBFkevMOvO06XthEa5wNZtlAJO6jte20VadbbyNNn/qAiocqd1ZvHtVBnLjc88GZc/SVPDpGocHgxV5qFPWUWoc8BlAepClf75uhxlFSNQcl0pHOllwwd58JTOwl5y4RFE/eMBJMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by CO1PR03MB7913.namprd03.prod.outlook.com (2603:10b6:303:274::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 14:48:11 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 14:48:11 +0000
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>, Brian Sune <briansune@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Subject: [PATCH v1 2/2] configs: agilex: enable FPGA Partial Reconfiguration
 command
Date: Fri, 14 Aug 2026 22:47:47 +0800
Message-ID: <20260814144747.12988-2-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260814144747.12988-1-boon.khai.ng@altera.com>
References: <20260814144747.12988-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::22) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|CO1PR03MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 057508a0-e400-47f9-dffd-08defa130f97
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|6133799003|11063799006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NO3oW2V8+KCK9yTG8a+7iIh9nbW0UST2B0qQbMXGEzFj8eL41E4hMowRO31k8qPpAdgye3rP7YfEaKNqvLGXvRRTXU/Gme9RiJKVYz2urUhs2Sy8Gu4L4GugP+F6OEdmleKvNe6fA+tpO2dzsBVs3ZLPAuHnFzczamZo4thkiwMhsGShrflrWAIAc4VVZR701Sx/WT0nKMcY4zr4rWZZL7FH+Ovq6getoZa0W2rcstyHOjxsukA3e0GnxHMVpFbuWnzv3is/d0ciukbbElNXJgzkiqAHrgf0/pNOlF/8HDBdQ5CF+kio5cC4U/aiO0sFfiSGojgmG+O9Po3syfAUZT1V80vsIVohjwNENU/BbXZCIVfxGKsp+jv/q4SEo0TtrYIcOL+juMeE3bspavUC7hvQwazTqAC8I1TvHuiEY1S3A8CqjCDctgw0YHG58vziD8AlycJxEY89mmL0rVpCyJMXDnFloLC/vYEiYO7G0W9F5MB0thbqRDZDagwZgzR0JBW9xLTHgW+mlhOwiCCbuhYbmyZMCk056o64K5acurM4FiChFQ9Xp3Um18Kb7LJOXPH45mVVwVCMyF2mF8gc7jPt2SwbiehMvRHWSSb1hpzu7NZMhuqHOm0XVq4m0C/e5VcRp+8WpAyxa1Y7ZwqCNlvMaOu3QZeym3/UZP2/TaQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(6133799003)(11063799006)(55112099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/h7dYsjubyrXQtVHlbv0OKkbA1zJh1tudgbGqTg1JN4QSsTFQJCO5WWKZjGT?=
 =?us-ascii?Q?BSj3r0YDHQg2w3pljHJVkDIaA8vkEkSQX6a4gQDu8SKBFBSb5XFJpwL4YObq?=
 =?us-ascii?Q?A4+wMNNRZdAj/9HGSFtlFoGlP2epS6Hd2uiHiLAwTr67TyjsaHbMyHrz871d?=
 =?us-ascii?Q?jf1OPTz4OU3iV4zBIksf8FDNlI/KDo8Ez+Lk4y1suI9rjtM5uoCZ2NSncEIa?=
 =?us-ascii?Q?0Awe34POLhnxBTfkooBBGCxfxNhu+o+HIvVbV/OPXLFkDebH+V5ZzpUqen3v?=
 =?us-ascii?Q?c3YHnvGSaOx05m7asbnt8SnCBaLs49n+lSrO55pAzGpQJPO4TD6iGi0Fw94S?=
 =?us-ascii?Q?ojBWi6E4+aYeJQRFuYpeOwAF17vWL9ZSpx4B90qk4yZ4Y0ObmkTZ3dkrK8z4?=
 =?us-ascii?Q?uBHhH+FdOhrDuXsBFBZZDvdVwDdigXmJZUDPnGfZvURt6JAcxf/Qn1atwzom?=
 =?us-ascii?Q?XMCIhq2RdrkptC6a7nLkmFrUNf12qKiS+fLe1r3wzzDjn1mV8neiWpN5S2up?=
 =?us-ascii?Q?gWC/NYhKCdU6paPfYa4E0Mbygf/aL1XgorMwwhRENC3rl1vYN4WqQ5OuJYQk?=
 =?us-ascii?Q?0iQDC/iYO+NWCM/suL2acnvJKKjU9H/bGAEIPoqcNAEz/fCId3bk5HDONH+Q?=
 =?us-ascii?Q?Up2FaFmNCW8dEXaTU099igc/jZ5UcZJ+sUaBP907cWBnsjA074uQ8NNhCo60?=
 =?us-ascii?Q?FX+BMHGnuWHhtrp30cPFX1T+zLtmygBDQMA8rJc59LSiMiTzP9QdR1QcAouO?=
 =?us-ascii?Q?j80SiNODfX1hWsyAPIz3xeQ4W+CAxmhcwr4LzF+CKMgc/tybV/HgSGb2AgiX?=
 =?us-ascii?Q?OXDNQSyPmMwHk1PCTfaZob39g0lOtq+vlJm09tVDW7t12jNaHPKJsLAwyabZ?=
 =?us-ascii?Q?JalH7DogaK5+710U+qwv18muNTUBqnJgDsZ/36yZBhpfQfRq+I/qM45d6Jsu?=
 =?us-ascii?Q?jqVfGfWIwK2iJIxx1FQW9Pm0WK7559DyshXQmUsY0gXm/yxNR90kPXXDU2g4?=
 =?us-ascii?Q?JGfODAgfqyPYm63Hsg4ptag4mV3NfcLqFNbs7HnUsINKOX1FjGNwAcroaka7?=
 =?us-ascii?Q?Cd1BrzusKcFjLPTx9+TUBlgBDw4uLZ1oCt2gIRCCLPVL0I/D90uUA5uWeG1H?=
 =?us-ascii?Q?MtZ807wXsXxhBxWMCcD3tGAlwLt2Lf66IOHeK1CaCWuvdtDKdatu4VCk3gLv?=
 =?us-ascii?Q?hOltE05zSHo8kpby4rJaFwjglkwaRKDwU70t6Gx8S2iYwkwZHLNtzDbLRwo4?=
 =?us-ascii?Q?9gvvynRbNldQAW8A7iJ7T3Ql2A5FrWPCzB0Ok6IxAFB4T+204jyzlsNIfT3K?=
 =?us-ascii?Q?xjcs9nBAzQ9EiEyNo6BaLHfcY+H9OcObv5bu/C1fN+gK7UBYq4qb38bPsMqW?=
 =?us-ascii?Q?B/ZsFTSjteVD5UNOIsRUs6BxfjQLi5r1Re2fgjXbV27zvgrmGXcIZgcuOrJ6?=
 =?us-ascii?Q?gS5vU0M10mrkNeYfhR2mhB2fBwaGLSPws5a3b8L7XLtur+IhseChOFeAgabZ?=
 =?us-ascii?Q?BNb5/t8Je39ogTAGYL29ahG+3EQZUfIMeKV7knMCoVA5KUo6IQzO1//jJzD8?=
 =?us-ascii?Q?VyhE+PbH1NUAb8qQ3XxbsUtArArcuISgDGS5UTip77kLGXv+5ZmbyHlKEkQO?=
 =?us-ascii?Q?ggLugEFWpwE65TA5DKSkRUU0zrQJWSKl8TwocNDIjux5LS3NrJnfTw8fS6uo?=
 =?us-ascii?Q?W42cORtf+dOxtvrGoJ9f2qqRWkVoo/DrFyNLUR961YuOmYZC4ygkLr/bSxet?=
 =?us-ascii?Q?MAkAwOEemQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057508a0-e400-47f9-dffd-08defa130f97
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 14:48:11.1945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCbYXLr1N6Sw0VUTNkK2U0dAEXwbu4WQaMoe8yr3mk45FyYkIl/7DsKQPdVXSHkGTi73Gy1vHTCtIJoAPcyKIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7913
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
From: Boon Khai Ng via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Boon Khai Ng <boon.khai.ng@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable config to support FPGA Partial Reconfiguration in agilex.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 configs/socfpga_agilex_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
index ba8dc821add..660cb9ca391 100644
--- a/configs/socfpga_agilex_defconfig
+++ b/configs/socfpga_agilex_defconfig
@@ -67,6 +67,7 @@ CONFIG_ENV_UBI_VOLUME="env"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_ALTERA_SDRAM=y
+CONFIG_FPGA_ALTERA_PR=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
-- 
2.43.7

