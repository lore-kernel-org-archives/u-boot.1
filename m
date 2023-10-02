Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA77E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 09:10:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CD38714F;
	Mon,  2 Oct 2023 11:10:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="nLpQFeHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1B087151; Mon,  2 Oct 2023 11:09:57 +0200 (CEST)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:704b::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E6587149
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 11:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ryan_chen@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBJZKXvRVMlZlq+R7ZpcATCeYUW+lcidD5pfJnlyKt+eOWS/Nf5yXoKMaEf5u2iq+7sBD8u0ssSVLqZMBNw/2jnjUnKoANHSROM0PWuTg69jmI0vE+tkBsDN+ds6dity3Jcsg7gmr7WhOzbDiRpf+ENJTVOqmyuyXklYB4FNaJwA7YCYTzddaTHlN299/gS46TUanNivbDvPO4OWLBt6YtQZh2wCNRZyvBalngdTvOVM/qIgLBlVxmnbEYZlFB8WEj2QzsQwWI2wzhVBjRgKVJEij/F71yvCtCtKO/8HhdlnH6OoE+MOMsku7v0johviNWZzNdJRG2sfmx2A2j5jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvEkoG81jhFQueOyl+ckTS0xre5k+5aLsqvmS8QBDLs=;
 b=dLrg38tj6EedI/0/aIqH0Swkgw0K/pp6p8OJZj7hFOJcUNK0tFS13/zASLALH1CkQ0qcSgZL+ylHmUPZkqCrPyC3WTNGsxUtSx4HhsbCSzKWUi2fN0EG16V5vO9rwiAGJmSYtp15t4llqY5gVIy7lMHTR93icyf2cnXwF2Bd1FBYIpqdRgQ/v/bQzBRqA5fb/X8v5FihCgvaVRn+u3rjTzwUGeXilSUo+eHdcIkReVwnCdUQCSj4i2D/zQk+iJ4cTNJVTOWKIU65rh0jm9JoaomDWsQ/GxpIGEaCoaI8HHZuaYWW+MFpKpdYWbgHFh5eLebparWLd9kXPkDx4XzxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvEkoG81jhFQueOyl+ckTS0xre5k+5aLsqvmS8QBDLs=;
 b=nLpQFeHAA2Uoq2D0w1S/zYUTHzuLpaK4cgzAJGzGD+Aceo9a+I4av3UOZ8daCe7ubDVnVNoprXeVijbMX0t3moOuUkwZsA+LGX752kforsHLW5wAmuiwNvMi7MFNuH4NB51cmDQ5yop3+aV1CwI6TOrsdlrEyCmKTQb+lFRf1LtxSXTK1R0sLO3P0VqnGJiTOZ5bNbFOiMT4HkPnQaqXPoSLNPoFStMM3vj4XEqPe63LbznzUAl7HidsmwELihUG9QduoD5+Aeh3WCEEVpY6bPl/dSzQdYSqymU+eqCsojtqVjGXIpU1LYTG2l9tPopYyYjkUOPskpruY4LLweypxg==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6167.apcprd06.prod.outlook.com (2603:1096:400:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 09:09:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::d6ab:2a17:4633:9a7d]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::d6ab:2a17:4633:9a7d%5]) with mapi id 15.20.6792.026; Mon, 2 Oct 2023
 09:09:32 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Dylan Hung <kobedylan@gmail.com>, ChiaWei Wang
 <chiawei_wang@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Dylan Hung <dylan_hung@aspeedtech.com>
Subject: RE: [PATCH] net: ftgmac100: Add reset control
Thread-Topic: [PATCH] net: ftgmac100: Add reset control
Thread-Index: AQHZwC3VFGq+HPNuwkGx4hCzC4STlLA2nrZg
Date: Mon, 2 Oct 2023 09:09:32 +0000
Message-ID: <SEZPR06MB52694F1A6CFE8C9C803B44A8F2C5A@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20230727015814.3459990-1-dylan_hung@aspeedtech.com>
In-Reply-To: <20230727015814.3459990-1-dylan_hung@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|TYZPR06MB6167:EE_
x-ms-office365-filtering-correlation-id: dd1e6336-e0a1-4618-ec9f-08dbc3274a8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IxksAB4QQecxp5L3VgeTRGj9PkTm1UsTWxC/pOipA3C/nNz7Q5+LMpsrRu6Iv+mUK73pwbOIV0swB7l1hCTKWMuxK8YltDPa6HqqGBd/sv9ZBnT6ZCrHYOQrQc0Lv4T/gkolIdoWFkbGB+HDh+CWezzbNtF0YTq+OR5Hk1CETZgbzUV9IOXOH0LT3fe3LVnSio0GUvxS/iD2nSicHUqebBF6i0bwQCR117HlBjmiizaoMix4RJTRs6fLy8qfvkqcN8kwz/8UhgnCkpRURDvtYNRvEF5N3cexFpmr05uvVZ+DfJ795yIzSAB2y29KV47kw7saD8xG8xtAnaMlJRKx73O7KERAxJL3J3iXNlF/15PRamQY0VkIpDfAL5foCfLDGbSd0qF55zMYLO+YbwGDkosYlgci9cByxm+lQBbfX0aWHqa19AF5Wr7k5jLyhHyDhheMC0GB4Vh8oXgD4N4ryxnpXrAU9WwEW27E/MoazK/+r5nw/tXgkxoRil8UG9A7J+e6P553My/OmhWFSz48b0Dhaq0IuRMsq9kkINYT7AJiaQ7w741yyqU27QJSroFjawtmfpQ0CD2aKgsED8gH1jMDwnUtJy4unDCmRlEbx6IpGMKqyJLf0ewhjgbUN5UM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5269.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39840400004)(396003)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(107886003)(52536014)(66556008)(5660300002)(66946007)(8676002)(8936002)(4326008)(66446008)(66476007)(478600001)(316002)(64756008)(71200400001)(53546011)(2906002)(6506007)(76116006)(41300700001)(7696005)(110136005)(26005)(9686003)(83380400001)(55016003)(122000001)(38100700002)(38070700005)(86362001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GGRfelUSLE61TrRFnnaT1YjIsCqGyl5FqEEXp44oNsd3Jw7RhN2y8jJ4sjch?=
 =?us-ascii?Q?FuQJe4PvnbWC4p37ZQjt1Iwf5D8RF36Ib+NunFMjlE4PWzu9U5wgGxxbNMHt?=
 =?us-ascii?Q?t5fJ7aopYyZfBpugIgWYIPv5kXqoyrjgBf+eYeC66UpgFfbG+AhzwCz9mLbd?=
 =?us-ascii?Q?HTjyNXELTP3GEBWpBICHsxa4uZLauQVM8/VUcToeLoCYXSyC0WZDtVn+kVim?=
 =?us-ascii?Q?riamvyBKqugbugcsTasuj0iICoA6cL2ngC4TNeRQ9H5OakJ061yY+zfHxssV?=
 =?us-ascii?Q?f1IPNcjsDZVtctttEqP6SOs+oCrAqT6rtIs5iHJ5VwSNxkTaNkcSXmvfHeOW?=
 =?us-ascii?Q?DP5x0scQP7mlShJJ98tt0XiUHibiat79aqSevSFtAjbWLbzjUFdjWKC+AGhv?=
 =?us-ascii?Q?y4zIndrzHhsB1b36/CCCiQenKEpqt6BhnBNA7AWm0WwUSLg77SetxQr4YUPh?=
 =?us-ascii?Q?Td2sE6YXc4aXABcMi4aZjbLRz/nRuhPDwZXHcM2iI218Di4DhVYRZjHGlAnu?=
 =?us-ascii?Q?Yt5bX535J+TQvOpzZ3Ur0893ipUCg3JKOYSVUQIHcyfhGzEi26Up2nDjDq4i?=
 =?us-ascii?Q?COqLDbt6AhocHsn1z8YOp27O/fEoorST+YfvQfbIQBKpEN0GL7i0ly464I19?=
 =?us-ascii?Q?gYWkgWjjUx4fDwzswJdoHhYgOwxOHW3UICbeaoWhsOMT2O0sRhrMaZdUMnXR?=
 =?us-ascii?Q?GtVpMrrQC5OJU4mvCR3XiELAaLdmR53VSGEKbOt8e15mEshH5/7JZy/cR1W/?=
 =?us-ascii?Q?iAFjpncIA7WFfsVFdGB9/nw6Gd91QgrcjltbwQ7CsHhuy01wmhhGY8El/tnA?=
 =?us-ascii?Q?A//dTFRAe7nbnpxHB74H6UtXLNNxuiA55t4NsA+3pHG1Zp02TqZIZt4jAJVb?=
 =?us-ascii?Q?WrFls3XIP/lP/Kvc9Ly4ia0VGoBpT+xPeLbaRm95XHZjdmDReL1j85JWDzmP?=
 =?us-ascii?Q?0B/qr70TXyl/rlm9XtiJiKrKR97zpaIlfTujVCj/P+ygBxl6vY4JYSy08NO6?=
 =?us-ascii?Q?W9+tj/kGdp5s25bSfvuwGwaGcVxZBd4Hqi9N08vPiYlyKJnvk3aEAUcByZp5?=
 =?us-ascii?Q?ptgI29NAKySuHJOQ+sSGlFT6h5t6TpAAE3HQLKQlhdw4Nt/Kt52mVDlB++6j?=
 =?us-ascii?Q?YAqNq17OlhyT81E8wXI9tkAJ469yH0TsskvkcwfhFHIVoz7lo4cCxt2IJ5tq?=
 =?us-ascii?Q?f7pMeyfn6Agyvs8krVrO19tsVxFRK0rx2UTdrBOH61HQHdPiII1Ch0sOU8oi?=
 =?us-ascii?Q?OKpbkc7b0bu+hXzDuaplmnpqs/DzaETKuHl0OGopeV0plPclzx8XZYDfXIQ8?=
 =?us-ascii?Q?iATqQb157U+Dz+BDQGaDvD4Sr4MXBHXjxtGId5wZrATEqkyQsxf6lHOJoMD5?=
 =?us-ascii?Q?NhSpxXLxS9sJzw0CVqpn2woz4UpI+QHRJMRCFrc7jVznFduzIP76FRiNGgah?=
 =?us-ascii?Q?2NNUFPMyUV3riqgevdh8eS2afSPqtYZDD3yvk9x/1CrLa7atwF4dkqdFUx8e?=
 =?us-ascii?Q?seIyRcpLgMatlHkspwNrfp9/GSvVUyGWbguuZuLPRWFBbciZxNyfARfqiTID?=
 =?us-ascii?Q?nWv8nyRl1ui17eg38c76HY7MFSh0dhudh5Ql/yL2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1e6336-e0a1-4618-ec9f-08dbc3274a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 09:09:32.4550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iw/Qd42YP+W5aJSgqV7CzKHlig9h8wSX9lkz3b2FLUzQcqGadwDuZh/V+AjZvEc12wWk7tYtBv7hL2kpE5xqw4pnill373FtJQQ1ts6FBJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6167
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
> From: Dylan Hung <kobedylan@gmail.com>
> Sent: Thursday, July 27, 2023 9:58 AM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; ChiaWei Wang
> <chiawei_wang@aspeedtech.com>; BMC-SW <BMC-SW@aspeedtech.com>;
> joel@jms.id.au; joe.hershberger@ni.com; rfried.dev@gmail.com;
> u-boot@lists.denx.de
> Cc: kobedylan@gmail.com; Dylan Hung <dylan_hung@aspeedtech.com>
> Subject: [PATCH] net: ftgmac100: Add reset control
>=20
> Add optional reset control, especially for the Aspeed SOC. For the hardwa=
re
> without a reset line, the reset assertion/deassertion will be skipped.
>=20
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Reviewed-by: Ryan Chen <ryan_chen@aspeedtech.com>

> ---
>  drivers/net/ftgmac100.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/net/ftgmac100.c b/drivers/net/ftgmac100.c index
> a50cde338a..886b97119d 100644
> --- a/drivers/net/ftgmac100.c
> +++ b/drivers/net/ftgmac100.c
> @@ -13,6 +13,7 @@
>=20
>  #include <common.h>
>  #include <clk.h>
> +#include <reset.h>
>  #include <cpu_func.h>
>  #include <dm.h>
>  #include <log.h>
> @@ -90,6 +91,7 @@ struct ftgmac100_data {
>  	u32 max_speed;
>=20
>  	struct clk_bulk clks;
> +	struct reset_ctl *reset_ctl;
>=20
>  	/* End of RX/TX ring buffer bits. Depend on model */
>  	u32 rxdes0_edorr_mask;
> @@ -568,6 +570,8 @@ static int ftgmac100_of_to_plat(struct udevice *dev)
>  		priv->txdes0_edotr_mask =3D BIT(15);
>  	}
>=20
> +	priv->reset_ctl =3D devm_reset_control_get_optional(dev, NULL);
> +
>  	return clk_get_bulk(dev, &priv->clks);  }
>=20
> @@ -593,6 +597,12 @@ static int ftgmac100_probe(struct udevice *dev)
>  	if (ret)
>  		goto out;
>=20
> +	if (priv->reset_ctl) {
> +		ret =3D reset_deassert(priv->reset_ctl);
> +		if (ret)
> +			goto out;
> +	}
> +
>  	/*
>  	 * If DM MDIO is enabled, the MDIO bus will be initialized later in
>  	 * dm_eth_phy_connect
> @@ -628,6 +638,8 @@ static int ftgmac100_remove(struct udevice *dev)
>  	free(priv->phydev);
>  	mdio_unregister(priv->bus);
>  	mdio_free(priv->bus);
> +	if (priv->reset_ctl)
> +		reset_assert(priv->reset_ctl);
>  	clk_release_bulk(&priv->clks);
>=20
>  	return 0;
> --
> 2.25.1

