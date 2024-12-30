Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6D2E77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 07:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FFDE804CE;
	Mon, 30 Dec 2024 08:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m3gLrpH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F048021A; Mon, 30 Dec 2024 08:09:01 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAC2A8021A
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 08:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCPjTBq6dXjCIV5+sC/uucNEcZu+0qeexJz4as5DX73WZ5+QGkB1P8ZiIDl36W3Pnuxzu6+7/N5g5L9AgTGfCa+TC62sSB0UWWajMXdXZAbvwWA74YS8r82jBhhUrhYsNfa2nRnVfo8w2hjmCu8tqBoDvsCpBcogOv6IwYHChHO9Vvn9eViz1jvXhcJniPhudksnTKrTvrfNTRU4eYbzZrqftU5QO+QUmAYr43GVnylgAsVSRNvyoKczAccy6+8E0KuEp0OSgzrDFiZ8D4k+3Wmgr7sTthnvTHhg8zoVDSNhFOLKxcxDj0/WD4R4P9HJGLSrZ+Px49e3cEtk5idk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kv2/Y6T5ULfo1BX2ZobbQEgSnHSldv6rMQTuHDLx6s=;
 b=qAERMcU5kCAidVsAO3leUKeujO11yOJhqRorfqslExr4X3oHVLmvTfDaAGWoDnAEq8s0SA8A9u/aJI62TLy298+2YbHlKcJ5w4zmKbA5ORw1h4uZ9BBwSVbJCXMmDgR0404EW6G21+u94cZrB5+O/57MvTv7k9PWX0K3k3fbAajQtrfaldUyXf02HVrjq2LimXpRl9cFxYlJrxsUeadih2yscnEnab8Ga2pomRTCkHnSZmtsU9hvJ1XC9x8KCFBcfiXpZi6Uuj0LmpAzcKlC97KDRMLnrmHVJi6PAjtD3fltbHDAQc46pQfQ3Nden2HA0EiLBeuy00wKauxj52VlXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kv2/Y6T5ULfo1BX2ZobbQEgSnHSldv6rMQTuHDLx6s=;
 b=m3gLrpH+ImVLw0uRvUXm4AYUF4Fa8y7652G4Bv3nNFoCPABRWJWrteMin5FbPX9p6e16yxecNnxijP9IxU5pe+hKQ5o7hNdnll3CxwRi9w6sww9UfmcnBml5IzpXLS7Oq0FBnFb5i0iUkewfPaJASkthfqfeWtaAW0i0qnwpX0M=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH7PR12MB8178.namprd12.prod.outlook.com (2603:10b6:510:2b3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Mon, 30 Dec
 2024 07:08:48 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%5]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 07:08:48 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>,
 "marex@denx.de" <marex@denx.de>, "Simek, Michal" <michal.simek@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>, "seanga2@gmail.com"
 <seanga2@gmail.com>, "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, 
 "sjg@chromium.org" <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Topic: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Index: AQHbWBrUi10JtBBhZE6rXbOanbpUqbL6aIkAgACo9OCAAl3AAIAA8ugw
Date: Mon, 30 Dec 2024 07:08:48 +0000
Message-ID: <SA1PR12MB8697C34CAF53AF3EC9EAD14A98092@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241227044934.2109997-1-venkatesh.abbarapu@amd.com>
 <20241227182306.GE1505244@bill-the-cat>
 <SA1PR12MB869745E73B63621C18E0E4D6980F2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20241229163552.GA3476@bill-the-cat>
In-Reply-To: <20241229163552.GA3476@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH7PR12MB8178:EE_
x-ms-office365-filtering-correlation-id: f28c307d-aa8d-476f-0d58-08dd28a0cef1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oSMKu5kTpTb15YG1mmd4VGUzoETvil/BaApX83yCaHBeO+nlmVqLYv1a8y4u?=
 =?us-ascii?Q?/yPB+LFkwSzTOgDeMihiolCnDDah4SW49GtQ9x/4KPiXOGUE9jtFecrSYLgH?=
 =?us-ascii?Q?99ye3c/nf2WiKlhQgVpxNoggGNr1zydz6+RJt+XNMcKl5Rlwt2lBEjRsGu9V?=
 =?us-ascii?Q?vwF3A2CzC+tWvZhUsJmYvSfhRmWOlRvSwlSOnSWY+cKWr19YTQVQ5KN3YacR?=
 =?us-ascii?Q?qCCCiAUQmVqTxtnbHR7wjTINNDVPxAADwi7ouHOyInG29WFMl2G3w8ip3p73?=
 =?us-ascii?Q?B+aJ55nGIsfcO1cqvwj9WbbkBLlDwDm/2SauX1FYqBRIeo2qUQOxjRUwRrwH?=
 =?us-ascii?Q?pi2qElaw41o0ju3eNNeo1Vi24XENctgskngy5Pe2ahNUakUQPL6KWZe4MMG2?=
 =?us-ascii?Q?rjXrLn9IrmFFWUQwBkgs7kLZbqLZrcVy0Az/H/nfYBIsKYmMZld0Fy0oIhOY?=
 =?us-ascii?Q?CkLXf3+SJ0IRncjAuCAVFN+QwymAFTCm/ySSCVMEPt/6VFG5PN7iwTiFF3n2?=
 =?us-ascii?Q?NSIynwWqaPtd6IIcJQXfSxcwfJg9cLsvJSRrckvTJLJ1k+Fe/uu9zJRkEdvM?=
 =?us-ascii?Q?BEPgDCWwEaMP+cHELl2GHJrXtk1c2e+Gin1sfUl5a52Y6WsnfI0bHaK0zCLh?=
 =?us-ascii?Q?DcMFG4c8N9Is98sRKlkNZ0a7JrXlQf0M73svRT3QNK8qOuIbrVfREtN5aLKK?=
 =?us-ascii?Q?jGwnwNQpLZNj0i51M0QEoYgUpEQtrbblg0N4iiapz57dBxqAsZVQ0ur5StoE?=
 =?us-ascii?Q?Q9apM9bPjbYlDj6cmsnKT1uw8x/P2yhKIb6QZnzdV/Yl53AGehjKt6ATAkLL?=
 =?us-ascii?Q?AIh+pJgFHcO+p0PgrKiW3In5HImjsJGYoLEkUyEQEfnjluT5iC1QHuz4LDKX?=
 =?us-ascii?Q?KuAyIuXKjdG3Cv9tqjU2hn5kMbENRmWFaM7lreLGVFbDUqnValBRie3xw3A2?=
 =?us-ascii?Q?87aBAmwurWOwYczbsi6sD7tIw0qlYINfDhd9UJFGaGIvxda5LP37bawB7DVO?=
 =?us-ascii?Q?X09CCqQDzT1HL9Zkf7tzJ2yzL+WWnEl7z6A9HgtGBykR5MGN164iH4OBKRT8?=
 =?us-ascii?Q?C2ComStqfq1QY2Tjhi/MyI5SeBbaFEMior0phuVQlUOFlj/zHBtJ3tY+83P0?=
 =?us-ascii?Q?cGZ6o3zJ1grY+OmlKg7Bx4dTgU2OhHggOAR7IzE71tPAxTtC8INbc84w1/iG?=
 =?us-ascii?Q?mW/6/UTHbSJKr5fVC6W5bhdJXlvMc2NyuiXjivJ5Nm3DyGwwBg9G/X3OL8R4?=
 =?us-ascii?Q?FpL6ZTx69m3UiFPr0aJYniCdoyE7eXAda9WosArQ+LcJiiPGjEMQI5J992Fv?=
 =?us-ascii?Q?j+ouTfZEXbxe0uJ4mtjnTBIzRXO5YTMAdBXo2bjTZHlPF0LF/MMWVFD7zVhj?=
 =?us-ascii?Q?eLh1BCCTQaOO00Vt51bJJidgY4Tp7coki7OyExnukCVXM3t4Ww=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4vZvZ7XkC25zZ3/uG8dyYMXU/XTFso96iCzZpgR16nT3OXB/E06IVlilX6BR?=
 =?us-ascii?Q?bY2LhRGyp7UWWML5Tt5g1jKkJzeX7ndh/kPshnhW3yBcGjIPtDPzF30aABNR?=
 =?us-ascii?Q?loCTTdVj1KURXGxOCyEXeVY9S46RCGYsQTtDKfs7QtINU/9mp05SGA7V7cOK?=
 =?us-ascii?Q?Va8RMO6eb57evqLaC+Sql744Dec23ZkkirI3zxELcIFCUUCcG+Wjrovj9YUu?=
 =?us-ascii?Q?LvaC6Peo0ULAmKvdhMC4VLvOub+3igCeBorK5IEvRRx9E1qticN1/ExhTiDh?=
 =?us-ascii?Q?M6msyEwY4JIDIkhFrq8n1AD3mgHS3dKDsvm6gY87cqUU/DgC7Pg0b+M2VofN?=
 =?us-ascii?Q?RTyDpihlYcHmNGnv1JMDYqR2OJPlwaDDifoDrZXoSZqx51WC17hofTCHnG83?=
 =?us-ascii?Q?yosjF9n41BW6lEVZ4YtVGiTLioduz1uccxq90TwR6mKNWksbMg8uNDhFxx2c?=
 =?us-ascii?Q?rTt2nZIJ2zjOcKEDImhPiwgims5/E8qzkyj+bMWsX7HkKHayovZiWtCZA2/J?=
 =?us-ascii?Q?ugQdgEoKAjjHOa3BKtdIrpuSwKphrU2jWbmGPHY/RnEPhERflXZZiJjCzZ8f?=
 =?us-ascii?Q?/dGsPIRukEYLefONa3QPchPYmd6CaRX5uWk3iJTQwAMSskbwFe3jxrzbJTIl?=
 =?us-ascii?Q?dJkT8jQTYbgQZNcvhct+Bve9QPvSj3NJr+PmrszUqPy4ryGt7v6saybr67kS?=
 =?us-ascii?Q?31RX8mRngqMMZ6VTu5Z1nhwIIv6HvvDbtGfq32R4+R4luLtzglcacG9oVZ5L?=
 =?us-ascii?Q?QlpAwqFDUtnYFoSS6K0I/1pcXQvD3xGJ1OcklYUJ4zEOfz0bBphFPMUeqEMN?=
 =?us-ascii?Q?DXmmBqcwBMErnu6jDCnWKnd5L/EEf2dse70QwumXVRXN2nCGxy4SNFOOWBix?=
 =?us-ascii?Q?TPSGBMhE4VyfR6+oH2xzaBK+fgeasAT5iBnDzisI8LOAkpLO6b9k1UrXd5u/?=
 =?us-ascii?Q?043N4c/Bm4ZU2wuCHSKdHCzvleVifcaXVruQSsqy+uwDs9CrW3mYK/4RrIN2?=
 =?us-ascii?Q?sMuAmatjbyVoFJ8JQwDMO1eD33LDN5YL9ujwZH2iHwhHPoHwO5DDyNfQPTkU?=
 =?us-ascii?Q?KymH/ufwiegn5y+KWQFAcKZNIjZGW7oSxQYfEDXdUlaICjrG+vSKb8t47AwZ?=
 =?us-ascii?Q?51mB85gD/1B2QmPbZSfTb0Fe3B/6VdgN8yCMaYgk+PFQIXRfmVqkMhq+cvxj?=
 =?us-ascii?Q?y3JwGbq9uekCj4rvIIjyItUxhYvQMaqGDq+0LYdbMDHOGDasJU43Ze0f9Y/j?=
 =?us-ascii?Q?P84OTbp6KgZjPpRB+OzTTIoEQvwdM8mIR/1RXk0IIVF4EsFUP7vwet5dBOLR?=
 =?us-ascii?Q?0gRFqjm7tgYVT+/irh2onXXqF2Sp44FL3R82xkN/Y5ViS38EL89/lcxjV1/v?=
 =?us-ascii?Q?zChXi39/9IitSoyK3QfXQgi2HaGteQsYDtgfHcKQfPO42f/jkdSw6f3Z4OLX?=
 =?us-ascii?Q?pFIt6GdFaHlbiIq5YF/M6L39FmZqMIjfKFFLLHpKotC1ebv7WjnqTF6xMoKg?=
 =?us-ascii?Q?CZQ6QyxVzosTAilxOiDV0wfOlsmz3DgAoCCXuztz3GApPM3bJMcxvhriwapi?=
 =?us-ascii?Q?23B723/RGiX1x9a5rcg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28c307d-aa8d-476f-0d58-08dd28a0cef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2024 07:08:48.7871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRokeLexEeKyxc7F0yxikllVH4dYRCGP1PrasxILRWnJm7TGK/roVhd40F8unEtzOckvJr39Wfy4ppav73rn3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8178
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

> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Sunday, December 29, 2024 10:06 PM
> To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.denx.de; tudor.ambarus@linaro.org; j-humphreys@ti.com;
> marex@denx.de; Simek, Michal <michal.simek@amd.com>;
> jagan@amarulasolutions.com; vigneshr@ti.com; u-kumar1@ti.com;
> seanga2@gmail.com; caleb.connolly@linaro.org; sjg@chromium.org;
> william.zhang@broadcom.com; stefan_b@posteo.net; quentin.schulz@cherry.de=
;
> Takahiro.Kuwano@infineon.com; p-mantena@ti.com; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when config
> SPI_STACKED_PARALLEL is enabled
>=20
> On Sat, Dec 28, 2024 at 04:29:39AM +0000, Abbarapu, Venkatesh wrote:
> > Hi Tom,
> >
> > > -----Original Message-----
> > > From: Tom Rini <trini@konsulko.com>
> > > Sent: Friday, December 27, 2024 11:53 PM
> > > To: Abbarapu, Venkatesh <venkatesh.abbarapu@amd.com>
> > > Cc: u-boot@lists.denx.de; tudor.ambarus@linaro.org;
> > > j-humphreys@ti.com; marex@denx.de; Simek, Michal
> > > <michal.simek@amd.com>; jagan@amarulasolutions.com; vigneshr@ti.com;
> > > u-kumar1@ti.com; seanga2@gmail.com; caleb.connolly@linaro.org;
> > > sjg@chromium.org; william.zhang@broadcom.com; stefan_b@posteo.net;
> > > quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.com;
> > > p-mantena@ti.com; git (AMD-Xilinx) <git@amd.com>
> > > Subject: Re: [PATCH v5] mtd: spi-nor: Fix the spi_nor_read() when
> > > config SPI_STACKED_PARALLEL is enabled
> > >
> > > On Fri, Dec 27, 2024 at 10:19:34AM +0530, Venkatesh Yadav Abbarapu wr=
ote:
> > >
> > > > Update the spi_nor_read() function based on the config
> > > > SPI_FLASH_BAR and update the length and bank calculation by
> > > > spliting the memory of 16MB size banks only when the address width =
is 3byte.
> > > > Fix the read issue for 4byte address width by passing the entire
> > > > length to the read function. Also update the size when the
> > > > configuration is stacked.
> > > >
> > > > Fixes: 5d40b3d384 ("mtd: spi-nor: Add parallel and stacked
> > > > memories
> > > > support")
> > > > Signed-off-by: Venkatesh Yadav Abbarapu
> > > > <venkatesh.abbarapu@amd.com>
> > >
> > > I don't think you've run this through CI?
> > > https://source.denx.de/u-boot/u-boot/-/jobs/984698#L289 and similar
> > > on all sandbox targets, and Azure shows it too.
> > >
> >
> > Ok...Could you please run the CI on the "v3 patch" once, as this patch =
is entirely
> separated the parallel code with the default one.
> >
> > [PATCH v3] mtd: spi-nor: Fix the spi_nor_read() when config
> > SPI_STACKED_PARALLEL is enabled
>=20
> Yes, v3 passes CI. Does the help with what you need to do for v6 then?

Thanks for running CI with v3. I sent v6 patch considering the v3 related c=
hanges and mostly this should pass the CI. If there are any issues seen wit=
h v6 then we need to consider v3 patch as the comment is only with the addi=
tional #ifdef statement for the parallel configuration.

Thanks
Venkatesh

>=20
> --
> Tom
