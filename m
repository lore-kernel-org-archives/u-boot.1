Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC93C2A062
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 02:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F0EF83A9F;
	Mon,  5 Jan 2026 03:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="MfHyJT7P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1FB83AB7; Mon,  5 Jan 2026 03:52:25 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C4D83A1B
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 03:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aelX1aprdLIXZiUcIiV1IMAqC88GVOzLI0x7JQXwZsCsX86DmmzWk9UL30c3rvCDwDOGE1FRV2EBjddiKa25p55+l7McQ4SO5bFZlUZys+Df5r/eAzL88zwQ2hqA3khnTSdmLAS/wGExxY3shd3CI/Q3o04OH9zyhMT1amnMmAOUTS1nGR3tDxpYGdSTtOt0mbGjHbq5rO9m0W5ESinQKn0NoqEf9QY/CbP0BmBTOkUxnzHW3RYYCwJ5X8srskNyV28KEuSZpOb6qOWjwsn1aJTwaJRfQWZ6Cd7/vLKtyyrJKIiXZ4x7xfjpDcr1Re+B2kvDkJRB3PeDXX8YD+OjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NzpqgwLrNAkWd9/qa2JLo1s9n1RkkSlcto7jfeg36I=;
 b=Rhkj+zIHH8+gKN+zTIQhZqUfk9TXjKLDPV614bkd4xXqUr0MR9Py3IsFTa3nBqXK+4vIwDWqQqP3GV48Y2zrd8+X+r9DhAV+tenHfwdrNYEt4PfirKU9rl3nNRaovUlXTKYL2gyGcRx2/Moy70KABTxs7OCB6a2pWhKsfVEzsd7MdDSAE75Ui+pag4CWPjVIgTdPa9Ezz19cwIgUkOxDKpYiyLfI1cBte4/LyO15LHVdeJ2wu7md/bfJ5nzdKmz4EcJDE6w4+Q0ZIInVPyUiRvuaFuaCVp1UkpVqmbQkFpr/Yj239S6iuAh43GsRNLggwnUEwYaOLu1pfxzjl4tTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NzpqgwLrNAkWd9/qa2JLo1s9n1RkkSlcto7jfeg36I=;
 b=MfHyJT7PCbBeBE7klUL3DYBchdOkXvyEC9DMz2jACjA2u2ZyyJLgmJ5pjBFnd6/SjbFA3zrm4Yig5wpC27UZ88JGRMsKoNmbelMyMRGqPqvD64HsWNjTRQKLqYwG4a3sm3VuOgMMi6v+T7AY3tAa7SZW2H1mHY1QeDHMbnGC0YstloNpQYMw6sRjvzb7TpBthTZZi0wMOaLirTUDfe2KjQeF1RmcBVT/yHVhf3H2YUE+9DrPIRcQPz80ADm6XQpMY9sAvz0fntoQ4Z7S9IGIIg7huCVfBZuPMm0juaHP4C0ws/8q3Y/U8//tj8I0l4hOv/uDkSK07/GEBk3+9G1n/w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 02:52:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 02:52:21 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Luke Wang <ziniu.wang_1@nxp.com>, "jh80.chung@samsung.com"
 <jh80.chung@samsung.com>, "trini@konsulko.com" <trini@konsulko.com>,
 Christoph Stoidner <c.stoidner@phytec.de>
CC: "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "bhimeswararao.matsa@gmail.com" <bhimeswararao.matsa@gmail.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "kauschluss@disroot.org"
 <kauschluss@disroot.org>, "andrew.goodbody@linaro.org"
 <andrew.goodbody@linaro.org>, "tanmay.kathpalia@altera.com"
 <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, Bough Chen
 <haibo.chen@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] mmc: Add power stabilization delay in mmc_power_on()
Thread-Topic: [PATCH] mmc: Add power stabilization delay in mmc_power_on()
Thread-Index: AQHceXhbeEtWnZWc30eQOdrXBS8riLVC5uTA
Date: Mon, 5 Jan 2026 02:52:21 +0000
Message-ID: <PAXPR04MB845952139D9C3C7FE966993F8886A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251230103950.1543515-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20251230103950.1543515-1-ziniu.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB8020:EE_
x-ms-office365-filtering-correlation-id: d4c4c107-ca0f-4c02-370d-08de4c0572c2
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?I85wEg7JWW799sB1M+kOA21emSNAWO7f+tDE8BL7CnpLDMkiatlyj9t59kwY?=
 =?us-ascii?Q?39Kn/OVRaKawMfCmOhxn3SeP/sTWOrEcrn6Kv7CEVrVOZJVOWYF7kj+ByY+8?=
 =?us-ascii?Q?W99Nsa4nSFl1K9y+eDPAZtnAl66U0H+IlSYYp9C+lTFtxlOHYBOPZIsY+B6R?=
 =?us-ascii?Q?0Sd8KzlKEGUmWcsK701s0Bh8KMvtdzT9AXKoQuYoHtogovmsrAxAw5NqXgF1?=
 =?us-ascii?Q?olK0wd2/7sJhwUO+Op+9ZwEglvlnfrg664i1xuwdcDBVEWB8zI572uCrMF6U?=
 =?us-ascii?Q?hflnwcf/UjsDpSG7X31bv5JVUmJYWwGujLAq68GRud66TUStiJaJFGdsla6x?=
 =?us-ascii?Q?WbggswifaLkYwcjUAAjCT+v/49eVnrwZy0G+UkHI/3avw19ciCrg4O8EO7sX?=
 =?us-ascii?Q?Nc1Ebxj9jNNtOLdzxKaZIn/hrXqNDrZJd2bzXOaNicsnKuE/TXbOIw7HpYCR?=
 =?us-ascii?Q?J4FzoS9BUFoDTL+UgTUiQqlK/OV4oFScjln1SC+q4rdkJyaSqLzF91vKoUp4?=
 =?us-ascii?Q?jVsJ3Lj0+7+aozT3C1x1oV1I4NUhSOw/oz2RCw9iw39MJWH6FVmHBHv7+INh?=
 =?us-ascii?Q?Y0jKwA7N4jcIGRVeeSGRx/1JvSKBx6az+/lJGHizkqVZ7VZd7APQSH6BOgYL?=
 =?us-ascii?Q?sY+qUUfEflq9p9utA+ajQqQCIvh39o5z16qg6f8kQN4fQWT4XcVSa0Mp9mE5?=
 =?us-ascii?Q?SykJlJeCrxQpPgaIIPepqAQNHrWVQjfLBE+kgmBoh6Tfono9D1iaxByOfXBR?=
 =?us-ascii?Q?5uzqPHrALRW8lpU2NkAxMftXw7LLIrNop4oWcn7TyTEtEUK8ClD7vA+JTgkl?=
 =?us-ascii?Q?//KKZZ89z3tcGKRkWQCqw9m/v+2e/wGhqt1tJXEfIpxpFBruA/VeQO+9+3bm?=
 =?us-ascii?Q?Tsa2+7fhq2gkuaTULqKvc2pDo1Ggg6HDSNTgsHn/+3MGW9uou6o/v+sA9eYO?=
 =?us-ascii?Q?kyyeiPaDGmwGtNVpwW9B4CZjd1Oizu+rsRZJczPwFbREwMQSb2ONSDbulLU4?=
 =?us-ascii?Q?EIEyeHmLcCtAxTF7koyK0m6AkQlq66WxZJUPYK2zYh1AJ3+xSKVR0BDXPOII?=
 =?us-ascii?Q?lsrYgri/gvNo5uUzZi84Sc5Vqiex0wUAk/1AInkBg1Z6S3xcUFHSdKRuVZyc?=
 =?us-ascii?Q?vS0Mdaf4lEd+uW55he5IxJCXIFDRSEwZWQviX1jeQhLOLvj6ZSe86/eILYJQ?=
 =?us-ascii?Q?+bxK+upLJvraWA8Fzh1P62wQlJ2TEGXhWvOUk1sVU7hUQTey1YeFYoyHXzye?=
 =?us-ascii?Q?zBNmOq3qALGctPcoVCbg1zRsCT8oPCxQnCGBdIwue+apyXQ0ePlz+dSIYARu?=
 =?us-ascii?Q?juM+M6Oi0REhHxAwHc2veG5rLbjrsFFNoEqdsiQlrQMppcB53rE1jSHFIUb3?=
 =?us-ascii?Q?4Yz1SuhAgG1iZTtYJ3Q669bgU60cbHQjlTO6CPcKiE9+taj1iD8hgvxNyRU1?=
 =?us-ascii?Q?fPoMjKakm+qfrsXdR4NWfyGDf0UyKW8T/KiPE4076siXZu8oIcfPCihox+/f?=
 =?us-ascii?Q?PX95CBR/pU+QjCVyokINebnRMeDByHkP2MT2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wyXdW68EBfYX3KRcvDGbhiZGT8Fya6sTF/Fg1RVhS1s40RCO80hCWaWkvhAT?=
 =?us-ascii?Q?QFBUWVDzlmfTFPAhFD1cilEH3mIjk5BmPVsYWAmJihQ3MhuSpDRU/T0vS6an?=
 =?us-ascii?Q?fVMdK/+j7DK9AucwI0Ic2emXL7xnUYrzecSUNr+97bUCGzsCIbESW+BqlMqU?=
 =?us-ascii?Q?gHbe5zwqFdjcnUdTCMUpXJPjmr1YfeQwerQU0Q993tg7buQr5hzlYsHwTc/Y?=
 =?us-ascii?Q?r+EUV4WE0HPxjxS1LXLQl5CkSkUclgAn2r/DR630/FNm6KVM7FpTdqa33qe/?=
 =?us-ascii?Q?VON8QqRj/HpDkdoVoiJ/tDMgblF9BH9+B30uFNVvQYgXXSc2d8cQJzFaZlHs?=
 =?us-ascii?Q?YpV4nZu/4mqHYtl+CAvRzj4+7Q/JChFdAGei2J6G0Zmd7vPAWXOeM4QuVceU?=
 =?us-ascii?Q?1rXCfHqcP7gQLwbhKmReKSLIVLBpumIDK8bgmTeMAwSi33pYc8XiIHHZliMo?=
 =?us-ascii?Q?piKrzOB9Wq02048W+V3KxrqVhlsOSOMcNqqiB6QrnSwpOH4HdX/w0Z6CPDiV?=
 =?us-ascii?Q?OrNdPKmOc74zaDc9zpqiUr+LFfJjZSdmt33KYJkiYvpVBAKnKS+W54yLFvVm?=
 =?us-ascii?Q?KeP195mCL+VqxC/SLypxN//tgN5tb+KbWOOJlDUd7OYAB6/Z2ybgdxtwPzA2?=
 =?us-ascii?Q?UJD+jwOFDw6XP3CXvjfsglqVazyKdbaOLpxTHCnLcKv9/Pot+7hizNwDRew3?=
 =?us-ascii?Q?6deE0gIMLdla0xkH3pV4dhn5T36oM/AtiXrRm6/LCxZYDxAIX90c7/v7hDH9?=
 =?us-ascii?Q?MyicRbCjnzAHMLoDWLvH5W39KGTCYvvBlgFBgp1yaB7qSBh0vpO3KEN6sDB4?=
 =?us-ascii?Q?zhpMQq00qVaNSOOHg9WdBuMfo428a0i94y3I93RuMbgvDexlkh19+dDEQ7Lg?=
 =?us-ascii?Q?ZW5zHzU5+s95hbYFy6/dN3Dk3TdN2XfenwTNrywlQ8FDIbubgqQHwi6UagJp?=
 =?us-ascii?Q?p6rEylr80iftvZawTxPPyFriBWpAW0mZBlkna+rxqq5kQUkMEDyYNa4CVJLP?=
 =?us-ascii?Q?AQMLq6QTgVseVpzztm0taffGwV52MlehpJWorVz2HzMiTD/ClqJhGT5cV0bT?=
 =?us-ascii?Q?QT25HQ5i4KeZ77FX8FVD7EveNMnSle8b4yJfNovbFFkVisT5I1KDZJmxD8Y1?=
 =?us-ascii?Q?0nSbvFuud/dYzR4OQdDZAJWQ8+KLa5UYKbdx2ibmVCRP7+SbOr073xjyEEzb?=
 =?us-ascii?Q?HSk/K/LKAbMfGpWwhXfR7RnOVqQpQ4rjMU0yl3cmqtWWyXGyBTtPvi/0Gp1M?=
 =?us-ascii?Q?+cCDe7t2hvvDcEI6E4NMdo+ZhWAWDh1h77DnW+EXcD1EnK2266NVK0bEeZ4i?=
 =?us-ascii?Q?szzE5QyuSRtzeIJuwcbF3I81m15IJsiy4koobhO6zTVXshhvxCbsQfHUWER+?=
 =?us-ascii?Q?D1ogVElUUZNGCZjzW5Ex/KpbVqmoWLZYcyo70xYCoNTfGsNuo/clLysU9NyZ?=
 =?us-ascii?Q?icKW8Gk5/4Rrhq2JOIv8FHDAx133g+gVODBXkrKyjPzLLJ17qxM4CKqx61KJ?=
 =?us-ascii?Q?rUbuu7vB99kGRq+nDw6mplFp2jW1gz9Tj1p7rnCHJvcSbSQom0YDgAkUyK5t?=
 =?us-ascii?Q?WlwTey6IDvOuAZez27y+7dPz/NPp/G8dO3+z5jaFA5A5hx1+uCce6TGrA6DZ?=
 =?us-ascii?Q?mKb3DCiUoXDPfAqp5XyP6Xzqsq38S+emdKJxt/qfS5oLFcEpb+0slqdyjVqv?=
 =?us-ascii?Q?p2SQxdMB0FIOZjYdgusntCQpPf+ycVdzPLsv4fz3FC2kZVTx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c4c107-ca0f-4c02-370d-08de4c0572c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 02:52:21.6443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRFe74BKvZ0L0tOJTvABGGDwvxUnKfDC5ufQePQkWO1g6tKQmaltRPTZFH6+4INaqlXP59Cty9njhn06jUB5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020
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

> Subject: [PATCH] mmc: Add power stabilization delay in
> mmc_power_on()
>=20
> From: Luke Wang <ziniu.wang_1@nxp.com>
>=20
> After enabling vmmc supply, add 10ms delay to allow voltage to
> stabilize before SD initialization starts. Without this delay, some SD
> cards fail to initialize because the initial clock cycles are sent while
> power is still ramping up.

There was an patch to add 2ms delay that missed in my mailbox and
I plan to pick it up.

https://lore.kernel.org/all/20251031145951.535376-1-c.stoidner@phytec.de/

That patch is for 1ms delay per spec requirement.

But here you added 10ms for power up ramp time, this should really
be in board off-on-delay-us because this is board specific stuff.

Adding 10ms here for all will enlarge boot time, I think this is
not good.

Thanks,
Peng.

>=20
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/mmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c index
> bf82c515600..97037722fe1 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -2878,6 +2878,12 @@ static int mmc_power_on(struct mmc
> *mmc)
>  			printf("Error enabling VMMC supply : %d\n",
> ret);
>  			return ret;
>  		}
> +
> +		/*
> +		 * Wait for power supply to stabilize before sending
> +		 * initial clock cycle.
> +		 */
> +		mdelay(10);
>  	}
>=20
>  	if (mmc->vqmmc_supply) {
> --
> 2.34.1

