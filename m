Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4561CA0FE1
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 08:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0076781E13;
	Mon, 25 Aug 2025 10:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="GKUp/2vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 150A882FC7; Mon, 25 Aug 2025 10:00:39 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA99F808AF
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1ZEORjzdILlcmk00EDkib6KXGXZCiERuz6i9ktM/kBB3qj3gexB+pxrzcOQ/+//bXZqdVd6NeHfgaHc5aHDZSaaRZ6/IKFxz7w25oW26ZJLu7sUdO5XrYTvBgrCtld/Z4avy9xKlwVt9FBxL00lIJaq+9Cfv76cn+D+ovLMp3UziM+NWaCcvV17e84wQFuG3qprNLf+rjYEGnD2nw2ApDWu74pzFDH+fQdffwvg+/fVcnf876TXPngJRckUUHeXyGPfuZJAgMOz4ttDykyybFDE1DF85vMTdCQNZh6R0O8hsPHWNgNg0hBCVNj+jGiH6DQP2j9v2yEBHr9yyl0jDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lYw7Kne5GYnzTy7D2nqa0Sv9HZ1zWZIWe41rYMD1vA=;
 b=n5uxA970F+6E//a95GBlq37d0LmIdVN6n1UM+xLzEksnh90uQl2kWnNR7e4hriqz1Tia2iyjBinIjEhPk9kEDD6flaLI8fn+RODPyvDJTe45QRn14/EclDlF3jvyTqo6iLT39qTD3hjwbgVzm7jihJxp9rmaY2YGcIbXJMAdIDXg4xRWxYLAnuHSc7xSUZfPnaG3Ih7jIpThTUKIpULFfGpWOvFdreTmp7qF9lfbt25v7fAHpJp691VdblwpeIPxUs8OK0q5b/RK0pItKretua92vB/tNwLDqWYpBSHQdKrRMMSwtynkqRuwwLe6mbD7pE/5Q2XEUMVCbP6nrvsf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lYw7Kne5GYnzTy7D2nqa0Sv9HZ1zWZIWe41rYMD1vA=;
 b=GKUp/2vyjgZnK83bpOuHbIdShpFuMql3d1errjfI0CZMHtyrC7RA2/VIKulcrzliOdn7EVunsy0MMRGZijM4OEs54C4fMNJFvVXsw6e7PWsLxWfxEWnI7ZvRVORofGvXkzpRD1DTJ2QBY57ZcyHoklZ0SdHWrTRvLv/5yEhOAgn9qNl+DGi85lOFMN+0vAWk/Obah/r/MvjaiNlNQqOLUo8mVenUeE1VLoE9QCcSasz5cNgiELHnquA/MBM9GxSW8DfMwsPApa+KpKqBPkLvTQD/ObgrYGpwnlqjISu1+ylBmhRPPqrD51CJXFN0MWjBPR8vhlMa0dHHtjn3LfQp/g==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB5810.namprd03.prod.outlook.com (2603:10b6:303:6c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 08:00:32 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 08:00:31 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH] configs: socfpga: Remove SYS_BOOTM_LEN from N5X VAB config
Thread-Topic: [PATCH] configs: socfpga: Remove SYS_BOOTM_LEN from N5X VAB
 config
Thread-Index: AQHcEMKXTtuWLb86aUK1RclmsNz+lbRzCxfg
Date: Mon, 25 Aug 2025 08:00:31 +0000
Message-ID: <LV8PR03MB81371910607AA9C0628585AEA73EA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250819043440.6126-1-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250819043440.6126-1-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CO1PR03MB5810:EE_
x-ms-office365-filtering-correlation-id: 8ef659ae-2831-4152-2d4e-08dde3ad7676
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yHNjPFgn1WlXFuI7CtzwnHfvIIe6/wV2FI5poWVdB7bP+pndosa9lqV/K7hY?=
 =?us-ascii?Q?18X7FJyT+kgX17SLewPv7MwwgxXC/H8ezxFPZW4qHygOuVsuJRP92w9qFDNo?=
 =?us-ascii?Q?jva6lLUqW3DGme021F4c0c9hyrfuLu+uYQpFXtOcqQ/iBXySKvoC4BegUQ0k?=
 =?us-ascii?Q?dAwhf4Jxj3YGzUJxaKvAD30S/BZWTi7T3OgEHVbsGcKn0Y4Oucj26e+IXSAu?=
 =?us-ascii?Q?clHrPcgPj0Pv+AjvsEvSHSeJF0PV2WNcV1DMb5Bsf+U4xd+BA15Qm2lDCu7w?=
 =?us-ascii?Q?oKBJDoU/twrSqxcShTNVHxhV1G524OMxRO9hatH/HB0ni64aw5fgxROfvRvc?=
 =?us-ascii?Q?k7PXm6CV2cemcxYNpzR2wLuvlccq2+bvqZox5fMtk65OosJu24zxw8ZAgEgl?=
 =?us-ascii?Q?1OAtVOoLCVqhXv3+iedMcxdiiTNz/C7a1Qg8cKEEU1x2nYoSw4AxUm7HoTbe?=
 =?us-ascii?Q?hCNfPEWyXdBSGfI+I3dm/4iX3oiS6ha0lq3NwcoB/q97/2jLyMfeEfGbEbV7?=
 =?us-ascii?Q?DliiZqpM4tBmHUFBM/KCim51f9JmI+i39YV0rXV9l4sL/XfKbJ5fx6cQ86Wg?=
 =?us-ascii?Q?FO476zLLxYQmILOO5pNdUwa4q7JFH5a4jfEXznzz06f+eNxVdA9fbANSCa0j?=
 =?us-ascii?Q?k2TVDTmOIHps0kfzqrf231+Ts1KRZk3Two8nBEiiZaisbOASzMu7x1j6m4tx?=
 =?us-ascii?Q?vwxvjJqXDRbs3g9U5ncR/wcXRVf92dU39YA7+mRt3N/VfjHTexrGEaUkXns5?=
 =?us-ascii?Q?2Kj4a7bl5Vh75SQxc+3KQdAssmBlQlVGqu3o6Nhqpls6Byt16dQbkeH7uHGL?=
 =?us-ascii?Q?F+3TkH0b3hX+qZouFRbCT6jdf8q9JIXhPmbu53K4FCSAJjhoYqU5DwkxXNRj?=
 =?us-ascii?Q?M/jxrJXapmW9pLheFcfB/nzhl4rgszZ5HKep0J3AojgljIEd6XzuYEr9jANa?=
 =?us-ascii?Q?DPIGW9R6ZrKf6TO32pYfTYlzXkOCs8ihMCe6kdGwJduleFStDDPJYG90NnmL?=
 =?us-ascii?Q?SLauOe2iAMJ/c23zri6SvGAICTeJNIr4Soio603DHiSH6Vs2B+UDPyHnVb6l?=
 =?us-ascii?Q?2rWYj+vwgh1ncL67sKTvFyQE0U+A5FTW8UF+WPlPinW7ZKEpNJyPXJySSJBr?=
 =?us-ascii?Q?kx5QxdXlYzIMAZy1vvHGEOoGfC0cHNKcvk106Rc7v3+N7nsP/4WLhrxKBL3t?=
 =?us-ascii?Q?Zc9US0VykIs7lStnXnpXSEUbW08odzc/viDRobZBVsjYfU1BtJ+C9Qlk924Y?=
 =?us-ascii?Q?phGUjb9H5TAdqB0Oq/hFhVJAuUJsYIQSbJ99R4rYsxVUUKIBYNlLeLdjOR0f?=
 =?us-ascii?Q?F9EHZujniIOmtoXrKpp3k8vRVD3as5DGYsWz6qChpqn7WuSx+ubdqhlGNWH4?=
 =?us-ascii?Q?CAMURvZipKUwYTPNYYjXBFbPLV4dUw+lhW364jwELkulT3AF8rMYwT+robDw?=
 =?us-ascii?Q?hhiYN0B6WtqfdQZ9U8A7do+fLGMwBMm0zO9ioCCBT4cdfL3OrS0l4w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmshjS6J73n7zfr5mtxjQ9zE0vPjsvK255XGJdOIxOa0MpqGf0G8mg48cM5e?=
 =?us-ascii?Q?1fI+JEvBDvFktZVZvFIo2O15btn0n+7w/MyoaoDpCvqDh3Y53KgoDLJev2XR?=
 =?us-ascii?Q?S5s727P9t6+hDBFY/KVw3EKJgSkreD9/qyalxO/1zssBNDI9Nx+Dva+ILlbq?=
 =?us-ascii?Q?8SZYWs0K1drMEYLPJpXN5fb8uP/M1yyWNZM4kgQGddKjsDtAMZb0al9fu84/?=
 =?us-ascii?Q?MkJaG/P+kClUGxm7kwtsOrZF2FUvCQdJmZlGk3NUmJaHjwK+vQ1AZU5ZJhgD?=
 =?us-ascii?Q?sfqcbHsgoFc/BnuIxjejU9vHn8y77ESF+vAcDnxEgfP1oQqWUijfxRyvQtsO?=
 =?us-ascii?Q?ILeju6HMDofknE54hXEGbUEQ7UfckrOEi9ENxHdy0c3xwOSLK0nj1TqYxrxc?=
 =?us-ascii?Q?wcjpl9Ga5bucWrXlZcaQWFCcC+EeHrDvbf/xrDL90S0YHUdou1mWLtFYHBqc?=
 =?us-ascii?Q?CBeEa6mfuLrr9VMnzOypSdDn3z5QgwGAY3QuMNJgYDdvhENS22KhPxRt/TCM?=
 =?us-ascii?Q?B8WYXotkThvFJ94fn5rZdyxklb3WYLUdroyYd7TE4iaF3vSEHq8QsLWc3aFr?=
 =?us-ascii?Q?hxHoe6RMoMoZkTpkbVsIPhZQ7uUEe+5CXwSkIOfNOTZFcpNfR0y7a+fXWstP?=
 =?us-ascii?Q?C6jMQR6Th5IE5YIy6IUjzJshpDL4m+JyCXgT4evVXHgU4zJBvcVKZmHX1Xv2?=
 =?us-ascii?Q?jJUAdV7L8SDDNBBgsAWdo93TSRyoj9AApF1UZELXXZT5lTSr/04d12RarbPA?=
 =?us-ascii?Q?J5sghW+xbOnjo7xPFCsTuo/f+T6YuqKUoTgVQCvl3rAS+aiLAjfwbbIACZOQ?=
 =?us-ascii?Q?FCdu5Ash2dDq8FbBAznpsZdOG22P/ZSAwN6olIpneBsvI92N1y5r4xxEymrT?=
 =?us-ascii?Q?qSvSzJ6ECuRUuCjYv+J1DnI7M9oRlHW4xl526yi4ZJzEjk/KM3/RNBs7ri0e?=
 =?us-ascii?Q?1nlx++K/y20I7Ukq4axD6aJfEb3rbOF+Ne33rpmBJ8wVmabCnwIozGvSwhbI?=
 =?us-ascii?Q?TSQlL02V8NDKc15jRzA74uGniWW6HQ5wzj1uMzGJXZWlAJsIkIr+rg7mIXPD?=
 =?us-ascii?Q?jYcsY5KbrG/dd8OSIBUApRy0Uzw3a3KZIE+6OCENpw6K30YVf74VgTPqN1vu?=
 =?us-ascii?Q?rHVV75puUYuETwuKOpe3jwLXBylYr3VMGZIaqjvp7yhm/bMitBlBajyx3lnz?=
 =?us-ascii?Q?HwLbFl7TBDTvBfVigrbvH4QarxyL03ks8ehzeqU7qUkTbbNMESygvkrE14Kb?=
 =?us-ascii?Q?t1RzOHPwyvEc2yP1YIewcgKWw0ZexDCHWJJWz9qPN0pJd7B3e5xEEt7P6cR3?=
 =?us-ascii?Q?j/9PUol/3a5t5OuU9cXD13Xp1Q4GJ9+4YsugOpt3Mew4Ttd8eCsgTM+xqYf2?=
 =?us-ascii?Q?/U4cuYP2sPnzduo3+0+rgxjj0Q0ZVIuYRmBVp60VhlmLt4Gz4f0xmc5VmGJN?=
 =?us-ascii?Q?r4pUE979s3Ft9mJRvS2W8+f8d7FChp3dMnY8ZCvjE5g/WiVrgIEtVMAGaBFy?=
 =?us-ascii?Q?wNiheWkux+w6Pu/2d/I7lVMJkpcUOLZPR2uIl+YF0mdVdNR+7RaUV0IyEjlr?=
 =?us-ascii?Q?GOIbPSH7R7GIdCqYwliDsrtYdZkXlHbvODZbGtw6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef659ae-2831-4152-2d4e-08dde3ad7676
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:00:31.2391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZ9whvnEYoMqTAI869zeoa4S1ygSxDMvSoVWefJSfaxOAh8wEc/ecPDyD1jFucy1oEihS4kvqIscOINYyuVVkroB/uIMPqIXYLb6usa7Hco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5810
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
> Sent: Tuesday, August 19, 2025 12:35 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH] configs: socfpga: Remove SYS_BOOTM_LEN from N5X VAB
> config
>=20
> Remove the current CONFIG_SYS_BOOTM_LEN in N5X VAB defconfig.
> Previously, the size was set to 32MB, but due to larger kernel image, 64M=
B
> size is required. This 64MB configuration has been set as default in the
> Kconfig.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  configs/socfpga_n5x_vab_defconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/configs/socfpga_n5x_vab_defconfig
> b/configs/socfpga_n5x_vab_defconfig
> index c0dc8558153..92cd0fa6add 100644
> --- a/configs/socfpga_n5x_vab_defconfig
> +++ b/configs/socfpga_n5x_vab_defconfig
> @@ -18,7 +18,6 @@ CONFIG_SPL_TEXT_BASE=3D0xFFE00000
> CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
>  CONFIG_SPL_BSS_START_ADDR=3D0x3ff00000
>  CONFIG_SPL_BSS_MAX_SIZE=3D0x100000
> -CONFIG_SYS_BOOTM_LEN=3D0x2000000
>  CONFIG_SOCFPGA_SECURE_VAB_AUTH=3Dy
>  CONFIG_TARGET_SOCFPGA_N5X_SOCDK=3Dy
>  CONFIG_IDENT_STRING=3D"socfpga_n5x"
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

