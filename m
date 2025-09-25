Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DA4CAC5A5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 02:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF2C483678;
	Thu, 25 Sep 2025 04:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="SZ67T/b/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8383C836AC; Thu, 25 Sep 2025 04:39:24 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A65680819
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 04:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzWuNr55eEfsUQqkSyioYZId48GuEnugu9ybElDLwQSIgix/xVqMYogyiaXFU9iYjXUER3H0OHhSuR/YD8mHU8/qkJ5x/tomqI7936gTUo0mD9vB61MYdxEhocEVPCxjBZkXogn16ELKRnzRWH+3e+ni6Brb+WMJokodJyyVfYlatgyjDLgTfTOjgY9K93QaHEEGx47KIUuCq2oWXXdIZkehwUd3R0NZq09jYu1mz+6LFLyqrq/Cprpcg7wSDbI6q30H95oOTd07XLAUfK3apf9q4+XOctCHHNFfRl96S7WyBCO/aIn3UBM77r2XKkkcQek6oI0QZHpVHr6McUXhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAtHN+RtMZlDEDNG0VpPrHqJVGm8TbPAFPW+2je2W8Y=;
 b=JV8xm/T1MOkS9ZqGt0tROgAATBkZhlVmHlh7jV7DGbPmrcbolp9uUZKPBY2Zlr5nfXMW/wLo2afsB575rWz7r6XnhsfNAFI1NaP9s8edd9OV8bOpjQELoR4i3d/DcXXGhwT2inJWJ3vMUV2tcqjs7++o3Qez80VT3a/Jp5/lKhk0/8MIAhNKEd5J0s5veMV8bzJzFKiYqygeOhuNhsa6MXWxsivBYu3CDibPDR9das3CKthGRXjS4d9MnCpdsyGEOEw0/grMoYX6UuWHGEvaFJcYNOvYhwXqVF50oVCJKCpLNwqzF1TF41Ci0LkDAZWBo1WOgJAgrXGDj+iuq2dZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAtHN+RtMZlDEDNG0VpPrHqJVGm8TbPAFPW+2je2W8Y=;
 b=SZ67T/b/R2WsdLrbwkwzJsCFA7bGWyMRPBEzaFgUniihf1JSBJ9bx8wL1yBgFLxYrxmxSmFHApOJe9bhYzMEF69WGOdfLT4ylqYIdCBvrWAEdj2xu6IFqyz/mWFuU28b9nBKPKdCQZQH8PC3Zrg9x8AFpQuaXxBrWfimGtC2kQKvsWl8yeurG3v1jTSFKvdIsBGrFRMYp8JHG0lA3gBtlcCDZQcgpLA9+Qi2E+W/MQSk6oU67z2dpDpFtp5jkkqf6SirJMjG5UeegJwVWtAQHMoMlJA1489wn/w1ZTecfnpx2alRN139RdBWxXCPZg9OkCEvDJdBdeq/7xlmmOH6EQ==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ2PR03MB7497.namprd03.prod.outlook.com (2603:10b6:a03:566::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 02:39:19 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 02:39:19 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v4 3/4] configs: Increase USB Hub debounce timeout in
 Agilex5
Thread-Topic: [PATCH v4 3/4] configs: Increase USB Hub debounce timeout in
 Agilex5
Thread-Index: AQHcLSfaop43XzEo2UqT9pxRyx4IObSjMMyg
Date: Thu, 25 Sep 2025 02:39:19 +0000
Message-ID: <LV8PR03MB81373797229C849311013A74A71FA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250924074911.15538-1-nareshkumar.ravulapalli@altera.com>
 <20250924074911.15538-4-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250924074911.15538-4-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SJ2PR03MB7497:EE_
x-ms-office365-filtering-correlation-id: 102356d8-45f8-428e-0bbd-08ddfbdcba65
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?f2bBeBvWjsry2TNw9DVw8JnPdVPiV2vl7XpSuz+7DsTjRRnRynXjUbR2zywx?=
 =?us-ascii?Q?Nxvj2fvFBX31+D7IVR/HTFkR5jofbL/74V1dy2Z1/y2+6E9rqnGrTKHolZUH?=
 =?us-ascii?Q?iUSRR8Lfvl3ozBMmdxMpVP4AZnkg2VQ0Q9uMn1XEh5gRKXFuzIjXohIIcFxn?=
 =?us-ascii?Q?VKX2GWLn3zP0ZSxK7sU9wdUkYTDD17UhiCz/EKHDMA+8erZcL1CwH7rQdEgW?=
 =?us-ascii?Q?AUE/edxGUgEenE0xEjiIrLHvPheUxFqvzRPrO2+h9Cab30J2sS8xR+mtfGAV?=
 =?us-ascii?Q?jSG/1iFFDvtC9DpON9OY7H9YufQmEMTxbYbZyhECcKvW7RuSkeoLiAdMzBSv?=
 =?us-ascii?Q?lMeRxFS27QLEwY2JFgsHR0CojjTx8Oz20QbLgTsCS6GMJX6nag2LiCYjtKQ/?=
 =?us-ascii?Q?g2fuKhHjEz6P3ZfmSdhAsGuLRyXeWVzuiu4ndw2/1xoc0zEDjU0mkW1geC8K?=
 =?us-ascii?Q?O129qZYR/qpCw5nrC+yB2En9jCW+Fd0wMHrorJhcMlDtuPjIBXzvDxOrQ5wo?=
 =?us-ascii?Q?UytTV8askt5jTUSBYKQqbvCNtLCIsNhCrQWQ4PJ/klciTEhNdaPBhgcarYNH?=
 =?us-ascii?Q?76ZAeInvSM4iMXPKW4afKqHsZw9FYk0kPRfrk03oplPU1ZU1CDc5SiSADgUB?=
 =?us-ascii?Q?3fHhcrosS+OAPlIs7J5grFz6BdwmWcEBDl8Z1cEFVqgJFHUE4e5YHpLLD1gr?=
 =?us-ascii?Q?k4nLdaXfgmxseFB5P9xKXYCSb2lted4eOHcpa2mOuE14N3DS/SSDv+Jd9O6o?=
 =?us-ascii?Q?66RiGpdKBpi/3caAfn457y5TTBTWbjtq/zxD5Miw/p28m+3Irq+GlBwUJ3Jx?=
 =?us-ascii?Q?8SMbCTF0cnRVDsrEigdLx4iypQSRMLChxDzohuNJhc2NrnOyag4GpZNaXGv+?=
 =?us-ascii?Q?TxAgLWkf1xIdtjwEkDHi5nesJTqpkur4YL1vrqjrEYC7emNWBELpxfrTjCHJ?=
 =?us-ascii?Q?sv4fp/LjJFCQOh+Xhwd/T9F4daKXaVoqQmGwzHHpgkgT5cq02A5mAExWe0VK?=
 =?us-ascii?Q?Mg3aI3ZLG1gC35VcwAeCvZdOLMDZZGRs4YbUggpG23Q09lSMf2KEY6ufBOUO?=
 =?us-ascii?Q?yQt22dw1pQ2jI4HPjWoMOhX7uAkw6jXDUpKN+OeO6EMvmFQgTfKx+/aR5IoK?=
 =?us-ascii?Q?PtgXLhVzI7PMcbRYKar9TKzPBn4TR6XNzP5O+ZwQFh0JoVL7YRYIa3D0K856?=
 =?us-ascii?Q?wDNCTNscgA5NUKwu5FKenNCcKrhbXEdHK1AXnDjzdEAjQHDEwGJvo1kfqCpb?=
 =?us-ascii?Q?Cl9nkN0rlLV7Fh83Qq9heWBWkaQweTFrS4nFNJXfMGcAr724rRJ3pMVUZ+ik?=
 =?us-ascii?Q?nmuJ/oZ4YImbm3d+jzsv33CNo8frpNQ9s8yjm1SZZ9tsSQwdtte2Lh5go038?=
 =?us-ascii?Q?3X2X3iUPfq7Xqt3vOydKwqqW5MT4x5v/XdDEOGyAu5KVBKPDnLZjKabsCWU/?=
 =?us-ascii?Q?aJriJILEJdZgGu+v30QhMaso9T2/wjPj6dBhPZoIHMQlS09+v06aJQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OX62GcPjwiBZxos0Mlqc2ptjnofgKDBIBaZN0ayoGTynXdgahSOmstzSYyFH?=
 =?us-ascii?Q?dcW6ITpczRZzlO8idou3hKr7Bao0PltOMN49laxRpBuc5yGcRylx8H/YM4+L?=
 =?us-ascii?Q?dQtIZ3zTi+tEqd4YtRf2pKWWM27f66Sas1tSmJAflNOSdJ53Xpb30k5WaRs9?=
 =?us-ascii?Q?90hzGh40Ls+ebDB8gL06WVBevM3oIRtcaDfreRRXEqZd6c5MpM8nJVlNGR31?=
 =?us-ascii?Q?55geI+g6UYd4ly/LweQR8hXjYSp601CmGuHHERoRaGa2xVlJdZsetRZLm2IK?=
 =?us-ascii?Q?K7DRbx0WfgVVS6eDW8TNpfLLgkP2iA4WDZ7lJKGyyP9+nB8QL8QWdfbH6GfQ?=
 =?us-ascii?Q?vjaRh1fMd6b6CCxD40SXJHXXhB9TG9t8v3DAAXv5xpo0Iwl+IWnTexuCZfUF?=
 =?us-ascii?Q?JdptkiktHzoVuCopruRLQzad+3M3wTjzYtI3E2+rLoYZ/7b7zMSbTC9MkLZM?=
 =?us-ascii?Q?7h80oYgUAiz763SHv0thgQDvglgm+ZlsNqu212MlCO3lzHL6nrFM81GKqfdZ?=
 =?us-ascii?Q?h53J2d5CLFlks55IUVo4X6/Mv0hm+XtdgUGV6G6/TqjF8u9YytPfgSzZy9yY?=
 =?us-ascii?Q?gCncxBXxdl8QnErbrbDYjZ9sctVE4nWPqW6vCvha/3L81GGiPNAT2MjnyDbv?=
 =?us-ascii?Q?hVJ8TlN1oQX2/N3iLmBwIPZUOAdn/gbGIDjkjv+PWdtdHiijSq+ogxAOdktu?=
 =?us-ascii?Q?UC/9WMlROwjeQvRsspcJHZo4jErH8y3+uGCNIMJVifeampi06i+VW6jtWG2/?=
 =?us-ascii?Q?UahSYx3aIZbpRCisGVJiWq11m2uMsYAhlA1eqx/VO6njZVxotqqkOSasyrcP?=
 =?us-ascii?Q?DxLzHzVpUfzl6DXyIZK/iJobGiwgSAwjIngcxgs5xfxaS3nJdeVE1zou8jXD?=
 =?us-ascii?Q?58jqSwMr4fgLdk2wKCZ9tTOadKrwhBOT6n17KVEt+Uu/An1NfQChVDqI2CO0?=
 =?us-ascii?Q?ayfpQY58HRSdkNpEb7T02K0CEU3Bauf6m4tR4SwgIbMj4HtySKtR4ZQ/c7qQ?=
 =?us-ascii?Q?gJVsU3fXsFNPXMRvpM5NoGgRn8QFgGBceYinaxnaJ/X09arjJ5fT6Ck876CL?=
 =?us-ascii?Q?83H/mq35hjl6fsRtS5JdRl5eG8mAXlGEwDWPJVBF9neqYj96A2Fv6isMuFCh?=
 =?us-ascii?Q?zH73J0UhzOkerKlp7/OQyM9xYK2S3Vy2yNI7JWyV925C2ipS8p0gyy6ctvIs?=
 =?us-ascii?Q?OdMTzpRqlaekOPnE9TAFqd10FCYtMOv8AiSOS84hiPSuUe4vFpDwPAczGbD5?=
 =?us-ascii?Q?NtHxg3kxhhoIGdq+tNEnFblAy3guVqTlR7c1vbOocC2dcniA8gUFYVHhbCnd?=
 =?us-ascii?Q?FupceX+mQMP7tyZduCcz13WswniofC85SLrY5dQuDjMTYKDgAOUCW/hJ+Amn?=
 =?us-ascii?Q?8gxnPQNb8qBVoHMA3+PILlk3QFfgf+dfJKy03qusqYqPF8EbibgGSYH8RNW3?=
 =?us-ascii?Q?BJ7l/RIPWjxlUVcwKp8YwDGn5iELASQGrWygvDh1flgCoA/usERIzQS/CytM?=
 =?us-ascii?Q?XvlS1z8nerkHKzYwESnDzm+Lw0u+stWUJQ42V8dYbQnT+H30om402DxAsa43?=
 =?us-ascii?Q?Enggit9HdwWu2+hO3FXpAZ1mVf9H4Ci23NToAoVG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102356d8-45f8-428e-0bbd-08ddfbdcba65
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 02:39:19.4663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqT7CvMK67cwaOzrQeoSpQVn0I5tU3n/6RBl2DXIBIJaG67w+YWy1Fx8FOImitRyZBnD52H196PxRN22ZsA+EsgtGv/tUDGHWek7QrJcv70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7497
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Wednesday, 24 September, 2025 3:49 PM
> To: u-boot@lists.denx.de
> Cc: Chee, Tien Fong <tien.fong.chee@altera.com>; Marek Vasut
> <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Tom Rini <trini@konsulko.com>;
> Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH v4 3/4] configs: Increase USB Hub debounce timeout in Agi=
lex5
>=20
> Some legacy USB mass storage devices during connection were observed to
> have debounce issues. Hence, increasing the default USB Hub debounce
> timeout value to handle this issue for devices connected to Agilex5 board=
s.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.c=
om>
> ---
>  configs/socfpga_agilex5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configs/socfpga_agilex5_defconfig
> b/configs/socfpga_agilex5_defconfig
> index 7cd2fcbf4ac..69be3bf79d0 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -104,6 +104,7 @@ CONFIG_USB_XHCI_HCD=3Dy
> CONFIG_USB_XHCI_DWC3=3Dy  CONFIG_USB_DWC2=3Dy  CONFIG_USB_DWC3=3Dy
> +CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=3D3000
>  CONFIG_DESIGNWARE_WATCHDOG=3Dy
>  CONFIG_WDT=3Dy
>  # CONFIG_SPL_USE_TINY_PRINTF is not set
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

