Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDB8C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 13:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1994889DC;
	Wed, 31 Jul 2024 15:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="iQp4Xj7L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F807889E2; Wed, 31 Jul 2024 15:30:38 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AD5B889D2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qW0ysm0mu4NHGgU0N2B4Ja9qBQ0HUd3UOd49XH2p6Qon4GAZcPMOxJJz2T4zOaGjahIgg9cL6oGGFdujxfij3L4jsylm9pxIaeafhm1lNLPlylCp8M8aKPOk3XIO2rZ9kp34vRn+khfdL8MFPH2IsnVQ2Ex+D7VNrWmYiCf9hEVGEtcdxLRPV8UIzOfWPLPjNkqkqWNihCfgn6H+GhycYtcvHGWVdxHrdYLwUxgB902U9uWhF0c3m/o7AS2+BIylK1pQdEzDvH35/hG+1tf0e3GwgvkW7lYUpCR83hbCQfgsxCgdHeOGBONxE6ZCqo2Jwpo/o2h8vdMc3itLI2DDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGJSqgOB2byw7Q4w9bqMXJE+HI/ooeAi68R9s+DBZig=;
 b=E34bh6TszFVMe0CN9IBUNlfO2HSR4VNABylnGc2486U6bdMxgmiEk4/WizV+hmVgtxZYkg08QEKyZNGRwG6uwfjlkr0TaT5V4hdGi4CceE95GDaxXi2Bv5m4W64CccPP4Kqf90zz77JkhYiryAaolj4aDxZSDnJTAuK+Q6dY/07Kh5qtYbtcsub47rIoCmlpKdQtKZ+kF3BRSZfwncjtR4CLA54456MoTiVuaxeDwPADFoI2PqNrBsrWmJGBgrQUTHtW6qy+jU4+0/JOH2z/0SHTotxRyEsJREHIMNZ6IN+MSNKjUFuHq+imR6i9rqUS0J8S33+ug5MTcRxuVIsaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGJSqgOB2byw7Q4w9bqMXJE+HI/ooeAi68R9s+DBZig=;
 b=iQp4Xj7L9Rzf/U2B8ClQMf3U7QvRmrpiohiR1DinyOEzRYjv6mRm6U3WysaDTm/E/sfsvF0veFg/nJrGLViwtw1BQ6v5AoXXl3rMhsC8oEXX/PRmd99hjJE6jZ1bhs6bUnLbhV96tIB6zDcb1Ntlp+2UW2vbLLOWpP66xKd1faAXDtI+K23ms8qeWff4fKkFdtxyBnflopAMd6hXfLjuXR2sm3tqA4dHVm+n4eB9bC4kKv3RcwNbiNXyl6SsSM20flCemCZAphZ2CkfpZIqv7D+Y4LLAYKdVHOAAS+PmEEee5bl0Kn2rPNE0CGg8fWxpIEIcD4T8N5U5/D2U6glX7Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7791.eurprd04.prod.outlook.com (2603:10a6:102:cf::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 13:30:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Wed, 31 Jul 2024
 13:30:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Franco Venturi <fventuri@comcast.net>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>
Subject: RE: [PATCH v2] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
Thread-Topic: [PATCH v2] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
Thread-Index: AQHa40r1tIpBeRGZiEaWkQCM9UM1d7IQ1O4A
Date: Wed, 31 Jul 2024 13:30:34 +0000
Message-ID: <PAXPR04MB8459BB4C5F6058277C85736F88B12@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240731130913.487121-1-fventuri@comcast.net>
In-Reply-To: <20240731130913.487121-1-fventuri@comcast.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7791:EE_
x-ms-office365-filtering-correlation-id: 9eb22c22-4f7f-4b55-847c-08dcb164f504
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?l5dVvJnpVspe4z0ZYaNih2fdIUFGa9O32Dobl9gHtFIYqdKY6sa6iWKWqsNw?=
 =?us-ascii?Q?nIELgswEcrMzZ2FBlWJLO4qb89pTuqO0tWpCi6wlOgFlgosntRmgPyM18U6J?=
 =?us-ascii?Q?R04XRoBLqk6TE1QvIV5aULbL3O3iEg/yRUxAVorJWl8l4+CxF9rLrCLRFGz3?=
 =?us-ascii?Q?RII0175CH3IQUl5dT7vED7sh4yOFdikVBexcDQIjUX1ICtoYKDlglUNRediw?=
 =?us-ascii?Q?QehCiycrBEGNS2W/oGSjzlIDpXZ8wPUsqmYUWufyOU5iCwNU01oiHnk4dw9Q?=
 =?us-ascii?Q?p/p055T0MJfVQ4LyaJsFa4GGpsc9AiIBLtsl0MJnxoVtM99PvK7V9HdlAs09?=
 =?us-ascii?Q?sdWDxDvgNPNy1EU9BdqWEtvt/QTCLdaZvLoEioa4TseXRrZTIWjSRM3Z+YFa?=
 =?us-ascii?Q?YyV2DLGOYKQZWyc0EDD/5tvGjNq2PJAF+/kMeIGbd88laIWIvFcK0600G/B/?=
 =?us-ascii?Q?SCefVG9Mbz/yn0abftRhZqvT+SsZc4N6Vk4WiFXwzrZ19hdSGe2TCk3k7Ua0?=
 =?us-ascii?Q?7FXqdu/Ga044cyO+pxltEnkRKg0Eg1QzE4Qi1athpDFadUBKbwH1zn6VaDSt?=
 =?us-ascii?Q?CShzYvfpe1AT8f6MnKa13wsJlf82pgEf2j1GoQOXlqmMnVIY6rP4tnSxDm3r?=
 =?us-ascii?Q?dKgBqAApkGbO7ipgP48xSJheRp3KUUGNBjmudO593AB7D9f1dP5fXJqYUMME?=
 =?us-ascii?Q?XEQY+TUGzcStbR4mFVuBqZ3iNpRW8AeHK7V45r7FX54YR2Sv5cEYsRVy/sBi?=
 =?us-ascii?Q?aTWGpkAjdmKG3vgZlT8/I1Oeh13JnbiqWqF1HSOr0M8/fHPBRxAlVozmSxJb?=
 =?us-ascii?Q?w8E3pZ+itnHOScJS7PnC73+RXzo9T0jczb5Kf/VM+zb+NV4oCylzWWvKRAxv?=
 =?us-ascii?Q?OWtTxvUpqeRsLiLW7tUnZtL4s9y60NcynCQytKJd0eYrV3PAmDa8yFe3e9Mt?=
 =?us-ascii?Q?AtHt/Li2XzFKEjaTE0W5zoiE9nrjmlyW3Ton1Y4woqlpriGVGnR1NYKUuanY?=
 =?us-ascii?Q?/Bb4vnogjHfVVUgdVJkx0I9yZ1KnRR8dY973TEk/28CSUf5xW8layMZ+OhF9?=
 =?us-ascii?Q?VQPS69cByda+/G6RKReuUpddPL8zpvBKbtivROin/tCZL98A9WxTEE+zyco2?=
 =?us-ascii?Q?8mqg0XAY7C+r1hfFpwQN7csFcBo/Cl5ApkcoCyJvBb0lcdnkM16nyqE7docV?=
 =?us-ascii?Q?Sn3/JBMMW+TtL7CqSI70Mh1VLjRXRkrWSGS+/gBD7Vr9jWP33MMxJdz91LTT?=
 =?us-ascii?Q?ZtDmqLOrf1bZ3EQBqRqAZWB0LricAGI2SX8X6QHc7OCHXW1br0k3r3DsAZDA?=
 =?us-ascii?Q?BwOzmgvilddEiT/XoAXnhPrvPheGVRrqVH/4hP1gCg/+netvFkIt60FdzyKS?=
 =?us-ascii?Q?AvjdhM14bvv3ftaj68whX0hymzqgi7s8t0dhK9R1a8UpwAZr7g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3q0Pk8q+kurB75CLnPL7r1dsXk6lu8c4Gfqxk+sHi3N2LNfms80RjzyywPkK?=
 =?us-ascii?Q?qJ8Vs97TqbT0d+gI6M3LsBs+8rMgkEfM3xK2bR174hjDcDIkkoUP+Bv8YAHh?=
 =?us-ascii?Q?jUf9U6nAYYTsiCH95NU6ABN2rF0sXfZimP3m1wj562koFWNiMOrTxg/XXYFT?=
 =?us-ascii?Q?MJi1SseNmguyxoX6vgnn6xJ+rKBR+AIGELxopgw0QThnEzHHgfZQ4ZwPS5ih?=
 =?us-ascii?Q?vocmMd/MOHYuS5uetrE2H3vvZEhMCfWsaS0JmibEhsNC1EgtPnVDP1lYipwM?=
 =?us-ascii?Q?k+rkgsfnythPjpZ2wV5YOObjVK7yNfAwC4t/hIIn/t8Fdn25tKYCnC1w1LTY?=
 =?us-ascii?Q?Dh033Qly6AD6ILC626lsDWRKnP6s1pQDJbdlecS/sHn6ynwUeVmCkpWJbOxD?=
 =?us-ascii?Q?QYS7Kq13wKHKZDfrBqjl4jiFXG7+xT87HNnv+z6IG1DbOSp2+ted4mC95RPs?=
 =?us-ascii?Q?96rCJ5LCNqgz1J1LrEjLka392RFumERB9D4VPv7158lo/e86Koqa5bw8hInt?=
 =?us-ascii?Q?4kFdypeKK8KkgEpTSRUHZAraVMUnPjTkapIfNwOi99LPMIXOLGG4rlX6olcZ?=
 =?us-ascii?Q?dxAv29OFlHxlQNnLfRfiYt6Ss8Ea1SAIGKI4wcoRIpfMcQ69hDhf54zakNPc?=
 =?us-ascii?Q?qED8a3c41q++LstlD9F5+ub9Yn6GcS77uOeexP20XwfjEi/aQdnXOA2ccYuo?=
 =?us-ascii?Q?DcoxhX0uus+l6+1FrfJHnhL5Fy503FGAOJxoz7b9zMXz/n9ANOHaLU9TrkXK?=
 =?us-ascii?Q?DzLUeytIQNwxL6y0lpWFFyywNFMK3Eo8rYMxIQco8oeUxXlsV784DQ2MJs0g?=
 =?us-ascii?Q?WRaDWecP42fO/am4SuK6GpG7zNJyKArkiXpAREvB7cD79UC8GheBiaHGny8G?=
 =?us-ascii?Q?ywXbsbW6tMZgNYf3GtosPjWndD+l6k6ZR9mzO9n1+fxKOzTouOwctgqgvrV0?=
 =?us-ascii?Q?StA4Ueyii1dVKG/1S4jP5qmuqJ1aAGcQGisfPMeN02ma+gtt5OXyL8XdRaa2?=
 =?us-ascii?Q?pSaso5laSqP1syaztx5JO7vQalZtAh15rT9YP8ZR35e6MauK3uZkQLDQYTTU?=
 =?us-ascii?Q?AKyqlD/T2kT9ZtsE873IXJXTeOvFGM9k5qplblOhgQ7LKFSWgS6NluBouuHt?=
 =?us-ascii?Q?kW8bxSrovNLhK/hglQmNAQhiAHLq5srZwtmINyQEyW7/mIqjdC3VAZ4NlpWM?=
 =?us-ascii?Q?GjIuO7SMG/nb7KgPO0d49JuHpqycCxapNBOBTBiFxSMxwWrdLAqqrGNLWf2f?=
 =?us-ascii?Q?MMJal9gjfIfTqvm6lYmVNV579x7mnvff23byGL99aG1lgnd7I6QLfJ4lTNC0?=
 =?us-ascii?Q?BvUu2yAVPsv7+TO9uC7gmNovGphbap698amrHc8zmhUn3KooOZ0/AO7mHTV5?=
 =?us-ascii?Q?kXK3otRfK0C2N6isvG+mgE3lLahYf3Ftihhu6N6CMM7YSdO+AhJo/V6iyUra?=
 =?us-ascii?Q?aTrG43/QK+/TIKDXx3jLzs7THSb6ZcwGoXxNn201dPFSiNr6VH1+0qJiMtyh?=
 =?us-ascii?Q?EI7X54qmUmwrZ+5hWUT/sV9FTInNaJMXGZltkjhZ2vbrabEAINCQdaQ0B3fb?=
 =?us-ascii?Q?I/JEWq8ylKCugJ6Op0s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb22c22-4f7f-4b55-847c-08dcb164f504
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 13:30:34.4826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Kh8lEh824ah/B9L4hAFcVkkF4rkvh2AAmGDWWKviH/i+nDGqh2laXoVrhRPRpfnGjw6F+n6ur6x0AFdVSyaXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7791
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

> Subject: [PATCH v2] mmc: fix signed vs unsigned compare in read
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
> Fix: cast 'sizeof(*header)' to int so the compare is now between
>      signed types
> Reference:
>=20
> Signed-off-by: Franco Venturi <fventuri@comcast.net>
> ---
>=20
> (no changes since v1)
>=20
>  include/spl_load.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/spl_load.h b/include/spl_load.h index
> 1c2b296c0a..83db381202 100644
> --- a/include/spl_load.h
> +++ b/include/spl_load.h
> @@ -22,7 +22,7 @@ static inline int _spl_load(struct spl_image_info
> *spl_image,
>=20
>  	read =3D info->read(info, offset, ALIGN(sizeof(*header),
>  					      spl_get_bl_len(info)),
> header);
> -	if (read < sizeof(*header))
> +	if (read < (int)sizeof(*header))
>  		return -EIO;
>=20
>  	if (image_get_magic(header) =3D=3D FDT_MAGIC) {
> --

Reviewed-by: Peng Fan <peng.fan@nxp.com>
