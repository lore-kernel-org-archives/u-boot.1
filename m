Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C524BD58CAB
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 03:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52BAE84101;
	Mon, 23 Mar 2026 04:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="G9fieJW4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7918840AE; Mon, 23 Mar 2026 04:20:38 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 171838408D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 04:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvevoZTN1vADiS+/kNwEna+9FXp3wNxa3mC8VmLMS1QZXPVpQJiSXvBbdVylTMi+JrHpM+5Drb1zY0dSIZ6egWG3zZ7jcb9oUdp/07d7P+guSxaOIALSZex5cKLg7QCB0I98/xPgGmKEL/Cel7y2+/jU681oyTCCH9kR4FHVX8qNR9+OFJ42PRDu+jU/PVAKwghcbsSlSXvJPZ06t/Tm0uIQalQLZ31fpZZBGjXhd3Ua/0HkGpDfdm/ajjvrTcpak+O+7zxvh+AVCnV3gW+xdz3BkO+ULpcJq39gYl0yH+YNpS5qSp7KrmyXufr5lScsKETYar7KmopL48ld8a2a1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8Klpzc2F9Rdq7vk7OqGK9Hyz3hdHLr5PR2hza75WJ0=;
 b=y+bVaob0P2S5veM/IpsUXGOThq0Em2Hxm7YCexIccfYa1BUy0+88AbVNEYqAvyLu3WD1/1usYhVmv2j4+X7uUn4tAeBra7ISsa7HcLdkwjltQXEsD5IFA67kQklU80QOVZq1cU4VUDnXmtdNLU7wawRyD8PIDyHFrHAg4mj8xNtX1moPvEeb8Wb/RIV1iNruzBH97rxfz7c5X1baUEdYtGUHYteDZOXnQOTcompJ1B0hCcdp0jRe0Aa5t8VpToSNo+rhIpKvfxFMD1/Tmg1L49Ua//S7ir7nDJlwQqDTuvs2cacFfUQRt/gEcWIHGM7I9bNzqOQmEafuNFJukFoKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8Klpzc2F9Rdq7vk7OqGK9Hyz3hdHLr5PR2hza75WJ0=;
 b=G9fieJW4jMCw3JVZv5AJBn6CSFOQ4a/6RPk0eMXtpCMEf+Jwg8qBOS1YMdzGMt9RRlEQ0h5EH24RlfCg8SykMVu/NQn5ejudLKwuBrkGe1v0XwCUEyvXemhM0aHFF9c2VDxXQ+z6feajLLc8v16ec9RC72gmgd9B2DISnjC7l2UJ8OTJkrxw18c+H/QCxy5lawY38qdXpJ46HWXebxvg3HuaLaQUMnsk+k8sjeodzKtcVsrQvUPNvfTtppM3YXBeIZUkRjRyWsJss9dG7VyxH6snlKWP6xfFgYSRSPPzSRIIFsXRr1ZjisqhXH+ilbB/f9NZ7WgXcbl0Tzv5SV+3dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8456.eurprd04.prod.outlook.com (2603:10a6:20b:3df::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 03:20:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.022; Mon, 23 Mar 2026
 03:20:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 David Lechner <dlechner@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] dm: regulator: fix missing quote in error message
Date: Mon, 23 Mar 2026 12:36:01 +0800
Message-ID: <177424051905.2364563.18006221967589867160.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319-regulator-fix-missing-quote-v1-1-839144d65db3@baylibre.com>
References: <20260319-regulator-fix-missing-quote-v1-1-839144d65db3@baylibre.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 48292e1b-11f5-403d-83b2-08de888b17f2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CoCWNmO/9pLtKWs9wA6TVhCxZcHepZFpap5egv8rLtZTE0OeJK/Nb/4gXiVEdB7u3efU8P2ItwgeQymZIIfS3Hk3GvH20zKj4iXd4zrUTf0lbHLMLXMdd2JKqPyZ4AtfPb71SzOJMVWM7AIfFNNfwq3kWuDesKW9780FefjxrWfAokpfo8vq75azVzgxVqQgc2v4kKqiVUczZ6AdWsIe96V87He87/BhCI+tbpcFLJfNtRxI1mxy3v0kPkMo3L1ElIQtn7+JnojjY5zlkK2pIbflLv+jUaPKGXlqbXwMe6PXOKzt/1S0HpJ4kHsyLcjkyUSq3Y2CyoD28LdtkmNl4e/qZh79K3BMWU830/btJKqK5M5lM+lbASj/52fW9KDw9dD6tYHnFjR0E33V7GcYLMGynwpZ+SuxyCznElefPwFEkpP17A+XOeZ9xATEQYaZjYv/BUsuQ+vfc1dK+n6OOhXZo6d2Ag1MWCmBPDoiYfG9yx0pgg/axs0NoR+KxTgtQ3IFYdiMXWXpEszDCmPARFSMvkn/5ZrDIijZDpMqLUBwNMYpjEgUtk3t+ao2/UaGXviYNSx3k/vR2T2MHUjuw3+RbHTHsUZuWFClighPBcqMWvTiG7dLhbSq6eE69KdzIauZFCxHAADG6M3YdhJ8sqdFouYcbOSTzoADGabsmZE3s17r5+L83xtZd7JdpjyB7z9lrU6l19ucUSKs2m5dn9QRYpdxZRNbtH2aZvAPu7CYHMBOSC8vRVl9XbA8kHEvvQ3E56jCnve/tCJeGjpqOECR1W5+KpL+/ZD3+sI4bng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1MvWVY3VGhTL2o3ZUFPdGVnREVRMlgvQ2hNUjV4L2cwUHpKaTBkYmhpWjJ0?=
 =?utf-8?B?T3VFRmN0WXpaelJoZDFyOHlEWnhGMFZBbmQrT1VUK1AwQTRuSVdvcFh3SVZx?=
 =?utf-8?B?Y1AzRmsvMnllUE43SE1tZGp2N3ZJMzFsRDExNHFxS2swWXNxdzVWbExoRjl5?=
 =?utf-8?B?QnhxUjNBZXlzTEhoNTMvVSsvdHhwRTJtUzdqVDAyc0h6YSt4UVpHdXV6TzJJ?=
 =?utf-8?B?VXVGaDFpUllMaXF2SWhPc0RyZzAzY1J2OFZzSXp1T01YV3NVc2c4Qk1BSjRq?=
 =?utf-8?B?UnJkTHBaUXJBMnZkemN2REkyV1BsbUhNajNlWWhVbUJQdkJhWnMyc1NleTRN?=
 =?utf-8?B?Z0tRS2Y5VzdlQnlLdnFrZ2ZjODAxcGdrQ2thWldiampzcTdYNDNKVHIxbEdr?=
 =?utf-8?B?dVB0QUI2K0RkRmpMcGdzNlI1NWErNklwb1dLZk1ZeG1CeWZkbGk5U3haMG1E?=
 =?utf-8?B?L2RVQUpyUi91eUVNUmd2d2FRUnJnNmlqam9vL0JhTUlsY0IwbG1nL0lTa3hE?=
 =?utf-8?B?R091YzBVV3N2bHVPM2lBdFRaNndWOUxoZHRadDVRaXQ1ckMwVUJaWXFRZGVh?=
 =?utf-8?B?S1M2N0dJVGRhZ0luOTdGR0tGaFJYOXZtaGM4SmFGTnZ3ZndYQVJkdkZra0Yy?=
 =?utf-8?B?enVFZWoyRy9PS0E4K1dSVVRlVlh2b0pvamFNc0N1VVkySVh3K0ZGelpWUjRR?=
 =?utf-8?B?VnNhbHY1M2JVUjQ1bEx0cGR0TlpoOWpQVDBEdzI5ZTFwZVdJMTB2d20wa3F0?=
 =?utf-8?B?Ni9tWnNVZHB6V21QUnBUZmFkN0NoTmtldlZ1UlQ3cnNyeXY2cko4bERmZmEr?=
 =?utf-8?B?VEtHS0FVNW1sT3RteTF0eWV6dENwYzJ1SGJJUHJzOUpoWE9TdTlHSTI2V1Ru?=
 =?utf-8?B?cTR6K3NuVFdQajVpc3VmNGR4RkNIMTVkU09zS2JvOGxkSHN5T3N1aUtqZ2JT?=
 =?utf-8?B?clQvRU5OLzJURFh2d3J5RDExamtKOVl1KzRXanp5cEJDNUgzcHN3ZDFqSG1U?=
 =?utf-8?B?RmZ1TkFRRndLQktKYUw4LzBhYjhVaFFoUVRZa0ZIbUpLcTV4ZC9ieE9ETXpN?=
 =?utf-8?B?QnhxY1QvUjd4dzBueXczSlQvMzFqTWp5MWNyNkZTVFREYmtIeHcyRi9oYno2?=
 =?utf-8?B?Sk5qVUhLaEN5ZWtZeGpyT2U2dHhKUVJmQzBEUFVjN3gvY2hNUTJ1Yll3TVYx?=
 =?utf-8?B?V09ndUdPRGpFbWpxaVhpcXM3ajAvSDZqYVZpMXp1d3dFc2JiTWF3ZXVncUxR?=
 =?utf-8?B?TnRvYVppemVoYXUzaUlucFNPWW5WY2NjM0lsVnd3WURQQmE4UmJ0NENhVlJI?=
 =?utf-8?B?YXNadERoaUlXKzdrZSs5TzkzVVpybnBENERFVy9nekFvbVY0RktmbThRcXVm?=
 =?utf-8?B?Y0hvWllodjJBNWRvNG5rU2dWMk1TUkNhd3I1YzNwNXppQkRLYjRhWDhsWmhx?=
 =?utf-8?B?d1d4M0UvM3RUNjl1M2xVSkNzaTRsNTdTME9RbytjOC9NdUgrbGNmRU1SZE1W?=
 =?utf-8?B?NnhNTWI1SzdJWVFmVHc3bGJaTG91UUdGdHlNZlcwbm1tcENMYU83SzdjYWRX?=
 =?utf-8?B?ZEJSN1psbnU5TVFsM0hIS29tU2hGU0xRUkVERExuRGdiTnRxOURHM3lraGVr?=
 =?utf-8?B?dVNKUjZhK1RFUmQyci9BTkk3VGNqYVhhYm44bmlFeTA5Y0lERTRNTEhzeHlL?=
 =?utf-8?B?Z2o2SjFlTXhKT0NtcTFwcy80M2YrU2pxOWVNWU5xdkFqMXlINGw0OEJWWjZh?=
 =?utf-8?B?a2pPbkJwOEpxOFY1YUdSOThNbklwTHlxZGFra0F1UFN3dHJLdTBFNEZXZjNh?=
 =?utf-8?B?TFFNeklXK3pSbGtOcGpRUG9MaTFjWnRkZUlMbmhRWlR5Y2grSFI3OE4xbDFp?=
 =?utf-8?B?L1pma2F1djArdXBvQTJRNUFzSHU4cEw0QnQvc1hROHVzM2pCcDV4amE0RGRD?=
 =?utf-8?B?RkNjQUVQSHdjWWJFRzFDWnBUbFU5NFJ5MzZDRmR3NFJMVG9yV1V4VmdFdERq?=
 =?utf-8?B?MGZDZWRlQm1jMGdiTU83aHk5Z0pSMG9SOWxjeTJDNktpWGdDV1NaOEx5TmRr?=
 =?utf-8?B?ZEEva3NoU3Urd3hTaHhMNXV4WU1DSisvNDhnMnptMG9SckFhU1ZYMTR2TDgy?=
 =?utf-8?B?cEpYa2FEMC9ZeTJ1RXZ1RHB4Tld6K1VMTXJ2djhQZlU4NkdLZGZTV3JhZDMw?=
 =?utf-8?B?dHlDWXFLQjBTTmF4VE5KbU1saENMVXZkY0J0YVAyYkZHcGNJeEQvb1dqTWk1?=
 =?utf-8?B?QkYwMjhPTHBScmVReXhWT1RSZmdYbUdxQURQajU1cVdOSmt3NnF2VW5tRjNv?=
 =?utf-8?B?TGtUYXhvRjJuQmFGZnBGd1FJZ0NxVVVSNWhkbDU1RlJqS2VvV2kzdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48292e1b-11f5-403d-83b2-08de888b17f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:20:12.2041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HhNSh/m0BoxOab1XoYTjysp2CZdTNKoXzxVuAskgrM3KeSaVaw2gsRIencuAm9jKA+2zjkewCgcUbNficwXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8456
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Peng Fan <peng.fan@nxp.com>


On Thu, 19 Mar 2026 17:30:04 -0500, David Lechner wrote:
> Fix a missing closing quote in the error message when a regulator name
> is not unique.
> 
> 

Applied to mmc-next-2026-03-23, thanks!

[1/1] dm: regulator: fix missing quote in error message
      commit: 9936e1083dd8c45cd10e7497bd83933b28096dcf

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
