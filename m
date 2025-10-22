Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E65DCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F3C83642;
	Wed, 22 Oct 2025 09:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F37B83303; Wed, 22 Oct 2025 04:11:53 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2071a.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B47282B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 04:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aghv+5DnV2xILO36d6epXAmbfTorieosBYkP9P4L4Awk1ihaAAgh1GFHuultF4TosRFn5HBDaD88SoM8VxX7TzxubiJjLEk8Ug3/R7RxO9dsRb3qM6NAXdNPbCLDsRqaB3TiNMGH3vDvYVBnVyIYEJcUiQGk3KDS2P9dxulNXGzRzwBWq1S2hOTzh7ChOUiOX6nDueLgceAdmCd8/0/zOB//NI+AfoPmE02dCOSQkg91NIFHxLb4Gsb+4FOoQrzYzxzjerJ2WTVoHKvvr7KOMQyr10IrzCdgobOTGJQ7WpOL84EJiRK4HRupcIUaDWRK9OiY+1t6TaRjlFObfZ7MUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25+xJENb8nZkfJgdMuI79QeSpMd+qk8prIy24o+XJsw=;
 b=DcplbKbmZC1/Zj49CBYadD5Y5a6GeItCgCC6xL5SUyfkyrAY9CdvxuyAU1BBFiYwo9WdbIwf0UPrn6JknQxBOnLarWsVyD7h8A6cxuSocMvHIoZ4/pqX/l6RwDvPxzi6KHw32SZ4M6mhBIWv8i29ybxxy7edP3gDdS3Q+C8IRdCkCZur0eu5fgBYCqnt6sCIrcDJ7XSGKcmE0D9uz6yGhr7P92hoEmCBcWpN8oI9aSe7mPkfALk9kZ1LfwV0iwpU4qxfgyk8ivYQNTPW3XrHBlio4KO+4cytCUsmeAxLBtuBDYQT5si5xDiw6zGT6mdE8lfSL5Iuc/VWDb9Odjtd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1210.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Wed, 22 Oct
 2025 02:11:45 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 02:11:45 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH v2 1/3] board: starfive: visionfive2: Add Milk-V Mars CM
 and Mars CM Lite selection by product_id
Thread-Topic: [PATCH v2 1/3] board: starfive: visionfive2: Add Milk-V Mars CM
 and Mars CM Lite selection by product_id
Thread-Index: AQHcQuARdRH8JIJidUqaZFvhgaPV6LTNa+mw
Date: Wed, 22 Oct 2025 02:11:45 +0000
Message-ID: <ZQ2PR01MB1307EB6C8299B7E8EEE9383DE6F32@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251021231021.196336-1-e@freeshell.de>
 <20251021231021.196336-2-e@freeshell.de>
In-Reply-To: <20251021231021.196336-2-e@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1210:EE_
x-ms-office365-filtering-correlation-id: 241f9ef4-90fd-46a3-8ff4-08de11105994
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|41320700013|366016|38070700021; 
x-microsoft-antispam-message-info: Tpm19lYkOCCseq9ZV427FDb/6hVRz21CGYOl6FjSzb0wjOvn30Fqc3T7cQ6PNlO/VYkJLZUTeDValMhOLXO8pYcku6Xs8Nh9ObiPEys72zW+3cgbeDqsMLkjoZFIoaSNeQWREJGW51606VQdxxb3nVCIXu+BafNR5D9Qw7C5WdJV69N7U9123dFILcNVoX8tiG83mdK4RTjiFxzFN/gDCAx2hXkG6kOumE72rkauLSj010rGDP/62Bqi0pU5NSnlMwQVbT0RXbOGMaAOqzo9SFwFssOneOn02/avN70MhsnP4CVXrBkraMUM2QjZ47sjG20MCplGOWAaE8MiYiYVsoeU3ctp/Iped9t0hOt/ApZZpsS2y228ABIwd5RnpYgk3NHUnm7dzw6D7enQqAfpRhTFolh7HaRM2i5P3jhWFkHl6FK4tsSZnI9BMJvF54kEyCwwlyuPf3OBKTPM/3kOVryvIvwUdssHSxRpshgneoHI7LChb74TxTiXnit+TIAJ7EjeRF3m2maoRebUTZ8zV1ndmrSgknnncg7YoooK1AhZBDxjKNPhOGr/DCU9qkr6Owo7fPllysywkyUr7B3K+svyi978+uzWDEyig5BKtBI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(41320700013)(366016)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OpybNeccVKG1bt6cTNpsLxmtbav6D5s5Wvj1Nu8ZZwG8lhsFEMoguGhsfckm?=
 =?us-ascii?Q?GufY5Ry0gJ8wjB7gQy+At0Ug3s/IeKuhA5JyKs4TcDXJ4p6wE0BrBMWTKZJj?=
 =?us-ascii?Q?RPJho3lrGyt5rRk0WI559vEdWe2rT4W7gJNFkf8jApUEJ8rLby6aceZz5759?=
 =?us-ascii?Q?5YsaY+VvIFm5y8TUlFOqws1AJb7dNdmSbbxXi0qBMhyvo3G9daVs70ZlZ+4+?=
 =?us-ascii?Q?Iw5mpEyNGOSdgRD08I3g66d/t+b7uICxkQm78lGFlsH12eDPIa5UpehjmvtV?=
 =?us-ascii?Q?pl8P/Wv25/O/9xjwR0L/+g+mAu+C67HhycRLOv4Wf4nDPZ9J0DTqeaaZZhIq?=
 =?us-ascii?Q?DYAfecNSYRPg45yjXPu8VdBbZGdnqnRlmhX1JEDhTD5i9JCTZzjyLKZY+yOd?=
 =?us-ascii?Q?lJYhssP4i3w7lX7XMGQ0KEhQzQtvwYQqQyCvXiW0dhvI/z+OyL6JwkSNQqms?=
 =?us-ascii?Q?RF+Q1AnnfRDeOXPH82Qtd2cSZnE7IfTsvMV5aPeZwXuiqTnjglh+KKN0i/2x?=
 =?us-ascii?Q?cCixkNUmgoNmUYyTGt6r/CUbThFqjcwLoWin2BW92CBNVJJDS8Z1BMAdGE4r?=
 =?us-ascii?Q?TSGjVQovwVCYBp2xtEuICpLa92Qi2kk2TIaVDKlYdp4BNVyBrAKQpz2tJLZM?=
 =?us-ascii?Q?r22QbXrBvEj7mZZzhsE3A8O2BjuSaDaN3KIhTYHqNIGvpasoF4IiJRili81x?=
 =?us-ascii?Q?hgRREBKTMUFj5W80SIHxVYo5/dIJ17u9JrXxkWaoaELsnqCM8eJjiMCQQSbp?=
 =?us-ascii?Q?AAznkRUQ59SUtgOXaXh84HlceZYAv6VKKq2F+QxFgzfGlNl/+xpm2Ltgd8PT?=
 =?us-ascii?Q?3TiVXdxjn0+/FMm9WsmfAMGMS/qA1Dd6WSsMfW2GhC30whqr7UMgDLP24FYc?=
 =?us-ascii?Q?9BaVydDMFhGllLQ8ZsHlzW0oXs9c+Mrhrz+e8Qal6kt5SlicS6Tjy8wMORpB?=
 =?us-ascii?Q?wTvvDjO2uT/dTT9jcyH62cW51N0IXCUgklYlqNfbY+qIuw/+s3djje/9hIS8?=
 =?us-ascii?Q?Sbo65v8jBQb8UGsM5JcAWHOc0dH95bGEuyqmudlfLn6L2XEHkgCGNiYy7on0?=
 =?us-ascii?Q?dpVcZA5UEf0RWTchDQzQmq/61zQZa6B2WxbIYcgcH8BVH3ZNxqXrlBbQBmx0?=
 =?us-ascii?Q?lmQpzGyoOgtmKGd/jITRu47Iavgq/QsYwgScgjEFojbgR0DXvnfJf21yNE5C?=
 =?us-ascii?Q?PwWdiqybNw1/sbxd6NUZAjnPZAYfC3d8w7wBEXR3GKc+rE9HpgHP/y1qqJYp?=
 =?us-ascii?Q?fNbMol8BBlZSBsqqUuYOEoWE58YguqOSTeGjxrc0PylS8N7YGscJFusL2ETt?=
 =?us-ascii?Q?OIHYu2rRl7v9D8v2xGBFDhuYfvjrSIFKclrCSruaFdiqBAzZxdgehSMu7uqN?=
 =?us-ascii?Q?WR9Qsc96R+9wadzjUITNYh6iGcLY+7UgrllnP+ZWVN2nvj5wwtJbPk0PTsMx?=
 =?us-ascii?Q?hlNkqNJPArc2hIYLPmxF5mOEOwUUE0H6j3ZeitE1Mx279VzGVZBNdnA57rQY?=
 =?us-ascii?Q?fl/NJJqoRcLTy5aSM6e9MM5Vjkq9V8Usa5yVAsM+0vnfSci6D9IVdw0ZF3P5?=
 =?us-ascii?Q?rYFmCG8tV0lbmjNVY4buKZgzkyTQHgPATUfgwdJd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 241f9ef4-90fd-46a3-8ff4-08de11105994
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 02:11:45.2702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofau/y95PRet7sxyzg6e3IJ3/iTMlLqxJ6IybCs0yGSke0U4KsgDYMLp3BQPZwpZXWO5Q13C7HklhNL/+43a77+yRS3y2zl5f8QrY44P72I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1210
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
> Add identifier for Milk-V Mars CM to dts selection callback in SPL, and t=
o
> fdtfile environment variable default value selection in payload.
>=20
> Signed-off-by: E Shattow <e@freeshell.de>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal

> ---
>  board/starfive/visionfive2/spl.c                  | 8 ++++++++
>  board/starfive/visionfive2/starfive_visionfive2.c | 6 ++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive=
2/spl.c
> index 420a8cf8d91..5047292a0fa 100644
> --- a/board/starfive/visionfive2/spl.c
> +++ b/board/starfive/visionfive2/spl.c
> @@ -123,6 +123,14 @@ int board_fit_config_name_match(const char *name)
>  	} else if (!strcmp(name, "starfive/jh7110-milkv-mars") &&
>  		    !strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
>  		return 0;
> +	} else if (!strcmp(name, "starfive/jh7110-milkv-marscm-emmc") &&
> +		    !strncmp(get_product_id_from_eeprom(), "MARC", 4) &&
> +		    get_mmc_size_from_eeprom()) {
> +		return 0;
> +	} else if (!strcmp(name, "starfive/jh7110-milkv-marscm-lite") &&
> +		    !strncmp(get_product_id_from_eeprom(), "MARC", 4) &&
> +		    !get_mmc_size_from_eeprom()) {
> +		return 0;
>  	} else if (!strcmp(name, "starfive/jh7110-pine64-star64") &&
>  		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>  		return 0;
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c
> b/board/starfive/visionfive2/starfive_visionfive2.c
> index 6271974b9c7..6c39fd4af35 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -57,6 +57,12 @@ static void set_fdtfile(void)
>  		fdtfile =3D "starfive/jh7110-deepcomputing-fml13v01.dtb";
>  	} else if (!strncmp(get_product_id_from_eeprom(), "MARS", 4)) {
>  		fdtfile =3D "starfive/jh7110-milkv-mars.dtb";
> +	} else if (!strncmp(get_product_id_from_eeprom(), "MARC", 4)) {
> +		if (get_mmc_size_from_eeprom()) {
> +			fdtfile =3D "starfive/jh7110-milkv-marscm-emmc.dtb";
> +		} else {
> +			fdtfile =3D "starfive/jh7110-milkv-marscm-lite.dtb";
> +		}
>  	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>  		fdtfile =3D "starfive/jh7110-pine64-star64.dtb";
>  	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7)) {
> --
> 2.50.0

