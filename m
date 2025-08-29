Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66904CA0FF2
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 02:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A03083447;
	Fri, 29 Aug 2025 04:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="DPxgQuh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A37683448; Fri, 29 Aug 2025 04:27:12 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F42383443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 04:27:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEb2qYXMqjHVi78G1j7fc/0un/z1FjIgU+T3wJuqPGrh3ZjEn8hGIF4cRvj8o9rnxsBu4dczdNqxFYi23y81ts+MYG/3BQPhxKI70GHRj4bHD46GstQ/oBH91v4dy1B0brCb9dcrNnyK2x+xpuqBwZrp/lYrnxiE+2ueKVBWlkf/0JHdTUcqfHgyH3j/L5HRDC4lVAVOM8cEXUPzP9o/1CwZae0RkFPSCdFHYiHzKto5gXPvOK1LWue29VqJSVjLQ1SKQAeyp9X0y47BDcaRb/GXxDJXSBLcbARXmlsG2Ufq5d2kjq2pwpC0y9LCDd9MTR5v6hbYvmv0rR0156VpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+ixxV0kbAduOsZg79/t0+ZsvUnywsNmh+Q58gKb7I8=;
 b=gECnBWPo0ONWGZCFQOvelHdQmUnLW5J/419d8YzHa4qasXXx6uGQzeYHPu19uFPhrJDaFOhkechcuwJbLjQryIIMbY/+8+4xgCc4K+eknETHrjc3u7/iwfaF4DksetBrhDAOVlp8VA/0+JfooogfWdNCl6PxU+ePs9scIx+5FzAVzkiTBDsprjhfmS3G/xIpvS9DFf9b6mdFJvSba04XhezoTOWNPK+OE3JApQr583ViAEuTglZaRiC8vlt0z88NxX+7S1T7A+BHkk0ON5HtQw1ZFXwgtPt9KkOzqpzci/WfjsLocXe4QT0d9l2aqX3IyvplXQTPaDhASP+2A6GGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+ixxV0kbAduOsZg79/t0+ZsvUnywsNmh+Q58gKb7I8=;
 b=DPxgQuh38CYImRwEXNuksr3GwePTqjojhyzt/WnCOFYdpwvsBwnG/GI+ex1B+VG9F3EI6UGr9DWVEYI267C/E9LeLWgiyg4YPWP+9wyFdZv/qpmIUn2iDEctJxwUdDdgA/7e9N6kJW8rH5JrBeyahk9u1fUjUxYSJuqQKBG2xe5P0T9+riZIWISTasPcn1wUM9nR+Ba8tf7CoMBSXTlVpeCnOECdK3YJFaRkDb0uTMQdlK1v7uSe+QTQj0zzZM38beigc3OrGdP1On1StOgR+9jb6NN4wi5zs0X3yiLzjFYUAWS/DD5h4B/WLniWLja4jSl0wfIXbBRdQxqwVuN2Tw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10882.eurprd04.prod.outlook.com (2603:10a6:800:27a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.9; Fri, 29 Aug
 2025 02:27:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 02:27:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
CC: Oliver Gaskell <Oliver.Gaskell@analog.com>, Greg Malysa
 <malysagreg@gmail.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Ye Li <ye.li@nxp.com>, Simon Glass
 <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/1] spl: SPL_DM_SPI_FLASH depends on SPL_DM_SPI
Thread-Topic: [PATCH 1/1] spl: SPL_DM_SPI_FLASH depends on SPL_DM_SPI
Thread-Index: AQHcGCMIXgIkp732Wk+pJl7m+04PvrR46HRg
Date: Fri, 29 Aug 2025 02:27:06 +0000
Message-ID: <PAXPR04MB84591231F8D343B160F30E2C883AA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250828135235.26711-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250828135235.26711-1-heinrich.schuchardt@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI2PR04MB10882:EE_
x-ms-office365-filtering-correlation-id: f63fa126-19be-4bf5-654b-08dde6a38c71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|19092799006|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yCd+sXEiAt44VjiT6trCORVCqF6z16Bw1Dcfgf+FAup6tQ1izf/1rHRXrQd/?=
 =?us-ascii?Q?rE+Boj/lsWVwaYN+qe8C99dgRsDBdcf9r6GEG3MeffmjbndGcQ/2iJdI8syg?=
 =?us-ascii?Q?n7T0Sdaxfvld8ktSqRhMhT7ouCUgBkMjoQ6G0jd/qKBppNUHVFDLm2n2BT22?=
 =?us-ascii?Q?SfNOCxRwbpNvH5ftOsLpxfb60hzpaa9zVxyAzNq3eaQiEz19aoBTJOPZHZ6x?=
 =?us-ascii?Q?vm1HPfRCVXTFqUQ02T3zr+DQRJtinWy65bi0QC4t3KPCzIOe5hHtBdzGANIs?=
 =?us-ascii?Q?AqAn3/2glt5/jYi3aY/KjZdFWptt9gipNgP1ztFwzT8NiGIZP53mreYDo0Wh?=
 =?us-ascii?Q?K1H/zH6k7XjOqkuCDV8uLr8LiLhzM2MvZtyclJE2NZjcdrpHaZ01ENtde1q/?=
 =?us-ascii?Q?dk9p770udwlT6qF0u0hpea54afOglSTrSW21gFBQ2kXrKbN95y/z+dIJmeId?=
 =?us-ascii?Q?JA2yNjjKygMl63qkaCMfQJ2vCOW4eePV7lrgavFmurfEpR6CfltFdtd+a5KL?=
 =?us-ascii?Q?sZ8gIpCJU4Aai5Af1AnMSVZ7KfEpmBVMjIh2XH3Jjfamj4+JqPkqMbPGpPWX?=
 =?us-ascii?Q?6tKLP8UbhyoJqBN3+41xlx8k+gmYaaLr3VA5Cd3aFsaBBBn+1ejMerY6G7kB?=
 =?us-ascii?Q?4XF+TPNnwhV/KQbHF5BHBX6ZOS65468CEiWSz6Tryl/nkP0zcI+hBAC9IiTq?=
 =?us-ascii?Q?HXJI9xq98MdxwKDZjchhfPx6pbMc3oCKRjcQCXNLoxGCbVFw/hG/3/WFOhTN?=
 =?us-ascii?Q?b8GgjjbfI/fpI9dp2gUTmh6mB/0rkDuZkMaG34Xnq1HcSwjRTyq6yma1+69U?=
 =?us-ascii?Q?VNd4U0wr7uyGhfGMc8x32x5Fe5JA0YVdKGiavJl7GJMzJmpiUNSONFnDurod?=
 =?us-ascii?Q?1wmxrL1hyxEixDHKTcpEh18JPwkla2/5hRQdori9f7Qna2+VFzCjDozYWfDF?=
 =?us-ascii?Q?nwGP0Ww7IkkKDP22QYxq04RzY4br7/l63d7+Uu0893JnHNwUO5g5Xd3EE95A?=
 =?us-ascii?Q?94BwYhO7fEG4INys9OIPK4BDQzuIXHhOjzfYLEzUptuK5yvJF5NBczF9OEa3?=
 =?us-ascii?Q?lqP9k/XTnmb2FMbqcDZrfrEZXjLSpkHg4n8ULinB66s/VxOeI999apwzMgDe?=
 =?us-ascii?Q?T5YklBom/jihec8b3BLi64fnzVP1Y1sLQUyD2nkufUj09nuBtaqDv0ilmPoG?=
 =?us-ascii?Q?blJf1QhB7B/tC8t3SBLQaJ2BOybZfaHqu61W6wjow8bkfIVNQv5edyVfhlE/?=
 =?us-ascii?Q?0QCRXLOH6jHIKXSMi9yLKer4KOnIwxD2+Zq1nugpKcmyw+JRmY5ESwAThZKw?=
 =?us-ascii?Q?ZgifXK4XtR/t7YgMGVmyUKyKd2jnpAaulo8fYlLQKUAhbRFHFZXEuy9ASJut?=
 =?us-ascii?Q?2CTjZw2cR+F9dK0e1mkAQ7OGgy/2g78FXsv/2op5hUYfQmnOPd2+xLi1HeoO?=
 =?us-ascii?Q?7z5dmj8oKF9O8Gn4k6M0ob0iHLqwC21wPnWTGgBmqDvJ91BU2dV4Ng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l2zFPPFYtyXDHiRlfT5ykL9BsjRVzWjVfmF93v+JTeHUrzPn3OWAd1CAK6JA?=
 =?us-ascii?Q?9em2WoRYGv7GQ8RPMhFr4n/6zb+diMqdui+uYwlLkZPmT6HEX68DcWtsyrCL?=
 =?us-ascii?Q?XXr+n8fA98hi4PrJ2csRg1BsoQbMWZtg8IV7+R2LNDDHcFO1CmPFqWc6wUc8?=
 =?us-ascii?Q?qsCuMuqsHHRidN06vIkjQ2dy6FEAIl7TtCzbXb34FUkPYaHwVCWWGlbTL6Vk?=
 =?us-ascii?Q?cZZHDtg1n9DMwRGcc2VE2/feP0f4clDiJ6l+gX4z/5HkHN7tQs3qGaihptgi?=
 =?us-ascii?Q?X1NXs8XOlWmE6iwLJDX1EUxFmNAjguPQaQuTMGzmfcm66FRB0BNt3aH/xsov?=
 =?us-ascii?Q?+bO7SbU/mSFah/fKZfcJk8tUTT1Dp69lfznovYT43kQBObHwdlkHQo/vDHXg?=
 =?us-ascii?Q?zLkSmjltVRkOj54SpFws6NM6vfYlBq3k3g0lvS8Cfe7XYlM9Qf9KkWASSLJb?=
 =?us-ascii?Q?Ml1rYCJ8ksm2tzSaSIDH1cKRtWzn1udD9m0Sx+mQW+ccs+4ChbZQWuc2cUCG?=
 =?us-ascii?Q?4oq+/6KXQPiOntrrgb4Y5XGESIJpMiVjwllSSOhpUXSHQLQjALf0CKI9r0e6?=
 =?us-ascii?Q?232LnayS9QnVGwRkTlciG1R83Fm1wDq8MrgKpfF3sCTyqGE6NJbRvKJFxyd9?=
 =?us-ascii?Q?g2BSvcTNjxjWcqVq9jc4B3z6vfbUOcgT/xLCHKlsxTv734mUkgnzH+l/ICoM?=
 =?us-ascii?Q?Nx/OkDVGRHCwwmi47g3Q12FAORxZkLS/Yt/6bRZ3M8zV4g4N289wX3B3ryCT?=
 =?us-ascii?Q?x+B/65NeRn7+0NX3wXBLhYY0YkW8CjQW6OHyMpBzuXN11lrbVrvFcUAVV9XF?=
 =?us-ascii?Q?f1wqfVcRCQnMHdkH5TY+fsYh9nbq7Z3non/tG7G6jtmgeDJHpvIKO2YCRfYF?=
 =?us-ascii?Q?bfQzjKqheywVqHgOOzOScahWB9P9sG6x7OkVjDLAylqpL+PMSR1kusQPQ+I2?=
 =?us-ascii?Q?Yc86OBKKF7afGhERPTApph3t43la4+ozPhbJQn18ZZAVgCAlMrJkJ3QXmjUI?=
 =?us-ascii?Q?kZ9UZf9IrYCiP8WlvqZIloZ27ofVY37NbXYc4idxf9y43WDsNwwL0jzy/XnP?=
 =?us-ascii?Q?D5WneSIcFQylAuXuYeelRAwYxQ+PT9O4W7PaaR83U6w2ak8CzWOa7exLEZby?=
 =?us-ascii?Q?Z+9gOCI+noIqENxOcvzc90nI8tU16wR5zYf1Z0rJjbsapIf+VEa3+RJhzXqL?=
 =?us-ascii?Q?or4KcClScZifUuglaE00zUEWKWAHUb0jI0OVvHexIBvetTK18QrDHfrXzNiZ?=
 =?us-ascii?Q?yQduqEJGzY7I8FMUCXK8q1R7j330pPy4SfSLKV7N4e/8jaxUR75J+sI5d8UF?=
 =?us-ascii?Q?pB9YCaEF4fegwoLQbEpEiDC8F6Vrznfaai+/TTETsg6igV8MWFShbasUxqMc?=
 =?us-ascii?Q?qe5Fd/Z6uOOpykNV7KZtjETygr3usMWiAf+oht+qPhCdHqk3Zm3nmADqJo97?=
 =?us-ascii?Q?zW/F/nxJlxgdtHfLIWhtge+MtgDJQ4Nw+4xPIykM46E7dl+c9YDGHUa6Zi4V?=
 =?us-ascii?Q?h6ybz87pLx8KWX67hm0duO4kEw9nGUM7LIO+8YE+0h39PhxSaD10uu1LmLJX?=
 =?us-ascii?Q?n1lMFQ73oli2IkfbJQY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63fa126-19be-4bf5-654b-08dde6a38c71
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 02:27:06.6655 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVP5RAoQk00tQaddbHLVcimJ4c+y1auAcH0aV+slLJT2QCkyezWr9yiR5ffiykClUxvn+pRDn6jot+snuko/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10882
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

> Subject: [PATCH 1/1] spl: SPL_DM_SPI_FLASH depends on SPL_DM_SPI
>=20
> The SPI flash driver does not build without SPI support enabled.
>=20
> Fixes: 4151f4f822bb ("spl: Rework and tighten some dependencies")
> Signed-off-by: Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
