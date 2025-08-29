Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B568BC8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 05:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229BA83487;
	Fri, 29 Aug 2025 07:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="pJhjp2wz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE3A9834AD; Fri, 29 Aug 2025 07:19:54 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E15583443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebxY0ShVTKLZ7Lpnk+LlNx2+rbAd67JcJ4/E2vhmrD/tlVM9rGT/a1PwWbyX9ijVmMefg8Wb/jl3zCWzdzbEcLcYfjCFng+hlpALFWHV2/5U4e6+K5WgPPASlUDuHwQQxxfe/uYNBAUKU89n8XAIJa682s2z06Po6NmTerlLscK1D6x+RbA3PIhn+y0WV6G0EpT/i6sii9dIic9qCVsxKGjnq0cyiUAYgKxPgzhCPw6TwN6Is9yN7KPIa1SPZtT3P+FFmR3yz+b/HJQThYEM5LWyvPcYoNhzwnEN/J8T3sgyQJyEhVfh7N86BqJQmKnwxXxcx2aJBDceZTWSw6WaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afxYYII/pIOXrIOxJ4ChxZdDIMrSRapmnCnq8g1cCrw=;
 b=r2VnLe4vB+Jn1yAi+SRv2en17opL6paC6FVz9xvAFiL5d0UrxhtJSZyW6nrI/MOwo+X+1wovlfS+acEL1tpzOjmbBuZQLVAqoCsjIrVg4NfHN+HDQXQgd0dCQRwrNPpiYBeSpgoBKJMvo4pfKNwDFy741/irZNIraMepbnuyGnP5TfjrLqsaNJRAjL7MXfxXCIl6PqNYKhLvwgUJ4OQ7tEzIoFyns6xs4PL9EUUPQFxSp0IpD/ZUjXlnYNDRQOrXCewFcYXwxjPAsb0mLLHkIOjF9fEdefNsXDZaOgUWlS8v/Y+qBG74qP1rmtwtPSmdDzjBvTJNgFNrEwYv45y3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afxYYII/pIOXrIOxJ4ChxZdDIMrSRapmnCnq8g1cCrw=;
 b=pJhjp2wzUeFk0/zoZGXrIhho3bC5BdG4PCo6XTRsIr6WvPeo8z1iCm8Q3EqnCETG0ZwJRhSs5T6Fg5fuZOHXhHMDKyA+br6b0EESbpS5l+WTuN+f4wt5rpDYJdXYd7/XnVDZSb0tZPVun4Z4VMlGQUcQX8C0tQTz08mB/1l9T2K0MnyUfTSOr8dCEZKGKg+8uBM8r/P4TGUd2F8uD9PGSvg0Lobr/wPjb5LdEFFGXKCBgCGiyhIflSap56UVqF163xt/2WgyIJOmWhB71jYBin5t/XbuVk0SR67+YHqBAl1zw0zYVkByl9lPo6VYGR4xgTXg14oLNBFS87U1CckU0g==
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SJ0PR03MB6534.namprd03.prod.outlook.com (2603:10b6:a03:38e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Fri, 29 Aug
 2025 05:19:47 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::7b6d:7517:b2b0:bca0%7]) with mapi id 15.20.9094.006; Fri, 29 Aug 2025
 05:19:47 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v1] arm: socfpga: Define Use FPGA switch handoff section
 size for Agilex5
Thread-Topic: [PATCH v1] arm: socfpga: Define Use FPGA switch handoff section
 size for Agilex5
Thread-Index: AQHcGJcLzEhFuTnWjU6eAGKyZiE/YLR5F83Q
Date: Fri, 29 Aug 2025 05:19:47 +0000
Message-ID: <CY1PR03MB8121EB69C40D832EE6E36D8DA73AA@CY1PR03MB8121.namprd03.prod.outlook.com>
References: <20250829034259.27848-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20250829034259.27848-1-alif.zakuan.yuslaimi@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY1PR03MB8121:EE_|SJ0PR03MB6534:EE_
x-ms-office365-filtering-correlation-id: 2c82706d-a8a9-44b6-a09f-08dde6bbac1d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?YzGQKhTX7GWYF0l7JTMpxsR76Kyt6G3s+87LX/5mEzuidUdhuD4adTEFLZiM?=
 =?us-ascii?Q?PbHCXoAeby+26wqzoVGK59eh+35p94U3zNgpfHPT6POygRGSq1i/tnZOxNxY?=
 =?us-ascii?Q?qD5Yoz8fJERWAG0cF/vN+3SPLxsPQrxI6XC3/T1trC0wtTbk1zT0NnMb0PMI?=
 =?us-ascii?Q?0bIjGJkDiZp6Q5pFS9daZaaY41cLe0wqaEU8UdbVuHjhXhK8/KR98aL+LIpq?=
 =?us-ascii?Q?QSRuoTb+JEmumiX9TJGgDQuMF+O9RVINUjnv3ajbdWNp3qm9tJyDFEIrRehn?=
 =?us-ascii?Q?FPc4wI7JU+LOKiHnl2a+UtFgqMI6PVUaD1B99eYfaas84ncypECsucNTchkH?=
 =?us-ascii?Q?Lp92tH35/PwJwr5UST3NbNYWzrPx8Q2VS8BxyBS0FPQN8sLqCGhXyh2qsrtA?=
 =?us-ascii?Q?BBmr0k/DGyi+GeQSFt3U+LPDi93IrBQ/Gi/m1BxlOQEUGlwdAfqnqct5aqLQ?=
 =?us-ascii?Q?OZGsO31sjezgZ6FF99KYcvFa7RN4LTGX+1L66ir8QaNP0Yc1k00n8IHt0P7j?=
 =?us-ascii?Q?WNqupMkqmwsaF45UXsAdcMgj7t7hgB1K7RuiRGZfuxqDDvSVvycNs66yS7J0?=
 =?us-ascii?Q?QByEV0RBnkedx4BHe1EAu6c1qFxIf15LuroHKkMlgdnFVdfUzmPZxZl5XuMH?=
 =?us-ascii?Q?p7rNYP3L+kui2e1SOb3v1EMQNnb/RY8faBGZrkRuIyBJ4+YPWiXw5vFbbUsm?=
 =?us-ascii?Q?KV6vng5Lcr9qO4zYAGgyw3DFeD8r6PsY1GNCtMBjZmZINK5KfPNY8eEMoQL3?=
 =?us-ascii?Q?A/I6ecNREiFiYphXuvAqKLZiqlqDUsntaaqYu/8dTrT4WpB7d8Yj3SQDVZci?=
 =?us-ascii?Q?K4DAkccJLe1QWNCiXA6d7L5bM9UtHeY3TrtzKGVKmqDjo8qAuXlHtXe62w6z?=
 =?us-ascii?Q?4shpUOW/D2evqc6yGLHHuMUvFXI0wkrQcWOZ6VRzpB4GP+h4Bcgj3jFOKtqb?=
 =?us-ascii?Q?8pg1vLEFEenBAqIU1JVG8ze7JAa1/Hccs/ygg+SfJ+seO6hwQSkpSknypofg?=
 =?us-ascii?Q?+G2LRIg6lVrAcGXa7oUvFt0DSVW9OJrwcgnNbcUuF9fETH+pgMzz/48zS0TL?=
 =?us-ascii?Q?hVFE1up8fOoSueSF0AsQpFXTX0f9E3egjIlyEefkg25/rZO2lrX4bZQ7GlU+?=
 =?us-ascii?Q?BZd38BtSI6GzWOizbVmEYeKVwLw2fQIxJJmCm8Ynp2DbuupcsyjaKLoK2KxA?=
 =?us-ascii?Q?qgdKQXzxppJZ0vYSdgN8fhNhTpHizhssOdM3D09R3Cq1Zd0mPE7VYwERzZHB?=
 =?us-ascii?Q?jsbjbsBksNxt05kutuDrX99aYue/e4VXEhXDqkK3RLtt+w7aZeEk5+NvaR+q?=
 =?us-ascii?Q?MG+tG/5ISjQSViQiWbcbCn4/d1IowJi8xCVIaUTylZdmQpAR09HIvLf4nGEU?=
 =?us-ascii?Q?sBucDp2ZJgCMKA6IuyNDXp+hUuU8L5D4tjlPXW42VYYS+FPxzfI0UaRQZx6b?=
 =?us-ascii?Q?oowo2uLkB2bBH664Fqf05D13nY1VLD440DusQUuljFL/HLHSknar8g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cMD1djIWN3Trz4NZ5ysmZNF5K+1tiHCH3oC+51Zy+2rVrQ2Lx0yBkda7cjUS?=
 =?us-ascii?Q?BUxW67pDh1sj5BDomqlI3EkBmszY88L91A5Spxb/+YxFdW6a5wDD7BJbWnza?=
 =?us-ascii?Q?/vQDESQMo5ZGKLF8R81kSDNA4SLl6dJf197UNks6TK5dkxgkpcBZkmTn1cEz?=
 =?us-ascii?Q?b5onQ9Vjse4v5kwlU7JwTd2jpJznGJdLnrg6vn0XfFJVbb/0qDp0nIpyub3I?=
 =?us-ascii?Q?0alv99HoPaCHojFLoAq1qS5lm6sg/ITL+LEM9D0t0OMXpQwvmAppliwiWIgQ?=
 =?us-ascii?Q?tMyw+8P2GuvI+eJxg7UOqg/gLC1F+g06h2yPoEYFPhj1yMfWQYlpbmE8nG79?=
 =?us-ascii?Q?vfeSGSYP7sQPVH3lRk0PpilKZNDuXBU4fB5V6PGhrToLHlAyR6KeqlzVsSch?=
 =?us-ascii?Q?RA64G9pvZoj/l0xS/y/JtTy/7g4+jrqZgacmYgMrXDl3RfYm0scbm8f2Qmob?=
 =?us-ascii?Q?j8X5lMlE8sJrNy6cYD19bSzAsh7GygMUl6o/bZ1vXwpNPdT36wwZFcdU1OB1?=
 =?us-ascii?Q?JglNIs1MHmUFHO/VyfEp3ZR5pTKJfr5GnvEmI8DHTUmhnmEYB8AzQfuc7hxg?=
 =?us-ascii?Q?0ZD/inU97ealpIu7Bq5oY7H2Td6z2FAc5gxEZ6zghh0R8xKpPGoWzrrxUZIg?=
 =?us-ascii?Q?1M775BWc+rHt3FotCRDRgyXIeJJBc6YS458Zv5G6HFZoCj9/CCBpxeKCtTwf?=
 =?us-ascii?Q?4Rh8ag8AZkkbQOTZRCTk6yhqRBF/E3Rjd12+ZX2mXGx70AxNg2Hil0a6S0Ne?=
 =?us-ascii?Q?Q6JexrMloX7ZPjvwMFteAAc2kyG3dgjXLjp217fK6BjnnLhewwg/zwXWoJLg?=
 =?us-ascii?Q?SXVhOueXcjs5+brp9jdzKUMrMBi2a08efNxjV04pbo2eETHUb4AF1vU4VcP2?=
 =?us-ascii?Q?hyW5jaunBGBFjF62l6A3kOdkG27nkLSMbiWF2LSoe3lUQ3dT0ZN+i0tv0J7a?=
 =?us-ascii?Q?/bzRJ47TUllMMN6hyWUS/mMiYq++imvXyYdmwGE4evtzE4WZW2nlGlQqyusS?=
 =?us-ascii?Q?ionJfKFA6lql5XuB/EEC3gU3k1PAqSvfLk6vXXULO6jUQOYvAolfOdYyUWNK?=
 =?us-ascii?Q?Z6JajnoOjdOYGIYAUO1fyylAhkdwI9hz3+NyEDJ4KquUtS9A/iWJfjWigR7j?=
 =?us-ascii?Q?aN1cQQnD5p23fnmvwBBnwG5EtdcXDWea+fZ9Yre7ZM/cZRWHKmbayZJ6V/ZB?=
 =?us-ascii?Q?pjl4q4Wpihzd1BTDuw2HEo1XzmwJHkMFQBM2QX4WotSodm/w9hwr8IeMxlk+?=
 =?us-ascii?Q?oHU3u6+pCKzgbZjjFm2OvQgdOzC1lDwvMyOSgkOtT6F3SqkX95gjZbiTXnHs?=
 =?us-ascii?Q?ts7WWKifu4LgxLOad5B/GF3bb+UTPx5teXupycy/0NJzWY+dYP29ACcnqwlX?=
 =?us-ascii?Q?WPw7rFmDl308iAvLP2u5kcVNzkw3XCjD4dQlkyj9dwGNI7QK/Z95JdeagZ5d?=
 =?us-ascii?Q?EqlLvAAWg0AUTxG+vLhzV+fLRv23cT2OWAqvQAwsSnBI0xtNqE7vUDqMhlRh?=
 =?us-ascii?Q?8tl2idbxEOzwFL/mTkPirrZQcU2NO3zey4Cr5d+joLj7vt7zkV3TqxIOSiKy?=
 =?us-ascii?Q?IjwVu9TULnOMAiaffetL9jDp/N2vngpqrojx7pof?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c82706d-a8a9-44b6-a09f-08dde6bbac1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 05:19:47.7320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QmfYoUBz1e4WPPCDtNGILwL/WuP/MF2zer4UDB3CrzUFhuqrBHImmDcE9OAjNdM3+rNBE4n331ucfm9mPDVxlRvGYbRKKL7PtbOPVCyDOCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6534
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
> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@altera.com>
> Sent: Friday, August 29, 2025 11:43 AM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Yuslaimi, Ali=
f
> Zakuan <alif.zakuan.yuslaimi@altera.com>
> Subject: [PATCH v1] arm: socfpga: Define Use FPGA switch handoff section
> size for Agilex5
>=20
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>=20
> Agilex5 FPGA switch section in the handoff data is larger by 32 bytes tha=
n the
> default value as these extra sections contains I3C0 and I3C1 register off=
sets
> and values with 4 bytes each.
>=20
> This requires 4 more times of reading the FPGA switch section of the hand=
off
> data to fully populate the handoff data table in the memory during runtim=
e.
>=20
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> index 9ef82cf46c0..b8f2f73e283 100644
> --- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> +++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
> @@ -98,6 +98,8 @@
>  #define SOC64_HANDOFF_IOCTL_LEN			96
>  #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_STRATIX10)
>  #define SOC64_HANDOFF_FPGA_LEN			42
> +#elif IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
> +#define SOC64_HANDOFF_FPGA_LEN			44
>  #else
>  #define SOC64_HANDOFF_FPGA_LEN			40
>  #endif
> --
> 2.35.3

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

