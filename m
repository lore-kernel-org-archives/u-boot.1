Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBFCCA0EE3
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 06:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112BB82EB8;
	Wed, 13 Aug 2025 08:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aZPsGzhl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD2C8319A; Wed, 13 Aug 2025 08:45:49 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F7B82D32
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 08:45:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzCtHgkXSy3DKgod/8pVU+Uuk/e//PnCikVpjoUVp0NqrJQEM9SLgqtwGu7eUinwCeGmVrX4unXQzln41Xq8plDcH0lLA42ljr326+Lqo/HeZAyqruPVxyQJ8gOYyqBcan+Gs1x0mowmTD/RPWnYCAuMnCbzAWeBVu+FNvynbln4GQ1WtiHzxypQRrZTfcMzWgpPlDO3ChSwJqblBuguJiADTTfDrz4QBn6w4xmBnwJzKybgCWU7ZDZrN6RPTMvuIyUfakzNCOmpc6ivNrfD4SvD8xizoYOeB3ZRXds1LTGLSo56bV9poy5NaMUNMg1gS2nGtkbzje4qfX2bxf2oxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp7FvLqp0vhg5aLrWmKMpzp6arjw9zQmX+NCcseDadY=;
 b=FaOYf69usppUlAqcAh3oTDYmFfuHhQv8jVCKKFPHkG3aCar+iHKOULbvbl40maUM+Ysr3VT501XUAHygW3RDU0Z1h+cdIRALkzOQI3266kgEbPhMheVhZd87rbbO7DMBet2L4YQF94qGpoRGI5F16LQ4tomqHD/OJBkLwuKsWdGO7LEOWDokyBGC2ikAkuylT9wq9n4ZwyiWHgrrysj7lSbMng3lyLKOVtzljfqbUK/g6hjCAj0YGLJcM5Nup2FtK6e3A84+yL35XrRjPU9LMdtgM9+KKzs0uFZkWfYqQtAJOpD2LgtZz4rz6q92wAr5k7rJR5m7x5MJx3hB17QJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sp7FvLqp0vhg5aLrWmKMpzp6arjw9zQmX+NCcseDadY=;
 b=aZPsGzhlKaxd6EytzsH0aylDOeWSahGjPLBdpZ8lZdC7Q63LtwxCjyiBIZAKXqYQJlI+boxJhLJMuYhrxlWeaoQi4t9cXgES8cvTIaddB5MRA41JxcCkT+ZJe3klocXxDz4lELmmfjRnJGgV6k+1RA+2VIHAcIL/usIwWg4A1gVnhLansXWIPvbT5lqmN7Peqgck65jDlCxmT0vzswh2E+uNUQXgtnUNsgJLrrlJaCam5AGQbe4UcWp95hcq+7sG6aR5vAgCWR09G79Ij9EfgCAqbHlBaSsn69JYdlCYHiPtKW66klZ3wri/o7LPNXuYqf2CnzQa3H3RJzgkvkPjJw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8367.eurprd04.prod.outlook.com (2603:10a6:102:1c7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 06:45:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 06:45:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: Heiko Schocher <hs@nabladev.com>, Alice Guo <alice.guo@nxp.com>, Fabio
 Estevam <festevam@denx.de>, Gary Bisson <bisson.gary@gmail.com>, Maks Mishin
 <maks.mishinfz@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH] tools: imx8image: Make imx8image_check_params() static
Thread-Topic: [PATCH] tools: imx8image: Make imx8image_check_params() static
Thread-Index: AQHcC098rUDTGwkFqEGsSautombk1bRgJRMw
Date: Wed, 13 Aug 2025 06:45:43 +0000
Message-ID: <PAXPR04MB84599BC3E230844010C213A4882AA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250812060807.1224861-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20250812060807.1224861-1-ilias.apalodimas@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8367:EE_
x-ms-office365-filtering-correlation-id: ba9c2713-cea8-4a03-3157-08ddda350687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MZ/5sP4Keea+YiPUvRG5vSdV/hUEvxP0AQMlpUNEI/JmYZT/lqcOR4cSCMUu?=
 =?us-ascii?Q?g6sOtZbFlJ7NiVe3ADUaJWqAmbR7KkR4VeB2kiP31z5sGSrjdufeLsBLOnzg?=
 =?us-ascii?Q?64DjyqgGQEnXsAjlRKsjDABNKHCq/k32VEJdIiLXG9i+SY4mo7Fl0WScVBGt?=
 =?us-ascii?Q?4Ge4YrslgxrLxubaqwcDxHemBcozkVNBhDt0gIRBGQ9bDcZI6ksbQm07JdpH?=
 =?us-ascii?Q?p3K3yTkan3K7M2W+rzQDYqJqsUyzd+8hoE2F3qkq6UuapriStKyLMa+hGyKe?=
 =?us-ascii?Q?y7ZsCVmM2x1d+bb69Z55uc+DY1by+VJiQND/fam5BHM2U3vJ3lCL5W541Piw?=
 =?us-ascii?Q?yUMsF4LrIgPlPVLAXNm4IFRFB9ibs81u8my9qp2fDSRF/62FHz937/isgugY?=
 =?us-ascii?Q?Z3DynkqttYeCzmK6Gk6m2tAQw9jrN5Z63hd67TCjmK0iSm9Tu3nHFtBt47Vq?=
 =?us-ascii?Q?N9KLb1bBkdgSMUvzHH8nBAsSkyzECEee/lksAK/zgJQ4j+QctlrsMEVf+QNg?=
 =?us-ascii?Q?LspKpGAY/yVU6sJtiuyhTHGuiTmqrJ2BrfuYgkZOgvI5hh7UiSxENGxP+6nN?=
 =?us-ascii?Q?lrFr4Yug6qW92wkA4SemnxUCLiu1q9Ap+HPythKktgv1HuML+mjrEs4M+Vz/?=
 =?us-ascii?Q?Kjm7D0/zawXHKzaeMOBEfWFWa0JQXiMFr1zuavAcJiL+eIKSe5/T6MGYedB6?=
 =?us-ascii?Q?9uOKn1D4q88U2zk1n9pDXhvs5A6LpVhg7N/6MmglRXlHqJ5mjjOqgMwFLvXc?=
 =?us-ascii?Q?YlpuHbNde2+eHF+uelvIn5L3gA3j3wW50K+mC4P5Ku9k4mhSpyDZIJ+smEtc?=
 =?us-ascii?Q?eFLIo0atSyoKuROFsAHDx4Dx623/t7kXYZtCb1ls8hyt2jBlqpu4T/iba5n4?=
 =?us-ascii?Q?QZ4C6ypfzM6j/y/1rsvn7O9li/sTc5I19OViMtxA5NMd/YDfX4Zu5RCUEbv/?=
 =?us-ascii?Q?mO5DF5qGxn+ZYGZxPYWsGJM7rEKxLw9OZMKtLJ6o6oNZCH1snjAN7KvWZvB/?=
 =?us-ascii?Q?gRAkV+y44pjiecUXMYsn4FOnsvUOW3B81xuenhEHzS+Y1D8yxch1jD/FJIN2?=
 =?us-ascii?Q?GhFGD0+moyU28DKU4exMWYghheJaAZQ+c8J892Ed8IaxCalG4EE8HgcXKLxl?=
 =?us-ascii?Q?5Vr5uubGu2USc1DpTr4mxHH2QXo3xxTcROfuNGhs86O4aWqPn1se6mIR0acj?=
 =?us-ascii?Q?bOxq7r+w8r3NdVUYVK6kzQ0dk7UFU5iaHeaCOXCliofjgLg4wVJzJ2jQAn97?=
 =?us-ascii?Q?AOTM9leF89nszF3364NsxNDm1/X80gqtwKfcJ+VAg1MyPWopYuLq9NR77VF2?=
 =?us-ascii?Q?cjNO52J+qx6VDcPli6aqTI2BIlLhFHBGmOZynepgD9obDXV7zC3B/jMPCos+?=
 =?us-ascii?Q?Ex3bE78ZZzOMLNEPtMgTcH9MZ42MK1lJwZ+SJYdhLaWcyL3B7iyedkOmOWVj?=
 =?us-ascii?Q?v+P3QQ90uW4bU8JDp6AI88Fn4r3cLXO75Ra/wdm5bx9cwYVDEaw0yA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kQUU/i8kRK3HMHKpLIhwqzNt9/R9hafXHVJnieCgkNHXFUnia346DHmuJmRJ?=
 =?us-ascii?Q?SUVVOQYfB3ST9iZtL30YiEOUhRlKmIG9DFD3fvOlsJSRhJ/7P1qhIfNal1mg?=
 =?us-ascii?Q?SNZsXx3Mfy0Jdjf7eb7a4L4nuG9DiHG8ntq+2Ei0AIVj22Jt3RGvb2cWKCSf?=
 =?us-ascii?Q?IQVI803z+I8hDJ/yjMX5Ml6x5tCS5b8T8WALJAn1I2xLCBm3VLCyk3vQ+ehu?=
 =?us-ascii?Q?uYoHiOCeCmQGpFucnNQjx/pdK/VXAm09jMCU/p01PfeZ+K30rMoA3FL1RjOP?=
 =?us-ascii?Q?FDoU65JmfIbxtM1wUPa4pOFVDyfx/7kyC3iUKSk5ztc6+F+LfKg4etk+WhU1?=
 =?us-ascii?Q?3YI70+EnNJdzdmJ+7vAtqzeiAlNI717fbCr4nTUiDWPiRnxwUNUwsxE4UO2O?=
 =?us-ascii?Q?Y32R4g/mZOhzHpxYU6xpTVZePPeQLzbgLa+IZOp4lPOO7G4pHeyWrGBaS0+o?=
 =?us-ascii?Q?rYmswW+woKQJH4pgi/x+5E2fO+D3ohaRLX14lexAeEV8fWqi5O97zfy3Mb7X?=
 =?us-ascii?Q?ZFDK0p78qeVUHeFTXlYwCoKY6kvxy48GL0ujWjhwkb+/OD581OtFstx2skYz?=
 =?us-ascii?Q?zMWMi8dPOrdLnmj8MnnqeNdzyHe4CkpTdSppw7iIqtlMQGuN14+f6AqGMyuB?=
 =?us-ascii?Q?OAWwaft/wOrYW/mWO3X5BH9jaVp9KBjrNT0fao3RFg2f8R3vCm6os6KJNvU+?=
 =?us-ascii?Q?Fi2dZcWh6lqoJpNleJAhUF4Lzlkf+Yqx6SCIit7JAR6SHUr5ddL/kRC46XHS?=
 =?us-ascii?Q?TVDccEoKsa6it0KWn+SxCFcyCY8zG51/6L3Jxtgs4pW/3lpHFZCiCsRxgAu+?=
 =?us-ascii?Q?d7sYQSH3Myf+8bDX9mwIWx4J0+9jY3akEkA7ddIThA6PS6E0aADkTA4liA+j?=
 =?us-ascii?Q?V8oK4gJCD69dDd/OilhLJsdpHMc1IJOPx6TnqowF5TPK2TmEAmc3pkkMu82F?=
 =?us-ascii?Q?k8Mo6yuOs66BM6qrxwtkZOpRMCnL1GeCFfWyLJWJU8x9lrrnvcLnEbAL1YTp?=
 =?us-ascii?Q?7eMPEtIGfM0uJhcNxnTsDAqqF6uz9Mt1FbjTXyY/zpWQmtwGrX1weMWBxnBL?=
 =?us-ascii?Q?WhPh92mpJ9TZzrXBzYRChqZMHmt+qhbg2+e3clzI4rvTtJOdNP8XAs7tSn17?=
 =?us-ascii?Q?Xg5J1Ez2NbvDjOZaas2EjJN73HzR6xGNHs1idpQIybGYLlwArqusrUbiNniX?=
 =?us-ascii?Q?TQzFxY92L5NzypVGzYEkOLSS7r27GBfSR0GMO9OgpDGzU0b/DUVWByCvhEw6?=
 =?us-ascii?Q?kIrkhWAe7zRjJ1y7jr5DPjws4U0jGI83dpLuZ5vUjyjfGNPj2tJ0W2VKMPpk?=
 =?us-ascii?Q?QkTF2ccZYnZYncGax3yEMVjrQ22X6m/VGKr+xHIjdkpQb8y487N20qZvOhqa?=
 =?us-ascii?Q?X1LId0NNxkxfWebDnMilA6LUN65IjjkOocxd+xOoZC/VZQCsYH7f+pD6iCIv?=
 =?us-ascii?Q?VvB45ybiYHoijlEG0A8ajqtjgN8H7vxKUzfqKpk+M8fDH24/eqhYi7utkhEo?=
 =?us-ascii?Q?mKdk3Sfyj7w0qKgbdLJegSaVfySsRKCxCDX0bErpSKtGgTH7MZSkAyTLRBZr?=
 =?us-ascii?Q?vE9VZWoy5EdP5Lvav0I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9c2713-cea8-4a03-3157-08ddda350687
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 06:45:43.3787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9volieLAWCmCfh60wDNbdjyK/BcQaXLn7oLK4ZhSindfEaMglgxECTvk5hWcc/ensp4IWJ9X24c9zI7oHCwmBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8367
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

> Subject: [PATCH] tools: imx8image: Make imx8image_check_params()
> static
>=20
> We are trying to enable -Wmissing-prototypes and this functiion is only
> used locally. Mark it as static.
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
