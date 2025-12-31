Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BA4EE642F
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 13:17:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D80548404D;
	Wed, 31 Dec 2025 14:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A654A8401F; Wed, 31 Dec 2025 10:04:05 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on2070f.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E5483FC6
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 10:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu0dmvMrHm3AwAdZuON9x5eczB83aq9AN4oDq4UVa8HQyK4+swGzIctmhF9xzWqWIJ9RmwP7Fb91NyMCiy6dsmeuiF8sWWHXwBkFWplj7aEHK8Ru37IvfO9dPxhYyyZIlrppFnEhczjXunsBA48AFpYiZr2O8+MyEOx9L1kJzjsuUm1ZhQix8YCF/SUQI32+14DRnrhtCdUKhvVzWO6rMBehPx0BFcpw9sQ/3Yk7fQ7kBwD1Z8GWO+D4Z90vxTHNjeD21cO4Ue6pDjHl8L+5j6zfILLp0Bx8mwqu674RabM+Ft2LhFyDbUob0zMGQF1/FmUogUI4tdsfy3KnwkPBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBMtPY9lvEUbfEw6SKYw+P9XAqHCtJVd5Mk9B5cmtzI=;
 b=k3DKwL0JYn0YbYGz/PFr9VoCn8DPWnG0ZbLvCInQMiRiJ7fMqcQEPbK0iDpNp8GhKLkrweV5nnJu7QDxkle28/QG3DsY45Xjim7ed9X4HceoUY1kMQbq1Dbef1RFQIMpUX8YrOTKhrYmgjVdkmnnCECvykX7SwopmbBHVsd6OZniyB42Q/gJehXmxvdLmeLQg+YmJztfSATWXPKWEK1IpFXOvRp+LwXSHW9+E0hVvr2ncUugJMu5Oz4EoyvMbipjNw1bmggxvGZ0s3GwNXPsgKRsz9blgmawL6Q7lR6RK9qq1hkfIAMihyVVubiUTtXbJAzpT/sNsZPPw1ks23t3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1274.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:10::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 31 Dec
 2025 09:03:55 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.9434.001; Wed, 31 Dec 2025
 09:03:55 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Leo Liang <ycliang@andestech.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 3/5] board: starfive: visionfive2: Add Orange Pi RV
 selection by product_id
Thread-Topic: [PATCH v2 3/5] board: starfive: visionfive2: Add Orange Pi RV
 selection by product_id
Thread-Index: AQHcdp6Ym35l/Lnm+0yxYuRyKF3mVLU7emfg
Date: Wed, 31 Dec 2025 09:03:55 +0000
Message-ID: <ZQ2PR01MB1307B985364C58E987C20027E6BD2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251226193034.181659-1-e@freeshell.de>
 <20251226193034.181659-4-e@freeshell.de>
In-Reply-To: <20251226193034.181659-4-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1274:EE_
x-ms-office365-filtering-correlation-id: e25ac3c5-7a37-4d7f-2b66-08de484b86a1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|38070700021; 
x-microsoft-antispam-message-info: 6gjMVCPKW8UQYh4PMz9cl9GG3pinSOZK/EbSMYpM0/vKaZa1QQfz3Lh/StiFRNUhMeXEuMXPptPXODTE/8JVgkhp3xP2GBIxG30dVaEwiaVBzxhRUEgzMkgntiMtQoZ8TL1M3Gk5e7FinwQtQqozppMeFnh3e5l6y0PFQSvGtgwSKKBDw8UPN5/V0L0uwE5E+O1D8hKPGwuk5grFUfsMyQBis/LhjozDHjsZgSPUWRdN61lmIr3mLoXOsMA4R4nTVaLgySaCwCAC81Lbyl6LZNMzRTlBJc2gIC4456kBL5xbXymgpCCjBQu2Ykb+Ew0QshpetRNlZLvoeVAXLfc2+7BUb5pMYcTUtVM/HWxvwIZXeyHGVLMsATrGNDnGJyRje3DdH5Lx2n8Dy0Eoof1oWOC9M83ToAJlSBVB21o40QPPerfmAETNj1kjcTWM0rr/Yp1FYG+gHen++hV9fs2wXBQWKkJmcLzh4O1RCWqgbMG8ymGtN26Jc4cp/WkNL2pYEt+hcqQwcSxDDov7/FwzcaX3+JPlqmlK2JwwPoYnD1QUwtzkpG/rRJd8sGETyTn2MVCNh9GYKqJbxkbujaEo8LgBwS1j6GcqLnZzJ4obet8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(41320700013)(1800799024)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kTvxUFxXkG1L67sIC8PrhNXCKJGx0J5pKj9fJAy+W142elOTp9Fb3hgnOxI7?=
 =?us-ascii?Q?HRzZbWczvFF53aNm+sfj2UI7UxijQUZqKxWh+giq53z81NiivpOYDekJpuR7?=
 =?us-ascii?Q?6ervqy6yQLB9yp9jymJxVybweOnUnWVHNrL1LirEQezgbFBwA+3Kc8ST+XZe?=
 =?us-ascii?Q?yP5UVkOrb1NoiNGjBbd6VhfKPHXakh3V1C1u7OA9J9DOoohlRvyd0MmaVeSZ?=
 =?us-ascii?Q?4WuPiVkksNJWkIyDgtRkcSCFG0glmLlHZIH+2LRxhK9oaGe2wr2B1r2jsA9z?=
 =?us-ascii?Q?FD8M8gdL6MvODyX0yNMsG/UJlAakWFY4MOerlqOTtsJACt54tTTrHaCN/wM0?=
 =?us-ascii?Q?6FLNGOK2lDYwTreG3mLDFYyF9Gn0qCbVZv301JJ19KIWaA2PwWYA/Mcm5Wis?=
 =?us-ascii?Q?Sn5XWcr4ScfmQU3sUD9/WF7PZYo5aNF46NB5s91VNLopkNdmYntpvLAlTPk6?=
 =?us-ascii?Q?p1vyqTIx/OY1y8GqenkVvnum/mokvVOpLLUIeD1DoooHAYCvARH50WOwhIx4?=
 =?us-ascii?Q?ZHas2QEPQkqNpoo8xCs7dckknLMkaS6o7slT+76u/L5jYdyT6Cny5uVlp7xz?=
 =?us-ascii?Q?LLeoCopItgaYM+OVAK1dF44kAm+ygFQHvzUCbq4XzCav3ju15REVlZjArobO?=
 =?us-ascii?Q?4o183zmRB0veJ46BdqYJHNUY7OWiOK7ZN6tDfghMVj/UPSZHo4/Har60p8gu?=
 =?us-ascii?Q?aDdvGvvnqUH0e7/jHHmDF47Qzku07hKDsym7O/4dN29TgrYcsYEK9ZIW1adY?=
 =?us-ascii?Q?xDoSt9aUkx35SgVRZcU54m0x+7TLWlAjgGZBPStz2zxrFOQMvCXvHAng+qlK?=
 =?us-ascii?Q?0k/Ljtow6M9qzJz8vHSPcGcuFiiLXSrbZR2zrL4RisePv191feOkAWareDIu?=
 =?us-ascii?Q?ikHkrAuImsyZ41fupIOxAjI2PC9P6R0weeX0gYGDrxeGBOd6uQwfVcdHoxXC?=
 =?us-ascii?Q?X2i/Quno1Uf7tV4oEakgX4M/PN68iMzoxplmWFXyRnzlWqltqNdsXcqBk8eb?=
 =?us-ascii?Q?eLs7JJyjMorfcMk50c2QN3IpB4h7IrpIeIzSgjWA0tBCcv0b9+KddAJufbCd?=
 =?us-ascii?Q?ofWciqBY4DbJjt2Zhvr6MF5UmSzgbwwzFruTFoNT3W8TFucfrCnCy9f8ui8z?=
 =?us-ascii?Q?USBwegyuNy4GkF6Yd4b6J5UbnodICKAsDUaPdnzjF6sJAOCwh4TRealhZuMg?=
 =?us-ascii?Q?Yy68H/T0VN33Bq3Nu+NdCv5Rx3LsIhWZsm+Ep/s9aPM1rLdzWDkafeyDZqQo?=
 =?us-ascii?Q?i9qJp01dXhNnteOQFbDb6jdNsKjLala41Ism6+RpAMp8na2DuiUtOSvWs9Te?=
 =?us-ascii?Q?wRpRT9sl9PnNnKXFuzXxiRB3GrLNleow4nkljNKABKsgEowQ9YrgOpo6l6qs?=
 =?us-ascii?Q?9QsVxcXwt9rIUMFSd29kHFMRtWJxWXGxzLWZIZH9mK8ZcB9HZnqFszMsII3r?=
 =?us-ascii?Q?lO92qTGcmpf6BVKGS758zukS3+tB3L4zZNtt2PJw99VDWvZD4Ca7CkEJUvFK?=
 =?us-ascii?Q?RzQRIR9uaJszF1d8Ag9JNo6/OupGDblTWaIjPgL8Akqq+2owUm0ln6VUpXQD?=
 =?us-ascii?Q?BUgyjJgtHzFPZrpNiZ1Mg5s6p5SUxrmHaRPwTzL7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: e25ac3c5-7a37-4d7f-2b66-08de484b86a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 09:03:55.1431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L701joaz/cYPNseVhuM3OXxhuzAO0InWD/xYj35rRrLWCOMCYGK+YLRQXSdPaE1Y411L28SqJaZXtERObckdo69HsplHNz8eXN0dJCU3aYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1274
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
> Add XOPIRV identifier for Orange Pi RV to dts selection callback in SPL, =
and to
> fdtfile environment variable default value selection in payload.
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal

> ---
>  board/starfive/visionfive2/spl.c                  | 3 +++
>  board/starfive/visionfive2/starfive_visionfive2.c | 2 ++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index 2d9431d2976..684605278c0 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -131,6 +131,9 @@ int board_fit_config_name_match(const char *name)
>  		    !strncmp(get_product_id_from_eeprom(), "MARC", 4) &&
>  		    !get_mmc_size_from_eeprom()) {
>  		return 0;
> +	} else if (!strcmp(name, "starfive/jh7110-orangepi-rv") &&
> +		    !strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {
> +		return 0;
>  	} else if (!strcmp(name, "starfive/jh7110-pine64-star64") &&
>  		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>  		return 0;
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c
> b/board/starfive/visionfive2/starfive_visionfive2.c
> index 6c39fd4af35..d59622f6b64 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -63,6 +63,8 @@ static void set_fdtfile(void)
>  		} else {
>  			fdtfile =3D "starfive/jh7110-milkv-marscm-lite.dtb";
>  		}
> +	} else if (!strncmp(get_product_id_from_eeprom(), "XOPIRV", 6)) {
> +		fdtfile =3D "starfive/jh7110-orangepi-rv.dtb";
>  	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>  		fdtfile =3D "starfive/jh7110-pine64-star64.dtb";
>  	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7)) {
> --
> 2.50.0

