Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186D6C3ABC3
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 04:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD2F82B07;
	Thu, 15 May 2025 06:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="I3QW5UBk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D516382B0F; Thu, 15 May 2025 06:24:39 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6071A82AC1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 06:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJvgErpGA8hdSz1yI2o22uGqzduw87mgtMQDyWiB5RBj1xEa0wrgIxrrr0cMCUu809IHmNyjO8uF7ypZz0ur3+lImYrMX+qzw8yptCwJhmeJCem82tVbEjqiX//c34l2af5wfqSzsm51XtUu07UyV2UPDWHBDOsqHWwI4afeYQsLNOF8Q/CvQJzXaU13nC9KmGYw+UXJrTbTr5qjhapAgCunJxc7USdDiXhrW9OenHqg8HwrN87tnyyT7LMPASsma1daKEoNI1HJy0EItPK+Hdg99jlbH5iKATDF7uBQQ55gbwguAiGfaegyDUvUwnJegA6VN97uIE+Icys1e+uivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Y4QcskVbwWLx/olt3NhJarDDc1i3k7cu76Sv8fJ9OA=;
 b=HG+Z9++Vsk6FkQvy9bdH9K6PVj0CfeWCyS8vnucyeToEODOF/R0cqGsNBtxy3TJ1Rf6Fn/eFIyekp5X7739zR6wlzA3bKJ9JbDNIrlzGRvBcjfdJr1klWjbKVdNMZ0kA8JgcZhHAGh8cXvmX03COyD4SnH48FIJvo3nrtQ7Q01ljGRZgbiVbgezMJyxIe3opZq6Trn4xZ4APLN4vAR94jSrE5cxw/0DQkSjR7pfkQLbjDPpHFZuETeSdmoa6GnVcTEgkh5LgekL2LaovzPvFcUAZJ1QHsb2RyOkWcjpPOvBIHle9bNSmqILF1QFHk0gl0vo6GR6+UgE97W0t2ruDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Y4QcskVbwWLx/olt3NhJarDDc1i3k7cu76Sv8fJ9OA=;
 b=I3QW5UBkbvkPEnoLO8xZOlm4rFr2Ngu2IHYgTEC3Oz8RvH36TV0M/AoMGO8Iy/IiC/+xfPPlfRpR1UjIFxZ2ackAu288i8VJz6S3GshqrcB/N3n9dZug6P/1zfLTpNUO7YnAmN+sUs4PIwZoFlBstnRrulIZro92uppIK8xaXIzF/Za8O00TjRAg8w10QNjEy2qnKAK783Sl+e+ndDIBmgyn6m7Ydc5wpqtIp8ZVi1UHRZVUCUqxMEWEHEYIZot26/JgWZwgx4EBx61IDKeb/zFy0eZR6MLyhNGs4rXk8tN7qrECJKdgiZQKUvNlCWHiYko5v+T0Vt7TX0mpdTAgig==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB6680.namprd03.prod.outlook.com (2603:10b6:510:b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 04:24:33 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 04:24:32 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 5/5] drivers: ddr: altera: Add ECC scrubbing with Dcache
 enabled
Thread-Topic: [PATCH 5/5] drivers: ddr: altera: Add ECC scrubbing with Dcache
 enabled
Thread-Index: AQHbvpEP8oBs6BeIx0SoVYtRks1aTbPTIsSA
Date: Thu, 15 May 2025 04:24:32 +0000
Message-ID: <LV8PR03MB813720C3BE2905D4DCA49DF4A790A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
 <20250506141246.6672-6-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250506141246.6672-6-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|PH0PR03MB6680:EE_
x-ms-office365-filtering-correlation-id: 4f598d21-91b9-482f-2bc4-08dd9368644c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XlDdkZ9RhgO8lmxc+nB+kyjZ/EGiPmZ4H/LcHoEsSRSydmWeDCldKvECR0F9?=
 =?us-ascii?Q?IBxUUoUejD5zoAjZXbSGOEasMkHoXjXxlFVIVrxxmzBpuWr+k9jytuDxLRyw?=
 =?us-ascii?Q?xCdgzb5kG9zlgleXFIBkS3cAuEqQpIZGHaZYzv3WtPPvW0cn3ZkyfjvWE7mz?=
 =?us-ascii?Q?YThkK08p08/p8Zi58MQDfM0VsgGTE8OR4oULadfMa9V8kwoXNexgw7o7vFXD?=
 =?us-ascii?Q?n9uEwyCqLozk1ycGaBOln+ecWIa9cY6ncVVHHR9YW748rHGi/wLtDocA21fZ?=
 =?us-ascii?Q?qMOh6BR8fYDgLyNJD9eCFJdamhac6iZQSR0MRYrF4ty0DbwCnFxq1gdn9RTi?=
 =?us-ascii?Q?+4vcxyJWGNtUNtxRtdr9zeTBtIWDODe+1uyu6d8fzhS2F2bPlxw1PT+gzizu?=
 =?us-ascii?Q?UXzd8LLlpD61RzTktEDwJJsv+XFWzkb4nStG3VrY/D+bIg966+AhhX6PwNKg?=
 =?us-ascii?Q?JB6lNViKd0/SY2pW5jzMj4pbWMZ/IA+lRYMRwkafbs7bea19/FNooH2Z+gFT?=
 =?us-ascii?Q?9D5bvXTwD87G7dE+kpXR+5kvG7GjjDzhHzXI1xF6zZezQM/AtPfNJPJL1P/i?=
 =?us-ascii?Q?j+WyVSORsxYpJVNcm7Tw+P7V2ifHTU6MTxok3lHxv9HmmSvo753/4C7wZLZ4?=
 =?us-ascii?Q?eT29dnenQDnDxuzofFxaTuZ2O6n3bVD/C+MkW8Lc9X55CJ9pQnlt5UtLlPjk?=
 =?us-ascii?Q?7BRMkh3zvWU4R6IsX69HWh6WQMzjGBhEh65QwNcd3ppkym7bC9VUcWK6l++Q?=
 =?us-ascii?Q?5W6vQhfD2+sIuRjLnxlo0aDSQXMQS0mZFiMXN9IJv1f96YyTTlioR4NYGGLS?=
 =?us-ascii?Q?jt5aBIVtO5kTKNMgGFcRR1yagtTO/g5XJtyxW6vPm3IQZCruma/FNw7Nx+wt?=
 =?us-ascii?Q?+XCCs/w01NCM38YdgYKtKrOx75HrX6YgzE/RLhC86IV5zYMV3SHg7Yp2eInb?=
 =?us-ascii?Q?Dg/Bpf2HnKq9XzkfOhWcPa3ev4CxCNBDFhjy1ZzHoG25pDx8WKTRfidXvsMh?=
 =?us-ascii?Q?XRqTGzp3tbOjRm4UgRPFxqz5Y8HF0xUnd9wtsX17pForOuSr+CvSKzmmgJ7/?=
 =?us-ascii?Q?FDwLLyQpZUGLk1XJJRhLyMhJc33RiQQdYQ3zWVHfPQ4l6+xO2Cr+CbSa2xUl?=
 =?us-ascii?Q?5cz4wl316Hgl6BVG1IqfwodkfAvP0J5zrH8iDxtzWUtkYC32rE6PEVuadIsZ?=
 =?us-ascii?Q?CaeDT98XGcN77UHR8myssq2TzGFA6aN1TyY9yoKfdhN/WLtq2VoJ/9ZC1pC0?=
 =?us-ascii?Q?uM8B7X4hCqVxyKSzKHOe+pzLaeOu3IcTkkPkGogVe+mgOoYchS7VKKclYkDw?=
 =?us-ascii?Q?CDMBsSI6C+sGWTb2Ndq4yqUdVEj2K6E2e0gkQ/UrBiaaE7SrMJVjS/zd0fXg?=
 =?us-ascii?Q?U2gFPWXkOGKo9KCwVt8sxc09QfB1HDTedMuLWMnfu7Okr5Z4sXHOpHSpHVdg?=
 =?us-ascii?Q?NtbJ1BlBRdQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+6FYUjOcU9CcE8gAjaGlahhCD+n82/pXBOkDbzZfsNE0VvJFS1L8vgYboLvn?=
 =?us-ascii?Q?RFMdok1BIeJvNXEmt+3b1t18vdOaPgySSvPFex7NIFX5Iypx/kBHiZhIapp1?=
 =?us-ascii?Q?BU71RTx5N8OqWWJpUMdx8cevuXtdSw3QETiFaehdPr74R+WRspXd5RzM834l?=
 =?us-ascii?Q?cgNOzjNuQnxlywac9nvkme8xxZMleLWKmK+8kanrpIU3knZmPPqByUHxTwBe?=
 =?us-ascii?Q?u1lS3GAsrdUiTVp9nKRQdQyXelmelvtvaGrN3T5VX30uyJZJMHWnAl7LfD31?=
 =?us-ascii?Q?JZbN4onDQVLHYs6JxRfh8499Y2IwoMmAIWeXCC0h3cGefFrYYCBtYuo0N1oC?=
 =?us-ascii?Q?gPN/Wk1+k7HMh7GjijPq515eQXI75kxdZHAkGXHh55dxnSOOmw2k7g9Yb1wL?=
 =?us-ascii?Q?n/CHPTisp1VTUuIvUobxObaRNwtsSMi6eRojLU8mKXMiZTcUV/rjDPMy3l2V?=
 =?us-ascii?Q?ERZFCsQUUSsFGfnGatPMGFLqcXLTvRp/DNUBI+g9btiBa5uvtiuhCgH5i6hf?=
 =?us-ascii?Q?pyL3JdMT86+AJIhIAFmLHuxXpRCE7c+G8dnTe/opTF7T42PbBGRq3nmuyGvb?=
 =?us-ascii?Q?rJ74cYgDowKj3q/WOomp+dNADtYoTSNd7qyRnvqC8m3839lx1/3LDYNZvMCf?=
 =?us-ascii?Q?r6IwXz18Rwud97F4OyT5OUDZb1Qnu+9ROjr4ufduLBQPc+J/Kjot4dmXXjhs?=
 =?us-ascii?Q?bUcNCcdl9my5NIpnXAr4jP8LsjWYnXbURl9bj1B0N5YiuOy1erbn53twUvaq?=
 =?us-ascii?Q?AmJyiHhefduczzJqsB/N7y7LIIpwFSwN0rNNPaRt8W9ySU8Rnz+HxcPxK+Wo?=
 =?us-ascii?Q?iwCetqKz0woNat55LC/Ko/7DfXimUNNmYzTX4g3wRd0ksiALTzUm7T/9M6dL?=
 =?us-ascii?Q?AHpmjGqEngvnBleE7nH/e5KloO4qgCKx4uyUXwQj7rL2HNA0DrW4wLpDWQul?=
 =?us-ascii?Q?rkxvPGnMIQGDHQtsXK8l3WLTj4r646z47dZagAsAkwWOYjV6LFdcRbHPMuLp?=
 =?us-ascii?Q?EhXTw0MisRT6JGHFkluPGtRakFIlnNogTq0ot5O65mhFaY3Q+GWTuZBQyRlB?=
 =?us-ascii?Q?7EqGGT4y21ep96RyHrhHIUhYDtVP+IOtW24dKTkWaBnqdJTxsomcngme4YNS?=
 =?us-ascii?Q?dT88miqfsW+qs2lLzxyfXWnvHArnl6eSIsp2CxaW+E67F7OW0Tupl96Ze2GR?=
 =?us-ascii?Q?w8R0NwEJa2FwOE6/hSy1l4GOaNGRqPfZVMmn1Z1nBIBy1oS9KvcXJg2gDVm4?=
 =?us-ascii?Q?7XkGmo4J84nVWG0aX5hcAA1cOzkZviQRICMTEvSgE6BLj6VaNvOegf3mGz54?=
 =?us-ascii?Q?A3h4h3mcqcb2nL7B7DXCZj9Z4yRMvOKLQuJFzGj5beiJogSE6b7YBF/wlQ4i?=
 =?us-ascii?Q?VGxzaaf/hRXmQtJxchRugYz1unNT3OEyDu62ai8rhwjhP5PzlI6ed8BPiSXc?=
 =?us-ascii?Q?wYNkDiHjJgh6OKTG6rnq+7/hQ9rGGRNh/W+nwG01KAH3Ee2zLK79vTLLKEMy?=
 =?us-ascii?Q?DRMRVhw7nl+RLyyrxoA5O2JSDINXsotMasn1+Pif2+G/HcrU+GRbYKoDf47a?=
 =?us-ascii?Q?vme61lIpUSGBBZ6pcOO2XE9Bbh9l7vtpK1jG3iKl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f598d21-91b9-482f-2bc4-08dd9368644c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 04:24:32.4978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wHhVKQ+ag3GvXc/Nd2WTR4tNQecBvbgweEfue5lyfDhKxXTkgd2vuZu61Qvr7TPSmwhLnOeKWiqKHno56M3EaCakEBqsT6Nr3g/JmwXPKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6680
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

Hi,

> -----Original Message-----
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, May 6, 2025 10:13 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 5/5] drivers: ddr: altera: Add ECC scrubbing with Dcache
> enabled
>=20
> Add ECC scrubbing with Dcache enabled to speed up the scrubbing time.
> Change the SDRAM region to writethrough before scrubbing and restore
> back to its original behavior after that. This is to avoid triggering of =
false
> double-bit error.

The term 'ECC scrubbing' can be misleading, as it typically refers to the
process of periodically reading memory, correcting any ECC-detectable error=
s,
and optionally writing the corrected data back.

However, based on the code changes, it appears that the operation in questi=
on
is actually a full memory initialization-writing zeros across the entire me=
mory
to bring it into a known state and to generate the corresponding ECC data b=
efore use.

>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> ---
>  drivers/ddr/altera/sdram_arria10.c | 62 ++++++++++++------------
>  drivers/ddr/altera/sdram_soc32.c   | 75 ++++++++++++++++++++++++++---
> -
>  drivers/ddr/altera/sdram_soc32.h   |  2 +-
>  3 files changed, 99 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/ddr/altera/sdram_arria10.c
> b/drivers/ddr/altera/sdram_arria10.c
> index 133d4604738..8f281b82765 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -4,7 +4,6 @@
>   * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
> -#include <cpu_func.h>
>  #include <errno.h>
>  #include <fdtdec.h>
>  #include <init.h>
> @@ -23,11 +22,14 @@
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
> +#include <linux/sizes.h>
>=20
>  #include "sdram_soc32.h"
>=20
>  DECLARE_GLOBAL_DATA_PTR;
>=20
> +#define PGTABLE_OFF	0x4000
> +
>  static void sdram_mmr_init(void);
>  static u64 sdram_size_calc(void);
>=20
> @@ -129,10 +131,10 @@ static int emif_reset(void)
>  	s2c =3D readl(DDR_REG_SEQ2CORE);
>=20
>  	debug("c2s=3D%08x s2c=3D%08x nr0=3D%08x nr1=3D%08x nr2=3D%08x
> dst=3D%08x\n",
> -	     c2s, s2c, readl(IO48_MMR_NIOS2_RESERVE0),
> -	     readl(IO48_MMR_NIOS2_RESERVE1),
> -	     readl(IO48_MMR_NIOS2_RESERVE2),
> -	     readl(IO48_MMR_DRAMSTS));
> +		c2s, s2c, readl(IO48_MMR_NIOS2_RESERVE0),
> +		readl(IO48_MMR_NIOS2_RESERVE1),
> +		readl(IO48_MMR_NIOS2_RESERVE2),
> +		readl(IO48_MMR_DRAMSTS));
>=20
>  	if (s2c & SEQ2CORE_MASK) {
>  		ret =3D emif_clear();
> @@ -162,9 +164,9 @@ static int emif_reset(void)
>  	debug("emif_reset interrupt cleared\n");
>=20
>  	debug("nr0=3D%08x nr1=3D%08x nr2=3D%08x\n",
> -	     readl(IO48_MMR_NIOS2_RESERVE0),
> -	     readl(IO48_MMR_NIOS2_RESERVE1),
> -	     readl(IO48_MMR_NIOS2_RESERVE2));
> +		readl(IO48_MMR_NIOS2_RESERVE0),
> +		readl(IO48_MMR_NIOS2_RESERVE1),
> +		readl(IO48_MMR_NIOS2_RESERVE2));
>=20
>  	return 0;
>  }
> @@ -225,7 +227,7 @@ static u64 sdram_size_calc(void)
>  		(dramaddrw &
> IO48_MMR_DRAMADDRW_CFG_COL_ADDR_WIDTH_MASK));
>=20
>  	size *=3D (2 << (readl(&socfpga_ecc_hmc_base->ddrioctrl) &
> -		       ALT_ECC_HMC_OCP_DDRIOCTRL_IO_SIZE_MSK));
> +		 ALT_ECC_HMC_OCP_DDRIOCTRL_IO_SIZE_MSK));
>=20
>  	debug("SDRAM size=3D%llu\n", size);
>=20
> @@ -264,7 +266,7 @@ static void sdram_mmr_init(void)
>  	if ((readl(&socfpga_io48_mmr_base->niosreserve1) >> 6) & 0x1FF) {
>  		update_value =3D readl(&socfpga_io48_mmr_base-
> >niosreserve0);
>  		writel(((update_value & 0xFF) >> 5),
> -		       &socfpga_ecc_hmc_base->ddrioctrl);
> +			&socfpga_ecc_hmc_base->ddrioctrl);
>  	}
>=20
>  	ddrioctl =3D readl(&socfpga_ecc_hmc_base->ddrioctrl);
> @@ -352,11 +354,11 @@ static void sdram_mmr_init(void)
>  			(ctrlcfg0_cfg_ctrl_burst_len >> 2));
>=20
>  	io48_value =3D ((((readl(&socfpga_io48_mmr_base->dramtiming0) &
> -		      ALT_IO48_DRAMTIME_MEM_READ_LATENCY_MASK) + 2
> + 15 +
> -		      (ctrlcfg0_cfg_ctrl_burst_len >> 1)) >> 1) -
> -		      /* Up to here was in memory cycles so divide by 2 */
> -		      caltim1_cfg_rd_to_wr + caltim0_cfg_act_to_rdwr +
> -		      caltim4_cfg_pch_to_valid);
> +			ALT_IO48_DRAMTIME_MEM_READ_LATENCY_MASK)
> + 2 + 15 +
> +			(ctrlcfg0_cfg_ctrl_burst_len >> 1)) >> 1) -
> +			/* Up to here was in memory cycles so divide by 2 */
> +			caltim1_cfg_rd_to_wr + caltim0_cfg_act_to_rdwr +
> +			caltim4_cfg_pch_to_valid);
>=20
>  	writel(((caltim0_cfg_act_to_act <<
>=20
> 	ALT_NOC_MPU_DDR_T_SCHED_DDRTIMING_ACTTOACT_LSB) | @@
> -414,23 +416,23 @@ static void sdram_mmr_init(void)
>  	/* Enable or disable the SDRAM ECC */
>  	if (ctrlcfg1 & IO48_MMR_CTRLCFG1_CTRL_ENABLE_ECC) {
>  		setbits_le32(&socfpga_ecc_hmc_base->eccctrl,
> -
> (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
> -			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK
> |
> -			      ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
> +
> 	(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
> +
> 	ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
> +
> 	ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
>  		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl,
> -
> (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
> -
> ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK));
> +
> 	(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
> +
> 	ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK));
>  		setbits_le32(&socfpga_ecc_hmc_base->eccctrl2,
> -
> (ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
> -
> ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
> +
> 	(ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
> +
> 	ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
>  	} else {
>  		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl,
> -
> (ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
> -			      ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK
> |
> -			      ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
> +
> 	(ALT_ECC_HMC_OCP_ECCCTL_AWB_CNT_RST_SET_MSK |
> +
> 	ALT_ECC_HMC_OCP_ECCCTL_CNT_RST_SET_MSK |
> +
> 	ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK));
>  		clrbits_le32(&socfpga_ecc_hmc_base->eccctrl2,
> -
> (ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
> -
> ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
> +
> 	(ALT_ECC_HMC_OCP_ECCCTL2_RMW_EN_SET_MSK |
> +
> 	ALT_ECC_HMC_OCP_ECCCTL2_AWB_EN_SET_MSK));
>  	}
>  }

The patch should be split into two
1: For alignment clean up
2: For improving the performance of full memory initialization with DCACHE =
on.

[...]

Best regards,
Tien Fong
