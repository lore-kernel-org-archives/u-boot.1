Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0291C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 08:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75557832EB;
	Tue, 22 Jul 2025 10:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="I1LeiLHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 379538331C; Tue, 22 Jul 2025 10:41:03 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B47C832C8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 10:41:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=re7jk/pHz8kXUoQgjvXRr8OgPkjRXRJh1m4E1al6rY1QRJhgFuyjuLXf8dW9P60L9Q0mLpBplmlmJ8PeIjWPMT+ZLCZFz/7NMEMPdBT7IqJsJ5lMpl8YkJXiEapE4Oy/BZdyQtlHXLB4fmEoG207dxvp4PkVMLdo+5oN9yjaIdVSH8pi+qNinKieHTP99QCqyygUpyCchkNroalb8dJ42SjZsbvuepOaYW+1uH9UQQ1vOoFPHWciGgsRnIlrsXBM+almKz4hU3b0ds/2in/OWyOC1SfSylhQI/KPYUpIGOrMgUeMvhagg9064Qww1r2dTxTMSiihfG8w0lK7G+ASpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DSZWGA5OoxbUaE4HoBVbjTEsF/aIu8FUvApFuEyjRM=;
 b=HP7FdzfbuadumrsOjkvjGeB51+oJgoYxqQSqUT1DedUKKS1m+GGQoi611K0KUqvYlMQ2HybKklfby7dinkqVBy9XFJ1kRldRYcLbaPuHybCjEa4FQIHYjZULv8H+h6/q8JXMxMsg6D3T02SzRoaB8wFvYb5TfTHexU854U9UZ+GZSKJQMWaqtB0yZftnDx3FlBx66SyJtFJIOUgtNOX9UpPrFKvgkY+PG9JuJXRGV0XgAKmF83NE2jXti0QSKEpxDmbeABDy9gikVgg3CSMyauQv9b9mS5PUFMn0EMoKxB5pSW+rN3XB7zEbhJQaiSW05gI+MPfv2+/EtHHq7pVpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DSZWGA5OoxbUaE4HoBVbjTEsF/aIu8FUvApFuEyjRM=;
 b=I1LeiLHqs+3cLdbbl1nAt9FG1yooYIsIGmHHrKN+itZoM3XA+AQRFxkbI+ZLpGAuYXbo1NYfUBvcECgQRZVCm05joGS7rUxuMaqyq73K5oCroju0E6XhD6Gv/g3HszYEbokaq6M0ojyDyWMjhpPgGAsa55U11lbxjzrVVTFWB+ONPdeiRZHcYmeow6nsh5UyQ3UDgGKGEL/g7GH2xuqpFArzE4V35vlpwQ5rvXPUvFpymosDUk7ByvVsFTiFKwsmvsdyugXRC9DREJMXl4ag3gwjO74XmFfWRyeW13M/UluUbE4ctY1/bM1hFOlrYQA/TWJuPYH4HlTDX15oZuGNCA==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH0PR03MB5970.namprd03.prod.outlook.com (2603:10b6:610:e1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 08:40:59 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%5]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 08:40:58 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Hea, Kok Kiang"
 <kok.kiang.hea@altera.com>, "Ng, Boon Khai" <boon.khai.ng@altera.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v2] configs: socfpga: soc64: agilex5: Enable NAND boot
 with UBI / UBIFS
Thread-Topic: [PATCH v2] configs: socfpga: soc64: agilex5: Enable NAND boot
 with UBI / UBIFS
Thread-Index: AQHb7KpTjhQgeClUkEa9ADI993+TmrQ971Hw
Date: Tue, 22 Jul 2025 08:40:58 +0000
Message-ID: <LV8PR03MB81376284479FF30EF708024CA75CA@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250704060956.10955-1-dinesh.maniyam@altera.com>
In-Reply-To: <20250704060956.10955-1-dinesh.maniyam@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|CH0PR03MB5970:EE_
x-ms-office365-filtering-correlation-id: a3793f6a-d28f-4aee-c3dd-08ddc8fb7b65
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3qd0f903/Oa8KnN8AxfM70Iz/ihBoXFOL/1Y3DJ6GmBTX1TpQIOYEkhmjCxC?=
 =?us-ascii?Q?PPzxzpOaQFYmh2RYrtdGv4B4bhAMFJK4ayxebUwKmOcHRiMldeXHJnoJeEVC?=
 =?us-ascii?Q?Sm5/oz0WIGiJpo8DSmgzfpn77KWVsK+o0vVtdByrnTZsimWJ7weVgfArD9GT?=
 =?us-ascii?Q?85u2nO1kDFoz98YcGXR+UiwEFFmlIDp+mpSDgzgaccus6MvCKgcqwnGpoayi?=
 =?us-ascii?Q?NxKVSYg3km6eIRUnoDCTipHLXcFzVfhxzRX21hBKABvxITVjbKHetlIFv6zL?=
 =?us-ascii?Q?2DARtfiVeUhXC4REbP6v6sR/mnI0hOwB0Lgqpt9fEg+WMPGgqEg95eYPYChB?=
 =?us-ascii?Q?YjbQIrlL7AjxxerArABy60JG87+zKCLay1UniWLtpUV5gnV0L73ZnMa7P6lq?=
 =?us-ascii?Q?Jh5mcjduuy6Z4uChvTLWlsDyLowSimxspDmLBvaEaDHw2iZMx5qKLSCi6Y+d?=
 =?us-ascii?Q?vKbS04pummm6KN9HZiyQ1BPTeORB45LGaR0saG673zL5iwzT73q6o1OeVQvI?=
 =?us-ascii?Q?934c0nS+V7tQ0n9CxG3HU0EkCezKF0WkRZDIFXZiZItno3DzabFelzu3672O?=
 =?us-ascii?Q?HQ4bcYWiOBeQly4MYN1e3nvFBMiL1TGofzCZEYHfLNu5QinhbGPiziMahMi1?=
 =?us-ascii?Q?WJ4Ugpx05Ey215jOQGRtgpa2YMTyJBdaOGsC5WT4NVsEvrwzXwRHIq0I5fzG?=
 =?us-ascii?Q?vnbUhBRtlui8zvyx7Fcujds6Q6AcCErdyVQ2HFOoOGuyEEAV8BuuKcQtXEP0?=
 =?us-ascii?Q?T6JAcBNklqDlXT9Wo5+65H1MCr3it5xVpU6N7PXijvbyybpff0l911i+mPJq?=
 =?us-ascii?Q?maFpBJr72A/eQoXoWUsLqHzKorpgJYn0ghfKR9H66ikEBjRYVRmicRmDN+UC?=
 =?us-ascii?Q?AXweEyzU3ExFfav8P3KPjN0cZZUb1ZfJmz4zmrAiK1V0RxOxM9mXIyVDZnmp?=
 =?us-ascii?Q?C7IdUXhrdd7G8Nxc3EAAsbeCX7UU0tcH1qvi+WG9jRQ+0l2Rf80eCHsqyRNg?=
 =?us-ascii?Q?FEjSVrCkbCr8KbSgRwYlpDCbIGKpP9cJD0gdBPb2sh79yl4Qq7mc3tI4JLo8?=
 =?us-ascii?Q?HNLKkQe8ZLDGf1qb7OOVCV4gT9wRwMBHN36Y0MHU3tu7ejyC7aRWKdS75+fs?=
 =?us-ascii?Q?08OrUQWvI6KZLOa+vVJQ7gWuXF0MyGv+yVtT0R9yMWT5E697RL2QJTvOAhz4?=
 =?us-ascii?Q?+DmJUX0loK693X4qaGbMtjfKjdre95AyGH7JFab2Z59FlbDklKdeVneQ5ygs?=
 =?us-ascii?Q?O2KqTgBh7nrqSUEc4vV1Y9rHHbD6DPN1kqoSJ9Mab1WRkiSjubF2bA1mst4y?=
 =?us-ascii?Q?8N4+nF60eUMr6EXw1m0XxvSHH9WHWDrG2DhQTtXd5iLCxxWJl6XMVkNQ4J5u?=
 =?us-ascii?Q?WsfbVWqO0igHbNiEoX24yl+8KUt/r2lckoOMxknA4kMMvaxLEklIl+Rixh8X?=
 =?us-ascii?Q?4fkgtHvI30FWEXiwY1UJD4nl2Oxyg+rt6O7D9oUomGk+8IzPO5/m/A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4X+SIIqi+u25D82ZUKBV8Jb2fT5VUsa/Rl636vZI7GmpYUTq9CKMmTJU4Qgq?=
 =?us-ascii?Q?AGIHjz8/yzEj5LpdHs717Q6fPJZenSssTzJA8w/FfIKbJPkNITFGiJOnPL+1?=
 =?us-ascii?Q?l7gNz2ZHK12tHWRNs6qAJUruVB+xv8NUBeMbOum/twaVBuMzcBPuYVqB/TVK?=
 =?us-ascii?Q?C3Lrdh9u9S2382SFCsOQIbmg92Nh1RSu+R2CZS7OcEDohDulH4K20DB48Quo?=
 =?us-ascii?Q?KcFRcJWLDhDU1Al65Zx3d4yTr+qxZN9tewHu8ym5xMhkEZQrqN9lVP9c8Q5J?=
 =?us-ascii?Q?Ud83eyx7NJlK19a0Ua6CvOoqZsxJzTlpg4IDxY5gejDvBB4UoCVFVX+8VBg2?=
 =?us-ascii?Q?LH3JuH1Ioala2sukJTTltHUhkTDDi5C246CWHW9btnQS0T6C9c/3cCFfSTh5?=
 =?us-ascii?Q?ivug7y5pLWHBcqVw8TB7fpszlnvQI1yuWQH7ORTAoUgtLJ57FEPBYV5Olt9c?=
 =?us-ascii?Q?TmVPjlx4DJkXM/SumvfQXj4RvDZ0eo9eFwNxCkoC1hgHk2KU2Wt+LpDcUdkC?=
 =?us-ascii?Q?kCb8EJunk7RUVuPXd8RXUQvQ8ub/S4Ch/ifIO16ByzIPJFSs/H6eCfjKzTsR?=
 =?us-ascii?Q?TD0jHIPvDsRF7tMEdeyo9qmqlYhps1JBIcPY9ldWlbkVsKfLaDWM39kD8SdP?=
 =?us-ascii?Q?Xn19HaLrmFoeSO1ki2NnaH+S9BGFsXfIBYibdhP0S96nTs4cMJwn/6UOWxjg?=
 =?us-ascii?Q?8OzoMbrG8ZaPC6jnP3yFovbOLmW60bxuOmEEl0G32zSpr2TJRgQ2pnb7NRKT?=
 =?us-ascii?Q?EOU/TXSxnz4XK3S7PhgH9toXb1o1hjlvb15ZeDqmMj8MlQsuKSiMEyThPNqq?=
 =?us-ascii?Q?UYgf9abIH8KMHPdqdNcJSP3N2DzK7kjcAZgTvA0wXDg962uFkovQ8zjBgtPg?=
 =?us-ascii?Q?FDGYU3HHEM7zF1xoxH8M+12bXN0b3PRSq1NJlqYKWA15IBC0bA9CxKDksbmZ?=
 =?us-ascii?Q?DOKypTS9y2kLSQN4YYxwkNEm4OgN1aP8SEN+9dKNG+NvGed/XQaYWN7RjGrt?=
 =?us-ascii?Q?aZ9egvhmCfdBPuiuPs0GjkV2r4fh09YLmS8N25sjFxNGVXskpWl1WZrKaOrx?=
 =?us-ascii?Q?WX6+hde2eR0n3NtsMRPyo+2uEnXLIEVC8ULx1L4y3PeEdsqAC6KdaL8fxeoo?=
 =?us-ascii?Q?a3F35B5S+RUOEdhEwFGNlqAjxegkr9Q8crK5JNM5uL7tDy7Qsx5BkIfxYtEa?=
 =?us-ascii?Q?ujHvIMG0KvrHsniATepEtzHGDmewzSRHMtrlYRRXoNeKStLI+Y3a26OUPcW9?=
 =?us-ascii?Q?uDsoDMb5DIvrpipTvPMBE0166tiESGGdIzrr5KtfKVbf9gQeCQosuckHXFZW?=
 =?us-ascii?Q?3fDocIjRbLRRlk2W1PaqzOvnBaUyiEwah+scaUMv0z4G4n9nKVDE67YkLI/h?=
 =?us-ascii?Q?Vg/40wnvr9L9it3oIE4VIEP33YBNn30OSKrGRa9KdEqijyZzYl21aZ9biplY?=
 =?us-ascii?Q?Krff0SLnwk6iRSeYp5KvhKiUWrffsAyv/9hsBxMATSfCI8uzoFe9KqweG3CR?=
 =?us-ascii?Q?1SQQmkLfvce6YS3oVpwFDhG5SQJyBh9h8LN5SJI61G4dtsDBLSnsd5j9BeaR?=
 =?us-ascii?Q?jJZ7L0vqX8LcfRLhyzXx1oNR1jjBIXzn7Yk5Jrde?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3793f6a-d28f-4aee-c3dd-08ddc8fb7b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 08:40:58.8994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fm5sX8UERbifzoCruEmZsWzSgnxbbkhG0G7wcP+IMpEJ3ODUFDN1jL5v1+vnR5OYBToyRUSQdjhHqgysqkruL9euuMo4hfF3n6lLHGxIIK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5970
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
> Sent: Friday, July 4, 2025 2:10 PM
> To: u-boot@lists.denx.de
> Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>;
> Simon Glass <sjg@chromium.org>; Tom Rini <trini@konsulko.com>; Chee,
> Tien Fong <tien.fong.chee@altera.com>; Hea, Kok Kiang
> <kok.kiang.hea@altera.com>; Maniyam, Dinesh
> <dinesh.maniyam@altera.com>; Ng, Boon Khai <boon.khai.ng@altera.com>;
> Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>; Lim, Jit Loon
> <jit.loon.lim@altera.com>
> Subject: [PATCH v2] configs: socfpga: soc64: agilex5: Enable NAND boot wi=
th
> UBI / UBIFS
>=20
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Add the required configuration in the U-Boot env to enable Linux NAND boo=
t
> with UBI / UBIFS.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> ---
>=20
> v2->v1
> - remove additional space
> ---
>  include/configs/socfpga_soc64_common.h | 24
> +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/configs/socfpga_soc64_common.h
> b/include/configs/socfpga_soc64_common.h
> index 5ed17671f79..83b600c7fcc 100644
> --- a/include/configs/socfpga_soc64_common.h
> +++ b/include/configs/socfpga_soc64_common.h
> @@ -73,9 +73,31 @@
>  #define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
>  	"qspi "
>=20
> +#if IS_ENABLED(CONFIG_CMD_NAND)
> +#define BOOT_TARGET_DEVICES_NAND(func)	func(NAND, nand, na)
> +#else
> +#define BOOT_TARGET_DEVICES_NAND(func)
> +#endif
> +
> +#define BOOTENV_DEV_NAND(devtypeu, devtypel, instance) \
> +	"bootcmd_nand=3Dubi detach && " \
> +	"setenv mtdids 'nor0=3Dnor0,nand0=3Dnand.0' && " \
> +	"setenv mtdparts
> 'mtdparts=3Dnor0:66m(qspi_uboot),190m(qspi_root);" \
> +	"nand.0:2m(u-boot),500m(root)' && " \
> +	"env select UBI; saveenv && " \
> +	"ubi part root && " \
> +	"ubi readvol ${scriptaddr} script && " \
> +	"echo NAND: Trying to boot script at ${scriptaddr} && " \
> +	"source ${scriptaddr}; " \
> +	"echo NAND: SCRIPT FAILED: continuing...; ubi detach;\0"
> +
> +#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
> +	"nand "
> +
>  #define BOOT_TARGET_DEVICES(func) \
>  	BOOT_TARGET_DEVICES_MMC(func) \
> -	BOOT_TARGET_DEVICES_QSPI(func)
> +	BOOT_TARGET_DEVICES_QSPI(func) \
> +	BOOT_TARGET_DEVICES_NAND(func)
>=20
>  #include <config_distro_bootcmd.h>
>=20
> --
> 2.19.0

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
