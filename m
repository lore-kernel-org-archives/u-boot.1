Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B40CEE6432
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 13:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2269B84057;
	Wed, 31 Dec 2025 14:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BE6A8401F; Wed, 31 Dec 2025 10:12:31 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on20726.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2891083FC6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 10:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISspRyyZq1RJM55pzsGWcnFH7V3N/WOOGDuSSA2SxeumFsdsKApaNMd9LdAi2HX5gOzjuH5iX60z+tU4Oe6ElVaJc+y/TEeSCsNB9RpvJ1pH4zr1DMATZpvk8iobLSJ7jD8YAp4hMB67KMiN/DvgPc1sXI0MtUOohvzpZnE5YwmFPkCy2htT8OLyaPz0HXd0zBxvt2H59S/6+fyeQClIZhVK5YkadPLqbhGRp2YdzS3dqf65PUbp3Oeh23FDUErpw9TVLjSeekaGE83BBbDkdFaU0W3ZOGmKHeJDq+Hn+xoAdxc1v1ECN7J3j5UYXtRHZdtxpnelP6szhnog8WZ4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS8kkOf602nrfa2KtxuLe88D9V+lMeuh51f0VPgr0GQ=;
 b=CkaBqy6JN5O2qy2uQD24OsYEb7sSYNyCc3qUSPZiwsjWpDdESL2vVfra8DqNxgvQr1KMoCAOIoyprTQ2MeuXFYiicHj4a2bYK9+YMjzMCWEcmziHZl3yvKYhbYAJ23ewliz+jMTEoUODKBiK7YHolKcDzfTshn2hOs2WSsHf15HCVk9OCZrRRtdEsS9aE6AyUDQLDF11QzyIxy5QKUIhJ6cY0gtvWwvj8bgr/kXuWlzUC5IwpF/ZoQFtGR7TqVxZpM2+Mi0wqQpDyIqYRB/1G7fjFnaXLSYGzmt7A/u9iMJvUVodQiLX/ZEMQMK/gN68IKYbJsy2DwtNKCtBv5iHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1209.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 31 Dec
 2025 09:12:24 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9434.001; Wed, 31 Dec 2025
 09:12:24 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Leo Liang <ycliang@andestech.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 4/5] configs: starfive: Add Orange Pi RV to visionfive2
Thread-Topic: [PATCH v2 4/5] configs: starfive: Add Orange Pi RV to visionfive2
Thread-Index: AQHcdp6lrnlCNaRiKkyb6W9uF0x/BrU7fHag
Date: Wed, 31 Dec 2025 09:12:24 +0000
Message-ID: <ZQ2PR01MB1307A29262132CA6FAB3BE24E6BD2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251226193034.181659-1-e@freeshell.de>
 <20251226193034.181659-5-e@freeshell.de>
In-Reply-To: <20251226193034.181659-5-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1209:EE_
x-ms-office365-filtering-correlation-id: d12ef449-5289-4722-59ec-08de484cb5fd
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: Ybl0hB4ueN3vfzSSwt+zi5w6Nq47Wyto2sb6vrAoR5YHdB/BQfdjN0F9C9tQLUOKChzvsistdGHul7PNWCu8M3HdiTJEVtb5Zcttuo05I9UPbMUN+/7jh7Nl53BeX0EtTxIr7mVtmaOsk7b2r8oO/vHt3I9GfmhQDJFZQ8CtjyTX3/KfSs5WFbpFvvCnPfg66mRxw6mm5ZoJYnv+scKp5A7+sYcy1zeR5diadh4kHvgVu5B1FdiUgiLVbwfPaMNVN5AEQ5D1okaTa5MsZpN5l4AtHQeAqgDp0ht3GFKtpUW6tcfkNi+q7x9Gox3q+Vfemgh8jGDXwGNSDhbep9r36Vra2IREmr3Ej2D4wlwupZZMIRmwnqc3R4eN/RMiyPcJW/woHYmq5+BzmqRDvbkRj3u3cghlbgpVGZCNQ3oiJ3kQtNKcEX7j0YSwpAtTNmSzjqMjcxwupSEo/0U1qhMH9mNWXgyrLdtkfTegLdQOo97o4skpgK89eAdC2gJq8WEWla5iNjzxX7RBdNazw34+8lRexRwUyPOtQjNhivQ0+X3yxMUTJhAOMzXAV4fx6h24+SuCRDFNJziAjCfIc8X9mQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(41320700013)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dxg1JLJM8SmBMwcbD7YbwTO0JKBMxeweAUZ4nwC99+wWD7JZWORtVNNyVe26?=
 =?us-ascii?Q?CDFwChZNd0fPrheB/eqgdfRX1VtVO3n/Ka2WZdoOU656mp2BS8adJhdjf8QF?=
 =?us-ascii?Q?GaNIFCuM4Yzjtw7QgI0jVGvOSCSFEjbWRHy0p2ktmc4oUotu1Qq1nLhyfbvE?=
 =?us-ascii?Q?JD4JSxFASTOYV3li+GChk0JipMgjm1EogiVbdaqYW2lbXYsPgEYHV7qmTTwr?=
 =?us-ascii?Q?aLk7SisMCW8H5tBf1L65/jyfNzqZsgwISEy9auKIfn1YiwbSE64tD9W6KGmc?=
 =?us-ascii?Q?HQvv69QeBq7cXMGfoUjqLyQcKRqPrU1/cZtaRdpfz1myIFSmM+P3bV5lQEX5?=
 =?us-ascii?Q?84qmmpJDCkzPaqFaqIRHy3n8w5+E4ueM2iwy2dyIUso/3L776e367RWuSiEc?=
 =?us-ascii?Q?yLj4MhW461JudpGSH824O/PN4d3rxAYs9yImzhFtermKwjeZL59fFRffu8/7?=
 =?us-ascii?Q?TgP56sMKfCOBsTDwcE+OfZKLk4zUNTslDaq3GSOo8GBPSZOsXIPxKl6lRR3Y?=
 =?us-ascii?Q?MUXs8HtrDH8VqlP2/1i6cfIg0Q6IgXjWzmD+WxdFXVJ422SBubYtLPUJfxaP?=
 =?us-ascii?Q?aBha2EbGS6qukkzF2fz5LvpSwtHMut6tdw3gTIeCoKuAxYVqVzVyisbleaj7?=
 =?us-ascii?Q?4nwqCCzYE8GQYT9PKHWnK+9RYZxHYzn40hti/mrD94FjQ7OS970Wi9adAErS?=
 =?us-ascii?Q?G4+br+puqgPfJf2h2mgdK6QSx5i0AfsuNZVBv0NmilcBMrdtIM5ql2Gp1ihG?=
 =?us-ascii?Q?T2k3kKOtUgDtZlXSPbml9Qp4igZxvIxJWEMsf/AXabQ7d9ZCoARiRoxJnHf3?=
 =?us-ascii?Q?o61hwBTE/QnZwr/ozlPsG/qO9pcOntsJV/3H46ILwCfukcuLfRIVXM8nDTut?=
 =?us-ascii?Q?ntTWc4FVDrpZfuOnB60vAO8TNNKUy/HLjtDz/1BEY63pvTFTWvRmtA8SaXdy?=
 =?us-ascii?Q?SAQ0RPdneFlcBnuub+anMfFt4MSWI3uc9YoXsYBP/lciet5u+/caHGb7ulUL?=
 =?us-ascii?Q?L5VfSCT4tWTopoklscOizdCgpIlqBRL+W5d5vlATUAo7Mqz3PVEujseTpecN?=
 =?us-ascii?Q?yigaYgQZvB93d+hYUU+MTnA/I01DlFnQ91HCbyC5mb3oymIsmuweMfHPgfPl?=
 =?us-ascii?Q?JY64/cB9JelcSHRqd4YoDbTxR5eSwty859bc8wsgwMgUYLBaDQD7A8bhTMSh?=
 =?us-ascii?Q?K1w/mOCKbXwipr5/beifsu/2zMKG1QccHL3MVrjlX4sIl7IsboYu5dAaRdle?=
 =?us-ascii?Q?b2OvrIpwCfrztlf4Y7p4t/+9eCj3u29y1/6rb3H9yfsyrE3B9Qu247b5rlkW?=
 =?us-ascii?Q?YdH+pMPMloPbxO4voT0ALdYRAPv60nicNuV9UstjLSutGOaGssakAq1+vHki?=
 =?us-ascii?Q?rniL7a9I2B82aR92dT1qDuA8Vk7pqeZmLeyq+buzv0ok4kzK9w2H/KvqPX7K?=
 =?us-ascii?Q?EprUTwQszRzK44gb9PBvtLe6qRsXsmMvfQIbaM5V0WGp5ZE1Tv0m712Lgx0V?=
 =?us-ascii?Q?n7fwIFCOM0rR9EXc7myRGY82laWilMUN5tFGj5/p654StZ8VHit/6htpikMo?=
 =?us-ascii?Q?5NMniA4+WTTvS4wAA9IGdkL16bwj0jf43jPoKBvz626FZx+lvhgB2776ukCh?=
 =?us-ascii?Q?VQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: d12ef449-5289-4722-59ec-08de484cb5fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 09:12:24.0770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8VeVBPoP+xSROCceADEz2hUlWjUHIXuhSJuOyC95NwEbgNVCwz9bEsNfexW3zh5ThYIkQD1g2Hdo6NiOD6urG8D/HXzg8ULy7OIr9iZLb/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1209
X-Mailman-Approved-At: Wed, 31 Dec 2025 14:17:47 +0100
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

> On 27.12.25 03:30, E Shattow wrote:
> Add Orange Pi RV to visionfive2 CONFIG_OF_LIST

Missing Signed-off-by here?

With that,

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal

> ---
>  configs/starfive_visionfive2_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configs/starfive_visionfive2_defconfig
> b/configs/starfive_visionfive2_defconfig
> index a754134a313..7c957cc0ea1 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=3Dy
>  CONFIG_CMD_BOOTSTAGE=3Dy
>  CONFIG_OF_BOARD=3Dy
>  CONFIG_DEVICE_TREE_INCLUDES=3D"starfive-visionfive2-u-boot.dtsi"
> -CONFIG_OF_LIST=3D"starfive/jh7110-deepcomputing-fml13v01
> starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc
> starfive/jh7110-milkv-marscm-lite starfive/jh7110-pine64-star64
> starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-
> visionfive-2-v1.3b"
> +CONFIG_OF_LIST=3D"starfive/jh7110-deepcomputing-fml13v01
> starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc
> starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv
> starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a
> starfive/jh7110-starfive-visionfive-2-v1.3b"
>  CONFIG_MULTI_DTB_FIT=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
>  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> --
> 2.50.0

