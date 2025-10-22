Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD283CCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A404B838E3;
	Wed, 22 Oct 2025 09:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qeHmtA6i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8A183303; Wed, 22 Oct 2025 09:06:27 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA24D82E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iysNWRjE5ihFd1RmGAWSPAU6it21oMryzk0RyxMe7+Tg2AAmKO5IwUVbikEoetFnYyzf8BpK8HPBpJNsSP+2bYpPLmUZLEfHRtwfsh0kTzIlXcsIRAiVNdJmlqF0zLeRrpgGfuPMfPJxGy5Wdx/4ohJrsqNEEUaSJTPhA9s1g4g6V29gnzJSAXZwjdvo1Gsd+d8XcOk+qmJo7HsQRgw0PXEFD2cxjcNTBEj3MbSr/vC9q39tCk1kt6IVGISyqv78HseIBxPWSi7U5hZ1xUorK7TufmgCtd9pcVxo57KTUUiOFW/VZAjJOSq+NbgJ9iztQ/4blPiBd5vrDtImFOpH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hp6G0BRD8snumoI0fRmHsRjRko7XxBkdJiqc3Q2o/oY=;
 b=CMgtYzZ4YqeB1B/40YEzRSr8sTb6Ewrt45gNFbVsumB7YQWuJmKswNMLQzvqdGdXwwUcK4cUnjI9IGduvQh3onvr1eV4Vqfv4C7DiYbYusIGI3WcRD1aNBKgRJpKsFTdlZXO6oGi/jr4zOTxdL6oU2xtaGpqisECzqKJNcIDiERwqu7bNCLaPHWYHtBLaf6M4vDQzsdD217JBznv9JYIrMzzF9rVyLOwCaDLDP8PHknlIm9/K55x3tJAeNZpSjSFEMbT48uJkifF3oBzSlEGbgk3iwlUt+mHNQuqIxuGgVRI6zTUrsh2/4dwQ+Zm1agR+h8uY7MY1kL/lyESrboVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hp6G0BRD8snumoI0fRmHsRjRko7XxBkdJiqc3Q2o/oY=;
 b=qeHmtA6i5Ve7guUanxrqJylTksMSzDoDXeT618tMD7Q6GmMBaxceeNk/Z/2+3ppOKNR6eEorelXwJV64jfTFz0AZOESvN7U06PGA6DWuGTD41sgRtbKpifv7n6CHtYW3/ifQ4XHzI9MuQcqmugQb0WjbD85PLISvxKAeJd2SUEBgsdHcBF6/7HzROUOnjT70ZyM353NFVuZ2n0C84d6MTPvbYomYbL7objm+/nxqZNu9D8BuC41A1A4J3yjHaUeftwBzb4kV8fTexewPgPCYhoC+8ZQswE6m2UdzDni/67uYEcZcNep69oBSQrktgOAi6BJNAQkTGr2DPjR13kM0Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB11879.eurprd04.prod.outlook.com (2603:10a6:20b:6f9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:06:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:06:20 +0000
Date: Wed, 22 Oct 2025 16:18:32 +0800
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
Subject: Re: [PATCH 7/9] mmc: exynos_dw_mmc: add support for MMC HS200 and
 HS400 modes
Message-ID: <20251022081832.GG30163@nxa18884-linux.ap.freescale.net>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
 <20251017-mmc-dw-exynos7870-v1-7-a2c5139d9afe@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-7-a2c5139d9afe@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB11879:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5be749-f730-4594-f758-08de11398078
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jrfgFjCAzSUdRvPNCnTgKVJq574xPoYLXWKVwk7byVn0WkOZdjmrueg89Rm+?=
 =?us-ascii?Q?LfbC0zZvbsKYpIbsM780zKYa/u0RbmEMTe3lsl6nfhLgWUvjsFbODX9OXGyp?=
 =?us-ascii?Q?nRBw1e13EeIE7o3N1VUbD7P7Dm9gQJOMx/Bv/cQUhOuAP9D8JGtrItKVRLBl?=
 =?us-ascii?Q?vNUZImJMGuDfslWeFn91xdnN7dZzyMdN4r1pf2oUz01u0yu7pWY9yIOHoNSW?=
 =?us-ascii?Q?OLakGr4LjzzMnv/238YQ5cVqTJosEYfzDuq8Gp1PYuJk3qCShL9Tf0zUZsOf?=
 =?us-ascii?Q?k5W0Y1VFiJYWZ3bC7Dy4aqg1ruhuWVJWPedXDK7cJB5P+BuxJ+Rfrhkk+P3z?=
 =?us-ascii?Q?NkP93Yb+s44dZo4vVlGAkrIlJzj9v0A7piy147X5X/MvaoXRuJ4A6GsadHEu?=
 =?us-ascii?Q?HGPya/sx9Q/3RnbEvjpEa8mTalCjAf1/225Gr/ASJH9NHJQeD8c9NxI8yWxR?=
 =?us-ascii?Q?9YSlsrU4Zs8USxIAskOk5c6crFEA5I/CtnOK/aIPNNeEq+VBXSSdQCcVvVnb?=
 =?us-ascii?Q?0FhgrHz5Or/AGo6Qd1cz982UcFMqWRM2n/yBrUEKq2rKHPUS6nMjVMb0LRmj?=
 =?us-ascii?Q?byZQJ8T8GYIwCeQ1uSt6u/SiAbgYUF6LxA0ZuwAc2ajReoK+PwasCEn6K/k8?=
 =?us-ascii?Q?jF0DGm+Ujzq5lkDoLsQYSoubnHGZb0jzRrV5mzsHCjR/bE0AddF6B6ICOw42?=
 =?us-ascii?Q?wqzEwux6Qd0N2aCJbbSFjOjGF05sZDxTgRUtQlJHDjzL3GlsQvptMZTXIYU8?=
 =?us-ascii?Q?INYazBKT/PTzCkzG6Mjz4iQGvrb1WS4HZOWa7/yrgqkqzSDQshkYs3taVApu?=
 =?us-ascii?Q?YIom0MGZpNcHR/1M58g1VgVI/540DbAFMAgskG3U3YPEWkE4r5KTVRiH6QVf?=
 =?us-ascii?Q?gC9hC9vARk3G3EfWEEtuqvkyLb9PTSGmsD9TgFaw8ut+6y5efmD3xVpUiATt?=
 =?us-ascii?Q?3s0bYq2rHYSaThjFu28THUEDan0VlgjR6sHM3TI19RBX61GcANUjPUhnDsfW?=
 =?us-ascii?Q?AWbyXKsxj39cWFuPaPUNUMH4ny/8Fc95jxHifMR4L39wqdqozNeOErkVD6OA?=
 =?us-ascii?Q?v3cVzLnwODFptK1NeMWEOIF9AnIWnTOtqQsirPmJKq83oNGcjEeEeqRRMFMv?=
 =?us-ascii?Q?rmJzGut+pWZU3xyljPaiCSMLOO6ZJCQ9lWqKLdjgOW9dQeYBFmOdDb0gYH0b?=
 =?us-ascii?Q?tL3++Zvoh2rUR9wpuBY5jxqoJLbN23DS0tWJGhXnQ2MdidqTV+uu1neHOfsL?=
 =?us-ascii?Q?shVZS4++Pa+D7EY6+f/7kH45jzSUv/A7pUDKUJ4yamaNhBvDuh0OWfWIC7sK?=
 =?us-ascii?Q?8CL0JgHN0dxMNP4Dgo6MYsbL5QjemrrjbAcofBAWtGRl7kcA4SwKara+yPuG?=
 =?us-ascii?Q?sYoCkcAez+Le/5I5IyC8YQxTvJ1W8SvfY0u5RJDmozkiH4WBbJuegYr0heWg?=
 =?us-ascii?Q?ISvBrQl82y1KY67Ba7RZpfx0arAUxqgrPgGQebHQdPy480r2RXn3VcVn5Vy3?=
 =?us-ascii?Q?sH/fBYszAvpNcz+ySrjLRk9zK81WbwfMFwIB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(7416014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v3lkd4GWT9/32FDh5TuD5MiFAlt5yFPntXf3XSzzFX+k9sFUmPyzxjyb+hcH?=
 =?us-ascii?Q?AZ2CQWbaG8Fm89P6BC7Xx3mpo0TgiFtxRjkM+dvMguXsIh5qp8f3faXpvmYY?=
 =?us-ascii?Q?bveUrzymOE9CiI+khAwbs1nMKXGPXRCSKLNh9O+kj0MY7D2N7AfjPUrsYcLI?=
 =?us-ascii?Q?vKtyvoKd6smKPPTQrYJRWN66FYJmvrdcONfx+cppfAlLbHjsqiCjA7BpllbV?=
 =?us-ascii?Q?EGHeQAk1MsnM/udsDm7R6Q2f1X3K82+hvY32MngU3UJoIwUahRhyNA0yc3rP?=
 =?us-ascii?Q?Hzbe3fICL72PKucspRsdjRyWn4w9KdWbRc8ZokIdj+xTbc90bL9EMigCA0Hr?=
 =?us-ascii?Q?nbydr9PDKGJk5AOzy9Y5qu8ZFFYEzmo+XdevjCTKz7MMLu72tC8dTKi7RAqv?=
 =?us-ascii?Q?0JDMRzyjmo3OmfqMAI8CvB9L30Gc+x6pLbQsRa/tj/xGaJoJn31zoMzr9ejX?=
 =?us-ascii?Q?fC1NiZGnLv7JIG0FlEQJ5/KYzfaRPJyyP774N5iSxiSK0RF3g1a2CXLDDV0z?=
 =?us-ascii?Q?eqUkZwM3C75A+H3X5eE3CEYzWU77dfUcYDrEyfdBOIbchX4XaY9CzWzjPniR?=
 =?us-ascii?Q?pN7bg+QUwAhW1RNd8nrrevHWZcX2oyhBvHpsBgTYhlKdYjOH8l2WR74LBxhe?=
 =?us-ascii?Q?ekDR2iQ2C7vdeDsjiVh6pbs7dB3nYEwviu5b+qjW5UnHKsXm997MRApWkcG3?=
 =?us-ascii?Q?YxogY/DfTnir9YsWjEg3p9J6j2AtgA0m/aGsoe5GHcnIq3n5GAlJjhHnOoBX?=
 =?us-ascii?Q?kDYXfRXhVU9smgX11NTEQDZPAi4U7pgvJ1AAaaKx/KzOt5rbX2KX3EBsIA4M?=
 =?us-ascii?Q?D/7Lws8kMkOmW3t183K+FQsy4/QPqxJ+SwEuD/9ycRMTqzffjwL8Mg2N3uQK?=
 =?us-ascii?Q?iZgpRTJeH0ANK92sxpaWGOeEb1GFK2PjygJ+E0XgVCo3RNwYgajX9ECjc5vy?=
 =?us-ascii?Q?NDu3cq4Ftq+KfwWyy0K9fXEWa3MLvPEQAPxgDo/sLFxjC1zBqDFjvW7j/w3u?=
 =?us-ascii?Q?A/PHZAk+hwoX6y/lhw6/hK1kOehEroa2MKMVW1N8BLk2yHu02OQSW3tuc80S?=
 =?us-ascii?Q?bLvRKXslhnQeLgBngOkd0eNZbx3GLMvn1TTAnlNQ4K9vbL8lUbKx0zL0Qsmz?=
 =?us-ascii?Q?xYpOVaUigecodoN5hUYmA19NpwM7Y11M3o//hWxWz99wOLWSaTCdjy2uYx4o?=
 =?us-ascii?Q?jmZcPAkx0AiRivMhNhnrTivDdr2zFPJW+9psY+N3gqqgpTKqJnYy4Q3aTmlc?=
 =?us-ascii?Q?aIkTyBMtrtm3ibWAiJi6cE8+s5ShsyFdo6BCF3jF+YE7KzXXJopfabJyD4Vm?=
 =?us-ascii?Q?zuiZtJ30+QcnU2OzPPPhZazBLddEJpqla8FlHRgWrPbiowKqfTGxtNSku1UU?=
 =?us-ascii?Q?MPwUR1P1NUHobj1B9BhVzmRoG8zsCW1Xia9maM8DRnLYG9IsThhE5+8+148L?=
 =?us-ascii?Q?5uRtxlW6ZRdtxsAUJdDO72Mn6WTaleeQkYPvRH5KiXId+va2/wZINxJUKP02?=
 =?us-ascii?Q?TiE+65yjVWVgDrMzXwcVBhF0rgbGhbNJ7WKwiO4k8SKPwO3ZjdF+5jeaMDJd?=
 =?us-ascii?Q?8G5Ae6xnLkaPN6v2taVJ27fcML1NgShxKzokWCMP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5be749-f730-4594-f758-08de11398078
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:06:20.1160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P72ikwIWTGHLBR3yYQ7kxpvR9Fh+5QKBkBKD43wAE+L2fzLm+pRO0eEvX+4AuoFzcYI4LukqDy8M7GCGgSfKvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11879
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

On Fri, Oct 17, 2025 at 08:54:12PM +0530, Kaustabh Chakraborty wrote:
>MMC HS200 and HS400 modes are already supported by the Exynos DW-MMC
>driver in mainline Linux. Using that as reference, add support in the
>U-Boot driver.
>
>The maximum frequency was capped to 50000000, increase it to 200000000,
>which is the required frequency for HS200/HS400. Moreover, add
>MMC_MODE_HS200 and MMC_MODE_HS400 to host capailities. These changes
>allow both host and card to recognize support for HS200/HS400.
>
>This change also includes a new ops function, namely execute_tuning.
>Implementing it would mean that we can no longer rely on the default ops
>provided by dw_mmc.c, thus a new ops instance is created with proper
>fields. The execute_tuning function is modeled after the one available
>in the Linux driver.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
