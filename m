Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58C3C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9382180E90;
	Wed,  5 Feb 2025 14:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="DLd9vKhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DA4980207; Wed,  5 Feb 2025 11:16:00 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CCCC807FB
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHFl/PkQnroXQ4cdzCiY+k+NdD3Plxqme9jPL4X68CJq9mFQ3Bj5GZVzHBYOGSb27Mf/UKGVmdfdPTUPrxQs+T2xcgBU7qpnrijAIikkLiqyQKgCemNcM8Fe8GFTqowaye8O3hLsJmIesEnMPaBnAcpWVkQ9dOuWuq1imbOszb9xPlb4pSQ4X1ubJRSlkErCYqO8NOfgWTGyUkhEnrdbb9e5o9PpfqNcvLJFCnRebeWhzB3Ex62ogyFTO26Rcl874pDzL3fuJ+hjrakNIEJz7Ysg69k3Ub9gnPaLxJbY1Yw5OJZBceZFFf8cw8oZmt3TUY9bvrpZy/kuhHP10okcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isFTt1CLLEDWRBi4emRYVqG/FoKLgmP6uBl/mJuyzfU=;
 b=cjE4MYuU8Ww2k6Ru4BeneZAJ2Q/QwZqWop7RTykEbjzER7kY1EcK2ggcUafsiM6RAk0TGbCJvW34PD3HP0Vb9UnbTdsSdEoFPD3yFPXea7ApBTi5PVbrtPuSUsuEjLKAwUit3fFEkIIRBNMwrGLBki8SIGlz06hkOZLLh6uhi7IcsUFg4cdZe8mGVWLUlIFE2ojExKflodv0/Sr2qpMThTZBl9yBmexneIDklm2Q8S5CWKsS7F5jV19rJ/VgLrTc3QDSR0/3lHtSAr5Lxk4/dsS2jPhOXgkRVQ9lC+HhjKWYqwA2zvmcKtI5QHQUJ6El97+h6WQRdC6FkaobdNc9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isFTt1CLLEDWRBi4emRYVqG/FoKLgmP6uBl/mJuyzfU=;
 b=DLd9vKheaZIZ3UlGgtTBo9woOBuOCf62xkMg9VfZ6oy5POnKiTaMkt2VXI9886H6tZV4EpMWZK6QKHatrF//tqgpipfioeJSJ8w/MBVzgi2sashRr7/kosuGFo2hy/XFV27MH004+lpKYXwp9rNyhpUcDNLyUQZucDe1Iz/17zcnBQFzqXoI698vBNAy44kr1g8qgk9dQvQ/RFzKb9WP8KvGqFmDT4MFwXYHpW3MT0XOgTr4QPCNCLnmgEgIdncvLdI7E9/rx8t4n1ioalobrTd/jWkMTbj2KgF2U4Rb3EReEeLVkrmYvo8uT0/whtLIVRDUpHL35LAwwrK+hrJarA==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by AS2PR03MB9879.eurprd03.prod.outlook.com (2603:10a6:20b:547::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:52 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:52 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 19/20] drivers: pci: pcie_brcmstb: set correct reset
 state on pcie_remove
Thread-Topic: [RFC PATCH v1 19/20] drivers: pci: pcie_brcmstb: set correct
 reset state on pcie_remove
Thread-Index: AQHbd7bty3FajbY8+E+cVb/woGJ44w==
Date: Wed, 5 Feb 2025 10:15:48 +0000
Message-ID: <857d42ec4a5e643d80abf52daf29f42bf3ea35a8.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|AS2PR03MB9879:EE_
x-ms-office365-filtering-correlation-id: 3511ccc6-4c47-45aa-39c1-08dd45ce1211
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AQOrNj33yKgK7O+fJILJr5E0iJ4psHt24bgkaD+sCf6IIm+QKAbxaS8KDt?=
 =?iso-8859-1?Q?lksoZY3tRT1kTwC79wyOfyuMmlm7B8UBZMz57GAwR7nBk6kMFyLaXYVMg/?=
 =?iso-8859-1?Q?kn9IQ+TfoxrKlNNezxGWB2LVMh4Rhbnm8/cO38A9VPidfANYrCYmPxzbAO?=
 =?iso-8859-1?Q?xGeE7b18MAVlkhmM/znmBuqmrz1HkrDBwhEvr2yXQCf6IrVak0xv616bBf?=
 =?iso-8859-1?Q?akwyGohuq2/jSMybS3qvEngcTviV3XyItMZ/L1+0AdfU/lo6Muqg9UHHUX?=
 =?iso-8859-1?Q?wOzWrFeCn4x1oE3IwnMP/nfmFtoLG/fg5U6nFH4mhApfBTjwEfTUnlgdwg?=
 =?iso-8859-1?Q?J20GlRfGaQPNkrnQtmgs22ur+75xXGsq3DN2LSryDMqecXX7fq2q/C/iex?=
 =?iso-8859-1?Q?bgfC6Iz52Z6SjD+mQXcIQ56yF2d5Ju/4J4Pn4b59vMvtVypvSeYTe1L6+j?=
 =?iso-8859-1?Q?+Evkvwlcj9XcSWc8k/uOmRzLnQOF7Xtd0HkzQ7i7QSojUjxJaWP4fDa9mJ?=
 =?iso-8859-1?Q?8AK2J707rneqMxnkQ22Egb2h1cdvWmGCj5WMdHWsYwiN8uWQ8IbhDOH8wY?=
 =?iso-8859-1?Q?F9hYcc5HsJkKdQtKSvwthvgsoiJ9nC5qVzSJLFWPBHsSvD9k5PiArtcqC1?=
 =?iso-8859-1?Q?HHsHmzaDZnIpta1+0hUVrPU4hvlUSNdXQmPlZc9OJReau1d9CYelSwxZn0?=
 =?iso-8859-1?Q?hQPsoAH/ZKP4+y0RicPuhaSyH26jTA+YpUoiyeMNi9e0Wt5N3in4KgjcSN?=
 =?iso-8859-1?Q?L8HUuqmtzPKWnCitx9LX4oajxjs6elxsxhPlFnhLz/i8qiJJo9CS6f+/WV?=
 =?iso-8859-1?Q?8z6Htfdl7lw8M+BKJ5vsxlj7TZzGEnaru8gIZRGdf7oDKWiSD+8tiWPfK6?=
 =?iso-8859-1?Q?82PSWeeB3bmcRWI48ySuX1OiD1NIF0S7P0ftt2IYyLkkIYHrwPLXhb6ONX?=
 =?iso-8859-1?Q?StitdgjcGVoD/YkumhHHPZxNcDmbWCZN7S4xzA2cDIl+fyoHaImS6b4VUM?=
 =?iso-8859-1?Q?u9Rob3D3G0byn/RzDMUgtZeG7G1f91TVqAKC5gIgCn+VTWkT3/7CpooCFu?=
 =?iso-8859-1?Q?jl0aDgBvEoQ4fc3Q+dVam5o9CyhnSRDDQ13jgzHkMI6V1q/SeaYDNGwZpj?=
 =?iso-8859-1?Q?HtFvPJcV23KrZjTZQ2FcxClBKAUhNuCRwmB4YVXyG4zZH0Xtv7FnuNeekx?=
 =?iso-8859-1?Q?FJ64AKIY2aoIq0MIOHjuidyjsTciNz5R6ozNI/mHjRtQZSuiwNhcLYLZ7S?=
 =?iso-8859-1?Q?adFMmNf2WC378yPo26m+BLhEcZkuwxRsPBy2ua0pkTMyXIqttFAFLNy04I?=
 =?iso-8859-1?Q?oaRJhIwf+XjnoebCv64tRtjmEEpdBD0UCVc+uop7YJqDjIS+fCixPIarlw?=
 =?iso-8859-1?Q?jZLBCW79asGcLZhMMdReYKjfbzoZ8l0p6DfYM/vvcVmm9MPEKMP+ki7Sds?=
 =?iso-8859-1?Q?4LbAeM+HGvBAdO2z02mbA1amqXfuPWUxdZ8Xxh8BEWdd3Q0CLLWm+iKcxp?=
 =?iso-8859-1?Q?buqd7t6UveyDBORU4o16wC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PPAiepFlvycK1QQjByjdcV/uIaWGp3K6ymmaqjS3/Bpxuxi4d54BIZ1nSJ?=
 =?iso-8859-1?Q?bp4FJtOzChMSUtPerdy7CWjJgSZ6DoNv7p5O7iSIxtmipwbT/YjoY6aEd3?=
 =?iso-8859-1?Q?Bgiyi+YwP1o2njXegq7ANq2zTCrGnongVXXdk0VZIsO4SxQZxpqaVY+EoF?=
 =?iso-8859-1?Q?sYFWBMoL34RrxADhY6E+zBzTlkN6wSfrA2+Dv11U7qdFL5nt5nFpLmknOk?=
 =?iso-8859-1?Q?diqM4Qi9ydY8ZYlAxSIjTqSpbOtXzFOPPwyIAp+bSBEaj967O9XKzO47TW?=
 =?iso-8859-1?Q?cGW+HyDXcSAafh5klsaTTgci5twORB4ltP9SVZs4ZW6507anKsczrad4XP?=
 =?iso-8859-1?Q?isOjCVGoYMOn3QM1zJ82ZqCJx6kfYL5Db58FLRpFZc4c9ZbFjQVMQ7IZs9?=
 =?iso-8859-1?Q?PNvdIT3Q3n4wFUUqjfnCdxEjf8R4JB4S6a/Zgg0mBySngOlBDbtl/4pqyc?=
 =?iso-8859-1?Q?yAtP2iPcs9ITDqQlwQl1EJCSQ+1P6+Yh5auSmrfRtTeRE7d85eylQh2FTf?=
 =?iso-8859-1?Q?Qe9bqO1vX5+LFx1y0paaPkt/FOcFqxb3p76P8N5DHGXRd+rPrxCNHwNmy1?=
 =?iso-8859-1?Q?iyljZvU7WHbllIN78YrGA2P2kAv5gWU/VJRv+J9qBytRZMSap2JJ+QbjVW?=
 =?iso-8859-1?Q?2DxLLJoMK7IPhOvyQhaDDW6udMYhdoyUEVABMZF1p+HEpmBesMe66wn94E?=
 =?iso-8859-1?Q?FZNbuW6B8z6VILEBhGUKj2O1ZvYnTlMb4Ygp5ri61PvpLIlSSPDrGrp+MG?=
 =?iso-8859-1?Q?0r2GUGeSwgXTlQ9n9NMItmD6iDnTxycyQmawI8OpQuKm5LPc0hHWQ98T8D?=
 =?iso-8859-1?Q?/8I+2VZuhcLAYPDrp7JyQlQEfTQpqPoVO1+xcDk8dHsMRt0gFv7s1NKk4M?=
 =?iso-8859-1?Q?nRGa0FkFmlpXPQSXJMb4vI0egJKw5um2osK4jslDhJYTEr5bvbCaJGJjBq?=
 =?iso-8859-1?Q?IyP6eLV2fSpakavH/hvwW4T0Ca88KHB8hliVjkthCDKsGYItwj/n7iKdey?=
 =?iso-8859-1?Q?/QEi5URm3vKbD0qQpRgN95aPZ0Hr+zekLQ7k/nEn4Yy1isCSpFQkSwFPfq?=
 =?iso-8859-1?Q?+UQkHvT628daawssqNHoEJ3AJCH70eMHGGnM4qVK4D+G2H71941tzJP0Qt?=
 =?iso-8859-1?Q?aJvqJujmLeB4e/040PBpCZEpJnUcx2MfV1LHfAtzenn64EXJFEpd1lf+4j?=
 =?iso-8859-1?Q?6OaJx8Aq42/xYZA/pBzLJjO7rASKJD5TiJHG1XzFMl5J+GK+2lBnRpWY/n?=
 =?iso-8859-1?Q?6c5tg45wJOM/R0ms2sV50VTtyyD0WsnnOIxdchhPRzDI28TqoUwm9l7FN9?=
 =?iso-8859-1?Q?gTS+nCYAMq2Uwvy1mbPdL7CUAFpDTJORpFrmvOO1fcS3xXdtg1sRfUy5Q/?=
 =?iso-8859-1?Q?DdXiS20yctIaN9ECmQNcY0hSK9hHH/jyu1Rc2ZD1CVbAuPAXOLAEtM8GBo?=
 =?iso-8859-1?Q?LV/mPsknHZI4UOVDoxEG4KiMmzPMEyB3/6uUSAlTd+UKOf90vYwfP6l1em?=
 =?iso-8859-1?Q?j9MMrmdHRimvouMwbqzMCUJ40daGrequYxx4Mi8F19DIfU8BGBs8qf23/h?=
 =?iso-8859-1?Q?wuQ5TWEEg5wyDbP586vcFTktg+wNjd9tgbXq3Sdv0o8xqggDhwjUT6db42?=
 =?iso-8859-1?Q?lbgbv6luLr5JxMDuka4JInGxGpBvqGp2xbot1YMlsQXz7oyS5K3QNsWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3511ccc6-4c47-45aa-39c1-08dd45ce1211
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:48.3802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mfq3FByG65kEUzj4zYe+jYht65X/HSbpZP+XmXfOoryThzArGOOSES10XNslWN4FVtlbTdLaHosjubXn4TrL5t+B1a5MX8RpcLRjx6rF5q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9879
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

For the controllers that are utilizing reset for bridge sw init,
such as BCM2712, reset should be deasserted after assertion.
Leaving it in asserted state may lead to unexpected hangs in
the Linux Kernel driver because it do not perform reset initialization
and start accessing the device memory.

We've met this issue on the Raspberry PI5 kernel and got the following
log:

[    1.842953] brcm-pcie 1000110000.pcie: host bridge /axi/pcie@110000 rang=
es:
[    1.849953] brcm-pcie 1000110000.pcie:   No bus range found for /axi/pci=
e@110000, using [bus 00-ff]
[    1.859104] brcm-pcie 1000110000.pcie:      MEM 0x1b00000000..0x1bffffff=
fb -> 0x0000000000
[    1.867407] brcm-pcie 1000110000.pcie:      MEM 0x1800000000..0x1affffff=
ff -> 0x0400000000
[    1.875707] brcm-pcie 1000110000.pcie:   IB MEM 0x0000000000..0x0fffffff=
ff -> 0x1000000000nc

After that system reports a context switch error after 120 sec timeout.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/pci/pcie_brcmstb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index 2e58ea453e..c5fe5f9d20 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -851,6 +851,16 @@ static int brcm_pcie_remove(struct udevice *dev)
 	/* Shutdown bridge */
 	pcie->pcie_cfg->bridge_sw_init_set(pcie, 1);
=20
+	/*
+	 * For the controllers that are utilizing reset for bridge Sw init,
+	 * such as BCM2712, reset should be deasserted after assertion.
+	 * Leaving it in asserted state may lead to unexpected hangs in
+	 * the Linux Kernel driver because it do not perform reset initialization
+	 * and start accessing device memory.
+	 */
+	if (pcie->pcie_cfg->type =3D=3D BCM2712)
+		pcie->pcie_cfg->bridge_sw_init_set(pcie, 0);
+
 	return 0;
 }
=20
--=20
2.34.1
