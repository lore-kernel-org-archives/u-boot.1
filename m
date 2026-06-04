Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107E0CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 465EA8484F;
	Thu,  4 Jun 2026 14:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mlMDXPeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1335E84715; Thu,  4 Jun 2026 07:49:59 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E62844CF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 07:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpQ1QQdagfbqfW94kq5KOPrLMC2bHRK/qFXSpCYalt1tRtF7sFkYwi94amY1cgKS/u06tj5kWhcIb54inYk8/lqhkg2J3Ivu0nc1stLWOgHy/AucunjlGgTLXj302GDCuALrk5Qv4sqyI3uiDs8YlSU4lCf1+q304kX2pZBiyGGOpXB7y/Mck18DaWWxiDzTSLR1tamg2uKu+dnjrbSC0XtEaJphW4GrJdVxXJOS12Uc0RiWXyWkvLUGKhRy1Bug8roE95pZC0+mT0m6Q+h+6YDFVZwvSaSNguSAePLhdDTqy04gKs6oMxDg2cvP5tk9Z9rLcysAKColx5axkjk2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rE+VMJs897r3Nfgg5eZ2gPmpIOs673guVZgT5FwmDs=;
 b=Gc/qJYz4092ALSBLF2qfis7k/1PLPM/WkCfuJ8hpjuimlPpUDPTrEKXsbNjA3FQMSICuZ9vfQxZchkm/BzYQwZy+KlnWbLk4QG5nFmzFLSKMXdW2mbuVsAZlpjWK3HOTQAY70RDVyFbJ6lDh3etkJZ1x3vK+nw3AvwolBkVQZTRn2ogWZlkl+ugTzkfI9OybByWidF28oJJE1dR4hKbX0XuC0F/oGKl4+GER7lZ8ss1ht9TABguothWqsbXNy+Oilh4qp5V9w5XwdoFcApsNCId+8lqcuPH7t8Ggs8Sg9NvfHPvciPW6CXkCyD2nC93y/J7Ml7ixpMuueNURAjHOqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rE+VMJs897r3Nfgg5eZ2gPmpIOs673guVZgT5FwmDs=;
 b=mlMDXPeqtGqKEMeMZ5lwXJVe+uYwrMQrsrl1EC8raeYZPSO3Ba8latao9HGoeypyvJpbHm+XGDGdofm5455iMgHfU5DUeaN69WA+B38LNCoVDPaP6R0/SqkxbfPZYhK7c+1hhrpDRv3HIxc/S0McZA4buqdVq8bnr4lipXZ8aqEcWkhCBbu7s0t+aAWCghdn4pVIoOg9piikLfqBWA1kTmPyc3g6R3WXexISk8SrzC8zDPfHfIdJdfQhsuNqCxPPIq6edRVD1QGg3MPiVzdt9LmSHFUQZSU/4ENUTJLV8oQZmXHfUWVwytV4mGZHgekw2YxuWt34GqqDBRJ3SKgTMg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11562.eurprd04.prod.outlook.com (2603:10a6:150:2c8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 05:49:47 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 05:49:47 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Christoph Stoidner <c.stoidner@phytec.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, Fabio Estevam
 <festevam@gmail.com>
CC: Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>, Peng
 Fan <peng.fan@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Joseph Guo
 <qijian.guo@nxp.com>, Francesco Valla <francesco@valla.it>, Sumit Garg
 <sumit.garg@oss.qualcomm.com>, Ye Li <ye.li@nxp.com>, Primoz Fiser
 <primoz.fiser@norik.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Sam Protsenko
 <semen.protsenko@linaro.org>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Andre Przywara
 <andre.przywara@arm.com>, Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Johan Jonker <jbx6244@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, David
 Lechner <dlechner@baylibre.com>, Parth Pancholi <parth.pancholi@toradex.com>, 
 Paresh Bhagat <p-bhagat@ti.com>, Janne Grunau <j@jannau.net>, Paul
 Kocialkowski <contact@paulk.fr>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Brian Sune <briansune@gmail.com>,
 =?utf-8?B?SsOpcsOpbWllIERhdXRoZXJpYmVzIChTY2huZWlkZXIgRWxlY3RyaWMp?=
 <jeremie.dautheribes@bootlin.com>, Jacky Bai <ping.bai@nxp.com>, David Zang
 <davidzangcs@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, Simon
 Glass <sjg@chromium.org>, =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, "Ross, Fedor" <fedor.ross@ifm.com>, Stefan
 Roese <stefan.roese@mailbox.org>, Lukasz Majewski <lukma@denx.de>, Max
 Krummenacher <max.krummenacher@toradex.com>, Wadim Egorov
 <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>, Simona Toaca
 <simona.toaca@nxp.com>, Anshul Dalal <anshuld@ti.com>, Franz Schnyder
 <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjQgMC84XSBpbXg6IFN3aXRjaCB3YXRjaGRvZyBh?=
 =?utf-8?Q?ddressing_from_macros_to_devicetree?=
Thread-Topic: [PATCH v4 0/8] imx: Switch watchdog addressing from macros to
 devicetree
Thread-Index: AQHc51d0qOU9oohRP0iBFn6CfBb4NbYt/TIQ
Date: Thu, 4 Jun 2026 05:49:47 +0000
Message-ID: <PAXPR04MB964406C7D2205192B8BC6747E2102@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
In-Reply-To: <20260519-wdtv4-v1-0-deef133b81cd@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV2PR04MB11562:EE_
x-ms-office365-filtering-correlation-id: 7434c77a-ae7d-4ad8-e066-08dec1fd15f0
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 6sUff7gqoQ58fRQ7y9GSF8a2MICvtG0tgEVYvKWgK4Xftk6PE2R6EfpX56gimyF9C6T0dGubzJbxxJLI5VCZjs6iIPuoUugF/O46TMDqQ9JNbSzmnqay81vhv2o0114/INPUg9f4SfBY9xCbMPX+MJ+HOJp/0dTQ8Vodp6dLJ1/PIhXReiW8s9VHBW5O2hlfB7+bdMPPTtEtZ/3ErTnU8GyH8aTwE7cp7jSGdcMBzB1tvHskj+RjE8bmNdUnKUvCaONmpmKM3bNWhSxauy8zxrveG6bpDfEOnRzwTzHvFL1bblB3t16SvRiqMeW5hBU+UDLwCbOyrWISAS620q8F1V9pbR8gQW/8e0pFm4tTahF5mU6Ck5x2HZwXU+vocu7onXO7LXdgnnYblzvpU/rQRFsUK122cUdYd0/Svh7yJ+tnoylXST64J3yyo9RAOUAleXt1jLwFLmGF6HIH63/6+rljHzwFfgMTxniRNLxMVDrOKuHlvV9c4c33mVB026c6SWCqS0n7HMDsjvMs6bMJGiE5Dze6t9E4+iEqar8Afs/xrNgK7uVUYuHKH21GaBetHdP8DexccLTIR3TFoQvfIeE6U2COMpUk4YyrqKIeDOppkxdCRm2CKOKaH6DDZaNb2qkCoS8TgqmTq/7IhtPaPg9CZlQg9bEzChymKo7yXjqRaRw1KouTFTes3f1hLlxQfUobsKISKpuQNCNt4NDppi7brHFpAEFjNR0cPxyZb4fT+CSsCy11vDV0F8RqaeLL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2tlQWpOanpPcEZ3OUpXZldQaEF3SW9FMHgvTHpjY2p1dDBtcEExZ25xamVB?=
 =?utf-8?B?ZUNHZlcwS2taNmlQVnVES04vbkt5Uzl4ZVllKzFpUjVVNXlEZCtETG5vMmNP?=
 =?utf-8?B?eENNakVZd3MxS2MvSkVXZjFnQWs0VDg1b3ZhQzVhcmIwZUpGTDJTYzNYdFIy?=
 =?utf-8?B?QUUrMkgyd0c1ZG9QZER0bDNxSmJoMkp6VWRKSk52QlNuSXVaMTVtRUZHWEpB?=
 =?utf-8?B?RWtnZlFzQmNraXdZbHNQejBmVmlZb3lhbXpzSmkvakpsRzI2VitRd3lmOEIw?=
 =?utf-8?B?c1pTZHRXQ1Z1Y0VRdGFuT2RacTdLUklTbWVlNmdRK1k3bW9hOHpibkNQNGg5?=
 =?utf-8?B?WlZsRWt5QUVaR01rSVF4NGYzTmh0U0hRWnVCRVJ5Z0xFVUJuOTdDa1BsaEtD?=
 =?utf-8?B?MEQ5OE5hTHpaUHJMMVJzZG9aUk9KdmhPMjd4VW9zSGQyZmUxNWl2eWxlVDd3?=
 =?utf-8?B?eHV4eWJ6NUFwcDZYSWVwY3M3M2dMdWpPZmFFTTRsWEJLVlJtQ3VicFNybmkr?=
 =?utf-8?B?N2dZMjY4dEpzRGEzbDI3UkZBWVhTTWxyNzl3c1VPWVRjODc3WGRpQUx3Vm1N?=
 =?utf-8?B?ekN4aDIrL0cramdMQS9JMGNaTjh3NjVYR2MxbTRXN3lJeEdQUXAyQTRqK0Jy?=
 =?utf-8?B?enFucGRxdzJjMUhiTWhiK0dVd2VUYjlKVjR5OVpFb1hRa2psRGt5MUVoUWJ3?=
 =?utf-8?B?cWYxa09YQlJlVTRUMTU3UjA4eFdOQktGbHREc1ZUREZVb0JCdGgxc1VQeXJX?=
 =?utf-8?B?SUVOMXVmMXljMW9MSkNpQWhBZmFpQVNlanVEbE5TU2xIZW13U1NzTGhiczhU?=
 =?utf-8?B?UnNFbmFXOGh6ejkrN2UrS3daS1ZmV0JUSWw1Ym5NMWJWWjBnWnJ0TWFpQXpL?=
 =?utf-8?B?aURsVVJzVmo1Ulo1eEdHSjVxNW8ydmVmQ1R6STZQczNTZmxpT1hGWVFJMWxu?=
 =?utf-8?B?YklwMksyNHU5TzZvVlV5dk1NUjZPQkRaRzdFSEcrTWdQaUhneXFmY2tPVzZO?=
 =?utf-8?B?Sk43UGhtMDROdmtCc2dxSUxHL3IzVktlK2NDTXkzOXVKZzNTNU85ZnpLNi9Y?=
 =?utf-8?B?RFk3YVFHSHd2NXBneDhVcU56RTBiSTNtU3MwRnR3Nnc1VE9TaDM0Sy91WEMr?=
 =?utf-8?B?UmVOeW41b3M1a0grNUh6eExtNS9EZVdPVkdaays4U3lpQUJaakRpRk4yMHVp?=
 =?utf-8?B?em14WUxtSkdBN3RIQ20vYStuRHpzRXVtUEM4UWpZVm5WNTRscmdtcDdaVTAx?=
 =?utf-8?B?YXNaQ0cwRU9OTFU3aVdIbENjZnJEQndXanZKcENXa2Q5RHJLdFJsTDNHdXVr?=
 =?utf-8?B?K1N1UGZkNGdUcEt6clRrOHVhRHBPN0VGWjYxdHh6dU53Um5rbE9uMEVuUmhE?=
 =?utf-8?B?bzRKQUkyNk5kRzV5RGtkZUtOdjM4b3h6dnBLYk9hMzUyTDFGaDU5N285d3FO?=
 =?utf-8?B?TXRJSk9nUXFXOG50eC9RazljK0NoSGV4L2lDRHRPbmVNYmFqT1k2Z09oaTFy?=
 =?utf-8?B?ZDFtRkkvN2JsVEhlRjRDbGpJaGlNU3o5bWZwS3VwdWxiZW9DVGVjWE1kc1pP?=
 =?utf-8?B?M1M1bkhpQ21CVWJmTGdZNHRjNjBPM29WSmkwUEhFdEJvNXpMaXRJQVdTb0lk?=
 =?utf-8?B?Vi92N3JOeUc3TDZUYytDdXZ3MmQ4dVpQL05RVS8rU3hLcUxQK0dFU1Iya1Zt?=
 =?utf-8?B?VFg5b1B5VldxMWEyY1VoM3ozU28yVE5OMmt3cW1XdndKMWg1MktMZzJyWXYw?=
 =?utf-8?B?NnFoeXBYRHJ3OHNGeUF3RFZTbWxKWi9pRDdXSDQ1cm1HVkxJSlNGZXdTem0r?=
 =?utf-8?B?Zk5ZNS9OSUdnWmNxWkpVaGJ3L2ZEUGgwajRrUDlQdGFFZ2xMS1JZZTE4c1Bx?=
 =?utf-8?B?UGhrVzJLZ295V25nb2RqNGkxSlZlUDRLUWs2QXVCdk15OUZGQkJrUzVBNnUx?=
 =?utf-8?B?Yis0OXFOcVdDeE91T1JSdmF1Mkx1N01ZSGRtMmZMNENjeEpxWWNWRnpSbDVQ?=
 =?utf-8?B?MlNqVVJBWFVBSmZtQkRnb0ppd0ZpcW94NmEwbm1RNk54ZnhrVmh5bCt0RlV6?=
 =?utf-8?B?SkFLNnhrQThyR3ZSTzU5SlBsNjgwbncwWDRqVGUzcm1HRitLRkNMbkplRUt6?=
 =?utf-8?B?NXppdTErNTZZeFB2R1Ardmk1TEhVa3NCNmdyM0tnWHBJcnJJWEhZRW9ZSXc2?=
 =?utf-8?B?bVg4U2ttN1RHWUswb05qZE5CMVFzK3RQMEV2dk1PMEdHN0drMkZibmVobmJz?=
 =?utf-8?B?Q0FDaUVhazZ0bFpWL2JETDhmS0FEc1N2Z0NlZnR3ZU1VR0xxdHNsM3B0L2I2?=
 =?utf-8?Q?hwrJCcmoElaRKgDKy/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7434c77a-ae7d-4ad8-e066-08dec1fd15f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 05:49:47.2081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3WwpKFo85oiq5jLng++9S1FeNlQ/2EMzcFO8odhRAnb+WfnwK4MxiHmsvFZ5jsF4gM/TqnaaRJMllIFZdBUK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11562
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

SGkgRmFiaW8sDQoNCk1heSBJIGtpbmRseSBhc2sgaWYgdGhpcyBzZXJpZXMgY2FuIGJlIGNvbnNp
ZGVyZWQgZm9yIGluY2x1c2lvbiBpbiB0aGUgbmV4dCBicmFuY2g/IFRoYW5rcyENCg0KQmVzdCBy
ZWdhcmRzLA0KQWxpY2UgR3VvDQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bk
uro6IFUtQm9vdCA8dS1ib290LWJvdW5jZXNAbGlzdHMuZGVueC5kZT4g5Luj6KGoDQo+IGFsaWNl
Lmd1b0Bvc3MubnhwLmNvbQ0KPiDlj5HpgIHml7bpl7Q6IDIwMjblubQ15pyIMTnml6UgMTQ6MjIN
Cj4g5pS25Lu25Lq6OiBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsgdS1ib290QGxp
c3RzLmRlbnguZGU7IENocmlzdG9waA0KPiBTdG9pZG5lciA8Yy5zdG9pZG5lckBwaHl0ZWMuZGU+
OyB1cHN0cmVhbUBsaXN0cy5waHl0ZWMuZGUNCj4g5oqE6YCBOiBTdGVmYW5vIEJhYmljIDxzYmFi
aWNAbmFibGFkZXYuY29tPjsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsg
VG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAu
Y29tPjsgRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPjsN
Cj4gTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBKb3NlcGgg
R3VvDQo+IDxxaWppYW4uZ3VvQG54cC5jb20+OyBGcmFuY2VzY28gVmFsbGEgPGZyYW5jZXNjb0B2
YWxsYS5pdD47IFN1bWl0IEdhcmcNCj4gPHN1bWl0LmdhcmdAb3NzLnF1YWxjb21tLmNvbT47IFll
IExpIDx5ZS5saUBueHAuY29tPjsgUHJpbW96IEZpc2VyDQo+IDxwcmltb3ouZmlzZXJAbm9yaWsu
Y29tPjsgRW1hbnVlbGUgR2hpZG9saQ0KPiA8ZW1hbnVlbGUuZ2hpZG9saUB0b3JhZGV4LmNvbT47
IEZyaWVkZXIgU2NocmVtcGYNCj4gPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT47IFNhbSBQ
cm90c2Vua28NCj4gPHNlbWVuLnByb3RzZW5rb0BsaW5hcm8ub3JnPjsgVGllbiBGb25nIENoZWUg
PHRpZW4uZm9uZy5jaGVlQGFsdGVyYS5jb20+Ow0KPiBTdnlhdG9zbGF2IFJ5aGVsIDxjbGFtb3I5
NUBnbWFpbC5jb20+OyBBbmRyZSBQcnp5d2FyYQ0KPiA8YW5kcmUucHJ6eXdhcmFAYXJtLmNvbT47
IEVybmVzdCBWYW4gSG9lY2tlDQo+IDxlcm5lc3QudmFuaG9lY2tlQHRvcmFkZXguY29tPjsgSm9o
YW4gSm9ua2VyIDxqYng2MjQ0QGdtYWlsLmNvbT47IEhhaQ0KPiBQaGFtIDxoYWkucGhhbS51ZEBy
ZW5lc2FzLmNvbT47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47DQo+IFBh
cnRoIFBhbmNob2xpIDxwYXJ0aC5wYW5jaG9saUB0b3JhZGV4LmNvbT47IFBhcmVzaCBCaGFnYXQN
Cj4gPHAtYmhhZ2F0QHRpLmNvbT47IEphbm5lIEdydW5hdSA8akBqYW5uYXUubmV0PjsgUGF1bCBL
b2NpYWxrb3dza2kNCj4gPGNvbnRhY3RAcGF1bGsuZnI+OyBNYXRoaWV1IER1Ym9pcy1CcmlhbmQN
Cj4gPG1hdGhpZXUuZHVib2lzLWJyaWFuZEBib290bGluLmNvbT47IE1hdGhpZXUgT3RoYWNlaGUN
Cj4gPG0ub3RoYWNlaGVAZ21haWwuY29tPjsgQnJpYW4gU3VuZSA8YnJpYW5zdW5lQGdtYWlsLmNv
bT47IErDqXLDqW1pZQ0KPiBEYXV0aGVyaWJlcyAoU2NobmVpZGVyIEVsZWN0cmljKSA8amVyZW1p
ZS5kYXV0aGVyaWJlc0Bib290bGluLmNvbT47IEphY2t5IEJhaQ0KPiA8cGluZy5iYWlAbnhwLmNv
bT47IERhdmlkIFphbmcgPGRhdmlkemFuZ2NzQGdtYWlsLmNvbT47IFF1ZW50aW4gU2NodWx6DQo+
IDxxdWVudGluLnNjaHVsekBjaGVycnkuZGU+OyBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9y
Zz47IEpvw6NvIFBhdWxvDQo+IEdvbsOnYWx2ZXMgPGpvYW8uZ29uY2FsdmVzQHRvcmFkZXguY29t
PjsgUm9zcywgRmVkb3IgPGZlZG9yLnJvc3NAaWZtLmNvbT47DQo+IFN0ZWZhbiBSb2VzZSA8c3Rl
ZmFuLnJvZXNlQG1haWxib3gub3JnPjsgTHVrYXN6IE1hamV3c2tpIDxsdWttYUBkZW54LmRlPjsN
Cj4gTWF4IEtydW1tZW5hY2hlciA8bWF4LmtydW1tZW5hY2hlckB0b3JhZGV4LmNvbT47IFdhZGlt
IEVnb3Jvdg0KPiA8dy5lZ29yb3ZAcGh5dGVjLmRlPjsgTWFydGluIFNjaHdhbiA8bS5zY2h3YW5A
cGh5dGVjLmRlPjsgU2ltb25hDQo+IFRvYWNhIDxzaW1vbmEudG9hY2FAbnhwLmNvbT47IEFuc2h1
bCBEYWxhbCA8YW5zaHVsZEB0aS5jb20+OyBGcmFueg0KPiBTY2hueWRlciA8ZnJhbnouc2Nobnlk
ZXJAdG9yYWRleC5jb20+OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiDkuLvpopg6
IFtQQVRDSCB2NCAwLzhdIGlteDogU3dpdGNoIHdhdGNoZG9nIGFkZHJlc3NpbmcgZnJvbSBtYWNy
b3MgdG8NCj4gZGV2aWNldHJlZQ0KPiANCj4gQ0k6IGh0dHBzOi8vZ2l0aHViLmNvbS91LWJvb3Qv
dS1ib290L3B1bGwvOTc0L2NoZWNrcw0KPiANCj4gVGhlIHdhdGNoZG9nIERUIGNoYW5nZXMgaGF2
ZSBhbHJlYWR5IGJlZW4gcG9zdGVkIHRvIHRoZSB1cHN0cmVhbSBMaW51eA0KPiBrZXJuZWwsIGFk
ZHJlc3NpbmcgdGhlIGNvbmNlcm4gYWJvdXQgYXZvaWRpbmcgdW5uZWNlc3NhcnkgZ3Jvd3RoIG9m
DQo+IHUtYm9vdC5kdHNpLiBMaW51eCBEVCBjaGFuZ2VzIGFyZSBhdmFpbGFibGUgYXQ6DQo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDUxMjAyNDg1MC45MDQ1NTEtMS1hbGljZS5n
dW9Ab3NzLm54cC5jb20vDQo+IFQvI3UNCj4gDQo+IENoYW5nZXMgZm9yIHYyOg0KPiAtIEl0ZXJh
dGUgYWxsIHdhdGNoZG9nIG5vZGVzIGluIGRldmljZSB0cmVlIGluc3RlYWQgb2Ygd2RvZyBhbGlh
cw0KPiAtIERlbGV0ZSBub24tRE0gaW1wbGVtZW50YXRpb24gb2YgdGhlIFVMUCB3YXRjaGRvZyBk
cml2ZXINCj4gDQo+IENoYW5nZXMgZm9yIHYzOg0KPiAtIENvbnZlcnQgaW14N3VscCwgaW14OTEs
IGlteDkzLWZyZG0gYW5kIGlteDkzX3Zhcl9zb20gdG8NCj4gQ09ORklHX09GX1VQU1RSRUFNDQo+
IA0KPiBDaGFuZ2VzIGZvciB2NDoNCj4gLSBSZXBsYWNlIG9mbm9kZV9ieV9jb21wYXRpYmxlIHdp
dGggdGhlIG9mbm9kZV9mb3JfZWFjaF9jb21wYXRpYmxlX25vZGUNCj4gLSBSZW9yZGVyIHBhdGNo
IFt2Myw1LzldIGFuZCBwYXRjaCBbdjMsNi85XQ0KPiAtIE1lcmdlIHBhdGNoIFt2Myw3LzldIGFu
ZCBwYXRjaCBbdjMsOC85XQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5n
dW9AbnhwLmNvbT4NCj4gLS0tDQo+IEFsaWNlIEd1byAoOCk6DQo+ICAgICAgIGlteDd1bHA6IFN3
aXRjaCB0byBPRl9VUFNUUkVBTQ0KPiAgICAgICBpbXg5MTogU3dpdGNoIHRvIE9GX1VQU1RSRUFN
DQo+ICAgICAgIGlteDkzLWZyZG06IFN3aXRjaCB0byBPRl9VUFNUUkVBTQ0KPiAgICAgICBpbXg5
M192YXJfc29tOiBTd2l0Y2ggdG8gT0ZfVVBTVFJFQU0NCj4gICAgICAgYXJtOiBkdHM6IGlteDog
VXBkYXRlIHdhdGNoZG9nIG5vZGVzIGZvciBkeW5hbWljIGJhc2UgYWRkcmVzcyBsb29rdXANCj4g
ICAgICAgaW14OiBzb2M6IEdldCB3YXRjaGRvZyBiYXNlIGFkZHJlc3NlcyBmcm9tIGRldmljZSB0
cmVlDQo+ICAgICAgIHdhdGNoZG9nOiB1bHBfd2RvZzogVXNlIGRyaXZlciBtb2RlbCBmb3IgcmVz
ZXRfY3B1KCkNCj4gICAgICAgaW14OiBSZW1vdmUgaGFyZGNvZGVkIHdhdGNoZG9nIGJhc2UgYWRk
cmVzcyBtYWNyb3MNCj4gDQo+ICBhcmNoL2FybS9kdHMvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDQgLQ0KPiAgYXJjaC9hcm0vZHRzL2lteDd1bHAtY29tLXUtYm9vdC5k
dHNpICAgICAgICAgICAgIHwgICAyICsNCj4gIGFyY2gvYXJtL2R0cy9pbXg3dWxwLWNvbS5kdHMg
ICAgICAgICAgICAgICAgICAgICB8ICA3OSAtLQ0KPiAgYXJjaC9hcm0vZHRzL2lteDd1bHAtZXZr
LXUtYm9vdC5kdHNpICAgICAgICAgICAgIHwgICA2ICsNCj4gIGFyY2gvYXJtL2R0cy9pbXg3dWxw
LWV2ay5kdHMgICAgICAgICAgICAgICAgICAgICB8IDEzMyAtLS0tDQo+ICBhcmNoL2FybS9kdHMv
aW14N3VscC11LWJvb3QuZHRzaSAgICAgICAgICAgICAgICAgfCAgMTcgKw0KPiAgYXJjaC9hcm0v
ZHRzL2lteDd1bHAuZHRzaSAgICAgICAgICAgICAgICAgICAgICAgIHwgNDYxIC0tLS0tLS0tLS0t
LQ0KPiAgYXJjaC9hcm0vZHRzL2lteDh1bHAtZXZrLXUtYm9vdC5kdHNpICAgICAgICAgICAgIHwg
ICA0IC0NCj4gIGFyY2gvYXJtL2R0cy9pbXg4dWxwLXUtYm9vdC5kdHNpICAgICAgICAgICAgICAg
ICB8ICAgNCArDQo+ICBhcmNoL2FybS9kdHMvaW14OTEtMTF4MTEtZXZrLmR0cyAgICAgICAgICAg
ICAgICAgfCA4NzUgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vZHRzL2lteDkx
LTExeDExLWZyZG0uZHRzICAgICAgICAgICAgICAgIHwgNzczIC0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gIGFyY2gvYXJtL2R0cy9pbXg5MS1waW5mdW5jLmggICAgICAgICAgICAgICAgICAgICB8IDc3
MCAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBhcmNoL2FybS9kdHMvaW14OTEtdS1ib290LmR0c2kg
ICAgICAgICAgICAgICAgICAgfCAgMTIgKw0KPiAgYXJjaC9hcm0vZHRzL2lteDkxLmR0c2kgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDUzIC0tDQo+ICBhcmNoL2FybS9kdHMvaW14OTMtMTF4
MTEtZnJkbS5kdHMgICAgICAgICAgICAgICAgfCA2MDMgLS0tLS0tLS0tLS0tLS0tDQo+ICBhcmNo
L2FybS9kdHMvaW14OTMtdS1ib290LmR0c2kgICAgICAgICAgICAgICAgICAgfCAgMTIgKw0KPiAg
YXJjaC9hcm0vZHRzL2lteDkzLXZhci1zb20tc3ltcGhvbnkuZHRzICAgICAgICAgIHwgMzIzIC0t
LS0tLS0tDQo+ICBhcmNoL2FybS9kdHMvaW14OTMtdmFyLXNvbS5kdHNpICAgICAgICAgICAgICAg
ICAgfCAxMTEgLS0tDQo+ICBhcmNoL2FybS9kdHMvaW14OTMuZHRzaSAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCA5MDYNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIGFyY2gvYXJtL2R0
cy9pbXg5NDMtZXZrLXUtYm9vdC5kdHNpICAgICAgICAgICAgICB8ICAgNCAtDQo+ICBhcmNoL2Fy
bS9kdHMvaW14OTQzLXUtYm9vdC5kdHNpICAgICAgICAgICAgICAgICAgfCAgMTkgKw0KPiAgYXJj
aC9hcm0vZHRzL2lteDk1LTE1eDE1LWV2ay11LWJvb3QuZHRzaSAgICAgICAgIHwgICA0IC0NCj4g
IGFyY2gvYXJtL2R0cy9pbXg5NS0xOXgxOS1ldmstdS1ib290LmR0c2kgICAgICAgICB8ICAgNCAt
DQo+ICBhcmNoL2FybS9kdHMvaW14OTUtdG9yYWRleC1zbWFyYy1kZXYtdS1ib290LmR0c2kgfCAg
IDQgLQ0KPiAgYXJjaC9hcm0vZHRzL2lteDk1LXUtYm9vdC5kdHNpICAgICAgICAgICAgICAgICAg
IHwgIDE0ICsNCj4gIGFyY2gvYXJtL2R0cy9pbXg5NS12ZXJkaW4td2lmaS1kZXYtdS1ib290LmR0
c2kgICB8ICAgNCAtDQo+ICBhcmNoL2FybS9kdHMvaW14OTUyLXUtYm9vdC5kdHNpICAgICAgICAg
ICAgICAgICAgfCAgMTQgKw0KPiAgYXJjaC9hcm0vaW5jbHVkZS9hc20vYXJjaC1pbXg4dWxwL2lt
eC1yZWdzLmggICAgIHwgICAyIC0NCj4gIGFyY2gvYXJtL2luY2x1ZGUvYXNtL2FyY2gtaW14OS9p
bXgtcmVncy5oICAgICAgICB8ICAgOSAtDQo+ICBhcmNoL2FybS9tYWNoLWlteC9pbXg4dWxwL3Nv
Yy5jICAgICAgICAgICAgICAgICAgfCAgMTIgKy0NCj4gIGFyY2gvYXJtL21hY2gtaW14L2lteDkv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAgNCArDQo+ICBhcmNoL2FybS9tYWNoLWlteC9p
bXg5L3NjbWkvc29jLmMgICAgICAgICAgICAgICAgfCAgMTMgKy0NCj4gIGFyY2gvYXJtL21hY2gt
aW14L2lteDkvc29jLmMgICAgICAgICAgICAgICAgICAgICB8ICAxNCArLQ0KPiAgYXJjaC9hcm0v
bWFjaC1pbXgvbXg3dWxwL0tjb25maWcgICAgICAgICAgICAgICAgIHwgICAyICsNCj4gIGFyY2gv
YXJtL21hY2gtaW14L214N3VscC9zb2MuYyAgICAgICAgICAgICAgICAgICB8ICAyMiArLQ0KPiAg
Y29uZmlncy9pbXg4dWxwX2V2a19kZWZjb25maWcgICAgICAgICAgICAgICAgICAgIHwgICAxICsN
Cj4gIGNvbmZpZ3MvaW14OTFfMTF4MTFfZXZrX2RlZmNvbmZpZyAgICAgICAgICAgICAgICB8ICAg
MiArLQ0KPiAgY29uZmlncy9pbXg5MV8xMXgxMV9ldmtfaW5saW5lX2VjY19kZWZjb25maWcgICAg
IHwgICAyICstDQo+ICBjb25maWdzL2lteDkxXzExeDExX2ZyZG1fZGVmY29uZmlnICAgICAgICAg
ICAgICAgfCAgIDIgKy0NCj4gIGNvbmZpZ3MvaW14OTMtcGh5Y29yZV9kZWZjb25maWcgICAgICAg
ICAgICAgICAgICB8ICAgMSArDQo+ICBjb25maWdzL2lteDkzX2ZyZG1fZGVmY29uZmlnICAgICAg
ICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gIGNvbmZpZ3MvaW14OTNfdmFyX3NvbV9kZWZjb25m
aWcgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiAgY29uZmlncy9pbXg5NDNfZXZrX2RlZmNv
bmZpZyAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gIGNvbmZpZ3MvaW14OTVfMTV4MTVf
ZXZrX2RlZmNvbmZpZyAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBjb25maWdzL2lteDk1X2V2
ay5jb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgY29uZmlncy9teDd1
bHBfY29tX2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgICAzICstDQo+ICBjb25maWdz
L214N3VscF9ldmtfZGVmY29uZmlnICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gIGNv
bmZpZ3MvbXg3dWxwX2V2a19wbHVnaW5fZGVmY29uZmlnICAgICAgICAgICAgICB8ICAgMiArLQ0K
PiAgY29uZmlncy90b3JhZGV4LXNtYXJjLWlteDk1X2RlZmNvbmZpZyAgICAgICAgICAgIHwgICAx
ICsNCj4gIGNvbmZpZ3MvdmVyZGluLWlteDk1X2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgICB8
ICAgMSArDQo+ICBkcml2ZXJzL3dhdGNoZG9nL3VscF93ZG9nLmMgICAgICAgICAgICAgICAgICAg
ICAgfCAgNzkgKy0NCj4gIGluY2x1ZGUvY29uZmlncy9pbXg4dWxwX2V2ay5oICAgICAgICAgICAg
ICAgICAgICB8ICAgMiAtDQo+ICBpbmNsdWRlL2NvbmZpZ3MvaW14OTFfZXZrLmggICAgICAgICAg
ICAgICAgICAgICAgfCAgIDIgLQ0KPiAgaW5jbHVkZS9jb25maWdzL2lteDkxX2ZyZG0uaCAgICAg
ICAgICAgICAgICAgICAgIHwgICAyIC0NCj4gIGluY2x1ZGUvY29uZmlncy9pbXg5M19ldmsuaCAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMyAtDQo+ICBpbmNsdWRlL2NvbmZpZ3MvaW14OTNfZnJk
bS5oICAgICAgICAgICAgICAgICAgICAgfCAgIDMgLQ0KPiAgaW5jbHVkZS9jb25maWdzL2lteDkz
X3FzYi5oICAgICAgICAgICAgICAgICAgICAgIHwgICAyIC0NCj4gIGluY2x1ZGUvY29uZmlncy9p
bXg5M192YXJfc29tLmggICAgICAgICAgICAgICAgICB8ICAgMyAtDQo+ICBpbmNsdWRlL2NvbmZp
Z3MvaW14OTRfZXZrLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDMgLQ0KPiAgaW5jbHVkZS9j
b25maWdzL2lteDk1X2V2ay5oICAgICAgICAgICAgICAgICAgICAgIHwgICAyIC0NCj4gIGluY2x1
ZGUvY29uZmlncy9rb250cm9uLW9zbS1zLW14OTMuaCAgICAgICAgICAgICB8ICAgMiAtDQo+ICBp
bmNsdWRlL2NvbmZpZ3MvbXg3dWxwX2NvbS5oICAgICAgICAgICAgICAgICAgICAgfCAgIDMgLQ0K
PiAgaW5jbHVkZS9jb25maWdzL214N3VscF9ldmsuaCAgICAgICAgICAgICAgICAgICAgIHwgICAz
IC0NCj4gIGluY2x1ZGUvY29uZmlncy9waHljb3JlX2lteDkxXzkzLmggICAgICAgICAgICAgICB8
ICAgMyAtDQo+ICBpbmNsdWRlL2NvbmZpZ3MvdG9yYWRleC1zbWFyYy1pbXg5NS5oICAgICAgICAg
ICAgfCAgIDIgLQ0KPiAgNjUgZmlsZXMgY2hhbmdlZCwgMTk4IGluc2VydGlvbnMoKyksIDUyMzMg
ZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogMzhkYmU2MzdjOWRmY2FkYmQxYmMy
MDFiZmJiMjdmOTZiMmFkNTI1YQ0KPiBjaGFuZ2UtaWQ6IDIwMjYwNTE5LXdkdHY0LTU4ODYyYTE0
ZmY4NA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBBbGljZSBHdW8gPGFsaWNlLmd1b0Bu
eHAuY29tPg0KDQo=
