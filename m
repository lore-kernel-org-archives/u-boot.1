Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF97CCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2280E838CE;
	Wed, 22 Oct 2025 09:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="i/mgbYQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A9F8334F; Wed, 22 Oct 2025 09:03:15 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A06282E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:03:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhyKm4G7L+uSBuY5wjeBezJlswdnVgQSz6U192tKvaBmKkQ45KJkJLL6wOkcP4eY+9W/gzbZzWfO7KIyJCb4YdQNQyO08JN0FTluJQpMJ1VAwDabekivUD5egkP+iViLvAB2i7nVnOUMYprnqjvuf3uemBufkTe8N4SdaJqHuFzhlDIH9AVUAjruUANZHMTQPd1UllxZktdnRb4HmZcQoDrSbWLgbjJUCNyCjMlVq/33ZmGaQzvsJr5mdedSCV1xCpORR7KbABS1+bB8rAd+JdNMvZIi4xIDoLtinuhGERRRrKiAREpo+F3eigrQ+UgR38jBra8GALY+sU9v9ev70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y+gUfsR28iQkjRUIMTGdvpnfQ1z5EyrY7rJwE9+RVw=;
 b=wFjq3tLI8qLCWDnvMd4dqXWLC61Phdip+1IlKBNG1SDyoGB34/n8twvBSYJsWUHvbQ9eeYeMCJ2RCz8rwK/Oj8RfGICLdFWnJxOb3Me5Jgi/rW/xczDfr72T2hp5KR414gohn5XxNdVvoi5lJIEVMx4CJaztNaLBOdVHUGkdf8Oh8j1s0vmx6UuJPpZKWh01rRgW67C+rvDVyrjLx3ZEDGx20EsCiyamo7uULVXOOhhOFu/lxEHi3HBNoc2xz79yIkkybmwmYCG2TGcBMBQ6X7KM043hptwcmQm2tzEx0AygmGb2ajvCtQM7ii209zO8GxhdYvfq2TRSKXZKkcE8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y+gUfsR28iQkjRUIMTGdvpnfQ1z5EyrY7rJwE9+RVw=;
 b=i/mgbYQQzzGypNJZt/avOIemFT8UhrJww/u91iYneo7cUTH20ZInEF2H2W0uFgMwIRHW2ck9FN0WTYZ+eM7cZ5BurfHIM1nnQkQf6g5oz9hliHapidjbvHCGeM4yM7XkxDisqKwugy4X1qBdCsCp71kPDFxUYfqK8nr/4p+5Y+3rCZeCohfcq3DpJ2STasqzKXOSnQaOh2RRCzlm9g9XdmttQcPWLdFkpbGO4ISTr9cbw2qTWU155moeONv5lHAyYgn2Mfb0keycfeX8AJLs9yGSoQCL/bEJHOtCmA/Gc5S2TCY/7W4Vab04YxvVq+5RAQJYgKvDPQxl+NZdoXaQ7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6935.eurprd04.prod.outlook.com (2603:10a6:20b:10e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:03:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:03:11 +0000
Date: Wed, 22 Oct 2025 16:15:21 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 1/9] mmc: dw_mmc: export dwmci_send_cmd() and
 dwmci_set_ios()
Message-ID: <20251022081521.GE30163@nxa18884-linux.ap.freescale.net>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
 <20251017-mmc-dw-exynos7870-v1-1-a2c5139d9afe@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-1-a2c5139d9afe@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA5P287CA0116.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 282c3a52-5cf1-4f57-85f4-08de11390ffc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZdKo/NdWQapcAJcV64Ak4bSraPzhFQyRXO4EH98VjS0yHRJjLLcq9KxaCEuD?=
 =?us-ascii?Q?C7aGlY94L5gil1D2cvUWmZxgzHgNq1BrWA/bzj3O2JJ9+zt2UDC/nqy2COgq?=
 =?us-ascii?Q?XYrRZTQrLr1KFAKIMpp1Sutgt8l5tCjXGw7lJxgQw/Wk3WbtD+EX8uNrpL71?=
 =?us-ascii?Q?rvrNG3EWuZle/gYB4Gi7REYpU4EovpEPiyJaKEOO0hQacba7iHgYrJ4NAQ1A?=
 =?us-ascii?Q?cSK0GmkFWt9TR/S5zGr7uZtqvhtt2F0dOZaydaIECH7rWSgu5V/+8LNPxF8K?=
 =?us-ascii?Q?pJplgbNFEvfYmGoXmiCOAl1mjRfcTTg/GBHKNIZRIFXXogSMrIVoGmfpi5A9?=
 =?us-ascii?Q?+Ka+B6ciMNgrByEbiLHRp5IUOkpZOGHOuJHSNi+V7NPFvaw1iZ1Bq85xDRoF?=
 =?us-ascii?Q?RxnUW2Xvw7/saQBnw/rwFsoIGLPXqZZNDdWxB1NiigZFqgseXPy1hkkZVyVs?=
 =?us-ascii?Q?+H5s4yPLhnD64yCJhhn+mvyYlWUt9ySYbr/D8/WTFTuP6TNoTz+GXyct8Xo/?=
 =?us-ascii?Q?k7VX9UcSnidc8hJ9KISY+6YFKEahojDBOZcmacW+zQ0SSVv/bQATf/ZgZtVZ?=
 =?us-ascii?Q?6gKIzLNuJj2eHpd1tOXxyeJ+EIPZMJNSexTTZ0MLq9bPuHQ5ab0j+8oE1wrY?=
 =?us-ascii?Q?Aeq4qmRw4coprbHpI91zOA0pVdsLoUqJlC4uzzsh0hH7gzUIdCVPrPM8NM9q?=
 =?us-ascii?Q?lbvOaSY9l7NrvmNIDYS+P9/OAi9hiWBSt8REZo5rS9kQzLqk3VT1rBb0L5bq?=
 =?us-ascii?Q?0PPQWMy8r5U3XyaSrPAfI6LecRVNw294BsQVWRDzSnoEjB6ukJ5zUMBJU4mh?=
 =?us-ascii?Q?rfrz9uWzsT/SNgESdmimRadmTvO4DSlHabZrhguoVTOyfYsR6cCU0Ap/YyVu?=
 =?us-ascii?Q?BlSIQuh5eFy4qUcyKU4lK2Tz3pOHRs+YWwIGLUeTx4S098EBTud0vH3FwwzP?=
 =?us-ascii?Q?NLND7B+aWzDnC3aJX5PABlrxD7T0rqenRGUH5RNus02FbHH9HdPrgdJbEgGc?=
 =?us-ascii?Q?BhZIQZ5dxCJcKOXaU8ezyx2aaeYYUE71x978lkf1n8b/ki0xNdAEawHpzCDk?=
 =?us-ascii?Q?AsOB5YVoxUTqFeWgxot1O8E4mJWx4//Ml39w5AGOhgYUF1nnISQ3MJuEe47t?=
 =?us-ascii?Q?YCoRd7P4u0OQ8qHpczrvMTcBJ65sMHLRyFrwlTRKLTkQXlruv/jgvuCMBAfr?=
 =?us-ascii?Q?+wnay0S8yN6tIS73dxIUD6cTDCe4dlD/QDI7bOOFfCW4RGHYPYD1DtVTXxyC?=
 =?us-ascii?Q?Y0TIgnJFMnIJPjJH8GU7hSm37V9PJgDqP5iUvRtX8mViDq3z+17kwxSpcVGp?=
 =?us-ascii?Q?14+xXoJNRty4aRy4QD1HPJxR/2EgcePbZco6lIvthR9Q/EXHQy5xil9FYusD?=
 =?us-ascii?Q?9TvLbe75tzrHAy/0lpJAvCSwYJ+z+K4/PPSxa0c0yVnfEkHnDdjJD47yX4e2?=
 =?us-ascii?Q?YND1g8t48gDI+osdQlOkt4EOLycLPxGf/uiz/BKrQjhLRNlV9M/R4ivKxWHS?=
 =?us-ascii?Q?/5DVp4+1j5FNsUTbGXUNRMkEXMftLuNuSJbh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9LjWbOhlV5P05rCLM3N0sp4v01gMB0PgSNP2WQ9dAW0f7iahKqnwdglY19Lc?=
 =?us-ascii?Q?eYT9PaF50PO5nBiOHU4yqglufUSbXD+7XOFbYRA1wN41EioMRQxpBD4m15xp?=
 =?us-ascii?Q?hHr2VRDPqhqxrt3LOBCCwQcLFnVknobG1Nw4y9rORo6bSmzliioGI30WtD/4?=
 =?us-ascii?Q?2KSrmjYg4h1EqSEfE2ECPdhzHg4TLvYT+tepGGmZo/xDnR1O5l7XSKDqfxkO?=
 =?us-ascii?Q?HVeqrgjDfSVelGvYk4bCL9VkHk1YmjI/MbFP+nFKrQVe7+CXoeH3zwxpRzJ0?=
 =?us-ascii?Q?F8+eJaC9EhyDPBfnZK/bxPAaDaso3jGD/Z9xjHKS8kJaXMnB3nyK5IoGwla4?=
 =?us-ascii?Q?Saicfql2Lm8fll9LeEkvM1WDRz6ftnpDMG9yjnfcm/uYfbLIlrd0dg2uwEeU?=
 =?us-ascii?Q?IhwAR0MhvZtFGADfCFMCfgQQ9pm+GJtmH7GXf2hQMsChNsmYnV9BAp5fKq7/?=
 =?us-ascii?Q?/oJCV2HY8hjCR+YvffkPXTUzDyNjIb/h7fT5Ba/6KS+6Dg6H+by7ghUw+tFw?=
 =?us-ascii?Q?brWgj6Zfm79YP72MhE9bDe2orkAk07AEvUUUU+Qio/7wCI4WAb40G40dFa8K?=
 =?us-ascii?Q?/s/1shi7xjTdH/eed+g98/q3Xs2CfQHWcIEVKBD2KMC2KWxe9UTYX50NvxXk?=
 =?us-ascii?Q?JxTP5udnwtRfFu5XQEqgrcGxR9rjIbbFjY6I86aqCaffmH6ebF9lMX3Dc+G7?=
 =?us-ascii?Q?FQOT1rfK4LlUiNJhb1OcrbqwU5g3jbFPmmTbszsLF6tooOZcNKSh32W1Jqmx?=
 =?us-ascii?Q?vIvLSQ49N0KQsFQSg5dFunlMDpbGjVhpT80R7qz2rLDY4mz9mMXQ/BLqYq8G?=
 =?us-ascii?Q?d1ifp3ThIL8hXfQg4fZv3e7NfBfh6xIIjuHt0uQAW0D8aaif5RBgF+FQkB0m?=
 =?us-ascii?Q?HG2AAtwogY9oIp/nJEpHyUbkuzWW4iNcBzZ367A2ofNzSRiYi0M6X6rgTcqE?=
 =?us-ascii?Q?TYo08qEbgSXq/iyytbAZXjZiTxY2Zqmc4iA7dACDgZzGeCQXnPdqtsvsYV+0?=
 =?us-ascii?Q?ClUqIkTT2h590vobhu/WkiC7/eonggzvNpV0NnmYqSv8IfzG2r7zmP+6asa4?=
 =?us-ascii?Q?ztLwtcvjET3l8w4dw4+EIyhjWhSeDquvaNigu+nV1m/CAqXzEZfxWF7lbBE0?=
 =?us-ascii?Q?47WxdEUGjwCaaaSq6c/rjYL5qJx9vbyEhAJrj1nnAjHw77f7pT6ICJgs/g5M?=
 =?us-ascii?Q?6T+ZPHtcg5m+Bh1ElnDj+Js0J38nAIun8eqH6z71hLzchH81knWavq7+iMgr?=
 =?us-ascii?Q?Gygo72bzVqXnIcPn1YkhJvnInlpUjMT0P+AehjE67lQAv2g6A9EK/IqRCQDe?=
 =?us-ascii?Q?eNZPhUDwv+v5/uq0qxs8HpkCPKQInKdHxr2Zsnsnie6Ju+igFXlsSxbJ/tXM?=
 =?us-ascii?Q?5SI18GSkySwiHbpLMJPtohkHynlOGgYXt5iRt6xCr4SyE+aoEusAi33TD3by?=
 =?us-ascii?Q?+sZQHOvdWWXy62HhERLBN+o8RNfNqDjfPINMeiVDNMxOkohwA6afhnBorDpS?=
 =?us-ascii?Q?BKlvW5BE4gRemFlw4M5UJg6cOLoaPzZVn2sybLg8wmBmf7Nk34ZH+RloMfRh?=
 =?us-ascii?Q?6CUBnEZ1EqbyNdgXDZ6Ndb7WyCiV5FQ+fXuPMNzQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282c3a52-5cf1-4f57-85f4-08de11390ffc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:03:11.4461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwRiseiZDDLfd1mmcEUlebcK5ggnpCFf2Wpuc52BDvxLcUA65UVcCkWHhoSKDNsHCRRHevjBP3KMN4LMt2r71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6935
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:54:06PM +0530, Kaustabh Chakraborty wrote:
>These commands are required by struct dm_mmc_ops. Any platform specific
>driver may use some or all of the functions in their own ops. Make them
>accessible by moving the prototype to the dwmmc.h header.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
