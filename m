Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D46D6CA101F
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 02:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F07C831C2;
	Thu, 11 Sep 2025 04:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="N5NkU603";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F82A83253; Thu, 11 Sep 2025 04:01:00 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CDF08319C
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 04:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiUX7xv7mCyL3eCugOJlhib0lB0ynBbD9gzgS0lx24T4WFwyxlaJXAUfapAAlbUUoj73vnuduFwm/wU4bBVogpUFc/V8SjmttB7kCJm+A9m/P0u/RDOYs6TKmhemHtc4YokyLq2TarjeSNRqYrY0+g3INt8Z1vCq5GcStcNMFJyNd4YS8l7alLUkNoDS6IfzO8g31D9EkywiiJcl85p1knz7tYZYC3iraaLCwOgVT4hpvGiVavPAPaQdjG2Eie9hWEP0BBbOH7J67wMVYwwIbgUzlyQfg3dUsHBakL66WxRBMxp7Yj0H9HT1f7RC3ERyuHBQTMsmN346k3NKyy4Mug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UT08fwdSJNqXWKz4ASJCV10vIBFAAlHGTF2y47jGf4c=;
 b=Z80gpVU6SxJfhdKuxx6ZAalthFLTliZSb0VaKSCTK3slmtTKXttMEzYpQD6F+phL7giU1fkoxm7V+j61kAtPRpzsbXv8QC666B4q8nzn2ohCY1v7nW1ZxYto82rvsiWi9H+Bb87qA9oy7cZqV/o41bUsx5YOHsAtkzMyzDS4yZYddIwZZ/bm38TLU4LPcmwO5dthjYh+DdmBCks2myahV0EfmeFMsvSfgeEj4ysxBPEyLIASVmMiTUwallUx75bhK31qpbVzKXTD+Do+hff0q3wHi3acXdSA+mUc4OXtNpOZZ2OKiBWdt2ShrKKF39jnBwhHA6u+eO6PTF7uDT99OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UT08fwdSJNqXWKz4ASJCV10vIBFAAlHGTF2y47jGf4c=;
 b=N5NkU603jDImsXfoSyN2JEwL85Q4AcL3r7dMBhSb1H2Y+owq0ipCuIaXPX9Jsn3vQNKQVKKyQH1Fg8/4ClKZcFL0OJBI67su3m0Yms1CM1gYlqfA/VSQur2J3KSgR6ccGYKGXcUJTdGBzy4UxCroBljOEbeZNRQwosJLdaxA3cdkOQad3Ce7uUiQ7brSAxgKNwL6kVBQSIElKYVrpgxakB2Kof8C5Rm5DNjIX9jqgK/Jxns35tU7gooQOeK3OOW2CZgEXf6HWBnYxVkXPRsYAqYtAC2FtC7BZll/Cy3rQgEaYIycA7TFjy9gZqrMHvqVExSCOVoOnXSJITX4CSs89w==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH2PR03MB5176.namprd03.prod.outlook.com (2603:10b6:610:97::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Thu, 11 Sep
 2025 02:00:55 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 02:00:55 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>
Subject: RE: [PATCH v2 2/3] drivers: clk: agilex: Support for enable/disable
 API
Thread-Topic: [PATCH v2 2/3] drivers: clk: agilex: Support for enable/disable
 API
Thread-Index: AQHcIS9FGTBHxCeMfk2PtxU1WYC+LLSNPVrQ
Date: Thu, 11 Sep 2025 02:00:55 +0000
Message-ID: <LV8PR03MB81375364E817DEEDE7572252A709A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250909021116.12599-1-alif.zakuan.yuslaimi@altera.com>
 <20250909021116.12599-3-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250909021116.12599-3-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH2PR03MB5176:EE_
x-ms-office365-filtering-correlation-id: 872146b3-c4da-4b81-2d36-08ddf0d70b22
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ueFozq17ad+TadSN3jOER/qO7WH/jnJUEeY5x3amMXw/tfllJn/38rsiPHzi?=
 =?us-ascii?Q?NZImlRtnDqqrMf3DBHmP7ChdOSOu/Ct/Gr113VxgDW3D0ZVH89PKQYhRpJ81?=
 =?us-ascii?Q?KYsU3aRCZDNiw07Q9XMrzXBpdEx+KU1hdp5SJ5s1EOIZfXVudLXQmC/+YquD?=
 =?us-ascii?Q?dEGD1kHeDD/fORsGkPVIMa+sNTTdK+DmZCFNG6lrakf/VcT7A0bVNhdokYOO?=
 =?us-ascii?Q?8OU8GOuvHK3/0nB4jLNZsJd3Lo+tty99PvfOL+VMtdKaneG3c9y8IDDi20dO?=
 =?us-ascii?Q?w7m4rlB9ZSD7B7DtYIjPXoX0GMdFz8uiaUpWg70BUayTiH/08xpKorTICTiC?=
 =?us-ascii?Q?uOsgqvvFmlY6MZ7sK2zBvqlp0tk3lT/n5IxQnAENFaDRno8yPmn3vvG831Pb?=
 =?us-ascii?Q?wLILzXNM/8LOlVOtfAxTmq39JA5Q7E9dojzLrHTMqyTZmpXeZrRsrM5nkNoN?=
 =?us-ascii?Q?IFt2Vj3Kxzc/7rajLYwuySn6bvbbw6WC8YN788ekpaMnuCEl0YUoDUREiV7O?=
 =?us-ascii?Q?/PiXJpRVwcZXJ2NhbzNARSWqeI+CrblNthxlySfqDKMIDWntqth62PMY6aWI?=
 =?us-ascii?Q?AZUTYkqg/1IaC1L9mY73hMBuGqfaADJZebEmDwVyF3reTrovl0ZA0+rZ+nCx?=
 =?us-ascii?Q?InadSGIBNu762E3YQtTeF5aOhjbqA0kxhvRSVzWKFdAeM9FbCTz3OEEtY6ao?=
 =?us-ascii?Q?f69UdjXjW8alm3CbxQQP3PA6GPH3EE9uXbL65acXBaWLCYpprfcwL7kcrTOz?=
 =?us-ascii?Q?iI9zc4fCPTeDrEbMEmUcivLO1I/nNOKXMnwtcQAdFE/Ti+HrRDzjQfmbsu9j?=
 =?us-ascii?Q?1P2ub6D+XTuDv5aFA7yQDSKBNJ0BHiJxkwH+3wAgrxIAI1/IULDgbhLbNJQ0?=
 =?us-ascii?Q?51Gle/ll+cV8EH0IEE0RFo0jGryq9yEukj8jYN4ynAHJWeWfjOKgwyXn2bNu?=
 =?us-ascii?Q?swdC/3r8LyrP1Ly8PaG0CZgZLk9PeOkL2lwgwWPMIYo1S4HqZdQ7gQcsNVgH?=
 =?us-ascii?Q?pGazVQJh9GXkRkruBfgaPlSWQWlngMp3kt3eO9eucYMWBck8RnnImJSUfJIS?=
 =?us-ascii?Q?tTj0/A6lHLZ/gdBKvkrwK8KV+lC616fJZ5HGPJ+DSwAy7Ad/BqvBQg4OK5G9?=
 =?us-ascii?Q?DMHywAnZcEGYMOxJA3gLhN6f01QzJ1e80auKe/M8dSHS2aIJTR1A43j9f+1H?=
 =?us-ascii?Q?FskBCk7NPck7KOHUf9gpppXfdxSjwulVhXDIGbpLUurE4KCvCUJzrIRdgRMV?=
 =?us-ascii?Q?2ZoU238gqiGC2FCrKcT9tSx5Pi7WJ21GHYrY2uw6/ohZh2dOybt+AihTWKHp?=
 =?us-ascii?Q?gArQ4g8zQ0tI77y9aUDG5qN0qxkZZn1pe9v9ZiEu20l6eoWiphut6Hn3CSvd?=
 =?us-ascii?Q?yv3UGUlRhCCQZiIVTJREsK+KB8hzgzHfDfnrRsBNgNT6n+4FM81xjIDa9AqZ?=
 =?us-ascii?Q?TmddpcF3F0Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j0c+3AjpyY21mFQKkuK2CCWa4YE4q/9VjI1aBOuwlkxBCvxlcS6NmNdvMHz2?=
 =?us-ascii?Q?CzBSwP7dPUSkjlk/oiZhJDfhllift2fBdqJc+ZLLmTVeuK3EvIdsYRyevCHb?=
 =?us-ascii?Q?oiqaaXG5EsjHrkDU+Qff9lctKfUdWiTSEAwHxRylkHVsk+87ikM9T+cDULuX?=
 =?us-ascii?Q?rW3lULXef1jXtlkQkAylONx3A2NZbBAx5rXZhKS3mD3nVHr+C+YxLF8AU8fu?=
 =?us-ascii?Q?XYo+eUeECjddCTOc2CChoBZbg/WYaZV24wfXNtxSlhz6owaaKJxBxq3zbjMq?=
 =?us-ascii?Q?dkDZXjSNCG8xnVvkHbSrtIzrNKWSn2DsMZtOtxxd85fz3cZsg/KTlafO2DHS?=
 =?us-ascii?Q?w+FxWL4oMOaFogHTE2O3MQmlU5hOGT4qcoUQCQ2hygi1ktUTDKLE+KsKL+cV?=
 =?us-ascii?Q?ZhOqpieEAV9DKAjbdmDPjZ/pogk7st+ZyTrsTQFXfKfYnY7dY1ciTnpgy7hH?=
 =?us-ascii?Q?ca+WFcts+Hn4lYD0Q2737JXl3sGFoJlgqkhosTUlyc38RMSrGOWnldNRx2b6?=
 =?us-ascii?Q?kTAsv20VujqQyM/7u/ShBODoD44Lw3gxI4N1urhvOd+u0l1Kg81a5VIfvcQF?=
 =?us-ascii?Q?i+EU0C/ATKmEJtD/ySKSc/BlkIN8uLK8zpAXp6leKhsiUjEr2pQI43dojdWt?=
 =?us-ascii?Q?i/elDy3dHWeO+xSV6Nmdjg2nIxAa3uRpJbbZFtN1DVBVwDBg8z/cYf+Y1yHG?=
 =?us-ascii?Q?lrcxAIGoN5QPX2neq48AQneDOl/lNYkySNdswSQO3F/nYUM9h2HFrYVcyKgx?=
 =?us-ascii?Q?W8N1nQTGEzt8SdGQ5Bjqn5malgel1Bmt8DsnveWhMWV/l4mJX9voXffgVuEA?=
 =?us-ascii?Q?MtQ7UHWSbPs4P4YUqoNL4yQhFbVe8VvnSGaUTyvNgSYCSHLWadPbgUJ2jbN4?=
 =?us-ascii?Q?i5weVZ/mdxX1lZur+wgDB6O1oC7Nz/tM7O6ucVL5KE6dUuMwyyoh+aR3kGX1?=
 =?us-ascii?Q?2odb6KUXR+eJMjy81s6HyKCiI/aR1lTWQbfPtNpS+px3kUKQ+PWQT38Z5V/5?=
 =?us-ascii?Q?sGcR3gRK953amXdubANQunmPUAO+G8ucsXzIr6ceJVpw3AGMBp9m6UfntzKu?=
 =?us-ascii?Q?luXnpqhr4/oJIYAWICMJarHTUPf6ZIL4fqTlicjjE9pw5fC0AByg+53hMg4v?=
 =?us-ascii?Q?d65/Y33GRNy6G11KMwZvfUZjc9fO1utfbSOirixh3Jdrz/CTGDJgw4drPSOe?=
 =?us-ascii?Q?EmXrReRn5Ih7Rwy1+OiS+ti35FrFra4Ypq2qTc4iNpfAAhPSzwNzyzGM3Bdf?=
 =?us-ascii?Q?5g2vjxhwZJTeECNBYcv1XxwILjwSfwxI390fcp8mSo+nbfzrManTiKaFRR9O?=
 =?us-ascii?Q?5s5tEZn5/LL3uQSoOdmUgXmSkWzugUFCOvZYTw0VlESvRHKh+P2N60Q8v6va?=
 =?us-ascii?Q?N0TFbx/MH0AdwOJ9gn06Y+CP5ipogDx3oEh1gbTq/Sq8JmLqZdNFPB7YQmZN?=
 =?us-ascii?Q?Q1nh6XLx4MqhIAFabBaxj1UD0OHw7ta+8PZ6P69c6m58QUtM8pRzgjWxdWMj?=
 =?us-ascii?Q?t0i7F+epmKMd8XuHdj0tuvH1nZJlmAFdL1YPFYIQYnYSvlMuWsmcYQM/t7W/?=
 =?us-ascii?Q?AxbL8kPjMuhnwvDaL5Qegi+DP5a+IqFSRu23U1Km?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872146b3-c4da-4b81-2d36-08ddf0d70b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 02:00:55.1382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlgqTBDL+E6fPTgXvgy461/D1mgu3IVqRfQP8IvKkqfP8JVm2FXmkSwaBv/Wpwg0z6G0GiVc77c7FP482iHxEdT45eo08IVRTZdKqZdBHyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5176
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



> -----Original Message-----
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Tuesday, September 9, 2025 10:11 AM
> To: u-boot@lists.denx.de
> Cc: Tom Rini <trini@konsulko.com>; Lukasz Majewski <lukma@denx.de>;
> Sean Anderson <seanga2@gmail.com>; Peng Fan <peng.fan@nxp.com>;
> Jaehoon Chung <jh80.chung@samsung.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Simon Glass <sjg@chromium.org>; Marek
> Vasut <marek.vasut+renesas@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v2 2/3] drivers: clk: agilex: Support for enable/disable =
API
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Update Agilex clock driver to support enabling or disabling the periphera=
l
> clocks via clock driver model APIs.
>=20
> The caller will pass the clock ID to this driver and the driver will then=
 proceed
> to manipulate the desired bit in the Agilex clock manager peripheral PLL
> register based on the given clock ID.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  drivers/clk/altera/clk-agilex.c | 120
> ++++++++++++++++++++++++++++++++  drivers/clk/altera/clk-agilex.h |
> 20 ++++++
>  2 files changed, 140 insertions(+)
>=20
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agi=
lex.c
> index 242740a4b00..46b04895cc5 100644
> --- a/drivers/clk/altera/clk-agilex.c
> +++ b/drivers/clk/altera/clk-agilex.c
> @@ -22,6 +22,8 @@ DECLARE_GLOBAL_DATA_PTR;
>=20
>  struct socfpga_clk_plat {
>  	void __iomem *regs;
> +	int pllgrp;
> +	int bitmask;
>  };
>=20
>  /*
> @@ -643,8 +645,125 @@ static ulong socfpga_clk_get_rate(struct clk *clk)
>  	}
>  }
>=20
> +static int bitmask_from_clk_id(struct clk *clk) {
> +	struct socfpga_clk_plat *plat =3D dev_get_plat(clk->dev);
> +
> +	switch (clk->id) {
> +	case AGILEX_MPU_CLK:
> +		plat->pllgrp =3D CLKMGR_MAINPLL_EN;
> +		plat->bitmask =3D CLKMGR_MAINPLLGRP_EN_MPUCLK_MASK;
> +		break;
> +	case AGILEX_L4_MAIN_CLK:
> +		plat->pllgrp =3D CLKMGR_MAINPLL_EN;
> +		plat->bitmask =3D
> CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK;
> +		break;
> +	case AGILEX_L4_MP_CLK:
> +		plat->pllgrp =3D CLKMGR_MAINPLL_EN;
> +		plat->bitmask =3D
> CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK;
> +		break;
> +	case AGILEX_L4_SP_CLK:
> +		plat->pllgrp =3D CLKMGR_MAINPLL_EN;
> +		plat->bitmask =3D CLKMGR_MAINPLLGRP_EN_L4SPCLK_MASK;
> +		break;
> +	case AGILEX_CS_AT_CLK:
> +		plat->pllgrp =3D CLKMGR_MAINPLL_EN;
> +		plat->bitmask =3D CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
> +		break;
> +	case AGILEX_CS_TRACE_CLK:
> +		plat->pllgrp =3D CLKMGR_MAINPLL_EN;
> +		plat->bitmask =3D CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
> +		break;
> +	case AGILEX_CS_PDBG_CLK:
> +		plat->pllgrp =3D CLKMGR_MAINPLL_EN;
> +		plat->bitmask =3D CLKMGR_MAINPLLGRP_EN_CSCLK_MASK;
> +		break;
> +	case AGILEX_CS_TIMER_CLK:
> +		plat->pllgrp =3D CLKMGR_MAINPLL_EN;
> +		plat->bitmask =3D
> CLKMGR_MAINPLLGRP_EN_CSTIMERCLK_MASK;
> +		break;
> +	case AGILEX_S2F_USER0_CLK:
> +		plat->pllgrp =3D CLKMGR_MAINPLL_EN;
> +		plat->bitmask =3D
> CLKMGR_MAINPLLGRP_EN_S2FUSER0CLK_MASK;
> +		break;
> +	case AGILEX_EMAC0_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D CLKMGR_PERPLLGRP_EN_EMAC0CLK_MASK;
> +		break;
> +	case AGILEX_EMAC1_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D CLKMGR_PERPLLGRP_EN_EMAC1CLK_MASK;
> +		break;
> +	case AGILEX_EMAC2_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D CLKMGR_PERPLLGRP_EN_EMAC2CLK_MASK;
> +		break;
> +	case AGILEX_EMAC_PTP_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D
> CLKMGR_PERPLLGRP_EN_EMACPTPCLK_MASK;
> +		break;
> +	case AGILEX_GPIO_DB_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D
> CLKMGR_PERPLLGRP_EN_GPIODBCLK_MASK;
> +		break;
> +	case AGILEX_SDMMC_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D
> CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK;
> +		break;
> +	case AGILEX_S2F_USER1_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D
> CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK;
> +		break;
> +	case AGILEX_PSI_REF_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK;
> +		break;
> +	case AGILEX_USB_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D CLKMGR_PERPLLGRP_EN_USBCLK_MASK;
> +		break;
> +	case AGILEX_SPI_M_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK;
> +		break;
> +	case AGILEX_NAND_CLK:
> +		plat->pllgrp =3D CLKMGR_PERPLL_EN;
> +		plat->bitmask =3D CLKMGR_PERPLLGRP_EN_NANDCLK_MASK;
> +		break;
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
>  static int socfpga_clk_enable(struct clk *clk)  {
> +	struct socfpga_clk_plat *plat =3D dev_get_plat(clk->dev);
> +	uintptr_t base_addr =3D (uintptr_t)plat->regs;
> +	int ret;
> +
> +	ret =3D bitmask_from_clk_id(clk);
> +	if (ret)
> +		return ret;
> +
> +	setbits_le32(base_addr + plat->pllgrp, plat->bitmask);
> +
> +	return 0;
> +}
> +
> +static int socfpga_clk_disable(struct clk *clk) {
> +	struct socfpga_clk_plat *plat =3D dev_get_plat(clk->dev);
> +	uintptr_t base_addr =3D (uintptr_t)plat->regs;
> +	int ret;
> +
> +	ret =3D bitmask_from_clk_id(clk);
> +	if (ret)
> +		return ret;
> +
> +	clrbits_le32(base_addr + plat->pllgrp, plat->bitmask);
> +
>  	return 0;
>  }
>=20
> @@ -672,6 +791,7 @@ static int socfpga_clk_of_to_plat(struct udevice *dev=
)
>=20
>  static struct clk_ops socfpga_clk_ops =3D {
>  	.enable		=3D socfpga_clk_enable,
> +	.disable	=3D socfpga_clk_disable,
>  	.get_rate	=3D socfpga_clk_get_rate,
>  };
>=20
> diff --git a/drivers/clk/altera/clk-agilex.h b/drivers/clk/altera/clk-agi=
lex.h
> index b3e8841a512..be639957940 100644
> --- a/drivers/clk/altera/clk-agilex.h
> +++ b/drivers/clk/altera/clk-agilex.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (C) 2019 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
>  #ifndef	_CLK_AGILEX_
> @@ -210,7 +211,26 @@ struct cm_config {
>=20
>  #define CLKMGR_LOSTLOCK_SET_MASK		BIT(0)
>=20
> +#define CLKMGR_MAINPLLGRP_EN_MPUCLK_MASK		BIT(0)
> +#define CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK		BIT(1)
> +#define CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK		BIT(2)
> +#define CLKMGR_MAINPLLGRP_EN_L4SPCLK_MASK		BIT(3)
> +#define CLKMGR_MAINPLLGRP_EN_CSCLK_MASK		BIT(4)
> +#define CLKMGR_MAINPLLGRP_EN_CSTIMERCLK_MASK		BIT(5)
> +#define CLKMGR_MAINPLLGRP_EN_S2FUSER0CLK_MASK		BIT(6)
> +
> +#define CLKMGR_PERPLLGRP_EN_EMAC0CLK_MASK		BIT(0)
> +#define CLKMGR_PERPLLGRP_EN_EMAC1CLK_MASK		BIT(1)
> +#define CLKMGR_PERPLLGRP_EN_EMAC2CLK_MASK		BIT(2)
> +#define CLKMGR_PERPLLGRP_EN_EMACPTPCLK_MASK		BIT(3)
> +#define CLKMGR_PERPLLGRP_EN_GPIODBCLK_MASK		BIT(4)
>  #define CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK		BIT(5)
> +#define CLKMGR_PERPLLGRP_EN_S2FUSER1CLK_MASK		BIT(6)
> +#define CLKMGR_PERPLLGRP_EN_PSIREFCLK_MASK		BIT(7)
> +#define CLKMGR_PERPLLGRP_EN_USBCLK_MASK		BIT(8)
> +#define CLKMGR_PERPLLGRP_EN_SPIMCLK_MASK		BIT(9)
> +#define CLKMGR_PERPLLGRP_EN_NANDCLK_MASK		BIT(10)
> +
>  #define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_OFFSET	26
>  #define CLKMGR_PERPLLGRP_EMACCTL_EMAC0SELB_MASK		BIT(26)
>  #define CLKMGR_PERPLLGRP_EMACCTL_EMAC1SELB_OFFSET	27
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

