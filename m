Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FE6C71159
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE2BC86E92;
	Fri, 18 Aug 2023 19:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KjlotpVc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E88A86DC8; Fri, 18 Aug 2023 19:00:13 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D584E86E92
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=elena.popa@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmP8a4TpdIsLQQaA32q+a7JGjy5n7qoxkBCDszLxwi5ukKV4cplNehdazS/Wf/DbbDJ97jp/NtpD+XrniRV9Q61kHUeG7Y3r8tWPqeTFrVQOtzVOsTA+kdBH3d9TYOi0DOGmAk6Ksf7qvGsGmAinwtzVcxFYyap4d7FrB5XgKQrpIQvRdhdpuBakR4CD9tqAtOzG4nFHoJpDedRZb89HbGmF6aTdctJHmvudMSYz4VyJcu5dxOfi9BJjmg8buf/8eeuKs2Q1zfb93nBhcSlQty9T94PRwga+nkspUoEvVFu+Mi0oLAOYQ2mEp+a481s5HKKxKMpHtXVGcyhnP4CwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s53WD9Ziw1D4KnF3V1xUAstddfJQMlUN0xiNIwxvmyo=;
 b=C+SVFfQSoNs0Et+GiDFy0k+ra+ftnhv9DS2SumY0K8tVgKFFKJ57L9xkvZy0reU0OkD4LnTZhRYQQ4hMzylv0YAeZS4JOXdLUB2RipIP8mpo3b/y3pW3k5VYU8Nc5ac86sGPis31Qk0VJfHiVBX2T4G1IcXKAfIoHgZ7JWIsP9SfzL2/vYeLXuOnEelRAnCLTGs+0pdQbIm/7InRc1dcfOoDqCKOST9C0x+eP05TsfsImtWyy5NdkTsnxdgYg7mZ0L9pjz9MJxET5tk9c1/LClLjzGwZjgGNHLJKCDThscImSSb8sLmLcPwwcdVmiWnI2gQ6n7ald6KrWluelcng8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s53WD9Ziw1D4KnF3V1xUAstddfJQMlUN0xiNIwxvmyo=;
 b=KjlotpVczoQOoTLDjJ2sMtXZISPCkgx2+g+zQEKTBwQXZthk3M23ddAcDw7nUH2RFw82qKZEcWfYyEv0yjK0xr0vcm70g+nhGur1SSt+76PVMh1EPp63m0mGsPkVmp1ngYPnQuLliuR3mMroJu8OQ5YqEsHV5R7A4Ymbk3Vw3FA=
Received: from VI1PR0402MB3630.eurprd04.prod.outlook.com (2603:10a6:803:d::20)
 by DU0PR04MB9660.eurprd04.prod.outlook.com (2603:10a6:10:31b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 17:00:06 +0000
Received: from VI1PR0402MB3630.eurprd04.prod.outlook.com
 ([fe80::2eae:c5f5:ea9e:ee77]) by VI1PR0402MB3630.eurprd04.prod.outlook.com
 ([fe80::2eae:c5f5:ea9e:ee77%6]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 17:00:06 +0000
From: Elena Popa <elena.popa@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ji Luo <ji.luo@nxp.com>, Ye
 Li <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marex@denx.de>
Subject: RE: [EXT] Re: [RFC] spl_fit.c: SPL Falcon Mode return to U-Boot
Thread-Topic: [EXT] Re: [RFC] spl_fit.c: SPL Falcon Mode return to U-Boot
Thread-Index: AdnJ/qc6FoxI5maVQBmH4wiDrHixoAB2QHkAAYbjQxA=
Date: Fri, 18 Aug 2023 17:00:05 +0000
Message-ID: <VI1PR0402MB363013B1B87BB43633C38501901BA@VI1PR0402MB3630.eurprd04.prod.outlook.com>
References: <VI1PR0402MB3630FE83008686093D25C582900DA@VI1PR0402MB3630.eurprd04.prod.outlook.com>
 <20230810221150.GA3630934@bill-the-cat>
In-Reply-To: <20230810221150.GA3630934@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR0402MB3630:EE_|DU0PR04MB9660:EE_
x-ms-office365-filtering-correlation-id: ec4f1edd-e537-4901-0aa7-08dba00c9258
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ZHML08qzvXMBER2dnIBoRKA6lDWVLIPMvT5m2iGIQvTpy63ss3fljrYFLFLHNBZwVjJ9qRX0Hpi0mWDu3uwwpgPFmGxIb8q5OEfF37TvLCxgby31sGlebBlo9V9lNSaZN4CrL2v3us4736nb7aXvbb25evjfSa585sd8V2Rk6y/TvWih3rRJHGtq3Huhs1RyvDv+lIquQEJenYgQkV4NnDgnEMlgoKQmqKuwgEM+bb3rCCNEdwExnwkHCy8a6QHn4YyJ9wHi+z9L5reKqRn4qHgRLXEYNHIG7+FntPsepCpNQGfD4M+EF45vpUU0hJ9wNqIOvUEvHR78xkwDQ7akzMcxgRPtu/DuC2JBVlG/66bVZHqodl5VDOJXInS61+sAg5iQrPth50dpVugzp/LLQJ/g90QLwHWYmRDbTivlE41Mq0d3uiPOCP9tIhgsV0F15tu+ua1iEGCCxCaBVIry5re0AjTticCcLLE2SxQ9Vy/eYlpRCmrJOEplHZZFonkzrXqLggam3Nys7i+Q0PjDFia00TQliKUlu197BstH0RR3uu+W064isl1elUeH5Vsj0SEN0S6OYl1cn4uslZrpxfw3FTM937pP1LaTQtraewvAOnQOrA8qxwAMm6K2xL0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0402MB3630.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199024)(186009)(1800799009)(76116006)(5660300002)(44832011)(33656002)(41300700001)(2906002)(66556008)(316002)(6916009)(66446008)(66946007)(66476007)(64756008)(54906003)(8676002)(4326008)(52536014)(8936002)(478600001)(86362001)(71200400001)(38070700005)(9686003)(38100700002)(6506007)(7696005)(122000001)(83380400001)(26005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?otAoJ6jQhfi+HoMzxA051sYpo5PH7ZUYWVstvI2zNwHEhO+Xj2uToOZ+KITz?=
 =?us-ascii?Q?QTbDLhNFe/XGht7HZkkqPC3PYcsjNzmzbklv71O3LKkn72cKSpZE6tGJNWSZ?=
 =?us-ascii?Q?dQc+zujjzCIGGogOGNgME+i81GKgtO79lfE8tW81aRdcqK93HzgTqJuty/ll?=
 =?us-ascii?Q?0M33dUfLGSL9SCS7PKrhg+wlNolR25hxX56CedNDpcmS4x6peBBxpjPY5sDU?=
 =?us-ascii?Q?Ab7gMv7WyYaaY2ztZwN2Usm2Ezx6PEYHeoQv2e9CaEslNZH22KmgrILDlfvB?=
 =?us-ascii?Q?iUnhH9uFuBQNGQ9Z5IQm54r54TKn1UXXVEsvOxgpvtS/LJGC7WuZ/9PmdGC9?=
 =?us-ascii?Q?VqU8iUNIs7uoXIXZGGNQmlkD7sUqkKnClUKzGBqbQMv8lMaIWCqxLdYvHqPW?=
 =?us-ascii?Q?cj3D3KFlB8c07CeqTh1hmc0duTffMXXNZUF8FetQhi6uZIrLsr5zO678BtEy?=
 =?us-ascii?Q?mJ/eIM5ULhPcyANwmMs6fHIzAWHSnJJ1Gp7xDueKKPJh0Pc87VfLNk7KGSxV?=
 =?us-ascii?Q?6/AZBo96pYQXNNDRNPUYNqOZJ7D2cLPjvk5CrHVBnupTNO4T0vOa8ljyhxva?=
 =?us-ascii?Q?QgH8Qwc8ystF6SJFIb53w6dx2D+RvyUb5WaPMVo6garpbCk1JpgFBUWJ4M3k?=
 =?us-ascii?Q?khqmOfIigDOVk9BNmZOlE8FLTX3GdXps4WIFPKrkdrn9IBNB31q02LAMvstD?=
 =?us-ascii?Q?ln9CGWPto/SZS7jQfnu0+ai976dyOPAf4IhD+uJ+Z6EbQviGBIUhYB/AiwAK?=
 =?us-ascii?Q?RVVqCC/dl7L42tsFnJrVcQcUvRetWU+D0LhB+W/FM0aC+/vfvhdEUN85aNPc?=
 =?us-ascii?Q?li6s17+ZUGL2BGbwv2m0cpsftXGfgckBe4xKUl5djOE2doWmp9bFCqnpFMPg?=
 =?us-ascii?Q?AXRnsNG2XQAcPgEk4kVYD0BCEun1X/VNYzvu7GiUCKgFMAniC4IFayR8GTmx?=
 =?us-ascii?Q?Ysx6whrj3EPQcBNkEoq4rW/sZT768JcAP46C2zQwDyCQk5rznVmzMPQZkCUh?=
 =?us-ascii?Q?pzph5bq7BTKYN7hBUuV23JvUu6B15p9SE+UAe/I1GuTDxfC5do9cj7tN0WKI?=
 =?us-ascii?Q?xDuo+b2n9PZqi/xLWgRy1VgnsgunH4RnfcwOcm7jmE0dLSVUOuSXwwOtEcom?=
 =?us-ascii?Q?FMjMHLOuEW1doryeULy4ISw7iBX3CHyzn/fahnBtGe6qv0R4Ka773vJay2wo?=
 =?us-ascii?Q?fajS9SSqqnQrNrq4i+4wvE0IEbjnjb7r78o8Hu2Y2DY/oEE1kUpaCF3UNlEj?=
 =?us-ascii?Q?tEaeDNWTI9nCFDpb0FxR0N8c1o0RYhw3rTl4t2HpNjCsUXonHWFx1mVd7fGU?=
 =?us-ascii?Q?3G8FkpoIok27HszOyJU2qNINu6pA13G+halFzv63EgoAzgVAEAh3vkSW6W1M?=
 =?us-ascii?Q?q9VZGCqPRZkog5mySTq7LegEZGUCljsqIs4oUFsjwzUc2hKIGvMBXGeCqHvU?=
 =?us-ascii?Q?K8OgROWLSENISlhWcvZY+Wzvw/2kXF0jKXnrwMOFUSryDt0eNz9gX5oE6uUZ?=
 =?us-ascii?Q?toG/SeAfILiXckbqPSFFGUU4x9WOhc+OIWc6exjB9KGHhXD+VNTWR6Yn/C/d?=
 =?us-ascii?Q?CplhKXMDHts6SZ7OKI9QrLq1yP77aJ2nXdxFcbdm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4f1edd-e537-4901-0aa7-08dba00c9258
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 17:00:05.8125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0o+2gJbyhST+cq9VwDvyo+T5XvEexkZw3D6rFvRBWq4vjUG0LXUmoWKga9BMmvntNQ8XkLtI6UVuKWU4kalLKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9660
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



> > When Falcon Mode is enabled, spl_start_uboot() function must be defined=
.
> If this function returns 0 then SPL should start the kernel, if it return=
s 1 then
> U-Boot must be started.
> >
> > When spl_start_uboot() returns 1, then U-Boot must be loaded, and as fa=
r
> as I can tell spl_image->os should be set to IH_OS_U_BOOT before:
> >
> > 	if (os_takes_devicetree(spl_image->os)) {
> > 		ret =3D spl_fit_append_fdt(spl_image, info, sector, &ctx);
> >
> > in common/spl/spl_fit.c/ int spl_load_simple_fit(...)
> >
> > this is not the case currently, and the loading fails. If set manually
> spl_image->os =3D IH_OS_U_BOOT, it works fine.
> >
> > The only place I could see where it could be set is a few lines above i=
n:
> >
> > if (!spl_fit_image_get_os(ctx.fit, node, &spl_image->os))
> > 	debug("Image OS is %s\n", genimg_get_os_name(spl_image->os));
> > else if (!IS_ENABLED(CONFIG_SPL_OS_BOOT))
> > 	spl_image->os =3D IH_OS_U_BOOT;
> >
> > but the second "if" does not execute, obviously (since we are in falcon=
,
> CONFIG_SPL_OS_BOOT is enabled). I see a few options, but I am not sure ho=
w
> best to fix this:
> >
> > 1) add something like:
> > else if (!IS_ENABLED(CONFIG_SPL_OS_BOOT) || spl_start_uboot())
> > 	spl_image->os =3D IH_OS_U_BOOT;
> > but this would mean calling spl_start_uboot() twice, requiring it to re=
turn
> the same value. It works in my case.
> >
> > 2) set spl_image->os to IH_OS_U_BOOT when the spl_start_uboot() is call=
ed
> the first time, in:
> > common/spl/spl_mmc.c/spl_mmc_do_fs_boot(..)    - in several places:
> > #ifdef CONFIG_SPL_FS_FAT
> > 	if (!spl_start_uboot()) {
> > 		err =3D spl_load_image_fat_os(spl_image, bootdev,
> > mmc_get_blk_desc(mmc), ...
> >
> > #ifdef CONFIG_SPL_FS_EXT4
> > 	if (!spl_start_uboot()) {
> > 		err =3D spl_load_image_ext_os(spl_image, bootdev,
> > mmc_get_blk_desc(mmc),
> >
> > ...
> >
> > Any insight on how to proceed? I've implemented spl_start_uboot() to
> decide on whether to boot the kernel or the U-Boot based on key presses o=
n
> the console.
>=20
> Are you talking about the case where we tried to load (or verify) the ker=
nel
> image and that failed, and so should fall back to U-Boot? Or the case whe=
re
> we're going to U-Boot instead of trying the kernel. For the second case t=
here,
> we should be doing the same thing we do in the case of not-falcon mode. I=
n
> the first case however, we might well have a bug or two there and aren't
> falling back to reporting the error and then loading U-Boot just like we =
hadn't
> tried to load the kernel before.
>=20
> --
> Tom

I was referring to the second case: we are in Falcon Mode, but spl_start_ub=
oot() returns 1, so we should load U-Boot instead of the Kernel. However, I=
 found a solution that works with the current implementation: adding the "o=
s" property into the u-boot node from U-Boot FIT image. Then, spl_fit_image=
_get_os(...) sets spl_image->os correctly.
