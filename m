Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D17CC61DFD
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 08:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E95C080F76;
	Wed,  2 Sep 2026 08:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qSL_DVUvpGh2; Wed,  2 Sep 2026 08:53:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788339228;
	bh=DOlqBpWgueXbfr6d7mczjBpvMpddtssHASAXGumaWjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qE5MQYihLroqMigHAsw/5pN81XK/zuC44yWFLnXBo39rtTNUWIIcFOq5/SS/N+3eW
	 HOQtXDwePYdu3k3f8z/1STk69Q1If+FCLKDGgmawI1t2VmBLvsX8hNzaDOHJO4Xnfb
	 JHej+q5vSz8rTJ6WkFKWQ3h0ZpjddrZ8ViXJDb25VR6QFgGAe7Xr3U9Kq1TqqF47ox
	 eJZNgJL0ypivncvbrpwlkCRB2MvBfix69+EZUUFkgqyD7qxbOv1A8dX9R6Tv2Is2xh
	 xiqIyoQALAR6yf70A1BoigUuER5K9omEymwJvT5/kTk05t8S7L9GaVE+gBQ2v8rdrG
	 45cJ+QO88bTVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 733B880F7F;
	Wed,  2 Sep 2026 08:53:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01212127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E7E384031F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L36-wRU_Ar8x for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 08:53:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=FSYiM29q
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF3C740310
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 08:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ik3tpekRlLAYbVCZ7DhEp2Y+bmSPam6zHJVxBAk3CrgvJqvg1xrwLs6FwU8uyNyBFXiWyZNpCOci7SYAltDsXJIq+M6VE/8wgtH5NhD14AdNqxvOFlNmxpoYv1105O/WLN5k/TVAG0zqZmey669wnUAmHrBF3xmZZZEfUMUTvq5jpS8jrfeGHWg2MoaBeX/n0vyAJjf/QMxfR1V6fGct2iQFTSrKrMX/Fg0rhbbn6SJMeIYeli8EKqxqEOxGCSskD8muANIjI7yMz12LfhcvFmuKOwnRaT2z9nRcHFuO04Vwd3QfUJt2az9uawI7VM5tfxEOe8OL4iBxMtD0iw28nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOlqBpWgueXbfr6d7mczjBpvMpddtssHASAXGumaWjI=;
 b=PqWUQU67kJz7X6BG6gNFXF5tGh8YVDJhMeIuojSpUsnzbj1HmE7XPBt4Lh/b82s/A/7TVhWYPJx9Q0p/SSlqjmt5VovSQkCXYhXqn4BYQfhyqTFr74ir0y7cIfU5E32D4BnIIr0+nMGut/vyrewMk2+rgmvqZiEL93Sf0zHB1pPHCDRC3BzjQeD3/Jwr3bwklQfcacrSL4LZZGevZyCPHuxJjpLQ+5N7ryKnkLX7/Q1qHrVgzh7rRYHgjkSroO7qGUIwRb8xUti2rJuVjIfPL1eSipDRypszi9jtjGfc9kgsU83ITcuIbxWFoafVcIDiR9WiQGSWFvuEGAqWVt4IOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOlqBpWgueXbfr6d7mczjBpvMpddtssHASAXGumaWjI=;
 b=FSYiM29qvD6H4mIeVESw2a5B+7ydqcslPI8CRj2B+TovT8xarKFbjFR3V0fY7JY01873DoXNVO5EJpWeSeXxeEJw4N8uUJjkVB8GR80Br3HvArx22ppF9E2yIXjtHW3IcibT7g+3X16POj97PfO4kfMQbfJpIDUAHdGHAKqViuJCh2+0SOBJ1FexEZAFQECmQmU0jbcuFZECMwsnMdbGpjuI77z717o70We34yo/AKoa7oISsiWcY6BvqfuAvvISDkY6HRjqLiuFAmW356Ax+u4vyvG4KeSbg5fj4R1MVHZdkRk3me5sziBwApyZKz/i+9SIzuCOLwfcw93jqybOlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV2PR08MB11739.eurprd08.prod.outlook.com (2603:10a6:150:327::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 08:53:32 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 08:53:32 +0000
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
Subject: [PATCH v2 04/16] clk: airoha: add support for Airoha AN7583 SoC clock
Date: Wed,  2 Sep 2026 11:52:59 +0300
Message-ID: <20260902085311.1550804-5-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: 35f9bf11-e08d-4681-7be4-08df08cfaa69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|52116014|1800799024|23010399003|10067099003|11063799006|56012099006|921020|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: h1QQF33uhjmslGwxoE5zKoHY1wKB1JOMwuyo6GUdnEnHvXD27hMcyszSLCyXZb+Ri95cal2mbeLEcBguM/563bMmzzGTXT92rMu3pLJWe1lI9+BnI43eoKejhR8Iqfz0HTVxd6Kctgww9mHkePvzESgM+JQeNk0VywPpfOuAEMndWrg7NjPT2HY3KqIu+1cEd9KIBZ4IVNm8aJy4a4lXWYlHlRVlp5yWmXceOxEjbrarjjmlirCO7xCHG/6EncV+iplJx2A6wD8vDHkJ5CBwoEs4F1rpv33j/QwhwmK7cTWLxexi9PseSKRzGDMhmN/eC8lr0PbrOaLNh24EWlXSdtLvoqUAWAxrCiktJwO0afQlNCGkDiJC3exsYSCYVLDXA9govQu3H8x4CUCwSEc7a+YrU2T7PSOvq0ujVEpk/CVQbt6TEtZZt0lSCKXDhaPndeVEOTQdAI8lECC4HjyI9UqM3OKV8ZycWFQI6kF9uvpAjcgpIWDf9x3/EzZ7epIkSumeDBumXB3MUkPtu34Ce9TshnB/vRFXbI8UuKW+TKBkdRye9d7V6kF+Q0nhPQ9ZtSEkrLLKK03jFxu44/qlvfhSqGtM2NyHL+fyfZDlOYFqTP5ddqQfT4NEYVCaTgb8AWHM6ZxklFG6U4HRLwXXCyDtWrzJvqbdugydAwNBN9zszLEJW6gKhfo2UYS4XEiifQSd/Z6udnCA4XI6V0TyW7r7qD0MvsIbgaoFG146PDv0gK5oiDJZXVGgKaKaLdcj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(921020)(38350700014)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oidKHHuG8zVT0rYP0FByiix6u1vmEN/z5tX5/sgnQwoDyOj+M4oDZHOrptqG?=
 =?us-ascii?Q?IPKSqYsjLlZfBBm7nHikXUrS3dVnrz3A2OWEZEmynYSLUhNxvpZzJvMJKG2q?=
 =?us-ascii?Q?VPRxlHVq5QJ+Qqe2mjUYzLmDxk+2OLVBLlrD0ehNkj+5VE6g2abNOUuHDDFP?=
 =?us-ascii?Q?9qO9xnFMnBzvDjsGey/sipdvct2aO9iZo6zk775O4Cz3cUDXUxfkJU37j+9S?=
 =?us-ascii?Q?WhLRyfM6Zm0V8zdT+v7+LxfpyLFcxw0j2QNudi7PcyOf5y7OHEKwt5xoY35E?=
 =?us-ascii?Q?xAuMXuKdnlwUpx9kFLflWRwKpU/Aug/LXXJTaWsV2aKp17ZpDQ84ds3Il8pE?=
 =?us-ascii?Q?aC7sred+tucRMx8ZnfUIzorGSVv7UlJXPDdXtp9XsqBbU20/mKWZfQ8Qgdra?=
 =?us-ascii?Q?Jf4BnHtSi0kcrFW5vBKwxUWLHhRQV+h7k7SPS5la7gEtqI3p9oMQhNWsEJSS?=
 =?us-ascii?Q?FCsu80M3DGLYoHofgBjHi7tXKAkRUnLHbtuNEVFYNEak0Co1Lsrjf/mCHuE0?=
 =?us-ascii?Q?aRL1ov2ZDP9qjhxbeDP/gQ5/ww7YAgwzdxOv9v1s7t2+gsRkQoALhC6QOlis?=
 =?us-ascii?Q?94uRxrva5rsZT7Famd7c6BgDlpzjEiYeOJ/v0i/jOera3ogp+sa9NCzxsvxU?=
 =?us-ascii?Q?Hq1zaKL7ZjWp+ftxvvuLzG6B2yrLxWx5/nqIGi4bErbVpbSFMXAqXBXsUvuc?=
 =?us-ascii?Q?obkukdJ6kFjMgSNRrH81It3pKBDGvpjNJWVOCnwT4XZIMEo7hp8OsehJUVVy?=
 =?us-ascii?Q?XRhUeZHzQVfDWzcCNMq21vwfhh6PTp/2wddPHOMphoFdJwhCZRUABVrvjyWI?=
 =?us-ascii?Q?TgHiyaE/OQyyNlyupqxk0OgX8rWONEaBX9BczT1b2JNZVTAVNrBNo1/33VHx?=
 =?us-ascii?Q?yahLGd3ZiFkDFdsZbWjqNkrwfIbZjuIx11ia2/Kc17oYnURGK5LdGsbZzs8k?=
 =?us-ascii?Q?juPRYzXuUgDZOVxY6cyM6HAAvLTPe88NU9korHsUfvGSlsTcqKK4/qTsv4qi?=
 =?us-ascii?Q?RLoD9EeJ1QiRsMCacdfTjjuuhD3Q6nuSklvwNKaV5rTYHIIgTxLAsy0ujpim?=
 =?us-ascii?Q?xLEO1jniAgoXQ8uYhNN7Iw9C68VDLrUnmpFvCpGHDDDyQX/V+j5hIQRNlBHp?=
 =?us-ascii?Q?B5hnwKLgdcvWTF92mS+eC9XSczszlKXbW4/6908vHeJ141nV+7n8vkWkGt5z?=
 =?us-ascii?Q?Os4e9WGGqKbGssSEtDuxjky9iR7S0osKThDyGJPFRENVp2yDNnt++tl9kVof?=
 =?us-ascii?Q?MYw+59ANUVCXCa9lvfKNBwT4I+dwrSNGoAIeAIzBNAMnmEgjXSNISLzhVeMX?=
 =?us-ascii?Q?Ajg4y74WBVHsD8cEM8CYhaQdEYMjjt+J/sN5dhCB3tLw4FUydqLcZdcz1Smr?=
 =?us-ascii?Q?rRHIN9ugRK1lZfSy2nUL3TPWWnm3svaXByiMkSAXPU4en0m42Ci3SYAadl9+?=
 =?us-ascii?Q?bxZuhtEyFozT4rxnnj3qhMmVEfz3mi9m+qBNmmOrcgMs/csvAcgVeMNSuBKk?=
 =?us-ascii?Q?nc0AVoemv6SqBnCyOLXqHjHPBHO7V/wyd/4d+EmAnhuY17mGmGco3Y0VOHWz?=
 =?us-ascii?Q?AOPcKSK2OQ4/EDMLwTy9Q4JAsLOwMEQy8WlJj9AIpAZSU2WXMEHeehckAKBD?=
 =?us-ascii?Q?16v5MCRHDrPD/lN5JUG9uST5CQhQzVGJ78kQomO0KGPMCaSRhFvKVQQI3Z3X?=
 =?us-ascii?Q?I3lRlHkCW/lFQWhaJ8g/NxrB7vII78gXZpGFcxHaMU5dqRrMho6qpL/aWxBf?=
 =?us-ascii?Q?0tC9JVnDeP5SvUpDJL7rXX1ju9V6eK8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f9bf11-e08d-4681-7be4-08df08cfaa69
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:53:32.2531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UuFV8QVPuPXXWKwPvUQ+OgHEwtR5tg3nF+jphu3XcVzgqOretFh9j+uolC/QTAkrJitkbD4cFgBdAzsw+8sG2MlNHYkKnrGix8nfGo2pOSI=
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

Add support for Airoha AN7583 SoC clock that implement more base values
for clocks compared to AN7581.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/airoha/clk-airoha.c | 158 ++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/clk/airoha/clk-airoha.c b/drivers/clk/airoha/clk-airoha.c
index 89a8b4cb1cf..23cb04aa5ef 100644
--- a/drivers/clk/airoha/clk-airoha.c
+++ b/drivers/clk/airoha/clk-airoha.c
@@ -36,6 +36,7 @@
 
 #define EN7523_MAX_CLKS			8
 #define EN7581_MAX_CLKS			9
+#define EN7583_MAX_CLKS			11
 
 struct airoha_clk_desc {
 	int id;
@@ -78,6 +79,14 @@ static const u32 bus7581_base[] = { 600000000, 540000000 };
 static const u32 npu7581_base[] = { 800000000, 750000000, 720000000, 600000000 };
 static const u32 crypto_base[] = { 540000000, 480000000 };
 static const u32 emmc7581_base[] = { 200000000, 150000000 };
+/* AN7583 */
+static const u32 gsw7583_base[] = { 540672000, 270336000, 400000000, 200000000 };
+static const u32 emi7583_base[] = { 540672000, 480000000, 400000000, 300000000 };
+static const u32 bus7583_base[] = { 600000000, 540672000, 480000000, 400000000 };
+static const u32 spi7583_base[] = { 400000000, 12500000 };
+static const u32 npu7583_base[] = { 666000000, 800000000, 720000000, 600000000 };
+static const u32 crypto7583_base[] = { 540672000, 400000000 };
+static const u32 emmc7583_base[] = { 150000000, 200000000 };
 
 static const struct airoha_clk_desc en7523_base_clks[EN7523_MAX_CLKS] = {
 	[EN7523_CLK_GSW] = {
@@ -293,6 +302,147 @@ static const struct airoha_clk_desc en7581_base_clks[EN7581_MAX_CLKS] = {
 	}
 };
 
+static const struct airoha_clk_desc an7583_base_clks[EN7583_MAX_CLKS] = {
+	[EN7523_CLK_GSW] = {
+		.id = EN7523_CLK_GSW,
+		.name = "gsw",
+
+		.base_reg = REG_GSW_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = gsw7583_base,
+		.n_base_values = ARRAY_SIZE(gsw7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_EMI] = {
+		.id = EN7523_CLK_EMI,
+		.name = "emi",
+
+		.base_reg = REG_EMI_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = emi7583_base,
+		.n_base_values = ARRAY_SIZE(emi7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_BUS] = {
+		.id = EN7523_CLK_BUS,
+		.name = "bus",
+
+		.base_reg = REG_BUS_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 8,
+		.base_values = bus7583_base,
+		.n_base_values = ARRAY_SIZE(bus7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_SLIC] = {
+		.id = EN7523_CLK_SLIC,
+		.name = "slic",
+
+		.base_reg = REG_SPI_CLK_FREQ_SEL,
+		.base_bits = 1,
+		.base_shift = 1,
+		.base_values = slic_base,
+		.n_base_values = ARRAY_SIZE(slic_base),
+
+		.div_reg = REG_SPI_CLK_DIV_SEL,
+		.div_bits = 5,
+		.div_shift = 24,
+		.div_val0 = 20,
+		.div_step = 2,
+	},
+	[EN7523_CLK_SPI] = {
+		.id = EN7523_CLK_SPI,
+		.name = "spi",
+
+		.base_reg = REG_SPI_CLK_FREQ_SEL,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = spi7583_base,
+		.n_base_values = ARRAY_SIZE(spi7583_base),
+
+		.div_reg = REG_SPI_CLK_DIV_SEL,
+		.div_bits = 5,
+		.div_shift = 8,
+		.div_val0 = 40,
+		.div_step = 2,
+	},
+	[EN7523_CLK_NPU] = {
+		.id = EN7523_CLK_NPU,
+		.name = "npu",
+
+		.base_reg = REG_NPU_CLK_DIV_SEL,
+		.base_bits = 2,
+		.base_shift = 9,
+		.base_values = npu7583_base,
+		.n_base_values = ARRAY_SIZE(npu7583_base),
+
+		.div_bits = 3,
+		.div_shift = 0,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[EN7523_CLK_CRYPTO] = {
+		.id = EN7523_CLK_CRYPTO,
+		.name = "crypto",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+		.base_bits = 1,
+		.base_shift = 0,
+		.base_values = crypto7583_base,
+		.n_base_values = ARRAY_SIZE(crypto7583_base),
+	},
+	[EN7581_CLK_EMMC] = {
+		.id = EN7581_CLK_EMMC,
+		.name = "emmc",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+		.base_bits = 1,
+		.base_shift = 13,
+		.base_values = emmc7583_base,
+		.n_base_values = ARRAY_SIZE(emmc7583_base),
+	},
+	[AN7583_CLK_MDIO0] = {
+		.id = AN7583_CLK_MDIO0,
+		.name = "mdio0",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+
+		.base_value = 25000000,
+
+		.div_bits = 4,
+		.div_shift = 15,
+		.div_step = 1,
+		.div_offset = 1,
+	},
+	[AN7583_CLK_MDIO1] = {
+		.id = AN7583_CLK_MDIO1,
+		.name = "mdio1",
+
+		.base_reg = REG_CRYPTO_CLKSRC2,
+
+		.base_value = 25000000,
+
+		.div_bits = 4,
+		.div_shift = 19,
+		.div_step = 1,
+		.div_offset = 1,
+	}
+};
+
 static u32 airoha_clk_get_base_rate(const struct airoha_clk_desc *desc, u32 val)
 {
 	if (!desc->base_bits)
@@ -542,6 +692,11 @@ static const struct airoha_clk_soc_data en7581_data = {
 	.descs = en7581_base_clks,
 };
 
+static const struct airoha_clk_soc_data an7583_data = {
+	.num_clocks = ARRAY_SIZE(an7583_base_clks),
+	.descs = an7583_base_clks,
+};
+
 static const struct udevice_id airoha_clk_ids[] = {
 	{ .compatible = "airoha,en7523-scu",
 	  .data = (ulong)&en7523_data,
@@ -549,6 +704,9 @@ static const struct udevice_id airoha_clk_ids[] = {
 	{ .compatible = "airoha,en7581-scu",
 	  .data = (ulong)&en7581_data,
 	},
+	{ .compatible = "airoha,an7583-scu",
+	  .data = (ulong)&an7583_data,
+	},
 	{ }
 };
 
-- 
2.53.0

