Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21655CED25B
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 02:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B7888D86;
	Tue,  8 Oct 2024 04:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="gGPQr7vJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326C388DAA; Tue,  8 Oct 2024 04:59:25 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A50A88D7F
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 04:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndhca3rDGvXU8yizZ2a4ynU2M2tt9ucXd4YD3tmwrUYac42+WeFsdtSOnPGtmIQ1jXwsZbYrq8ygjME9o3SvpjYf29zt2OkTvHiISkd11rUPKPRUvA8KGR6gJMDsDjfXSYA2PDmXLiYOlIHFlnK9jrLBRd5jctxgpH+mhKvaSvoKlQy8pEim1fRGmSOX7Va6InMTfuywuMyupKPkqOEJoAVp1RG/4YYrq2pAIxCqIEuXx2/G4b7Z8diMgS+UrcoEqbUGrAUIYTel5C+z/4mGfCOJGDKviCOPH0hNKucbjK8GjdFw5ouO9BOL/VVhFuvscKlEsnq5kyO1OnOkE92M8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJomZPyhsbYL5y085oa162rCoO7ttQVX1EAHA+x0lJw=;
 b=hJTV4+Zo3l3rBFcsWZwXqLvWul27i97NMasFhO9IegV8VX545/QxMr9LFv6HSyXg1fcEZe1+kBsiphj1Rfhyms1EWbC/Qq0h8I4l7n11ixs5kPefLiiw9eZ+HOJiEEsI6LF1OmcYOM0oz+h1fXQ0aiVGgTQfa8hNBErqcEJJKm0lYZIY+OQrPRBKS5wEUo1vqO1h1ko4DDbD8EvLyYllTRpKMKw63uzBhXPOl7HmtkEAvG4H5IeUIradwDZc/1Sy+dbCwtI8Ooboj8sfqtnFcSEDkPJZLndBIBcumgXi8qyiqsR6lB1AQ4BzUH0HhX8ytRO5qThCrf6+h9OXi/zbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJomZPyhsbYL5y085oa162rCoO7ttQVX1EAHA+x0lJw=;
 b=gGPQr7vJ3lK+xLUMd77EWEklfnWtAxJy50POE6RfagBtYtsufVJzayA7ry+4MMU5fS+jUuIz1LpMiJSgYRBjynWQSxgLxDXhut+4nJbv6trskTlA5o/1CZ5bea2Ccmcv3PVhQxDPuktochN6POpgXELmDkD23RQiCBVQbaIjmtRGt8iPbyPv9Nq07D3W5hiiz+zwyzLTeuB9XlsDi+OgQR+9HY1YzA+uXvfWfr8yM91W+Vy45QRtt4tX0uMRZ3i2vHZN8KSsgk2XhpZ6SzD1ECGIVCMQlap7XgUuQLM73A3PqeDbKSftqMP4gjY6xibuy+Wu6GTTsz18zvG7xQi01Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9665.eurprd04.prod.outlook.com (2603:10a6:102:240::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 02:59:18 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 02:59:18 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sjg@chromium.org"
 <sjg@chromium.org>, "judge.packham@gmail.com" <judge.packham@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, Ye
 Li <ye.li@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "marex@denx.de" <marex@denx.de>
Subject: RE: [PATCH v1] arm: global_data: add scmi pointer
Thread-Topic: [PATCH v1] arm: global_data: add scmi pointer
Thread-Index: AQHbF9WVGGxvWv51PkuEG83h1EQ71bJ7hqeAgACigYA=
Date: Tue, 8 Oct 2024 02:59:17 +0000
Message-ID: <PAXPR04MB8459A692CF21AA616DCDA7BA887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241006095228.2800776-1-alice.guo@oss.nxp.com>
 <20241007170551.GB4737@bill-the-cat>
In-Reply-To: <20241007170551.GB4737@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB9665:EE_
x-ms-office365-filtering-correlation-id: 85cff4b3-e930-49f8-31b4-08dce7453359
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wgYynFsna8maWv/RXuFGgiWg/xOOjPB2Z/cmgXEbq5YJB0Zkr/WfcqEGPRk0?=
 =?us-ascii?Q?x4ZE/vkgJnaAWZMbj1nziHVp+YEA13B53MmKeBgnfcADR9+cGQDmpI79eNu3?=
 =?us-ascii?Q?kBR5nPShX3oFq/zYjGWm64HsFHzITwNrPnkmcXRsVUChKrL1vpFAtwtMKbOD?=
 =?us-ascii?Q?i+CoznztZQZXG8EHD4fLLx7JJruop74f9GVjXFmRgXQDGYibcQWY2kVz26Nw?=
 =?us-ascii?Q?n5xRRYlr9gKYHOFoHyUX8W3aKJbTQHV7UWigzYBR7ZpmOMQlh5p1JOWlZHBk?=
 =?us-ascii?Q?PMxE8/rNLCsMHGNKq7D0yGO+oRxaHsxAzaRMlYrBiU5qw43RohjFegaSmIuD?=
 =?us-ascii?Q?VWIsIsaURucJQZR8O6ptpbdUWhCn2yxrM+JU+gubThapBhBe2Xvbpr1ULP7W?=
 =?us-ascii?Q?Sz8pD5AQxE1D7Agolll494x2WLM7IpVVir9AgdUo7Vpj4/TJBD2HPgtDJkOS?=
 =?us-ascii?Q?c6XPphDqtotPbHgRRtqc26X2gA40t7NyFjKGL3tA+RqHxKRKbkq4iiH6dBEf?=
 =?us-ascii?Q?KkKUMRqERbvohOTE8ow+4iKh5OXyNrEA96Sx/m1o7gL7vL7AoBWft+NyEQDt?=
 =?us-ascii?Q?+MOd5QYaf8CpK/K5KRNWWQhAYGbkoNldoewMWXF7GZfR9311aET+ElGkKRm2?=
 =?us-ascii?Q?CLPvvJk3P44Wm4MeAlDvs7qzdh3T0P7ois0YHA25LD+x2RWXwGaN/8nGkIfC?=
 =?us-ascii?Q?irobzC0I/EgLsZR4BkpVldh1Jt3v9YmQBNAUtbO+GL7NtPALnAmDX2zpoPl9?=
 =?us-ascii?Q?t1ENQ0Yfei+i3gMkDRWg+UJ31WHwQJEROg+5X+z5JednIVF4LBU7KEnN5W/a?=
 =?us-ascii?Q?XtwSg4MwHrxLfodoQPsQ9vVXDEV9vZI6SrnXs+xpO2ceCrObqoKiwYeOXpUA?=
 =?us-ascii?Q?8upeq3quN9t3crpZnZiEKZhZ7Hlpn/z1gHV/V9P8tE2o84k9o8+ionzHA8Aj?=
 =?us-ascii?Q?Jw+FtSPtcZWSfI3b2An6QBmbC7aLD1XLdALiKZqf5aEk0pvlb8lPENZfUUB8?=
 =?us-ascii?Q?D3woFSos+pnIJkXfaSVDpSx6mDeW6vuozQpWggt1UaqaU/1FGgnJpAqCBdW6?=
 =?us-ascii?Q?o04sgWBGPRvaytOV/fHEflHec9pAgEkWi9h0FZveWI56sC6c+1KETgZrs9Uv?=
 =?us-ascii?Q?kQX0B372Mp1mpK3Tb4KFS3i4uBS3qyNHjVWzbsyukaJwnBoOoK7zGS9YqCiZ?=
 =?us-ascii?Q?CCpP8yzQyXjkbn5+pFZGEbq+UQdVvyVJR7FghaC25v/xTLJBZly7h9XowpeB?=
 =?us-ascii?Q?V5IkKFjNJnoyz4aYyoLj1L3TL0EedknB+7Ces/yrLBz62V+PJDUrABBLS3O7?=
 =?us-ascii?Q?6GVoy0yleO3y9EYjqs4QuMEXDNMYJU0lh1qgmqkdib4ebQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vqoS9ZYpwDcSDbNDhWGdJFy0bFTbrFHUOsM4RmXf0RttTR5gcu8omp+cbhn2?=
 =?us-ascii?Q?na9odHYAv75hu41KhNPqDQ9qmKhlAlb5TcWQH9KsTOGaNdBXHPKEDuWHc4kW?=
 =?us-ascii?Q?g26wZR3ifQlpASoHXZDfeVQv4eX2q+LWaV8CytkDMM9e8SOtea+DZXtMSgJ2?=
 =?us-ascii?Q?weoW7p9FWz8Rd3cWpvHyG3bJk7gEZ2pPZ1myUeqEu9/U5+vI4p38LDEftJ7D?=
 =?us-ascii?Q?0UxpNdOCJOvwRuxHAxxH55ZBr4QIvbabmdU+aPCYr9qH+AfdZM9tZhmUHLBZ?=
 =?us-ascii?Q?4GwNHn8iNRU3JdWFmi7jtBo7kd0x3m/UiHPHq2YMhu2aipEUFP51pRd5WgO6?=
 =?us-ascii?Q?YYx12Q5jiIEpF0BpDx9q3UYfVaUZOJesQTmQRcce28AjibLSIVUcxx5Lnuo5?=
 =?us-ascii?Q?pTfNtL9YRULUfqU172ZbyVDAhoaH6+7Jp3Nr8lt2aIMAjpmMM5I1pJan7/Mx?=
 =?us-ascii?Q?rbWBx2qIt/Glg17uE4+EyjgUR+slhPbMF/9j7vLq2Ax/UubYohd+W7mqJfYG?=
 =?us-ascii?Q?ZofCDgeI1BXmPYKG3dKue9Qun/TkmQznsKttHMNwjLEc2nB/sDGtMcqbj5eG?=
 =?us-ascii?Q?3Vxl9hhHFgjPFysgpTIhMRB3Psfyv6IgtVfH1fL2AhcnTkT/6eTr2NLQDim4?=
 =?us-ascii?Q?p9b3ry5eZUMhpd4b6KrABkg7Dp4EoAf7k9js5L/jo/G3/cnalSOAPMsdPl/l?=
 =?us-ascii?Q?rW65nwDsU55CW8fOVdqKTBv9wU9Ajqfas4sqORhbZsqYU+NtNGhBa0GMgc1q?=
 =?us-ascii?Q?wA26W8n7JOBTpDNq63a6a5R9gEdudckp5+eDHjeCqVDFVBGLBl9gbPl+LJQc?=
 =?us-ascii?Q?++cxZ6zlNLzPDx68QKf1OPgTdlkGisge01djWJLWUjQo4XkXI0vjdQ1Xb1Bw?=
 =?us-ascii?Q?5NpnYFqmgqFvtELdUt7RLYYeTp8EnVjsCFqwecCqIbp+jeKgCYiGvFiR4HnZ?=
 =?us-ascii?Q?L6lIIF5fthbe+UCZx1vrmG4YJoDi0BI7pyaTte4iY5OxOt4eG1M7wtWA8iCT?=
 =?us-ascii?Q?W2N2MLE5V++vMCJBLXGlLkEK4f65XiZDEkSyQhrxx8CzzdbCxWTmgGjUxmPr?=
 =?us-ascii?Q?wo58ocDTmntILP9D+4eS0NJmhV2wWOgQCiZy52r5u9BReBzebc08JHUao0e7?=
 =?us-ascii?Q?nMvifiCYjJgwPUOhsiF2DrUalo2gU2fIIMjaK7h0gxXB0EtHymMWfJ6I41Tt?=
 =?us-ascii?Q?QA6FPqrI4KQ+1dLV57svg2Hfd0ii23PRxNky9/+ztlRZy7xQsNESu1tSEJl4?=
 =?us-ascii?Q?7xx2L+FFdQWE+Kg6agiC/Ilt0sHRh2Et89JCIwJ4M5Psw0oHHjQoFPHCkJVI?=
 =?us-ascii?Q?Ul0BqLqSymA7FYnN4OUtxN87tqwJPz6xAx75pTIEpImdzT5v0IyHqieeOS/x?=
 =?us-ascii?Q?Soe7BexcnpJHyQIDgqDNuBl5BfKSFET0OAlnDK37mW/Xwc5mbKRIk9OTe3WG?=
 =?us-ascii?Q?bwNXFUzPOIWfmJFmLjMJYkn3AzsEuRAc2vVz/JhDhOVhplRx1hLOpFjhWr+8?=
 =?us-ascii?Q?v2oPiI4CJpYyUezu43MdrRkYTW/Qt/xUQLFQZZVNRIkQxtrfx7xYV80VzZNh?=
 =?us-ascii?Q?a1Ss7uJsEYJQPbL6yXA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cff4b3-e930-49f8-31b4-08dce7453359
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 02:59:17.9855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ru5SB9VlIQ0OMmHMSZXM/4Pzt2ME3D2OHl7mpNRmmuz1IZzhqiB6bdC+E0vOUKb1zr1ELAe9WYj6r6LSG4MxQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9665
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

> Subject: Re: [PATCH v1] arm: global_data: add scmi pointer
>=20
> On Sun, Oct 06, 2024 at 05:52:28PM +0800, alice.guo@oss.nxp.com
> wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add scmi device and channel pointer for i.MX9.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > Reviewed-by: Ye Li <ye.li@nxp.com>
> > ---
> >  arch/arm/include/asm/global_data.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm/include/asm/global_data.h
> > b/arch/arm/include/asm/global_data.h
> > index 45401d5e3c..d04359f167 100644
> > --- a/arch/arm/include/asm/global_data.h
> > +++ b/arch/arm/include/asm/global_data.h
> > @@ -108,6 +108,9 @@ struct arch_global_data {  #ifdef
> CONFIG_SMBIOS
> >  	ulong smbios_start;		/* Start address of SMBIOS
> table */
> >  #endif
> > +#if defined(CONFIG_SCMI_FIRMWARE) && defined(CONFIG_IMX9)
> > +	struct udevice *scmi_dev;
> > +#endif
> >  };
> >
> >  #include <asm-generic/global_data.h>
>=20
> But why is this only needed for i.MX9 families and not other users?

i.MX95 has some code that communicates with SCMI platform,
but no scmi driver for those code, saying rom pass info. So we need
a global scmi_dev.

Thanks,
Peng.

>=20
> --
> Tom
