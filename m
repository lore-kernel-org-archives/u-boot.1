Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB88C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 09:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F08B8192A;
	Tue, 15 Apr 2025 11:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rLT0HqT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1950281E18; Tue, 15 Apr 2025 11:09:04 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B938007D
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 11:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELdbSWXg7YptPyzFufGoWZhih5xdK9w0MSLtjeY6RWA7XlTublXA/ApP6nY2JNmGjs0zfBxTqqk7WFsE3FFOjakKBnTyZBqXZo6IhFcvPOJ6CXTlQPPisEsRcCodky5QIFIBoj3Z3OHF+APNa752vimoD0t2tdbRJy9RjHR0oGiF9/uBuMXc/2BzF8suOF0iM6gwkfsvMJPZpTzHVfddoL8dSYl6Q9XuJD/PHKjnLTeEBRqD9IEjSEDGZzAvBLeg0FA/ozit3VhNhQZD/GRK9HkLmJmsPAPEosPFOXRFoMXRitZlQm8WDJY9gOojgxcRLr7+mCdqWO2MI881Mnw7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hrla1rWYdURkdVoNuqv6P/hhYt5ZMJbIICJ4xdrdIp8=;
 b=Mg813jMtpn++LmXK1ZwE1voRjhbrs2BNYMVIrGgQ+FRM8qqk9CPYJe7on5/xUhGKtf/tBtzxWjaj+BIu494M3f6K4nDsMDvgSoAv0gZXuaXwZ9by3OXl9FZWGfNPVrPz1sBDKnywP+WRZ8wFBRO46a71iob+U7jexWdsh0AQy2gMz3sEoIw0JuNxHxSzvm4CPd3NXxC0UKQ12G82v8mLUET6NIhulEkZwCs1xTzvmHLANv+Y9bBE3CATurZts7+vVROSaYm14O/VQd4fimXjr424IZkO9Him1uhQsRL9BDeOX4+oaYLtRzy01bM/NycY2vZ9gFKu+MLyOAX/8iJfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hrla1rWYdURkdVoNuqv6P/hhYt5ZMJbIICJ4xdrdIp8=;
 b=rLT0HqT1koSj++JxET6A2CbnpMvCWwVVZbKN8YQ4xZ/6lphxdAGqX4YfUmmpkRKPDj6cSEIxY61ifNQl5BehvoU9XvOtSovy7v5APmxTfCzOe91rBl+sYZsuFmtsh+AUxJECgM60LCJqVi6Cy0380d35qmOEpikCk1SUIKUik220cliJChcWuKTEXT0wjCqk8CfPOcs1VdCq57MedHGpMoVf6MjHRycCrybyzQ2hTq7jWChMtJDAWcaBA6vJ7YSqgGvyXRDM/oTknndZ94O5/axqd1m96E1QCoMZkLNG6OMbGAYeiKn61aiZK6JUt3xcUbklXWAzPQO2y0An33+OEQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB6631.namprd03.prod.outlook.com (2603:10b6:a03:388::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 09:08:56 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 09:08:56 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ng, Boon Khai" <boon.khai.ng@altera.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, Michal Simek
 <michal.simek@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, William Zhang
 <william.zhang@broadcom.com>, U-boot Openlist <u-boot@lists.denx.de>
CC: "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Maniyam, Dinesh"
 <dinesh.maniyam@altera.com>, "Zamri, Muhammad Hazim Izzat"
 <muhammad.hazim.izzat.zamri@altera.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>
Subject: RE: [CAD QSPI v1] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Topic: [CAD QSPI v1] spi: cadence-qspi: Add disable STIG mode quikrs.
Thread-Index: AQHbky6TG74aYUyNLk+zHdJK1Z2Yx7Oko/0g
Date: Tue, 15 Apr 2025 09:08:56 +0000
Message-ID: <LV8PR03MB8137E440D16452E4D494966BA7B22@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250312090944.35977-1-boon.khai.ng@altera.com>
In-Reply-To: <20250312090944.35977-1-boon.khai.ng@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SJ0PR03MB6631:EE_
x-ms-office365-filtering-correlation-id: 0d66dd91-3aff-4e68-f7a1-08dd7bfd26e7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Tvt7be+SvTksGLS4AejedRDlQpwGsy0Lyc4xvGR+L5O3tgW/haRDPA127X?=
 =?iso-8859-1?Q?RUJ7KDWfxyFwyYokXYTHHglptdV0hYaV6w78Azr5F2twHaPzhzQX1AqeGZ?=
 =?iso-8859-1?Q?crI33/WxWZqN5fUVYpSwcVayQMtiWN8pDjc556uWiTG2BkFT81/2pi25Rg?=
 =?iso-8859-1?Q?jFFvhvj6xrh84fZN/9ZXC76iMPgkSqPUvGSL2sZxPx8sIKdMSv1iHaA/hu?=
 =?iso-8859-1?Q?tKKxV10/7ZqL9ja88uPFFT4NyzVjB9RKTcZNSBP6Gmc2qgT8yV1wZXCt8H?=
 =?iso-8859-1?Q?bVltDiCJO3SA4yPJtNfDwhfkGqgB0Q6bFZAUNZubOLZJZXxCNyT4trMXJX?=
 =?iso-8859-1?Q?Ew/C3CxfUKPQFUCb5E0qZlGmlL8iVA0Kqt4rfL5PTTVaP6rXgYg0cr8dv5?=
 =?iso-8859-1?Q?Uv79XkbhX1cJ9DQoXsnXZiw/VRXv9odHekNCPGjFZKpsMH87BH5HscYk9S?=
 =?iso-8859-1?Q?cq9nAk9Pe0NorJMUKWXHT06YcHxbqTrNkTSs5ns5D+w/Vfa36RR45RGE0t?=
 =?iso-8859-1?Q?1ygOHAok3ugDrY2rK0cIqcEcd4ERAnQMKX38GqFmAqzsikpdFdT66M9VJc?=
 =?iso-8859-1?Q?zeBNV374+DOV/GJpPgTLXoR7YlJWX8Fq6ULuhXXbEdTf+4mdDza1IEsLjb?=
 =?iso-8859-1?Q?NVM1fb7zZuWfGTbNZXb9XaS5hBeVdS8P8fu8pUzqk+fXg8CwZx2Qt2P1Jw?=
 =?iso-8859-1?Q?Y+sBY5ScdoEQb2osoWf/SArfpyYvSFRLTy8pk/eBuhvMQml/DS+SR7xVaC?=
 =?iso-8859-1?Q?J1puN2TyPSzmF7U6V+z31Eru8lxr8Id3LH3PFN8r2+Qo4ghV4iZ1RVdh3E?=
 =?iso-8859-1?Q?JOdKDFooIhMwTQfxGtDHXg/AqnPrOyGnzh+06AeAWjsrMZHgF9LX1Aq764?=
 =?iso-8859-1?Q?JCsVkWeKVJjbDw9EjQQJd8Wb5JHUsEfEaFkLkxApQcaC7Z8QsA2ltlglcy?=
 =?iso-8859-1?Q?BW1Sksioq6Tn7nHHqAyx5h2dgHxFZNO6nZtkmuX2icgGJFnPtGK3PbOrhU?=
 =?iso-8859-1?Q?uIcHRQbcVKHqJ/SVFnxlkxtQz3iOd/0BBfVK1HNk36dq6MGneKalQ7zZ2v?=
 =?iso-8859-1?Q?c8pk/uXmEneNeYMlrrO/gIzYlY3WmH511zFAe2g67tdDVoVe2rne1/vz/h?=
 =?iso-8859-1?Q?qItABIGzpWEu6ktHWzwHiLGVHNo2LLLNdrBwbP4hhJCSFDAenL0YOehyM5?=
 =?iso-8859-1?Q?6aZaGGea/ADRyzmjTHw47wQSWFGga+HX66QIP4uE5iCxBcaeaA2ZZ17qTd?=
 =?iso-8859-1?Q?j9G0SesS5PB8WV/r1C1KbahYSS8bgUAEajWZpzambZmWzXhhSz04Ky5zHc?=
 =?iso-8859-1?Q?0SnS5YTbBh4GXlkNTAdrbOZZBd52uSEMDPyiTY5XPxzoLFp0jJoy427f8N?=
 =?iso-8859-1?Q?EqVY/MTlnkh/cSKhCBj1NYxzCoWS6PmIBqRSDTcf9y4QS2cJsMuz01da2k?=
 =?iso-8859-1?Q?X0kjAnP70YzU4RfOc4wIhHZRqCiZywzcAkVuDmXm+Rj3BbOjlMaqXbA39L?=
 =?iso-8859-1?Q?mf/tax/h4kBZiheCgiUnILbbqB8NyaYzwcrB39BtGdC7uNhb18wGI0/ChP?=
 =?iso-8859-1?Q?AahtaLw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nytyp7CmRLoG6F6LxA+SrlEvjT5FSOsHVzKU49dwt82zELPnAEt+TVE8Fi?=
 =?iso-8859-1?Q?MW2rrSbHPLuamGoPifsJmo+hEf7j2BHMdhyF9jVzcWDBL27sKMXf6qXgfu?=
 =?iso-8859-1?Q?X6OoHZBzWY2WPiDv1DcuqYn2vpn/A9dH4dlCcxX7GruVyzkUTn6Av47fAe?=
 =?iso-8859-1?Q?j5chl4yfqpQpjt7JdDNGQMrAOCGKtv4rdjPD1euLWwIWelRtS0g50AScZp?=
 =?iso-8859-1?Q?LiiBV/rg4nelA0jPWWzpzrEOn3gQCqomv4d7N5TX4LLB2xWiETzJ2RXmPm?=
 =?iso-8859-1?Q?EV2fdHOsPhH45okyzYf6Zj8YleojSWDVBYwfJ9ey53egv/2jF7E4v2nsEK?=
 =?iso-8859-1?Q?tQKcHOSrgvfpfcWevsoqVVCpXDGdz8rfQ70bIoondAfwDsg5E0vta6UuLO?=
 =?iso-8859-1?Q?bfGtqCD8P41ifqLKYiTZjcXYYvqocanM+GxbHA3jCh9PSTPxgTBObcyCB6?=
 =?iso-8859-1?Q?PzGyRmCVRCPPUQ5GwBx+fOVB/2VgbpArF0sqcNFisVlYld7VrLsv4Tc4b6?=
 =?iso-8859-1?Q?h3alsbL4NzHYhjRkLMnCEEpf7VFL2ySRiDop77u3nQsEbViUg33JMyGf0d?=
 =?iso-8859-1?Q?jztVeAXU/9+k+ZquM0jdu456l/GkzjYUjPWXptoj6wG0BuTJrPkfpjvYEz?=
 =?iso-8859-1?Q?amkNXT5zwV13VT76zQAK3KX/7ajwcZwsrHlgfx92CebwlLm2vKQ6dE5hyH?=
 =?iso-8859-1?Q?tl54UVirQwwJqfOYAFx1MeayVl1O5ezhB/Dkb1AinjgwRxoR4js7rXc/io?=
 =?iso-8859-1?Q?+yV8veLHZl5C4XmNMvRbt6ADE+yM0b9aHFpjNOwoIQYBVJAbPM2iCLTCRh?=
 =?iso-8859-1?Q?d42bFs+fA/JRCRGUhNy2hEavnX0tHMFDTlaj/8ue0nDLHJNvUCK0VcUkZj?=
 =?iso-8859-1?Q?e4KqmsQ4XBbqSTeMKJ7F2rfIqoumA8zXAgOqgP8zeVT2B/Jlpzt2oXh+IF?=
 =?iso-8859-1?Q?KWE7RlC47TssyRftid3YigdEUMqUBAhZwjsodgn/sDk0wF7s3YPbvNfIIB?=
 =?iso-8859-1?Q?0M7pgnoOHIQIYTC+inTWmYCO+dbXT+SYaZhcmCYU0UxDFK4+8oLeY6ZvmH?=
 =?iso-8859-1?Q?NZVkoqI94kphf6b2276yLLdfOWQBHPZtfiJDXWYFQyBEkwHNKwJUQ3xO19?=
 =?iso-8859-1?Q?x1oynBsglbKYZ7hBrGB8U3HlpFPriB3Me0uBFIHtKytbogU1q6UuIO45o8?=
 =?iso-8859-1?Q?Y5HAvWCCSv2d54FiSRQLSMkG1s7RD4/rBAfneqm0c/Cp3OlEZjwASR9zy7?=
 =?iso-8859-1?Q?r+si/aE7uWF2Yg5cdTW4VNV5bPOKqdyM5Z6AU+UhFLfXdL3zAKsZMze/Bi?=
 =?iso-8859-1?Q?PuRgMzL2FlC2+Z63qIZBWwhvV/zFlVpQj72mxtchtpii5L2IoX76eeVV9T?=
 =?iso-8859-1?Q?8vjvOsvaGKkCrSkP+tv7UDPKCq6mJghzF8crLPYGA7qbcRbeOf1HZ+yQ4u?=
 =?iso-8859-1?Q?DNqWCShxFOTRhbPKVmAx8A1CBjyte1v9aZr/VuKwe7Cf2JYOADWwLZZpp5?=
 =?iso-8859-1?Q?4Bhp0YdcO7UxLBegaNlzy+nA3v7Rt5IgA/ZaIOaga0o4obCpBmxd2GckCB?=
 =?iso-8859-1?Q?NTOnyhdca39Hwy6n0eCPzP3HPNHQlIOU/2I6kPvcSAJ1Kmz4yUcBYzW8Lo?=
 =?iso-8859-1?Q?KitPT7LOxGYccxV/FPaSLHMbU9VkTIqUgE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d66dd91-3aff-4e68-f7a1-08dd7bfd26e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 09:08:56.5770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZ/RN/18C5r089JDd8S/37XVgko3Hqzt0vOgKU3uNArsp/357rO44xfqL5P9VALDazjwcd1AsTSP6dojZezzNuIur5ahp8QTr6r2PUeM9gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6631
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

Hi Boon Khai,

> -----Original Message-----
> From: Ng, Boon Khai <boon.khai.ng@altera.com>
> Sent: Wednesday, March 12, 2025 5:10 PM
> To: Jagan Teki <jagan@amarulasolutions.com>; Tom Rini
> <trini@konsulko.com>; Michal Simek <michal.simek@amd.com>; Venkatesh
> Yadav Abbarapu <venkatesh.abbarapu@amd.com>; Tejas Bhumkar
> <tejas.arvind.bhumkar@amd.com>; C=E9dric Le Goater <clg@kaod.org>
> William Zhang <william.zhang@broadcom.com>; U-boot Openlist <u-
> boot@lists.denx.de>
> Cc: Hea, Kok Kiang <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Zamri, Muhammad Hazim Izzat
> <muhammad.hazim.izzat.zamri@altera.com>; Meng, Tingting
> <tingting.meng@altera.com>; Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com>; Ng, Boon Khai
> <boon.khai.ng@altera.com>
> Subject: [CAD QSPI v1] spi: cadence-qspi: Add disable STIG mode quikrs.
>=20
> Adding quirk to disable STIG mode since cadence controller has issue for
> read/write using the STIG mode. STIG mode is enabled by default since
> 2023.04 for small read/write(<8bytes).
>=20
> Updated STIG mode reading from dev_get_driver_data by assigning to
> platdata struct before read quirks variable.
>=20
> The STIG mode is disabled for normal read case and enabled for QSPI Jedec
> ID read/write since it requires STIG read/write.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/spi/cadence_qspi.c | 29 +++++++++++++++++++++++++----
> drivers/spi/cadence_qspi.h |  7 +++++++
>  2 files changed, 32 insertions(+), 4 deletions(-)
>=20

I think you can add the reference of the kernel patch https://lore.kernel.o=
rg/all/20241204063338.296959-1-niravkumar.l.rabara@intel.com/T/ you ported =
to this patch in commit message.

[...]

Best regards,
Tien Fong=20

