Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD2C87FCF
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 03:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1FE840AB;
	Tue,  5 Aug 2025 05:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x+9F9bPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3245A840DE; Tue,  5 Aug 2025 05:01:44 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF31C83AEE
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 05:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z0YfoaHD2pKACLmS158bbuLBaAYh25WJsdXht+ZpvMrYduvhdVyrwb3ygDV8+ObeZaobQql4yQGjnwtWhUUy/zOWT++dckuoDcCdlO06k6ah/6Nym6zrYo53rS9rbnMd6FEjpMR5PNyT0Mq1kwxmEqh4IjgmMc8bUPGQbP1Rilg/7sIlHBOIqu/u5OkovFbOCO8PZVqyqLUjd3GMXByob23n5by6X9dbt+1mroBoh3HnYwgXC0PiHCxD/dTgeQtlB2+3p+QB3noegujfv2+WquEla2uIWJsQxJ3hFHUaql7xdIoGCIRAwdFtsC/MtzRpiwQqtdyMNV5cgCxw3CqOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTre6jtg4kCGpjn8SrLCSIEbRray3c6gBqUnhLUhH4M=;
 b=w+jd91Wub2cvfnnw/HnCI9zV/VOBTY7Gl6jSF4hQ0bUfmC1R6vCa4kgD5t8kRlhSBkht6E9KuEbj0SVri5ywZp4qbzOGPWADYdFtHOY59GgpFLlwWtfIaLqQvrapMUC+vW63JhuACEu+YYnVLCcy+MIlLquF7qy1n55N/EyRYmasCrKbubjm/d+05POaRDqnp8Jm9igxERhTMtCpRHvoQ0f/hsS7HdMk6dufLv7PY+AJ2HFgZ2yeU52/eNcS8+GROvkCgsRlAQYfSVDwf2eLXvs4exotmTcDnuKtwf0OtdVPgEkYZy5wJBt3aU7w4WdMjQQLPqF3aTMhd6o8IjfuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTre6jtg4kCGpjn8SrLCSIEbRray3c6gBqUnhLUhH4M=;
 b=x+9F9bPa1EAd0ThJpDPaWgWM4C3Hxz75dVEEfAWtOPLWLziUPW9h/6wazgSbxMoA2jlxfA+SSzvaAM7wjusRaegyHoAospszzFZwGJ36cCYE0zHCucWIM0tLl0T2kQbXPzoZraFVaACABsRpNQ3orLsr5ZrCrQRQHMy7qix16zM2Ighu83uz8EMFhw79Cp5QgJBdrMKOF0Jy+koKP5z+LBw5VEAyt9kejSAQ+6IZzcF4ywlsLHqknZMBO7WwZ3j3TByaE7cRNJiQZ7/6yf4vFSpTmHECZkvBXobisi0XX/n6VELkYK5zswYxAGaoqpo57AXHRqWnd71sqn6qDddydw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 03:01:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 03:01:40 +0000
Date: Tue, 5 Aug 2025 12:12:27 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Judith Mendez <jm@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] mmc: am654_sdhci: Disable HS400 for AM62P SR1.0 and
 SR1.1
Message-ID: <20250805041227.GG29103@nxa18884-linux.ap.freescale.net>
References: <20250804233718.1471877-1-jm@ti.com>
 <20250804233718.1471877-3-jm@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804233718.1471877-3-jm@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 2340a5f7-1d84-4dce-1073-08ddd3cc6638
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MtH9Gy0em+cjyzfwGq0Y5GhxESwZh1tOJJP1oc6hrdcoGF3+39hQJ913OI8Z?=
 =?us-ascii?Q?bQue0h/mhIvZtVOzNoSPmu5k0N7eKJfTuj06P2MR6IOZXP6K+L7dgypkjkS5?=
 =?us-ascii?Q?mPzlmyNtiT2jvF2ki+1EFQfSHZFpUPL1INsBkTghHC8bsH8ea9kAgWK0Pf7K?=
 =?us-ascii?Q?mgNQtZC//NSNAn60hSUrz5gxY6htYlEYo6nIRHTaBG2fk43JBCaEQXPuN0Ns?=
 =?us-ascii?Q?hRgH9w0hw8z35Lf94l2CULTyTLQFqxKGETknZL5y0drn0pj6szTsA9ELwL1E?=
 =?us-ascii?Q?l4W6Al3YgEvL0mtVg3hywB5/EhJNDqk5xwrbzSUp87z/DVbFJRlmwYiwCz4z?=
 =?us-ascii?Q?em1ki4NGbQhgN9W7ErSbVTWHvKI4aS24m43892vwdUAl9zqyGX7URKKpXWgu?=
 =?us-ascii?Q?GbmngQNNIp7iDcvO+iAnDIqsNTWLrAjdyO6J2FrIlgbCh1miLqk5pmsXg6NA?=
 =?us-ascii?Q?PBEb7ZaXaX84o1M0o+DwAIWzDHPqRoT+SyRo+QLUC+7XHnZxTFIzTe0JvBFM?=
 =?us-ascii?Q?0CWSr3q+ZVIsM+12Frg+RocqrzXb4ICQS1nEWoJcwQVUd6PvGC5j18f9hjd4?=
 =?us-ascii?Q?9+1XKCYRrYOTCnPBCy4qJEhL9XpfZghv2BZZnOArp5Bh7sv9MtHbJNFYLHux?=
 =?us-ascii?Q?qTHPQSFWk0XNoWUmFxoJqO37zeh85PJW/mJAVpggGnLBq1ps6saAK/nyj199?=
 =?us-ascii?Q?GDKzuu1qVqn9vph07La0Ro12fAFLuM3XwV16DExTi7+zJ2/Ss9xDgbzFo6Ip?=
 =?us-ascii?Q?iVmpn5X35kb4P91W6EPY9F77FIykaKoQjh1Jn6QxbE7ketMZyhJ31usdFeWu?=
 =?us-ascii?Q?PgMx1PlABiwsfbEbgEPHkh57kLugnPq2hBRV/ASIGiQNh76l4tHfjamH3mGQ?=
 =?us-ascii?Q?GfvBiS0qbsWMDKHxmtHaAMiOKhHHqdor7YGJ7TpeI8ZTY9zm5ibfz7HYmK9U?=
 =?us-ascii?Q?9Rfzlu0DRixui3bPyDm3b02Zs9R+YdWV7BuyKX5J35o5O8OEvHLYrGUjGpKU?=
 =?us-ascii?Q?XrazJN/vw8zzAI/+yJaChS5dKud1X/azO/PW87TgdSSs52NCRsVwruWZ2s+E?=
 =?us-ascii?Q?HCvz2UJZECSGb1XzirhvIMZ+Yw50FLhIdTHJEi+y57hbZ62tKZIivp5uIWeM?=
 =?us-ascii?Q?N5MZkulN8GMMxQZ/i0Q7wBwaxXkYBmVmTWU9kfYX3gLQEIPORbufg0XQyhJ6?=
 =?us-ascii?Q?aUqcQakMQGhgqeP8RHA2ZOIHxYgnGi5yDKcQkN9KfMEXtVvOsO/effjHzG+o?=
 =?us-ascii?Q?yN6C6BZ3GRwbBTFIsj9e32FS0RdgrwXclCjlrMMGCF1F+3XZJEw2hGPlr8f2?=
 =?us-ascii?Q?C3dEXhnf7AGpYpED5Al/KgRuBkDgT+mhHmFJtWGFcL6ZlLjnrPmtXhTj1cxl?=
 =?us-ascii?Q?a9xotC2V1dSDDFeACac/ViozW6hA2Yxu/nH401dq34oJpJ9JAKMRZpE65m4O?=
 =?us-ascii?Q?q8BB7VzhYMe/ECyj53WIxzImA9UX+gu1L/rgCSWZh8K4Mka9amtBaILieufi?=
 =?us-ascii?Q?mL4x56IwMhTWIPk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVcHrlsifEDRv1T7Q1mqrQrg6tT7iVDqRQUPQnxzI7FkzRSzIDT9jzD02jDd?=
 =?us-ascii?Q?cZPBw+nBN1qc/H1UcEkX7KCGCIP6uXrGByuj4enr0b9hdd9x7xlBSCyHxu5e?=
 =?us-ascii?Q?YNn9wyY/TLg9yDDux0LukFoPvAzUhIT7x++eBB2SxLh0D5HCA83hGVTtN5Py?=
 =?us-ascii?Q?CA7jX4mdSP4TKMeXKGnp9KTVims1INUkl1RxvfiCg6YBvgF7T1hxvTrC/uvP?=
 =?us-ascii?Q?GU+uBTbKe5bx6qwi5xJta2WfRfmcWnpr7HwvNkIDLX51t+3vYRx8qGWu/5cW?=
 =?us-ascii?Q?GhuG0QS5J1HHp46s9DFOIH/syaoj0Fbg8Gxot7iQ9i/clp7iMKfeeHGevfXC?=
 =?us-ascii?Q?ZyZtEpJYeJyLC5GlgTW509bJ7LjKD3PSQhTvZq+Nx1TGA1ff1jLz1LZfSQty?=
 =?us-ascii?Q?+aUV0g7pdk7d/QuhAgTJBa+aludsvG7sQzMVHfV1NfCtek+p2j6k9g8q7W0b?=
 =?us-ascii?Q?wPfBLjd9EebygLuxRUtUReI4iKXBEkTsVMmr+lVHNgRnUXijidtD8PjUTCEp?=
 =?us-ascii?Q?ThVIa6J1YTrIZcP6izedeZ6unllLb0qg9S2nGdNf9G8zyK/zAhwaq0POB1il?=
 =?us-ascii?Q?+AjjqUlw2n0DUAViYRswuEgW6UKqrO7VQXNNskNMPv0POXaozOLD9xSv8I0R?=
 =?us-ascii?Q?BDGj80tHt50glWEIGUIOSds2YMV+4ppxRAJM/+j8A0thXgWYaB5Xf2OtpMVa?=
 =?us-ascii?Q?PFVrKQMcDgiYSVZPdUTjjE/HTLHTS9Hlc6O/NlO2V0jLUEz8BqnRVipAUJwT?=
 =?us-ascii?Q?5LuSRHCoO4ZXfEQitRBteAoGKLKZjVvi4QL0Rq0WgNIuKpIUDwVgLFt/L9Lj?=
 =?us-ascii?Q?cjbFvnyl4KsCTKANEHZ7CZYQd0YZBH/WFN9+4Vcn7mBjnCOOKQskI5C2Bsf6?=
 =?us-ascii?Q?x5IFu9dTz1Vr1tvoEphE6Xt0wcGGgkkm7yL6hwPx7vRHSJE1GWLF5vIoVuzG?=
 =?us-ascii?Q?KaziCq5aO0bK8C52IQr9tp+BdZrtst7J1qsZ56zRryqUHUDHH9qAFbINLcLF?=
 =?us-ascii?Q?7k3wL/lrqaYq09+ovU+TvlgI1Ln3hLxkl4Brzt+kTDeGsS71LO/AkNOejMY0?=
 =?us-ascii?Q?gcNLBxq2Io8I2Wm1UqPtjEfz3e0BVkzW+Yrt/4ZeX5RE4A6p4JhkfZ/ZJxiY?=
 =?us-ascii?Q?djdcsJ7tEvy7BQ5Sg9UgtIwiL7TRRwxYjYkfG/Rs3ytYVo4qc7iAQKo+/kl2?=
 =?us-ascii?Q?6gJSXq/4QeAzsPtsgkG70dZJY1gLYXM7NUDHqe6cN3x79tzC0w9vzOQ0mA5k?=
 =?us-ascii?Q?e6x94NrZr5rgbfkqj1NoGFcuPamZ7nYMtp4sjMjjbCdouFjl011yK0TDaaxg?=
 =?us-ascii?Q?LSwew60bC1xUP4WkALRiFsAlOatsVSZYazF/cNMxayyIL6tYI+qSX4nRQICo?=
 =?us-ascii?Q?Ck8TTHf0ldblX4+jwwWT9xH9WcKR+NuPIFOm0EXFuxQTcPRDwisxCDoChrbi?=
 =?us-ascii?Q?U7oIzzyF2KZJgrcuOIt0eEVGeQnl+hupQuEjzwv9lzD7bot8iLTLRo5VDwHy?=
 =?us-ascii?Q?Laq47oXPOnvp0buJUPDkGeFn0Qeu+IAB42lzhZUKc/P7nHOhC+Zvmmh3Ioy5?=
 =?us-ascii?Q?BK8Kz0XgUI9gxmzp7YH3SvWqp//7fZnelLuION3B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2340a5f7-1d84-4dce-1073-08ddd3cc6638
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 03:01:40.0152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBeJlCmbzRFWPNddj3q58A879clv93aLhmK3STyyCgMtZ3/M0Yg9kO7wLf1KY9XinjX7sByaju4hTPidn0GD0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938
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

On Mon, Aug 04, 2025 at 06:37:18PM -0500, Judith Mendez wrote:
>AM62P SR1.0 and SR1.1 do not support HS400 due to errata i2458 [0] so
>add functionality to detect these SoC revisions and disable HS400.
>
>[0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
>Signed-off-by: Judith Mendez <jm@ti.com>

LGTM:
Reviewed-by: Peng Fan <peng.fan@nxp.com>
