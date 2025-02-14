Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB701C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 13:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2A980EAF;
	Fri, 14 Feb 2025 14:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C89180A55; Fri, 14 Feb 2025 10:44:10 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070e.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 566AE801CF
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 10:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYBpGr9iRu8sTjJdm+HOb0srL2YPc8MMruCjwsT+zFOtfxf2HUCXHVGY2WixuXoT+vLhtq+x+XER+firFG2U91Ns4bUt4HxgVPofU3Fp/ZA3a+SV7RADAqDFBVaoHG6dJGJjHgavBS2RiSRKfuWwgVwfWTREQnV7B39KN/KQVZSfGFBwBZNe7L+NKpzgAAcL1fKzqq7quZCo02MF+s9ju5d7ARbbos5dN5OfcI1SxEWANvl+v3LHiHCJFpcXP/LIhij5tBEBIFwPGf3A5xNA+Ss/EC4RQGH/lFOuMGX1Dvrr1rVAJNk/bNTHM6iYI1E+e7EgGWp/hme1S1M3kopmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4gu5X9PBHi4h5JQACVsukwxNmHPEVIQevnNafAjs5s=;
 b=UO9dz8ehfXhPpuj5p4tbt5beZ4eSIVLLY0P5iCPmoGVmhrC6Extx9zh7ezEVn5IPySw4138DagggBvyBI+P6g/7CbnuCIRBN0tb5qmtvTyR5O3YPkR/5T2ohhfnYmNK3dPQ+R8Zl+tGckU/lRHCkTHItQQR2E94QFshjW9mP9XV8cvJtEr6FwNez3O3jUO5ZeqWxrWmJXHG3Z4enelRNFSv8O5hKO8QVfbGlxG5h35MIGonAITn7MRCxcZHT60nOp9PR5Nhqvi9MvLWChOql+43rtf9ErX8qZW3Pp9DDZuLHXX9/3jzqNI92TEU+RwXiiJcQI9OyRRUTbZr0t1qnmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1179.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.14; Fri, 14 Feb
 2025 09:44:03 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8398.013; Fri, 14 Feb 2025
 09:44:03 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>
CC: Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>, "E . Shattow"
 <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, "Leon M .
 Busch-George" <leon@georgemail.eu>, H Bell <dmoo_dv@protonmail.com>, Lukas
 Funke <lukas.funke@weidmueller.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Matthias Brugger <mbrugger@suse.com>, Simon
 Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>, Nam Cao
 <namcao@linutronix.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 3/6] riscv: dts: jh7110: add DeepComputing FML13V01
 device-tree
Thread-Topic: [PATCH 3/6] riscv: dts: jh7110: add DeepComputing FML13V01
 device-tree
Thread-Index: AQHbeYTYZa5rRm04j0+U9pgIx87oNrNGlm/w
Date: Fri, 14 Feb 2025 09:44:03 +0000
Message-ID: <ZQ2PR01MB1307A34B7A07C8BAAA1B3C49E6FEA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
 <20250207172116.117749-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250207172116.117749-4-heinrich.schuchardt@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1179:EE_
x-ms-office365-filtering-correlation-id: bbe8cd59-1abf-4408-02f7-08dd4cdc1df7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|41320700013|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: FrlSvaT05nqKH0V4/TPp4lRiwixATDSt45Trsjygeh8XTmjFKqb2viZ0r4xMST19L/c/g/CFlFQINSR3jph+2BKrpJpwiDibMk+lVN6c6Z07PqDrswaC/mxGUnBXM1sy5ekfHWja12hdlaNYVoYfgpbMx+4r5wzet08hMPPhT/ieGKfbypw/ijo507irkFhB9Hc+rAex5lBcdN4VdNzpiGiV4HluUakyU0X/hlMoA8w7H8ob6/OopqURKq3aK0k6ODzndYnxVX527j1MFwEW+liamKY7Rs8JXMX7c/Sg4fHnkCMOLlLeCY40DPMtN0r0chbhAdbfJ7VWRY54rtk52VJTZmVEOgoy42OfTLBV4RAgWuY0tHy3z/jv9o8xTpw2/Qnd/09ZYYDs6hMNuS+2jokjYnj1Wk9EZFxRB8LdDph5w25LpJ+kpjsfGl8zuOv8GLmeunAOT6AHuutvkvz/IX4m0R9rvrRmVMkjxXffn6O4gV2K7/0j+bLBtrPhs03R7NyAJZOWLZo3GO4+09VcoLVyTPcfP8JOdGIu/5WmjGEqjFHqom9PixqtSU6OTtHJpDmyoMe8RqbhA4UKlFV+Jw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(41320700013)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pcKQGSdKTX8Q0CzXH9OIFBJ2/XOUM/NSYlEhs2bwQM1xfulA+7zg4r3c+KrU?=
 =?us-ascii?Q?24vGE9GBVF7hg3oh6Nvi/cZhvI1P5gISSd8izdl6bPnDIzLfjPKl9kszRk7j?=
 =?us-ascii?Q?hJA/laxa87SEmf4iY6/cRNNcJT8DEw+oom4k/r3E9am0+9g5Vv+Lojg1/ZTN?=
 =?us-ascii?Q?7FvqrgikoqRzSJvYLidUgkmbqPKKyXtpQVRkNP0gTz8LzX30WZ9Ze6PCwMtS?=
 =?us-ascii?Q?sAix/Zskk7Vbih+S7GOkmUzxGRAWF4n565YzeNOwwg723gnJUvX2B/S2carN?=
 =?us-ascii?Q?9BZUZSj71D3eFUlDH+gHCgokQtnN8ljASH0rkYSh6/0WEqQsVwl8XL8Kp80u?=
 =?us-ascii?Q?Tuk2+8jyvJn/RL9A3H9f0Ql7JiMIjQl9yysihwdTJfQIYWy7F8tkpKyuJsX0?=
 =?us-ascii?Q?sdMK/1IGd01QonO4a/isMN1FEd04xqeoTiybZvgnVhzPBY3DovdytPZ1tVYM?=
 =?us-ascii?Q?6O0r6cI88g96/P6ibzzoYaqcmM4opOQ3+Z3t4/FivRvZBBmy36h8sKDQI5sa?=
 =?us-ascii?Q?UtxtOtQpJrybqxCRmLvcB6uoD3LHPnqmFvJCoqY2N/iyXycScwm966rxszws?=
 =?us-ascii?Q?Mqn01za6qZJNedwyAfecY8tuhvE3eSVWl5sG1UcbZqh7Tyzpf1qoPxFDQ2JR?=
 =?us-ascii?Q?7oT5irytp+ufu4fH820aQx/6dwv4gBrl4TUSI5+pcCtSP4UlId3i4mnrw8DD?=
 =?us-ascii?Q?AifJscArt9My0b40eATnkOSqF7PxPR5tAImM337z7c6UIDluA5ZaFlyo7ACN?=
 =?us-ascii?Q?GMG+6NZxLuUXR9NdR2sCbCEpgrYBpU0QtVSBzgih+vdbfXWVdf/75qHk4Mm3?=
 =?us-ascii?Q?E8BpM3pcMjfoUX/brooZrUz7mpH042uoIUpSAeVmQRVOAu3QbW84Ss54t6ID?=
 =?us-ascii?Q?8p2b8VyBczl1Zuf4FLzHvM40pfIgnX2HZoCSSsbzHhhSCEwiGbbZP2C/CUJH?=
 =?us-ascii?Q?iXTxJnO0eQ53x7/+FJnvRQLLB7LQe68SX324eYzKyt6RABIvoyyWqJ4ONhh2?=
 =?us-ascii?Q?FhUo0kVEVfUHXG4/mjOlFu0WR2s9FBhd3YqCeyetvqTMwxVxWnAIDm1seeyr?=
 =?us-ascii?Q?g172jTPa7iWgCxfrBWs1f1Ji3dXSnQKqWUSF3EITZBiNMTcaLfZKlaObV7Gz?=
 =?us-ascii?Q?yvujEHp5lOnuN6HSMOrU/OXvkfKO04sd4XDYBKqH58pEnl2gCqZY7MYL/zQn?=
 =?us-ascii?Q?VzeGAZFgm1UCIlxylqCoN9TLorn7a1blCqyhuvNbQgbGLRBpZTdLSVQ+HQO4?=
 =?us-ascii?Q?sRCHnYITYKqxQq/2jctvlKrhCR0TvJy7PQB6scTXE1chozyYW8KRHMb2PpdF?=
 =?us-ascii?Q?zrHfuNgleX1oTvP+D6UlxTE30s3QuPQJP5O2oJSrjEbB8NFMmGDtq7PdZiza?=
 =?us-ascii?Q?/NmVGScrnyrdxNFpWSi+MhepWIc7nDe/UbACcWC8DgCjZaFSWly3zul8U6CW?=
 =?us-ascii?Q?fAxb1WwiYPPwRErSbc55eFAstD+jhiDZDbRL0LW1/fKO5I+NDgldS9AJXa2m?=
 =?us-ascii?Q?g0DnFcxsh1jMugtGN8ZGz9zSs/FkQSZCmERdXU8BnZy55Qs2OGdtqFi/pc57?=
 =?us-ascii?Q?tFc6veheCzxsr8i0Z3p0F1NY3u8+ku+7eD5flfBX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe8cd59-1abf-4408-02f7-08dd4cdc1df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 09:44:03.5211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JvfhBH4iVpqLycKFdZmjwfYjYTaHrW1BV0xYUtJeDS8FRpKF5mOBJX2A6xnD37XE2pGM7ueJAxDffSmIIjx4KSjRmvI9yugIKVhIQhp4mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1179
X-Mailman-Approved-At: Fri, 14 Feb 2025 14:11:32 +0100
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

> On 08.02.25 01:21, Heinrich Schuchardt wrote:
> Add the u-boot device-tree include needed to support the DeepComputing
> Framework motherboard (FML13V01).
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-
> boot.dtsi
>=20
> diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> new file mode 100644
> index 00000000000..ab882d07f6f
> --- /dev/null
> +++ b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + */
> +
> +#include "jh7110-common-u-boot.dtsi"
> +#include "starfive-visionfive2-binman.dtsi"

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

Best regards,
Hal
