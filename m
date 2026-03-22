Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6417EFC72AD
	for <u-boot@archiver.kernel.org>; Sun, 22 Mar 2026 12:27:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 939B083FDC;
	Sun, 22 Mar 2026 13:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aNmfKn5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF3C8405B; Sun, 22 Mar 2026 13:27:06 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD2383FC6
 for <u-boot@lists.denx.de>; Sun, 22 Mar 2026 13:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py6KXCDR9Nb5Zh0JPGFV8PUh8F1COvbhjEVR1Gtf7kdGqMa4hBJS1Cloygq1axueEF5k5f/tn7TMY/3vlPyz9kVQAjm7Jjnk7Tfncw0AQJE5rVp7G0H4tgfV1CkRytwzd5G2fdNU8UCE1Cns3m9o2ks1ywhxd7wx0Q0Jn31JVFmWqAl2gwhzt1Vc9qqhQY9uIhJQIjTJx1dIQbY4Xr25yMkNgL1u//2F8KLTjM2b9Tkm8uwkxdF2KjdPv0ix2K8BVMdMwp0pXQAeeSb/dvuN3Q0RVGNx7c7B+JjzEiJdStOgZipRCRojbZCEnhxtIfw8TxbQ59D952hO0ksehRIHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/j17Jq8Mj/DK/P+Vvjr1RQjwlUnY/nkSoo6cNr91ZA=;
 b=Mcgq1Pq+e3qqwPrqc2tJCYtE+yPk0M6YJ7QeLqviuSQWp8Uwrkr7uls2KH69g1T/pAEwFNiVRUWgN0+zhpzFoVlt9OKXD5u4FH8lcyJa8gbev6o6T0Ii5I1AvzwtoGAR1kS80FfoxOuRRm6Uwm02On3upJ+j96vJxy6B9rG47XP1Byx4FzCpU5U4NXQy2b/uwji2aIZs5IcPkKkjj+CKKNlrA/iqoohsUrzKEcczEd6Ao3L30CGayAtkrr0d/X1BIfxkXHdySB+kPWX/2XvhRb7OCWVjtHLFO1u2UZADwpQnjuY5+/oBfBttUK1kQmnvckrusWOHiJHzvN1mCQwBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/j17Jq8Mj/DK/P+Vvjr1RQjwlUnY/nkSoo6cNr91ZA=;
 b=aNmfKn5PUde4cTeqqAYsCLyOWYrD3qoR6JXANApY6nRYlIF1a0RSsG151mZJs6hTfCiH2cbOSKwlUIGt2/gk3w90zKZym41idFBgAPB4k+Z3pDJqiDywdVqJ5+sejVFwodu5Vjshcd21vW3rrshIp5hyKVSxqDnANhOA/+CIPqvgqnsRKSQLoFFXFfYoL75GvjBaYIWSXq1IbKXEliJ/Rk3k9TZm5NXmA2lDrbRzoKpCVNgymMyb+PBEfr8Hcci8PCNOhUQ/FN9rZEqRKYKl84tFsnBTgJKCmFqDgZdAHcgGXQ3AZxNZAq21DVkSzcAwD6/33klBKCAFZg0PwJtxyw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9022.eurprd04.prod.outlook.com (2603:10a6:102:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sun, 22 Mar
 2026 12:26:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.022; Sun, 22 Mar 2026
 12:26:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, matteo.lisi
 <matteo.lisi@engicam.com>, Teresa Remmet <T.remmet@phytec.de>, Fabio Estevam
 <festevam@gmail.com>, Marco Franchi <marcofrk@gmail.com>, Alifer Moraes
 <alifer.wsdm@gmail.com>, "Lukas F. Hartmann" <lukas@mntre.com>, Patrick Wildt
 <patrick@blueri.se>, Heiko Thiery <heiko.thiery@gmail.com>, Marek Vasut
 <marex@denx.de>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: RE: U-Boot and legacy SPL power control on modern platforms
Thread-Topic: U-Boot and legacy SPL power control on modern platforms
Thread-Index: AQHcuLLYezNniABc4UyNlVXNULOJILW6fIfQ
Date: Sun, 22 Mar 2026 12:26:46 +0000
Message-ID: <PAXPR04MB84595AE69ADF07A9F9FAB7B1884AA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260320214518.GD502704@bill-the-cat>
In-Reply-To: <20260320214518.GD502704@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB9022:EE_
x-ms-office365-filtering-correlation-id: 31ae28d6-d2a2-4222-7f47-08de880e48c4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|19092799006|7416014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: KDrPoNKmm/u4phr9uMueVJ6WWmPEr6TNFr2qBvUX7I+r7CuFyUge1jdUn+Ug+dbKmguHdzgHEo9rsOGKATn+VJKniKSbtCo2+mqEjK9h5t2dlpFq/4MSumm7pJE8adul2pEWjkmmww7P5uZq+5Dlg6LnvRVoWh3wMN+RdeyOPNpKuZha7M0NuuytcZjn+pmhnOsSwoljTxYloSbhxP2SlHxpHY5BHnohM1/FVHv56H0xb1ocmT85TJdK0B/FT5vMkPOBj+K3l/RZmyP9DDUVzx+Yl0ltskJYAnobUjK3l4/WVVZpoqqyVBfb3Cw7q1QipUYpbAN3klMbip5emInu+YAUGdzo5MeqwGA1xJcD9Onl4kJYyjdDrrxT+K2BlOqD+9KHFzJGWFSqvJLDBg8Tdw6+L/SWnt/zIizzvkHixFHt+IyLafMYf2a7emTrFBqVYcEwJcU4NsxWVo96+pIWx8gtlqN1hVJu1mUaTq4JvDecBQydktBgnjA9Tg299M+pCmxnBiWSIeoWCm681s12SRPaBeMU3mL5rrE5NrMYmyiyiGGzfa1LR1Dk5a/z8JI9kBFGMFOUZ1JtPvnb9Y6mIYXG5FCChkC2oTOLrKyqL+DoT+uqIBjSgklLDttsS39dWdzJ21xw0UkSsnsvBCmgC+isIDmn0dicb1OLRs7g5qTGtcsYry7AFcMaFgeR/UGkKKo/iBuOR8kuavqYm7eGkX4865nGIgim4thl//tuSOQ4s9u/X2BIurPiRldyB6M34qwRodIxaQJNt7BiJEp5XT1YMKK+fHBjPjptEK7FxZc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(7416014)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rmt58EecZchfGAdE+Ymj0fZn9OWNe4NCyVzZLktB3hVXb15LkMkv/3gZLNqO?=
 =?us-ascii?Q?a6GQ/Zg4sK4F/Fd837C7ihUfrZonucQ49vU27YvskL4QAjUIGS/yACEBcEnz?=
 =?us-ascii?Q?rC4S6cRRNPmj9szcMuv+UEupdoeWEOIy9esF5ThfvX0/EmQhp1QCjdDE7DS3?=
 =?us-ascii?Q?uaF/GO2KkxkctUi0OY5YFMi5L2H8nm5Ylvqj/kWhi7phsEbGNoPKdezS29lc?=
 =?us-ascii?Q?PX58fOgJrh7zfA6SRFfRYvd44PBk4EPFbfVWYA7XsraF1LGjwouMU3ifuxZB?=
 =?us-ascii?Q?CwatiNxGpOZY/fR+YjWFRoyO4PoJeor2vHiBfF/uUMueKMIaejBnD1eYfLvU?=
 =?us-ascii?Q?j8r+lEKg9ki3vYoMZkEonXBn+6Y+ZTlmiEGWsJBTpZ95t2sYjCc9BgoC2/Aa?=
 =?us-ascii?Q?o+a3r1zfY6uYtXsU2rMhh1vs0nhZfZQNFQQP6QNYLiyqcthi4a5J6gWt9Nwt?=
 =?us-ascii?Q?3KD4lqNnil3kaLeDY/UVOWRa4a6421Luu4DCuXQ77FVvoFjB/sN/nqsj+OD9?=
 =?us-ascii?Q?k2voX7/FzDdFQ/vFs1wMlNgTyh1wlcCNZuDt1uDYFu4GCic0/dPnGo8asdmu?=
 =?us-ascii?Q?HPIViQ28E2fRtEl44A7bJdOl0yHHk/TGa1WVA0Q5v47PgebxsUsqB4qObEwo?=
 =?us-ascii?Q?BnFnlYZPkI2MbJ+cZlbkNqrbrerHe817TSzDo8ALnleoPkbdBtKzzagr0S4t?=
 =?us-ascii?Q?N/bw4cBAuW8kjUcO4oZvZmSO6fWFU8NKKNU7L4vT6yhvavLYH6HdCGvkZr5R?=
 =?us-ascii?Q?YxDKUOYkdumy969YQ5yQrDjUFy71knVCXUaLBuCTaKn2fHSiWSEoMiWTxiwH?=
 =?us-ascii?Q?7JoxcPb1LO8YmpCvjIGS7RXAXDOg95VolH4SvqLkAqqpDwliJDdh89gIBjF4?=
 =?us-ascii?Q?IycJRhm5otWlmXhPTUUsJ99KJZKQZrERxk6qGNhiPPxJMrLEJ6m4JXDuZduE?=
 =?us-ascii?Q?DdGPvchClf2zYaKwwPDU+2iK7cJl//uprw1edvxvoy2E4/sXfP/hI3V8Fdsn?=
 =?us-ascii?Q?OIiKjaDCPMGB865NspUHgGw7rzPlRvYR0aDSnu2ihulqdYnSaR6MJctzeunH?=
 =?us-ascii?Q?7RwfFCUa1HSw+Ylsqw5VXYKsIY/zkqMcEAYIIxUaKnArlWMLB2nelwqQ5xtC?=
 =?us-ascii?Q?GpIxy7eQzVCMObwI6VvWrA0ubmGEljpKUK4IfOLf/HhTtxoVPpWs+maPcrVq?=
 =?us-ascii?Q?nqWR69rRpnR2a4nQ/xD4GlH1CCYh2uLSkZ9ciEOt1nkgslOeLaYwfpHq2/2J?=
 =?us-ascii?Q?2ZmQBjHYxe5o4l55wNUhKCYarAxcbj1vqnjEOv2mE7quQS7u5TrfnPUI+hc1?=
 =?us-ascii?Q?GuB6pRio/67nffSoC4+DCytEWnQ1UzK+t0hiajXvWboYsYwGodT6dlCKhnUU?=
 =?us-ascii?Q?VymKs4XXcUmWmss2UbAMbeovYDjwPWym3z9tk5V+OAoXRSD33+22ezRN1ek8?=
 =?us-ascii?Q?YDg+LLWEuNHo2e8tHfySELNjqJyq9AUAgc1x4PPjNUOedNsfHUsw2JrwaXm2?=
 =?us-ascii?Q?+XWLsgUQybHiV5YCl1MVJZFJIMeFexxxck/ymv/RGMwwiB73ToHvUn0DdABk?=
 =?us-ascii?Q?KpTyfDnaSp/je23AqE85MBrtHqRXAuCBm/phzBAIZQzc6qKHrMglKZhg7Oyd?=
 =?us-ascii?Q?8FEN0ff7/dyk4vtYrWtC/krYOtOy4LrMqnIEIsrGIuObXguEm4E+x3r+C7de?=
 =?us-ascii?Q?PZ8CgEKk3HXPiDLF09qv2QPr8sAdc5x/FmHjJ67cmSSRKVMC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ae28d6-d2a2-4222-7f47-08de880e48c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2026 12:26:46.4737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2G1miX3QkPJBREozst3d5NF7ti4MXNI/cXpzDL93ktkfRdFgS+1Ygwp61kYgdEHQog2FDYDuoyr7alU975XPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9022
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

Hi Tom,

> Subject: U-Boot and legacy SPL power control on modern platforms
>=20
> Hello,
>=20
> As part of the work I've been doing on clarifying Kconfig dependencies
> I've stumbled on to a number of modern boards[1] that are using the
> SPL_POWER_LEGACY symbol. Can the maintainers please update these
> to use DM_PMIC, DM_REGULATOR (and SPL variants) as needed so
> that they use the modern architecture, or let me know what's missing
> here? Thanks!

If board maintainers would work on the migration, that would be great.
If not, I will give a check, but I not have the board to test.

Regards
Peng.


>=20
> --
> Tom
>=20
> [1]: imx8mp-icore-mx8mp-edimm2.2 imx8mp-libra-fpsc imx8mq_evk
>      imx8mq_phanbell imx8mq_reform2 kontron_pitx_imx8m phycore-
> imx8mp
>      pico-imx8mq verdin-imx8mp
