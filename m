Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E6BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 13:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A72E887E8;
	Tue, 30 Jul 2024 15:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PY6NYG3S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9099C887B9; Tue, 30 Jul 2024 15:45:23 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BEA86462
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 15:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GP0TbJnzFvAdaaSPN89hGbza7v6JFFLUUxVlhIWzV83r4AHqWVEqP4MpQuhJu9cM3lC/Cw69CJ3qJu3awI3C6jNibESWHEpXlmh7jiwAs0xgDhVi5Hh1DAItdp6HYqRYnev4VchYZSOpQ7TempkNjtx+QxpG4eMVQ5kOdNOMlI3NPRffMTm/3ovXxv0fddY2MS32ui6oKc+W+1mZOEWpvdtwrRLwL+iFZKQQhDNB4g38VHtU/lqNmtSKxrHiZbtm9jFAAdiCId8MpUmIBV0YHPhXg+6+m4O7ARqzx9IvRb41kklS5HHmDfewExYjswLRpFWBk96hMJ+QfacbthsymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fDEQy2HJJZh+OTfB++XDTDkecfKSA4wjQoyoZwNZ4o=;
 b=W4GTvmHcqYqB8nJ/wYMHQcIi7Ufy3cjyV460yUWvpQl6ITvQSyoditWVtRAgN76cOQG34Ujw2g84BQbt8lzIY8lMkS82XOqUI1fuTJMTXyTODBvnBZuIdZDcZWYc/42LsxeMWeZg/F5HCQT5qOWJaX9AS3kRDqhQF9h+8wzCOimADPxH6trBOnlfC2Vv/al3idySczI6/nI0Jm1N3ygDEPG6/zSsCcW4BvcNXbU8nRp54kB/3Bk/ySmpR6hKOBtfQ9qaaWPqrdvoMRK7iUHwO+efjs5xmIEm/efuz+Sr4kqu0BHxFfUBdr3dqRCsgxyAdfn2ihL7MX3n0D2pkpN9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fDEQy2HJJZh+OTfB++XDTDkecfKSA4wjQoyoZwNZ4o=;
 b=PY6NYG3SYJBb/hwjwLqOQN2WbiFZI6H8gAx9JcbOWsXFADcMtLWduVWBaGTajZM00ERPFQNZvwIbkoLeQW6PxzOlD+1sZidiboZ1YcoMkKLIoe/ps+/YMm3NcCpUn76HzlgJQcmfvr1BDIOwXTZ8zBRzEI3SQNHECN1o071cCKbEJXxthspsfPTBSdmaJilP3dnpLqgxP667HQRCeFMGiPMjyggM407J3TqnqkpIhSt5gDYWPFRp9lgWC+BYeDkLg4UHDv3xfoGinpd/unA5DsBWjJfBE3lbEceh5Iqj5rjpnzDyrFIPMJsoKXJhJA5qJZT6ycJ0dSwBCce4zvEB3g==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU2PR04MB8856.eurprd04.prod.outlook.com (2603:10a6:10:2e3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 30 Jul
 2024 13:45:19 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Tue, 30 Jul 2024
 13:45:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Franco Venturi <fventuri@comcast.net>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>
Subject: RE: [PATCH v1] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
Thread-Topic: [PATCH v1] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
Thread-Index: AQHa4oTReHkg9D4Xwk2Z3K9u+eaCSLIPR+SQ
Date: Tue, 30 Jul 2024 13:45:19 +0000
Message-ID: <DB9PR04MB8461F1E0FC7BC664F4924C0788B02@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240730133043.12577-1-fventuri@comcast.net>
In-Reply-To: <20240730133043.12577-1-fventuri@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|DU2PR04MB8856:EE_
x-ms-office365-filtering-correlation-id: cfc761d1-0a60-4634-97df-08dcb09dd9e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WA5wf1Gy3ud4kvF/2UCt4PGBDNjJOU2qYiTi+gudmpkAqgBild4TdeI3tG03?=
 =?us-ascii?Q?k/Sq1nfQp/e4qeBEOgCRcyWCeZmabilP23LbCzco2xbfOSFR7sGGLiu3fldQ?=
 =?us-ascii?Q?2RdKgaZIp2MILdizcYICnIvQys8ZjQsGChhwVrK4G3iGggJ7Q+jR64G72Jnh?=
 =?us-ascii?Q?egPXnIuXZXQvRnKlp/ZheOhJRDQ2BN7e5jLhuJU2T3+EzuYVEn69Jj3lNQnK?=
 =?us-ascii?Q?904OxYhKP4P5PPHMhzlMEafvNHXYPiPxrd7lHnJ7XGFcCUI9pFwFP7RNA3Wl?=
 =?us-ascii?Q?Jqs1+0+YiN9UhM6uN8JGFszZc4W/0JeA9f4Ghy/HaoUKsI5ChFpPaH8FE0HU?=
 =?us-ascii?Q?ES7ND9Kce20ckVggPpDNNckwpJJrjlATKqOrBjrhMO/fG+N5WnRNhR7Eg+Lp?=
 =?us-ascii?Q?bO0k4zkY1mfUZio5noX7HPpayHYh48x/jnWTqJzbVAOwMnsGthrUI/AtxqhB?=
 =?us-ascii?Q?rL+IWCz0c3LV25I9AswdHwvB1eTL7FpwyTiXx3WzxSyh2xabLUyQQ+f69x0i?=
 =?us-ascii?Q?9SlWkkLj/ZI7TOsUMUXYu1GoChN0g67T5iut/aEwRA4KcxmxoGr9oRUzqp/2?=
 =?us-ascii?Q?G04Jsle80/IuK1qaMovWt7aRbyjCB5AnjeWGUuA0oydDStq6+/uEY00xXSSv?=
 =?us-ascii?Q?bYin+cmD/dGSZmDkDRFj8eoohYX2WNGjgbXhYPER0KK/N6HRhgtdqG5/dih2?=
 =?us-ascii?Q?c8Iq73CcDL+BJzySHdaki7fV1LMWnylew2ZnjOaxNoUpBCyNV3nseuINR8Y1?=
 =?us-ascii?Q?58JimneRWM+VOOlylaoyV7OuUHzLHa4hyAnmw/BKjSSmeKqCBY2ASYPcJm1q?=
 =?us-ascii?Q?0C7xX9rWwy+ZnXwjfg2LgVNeT3lnocCvXbPZbjFPAaES8uowgaHq7GtEQM4J?=
 =?us-ascii?Q?defXpIyZpbqx1MsByz8piCsdPNN2Xj/Tdaeq6vp+wlj9U0Se2RZuw7gzSgfs?=
 =?us-ascii?Q?cF/hFyb6sfVNvctErh0+PwqWJ1aMV/5TucLCtKk1pBDbSbNa59cEQsitilSH?=
 =?us-ascii?Q?p5bzRWVXnL1z+lPsEwzyh2ACh71ckYXI6H+MkoeGtYqnQ4/OcH4jFlBNF030?=
 =?us-ascii?Q?opUoNX3M97ESWiklm8xIGlxn+HxuRF7otK1CEbhfyaE82n1Qj4t5ftnHvrWL?=
 =?us-ascii?Q?xOPExhfUjqSLO8CrS1V9vz4aug0ytInpVht26dmMFQ9Pp2T4vKScihCeq0Qe?=
 =?us-ascii?Q?8wD/GU3aWORmZ5UDx3dZ0+QDKgpMviBKnNKBrnE4GHFh7KdUD/cwKVyVJTtx?=
 =?us-ascii?Q?436ChlAw3RRyY8t9WWlYo395fLEv53Tv4mv/vnWqaG0o0qRh/wGT0TADg6IN?=
 =?us-ascii?Q?/b4j2VeGLajt+3gT4D8hIMnBOLGi/AxQVoR+BOjSz1Y7wU8FU4lAN3WUEIHk?=
 =?us-ascii?Q?rUAWYjp8RxQkaZ+8m7aGcGC+2RFI7yTdWaOo9cmKh6SOy2eqQw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WY+7zSoitdtimn1E6OPApsatuhS5irHDeaLrGIfne+4GTe3xE56NbeZaO190?=
 =?us-ascii?Q?2SxU1hsVLB4DV5J1oI5UhAH1qyI3SCetzM3H374cZrzhq9xL/hfDzTWiMki8?=
 =?us-ascii?Q?oL56ybr3N+xRhl5AyN5znNPScUMiNS3P9R4gH1MLEPPoKyLmWYvWyrXOUs9x?=
 =?us-ascii?Q?ZGiZh1Aa8mLe9sp35AVIpbkGF1tt01QpyALvLyU9B8Q6aWdMb7Gh6gJMaPQX?=
 =?us-ascii?Q?ptIiIYcbukG6n5cWX3zMdG/0yoRTpw9bN7BuBbW9YxMeSsEyscS1/U7dmhO8?=
 =?us-ascii?Q?XqdJNTQ4QFvxlYzCnBFjUXIQlpusrFy55BHe27kDFX5n8bMSgFR31NX3x/qO?=
 =?us-ascii?Q?MZz+n0OTYMO1+K+S1K9WTwCieZE3SBUgJLaxIGEobA3MTRHx2DtGblstxKDU?=
 =?us-ascii?Q?+7IHcE1xe7wrOscxSmrFi5SVVLjUW4fIpnMVCdBDTtPqRaYmtVcaoqSSWaWF?=
 =?us-ascii?Q?aCCtGJhyUEJHbs1zLoK2IPvkl6Fjjio2r0du4M2lWP38pDNVJCcBD1+ofL3A?=
 =?us-ascii?Q?Rzynym89FetfB3tB4FUgoYLvA5oActbtsRXcgXVRC4nTSVQPz086I3YiHFfS?=
 =?us-ascii?Q?BADEExidSCukZFTZYHkSzPKi/ay8EK6sjeodYYru2BdJnB75X4d19uQoMey7?=
 =?us-ascii?Q?BtifdeIEYUPdqRCfd8nrOIzNSNzWClJvlN8qxx6vjGgc/DX8Li4+EjteufMj?=
 =?us-ascii?Q?4VgOrlIRA8Gne82da51sllj5mb4Wa/xW+9Iwaj5FXj9oqV/x5lHAI+yZOvGX?=
 =?us-ascii?Q?yeU8s5ROlMYSNHYwZTgtu29rOGx9U8zfH9ma5EsQz/BnNiafHmfDETPwGNVm?=
 =?us-ascii?Q?kX2WGwntjtaA2RpauxhJdtU2MH8HOvrnXsKVuqhe6+VL/67RWFBGAB09AaH3?=
 =?us-ascii?Q?XdmV898WOz4KLQs3U7Dqf6ZxCNmNFO9Acp98u0Z9BBvM1VT6S60ZfsK1+L3q?=
 =?us-ascii?Q?6vh6Fab4z8W4fd6Dg4cTtdBBglUMTEN4sqLE3xZLkyEdlWz1tsjbPZWpbqNE?=
 =?us-ascii?Q?RwE8/qEACAUmE/kZinfiV8TyCJ2jAFXKb3tVMV3hIe1fKjKyjda5yGaBeDAZ?=
 =?us-ascii?Q?Ygnm4MXb4AvpIM7KD+p/MWpPrdJGNRc8Z/St4yHtksk09n9uUar4MmLMd7Y0?=
 =?us-ascii?Q?UXpY4CQ2AGBJiq+B6ZT04MV2CrdT+1JbtOM8ACNmalKOo1snq6Rk1jjkhRu2?=
 =?us-ascii?Q?SwTEUebIsEP8hTT9PuspKGE34/g4Bb/DSZC91ZB+8TCPSF/IR/+LUw/guYRL?=
 =?us-ascii?Q?IXdNmJl02EjJnTdgXftzLwvuzMvsSReks37l5BUAgAm6zJlmNr6PxVQpJZk8?=
 =?us-ascii?Q?00EGp/SCKgIcyNQtQsVlmbJmMepGwss7EErziMqTl3EwVQ5znNYn7PeBKjJD?=
 =?us-ascii?Q?jp0lJ89MFLOVOq3v6PPvUFlJe5bqo5xY0ctJCTFm+Jb7SJ5z2tnXCc63K1nG?=
 =?us-ascii?Q?ifv+vHT55vMA2nJGurF6o3/0hSQpkm+egJ+4BKvcafAG0MDd8uxFisVLu0DY?=
 =?us-ascii?Q?4ZpSMbDp40rNDRGKCcruc72y3xtljX80UxsIf6Kgt0riWl486ozjCSzZTD/s?=
 =?us-ascii?Q?GLOj7iiHQzeKjcs4/xQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc761d1-0a60-4634-97df-08dcb09dd9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 13:45:19.1244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEuH08Ul5i/JzsWVrO3+NoHh1QdCHze5bxkcZWWMqzl11PI/NVVU0mKQncATNpSFvgiejrd8ii3pIRTU97D5OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8856
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

> Subject: [PATCH v1] mmc: fix signed vs unsigned compare in read
> check in _spl_load()
>=20
> Fix signed vs unsigned compare in read check in _spl_load()
>=20
> Issue: when info->read() returns a negative value because of an error,
>        the comparison of 'read' (signed) with 'sizeof(*header)'
>        (unsigned silently converts the negative value into a very
>        large unsigned value and the check on the error condition
>        always return false, i.e. the error is not detected
> Symptoms: if spl_load_image_fat() is unable to find the file 'uImage',
>           the SPL phase of the boot process just hangs after displaying
>           the following line:
>           Trying to boot from MMC1
> Fix: first check if 'read' is negative then check its value against
>      'sizeof(*header)'
> Reference:
>=20
> Signed-off-by: Franco Venturi <fventuri@comcast.net>
> ---
>=20
>  include/spl_load.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/spl_load.h b/include/spl_load.h index
> 1c2b296c0a..1e05599d29 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -22,7 +22,7 @@ static inline int _spl_load(struct spl_image_info
> *spl_image,
>=20
>  	read =3D info->read(info, offset, ALIGN(sizeof(*header),
>  					      spl_get_bl_len(info)),
> header);
> -	if (read < sizeof(*header))
> +	if (read < 0 || read < sizeof(*header))

"read < 0" will imply that "read < sizeof(*header)", so there
should no need to include this change.

Regards,
Peng.

>  		return -EIO;
>=20
>  	if (image_get_magic(header) =3D=3D FDT_MAGIC) {
> --
> 2.45.2

