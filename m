Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF773CCD1BE
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 128EC83692;
	Wed, 22 Oct 2025 09:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906D68323A; Wed, 22 Oct 2025 04:14:12 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2072c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::72c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B92C282B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 04:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=embmuNSWpo8fGUSyQsZTeywOEiRQFsbeYTqeSJ0fHL20Z823xzT2GYY/58/aaUwRXzqYNFjhJePnXkLJhYTa31M9TxpfLN+dnif3leKSkHSjY4db0JSU1b5LWfcvfmksqnUO3noz4VG9G2vqqpTN8u82CkjUt4esuCVwBL9UWVMV9ArcJH6VjLCV22xA4nC7sR8rs+/IAjOa0T3hey2TvXFzTs6xRL4Tr0cYn/EgZZoxflm6b0zJVosdyxmcJZssYgwzDMwjI6+6nXNAVno9UYgoYW/P36zUzrzLX1RpgfBI4Y2LRMpRabomoGSQDj1PaM1xDlhakUzaw/3RNWZC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vfQ49SWvwhMGdq0sSOc73SlGWmIVPbMiCjFhdKyWP0=;
 b=DzhjV1k75VQAozIp6+4WVxYmAmz1+/W8q0sSpbCLuTFaG95smanlNx9lplUwLmRgtXSBeDgkUA6PoI0Dt9CQd3z21MEGJcd/a3AMnzQ65HOnFC9cBRD5k1jHHC48GrtAnXSsvqvFQbBz2kQnkvYTYroSZ3Z1j94fW/mdZhiGUk/6Wm2HcGKFCl3Svh9GWFoW5Dyw8DpfQ2gqFfM1tRoUGmbTkOEgGZXmtl4raQr7vbjSEnXA2AADuMV5B6bNZqisZAYuZ+WNA6YcLWI1xAT7OQo2/fWquhuJq1sBQ83qd3Afb0+iEqJUI3AU8YNMn82EjVpcnL6K/vhvYFMtT0HAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 02:14:06 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 02:14:06 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 2/3] configs: starfive: Add Milk-V Mars CM and Mars CM
 Lite to visionfive2
Thread-Topic: [PATCH v2 2/3] configs: starfive: Add Milk-V Mars CM and Mars CM
 Lite to visionfive2
Thread-Index: AQHcQuAUseJTr1CUfUiy8TWAldPnsLTNbNRw
Date: Wed, 22 Oct 2025 02:14:06 +0000
Message-ID: <ZQ2PR01MB13072A0661A6E5B1BD6C191EE6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251021231021.196336-1-e@freeshell.de>
 <20251021231021.196336-3-e@freeshell.de>
In-Reply-To: <20251021231021.196336-3-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
x-ms-office365-filtering-correlation-id: cf8d2151-88f3-4a1b-6461-08de1110adf4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|38070700021; 
x-microsoft-antispam-message-info: olFGRVbGAucUQ3GXYKZwcYv7xQ0XAqJUS+wlAhtckwo33ODAXp8KP0pgpJ9hd/066BkLeEfEXerdoLfD+YPyieHXiHdAQIcgajj4LbqLkcFkuyNGVAI/14Gwd/uc1GytJQUquScNQ3/UA41Uemu5wFiB1A5UBODc+q+7RB44gUFba+oiIdwMjrhpgAA+bOAq2PY1OLQ9xyXZsrTJw9k3sk0VTUBa6EAs4clFhgrVJc38vNN8m8dt++GCgA4S3XvQ6MMMPXsVx5wcgI7Ax6h9oNx+UdZk2AVOZJmVDkSKcwXiKwlXB+T9oG2urcH7yPjsPK/JqBDbqRSl1Gl9IlE8fUWa7wlncHwHaahBgdgxnNF1Oi55M0MAgafkgaWWO+MQ0txRMPad4ISVpAJ6uEXEwklj16kniLgd6XBOFFRgk32244qY//L9VLGTXvAwYjiaHjg0/7WkJUbTLfFCTPfwLTeEi5sIm9t6I/LB5+LTZbZsWIuxDtXf+QxlFL66u6onxbbDzV+CiDXPc5Hoi03ODXt8dADxm5y+WHb/eVmtBaMtCv9XmGYnICURZb6pbG4GMBMicisBY5pGKC1i2DVCDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(41320700013)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9JtnGc5Uy85GC8ERJwRpDpx2upOOY7qNpV4AihtbzF+Fknd+XM10+UlaofYO?=
 =?us-ascii?Q?v0YQp/l9aAWrBiZplaKlcW+PuS06QEv0w3JnglIg+CMSK9Npc09r7oydH3hm?=
 =?us-ascii?Q?/6UvEqS4SOc6zB7XcOx9pm7a/fwxsK7CPfih34+W8C/o9/eIICcabUiBHyhf?=
 =?us-ascii?Q?qzqxTuq3T8gfCFC4IUXj7pEUFcByAgP1qUpHksVehqxe/VtkfdGUn3BykbNy?=
 =?us-ascii?Q?IrIWNkLVod+p/O29VszUB1kFxB9biLKBF/r7OYTDci2NQEciQQnLLR62MLax?=
 =?us-ascii?Q?Hq+gjLK3KBPnOYZHrcu33VY/R3ZvSmAX7NTjDcZYhgpq4bifSN9+PZ2zgeO0?=
 =?us-ascii?Q?Cj3ovPNcYwR4FC5Ewu9rTs6AQjvKFFHbfFs1vyXfMFqYhx1HtupICKzM1fXo?=
 =?us-ascii?Q?n7W9zXyO8NadyPPAQJalrlGnSFlXAa1/WL7bLOZMvXf5s3hemY8tGNKWkv/m?=
 =?us-ascii?Q?at7E8TW+Gep+gzbssXEJiNb9zfo+VelLC96462c9V/4zMuNyqMMcxi6C7oxQ?=
 =?us-ascii?Q?zeYTCNn3fNaFKBC/dL3CuMSxfwzlNajEoNVD0U+7uRXqYDfx/KpVN0DZgKoI?=
 =?us-ascii?Q?2kx9BdZKi4savqCawKKuQnuVhNjvaYCYIkbWawTHmRqM1zyyIj45wLCm8Fl7?=
 =?us-ascii?Q?qJZScJx+PEyA9FkHF7m97qiPshdxQF30UMlredjaB7GLiT2J+JrfMHP69nxE?=
 =?us-ascii?Q?gp9wny+ddsS/UXs7VBPzuRlVGUEg8OGk/3cHarFm0L1F0AZah/ZxNaGZ+i8R?=
 =?us-ascii?Q?gGiE8IYVqK9G8YNnnIlHGSDg1sk6izgfSL+zwH8rQjCXoQUeHDclTLGMHgLH?=
 =?us-ascii?Q?1UadcvUT6mJy54BpOs4QZjejsC8gJ1yClahRkQgC3Fr58rG8eK2rBzEYv4Fr?=
 =?us-ascii?Q?YgjVEnwOnl32QT/MgxeZlp9Por/i/opX1mwbS8PWfbO741kZNo8uljxMSmej?=
 =?us-ascii?Q?w6mEZRvO0hvLP4yo7HtCtyBfN/4lV4cg2wITRqQO5/xLGkrX00S+QrArRqA2?=
 =?us-ascii?Q?INw6I3RdPLswZl8XQxxhjQoKHmr0NPtbvOqDVgYAlku8OJoI9oq2eHLCs+7n?=
 =?us-ascii?Q?0bZrkPWD/jcDDz7/Z2pfokoCYeHHskGNpO09+5OvVPfIXl9YNzIS+y3f57pn?=
 =?us-ascii?Q?eDRYS9rtlX4CzsFuG7pryASz6h0DtE2kUtH8YaomEm6But18iBs9g1ug3qUE?=
 =?us-ascii?Q?gRLd97jkhIv99L6DdUmu8THzFRzhAqzq4TscrqHRC4yfH/RZvGLT03IDhLe9?=
 =?us-ascii?Q?q0vf7ZIVw3XIFqjUn2i64iaC4Ibi9/Rf497gQ+KjmKSrXqlOeThBSe412Swv?=
 =?us-ascii?Q?9xf73IOFm+YjyO67AEufuVKHgHwqPARs6t65RfdyzIC6BsD6S3Lh3W2Fe7GC?=
 =?us-ascii?Q?tS//sMTK7Cl4TxLPCHnRLCMbEl1nWrabI2QhFjrBFsH5WJlbIez1sJkDxqvW?=
 =?us-ascii?Q?IX6YejpUYXfyOBcaeHKDbDyYqueMPkqJKPr7MtvK6V4Smzp3bZqKcXrTzXQy?=
 =?us-ascii?Q?HLHFAMaH1BcEe7/OEBZUUsKRlmjdgl2BRiiV9+Q37L9VbRsiDnQX1qMKxqn+?=
 =?us-ascii?Q?koUMrzE89Wr6Nx2z8phl3RRtTbt4nND40cS7P/gE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8d2151-88f3-4a1b-6461-08de1110adf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 02:14:06.8451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2bvPvw14gcRB3KJqARF66Y7cQGWZTfWFkWkI2OyZucgyn8a2XlpivKuZzqLvtsP8F52czDIS0hiuOknV7WeABM86k8G/xmFvhXlMUxy5+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
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

> On 22.10.25 07:10, E Shattow wrote:
>=20
> Add Milk-V Mars CM and Mars CM Lite to visionfive2.
>=20
> These boards were previously supported and then removed in the transition
> to OF_UPSTREAM. The dts have landed in the for-next queue so let's add th=
e
> boards again.
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal

> ---
>  configs/starfive_visionfive2_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configs/starfive_visionfive2_defconfig
> b/configs/starfive_visionfive2_defconfig
> index 34ebf3b605b..fa83ecfa10f 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -79,7 +79,7 @@ CONFIG_CMD_WGET=3Dy
>  CONFIG_CMD_BOOTSTAGE=3Dy
>  CONFIG_OF_BOARD=3Dy
>  CONFIG_DEVICE_TREE_INCLUDES=3D"starfive-visionfive2-u-boot.dtsi"
> -CONFIG_OF_LIST=3D"starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110=
-
> milkv-mars starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionf=
ive-2-
> v1.2a starfive/jh7110-starfive-visionfive-2-v1.3b"
> +CONFIG_OF_LIST=3D"starfive/jh7110-deepcomputing-fml13v01 starfive/jh7110=
-
> milkv-mars starfive/jh7110-milkv-marscm-emmc starfive/jh7110-milkv-marscm=
-
> lite starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-=
v1.2a
> starfive/jh7110-starfive-visionfive-2-v1.3b"
>  CONFIG_MULTI_DTB_FIT=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
>  CONFIG_ENV_IS_IN_SPI_FLASH=3Dy
> --
> 2.50.0

