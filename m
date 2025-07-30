Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328C2C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 08:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D672682BCD;
	Wed, 30 Jul 2025 10:43:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dbY8g2jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54DDF82E26; Wed, 30 Jul 2025 10:43:12 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D6F882BA1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 10:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N50EV6CF4vpCxgD467iAnOGHwFPmmzdbpgRPmUXE4QG/ksmSRay6xs9b1g7hxZSuJ6tOCgyOym/Ed82T6v1TUlRLma6itumeCl+NluDXJMlULD2TCEwOrK/+k7E+1oSZO7815Lo7oykUhNZiWk+Ei4cLv24KHmuby7IG7SDNLlrzDaxMQPOlko/g2mMW3VZo54e1f1D1G8F2gyAtaKwQJSurKnOOEk/ESsF785oB85v1MKZa+rGNy2ZnuA6l3oF00J/i1XK4uR5hKFj04JZoOQ3jdtuFHX4lOmAVAh55ofTndshz+zXFozNmYG01X1P13IcSEYj693fdSYLxhtQvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCgYaXJSZfM2dEdQXVLvVHOLHMmxGYSsAtkfWIXlA+8=;
 b=h/dUhiBEtfmgxfeEWbRzAu0L+RiQXNxIr5b/OM1ZLb3pPFWD8BHw6PA51N5oiCy3EDBhVSWTmBzpgExQg05bBygCN0GxEpn8Y356aD/XPbfPqxXvqWcLbs91F9nwNl38pPiF5NaHX0AX0vS5I8Huf1Zr+hWVm1rJECpguF8IvJNLBUZbDP6UINHsrHCTOZYNYZN+GImADKQAJb16jCwH5rM+JqTifoxnEf0sarhaH8SMFc9JlN03Foaf9+pZ/+8hQrUcHN8EJXFIMUD15W+czbTwOfOMsv8aterya5HlEYK62G8FhSZAK+5UTlTsImLmxiTI+i8CTIRx2f2Dk4syuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCgYaXJSZfM2dEdQXVLvVHOLHMmxGYSsAtkfWIXlA+8=;
 b=dbY8g2jqugH/ngLWLr1CIlRLGRxzgracL01AO+b+Jcbrrbt8T6OrwaXQac3lk8tvCRO79jRqiq9i/Fo1mlPtCTijo1hSOEc4Pl7j8z84Cu3P9r26UZExBC28VlRrifg2qB+1Gtdqe4Nl75zaWIuX0Gp5GMN/IEH9bbTkSQDDvm8JLpGG122oTNBpBQ3CfjIlNC2aOi2OTle6YcKNA8tZmL2VY8B+OOoiLVL1k03XravVAg8JR3cSjWvX+9cbc1yCt8rBQEHJw2dlMpyyIPPITkQJVU7Syf7aZf9C6THudMvmodV47heHRhdEQX4apOIzgIl3/6IQzl8u2uRj2z6ESQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA0PR03MB5529.namprd03.prod.outlook.com (2603:10b6:806:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 08:43:05 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 08:43:04 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>, "Maniyam, Dinesh" <dinesh.maniyam@intel.com>
Subject: RE: [PATCH v2] socfpga_agilex5: config: Relocate malloc and bss
 address
Thread-Topic: [PATCH v2] socfpga_agilex5: config: Relocate malloc and bss
 address
Thread-Index: AQHb/4fFZaZVsoVON02OUscFRvVMYbRKXM2A
Date: Wed, 30 Jul 2025 08:43:04 +0000
Message-ID: <LV8PR03MB813771A305632F932E9534D2A724A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250728061942.15766-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250728061942.15766-1-dinesh.maniyam@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA0PR03MB5529:EE_
x-ms-office365-filtering-correlation-id: 53ef0fbe-84d1-40a5-51ca-08ddcf451992
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IYAvQA52u9b2vyrLcNSRWDzF/AtHEtHBBXtCpjjXUrHfiTmfp+bQg5AT7hZu?=
 =?us-ascii?Q?wOZM/NiuRf6/TXELkkRARmXCbJQbQEGo0W87/1trPKbkvADya9aIhdZeB4/Q?=
 =?us-ascii?Q?YEOltGasKtcSpHFySjyNBHm3Of2iPEjz2yOt19iat4SF8gRPmpriB9zsbPJa?=
 =?us-ascii?Q?fcTql6evEv+VJxSwa3rqoIdrQatdRXec1qU4WVRLNhPKS6bb1QQGdtAKW3sJ?=
 =?us-ascii?Q?eOxZ7CCQw4di955GN5LHVNBTCNchjKj2ZVszwjKMRAlcexz9ydSCJl4DeZ35?=
 =?us-ascii?Q?e99miggqd5WsCrNl/OKDqvG6ergx6LjVq4rrawcJErteLU1qhM4wkFGBqQTl?=
 =?us-ascii?Q?oQRtN3zXYaVxXkvAzmC7O947wuT0GZxYG8zH3wNZB0eqlQGai+1t/9eCigRt?=
 =?us-ascii?Q?2ej4P+yNt7rPibXwIfZetfY8IL1VatgYatOioyCkz6TGfiaPfSXgkoktHxuo?=
 =?us-ascii?Q?c4lzgSY3L3uTx6YXKzcInJu/Wu2A+edBNMmgvvrhBKg4EgA1ASQmZOuNI2xC?=
 =?us-ascii?Q?DMRdic53JCBgNgp9muFt3z9rjkghMLKFTSKJGlTSt5ul2Awd6a37Nfm5b2AY?=
 =?us-ascii?Q?GdMv4uo8XD0DLRgfW/ejcHPxLzA2qiiAVWA7Ornor7fRV/D+R9z4iu88IKxJ?=
 =?us-ascii?Q?JwcviloD/W/4+3yZSHD8kSf1NieNuETot0jEz+5ob7UkLUiUngkk6pyoicm/?=
 =?us-ascii?Q?MUZrkgCafKk7YH3iRD0PzSL9oAdcrtfGBOIsqKPwTxLq4UrHD3T1hoTImxwy?=
 =?us-ascii?Q?OTai9PXZx493sYD81jav2HX0qRznbDX5z3FSdTONgRMSRA+6LrOV+4J7SvCa?=
 =?us-ascii?Q?g5ftYezOnal/l87pFmcgoFIEDFutWuRLHde8+LS/gHi5yijPUrGGvURZc1cS?=
 =?us-ascii?Q?YTqZTgPUPye1L3tUXprAPCDPnHzgw2UG/O5DDak20enzhqJtZ64dwExR8TsE?=
 =?us-ascii?Q?jSn1T5jmH07IALk+IbLBaRnXkcgVCg30EEU462ngcT+rIfSTKzFQu/RgY7pc?=
 =?us-ascii?Q?+r3vU/fQblJ56q9z7n/WvSDGm8tKctKkKUVEIc81m1grgpQI0wGNVaY4pLtl?=
 =?us-ascii?Q?bpVxzF4qAo51pMjKyymprWlRDSEuNrkCLGSLo5AOfletu7olXXwYLIsTDCTt?=
 =?us-ascii?Q?p4Y+Bs7TfDOP5z5HWv3/x/F8lJEvCW1Isebk9b3TucBNFg7EMWaZ37FwusGA?=
 =?us-ascii?Q?eue0oiI/SQ+KMn51KxXvOn+66Ersi1WDeZjaaAmQWEXgqmlcSdL7UgwLhbN+?=
 =?us-ascii?Q?4sDiaczKWSMI9hwV/GeSaC/o11o2ZxApBDGMck4DY2dDJoJ9zroZ370bfAGZ?=
 =?us-ascii?Q?0wLWEWNa7nvtGArtlTGq0s+qL6ukc/BfVzNIjMkP/msQNyVECDTJdw2yEYb7?=
 =?us-ascii?Q?sBScJdFdsQ329MfVVNB7rqFE1vMLLF38tsKqgy81nzBPu5MnlwxPPOMO8e/L?=
 =?us-ascii?Q?gb5IDE6oXb3ljG+pnqFl6oxigXtwUYpsLTuDQiCivZMR1GE9q57Nfw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eh8JXXWDSdrsI+E61H9FLBUe+ehDdd7D98Hqio8cl5uHl1BiM0WUgAvSKId9?=
 =?us-ascii?Q?VrItmg/0A1UwYO0cJWOv73xpPadgDUnv+Br89JUfSwjS3eGIbxJja7hRp+Cl?=
 =?us-ascii?Q?PSCYH0BSnRH1bZ9gVHORkg8U5GfZe+vYemFtSHlg5NwznwWaFxvKPUvsmhq6?=
 =?us-ascii?Q?dZ3YrJRo+hDAgErpMpdqZZW4399shuydZyNGpS8vH8nnK1SeLyzARoh8+1Tw?=
 =?us-ascii?Q?JeIMMSeOujud+detcUf6P8RNRwv+O8KTy9mYu1/WA/zfp//NfIiifIMo1NL7?=
 =?us-ascii?Q?q51EGp9JPWh3IteNSwZ3leWzG1xhh50GD4mriJKfzyEWGYg9XfWUDf09FbrR?=
 =?us-ascii?Q?Lhu4ecHBbkmPvgNCC3v9pJn6K4IDrtZi/Qoj05Z98S3vackkVMLDh0lPnjo+?=
 =?us-ascii?Q?G4YXOVMPUUv7nzhCCgXh1AfgwhtKINWi6iUO+CotENzmiKWXI9jIrcB5GqAs?=
 =?us-ascii?Q?6RFxD+zvA0rlRUFpL1y5JhML6k562tbBFyPi0Ki9QH5mBRdqMA5OJ2woOM4b?=
 =?us-ascii?Q?PRP6DathDk8CJR5jwz6TYiD/6k4CEWDDmdJUw1GnpMtp1S01/rr6OmMODu9A?=
 =?us-ascii?Q?sZ2QkBhD1W5u/sCcloUVAbvyOHzxWD+c2qdZ8dQUaRKy11U7+Jbg8pR2uxCt?=
 =?us-ascii?Q?ncBV07krdL1CF2YyND31+u6apeHiuA9SdqXAcyInoswhzdojqyuJCSXYEo5w?=
 =?us-ascii?Q?3JdTm/PmAZUnIFZ75kmkiQwF/l+g+NJSzK2+mcXpBRuRqzswQ4/QrgRbqHgq?=
 =?us-ascii?Q?Dcy22WYJx53KKNMqkyQwCQDY0SGwS11IzuKa9QtEWeXf7rGgwNt4zxl9tygQ?=
 =?us-ascii?Q?NJzQzuWOEkK6LD1v5R+s+HhTc142yZ9lPKAMT47bIjiTUd816xPWNywG9WUv?=
 =?us-ascii?Q?BG362e1gnAjIRsrDMMiNOgCfQtOg+6jO52JRxSSdRdwF388qXk/Tk6XJqovI?=
 =?us-ascii?Q?+ZHPz+GBgnIBl4V/WKgtNas7ygQcNjWtEbAS8GLl7MkKOYK8tVeD47YJU/Tj?=
 =?us-ascii?Q?8d56Y9+tVZ8XII+NwR9WJ8N4pfj66B8YL1b8OQk6GxHFr+uTxk+VbvjhJoxJ?=
 =?us-ascii?Q?79LY7kvttFjKGs27TPyJ7TI/gdfokpu8EFBry/1AxaUkzZS3lmUs1ynMdbnG?=
 =?us-ascii?Q?XUjl3VlCVuSgMM+hGkng+r4appi7grUhwVSFLd+fV5UxKwdcd9Pz3G6KNyXz?=
 =?us-ascii?Q?c0SGfnEnjSmasFlP1SFcPyXPOWjDZYpb0OXaqZAORjwaFZoIph3C9RiUjQPm?=
 =?us-ascii?Q?bZ2+f9gnUW2PAl0CkFLknVptVOh8jomKsUHNYbEOLfWyueqnEvvSC9SGOLBN?=
 =?us-ascii?Q?dHkkFbL/WZCtEFVdxhtN0mu+2snPUOjhfEHOfdbaJ5vJj/3ZvrkYtR5Wvxqg?=
 =?us-ascii?Q?xDyORkZEWTP2WEJ8dTF1IbAVRaK7mwIbE5K42VNfU/e+lmiOZKEvfewkbd2d?=
 =?us-ascii?Q?iDDRUTUaJpevSSqH/FNkJJ2JtjFVL6H4mdenAmv2/fToS0jw1nw02wt/AKDw?=
 =?us-ascii?Q?AN77JcpW2OfBP/yWM9qKZwwij2yyy+TyxKRlcGsw50N3tfqbIhOPCzILbU3b?=
 =?us-ascii?Q?XISrv7NVgAcREilai/74diUz3i4f9FXGIlNFfUDL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ef0fbe-84d1-40a5-51ca-08ddcf451992
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 08:43:04.4960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qthVl1vvAzHuBe93xBsvOaCh/mPYdhKDio9n+LuCmDBgKQAplylL4mo9QtMGuNljVCH+Y8u+n8JgOcnHN8FsCRiyS67G7SToceSPNGgi7sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5529
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



> -----Original Message-----
> From: Maniyam, Dinesh <dinesh.maniyam@altera.com>
> Sent: Monday, July 28, 2025 2:20 PM
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Chee,
> Tien Fong <tien.fong.chee@altera.com>; Hea, Kok Kiang
> <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>; Dinesh Maniyam <dinesh.maniyam@intel.com>
> Subject: [PATCH v2] socfpga_agilex5: config: Relocate malloc and bss addr=
ess
>=20
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>=20
> With Inline ECC enabled, the bottom 1/8 of DDR is reserved for ECC parity=
 bits
> and must not be used for general data address allocation. Previously, the=
 SPL
> bss and malloc addresses were allocated inside this ECC parity region if =
the
> DDR size is 1GB.
>=20
> This caused ECC hardware to detect stale or invalid parity bits, leading =
to data
> correction attempts and DMA polling hangs or failures.
>=20
> Fix this by relocating the malloc and bss to the usable 7/8 region of DDR=
 and is
> fully ECC-safe.
>=20
> This change ensures reliable ddr address operation and prevents unintende=
d
> memory corruption.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  configs/socfpga_agilex5_defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index 4ac0a5d9b99..01c5ac88015 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -12,7 +12,7 @@
> CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
>  CONFIG_DM_RESET=3Dy
>  CONFIG_SPL_STACK=3D0x7d000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
> -CONFIG_SPL_BSS_START_ADDR=3D0xbff00000
> +CONFIG_SPL_BSS_START_ADDR=3D0x9ff00000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
>  CONFIG_SYS_LOAD_ADDR=3D0x82000000
>  CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=3Dy
> @@ -42,7 +42,7 @@ CONFIG_HANDOFF=3Dy
>  CONFIG_SPL_HAVE_INIT_STACK=3Dy
>  CONFIG_SPL_SYS_MALLOC=3Dy
>  CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
> -CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0xbfa00000
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x9fa00000
>  CONFIG_SPL_SYS_MALLOC_SIZE=3D0x500000
>  CONFIG_SPL_CACHE=3Dy
>  CONFIG_SPL_MTD=3Dy
> --
> 2.26.2

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

