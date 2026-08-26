Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846DFC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 06:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46FDB80B8C;
	Wed, 26 Aug 2026 06:32:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oTJ-PfCCbWzx; Wed, 26 Aug 2026 06:32:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787725950;
	bh=xdjTUAHNZbGRhJa73yphnCvCAtujAmCupvJNGucgksw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0tEsQvTVBZeGfmeGcqjo0AFKViunb6p+r6IHiAdrnj+Nbu28Ti0z5RK+M7XIyKHEx
	 MOtqMeJLbBjgcJa48Z8Wu71uFujLX5vb/rnDj0yf97oTi/VUZxhJvVWu6IccOU5iii
	 hT2lLlo/LOn/xi6Zb62auNoDGNmII8LaV06K1e2Dx5IllwVTMyoPfLmdn2hk1bnPj/
	 m/YQ0SwSmcSwXCCNW197SMxOsDrsRR/MKYpgFDVhzbckL+pP7DALHCzsFOAlq/sPkj
	 xUtJct7ohzGVmG6iimDSc8LXROosMNcMOuiPVrrG9YGsT19jvt2rpXhrz6U6XwhUs+
	 dOIoVjo5bbHYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44D7080B6D;
	Wed, 26 Aug 2026 06:32:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AAB6923E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90EFB80B6D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HQmbZdJ9t5XB for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 06:32:27 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fwCIgIgU
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68C3380A80
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXOgkg2mPiTeR00GfazaQ1lyCtAH9N0xzEbQjhCwIuUEdKbfnEW0RpqyLxHTVpL+UO29iJZaGwB3WWHe94hTitQ1b36+6s25uV3m1m3j04xrzB46Pb4/rFc6Wg55fPxRBoUSWIyhzwm+8XvIJwsxqH/nfg9Ntx5bLV2FxbHD3tAaQZYjpUjWzwA4lg9rJuYOI/EqCEq5L8kNxj07rQMhC9931GTeAKopN3y4Vaf5GhDMAJ4cqIoBDzDBnRQG9wawTl2+Ga/J0sCB8YK3z0xTDD1nmQVLmWFFSfBr4QK4XCpbRMA0H7+aYZSiE91DEDn/LjmfaxS8XocRTiGwM3J6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdjTUAHNZbGRhJa73yphnCvCAtujAmCupvJNGucgksw=;
 b=JpkTI48gHhsqaV1uEVNMqwH9FJWxsXM1B2nm2gE7hyjrw+SM6ejuCGrPJD4k8u9LruffXEM8njbINvFH3qqBwqgady5Zjim7NwJ79kuMyLbU2c7c12ZcH+QuLH3gRcwn0rxgoAQQUKuGljszFrfjxt7qF462QcCecMmYGZX3AbBCRS2Amd4sFwwAwlU0FD77e9bul1/+6MnOxdl5QH6PZZ9jdYfe/FGrV+ojqCgF6nc7PmUZLEzBitCyo81pTL3mQJlKPAlicsAjLNMhDgGWDoUZxbyxiXKk/iXT2SbmjUBZD72vbm03Zxeo4CcOyQfov4T0DWdxhj86V7clgGrq7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdjTUAHNZbGRhJa73yphnCvCAtujAmCupvJNGucgksw=;
 b=fwCIgIgULexRz07ISTbF14SWTyyjM6Fn6yxEY7YMHpyWDQJtOZAeRfUjBl6D3VrufDEzF+CXn8z6v6OTTXkK1cAwtY6Cf4lQAaigCRH4lg1bU8fmHHsVcwaIn2/H/+KAzKdeO+zT81C83YKHyssg2CTnWZCGYfPfpDBkvbn+vOG0fPpM7x5o+OGXCb+qz1bOZ1RJ9N+Dx9lZIE9mzF8ZwNzLYtsjfFoySHP6q+B+TjkdywHOTuQZdbWkCyjrVrKRFN7FwIlFTrjLzzEHg8rt4VOd3N6hIlZoSNweuRoxMWYgzlCoEyWjMietz/dVt/EYj3ZAyLoUsZ5SPCeHMZtVkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 06:32:21 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 06:32:21 +0000
Date: Wed, 26 Aug 2026 14:29:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v6 07/13] power: regulator: Add AB8500 AUX3 support
Message-ID: <ao6H5n9rdsFlExjP@nxa18884-linux-1.ap.freescale.net>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
 <20260825-ux500-external-sdcard-v6-7-61446b6c289e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-ux500-external-sdcard-v6-7-61446b6c289e@kernel.org>
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbeb86a-eb86-47f8-2cbb-08df033bc895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|1800799024|376014|10067099003|3023799007|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 6kYPbjjd/jQ/TUIOYH61zqbuqmHV/Y25lvU0Xekj1oaWwD++0z0Jrs8+gglsMHhb93JgLjJKC18Q/PbUa/hY7znBZyHiI+jLIqU9uK2l3mHpcflWV1A5py/QgBybgzNkE0g6VUS9jexa/yZZ8NjZbNMTaYsHn9Ag+GcXMikJlfPU1zd4Y99nawTLO7su09iBp1KkAFysR87h8xWZrI38PkVDG2YNauf9jvtBH1VHhk8lKafzkKMHLeVcZc4wR3js/WrZ4ie36McxKhHPrhn+LmU7DWj/Se0D+UzN13mC1oMZa2FDhN7fTttBugINz0KMW9J4wwLMYV9Nzpl5X4qnP6yyENzs24smwHojGdEpNSd//qSSyyI1QCqcDEl04q1usFtJjO1R7QrYCYFCKWj3pMink8zJ10mBCvKpYDAsaLa7Ewa7D5Zqih3Kr6orO5Io2o+r29mW3O/iM7srH0Ykl3OBPhkaxzM9kWTemOSDOYmvLLZB6wwtRg9z0hxIv/wyw55wbk8WIftRP1X0aoQq0xJMWD+xE/7U8hZNJJ276lv0O0KQMjBmJH4Cwh56Ro7esoxp041Q57ex1q9OyWHfvEnJntzUD+9AdPY4E+o3azWmF0XRhaRyYUL/4S7bKUrK6WMS0EDutDK9UYpLeqCAngU2oCZuY2ehTC2oNSVUmLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qlZYZDkkdOG5XWPQjOo/+/9mrIuq9BIEJZv/CzKudjd16RjRi6R6G7YwSfmF?=
 =?us-ascii?Q?j6n5WbeQDgA90YBb8IpG2uQFGY8FnIcZD4Ddj8SnNc6fssfjG4PL8aGTzH+M?=
 =?us-ascii?Q?f4P2eh+LRJdOAAMvq5p0WQXOSf+CIKs51EnPawv8CMP2/W/hm44MQtyQcOBw?=
 =?us-ascii?Q?CKODq7uTt7ld/tpsXfRCXaVttky+Gz9y/wAZgNYzRickpGwhZyHoQ7DMrzXO?=
 =?us-ascii?Q?4IeDT4EvTcs6lX/LiDtvG6rRYMNN9yDVGd9RH5XuEkNV2HVGpE/U/wUcrUuB?=
 =?us-ascii?Q?pG8PVmY8WGgMxfnMjT6NiS3Q8fenuUAOZBmL4BHhcsYL9ZCaM1T1KzVKFV8x?=
 =?us-ascii?Q?2QFhoMdUYiDXKo0jnm47hOFMBWiaDtOqempEu2Ak91Ig/mSj/BoBJpYilJey?=
 =?us-ascii?Q?TriVVVumwS18uZs2la9i3VTIhDf6uU2X7ipmcfo/KImBdYB6ki6kP9Quz2Od?=
 =?us-ascii?Q?yMPaVhcerG2D0bVy5x//OYDaPf1nc08PHpNZiANJgb7UcTS1Td5gex8h4OjV?=
 =?us-ascii?Q?OYhSPoyJzCmbhXbP6rAwjFZ/O2aWrExWCsanOKHarNZ+isr/ilvnAXY3zRuw?=
 =?us-ascii?Q?EPnU5uvnJ1pZw/+68pLSERFtSrkKy5yko/oonlmeDk0e+e9btdkuQsueA5Fd?=
 =?us-ascii?Q?NjAwxAHIbulg/o3N6DphFDQPoXpyKAWxfXsdkN0MLj09kpcpXpoqD+R7Onv6?=
 =?us-ascii?Q?6Quzkrfq8agB2DnCXcxXkYWl6B20NuZNOPQeeTa8FILH4j/7z6k6Vc3a/62Q?=
 =?us-ascii?Q?xdL0ZHHks4v9EMidwkTIrtV48mD1kPX6P3DQ+gDkTeZxBF03ARsn4Y2BLhuF?=
 =?us-ascii?Q?MytXgP6cZFDtsinVK/vA+Nu2oA7lBggbg8wp3WhZQe9kFTsl8hZBtxOsMBjj?=
 =?us-ascii?Q?br747NgCQbB3Uz6jXK0ONQBYK50+lVOsk0P9zCJl8RqphUJPMN53hkFTrhjS?=
 =?us-ascii?Q?PSdLNrZzhlOKs4Hz9ei4Le1oj+8Do6hG2g2lYUWpex0O1J01ND2BtipaTL/W?=
 =?us-ascii?Q?W53Q1NXsAgMSHehKJxpifCtiybrbQ73iRqcDiRQgdF9iv6uCA/yQ8CeFwyqz?=
 =?us-ascii?Q?veppGyykhTf/1KDNxMgwr8+dqrUFv5Bs6L/4ROhiD3blqdDjS+BTEAIT0j8I?=
 =?us-ascii?Q?ezpuowbcG2xDWzzih0Qt5cJjVbcCXKdf5LZsOV+CnP+kkhTEJ2ESNVBYiw0E?=
 =?us-ascii?Q?/7Bs7e+eJUr8jCKy/AWau9LnglHi1HHUhLoeag4/FTtwlVu+jBQ3+S7NHOF+?=
 =?us-ascii?Q?HBnZFownBt91FrF/UzlZgt/qstLnJkJiCV35qLsK2d57FkE6tG3IWPSz41fa?=
 =?us-ascii?Q?SkJGSOXh/9eNR7pkXWSCfA+2vOp/vzrV9VuPTfhw1JGl7cBmHtWMzQANsWUR?=
 =?us-ascii?Q?SMtZWboRm3aZEtRkSZY0ijfSvKHtTwdu9FeCvF76Zua36Adm0ES1SDb1tvD2?=
 =?us-ascii?Q?qdoSPZBwBKrdMNmOWicI5Qcd2JpSYOaDIRHb0TxLLvMyRr5lpNM/0vtf/OmP?=
 =?us-ascii?Q?OqOZQwByJVU6o1bzXQ5DiFm40z5VNE9w7DNrf+RaS2pznmlatt12Ub64WZ2d?=
 =?us-ascii?Q?oWOMXwOf5FxldeLGRYR9LMKFFPNZYzQ3cvPGYInh9GXL78i8lCs4IPZrMjRD?=
 =?us-ascii?Q?135L2iV+iokJ7GHancpT02V0Elcnw28Ov2R7quXv4sW7jvqjWm4qHue/cU+e?=
 =?us-ascii?Q?8winRpJM50/U7xSqw5VZtIpWqDFnZZzatxEsahZ8N/9AJWGz8nT3i6sqjq4J?=
 =?us-ascii?Q?sQFkhhtCIIB2OngLBxfHr3V801j2fPVkoZoxyiipZlO/fFLBItCw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbeb86a-eb86-47f8-2cbb-08df033bc895
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 06:32:21.4183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u05m4+KjB6H0bgCTV19ZvndRS4TC4hdC7sH1T3LuYSrJ3WFnNNyyFyztV84+KPIR67H/QdLjRp8fQc4x/8kM4JbnsMQYJHAl0A2z6DuQplZTA+bh4H/PqrvQUd9Il1oa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923
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

On Tue, Aug 25, 2026 at 09:04:07PM +0200, Linus Walleij wrote:
>Add regulator support for LDO AUX3 on AB8500 and AB8505 PMICs.
>AUX3 supplies the removable SD card on the upstream Ux500 Samsung
>device trees.
>
>Support the AB8505-specific 3.05 V selector override and clear it after
>programming an ordinary voltage. Treat both normal and low-power modes
>as enabled and select the supported voltage closest to a requested
>target. AB8500 cut 2.0 or later is assumed.
>
>Imply the regulator core for ARCH_U8500 so the driver can instantiate
>from the upstream device trees.
>
>Signed-off-by: Linus Walleij <linusw@kernel.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
