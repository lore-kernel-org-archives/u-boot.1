Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26052E6B279
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 02:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B15841B1;
	Wed, 24 Dec 2025 03:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="ZhEbSJHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD12841B6; Wed, 24 Dec 2025 03:21:51 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F51784198
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 03:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8+GjNlhQNV9ETHBtW1c+6paderUNWFZIpTpuwxqLx2/3r57AcrMCRx9KVxK6W3DR7u/b2qIvUA1l1Y6KyVri/4YrFXuXKdyzArOJN1MHZpL9OoHJHqjnYb2GSpwnBw1j6APY35iMIMYMyMUONPBxfcOUcW1kSCAYOhLqlbPTotw4lwI0pXDouqSsnbwa4MQ6aZCSm7BieV/zxJtR3/eS6IoqzZnQSR0yg/nnALdZF1VOHPiEOzgKpZQ37Gmny2vBrU7VnWoUVIXFes5FbeG8yZisWgAFwmVWO4oGwQbLaE80LJhh7N1TFssAQOG34O/LIn2GHgMQNGRBuBj870wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPAbZDaSB+sNUL0HFlrXE52hDpqX2ULlrqI5wW/4JOQ=;
 b=btruqdx1RyD1yY0S2Bq6+qGAxsEnsIvns40GHQQsEOZlXx82vdnIcn7Md0v963giJHVmhCOtxPzFA9GSAgTx1zR089LU183dHarYYXFFLbYlynTDOXB/8MLzKEACLJI60jYzMIwcK3ZBNhmE5QXiNWqQkXzajiFFii0bFFRa1PXEBXrdHDB5kOZCZquFXbnyR9iia2fo+HMhLRvWSApTCc4wDgyDNqLDRNX18CSeyjMwWLG8Z5yhpo2EgtsidTt/2HAgdG3310dL08HdKf/t4/vpVJae/CEIECvy71WKGwm8Z4xCjEqyE7YZwWYNEU3vMiJvTSOr1lo2i7oc61Iexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPAbZDaSB+sNUL0HFlrXE52hDpqX2ULlrqI5wW/4JOQ=;
 b=ZhEbSJHQoZFJXh+jDS4PM6xLY07c9ftlmm5Y9+XdC8EJt9uKBNBmsHyymAM1q0z6vLhzVoUes3KGXFDAJQtNx1XI/YG1tF3GHxyLwukqU2TyRo4uY7ED/yEBLSwVufSULELG1HnLfmYL3P1559WxHyEb0jDp4nZHBTNjFGndPMzfTkmClIscMi9TA0J6ZVpCsLZvGxTo29Azdr9spcIuQtcQAfeZezakotx95zbSf7u5eiO6oeRcn/kgiQDR4vLcrU9QUDs5tr6F+HKQqRtb/DX8+3DQGSsoM/2f0LzmJZG/k8y3+S6YtOUG0PqeIt/iPeY3RtQ7/Y2xMRHvpK/DCA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8952.eurprd04.prod.outlook.com (2603:10a6:10:2e3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 02:21:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 02:21:45 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, U-Boot Mailing List
 <u-boot@lists.denx.de>
CC: David Zang <davidzangcs@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mathieu Othacehe <othacehe@gnu.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] omap_hsmmc: Support CONFIG_MMC_BROKEN_CD
Thread-Topic: [PATCH] omap_hsmmc: Support CONFIG_MMC_BROKEN_CD
Thread-Index: Adx0FCd9b/X98XjTSguLZ16auIS7yAAZ7TGg
Date: Wed, 24 Dec 2025 02:21:45 +0000
Message-ID: <PAXPR04MB8459DED744093008D9F2570688B2A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <GV2PR05MB1194100C3AFD5CDBCA957E91083B5A@GV2PR05MB11941.eurprd05.prod.outlook.com>
In-Reply-To: <GV2PR05MB1194100C3AFD5CDBCA957E91083B5A@GV2PR05MB11941.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8952:EE_
x-ms-office365-filtering-correlation-id: 58abec57-e292-4d71-59c1-08de42932f7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?crhe43wGtuB/mJuZHK86Az6iC08gmWtryzoSlDGi4fyjFjzkGXbGlfSSZiWp?=
 =?us-ascii?Q?Bcn6TEYc/lBOKUPA1mCO/uRSU2Qle7CHwhxL9E/chUbtGKT9WbK4a3U/X8b0?=
 =?us-ascii?Q?iQ7c+OrfHyJKyQ04DJffB7kH5MoKWBv4suCCfXngzbq3rvQRfng6NIlgc7ym?=
 =?us-ascii?Q?wI53fGmqRdPcyf1X9NrdTrWdibg7ZFARl+nPUm4ZDb9lSILN+zMisdcumG19?=
 =?us-ascii?Q?t1j97yiVFeq3oquk/urCMcquQmkLPtIacBox/gDfAk/zsEF47xSgwE4/IcmX?=
 =?us-ascii?Q?m6uArubtVijDcQI4gw9JaDTFSHeH6ZrbHuo8BJ+HwncWMqvpUQ1EamfivDuD?=
 =?us-ascii?Q?OU7fytQrkmQHmUz53sjvL6NffDO6+c1c2rae9ZAKHHp1aLubpM9TPtiIODyJ?=
 =?us-ascii?Q?0hY/Di8yGJ5e5FK5GwFE1hzd15R3Y6glUUpM3fn0G+yQnlMCdQa/Ifpz0cHG?=
 =?us-ascii?Q?bKmENAnR0FodtyIrHh+uMJtMauniL48QEj1fHRdTnhlwfJ1xJiWnwrJ5k9iD?=
 =?us-ascii?Q?TE2iUkJWDexKZrIw7iX7PnB+nujOgKcApFeNC07IOkjjHKUA884uQwRZ6Rk+?=
 =?us-ascii?Q?Ms3MPO0CedbERKg25m9LBBD8Wq/DYNkSk4Z3uzYkGnsuQa7O9OCu+RFfJf0U?=
 =?us-ascii?Q?66eNTig+qmKwjkvEwdKwBHn07XwcbZjJttvRIK4VOYKpKsv1AyZThbzN7CgZ?=
 =?us-ascii?Q?bB01m1e/QDWLBZq9Rf+82bwpUuD5aEjv2C2a74jA6feq1ia6s+366WZJdK/N?=
 =?us-ascii?Q?nt1SnB7qj+KyWseG9XacfZRnYcTkMflelXHoE0jIVt3gI6gD5xS63yUvBQG4?=
 =?us-ascii?Q?kNrPtZ+JLXtkuYmoh9cpzW49BIJ2bQ/w7Ok9X/hzk4bN9JRSJDnp92Khstha?=
 =?us-ascii?Q?dhMXVATvqjVEgNQ4vtaaiXq/x/rVbAZI0PaoBArijotq2ZlhSnrkK1b+YJQz?=
 =?us-ascii?Q?0LaqbQ9PCL/rhpxutPLA2XwlcTiK+Ed+rL9JIPnbozV34igKGxJN2PE6fnuh?=
 =?us-ascii?Q?xvenyV168C/UQ8YnxZ02gOyR17x3476weYVu+1JOIvJIGujRMNGEwvC+KAwE?=
 =?us-ascii?Q?0Y+i+ECZm6zVhbDddfKWoz/BAzZk7vQC1eMCPOsFFwfvZrdwIY7ZgsSbsgn9?=
 =?us-ascii?Q?2SR4u59Vz9+Jy+KaxAUCJhzAJWkdqmUkQS8o7XLXUPM8UdY7ZdvSR8FzxhNe?=
 =?us-ascii?Q?U80nAWPNkogSU+LGyJYs6XBgA/XSD5Y1aaDOAG+SluNIbyOUITDYWcUbGXSI?=
 =?us-ascii?Q?4JGhj9+zGW8Azhd9h3VA8g3uZ+xXkHhIHtuyegAY5+FGriw8A+IMxTVEsnnH?=
 =?us-ascii?Q?ixozYCz0x8UPIjbnx+a7jx6m7pEMHfoeTp+vYUt67XDdQbQWo76vkY8wPZ5f?=
 =?us-ascii?Q?yfBOFw49sADk/cu6Za90EdRR816aNke3CYyymVRAZYSMQtWgvWEOcbMg8QeY?=
 =?us-ascii?Q?aW9wwEuOoRwkHOPvhbmRgO5v0cXDprUiC08r+n+NzVS+G9ga2UsOHMWmFpK5?=
 =?us-ascii?Q?8YBT1Z5e7FfGFXdMx9LGsR5TR7C54l9kyZAU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v1SP2e7BsYrFw9E8FzZJn74U3kzVsSvdmhIf3S4lxpR4TIhBqwY+oD30ikYE?=
 =?us-ascii?Q?VlX1uekfneyf/HhPbJ5YD+eyS+mfaB/A/bYbA98NZum4FkGPP3MimXxVHEj5?=
 =?us-ascii?Q?tNPkn1gnK5QbxmjN3t2V5EmrgxFOntTvarzATK0ofnCCelp5iXy9/yP4OVGT?=
 =?us-ascii?Q?rtXdzzRMMYFqwXPXLVuODVNCERXZaF7OZfc8yVVu7XD4hiayOpqk+AVYn7H2?=
 =?us-ascii?Q?xSRgHB5LBr18G5bCTQzGzH8mzRoBiFdB/oWTkyKoHXAWboaG36MwqW0IfmkB?=
 =?us-ascii?Q?oQ9QsI4jdoYeUQ4bzizVJOLVgrX9mbud+CPibSrRkRhAv7twi5KhFvxpR84f?=
 =?us-ascii?Q?4EdcZ3Dcc8lAvp5T02LE1TCyZHK3jYuqGJ3I0E+9J+5mYTYsYZzELyku21Jo?=
 =?us-ascii?Q?+crNUvbAa5eAYsXbC6uRJvI1UGz7yNqLNVmNbIPSHGNzxURghtLcIcz8h8vS?=
 =?us-ascii?Q?rDURv2E8VuyjbOGcHd1XtO69ECwmI0oPw//hpBoaWyGnhxh7T3Z2XibYPeMu?=
 =?us-ascii?Q?PPlygb3yWOKLaGwjsPMqoEkGttcItG2mCepQbWiYBisVyCfsuWZ91xOAQCZw?=
 =?us-ascii?Q?XtKgzjqfDh4lcc8ZwNPFeAJMzE0Vj3XNC4vAidJIThQKGs1zFz3uvrYovHnT?=
 =?us-ascii?Q?01qmjCI9kdQN6OCn4rBQ2MRIyaSEMTzB4wmSBPJN6Tf7oK7MhPetFkRaiuU6?=
 =?us-ascii?Q?l1Ww13ahRImEaLJoMmxPLz8Tilnjn18H1/UvTSDgAPykTMGnt3+lRiJM9bKW?=
 =?us-ascii?Q?w4JDfgimGS3Fn1bm6k52idW2iqMEQFJGWfWwY+0BsY27W+Ga81uh3X/M8SoX?=
 =?us-ascii?Q?Aa30iBVQETpMwE25lX0fLxFKChUor0k0tgC5DAdyA82+1uco5DHCX3GZtHvK?=
 =?us-ascii?Q?Ql0dGQWiMWyqISRfNe4FUDxSh8M9+/uGxObiJ/y8S9kLr118PdIBGj/JSXXu?=
 =?us-ascii?Q?CciXcecYkfpYMrAdkQ+zNgXJIvBm31Aq2kXNT/vrhPzvJ/x6xNplHR7Xss0q?=
 =?us-ascii?Q?AsgpbwAx5YmRQ3G/1jBmaEvDDeQ1G5kTQ/75bR9oAZZ8fPgkW5UtQ/2Geg/I?=
 =?us-ascii?Q?QK56W8b22z5to7jQAkpPlrDy9/gA9jNuf+4Mis8tK2e8oyCYkRSg8ijh/7jw?=
 =?us-ascii?Q?l8KCYwHQYBhgR5FZVD5u810ibXZ1B8G6qi2jBane3mhpBC1/d9hBnhQYNHA0?=
 =?us-ascii?Q?kCx1GEltTdnVlbuYLXZR2wjgoCas2qdXfVIH1f1tkplN3/LlrF8l8Rm3zzbI?=
 =?us-ascii?Q?p6yYDNoABCmn3kBj9tz51QpeMVLBunSeB/tMtRVaUsxsKEGWv+GlTtPf7kOd?=
 =?us-ascii?Q?Yz7zSMb1eLCEaVi12WH5B3vimoiCtxpTzo9wKQpiuD4RUuB4/3h3EJr2AqB6?=
 =?us-ascii?Q?tu3SoHvCTFKWp9tSJSJHbpTN+7vobRrCNQ838GpoTnc6u504N7q2D8N2orFs?=
 =?us-ascii?Q?AOGhE+MXmIHXeUsspSiQb4Gm2RAc3t8zEjLTZqegJSragFkyyn/pUPPODhaz?=
 =?us-ascii?Q?IAsdP6BY6JZeOS14IMBimA6KI93Teo77rL0DlH0WKX7G5soIpkwAola8rMrp?=
 =?us-ascii?Q?OPyh3KE9zi27lJzciDEtgr/9TTLmDsb6pxLF/iqO9YsI7vpUQ0+6lympEPKB?=
 =?us-ascii?Q?KLpH5De0RZ1eLEVGuLvlHd7GpooN/VEuXmIL74iy7/58ZbFRNRp4Xn4Og+qG?=
 =?us-ascii?Q?BDGz6SiL0jfrTnQiPsgaHGQJ9itPHdeOtRKTLpFUJCx7H2fP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58abec57-e292-4d71-59c1-08de42932f7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 02:21:45.7483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwmRSkz6Runz+25c/Blg813xsffMM9Lz7dyGW67GtnYaHZzHag/3AJU3qfb29JPq7bDB6ITgP1GXXLVfetNf6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8952
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

> Subject: [PATCH] omap_hsmmc: Support CONFIG_MMC_BROKEN_CD
>=20
> Add support for the CONFIG_MMC_BROKEN_CD option to
> omap_hsmmc.c This should be selected when there is no Card Detect
> connection on a board.

There is broken-cd property in common mmc controller yaml,
could this be used for your case by parsing broken-cd property?

Regards
Peng.
