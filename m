Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9B0FD4605
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 01:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FA9983642;
	Thu, 26 Feb 2026 02:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AQmEz2uD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C12E83AA9; Thu, 26 Feb 2026 02:37:46 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB9C82A9E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 02:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmxgKBxiskXb7hAwZiyjRWst7MBiJxhh6sIjXlx78zRna5Yy5l8zoIqeuu+oWNceCVjyPN/ZmY4LF2J1C74I2vkR+n+h2Tf+cnXNGOgAPospIS29+/YntD794xNOCp0zO483hk2S1ke/Fon2VkvXr6Vf06Cq4oIOTO17vWn21J6fdO96NvRVJON6DCRLFmPSrtAcfqzHo3ZiW12LZoHYP5uvOSjaRnMJCvusxNpXJkwYdm2l1kuUvqgfEqiDlimlGy4/vFtAFht2pND3i+WxrQ1Tw59SoHkA+5//IOSDcnJYPcQHpL9C6AfSHht1tflz9ZiM4UzEm9J22YaBQ2fY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAbLTz6U38rgzPWSmndgemzGUoA8/uhwNa5P1P5LjV8=;
 b=KWKYKubrO5VEkm68ug5gPAA+wQwATcLksnKmvZnhqzbWmfhrpDnVxhk1bRlk+nlieCgyjAl9MG+MAUoiLLBQ/XrzmwiaHs8Jf39eTNi+5cEDBnTcW3oiGPfENGNtqEL9DXcfPvxJrSw8Ox//d9kiy7pdPhylQMYlRagd2gWA3RWYgtIdHk726i35hecSkJCsSWmXpNTqHihkA3o2C6BbTyr2dvYpeAeVs9Am8FL7tNHqmx6FAEvKswqf0Qs9lzQSPa0v8tOoLg5cJLFdPdHAr/kjkCE2vVnm6tcVKpHIbMI1X0LpIP9Z0k6WbENeACkpXVPcv82kOmvXKp132CZEdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAbLTz6U38rgzPWSmndgemzGUoA8/uhwNa5P1P5LjV8=;
 b=AQmEz2uDMh21RCmdaYoDFO8fyzWLzKlZyq5ZYjZic/FucLidZ3Dj7Eliw6Wf6PtFQnN+ZtemDah2UJafn8pjoiGilhsdqhcL2zqODqazm40z2vIuReP3/YZm7R5vld0SpiPZhnY7+3owG6WvKri6fhdHzC/dOzEwYfEV+RmA2FDn8+OlqU6GS6S1dcx2TSI3P1a8LtGblrTKqVCtEztQqR0zRhLwIrvaZF2587+ynbBazcgd2YE2jQzKz9N3fiGChoLnWQi/68oIhm4Fi0rOLKKw2gXeVNu5rnoCaL9RXgO1dTfiIyHTAATGCcqcFsTbHaFMlg9zSBlx8aW8SQOWXg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8883.eurprd04.prod.outlook.com (2603:10a6:20b:42e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 01:37:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 01:37:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Han Xu <han.xu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini
 <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] mmc: Add support for eMMC 5.1B specification
Thread-Topic: [PATCH] mmc: Add support for eMMC 5.1B specification
Thread-Index: AQHcppukxVdc9do9e0mprEoJ3XxeoLWUM2Xg
Date: Thu, 26 Feb 2026 01:37:39 +0000
Message-ID: <PAXPR04MB8459A20AF589F830523FFE008872A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260225211332.1896252-1-han.xu@nxp.com>
In-Reply-To: <20260225211332.1896252-1-han.xu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8883:EE_
x-ms-office365-filtering-correlation-id: c6a49b39-c9e6-437c-245d-08de74d7a0dc
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: +QvKIXYZjuB7XfoUIN/FafWR0AxPau2esN1K4idDJeqhILpMkLbmn97Kk1lVrVcbfgeRI9rysCvudk24DzxaaKsBKDd7hbKk5PR/pzU1GzuO0tBDVg878bqxrsABxW5Ykukc+Xw/pjeWTURVq9LDh/X91GzwE1GpuByK4EPqzVyne9IqPaSDDet/Lv4077TOhgKxAzzWfmq1mWFYc4IBpXPzJ0+7Qsqc7ywPF/ZyTwUtvqhP8dxPylAR+6IRrnU0NzW0fwKe3rXERaMWHa/AJYFG9xStIuDdIdpq9sDSZkZl0UtkdEdjYR6tPxkIcqOT1JYYP1CYWza/gHHgfrR+dziaBpo1gqtYX3wg0RHDieGbK10DIt+0LECA0Nsq50LGqHQxZrU4k+yaVnyKb/fPoSJkvsOQ6xP+Aomv3CQSbOtH1kFSvT2IOEtotLbdSP3PDaytQTwrfpp66A9hdNmKpLmC9AfZ0vo7SHNM9clbeuGaM0PDadO9FMX8Lj7e3OYnPK5mWKuKIDVDU361XSdCUGEjGQx7rPnWB7+y9fAz0IOrxVfOlqG2Nh/2/jvuuzjTB/juczDvvb/tnCTpVkmiaPLlyvprBDPNEptVAJRaEp9dzQb2n2+ochgLoJ0cKJR74rFSKayTGDU1KVOw/dJDGNRSQbSuu+EIuSEIlVtIwiT1YTzCY598TeC9NeeF36tofCEGsLISktWe4HPPSgTcScZZgCAYneT/XSOpCcCIiKQUljHDvRuPRVPjAolW1ol+fsQTsYy29lknDJMB/g2XbFHmXaaTaKcVal8mo3uskCM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rnJkAbhbi/cb4zHjeEQO4sQc0tUWolLYby3s84ZHsehbLL0lDfTSJowbdsO8?=
 =?us-ascii?Q?0XX/3SOKsdpeMKpii/9wcZWTQIzK5oOwjTmQWSZsUvplsde7OYiKOMO/j0jl?=
 =?us-ascii?Q?FTGWfOHqUr+RfUi+g5zR4iIDj6uwNnG4BpUAcViCZUaveOzQnvS3nRG7WDIr?=
 =?us-ascii?Q?RQGfz6HLwURQ/JQWpd8d/kX2YCzzkSzZDUq+psBqaHDcfvgGSdJICG/IDbo1?=
 =?us-ascii?Q?gxEHm5BV3jNN8BH+knVPFgtoimXsZCO7Uz8j8/JVDYdhQ1d4onhJHsVp4ujI?=
 =?us-ascii?Q?4yhWmXGXtCe9+rpTGb8BMd49lvKdcgMG3mF3YwltXrx5DocyISmraSeBq7lf?=
 =?us-ascii?Q?JDdnXFn3PyJqvly8p47dqlkK+FxdZ43tr+bS4okrftjtrybYFLok9dts+YR3?=
 =?us-ascii?Q?a3strUk5X31sviewhPXMtaTwntFSihNVkWsAe+XQISwc1ud+JXmhxiX+Pk3q?=
 =?us-ascii?Q?U8gFa/0wrn/aqt7cYEjQgSxndKwsNvr6WsxD4gVZp4bl7OXMw/U0eHkuD5e4?=
 =?us-ascii?Q?mU7VZYXUvZMIjJj4bXr5ucQSTDuoN/LrLi+kErtET/YU8BkSLonS8UdqDnDe?=
 =?us-ascii?Q?kAEwM5WdlCS6+OOLbazOoUgltn73ThDpig9vEe1QQnhcL0ziI7DXZEyWtelJ?=
 =?us-ascii?Q?Yo1/qgFOD9SQ374t4Hc86ENBaEGXtMibqOlL4Cbb18XCMt2r0R8wtBfKJWQb?=
 =?us-ascii?Q?P4+ivJJ2iXh9+cAhy6FBKIfCh6irvlrZ9g+mvgzGEIWskTJbZZ1tz8lY4fpw?=
 =?us-ascii?Q?/cfV2WrhBku8ngcu6DVnOD4yazzQyEbK2yW4LQLM1E8Fpeh8wmBXxauYlMyb?=
 =?us-ascii?Q?dtTyQGu/z6GPim7UyE+pkyplkwwqnuc+GgnYpSUc4SP2XSHXE3Cv+jTwbWdx?=
 =?us-ascii?Q?vOSQg1f+5/I1j/uyp/jA82gV6cp7F6moumSoAjWsJb+GLSC8RFi6acMqjw4F?=
 =?us-ascii?Q?wuajph1eBEYe9kp5E9bud2UYyZvTfvoOYHCJLUDIcSQMEbUyoo1Sq1IkXgiX?=
 =?us-ascii?Q?El/roC0E+5HntzN0wgemoeL1iUjWyaWHt3cHi9UqgmcMrWQHRigLsmQormla?=
 =?us-ascii?Q?C0pGQeeCwCSELVioZ5HnX0aXVjVw07gM0SzXAbFUQMb+kpdIZIe6ewUKQdTH?=
 =?us-ascii?Q?hxNNnrzoUTtNMkm1d/qo+B4neAKd/7Ncd0TaWo0rIxVd796YD4vKc9HItluc?=
 =?us-ascii?Q?hkDb5zqYtIrHlrHMMQp1MANfhB7oJCki+wGVHlvAS4bET89QEK6fWDnrJUGY?=
 =?us-ascii?Q?bLTwnIlPPKEYTy9G7YqRuJG5wUu5XUnTfhERz2+HBm0MTGG2XrE5hm3v55cO?=
 =?us-ascii?Q?B07gMmJnHWu6V9a5oexRZYaFHSgu1keg4PDZLRDfYxcVhLu7rdfuih45AywP?=
 =?us-ascii?Q?B+/QjPbYf2i5RRLLzgq/yL/seMIEg/fgi5OMY2e1hqreDlCaZhw+08MbVDdj?=
 =?us-ascii?Q?kcL/OkhdwAcePwANgBwlVqOql/0vh5rZhpzeX7f2Cp3NW6FHkvydaJZDS9mg?=
 =?us-ascii?Q?ooGVu3UknycPYQUZH7yc6BdIf+jWaH9kJy/lwwcgbTN/x0i2EL5TXh4qNMLg?=
 =?us-ascii?Q?KLmnpuv2fXJM3llNZm2+Yq7cDLvaFGqsJc3AaYffaW2+drgdOBrJeVkVQItv?=
 =?us-ascii?Q?DAIyBvncyYz+uMhuLhWeyxpTK4rQlGSY25NMpRT3iiZH+R6yPtLzvW7abOYv?=
 =?us-ascii?Q?D10bOqNSlvSBtlwAHscpAdMgIjYQU4iz6gAoa+XbUfEoBXdY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a49b39-c9e6-437c-245d-08de74d7a0dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 01:37:39.8345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oR3bQ4zQ3awhUxWyhqYfzrFxmT+qJNbgTT8LrBoHklDOJT/rEY2WYPqhnv/iwVWHLQsJ2cnKWnMnmhXRjkWbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8883
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

Hi Han,

> Subject: [PATCH] mmc: Add support for eMMC 5.1B specification
>=20
> Add support for eMMC specification version 5.1B by defining
> MMC_VERSION_5_1B and including it in the version array.
>=20
> eMMC 5.1B (JESD84-B51B) is a minor revision of the 5.1 specification
> that primarily addresses MDT (Manufacturing Date) adjustment for
> dates beyond 2025. This aligns with the Linux kernel commit
> 9996707822f82
> ("mmc: core: Adjust MDT beyond 2025").
>=20
> Since the manufacturing date field is not currently used in U-Boot, this
> change has no functional impact beyond proper device recognition.
> It allows the driver to correctly identify and initialize eMMC devices
> that report version 5.1B in their Extended CSD register.
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> ---
>  drivers/mmc/mmc.c | 3 ++-
>  include/mmc.h     | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c index
> c5705f4f215..f0e38efb262 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -2343,7 +2343,8 @@ static int mmc_startup_v4(struct mmc
> *mmc)
>  		MMC_VERSION_4_41,
>  		MMC_VERSION_4_5,
>  		MMC_VERSION_5_0,
> -		MMC_VERSION_5_1
> +		MMC_VERSION_5_1,
> +		MMC_VERSION_5_1B
>  	};
>=20
>  #if CONFIG_IS_ENABLED(MMC_TINY)
> diff --git a/include/mmc.h b/include/mmc.h index
> 51d3f2f8dd5..9509c9e9543 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -54,6 +54,7 @@ struct bd_info;
>  #define MMC_VERSION_4_5		MAKE_MMC_VERSION(4, 5,
> 0)
>  #define MMC_VERSION_5_0		MAKE_MMC_VERSION(5, 0,
> 0)
>  #define MMC_VERSION_5_1		MAKE_MMC_VERSION(5, 1,
> 0)
> +#define MMC_VERSION_5_1B	MAKE_MMC_VERSION(5, 1, 0xB)

https://lore.kernel.org/u-boot/aYH6H75gduflgjlR@nxa18884-linux.ap.freescale=
.net/

I have same question here.

Thanks,
Peng

>=20
>  #define MMC_CAP(mode)		(1 << mode)
>  #define MMC_MODE_HS		(MMC_CAP(MMC_HS) |
> MMC_CAP(SD_HS))
> --
> 2.34.1

