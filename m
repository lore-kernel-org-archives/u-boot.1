Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5D5D66BAC
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 03:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CC02890D8;
	Wed, 27 Nov 2024 04:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gm2362Pi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC97896C2; Wed, 27 Nov 2024 04:00:27 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA4088B58
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 04:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1oJ6mxhikbhJhXr7M5jes0q26uC3LFB0cliAin6jyU6Nph56PPbASu+VvoCR9EjyW7d4zXAFH89C6D95xlPpDmYHjhhvjRLVC9AJBm/jURyA3yr05GDx4nWF+W4NKAOrJCjSZukTnn2HA4/O6IEpWH1Dz7rZUGAsWwrVPYcWn4RhVKBBIJXl3gZbsncpFZ3iQDdInD1BYvRrYNCX1c5Q5I6+r7oIz0N2529olJSNAvcjR83+QueA4g/ZhteLKxtd1ApZr8+UfoaJ43ppxLh9TxJrW/h93U2Egv6K6OsHaxB2ik89K0+MtZa4XXBIWVP800r4Ht/3L4VfZORWjW3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmORP5RH0+SuyLdZcTj1UATUfzA/TjpjYogoFYqWNB0=;
 b=efNAW7aQUYXxnunzPr5aTCZQbSVFyDpzRfs6eNgwSyysIkmlwGcEENv5850+qPP4vODRlkH01aYTf5PKROQ9zRcLI6GKtNC5za9J7hMfT+b9O8dbAxf/tgwJaPyzDXb9pbK38n0bDhX49eobsKqfsvmmC5Q+1E5ruOaTcrmIRPJerMMZCfdF6D6+JyhEKEYxYPQOiuswQRIMG91OPf7s+4hw8Yi83dkRLlxIqVPRv3Xx3rK/BetzNhYpYQJD0y+68A4KZrtHw/H32U1AYFTqFUIoow3LFFdKfiUovXkPGYeVGIOdsgc7tXtJOs6OaRqS8WhfW7tdAsa1wTf1icCYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmORP5RH0+SuyLdZcTj1UATUfzA/TjpjYogoFYqWNB0=;
 b=Gm2362PiLIGLj7Q/Z1sQ5iId1dPPXWlF21FCQY2Xoz8IKIHAZrO6S7TDtHF6nkyljHC6suIwPz7/N9C4V6LHEgBS+pAhjDJHDrAqBjsKddh4sqZBklHhBHq6DhHlFU+M8H7kCQwoPAb0VP6HIaDeb5LOEFXJfGcq3xw7/m0RcXc=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 03:00:18 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 03:00:18 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Prasanth Mantena <p-mantena@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "j-humphreys@ti.com"
 <j-humphreys@ti.com>, "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>, "git
 (AMD-Xilinx)" <git@amd.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: RE: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Thread-Topic: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Thread-Index: AQHbPMCWS0dDsUoHJ0OAlINbovo5o7LHtFOAgAAFwgCAAU7GAIABbh1Q
Date: Wed, 27 Nov 2024 03:00:18 +0000
Message-ID: <SA1PR12MB869785A9FAE392A77928CAEB98282@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241122092619.1376234-1-venkatesh.abbarapu@amd.com>
 <20241125084919.e3mr4nwmoecqj3y7@prasanth-server>
 <SA1PR12MB8697E660E054185666B19C17982E2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20241126050808.yvezx37spuxnxucu@prasanth-server>
In-Reply-To: <20241126050808.yvezx37spuxnxucu@prasanth-server>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|MN2PR12MB4318:EE_
x-ms-office365-filtering-correlation-id: ef39811f-2edc-4e32-867e-08dd0e8fa012
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?AxsuMHJEJeo8MHdoXXgcyiHjkWmbAgAxMdd2ggbBjcpNSMR6piFbrQKGaesJ?=
 =?us-ascii?Q?uGPMTKvOFX79IIAyjDcpabSmNNWPyi0EB5426QcjQcKK+ikJe9Ia2iaoyP2a?=
 =?us-ascii?Q?ov6AJC9nn5zGTEZJdvYRZmXNzdx+fZIF3CHHmqyFz8ogkVYRAQ+2WJDPgpxG?=
 =?us-ascii?Q?IcI7HMnCEzdh1Uk9n+EW9FGpeQ5Q+3WK9Kt+rMUEIvi0anWw3evb3Pplxacp?=
 =?us-ascii?Q?sg2aZSvD6qvRmdMVHergxzCEcQY0wExsNxY6ih4gso/WJBKaMDV8qBaXE3dB?=
 =?us-ascii?Q?qrWfA9G2nrng0+4QGb7jQCfbw7+l06mdLi1/7aJfeO0h+GVC2kwMmiZJG/Og?=
 =?us-ascii?Q?XUZpX3UchNtwAxyXKAad0zaIqNmGwdRDE9oV1perBeWOp4ccymbN/pyAzYHe?=
 =?us-ascii?Q?8UAiHpy0Pu/xK2oLzAAYuG6m88DXgfG7/mgNcsgO6l+9gJCVczZ4wMDSR5Gy?=
 =?us-ascii?Q?Bq25uVQogL3qkpuaLxKXcFVa53hqKx81S06tu93WjK0KgqeKm/cOCyMw3S9f?=
 =?us-ascii?Q?mzaswJVGrggflQgfzF1px727dmyhbwuEQI1DpgBlvWLL1gAkwCKxfd0q76t3?=
 =?us-ascii?Q?Xq7lkLI0dBsuWDrHzmMJD1oCOewu0LVIQ4oLoUW4aq30pWhjUPiVprCRdCrI?=
 =?us-ascii?Q?qGtJlHoAw21yzPLySmOElKSykwt4flQkTtv+bH4GWzYIu1dej5CHz5PLWiby?=
 =?us-ascii?Q?BU5A3Idc8pbXzhnUDhW8HqIuUkPOu1UVx3Elmn5+0bMqGCcEOkWlJ0ybdkqa?=
 =?us-ascii?Q?d3Biv4Up0rKhxbwQWIUvzjQ+IXx4oaHZzQZhyEuNMvUP6xY4uWv71xQQ0zmj?=
 =?us-ascii?Q?+M+EfcjylMiFV+g7m+HBI9hMkLxQgbChKppVwgtQxmE7Tvm9HpnWIRE6eCUf?=
 =?us-ascii?Q?UUnAg8donL46SuI3hVHYUIKzq83IccXw+Q5lvF+tyoi8ixPvdMlMzhAf1qDq?=
 =?us-ascii?Q?7z9y/uK323ouAklJP/OWNYyGcwDHcPNQqahPayR/ONEtAOx+YiuRgV4VVNgK?=
 =?us-ascii?Q?ZCIZE98Wr+iglms5tPJ2gUVHfSc4UWoSLPxvb11gDu/AdbA/udln9hgr9DmW?=
 =?us-ascii?Q?ipAiyu6XfrVgFflZejK7s9ZQHMzJz8kxhqC9p+D+My2kWwK0rGUUHqE/1Y8r?=
 =?us-ascii?Q?l2IErMN3zCT4B/ahhjpioYlNVeXPA+C9zorDr7QwOSn0dBfehFrngEJGO8QM?=
 =?us-ascii?Q?+17etNNJGjEyx5XZKxkfski7S07ENEDaryXCSunLt9JrN488EmMRc1vkWKxU?=
 =?us-ascii?Q?YzesdkDJoFMBR5bROj27s+aTxl+KCE6eWt0BVdEnLRSFJitun6AerzxrJMyy?=
 =?us-ascii?Q?OvidcJfSPh5qUCRmc9FLt7JTKnoQtDFyo450iH80bY+mRyKkkQpbgSYqipJI?=
 =?us-ascii?Q?2xKUcnjPASgFgyiwMFYa7Bm3TsFSyNB52YKt7GCL68soWh8fKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0gnMNWpVp+sgmyGrjdnaVVPaAP4VCwoXOKOG2KpfyldkW5Eev8vgfvvQ8baM?=
 =?us-ascii?Q?8JdA4LKxKWIRlwU6JrjXBLeFlC8mrBuQM/dvB6GiBYnR1SOC1xXgoZBONCEH?=
 =?us-ascii?Q?gugR1AkTyR4t/pzsB73+zEnkTCfFFZ5iXdgFwnsbPv0NU5sSzDUxu/sg/uFG?=
 =?us-ascii?Q?KUksHzekdWKhC95gywgkUQdvbt6IQP6NZdhHNGWsrHLxDMPOCgi1bp/QP7Xp?=
 =?us-ascii?Q?VbiGDtX5dMMPmQiv4vIenrENTdMjrKRNQdQ/hMZ/SVjeINTNCDLw/kEGQq3B?=
 =?us-ascii?Q?v74JuA3UMOahQk0eNKcMRfx1/S2k20HslUCt3UNmUy1Q7jUoY5os8NcYBgSc?=
 =?us-ascii?Q?6rkaEFKT9weFK7MN2XatIepZMR3Dzucu5QeerNDXP0ubn2DN1iaxATjqSw+9?=
 =?us-ascii?Q?RIE96LDHAXx4QYJap8JBQrHsKU4Lpzvbf1UY9ZDIiyVVk/39inUQAqPUvfFu?=
 =?us-ascii?Q?MxhpHsKvfeKJcKEZAhfr9ESq+Y8UVW0v9WPUjccaVEkd9G9NwnZlRCbs1xS0?=
 =?us-ascii?Q?eL2M51vowDnUuR2YovyR8GnJK8B64vKtneds7UuLiy3htO0MK0XEy+8DWDTP?=
 =?us-ascii?Q?HRR/n6BgErigkeygFxdhmHXhyyj/ha2gQL5JkZaXDmXR55UMrX8jTj8fE5nt?=
 =?us-ascii?Q?UkXquM8AwZ+BsKIojbI9SQ3P9qT1fz68k7VAWBJbd8QHvZ0Kst2EmS1VUUjR?=
 =?us-ascii?Q?NYU/vDXIu12Jh8qW+G/t8tZ75XNddo/XO0FXTrk+Vn0T3shMTCcyQVSjvUg5?=
 =?us-ascii?Q?JF9XmtWRhWt/iaYHltcWZoJSb19uHZTQ5FxIO66XHaN2l3HrB5v0D0StaUIY?=
 =?us-ascii?Q?v/jU+bOGjcFk3cALHnQTYYR2A6G468nK8l3sieP+1g9Ui5MwFQovbSyF34kK?=
 =?us-ascii?Q?4Pe3aD8+qincz/Iyg/kgh6KgTdQVDly7mCbiDklz6liDztYj72ClR0xsnLOJ?=
 =?us-ascii?Q?8QynineytJ+wFM6gwHpzYCU9B4RRm738kyJolQHbQCSGqytl0uSFVsrsgOVx?=
 =?us-ascii?Q?0xHyYGMn7TsvLvLzKaXLVIEtryGGQ1JBlZqEH4DiWq6rCg/XtGMXxcIh9oyK?=
 =?us-ascii?Q?YF+OauxTcb2Z/DZLZPYvLYIl+RFoehE/ovnkSPyo54y6ONHwBu44Pg0UUO42?=
 =?us-ascii?Q?pJKY+1KPdImdvL5sDlrzoSl6xwZhsvTSM72uYM12cFZOeHZDhr9RpzH3MmfU?=
 =?us-ascii?Q?0qiIyfK6fqpiqQNcJE6R/sktAnkCntohoJKe3s1Pi2dtsbozOyBVvOvpigdk?=
 =?us-ascii?Q?/n/+2G9zvJyzUwoMGUIFuVjvQYvQ3oBJ9pPb+0/AK+939mu5wM0PlXuYVLA+?=
 =?us-ascii?Q?A1qgeCG7Nzi15Wjp7kY05KOhcYnNKn865GOlVZRgznJbtszPUziQFVDEZY5p?=
 =?us-ascii?Q?fOkLjvylaboDd8su9BmrEuMm+BihL7Q4cUHF/r8KFvudr6t96KcAnbawCc6s?=
 =?us-ascii?Q?CxgpIR/dLdXu2OktZxguaZ1VroHIbApUS/IIYNVTFNx7nDKx/GobthQE1bIF?=
 =?us-ascii?Q?4U25tWFt9GtvWD2sz68FQxU4IkfrdwnMlfANTPP0zAttmidkb/t35RhQkpF0?=
 =?us-ascii?Q?LXUtRivpNdtjHVdl9jI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef39811f-2edc-4e32-867e-08dd0e8fa012
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 03:00:18.4516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ndj/FbkifeztDgcZ0Zuca7LuCrL1/d/6YcHLtW7rhCVguKzEQiuiGz0UZ5Ml/qO5KZJdiUiseBD7BQwwLE4wXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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

Hi Prasanth,

> -----Original Message-----
> From: Prasanth Mantena <p-mantena@ti.com>
> Sent: Tuesday, November 26, 2024 10:38 AM
> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.denx.de; j-humphreys@ti.com; Simek, Michal
> <michal.simek@amd.com>; jagan@amarulasolutions.com; vigneshr@ti.com; u-
> kumar1@ti.com; trini@konsulko.com; seanga2@gmail.com;
> caleb.connolly@linaro.org; sjg@chromium.org; william.zhang@broadcom.com;
> stefan_b@posteo.net; quentin.schulz@cherry.de; tudor.ambarus@linaro.org;
> Takahiro.Kuwano@infineon.com; git (AMD-Xilinx) <git@amd.com>; Ashok Reddy
> Soma <ashok.reddy.soma@amd.com>
> Subject: Re: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt3=
5xx
> flashes
>=20
> On 09:12, Abbarapu, Venkatesh wrote:
> Hi Venkatesh,
>=20
> > Hi Prasanth,
> >
> > > -----Original Message-----
> > > From: Prasanth Mantena <p-mantena@ti.com>
> > > Sent: Monday, November 25, 2024 2:19 PM
> > > To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> > > Cc: u-boot@lists.denx.de; j-humphreys@ti.com; Simek, Michal
> > > <michal.simek@amd.com>; jagan@amarulasolutions.com; vigneshr@ti.com;
> > > u- kumar1@ti.com; trini@konsulko.com; seanga2@gmail.com;
> > > caleb.connolly@linaro.org; sjg@chromium.org;
> > > william.zhang@broadcom.com; stefan_b@posteo.net;
> > > quentin.schulz@cherry.de; tudor.ambarus@linaro.org;
> > > Takahiro.Kuwano@infineon.com; git (AMD-Xilinx) <git@amd.com>; Ashok
> > > Reddy Soma <ashok.reddy.soma@amd.com>
> > > Subject: Re: [PATCH] mtd: spi-nor: Enable mt35xu512aba_fixups for
> > > all mt35xx flashes
> > >
> > > On 14:56, Venkatesh Yadav Abbarapu wrote:
> > > Hi Venkatesh,
> > > > Enable mt35xu512aba_fixups for all mt35 series flashes to work in
> > > > DTR mode, and return after nor->fixups is updated, otherwise it
> > > > will get overwritten with macronix_octal_fixups.
> > > > This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU is
> > > > enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.
> > > >
> > > > Additionally, a new flag, "SPI_XFER_SET_DDR", has been introduced
> > > > to instruct the OSPI controller driver to switch to DDR mode.
> > > >
> > > > Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > > > Signed-off-by: Venkatesh Yadav Abbarapu
> > > > <venkatesh.abbarapu@amd.com>
> > > > ---
> > > >  drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
> > > >  include/spi.h                  | 1 +
> > > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/mtd/spi/spi-nor-core.c
> > > > b/drivers/mtd/spi/spi-nor-core.c index ec841fb13b..8d201433d5
> > > > 100644
> > > > --- a/drivers/mtd/spi/spi-nor-core.c
> > > > +++ b/drivers/mtd/spi/spi-nor-core.c
> > > > @@ -4073,6 +4073,7 @@ static int
> > > > spi_nor_micron_octal_dtr_enable(struct
> > > spi_nor *nor)
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > > +	nor->spi->flags |=3D SPI_XFER_SET_DDR;
> > > >  	buf =3D SPINOR_MT_OCT_DTR;
> > > >  	op =3D (struct spi_mem_op)
> > > >
> > > 	SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
> @@ -4404,8
> > > > +4405,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)  #endif
> > > >
> > > >  #ifdef CONFIG_SPI_FLASH_MT35XU
> > > > -	if (!strcmp(nor->info->name, "mt35xu512aba"))
> > > > +	if (!strcmp(nor->info->name, "mt35xu512aba") ||
> > > > +	    !strcmp(nor->info->name, "mt35xl512aba") ||
> > > > +	    !strcmp(nor->info->name, "mt35xu01g") ||
> > > > +	    !strcmp(nor->info->name, "mt35xu02g")) {
> > > >  		nor->fixups =3D &mt35xu512aba_fixups;
> > > > +		return;
> > > > +	}
> > > >  #endif
> > > >
> > > >  #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
> > > > diff --git a/include/spi.h b/include/spi.h index
> > > > 6944773b59..d7fef36662 100644
> > > > --- a/include/spi.h
> > > > +++ b/include/spi.h
> > > > @@ -164,6 +164,7 @@ struct spi_slave {
> > > >  #define SPI_XFER_U_PAGE		BIT(4)
> > > >  #define SPI_XFER_STACKED	BIT(5)
> > > >  #define SPI_XFER_LOWER		BIT(6)
> > > > +#define SPI_XFER_SET_DDR	BIT(7)
> > >
> > > Are we using this anywhere in the Controller driver ? What is the
> > > significance of this flag, when we can send the DDR info through the =
ops.
> > Yes...we will be checking this
> > If (spi->flags & SPI_XFER_SET_DDR) && op->cmd.dtr) then
> > 	setup the DDR mode in controller driver.
>=20
> Is this change going to be for every read/write exec op or in some init f=
unction.
> Current driver has this setup dtr mode on checking the opcode.
> Curious to know, what does this extra flag bring something new to the dri=
ver.
>=20
> Prasanth
I relooked the code and I see this flag is not required anymore. Will updat=
e the patch and send next version.

Thanks
Venkatesh
>=20
> >
> > I need to send the controller change series.
> >
> > Thanks
> > Venkatesh
> > >
> > > >
> > > >  	/*
> > > >  	 * Flag indicating that the spi-controller has multi chip select
> > > > --
> > > > 2.25.1
> > > >
> > > >
