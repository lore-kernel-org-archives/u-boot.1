Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1100CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 07:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7024F81309;
	Fri, 16 Oct 2026 07:27:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PCxx2iYnDHFr; Fri, 16 Oct 2026 07:27:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 31FF5812E3
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792135654;
	b=s07ZCfi5biCjL8FaWS5SA7eVV21qxEE+s9HcW5mqmjyV3GDQ2i2c1hgPmG35753/oAib
	 vZaVwnC+WpSRdxG0LQqXhaOg1JvII76WFqANtqXqous3xbh96QzSS9SMMzuWqF/T13d5D
	 NVLqonjT1o4hr9O7wz5+QWCHRMa2jjcQPsSCySWN/1oOzxPQJ59orGETU3wcv1l0g6tc3
	 KP6VZrhPOnkK9XeJhtjH8iiPTureX5nyImMHvOrOnjC/WT7qPI/aBqGYTNwHqFa547lbK
	 1blx744VHkRVunLUHoQT7g0YUQV8TDPpAGj5/sBMOy31c1SGDyU4+Sk0gHLzl2FR4NQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792135654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/7Rs61BS4zc+7If28TMp5brzGfHrcSNxbKY1clsCNoI=;
	b=iAvhzFgEez4e0zmJ0BkBlBwTHFGA2XBelx7VHeZCPqSLFzNLC96KB8ZV8JHzRipiNrgc
	 XOQrhEqzWKmjJmRmlQa8Zc7F+rXAkXNTCfjiRO4DHKesWiySPAIPbs28jubl7wXM5MhDs
	 TUfl6MovFnrdCh16UdRKnmoH/hZXjAW73Aiq7hUaaM/C5HULqVJA8dzPRgMMgI/3q2jto
	 iu7N9b8ebi8LAwLHDaZ1AuZm0v5zE796XdGVuYuE3J0zgNM21NUm/I6sReVdxf/WB7yzo
	 Rf2CO27iaWNfabYeSKlrigC0KmXG1niMm0HZG2SaT2nbHa3NVwdAX3dcoW1pnaMxKvg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792135654;
	bh=/7Rs61BS4zc+7If28TMp5brzGfHrcSNxbKY1clsCNoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nfVjDjG2MbV5I8Q3j47uY2FrPivBhikvaChLcwv8T1a6PTeUjLsFOnC1rPYP90M0U
	 +f2xwNbLY/QkHDEFWAxEF86nxaNp3c0PLCg8/lIz5rBgMXXckDdxM5hiwbJky8sSIJ
	 MS0ybK8PqmHTCMQKNfmm5icDfvt7yPE3bRROj7vBscdBOZT6xc/OfGChkqbz6kjE/c
	 ABd5zxqwGvySoxDBKX33v3a/pmddGLFrgqpPDNdSwRCOYiBotvgBMX1kFKFxWjRZ3i
	 /WNEac0oO/E8mEFZcERHjp+1RkDExiwsX9/hcHJqbSVSmtsdgUyOG8lSdOubY0/T+P
	 3X/mhK504gMTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31FF5812E3;
	Fri, 16 Oct 2026 07:27:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1309A79D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDB6B4022A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJJRxgmL66tl for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 07:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9393B4009C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792135650;
 b=SIRkzJo3OpjffuBaYgES31CNA+e2FGr9PIyhTywRb3jaTx3H4Oa1jf0mPGRVisPuUaRu
 1ReEUYKMpaK1XFRoHfKFTaXhcVdUUaZgpQPBsik9WoJfqnnphCTnG5JHLqkyfb5RYxHPf
 9DCPYQc00mB/tCIUG4f32i3MVvOBzVZvtbBqrFbx3C0xPIfqQ1afcE8k19MLjf90gyIHL
 96/x4DR9jjZLQ/9bE6dccMy6XVkszWCp/6z7wd8jbTNb19uGRJ+MU0fMtpbMSytoR3tzs
 upZs8FEoFlkIz8gg5xBBie4Jhk98LYToNdmllrZmyL+DICh/1K1i83QXNmDFaZ2gtGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792135650;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=/7Rs61BS4zc+7If28TMp5brzGfHrcSNxbKY1clsCNoI=;
 b=OjZikhf9YeML21zmVxN4eCAWf2Z+SlTt+XEL+XF6xTAnoJFnjmN4fosn0gRMvuksKj8G
 DG54ALL6f1oQ32QxzLWywxx+Px2DQdn66OsfLNbisyKC6GUAm4WZyLvAsrrVngJfGiTOS
 Ur+v9AjB+vKtnKV0VWxRv+hwo4wH1C8EiX92+J/2Ga3p9U4jUJihoYI78ZO7aXzL/uF4K
 w/JkoNJpQcR105j53WR3AY2ODM7vb8sGGTCrUZqwcugfjtpGJbEcV5+VpKDc34EjHexaV
 /Ne1N73t/8eo/brxG2+yk501Y9PYJxTIqkB725/J0ehw9PMku9l55J0HOZyXVPffiDA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=emteria.com;
 dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b="FdpQg7k/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jan.kehren@emteria.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=emteria.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=FdpQg7k/
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9393B4009C
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 07:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Unss0QIDFX+fszyPSa4pwdcInmC3Q8lvypRAANtTjqGvU4257CnPjzmCvJRa5Iwr3eo3/umAv4SbqsnvwMhGAKYq1Obnkg8/ZybVqXiol99m70AcmLlc42qbwDfrIl7pbFNC45twJpAl4bjayJacR3+a2SR+135fkeBCYSxM+/cP5GfI2xEcop329/lP1vqiqMBMaogEhkjWXS0ONgTcUbhwqP7MZvOuZHbACb5ZlTBwFBf5UGxOQTg8nBiNJtx8HKPuRvKx2l7njvTXv/cJOdCOtfO21kMDBKzvDkqUFk/JAXAiSt6C2KcnYDlvYVBfK8AAzjeyCvQwjyAQWawdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7Rs61BS4zc+7If28TMp5brzGfHrcSNxbKY1clsCNoI=;
 b=SHneTTmxm+CK285BuD0yGuM4r+F81rxLHUP7HqKm3b1TWLq0Kan2tB+LkPbR5pZCHd6lDhl1VDAiVLF1OPZWiglS2rBK3FZqkN0gj4p/R/Vnp1rDz/c3XyLStlSdGATT1QY+NQdbn9SYBREUd2Gmv/XrwTbB47LrE7KzsrgA+60sybgcvC0EPNe408Pr259AiOrnUIoMvIpnHJtGibXGTiHyKhuAybYWcCfwbPGwBEerWpRzY/uRQ6UwiyepLkK1EusmBc40Zrj/JOq4tCUs4mYt9gbLpPx1AQNtiMbJ2P1hFEnf1meJyehx7khfMyBeuForuoAETHjrCszj7zCkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7Rs61BS4zc+7If28TMp5brzGfHrcSNxbKY1clsCNoI=;
 b=FdpQg7k/kfEn8Y11NnMgfGLJgtxELdbLOwkXCg+dDuWjwdCeozT6X+SkT4vVTOAD/sDp4Ptin9KLRQ9NcWOSx6bdgnYaVbdeQxAnFsqkKRW3Dsu6i0YbcX4sovuaqAUKOVtvavvGNeE88kJtxCItLrBIJbytaKZ4JoOGVkZ6vpo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15)
 by PAXPR04MB8559.eurprd04.prod.outlook.com (2603:10a6:102:216::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 07:27:22 +0000
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d]) by AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d%3]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 07:27:22 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@oss.qualcomm.com,
 glaroque@baylibre.com, sjg@chromium.org, trini@konsulko.com,
 Jan Kehren <jan.kehren@emteria.com>
Subject: [PATCH v3 3/3] avb: Take a storage interface in the AVB operations
Date: Fri, 16 Oct 2026 09:26:39 +0200
Message-ID: <20261016072640.772964-4-jan.kehren@emteria.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016072640.772964-1-jan.kehren@emteria.com>
References: <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261016072640.772964-1-jan.kehren@emteria.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::9) To AM6PR04MB6662.eurprd04.prod.outlook.com
 (2603:10a6:20b:ff::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6662:EE_|PAXPR04MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dba5ad8-66ad-48ad-ef03-08df2b56eb1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10070799003|52116014|6133799003|18002099003|22082099003|10067099003|3023799007|5023799004|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: ty7Jbr60i45LNGA+uVK8kSZwNEWwVi+x8qG9ezlfrM/hAKZafmMNnDCjsjlrbnS4jl+DQtXC5bOFtcETJJJEREQdFsq05m7xYuFtzRD+MzC+f5Dqimsn10v2ul7gpib8WU45ecqZTdgxgvGGvM0PieyntqgppvmydaMTXR/CURhg2Y25GKGCftasCji11t9S4EvHX7GYmj1g/z+zWO8n1yha5r6lkojpuNXiEcC8UbL/JpqOnUk+8DXXJu9/2jU350xoEHGRghkorvIlm0WDC6aM5z2akNlv5Sk7l498/AHtGFIrjcOXsOdg/TBz+JhzdU80AiXr4O4TtMUEb7sZiFduDlFV7UZ2V8rhoCqA3A1uGXfMlvv9jBSTAkLgRTipWvdQDy6S4HgMtyLsF9wVlmFrJLbOyQXCjubSPo8TjEqI503NqL4XEe5ZgcOADmkkd2bqYUMBXxaIac+2UvDu4n6lIQQeVYgKg++niSRIhVqi8z40PvdYeNYRud62SyWdVlNsw4/amBxMjqXJ7uQe5jnPddH75QluOUHW5nBCvqPOjfXkYSAWiyS6cmiUW/cxQb/JzfQ+HqCQBgyZjbWeBcyuo+zdCER0LXsWS3vqDEWme7dCWVyvdGl4xGL6A2uDLTbTYEuRCJ+z8f7YI6rNO/UZneIiUTmocqCf9SpQy/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6662.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(52116014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(5023799004)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3UfcGeR6qQUjI/yYtzIX7+1Kz6KvkngOAnd098GasA7lpXLklx4GJyBelCGV?=
 =?us-ascii?Q?NOxCgJdD1E1/MZdPY20mYH6JTzuGZ9OCEQPDdzBli4FTRgtNb2D4h0LYlTfX?=
 =?us-ascii?Q?JHLAhTnP/4GcXI20YGFNIhAF/gFeLBKneXqzYT2sQJfm2TwIcUa7/W2yOydo?=
 =?us-ascii?Q?WOm5oG/ShgRjU/mrUaEEAZDeWaA3vERjUHcd2rvJ0od8SN6t+tMba+chaOAU?=
 =?us-ascii?Q?RwM5qjODApFJH+Dd7Y8B7dvSUJ8fpFVitySaEkCE4vi5Dbv2ySnCZtRbe5Bk?=
 =?us-ascii?Q?YsXFJk0e7HHZQm3oXoiK27MMnZ4pdL2yqGHZlycqbNCwGBtqfMeg+MwJT9TW?=
 =?us-ascii?Q?IPEZlaimUraJP8LE2+pXQ3Hz5HPFH8hJ2HXLHXIi4a8AnWQr6tuinbS+JtKo?=
 =?us-ascii?Q?QqolwMinVW62yspncNaMhga0yX1vI5SYKaicmmeagUghyi6bqEmMfR7zPzvJ?=
 =?us-ascii?Q?x63/Po8nkn8KDdyqo9pmUJ+LTLbcbwXItPkLMWt1GOr9xpU/+SQjaJe+frWD?=
 =?us-ascii?Q?3ZyGsmFWpGlg2bcQI6QQi3aDBg3ChKAZL73UorEtwFHNq+2O6fBs3h2fPz32?=
 =?us-ascii?Q?cf30hbY0PU8kMiyzJCYo2Nt+HCfXAoSWnn0N4VGBj/BjngopM1gQziBWFOX3?=
 =?us-ascii?Q?YSKWAeEpmtF40wUg7H5tTFnns3wJsG96CQNs/f66pA+6YJ69PNgDE0aYOtSL?=
 =?us-ascii?Q?FKppgyvvEt3QcnX7oFwt02jyHO/kwn9blfO3XiRortZujJDYfnazzJIA54Xn?=
 =?us-ascii?Q?DIm7SLr5vy4txaegESwpwuYnTdCob+i50pqO+TT31bYbTMJn4aZodoIqUFUE?=
 =?us-ascii?Q?aDbIWSDjSiQF2mDkeDCwEM7PcYYxQq/paDyywOTaEXvOk9OGYlwdjcKXWR/A?=
 =?us-ascii?Q?7YCT/O51dTx0+Rq1E8c+3A2NWsN4mQ2+YnjiIuDP25MWHV8+eL15vp/1uWcA?=
 =?us-ascii?Q?JzHJ/tDGHSEawEI2lPL2I+Yu03q2WcClhO/fTT9Zp7Eyf3Yweoo/sM3USX25?=
 =?us-ascii?Q?b+AcxXDZQkGo4gcp39sOWw8deXd9/IF9YgxA2bYVa5sIr9IAy6YK6DgHMb3q?=
 =?us-ascii?Q?pZEr0GCAZ49mS/NC7qjAfKMwfto0OAKjKDOv2szqXOPuCEZMLiiA2R0CLAwj?=
 =?us-ascii?Q?NNfxirP8fbX5qVRYaiLxRen9ixpN5eNN61CswlCe8VDpLceNIESfKnWm55nV?=
 =?us-ascii?Q?o27N8jk0RWHGa14PtKaSum19EmBUF4DbahyG8JDIDSoGBg8Vh9mMvIYldsIZ?=
 =?us-ascii?Q?5FuGsefYjkCzlKc4+jtpfduhtqKMUkEPcA6rAkUtXAx2wVP911f/LiZCpNXT?=
 =?us-ascii?Q?JF5wni2ZJDVeVK46q2Jmx/UF5KnJl+MRX0w7yqyKxJFdHHWtNpS1mf6ai+XH?=
 =?us-ascii?Q?6nz8k4LW+mgECAIJ5lNlTHP9EzDLbvpBOI6AqBNi68/VETFB2xGX1CeIkJk5?=
 =?us-ascii?Q?hLu0nagv3Vr6llR9+S41c1pGud5K9zmE/X9t6GqwggoOHj7yXdCZf9l3BHQq?=
 =?us-ascii?Q?7wyZNUrdjQpN4ln5Ku5Sch1QcArx2i1+dKJCtFEl28IOPeE+E+23cmuH/r5A?=
 =?us-ascii?Q?jlhNfK2umA5cna3vV3N9cD2sA4TMwJ1q+h4diQB1kzsTP0mM/Mmgz+GBEUKP?=
 =?us-ascii?Q?98RZqnXEN2xKEYl6oN6S2zvxatpf74iPxUxcxPMhbVEYZ7nlK36NvlxD7E0q?=
 =?us-ascii?Q?W2e2MjJUR2CtIYoEKof3H6oNVvvvA50Qwnd6D4K9hNnMEQQNLHHYtzU3BpYj?=
 =?us-ascii?Q?8ILaTJnN/qE8GqUw0tDirIuQifUtxNKZ2gzU0pAo2507FEQIDXCpKnI04JUA?=
X-MS-Exchange-AntiSpam-MessageData-1: dVhmxQuQ8pjS1w==
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dba5ad8-66ad-48ad-ef03-08df2b56eb1d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:27:22.2775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxsbzCP4fUiMSeSTMGNqEBXs7Rp3ulAQipxdYT7LhjflrtRKngY69qHamnILCOGQqlKt2mwfihXPfTZ/H/I2gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8559
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

AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare device
number and get_partition() called find_mmc_device(), which rules out
verified boot from anything else.

The user that benefits is "avb init", where boards already expect to name
an interface: board/armltd/total_compute/total_compute.env picks between
virtio and mmc at runtime and then runs "avb init ${blk_dev} 0", which no
release has ever accepted. bootmeth_android gains nothing yet, since
android_check() rejects non-mmc bootdevs through bootflow_iter_check_mmc().

Carry a uclass id alongside the device number and resolve the block device
with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
partition switch on the mmc path only. "avb init <dev>" still means mmc,
"avb init <interface> <dev>" selects another bus, and neither touches the
device: it is still resolved on the first partition access.

Only mmc is started by AVB itself, so say that in Kconfig and avb2.rst.

Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
---
Changes in v3:
- Keep "avb init" lazy: validate the interface name only and resolve the
  device on first partition access. The up-front lookup in v2 broke the
  sandbox AVB tests, which run before mmc1.img exists
- Reword the motivation around "avb init" and total_compute
- Note the OP-TEE nested RPMB announcement caveat in avb2.rst
- test_avb_init_bad_device becomes test_avb_init_bad_interface, and
  test_avb_init_interface no longer needs a device that exists

 boot/bootmeth_android.c                |  2 +-
 cmd/avb.c                              | 25 ++++++---
 common/Kconfig                         |  7 ++-
 common/avb_verify.c                    | 71 +++++++++++++++++---------
 doc/android/avb2.rst                   | 14 ++++-
 include/avb_verify.h                   | 26 +++++++---
 test/py/tests/test_android/test_avb.py | 28 ++++++++++
 7 files changed, 135 insertions(+), 38 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 0db08d4f86..ae05c08488 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -443,7 +443,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	bool unlocked = false;
 	int ret;
 
-	avb_ops = avb_ops_alloc(desc->devnum);
+	avb_ops = avb_ops_alloc(desc->uclass_id, desc->devnum);
 	if (!avb_ops)
 		return log_msg_ret("avb ops", -ENOMEM);
 
diff --git a/cmd/avb.c b/cmd/avb.c
index 8fbd48ee5a..8a915b6583 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -16,17 +16,29 @@ static struct AvbOps *avb_ops;
 
 int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	unsigned long mmc_dev;
+	enum uclass_id uclass_id;
+	int dev_num;
 
-	if (argc != 2)
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
-	mmc_dev = hextoul(argv[1], NULL);
+	/* "avb init <dev>" keeps its old meaning of mmc <dev> */
+	if (argc == 2) {
+		uclass_id = UCLASS_MMC;
+		dev_num = hextoul(argv[1], NULL);
+	} else {
+		uclass_id = blk_get_uclass_id(argv[1]);
+		if (uclass_id == UCLASS_INVALID) {
+			printf("Unknown interface '%s'\n", argv[1]);
+			return CMD_RET_FAILURE;
+		}
+		dev_num = hextoul(argv[2], NULL);
+	}
 
 	if (avb_ops)
 		avb_ops_free(avb_ops);
 
-	avb_ops = avb_ops_alloc(mmc_dev);
+	avb_ops = avb_ops_alloc(uclass_id, dev_num);
 	if (avb_ops)
 		return CMD_RET_SUCCESS;
 	else
@@ -428,7 +440,7 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 static struct cmd_tbl cmd_avb[] = {
-	U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
+	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
 	U_BOOT_CMD_MKENT(write_rb, 3, 0, do_avb_write_rb, "", ""),
 	U_BOOT_CMD_MKENT(is_unlocked, 1, 0, do_avb_is_unlocked, "", ""),
@@ -464,7 +476,8 @@ static int do_avb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	avb, 29, 0, do_avb,
 	"Provides commands for testing Android Verified Boot 2.0 functionality",
-	"init <dev> - initialize avb2 for <dev>\n"
+	"init [<interface>] <dev> - initialize avb2 for hex <dev> on <interface>\n"
+	"    (mmc, nvme, usb, ...; defaults to mmc)\n"
 	"avb read_rb <num> - read rollback index at location <num>\n"
 	"avb write_rb <num> <rb> - write rollback index <rb> to <num>\n"
 	"avb is_unlocked - returns unlock status of the device\n"
diff --git a/common/Kconfig b/common/Kconfig
index c739225621..5590fbfdb2 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -885,9 +885,14 @@ config AVB_VERIFY
 	  This option enables compilation of bootloader-dependent operations,
 	  used by Android Verified Boot 2.0 library (libavb). Includes:
 	  * Helpers to process strings in order to build OS bootargs.
-	  * Helpers to access MMC, similar to drivers/fastboot/fb_mmc.c.
+	  * Helpers to access block devices, similar to
+	    drivers/fastboot/fb_mmc.c.
 	  * Helpers to alloc/init/free avb ops.
 
+	  Only mmc is initialised by AVB itself. Any other interface must
+	  already be enumerated when AVB runs, either by the board code or by
+	  a command such as "usb start".
+
 if AVB_VERIFY
 
 config AVB_BUF_ADDR
diff --git a/common/avb_verify.c b/common/avb_verify.c
index fc29433c3c..b898ebb78f 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <image.h>
 #include <malloc.h>
+#include <mmc.h>
 #include <part.h>
 #include <tee.h>
 #include <tee/optee_ta_avb.h>
@@ -386,44 +387,68 @@ static unsigned long avb_blk_write(struct avb_blk_part *part, lbaint_t start,
 			  start, sectors, tmp_buf);
 }
 
-static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
+static int avb_init_mmc(int dev_num)
 {
+	struct mmc *mmc;
 	int ret;
-	u8 dev_num;
-	int part_num = 0;
-	struct avb_blk_part *part;
-	struct blk_desc *blk;
-
-	part = malloc(sizeof(struct avb_blk_part));
-	if (!part)
-		return NULL;
 
-	dev_num = get_boot_device(ops);
-	part->mmc = find_mmc_device(dev_num);
-	if (!part->mmc) {
+	mmc = find_mmc_device(dev_num);
+	if (!mmc) {
 		printf("%s: no MMC device at slot %x\n", __func__, dev_num);
-		goto err;
+		return -ENODEV;
 	}
 
-	ret = mmc_init(part->mmc);
+	ret = mmc_init(mmc);
 	if (ret) {
 		printf("%s: MMC initialization failed, err = %d\n",
 		       __func__, ret);
-		goto err;
+		return ret;
 	}
 
-	if (IS_MMC(part->mmc)) {
-		ret = mmc_switch_part(part->mmc, part_num);
+	if (IS_MMC(mmc)) {
+		/* Select the user area, where the GPT and our images live */
+		ret = mmc_switch_part(mmc, 0);
 		if (ret) {
 			printf("%s: MMC part switch failed, err = %d\n",
 			       __func__, ret);
-			goto err;
+			return ret;
 		}
 	}
 
-	blk = mmc_get_blk_desc(part->mmc);
+	return 0;
+}
+
+static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
+{
+	enum uclass_id uclass_id;
+	struct avb_blk_part *part;
+	struct blk_desc *blk;
+	int dev_num;
+	int ret;
+
+	part = malloc(sizeof(struct avb_blk_part));
+	if (!part)
+		return NULL;
+
+	dev_num = get_boot_device(ops);
+	uclass_id = get_boot_interface(ops);
+	if (uclass_id == UCLASS_INVALID || dev_num < 0) {
+		printf("%s: no storage interface, run 'avb init' first\n",
+		       __func__);
+		goto err;
+	}
+
+	if (uclass_id == UCLASS_MMC) {
+		ret = avb_init_mmc(dev_num);
+		if (ret)
+			goto err;
+	}
+
+	blk = blk_get_devnum_by_uclass_id(uclass_id, dev_num);
 	if (!blk) {
-		printf("%s: failed to obtain block descriptor\n", __func__);
+		/* Every bus but mmc must already be started when AVB runs */
+		printf("%s: no %s device %d, is the bus started?\n", __func__,
+		       blk_get_uclass_name(uclass_id), dev_num);
 		goto err;
 	}
 
@@ -433,7 +458,6 @@ static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
 		goto err;
 	}
 
-	part->dev_num = dev_num;
 	part->blk = blk;
 
 	return part;
@@ -1111,7 +1135,7 @@ __weak AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
  * AVB2.0 AvbOps alloc/initialisation/free
  * ============================================================================
  */
-AvbOps *avb_ops_alloc(int boot_device)
+AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num)
 {
 	struct AvbOpsData *ops_data;
 
@@ -1134,7 +1158,8 @@ AvbOps *avb_ops_alloc(int boot_device)
 	ops_data->ops.read_persistent_value = read_persistent_value;
 #endif
 	ops_data->ops.get_size_of_partition = get_size_of_partition;
-	ops_data->mmc_dev = boot_device;
+	ops_data->uclass_id = uclass_id;
+	ops_data->dev_num = dev_num;
 
 	return &ops_data->ops;
 }
diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index a514701241..43d5600d2d 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -29,6 +29,17 @@ integration in ``common/avb_verify.c`` and the platform port under
 
 For additional details check [1]_.
 
+Only mmc is started by AVB itself. Any other interface must already be
+enumerated when AVB runs, either by the board code or by a command such as
+``usb start``, or the partition lookup fails. ``avb init`` only records the
+interface and device number; the device is resolved on the first partition
+access.
+
+If the Android images live on another interface while the AVB trusted
+application keeps its state in eMMC RPMB, the trusted application's first
+RPMB request is also the first eMMC access, and it is made from within a
+supplicant RPC. That needs OP-TEE to tolerate a nested RPMB announcement.
+
 AVB using OP-TEE (optional)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -80,7 +91,8 @@ AVB 2.0 U-Boot shell commands
 Provides CLI interface to invoke AVB 2.0 verification + misc. commands for
 different testing purposes::
 
-    avb init <dev> - initialize avb 2 for <dev>
+    avb init [<interface>] <dev> - initialize avb 2 for hex <dev> on
+        <interface> (mmc, nvme, usb, ...; defaults to mmc)
     avb read_rb <num> - read rollback index at location <num>
     avb write_rb <num> <rb> - write rollback index <rb> to <num>
     avb is_unlocked - returns unlock status of the device
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 8c97adbfbf..6dbbb39a8a 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -7,8 +7,9 @@
 #define _AVB_VERIFY_H
 
 #include <../lib/libavb/libavb.h>
+#include <blk.h>
 #include <mapmem.h>
-#include <mmc.h>
+#include <part.h>
 
 #define AVB_MAX_ARGS			1024
 #define VERITY_TABLE_OPT_RESTART	"restart_on_corruption"
@@ -24,7 +25,8 @@ enum avb_boot_state {
 
 struct AvbOpsData {
 	struct AvbOps ops;
-	int mmc_dev;
+	enum uclass_id uclass_id;
+	int dev_num;
 	enum avb_boot_state boot_state;
 #ifdef CONFIG_OPTEE_TA_AVB
 	struct udevice *tee;
@@ -33,8 +35,6 @@ struct AvbOpsData {
 };
 
 struct avb_blk_part {
-	int dev_num;
-	struct mmc *mmc;
 	struct blk_desc *blk;
 	struct disk_partition info;
 };
@@ -44,7 +44,7 @@ enum avb_io_type {
 	AVB_IO_WRITE
 };
 
-AvbOps *avb_ops_alloc(int boot_device);
+AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
 void avb_ops_free(AvbOps *ops);
 
 /**
@@ -110,10 +110,24 @@ static inline int get_boot_device(AvbOps *ops)
 	if (ops) {
 		data = ops->user_data;
 		if (data)
-			return data->mmc_dev;
+			return data->dev_num;
 	}
 
 	return -1;
 }
 
+/* Mirrors get_boot_device(): no ops means no interface, not a default one */
+static inline enum uclass_id get_boot_interface(AvbOps *ops)
+{
+	struct AvbOpsData *data;
+
+	if (ops) {
+		data = ops->user_data;
+		if (data)
+			return data->uclass_id;
+	}
+
+	return UCLASS_INVALID;
+}
+
 #endif /* _AVB_VERIFY_H */
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 137d83e1de..e183b3da17 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -135,3 +135,31 @@ def test_avb_persistent_values(ubman):
 
     response = ubman.run_command('avb read_pvalue test 12')
     assert response == 'Read 12 bytes, value = value_value'
+
+
+@pytest.mark.buildconfigspec('cmd_avb')
+@pytest.mark.buildconfigspec('cmd_mmc')
+def test_avb_init_interface(ubman):
+    """Check that 'avb init' accepts an explicit interface
+
+    'avb init' only records the interface and device number, so this does
+    not need a device that exists.
+    """
+
+    response = ubman.run_command('avb init mmc 1')
+    assert response == ''
+
+    response = ubman.run_command('avb init 1')
+    assert response == ''
+
+
+@pytest.mark.buildconfigspec('cmd_avb')
+def test_avb_init_bad_interface(ubman):
+    """Check that 'avb init' rejects an interface that does not exist
+
+    The device itself is only resolved on first access, so a device number
+    that does not exist is not rejected here.
+    """
+
+    response = ubman.run_command('avb init nonsense 0')
+    assert response.find("Unknown interface 'nonsense'") != -1
-- 
2.43.0

